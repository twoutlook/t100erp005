#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt470_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-01-13 11:29:33), PR版次:0006(2017-01-11 18:17:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: axrt470_01
#+ Description: 批次產生
#+ Creator....: 06821(2016-01-13 11:22:00)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="axrt470_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160705-00042#11 2016/07/15  By sakura   查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#160811-00009#3  2016/08/15  By 01531    账务中心/法人/账套权限控管
#160829-00004#4  2016/09/05  By 08729    處理取匯率但取錯幣別
#161006-00005#39 2016/10/27  By 08171    账务中心开窗需调整为q_ooef001_46 where条件限定ooefstus=Y
#161104-00046#6  2017/01/11  By 06821    資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_xrep_m        RECORD
       xrepsite LIKE xrep_t.xrepsite, 
   l_xrepsite_desc LIKE type_t.chr80, 
   xrepld LIKE xrep_t.xrepld, 
   l_xrepld_desc LIKE type_t.chr80, 
   xrep003 LIKE xrep_t.xrep003, 
   l_xrep003_desc LIKE type_t.chr80, 
   xrepdocno LIKE xrep_t.xrepdocno, 
   xrep001 LIKE xrep_t.xrep001, 
   xrep002 LIKE xrep_t.xrep002, 
   xrepdocdt LIKE xrep_t.xrepdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xrep_m_o      type_g_xrep_m
DEFINE g_wc_xrepld     STRING
DEFINE r_xrepdocno     LIKE xrep_t.xrepdocno
DEFINE r_success       LIKE type_t.chr1
DEFINE g_comp          LIKE glaa_t.glaacomp
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE ls_wc           STRING #160811-00009#3
DEFINE g_user_slip_wc  STRING #161104-00046#6 add
#end add-point
 
DEFINE g_xrep_m        type_g_xrep_m
 
   DEFINE g_xrepld_t LIKE xrep_t.xrepld
