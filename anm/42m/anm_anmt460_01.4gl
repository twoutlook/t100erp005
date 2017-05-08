#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt460_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-08-11 14:07:15), PR版次:0007(2016-12-23 15:10:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: anmt460_01
#+ Description: 產生匯款付訖單
#+ Creator....: 04152(2015-08-07 16:42:27)
#+ Modifier...: 04152 -SD/PR- 07900
 
{</section>}
 
{<section id="anmt460_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150923          2015/09/23 By Reanna   寫入銀存檔的日期改放異動單據的日期為主
#150930-00010#4  2015/10/02 By 03538    匯率來源參數參照S-FIN-4012,且日平均匯率以新元件計算;透過匯率元件回傳的匯率不用再取一次位
#160122-00001#27 2016/01/27 By yangtt   添加交易帳戶編號用戶權限空管
#160122-00001#27 2016/03/16 By 07673    添加交易帳戶編號用戶權限空管,增加部门权限
#160321-00016#39 2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#26 2016/04/28 BY 07900    校验代码重复错误讯息的修改
#161021-00050#9  2016/10/27 By Reanna   资金中心开窗需调整为q_ooef001_33 where条件限定ooefstus= 'Y';
#                                       法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留;
#161209-00016#1  2016/12/22 By 07900    5区 CNJ-460-161100000001 审核后，运行“实际支付日”产生的anmt480单据中，包含有其他anmt460的资料。是插入单身时没有带入anmt460当前的单据导致问题的

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
PRIVATE type type_g_nmch_m        RECORD
       nmchsite LIKE nmch_t.nmchsite, 
   nmchsite_desc LIKE type_t.chr80, 
   nmchcomp LIKE nmch_t.nmchcomp, 
   nmchcomp_desc LIKE type_t.chr80, 
   nmchdocno LIKE nmch_t.nmchdocno, 
   nmchdocdt LIKE nmch_t.nmchdocdt, 
   nmch003 LIKE nmch_t.nmch003, 
   nmch003_desc LIKE type_t.chr80, 
   nmck012 LIKE nmck_t.nmck012, 
   docno_480 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc1                 STRING
DEFINE g_comp_wc             STRING
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_sql_bank            STRING                    #160122-00001#27 by 07673
#end add-point
 
DEFINE g_nmch_m        type_g_nmch_m
 
   DEFINE g_nmchcomp_t LIKE nmch_t.nmchcomp
DEFINE g_nmchdocno_t LIKE nmch_t.nmchdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt460_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt460_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_nmchsite,p_nmchcomp,p_nmch003,p_nmckdocno
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
   DEFINE p_nmchsite      LIKE nmch_t.nmchsite
   DEFINE p_nmchcomp      LIKE nmch_t.nmchcomp
   DEFINE p_nmch003       LIKE nmch_t.nmch003
   DEFINE p_nmckdocno     LIKE nmck_t.nmckdocno
   DEFINE l_cnt           LIKE type_t.num10
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt460_01 WITH FORM cl_ap_formpath("anm","anmt460_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   #160122-00001#27 by 07673 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#27 by 07673 --add--end
   
   INITIALIZE g_nmch_m.* TO NULL
   IF NOT cl_null(p_nmckdocno) THEN
      LET g_nmch_m.nmchsite = p_nmchsite
      LET g_nmch_m.nmchcomp = p_nmchcomp
      LET g_nmch_m.nmch003 = p_nmch003
      LET g_wc1=" nmckdocno='",p_nmckdocno,"'"
      CALL cl_set_comp_visible('group_1',FALSE)
      CALL cl_set_comp_entry("nmchsite,nmchcomp,nmch003",FALSE)
   ELSE
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_nmch_m.nmchsite,g_errno
      CALL s_anm_get_comp_wc('6',g_nmch_m.nmchsite,g_nmch_m.nmchdocdt) RETURNING g_comp_wc
      
      #抓取營運據點的歸屬法人
      SELECT ooef017 INTO g_nmch_m.nmchcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_nmch_m.nmchsite
      
      LET g_wc1 = " 1=1 "
   END IF
   
   #抓取法人的帳套/單據別參照表號
   SELECT glaald,glaa024 INTO g_glaald,g_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmch_m.nmchcomp
      AND glaa014 = 'Y'
   
   LET g_nmch_m.nmchdocdt = g_today
   LET g_nmch_m.nmck012 = g_today
   LET g_nmch_m.nmchsite_desc = s_desc_get_department_desc(g_nmch_m.nmchsite)
   LET g_nmch_m.nmchcomp_desc = s_desc_get_department_desc(g_nmch_m.nmchcomp)
   DISPLAY BY NAME g_nmch_m.nmchsite_desc,g_nmch_m.nmchcomp_desc
   
   WHILE TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmch_m.nmchsite,g_nmch_m.nmchcomp,g_nmch_m.nmchdocno,g_nmch_m.nmchdocdt,g_nmch_m.nmch003, 
          g_nmch_m.nmck012,g_nmch_m.docno_480 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
 
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmchsite
            
            #add-point:AFTER FIELD nmchsite name="input.a.nmchsite"
            IF NOT cl_null(g_nmch_m.nmchsite) THEN
               CALL s_anmt480_nmchsite_chk() RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmch_m.nmchsite
                  #160321-00016#39 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#39 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmch_m.nmchsite=''
                  LET g_nmch_m.nmchsite_desc = ''
                  DISPLAY BY NAME g_nmch_m.nmchsite_desc,g_nmch_m.nmchcomp_desc
                  NEXT FIELD CURRENT
               END IF

               CALL s_fin_account_center_with_ld_chk(g_nmch_m.nmchsite,'',g_user,'6','N','',g_nmch_m.nmchdocdt)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmch_m.nmchsite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmch_m.nmchsite =''
                  LET g_nmch_m.nmchcomp = ''
                  LET g_nmch_m.nmchsite_desc = ''
                  LET g_nmch_m.nmchcomp_desc = ''
                  DISPLAY BY NAME g_nmch_m.nmchsite_desc,g_nmch_m.nmchcomp_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_anm_get_comp_wc('6',g_nmch_m.nmchsite,g_nmch_m.nmchdocdt) RETURNING g_comp_wc
               IF NOT cl_null(g_nmch_m.nmchcomp) THEN
                  IF s_chr_get_index_of(g_comp_wc,g_nmch_m.nmchcomp,1) = 0 THEN
                     SELECT ooef017 INTO g_nmch_m.nmchcomp
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_nmch_m.nmchsite
   
                     #抓取法人的帳套/單據別參照表號
                     SELECT glaald,glaa024 INTO g_glaald,g_glaa024
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = g_nmch_m.nmchcomp
                        AND glaa014 = 'Y'
                     
                     LET g_nmch_m.nmchcomp_desc = s_desc_get_department_desc(g_nmch_m.nmchcomp)
                     DISPLAY BY NAME g_nmch_m.nmchcomp,g_nmch_m.nmchcomp_desc
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_nmch_m.nmchsite) RETURNING g_nmch_m.nmchsite_desc
            DISPLAY BY NAME g_nmch_m.nmchsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmchsite
            #add-point:BEFORE FIELD nmchsite name="input.b.nmchsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmchsite
            #add-point:ON CHANGE nmchsite name="input.g.nmchsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmchcomp
            
            #add-point:AFTER FIELD nmchcomp name="input.a.nmchcomp"
            IF NOT cl_null(g_nmch_m.nmchcomp) THEN
               CALL s_fin_comp_chk(g_nmch_m.nmchcomp) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#39 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#39 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmch_m.nmchcomp = ''
                  LET g_nmch_m.nmchcomp_desc = ''
                  DISPLAY BY NAME g_nmch_m.nmchcomp_desc
                  NEXT FIELD CURRENT
               END IF
               IF s_chr_get_index_of(g_comp_wc,g_nmch_m.nmchcomp,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02928'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmch_m.nmchcomp = ''
                  LET g_nmch_m.nmchcomp_desc = ''
                  DISPLAY BY NAME g_nmch_m.nmchcomp_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_nmch_m.nmchcomp_desc = s_desc_get_department_desc(g_nmch_m.nmchcomp)
            DISPLAY BY NAME g_nmch_m.nmchcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmchcomp
            #add-point:BEFORE FIELD nmchcomp name="input.b.nmchcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmchcomp
            #add-point:ON CHANGE nmchcomp name="input.g.nmchcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmchdocno
            #add-point:BEFORE FIELD nmchdocno name="input.b.nmchdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmchdocno
            
            #add-point:AFTER FIELD nmchdocno name="input.a.nmchdocno"
            IF NOT cl_null(g_nmch_m.nmchdocno) THEN
               CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_nmch_m.nmchdocno,'anmt480') RETURNING g_sub_success
               IF g_sub_success = FALSE THEN
                  LET g_nmch_m.nmchdocno = ''
                  NEXT FIELD nmchdocno
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmchdocno
            #add-point:ON CHANGE nmchdocno name="input.g.nmchdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmchdocdt
            #add-point:BEFORE FIELD nmchdocdt name="input.b.nmchdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmchdocdt
            
            #add-point:AFTER FIELD nmchdocdt name="input.a.nmchdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmchdocdt
            #add-point:ON CHANGE nmchdocdt name="input.g.nmchdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmch003
            
            #add-point:AFTER FIELD nmch003 name="input.a.nmch003"
            IF NOT cl_null(g_nmch_m.nmch003) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_nmch_m.nmch003
               LET g_chkparam.arg2 = g_nmch_m.nmchcomp
               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
               #160318-00025#26  by 07900 --add-end
               IF cl_chk_exist("v_nmas002_1") THEN
                  #160122-00001#27--add---str
                  IF NOT s_anmi120_nmll002_chk(g_nmch_m.nmch003,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmch_m.nmch003
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_nmch_m.nmch003 = ''
                     LET g_nmch_m.nmch003_desc= s_desc_get_nmas002_desc(g_nmch_m.nmch003)
                     DISPLAY BY NAME g_nmch_m.nmch003_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#27--add---end
               ELSE
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_nmch_m.nmch003_desc= s_desc_get_nmas002_desc(g_nmch_m.nmch003)
            DISPLAY BY NAME g_nmch_m.nmch003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmch003
            #add-point:BEFORE FIELD nmch003 name="input.b.nmch003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmch003
            #add-point:ON CHANGE nmch003 name="input.g.nmch003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck012
            #add-point:BEFORE FIELD nmck012 name="input.b.nmck012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck012
            
            #add-point:AFTER FIELD nmck012 name="input.a.nmck012"
            IF NOT cl_null(g_nmch_m.nmck012) THEN
               #實際匯款日不可小於單據日期
               IF g_nmch_m.nmck012 < g_nmch_m.nmchdocdt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02949'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmch_m.nmck012 = g_today
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck012
            #add-point:ON CHANGE nmck012 name="input.g.nmck012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno_480
            #add-point:BEFORE FIELD docno_480 name="input.b.docno_480"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno_480
            
            #add-point:AFTER FIELD docno_480 name="input.a.docno_480"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno_480
            #add-point:ON CHANGE docno_480 name="input.g.docno_480"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmchsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmchsite
            #add-point:ON ACTION controlp INFIELD nmchsite name="input.c.nmchsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmch_m.nmchsite
            LET g_qryparam.where = " ooef206 = 'Y'"
            LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#9
            #CALL q_ooef001()    #161021-00050#9 mark
            CALL q_ooef001_33()  #161021-00050#9
            LET g_nmch_m.nmchsite = g_qryparam.return1
            LET g_nmch_m.nmchsite_desc = s_desc_get_department_desc(g_nmch_m.nmchsite)
            DISPLAY BY NAME g_nmch_m.nmchsite_desc
            NEXT FIELD nmchsite
            #END add-point
 
 
         #Ctrlp:input.c.nmchcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmchcomp
            #add-point:ON ACTION controlp INFIELD nmchcomp name="input.c.nmchcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmch_m.nmchcomp
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc
            #CALL q_ooef001()  #161021-00050#9 mark
            CALL q_ooef001_2() #161021-00050#9
            LET g_nmch_m.nmchcomp = g_qryparam.return1
            LET g_nmch_m.nmchcomp_desc = s_desc_get_department_desc(g_nmch_m.nmchcomp)
            DISPLAY BY NAME g_nmch_m.nmchcomp_desc
            NEXT FIELD nmchcomp
            #END add-point
 
 
         #Ctrlp:input.c.nmchdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmchdocno
            #add-point:ON ACTION controlp INFIELD nmchdocno name="input.c.nmchdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmch_m.nmchdocno
            LET g_qryparam.where = " ooba001 = '",g_glaa024,"' AND oobx003 = 'anmt480'"
            CALL q_ooba002()
            LET g_nmch_m.nmchdocno = g_qryparam.return1
            DISPLAY g_nmch_m.nmchdocno TO nmchdocno
            NEXT FIELD nmchdocno
            #END add-point
 
 
         #Ctrlp:input.c.nmchdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmchdocdt
            #add-point:ON ACTION controlp INFIELD nmchdocdt name="input.c.nmchdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmch003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmch003
            #add-point:ON ACTION controlp INFIELD nmch003 name="input.c.nmch003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmch_m.nmch003
            LET g_qryparam.where = " nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "              AND ooef017 = '",g_nmch_m.nmchcomp,"')"
            #160122-00001#27 by 07673 --mark --str
            #160122-00001#27--add---str
#            LET g_qryparam.where = g_qryparam.where CLIPPED," AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
            #160122-00001#27--add---end
            #160122-00001#27 by 07673 --mark --end
            #160122-00001#27 by 07673 add -str
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND  nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 add -end
            
            CALL q_nmas_01()
            LET g_nmch_m.nmch003 = g_qryparam.return1
            DISPLAY g_nmch_m.nmch003 TO nmch003
            LET g_nmch_m.nmch003_desc= s_desc_get_nmas002_desc(g_nmch_m.nmch003)
            DISPLAY BY NAME g_nmch_m.nmch003_desc
            LET g_qryparam.where = " "             #160122-00001#27
            NEXT FIELD nmch003
            #END add-point
 
 
         #Ctrlp:input.c.nmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck012
            #add-point:ON ACTION controlp INFIELD nmck012 name="input.c.nmck012"
            
            #END add-point
 
 
         #Ctrlp:input.c.docno_480
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno_480
            #add-point:ON ACTION controlp INFIELD docno_480 name="input.c.docno_480"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc1 ON nmck011,nmckdocno
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD nmckdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '20' OR ooia002 = '10' AND ooiaent = ",g_enterprise,") ",
                                   " AND nmck012 IS NULL AND nmckcomp = '",g_nmch_m.nmchcomp,"' ",
                                   " AND nmck004 = '",g_nmch_m.nmch003,"' ",
                                   " AND nmck026 = '10' AND nmckstus = 'Y'",
                                   " AND nmckdocno NOT IN (",
                                   "     SELECT nmci003 FROM nmci_t ",
                                   "       LEFT JOIN nmch_t ON nmchent=nmcient AND nmchcomp=nmcicomp AND nmchdocno=nmcidocno",
                                   "       WHERE nmchent = ",g_enterprise,
                                   "         AND nmchcomp = '",g_nmch_m.nmchcomp,"'",
                                   "         AND nmchstus <> 'X'",
                                   "         AND nmch001 = '11'",
                                   "     )"
            CALL q_nmckdocno_4()
            DISPLAY g_qryparam.return1 TO nmckdocno
            NEXT FIELD nmckdocno
      END CONSTRUCT
      
      BEFORE DIALOG
         

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
   #161209-00016#1--add--s--
   IF NOT cl_null(p_nmckdocno) THEN
      LET g_wc1 = " nmckdocno='",p_nmckdocno,"'"
   END IF
   #161209-00016#1--add--e--
   IF INT_FLAG THEN
      LET INT_FLAG = TRUE
      EXIT WHILE
   ELSE
      #寫入anmt480
      CALL s_transaction_begin()
      CALL anmt460_01_ins_nmch(g_nmch_m.nmchsite,g_nmch_m.nmchcomp,g_nmch_m.nmchdocno,g_nmch_m.nmchdocdt,g_nmch_m.nmch003,g_nmch_m.nmck012,g_wc1)
           RETURNING g_sub_success,g_nmch_m.docno_480
      IF NOT g_sub_success THEN
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00187' #單據產生失敗
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N',0)
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00125'
         LET g_errparam.replace[1] = g_nmch_m.docno_480
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('Y',0)
      END IF
      
      #顯示成功產生的付訖單號
      SELECT COUNT(*) INTO l_cnt FROM nmch_t WHERE nmchent = g_enterprise AND nmchdocno = g_nmch_m.docno_480
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         LET g_nmch_m.docno_480 = ''
      END IF  
      DISPLAY g_nmch_m.docno_480 TO docno_480
      
      CONTINUE WHILE
   END IF
   END WHILE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_anmt460_01 
   
   #add-point:input段after input name="input.post_input"
 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt460_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt460_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 產生匯款異動單頭
