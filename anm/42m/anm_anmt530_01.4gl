#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt530_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2015-07-24 16:52:45), PR版次:0016(2017-01-12 16:49:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000184
#+ Filename...: anmt530_01
#+ Description: 產生帳務資料
#+ Creator....: 02114(2014-07-02 16:02:18)
#+ Modifier...: 03538 -SD/PR- 01531
 
{</section>}
 
{<section id="anmt530_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150707-00001#7  2015/07/24 By apo      整測bug修改,票據收票取消帳務處理;增加帳務中心欄位
#150924          2015/09/24 By Reanna   整批產生帳務資料，產生單號應用選擇的日期產生
#150918-00001#5  2015/10/07 By Reanna   加匯差處理入傳票
#151102-00007#1  2015/11/02 By yangtt   整单操作-产生账务数据，当勾选“平行账套同步产生”后，单别开窗出来无资料
#160929-00040#1  2016/10/13 By 01531    账套开窗检查只能是主账套及平行账套，拿掉这个控卡
#161018-00057#1  2016/10/25 By 07900    请依161018-00004的要求，增加anmt470,anmt530 产生账务资料的提示信息
#161021-00050#10 2016/10/28 By Reanna   账务中心开窗需调整为q_ooef001_46 where条件限定ooefstus= 'Y'；法人栏位进不去不调整
#161128-00061#2  2016/11/30 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161219-00057#1  2016/12/21 By 02114    anmt530核算项页签的交易客商抓取anmt540单身的交易客商
#170112-00051#1  2017/01/12 By 01531    整单操作执行产生账务时，程序档出报错
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
       nmbssite LIKE nmbs_t.nmbssite, 
   nmbssite_desc LIKE type_t.chr80, 
   nmbsld LIKE nmbs_t.nmbsld, 
   nmbsld_desc LIKE type_t.chr80, 
   nmbscomp LIKE type_t.chr500, 
   nmbscomp_desc LIKE type_t.chr80, 
   a LIKE type_t.chr500, 
   b LIKE type_t.chr500, 
   c LIKE type_t.chr500, 
   nmbsdocno LIKE nmbs_t.nmbsdocno, 
   nmbsdocdt LIKE nmbs_t.nmbsdocdt, 
   docno LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc1             STRING
DEFINE g_wc2             STRING
DEFINE g_sql             STRING
DEFINE g_para_data       LIKE type_t.chr80     #資金模組匯率來源
DEFINE g_ld_wc           STRING      #150707-00001#7
DEFINE g_nmbt017         LIKE nmbt_t.nmbt017   #150805apo
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
 
{<section id="anmt530_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt530_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_nmbscomp,p_b,p_c,p_nmbsld,p_nmbsdocno,p_nmcqdocno
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
   DEFINE p_b             LIKE type_t.chr1
   DEFINE p_c             LIKE type_t.chr1
   DEFINE p_nmbsld        LIKE nmbs_t.nmbsld
   DEFINE p_nmbsdocno     LIKE nmbs_t.nmbsdocno
   DEFINE p_nmcqdocno     LIKE nmcq_t.nmcqdocno
   DEFINE r_docno         LIKE nmbs_t.nmbsdocno   #150707-00001#4
   DEFINE l_origin_str    STRING  #160929-00040#1
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt530_01 WITH FORM cl_ap_formpath("anm","anmt530_01")
 
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
         CALL anmt530_01_nmbsld_desc(l_lsaeld)
         CALL cl_set_comp_entry('nmbsld',FALSE)
      END IF
   END IF

   IF NOT cl_null(p_nmbsdocno) THEN
      LET g_nmbs_m.nmbsdocno=p_nmbsdocno
   END IF
   
   LET g_nmbs_m.docno= ''
   CALL s_fin_create_account_center_tmp()  #160929-00040#1
   
   WHILE TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_nmbs_m.nmbscomp,g_nmbs_m.a,g_nmbs_m.b,g_nmbs_m.c, 
          g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,g_nmbs_m.docno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF cl_null(p_b) THEN
               LET g_nmbs_m.a = 'Y'
               LET g_nmbs_m.b = 'N'
            ELSE
               LET g_nmbs_m.a = 'N'
               LET g_nmbs_m.b = p_b
            END IF
            LET g_nmbs_m.a = 'N'   #150707-00001#7
            LET g_nmbs_m.b = 'Y'   #150707-00001#7
            IF cl_null(p_c) THEN
               LET g_nmbs_m.c = 'N'
            ELSE
               LET g_nmbs_m.c = p_c
            END IF
            #150707-00001#7-mark-(s)
            #LET g_nmbs_m.nmbscomp = l_isaecomp
            #LET g_nmbs_m.nmbsld = l_lsaeld
            #CALL anmt530_01_nmbscomp_desc()            
            #LET g_nmbs_m.nmbsdocdt = g_today
            #150707-00001#7-mark-(e)
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbssite
            
            #add-point:AFTER FIELD nmbssite name="input.a.nmbssite"
            #150707-00001#7--(s)
            IF NOT cl_null(g_nmbs_m.nmbssite) THEN
               CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmbs_m.nmbssite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()               
                  LET g_nmbs_m.nmbssite = ''
                  LET g_nmbs_m.nmbssite_desc = ''
                  DISPLAY BY NAME g_nmbs_m.nmbssite_desc
                  NEXT FIELD CURRENT
               END IF
               #取得所屬法人+帳別
               CALL s_fin_orga_get_comp_ld(g_nmbs_m.nmbssite) RETURNING g_sub_success,g_errno,g_nmbs_m.nmbscomp,g_nmbs_m.nmbsld
               IF NOT cl_null(g_nmbs_m.nmbsld) THEN
                  CALL anmt530_01_set_ld_info(g_nmbs_m.nmbsld)
                  CALL anmt530_01_nmbsld_desc(g_nmbs_m.nmbsld)                  
               END IF                  
            END IF
            LET g_nmbs_m.nmbssite_desc = s_desc_get_department_desc(g_nmbs_m.nmbssite)
            DISPLAY BY NAME g_nmbs_m.nmbssite_desc
            #150707-00001#7--(e)
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbssite
            #add-point:BEFORE FIELD nmbssite name="input.b.nmbssite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbssite
            #add-point:ON CHANGE nmbssite name="input.g.nmbssite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbsld
            
            #add-point:AFTER FIELD nmbsld name="input.a.nmbsld"
            CALL anmt530_01_nmbsld_desc(g_nmbs_m.nmbsld)
            IF NOT cl_null(g_nmbs_m.nmbsld) THEN               
              #150707-00001#7-mark-(s)
              #INITIALIZE g_chkparam.* TO NULL
              #LET g_chkparam.arg1 = g_nmbs_m.nmbsld
              #IF cl_chk_exist("v_glaald_1") THEN
              #   #檢查成功時後續處理
              #ELSE
              #   #檢查失敗時後續處理
              #   LET g_nmbs_m.nmbsld = ''
              #   CALL anmt530_01_nmbsld_desc(g_nmbs_m.nmbsld)
              #   NEXT FIELD CURRENT
              #END IF
              #150707-00001#7-mark-(e)
               #150707-00001#7--(s)
               CALL s_fin_account_center_with_ld_chk(g_nmbs_m.nmbssite,g_nmbs_m.nmbsld,g_user,'3','N','',g_nmbs_m.nmbsdocdt) RETURNING g_sub_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmbs_m.nmbsld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_nmbs_m.nmbsld = ''
                  LET g_nmbs_m.nmbsld_desc = ''
                  DISPLAY BY NAME g_nmbs_m.nmbsld_desc
                  NEXT FIELD CURRENT
               END IF
               CALL anmt530_01_set_ld_info(g_nmbs_m.nmbsld)    
               CALL anmt530_01_nmbsld_desc(g_nmbs_m.nmbsld)               
               #150707-00001#7--(e)
            END IF 
 
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
         AFTER FIELD nmbscomp
            
            #add-point:AFTER FIELD nmbscomp name="input.a.nmbscomp"
            CALL anmt530_01_nmbscomp_desc()
            IF NOT cl_null(g_nmbs_m.nmbscomp) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmbs_m.nmbscomp
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmbs_m.nmbscomp = ''
                  CALL anmt530_01_nmbscomp_desc()
                  NEXT FIELD CURRENT
               END IF
               LET g_nmbs_m.docno = ''
               DISPLAY g_nmbs_m.docno TO docno

            END IF 


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
            IF g_nmbs_m.a = 'Y' THEN 
               LET g_nmbs_m.b = 'N'
               DISPLAY '' TO nmcqdocno
            END IF
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
            IF g_nmbs_m.b = 'Y' THEN 
               LET g_nmbs_m.a = 'N'
               DISPLAY '' TO nmcqdocno
            END IF
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
         AFTER FIELD nmbsdocno
            
            #add-point:AFTER FIELD nmbsdocno name="input.a.nmbsdocno"
            IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               LET l_glaa024 = ''
               CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024
               IF NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
                  #CALL s_aooi200_chk_slip(g_nmbs_m.nmbscomp,l_glaa024,g_nmbs_m.nmbsdocno,'anmt530') RETURNING l_success   #2014/12/29 liuym mark
                  CALL s_aooi200_fin_chk_slip(g_nmbs_m.nmbsld,l_glaa024,g_nmbs_m.nmbsdocno,'anmt530') RETURNING l_success  #2014/12/29 liuym add
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno
            #add-point:BEFORE FIELD docno name="input.b.docno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno
            
            #add-point:AFTER FIELD docno name="input.a.docno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmbs_m.nmbsld) AND NOT cl_null(g_nmbs_m.nmbsdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbs_m.nmbsld != g_nmbsld_t  OR g_nmbs_m.nmbsdocno != g_nmbsdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbs_t WHERE "||"nmbsent = '" ||g_enterprise|| "' AND "||"nmbsld = '"||g_nmbs_m.nmbsld ||"' AND "|| "nmbsdocno = '"||g_nmbs_m.nmbsdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno
            #add-point:ON CHANGE docno name="input.g.docno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbssite
            #add-point:ON ACTION controlp INFIELD nmbssite name="input.c.nmbssite"
            #150707-00001#7--(s)
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbs_m.nmbssite
            #LET g_qryparam.where = " ooef201 = 'Y' " #161021-00050#10 mark
            #CALL q_ooef001()                         #161021-00050#10 mark
            CALL q_ooef001_46()                       #161021-00050#10
            LET g_nmbs_m.nmbssite = g_qryparam.return1
            DISPLAY g_nmbs_m.nmbssite TO nmbssite
            LET g_nmbs_m.nmbssite_desc = s_desc_get_department_desc(g_nmbs_m.nmbssite)
            NEXT FIELD nmbssite
            #150707-00001#7--(e)
            #END add-point
 
 
         #Ctrlp:input.c.nmbsld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsld
            #add-point:ON ACTION controlp INFIELD nmbsld name="input.c.nmbsld"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbs_m.nmbsld
            #160930-00025#1 mod s---            
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')",
            #                      #" AND glaacomp = '",g_nmbs_m.nmbscomp,"'"   #150707-00001#7mark
            #                       " AND glaald IN ",g_ld_wc                   #150707-00001#7
            CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt,'1')
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
            LET g_qryparam.where = " glaacomp IN ",l_origin_str
            #160930-00025#1 mod e---
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_nmbs_m.nmbsld = g_qryparam.return1
            CALL anmt530_01_nmbsld_desc(g_nmbs_m.nmbsld)
            DISPLAY g_nmbs_m.nmbsld TO nmbsld
            NEXT FIELD nmbsld
            #END add-point
 
 
         #Ctrlp:input.c.nmbscomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbscomp
            #add-point:ON ACTION controlp INFIELD nmbscomp name="input.c.nmbscomp"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbs_m.nmbscomp
            CALL q_ooef001_2()
            LET g_nmbs_m.nmbscomp = g_qryparam.return1
            CALL anmt530_01_nmbscomp_desc()
            DISPLAY g_nmbs_m.nmbscomp TO nmbscomp
            NEXT FIELD nmbscomp
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocno
            #add-point:ON ACTION controlp INFIELD nmbsdocno name="input.c.nmbsdocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbs_m.nmbsdocno
            LET l_glaa024 = ''
            CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024
            LET g_qryparam.where = " ooba001 = '",l_glaa024,"' AND oobx003 = 'anmt530'"
            ##151102-00007#1 --begin
            IF g_nmbs_m.c = 'Y' THEN
               LET g_qryparam.where = " oobx003 = 'anmt530'"
            ELSE
               LET l_glaa024 = ''
               CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa024') RETURNING  r_success,l_glaa024
               LET g_qryparam.where = " ooba001 = '",l_glaa024,"' AND oobx003 = 'anmt530'"
            END IF
            #151102-00007#1 --end
            CALL q_ooba002()
            LET g_nmbs_m.nmbsdocno = g_qryparam.return1
            DISPLAY g_nmbs_m.nmbsdocno TO nmbsdocno
            NEXT FIELD nmbsdocno
            #END add-point
 
 
         #Ctrlp:input.c.nmbsdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbsdocdt
            #add-point:ON ACTION controlp INFIELD nmbsdocdt name="input.c.nmbsdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.docno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno
            #add-point:ON ACTION controlp INFIELD docno name="input.c.docno"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc1 ON nmcqdocdt
         BEFORE CONSTRUCT

      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc2 ON nmcqdocno
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD nmcqdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_nmbs_m.a = 'Y' THEN 
               LET g_qryparam.where = " nmba003 = 'anmt510' AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
                                      "   AND (nmbastus = 'Y' OR nmbastus = 'V' ) ",
                                      #150707-00001#4--mark--(s)
                                      #"   AND nmbb042 IN (",
                                      #"SELECT gzcb002 FROM gzcb_t ",
                                      #" WHERE gzcb001 = '8714' ",
                                      #"   AND gzcb005 = 'Y' )",
                                      #150707-00001#4--mark--(e)                                      
                                      #150707-00001#4--(s)
                                      "   AND EXISTS ( SELECT 1 FROM nmbb_t ",
                                      "                 WHERE nmbaent  = nmbbent ",
                                      "                   AND nmbacomp = nmbbcomp ",
                                      "                   AND nmbadocno= nmbbdocno ",
                                      "                   AND nmbb042 IN (SELECT gzcb002 FROM gzcb_t ",
                                      "                                    WHERE gzcb001 = '8714' AND gzcb005 = 'Y')) ",                                    
                                      #150707-00001#4--(e)                                      
                                      "   AND nmbadocno NOT IN (",
                                      "SELECT nmbt002 FROM nmbt_t ",
                                      " WHERE nmbtent = '",g_enterprise,"'",")"                                      
               CALL q_nmbadocno()                           #呼叫開窗
            END IF
            
            IF g_nmbs_m.b = 'Y' THEN 
               LET g_qryparam.where = " nmcqcomp = '",g_nmbs_m.nmbscomp,"'",
                                      "   AND (nmcqstus = 'Y' OR nmcqstus = 'S') ",
                                      "   AND nmcq001 IN (",
                                      "SELECT gzcb002 FROM gzcb_t ",
                                      " WHERE gzcb001 = '8714' ",
                                      "   AND gzcb005 = 'Y' )",
                                      #150707-00001#7--(s)
                                      "   AND NOT EXISTS (SELECT 1 FROM nmbs_t,nmbt_t ",
                                      "                    WHERE nmbsent = nmbtent AND nmbsld = nmbtld ",
                                      "                      AND nmbsdocno = nmbtdocno AND nmbsstus <> 'X' ",
                                      "                      AND nmbt002 = nmcqdocno) "
                                      #150707-00001#7--(e)                                         
                                      #150707-00001#7--mark--(s)
                                      #"   AND nmcqdocno NOT IN (",
                                      #"SELECT nmbt002 FROM nmbt_t ",
                                      #" WHERE nmbtent = '",g_enterprise,"'",")"  
                                      #150707-00001#7--mark--(e)
               CALL q_nmcqdocno()                           #呼叫開窗
            END IF
            
            DISPLAY g_qryparam.return1 TO nmcqdocno      #顯示到畫面上
            NEXT FIELD nmcqdocno                         #返回原欄位
 
      END CONSTRUCT
     
      BEFORE DIALOG
         IF NOT cl_null(p_nmcqdocno) THEN
            CALL cl_set_comp_entry('nmcqdocno',FALSE)
            DISPLAY p_nmcqdocno TO nmcqdocno
            LET g_wc2=" nmcqdocno='",p_nmcqdocno,"'"
         END IF
         #150707-00001#7--(s)
         #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
         CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_nmbs_m.nmbssite,g_errno
         LET g_nmbs_m.nmbssite_desc = s_desc_get_department_desc(g_nmbs_m.nmbssite)
         DISPLAY BY NAME g_nmbs_m.nmbssite_desc
         #取得主帳套
         SELECT glaald INTO g_nmbs_m.nmbsld
           FROM glaa_t
          WHERE glaaent = g_enterprise  
            AND glaacomp = g_nmbs_m.nmbssite
            AND glaa014 = 'Y'       
         IF NOT cl_null(g_nmbs_m.nmbsld) THEN
            CALL anmt530_01_set_ld_info(g_nmbs_m.nmbsld)
            CALL anmt530_01_nmbsld_desc(g_nmbs_m.nmbsld)
         END IF      
         LET g_nmbs_m.nmbsdocdt = g_today
         #150707-00001#7--(e)         
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
      CALL anmt530_01_ins_nmbs()
       RETURNING r_docno   #150707-00001#4
       DISPLAY g_nmbs_m.docno TO docno
       #161018-00057#1 --add--s--
       IF cl_ask_confirm('apm-00285') THEN
          LET g_nmbs_m.docno = ''
          DISPLAY g_nmbs_m.docno TO docno
          CONTINUE WHILE
       ELSE
          EXIT WHILE
       END IF
       #161018-00057#1 --add--e--      
     # CONTINUE WHILE  #161018-00057#1  mark
   END IF
   
   END WHILE

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_anmt530_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN r_docno   #150707-00001#4
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt530_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt530_01.other_function" readonly="Y" >}
# 帳套名稱
PRIVATE FUNCTION anmt530_01_nmbsld_desc(p_nmbsld)
   DEFINE p_nmbsld    LIKE nmbs_t.nmbsld
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_nmbsld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbsld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbsld_desc

END FUNCTION
# 法人名稱帶值
PRIVATE FUNCTION anmt530_01_nmbscomp_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbs_m.nmbscomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbs_m.nmbscomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbs_m.nmbscomp_desc
END FUNCTION
# 插入單頭檔nmbs_t
PRIVATE FUNCTION anmt530_01_ins_nmbs()
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
#161128-00061#2---modify----end---------- 
   DEFINE l_date          DATETIME YEAR TO SECOND
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glaald        LIKE glaa_t.glaald
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   #150707-00001#4--(s)
   DEFINE l_ooba002       LIKE ooba_t.ooba002
   DEFINE l_dfin0030      LIKE type_t.chr1
   DEFINE l_glaa121       LIKE glaa_t.glaa121
   DEFINE r_docno         LIKE nmbs_t.nmbsdocno
   #150707-00001#4--(e)
   
   
   CALL s_transaction_begin()
   #CALL cl_showmsg_init()
   LET g_success = 'Y'
   LET r_docno = ''   #150707-00001#4
   
   LET l_nmbs.nmbsent = g_enterprise
   LET l_nmbs.nmbscomp = g_nmbs_m.nmbscomp
  #SELECT glaa003,glaa024 INTO l_glaa003,l_glaa024 FROM glaa_t WHERE glaaent =g_enterprise AND glaald=g_nmbs_m.nmbsld   #150707-00001#4 mark  #2014/12/29 liuym add
   CALL s_ld_sel_glaa(g_nmbs_m.nmbsld,'glaa003|glaa024|glaa121') RETURNING g_sub_success,l_glaa003,l_glaa024,l_glaa121  #150707-00001#4
   #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/29 liuym mark-----str-----
   #CALL s_aooi200_gen_docno(g_nmbs_m.nmbscomp,g_nmbs_m.nmbsdocno,g_today,"anmt530")   
   #RETURNING l_success,l_nmbs.nmbsdocno
   #2014/12/29 liuym add-----str-----
  #CALL s_aooi200_fin_gen_docno(g_nmbs_m.nmbsld,l_glaa024,l_glaa003,g_nmbs_m.nmbsdocno,g_today,"anmt530")            #150924 mark
   CALL s_aooi200_fin_gen_docno(g_nmbs_m.nmbsld,l_glaa024,l_glaa003,g_nmbs_m.nmbsdocno,g_nmbs_m.nmbsdocdt,"anmt530") #150924
        RETURNING l_success,l_nmbs.nmbsdocno
   #2014/12/29 liuym add-----end-----               
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_nmbs.nmbsdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   CALL cl_err_collect_init()
   
   LET g_nmbs_m.docno = l_nmbs.nmbsdocno

   LET l_nmbs.nmbsdocdt = g_nmbs_m.nmbsdocdt
   LET l_nmbs.nmbssite = g_nmbs_m.nmbssite   #150707-00001#7 mod g_site-->nmbssite
   LET l_nmbs.nmbs001 = 'anmt530'
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
      INSERT INTO nmbs_t(nmbsent,nmbssite,nmbscomp,nmbsld,nmbsdocno,nmbsdocdt,nmbs001,nmbsownid,nmbsowndp,nmbscrtid,
                         nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt,nmbscnfid,nmbscnfdt,nmbsstus)
                  VALUES(l_nmbs.nmbsent,l_nmbs.nmbssite,l_nmbs.nmbscomp,l_nmbs.nmbsld,l_nmbs.nmbsdocno,l_nmbs.nmbsdocdt,
                         l_nmbs.nmbs001,l_nmbs.nmbsownid,l_nmbs.nmbsowndp,l_nmbs.nmbscrtid,l_nmbs.nmbscrtdp,
                         l_date,l_nmbs.nmbsmodid,l_nmbs.nmbsmoddt,l_nmbs.nmbscnfid,l_nmbs.nmbscnfdt,
                         l_nmbs.nmbsstus)
      IF SQLCA.SQLcode  THEN
         #CALL cl_errmsg("ins nmbs",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'                         
      END IF
      
      #插入單身檔
      IF g_nmbs_m.a = 'Y' THEN 
         CALL anmt530_01_ins_nmbt_1(l_nmbs.nmbsdocno,l_nmbs.nmbsld,'')   #150707-00001#4 add ''
      END IF
      IF g_nmbs_m.b = 'Y' THEN
         CALL anmt530_01_ins_nmbt_2(l_nmbs.nmbsdocno,l_nmbs.nmbsld,'')   #150707-00001#4 add ''
      END IF
   END IF
   
   IF g_nmbs_m.c = 'Y' THEN 
       LET g_sql = "SELECT glaald FROM glaa_t ",
                   " WHERE glaaent = '",g_enterprise,"'",
                   "   AND glaacomp = '",g_nmbs_m.nmbscomp,"'",
                   "   AND (glaa014 = 'Y' OR glaa008 = 'Y') "
       PREPARE anmt530_01_pre1 FROM g_sql
       DECLARE anmt530_01_cur1 CURSOR FOR anmt530_01_pre1
       FOREACH anmt530_01_cur1 INTO l_glaald
          #插入單頭檔
          INSERT INTO nmbs_t(nmbsent,nmbssite,nmbscomp,nmbsld,nmbsdocno,nmbsdocdt,nmbs001,nmbsownid,nmbsowndp,nmbscrtid,
                             nmbscrtdp,nmbscrtdt,nmbsmodid,nmbsmoddt,nmbscnfid,nmbscnfdt,nmbsstus)
                      VALUES(l_nmbs.nmbsent,l_nmbs.nmbssite,l_nmbs.nmbscomp,l_glaald,l_nmbs.nmbsdocno,l_nmbs.nmbsdocdt,
                             l_nmbs.nmbs001,l_nmbs.nmbsownid,l_nmbs.nmbsowndp,l_nmbs.nmbscrtid,l_nmbs.nmbscrtdp,
                             l_date,l_nmbs.nmbsmodid,l_nmbs.nmbsmoddt,l_nmbs.nmbscnfid,l_nmbs.nmbscnfdt,
                             l_nmbs.nmbsstus)
          IF SQLCA.SQLcode  THEN
             #CALL cl_errmsg("ins nmbs",'','',SQLCA.SQLCODE,1) 
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "ins nmbs"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET g_success = 'N'                        
          END IF
          #插入單身檔
          IF g_nmbs_m.a = 'Y' THEN 
             CALL anmt530_01_ins_nmbt_1(l_nmbs.nmbsdocno,l_glaald,'')   #150707-00001#4 add ''
          END IF
          IF g_nmbs_m.b = 'Y' THEN
             CALL anmt530_01_ins_nmbt_2(l_nmbs.nmbsdocno,l_glaald,'')   #150707-00001#4 add ''
          END IF 
       END FOREACH 
   END IF
   
   IF g_success = 'N' THEN
      #CALL cl_err_showmsg() 
      CALL cl_err_collect_show()
       LET g_nmbs_m.docno = null
      CALL s_transaction_end('N','1') 
   ELSE
      SELECT COUNT(*) INTO l_cnt FROM nmbt_t WHERE nmbtent = g_enterprise AND nmbtdocno = l_nmbs.nmbsdocno
      IF l_cnt = 0 OR cl_null(l_cnt) THEN
         LET g_nmbs_m.docno = null
         CALL s_transaction_end('N','1')
      ELSE
         CALL s_transaction_end('Y','1')
         #- #150707-00001#4--(s)
         LET r_docno = l_nmbs.nmbsdocno
         CALL s_aooi200_fin_get_slip(l_nmbs.nmbsdocno) RETURNING g_sub_success,l_ooba002
         CALL s_fin_get_doc_para(l_nmbs.nmbsld,l_nmbs.nmbscomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
         IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y'THEN
            CALL s_transaction_begin()
            CALL s_pre_voucher_ins('NM','N30',l_nmbs.nmbsld,l_nmbs.nmbsdocno,l_nmbs.nmbsdocdt,'1')
                 RETURNING g_sub_success
            IF g_sub_success THEN
               CALL s_transaction_end('Y','0')
            ELSE
               CALL s_transaction_end('N','0')
            END IF
         END IF                  
         #-150707-00001#4--(e)         
      END IF 
      CALL cl_err_collect_show()   #150707-00001#7
   END IF
   RETURN r_docno   #150707-00001#4
END FUNCTION
# 插入單身檔nmbt_t
PUBLIC FUNCTION anmt530_01_ins_nmbt_1(p_nmbtdocno,p_nmbtld,p_wc)
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_wc            STRING   #150707-00001#4
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
   DEFINE l_nmbadocdt     LIKE nmba_t.nmbadocdt
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
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE l_cnt           LIKE type_t.num5
   
   CALL s_ld_sel_glaa(p_nmbtld,'glaa008|glaa014|glaa001|glaa015|glaa016|glaa017|glaa018|glaa019|glaa020|glaa021|glaa022')
   RETURNING l_success,l_glaa008,l_glaa014,l_glaa001,l_glaa015,l_glaa016,l_glaa017,l_glaa018,l_glaa019,l_glaa020,l_glaa021,l_glaa022

   LET g_wc1 = cl_replace_str(g_wc1,"nmcqdocdt","nmbadocdt")
   LET g_wc2 = cl_replace_str(g_wc2,"nmcqdocno","nmbadocno")
   #-#150707-00001#4--(s)
   IF cl_null(g_wc1) THEN LET g_wc1 = " 1=1" END IF
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF
   IF cl_null (g_nmbs_m.nmbscomp) THEN
      SELECT nmbscomp INTO g_nmbs_m.nmbscomp
        FROM nmbs_t
       WHERE nmbsent = g_enterprise
         AND nmbsld = p_nmbtld
         AND nmbsdocno = p_nmbtdocno
   END IF
   #-#150707-00001#4--(e)
   LET g_sql = "SELECT nmbadocno",
               "  FROM nmba_t,nmbb_t",
               " WHERE nmbaent = nmbbent ",
               "   AND nmbacomp = nmbbcomp ",
               "   AND nmbadocno = nmbbdocno ",
               "   AND nmbaent = '",g_enterprise,"'",
               "   AND nmbacomp = '",g_nmbs_m.nmbscomp,"'",
               "   AND nmba003 = 'anmt510' ",
               "   AND nmbb042 IN (",
               "SELECT gzcb002 FROM gzcb_t ",
               " WHERE gzcb001 = '8714' ",
               "   AND gzcb005 = 'Y' )",
               "   AND ",g_wc1,
               "   AND ",g_wc2
   #-#150707-00001#4--(s)
   IF NOT cl_null(p_wc) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc
   END IF
   #-#150707-00001#4--(e)
   LET g_sql = g_sql," ORDER BY nmbadocno "   #150707-00001#5
   PREPARE anmt530_01_pre2 FROM g_sql
   DECLARE anmt530_01_cur2 CURSOR FOR anmt530_01_pre2
   FOREACH anmt530_01_cur2 INTO l_nmbt002
   
      #檢查是否已經存在於anmt520應收票據異動檔
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt FROM nmcr_t WHERE nmcrent = g_enterprise AND nmcr003 = l_nmbt002
      IF l_cnt > 0 THEN
        #CONTINUE FOREACH   #150707-00001#4 mark
         #CALL cl_errmsg(l_nmbt002,l_nmbt002,'','anm-00301',1) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00301'
         LET g_errparam.extend = l_nmbt002
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         CONTINUE FOREACH   #150707-00001#4
      ELSE
         LET g_success = 'Y'   #只要有一筆資料則保留單身
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
      LET l_nmbt.nmbt001 = '1'
      LET l_nmbt.nmbt002 = l_nmbt002
      LET l_nmbt.nmbt003 = 1
      LET l_nmbt.nmbt013 = g_user
      
      #檢查單號是否已存在
      IF g_nmbs_m.c = 'Y' THEN 
         SELECT COUNT(*) INTO l_n
           FROM nmbt_t
          WHERE nmbtent = g_enterprise
            AND nmbt002 = l_nmbt.nmbt002
            AND nmbt003 = l_nmbt.nmbt003
            AND nmbtld  = p_nmbtld
      ELSE
         SELECT COUNT(*) INTO l_n    
           FROM nmbt_t
          WHERE nmbtent = g_enterprise
            AND nmbt002 = l_nmbt.nmbt002
            AND nmbt003 = l_nmbt.nmbt003
      END IF
      IF l_n > 0 THEN 
         #CALL cl_errmsg(l_nmbt.nmbt002,l_nmbt.nmbt003,'','anm-00171',1) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00171'
         LET g_errparam.extend = l_nmbt.nmbt002,"/",l_nmbt.nmbt003   #150707-00001#4 add nmbt002
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         CONTINUE FOREACH 
      END IF

      LET g_nmbt017 = ''    #150805apo
      SELECT nmbb030,nmbb004,nmbb005,nmbb006,nmbb007,nmbb031,
             nmbb003,nmbacomp,nmba001,nmba004,nmba008,nmbadocdt
        INTO l_nmbt.nmbt011,l_nmbt.nmbt100,
             l_nmbt.nmbt101,l_nmbt.nmbt103,
             l_nmbt.nmbt113,l_nmbt.nmbt012,
             l_nmbt.nmbt014,l_nmbt.nmbt017,
             l_nmbt.nmbt018,l_nmbt.nmbt021,
             l_nmbt.nmbt025,l_nmbadocdt
        FROM nmba_t,nmbb_t
       WHERE nmbaent = nmbbent
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmbaent = g_enterprise
         AND nmbacomp = g_nmbs_m.nmbscomp
         AND nmbadocno = l_nmbt.nmbt002        
     LET g_nmbt017 = l_nmbt.nmbt017    #150805apo
     
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
                                       #帳套       #日期;    來源幣別   目的幣別; 匯類類型
            CALL anmt530_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa016,l_glaa018)                      
            RETURNING l_nmbt.nmbt121   
            #150707-00001#7--(s)
            IF l_glaa017 = '1' THEN 
               LET l_nmbt.nmbt123 = l_nmbt.nmbt103 * l_nmbt.nmbt121   
            ELSE
            #150707-00001#7--(e)
               LET l_nmbt.nmbt123 = l_nmbt.nmbt113 * l_nmbt.nmbt121   
            END IF   #150707-00001#7
        END IF
         
        IF l_glaa019 = 'Y' THEN                         
           #主帳套本位幣二匯率
           IF l_glaa021 = '1' THEN 
              LET l_ooam003 = l_nmbt.nmbt100
           ELSE
              LET l_ooam003 = l_glaa001
           END IF
                                      #帳套      #日期;      來源幣別   目的幣別; 匯類類型
           CALL anmt530_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa020,l_glaa022)
           RETURNING l_nmbt.nmbt131   
           #150707-00001#7--(s)
           IF l_glaa021 = '1' THEN 
              LET l_nmbt.nmbt133 = l_nmbt.nmbt103 * l_nmbt.nmbt131   
           ELSE
           #150707-00001#7--(e)            
              LET l_nmbt.nmbt133 = l_nmbt.nmbt113 * l_nmbt.nmbt131 
           END IF   #150707-00001#7             
        END IF
     END IF
      
     #平行賬套,金額匯率重新計算
     IF l_glaa014 <> 'Y' AND l_glaa008 = 'Y' THEN 
        LET l_nmbt.nmbt101 = 0
        LET l_nmbt.nmbt113 = 0
 
        CALL cl_get_para(g_enterprise,l_nmbt.nmbtcomp,'S-FIN-4004') RETURNING g_para_data  #資金模組匯率來源
        #平行賬套匯率
                                   #帳套     #日期;       來源幣別        目的幣別; 匯類類型
        CALL anmt530_01_get_exrate(p_nmbtld,l_nmbadocdt,l_nmbt.nmbt100,l_glaa001,g_para_data)                      
        RETURNING l_nmbt.nmbt101    
        LET l_nmbt.nmbt113 = l_nmbt.nmbt103 * l_nmbt.nmbt101
        
        IF l_glaa015 = 'Y' THEN                         
            #主帳套本位幣二匯率
            IF l_glaa017 = '1' THEN 
               LET l_ooam003 = l_nmbt.nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                       #帳套      #日期;    來源幣別   目的幣別; 匯類類型
            CALL anmt530_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa016,l_glaa018)                      
            RETURNING l_nmbt.nmbt121   
            #150707-00001#7--(s)
            IF l_glaa017 = '1' THEN 
               LET l_nmbt.nmbt123 = l_nmbt.nmbt103 * l_nmbt.nmbt121   
            ELSE
            #150707-00001#7--(e)            
               LET l_nmbt.nmbt123 = l_nmbt.nmbt113 * l_nmbt.nmbt121   
            END IF   #150707-00001#7
        END IF
         
        IF l_glaa019 = 'Y' THEN                         
           #主帳套本位幣二匯率
           IF l_glaa021 = '1' THEN 
              LET l_ooam003 = l_nmbt.nmbt100
           ELSE
              LET l_ooam003 = l_glaa001
           END IF
                                      #帳套     #日期;       來源幣別   目的幣別; 匯類類型
           CALL anmt530_01_get_exrate(p_nmbtld,l_nmbadocdt,l_ooam003,l_glaa020,l_glaa022)
           RETURNING l_nmbt.nmbt131   
           #150707-00001#7--(s)
           IF l_glaa021 = '1' THEN 
              LET l_nmbt.nmbt133 = l_nmbt.nmbt103 * l_nmbt.nmbt131   
           ELSE
           #150707-00001#7--(e)            
              LET l_nmbt.nmbt133 = l_nmbt.nmbt113 * l_nmbt.nmbt131   
           END IF   #150707-00001#7
        END IF
     END IF
     
     LET l_nmbt.nmbt029 = "" #150817
     LET l_nmbt.nmbt030 = "" #150817
     #赋值 nmbt029,nmbt030
     IF l_nmbt.nmbt001 = '1' THEN
        SELECT nmbb028 INTO l_nmbb028
          FROM nmbb_t
         WHERE nmbbent = g_enterprise
           AND nmbbcomp = g_nmbs_m.nmbscomp
           AND nmbbdocno = l_nmbt.nmbt002
        SELECT DISTINCT glab005 INTO l_nmbt.nmbt029
          FROM glab_t
         WHERE glabent = g_enterprise #借方科目: 依 agli190 設定
           AND glabld  = p_nmbtld
           AND glab001 = '21'
           AND glab002 = '30'
           AND glab003 = l_nmbb028
        SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
          FROM glab_t
         WHERE glabent = g_enterprise
           AND glabld  = p_nmbtld
           AND glab001 = '41'
           AND glab002 = '8714'  # 應收票據 異動項
           AND glab003 = '1'     # 應收票據收票
     END IF
     
     #161128-00061#2---modify----begin----------
     #INSERT INTO nmbt_t VALUES(l_nmbt.*)
     INSERT INTO nmbt_t (nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,
                         nmbt012,nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,
                         nmbt022,nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,
                         nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,
                         nmbt042,nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,
                         nmbt004,nmbt114)
      VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,
             l_nmbt.nmbt012,l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,
             l_nmbt.nmbt022,l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,
             l_nmbt.nmbt032,l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
             l_nmbt.nmbt042,l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,
             l_nmbt.nmbt004,l_nmbt.nmbt114)
     #161128-00061#2---modify----end----------
     
     IF SQLCA.SQLcode  THEN
        #CALL cl_errmsg("ins nmbt",'','',SQLCA.SQLCODE,1)
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.SQLCODE
        LET g_errparam.extend = "ins nmbt"
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_success = 'N'
     END IF
     
   # CALL anmt530_01_nmbv_ins(p_nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'1',l_nmbt.nmbt002,'','',l_nmbt.nmbt103,l_nmbt.nmbt113,'',l_nmbt.nmbt123,'',l_nmbt.nmbt133)
   END FOREACH 
   #150707-00001#5--(s)
   #存在任何一筆單身成功寫入,應視為成功
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM nmbt_t 
    WHERE nmbtent = g_enterprise
      AND nmbtdocno = l_nmbt.nmbtdocno   
      AND nmbtld = l_nmbt.nmbtld
   IF l_n > 0 THEN
      LET g_success = 'Y'
   END IF
   #150707-00001#5--(e)   
