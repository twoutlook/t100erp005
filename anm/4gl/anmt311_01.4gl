#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt311_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2016-12-23 14:29:59), PR版次:0019(2017-02-07 18:06:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000312
#+ Filename...: anmt311_01
#+ Description: 產生帳務資料
#+ Creator....: 02295(2013-12-24 18:54:18)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="anmt311_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#141106-00011#22  2015/01/13 By Belle   批次產生帳務時,nmba006 ='Y'才可產生
#150714-00024#1   2015/07/15 By Reanna  bug修正
#150707-00001#7   2015/07/22 By apo     整測bug修正
#150803-00018#1   2015/08/12 By Reanna  產生帳務資料後，將單號傳回主程式，並查詢出來
#150924           2015/09/24 By Reanna  整批產生帳務資料，產生單號應用選擇的日期產生
#150930-00010#4   2015/10/05 By 03538   平行帳套處理:匯率來源參數參照S-FIN-4012,且日平均匯率以新元件計算
#160331-00011#1   2016/04/05 By 07673   修改单身来源单号带值段,单身的nmbt021、nmbt022应该给来源单据单身的值
#160318-00025#7   2016/04/20 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00006#1   2016/04/26 By 07673   转备用金和缴款汇总单不能同时为Y
#160519-00043#1   2016/05/19 By 02599   当异动别为1存入或2提出时，反向若未設定對應的存提科目，則不產生單身的的3借方或4.贷方
#160509-00004     2016/5/23  BY LIYAN   整单操作增加往来账款核销
#160811-00055#2   2016/08/12 By 01531   取銀存收支單的資料時, 請含 nmba003 = 'anmt440'
#160905-00007#8   2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160913-00017#5   2016/09/21 By 07900   ANM模组调整交易客商开窗
#160929-00040#1   2016/10/13 By 01531   账套开窗检查只能是主账套及平行账套，拿掉这个控卡
#161018-00004#1   2016/10/18 By 02599   产生成功后提示信息,增加询问是否继续产生提示框，如果选择是，停留在批次产生，选择否，关闭批次产生窗口；
#                                       抓取单身业务单号时，排除已存在于anmt311单身的业务单号
#161006-00005#41  2016/10/28 By 08171   开法人组织q_ooef001_2,要注意原本的权限控管要保留
#160518-00024#14  2016/10/29 By 01531    取銀存收支單的資料時, 請含 nmba003 = 'aapt352'
#161128-00061#2   2016/11/29 by 02481   标准程式定义采用宣告模式,弃用.*写法
#161026-00010#1   2016/12/23 By 01531   來源內容增加 nmba003 IN (...anmt510,anmt541)   
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_nmbs_m        RECORD
       nmbscomp LIKE nmbs_t.nmbscomp, 
   nmbscomp_desc LIKE type_t.chr80, 
   b LIKE type_t.chr500, 
   f LIKE type_t.chr500, 
   a LIKE type_t.chr500, 
   d LIKE type_t.chr500, 
   e LIKE type_t.chr500, 
   g LIKE type_t.chr500, 
   h LIKE type_t.chr500, 
   c LIKE type_t.chr500, 
   nmbsld LIKE nmbs_t.nmbsld, 
   nmbsld_desc LIKE type_t.chr80, 
   nmbsdocno LIKE nmbs_t.nmbsdocno, 
   nmbsdocdt LIKE nmbs_t.nmbsdocdt, 
   docno_311 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc1             STRING
DEFINE g_wc2             STRING
DEFINE g_wc3             STRING
DEFINE g_sql             STRING
DEFINE g_para_data       LIKE type_t.chr80     #資金模組匯率來源

#151111-00001#1--add--str--lujh
DEFINE g_free_m    RECORD
       free_item_1     LIKE nmbt_t.nmbt034, 
       free_item_2     LIKE nmbt_t.nmbt035,
       free_item_3     LIKE nmbt_t.nmbt036, 
       free_item_4     LIKE nmbt_t.nmbt037,
       free_item_5     LIKE nmbt_t.nmbt038, 
       free_item_6     LIKE nmbt_t.nmbt039,
       free_item_7     LIKE nmbt_t.nmbt040, 
       free_item_8     LIKE nmbt_t.nmbt041,
       free_item_9     LIKE nmbt_t.nmbt042,     
       free_item_10    LIKE nmbt_t.nmbt043            
       END RECORD

DEFINE g_field_m       RECORD
       field1     LIKE type_t.chr10, 
       field2     LIKE type_t.chr10,
       field3     LIKE type_t.chr10, 
       field4     LIKE type_t.chr10,
       field5     LIKE type_t.chr10, 
       field6     LIKE type_t.chr10,
       field7     LIKE type_t.chr10, 
       field8     LIKE type_t.chr10,
       field9     LIKE type_t.chr10,     
       field10    LIKE type_t.chr10            
       END RECORD
#151111-00001#1--add--end--lujh
#end add-point
 
DEFINE g_nmbs_m        type_g_nmbs_m
 
   DEFINE g_nmbsld_t LIKE nmbs_t.nmbsld
DEFINE g_nmbsdocno_t LIKE nmbs_t.nmbsdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt311_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt311_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_nmbscomp,p_a,p_b,p_c,p_nmbsld,p_nmbsdocno,p_nmbadocno
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_lsaeld        LIKE glaa_t.glaald
   DEFINE l_isaecomp      LIKE isae_t.isaecomp
   DEFINE l_errno         LIKE type_t.num5
   DEFINE p_nmbscomp      LIKE nmbs_t.nmbscomp
   DEFINE p_a             LIKE type_t.chr1
   DEFINE p_b             LIKE type_t.chr1
   DEFINE p_c             LIKE type_t.chr1
   DEFINE p_nmbsld        LIKE nmbs_t.nmbsld
   DEFINE p_nmbsdocno     LIKE nmbs_t.nmbsdocno
   DEFINE p_nmbadocno     LIKE nmba_t.nmbadocno
   DEFINE l_cnt           LIKE type_t.num5      #141106-00011#22
   DEFINE l_dfin0030      LIKE type_t.chr1      #141106-00011#22
   DEFINE l_ooba002       LIKE ooba_t.ooba002   #141106-00011#22
   DEFINE l_glaa121       LIKE glaa_t.glaa121   #141106-00011#22
   DEFINE g_comp_wc       STRING  #160929-00040#1
   DEFINE l_wc            STRING  #160929-00040#1
   DEFINE l_origin_str    STRING  #160929-00040#1
   DEFINE l_sql           STRING  #160929-00040#1
   DEFINE l_prog_310      LIKE nmba_t.nmba003  #161026-00010#1 add
   DEFINE l_prog_540      LIKE nmba_t.nmba003  #161026-00010#1 add 
   DEFINE l_prog_541      LIKE nmba_t.nmba003  #161026-00010#1 add  
   DEFINE l_prog_510      LIKE nmba_t.nmba003  #161026-00010#1 add   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt311_01 WITH FORM cl_ap_formpath("anm","anmt311_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_errshow = 1
   IF cl_null(p_nmbscomp) THEN
      CALL s_fin_ld_carry('',g_user) RETURNING l_success,l_lsaeld,l_isaecomp,l_errno
   ELSE
      LET l_isaecomp=p_nmbscomp
      IF NOT cl_null(p_nmbsld) THEN
         LET l_lsaeld=p_nmbsld
         CALL anmt311_01_nmbsld_desc(l_lsaeld)
         CALL cl_set_comp_entry('nmbsld',FALSE)
      END IF
   END IF
   IF NOT cl_null(p_nmbsdocno) THEN
      LET g_nmbs_m.nmbsdocno=p_nmbsdocno
   END IF
   
   LET g_nmbs_m.docno_311= ''
   
   #20150521--add--str--lujh
   IF cl_null(p_a) THEN
      LET g_nmbs_m.a = 'N'
   ELSE
      LET g_nmbs_m.a = p_a
   END IF
   IF cl_null(p_b) THEN
      LET g_nmbs_m.b = 'Y'
   ELSE
      LET g_nmbs_m.b = p_b
   END IF
   IF cl_null(p_c) THEN
      LET g_nmbs_m.c = 'N'
   ELSE
      LET g_nmbs_m.c = p_c
   END IF
   
   LET g_nmbs_m.d = 'N'
   #20150521--add--end--lujh
   LET g_nmbs_m.e = 'N'   #150417-00007#56 Add
   
   LET  g_nmbs_m.f = 'N'  #160509-00004#12 
   
   LET g_nmbs_m.g = 'N' #161026-00010#1 add
   LET g_nmbs_m.h = 'N' #161026-00010#1 add

   IF g_nmbs_m.c = 'Y' THEN 
      CALL cl_set_comp_entry('nmbsld',FALSE)
   ELSE
      CALL cl_set_comp_entry('nmbsld',TRUE)
   END IF
    
   LET g_nmbs_m.nmbscomp = l_isaecomp
   LET g_nmbs_m.nmbsld = l_lsaeld
   CALL anmt311_01_nmbsld_desc(g_nmbs_m.nmbsld)  #150714-00024#1
   LET g_nmbs_m.nmbsdocdt = g_today
   CALL anmt311_01_nmbscomp_desc()
   CALL s_fin_create_account_center_tmp()  #160929-00040#1
   WHILE TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmbs_m.nmbscomp,g_nmbs_m.b,g_nmbs_m.f,g_nmbs_m.a,g_nmbs_m.d,g_nmbs_m.e,g_nmbs_m.g, 
          g_nmbs_m.h,g_nmbs_m.c,g_nmbs_m.nmbsld,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.docno_311  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #20150521--mark--str--lujh
            #IF cl_null(p_a) THEN
            #   LET g_nmbs_m.a = 'N'
            #ELSE
            #   LET g_nmbs_m.a = p_a
            #END IF
            #IF cl_null(p_b) THEN
            #   LET g_nmbs_m.b = 'Y'
            #ELSE
            #   LET g_nmbs_m.b = p_b
            #END IF
            #IF cl_null(p_c) THEN
            #   LET g_nmbs_m.c = 'N'
            #ELSE
            #   LET g_nmbs_m.c = p_c
            #END IF
            #
            #IF g_nmbs_m.c = 'Y' THEN 
            #   CALL cl_set_comp_entry('nmbsld',FALSE)
            #ELSE
            #   CALL cl_set_comp_entry('nmbsld',TRUE)
            #END IF
            #
            #LET g_nmbs_m.nmbscomp = l_isaecomp
            #LET g_nmbs_m.nmbsld = l_lsaeld
            #LET g_nmbs_m.nmbsdocdt = g_today
            #CALL anmt311_01_nmbscomp_desc()
            #20150521--mark--end--lujh
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbscomp
            
            #add-point:AFTER FIELD nmbscomp name="input.a.nmbscomp"
            CALL anmt311_01_nmbscomp_desc()
            IF NOT cl_null(g_nmbs_m.nmbscomp) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_nmbs_m.nmbscomp