DEFINE g_xrepdocno_t LIKE xrep_t.xrepdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt470_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt470_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_date          DATE
   DEFINE l_flag1         LIKE type_t.num5   #161104-00046#6 add
   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt470_01 WITH FORM cl_ap_formpath("axr","axrt470_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   #161104-00046#6 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_xrep_m','','','','','','')RETURNING g_sub_success
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#6 --e add   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrep_m.xrepsite,g_xrep_m.xrepld,g_xrep_m.xrep003,g_xrep_m.xrepdocno,g_xrep_m.xrep001, 
          g_xrep_m.xrep002,g_xrep_m.xrepdocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xrep_m.* TO NULL
            #帳務中心&帳別
            CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_xrep_m.xrepsite,g_xrep_m.xrepld,g_comp
            CALL s_desc_get_department_desc(g_xrep_m.xrepsite) RETURNING g_xrep_m.l_xrepsite_desc
            CALL s_desc_get_ld_desc(g_xrep_m.xrepld)  RETURNING g_xrep_m.l_xrepld_desc
            #帳務人員
            LET g_xrep_m.xrep003 = g_user
            CALL s_desc_get_person_desc(g_xrep_m.xrep003) RETURNING g_xrep_m.l_xrep003_desc
            
            #取得會計週期參照表/單據別參照表號
            CALL s_ld_sel_glaa(g_xrep_m.xrepld,'glaa003|glaa024|glaa001|glaacomp') 
                    RETURNING  g_sub_success,l_glaa003,l_glaa024,g_glaa001,g_comp
            
            #關帳日期之年度期別
            CALL cl_get_para(g_enterprise,g_comp,'S-FIN-2007') RETURNING l_date
            LET g_xrep_m.xrep001 = YEAR(l_date) 
            LET g_xrep_m.xrep002 = MONTH(l_date)          

            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(l_glaa003,'',g_xrep_m.xrep001,g_xrep_m.xrep002)
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            LET g_xrep_m.xrepdocdt = l_pdate_e
            
            DISPLAY BY NAME g_xrep_m.xrepsite,g_xrep_m.l_xrepsite_desc
                           ,g_xrep_m.xrepld,g_xrep_m.l_xrepld_desc
                           ,g_xrep_m.xrep003,g_xrep_m.l_xrep003_desc
                           ,g_xrep_m.xrep001,g_xrep_m.xrep002,g_xrep_m.xrepdocdt
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrepsite
            
            #add-point:AFTER FIELD xrepsite name="input.a.xrepsite"
            #帳務中心
            LET g_xrep_m.l_xrepsite_desc = ''
            IF NOT cl_null(g_xrep_m.xrepsite) THEN
               #以目前的資料重展結構,避免[帳套]有值時會比對錯誤,在s_fin_account_center_with_ld_chk做勾稽時會依據這個結構做是否有符合的帳套
               CALL s_fin_account_center_sons_query('3',g_xrep_m.xrepsite,g_today,'1')
               #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次
               #避免USER 在帳務中心跟帳套卡住走不了 增加對帳套有資料的處理
               IF NOT cl_null(g_xrep_m.xrepld) THEN   
                  CALL s_fin_account_center_with_ld_chk(g_xrep_m.xrepsite,g_xrep_m.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                     CALL s_fin_orga_get_comp_ld(g_xrep_m.xrepsite) RETURNING g_sub_success,g_errno,g_comp,g_xrep_m.xrepld
                     #判斷這個主帳套使用者是否有權限
                     CALL s_fin_account_center_with_ld_chk(g_xrep_m.xrepsite,g_xrep_m.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  END IF
                  #判斷完成後 若勾稽失敗則回復舊值
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrep_m.xrepsite = ''
                     LET g_xrep_m.xrepld   = ''
                     CALL s_desc_get_department_desc(g_xrep_m.xrepsite) RETURNING g_xrep_m.l_xrepsite_desc
                     CALL s_desc_get_ld_desc(g_xrep_m.xrepld) RETURNING g_xrep_m.l_xrepld_desc
                     DISPLAY BY NAME g_xrep_m.l_xrepsite_desc,g_xrep_m.l_xrepld_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_desc_get_ld_desc(g_xrep_m.xrepld) RETURNING g_xrep_m.l_xrepld_desc
                  DISPLAY BY NAME g_xrep_m.l_xrepld_desc
               END IF
               #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次
               CALL s_fin_account_center_with_ld_chk(g_xrep_m.xrepsite,g_xrep_m.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrep_m.xrepsite = ''
                  CALL s_desc_get_department_desc(g_xrep_m.xrepsite) RETURNING g_xrep_m.l_xrepsite_desc
                  DISPLAY BY NAME g_xrep_m.l_xrepsite_desc
                  NEXT FIELD CURRENT
               END IF
               #依據正確的資料再重展一次結構
               CALL s_fin_account_center_sons_query('3',g_xrep_m.xrepsite,g_today,'1')  
               CALL s_fin_account_center_ld_str() RETURNING g_wc_xrepld
               CALL s_fin_get_wc_str(g_wc_xrepld) RETURNING g_wc_xrepld
            END IF
            CALL s_desc_get_department_desc(g_xrep_m.xrepsite) RETURNING g_xrep_m.l_xrepsite_desc                    
            DISPLAY BY NAME g_xrep_m.l_xrepsite_desc
            
            IF NOT cl_null(g_xrep_m.xrepld) THEN
               #取的帳務中心的所屬法人
               SELECT ooef017 INTO g_comp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_xrep_m.xrepsite
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrepsite
            #add-point:BEFORE FIELD xrepsite name="input.b.xrepsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrepsite
            #add-point:ON CHANGE xrepsite name="input.g.xrepsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrepld
            
            #add-point:AFTER FIELD xrepld name="input.a.xrepld"
            IF NOT cl_null(g_xrep_m.xrepld) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrep_m.xrepsite,g_xrep_m.xrepld,g_user,'3','N',g_wc_xrepld,g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrep_m.xrepld = ''
                  CALL s_desc_get_ld_desc(g_xrep_m.xrepld) RETURNING g_xrep_m.l_xrepld_desc
                  DISPLAY BY NAME g_xrep_m.xrepld,g_xrep_m.l_xrepld_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_ld_desc(g_xrep_m.xrepld) RETURNING g_xrep_m.l_xrepld_desc
               
               CALL s_ld_sel_glaa(g_xrep_m.xrepld,'glaa003|glaacomp|glaa001') RETURNING  g_sub_success,l_glaa003,g_comp,g_glaa001
               #關帳日期之年度期別
               CALL cl_get_para(g_enterprise,g_comp,'S-FIN-2007') RETURNING l_date
               LET g_xrep_m.xrep001 = YEAR(l_date) 
               LET g_xrep_m.xrep002 = MONTH(l_date)
               
               #抓取會計週期參照表之年度期別
               CALL s_get_accdate(l_glaa003,'',g_xrep_m.xrep001,g_xrep_m.xrep002)
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               LET g_xrep_m.xrepdocdt = l_pdate_e
               DISPLAY BY NAME g_xrep_m.l_xrepld_desc,g_xrep_m.xrep001,g_xrep_m.xrep002,g_xrep_m.xrepdocdt
            END IF
            
            IF NOT cl_null(g_xrep_m.xrepld) THEN
               #取的帳務中心的所屬法人
               SELECT ooef017 INTO g_comp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_xrep_m.xrepsite
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrepld
            #add-point:BEFORE FIELD xrepld name="input.b.xrepld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrepld
            #add-point:ON CHANGE xrepld name="input.g.xrepld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrep003
            
            #add-point:AFTER FIELD xrep003 name="input.a.xrep003"
            LET g_xrep_m.l_xrep003_desc = ' '
            IF NOT cl_null(g_xrep_m.xrep003) THEN
               LET g_errno = ''
               CALL s_employee_chk(g_xrep_m.xrep003) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_xrep_m.xrep003) RETURNING g_xrep_m.l_xrep003_desc
            DISPLAY BY NAME g_xrep_m.l_xrep003_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrep003
            #add-point:BEFORE FIELD xrep003 name="input.b.xrep003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrep003
            #add-point:ON CHANGE xrep003 name="input.g.xrep003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrepdocno
            #add-point:BEFORE FIELD xrepdocno name="input.b.xrepdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrepdocno
            
            #add-point:AFTER FIELD xrepdocno name="input.a.xrepdocno"
            IF NOT cl_null(g_xrep_m.xrepdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_xrepdocno_t) OR g_xrep_m.xrepdocno != g_xrepdocno_t)) THEN 
                  CALL s_fin_slip_chk(g_xrep_m.xrepdocno,g_prog,g_xrep_m.xrepld,'D-FIN-3001') RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrep_m.xrepdocno = g_xrepdocno_t
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#6 --s add
                  CALL s_control_chk_doc('1',g_xrep_m.xrepdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
                  IF g_sub_success AND l_flag1 THEN             
                  ELSE
                     LET g_xrep_m.xrepdocno = g_xrepdocno_t
                     NEXT FIELD CURRENT               
                  END IF
                  #161104-00046#6 --e add                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrepdocno
            #add-point:ON CHANGE xrepdocno name="input.g.xrepdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrep001
            #add-point:BEFORE FIELD xrep001 name="input.b.xrep001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrep001
            
            #add-point:AFTER FIELD xrep001 name="input.a.xrep001"
            IF NOT cl_null(g_xrep_m.xrep001) AND NOT cl_null(g_xrep_m.xrep002) THEN 
               CALL axrt470_01_xrep001_chk(g_xrep_m.xrep001,g_xrep_m.xrep002)RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_xrep_m.xrep001 = ''
                  LET g_xrep_m.xrep002 = ''
                  NEXT FIELD xrep001
                  DISPLAY BY NAME g_xrep_m.xrep001,g_xrep_m.xrep002
               END IF
               IF NOT cl_null(g_xrep_m.xrepdocdt) THEN 
                  IF g_xrep_m.xrep001 <> YEAR(g_xrep_m.xrepdocdt) OR g_xrep_m.xrep002 <> MONTH(g_xrep_m.xrepdocdt) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axr-00228"
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()  
                     NEXT FIELD xrepdocdt
                  END IF
               ELSE
                  #依年度+期別取得會計週期起迄日
                  CALL s_get_accdate(l_glaa003,'',g_xrep_m.xrep001,g_xrep_m.xrep002)
                  RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                            l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                  LET g_xrep_m.xrepdocdt = l_pdate_e
                  DISPLAY BY NAME g_xrep_m.xrepdocdt                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrep001
            #add-point:ON CHANGE xrep001 name="input.g.xrep001"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrep002
            #add-point:BEFORE FIELD xrep002 name="input.b.xrep002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrep002
            
            #add-point:AFTER FIELD xrep002 name="input.a.xrep002"
            IF NOT cl_null(g_xrep_m.xrep001) AND NOT cl_null(g_xrep_m.xrep002) THEN 
               CALL axrt470_01_xrep001_chk(g_xrep_m.xrep001,g_xrep_m.xrep002)RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_xrep_m.xrep002 = ''
                  NEXT FIELD xrep002
                  DISPLAY BY NAME g_xrep_m.xrep002
               END IF
               IF NOT cl_null(g_xrep_m.xrepdocdt) THEN 
                  IF g_xrep_m.xrep001 <> YEAR(g_xrep_m.xrepdocdt) OR g_xrep_m.xrep002 <> MONTH(g_xrep_m.xrepdocdt) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axr-00228"
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()  
                     NEXT FIELD xrepdocdt
                  END IF
               ELSE
                  #依年度+期別取得會計週期起迄日
                  CALL s_get_accdate(l_glaa003,'',g_xrep_m.xrep001,g_xrep_m.xrep002)
                  RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                            l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                  LET g_xrep_m.xrepdocdt = l_pdate_e
                  DISPLAY BY NAME g_xrep_m.xrepdocdt                 
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrep002
            #add-point:ON CHANGE xrep002 name="input.g.xrep002"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrepdocdt
            #add-point:BEFORE FIELD xrepdocdt name="input.b.xrepdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrepdocdt
            
            #add-point:AFTER FIELD xrepdocdt name="input.a.xrepdocdt"
            IF NOT cl_null(g_xrep_m.xrepdocdt) THEN
               #依年度+期別取得會計週期起迄日
               CALL s_get_accdate(l_glaa003,'',g_xrep_m.xrep001,g_xrep_m.xrep002)
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                         
               IF g_xrep_m.xrepdocdt < l_pdate_s OR g_xrep_m.xrepdocdt > l_pdate_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00238'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrepdocdt
            #add-point:ON CHANGE xrepdocdt name="input.g.xrepdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrepsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrepsite
            #add-point:ON ACTION controlp INFIELD xrepsite name="input.c.xrepsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrep_m.xrepsite
            LET g_qryparam.where = " ooefstus = 'Y' "  #161006-00005#39 add
            #CALL q_ooef001()   #161006-00005#39 mark
            CALL q_ooef001_46() #161006-00005#39 add
            LET g_xrep_m.xrepsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_xrep_m.xrepsite) RETURNING g_xrep_m.l_xrepsite_desc
            #取的帳務中心的所屬法人
            SELECT ooef017 INTO g_comp
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_xrep_m.xrepsite
            DISPLAY BY NAME g_xrep_m.xrepsite,g_xrep_m.l_xrepsite_desc
            NEXT FIELD xrepsite
            #END add-point
 
 
         #Ctrlp:input.c.xrepld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrepld
            #add-point:ON ACTION controlp INFIELD xrepld name="input.c.xrepld"
            INITIALIZE g_qryparam.* TO NULL
            CALL s_fin_account_center_sons_query('3',g_xrep_m.xrepsite,g_xrep_m.xrepdocdt,'1')
#160811-00009#3 mod s---
#            CALL s_fin_account_center_ld_str() RETURNING g_wc_xrepld
#            CALL s_fin_get_wc_str(g_wc_xrepld) RETURNING g_wc_xrepld
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc            
#160811-00009#3 mod e---
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrep_m.xrepld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_xrepld CLIPPED," "                        #160811-00009#3 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,"" #160811-00009#3 add
            CALL q_authorised_ld()
            LET g_xrep_m.xrepld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_xrep_m.xrepld) RETURNING g_xrep_m.l_xrepld_desc
            DISPLAY BY NAME g_xrep_m.xrepld,g_xrep_m.l_xrepld_desc
            NEXT FIELD xrepld
            #END add-point
 
 
         #Ctrlp:input.c.xrep003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrep003
            #add-point:ON ACTION controlp INFIELD xrep003 name="input.c.xrep003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
   			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrep_m.xrep003
            CALL q_ooag001()
            LET g_xrep_m.xrep003 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_xrep_m.xrep003) RETURNING g_xrep_m.l_xrep003_desc
            DISPLAY BY NAME g_xrep_m.xrep003,g_xrep_m.l_xrep003_desc
            NEXT FIELD xrep003
            #END add-point
 
 
         #Ctrlp:input.c.xrepdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrepdocno
            #add-point:ON ACTION controlp INFIELD xrepdocno name="input.c.xrepdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrep_m.xrepdocno
            LET g_qryparam.arg1 = l_glaa024
            #LET g_qryparam.arg2 = 'axrt470'   #160705-00042#11 160715 by sakura mark
            LET g_qryparam.arg2 = g_prog       #160705-00042#11 160715 by sakura add
            #161104-00046#6 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#6 --e add            
            CALL q_ooba002_1()
            LET g_xrep_m.xrepdocno = g_qryparam.return1
            DISPLAY BY NAME g_xrep_m.xrepdocno
            NEXT FIELD xrepdocno
            #END add-point
 
 
         #Ctrlp:input.c.xrep001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrep001
            #add-point:ON ACTION controlp INFIELD xrep001 name="input.c.xrep001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrep002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrep002
            #add-point:ON ACTION controlp INFIELD xrep002 name="input.c.xrep002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrepdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrepdocdt
            #add-point:ON ACTION controlp INFIELD xrepdocdt name="input.c.xrepdocdt"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
 
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
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
 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axrt470_01 
   
   #add-point:input段after input name="input.post_input"
   CALL cl_err_collect_init()
   LET r_success = TRUE 
   IF INT_FLAG THEN
      LET r_success = FALSE
      LET INT_FLAG = 0 
   ELSE
      CALL axrt470_01_xrep001_chk(g_xrep_m.xrep001,g_xrep_m.xrep002)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         LET r_success = FALSE
         LET r_xrepdocno = ''
         RETURN r_success,r_xrepdocno 
      END IF
      CALL axrt470_01_data_chk() RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         LET r_success = FALSE
         LET r_xrepdocno = ''
         RETURN r_success,r_xrepdocno 
      END IF
      
      #產生單頭
      CALL axrt470_01_ins_xrep() RETURNING g_sub_success,r_xrepdocno 

      IF NOT g_sub_success THEN
         LET r_success = FALSE        
      END IF
   END IF
   
   CALL cl_err_collect_show()
   RETURN r_success,r_xrepdocno 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt470_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt470_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 年度期別檢核