END FUNCTION
# 插入單身檔nmbt_t
PUBLIC FUNCTION anmt530_01_ins_nmbt_2(p_nmbtdocno,p_nmbtld,p_wc)
DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
DEFINE p_wc            STRING   #150707-00001#4
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
DEFINE l_nmcqdocdt     LIKE nmcq_t.nmcqdocdt
DEFINE l_nmcq001       LIKE nmcq_t.nmcq001
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
DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
DEFINE l_nmcr003       LIKE nmcr_t.nmcr003
   
   CALL s_ld_sel_glaa(p_nmbtld,'glaa008|glaa014|glaa001|glaa015|glaa016|glaa017|glaa018|glaa019|glaa020|glaa021|glaa022')
   RETURNING l_success,l_glaa008,l_glaa014,l_glaa001,l_glaa015,l_glaa016,l_glaa017,l_glaa018,l_glaa019,l_glaa020,l_glaa021,l_glaa022
   #-#150707-00001#4--(s)
   IF cl_null(g_wc1) THEN LET g_wc1 = " 1=1" END IF
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF
   IF cl_null (g_nmbs_m.nmbscomp) THEN
      SELECT nmbscomp INTO g_nmbs_m.nmbscomp
        FROM nmbs_t
       WHERE nmbsent = g_enterprise
         AND nmbsld = p_nmbtld
         AND nmbsdocno = p_nmbtdocno
   END IF
   #-#150707-00001#4--(e)
  #LET g_sql = "SELECT nmcqdocno,nmcrseq",          #150918-00001#5 mark
   LET g_sql = "SELECT nmcqdocno,nmcrseq,nmcq101",  #150918-00001#5
               "  FROM nmcq_t,nmcr_t",
               " WHERE nmcqent = nmcrent ",
               "   AND nmcqcomp = nmcrcomp ",
               "   AND nmcqdocno = nmcrdocno ",
               "   AND nmcqent = '",g_enterprise,"'",
               "   AND nmcqcomp = '",g_nmbs_m.nmbscomp,"'",
               "   AND (nmcqstus = 'Y' OR nmcqstus = 'S') ",
               "   AND nmcq001 IN (",
               "SELECT gzcb002 FROM gzcb_t ",
               " WHERE gzcb001 = '8714' ",
               "   AND gzcb005 = 'Y' )",
               "   AND ",g_wc1,
               "   AND ",g_wc2
   #-#150707-00001#4--(s)
   IF NOT cl_null(p_wc) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc
   END IF
   #-#150707-00001#4--(e)
   LET g_sql = g_sql," ORDER BY nmcqdocno,nmcrseq "   #150707-00001#5
   PREPARE anmt530_01_pre3 FROM g_sql
   DECLARE anmt530_01_cur3 CURSOR FOR anmt530_01_pre3
  #FOREACH anmt530_01_cur3 INTO l_nmbt002,l_nmbt003                #150918-00001#5 mark
   FOREACH anmt530_01_cur3 INTO l_nmbt002,l_nmbt003,l_nmbt.nmbt101 #150918-00001#5
   
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
      LET l_nmbt.nmbt001 = '2'
      LET l_nmbt.nmbt002 = l_nmbt002
      LET l_nmbt.nmbt003 = l_nmbt003
      LET l_nmbt.nmbt013 = g_user
      
      #檢查單號是否已存在
      IF g_nmbs_m.c = 'Y' THEN
        #SELECT COUNT(*) INTO l_n         #150707-00001#7 mark
        #  FROM nmbt_t                    #150707-00001#7 mark
         SELECT COUNT(nmbtseq) INTO l_n   #150707-00001#7
           FROM nmbs_t,nmbt_t             #150707-00001#7
          WHERE nmbtent = g_enterprise
            AND nmbt002 = l_nmbt.nmbt002
            AND nmbt003 = l_nmbt.nmbt003
            AND nmbtld  = p_nmbtld
            #150707-00001#7--(s)
            AND nmbsent = nmbtent
            AND nmbsld = nmbtld
            AND nmbsdocno = nmbtdocno
            AND nmbsstus <> 'X'
            #150707-00001#7--(e)
      ELSE
        #SELECT COUNT(*) INTO l_n         #150707-00001#7 mark
        #  FROM nmbt_t                    #150707-00001#7 mark
         SELECT COUNT(nmbtseq) INTO l_n   #150707-00001#7 
           FROM nmbs_t,nmbt_t             #150707-00001#7
          WHERE nmbtent = g_enterprise
            AND nmbt002 = l_nmbt.nmbt002
            AND nmbt003 = l_nmbt.nmbt003
            #150707-00001#7--(s)
            AND nmbsent = nmbtent
            AND nmbsld = nmbtld
            AND nmbsdocno = nmbtdocno
            AND nmbsstus <> 'X'
            #150707-00001#7--(e)
      END IF
      IF l_n > 0 THEN 
         #CALL cl_errmsg(l_nmbt.nmbt002,l_nmbt.nmbt003,'','anm-00171',1) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00171'
         LET g_errparam.extend = l_nmbt.nmbt002,"/",l_nmbt.nmbt003   #150707-00001#4 add nmbt002
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         CONTINUE FOREACH 
      END IF
      
      LET g_nmbt017 = ''    #150805apo
     #SELECT nmcr001,nmbb004,nmbb005,nmcr103,nmcr113, #150918-00001#5 mark
      SELECT nmcr001,nmbb004,nmcr103,nmcr113,         #150918-00001#5
             nmbb031,nmbb003,nmcrcomp,nmba001,nmbb026,  #161219-00057#1  change nmba004 to nmbb026 lujh
            #nmba008          #150918-00001#5 mark
             nmba008,nmbb007  #150918-00001#5
       #INTO l_nmbt.nmbt011,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,  #150918-00001#5 mark
        INTO l_nmbt.nmbt011,l_nmbt.nmbt100,l_nmbt.nmbt103,l_nmbt.nmbt113,                 #150918-00001#5
             l_nmbt.nmbt012,l_nmbt.nmbt014,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt021,
            #l_nmbt.nmbt025                 #150918-00001#5 mark
             l_nmbt.nmbt025,l_nmbt.nmbt114  #150918-00001#5
        FROM nmcr_t,nmba_t,nmbb_t
       WHERE nmbaent = nmbbent  
         AND nmbaent = nmcrent  #170112-00051#1 add       
         AND nmbacomp = nmbbcomp
         AND nmbadocno = nmbbdocno
         AND nmcr001 = nmbb030
         AND nmcr003 = nmbadocno   #150814apo
         AND nmcrent = g_enterprise
         AND nmcrcomp = g_nmbs_m.nmbscomp
         AND nmcrdocno = l_nmbt002 
         AND nmcrseq = l_nmbt003   #150707-00001#4
      
      LET g_nmbt017 = l_nmbt.nmbt017    #150805apo
      SELECT nmcq001,nmcqdocdt INTO l_nmcq001,l_nmcqdocdt
        FROM nmcq_t
       WHERE nmcqent = g_enterprise
         AND nmcqcomp = g_nmbs_m.nmbscomp
         AND nmcqdocno = l_nmbt.nmbt002
         
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
             CALL anmt530_01_get_exrate(p_nmbtld,l_nmcqdocdt,l_ooam003,l_glaa016,l_glaa018)
             RETURNING l_nmbt.nmbt121
            #150707-00001#7--(s)
            IF l_glaa017 = '1' THEN
               LET l_nmbt.nmbt123 = l_nmbt.nmbt103 * l_nmbt.nmbt121
            ELSE
            #150707-00001#7--(e)
               LET l_nmbt.nmbt123 = l_nmbt.nmbt113 * l_nmbt.nmbt121
            END IF    #150707-00001#7
         END IF
          
         IF l_glaa019 = 'Y' THEN
            #主帳套本位幣二匯率
            IF l_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt.nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                       #帳套     #日期;       來源幣別   目的幣別; 匯類類型
            CALL anmt530_01_get_exrate(p_nmbtld,l_nmcqdocdt,l_ooam003,l_glaa020,l_glaa022)
            RETURNING l_nmbt.nmbt131
            #150707-00001#7--(s)
            IF l_glaa021 = '1' THEN 
               LET l_nmbt.nmbt133 = l_nmbt.nmbt103 * l_nmbt.nmbt131
            ELSE
            #150707-00001#7--(e)
               LET l_nmbt.nmbt133 = l_nmbt.nmbt113 * l_nmbt.nmbt131
            END IF   #150707-00001#7
         END IF
      END IF
       
      #平行賬套,金額匯率重新計算
      IF l_glaa014 <> 'Y' AND l_glaa008 = 'Y' THEN 
         LET l_nmbt.nmbt101 = 0
         LET l_nmbt.nmbt113 = 0
      
         CALL cl_get_para(g_enterprise,l_nmbt.nmbtcomp,'S-FIN-4004') RETURNING g_para_data  #資金模組匯率來源
         #平行賬套匯率
                                    #帳套     #日期;       來源幣別        目的幣別; 匯類類型
         CALL anmt530_01_get_exrate(p_nmbtld,l_nmcqdocdt,l_nmbt.nmbt100,l_glaa001,g_para_data)
         RETURNING l_nmbt.nmbt101
         LET l_nmbt.nmbt113 = l_nmbt.nmbt103 * l_nmbt.nmbt101
         
         IF l_glaa015 = 'Y' THEN
             #主帳套本位幣二匯率
             IF l_glaa017 = '1' THEN 
                LET l_ooam003 = l_nmbt.nmbt100
             ELSE
                LET l_ooam003 = l_glaa001
             END IF
                                        #帳套     #日期;       來源幣別   目的幣別; 匯類類型
             CALL anmt530_01_get_exrate(p_nmbtld,l_nmcqdocdt,l_ooam003,l_glaa016,l_glaa018)
             RETURNING l_nmbt.nmbt121
             #150707-00001#7--(s)
             IF l_glaa017 = '1' THEN 
                LET l_nmbt.nmbt123 = l_nmbt.nmbt103 * l_nmbt.nmbt121
             ELSE
             #150707-00001#7--(e)
               LET l_nmbt.nmbt123 = l_nmbt.nmbt113 * l_nmbt.nmbt121
             END IF   #150707-00001#7
         END IF
          
         IF l_glaa019 = 'Y' THEN
            #主帳套本位幣二匯率
            IF l_glaa021 = '1' THEN 
               LET l_ooam003 = l_nmbt.nmbt100
            ELSE
               LET l_ooam003 = l_glaa001
            END IF
                                       #帳套     #日期;       來源幣別   目的幣別; 匯類類型
            CALL anmt530_01_get_exrate(p_nmbtld,l_nmcqdocdt,l_ooam003,l_glaa020,l_glaa022)
            RETURNING l_nmbt.nmbt131   
            #150707-00001#7--(s)
            IF l_glaa021 = '1' THEN 
               LET l_nmbt.nmbt133 = l_nmbt.nmbt103 * l_nmbt.nmbt131
            ELSE
            #150707-00001#7--(e)
               LET l_nmbt.nmbt133 = l_nmbt.nmbt113 * l_nmbt.nmbt131
            END IF   #150707-00001#7     
         END IF
      END IF
      
      LET l_nmbt.nmbt029 = "" #150817
      LET l_nmbt.nmbt030 = "" #150817
      IF l_nmbt.nmbt001 = '1' THEN
        SELECT nmbb028 INTO l_nmbb028
          FROM nmbb_t
         WHERE nmbbent = g_enterprise
           AND nmbbcomp = g_nmbs_m.nmbscomp
           AND nmbbdocno = l_nmbt.nmbt002
           AND nmbb030 = l_nmbt.nmbt011   #150805apo
        SELECT DISTINCT glab005 INTO l_nmbt.nmbt029
          FROM glab_t
         WHERE glabent = g_enterprise #借方科目: 依 agli190 設定
           AND glabld  = p_nmbtld
           AND glab001 = '21'
           AND glab002 = '30'
           AND glab003 = l_nmbb028
        SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
          FROM glab_t
         WHERE glabent = g_enterprise
           AND glabld  = p_nmbtld
           AND glab001 = '41'
           AND glab002 = '8714'  # 應收票據 異動項
           AND glab003 = '1'     # 應收票據收票
      END IF
      IF l_nmbt.nmbt001 = '2' THEN
         SELECT nmcr003 INTO l_nmcr003
           FROM nmcr_t
          WHERE nmcrent = g_enterprise
            AND nmcrdocno = l_nmbt.nmbt002
            AND nmcrseq = l_nmbt.nmbt003
            AND nmcrcomp = g_nmbs_m.nmbscomp
         SELECT nmbb028 INTO l_nmbb028
           FROM nmbb_t
          WHERE nmbbent = g_enterprise
            AND nmbbcomp = g_nmbs_m.nmbscomp
            AND nmbbdocno = l_nmcr003
            AND nmbb030 = l_nmbt.nmbt011   #150805apo
         
         IF l_nmcq001 = '4'  THEN    #票貼
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt029
              FROM glab_t
             WHERE glabent = g_enterprise  #借方科目: 依 agli190 設定
               AND glabld  = p_nmbtld
               AND glab001 = '21'
               AND glab002 = '30'
               AND glab003 = l_nmbb028
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
            FROM glab_t
            WHERE glabent = g_enterprise
              AND glabld  = p_nmbtld
              AND glab001 = '41'
              AND glab002 = '8714'   # 應收票據 異動項
              AND glab003 = 'C'      # 應收票據貼現利息支出
         END IF
         IF l_nmcq001 = '6'  THEN    #撤票
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld  = p_nmbtld
               AND glab001 = '41'
               AND glab002 = '8714'   # 應收票據 異動項
              #AND glab003 = '5 '     # 應收票據收票 #150918-00001#5 mark
               AND glab003 = '5'      # 應收票據收票 #150918-00001#5
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt029
              FROM glab_t
             WHERE glabent = g_enterprise  #借方科目: 依 agli190 設定
               AND glabld  = p_nmbtld
               AND glab001 = '21'
               AND glab002 = '30'
               AND glab003 = l_nmbb028
         END IF
         
         IF l_nmcq001 = '7'  THEN    #跳票
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld  = p_nmbtld
               AND glab001 = '41'
               AND glab002 = '8714'   # 應收票據 異動項
              #AND glab003 = '7 '     # 應收票據跳票 #150918-00001#5 mark
               AND glab003 = '7'      # 應收票據跳票 #150918-00001#5
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt029
              FROM glab_t
             WHERE glabent = g_enterprise #借方科目: 依 agli190 設定
               AND glabld  = p_nmbtld
               AND glab001 = '21'
               AND glab002 = '30'
               AND glab003 = l_nmbb028
         END IF
         IF l_nmcq001 = '8'  THEN    #兌現
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt029
              FROM glab_t
             WHERE glabent = g_enterprise  #借方科目: 依 agli190 設定
               AND glabld  = p_nmbtld
               AND glab001 = '21'
               AND glab002 = '30'
               AND glab003 = l_nmbb028
            #150805apo-mark--s
            #SELECT DISTINCT glab005 INTO l_nmbt.nmbt030 FROM glab_t WHERE glabent = g_enterprise
            #                                                          AND glabld  = p_nmbtld
            #                                                          AND glab001 = '41'
            #                                                          AND glab002 = '8714'   # 應收票據 異動項
            #                                                          AND glab003 = 'D'     # 匯兌收入
            #150805apo-mark--e
            #150805apo--s
            #取anmi121
            SELECT DISTINCT glab005 INTO l_nmbt.nmbt030
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld  = p_nmbtld
               AND glab001 = '40'
               AND glab002 = '40'
               AND glab003 = l_nmbt.nmbt014
            #150805apo--e
         END IF
      END IF
      
      #161128-00061#2---modify----begin----------
      #INSERT INTO nmbt_t VALUES(l_nmbt.*)
      INSERT INTO nmbt_t (nmbtent,nmbtcomp,nmbtld,nmbtdocno,nmbtseq,nmbt001,nmbt002,nmbt003,nmbt011,
                          nmbt012,nmbt013,nmbt014,nmbt015,nmbt016,nmbt017,nmbt018,nmbt019,nmbt020,nmbt021,
                          nmbt022,nmbt023,nmbt024,nmbt025,nmbt026,nmbt027,nmbt028,nmbt029,nmbt030,nmbt031,
                          nmbt032,nmbt033,nmbt034,nmbt035,nmbt036,nmbt037,nmbt038,nmbt039,nmbt040,nmbt041,
                          nmbt042,nmbt043,nmbt100,nmbt101,nmbt103,nmbt113,nmbt121,nmbt123,nmbt131,nmbt133,
                          nmbt004,nmbt114)
       VALUES(l_nmbt.nmbtent,l_nmbt.nmbtcomp,l_nmbt.nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,l_nmbt.nmbt001,l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt011,
              l_nmbt.nmbt012,l_nmbt.nmbt013,l_nmbt.nmbt014,l_nmbt.nmbt015,l_nmbt.nmbt016,l_nmbt.nmbt017,l_nmbt.nmbt018,l_nmbt.nmbt019,l_nmbt.nmbt020,l_nmbt.nmbt021,
              l_nmbt.nmbt022,l_nmbt.nmbt023,l_nmbt.nmbt024,l_nmbt.nmbt025,l_nmbt.nmbt026,l_nmbt.nmbt027,l_nmbt.nmbt028,l_nmbt.nmbt029,l_nmbt.nmbt030,l_nmbt.nmbt031,
              l_nmbt.nmbt032,l_nmbt.nmbt033,l_nmbt.nmbt034,l_nmbt.nmbt035,l_nmbt.nmbt036,l_nmbt.nmbt037,l_nmbt.nmbt038,l_nmbt.nmbt039,l_nmbt.nmbt040,l_nmbt.nmbt041,
              l_nmbt.nmbt042,l_nmbt.nmbt043,l_nmbt.nmbt100,l_nmbt.nmbt101,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133,
              l_nmbt.nmbt004,l_nmbt.nmbt114)
      #161128-00061#2---modify----end----------
      
      IF SQLCA.SQLcode  THEN
         #CALL cl_errmsg("ins nmbt",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbt"
         LET g_errparam.popup = TRUE
         CALL cl_err()
        LET g_success = 'N'
      END IF
      IF l_nmcq001 = '4' OR l_nmcq001 = '8' THEN   #票貼 +兌現
         CALL anmt530_01_nmbv_ins(p_nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq,'2',l_nmbt.nmbt002,
                                  l_nmcq001,l_nmbt003,l_nmbt.nmbt103,l_nmbt.nmbt113,l_nmbt.nmbt121,
                                  l_nmbt.nmbt123,l_nmbt.nmbt131,l_nmbt.nmbt133)
      #150817 add ------
      ELSE
         #其他類型就寫一筆進來
         CALL anmt530_01_nmbv_ins_other(l_nmbt.nmbtcomp,p_nmbtld,l_nmbt.nmbtdocno,l_nmbt.nmbtseq) RETURNING l_success
      #150817 add end ---
      END IF
   END FOREACH
   #150707-00001#5--(s)
   #存在任何一筆單身成功寫入,應視為成功
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM nmbt_t 
    WHERE nmbtent = g_enterprise
      AND nmbtdocno = l_nmbt.nmbtdocno
      AND nmbtld = l_nmbt.nmbtld
   IF l_n > 0 THEN
      LET g_success = 'Y'
   END IF
   #150707-00001#5--(e)