# Memo...........:
# Usage..........: CALL anmt460_01_ins_nmch()
# Date & Author..: 2015/08/10 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt460_01_ins_nmch(p_nmchsite,p_nmchcomp,p_nmchdocno,p_nmchdocdt,p_nmch003,p_nmck012,p_wc)
DEFINE p_nmchsite    LIKE nmch_t.nmchsite
DEFINE p_nmchcomp    LIKE nmch_t.nmchcomp
DEFINE p_nmchdocno   LIKE nmch_t.nmchdocno
DEFINE p_nmchdocdt   LIKE nmch_t.nmchdocdt
DEFINE p_nmch003     LIKE nmch_t.nmch003
DEFINE p_nmck012     LIKE nmck_t.nmck012
DEFINE p_wc          STRING
DEFINE l_nmch        RECORD
                        nmch100 LIKE nmch_t.nmch100,
                        nmch101 LIKE nmch_t.nmch101
                     END RECORD
DEFINE l_sfin4004    LIKE type_t.chr10
DEFINE l_sfin4012    LIKE type_t.chr10   #150930-00010#4
DEFINE l_date        DATETIME YEAR TO SECOND
DEFINE l_glaald      LIKE glaa_t.glaald
DEFINE l_glaa001     LIKE glaa_t.glaa001
DEFINE l_glaa003     LIKE glaa_t.glaa003
DEFINE l_glaa024     LIKE glaa_t.glaa024
DEFINE r_success     LIKE type_t.num5
DEFINE r_docno       LIKE nmch_t.nmchdocno
   
   
   LET r_success = TRUE
   LET r_docno = ""
   WHENEVER ERROR CONTINUE
   
   #抓取法人的帳套/單據別參照表號
   SELECT glaald,glaa001,glaa003,glaa024 INTO l_glaald,l_glaa001,l_glaa003,l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_nmchcomp
      AND glaa014 = 'Y'
   
   CALL s_aooi200_fin_gen_docno(l_glaald,l_glaa024,l_glaa003,p_nmchdocno,p_nmchdocdt,'anmt480')
        RETURNING g_sub_success,p_nmchdocno
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = p_nmchdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_docno
   END IF
   
   SELECT nmas003 INTO l_nmch.nmch100
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = p_nmch003
      AND nmaa002 IN (SELECT ooef001 FROM ooef_t
                       WHERE ooefent = g_enterprise
                         AND ooef017 = p_nmchcomp)
  #CALL cl_get_para(g_enterprise,p_nmchcomp,'S-FIN-4004') RETURNING l_sfin4004  #資金模組匯率來源   #150930-00010#4 mark
   CALL cl_get_para(g_enterprise,p_nmchcomp,'S-FIN-4012') RETURNING l_sfin4012  #銀行支出匯率來源   #150930-00010#4
   #150930-00010#4--s
   IF l_sfin4012 = '23' THEN
      #銀行日平均匯率
      CALL s_anm_get_exrate(l_glaald,p_nmchcomp,p_nmch003,l_nmch.nmch100,l_glaa001,p_nmchdocdt) RETURNING l_nmch.nmch101
   ELSE
   #150930-00010#4--e   
     #CALL s_aooi160_get_exrate('1',p_nmchcomp,p_nmchdocdt,l_nmch.nmch100,l_glaa001,0,l_sfin4004)   #150930-00010#4 mark
      CALL s_aooi160_get_exrate('1',p_nmchcomp,p_nmchdocdt,l_nmch.nmch100,l_glaa001,0,l_sfin4012)   #150930-00010#4
           RETURNING l_nmch.nmch101
   END IF   #150930-00010#4
  #150930-00010#4 mark--s
  #CALL s_curr_round_ld('1',l_glaald,l_glaa001,l_nmch.nmch101,3)
  #     RETURNING g_sub_success,g_errno,l_nmch.nmch101
  #150930-00010#4 mark--e
   LET l_date = cl_get_current()
   
   INSERT INTO nmch_t (nmchent,nmchsite,nmchcomp,nmchdocno,nmchdocdt,
                       nmch001,nmch002,nmch003,nmch004,nmch006,
                       nmch007,nmch010,nmch100,nmch101,
                       nmchstus,nmchownid,nmchowndp,nmchcrtid,nmchcrtdp,
                       nmchcrtdt,nmchmodid,nmchmoddt,nmchcnfid,nmchcnfdt)
               VALUES (g_enterprise,p_nmchsite,p_nmchcomp,p_nmchdocno,p_nmchdocdt,
                       '11',g_user,p_nmch003,'N','',
                       '','2',l_nmch.nmch100,l_nmch.nmch101,
                       'Y',g_user,g_dept,g_user,g_dept,
                       l_date,g_user,l_date,g_user,l_date) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_docno
   ELSE
      #寫入單身
     #CALL anmt460_01_ins_nmci(p_nmchsite,p_nmchcomp,p_nmchdocno,p_nmch003,p_nmck012,p_wc)             #150923 mark
      CALL anmt460_01_ins_nmci(p_nmchsite,p_nmchcomp,p_nmchdocno,p_nmchdocdt,p_nmch003,p_nmck012,p_wc) #150923
           RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         RETURN r_success,r_docno
      ELSE
         LET r_docno = p_nmchdocno
      END IF
   END IF
   
   #成功就產生銀存收支
   CALL s_anmt480_ins_nmbc(p_nmchdocno,p_nmchcomp,'1','')RETURNING g_sub_success
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success,r_docno
   