#160930-00025#1 mod s---               
#               IF cl_chk_exist("v_ooef001_1") THEN
#                  #檢查成功時後續處理
#                  #150714-00024#1 add ------
#                  SELECT glaald INTO g_nmbs_m.nmbsld
#                    FROM glaa_t
#                   WHERE glaaent = g_enterprise
#                     AND glaacomp = g_nmbs_m.nmbscomp
#                     AND glaa014 = 'Y'
#                  CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_nmbs_m.nmbscomp
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_nmbs_m.nmbscomp = ''
#                     LET g_nmbs_m.nmbsld = ''
#                     NEXT FIELD CURRENT
#                  END IF
#                  #150714-00024#1 add end---
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_nmbs_m.nmbscomp = ''
#                  CALL anmt311_01_nmbscomp_desc()
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_fin_comp_chk(g_nmbs_m.nmbscomp) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbs_m.nmbscomp = ''
                  CALL anmt311_01_nmbscomp_desc()
                  NEXT FIELD CURRENT
               END IF
               CALL s_anm_get_comp_wc('6',g_site,g_nmbs_m.nmbsdocdt) RETURNING g_comp_wc
               IF s_chr_get_index_of(g_comp_wc,g_nmbs_m.nmbscomp,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02928'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbs_m.nmbscomp = ''
                  CALL anmt311_01_nmbscomp_desc()
                  NEXT FIELD CURRENT
               END IF
               #检查用户是否有资金中心对应法人的权限
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET l_count = 0
               LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                           "   AND ooef001 = '",g_nmbs_m.nmbscomp,"'",
                           "   AND ooef003 = 'Y'",
                           "   AND ",l_wc CLIPPED
               PREPARE anmt311_01_count_prep1 FROM l_sql
               EXECUTE anmt311_01_count_prep1 INTO l_count
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ais-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbs_m.nmbscomp = ''
                  CALL anmt311_01_nmbscomp_desc()                   
                  NEXT FIELD CURRENT
               END IF
#160930-00025#1 mod e--- 
            END IF 
            LET g_nmbs_m.docno_311= ''
            DISPLAY g_nmbs_m.docno_311 TO docno_311
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbscomp
            #add-point:BEFORE FIELD nmbscomp name="input.b.nmbscomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbscomp
            #add-point:ON CHANGE nmbscomp name="input.g.nmbscomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
            #此段落由子樣板a05產生
            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            #20150521--add--str--lujh
            IF g_nmbs_m.b = 'Y' THEN 
               LET g_nmbs_m.d = 'N'
               LET g_nmbs_m.e = 'N'  #160414-00006#1
               LET g_nmbs_m.f = 'N'  #160509-00004#12 by liyan
            END IF
            #20150521--add--end--lujh
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD f
            #add-point:BEFORE FIELD f name="input.b.f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD f
            
            #add-point:AFTER FIELD f name="input.a.f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE f
            #add-point:ON CHANGE f name="input.g.f"
            #160509-00004#22  by liyan --str--
            IF g_nmbs_m.f = 'Y' THEN
               LET g_nmbs_m.d = 'N'
               LET g_nmbs_m.a = 'N'
               LET g_nmbs_m.b = 'N'
               LET g_nmbs_m.e = 'N'
               LET g_nmbs_m.g = 'N'  #161026-00010#1 add
               LET g_nmbs_m.h = 'N'  #161026-00010#1 add                 
            END IF
            #160509-00004#22 by liyan --end--
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            #20150521--add--str--lujh
            IF g_nmbs_m.a = 'Y' THEN 
               LET g_nmbs_m.d = 'N'
               LET g_nmbs_m.e = 'N'  #160414-00006#1  
               LET g_nmbs_m.f = 'N'  #160509-00004 add by liyan               
            END IF
            #20150521--add--end--lujh
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD d
            
            #add-point:AFTER FIELD d name="input.a.d"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            #IF  NOT cl_null(g_nmbs_m.nmbsld) AND NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbsld_t  OR g_nmbs_m.nmbsdocno != g_nmbsdocno_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbs_t WHERE "||"nmbsent = '" ||g_enterprise|| "' AND "||"nmbsld = '"||g_nmbs_m.nmbsld ||"' AND "|| "nmbsdocno = '"||g_nmbs_m.nmbsdocno ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD d
            #add-point:BEFORE FIELD d name="input.b.d"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE d
            #add-point:ON CHANGE d name="input.g.d"
            #20150521--add--str--lujh
            IF g_nmbs_m.d = 'Y' THEN 
               LET g_nmbs_m.a = 'N'
               LET g_nmbs_m.b = 'N'
               LET g_nmbs_m.f = 'N' #160509-00004#12
               LET g_nmbs_m.g = 'N'  #161026-00010#1 add
               LET g_nmbs_m.h = 'N'  #161026-00010#1 add                 
            END IF
            #20150521--add--end--lujh
            #160414-00006#1 add -str
            IF g_nmbs_m.d = 'Y' THEN
               LET g_nmbs_m.e = 'N'
               LET g_nmbs_m.f = 'N'  #160509-00004#12 by liyan
            END IF
            #160414-00006#1 add -end
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD e
            #add-point:BEFORE FIELD e name="input.b.e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD e
            
            #add-point:AFTER FIELD e name="input.a.e"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE e
            #add-point:ON CHANGE e name="input.g.e"
            #160414-00006#1 add -str
            IF g_nmbs_m.e = 'Y' THEN
               LET g_nmbs_m.d = 'N'
               LET g_nmbs_m.a = 'N'
               LET g_nmbs_m.b = 'N'
               LET g_nmbs_m.f = 'N'  #160509-00004#12 by liyan
               LET g_nmbs_m.g = 'N'  #161026-00010#1 add
               LET g_nmbs_m.h = 'N'  #161026-00010#1 add                 
            END IF
            #160414-00006#1 add -end
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD g
            #add-point:BEFORE FIELD g name="input.b.g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD g
            
            #add-point:AFTER FIELD g name="input.a.g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE g
            #add-point:ON CHANGE g name="input.g.g"
            #161026-00010#1 add s---
            IF g_nmbs_m.g = 'Y' THEN 
               LET g_nmbs_m.d = 'N'
               LET g_nmbs_m.e = 'N'   
               LET g_nmbs_m.f = 'N'   
            END IF
            #161026-00010#1 add e---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD h
            #add-point:BEFORE FIELD h name="input.b.h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD h
            
            #add-point:AFTER FIELD h name="input.a.h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE h
            #add-point:ON CHANGE h name="input.g.h"
            #161026-00010#1 add s---
            IF g_nmbs_m.h = 'Y' THEN 
               LET g_nmbs_m.d = 'N'
               LET g_nmbs_m.e = 'N'   
               LET g_nmbs_m.f = 'N'   
            END IF
            #161026-00010#1 add e---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="input.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="input.a.c"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c
            #add-point:ON CHANGE c name="input.g.c"
            IF g_nmbs_m.c = 'Y' THEN 
               CALL cl_set_comp_entry("nmbsld",FALSE)
               LET g_nmbs_m.nmbsld = ''
               LET g_nmbs_m.nmbsld_desc = ''
               DISPLAY g_nmbs_m.nmbsld_desc TO nmbsld_desc
            ELSE
               CALL cl_set_comp_entry("nmbsld",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsld
            
            #add-point:AFTER FIELD nmbsld name="input.a.nmbsld"
            IF NOT cl_null(g_nmbs_m.nmbsld) THEN 
#160930-00025#1 mark s---            
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = g_nmbs_m.nmbsld
#               #160318-00025#7--add--str
#               LET g_errshow = TRUE 
#               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
#               #160318-00025#7--add--end 
#               IF cl_chk_exist("v_glaald_1") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME
#                  #150714-00024#1 add ------
#160930-00025#1 mark e---
                  CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbs_m.nmbsld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbs_m.nmbsld = ""
                     LET g_nmbs_m.nmbsld_desc = ""
                     DISPLAY BY NAME g_nmbs_m.nmbsld,g_nmbs_m.nmbsld_desc
                     NEXT FIELD CURRENT
                  END IF
                  #150714-00024#1 add end---
#160930-00025#1 mark e---                  
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_nmbs_m.nmbsld = ''
#                  CALL anmt311_01_nmbsld_desc(g_nmbs_m.nmbsld)
#                  NEXT FIELD CURRENT
#               END IF
#160930-00025#1 mark e---
            END IF
            CALL anmt311_01_nmbsld_desc(g_nmbs_m.nmbsld)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsld
            #add-point:BEFORE FIELD nmbsld name="input.b.nmbsld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsld
            #add-point:ON CHANGE nmbsld name="input.g.nmbsld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocno
            
            #add-point:AFTER FIELD nmbsdocno name="input.a.nmbsdocno"
            IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               LET l_glaa024 = ''
               CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024   
               IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
                  #CALL s_aooi200_chk_slip(g_nmbs_m.nmbscomp,l_glaa024,g_nmbs_m.nmbsdocno,'anmt311') RETURNING l_success   #2014/12/29 liuym mark
                  CALL s_aooi200_fin_chk_slip(g_nmbs_m.nmbsld,l_glaa024,g_nmbs_m.nmbsdocno,'anmt311') RETURNING l_success  #2014/12/29 liuym add
                  IF l_success = FALSE THEN 
                     LET g_nmbs_m.nmbsdocno = ''
                     NEXT FIELD nmbsdocno
                  END IF
               END IF
            END IF 
            
            



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocno
            #add-point:BEFORE FIELD nmbsdocno name="input.b.nmbsdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsdocno
            #add-point:ON CHANGE nmbsdocno name="input.g.nmbsdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbsdocdt
            #add-point:BEFORE FIELD nmbsdocdt name="input.b.nmbsdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsdocdt
            
            #add-point:AFTER FIELD nmbsdocdt name="input.a.nmbsdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbsdocdt
            #add-point:ON CHANGE nmbsdocdt name="input.g.nmbsdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno_311
            
            #add-point:AFTER FIELD docno_311 name="input.a.docno_311"
            IF NOT cl_null(g_nmbs_m.docno_311) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbs_m.docno_311
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno_311
            #add-point:BEFORE FIELD docno_311 name="input.b.docno_311"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno_311
            #add-point:ON CHANGE docno_311 name="input.g.docno_311"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbscomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscomp
            #add-point:ON ACTION controlp INFIELD nmbscomp name="input.c.nmbscomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.nmbscomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #160929-00040#1 add s--- 
            CALL s_anm_get_comp_wc('6',g_site,g_nmbs_m.nmbsdocdt) RETURNING g_comp_wc  
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc   
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y'"
            #CALL q_ooef001()  #161006-00005#41 mark
            #160929-00040#1 add e--- 
            
            #CALL q_ooef001_2()                              #160929-00040#1  
            CALL q_ooef001_2() #161006-00005#41 add
            LET g_nmbs_m.nmbscomp = g_qryparam.return1              
            CALL anmt311_01_nmbscomp_desc()
            DISPLAY g_nmbs_m.nmbscomp TO nmbscomp              #

            NEXT FIELD nmbscomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD f
            #add-point:ON ACTION controlp INFIELD f name="input.c.f"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD d
            #add-point:ON ACTION controlp INFIELD d name="input.c.d"
            
            #END add-point
 
 
         #Ctrlp:input.c.e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD e
            #add-point:ON ACTION controlp INFIELD e name="input.c.e"
            
            #END add-point
 
 
         #Ctrlp:input.c.g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD g
            #add-point:ON ACTION controlp INFIELD g name="input.c.g"
            
            #END add-point
 
 
         #Ctrlp:input.c.h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD h
            #add-point:ON ACTION controlp INFIELD h name="input.c.h"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbsld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsld
            #add-point:ON ACTION controlp INFIELD nmbsld name="input.c.nmbsld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.nmbsld             #給予default值
#160929-00040#1 mod s---            
#            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')",
#                                   " AND glaacomp = '",g_nmbs_m.nmbscomp,"'"
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_site,g_nmbs_m.nmbsdocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str  
           
            LET g_qryparam.where = " glaacomp IN ",l_origin_str
#160929-00040#1 mod e---            
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_nmbs_m.nmbsld = g_qryparam.return1              
            CALL anmt311_01_nmbsld_desc(g_nmbs_m.nmbsld)
            DISPLAY g_nmbs_m.nmbsld TO nmbsld              #

            NEXT FIELD nmbsld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocno
            #add-point:ON ACTION controlp INFIELD nmbsdocno name="input.c.nmbsdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.nmbsdocno             #給予default值
            LET l_glaa024 = ''
            CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024 
            LET g_qryparam.where = " ooba001 = '",l_glaa024,"' AND oobx003 = 'anmt311'"
            #給予arg

            
            CALL q_ooba002()                                #呼叫開窗

            LET g_nmbs_m.nmbsdocno = g_qryparam.return1              

            DISPLAY g_nmbs_m.nmbsdocno TO nmbsdocno              #

            NEXT FIELD nmbsdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbsdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocdt
            #add-point:ON ACTION controlp INFIELD nmbsdocdt name="input.c.nmbsdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.docno_311
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno_311
            #add-point:ON ACTION controlp INFIELD docno_311 name="input.c.docno_311"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbs_m.docno_311             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooba002()                                #呼叫開窗

            LET g_nmbs_m.docno_311 = g_qryparam.return1              

            DISPLAY g_nmbs_m.docno_311 TO docno_311              #

            NEXT FIELD docno_311                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"

      CONSTRUCT BY NAME g_wc1 ON nmbadocno
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD nmbadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#161026-00010#1 mark s---            
#            IF g_nmbs_m.a = 'Y' AND g_nmbs_m.b = 'N' THEN 
#              #LET g_qryparam.where = " nmba003 = 'anmt540' AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",                #151021 by 03538 mark
#               LET g_qryparam.where = " nmba003 IN ('anmt540','anmt541') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",   #151021 by 03538
#                                      "   AND nmbastus = 'V' ",
#                                      "   AND nmba006 = 'Y'  ",      #141106-00011#22 >>由N改為Y
#                                      "   AND nmbadocno NOT IN (",
#                                      "       SELECT nmbt002 FROM nmbt_t ",
#                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                      "        WHERE nmbtent = '",g_enterprise,"'",
#                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                      "          AND nmbsstus <> 'X'", #150714-00024#1
#                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                      "       )"
#               CALL q_nmbadocno()
#            END IF
#            
#            IF g_nmbs_m.a = 'N' AND g_nmbs_m.b = 'Y'  THEN 
#               LET g_qryparam.where = " nmba003 IN ('anmt310','adet402','anmt440','aapt352') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'", #2015/6/24 增加来源adet402 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
#                                      "   AND (nmbastus = 'Y' OR nmbastus = 'V' ) ",
#                                      "   AND nmba006 = 'Y'  ",      #141106-00011#22 >>由N改為Y
#                                      "   AND nmbadocno NOT IN (",
#                                      "       SELECT nmbt002 FROM nmbt_t ",
#                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                      "        WHERE nmbtent = '",g_enterprise,"'",
#                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                      "          AND nmbsstus <> 'X'", #150714-00024#1
#                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                      "       )"
#               CALL q_nmbadocno()
#            END IF
#            #160509-00004#12 by liyan --str--
#            IF g_nmbs_m.f = 'Y' AND g_nmbs_m.a = 'N' AND g_nmbs_m.b = 'N' AND g_nmbs_m.d = 'N'  AND g_nmbs_m.e = 'N' THEN
#               LET g_qryparam.where = " nmba003 IN ('anmt310') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'", 
#                                      "   AND (nmbastus = 'Y' OR nmbastus = 'V' ) ",
#                                      "   AND nmba006 = 'Y' ",
#                                      "   AND nmba015='Y' ", #160509-0004#21
#                                      "   AND nmbadocno NOT IN (",
#                                      "       SELECT DISTINCT nmbt002 FROM nmbt_t ",  #151201-00003#2 add DISTINCT
#                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                      "        WHERE nmbtent = '",g_enterprise,"'",
#                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                      "          AND nmbtdocno <> '",g_nmbs_m.nmbsdocno,"'", #151201-00003#2 add
#                                      "          AND nmbsstus <> 'X'", #150714-00024#1
#                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                      "       )"
#               CALL q_nmbadocno()
#            END IF 
#            #160509-00004#21 by liyan  --end--
#            
#            IF g_nmbs_m.a = 'Y' AND g_nmbs_m.b = 'Y'  THEN 
#               LET g_qryparam.where = "        nmbacomp = '",g_nmbs_m.nmbscomp,"'", 
#                                      "   AND ((nmba003 IN ('anmt310','adet402','anmt440','aapt352') AND (nmbastus = 'Y' OR nmbastus = 'V' ) ) ",  #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
#                                     #"    OR (nmba003 = 'anmt540' AND nmbastus = 'V' ))",                #151021 by 03538 mark
#                                      "    OR (nmba003 IN ('anmt540','anmt541') AND nmbastus = 'V' ))",   #151021 by 03538                                       
#                                      "   AND nmba006 = 'Y'  ",      #141106-00011#22 >>由N改為Y
#                                      "   AND nmbadocno NOT IN (",
#                                      "       SELECT nmbt002 FROM nmbt_t ",
#                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                      "        WHERE nmbtent = '",g_enterprise,"'",
#                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                      "          AND nmbsstus <> 'X'", #150714-00024#1
#                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                      "       )" 
#               CALL q_nmbadocno()                           #呼叫開窗                                      
#            END IF
#            
#            #20150521--add--str--lujh
#            IF g_nmbs_m.d = 'Y' THEN 
#               LET g_qryparam.where = "  deabsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
#                                      "                  AND ooef017 = '",g_nmbs_m.nmbscomp,"'",
#                                      "              )",
#                                      "   AND deabstus = 'Y'  ",      
#                                      "   AND deabdocno NOT IN (",
#                                      "       SELECT nmbt002 FROM nmbt_t ",
#                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                      "        WHERE nmbtent = '",g_enterprise,"'",
#                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                      "          AND nmbsstus <> 'X'", #150714-00024#1
#                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                      "       )"  
#               CALL q_deabdocno()                           #呼叫開窗   
#            END IF
#            #20150521--add--end--lujh
#
#            #150417-00007#56 Add  ---(S)---
#            IF g_nmbs_m.e = 'Y' THEN
#               IF NOT cl_null(g_nmbs_m.nmbsld) THEN
#                  LET g_qryparam.where = "       nmbacomp = '",g_nmbs_m.nmbscomp,"'",
#                                         "   AND nmbastus = 'Y' ",
#                                         "   AND nmba003 = 'anmt563' ",
#                                         "   AND nmbadocno NOT IN (",
#                                         "       SELECT nmbt002 FROM nmbt_t ",
#                                         "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                         "        WHERE nmbtent = '",g_enterprise,"'",
#                                         "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                         "          AND nmbsstus <> 'X'", #150714-00024#1
#                                         "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                         "       )" 
#               ELSE
#                  LET g_qryparam.where = "       nmbacomp = '",g_nmbs_m.nmbscomp,"'",
#                                         "   AND nmbastus = 'Y' ",
#                                         "   AND nmba003 = 'anmt563' ",
#                                         "   AND nmbadocno NOT IN (",
#                                         "       SELECT nmbt002 FROM nmbt_t ",
#                                         "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
#                                         "        WHERE nmbtent = '",g_enterprise,"'",
#                                         "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
#                                         "          AND nmbsstus <> 'X'", #150714-00024#1
#                                         "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
#                                         "       )" 
#               END IF
#               CALL q_nmbadocno()
#            END IF
#            #150417-00007#56 Add  ---(E)---
#161026-00010#1 mark e---
#161026-00010#1 add s---
            IF g_nmbs_m.a = 'Y' OR g_nmbs_m.b = 'Y' OR g_nmbs_m.g = 'Y' OR g_nmbs_m.h = 'Y' THEN
               IF g_nmbs_m.a = 'Y' THEN 
                  LET l_prog_540 = 'anmt540'
               ELSE
                  LET l_prog_540 = ''
               END IF
               IF g_nmbs_m.b = 'Y' THEN 
                  LET l_prog_310 = 'anmt310'
               ELSE   
                  LET l_prog_310 = ''   
               END IF
               IF g_nmbs_m.g = 'Y' THEN 
                  LET l_prog_510 = 'anmt510'
               ELSE   
                  LET l_prog_510 = ''                  
               END IF 
               IF g_nmbs_m.h = 'Y' THEN 
                  LET l_prog_541 = 'anmt541'
               ELSE   
                  LET l_prog_541 = ''                  
               END IF       
               IF g_nmbs_m.b = 'Y' THEN
                  LET g_qryparam.where = "      ((nmba003 IN ('",l_prog_540,"','",l_prog_541,"') AND nmbastus = 'V' AND nmba006 = 'Y') ",
                                         "   OR (nmba003 IN ('adet402','",l_prog_310,"','anmt440','aapt352') AND nmbastus = 'Y' AND nmba006 = 'Y')",
                                         "   OR (nmba003 = '",l_prog_510,"' AND nmbastus = 'V')) "                                         
               ELSE
                  LET g_qryparam.where = "       ((nmba003 IN ('",l_prog_540,"','",l_prog_541,"') AND nmba006 = 'Y') ",
                                         "   OR  (nmba003 = '",l_prog_510,"'))",
                                         "   AND nmbastus = 'V'"               
               END IF            
               LET g_qryparam.where = g_qryparam.where,                      
                                      "   AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",    
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"                                            
               CALL q_nmbadocno()
            END IF
            
            #160509-00004#12 by liyan --str--
            IF g_nmbs_m.f = 'Y' AND g_nmbs_m.a = 'N' AND g_nmbs_m.b = 'N' AND g_nmbs_m.d = 'N'  AND g_nmbs_m.e = 'N' THEN
               LET g_qryparam.where = " nmba003 IN ('anmt310') AND nmbacomp = '",g_nmbs_m.nmbscomp,"'", 
                                      "   AND nmbastus = 'Y' ",
                                      "   AND nmba006 = 'Y' ",
                                      "   AND nmba015='Y' ", #160509-0004#21
                                      "   AND nmbadocno NOT IN (",
                                      "       SELECT DISTINCT nmbt002 FROM nmbt_t ",  #151201-00003#2 add DISTINCT
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbtdocno <> '",g_nmbs_m.nmbsdocno,"'", #151201-00003#2 add
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"
               CALL q_nmbadocno()
            END IF 
            #160509-00004#21 by liyan  --end--
            
            #20150521--add--str--lujh
            IF g_nmbs_m.d = 'Y' THEN 
               LET g_qryparam.where = "  deabsite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                      "                  AND ooef017 = '",g_nmbs_m.nmbscomp,"'",
                                      "              )",
                                      "   AND deabstus = 'Y'  ",      
                                      "   AND deabdocno NOT IN (",
                                      "       SELECT nmbt002 FROM nmbt_t ",
                                      "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                      "        WHERE nmbtent = '",g_enterprise,"'",
                                      "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                      "          AND nmbsstus <> 'X'", #150714-00024#1
                                      "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                      "       )"  
               CALL q_deabdocno()                           #呼叫開窗   
            END IF
            #20150521--add--end--lujh

            #150417-00007#56 Add  ---(S)---
            IF g_nmbs_m.e = 'Y' THEN
               IF NOT cl_null(g_nmbs_m.nmbsld) THEN
                  LET g_qryparam.where = "       nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                         "   AND nmbastus = 'V' ",
                                         "   AND nmba003 = 'anmt563' ",
                                         "   AND nmbadocno NOT IN (",
                                         "       SELECT nmbt002 FROM nmbt_t ",
                                         "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                         "        WHERE nmbtent = '",g_enterprise,"'",
                                         "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                         "          AND nmbsstus <> 'X'", #150714-00024#1
                                         "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                         "       )" 
               ELSE
                  LET g_qryparam.where = "       nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                         "   AND nmbastus = 'V' ",
                                         "   AND nmba003 = 'anmt563' ",
                                         "   AND nmbadocno NOT IN (",
                                         "       SELECT nmbt002 FROM nmbt_t ",
                                         "         LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno", #150714-00024#1
                                         "        WHERE nmbtent = '",g_enterprise,"'",
                                         "          AND nmbtld = '",g_nmbs_m.nmbsld,"'",
                                         "          AND nmbsstus <> 'X'", #150714-00024#1
                                         "          AND nmbt002 IS NOT NULL ", #151224-00022#1 add
                                         "       )" 
               END IF
               CALL q_nmbadocno()
            END IF
            #150417-00007#56 Add  ---(E)---