END FUNCTION

# 抓取匯率
PRIVATE FUNCTION anmt530_01_get_exrate(p_ld,p_date,p_ooam003,p_ooan002,p_type)
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
PRIVATE FUNCTION anmt530_01_nmbv_ins(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt001,p_nmbt002,p_nmcq001,p_nmcrseq,p_nmbt103,p_nmbt113,p_nmbt121,p_nmbt123,p_nmbt131,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt001       LIKE nmbt_t.nmbt001
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmcq001       LIKE nmcq_t.nmcq001
   DEFINE p_nmcrseq       LIKE nmcr_t.nmcrseq
   DEFINE p_nmbt103       LIKE nmbt_t.nmbt103
   DEFINE p_nmbt113       LIKE nmbt_t.nmbt113
   DEFINE p_nmbt121       LIKE nmbt_t.nmbt121
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt131       LIKE nmbt_t.nmbt131
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   DEFINE l_success       LIKE type_t.num5

   LET l_success = TRUE
#   IF p_nmbt001 = '1' THEN   #收票
#      CALL anmt530_01_ins_nmbv_1(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133) RETURNING l_success
#   END IF
   
   IF p_nmbt001 = '2' THEN 
      IF p_nmcq001 = '4'  THEN    #票貼
         CALL anmt530_01_nmbv_ins_4(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt121,p_nmbt123,p_nmbt131,p_nmbt133) RETURNING l_success
      END IF
      
#      IF p_nmcq001 = '6'  THEN    #撤票
#         CALL anmt530_01_nmbv_ins_6(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt123,p_nmbt133) RETURNING l_success
#      END IF
      
#      IF p_nmcq001 = '7'  THEN    #跳票
#         CALL anmt530_01_nmbv_ins_7(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt123,p_nmbt133) RETURNING l_success
#      END IF
      
      IF p_nmcq001 = '8'  THEN    #兌現
         CALL anmt530_01_nmbv_ins_8(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt121,p_nmbt123,p_nmbt131,p_nmbt133) RETURNING l_success
      END IF
   END IF
   
   IF l_success = FALSE THEN 
      LET g_success = 'N'
   END IF
END FUNCTION
# 收票
PRIVATE FUNCTION anmt530_01_ins_nmbv_1(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmbt103,p_nmbt113,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
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
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借：應收票據    
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #借方科目: 依 agli190 設定 
   SELECT nmbb028 INTO l_nmbb028 
     FROM nmbb_t
    WHERE nmbbent = g_enterprise 
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002
   
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '21' 
      AND glab002 = '30'
      AND glab003 = l_nmbb028
      
   LET l_nmbv.nmbv103 = p_nmbt103                 #借方原幣金額
#   LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
   LET l_nmbv.nmbv113 = p_nmbt113                 #借方本幣金額
#   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
#   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
#   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
   
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success  
   END IF

   #貸：暫收款
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
   
   #貸方科目: 依 anmi152 設定
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t 
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '41'
      AND glab002 = '8714'  # 應收票據 異動項 
      AND glab003 = '1'     # 應收票據收票
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#   LET l_nmbv.nmbv104 = p_nmbt103                 #貸方原幣金額
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#   LET l_nmbv.nmbv114 = p_nmbt113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#   LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#  LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
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
# 票貼
PRIVATE FUNCTION anmt530_01_nmbv_ins_4(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt121,p_nmbt123,p_nmbt131,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmcrseq       LIKE nmcr_t.nmcrseq
   DEFINE p_nmbt121       LIKE nmbt_t.nmbt121
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt131       LIKE nmbt_t.nmbt131
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
   DEFINE l_nmcr103       LIKE nmcr_t.nmcr103
   DEFINE l_nmcr113       LIKE nmcr_t.nmcr113
   DEFINE l_nmcr104       LIKE nmcr_t.nmcr104
   DEFINE l_nmcr114       LIKE nmcr_t.nmcr114
   DEFINE l_nmcr105       LIKE nmcr_t.nmcr105
   DEFINE l_nmcr115       LIKE nmcr_t.nmcr115
   DEFINE l_nmcr106       LIKE nmcr_t.nmcr106
   DEFINE l_nmcr107       LIKE nmcr_t.nmcr107
   DEFINE l_nmcr116       LIKE nmcr_t.nmcr116
   DEFINE l_nmcr117       LIKE nmcr_t.nmcr117
   DEFINE l_nmcr118       LIKE nmcr_t.nmcr118
   DEFINE l_nmcr122       LIKE nmcr_t.nmcr122
   DEFINE l_nmcr132       LIKE nmcr_t.nmcr132
   DEFINE l_nmcq101       LIKE nmcq_t.nmcq101
   DEFINE l_nmcq100       LIKE nmcq_t.nmcq100  #150918-00001#5
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE l_glaa014       LIKE glaa_t.glaa014
   DEFINE l_glaa017       LIKE glaa_t.glaa017
   DEFINE l_glaa021       LIKE glaa_t.glaa021
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_success       LIKE type_t.num5
   #150807-00007#2---add---str--
   DEFINE l_sql           STRING
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_glaa004       LIKE glaa_t.glaa004
   DEFINE l_glbcseq1      LIKE glbc_t.glbcseq1
   DEFINE l_glbc004       LIKE glbc_t.glbc004
   DEFINE l_glbc008       LIKE glbc_t.glbc008
   DEFINE l_glbc009       LIKE glbc_t.glbc009
   DEFINE l_glbc012       LIKE glbc_t.glbc012
   DEFINE l_glbc014       LIKE glbc_t.glbc014
   #150807-00007#2---add---end--
   
   LET r_success = FALSE
   
   CALL s_ld_sel_glaa(p_nmbtld,'glaa014|glaa017|glaa021')
   RETURNING l_success,l_glaa014,l_glaa017,l_glaa021
   
   DELETE FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = p_nmbtld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmbb003,nmcr103,nmcr113,nmcr104,nmcr114,
          nmcr105,nmcr115,nmcr106,nmcr107,nmcr116,
          nmcr117,nmcr118,nmcr122,nmcr132,nmcq101,
          nmcq100    #150918-00001#5
     INTO l_nmbb003,l_nmcr103,l_nmcr113,l_nmcr104,l_nmcr114,
          l_nmcr105,l_nmcr115,l_nmcr106,l_nmcr107,l_nmcr116,
          l_nmcr117,l_nmcr118,l_nmcr122,l_nmcr132,l_nmcq101,
          l_nmcq100  #150918-00001#5
     FROM nmcr_t,nmcq_t,nmba_t,nmbb_t
    WHERE nmbaent = nmbbent
      AND nmbaent = nmcrent  #170112-00051#1 add
      AND nmbacomp = nmbbcomp
      AND nmbadocno = nmbbdocno
      AND nmcrent = nmcqent
      AND nmcrcomp = nmcqcomp
      AND nmcrdocno = nmcqdocno
      AND nmcr003 = nmbadocno   #150814apo
      AND nmcr001 = nmbb030
      AND nmcrent = g_enterprise
      AND nmcrcomp = g_nmbs_m.nmbscomp
      AND nmcrdocno = p_nmbt002 
      AND nmcrseq = p_nmcrseq
   IF cl_null(l_nmcr104) THEN LET l_nmcr104 = 0 END IF  #利息收入
   IF cl_null(l_nmcr105) THEN LET l_nmcr105 = 0 END IF  #貼現息
   IF cl_null(l_nmcr107) THEN LET l_nmcr107 = 0 END IF  #手續費
   IF cl_null(l_nmcr118) THEN LET l_nmcr118 = 0 END IF  #本幣匯差
   IF cl_null(l_nmcr122) THEN LET l_nmcr122 = 0 END IF  #本幣匯差二
   IF cl_null(l_nmcr132) THEN LET l_nmcr132 = 0 END IF  #本幣匯差三
   
   #150817 mark ------
   ##-150707-00001#4--(s)
   #IF l_nmcr105 <> 0 OR
   #   l_nmcr107 <> 0 OR
   #  (l_nmcr118 <> 0 OR l_nmcr122 <> 0 OR l_nmcr132 <> 0) OR
   #   l_nmcr104 <> 0 THEN   
   ##-150707-00001#4--(e)
   #150817 mark end---
   LET l_nmbv.nmbv017 = g_nmbt017   #150805apo
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   LET l_nmbv.nmbv100 = l_nmcq100  #150918-00001#5
   
   #借方
   #借：銀行存款
   #150807-00007#2---mark---str--
#   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
#     FROM nmbv_t
#    WHERE nmbvent = g_enterprise
#      AND nmbvld = l_nmbv.nmbvld
#      AND nmbvdocno = l_nmbv.nmbvdocno
#      AND nmbvseq = l_nmbv.nmbvseq
#    IF cl_null(l_nmbv.nmbvseq2) THEN 
#       LET l_nmbv.nmbvseq2 = 1
#    END IF
    #150807-00007#2---mark---end--
   
   #借方科目: 帳戶對應會科
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise 
      AND glabld  = p_nmbtld
      AND glab001 = '40'
      AND glab002 = '40'  
      AND glab003 = l_nmbb003  #託貼帳戶
      
   #150807-00007#2---mark---str--
#   LET l_nmbv.nmbv103 = l_nmcr106                 #借方原幣金額
##  LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
#   IF l_glaa014 = 'Y' THEN 
#      LET l_nmbv.nmbv113 = l_nmcr116              #借方本幣金額
#   ELSE
#      LET l_nmbv.nmbv113 = l_nmcr106 * l_nmcq101  #借方本幣金額
#   END IF
##   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
#   IF l_glaa017 = '1' THEN 
#      LET l_nmbv.nmbv123 = l_nmcr106 * p_nmbt121  #本位幣二借方金額
#   ELSE
#      LET l_nmbv.nmbv123 = l_nmcr116 * p_nmbt121  #本位幣二借方金額
#   END IF   
##   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
#   
#   IF l_glaa021 = '1' THEN 
#      LET l_nmbv.nmbv133 = l_nmcr106 * p_nmbt131  #本位幣三借方金額
#   ELSE
#      LET l_nmbv.nmbv133 = l_nmcr116 * p_nmbt131  #本位幣三借方金額
#   END IF
##   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
#      
#   
#   INSERT INTO nmbv_t VALUES(l_nmbv.*)
#   IF SQLCA.sqlcode THEN
#      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.SQLCODE
#      LET g_errparam.extend = "ins nmbv"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN r_success    
#   END IF
   #150807-00007#2---mark---end--
   #150807-00007#2---add---str--
   LET l_glaa004 = ''
   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_nmbtld      
   SELECT COUNT(*) INTO l_n FROM glac_t
    WHERE glacent = g_enterprise AND glac001 = l_glaa004
      AND glac002 = l_nmbv.nmbv001 AND glac016 = 'Y'
   IF l_n > 0 THEN
      LET l_sql = " SELECT glbcseq1,glbc004,glbc008,glbc009,glbc012,glbc014 FROM glbc_t",
                  "  WHERE glbcent = ",g_enterprise," AND glbcdocno = '",p_nmbt002,"'",
                  "    AND glbcseq = ",p_nmcrseq
      PREPARE glbc_prep FROM l_sql
      DECLARE glbc_curs CURSOR FOR glbc_prep
      FOREACH glbc_curs INTO l_glbcseq1,l_glbc004,l_glbc008,l_glbc009,l_glbc012,l_glbc014
         SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
           FROM nmbv_t
          WHERE nmbvent = g_enterprise
            AND nmbvld = l_nmbv.nmbvld
            AND nmbvdocno = l_nmbv.nmbvdocno
            AND nmbvseq = l_nmbv.nmbvseq
         IF cl_null(l_nmbv.nmbvseq2) THEN 
            LET l_nmbv.nmbvseq2 = 1
         END IF
         LET l_nmbv.nmbv103 = l_glbc008                #借方原幣金額
         LET l_nmbv.nmbv113 = l_glbc009                #借方本幣金額
         LET l_nmbv.nmbv123 = l_glbc012                #本位幣二借方金額
         LET l_nmbv.nmbv133 = l_glbc014                #本位幣三借方金額
         LET l_nmbv.nmbv042 = l_glbc004                #現金變動碼
         #161128-00061#2---modify----begin----------
         #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
         INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                             nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                             nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                             nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
          VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                 l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                 l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                 l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
         #161128-00061#2---modify----begin---------- 
         IF SQLCA.sqlcode THEN
            #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins nmbv"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success       
         END IF
      END FOREACH
   ELSE
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
        FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
       IF cl_null(l_nmbv.nmbvseq2) THEN 
          LET l_nmbv.nmbvseq2 = 1
       END IF
         
      LET l_nmbv.nmbv103 = l_nmcr106                 #借方原幣金額
#     LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
      IF l_glaa014 = 'Y' THEN 
         LET l_nmbv.nmbv113 = l_nmcr116              #借方本幣金額
      ELSE
         LET l_nmbv.nmbv113 = l_nmcr106 * l_nmcq101  #借方本幣金額
      END IF
#      LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
      IF l_glaa017 = '1' THEN 
         LET l_nmbv.nmbv123 = l_nmcr106 * p_nmbt121  #本位幣二借方金額
      ELSE
         LET l_nmbv.nmbv123 = l_nmcr116 * p_nmbt121  #本位幣二借方金額
      END IF   
#      LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
      
      IF l_glaa021 = '1' THEN 
         LET l_nmbv.nmbv133 = l_nmcr106 * p_nmbt131  #本位幣三借方金額
      ELSE
         LET l_nmbv.nmbv133 = l_nmcr116 * p_nmbt131  #本位幣三借方金額
      END IF
#      LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
         
      
      #161128-00061#2---modify----begin----------
      #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
      INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                          nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                          nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                          nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
       VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
              l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
              l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
              l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
      #161128-00061#2---modify----begin---------- 
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbv"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success    
      END IF
   END IF
   LET l_nmbv.nmbv042 = ''
   #150807-00007#2---add---end--
   
   
   #借:貼現利息支出
   IF l_nmcr105 <> 0 THEN
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
       FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
       IF cl_null(l_nmbv.nmbvseq2) THEN 
          LET l_nmbv.nmbvseq2 = 1
       END IF
   
       #借方科目: anmi152資金常用會科
       SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
         FROM glab_t 
        WHERE glabent = g_enterprise  
          AND glabld  = p_nmbtld
          AND glab001 = '41'
          AND glab002 = '8714'   # 應收票據 異動項 
          AND glab003 = 'C'      # 應收票據貼現利息支出
   
        LET l_nmbv.nmbv103 = l_nmcr105                 #借方原幣金額
     #   LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
        IF l_glaa014 = 'Y' THEN 
           LET l_nmbv.nmbv113 = l_nmcr115              #借方本幣金額
        ELSE
           LET l_nmbv.nmbv113 = l_nmcr105 * l_nmcq101  #借方本幣金額
        END IF
     #   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
        IF l_glaa017 = '1' THEN 
           LET l_nmbv.nmbv123 = l_nmcr105 * p_nmbt121  #本位幣二借方金額
        ELSE
           LET l_nmbv.nmbv123 = l_nmcr115 * p_nmbt121  #本位幣二借方金額
        END IF   
     #   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
        
        IF l_glaa021 = '1' THEN 
           LET l_nmbv.nmbv133 = l_nmcr105 * p_nmbt131  #本位幣三借方金額
        ELSE
           LET l_nmbv.nmbv133 = l_nmcr115 * p_nmbt131  #本位幣三借方金額
        END IF
     #   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
           
        
        #161128-00061#2---modify----begin----------
        #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
        INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                            nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                            nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                            nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
         VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
        #161128-00061#2---modify----begin---------- 
        IF SQLCA.sqlcode THEN
           #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = "ins nmbv"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           RETURN r_success    
        END IF
    END IF    
   
   #借:手續費
   IF l_nmcr107 <> 0 THEN
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
       FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
       IF cl_null(l_nmbv.nmbvseq2) THEN 
          LET l_nmbv.nmbvseq2 = 1
       END IF
   
       #借方科目: anmi152資金常用會科
       SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
         FROM glab_t 
        WHERE glabent = g_enterprise  
          AND glabld  = p_nmbtld
          AND glab001 = '41'
          AND glab002 = '8714'   # 應收票據 異動項 
          AND glab003 = 'A'      # 應收票手續費
   
        LET l_nmbv.nmbv103 = l_nmcr107                 #借方原幣金額 
        IF l_glaa014 = 'Y' THEN 
           LET l_nmbv.nmbv113 = l_nmcr117              #借方本幣金額
        ELSE
           LET l_nmbv.nmbv113 = l_nmcr107 * l_nmcq101  #借方本幣金額
        END IF
     #   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
        IF l_glaa017 = '1' THEN 
           LET l_nmbv.nmbv123 = l_nmcr107 * p_nmbt121  #本位幣二借方金額
        ELSE
           LET l_nmbv.nmbv123 = l_nmcr117 * p_nmbt121  #本位幣二借方金額
        END IF   
     #   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
        
        IF l_glaa021 = '1' THEN 
           LET l_nmbv.nmbv133 = l_nmcr107 * p_nmbt131  #本位幣三借方金額
        ELSE
           LET l_nmbv.nmbv133 = l_nmcr117 * p_nmbt131  #本位幣三借方金額
        END IF
     #   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
           
        
        #161128-00061#2---modify----begin----------
        #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
        INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                            nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                            nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                            nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
         VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
        #161128-00061#2---modify----begin---------- 
        IF SQLCA.sqlcode THEN
           #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = "ins nmbv"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           RETURN r_success
        END IF
   END IF
   
   #匯兌科目（不分正负）
   IF l_nmcr118 <> 0 OR l_nmcr122 <> 0 OR l_nmcr132 <> 0 THEN   #表示匯兌支出 , 在借方
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
        FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
      IF cl_null(l_nmbv.nmbvseq2) THEN
         LET l_nmbv.nmbvseq2 = 1
      END IF
      
      IF l_nmcr118 < 0 OR l_nmcr122 < 0 OR l_nmcr132 < 0 THEN
         SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
           FROM glab_t
          WHERE glabent  = g_enterprise
            AND  glabld  = p_nmbtld
            AND  glab001 = '41'
            AND  glab002 = '8714'   #應收票據 異動項
           #AND  glab003 = 'E '     #匯兌損失 #150918-00001#5 mark
            AND  glab003 = 'E'      #匯兌損失 #150918-00001#5
      ELSE
         SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
           FROM glab_t
          WHERE glabent  = g_enterprise
            AND  glabld  = p_nmbtld
            AND  glab001 = '41'
            AND  glab002 = '8714'   #應收票據 異動項 
            AND  glab003 = 'D'      #匯兌收入
      END IF
      
      LET l_nmbv.nmbv103 = 0               #借方原幣金額
     #LET l_nmbv.nmbv104 = 0               #貸方原幣金額
     #LET l_nmbv.nmbv113 = l_nmcr118       #借方本幣金額     #150918-00001#5 mark
      LET l_nmbv.nmbv113 = l_nmcr118 * -1  #借方本幣金額     #150918-00001#5
     #LET l_nmbv.nmbv114 = 0               #貸方本幣金額
     #LET l_nmbv.nmbv123 = l_nmcr122       #本位幣二借方金額 #150918-00001#5 mark
      LET l_nmbv.nmbv123 = l_nmcr122 * -1  #本位幣二借方金額 #150918-00001#5
     #LET l_nmbv.nmbv124 = 0               #本位幣二貸方金額
     #LET l_nmbv.nmbv133 = l_nmcr132       #本位幣三借方金額 #150918-00001#5 mark
      LET l_nmbv.nmbv133 = l_nmcr132 * -1  #本位幣三借方金額 #150918-00001#5
     #LET l_nmbv.nmbv134 = 0               #本位幣三貸方金額
      
      #150918-00001#5 add ------
      #抓取主帳套幣別
      SELECT glaa001 INTO l_nmbv.nmbv100
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = p_nmbtld
      #150918-00001#5 add end---
      #161128-00061#2---modify----begin----------
      #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
      INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                          nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                          nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                          nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
       VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
              l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
              l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
              l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
      #161128-00061#2---modify----begin---------- 
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbv"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   
   #貸方
   #貸：應收票據
#   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
#     FROM nmbv_t
#    WHERE nmbvent = g_enterprise
#      AND nmbvld = l_nmbv.nmbvld
#      AND nmbvdocno = l_nmbv.nmbvdocno
#      AND nmbvseq = l_nmbv.nmbvseq
#    IF cl_null(l_nmbv.nmbvseq2) THEN 
#       LET l_nmbv.nmbvseq2 = 1
#    END IF
#   
#   #貸方科目: agli191依款別設定
#   SELECT nmbb028 INTO l_nmbb028 
#     FROM nmbb_t
#    WHERE nmbbent = g_enterprise 
#      AND nmbbcomp = g_nmbs_m.nmbscomp
#      AND nmbbdocno = p_nmbt002
#   
#   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
#     FROM glab_t
#    WHERE glabent = g_enterprise
#      AND glabld  = p_nmbtld
#      AND glab001 = '42' 
#      AND glab002 = '30'
#      AND glab003 = l_nmbb028
      
#   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#   LET l_nmbv.nmbv104 = l_nmcr103                 #貸方原幣金額
#   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#   LET l_nmbv.nmbv114 = l_nmcr113                 #貸方本幣金額
#   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#   LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
#   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#   LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
#   INSERT INTO nmbv_t VALUES(l_nmbv.*)
#   IF SQLCA.sqlcode THEN
#      CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
#      RETURN r_success      
#   END IF
   
   #貸：利息收入  
   IF l_nmcr104 <> 0 THEN
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
       FROM nmbv_t
      WHERE nmbvent = g_enterprise
        AND nmbvld = l_nmbv.nmbvld
        AND nmbvdocno = l_nmbv.nmbvdocno
        AND nmbvseq = l_nmbv.nmbvseq
      IF cl_null(l_nmbv.nmbvseq2) THEN 
         LET l_nmbv.nmbvseq2 = 1
      END IF
   
     #貸方科目: anmi152資金常用會科
     SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
       FROM glab_t 
      WHERE glabent = g_enterprise
        AND glabld  = p_nmbtld
        AND glab001 = '41'
        AND glab002 = '8714'        # 應收票據 異動項 
        AND glab003 = 'B'           # 應收票據利息收入 
   
#   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#   LET l_nmbv.nmbv104 = l_nmcr104    #jingll             #貸方原幣金額
#   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#   IF l_glaa014 = 'Y' THEN  
#     LET l_nmbv.nmbv114 = l_nmcr114              #貸方本幣金額
#   ELSE
#      LET l_nmbv.nmbv114 = l_nmcr104 * l_nmcq101  #貸方本幣金額
#   END IF
   
#   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#   IF l_glaa017 = '1' THEN 
#      LET l_nmbv.nmbv124 = l_nmcr104 * p_nmbt121  #本位幣二貸方金額
#   ELSE
#      LET l_nmbv.nmbv124 = l_nmcr114 * p_nmbt121  #本位幣二貸方金額
#   END IF   
   
#   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#   IF l_glaa021 = '1' THEN 
#      LET l_nmbv.nmbv134 = l_nmcr104 * p_nmbt131  #本位幣三貸方金額
#   ELSE
#      LET l_nmbv.nmbv134 = l_nmcr114 * p_nmbt131  #本位幣三貸方金額
#   END IF
     LET l_nmbv.nmbv103 =  -1 * l_nmcr104
     IF l_glaa014 = 'Y' THEN  
        LET l_nmbv.nmbv113 =  -1 * l_nmcr114              #貸方本幣金額
     ELSE
        LET l_nmbv.nmbv113 = -1 * (l_nmcr104 * l_nmcq101)        #貸方本幣金額
     END IF
    
     IF l_glaa017 = '1' THEN 
       LET l_nmbv.nmbv123 = -1 * (l_nmcr104 * p_nmbt121)  #本位幣二貸方金額
    ELSE
       LET l_nmbv.nmbv123 = -1 * (l_nmcr114 * p_nmbt121)  #本位幣二貸方金額
    END IF   
   
    IF l_glaa021 = '1' THEN 
       LET l_nmbv.nmbv133 = -1 * (l_nmcr104 * p_nmbt131)  #本位幣三貸方金額
    ELSE
       LET l_nmbv.nmbv133 = -1 * (l_nmcr114 * p_nmbt131)  #本位幣三貸方金額
    END IF 
   
    #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
    IF SQLCA.sqlcode THEN
       #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.SQLCODE
       LET g_errparam.extend = "ins nmbv"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN r_success      
    END IF
  END IF  
   #匯兌科目
# IF l_nmcr118 > 0 THEN   #表示匯兌收入 , 在貸方   
#    SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
#      FROM nmbv_t
#     WHERE nmbvent = g_enterprise
#       AND nmbvld = l_nmbv.nmbvld
#       AND nmbvdocno = l_nmbv.nmbvdocno
#       AND nmbvseq = l_nmbv.nmbvseq
#    IF cl_null(l_nmbv.nmbvseq2) THEN 
#       LET l_nmbv.nmbvseq2 = 1
#    END IF
#    
#    SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
#      FROM glab_t 
#     WHERE glabent = g_enterprise
#      AND  glabld  = p_nmbtld
#      AND  glab001 = '41'
#      AND  glab002 = '8714'   # 應收票據 異動項 
#      AND  glab003 = 'D '     # 匯兌收入 
#      
#     LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#     LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
#     LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#     LET l_nmbv.nmbv114 = l_nmcr118                 #貸方本幣金額
#     LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#     LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
#     LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#     LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
#     LET l_nmbv.nmbv103 = 0  
#     LET l_nmbv.nmbv113 = -1 * (l_nmcr118)
#     LET l_nmbv.nmbv123 = 0
#     LET l_nmbv.nmbv133 = 0        
#    INSERT INTO nmbv_t VALUES(l_nmbv.*)
#    IF SQLCA.sqlcode THEN
#       CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
#       RETURN r_success        
#    END IF
# END IF
   #END IF   #-150707-00001#4 #150817 mark
   
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 撤票
PRIVATE FUNCTION anmt530_01_nmbv_ins_6(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmcrseq       LIKE nmcr_t.nmcrseq
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   DEFINE l_nmcr103       LIKE nmcr_t.nmcr103
   DEFINE l_nmcr113       LIKE nmcr_t.nmcr113
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
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmcr103,nmcr113
     INTO l_nmcr103,l_nmcr113
     FROM nmcr_t,nmcq_t,nmba_t,nmbb_t
    WHERE nmbaent = nmbbent
      AND nmbaent = nmcrent  #170112-00051#1 add
      AND nmbacomp = nmbbcomp
      AND nmbadocno = nmbbdocno
      AND nmcrent = nmcqent
      AND nmcrcomp = nmcqcomp
      AND nmcrdocno = nmcqdocno
      AND nmcr001 = nmbb030
      AND nmcr003 = nmbadocno   #150814apo
      AND nmcrent = g_enterprise
      AND nmcrcomp = g_nmbs_m.nmbscomp
      AND nmcrdocno = p_nmbt002 
      AND nmcrseq = p_nmcrseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方:
   #借：銀行存款
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
    
   #借方科目:anmi152資金常用會科           
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t 
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '41'
      AND glab002 = '8714'   # 應收票據 異動項
     #AND glab003 = '5 '     # 應收票據收票 #150918-00001#5 mark
      AND glab003 = '5'      # 應收票據收票 #150918-00001#5
       
   LET l_nmbv.nmbv103 = l_nmcr103                 #借方原幣金額
#   LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
   LET l_nmbv.nmbv113 = l_nmcr113                 #借方本幣金額
#   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
#   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
#   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success      
   END IF
   
   #貸方:
   #貸：應收票據
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
    
   #貸方科目:agli190依款別設定
   SELECT nmbb028 INTO l_nmbb028 
     FROM nmbb_t
    WHERE nmbbent = g_enterprise 
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002
   
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '21' 
      AND glab002 = '30'
      AND glab003 = l_nmbb028 
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#   LET l_nmbv.nmbv104 = l_nmcr103                 #貸方原幣金額
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#   LET l_nmbv.nmbv114 = l_nmcr113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#   LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#   LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
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
# 跳票
PRIVATE FUNCTION anmt530_01_nmbv_ins_7(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt123,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmcrseq       LIKE nmcr_t.nmcrseq
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt133       LIKE nmbt_t.nmbt133
   DEFINE l_nmcr103       LIKE nmcr_t.nmcr103
   DEFINE l_nmcr113       LIKE nmcr_t.nmcr113
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
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld 
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   SELECT nmcr103,nmcr113
     INTO l_nmcr103,l_nmcr113
     FROM nmcr_t,nmcq_t,nmba_t,nmbb_t
    WHERE nmbaent = nmbbent
      AND nmbaent = nmcrent  #170112-00051#1 add
      AND nmbacomp = nmbbcomp
      AND nmbadocno = nmbbdocno
      AND nmcrent = nmcqent
      AND nmcrcomp = nmcqcomp
      AND nmcrdocno = nmcqdocno
      AND nmcr003 = nmbadocno   #150814apo
      AND nmcr001 = nmbb030
      AND nmcrent = g_enterprise
      AND nmcrcomp = g_nmbs_m.nmbscomp
      AND nmcrdocno = p_nmbt002 
      AND nmcrseq = p_nmcrseq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
   LET l_nmbv.nmbvld = p_nmbtld
   LET l_nmbv.nmbvdocno = p_nmbtdocno
   LET l_nmbv.nmbvseq = p_nmbtseq
   
   #借方:
   #借：銀行存款
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
    
   #借方科目:anmi152資金常用會科           
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t 
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '41'
      AND glab002 = '8714'   # 應收票據 異動項
     #AND glab003 = '7 '     # 應收票據跳票 #150918-00001#5 mark
      AND glab003 = '7'      # 應收票據跳票 #150918-00001#5
       
   LET l_nmbv.nmbv103 = l_nmcr103                 #借方原幣金額
#   LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
   LET l_nmbv.nmbv113 = l_nmcr113                 #借方本幣金額
#   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
   LET l_nmbv.nmbv123 = p_nmbt123                 #本位幣二借方金額
#   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
   LET l_nmbv.nmbv133 = p_nmbt133                 #本位幣三借方金額
#   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
   IF SQLCA.sqlcode THEN
      #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins nmbv"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success      
   END IF
   
   #貸方:
   #貸：應收票據
   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
     FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = l_nmbv.nmbvld
      AND nmbvdocno = l_nmbv.nmbvdocno
      AND nmbvseq = l_nmbv.nmbvseq
    IF cl_null(l_nmbv.nmbvseq2) THEN 
       LET l_nmbv.nmbvseq2 = 1
    END IF
    
   #貸方科目:agli190依款別設定
   SELECT nmbb028 INTO l_nmbb028 
     FROM nmbb_t
    WHERE nmbbent = g_enterprise 
      AND nmbbcomp = g_nmbs_m.nmbscomp
      AND nmbbdocno = p_nmbt002
   
   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
     FROM glab_t 
    WHERE glabent = g_enterprise
      AND glabld  = p_nmbtld
      AND glab001 = '21' 
      AND glab002 = '30'
      AND glab003 = l_nmbb028 
      
   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#   LET l_nmbv.nmbv104 = l_nmcr103                 #貸方原幣金額
   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#   LET l_nmbv.nmbv114 = l_nmcr113                 #貸方本幣金額
   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#   LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#   LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
   INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                       nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                       nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                       nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
    VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
           l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
           l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
           l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
   #161128-00061#2---modify----begin---------- 
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
# 兌現
PRIVATE FUNCTION anmt530_01_nmbv_ins_8(p_nmbtld,p_nmbtdocno,p_nmbtseq,p_nmbt002,p_nmcrseq,p_nmbt121,p_nmbt123,p_nmbt131,p_nmbt133)
   DEFINE p_nmbtld        LIKE nmbt_t.nmbtld
   DEFINE p_nmbtdocno     LIKE nmbt_t.nmbtdocno
   DEFINE p_nmbtseq       LIKE nmbt_t.nmbtseq
   DEFINE p_nmbt002       LIKE nmbt_t.nmbt002
   DEFINE p_nmcrseq       LIKE nmcr_t.nmcrseq
   DEFINE p_nmbt121       LIKE nmbt_t.nmbt121
   DEFINE p_nmbt123       LIKE nmbt_t.nmbt123
   DEFINE p_nmbt131       LIKE nmbt_t.nmbt131
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
   DEFINE l_nmcr103       LIKE nmcr_t.nmcr103
   DEFINE l_nmcr113       LIKE nmcr_t.nmcr113
   DEFINE l_nmcr104       LIKE nmcr_t.nmcr104
   DEFINE l_nmcr114       LIKE nmcr_t.nmcr114
   DEFINE l_nmcr105       LIKE nmcr_t.nmcr105
   DEFINE l_nmcr115       LIKE nmcr_t.nmcr115
   DEFINE l_nmcr106       LIKE nmcr_t.nmcr106
   DEFINE l_nmcr107       LIKE nmcr_t.nmcr107  #原幣手續費用
   DEFINE l_nmcr116       LIKE nmcr_t.nmcr116
   DEFINE l_nmcr117       LIKE nmcr_t.nmcr117  #本幣手續費用
   DEFINE l_nmcr118       LIKE nmcr_t.nmcr118
   DEFINE l_nmcr122       LIKE nmcr_t.nmcr122
   DEFINE l_nmcr132       LIKE nmcr_t.nmcr132
   DEFINE l_nmcq100       LIKE nmcq_t.nmcq100  #150803-00018#1
   DEFINE l_nmcq101       LIKE nmcq_t.nmcq101
   DEFINE l_nmbb003       LIKE nmbb_t.nmbb003
   DEFINE l_nmbb028       LIKE nmbb_t.nmbb028
   DEFINE l_glaa001       LIKE glaa_t.glaa001  #150803-00018#1
   DEFINE l_glaa014       LIKE glaa_t.glaa014
   DEFINE l_glaa017       LIKE glaa_t.glaa017
   DEFINE l_glaa021       LIKE glaa_t.glaa021
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_success       LIKE type_t.num5
   #150807-00007#2---add---str--
   DEFINE l_sql           STRING
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_glaa004       LIKE glaa_t.glaa004
   DEFINE l_glbcseq1      LIKE glbc_t.glbcseq1 
   DEFINE l_glbc004       LIKE glbc_t.glbc004
   DEFINE l_glbc008       LIKE glbc_t.glbc008
   DEFINE l_glbc009       LIKE glbc_t.glbc009
   DEFINE l_glbc012       LIKE glbc_t.glbc012
   DEFINE l_glbc014       LIKE glbc_t.glbc014
   #150807-00007#2---add---end--
   
   LET r_success = FALSE
   
   #150803-00018#1 add glaa001
   CALL s_ld_sel_glaa(p_nmbtld,'glaa001|glaa014|glaa017|glaa021')
        RETURNING l_success,l_glaa001,l_glaa014,l_glaa017,l_glaa021
   
   DELETE FROM nmbv_t 
    WHERE nmbvent = g_enterprise 
      AND nmbvld = p_nmbtld
      AND nmbvdocno = p_nmbtdocno
      AND nmbvseq = p_nmbtseq
   
   #150803-00018#1 add nmcq100
   SELECT nmbb003,nmbb028,nmcr103,nmcr113,nmcr104,
          nmcr114,nmcr105,nmcr115,nmcr106,nmcr107,
          nmcr116,nmcr117,nmcr118,nmcr122,nmcr132,
          nmcq100,nmcq101
     INTO l_nmbb003,l_nmbb028,l_nmcr103,l_nmcr113,l_nmcr104,
          l_nmcr114,l_nmcr105,l_nmcr115,l_nmcr106,l_nmcr107,
          l_nmcr116,l_nmcr117,l_nmcr118,l_nmcr122,l_nmcr132,
          l_nmcq100,l_nmcq101
     FROM nmcr_t,nmcq_t,nmba_t,nmbb_t
    WHERE nmbaent = nmbbent
      AND nmbaent = nmcrent  #170112-00051#1 add
      AND nmbacomp = nmbbcomp
      AND nmbadocno = nmbbdocno
      AND nmcrent = nmcqent
      AND nmcrcomp = nmcqcomp
      AND nmcrdocno = nmcqdocno
      AND nmcr003 = nmbadocno   #150814apo
      AND nmcr001 = nmbb030
      AND nmcrent = g_enterprise
      AND nmcrcomp = g_nmbs_m.nmbscomp
      AND nmcrdocno = p_nmbt002
      AND nmcrseq = p_nmcrseq
   IF cl_null(l_nmcr103) THEN LET l_nmcr103 = 0 END IF
   IF cl_null(l_nmcr104) THEN LET l_nmcr104 = 0 END IF
   IF cl_null(l_nmcr105) THEN LET l_nmcr105 = 0 END IF
   IF cl_null(l_nmcr113) THEN LET l_nmcr113 = 0 END IF
   IF cl_null(l_nmcr114) THEN LET l_nmcr114 = 0 END IF
   IF cl_null(l_nmcr107) THEN LET l_nmcr107 = 0 END IF
   IF cl_null(l_nmcr117) THEN LET l_nmcr117 = 0 END IF
   IF cl_null(l_nmcr118) THEN LET l_nmcr118 = 0 END IF #150918-00001#5
   IF cl_null(l_nmcr122) THEN LET l_nmcr122 = 0 END IF
   IF cl_null(l_nmcr132) THEN LET l_nmcr132 = 0 END IF
   
   #150817 mark ------
   ##-150707-00001#4--(s)
   #IF l_nmcr105 <> 0 OR l_nmcr107 <> 0 OR
   #  (l_nmcr118 <> 0 OR l_nmcr122 <> 0 OR l_nmcr132 <> 0) OR l_nmcr104 <> 0 THEN   
   ##-150707-00001#4--(e)
   #150817 mark end---   
      LET l_nmbv.nmbv017 = g_nmbt017   #150805apo
      LET l_nmbv.nmbvent = g_enterprise
      LET l_nmbv.nmbvcomp = g_nmbs_m.nmbscomp
      LET l_nmbv.nmbvld = p_nmbtld
      LET l_nmbv.nmbvdocno = p_nmbtdocno
      LET l_nmbv.nmbvseq = p_nmbtseq
      LET l_nmbv.nmbv100 = l_nmcq100  #150918-00001#5

      #借方
      #借：銀行存款
      #150807-00007#2---mark---str--
#      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
#        FROM nmbv_t
#       WHERE nmbvent = g_enterprise
#         AND nmbvld = l_nmbv.nmbvld
#         AND nmbvdocno = l_nmbv.nmbvdocno
#         AND nmbvseq = l_nmbv.nmbvseq
#      IF cl_null(l_nmbv.nmbvseq2) THEN 
#         LET l_nmbv.nmbvseq2 = 1
#      END IF
      #150807-00007#2---mark---end--
   
      #借方科目: anmi121帳戶會科
      SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
        FROM glab_t
       WHERE glabent = g_enterprise 
         AND glabld  = p_nmbtld
         AND glab001 = '40'
         AND glab002 = '40'
         AND glab003 = l_nmbb003  #託貼帳戶
   
      #   LET l_nmbv.nmbv103 = l_nmcr103 + l_nmcr104     #借方原幣金額   
      #   LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
      #150807-00007#2---mark---str--
#      LET l_nmbv.nmbv103 = l_nmcr103 + l_nmcr104 -l_nmcr107      #借方原幣金額(扣掉費用) 
#      IF l_glaa014 = 'Y' THEN 
#         LET l_nmbv.nmbv113 = l_nmcr113 + l_nmcr114 - l_nmcr117  #借方本幣金額(扣掉費用) 
#      ELSE
#         LET l_nmbv.nmbv113 = (l_nmcr103 + l_nmcr104 - l_nmcr107) * l_nmcq101  #借方本幣金額(扣掉費用)
#      END IF
#      #   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
#      IF l_glaa017 = '1' THEN 
#         LET l_nmbv.nmbv123 = (l_nmcr103 + l_nmcr104 - l_nmcr107) * p_nmbt121  #本位幣二借方金額(扣掉費用)
#      ELSE
#         LET l_nmbv.nmbv123 = (l_nmcr113 + l_nmcr114 - l_nmcr117) * p_nmbt121  #本位幣二借方金額(扣掉費用)
#      END IF   
#      #   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
#      
#      IF l_glaa021 = '1' THEN 
#         LET l_nmbv.nmbv133 = (l_nmcr103 + l_nmcr104 - l_nmcr107) * p_nmbt131  #本位幣三借方金額(扣掉費用)
#      ELSE
#         LET l_nmbv.nmbv133 = (l_nmcr113 + l_nmcr114 - l_nmcr117) * p_nmbt131  #本位幣三借方金額(扣掉費用)
#      END IF
#      #   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
#   
#      INSERT INTO nmbv_t VALUES(l_nmbv.*)
#      IF SQLCA.sqlcode THEN
#         #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.SQLCODE
#         LET g_errparam.extend = "ins nmbv"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         RETURN r_success
#      END IF
      #150807-00007#2---mark---end--
      #150807-00007#2---add---str--
      LET l_glaa004 = ''
      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_nmbtld      
      SELECT COUNT(*) INTO l_n FROM glac_t
       WHERE glacent = g_enterprise AND glac001 = l_glaa004
         AND glac002 = l_nmbv.nmbv001 AND glac016 = 'Y'
      IF l_n > 0 THEN
         LET l_sql = " SELECT glbcseq1,glbc004,glbc008,glbc009,glbc012,glbc014 FROM glbc_t",
                     "  WHERE glbcent = ",g_enterprise," AND glbcdocno = '",p_nmbt002,"'",
                     "    AND glbcseq = ",p_nmcrseq
         PREPARE glbc_prep1 FROM l_sql
         DECLARE glbc_curs1 CURSOR FOR glbc_prep1
         FOREACH glbc_curs1 INTO l_glbcseq1,l_glbc004,l_glbc008,l_glbc009,l_glbc012,l_glbc014
            SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
              FROM nmbv_t
             WHERE nmbvent = g_enterprise
               AND nmbvld = l_nmbv.nmbvld
               AND nmbvdocno = l_nmbv.nmbvdocno
               AND nmbvseq = l_nmbv.nmbvseq
            IF cl_null(l_nmbv.nmbvseq2) THEN 
               LET l_nmbv.nmbvseq2 = 1
            END IF
            LET l_nmbv.nmbv103 = l_glbc008                #借方原幣金額
            LET l_nmbv.nmbv113 = l_glbc009                #借方本幣金額
            LET l_nmbv.nmbv123 = l_glbc012                #本位幣二借方金額
            LET l_nmbv.nmbv133 = l_glbc014                #本位幣三借方金額
            LET l_nmbv.nmbv042 = l_glbc004                #現金變動碼
            #161128-00061#2---modify----begin----------
            #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
            INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                                nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                                nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                                nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
             VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                    l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                    l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                    l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
            #161128-00061#2---modify----begin---------- 
            IF SQLCA.sqlcode THEN
               #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = "ins nmbv"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN r_success       
            END IF
         END FOREACH
      ELSE
         SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
           FROM nmbv_t
          WHERE nmbvent = g_enterprise
            AND nmbvld = l_nmbv.nmbvld
            AND nmbvdocno = l_nmbv.nmbvdocno
            AND nmbvseq = l_nmbv.nmbvseq
         IF cl_null(l_nmbv.nmbvseq2) THEN 
            LET l_nmbv.nmbvseq2 = 1
         END IF
         
         LET l_nmbv.nmbv103 = l_nmcr103 + l_nmcr104 -l_nmcr107      #借方原幣金額(扣掉費用) 
         IF l_glaa014 = 'Y' THEN 
            LET l_nmbv.nmbv113 = l_nmcr113 + l_nmcr114 - l_nmcr117  #借方本幣金額(扣掉費用) 
         ELSE
            LET l_nmbv.nmbv113 = (l_nmcr103 + l_nmcr104 - l_nmcr107) * l_nmcq101  #借方本幣金額(扣掉費用)
         END IF
         #   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
         IF l_glaa017 = '1' THEN 
            LET l_nmbv.nmbv123 = (l_nmcr103 + l_nmcr104 - l_nmcr107) * p_nmbt121  #本位幣二借方金額(扣掉費用)
         ELSE
            LET l_nmbv.nmbv123 = (l_nmcr113 + l_nmcr114 - l_nmcr117) * p_nmbt121  #本位幣二借方金額(扣掉費用)
         END IF   
         #   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
         
         IF l_glaa021 = '1' THEN 
            LET l_nmbv.nmbv133 = (l_nmcr103 + l_nmcr104 - l_nmcr107) * p_nmbt131  #本位幣三借方金額(扣掉費用)
         ELSE
            LET l_nmbv.nmbv133 = (l_nmcr113 + l_nmcr114 - l_nmcr117) * p_nmbt131  #本位幣三借方金額(扣掉費用)
         END IF
         #   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
         #161128-00061#2---modify----begin----------
         #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
         INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                             nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                             nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                             nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
          VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                 l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                 l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                 l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
         #161128-00061#2---modify----begin---------- 
         IF SQLCA.sqlcode THEN
            #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins nmbv"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      LET l_nmbv.nmbv042 = ''
      #150807-00007#2---add---end--
   
      #借贴现息
      IF l_nmcr105 <> 0 THEN
         SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
          FROM nmbv_t
         WHERE nmbvent = g_enterprise
           AND nmbvld = l_nmbv.nmbvld
           AND nmbvdocno = l_nmbv.nmbvdocno
           AND nmbvseq = l_nmbv.nmbvseq
         IF cl_null(l_nmbv.nmbvseq2) THEN
            LET l_nmbv.nmbvseq2 = 1
         END IF
   
         #借方科目: anmi152資金常用會科
         SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
           FROM glab_t 
          WHERE glabent = g_enterprise
            AND glabld  = p_nmbtld
            AND glab001 = '41'
            AND glab002 = '8714'   # 應收票據 異動項
            AND glab003 = 'C'      # 應收票據貼現利息支出
   
        LET l_nmbv.nmbv103 = l_nmcr105                 #借方原幣金額
     #   LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
        IF l_glaa014 = 'Y' THEN 
           LET l_nmbv.nmbv113 = l_nmcr115              #借方本幣金額
        ELSE
           LET l_nmbv.nmbv113 = l_nmcr105 * l_nmcq101  #借方本幣金額
        END IF
     #   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
        IF l_glaa017 = '1' THEN 
           LET l_nmbv.nmbv123 = l_nmcr105 * p_nmbt121  #本位幣二借方金額
        ELSE
           LET l_nmbv.nmbv123 = l_nmcr115 * p_nmbt121  #本位幣二借方金額
        END IF   
     #   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
        
        IF l_glaa021 = '1' THEN 
           LET l_nmbv.nmbv133 = l_nmcr105 * p_nmbt131  #本位幣三借方金額
        ELSE
           LET l_nmbv.nmbv133 = l_nmcr115 * p_nmbt131  #本位幣三借方金額
        END IF
     #   LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
           
        
        #161128-00061#2---modify----begin----------
        #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
        INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                            nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                            nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                            nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
         VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
        #161128-00061#2---modify----begin---------- 
        IF SQLCA.sqlcode THEN
           #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = "ins nmbv"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           RETURN r_success    
        END IF
    END IF 
    
    
    IF l_nmcr107 <> 0 THEN
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
        FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
      IF cl_null(l_nmbv.nmbvseq2) THEN
         LET l_nmbv.nmbvseq2 = 1
      END IF
      
      SELECT glab005 INTO l_nmbv.nmbv001 
        FROM glab_t 
       WHERE glabent = g_enterprise
        AND  glabld  = g_nmbs_m.nmbsld
        AND  glab001 = '41'
        AND  glab002 = '8714'   # 應收票據 異動項 
       #AND  glab003 = 'A '     # 應收票據手續費 #150918-00001#5 mark
        AND  glab003 = 'A'      # 應收票據手續費 #150918-00001#5
        
     LET l_nmbv.nmbv103 = l_nmcr107                 #借方原幣金額 
     IF l_glaa014 = 'Y' THEN 
        LET l_nmbv.nmbv113 = l_nmcr117              #借方本幣金額
     ELSE
        LET l_nmbv.nmbv113 = l_nmcr107 * l_nmcq101  #借方本幣金額
     END IF
  #   LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
     IF l_glaa017 = '1' THEN 
        LET l_nmbv.nmbv123 = l_nmcr107 * p_nmbt121  #本位幣二借方金額
     ELSE
        LET l_nmbv.nmbv123 = l_nmcr117 * p_nmbt121  #本位幣二借方金額
     END IF   
  #   LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
     
     IF l_glaa021 = '1' THEN 
        LET l_nmbv.nmbv133 = l_nmcr107 * p_nmbt131  #本位幣三借方金額
     ELSE
        LET l_nmbv.nmbv133 = l_nmcr117 * p_nmbt131  #本位幣三借方金額
     END IF
    #161128-00061#2---modify----begin----------
    #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
    INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                        nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                        nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                        nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
     VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
            l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
            l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
            l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
    #161128-00061#2---modify----begin---------- 
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'ins nmbv'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        RETURN r_success       
     END IF
   END IF      
    
   #匯兌科目
  #IF l_nmcr118 <> 0 OR l_nmcr122 <> 0 OR l_nmcr132 <> 0 THEN #表示匯兌支出 , 在借方 #150803-00018#1 mark
   IF l_glaa001 <> l_nmcq100 AND (l_nmcr118 <> 0 OR l_nmcr122 <> 0 OR l_nmcr132 <> 0) THEN #150803-00018#1
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
        FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
      IF cl_null(l_nmbv.nmbvseq2) THEN
         LET l_nmbv.nmbvseq2 = 1
      END IF
      
      IF l_nmcr118 < 0 OR l_nmcr122 < 0 OR l_nmcr132 < 0 THEN
         SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld  = p_nmbtld
            AND glab001 = '41'
            AND glab002 = '8714'   # 應收票據 異動項
           #AND glab003 = 'E '     # 匯兌損失 #150918-00001#5 mark
            AND glab003 = 'E'      # 匯兌損失 #150918-00001#5
      ELSE
         SELECT DISTINCT glab005 INTO l_nmbv.nmbv001
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld  = p_nmbtld
            AND glab001 = '41'
            AND glab002 = '8714'   # 應收票據 異動項
            AND glab003 = 'D'      # 匯兌收入
      END IF
      
      LET l_nmbv.nmbv103 = 0                         #借方原幣金額
     #LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
     #LET l_nmbv.nmbv113 = l_nmcr118                 #借方本幣金額     #150918-00001#5 mark
      LET l_nmbv.nmbv113 = l_nmcr118 * -1            #借方本幣金額     #150918-00001#5
     #LET l_nmbv.nmbv114 = 0                         #貸方本幣金額
     #LET l_nmbv.nmbv123 = l_nmcr122                 #本位幣二借方金額 #150918-00001#5 mark
      LET l_nmbv.nmbv123 = l_nmcr122 * -1            #本位幣二借方金額 #150918-00001#5
     #LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
     #LET l_nmbv.nmbv133 = l_nmcr132                 #本位幣三借方金額 #150918-00001#5 mark
      LET l_nmbv.nmbv133 = l_nmcr132 * -1            #本位幣三借方金額 #150918-00001#5
     #LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
      
      #150918-00001#5 add ------
      #抓取主帳套幣別
      SELECT glaa001 INTO l_nmbv.nmbv100
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = p_nmbtld
      #150918-00001#5 add end---
      
      #161128-00061#2---modify----begin----------
      #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
      INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                          nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                          nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                          nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
       VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
              l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
              l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
              l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
      #161128-00061#2---modify----begin---------- 
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbv"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   #貸方:
   #貸：應收票據 
#   SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
#     FROM nmbv_t
#    WHERE nmbvent = g_enterprise
#      AND nmbvld = l_nmbv.nmbvld
#      AND nmbvdocno = l_nmbv.nmbvdocno
#      AND nmbvseq = l_nmbv.nmbvseq
#    IF cl_null(l_nmbv.nmbvseq2) THEN 
#       LET l_nmbv.nmbvseq2 = 1
#    END IF
 
#   #貸方科目: agli191依款別設定
#   SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
#     FROM glab_t
#    WHERE glabent = g_enterprise
#      AND glabld  = p_nmbtld
#      AND glab001 = '42' 
#      AND glab002 = '30'
#      AND glab003 = l_nmbb028
   
#   LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#   LET l_nmbv.nmbv104 = l_nmcr103                 #貸方原幣金額
#   LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#   LET l_nmbv.nmbv114 = l_nmcr113                 #貸方本幣金額
#   LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#   LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
#   LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#   LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
#  
#   INSERT INTO nmbv_t VALUES(l_nmbv.*)
#   IF SQLCA.sqlcode THEN
#      CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
#      RETURN r_success    
#   END IF
   #應收票據手續費
   
   IF l_nmcr104 <> 0 THEN  #表示有利息收入  
      SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
        FROM nmbv_t
       WHERE nmbvent = g_enterprise
         AND nmbvld = l_nmbv.nmbvld
         AND nmbvdocno = l_nmbv.nmbvdocno
         AND nmbvseq = l_nmbv.nmbvseq
      IF cl_null(l_nmbv.nmbvseq2) THEN 
         LET l_nmbv.nmbvseq2 = 1
      END IF
      
      SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
        FROM glab_t 
       WHERE glabent = g_enterprise
         AND glabld  = p_nmbtld
         AND glab001 = '41'
         AND glab002 = '8714'   # 應收票據 異動項 
         AND glab003 = 'B'      # 匯兌損失
                       
#      LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#      LET l_nmbv.nmbv104 = l_nmcr103                 #貸方原幣金額
#      LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#      LET l_nmbv.nmbv114 = l_nmcr113                 #貸方本幣金額
#      LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#      LET l_nmbv.nmbv124 = p_nmbt123                 #本位幣二貸方金額
#      LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#      LET l_nmbv.nmbv134 = p_nmbt133                 #本位幣三貸方金額
       LET l_nmbv.nmbv103 =  -1 * l_nmcr104
      IF l_glaa014 = 'Y' THEN  
         LET l_nmbv.nmbv113 = -1 * l_nmcr114              #貸方本幣金額
      ELSE
         LET l_nmbv.nmbv113 = -1 * (l_nmcr104 * l_nmcq101)        #貸方本幣金額
      END IF
    
      IF l_glaa017 = '1' THEN 
         LET l_nmbv.nmbv123 = -1 * (l_nmcr104 * p_nmbt121)  #本位幣二貸方金額
      ELSE
         LET l_nmbv.nmbv123 = -1 * (l_nmcr114 * p_nmbt121)  #本位幣二貸方金額
      END IF   
   
      IF l_glaa021 = '1' THEN 
         LET l_nmbv.nmbv133 = -1 * (l_nmcr104 * p_nmbt131)  #本位幣三貸方金額
      ELSE
         LET l_nmbv.nmbv133 = -1 * (l_nmcr114 * p_nmbt131)  #本位幣三貸方金額
      END IF 
   
  #     LET l_nmbv.nmbv103 = -1 * l_nmcr103
  #     LET l_nmbv.nmbv113 = -1 * l_nmcr113
  #     LET l_nmbv.nmbv123 = -1 * p_nmbt123
  #     LET l_nmbv.nmbv133 = -1 * p_nmbt133
       
      #161128-00061#2---modify----begin----------
      #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
      INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                          nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                          nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                          nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
       VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
              l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
              l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
              l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
      #161128-00061#2---modify----begin---------- 
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins nmbv"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success     
      END IF
   END IF
   
   #匯兌科目
#  IF l_nmcr118 > 0 THEN   #表示匯兌收入 , 在貸方
#     SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
#       FROM nmbv_t
#      WHERE nmbvent = g_enterprise
#        AND nmbvld = l_nmbv.nmbvld
#        AND nmbvdocno = l_nmbv.nmbvdocno
#        AND nmbvseq = l_nmbv.nmbvseq
#     IF cl_null(l_nmbv.nmbvseq2) THEN 
#        LET l_nmbv.nmbvseq2 = 1
#     END IF
#     
#     SELECT DISTINCT glab005 INTO l_nmbv.nmbv001 
#       FROM glab_t 
#      WHERE glabent = g_enterprise
#        AND glabld  = p_nmbtld
#        AND glab001 = '41'
#        AND glab002 = '8714'   # 應收票據 異動項 
#        AND glab003 = 'D '     # 匯兌收入 
#       
#      LET l_nmbv.nmbv103 = 0                         #借方原幣金額
#      LET l_nmbv.nmbv104 = 0                         #貸方原幣金額
#      LET l_nmbv.nmbv113 = 0                         #借方本幣金額
#      LET l_nmbv.nmbv114 = l_nmcr118                 #貸方本幣金額
#      LET l_nmbv.nmbv123 = 0                         #本位幣二借方金額
#      LET l_nmbv.nmbv124 = 0                         #本位幣二貸方金額
#      LET l_nmbv.nmbv133 = 0                         #本位幣三借方金額
#      LET l_nmbv.nmbv134 = 0                         #本位幣三貸方金額
#       LET l_nmbv.nmbv103 = 0
#       LET l_nmbv.nmbv113 = -1 * l_nmcr118
#       LET l_nmbv.nmbv123 = 0 
#       LET l_nmbv.nmbv133 = 0       
#      INSERT INTO nmbv_t VALUES(l_nmbv.*)
#      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg("ins nmbv",'','',SQLCA.SQLCODE,1)
#         RETURN r_success       
#      END IF
#   END IF   
   #END IF   #-150707-00001#4 #150817 mark
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 帳別預設資料
# Memo...........:
# Usage..........: CALL anmt530_01_set_ld_info(p_ld)
# Date & Author..: 15/07/23 By apo(150707-00001#7)
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt530_01_set_ld_info(p_ld)
DEFINE p_ld          LIKE nmbs_t.nmbsld
   #維護帳別時不需要重展帳務中心樹
   IF NOT INFIELD(nmbsld) THEN
      #展帳務中心樹
      CALL s_fin_account_center_sons_query('3',g_nmbs_m.nmbssite,g_nmbs_m.nmbsdocdt,'1')
      #取得帳務中心下所屬成員之帳別
      CALL s_fin_account_center_ld_str() RETURNING g_ld_wc
      #將取回的字串轉換為SQL條件
      CALL s_fin_get_wc_str(g_ld_wc) RETURNING g_ld_wc
   END IF
   #取得法人
   CALL s_ld_sel_glaa(p_ld,'glaacomp') RETURNING g_sub_success,g_nmbs_m.nmbscomp
   LET g_nmbs_m.nmbscomp_desc = s_desc_get_department_desc(g_nmbs_m.nmbscomp)  
   DISPLAY BY NAME g_nmbs_m.nmbscomp,g_nmbs_m.nmbscomp_desc
   
END FUNCTION

################################################################################
# Descriptions...: 其他票據產生時都要寫入nmbv_t
# Memo...........: #150807-00007#1
# Usage..........: CALL anmt530_01_nmbv_ins_other()
# Date & Author..: 2015/08/17 By Reanna
# Modify.........:
################################################################################
PUBLIC FUNCTION anmt530_01_nmbv_ins_other(p_comp,p_ld,p_docno,p_seq)
DEFINE p_comp          LIKE nmbs_t.nmbscomp
DEFINE p_ld            LIKE nmbs_t.nmbsld
DEFINE p_docno         LIKE nmbs_t.nmbsdocno
DEFINE p_seq           LIKE nmbt_t.nmbtseq
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
DEFINE l_nmbt          RECORD
                          nmbt002   LIKE nmbt_t.nmbt002,
                          nmbt003   LIKE nmbt_t.nmbt003,
                          nmbt017   LIKE nmbt_t.nmbt017,
                          nmbt030   LIKE nmbt_t.nmbt030,
                          nmbt103   LIKE nmbt_t.nmbt103,
                          nmbt113   LIKE nmbt_t.nmbt113,
                          nmbt123   LIKE nmbt_t.nmbt123,
                          nmbt133   LIKE nmbt_t.nmbt133
                       END RECORD 
DEFINE l_sql           STRING
DEFINE l_n             LIKE type_t.num5
DEFINE l_glaa004       LIKE glaa_t.glaa004
DEFINE l_glbcseq1      LIKE glbc_t.glbcseq1
DEFINE l_glbc004       LIKE glbc_t.glbc004
DEFINE l_glbc008       LIKE glbc_t.glbc008
DEFINE l_glbc009       LIKE glbc_t.glbc009
DEFINE l_glbc012       LIKE glbc_t.glbc012
DEFINE l_glbc014       LIKE glbc_t.glbc014
DEFINE r_success       LIKE type_t.num5
   
   LET r_success = FALSE
   
   DELETE FROM nmbv_t
    WHERE nmbvent = g_enterprise
      AND nmbvld = p_ld
      AND nmbvdocno = p_docno
      AND nmbvseq = p_seq
   
   LET l_nmbv.nmbvent = g_enterprise
   LET l_nmbv.nmbvcomp = p_comp
   LET l_nmbv.nmbvld = p_ld
   LET l_nmbv.nmbvdocno = p_docno
   LET l_nmbv.nmbvseq = p_seq
   
   #抓取科目參照表
   LET l_glaa004 = ''
   SELECT glaa004 INTO l_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
   
   LET l_sql = " SELECT nmbt002,nmbt003,nmbt017,nmbt030,nmbt103,",
               "        nmbt113,nmbt123,nmbt133",
               "   FROM nmbt_t",
               "  WHERE nmbtent = ",g_enterprise,
               "    AND nmbtdocno = '",p_docno,"'",
               "    AND nmbtseq = ",p_seq
   PREPARE nmbt_sel_pr FROM l_sql
   DECLARE nmbt_sel_cs CURSOR FOR nmbt_sel_pr
   FOREACH nmbt_sel_cs INTO l_nmbt.nmbt002,l_nmbt.nmbt003,l_nmbt.nmbt017,l_nmbt.nmbt030,l_nmbt.nmbt103,
                            l_nmbt.nmbt113,l_nmbt.nmbt123,l_nmbt.nmbt133
      #對方科目
      LET l_nmbv.nmbv001 = l_nmbt.nmbt030
      #營運據點
      LET l_nmbv.nmbv017 = l_nmbt.nmbt017
      
      #若為現金科目，則看有幾筆現金變動碼就寫幾筆進來
      SELECT COUNT(*) INTO l_n
        FROM glac_t
       WHERE glacent = g_enterprise
         AND glac001 = l_glaa004
         AND glac002 = l_nmbt.nmbt030
         AND glac016 = 'Y'
      IF cl_null(l_n) THEN LET l_n = 0 END IF
      IF l_n > 0 THEN
        LET l_sql = " SELECT glbcseq1,glbc004,glbc008,glbc009,glbc012,glbc014",
                    "   FROM glbc_t",
                    "  WHERE glbcent = ",g_enterprise,
                    "    AND glbcdocno = '",l_nmbt.nmbt002,"'",
                    "    AND glbcseq = ",l_nmbt.nmbt003
        PREPARE glbc_sel_pr FROM l_sql
        DECLARE glbc_sel_cs CURSOR FOR glbc_sel_pr
        FOREACH glbc_sel_cs INTO l_glbcseq1,l_glbc004,l_glbc008,l_glbc009,l_glbc012,l_glbc014
           SELECT MAX(nmbvseq2) + 1 INTO l_nmbv.nmbvseq2
             FROM nmbv_t
            WHERE nmbvent = g_enterprise
              AND nmbvld = p_ld
              AND nmbvdocno = p_docno
              AND nmbvseq = p_seq
           IF cl_null(l_nmbv.nmbvseq2) THEN
              LET l_nmbv.nmbvseq2 = 1
           END IF
           LET l_nmbv.nmbv103 = l_glbc008                #借方原幣金額
           LET l_nmbv.nmbv113 = l_glbc009                #借方本幣金額
           LET l_nmbv.nmbv123 = l_glbc012                #本位幣二借方金額
           LET l_nmbv.nmbv133 = l_glbc014                #本位幣三借方金額
           LET l_nmbv.nmbv042 = l_glbc004                #現金變動碼
           #161128-00061#2---modify----begin----------
           #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
           INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                               nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                               nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                               nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
            VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                   l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                   l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                   l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
           #161128-00061#2---modify----begin---------- 
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.SQLCODE
              LET g_errparam.extend = "ins nmbv"
              LET g_errparam.popup = TRUE
              CALL cl_err()
              RETURN r_success
           END IF
        END FOREACH
      ELSE
         LET l_nmbv.nmbvseq2 = 1
         LET l_nmbv.nmbv103 = l_nmbt.nmbt103
         LET l_nmbv.nmbv113 = l_nmbt.nmbt113
         LET l_nmbv.nmbv123 = l_nmbt.nmbt123
         LET l_nmbv.nmbv133 = l_nmbt.nmbt133
         #161128-00061#2---modify----begin----------
         #INSERT INTO nmbv_t VALUES(l_nmbv.*) 
         INSERT INTO nmbv_t (nmbvent,nmbvcomp,nmbvld,nmbvdocno,nmbvseq,nmbvseq2,nmbv001,nmbv017,nmbv018,
                             nmbv019,nmbv020,nmbv021,nmbv022,nmbv023,nmbv024,nmbv025,nmbv026,nmbv027,nmbv028,
                             nmbv029,nmbv030,nmbv031,nmbv032,nmbv033,nmbv034,nmbv035,nmbv036,nmbv037,nmbv038,
                             nmbv039,nmbv040,nmbv041,nmbv103,nmbv113,nmbv123,nmbv133,nmbv042,nmbv100)
          VALUES(l_nmbv.nmbvent,l_nmbv.nmbvcomp,l_nmbv.nmbvld,l_nmbv.nmbvdocno,l_nmbv.nmbvseq,l_nmbv.nmbvseq2,l_nmbv.nmbv001,l_nmbv.nmbv017,l_nmbv.nmbv018,
                 l_nmbv.nmbv019,l_nmbv.nmbv020,l_nmbv.nmbv021,l_nmbv.nmbv022,l_nmbv.nmbv023,l_nmbv.nmbv024,l_nmbv.nmbv025,l_nmbv.nmbv026,l_nmbv.nmbv027,l_nmbv.nmbv028,
                 l_nmbv.nmbv029,l_nmbv.nmbv030,l_nmbv.nmbv031,l_nmbv.nmbv032,l_nmbv.nmbv033,l_nmbv.nmbv034,l_nmbv.nmbv035,l_nmbv.nmbv036,l_nmbv.nmbv037,l_nmbv.nmbv038,
                 l_nmbv.nmbv039,l_nmbv.nmbv040,l_nmbv.nmbv041,l_nmbv.nmbv103,l_nmbv.nmbv113,l_nmbv.nmbv123,l_nmbv.nmbv133,l_nmbv.nmbv042,l_nmbv.nmbv100) 
         #161128-00061#2---modify----begin---------- 
         IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'ins nmbv'
           LET g_errparam.popup = TRUE
           CALL cl_err()
           RETURN r_success
         END IF
      END IF
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

 
{</section>}
 