# Memo...........:
# Usage..........: CALL axrt470_01_xrep001_chk(p_xrep001,p_xrep002)
# Date & Author..: 160114 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt470_01_xrep001_chk(p_xrep001,p_xrep002)
DEFINE p_xrep001      LIKE xrep_t.xrep001
DEFINE p_xrep002      LIKE xrep_t.xrep002
DEFINE l_cnt          LIKE type_t.num10
DEFINE r_success      LIKE type_t.num5


   LET r_success = TRUE
   LET l_cnt = 0
   
   #1.存在所輸入年度期別當期之axrt470 資料 且為已確認
   SELECT COUNT(*) INTO l_cnt
     FROM xrep_t
    WHERE xrepent = g_enterprise
      AND xrepld = g_xrep_m.xrepld
      AND xrep001 = p_xrep001
      AND xrep002 = p_xrep002
      AND xrepstus = 'Y'
      
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00996'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #2.存在大於所輸入年度期別之axrt470
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM xrep_t
    WHERE xrepent = g_enterprise
      AND xrepld = g_xrep_m.xrepld
      AND ((xrep001 = p_xrep001  AND xrep002 > p_xrep002) OR xrep001 > p_xrep001)

   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00997'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #3.存在小於所輸入年度期別之axrt470 且未確認
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM xrep_t
    WHERE xrepent = g_enterprise
      AND xrepld = g_xrep_m.xrepld
      AND ((xrep001 = p_xrep001  AND xrep002 < p_xrep002) OR xrep001 < p_xrep001)
      AND xrepstus = 'N'

   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00998'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生遞延沖轉單頭檔xrep_t