#161026-00010#1 add e---
            DISPLAY g_qryparam.return1 TO nmbadocno      #顯示到畫面上
            NEXT FIELD nmbadocno                         #返回原欄位
 
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc2 ON nmbadocdt
         BEFORE CONSTRUCT

      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc3 ON nmbb026
         BEFORE CONSTRUCT
  
          ON ACTION controlp INFIELD nmbb026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#5  add
            #CALL q_pmaa001()        #160913-00017#5  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO nmbb026  #顯示到畫面上

            NEXT FIELD nmbb026                     #返回原欄位
      END CONSTRUCT
     
      BEFORE DIALOG
         IF NOT cl_null(p_nmbadocno) THEN
            CALL cl_set_comp_entry('nmbadocno',FALSE)
            DISPLAY p_nmbadocno TO nmbadocno
            LET g_wc1=" nmbadocno='",p_nmbadocno,"'"
         END IF
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前 name="input.before_close"
   IF INT_FLAG THEN
      LET INT_FLAG = TRUE 
      EXIT WHILE
   ELSE
      CALL anmt311_01_ins_nmbs()
      DISPLAY g_nmbs_m.docno_311 TO docno_311
      #141106-00011#22--(S)--
      LET l_cnt = 0
      SELECT count(*) INTO l_cnt
        FROM nmbt_t
       WHERE nmbtent = g_enterprise
         AND nmbtld = g_nmbs_m.nmbsld AND nmbtdocno = g_nmbs_m.docno_311
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 AND NOT cl_null(g_nmbs_m.docno_311) THEN
         CALL s_aooi200_fin_get_slip(g_nmbs_m.nmbsdocno) RETURNING l_success,l_ooba002
         CALL s_fin_get_doc_para(g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
         SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
            AND glaald = g_nmbs_m.nmbsld
         IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
            CALL s_transaction_begin()
            CALL cl_err_collect_init() #161018-00004#1 add
            CALL s_pre_voucher_ins('NM','N10',g_nmbs_m.nmbsld,g_nmbs_m.docno_311,g_nmbs_m.nmbsdocdt,'1') RETURNING l_success
            CALL cl_err_collect_show() #161018-00004#1 add
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
            ELSE
               CALL s_transaction_end('Y',0)
            END IF
         END IF
         #161018-00004#1--add--str--
         IF cl_ask_confirm('apm-00285') THEN
            CONTINUE WHILE
         ELSE
            EXIT WHILE
         END IF
         #161018-00004#1--add--end
      END IF
      #141106-00011#22--(E)--
      
      CONTINUE WHILE
   END IF
   
   END WHILE

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_anmt311_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN g_nmbs_m.docno_311   #150803-00018#1
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt311_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt311_01.other_function" readonly="Y" >}
# 帳套名稱
PRIVATE FUNCTION anmt311_01_nmbsld_desc(p_nmbsld)
   DEFINE p_nmbsld    LIKE nmbs_t.nmbsld
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_nmbsld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbsld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbsld_desc

END FUNCTION
# 法人名稱帶值
PRIVATE FUNCTION anmt311_01_nmbscomp_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbs_m.nmbscomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbscomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbscomp_desc
END FUNCTION
# 插入單頭檔nmbs_t
PRIVATE FUNCTION anmt311_01_ins_nmbs()
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmbs          RECORD  LIKE nmbs_t.*  
   DEFINE l_nmbs RECORD  #帳務底稿主檔
       nmbsent LIKE nmbs_t.nmbsent, #企業編號
       nmbssite LIKE nmbs_t.nmbssite, #帳務中心
       nmbscomp LIKE nmbs_t.nmbscomp, #法人
       nmbsld LIKE nmbs_t.nmbsld, #帳套
       nmbsdocno LIKE nmbs_t.nmbsdocno, #帳務單號
       nmbsdocdt LIKE nmbs_t.nmbsdocdt, #帳務單日期
       nmbs001 LIKE nmbs_t.nmbs001, #作業來源
       nmbs002 LIKE nmbs_t.nmbs002, #附件張數
       nmbs003 LIKE nmbs_t.nmbs003, #傳票編號
       nmbs004 LIKE nmbs_t.nmbs004, #傳票日期
       nmbsownid LIKE nmbs_t.nmbsownid, #資料所有者
       nmbsowndp LIKE nmbs_t.nmbsowndp, #資料所屬部門
       nmbscrtid LIKE nmbs_t.nmbscrtid, #資料建立者
       nmbscrtdp LIKE nmbs_t.nmbscrtdp, #資料建立部門
       nmbscrtdt LIKE nmbs_t.nmbscrtdt, #資料創建日
       nmbsmodid LIKE nmbs_t.nmbsmodid, #資料修改者
       nmbsmoddt LIKE nmbs_t.nmbsmoddt, #最近修改日
       nmbscnfid LIKE nmbs_t.nmbscnfid, #資料確認者
       nmbscnfdt LIKE nmbs_t.nmbscnfdt, #資料確認日
       nmbsstus LIKE nmbs_t.nmbsstus  #狀態碼
       END RECORD

   #161128-00061#2---modify----end---------
   DEFINE l_date          DATETIME YEAR TO SECOND
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glaald        LIKE glaa_t.glaald
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_glaa003       LIKE glaa_t.glaa003   #会计周期参照表号
   DEFINE l_glaa024       LIKE glaa_t.glaa024   #单据别参照表号
   
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   LET l_nmbs.nmbsent = g_enterprise
   LET l_nmbs.nmbscomp = g_nmbs_m.nmbscomp
   #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/29 liuym mark-----str-----
   #CALL s_aooi200_gen_docno(g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_today,'anmt311')   
   #RETURNING l_success,l_nmbs.nmbsdocno
   #2014/12/29 liuym mark-----end-----
   #2014/12/29 liuym add-----str------
   #财务改为使用s_aooi200_fin中的FUNCTION
   #获取会计周期参照表号+单据别参照表号
   SELECT glaa003,glaa024 INTO l_glaa003,l_glaa024 FROM glaa_t WHERE glaaent=g_enterprise AND glaald= g_nmbs_m.nmbsld
  #CALL s_aooi200_fin_gen_docno(g_nmbs_m.nmbsld,l_glaa024,l_glaa003,g_nmbs_m.nmbsdocno,g_today,'anmt311')            #150924 mark
   CALL s_aooi200_fin_gen_docno(g_nmbs_m.nmbsld,l_glaa024,l_glaa003,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,'anmt311') #150924
        RETURNING l_success,l_nmbs.nmbsdocno
   #2014/12/26 liuym add-----end-----                        
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_nmbs.nmbsdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN
   END IF
   
   CALL cl_err_collect_init()
   
   LET g_nmbs_m.docno_311 = l_nmbs.nmbsdocno
   LET l_nmbs.nmbscomp = g_nmbs_m.nmbscomp
   LET l_nmbs.nmbssite = g_site
   LET l_nmbs.nmbsdocdt = g_nmbs_m.nmbsdocdt
   LET l_nmbs.nmbs001 = 'anmt311'
   LET l_nmbs.nmbsownid = g_user
   LET l_nmbs.nmbsowndp = g_dept
   LET l_nmbs.nmbscrtid = g_user
   LET l_nmbs.nmbscrtdp = g_dept 
   LET l_date = cl_get_current()    #nmbscrtdt
   LET l_nmbs.nmbsmodid = ""
   LET l_nmbs.nmbsmoddt = ""
   LET l_nmbs.nmbscnfid = ""
   LET l_nmbs.nmbscnfdt = ""
   LET l_nmbs.nmbsstus = 'N'
   
   IF g_nmbs_m.c = 'N' THEN 
      LET l_nmbs.nmbsld = g_nmbs_m.nmbsld
      
      #插入單頭檔
      INSERT INTO nmbs_t(nmbssite,nmbsent,nmbscomp,nmbsld,nmbsdocno,nmbsdocdt,nmbs001,nmbsownid,nmbsowndp,nmbscrtid,
                         nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt,nmbscnfid,nmbscnfdt,nmbsstus)
                  VALUES(l_nmbs.nmbssite,l_nmbs.nmbsent,l_nmbs.nmbscomp,l_nmbs.nmbsld,l_nmbs.nmbsdocno,l_nmbs.nmbsdocdt,
                         l_nmbs.nmbs001,l_nmbs.nmbsownid,l_nmbs.nmbsowndp,l_nmbs.nmbscrtid,l_nmbs.nmbscrtdp,
                         l_date,l_nmbs.nmbsmodid,l_nmbs.nmbsmoddt,l_nmbs.nmbscnfid,l_nmbs.nmbscnfdt,
                         l_nmbs.nmbsstus)
      IF SQLCA.SQLcode  THEN
         #CALL cl_errmsg("ins nmbs",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'                        
      END IF
      
      #插入單身檔
      #IF g_nmbs_m.a = 'Y' OR g_nmbs_m.b = 'Y' OR g_nmbs_m.f = 'Y' THEN   #20150521 add lujh   #160509-00004#12 liyan #161026-00010#1 mark
      IF g_nmbs_m.a = 'Y' OR g_nmbs_m.b = 'Y' OR g_nmbs_m.f = 'Y' OR g_nmbs_m.g = 'Y' OR g_nmbs_m.h = 'Y' THEN   #20150521 add lujh   #160509-00004#12 liyan #161026-00010#1 add
         CALL anmt311_01_ins_nmbt(l_nmbs.nmbsdocno,l_nmbs.nmbsld)
      END IF  #20150521 add lujh
      
      #20150521--add--str--lujh
      IF g_nmbs_m.d = 'Y' THEN 
         CALL anmt311_01_ins_nmbt_9(l_nmbs.nmbsdocno,l_nmbs.nmbsld)
      END IF
      #20150521--add--end--lujh

      #150417-00007#56 Add ---(S)---
      IF g_nmbs_m.e = 'Y' THEN 
         CALL anmt311_01_ins_nmbt_10(l_nmbs.nmbsdocno,l_nmbs.nmbsld)
      END IF
      #150417-00007#56 Add ---(E)---

   END IF
   
   IF g_nmbs_m.c = 'Y' THEN 
       LET g_sql = "SELECT glaald FROM glaa_t ",
                   " WHERE glaaent = '",g_enterprise,"'",
                   "   AND glaacomp = '",g_nmbs_m.nmbscomp,"'",
                   "   AND (glaa014 = 'Y' OR glaa008 = 'Y') "
       PREPARE anmt311_01_pre1 FROM g_sql
       DECLARE anmt311_01_cur1 CURSOR FOR anmt311_01_pre1
       FOREACH anmt311_01_cur1 INTO l_glaald
          #插入單頭檔
          INSERT INTO nmbs_t(nmbssite,nmbsent,nmbscomp,nmbsld,nmbsdocno,nmbsdocdt,nmbs001,nmbsownid,nmbsowndp,nmbscrtid,
                             nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt,nmbscnfid,nmbscnfdt,nmbsstus)
                      VALUES(l_nmbs.nmbssite,l_nmbs.nmbsent,l_nmbs.nmbscomp,l_glaald,l_nmbs.nmbsdocno,l_nmbs.nmbsdocdt,
                             l_nmbs.nmbs001,l_nmbs.nmbsownid,l_nmbs.nmbsowndp,l_nmbs.nmbscrtid,l_nmbs.nmbscrtdp,
                             l_date,l_nmbs.nmbsmodid,l_nmbs.nmbsmoddt,l_nmbs.nmbscnfid,l_nmbs.nmbscnfdt,
                             l_nmbs.nmbsstus)
          IF SQLCA.SQLcode  THEN
             #CALL cl_errmsg("ins nmbs",'','',SQLCA.SQLCODE,1) 
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.SQLCODE
             LET g_errparam.extend = "ins nmbs"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET g_success = 'N'                        
          END IF
          #插入單身檔
          IF g_nmbs_m.a = 'Y' OR g_nmbs_m.b = 'Y' THEN   #20150521 add lujh
             CALL anmt311_01_ins_nmbt(l_nmbs.nmbsdocno,l_glaald)
          END IF  #20150521 add lujh
          
          #20150521--add--str--lujh
          IF g_nmbs_m.d = 'Y' THEN 
             CALL anmt311_01_ins_nmbt_9(l_nmbs.nmbsdocno,l_nmbs.nmbsld)
          END IF
          #20150521--add--end--lujh

          #150417-00007#56 Add ---(S)---
          IF g_nmbs_m.e = 'Y' THEN 
             CALL anmt311_01_ins_nmbt_10(l_nmbs.nmbsdocno,l_nmbs.nmbsld)
          END IF
          #150417-00007#56 Add ---(E)---

       END FOREACH 
   END IF
   
   #2015/6/23--by--02599--str--
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld AND nmbtdocno = g_nmbs_m.docno_311
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt =0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = "axr-00241"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N' 
   END IF
   #2015/6/23--by--02599--end
   CALL cl_err_collect_show() #161018-00004#1 add
   IF g_success = 'N' THEN
      #CALL cl_err_showmsg() 
#      CALL cl_err_collect_show() #161018-00004#1 mark
      LET g_nmbs_m.docno_311 = null
      CALL s_transaction_end('N','1') 
   ELSE
      SELECT COUNT(*) INTO l_cnt FROM nmbt_t WHERE nmbtent = g_enterprise AND nmbtdocno = l_nmbs.nmbsdocno
      IF l_cnt = 0 OR cl_null(l_cnt) THEN
         LET g_nmbs_m.docno_311 = null
         CALL s_transaction_end('N','1')
      ELSE
         CALL s_transaction_end('Y','1')
      END IF       
   END IF
   
   
END FUNCTION
# 插入單身檔nmbt_t
PRIVATE FUNCTION anmt311_01_ins_nmbt(p_nmbtdocno,p_nmbtld)
DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
#161128-00061#2---modify----begin----------
#DEFINE l_nmbt          RECORD  LIKE nmbt_t.* 
DEFINE l_nmbt RECORD  #帳務底稿明細檔
       nmbtent LIKE nmbt_t.nmbtent, #企業編號
       nmbtcomp LIKE nmbt_t.nmbtcomp, #法人
       nmbtld LIKE nmbt_t.nmbtld, #帳套(套)編號
       nmbtdocno LIKE nmbt_t.nmbtdocno, #帳務編號
       nmbtseq LIKE nmbt_t.nmbtseq, #項次
       nmbt001 LIKE nmbt_t.nmbt001, #單據來源
       nmbt002 LIKE nmbt_t.nmbt002, #來源單號
       nmbt003 LIKE nmbt_t.nmbt003, #來源單項次
       nmbt011 LIKE nmbt_t.nmbt011, #票據號碼
       nmbt012 LIKE nmbt_t.nmbt012, #票據日期
       nmbt013 LIKE nmbt_t.nmbt013, #申請人
       nmbt014 LIKE nmbt_t.nmbt014, #銀行帳號
       nmbt015 LIKE nmbt_t.nmbt015, #結算方式
       nmbt016 LIKE nmbt_t.nmbt016, #收支專案
       nmbt017 LIKE nmbt_t.nmbt017, #營運據點
       nmbt018 LIKE nmbt_t.nmbt018, #部門
       nmbt019 LIKE nmbt_t.nmbt019, #利潤/成本中心
       nmbt020 LIKE nmbt_t.nmbt020, #區域
       nmbt021 LIKE nmbt_t.nmbt021, #交易客商
       nmbt022 LIKE nmbt_t.nmbt022, #帳款客商
       nmbt023 LIKE nmbt_t.nmbt023, #客群
       nmbt024 LIKE nmbt_t.nmbt024, #產品類別
       nmbt025 LIKE nmbt_t.nmbt025, #人員
       nmbt026 LIKE nmbt_t.nmbt026, #預算編號
       nmbt027 LIKE nmbt_t.nmbt027, #專案編號
       nmbt028 LIKE nmbt_t.nmbt028, #WBS
       nmbt029 LIKE nmbt_t.nmbt029, #科目
       nmbt030 LIKE nmbt_t.nmbt030, #對方科目
       nmbt031 LIKE nmbt_t.nmbt031, #經營方式
       nmbt032 LIKE nmbt_t.nmbt032, #渠道
       nmbt033 LIKE nmbt_t.nmbt033, #品牌
       nmbt034 LIKE nmbt_t.nmbt034, #自由核算項一
       nmbt035 LIKE nmbt_t.nmbt035, #自由核算項二
       nmbt036 LIKE nmbt_t.nmbt036, #自由核算項三
       nmbt037 LIKE nmbt_t.nmbt037, #自由核算項四
       nmbt038 LIKE nmbt_t.nmbt038, #自由核算項五
       nmbt039 LIKE nmbt_t.nmbt039, #自由核算項六
       nmbt040 LIKE nmbt_t.nmbt040, #自由核算項七
       nmbt041 LIKE nmbt_t.nmbt041, #自由核算項八
       nmbt042 LIKE nmbt_t.nmbt042, #自由核算項九
       nmbt043 LIKE nmbt_t.nmbt043, #自由核算項十
       nmbt100 LIKE nmbt_t.nmbt100, #幣別
       nmbt101 LIKE nmbt_t.nmbt101, #匯率
       nmbt103 LIKE nmbt_t.nmbt103, #原幣金額
       nmbt113 LIKE nmbt_t.nmbt113, #本幣金額
       nmbt121 LIKE nmbt_t.nmbt121, #本位幣二匯率
       nmbt123 LIKE nmbt_t.nmbt123, #本位幣二金額
       nmbt131 LIKE nmbt_t.nmbt131, #本位幣三匯率
       nmbt133 LIKE nmbt_t.nmbt133, #本位幣三金額
       nmbt004 LIKE nmbt_t.nmbt004, #異動別
       nmbt114 LIKE nmbt_t.nmbt114  #開立金額
       END RECORD

#161128-00061#2---modify----end----------
DEFINE l_nmbt002       LIKE nmbt_t.nmbt002
DEFINE l_nmbt003       LIKE nmbt_t.nmbt003
DEFINE l_nmbadocdt     LIKE nmba_t.nmbadocdt
DEFINE l_nmbb001       LIKE nmbb_t.nmbb001
DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
DEFINE l_nmbb028       LIKE nmbb_t.nmbb028   #150707-00001#7
DEFINE l_nmbb029       LIKE nmbb_t.nmbb029   #150707-00001#7
DEFINE l_nmba003       LIKE nmba_t.nmba003
DEFINE l_nmba015       like nmba_t.nmba015  #160509-00004#12
DEFINE l_glaa014       LIKE glaa_t.glaa014
DEFINE l_glaa001       LIKE glaa_t.glaa001
DEFINE l_glaa008       LIKE glaa_t.glaa008
DEFINE l_glaa015       LIKE glaa_t.glaa015
DEFINE l_glaa016       LIKE glaa_t.glaa016
DEFINE l_glaa017       LIKE glaa_t.glaa017
DEFINE l_glaa018       LIKE glaa_t.glaa018
DEFINE l_glaa019       LIKE glaa_t.glaa019
DEFINE l_glaa020       LIKE glaa_t.glaa020
DEFINE l_glaa021       LIKE glaa_t.glaa021
DEFINE l_glaa022       LIKE glaa_t.glaa022
DEFINE l_success       LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_ooam003       LIKE ooam_t.ooam003
DEFINE l_cnt           LIKE type_t.num5     #150714-00024#1
DEFINE l_prog_310      LIKE nmba_t.nmba003  #161026-00010#1 add
DEFINE l_prog_540      LIKE nmba_t.nmba003  #161026-00010#1 add 
DEFINE l_prog_541      LIKE nmba_t.nmba003  #161026-00010#1 add  
DEFINE l_prog_510      LIKE nmba_t.nmba003  #161026-00010#1 add  
   
   CALL s_ld_sel_glaa(p_nmbtld,'glaa008|glaa014|glaa001|glaa015|glaa016|glaa017|glaa018|glaa019|glaa020|glaa021|glaa022')
        RETURNING l_success,l_glaa008,l_glaa014,l_glaa001,l_glaa015,l_glaa016,
                            l_glaa017,l_glaa018,l_glaa019,l_glaa020,l_glaa021,
                            l_glaa022
   
   LET g_sql = "SELECT nmbbdocno,nmbbseq,nmbb030,nmbb031,nmbb003,",
#               "       nmbacomp,nmba001,nmba004,nmba008,nmbb004,",  #160331-00011#1 mark
                "       nmbacomp,nmba001,nmba015,nmbb026,nmba008,nmbb004,",  #160331-00011#1 add  #160509-0004#12 by liyan
               "       nmbb005,nmbb006,nmbb007,nmbb001,nmbadocdt,",
               "       nmba003,nmbb028,nmbb029 ",   #150707-00001#7 add nmbb028/nmbb029       
               "  FROM nmba_t,nmbb_t",
               " WHERE nmbaent = nmbbent ",
               "   AND nmbacomp = nmbbcomp ",
               "   AND nmbadocno = nmbbdocno ",
               #"   AND nmba006 = 'Y' ",           #141106-00011#22 #161026-00010#1 mark 
               "   AND nmbaent = '",g_enterprise,"'",
               "   AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               #"   AND nmba006 = 'Y'", #150714-00024#1 #161026-00010#1 mark 
               "   AND ",g_wc1,
               "   AND ",g_wc2,
               "   AND ",g_wc3
#161026-00010#1 mark s---               
#   IF g_nmbs_m.a = 'Y' AND g_nmbs_m.b = 'N' THEN   #繳款單
#      LET g_sql = g_sql CLIPPED," AND nmbastus = 'V'"       #150714-00024#1
#     #LET g_sql = g_sql CLIPPED," AND nmba003 = 'anmt540'"                 #151021 by 03538 mark
#      LET g_sql = g_sql CLIPPED," AND nmba003 IN ('anmt540','anmt541') "   #151021 by 03538      
#   END IF
#   IF g_nmbs_m.b = 'Y' AND g_nmbs_m.a = 'N' THEN   #銀存收支單
##      LET g_sql = g_sql CLIPPED," AND nmba003 = 'anmt310'"  #2015/6/23 by 02599 mark
#      LET g_sql = g_sql CLIPPED," AND (nmbastus = 'Y' OR nmbastus = 'V' )"       #150714-00024#1
#      LET g_sql = g_sql CLIPPED," AND (nmba003 = 'anmt310' OR nmba003 = 'adet402' OR nmba003 = 'anmt440' OR nmba003 = 'aapt352')"  #2015/6/23 by 02599 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
#   END IF
#   #160509-00004#12--byliyan --str--
#   IF g_nmbs_m.f = 'Y' AND g_nmbs_m.b = 'N' AND g_nmbs_m.a = 'N' AND g_nmbs_m.d = 'N' AND g_nmbs_m.e = 'N' THEN 
#      LET g_sql = g_sql CLIPPED," AND (nmbastus = 'Y' OR nmbastus = 'V' )"     
#      LET g_sql = g_sql CLIPPED," AND (nmba003 = 'anmt310' )"
#   END IF
#   #160509-00004#12 by liyan --end--
#   IF g_nmbs_m.a = 'Y' AND g_nmbs_m.b = 'Y' THEN   #繳款單,銀存收支單同時產生
#      LET g_sql = g_sql CLIPPED," AND ((nmba003 IN ('anmt310','adet402','anmt440','aapt352') AND (nmbastus = 'Y' OR nmbastus = 'V' ) ) ",   #150714-00024#1 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
#                               #"  OR (nmba003 = 'anmt540' AND nmbastus = 'V' ))"                #151021 by 03538 mark   #150714-00024#1
#                                "  OR (nmba003 IN ('anmt540','anmt541') AND nmbastus = 'V' ))"   #151021 by 03538       
#      #LET g_sql = g_sql CLIPPED," AND (nmba003 = 'anmt540' OR nmba003 = 'anmt310')" #150714-00024#1 mark
#   END IF
#   #161018-00004#1--add--str--
#161026-00010#1 mark e---
#161026-00010#1 add s---
   IF g_nmbs_m.a = 'Y' OR g_nmbs_m.b = 'Y' OR g_nmbs_m.g = 'Y' OR  g_nmbs_m.h = 'Y' THEN
      IF g_nmbs_m.a = 'Y' THEN
         LET l_prog_540 = 'anmt540'
      ELSE
         LET l_prog_540 = ''         
      END IF
      IF g_nmbs_m.b = 'Y' THEN
         LET l_prog_310 = 'anmt310' 
      ELSE
         LET l_prog_310 = ''         
      END IF
      IF g_nmbs_m.g = 'Y' THEN
         LET l_prog_510 = 'anmt510'
      ELSE
         LET l_prog_510 = ''         
      END IF
      IF g_nmbs_m.h = 'Y' THEN
         LET l_prog_541 = 'anmt541' 
      ELSE
         LET l_prog_541 = ''         
      END IF      
      IF g_nmbs_m.b = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                                #"  AND    ((nmba003 IN ('",l_prog_540,"','",l_prog_541,"') AND nmba006 = 'Y') ", #170207-00041#1 mark
                                "  AND    ((((nmba003 IN ('",l_prog_540,"','",l_prog_541,"') AND nmba006 = 'Y') ",  #170207-00041#1 add
                                "       OR nmba003 IN ('",l_prog_510,"')) AND nmbastus = 'V' ) ",
                                "   OR (nmba003 IN ('adet402','anmt440','",l_prog_310,"','aapt352') AND nmbastus = 'Y')) "
      ELSE
         LET g_sql = g_sql CLIPPED,
                                "   AND    ((nmba003 IN ('",l_prog_540,"','",l_prog_541,"') AND nmba006 = 'Y') OR nmba003 IN ('",l_prog_510,"') )",
                                "   AND nmbastus = 'V'"               
      END IF          
   END IF
#161026-00010#1 add e---   

   #160509-00004#12--byliyan --str--
   IF g_nmbs_m.f = 'Y' AND g_nmbs_m.b = 'N' AND g_nmbs_m.a = 'N' AND g_nmbs_m.d = 'N' AND g_nmbs_m.e = 'N' THEN 
      #LET g_sql = g_sql CLIPPED," AND nmbastus = 'V'" #161026-00010#1 mark
      LET g_sql = g_sql CLIPPED," AND nmbastus = 'Y'"  #161026-00010#1 add      
      LET g_sql = g_sql CLIPPED," AND (nmba003 = 'anmt310' )"
   END IF
   #160509-00004#12 by liyan --end--

   #161018-00004#1--add--str--
   LET g_sql=g_sql,
             " AND nmbbdocno||'-'||nmbbseq NOT IN (SELECT nmbt002||'-'||nmbt003 FROM nmbt_t ",
             "                               LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno",
             "                                WHERE nmbtent =",g_enterprise,
             "                                  AND nmbtld ='",p_nmbtld,"'",
             "                                  AND nmbsstus <> 'X')"
   #161018-00004#1--add--end
#161026-00010#1 add e---   
   LET g_sql = g_sql CLIPPED," ORDER BY nmbadocdt,nmbacomp,nmbbdocno,nmbbseq"

   PREPARE anmt311_01_pre2 FROM g_sql
   DECLARE anmt311_01_cur2 CURSOR FOR anmt311_01_pre2
   
   FOREACH anmt311_01_cur2 INTO l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,l_nmbt.nmbt014,
                                l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmba015,l_nmbt.nmbt021,l_nmbt.nmbt025,l_nmbt.nmbt100,
                                l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbb001,l_nmbadocdt,
                                l_nmba003,l_nmbb028,l_nmbb029   #150707-00001#7 add nmbb028/nmbb029       
      #檢查單號是否已存在
      IF g_nmbs_m.c = 'Y' THEN
         SELECT COUNT(*) INTO l_n
           FROM nmbt_t
           LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno #150714-00024#1
          WHERE nmbtent = g_enterprise
            AND nmbt002 = l_nmbt.nmbt002
            AND nmbt003 = l_nmbt.nmbt003
            AND nmbtld  = p_nmbtld
            AND nmbsstus <> 'X'  #150714-00024#1
      ELSE
         SELECT COUNT(*) INTO l_n
           FROM nmbt_t
           LEFT JOIN nmbs_t ON nmbsent=nmbtent AND nmbsld=nmbtld AND nmbsdocno=nmbtdocno #150714-00024#1
          WHERE nmbtent = g_enterprise
            AND nmbt002 = l_nmbt.nmbt002
            AND nmbt003 = l_nmbt.nmbt003
            AND nmbtld  = p_nmbtld
            AND nmbsstus <> 'X'  #150714-00024#1
      END IF
      IF l_n > 0 THEN
         #CALL cl_errmsg(l_nmbt.nmbt002,l_nmbt.nmbt003,'','anm-00171',1) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00171'
         LET g_errparam.extend = l_nmbt.nmbt002
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         CONTINUE FOREACH 
      END IF
                                
                                
      LET l_nmbt.nmbtent = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld = p_nmbtld
      LET l_nmbt.nmbtdocno = p_nmbtdocno
      SELECT MAX(nmbtseq) + 1 INTO l_nmbt.nmbtseq
        FROM nmbt_t
       WHERE nmbtent = g_enterprise
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtdocno = l_nmbt.nmbtdocno
      IF cl_null(l_nmbt.nmbtseq) THEN 
         LET l_nmbt.nmbtseq = 1
      END IF
      IF l_nmba003 = 'anmt310' OR l_nmba003 = 'adet402' OR l_nmba003 = 'anmt440' OR l_nmba003 = 'aapt352' THEN   #銀存收支單 #2015/6/25 by 02599 增加adet402 #160811-00055#2 add anmt440 #160518-00024#14 add aapt352
         LET l_nmbt.nmbt001 = '3'
      END IF

     #IF l_nmba003 = 'anmt540' THEN   #繳款單            #151021 by 03538 mark
     #IF l_nmba003 MATCHES 'anmt54[01]' THEN            #151021 by 03538      #161026-00010#1 mark
      IF l_nmba003 = 'anmt540' THEN                      #161026-00010#1 add
         LET l_nmbt.nmbt001 = '4'
      END IF
      #161026-00010#1 add s---
      IF l_nmba003 = 'anmt541' THEN                      #161026-00010#1 add
         LET l_nmbt.nmbt001 = '13'
      END IF      
      IF l_nmba003 = 'anmt510' THEN                      #161026-00010#1 add
         LET l_nmbt.nmbt001 = '1'
      END IF      
      #161026-00010#1 add e---
      #160509-00004#12 by liyan--str--
      IF l_nmba015='Y' THEN 
         LET l_nmbt.nmbt001 = '11' 
      END IF 
      #160509-00004#12 by liyan --end--
      LET l_nmbt.nmbt004 = l_nmbb001   #150707-00001#7

      LET l_nmbt.nmbt013 = g_user
     
      LET l_nmbt.nmbt022 = l_nmbt.nmbt021
      SELECT ooeg004 INTO l_nmbt.nmbt019
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_nmbt.nmbt018
        
      IF l_glaa014 = 'Y' THEN 
         IF l_glaa015 = 'Y' THEN
             #主帳套本位幣二匯率
             IF l_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt.nmbt100
             ELSE
                LET l_ooam003 = l_glaa001
             END IF
                                        #帳套     #日期;       來源幣別   目的幣別; 匯類類型
             CALL anmt311_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa016,l_glaa018)
             RETURNING l_nmbt.nmbt121   
             LET l_nmbt.nmbt123 = l_nmbt.nmbt113 * l_nmbt.nmbt121
         END IF
          
         IF l_glaa019 = 'Y' THEN
            #主帳套本位幣三匯率
            IF l_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt.nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                       #帳套     #日期;       來源幣別   目的幣別; 匯類類型
            CALL anmt311_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa020,l_glaa022)
            RETURNING l_nmbt.nmbt131   
            LET l_nmbt.nmbt133 = l_nmbt.nmbt113 * l_nmbt.nmbt131
         END IF
      END IF
     
      #平行賬套,金額匯率重新計算
      IF l_glaa014 <> 'Y' AND l_glaa008 = 'Y' THEN 
         LET l_nmbt.nmbt101 = 0
         LET l_nmbt.nmbt113 = 0
         #150930-00010#4--s
         IF l_nmbb001 = '2' THEN
            CALL cl_get_para(g_enterprise,l_nmbt.nmbtcomp,'S-FIN-4012') RETURNING g_para_data   #銀存支出匯率來源
         ELSE
         #150930-00010#4--e
            CALL cl_get_para(g_enterprise,l_nmbt.nmbtcomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源
         END IF   #150930-00010#4
         #平行賬套匯率
         #150930-00010#4--s
         IF g_para_data = '23' THEN
            #銀行日平均匯率
            CALL s_anm_get_exrate(p_nmbtld,l_nmbt.nmbtcomp,l_nmbt.nmbt014,l_nmbt.nmbt100,l_glaa001,l_nmbadocdt) 
             RETURNING l_nmbt.nmbt101 
         ELSE         
         #150930-00010#4--e
                                       #帳套     #日期;       來源幣別        目的幣別; 匯類類型
            CALL anmt311_01_get_exrate(p_nmbtld,l_nmbadocdt,l_nmbt.nmbt100,l_glaa001,g_para_data)
             RETURNING l_nmbt.nmbt101    
         END IF    #150930-00010#4
         LET l_nmbt.nmbt113 = l_nmbt.nmbt103 * l_nmbt.nmbt101
         
         IF l_glaa015 = 'Y' THEN
             #主帳套本位幣二匯率
             IF l_glaa017 = '1' THEN
                LET l_ooam003 = l_nmbt.nmbt100
             ELSE
                LET l_ooam003 = l_glaa001
             END IF
                                        #帳套    #日期;       來源幣別   目的幣別; 匯類類型
             CALL anmt311_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa016,l_glaa018)
                  RETURNING l_nmbt.nmbt121
             LET l_nmbt.nmbt123 = l_nmbt.nmbt113 * l_nmbt.nmbt121
         END IF
         
         IF l_glaa019 = 'Y' THEN
            #主帳套本位幣三匯率
            IF l_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt.nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                       #帳套    #日期;       來源幣別   目的幣別; 匯類類型
            CALL anmt311_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa020,l_glaa022)
                 RETURNING l_nmbt.nmbt131
            LET l_nmbt.nmbt133 = l_nmbt.nmbt113 * l_nmbt.nmbt131
         END IF
      END IF
      
      #科目
      LET l_nmbb002 = ''
      LET l_nmbb003 = ''
      SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
        FROM nmbb_t
       WHERE nmbbent = g_enterprise
         AND nmbbcomp = g_nmbs_m.nmbscomp
         AND nmbbdocno = l_nmbt.nmbt002
         AND nmbbseq = l_nmbt.nmbt003
     
      LET l_nmbt.nmbt029 = "" #150817
      LET l_nmbt.nmbt030 = "" #150817
      IF l_nmbt.nmbt001 = '3' OR l_nmbt.nmbt001 = '4' THEN
         #150707-00001#7--(s)
         CASE l_nmbt.nmbt001
            WHEN '3'
               #anmt310異動別:1存入/2提出
               IF l_nmbb001 MATCHES '[12]' THEN
                  SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi121
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = p_nmbtld
                     AND glab001 = '40'
                     AND glab002 = '40'
                     AND glab003 = l_nmbb003
               END IF
               #anmt310異動別:3借方科目/4貸方科目
               IF l_nmbb001 MATCHES '[34]' THEN
                  SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi171
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = p_nmbtld
                     AND glab001 = '43'
                     AND glab002 = '43'
                     AND glab003 = l_nmbb002
               END IF
               
            #160509-00004#12 by liyan --str--
            WHEN '11'
               #anmt310異動別:1存入/2提出
               IF l_nmbb001 MATCHES '[12]' THEN
                  SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi121
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = p_nmbtld
                     AND glab001 = '40'
                     AND glab002 = '40'
                     AND glab003 = l_nmbb003
               END IF
               #anmt310異動別:3借方科目/4貸方科目
               IF l_nmbb001 MATCHES '[34]' THEN
                  SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi171
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = p_nmbtld
                     AND glab001 = '43'
                     AND glab002 = '43'
                     AND glab003 = l_nmbb002
               END IF
            #160509-00004#12 by liyan --end--
            WHEN '4'
               #當款別為10/20,取銀行帳戶科目anmi121;其他款別則依款別科目agli190
               IF l_nmbb029 MATCHES '[12]0' THEN
                  SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi121
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = p_nmbtld
                     AND glab001 = '40'
                     AND glab002 = '40'
                     AND glab003 = l_nmbb003
               ELSE
                  SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #agli190 
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = p_nmbtld
                     AND glab001 = '21'
                     AND glab002 = l_nmbb029
                     AND glab003 = l_nmbb028
               END IF
         END CASE
         #150707-00001#7--(e)
         #150707-00001#7--mark--(s)
         #SELECT DISTINCT glab006 INTO l_nmbt.nmbt029  #anmi171
         #  FROM glab_t
         # WHERE glabent = g_enterprise
         #   AND glabld  = p_nmbtld
         #   AND glab001 = '43'
         #   AND glab002 = '43'
         #   AND glab003 = l_nmbb002
         #150707-00001#7--mark--(e)
      ELSE     
         SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi121
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld  = p_nmbtld
            AND glab001 = '40'
            AND glab002 = '40'
            AND glab003 = l_nmbb003
      END IF 
      
      #150803-00018#1 add ------
      CASE
         WHEN l_nmbt.nmbt001 = '4'  #繳款單>>取anmi152收款待沖銷科目
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld = p_nmbtld
               AND glab001 = '41'
               AND glab002 = '8714'
               AND glab003 = 'F'
         OTHERWISE
     #IF l_nmbt.nmbt001 <> '3' THEN   #150707-00001#7 #150803-00018#1 mark
            #对方科目
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt030  #anmi171 
             #FROM glab_t,nmbb_t   #150707-00001#7 mark
              FROM glab_t          #150707-00001#7
             WHERE glabent = g_enterprise
               AND glabld  = p_nmbtld
               AND glab001 = '43'
               AND glab002 = '43'
               AND glab003 = l_nmbb002
     #END IF   #150707-00001#7 #150803-00018#1 mark
      END CASE
      #150803-00018#1 add end---
      #160509-00004 by liyan --str--
      IF g_nmbs_m.f = 'Y' THEN 
         SELECT nmbb070 INTO l_nmbt.nmbt017 FROM nmbb_t WHERE nmbbdocno=l_nmbt.nmbt002 AND nmbbseq=l_nmbt.nmbt003 AND nmbbent = g_enterprise #160905-00007#8 add nmbbent = g_enterprise  
      END IF 
      #160509-00004 by liyan --end--
      
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,
                         nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,
                         nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,
                         nmbt028,nmbt029,nmbt030,nmbt100,nmbt101,
                         nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,
                         nmbt133,nmbt004                     #150707-00001#7 add nmbt004
                         ) VALUES(
                         g_enterprise,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,
                         l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,
                         l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,
                         l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt100,l_nmbt.nmbt101,
                         l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,
                         l_nmbt.nmbt133,l_nmbt.nmbt004       #150707-00001#7 add nmbt004
                         )
      IF SQLCA.SQLcode  THEN
         #CALL cl_errmsg("ins nmbt",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
      
      #151111-00001#1--add--str--lujh
      LET l_nmbt.nmbt034 = ''
      LET l_nmbt.nmbt035 = ''
      LET l_nmbt.nmbt036 = ''
      LET l_nmbt.nmbt037 = ''
      LET l_nmbt.nmbt038 = ''
      LET l_nmbt.nmbt039 = ''
      LET l_nmbt.nmbt040 = ''
      LET l_nmbt.nmbt041 = ''
      LET l_nmbt.nmbt042 = ''
      LET l_nmbt.nmbt043 = ''
      
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
      
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
      #151111-00001#1--add--end--lujh
     
  #   IF l_nmba003 = 'anmt310' THEN   #銀存收支單
  #      CALL anmt311_01_nmbv_ins(p_nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'3',l_nmbt.nmbt002,l_nmbb001,l_nmbt.nmbt003,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt123,l_nmbt.nmbt133)
  #   END IF
  #   IF l_nmba003 = 'anmt540' THEN   #繳款單
  #      CALL anmt311_01_nmbv_ins(p_nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'4',l_nmbt.nmbt002,l_nmbb001,l_nmbt.nmbt003,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt123,l_nmbt.nmbt133)
  #   END IF
      #151224-00022#1--add--str--
      #當錄入3.銀存收支單時，在輸入資料同時，插入一筆相反資料，
      #即當錄入1.存入時再插入一筆4.貸方科目，當錄入2.提出時再插入一筆3.借方科目,
      #  當錄入3.借方科目時再插入一筆4.貸方科目，當錄入4.貸方科目時再插入一筆3.借方科目
      IF l_nmbt.nmbt001 = '3' OR l_nmbt.nmbt001 = '11' THEN #160509-00004312 add by liyan
         #當異動別為：1.存入或2.提出時，nmbt029按存提码取glab005的存提科目
         IF l_nmbb001='1' OR l_nmbb001='2' THEN
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt029  #anmi171
             FROM glab_t
            WHERE glabent = g_enterprise
              AND glabld  = l_nmbt.nmbtld
              AND glab001 = '43'
              AND glab002 = '43'
              AND glab003 = l_nmbb002
         END IF
         #當異動別為：3.借方科目或4.貸方科目時，nmbt029按存提码取glab006的对应科目
         IF l_nmbb001='3' OR l_nmbb001='4' THEN
            SELECT DISTINCT glab006 INTO l_nmbt.nmbt029  #anmi171
             FROM glab_t
            WHERE glabent = g_enterprise
              AND glabld  = l_nmbt.nmbtld
              AND glab001 = '43'
              AND glab002 = '43'
              AND glab003 = l_nmbb002
         END IF
         #160519-00043#1--add--str--
         IF cl_null(l_nmbt.nmbt029) THEN
            CONTINUE FOREACH
         END IF
         #160519-00043#1--add--end
         #異動別
         IF l_nmbb001='1' OR l_nmbb001='3' THEN
            LET l_nmbt.nmbt004='4'
         END IF
         IF l_nmbb001='2' OR l_nmbb001='4' THEN
            LET l_nmbt.nmbt004='3'
         END IF
         #160509-00004 by liyan --str--
         IF g_nmbs_m.f = 'Y' THEN 
            SELECT nmbb070 INTO l_nmbt.nmbt017 FROM nmbb_t WHERE nmbbdocno=l_nmbt.nmbt002 AND nmbbseq=l_nmbt.nmbt003 AND nmbbent = g_enterprise #160905-00007#8 add nmbbent = g_enterprise
         END IF 
      #160509-00004 by liyan --end--
         #項次
         LET l_nmbt.nmbtseq = l_nmbt.nmbtseq + 1
         INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,
                            nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                            nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,
                            nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                            nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,
                            nmbt028,nmbt029,nmbt030,nmbt100,nmbt101,
                            nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,
                            nmbt133,nmbt004
                            ) VALUES(
                            g_enterprise,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,
                            l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                            l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,
                            l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                            l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,
                            l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt100,l_nmbt.nmbt101,
                            l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,
                            l_nmbt.nmbt133,l_nmbt.nmbt004
                            )
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins nmbt"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
         
         LET l_nmbt.nmbt034 = ''
         LET l_nmbt.nmbt035 = ''
         LET l_nmbt.nmbt036 = ''
         LET l_nmbt.nmbt037 = ''
         LET l_nmbt.nmbt038 = ''
         LET l_nmbt.nmbt039 = ''
         LET l_nmbt.nmbt040 = ''
         LET l_nmbt.nmbt041 = ''
         LET l_nmbt.nmbt042 = ''
         LET l_nmbt.nmbt043 = ''
         
         LET g_free_m.free_item_1 = l_nmbt.nmbt034
         LET g_free_m.free_item_2 = l_nmbt.nmbt035
         LET g_free_m.free_item_3 = l_nmbt.nmbt036
         LET g_free_m.free_item_4 = l_nmbt.nmbt037
         LET g_free_m.free_item_5 = l_nmbt.nmbt038
         LET g_free_m.free_item_6 = l_nmbt.nmbt039
         LET g_free_m.free_item_7 = l_nmbt.nmbt040
         LET g_free_m.free_item_8 = l_nmbt.nmbt041
         LET g_free_m.free_item_9 = l_nmbt.nmbt042
         LET g_free_m.free_item_10 = l_nmbt.nmbt043
         
         LET g_field_m.field1 = 'nmbt034'
         LET g_field_m.field2 = 'nmbt035'
         LET g_field_m.field3 = 'nmbt036'
         LET g_field_m.field4 = 'nmbt037'
         LET g_field_m.field5 = 'nmbt038'
         LET g_field_m.field6 = 'nmbt039'
         LET g_field_m.field7 = 'nmbt040'
         LET g_field_m.field8 = 'nmbt041'
         LET g_field_m.field9 = 'nmbt042'
         LET g_field_m.field10 = 'nmbt043'
         
         CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
         RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                   l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                   l_nmbt.nmbt042,l_nmbt.nmbt043
         
         UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                           nmbt035 = l_nmbt.nmbt035,
                           nmbt036 = l_nmbt.nmbt036,
                           nmbt037 = l_nmbt.nmbt037,                           
                           nmbt038 = l_nmbt.nmbt038,
                           nmbt039 = l_nmbt.nmbt039,
                           nmbt040 = l_nmbt.nmbt040,
                           nmbt031 = l_nmbt.nmbt041,
                           nmbt042 = l_nmbt.nmbt042,
                           nmbt043 = l_nmbt.nmbt043
          WHERE nmbtent = g_enterprise
            AND nmbtdocno = l_nmbt.nmbtdocno
            AND nmbtld = l_nmbt.nmbtld
            AND nmbtseq = l_nmbt.nmbtseq
            
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "upd nmbt"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
      END IF
      #151224-00022#1--add--end
   END FOREACH
   
   #150714-00024#1 add ------
   #計算單身是否有筆數寫入，如果有的話g_success要給Y
   SELECT COUNT(*) INTO l_cnt
     FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = p_nmbtld
      AND nmbtdocno = p_nmbtdocno
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      LET g_success = 'Y'
   ELSE
      LET g_success = 'N'
   END IF
   #150714-00024#1 add end---
   