END FUNCTION

################################################################################
# Descriptions...: 產生匯款異動單身
# Memo...........:
# Usage..........: CALL anmt460_01_ins_nmci()
# Date & Author..: 2015/08/10 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt460_01_ins_nmci(p_nmchsite,p_nmchcomp,p_nmchdocno,p_nmchdocdt,p_nmch003,p_nmck012,p_wc)
DEFINE p_nmchsite       LIKE nmch_t.nmchsite
DEFINE p_nmchcomp       LIKE nmch_t.nmchcomp
DEFINE p_nmchdocno      LIKE nmch_t.nmchdocno
DEFINE p_nmchdocdt      LIKE nmch_t.nmchdocdt  #150923
DEFINE p_nmch003        LIKE nmch_t.nmch003
DEFINE p_nmck012        LIKE nmck_t.nmck012
DEFINE p_wc             STRING
DEFINE l_sql            STRING
DEFINE l_nmckdocno      LIKE nmck_t.nmckdocno
DEFINE l_date           DATETIME YEAR TO SECOND
DEFINE r_success        LIKE type_t.num5
   
   
   LET r_success = FALSE
   WHENEVER ERROR CONTINUE
   
   LET l_date = cl_get_current()
   
   #先撈出適合的匯款單據
   LET l_sql = "SELECT nmckdocno",
               "  FROM nmck_t",
               " WHERE nmckent = ",g_enterprise,
               "   AND nmcksite = '",p_nmchsite,"'",
               "   AND nmckcomp = '",p_nmchcomp,"'",
               "   AND nmck004 = '",p_nmch003,"'",
               "   AND nmck026 ='10' AND nmck012 IS NULL AND nmckstus='Y'",
               "   AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 IN ('10','20') AND ooiaent = ",g_enterprise,") ",
               "   AND nmckdocno NOT IN (",
               "       SELECT nmci003 FROM nmci_t ",
               "         LEFT JOIN nmch_t ON nmchent=nmcient AND nmchcomp=nmcicomp AND nmchdocno=nmcidocno",
               "         WHERE nmchent = ",g_enterprise,
               "           AND nmchcomp = '",p_nmchcomp,"'",
               "           AND nmchstus <> 'X'",
               "           AND nmch001 = '11'",
               "       )",
               "   AND ",g_wc1,
               "   AND ",p_wc,
               " ORDER BY nmckdocno"
   PREPARE anmt460_01_p FROM l_sql
   DECLARE anmt460_01_c CURSOR FOR anmt460_01_p
   FOREACH anmt460_01_c INTO l_nmckdocno
     #CALL s_anmt480_ins_nmci(p_nmchdocno,p_nmchcomp,'11',l_nmckdocno) RETURNING g_sub_success             #150923 mark
      CALL s_anmt480_ins_nmci(p_nmchdocno,p_nmchdocdt,p_nmchcomp,'11',l_nmckdocno) RETURNING g_sub_success #150923
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         EXIT FOREACH
      ELSE
         #成功就更新匯款開立單的狀態
         UPDATE nmck_t
            SET nmck012 = p_nmck012,
                nmck026 = '11', #付訖
                nmck022 = g_user,
                nmckmoddt = l_date
          WHERE nmckent  = g_enterprise
            AND nmckcomp = p_nmchcomp
            AND nmckdocno = l_nmckdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE nmck_t wrong'
            LET g_errparam.popup = TRUE
            LET g_errparam.sqlerr = SQLCA.SQLCODE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         #表示成功寫入
         LET r_success = TRUE
      END IF
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

 
{</section>}
 