# Memo...........:
# Usage..........: CALL axrt470_01_ins_xrep()
# Date & Author..: 160114 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt470_01_ins_xrep()
DEFINE l_gen_xrepdocno LIKE xrep_t.xrepdocno
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_xrep          RECORD 
       xrepent         LIKE xrep_t.xrepent,
       xrepsite        LIKE xrep_t.xrepsite,
       xrepcomp        LIKE xrep_t.xrepcomp,
       xrepdocno       LIKE xrep_t.xrepdocno,
       xrepdocdt       LIKE xrep_t.xrepdocdt,
       xrepld          LIKE xrep_t.xrepld,
       xrepstus        LIKE xrep_t.xrepstus,
       xrep001         LIKE xrep_t.xrep001,
       xrep002         LIKE xrep_t.xrep002,
       xrep003         LIKE xrep_t.xrep003,
       xrep004         LIKE xrep_t.xrep004,
       xrep005         LIKE xrep_t.xrep005,
       xrepownid       LIKE xrep_t.xrepownid,
       xrepowndp       LIKE xrep_t.xrepowndp,
       xrepcrtid       LIKE xrep_t.xrepcrtid,
       xrepcrtdp       LIKE xrep_t.xrepcrtdp,
       xrepcrtdt       LIKE xrep_t.xrepcrtdt,
       xrepmodid       LIKE xrep_t.xrepmodid,
       xrepmoddt       LIKE xrep_t.xrepmoddt,
       xrepcnfid       LIKE xrep_t.xrepcnfid,
       xrepcnfdt       LIKE xrep_t.xrepcnfdt
                       END RECORD
DEFINE r_success       LIKE type_t.num5
DEFINE r_docno         LIKE fmml_t.fmmldocno

   LET r_success = TRUE
   LET r_docno = ''
   
   CALL s_transaction_begin()

   #設定單據編號
   CALL s_aooi200_fin_gen_docno(g_xrep_m.xrepld,'','',g_xrep_m.xrepdocno,g_xrep_m.xrepdocdt,g_prog)
       RETURNING g_sub_success,l_gen_xrepdocno
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_gen_xrepdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      LET r_xrepdocno = ''
      RETURN r_success,r_xrepdocno
   END IF

   LET l_xrep.xrepent   = g_enterprise
   LET l_xrep.xrepsite  = g_xrep_m.xrepsite
   LET l_xrep.xrepcomp  = g_comp
   LET l_xrep.xrepdocno = l_gen_xrepdocno
   LET l_xrep.xrepdocdt = g_xrep_m.xrepdocdt
   LET l_xrep.xrepld    = g_xrep_m.xrepld
   LET l_xrep.xrepstus  = 'N'
   LET l_xrep.xrep001   = g_xrep_m.xrep001
   LET l_xrep.xrep002   = g_xrep_m.xrep002
   LET l_xrep.xrep003   = g_xrep_m.xrep003
   LET l_xrep.xrep004   = ''
   LET l_xrep.xrep005   = 'N'
   LET l_xrep.xrepownid = g_user
   LET l_xrep.xrepowndp = g_dept
   LET l_xrep.xrepcrtid = g_user
   LET l_xrep.xrepcrtdp = g_dept
   LET l_xrep.xrepcrtdt = cl_get_current()
   LET l_xrep.xrepmodid = ''
   LET l_xrep.xrepmoddt = ''
   LET l_xrep.xrepcnfid = ''
   LET l_xrep.xrepcnfdt = ''
   
   #產生單頭 xrep
   INSERT INTO xrep_t (xrepent,xrepsite,xrepcomp,xrepdocno,xrepdocdt,xrepld,xrepstus,
                       xrep001,xrep002,xrep003,xrep004,xrep005,xrepownid,xrepowndp,
                       xrepcrtid,xrepcrtdp,xrepcrtdt,xrepmodid,xrepmoddt,xrepcnfid,xrepcnfdt)
               VALUES (l_xrep.xrepent,l_xrep.xrepsite,l_xrep.xrepcomp,l_xrep.xrepdocno,l_xrep.xrepdocdt,l_xrep.xrepld,l_xrep.xrepstus,
                       l_xrep.xrep001,l_xrep.xrep002,l_xrep.xrep003,l_xrep.xrep004,l_xrep.xrep005,l_xrep.xrepownid,l_xrep.xrepowndp,
                       l_xrep.xrepcrtid,l_xrep.xrepcrtdp,l_xrep.xrepcrtdt,l_xrep.xrepmodid,l_xrep.xrepmoddt,l_xrep.xrepcnfid,l_xrep.xrepcnfdt)

   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = "ins xrep_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      LET r_docno = ''
      RETURN r_success,r_docno
   END IF 

   LET r_docno = l_gen_xrepdocno
   CALL axrt470_01_ins_xreq(r_docno)RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
      LET r_docno = ''
      RETURN r_success,r_docno
   END IF
   
   RETURN  r_success,r_docno