END FUNCTION
# 抓取匯率
PRIVATE FUNCTION anmt311_01_get_exrate(p_ld,p_date,p_ooam003,p_ooan002,p_type)
   DEFINE p_ld         LIKE nmbs_t.nmbsld
   DEFINE p_date       LIKE nmbs_t.nmbsdocdt
   DEFINE p_ooam003    LIKE ooam_t.ooam003
   DEFINE p_ooan002    LIKE ooan_t.ooan002
   DEFINE p_type       LIKE glaa_t.glaa018
   DEFINE r_exrate     LIKE nmbt_t.nmbt121
   
                          #匯率參照表;帳套;         日期;  來源幣別
   CALL s_aooi160_get_exrate('2',p_ld,p_date,p_ooam003,
                             #目的幣別; 交易金額; 匯類類型
                             p_ooan002,0,p_type)
   RETURNING r_exrate  
   
   RETURN r_exrate   
END FUNCTION
# 插入nmbt_t
PRIVATE FUNCTION anmt311_01_nmbv_ins(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt001,p_nmbt002,p_nmbb001,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt001       LIKE nmbt_t.nmbt001
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbb001       LIKE nmbb_t.nmbb001
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt121       LIKE nmbt_t.nmbt121
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt131       LIKE nmbt_t.nmbt131
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   DEFINE l_success       LIKE type_t.num5

   LET l_success = TRUE

   IF p_nmbt001 = '3' THEN    #銀存收支單
      IF p_nmbb001 = '1'  THEN    #存入
         CALL anmt311_01_nmbv_ins_3_1(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
      END IF
      
      IF p_nmbb001 = '2'  THEN    #存入
         CALL anmt311_01_nmbv_ins_3_2(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
      END IF
   END IF
   
   IF p_nmbt001 = '4' THEN    #繳款單
      CALL anmt311_01_nmbv_ins_4(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
   END IF
   
   IF l_success = FALSE THEN 
      LET g_success = 'N'
   END IF
END FUNCTION
# 銀存收支單：存入
PRIVATE FUNCTION anmt311_01_nmbv_ins_3_1(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmbv          RECORD  LIKE nmbv_t.*
   DEFINE l_nmbv RECORD  #帳務底稿科目明細檔
       nmbvent LIKE nmbv_t.nmbvent, #企業編號
       nmbvcomp LIKE nmbv_t.nmbvcomp, #法人
       nmbvld LIKE nmbv_t.nmbvld, #帳套(套)編號
       nmbvdocno LIKE nmbv_t.nmbvdocno, #帳務編號
       nmbvseq LIKE nmbv_t.nmbvseq, #項次
       nmbvseq2 LIKE nmbv_t.nmbvseq2, #分項項次
       nmbv001 LIKE nmbv_t.nmbv001, #對方分項科目編號
       nmbv017 LIKE nmbv_t.nmbv017, #營運據點
       nmbv018 LIKE nmbv_t.nmbv018, #部門
       nmbv019 LIKE nmbv_t.nmbv019, #利潤/成本中心
       nmbv020 LIKE nmbv_t.nmbv020, #區域
       nmbv021 LIKE nmbv_t.nmbv021, #交易客戶
       nmbv022 LIKE nmbv_t.nmbv022, #帳款客戶
       nmbv023 LIKE nmbv_t.nmbv023, #客群
       nmbv024 LIKE nmbv_t.nmbv024, #產品類別
       nmbv025 LIKE nmbv_t.nmbv025, #人員
       nmbv026 LIKE nmbv_t.nmbv026, #預算編號
       nmbv027 LIKE nmbv_t.nmbv027, #專案編號
       nmbv028 LIKE nmbv_t.nmbv028, #WBS
       nmbv029 LIKE nmbv_t.nmbv029, #自由核算項(一)
       nmbv030 LIKE nmbv_t.nmbv030, #自由核算項(二)
       nmbv031 LIKE nmbv_t.nmbv031, #自由核算項(三)
       nmbv032 LIKE nmbv_t.nmbv032, #自由核算項(四)
       nmbv033 LIKE nmbv_t.nmbv033, #自由核算項(五)
       nmbv034 LIKE nmbv_t.nmbv034, #自由核算項(六)
       nmbv035 LIKE nmbv_t.nmbv035, #自由核算項(七)
       nmbv036 LIKE nmbv_t.nmbv036, #自由核算項(八)
       nmbv037 LIKE nmbv_t.nmbv037, #自由核算項(九)
       nmbv038 LIKE nmbv_t.nmbv038, #自由核算項(十)
       nmbv039 LIKE nmbv_t.nmbv039, #經營方式
       nmbv040 LIKE nmbv_t.nmbv040, #渠道
       nmbv041 LIKE nmbv_t.nmbv041, #品牌
       nmbv103 LIKE nmbv_t.nmbv103, #原幣金額
       nmbv113 LIKE nmbv_t.nmbv113, #本幣金額
       nmbv123 LIKE nmbv_t.nmbv123, #本幣二金額
       nmbv133 LIKE nmbv_t.nmbv133, #本幣三金額
       nmbv042 LIKE nmbv_t.nmbv042, #現金變動碼
       nmbv100 LIKE nmbv_t.nmbv100  #幣別
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002 
      AND nmbbseq = p_nmbbseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方
   #借：銀行帳戶對應會科
    
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目: 依 anmi121  設定 
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise 
      AND glabld  = p_nmbtld
      AND glab001 = '40'
      AND glab002 = '40'  
      AND glab003 = l_nmbb003  #交易帳戶編號
   
      
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
 # LET l_nmbv.nmbv104 = 0                         #貸方原幣金額 
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
 # LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
 # LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
 # LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
   
   INSERT INTO nmbv_t(nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,
                      nmbv103,nmbv113,nmbv123,nmbv133) VALUES(g_enterprise,l_nmbv.nmbvcomp,
                      l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,
                      l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133)
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success     
   END IF
 
   
   #貸方
   #貸：存提碼對應會科
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi171  設定
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001   
    #FROM glab_t,nmbb_t    #150707-00001#7 mark
     FROM glab_t           #150707-00001#7
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '43' 
      AND glab002 = '43'
      AND glab003 = l_nmbb002
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
 #  LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額 
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
 #  LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   INSERT INTO nmbv_t(nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,
                      nmbv103,nmbv113,nmbv123,nmbv133) VALUES(g_enterprise,l_nmbv.nmbvcomp,
                      l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,
                      l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133)
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success       
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 提出
PRIVATE FUNCTION anmt311_01_nmbv_ins_3_2(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmbv          RECORD  LIKE nmbv_t.*
   DEFINE l_nmbv RECORD  #帳務底稿科目明細檔
       nmbvent LIKE nmbv_t.nmbvent, #企業編號
       nmbvcomp LIKE nmbv_t.nmbvcomp, #法人
       nmbvld LIKE nmbv_t.nmbvld, #帳套(套)編號
       nmbvdocno LIKE nmbv_t.nmbvdocno, #帳務編號
       nmbvseq LIKE nmbv_t.nmbvseq, #項次
       nmbvseq2 LIKE nmbv_t.nmbvseq2, #分項項次
       nmbv001 LIKE nmbv_t.nmbv001, #對方分項科目編號
       nmbv017 LIKE nmbv_t.nmbv017, #營運據點
       nmbv018 LIKE nmbv_t.nmbv018, #部門
       nmbv019 LIKE nmbv_t.nmbv019, #利潤/成本中心
       nmbv020 LIKE nmbv_t.nmbv020, #區域
       nmbv021 LIKE nmbv_t.nmbv021, #交易客戶
       nmbv022 LIKE nmbv_t.nmbv022, #帳款客戶
       nmbv023 LIKE nmbv_t.nmbv023, #客群
       nmbv024 LIKE nmbv_t.nmbv024, #產品類別
       nmbv025 LIKE nmbv_t.nmbv025, #人員
       nmbv026 LIKE nmbv_t.nmbv026, #預算編號
       nmbv027 LIKE nmbv_t.nmbv027, #專案編號
       nmbv028 LIKE nmbv_t.nmbv028, #WBS
       nmbv029 LIKE nmbv_t.nmbv029, #自由核算項(一)
       nmbv030 LIKE nmbv_t.nmbv030, #自由核算項(二)
       nmbv031 LIKE nmbv_t.nmbv031, #自由核算項(三)
       nmbv032 LIKE nmbv_t.nmbv032, #自由核算項(四)
       nmbv033 LIKE nmbv_t.nmbv033, #自由核算項(五)
       nmbv034 LIKE nmbv_t.nmbv034, #自由核算項(六)
       nmbv035 LIKE nmbv_t.nmbv035, #自由核算項(七)
       nmbv036 LIKE nmbv_t.nmbv036, #自由核算項(八)
       nmbv037 LIKE nmbv_t.nmbv037, #自由核算項(九)
       nmbv038 LIKE nmbv_t.nmbv038, #自由核算項(十)
       nmbv039 LIKE nmbv_t.nmbv039, #經營方式
       nmbv040 LIKE nmbv_t.nmbv040, #渠道
       nmbv041 LIKE nmbv_t.nmbv041, #品牌
       nmbv103 LIKE nmbv_t.nmbv103, #原幣金額
       nmbv113 LIKE nmbv_t.nmbv113, #本幣金額
       nmbv123 LIKE nmbv_t.nmbv123, #本幣二金額
       nmbv133 LIKE nmbv_t.nmbv133, #本幣三金額
       nmbv042 LIKE nmbv_t.nmbv042, #現金變動碼
       nmbv100 LIKE nmbv_t.nmbv100  #幣別
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb002       LIKE nmbb_t.nmbb002
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmbb002,nmbb003 INTO l_nmbb002,l_nmbb003
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002 
      AND nmbbseq = p_nmbbseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方
   #借：銀行帳戶對應會科
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目: 依 anmi171  設定
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001  
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '43' 
      AND glab002 = '43'
      AND glab003 = l_nmbb002
   
      
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
 #  LET l_nmbv.nmbv104 = 0                         #貸方原幣金額 
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
 #  LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
  # LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
   
   INSERT INTO nmbv_t(nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,
                      nmbv103,nmbv113,nmbv123,nmbv133) VALUES(g_enterprise,l_nmbv.nmbvcomp,
                      l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,
                      l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133)
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success     
   END IF
 
   
   #貸方
   #貸：存提碼對應會科
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi121  設定 
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise 
      AND glabld  = p_nmbtld
      AND glab001 = '40'
      AND glab002 = '40'  
      AND glab003 = l_nmbb003  #交易帳戶編號
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
 #  LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額 
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
 #  LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
      INSERT INTO nmbv_t(nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,
                      nmbv103,nmbv113,nmbv123,nmbv133) VALUES(g_enterprise,l_nmbv.nmbvcomp,
                      l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,
                      l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133)
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success       
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 繳款單
PRIVATE FUNCTION anmt311_01_nmbv_ins_4(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbbseq,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmbbseq       LIKE nmbb_t.nmbbseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmbv          RECORD  LIKE nmbv_t.*
   DEFINE l_nmbv RECORD  #帳務底稿科目明細檔
       nmbvent LIKE nmbv_t.nmbvent, #企業編號
       nmbvcomp LIKE nmbv_t.nmbvcomp, #法人
       nmbvld LIKE nmbv_t.nmbvld, #帳套(套)編號
       nmbvdocno LIKE nmbv_t.nmbvdocno, #帳務編號
       nmbvseq LIKE nmbv_t.nmbvseq, #項次
       nmbvseq2 LIKE nmbv_t.nmbvseq2, #分項項次
       nmbv001 LIKE nmbv_t.nmbv001, #對方分項科目編號
       nmbv017 LIKE nmbv_t.nmbv017, #營運據點
       nmbv018 LIKE nmbv_t.nmbv018, #部門
       nmbv019 LIKE nmbv_t.nmbv019, #利潤/成本中心
       nmbv020 LIKE nmbv_t.nmbv020, #區域
       nmbv021 LIKE nmbv_t.nmbv021, #交易客戶
       nmbv022 LIKE nmbv_t.nmbv022, #帳款客戶
       nmbv023 LIKE nmbv_t.nmbv023, #客群
       nmbv024 LIKE nmbv_t.nmbv024, #產品類別
       nmbv025 LIKE nmbv_t.nmbv025, #人員
       nmbv026 LIKE nmbv_t.nmbv026, #預算編號
       nmbv027 LIKE nmbv_t.nmbv027, #專案編號
       nmbv028 LIKE nmbv_t.nmbv028, #WBS
       nmbv029 LIKE nmbv_t.nmbv029, #自由核算項(一)
       nmbv030 LIKE nmbv_t.nmbv030, #自由核算項(二)
       nmbv031 LIKE nmbv_t.nmbv031, #自由核算項(三)
       nmbv032 LIKE nmbv_t.nmbv032, #自由核算項(四)
       nmbv033 LIKE nmbv_t.nmbv033, #自由核算項(五)
       nmbv034 LIKE nmbv_t.nmbv034, #自由核算項(六)
       nmbv035 LIKE nmbv_t.nmbv035, #自由核算項(七)
       nmbv036 LIKE nmbv_t.nmbv036, #自由核算項(八)
       nmbv037 LIKE nmbv_t.nmbv037, #自由核算項(九)
       nmbv038 LIKE nmbv_t.nmbv038, #自由核算項(十)
       nmbv039 LIKE nmbv_t.nmbv039, #經營方式
       nmbv040 LIKE nmbv_t.nmbv040, #渠道
       nmbv041 LIKE nmbv_t.nmbv041, #品牌
       nmbv103 LIKE nmbv_t.nmbv103, #原幣金額
       nmbv113 LIKE nmbv_t.nmbv113, #本幣金額
       nmbv123 LIKE nmbv_t.nmbv123, #本幣二金額
       nmbv133 LIKE nmbv_t.nmbv133, #本幣三金額
       nmbv042 LIKE nmbv_t.nmbv042, #現金變動碼
       nmbv100 LIKE nmbv_t.nmbv100  #幣別
       END RECORD
   #161128-00061#2---modify----end----------
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE l_nmbb029       LIKE nmbb_t.nmbb029
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
      
   SELECT nmbb003,nmbb028,nmbb029 INTO l_nmbb003,l_nmbb028,l_nmbb029
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002 
      AND nmbbseq = p_nmbbseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方
   #借：款別對應的會科
    
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目
   IF l_nmbb029 <> '20' THEN   # 20.電匯款
      #借方科目: 依 agli190 設定 
      SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
       #FROM glab_t,nmbb_t    #150707-00001#7 mark
        FROM glab_t           #150707-00001#7
       WHERE glabent = g_enterprise 
         AND glabld  = p_nmbtld
        #AND glab001 = '42'   #150707-00001#7 mark
         AND glab001 = '21'   #150707-00001#7
         AND glab002 = l_nmbb029  
         AND glab003 = l_nmbb028
   ELSE
      #Dr. 銀行帳戶對應會科 
      #借方科目: 依 anmi121  設定 
      SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
        FROM glab_t 
       WHERE glabent = g_enterprise 
         AND glabld  = p_nmbtld
         AND glab001 = '40' 
         AND glab002 = '40' 
         AND glab003 = l_nmbb003
   END IF
   
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
 #  LET l_nmbv.nmbv104 = 0                         #貸方原幣金額 
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
 #  LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
  # LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
   
   INSERT INTO nmbv_t(nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,
                      nmbv103,nmbv113,nmbv123,nmbv133) VALUES(g_enterprise,l_nmbv.nmbvcomp,
                      l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,
                      l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133)
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success     
   END IF
 
   
   #貸方
   #貸：收款待沖銷科目
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi171  設定
   SELECT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '41' 
      AND glab002 = '8714'   # 應收票據 異動項 
      AND glab003 = 'F'      # 收款待沖銷科目 
          
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
 #  LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額 
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
 #  LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
 #  LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
 #  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   INSERT INTO nmbv_t(nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,
                      nmbv103,nmbv113,nmbv123,nmbv133) VALUES(g_enterprise,l_nmbv.nmbvcomp,
                      l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,
                      l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133)
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success       
   END IF
   
   LET r_success = TRUE
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_01_ins_nmbt_9(p_nmbtdocno,p_nmbtld)
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE p_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   DEFINE l_nmbt002      LIKE nmbt_t.nmbt002
   DEFINE l_nmbt003      LIKE nmbt_t.nmbt003
   DEFINE l_nmbt014      LIKE nmbt_t.nmbt014
   DEFINE l_nmbt017      LIKE nmbt_t.nmbt017
   DEFINE l_nmbt018      LIKE nmbt_t.nmbt018
   DEFINE l_nmbt019      LIKE nmbt_t.nmbt019
   DEFINE l_nmbt021      LIKE nmbt_t.nmbt021
   DEFINE l_nmbt022      LIKE nmbt_t.nmbt022
   DEFINE l_nmbt025      LIKE nmbt_t.nmbt025
   DEFINE l_nmbt100      LIKE nmbt_t.nmbt100
   DEFINE l_nmbt101      LIKE nmbt_t.nmbt101
   DEFINE l_nmbt103      LIKE nmbt_t.nmbt103
   DEFINE l_nmbt113      LIKE nmbt_t.nmbt113
   DEFINE l_nmbt121      LIKE nmbt_t.nmbt121
   DEFINE l_nmbt131      LIKE nmbt_t.nmbt131
   DEFINE l_nmbt123      LIKE nmbt_t.nmbt123
   DEFINE l_nmbt133      LIKE nmbt_t.nmbt133
   DEFINE l_ooam003      LIKE ooam_t.ooam003
   DEFINE l_nmbt029_1    LIKE nmbt_t.nmbt029
   DEFINE l_nmbt029_2    LIKE nmbt_t.nmbt029
   DEFINE l_deac007      LIKE deal_t.deal007
   DEFINE l_deac005      LIKE deac_t.deac005
   DEFINE l_deac006      LIKE deac_t.deac006
   DEFINE l_deabsite     LIKE deab_t.deabsite
   DEFINE l_glaa014      LIKE glaa_t.glaa014
   DEFINE l_glaa001      LIKE glaa_t.glaa001
   DEFINE l_glaa008      LIKE glaa_t.glaa008
   DEFINE l_glaa015      LIKE glaa_t.glaa015
   DEFINE l_glaa016      LIKE glaa_t.glaa016
   DEFINE l_glaa017      LIKE glaa_t.glaa017
   DEFINE l_glaa018      LIKE glaa_t.glaa018
   DEFINE l_glaa019      LIKE glaa_t.glaa019
   DEFINE l_glaa020      LIKE glaa_t.glaa020
   DEFINE l_glaa021      LIKE glaa_t.glaa021
   DEFINE l_glaa022      LIKE glaa_t.glaa022
   DEFINE l_success      LIKE type_t.num5
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmbt          RECORD  LIKE nmbt_t.* 
   DEFINE l_nmbt RECORD  #帳務底稿明細檔
       nmbtent LIKE nmbt_t.nmbtent, #企業編號
       nmbtcomp LIKE nmbt_t.nmbtcomp, #法人
       nmbtld LIKE nmbt_t.nmbtld, #帳套(套)編號
       nmbtdocno LIKE nmbt_t.nmbtdocno, #帳務編號
       nmbtseq LIKE nmbt_t.nmbtseq, #項次
       nmbt001 LIKE nmbt_t.nmbt001, #單據來源
       nmbt002 LIKE nmbt_t.nmbt002, #來源單號
       nmbt003 LIKE nmbt_t.nmbt003, #來源單項次
       nmbt011 LIKE nmbt_t.nmbt011, #票據號碼
       nmbt012 LIKE nmbt_t.nmbt012, #票據日期
       nmbt013 LIKE nmbt_t.nmbt013, #申請人
       nmbt014 LIKE nmbt_t.nmbt014, #銀行帳號
       nmbt015 LIKE nmbt_t.nmbt015, #結算方式
       nmbt016 LIKE nmbt_t.nmbt016, #收支專案
       nmbt017 LIKE nmbt_t.nmbt017, #營運據點
       nmbt018 LIKE nmbt_t.nmbt018, #部門
       nmbt019 LIKE nmbt_t.nmbt019, #利潤/成本中心
       nmbt020 LIKE nmbt_t.nmbt020, #區域
       nmbt021 LIKE nmbt_t.nmbt021, #交易客商
       nmbt022 LIKE nmbt_t.nmbt022, #帳款客商
       nmbt023 LIKE nmbt_t.nmbt023, #客群
       nmbt024 LIKE nmbt_t.nmbt024, #產品類別
       nmbt025 LIKE nmbt_t.nmbt025, #人員
       nmbt026 LIKE nmbt_t.nmbt026, #預算編號
       nmbt027 LIKE nmbt_t.nmbt027, #專案編號
       nmbt028 LIKE nmbt_t.nmbt028, #WBS
       nmbt029 LIKE nmbt_t.nmbt029, #科目
       nmbt030 LIKE nmbt_t.nmbt030, #對方科目
       nmbt031 LIKE nmbt_t.nmbt031, #經營方式
       nmbt032 LIKE nmbt_t.nmbt032, #渠道
       nmbt033 LIKE nmbt_t.nmbt033, #品牌
       nmbt034 LIKE nmbt_t.nmbt034, #自由核算項一
       nmbt035 LIKE nmbt_t.nmbt035, #自由核算項二
       nmbt036 LIKE nmbt_t.nmbt036, #自由核算項三
       nmbt037 LIKE nmbt_t.nmbt037, #自由核算項四
       nmbt038 LIKE nmbt_t.nmbt038, #自由核算項五
       nmbt039 LIKE nmbt_t.nmbt039, #自由核算項六
       nmbt040 LIKE nmbt_t.nmbt040, #自由核算項七
       nmbt041 LIKE nmbt_t.nmbt041, #自由核算項八
       nmbt042 LIKE nmbt_t.nmbt042, #自由核算項九
       nmbt043 LIKE nmbt_t.nmbt043, #自由核算項十
       nmbt100 LIKE nmbt_t.nmbt100, #幣別
       nmbt101 LIKE nmbt_t.nmbt101, #匯率
       nmbt103 LIKE nmbt_t.nmbt103, #原幣金額
       nmbt113 LIKE nmbt_t.nmbt113, #本幣金額
       nmbt121 LIKE nmbt_t.nmbt121, #本位幣二匯率
       nmbt123 LIKE nmbt_t.nmbt123, #本位幣二金額
       nmbt131 LIKE nmbt_t.nmbt131, #本位幣三匯率
       nmbt133 LIKE nmbt_t.nmbt133, #本位幣三金額
       nmbt004 LIKE nmbt_t.nmbt004, #異動別
       nmbt114 LIKE nmbt_t.nmbt114  #開立金額
       END RECORD

#161128-00061#2---modify----end----------
   
   
   IF g_wc1 <> " 1=1 " THEN  
      LET g_wc1 = cl_replace_str(g_wc1,'nmbadocno','deabdocno')
   END IF
   
   IF g_wc2 <> " 1=1 " THEN  
      LET g_wc2 = cl_replace_str(g_wc2,'nmbadocdt','deabdocdt')
   END IF
   
   CALL s_ld_sel_glaa(p_nmbtld,'glaa008|glaa014|glaa001|glaa015|glaa016|glaa017|glaa018|glaa019|glaa020|glaa021|glaa022')
   RETURNING l_success,l_glaa008,l_glaa014,l_glaa001,l_glaa015,l_glaa016,l_glaa017,l_glaa018,l_glaa019,l_glaa020,l_glaa021,l_glaa022
   
   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq
     FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = g_nmbs_m.nmbsld
      AND nmbtdocno = p_nmbtdocno
    
   IF cl_null(l_nmbtseq) THEN 
      LET l_nmbtseq = 0
   END IF
               #        單號/     項次/   營運據點  /繳款部門/
   LET g_sql = " SELECT deacdocno,deacseq,deacsite,deacunit,",
               #        繳款人員/存款金額  
               "        deab002,deac007,",
               #        帳戶編號/款別類型/款別
               "        deac002,deac005,deac006",
               "   FROM deab_t,deac_t ",
               "  WHERE deabent = deacent",
               "    AND deabdocno = deacdocno ",
               "    AND deabent = '",g_enterprise,"'",
               "    AND deabsite = '",g_nmbs_m.nmbscomp,"'",
               "    AND ",g_wc1,
               "    AND ",g_wc2               
   
   PREPARE anmt311_01_deab_pre FROM g_sql
   DECLARE anmt311_01_deab_cur CURSOR FOR anmt311_01_deab_pre
   FOREACH anmt311_01_deab_cur INTO l_nmbt002,l_nmbt003,l_nmbt017,
                                    l_nmbt018,l_nmbt025,l_deac007,
                                    l_nmbt014,l_deac005,l_deac006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:deab_cur' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #項次
      LET l_nmbtseq = l_nmbtseq + 1
     
      #幣別=帳套本位幣一，匯率=1
      LET l_nmbt100 = l_glaa001
      LET l_nmbt101 = 1
      #利潤/成本中心
      SELECT ooeg004 INTO l_nmbt019
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_nmbt018
      #原幣金額
      LET l_nmbt103 = l_deac007
      #本幣金額
      LET l_nmbt113 = l_deac007
      
      #1）存入第一筆資料：異動別=1.存入；金額=存款金額
      #科目1：anmi121 交易账户deal003对应的科目
      LET l_nmbt029_1 = ''
      SELECT glab005 INTO l_nmbt029_1 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='40' AND glab002='40' AND glab003=l_nmbt014
     
     
      #2）存入第二筆對應的貸方資料：異動別=4.貸方科目；金額=存款金額
      #科目3：agli190 款别对应会科
      LET l_nmbt029_2 = ''
      SELECT glab005 INTO l_nmbt029_2 FROM glab_t
       WHERE glabent=g_enterprise AND glabld=g_nmbs_m.nmbsld
        AND glab001='21' AND glab002=l_deac005 AND glab003=l_deac006
      
      IF l_glaa014 = 'Y' THEN 
         IF l_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF l_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = l_glaa001
             END IF
                                         #帳套     #日期;            來源幣別   目的幣別; 匯類類型
             CALL anmt311_01_get_exrate(p_nmbtld,g_nmbs_m.nmbsdocdt,l_ooam003,l_glaa016,l_glaa018)              
             RETURNING l_nmbt121  
             LET l_nmbt123 = l_nmbt113 * l_nmbt121
         END IF
          
         IF l_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF l_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                        #帳套     #日期;            來源幣別   目的幣別; 匯類類型
             CALL anmt311_01_get_exrate(p_nmbtld,g_nmbs_m.nmbsdocdt,l_ooam003,l_glaa020,l_glaa022)  
            RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131
         END IF
      END IF
      
      #平行賬套,金額匯率重新計算
      IF l_glaa014 <> 'Y' AND l_glaa008 = 'Y' THEN 
         LET l_nmbt101 = 0
         LET l_nmbt113 = 0  
         CALL cl_get_para(g_enterprise,g_nmbs_m.nmbscomp,'S-FIN-4004') RETURNING g_para_data   #資金模組匯率來源
         #平行賬套匯率      
                                    #帳套            #日期;       來源幣別  目的幣別; 匯類類型
         CALL anmt311_01_get_exrate(p_nmbtld,g_nmbs_m.nmbsdocdt,l_nmbt100,l_glaa001,g_para_data)                      
         RETURNING l_nmbt101    
         LET l_nmbt113 = l_nmbt103 * l_nmbt101
         
         IF l_glaa015 = 'Y' THEN                         
             #主帳套本位幣二匯率
             IF l_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt100
             ELSE
                LET l_ooam003 = l_glaa001
             END IF
                                        #帳套            #日期;       來源幣別   目的幣別; 匯類類型
             CALL anmt311_01_get_exrate(p_nmbtld,g_nmbs_m.nmbsdocdt,l_ooam003,l_glaa016,l_glaa018)           
             RETURNING l_nmbt121 
             LET l_nmbt133 = l_nmbt113 * l_nmbt131 
         END IF
          
         IF l_glaa019 = 'Y' THEN                         
            #主帳套本位幣三匯率
            IF l_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                       #帳套          #日期;       來源幣別   目的幣別; 匯類類型
            CALL anmt311_01_get_exrate(p_nmbtld,g_nmbs_m.nmbsdocdt,l_ooam003,l_glaa020,l_glaa022)
            RETURNING l_nmbt131   
            LET l_nmbt133 = l_nmbt113 * l_nmbt131  
         END IF
      END IF
      
      #1）插入第一筆應收金額 
      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,p_nmbtld,p_nmbtdocno,l_nmbtseq,
                         '9',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbt029_1,'1')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(p_nmbtld,l_nmbt029_1,g_prog,p_nmbtdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = p_nmbtdocno
         AND nmbtld = p_nmbtld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
      #2）插入一筆貸方合計金額
      LET l_nmbtseq = l_nmbtseq + 1

      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,
                         nmbt100,nmbt101,nmbt103,nmbt113,nmbt013,nmbt014,
                         nmbt017,nmbt018,nmbt019,nmbt021,nmbt022,nmbt025,nmbt121,nmbt123,
                         nmbt131,nmbt133,nmbt029,nmbt004) 
                  VALUES(g_enterprise,g_nmbs_m.nmbscomp,p_nmbtld,p_nmbtdocno,l_nmbtseq,
                         '9',l_nmbt002,l_nmbt003,l_nmbt100,l_nmbt101,l_nmbt103,l_nmbt113,
                         g_user,l_nmbt014,l_nmbt017,l_nmbt018,l_nmbt019,l_nmbt021,l_nmbt022,
                         l_nmbt025,l_nmbt121,l_nmbt123,l_nmbt131,l_nmbt133,l_nmbt029_2,'4')
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = ''
      LET g_free_m.free_item_2 = ''
      LET g_free_m.free_item_3 = ''
      LET g_free_m.free_item_4 = ''
      LET g_free_m.free_item_5 = ''
      LET g_free_m.free_item_6 = ''
      LET g_free_m.free_item_7 = ''
      LET g_free_m.free_item_8 = ''
      LET g_free_m.free_item_9 = ''
      LET g_free_m.free_item_10 = ''
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(p_nmbtld,l_nmbt029_2,g_prog,p_nmbtdocno,l_nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING g_free_m.free_item_1,g_free_m.free_item_2,g_free_m.free_item_3,g_free_m.free_item_4,
                g_free_m.free_item_5,g_free_m.free_item_6,g_free_m.free_item_7,g_free_m.free_item_8,
                g_free_m.free_item_9,g_free_m.free_item_10
                
      UPDATE nmbt_t SET nmbt034 = g_free_m.free_item_1,
                        nmbt035 = g_free_m.free_item_2,
                        nmbt036 = g_free_m.free_item_3,
                        nmbt037 = g_free_m.free_item_4,                           
                        nmbt038 = g_free_m.free_item_5,
                        nmbt039 = g_free_m.free_item_6,
                        nmbt040 = g_free_m.free_item_7,
                        nmbt031 = g_free_m.free_item_8,
                        nmbt042 = g_free_m.free_item_9,
                        nmbt043 = g_free_m.free_item_10
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = p_nmbtdocno
         AND nmbtld = p_nmbtld
         AND nmbtseq = l_nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh
      
   END FOREACH 

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_01_ins_nmbt_10(p_nmbtdocno,p_nmbtld)
   DEFINE p_nmbtdocno    LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtld       LIKE nmbt_t.nmbtld
   DEFINE l_nmbadocno    LIKE nmba_t.nmbadocno
   DEFINE l_nmbacomp     LIKE nmba_t.nmbacomp
   DEFINE l_nmbbseq      LIKE nmbb_t.nmbbseq
   DEFINE l_nmba001      LIKE nmba_t.nmba001
   DEFINE l_nmba008      LIKE nmba_t.nmba008
   DEFINE l_nmbb004      LIKE nmbb_t.nmbb004
   DEFINE l_nmbb005      LIKE nmbb_t.nmbb005
   DEFINE l_nmbb006      LIKE nmbb_t.nmbb006
   DEFINE l_nmbb028      LIKE nmbb_t.nmbb028
   DEFINE l_nmee006      LIKE nmee_t.nmee006
   DEFINE l_nmee009      LIKE nmee_t.nmee009
   DEFINE l_nmee018      LIKE nmee_t.nmee018
   DEFINE l_glab005      LIKE glab_t.glab005
   DEFINE l_nmbtseq      LIKE nmbt_t.nmbtseq
   #160509-00004#28 add by liyan --str--
   DEFINE l_nmee022      LIKE nmee_t.nmee022,
          l_nmee020      LIKE nmee_t.nmee020,
          l_nmee003      LIKE nmee_t.nmee003
   #160509-00004#28 add by liyan --end--
   DEFINE l_wc3          STRING
   DEFINE l_nmbt         RECORD
             nmbtent        LIKE nmbt_t.nmbtent,     #企業編號
             nmbtcomp       LIKE nmbt_t.nmbtcomp,    #法人
             nmbtld         LIKE nmbt_t.nmbtld,      #帳別(套)編號
             nmbtdocno      LIKE nmbt_t.nmbtdocno,   #帳務編號
             nmbtseq        LIKE nmbt_t.nmbtseq,     #項次
             nmbt001        LIKE nmbt_t.nmbt001,     #單據來源
             nmbt002        LIKE nmbt_t.nmbt002,     #來源單號
             nmbt003        LIKE nmbt_t.nmbt003,     #來源單項次
             nmbt011        LIKE nmbt_t.nmbt011,     #票據號碼
             nmbt012        LIKE nmbt_t.nmbt012,     #票據日期
             nmbt013        LIKE nmbt_t.nmbt013,     #申請人
             nmbt014        LIKE nmbt_t.nmbt014,     #銀行帳號
             nmbt015        LIKE nmbt_t.nmbt015,     #結算方式
             nmbt016        LIKE nmbt_t.nmbt016,     #收支項目
             nmbt017        LIKE nmbt_t.nmbt017,     #營運據點
             nmbt018        LIKE nmbt_t.nmbt018,     #部門
             nmbt019        LIKE nmbt_t.nmbt019,     #利潤/成本中心
             nmbt020        LIKE nmbt_t.nmbt020,     #區域
             nmbt021        LIKE nmbt_t.nmbt021,     #交易客商
             nmbt022        LIKE nmbt_t.nmbt022,     #帳款客商
             nmbt023        LIKE nmbt_t.nmbt023,     #客群
             nmbt024        LIKE nmbt_t.nmbt024,     #產品類別
             nmbt025        LIKE nmbt_t.nmbt025,     #人員
             nmbt026        LIKE nmbt_t.nmbt026,     #預算編號
             nmbt027        LIKE nmbt_t.nmbt027,     #專案編號
             nmbt028        LIKE nmbt_t.nmbt028,     #WBS
             nmbt029        LIKE nmbt_t.nmbt029,     #科目
             nmbt030        LIKE nmbt_t.nmbt030,     #對方科目
             nmbt031        LIKE nmbt_t.nmbt031,     #經營方式
             nmbt032        LIKE nmbt_t.nmbt032,     #渠道
             nmbt033        LIKE nmbt_t.nmbt033,     #品牌
             nmbt034        LIKE nmbt_t.nmbt034,     #自由核算項一
             nmbt035        LIKE nmbt_t.nmbt035,     #自由核算項二
             nmbt036        LIKE nmbt_t.nmbt036,     #自由核算項三
             nmbt037        LIKE nmbt_t.nmbt037,     #自由核算項四
             nmbt038        LIKE nmbt_t.nmbt038,     #自由核算項五
             nmbt039        LIKE nmbt_t.nmbt039,     #自由核算項六
             nmbt040        LIKE nmbt_t.nmbt040,     #自由核算項七
             nmbt041        LIKE nmbt_t.nmbt041,     #自由核算項八
             nmbt042        LIKE nmbt_t.nmbt042,     #自由核算項九
             nmbt043        LIKE nmbt_t.nmbt043,     #自由核算項十
             nmbt100        LIKE nmbt_t.nmbt100,     #幣別
             nmbt101        LIKE nmbt_t.nmbt101,     #匯率
             nmbt103        LIKE nmbt_t.nmbt103,     #原幣金額
             nmbt113        LIKE nmbt_t.nmbt113,     #本幣金額
             nmbt121        LIKE nmbt_t.nmbt121,     #本位幣二匯率
             nmbt123        LIKE nmbt_t.nmbt123,     #本位幣二金額
             nmbt131        LIKE nmbt_t.nmbt131,     #本位幣三匯率
             nmbt133        LIKE nmbt_t.nmbt133,     #本位幣三金額
             nmbt004        LIKE nmbt_t.nmbt004      #異動別
                         END RECORD

   IF g_wc3 <> " 1=1 " THEN  
      LET l_wc3 = cl_replace_str(g_wc2,'nmbb026','nmee001')
   ELSE
      LET l_wc3 = " 1=1"
   END IF

   #項次
   SELECT MAX(nmbtseq) INTO l_nmbtseq FROM nmbt_t
    WHERE nmbtent = g_enterprise
      AND nmbtld = p_nmbtld
      AND nmbtdocno = p_nmbtdocno
   IF cl_null(l_nmbtseq) THEN LET l_nmbtseq = 0 END IF

   LET g_success = 'Y'

   #STEP1.存入
   LET g_sql = " SELECT nmbadocno,nmbbseq,nmbacomp,nmba001,nmba008,nmbb004,nmbb005,nmbb006,nmbb028",
               "   FROM nmba_t,nmbb_t ",
               "  WHERE nmbaent = '",g_enterprise,"'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbaent = nmbbent ",
               "    AND nmbacomp = nmbbcomp ",
               "    AND nmba003 = 'anmt563'",
               "    AND nmbadocno = nmbbdocno ",
               "    AND ",g_wc1,
               "    AND ",g_wc2,
               "    AND ",g_wc3,
               "    AND NOT EXISTS (SELECT 1 FROM nmbt_t WHERE nmbtent = '",g_enterprise,"' ",
               "                       AND nmbtcomp = '",g_nmbs_m.nmbscomp,"' AND nmbt002 = nmbadocno AND nmbtld = '",p_nmbtld,"' AND nmbt004 = '1')"
   PREPARE anmt311_nmbb_prep FROM g_sql
   DECLARE anmt311_nmbb_curs CURSOR FOR anmt311_nmbb_prep
   FOREACH anmt311_nmbb_curs INTO l_nmbadocno,l_nmbbseq,l_nmbacomp,l_nmba001,l_nmba008,l_nmbb004,l_nmbb005,l_nmbb006,l_nmbb028

      SELECT glab007 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
         AND glab001 = '21' AND glab003 = l_nmbb028
         AND glabld = p_nmbtld
      IF cl_null(l_glab005) THEN
         SELECT glab005 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glab001 = '21' AND glab003 = l_nmbb028
            AND glabld = p_nmbtld
      END IF

      LET l_nmbt.nmbtent  = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld   = p_nmbtld
      LET l_nmbt.nmbtdocno= p_nmbtdocno
      LET l_nmbt.nmbtseq  = l_nmbtseq + 1
      LET l_nmbt.nmbt001  = '10'
      LET l_nmbt.nmbt002  = l_nmbadocno
      LET l_nmbt.nmbt003  = l_nmbbseq
      LET l_nmbt.nmbt011  = ''
      LET l_nmbt.nmbt012  = ''
      LET l_nmbt.nmbt013  = ''
      LET l_nmbt.nmbt014  = ''
      LET l_nmbt.nmbt015  = ''
      LET l_nmbt.nmbt016  = ''
      LET l_nmbt.nmbt017  = l_nmbacomp
      LET l_nmbt.nmbt018  = l_nmba001
      LET l_nmbt.nmbt019  = ''
      LET l_nmbt.nmbt020  = ''
      LET l_nmbt.nmbt021  = ''
      LET l_nmbt.nmbt022  = ''
      LET l_nmbt.nmbt023  = ''
      LET l_nmbt.nmbt024  = ''
      LET l_nmbt.nmbt025  = l_nmba008
      LET l_nmbt.nmbt026  = ''
      LET l_nmbt.nmbt027  = ''
      LET l_nmbt.nmbt028  = ''
      LET l_nmbt.nmbt029  = l_glab005
      LET l_nmbt.nmbt030  = ''
      LET l_nmbt.nmbt031  = ''
      LET l_nmbt.nmbt032  = ''
      LET l_nmbt.nmbt033  = ''
      LET l_nmbt.nmbt034  = ''
      LET l_nmbt.nmbt035  = ''
      LET l_nmbt.nmbt036  = ''
      LET l_nmbt.nmbt037  = ''
      LET l_nmbt.nmbt038  = ''
      LET l_nmbt.nmbt039  = ''
      LET l_nmbt.nmbt040  = ''
      LET l_nmbt.nmbt041  = ''
      LET l_nmbt.nmbt042  = ''
      LET l_nmbt.nmbt043  = ''
      LET l_nmbt.nmbt100  = l_nmbb004
      LET l_nmbt.nmbt101  = l_nmbb005
      LET l_nmbt.nmbt103  = l_nmbb006
      LET l_nmbt.nmbt113  = l_nmbt.nmbt103 * l_nmbt.nmbt101
      LET l_nmbt.nmbt121  = 0
      LET l_nmbt.nmbt123  = 0
      LET l_nmbt.nmbt131  = 0
      LET l_nmbt.nmbt133  = 0
      LET l_nmbt.nmbt004  = 1

      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,nmbt032,
                         nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,
                         nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004) 
                  VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,l_nmbt.nmbt032,
                         l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,l_nmbt.nmbt042,
                         l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,l_nmbt.nmbt004)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
                
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh

      LET l_nmbtseq = l_nmbtseq + 1

   END FOREACH

   #STEP2.貸方科目
   LET g_sql = " SELECT nmbadocno,nmbacomp,nmba001,nmba008,SUM(nmee012),nmee006,nmee009,nmee018,nmee022,nmee020,nmee003",
               "   FROM nmba_t,nmee_t ",
               "  WHERE nmbaent = '",g_enterprise,"'",
               "    AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "    AND nmbaent = nmeeent ",
               "    AND nmbacomp = nmeecomp ",
               "    AND nmba003 = 'anmt563'",
               "    AND nmbadocno = nmeedocno ",
               "    AND ",g_wc1,
               "    AND ",g_wc2,
               "    AND ",l_wc3,
               "    AND NOT EXISTS (SELECT 1 FROM nmbt_t WHERE nmbtent = '",g_enterprise,"' ",
               "                       AND nmbtcomp = '",g_nmbs_m.nmbscomp,"' AND nmbt002 = nmbadocno AND nmbtld = '",p_nmbtld,"' AND nmbt004 = '4')",
               "  GROUP BY nmbadocno,nmbacomp,nmba001,nmba008,nmee006,nmee009,nmee018,nmee022,nmee020,nmee003"

   PREPARE anmt311_nmee_prep FROM g_sql
   DECLARE anmt311_nmee_curs CURSOR FOR anmt311_nmee_prep
   FOREACH anmt311_nmee_curs INTO l_nmbadocno,l_nmbacomp,l_nmba001,l_nmba008,l_nmbb006,l_nmee006,l_nmee009,l_nmee018
                                  ,l_nmee022,l_nmee020,l_nmee003   #20160509-00004#28 add by liyan 
      LET l_glab005 = ""
      #160509-00004#28 mod by liyan --str--
      IF l_nmee022 MATCHES '[12]' AND l_nmee020='Y' THEN 
         SELECT glab013 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
            AND glabld = g_nmbs_m.nmbsld
            AND glab001 = 'AR'
            AND glab002 = (select steu004 FROM steu_t WHERE steuent=g_enterprise AND steudocno=l_nmee003)
            AND glab003 = l_nmee006
      ELSE    
         SELECT glab005 INTO l_glab005 FROM glab_t WHERE glabent = g_enterprise
         AND glabld = p_nmbtld
         AND glab001 = 'AP'
         AND glab003 = l_nmee006
      END IF 
      #160509-00004#28 mod by liyan --end--

      LET l_nmbt.nmbtent  = g_enterprise
      LET l_nmbt.nmbtcomp = g_nmbs_m.nmbscomp
      LET l_nmbt.nmbtld   = p_nmbtld
      LET l_nmbt.nmbtdocno= p_nmbtdocno
      LET l_nmbt.nmbtseq  = l_nmbtseq + 1
      LET l_nmbt.nmbt001  = '10'
      LET l_nmbt.nmbt002  = l_nmbadocno
      LET l_nmbt.nmbt003  = 0
      LET l_nmbt.nmbt011  = ''
      LET l_nmbt.nmbt012  = ''
      LET l_nmbt.nmbt013  = ''
      LET l_nmbt.nmbt014  = ''
      LET l_nmbt.nmbt015  = ''
      LET l_nmbt.nmbt016  = ''
      LET l_nmbt.nmbt017  = l_nmbacomp
      LET l_nmbt.nmbt018  = l_nmba001
      LET l_nmbt.nmbt019  = ''
      LET l_nmbt.nmbt020  = ''
      LET l_nmbt.nmbt021  = ''
      LET l_nmbt.nmbt022  = ''
      LET l_nmbt.nmbt023  = ''
      LET l_nmbt.nmbt024  = ''
      LET l_nmbt.nmbt025  = l_nmba008
      LET l_nmbt.nmbt026  = ''
      LET l_nmbt.nmbt027  = ''
      LET l_nmbt.nmbt028  = ''
      LET l_nmbt.nmbt029  = l_glab005
      LET l_nmbt.nmbt030  = ''
      LET l_nmbt.nmbt031  = ''
      LET l_nmbt.nmbt032  = ''
      LET l_nmbt.nmbt033  = ''
      LET l_nmbt.nmbt034  = ''
      LET l_nmbt.nmbt035  = ''
      LET l_nmbt.nmbt036  = ''
      LET l_nmbt.nmbt037  = ''
      LET l_nmbt.nmbt038  = ''
      LET l_nmbt.nmbt039  = ''
      LET l_nmbt.nmbt040  = ''
      LET l_nmbt.nmbt041  = ''
      LET l_nmbt.nmbt042  = ''
      LET l_nmbt.nmbt043  = ''
      LET l_nmbt.nmbt100  = l_nmee009
      LET l_nmbt.nmbt101  = l_nmee018
      LET l_nmbt.nmbt103  = l_nmbb006
      LET l_nmbt.nmbt113  = l_nmbt.nmbt103 * l_nmbt.nmbt101
      LET l_nmbt.nmbt121  = 0
      LET l_nmbt.nmbt123  = 0
      LET l_nmbt.nmbt131  = 0
      LET l_nmbt.nmbt133  = 0
      LET l_nmbt.nmbt004  = '4'

      INSERT INTO nmbt_t(nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,nmbt012,
                         nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,nmbt022,
                         nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,nmbt032,
                         nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,nmbt042,
                         nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,nmbt004) 
                  VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,l_nmbt.nmbt012,
                         l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,l_nmbt.nmbt022,
                         l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,l_nmbt.nmbt032,
                         l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,l_nmbt.nmbt042,
                         l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,l_nmbt.nmbt004)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      
      #151111-00001#1--add--str--lujh
      LET g_free_m.free_item_1 = l_nmbt.nmbt034
      LET g_free_m.free_item_2 = l_nmbt.nmbt035
      LET g_free_m.free_item_3 = l_nmbt.nmbt036
      LET g_free_m.free_item_4 = l_nmbt.nmbt037
      LET g_free_m.free_item_5 = l_nmbt.nmbt038
      LET g_free_m.free_item_6 = l_nmbt.nmbt039
      LET g_free_m.free_item_7 = l_nmbt.nmbt040
      LET g_free_m.free_item_8 = l_nmbt.nmbt041
      LET g_free_m.free_item_9 = l_nmbt.nmbt042
      LET g_free_m.free_item_10 = l_nmbt.nmbt043
      
      LET g_field_m.field1 = 'nmbt034'
      LET g_field_m.field2 = 'nmbt035'
      LET g_field_m.field3 = 'nmbt036'
      LET g_field_m.field4 = 'nmbt037'
      LET g_field_m.field5 = 'nmbt038'
      LET g_field_m.field6 = 'nmbt039'
      LET g_field_m.field7 = 'nmbt040'
      LET g_field_m.field8 = 'nmbt041'
      LET g_field_m.field9 = 'nmbt042'
      LET g_field_m.field10 = 'nmbt043'
      
      CALL s_account_item_free(l_nmbt.nmbtld,l_nmbt.nmbt029,g_prog,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'',g_free_m.*,g_field_m.*)
      RETURNING l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,
                l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
                l_nmbt.nmbt042,l_nmbt.nmbt043
                
      UPDATE nmbt_t SET nmbt034 = l_nmbt.nmbt034,
                        nmbt035 = l_nmbt.nmbt035,
                        nmbt036 = l_nmbt.nmbt036,
                        nmbt037 = l_nmbt.nmbt037,                           
                        nmbt038 = l_nmbt.nmbt038,
                        nmbt039 = l_nmbt.nmbt039,
                        nmbt040 = l_nmbt.nmbt040,
                        nmbt031 = l_nmbt.nmbt041,
                        nmbt042 = l_nmbt.nmbt042,
                        nmbt043 = l_nmbt.nmbt043
       WHERE nmbtent = g_enterprise
         AND nmbtdocno = l_nmbt.nmbtdocno
         AND nmbtld = l_nmbt.nmbtld
         AND nmbtseq = l_nmbt.nmbtseq
         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET g_success = 'N'         
      END IF
      #151111-00001#1--add--end--lujh

      LET l_nmbtseq = l_nmbtseq + 1

   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt311_01_s_account_item_free(p_glagld,p_glag001,p_glag002,p_docno,p_seq1,p_seq2,p_free_m,p_field_m)
   DEFINE p_glagld        LIKE glag_t.glagld
   DEFINE p_glag001       LIKE glag_t.glag001
   DEFINE p_glag002       LIKE glag_t.glag002
   DEFINE p_docno         LIKE glap_t.glapdocno
   DEFINE p_seq1          LIKE glaq_t.glaqseq
   DEFINE p_seq2          LIKE glaq_t.glaqseq 
   DEFINE p_free_m       RECORD
          free_item_1     LIKE nmbt_t.nmbt034, 
          free_item_2     LIKE nmbt_t.nmbt035,
          free_item_3     LIKE nmbt_t.nmbt036, 
          free_item_4     LIKE nmbt_t.nmbt037,
          free_item_5     LIKE nmbt_t.nmbt038, 
          free_item_6     LIKE nmbt_t.nmbt039,
          free_item_7     LIKE nmbt_t.nmbt040, 
          free_item_8     LIKE nmbt_t.nmbt041,
          free_item_9     LIKE nmbt_t.nmbt042,     
          free_item_10    LIKE nmbt_t.nmbt043            
                         END RECORD
   DEFINE p_field_m       RECORD
          field1     LIKE type_t.chr10, 
          field2     LIKE type_t.chr10,
          field3     LIKE type_t.chr10, 
          field4     LIKE type_t.chr10,
          field5     LIKE type_t.chr10, 
          field6     LIKE type_t.chr10,
          field7     LIKE type_t.chr10, 
          field8     LIKE type_t.chr10,
          field9     LIKE type_t.chr10,     
          field10    LIKE type_t.chr10            
                         END RECORD
   
   IF cl_null(p_free_m.free_item_1) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field1,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_1
   END IF
   
   IF cl_null(p_free_m.free_item_2) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field2,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_2
   END IF
   
   IF cl_null(p_free_m.free_item_3) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field3,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_3
   END IF
   
   IF cl_null(p_free_m.free_item_4) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field4,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_4
   END IF
   
   IF cl_null(p_free_m.free_item_5) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field5,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_5
   END IF
   
   IF cl_null(p_free_m.free_item_6) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field6,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_6
   END IF
   
   IF cl_null(p_free_m.free_item_7) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field7,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_7
   END IF
   
   IF cl_null(p_free_m.free_item_8) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field8,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_8
   END IF
   
   IF cl_null(p_free_m.free_item_9) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field9,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_9
   END IF
   
   IF cl_null(p_free_m.free_item_10) THEN
      CALL s_account_item('1',p_glagld,p_glag001,p_glag002,p_field_m.field10,p_docno,p_seq1,p_seq2) 
      RETURNING p_free_m.free_item_10
   END IF
   
   RETURN p_free_m.free_item_1,p_free_m.free_item_2,p_free_m.free_item_3,p_free_m.free_item_4,
          p_free_m.free_item_5,p_free_m.free_item_6,p_free_m.free_item_7,p_free_m.free_item_8,
          p_free_m.free_item_9,p_free_m.free_item_10
END FUNCTION

 
{</section>}
 