END FUNCTION

################################################################################
# Descriptions...: 檢查是否已存在資料(年度+期別+帳套)
# Memo...........:
# Usage..........: CALL axrt470_01_data_chk()
# Date & Author..: 160114 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt470_01_data_chk()
DEFINE l_cnt         LIKE type_t.num5
DEFINE l_del_docno   LIKE xrep_t.xrepdocno
DEFINE l_del_docdt   LIKE xrep_t.xrepdocdt
DEFINE l_xrepstus    LIKE xrep_t.xrepstus
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE

   #檢查該年度+期別+帳套不可重複
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xrep_t
    WHERE xrepent = g_enterprise
      AND xrepld = g_xrep_m.xrepld
      AND xrep001 = g_xrep_m.xrep001
      AND xrep002 = g_xrep_m.xrep002

   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF

   IF l_cnt > 0 THEN
      SELECT xrepstus INTO l_xrepstus
        FROM xrep_t
       WHERE xrepent = g_enterprise
         AND xrepld = g_xrep_m.xrepld
         AND xrep001 = g_xrep_m.xrep001
         AND xrep002 = g_xrep_m.xrep002
         
      IF l_xrepstus = 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00996'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      IF l_xrepstus = 'N' THEN
         IF NOT cl_ask_confirm("axr-00995") THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            SELECT xrepdocno,xrepdocdt INTO l_del_docno,l_del_docdt
              FROM xrep_t
             WHERE xrepent = g_enterprise
               AND xrepld = g_xrep_m.xrepld
               AND xrep001 = g_xrep_m.xrep001
               AND xrep002 = g_xrep_m.xrep002
               AND xrepstus = 'N'
               
            #刪除計提投資收益檔單頭檔
            DELETE FROM xrep_t
             WHERE xrepent = g_enterprise
               AND xrepld = g_xrep_m.xrepld
               AND xrepdocno = l_del_docno
         
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "del xrep_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            ELSE
               #更新最大單號
               IF NOT s_aooi200_fin_del_docno(g_xrep_m.xrepld,l_del_docno,l_del_docdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "aap-00266"
                  LET g_errparam.extend = l_del_docno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  RETURN r_success
               END IF
               
               #刪除計提投資收益檔單身
               DELETE FROM xreq_t 
                WHERE xreqent = g_enterprise AND xreqdocno = l_del_docno
                  AND xreqld = g_xrep_m.xrepld
                
               IF SQLCA.SQLcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "del xreq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  RETURN r_success
               END IF
            END IF 
         END IF 
      END IF          
   END IF  
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 產生遞延沖轉單身檔xreq_t
# Memo...........:
# Usage..........: CALL axrt470_01_ins_xreq(p_docno)
# Date & Author..: 160114 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt470_01_ins_xreq(p_docno)
DEFINE p_docno      LIKE xrep_t.xrepdocno
DEFINE l_sql        STRING
DEFINE l_glca003    LIKE glca_t.glca003
DEFINE l_xralseq1   LIKE xral_t.xralseq1
DEFINE l_countdo    LIKE type_t.num10     #紀錄是否有寫入
DEFINE l_xreq103    LIKE xreq_t.xreq103   #比較值
DEFINE l_xreq113    LIKE xreq_t.xreq113   #比較值
DEFINE l_xreq123    LIKE xreq_t.xreq123   #比較值
DEFINE l_xreq133    LIKE xreq_t.xreq133   #比較值
DEFINE l_xreq       RECORD                 #單身xreq_t
       xreqent      LIKE xreq_t.xreqent, 
       xreqdocno    LIKE xreq_t.xreqdocno,
       xreqld       LIKE xreq_t.xreqld,   
       xreqseq      LIKE xreq_t.xreqseq,  
       xreqorga     LIKE xreq_t.xreqorga, 
       xreq001      LIKE xreq_t.xreq001,  
       xreq002      LIKE xreq_t.xreq002,  
       xreq003      LIKE xreq_t.xreq003,  
       xreq004      LIKE xreq_t.xreq004,  
       xreq005      LIKE xreq_t.xreq005,  
       xreq006      LIKE xreq_t.xreq006,  
       xreq007      LIKE xreq_t.xreq007,  
       xreq008      LIKE xreq_t.xreq008,  
       xreq009      LIKE xreq_t.xreq009,  
       xreq010      LIKE xreq_t.xreq010,  
       xreq011      LIKE xreq_t.xreq011,  
       xreq012      LIKE xreq_t.xreq012,  
       xreq013      LIKE xreq_t.xreq013,  
       xreq014      LIKE xreq_t.xreq014,  
       xreq015      LIKE xreq_t.xreq015,  
       xreq016      LIKE xreq_t.xreq016,  
       xreq017      LIKE xreq_t.xreq017,  
       xreq018      LIKE xreq_t.xreq018,  
       xreq019      LIKE xreq_t.xreq019,  
       xreq020      LIKE xreq_t.xreq020,  
       xreq021      LIKE xreq_t.xreq021,  
       xreq022      LIKE xreq_t.xreq022,  
       xreq023      LIKE xreq_t.xreq023,  
       xreq024      LIKE xreq_t.xreq024,  
       xreq025      LIKE xreq_t.xreq025,  
       xreq026      LIKE xreq_t.xreq026,  
       xreq027      LIKE xreq_t.xreq027,  
       xreq028      LIKE xreq_t.xreq028,  
       xreq029      LIKE xreq_t.xreq029,  
       xreq030      LIKE xreq_t.xreq030,  
       xreq031      LIKE xreq_t.xreq031,  
       xreq032      LIKE xreq_t.xreq032,  
       xreq033      LIKE xreq_t.xreq033,  
       xreq034      LIKE xreq_t.xreq034,  
       xreq035      LIKE xreq_t.xreq035,  
       xreq036      LIKE xreq_t.xreq036,  
       xreq037      LIKE xreq_t.xreq037,  
       xreq038      LIKE xreq_t.xreq038,  
       xreq039      LIKE xreq_t.xreq039,  
       xreq040      LIKE xreq_t.xreq040,  
       xreq041      LIKE xreq_t.xreq041,  
       xreq042      LIKE xreq_t.xreq042,  
       xreq043      LIKE xreq_t.xreq043,  
       xreq044      LIKE xreq_t.xreq044,  
       xreq100      LIKE xreq_t.xreq100,  
       xreq101      LIKE xreq_t.xreq101,  
       xreq103      LIKE xreq_t.xreq103,  
       xreq113      LIKE xreq_t.xreq113,  
       xreq121      LIKE xreq_t.xreq121,  
       xreq123      LIKE xreq_t.xreq123,  
       xreq131      LIKE xreq_t.xreq131,  
       xreq133      LIKE xreq_t.xreq133  
                    END RECORD
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   LET l_countdo = 0
   
   INITIALIZE l_xreq.* TO NULL
   LET l_sql = " SELECT xreqent,xreqdocno,xreqld,xreqseq,xreqorga,xreq001,xreq002,xreq003,
                        xreq004,xreq005,xreq006,xreq007,xreq008,xreq009,xreq010,xreq011,
                        xreq012,xreq013,xreq014,xreq015,xreq016,xreq017,xreq018,xreq019,
                        xreq020,xreq021,xreq022,xreq023,xreq024,xreq025,xreq026,xreq027,
                        xreq028,xreq029,xreq030,xreq031,xreq032,xreq033,xreq034,xreq035,
                        xreq036,xreq037,xreq038,xreq039,xreq040,xreq041,xreq042,xreq043,
                        xreq044,xreq100,xreq101,xreq103,xreq113,xreq121,xreq123,xreq131,xreq133 ",
               "   FROM xrep_t,xreq_t ",
               "  WHERE xreqent = ",g_enterprise," ",
               "    AND xrepent = xreqent AND xrepdocno = xreqdocno AND xrepld = xreqld",
               "    AND xreqld = '",g_xrep_m.xrepld,"' ",
               "    AND (xreq041-xreq103) > 0 ",  #交易認列原幣-本期已實現原幣 > 0，須有沖銷餘額者
               "    AND xreq003 IN ('1','3') AND xrepstus = 'Y' "
   
   PREPARE sel_xreq_pre FROM l_sql
   DECLARE sel_xreq_cur CURSOR FOR sel_xreq_pre
   FOREACH sel_xreq_cur INTO l_xreq.xreqent,l_xreq.xreqdocno,l_xreq.xreqld,l_xreq.xreqseq,l_xreq.xreqorga,l_xreq.xreq001,l_xreq.xreq002,l_xreq.xreq003,
                             l_xreq.xreq004,l_xreq.xreq005,l_xreq.xreq006,l_xreq.xreq007,l_xreq.xreq008,l_xreq.xreq009,l_xreq.xreq010,l_xreq.xreq011,
                             l_xreq.xreq012,l_xreq.xreq013,l_xreq.xreq014,l_xreq.xreq015,l_xreq.xreq016,l_xreq.xreq017,l_xreq.xreq018,l_xreq.xreq019,
                             l_xreq.xreq020,l_xreq.xreq021,l_xreq.xreq022,l_xreq.xreq023,l_xreq.xreq024,l_xreq.xreq025,l_xreq.xreq026,l_xreq.xreq027,
                             l_xreq.xreq028,l_xreq.xreq029,l_xreq.xreq030,l_xreq.xreq031,l_xreq.xreq032,l_xreq.xreq033,l_xreq.xreq034,l_xreq.xreq035,
                             l_xreq.xreq036,l_xreq.xreq037,l_xreq.xreq038,l_xreq.xreq039,l_xreq.xreq040,l_xreq.xreq041,l_xreq.xreq042,l_xreq.xreq043,
                             l_xreq.xreq044,l_xreq.xreq100,l_xreq.xreq101,l_xreq.xreq103,l_xreq.xreq113,l_xreq.xreq121,l_xreq.xreq123,l_xreq.xreq131,l_xreq.xreq133
   
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH xreq_t"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_xreq.xreqent   = g_enterprise
      LET l_xreq.xreqdocno = p_docno
      LET l_xreq.xreqld    = g_xrep_m.xrepld
      SELECT MAX(xreqseq)+1 INTO l_xreq.xreqseq     
        FROM xreq_t WHERE xreqent = g_enterprise AND xreqdocno = p_docno AND xreqld = g_xrep_m.xrepld
      IF cl_null(l_xreq.xreqseq)THEN LET l_xreq.xreqseq = 1 END IF  
      LET l_xreq.xreq001 = g_xrep_m.xrep001
      LET l_xreq.xreq002 = g_xrep_m.xrep002   
      IF l_xreq.xreq003 = '1' THEN LET l_xreq.xreq003 = '2' END IF #遞延認列 > 每期沖轉
      IF l_xreq.xreq003 = '3' THEN LET l_xreq.xreq003 = '4' END IF #銷退折讓 > 折讓沖轉 
      IF cl_null(l_xreq.xreq040) THEN LET l_xreq.xreq040 = 0 END IF
      LET l_xreq.xreq008 = l_xreq.xreq040+1

      SELECT xral002 INTO l_xreq.xreq011 FROM xral_t 
      WHERE xralent = g_enterprise AND xralld = g_xrep_m.xrepld AND xral001 = l_xreq.xreq009 
        AND xralseq IN (SELECT xrakseq FROM xrak_t WHERE xrakent = g_enterprise AND xrakld = g_xrep_m.xrepld 
                           AND xrak001 = l_xreq.xreq009 AND ((l_xreq.xreq007 BETWEEN xrak008 AND xrak009) OR (l_xreq.xreq007 >= xrak008 AND xrak009 IS NULL) AND xrakstus = 'Y')) 
        AND xralseq1 = l_xreq.xreq008
      
      #匯率
      CALL axrt470_01_get_rate(g_xrep_m.xrepld,g_xrep_m.xrepdocdt,l_xreq.xreq100) RETURNING l_xreq.xreq101,l_xreq.xreq121,l_xreq.xreq131

      #寫入金額前判斷--------------------
      #取該符合攤銷類型條件之最大攤銷期別，供後續作比較
      SELECT MAX(xralseq1) INTO l_xralseq1 FROM xral_t 
      WHERE xralent = g_enterprise 
        AND xralld = g_xrep_m.xrepld 
        AND xral001 = l_xreq.xreq009 
        AND xralseq IN (SELECT xrakseq FROM xrak_t 
                         WHERE xrakent = g_enterprise   
                           AND xrakld = g_xrep_m.xrepld 
                           AND xrak001 = l_xreq.xreq009 
                           AND (l_xreq.xreq007 BETWEEN xrak008 AND xrak009) OR (l_xreq.xreq007 >= xrak008 AND xrak009 IS NULL) 
                           AND xrakstus = 'Y') 

      #若無符合條件之期別資料則報錯
      IF cl_null(l_xralseq1) THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'axr-00991'
         LET g_errparam.extend = 'ins xreq_t'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE   
         RETURN r_success
      END IF

      #檢查是最後一期攤銷取剩餘攤銷金額寫入，若非則取(剩餘攤銷金額)與(比例攤銷金額)金額小者寫入-----------
      IF l_xralseq1 = l_xreq.xreq008 THEN
         #若本期為最後一期攤銷> 使用剩餘金額寫入
         LET l_xreq.xreq103 = l_xreq.xreq041 - l_xreq.xreq103   #本期已實現原幣金額
         LET l_xreq.xreq113 = l_xreq.xreq042 - l_xreq.xreq113   #本期已實現本幣金額
         LET l_xreq.xreq123 = l_xreq.xreq042 - l_xreq.xreq123   #本期已實現本位幣二金額
         LET l_xreq.xreq133 = l_xreq.xreq042 - l_xreq.xreq133   #本期已實現本位幣三金額
      ELSE
         #(可沖餘額)比較(比例乘算結果)> 取金額較小的攤銷
         #可沖餘額
         LET l_xreq.xreq103 = l_xreq.xreq041 - l_xreq.xreq103   #本期已實現原幣金額
         LET l_xreq.xreq113 = l_xreq.xreq042 - l_xreq.xreq113   #本期已實現本幣金額
         LET l_xreq.xreq123 = l_xreq.xreq042 - l_xreq.xreq123   #本期已實現本位幣二金額
         LET l_xreq.xreq133 = l_xreq.xreq042 - l_xreq.xreq133   #本期已實現本位幣三金額
         
         #比例乘算結果
         LET l_xreq103 = l_xreq.xreq011/100 * l_xreq.xreq041   #本期已實現原幣金額
         CALL s_curr_round_ld('1',g_xrep_m.xrepld,g_glaa001,l_xreq103,2) RETURNING g_sub_success,g_errno,l_xreq103
         CALL s_afm_rate_money(g_xrep_m.xrepld,l_xreq.xreq101,l_xreq.xreq121,l_xreq.xreq131,l_xreq103)
            RETURNING l_xreq113,l_xreq123,l_xreq133  
            
         #取小者寫入
         IF l_xreq.xreq103 > l_xreq103 THEN
            LET l_xreq.xreq103 = l_xreq103   #本期已實現原幣金額
            LET l_xreq.xreq113 = l_xreq113   #本期已實現本幣金額
            LET l_xreq.xreq123 = l_xreq123   #本期已實現本位幣二金額
            LET l_xreq.xreq133 = l_xreq133   #本期已實現本位幣三金額
         END IF
      END IF

      #異動類型為3或4者負數呈現
      IF l_xreq.xreq003 = '3' OR l_xreq.xreq003 = '4' THEN
         LET l_xreq.xreq041 = l_xreq.xreq041 * -1 
         LET l_xreq.xreq103 = l_xreq.xreq103 * -1
         LET l_xreq.xreq113 = l_xreq.xreq113 * -1 
         LET l_xreq.xreq123 = l_xreq.xreq123 * -1 
         LET l_xreq.xreq133 = l_xreq.xreq133 * -1 
      END IF

      INSERT INTO xreq_t(xreqent,xreqdocno,xreqld,xreqseq,xreqorga,xreq001,xreq002,xreq003,
                         xreq004,xreq005,xreq006,xreq007,xreq008,xreq009,xreq010,xreq011,
                         xreq012,xreq013,xreq014,xreq015,xreq016,xreq017,xreq018,xreq019,
                         xreq020,xreq021,xreq022,xreq023,xreq024,xreq025,xreq026,xreq027,
                         xreq028,xreq029,xreq030,xreq031,xreq032,xreq033,xreq034,xreq035,
                         xreq036,xreq037,xreq038,xreq039,xreq040,xreq041,xreq042,xreq043,
                         xreq044,xreq100,xreq101,xreq103,xreq113,xreq121,xreq123,xreq131,xreq133)
                  VALUES(l_xreq.xreqent,l_xreq.xreqdocno,l_xreq.xreqld,l_xreq.xreqseq,l_xreq.xreqorga,l_xreq.xreq001,l_xreq.xreq002,l_xreq.xreq003,
                         l_xreq.xreq004,l_xreq.xreq005,l_xreq.xreq006,l_xreq.xreq007,l_xreq.xreq008,l_xreq.xreq009,l_xreq.xreq010,l_xreq.xreq011,
                         l_xreq.xreq012,l_xreq.xreq013,l_xreq.xreq014,l_xreq.xreq015,l_xreq.xreq016,l_xreq.xreq017,l_xreq.xreq018,l_xreq.xreq019,
                         l_xreq.xreq020,l_xreq.xreq021,l_xreq.xreq022,l_xreq.xreq023,l_xreq.xreq024,l_xreq.xreq025,l_xreq.xreq026,l_xreq.xreq027,
                         l_xreq.xreq028,l_xreq.xreq029,l_xreq.xreq030,l_xreq.xreq031,l_xreq.xreq032,l_xreq.xreq033,l_xreq.xreq034,l_xreq.xreq035,
                         l_xreq.xreq036,l_xreq.xreq037,l_xreq.xreq038,l_xreq.xreq039,l_xreq.xreq040,l_xreq.xreq041,l_xreq.xreq042,l_xreq.xreq043,
                         l_xreq.xreq044,l_xreq.xreq100,l_xreq.xreq101,l_xreq.xreq103,l_xreq.xreq113,l_xreq.xreq121,l_xreq.xreq123,l_xreq.xreq131,l_xreq.xreq133)
                  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'ins xreq_t'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE  
         EXIT FOREACH
      ELSE
         LET l_countdo = l_countdo + 1
      END IF
      
   END FOREACH
   
   IF l_countdo = 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      CALL cl_err()
      LET r_success = FALSE   
   END IF
    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 依匯率類型取匯率，多本幣則考慮匯率基準
# Memo...........:
# Usage..........: CALL axrt470_01_get_rate(p_ld,p_docdt,p_xreq100)
# Date & Author..: 160115 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt470_01_get_rate(p_ld,p_docdt,p_xreq100)
DEFINE p_ld        LIKE glaa_t.glaald    #帳套
DEFINE p_docdt     LIKE xrep_t.xrepdocdt #單據日期
DEFINE p_xreq100   LIKE xreq_t.xreq100   #交易幣別
DEFINE l_curr      LIKE glaa_t.glaa001   #基準設定幣別
DEFINE l_glca003   LIKE glca_t.glca003   #匯率類型 
DEFINE l_glaa001   LIKE glaa_t.glaa001   #本位幣一 
DEFINE l_glaa015   LIKE glaa_t.glaa015   #啟用本幣二否
DEFINE l_glaa016   LIKE glaa_t.glaa016   #本位幣二
DEFINE l_glaa017   LIKE glaa_t.glaa017   #本位幣二 換算基準
DEFINE l_glaa019   LIKE glaa_t.glaa019   #啟用本幣三否
DEFINE l_glaa020   LIKE glaa_t.glaa020   #本未幣三
DEFINE l_glaa021   LIKE glaa_t.glaa021   #本位幣三 換算基準
DEFINE r_rate1     LIKE ooao_t.ooao005   #匯率1
DEFINE r_rate2     LIKE ooao_t.ooao005   #匯率2
DEFINE r_rate3     LIKE ooao_t.ooao005   #匯率3

   CALL s_ld_sel_glaa(p_ld,'glaa001|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaacomp')
        RETURNING  g_sub_success,l_glaa001,l_glaa015,l_glaa016,l_glaa017,l_glaa019,l_glaa020,l_glaa021,g_comp 

   #匯率類型
   SELECT glca003 INTO l_glca003 FROM glaa_t,glca_t
    WHERE glaaent = g_enterprise AND glaald = p_ld AND glcaent = glaaent AND glcald = glaald AND glca001 = 'AR' AND glca002 <> '1'
  
   IF cl_null(l_glca003) THEN 
      #本位幣一
      CALL cl_get_para(g_enterprise,g_comp,'S-BAS-0011') RETURNING l_glca003
      CALL s_aooi160_get_exrate('2',p_ld,p_docdt,p_xreq100,l_glaa001,0,l_glca003)
           RETURNING r_rate1
           
      #本位幣二
      IF l_glaa015 = 'Y' THEN
         IF l_glaa017 = '1' THEN 
            #換算基準:交易幣
            LET l_curr = p_xreq100
         ELSE
            #換算基準:帳別本幣
            LET l_curr = l_glaa001
         END IF
         CALL s_aooi160_get_exrate('2',p_ld,p_docdt,l_curr,l_glaa016,0,l_glca003)
              RETURNING r_rate2
         CALL s_curr_round_ld('1',p_ld,l_curr,r_rate2,3) RETURNING g_sub_success,g_errno,r_rate2 #160829-00004#4     
      END IF

      #其他本位幣三
      IF l_glaa019 = 'Y' THEN
         IF l_glaa021 = '1' THEN
            #換算基準:交易幣
            LET l_curr = p_xreq100
         ELSE
            #換算基準:帳別本幣
            LET l_curr = l_glaa001
         END IF
         CALL s_aooi160_get_exrate('2',p_ld,p_docdt,l_curr,l_glaa020,0,l_glca003)
              RETURNING r_rate3
              CALL s_curr_round_ld('1',p_ld,l_curr,r_rate3,3) RETURNING g_sub_success,g_errno,r_rate3 #160829-00004#4
      END IF           
   ELSE 
      #本位幣一
      CALL s_aooi160_get_exrate_avg('2',p_ld,p_docdt,p_xreq100,l_glaa001,0,l_glca003)
           RETURNING g_sub_success,g_errno,r_rate1
      
      #本位幣二
      IF l_glaa015 = 'Y' THEN
         IF l_glaa017 = '1' THEN 
            #換算基準:交易幣
            LET l_curr = p_xreq100
         ELSE
            #換算基準:帳別本幣
            LET l_curr = l_glaa001 
         END IF
         CALL s_aooi160_get_exrate_avg('2',p_ld,p_docdt,l_curr,l_glaa016,0,l_glca003)
              RETURNING g_sub_success,g_errno,r_rate2
         CALL s_curr_round_ld('1',p_ld,l_curr,r_rate2,3) RETURNING g_sub_success,g_errno,r_rate2 #160829-00004#4     
      END IF

      #其他本位幣三
      IF l_glaa019 = 'Y' THEN
         IF l_glaa021 = '1' THEN
            #換算基準:交易幣
            LET l_curr = p_xreq100
            #換算基準:帳別本幣
            LET l_curr = l_glaa001
         END IF
         CALL s_aooi160_get_exrate_avg('2',p_ld,p_docdt,l_curr,l_glaa020,0,l_glca003)
              RETURNING g_sub_success,g_errno,r_rate3
         CALL s_curr_round_ld('1',p_ld,l_curr,r_rate3,3) RETURNING g_sub_success,g_errno,r_rate3 #160829-00004#4
         ELSE
      END IF
   END IF   
   #160829-00004#4 mark--(s)
   #CALL s_curr_round_ld('1',p_ld,l_glaa001,r_rate1,3) RETURNING g_sub_success,g_errno,r_rate1
   #CALL s_curr_round_ld('1',p_ld,l_glaa016,r_rate2,3) RETURNING g_sub_success,g_errno,r_rate2     
   #CALL s_curr_round_ld('1',p_ld,l_glaa020,r_rate3,3) RETURNING g_sub_success,g_errno,r_rate3      
   #160829-00004#4 mark--(e)
   CALL s_curr_round_ld('1',p_ld,p_xreq100,r_rate1,3) RETURNING g_sub_success,g_errno,r_rate1 #160829-00004#4
   IF cl_null(r_rate1) THEN LET r_rate1 = 0 END IF
   IF cl_null(r_rate2) THEN LET r_rate2 = 0 END IF
   IF cl_null(r_rate3) THEN LET r_rate3 = 0 END IF

   RETURN r_rate1,r_rate2,r_rate3
END FUNCTION

 
{</section>}
 
