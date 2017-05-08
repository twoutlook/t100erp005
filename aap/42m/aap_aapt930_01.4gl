#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt930_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2017-01-03 09:55:19), PR版次:0010(2017-01-12 10:44:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000095
#+ Filename...: aapt930_01
#+ Description: 批次產生
#+ Creator....: 05016(2014-11-03 14:45:17)
#+ Modifier...: 06821 -SD/PR- 06694
 
{</section>}
 
{<section id="aapt930_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151125-00006#2             By 06421     新增[編輯完單據後立即審核]和[編輯完單據後立即拋轉憑證]功能
#160905-00002#4  2016/09/05 By 06821     補入WHERE條件漏掉ENT的部分
#160909-00035#1  2016/10/03 By albireo   已取得帳務中心預設值,帳套應以帳務中心主帳套預設
#161006-00005#6  2016/10/12 By 08732     組織類型與職能開窗調整
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#161104-00024#6  2016/11/10 By 08729     處理DEFINE有星號
#161208-00026#15 2016/12/12 By 08732     SUB_程式中DEFINE / INSERT INTO 有星號整批調整(針對SELECT *的部份)
#161104-00046#8  2017/01/03 By 06821     單別預設值;資料依照單別user dept權限過濾單號
#161213-00023#2  2017/01/12  By 06694    新增aapp330_01元件單別參數，默認拋轉單別
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
PRIVATE type type_g_xrem_m        RECORD
       xremsite LIKE xrem_t.xremsite, 
   xremsite_desc LIKE type_t.chr80, 
   xremld LIKE xrem_t.xremld, 
   xremld_desc LIKE type_t.chr80, 
   xrem004 LIKE xrem_t.xrem004, 
   xrem004_desc LIKE type_t.chr80, 
   xremdocno LIKE xrem_t.xremdocno, 
   xrem001 LIKE xrem_t.xrem001, 
   xrem002 LIKE xrem_t.xrem002, 
   xremdocdt LIKE xrem_t.xremdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql STRING
DEFINE g_argv1  LIKE type_t.chr1
 
DEFINE g_user_slip_wc      STRING      #161104-00046#8 add 
#end add-point
 
DEFINE g_xrem_m        type_g_xrem_m
 
   DEFINE g_xremdocno_t LIKE xrem_t.xremdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt930_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt930_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_argv1
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
   DEFINE l_comp          LIKE xrem_t.xremcomp
   DEFINE l_strdate       LIKE xrem_t.xremdocdt
   DEFINE l_enddate       LIKE xrem_t.xremdocdt
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_glaa003       LIKE glaa_t.glaa003 #會計參照表號
   DEFINE l_glav006       LIKE glav_t.glav003 #會計期別
   DEFINE l_origin_str    STRING
   DEFINE r_xremdocno     LIKE xrem_t.xremdocno
   DEFINE r_success       LIKE type_t.chr1
   DEFINE p_argv1         LIKE type_t.chr1
   DEFINE l_flag          LIKE type_t.num5   #161104-00046#8   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt930_01 WITH FORM cl_ap_formpath("aap","aapt930_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET g_argv1 = p_argv1
   LET g_xrem_m.xrem001 = YEAR(g_today)
   LET g_xrem_m.xrem002 = MONTH(g_today)
   LET g_xrem_m.xremsite = g_site
   LET g_xrem_m.xrem004  = g_user
   #取得使用者所屬帳套法人
   #CALL s_fin_ld_carry('',g_user) RETURNING g_success,g_xrem_m.xremld,l_comp,g_errno    #160909-00035#1 mark
   #160909-00035#1-----s
   LET g_xrem_m.xremld = NULL
   SELECT glaald INTO g_xrem_m.xremld FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = (SELECT ooef017 FROM ooef_t WHERE ooefent = glaaent AND ooef001 = g_xrem_m.xremsite)
      AND glaa014 = 'Y'      
   #160909-00035#1-----e
   CALL s_desc_get_ld_desc(g_xrem_m.xremld) RETURNING g_xrem_m.xremld_desc
   CALL s_desc_get_department_desc(g_xrem_m.xremsite)RETURNING g_xrem_m.xremsite_desc           
   CALL s_desc_get_person_desc(g_xrem_m.xrem004) RETURNING g_xrem_m.xrem004_desc        
   #單據別參照表號
   SELECT glaa024 INTO l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xrem_m.xremld
   #取得會計周期參照表設定下拉   
   CALL aapt930_01_glaa003(g_xrem_m.xremld,g_xrem_m.xrem001)RETURNING l_glaa003
   #取得該期最大最小日期      
   IF g_argv1 = '1' THEN
      #下期最大最小日期 
      CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002+1)RETURNING l_strdate,l_enddate
      LET g_xrem_m.xremdocdt = l_strdate
   ELSE
      #當月最大最小日期
      CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002)RETURNING l_strdate,l_enddate
      LET g_xrem_m.xremdocdt = l_enddate
   END IF
   LET g_xrem_m.xremdocno = ''
   DISPLAY BY NAME g_xrem_m.xremld,g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xremdocdt,g_xrem_m.xremld_desc,
                   g_xrem_m.xremsite,g_xrem_m.xremsite_desc,g_xrem_m.xrem004_desc 
                   
   #161104-00046#8 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_xrem_m','','','','','','')RETURNING g_sub_success
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#8 --e add                    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004,g_xrem_m.xremdocno,g_xrem_m.xrem001, 
          g_xrem_m.xrem002,g_xrem_m.xremdocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremsite
            
            #add-point:AFTER FIELD xremsite name="input.a.xremsite"
            LET g_xrem_m.xremsite_desc = ''
            IF NOT cl_null(g_xrem_m.xremsite) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrem_m.xremsite,'','','3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_xrem_m.xremsite = ''
                  LET g_xrem_m.xremsite_desc = ''
                  DISPLAY BY NAME g_xrem_m.xremsite_desc
                  CALL cl_err()
                  NEXT FIELD xremsite
               END IF
            END IF
            LET g_xrem_m.xremsite_desc = s_desc_get_department_desc(g_xrem_m.xremsite)
            DISPLAY BY NAME g_xrem_m.xremsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremsite
            #add-point:BEFORE FIELD xremsite name="input.b.xremsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremsite
            #add-point:ON CHANGE xremsite name="input.g.xremsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremld
            
            #add-point:AFTER FIELD xremld name="input.a.xremld"
            LET g_xrem_m.xremld_desc = ''
            IF NOT cl_null(g_xrem_m.xremld) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrem_m.xremsite,g_xrem_m.xremld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrem_m.xremld = '' 
                  NEXT FIELD CURRENT
                END IF            
            #單據別參照表號
            SELECT glaa024 INTO l_glaa024
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_xrem_m.xremld
                END IF
            #重新取得會計週期參照表,最大期別,月份下拉
            CALL aapt930_01_glaa003(g_xrem_m.xremld,g_xrem_m.xrem001)RETURNING l_glaa003
            CALL s_desc_get_ld_desc(g_xrem_m.xremld) RETURNING g_xrem_m.xremld_desc
            DISPLAY BY NAME g_xrem_m.xremld_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremld
            #add-point:BEFORE FIELD xremld name="input.b.xremld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremld
            #add-point:ON CHANGE xremld name="input.g.xremld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem004
            
            #add-point:AFTER FIELD xrem004 name="input.a.xrem004"
            LET g_xrem_m.xrem004_desc = ' '
            IF NOT cl_null(g_xrem_m.xrem004) THEN        
               CALL s_employee_chk(g_xrem_m.xrem004) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_xrem_m.xrem004 = ''
                  NEXT FIELD CURRENT
               END IF     
            END IF
            CALL s_desc_get_person_desc(g_xrem_m.xrem004) RETURNING g_xrem_m.xrem004_desc
            DISPLAY BY NAME g_xrem_m.xrem004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem004
            #add-point:BEFORE FIELD xrem004 name="input.b.xrem004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem004
            #add-point:ON CHANGE xrem004 name="input.g.xrem004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremdocno
            #add-point:BEFORE FIELD xremdocno name="input.b.xremdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremdocno
            
            #add-point:AFTER FIELD xremdocno name="input.a.xremdocno"
             IF NOT cl_null(g_xrem_m.xremdocno) THEN 
               CALL s_fin_slip_chk(g_xrem_m.xremdocno,g_prog,g_xrem_m.xremld,l_glaa024)RETURNING g_sub_success,g_errno            
               IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrem_m.xremdocno = ''
                  NEXT FIELD CURRENT
               END IF     
               #161104-00046#8 --s add
               CALL s_control_chk_doc('1',g_xrem_m.xremdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_xrem_m.xremdocno = ''
                  NEXT FIELD CURRENT              
               END IF
               #161104-00046#8 --e add               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremdocno
            #add-point:ON CHANGE xremdocno name="input.g.xremdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem001
            #add-point:BEFORE FIELD xrem001 name="input.b.xrem001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem001
            
            #add-point:AFTER FIELD xrem001 name="input.a.xrem001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem001
            #add-point:ON CHANGE xrem001 name="input.g.xrem001"
            CALL aapt930_01_glaa003(g_xrem_m.xremld,g_xrem_m.xrem001)RETURNING l_glaa003
            IF g_argv1 = '1' THEN
               #下期最大最小日期 
               CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002+1)RETURNING l_strdate,l_enddate
            ELSE
               #當月最大最小日期
               CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002)RETURNING l_strdate,l_enddate
            END IF        
            CALL aapt930_01_glaa003(g_xrem_m.xremld,g_xrem_m.xrem001)RETURNING l_glaa003
            CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002)RETURNING l_strdate,l_enddate
            IF cl_null(l_strdate) OR cl_null(l_enddate)THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00129'
               LET g_errparam.extend = g_xrem_m.xrem001
               LET g_errparam.popup = TRUE
               CALL cl_err()                            
               NEXT FIELD CURRENT
            END IF
            IF g_argv1 = '1' THEN
               #下期第一天
               LET g_xrem_m.xremdocdt = l_strdate
            ELSE
               #當期最後一天
               LET g_xrem_m.xremdocdt = l_enddate
            END IF
            DISPLAY BY NAME g_xrem_m.xremdocdt
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem002
            #add-point:BEFORE FIELD xrem002 name="input.b.xrem002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem002
            
            #add-point:AFTER FIELD xrem002 name="input.a.xrem002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem002
            #add-point:ON CHANGE xrem002 name="input.g.xrem002"
            CALL aapt930_01_glaa003(g_xrem_m.xremld,g_xrem_m.xrem001)RETURNING l_glaa003
            IF g_argv1 = '1' THEN
               #下期最大最小日期 
               CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002+1)RETURNING l_strdate,l_enddate
            ELSE
               #當期最大最小日期
               CALL s_fin_date_get_period_range(l_glaa003,g_xrem_m.xrem001,g_xrem_m.xrem002)RETURNING l_strdate,l_enddate
            END IF    
            IF cl_null(l_strdate) OR cl_null(l_enddate)THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00129'
               LET g_errparam.extend = g_xrem_m.xrem002
               LET g_errparam.popup = TRUE
               CALL cl_err()                            
               NEXT FIELD CURRENT
            END IF
            IF g_argv1 = '1' THEN
               LET g_xrem_m.xremdocdt = l_strdate
            ELSE
               LET g_xrem_m.xremdocdt = l_enddate
            END IF
            DISPLAY BY NAME g_xrem_m.xremdocdt
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremdocdt
            #add-point:BEFORE FIELD xremdocdt name="input.b.xremdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremdocdt
            
            #add-point:AFTER FIELD xremdocdt name="input.a.xremdocdt"
            IF g_argv1 = '1' THEN
               IF g_xrem_m.xremdocdt > l_enddate OR g_xrem_m.xremdocdt < l_strdate THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00240'
                  LET g_errparam.extend = g_xrem_m.xremdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrem_m.xremdocdt = l_strdate
                  NEXT FIELD CURRENT
               END IF
            ELSE
               IF g_xrem_m.xremdocdt > l_enddate OR g_xrem_m.xremdocdt < l_strdate THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00225'
                  LET g_errparam.extend = g_xrem_m.xremdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrem_m.xremdocdt = l_enddate
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremdocdt
            #add-point:ON CHANGE xremdocdt name="input.g.xremdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xremsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremsite
            #add-point:ON ACTION controlp INFIELD xremsite name="input.c.xremsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrem_m.xremsite
            #LET g_qryparam.where = " ooef201 = 'Y' "   #161006-00005#6   mark
            #CALL q_ooef001()                           #161006-00005#6   mark
            CALL q_ooef001_46()                         #161006-00005#6   add 
            LET g_xrem_m.xremsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_xrem_m.xremsite) RETURNING g_xrem_m.xremsite_desc
            DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremsite_desc
            NEXT FIELD xremsite
            #END add-point
 
 
         #Ctrlp:input.c.xremld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremld
            #add-point:ON ACTION controlp INFIELD xremld name="input.c.xremld"
            INITIALIZE g_qryparam.* TO NULL
            CALL s_fin_account_center_sons_query('3',g_xrem_m.xremsite,g_today,'1')
            CALL s_fin_account_center_ld_str()RETURNING l_origin_str
            CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrem_m.xremld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            LET g_qryparam.where = " glaald IN ",l_origin_str CLIPPED ," "
            CALL q_authorised_ld()
            LET g_xrem_m.xremld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_xrem_m.xremld) RETURNING g_xrem_m.xremld_desc     
            DISPLAY BY NAME g_xrem_m.xremld,g_xrem_m.xremld_desc
            NEXT FIELD xremld 
            #END add-point
 
 
         #Ctrlp:input.c.xrem004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem004
            #add-point:ON ACTION controlp INFIELD xrem004 name="input.c.xrem004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrem_m.xrem004
            CALL q_ooag001()
            LET g_xrem_m.xrem004 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_xrem_m.xrem004) RETURNING g_xrem_m.xrem004_desc
            DISPLAY BY NAME g_xrem_m.xrem004,g_xrem_m.xrem004_desc
            NEXT FIELD xrem004
            #END add-point
 
 
         #Ctrlp:input.c.xremdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremdocno
            #add-point:ON ACTION controlp INFIELD xremdocno name="input.c.xremdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrem_m.xremdocno 
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#8 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc CLIPPED
            END IF
            #161104-00046#8 --e add            
            CALL q_ooba002_1()                          
            LET g_xrem_m.xremdocno  = g_qryparam.return1 
            DISPLAY g_xrem_m.xremdocno TO xremdocno      
            NEXT FIELD xremdocno                    
            #END add-point
 
 
         #Ctrlp:input.c.xrem001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem001
            #add-point:ON ACTION controlp INFIELD xrem001 name="input.c.xrem001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrem002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem002
            #add-point:ON ACTION controlp INFIELD xrem002 name="input.c.xrem002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xremdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremdocdt
            #add-point:ON ACTION controlp INFIELD xremdocdt name="input.c.xremdocdt"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            LET l_count =''
            SELECT count(*) INTO l_count
              FROM xrem_t
             WHERE xrement = g_enterprise
               AND xremld  = g_xrem_m.xremld
               AND xrem001 = g_xrem_m.xrem001
               AND xrem002 = g_xrem_m.xrem002
               AND xrem003 = 'AP'
               AND xrem006 = g_argv1
               AND xremstus != 'X'
               
            IF cl_null(l_count) THEN LET l_count = 0 END IF  
            
            IF l_count > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00006'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xrem001
            END IF

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
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_aapt930_01
      RETURN r_success,r_xremdocno
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt930_01 
   
   #add-point:input段after input name="input.post_input"
   CALL cl_err_collect_init()   
   CALL aapt930_01_ins_xrem(g_xrem_m.xremdocno) RETURNING g_sub_success,r_xremdocno   
   LET r_success = g_sub_success
   CALL cl_err_collect_show()  
   
   #151125-00006#2--s
   LET g_xrem_m.xremdocno  = r_xremdocno
   CALL aapt930_01_immediately_conf()
   CALL aapt930_01_immediately_gen()
   #151125-00006#2--e
   
   RETURN r_success,r_xremdocno
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt930_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt930_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 設定最大期別傳回會計周期參照表
# Memo...........:
# Usage..........: CALL aapt930_01_glaa003(p_ld,p_xrem001)
# Date & Author..: 2014/10/28 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt930_01_glaa003(p_ld,p_xrem001)
DEFINE p_ld       LIKE xrem_t.xremld
DEFINE p_xrem001  LIKE xrem_t.xrem001 #年度
DEFINE l_glav006  LIKE glav_t.glav006
DEFINE r_glaa003  LIKE glaa_t.glaa003 #會計週期參照表
DEFINE l_comb_value STRING
   
   WHENEVER ERROR CONTINUE
   LET r_glaa003 = ''
   LET l_comb_value = '1,2,3,4,5,6,7,8,9,10,11,12'
   #取得會計週期參照表
   SELECT glaa003 INTO r_glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_ld
      
   #取得年度最大期別            
   SELECT DISTINCT MAX(glav006)  INTO l_glav006
     FROM glav_t 
    WHERE glavent = g_enterprise
      AND glav001 = r_glaa003
      AND glav002 = p_xrem001
      
   CALL s_fin_set_comp_scc('xrem001','43')   #年度
   IF l_glav006 = 13 THEN
      CALL s_fin_set_comp_scc('xrem002','111')  #13期
   ELSE
       CALL cl_set_combo_items('xrem002',l_comb_value,l_comb_value)#12期
   END IF
   
   
   RETURN r_glaa003
END FUNCTION

################################################################################
# Descriptions...: 批次產生單頭
# Memo...........:
# Usage..........: CALL aapt930_01_ins_xrem(p_docno)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt930_01_ins_xrem(p_docno)
#DEFINE l_xrem RECORD LIKE xrem_t.* #161104-00024#6 mark
#161104-00024#6-add(s)
DEFINE l_xrem  RECORD  #暫估帳務主檔
       xrement   LIKE xrem_t.xrement, #企業編號
       xremownid LIKE xrem_t.xremownid, #資料所有者
       xremowndp LIKE xrem_t.xremowndp, #資料所屬部門
       xremcrtid LIKE xrem_t.xremcrtid, #資料建立者
       xremcrtdp LIKE xrem_t.xremcrtdp, #資料建立部門
       xremcrtdt LIKE xrem_t.xremcrtdt, #資料創建日
       xremmodid LIKE xrem_t.xremmodid, #資料修改者
       xremmoddt LIKE xrem_t.xremmoddt, #最近修改日
       xremcnfid LIKE xrem_t.xremcnfid, #資料確認者
       xremcnfdt LIKE xrem_t.xremcnfdt, #資料確認日
       xremstus  LIKE xrem_t.xremstus, #狀態碼
       xremsite  LIKE xrem_t.xremsite, #營運據點
       xremld    LIKE xrem_t.xremld, #帳套
       xremcomp  LIKE xrem_t.xremcomp, #法人
       xremdocno LIKE xrem_t.xremdocno, #單據編號
       xremdocdt LIKE xrem_t.xremdocdt, #單據日期
       xrem001   LIKE xrem_t.xrem001, #年度
       xrem002   LIKE xrem_t.xrem002, #期別
       xrem003   LIKE xrem_t.xrem003, #來源模組
       xrem004   LIKE xrem_t.xrem004, #帳務人員
       xrem005   LIKE xrem_t.xrem005, #傳票號碼
       xrem006   LIKE xrem_t.xrem006, #暫估類型
       xremud001 LIKE xrem_t.xremud001, #自定義欄位(文字)001
       xremud002 LIKE xrem_t.xremud002, #自定義欄位(文字)002
       xremud003 LIKE xrem_t.xremud003, #自定義欄位(文字)003
       xremud004 LIKE xrem_t.xremud004, #自定義欄位(文字)004
       xremud005 LIKE xrem_t.xremud005, #自定義欄位(文字)005
       xremud006 LIKE xrem_t.xremud006, #自定義欄位(文字)006
       xremud007 LIKE xrem_t.xremud007, #自定義欄位(文字)007
       xremud008 LIKE xrem_t.xremud008, #自定義欄位(文字)008
       xremud009 LIKE xrem_t.xremud009, #自定義欄位(文字)009
       xremud010 LIKE xrem_t.xremud010, #自定義欄位(文字)010
       xremud011 LIKE xrem_t.xremud011, #自定義欄位(數字)011
       xremud012 LIKE xrem_t.xremud012, #自定義欄位(數字)012
       xremud013 LIKE xrem_t.xremud013, #自定義欄位(數字)013
       xremud014 LIKE xrem_t.xremud014, #自定義欄位(數字)014
       xremud015 LIKE xrem_t.xremud015, #自定義欄位(數字)015
       xremud016 LIKE xrem_t.xremud016, #自定義欄位(數字)016
       xremud017 LIKE xrem_t.xremud017, #自定義欄位(數字)017
       xremud018 LIKE xrem_t.xremud018, #自定義欄位(數字)018
       xremud019 LIKE xrem_t.xremud019, #自定義欄位(數字)019
       xremud020 LIKE xrem_t.xremud020, #自定義欄位(數字)020
       xremud021 LIKE xrem_t.xremud021, #自定義欄位(日期時間)021
       xremud022 LIKE xrem_t.xremud022, #自定義欄位(日期時間)022
       xremud023 LIKE xrem_t.xremud023, #自定義欄位(日期時間)023
       xremud024 LIKE xrem_t.xremud024, #自定義欄位(日期時間)024
       xremud025 LIKE xrem_t.xremud025, #自定義欄位(日期時間)025
       xremud026 LIKE xrem_t.xremud026, #自定義欄位(日期時間)026
       xremud027 LIKE xrem_t.xremud027, #自定義欄位(日期時間)027
       xremud028 LIKE xrem_t.xremud028, #自定義欄位(日期時間)028
       xremud029 LIKE xrem_t.xremud029, #自定義欄位(日期時間)029
       xremud030 LIKE xrem_t.xremud030  #自定義欄位(日期時間)030
           END RECORD
#161104-00024#6-add(e)
DEFINE p_docno     LIKE xrem_t.xremdocno #單據別
DEFINE r_xremdocno LIKE xrem_t.xremdocno
DEFINE r_success   LIKE type_t.chr1
DEFINE l_comp      LIKE xrem_t.xremcomp   
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_xremdocno = ''
   #取得帳套所屬法人 
   CALL s_fin_ld_carry(g_xrem_m.xremld,'')RETURNING g_sub_success,g_xrem_m.xremld,l_comp,g_errno 
   #自動編號
   IF g_argv1 = '1' THEN
    #  CALL s_aooi200_gen_docno(g_xrem_m.xremsite,p_docno,g_xrem_m.xremdocdt,'aapt930') RETURNING r_success,r_xremdocno
      CALL s_aooi200_fin_gen_docno(g_xrem_m.xremld,'','',p_docno,g_xrem_m.xremdocdt,'aapt930')  
         RETURNING r_success,r_xremdocno
   ELSE      
   #  CALL s_aooi200_gen_docno(g_xrem_m.xremsite,p_docno,g_xrem_m.xremdocdt,'aapt931') RETURNING r_success,r_xremdocno
      CALL s_aooi200_fin_gen_docno(g_xrem_m.xremld,'','',p_docno,g_xrem_m.xremdocdt,'aapt931')  
         RETURNING r_success,r_xremdocno
   END IF
   
   IF NOT r_success THEN
      RETURN r_success,r_xremdocno
   END IF
   INITIALIZE l_xrem.* TO NULL
   LET l_xrem.xrement   = g_enterprise
   LET l_xrem.xremownid = g_user
   LET l_xrem.xremowndp = g_dept 
   LET l_xrem.xremcrtid = g_user
   LET l_xrem.xremcrtdt = g_today
   LET l_xrem.xremcrtdp = g_dept
   LET l_xrem.xremmodid = ''       #資料修改者
   LET l_xrem.xremmoddt = ''       #最近修改日
   LET l_xrem.xremcnfid = ''       #資料確認者
   LET l_xrem.xremcnfdt = ''       #資料確認日
   LET l_xrem.xremstus  = 'N'      #狀態碼
   LET l_xrem.xremsite  = g_xrem_m.xremsite
   LET l_xrem.xremld    = g_xrem_m.xremld
   LET l_xrem.xremcomp  = l_comp
   LET l_xrem.xremdocno = r_xremdocno
   LET l_xrem.xremdocdt = g_xrem_m.xremdocdt
   LET l_xrem.xrem001   = g_xrem_m.xrem001   #年度
   LET l_xrem.xrem002   = g_xrem_m.xrem002   #期別
   LET l_xrem.xrem003   = 'AP'               #來源模組
   LET l_xrem.xrem004   = g_xrem_m.xrem004   #帳務人員
   IF g_argv1 = '1' THEN 
      LET l_xrem.xrem006 = '1'               
   ELSE
      LET l_xrem.xrem006 = '2'
   END IF      
   
   #INSERT INTO xrem_t VALUES (l_xrem.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO xrem_t (xrement,xremownid,xremowndp,xremcrtid,xremcrtdp,
                       xremcrtdt,xremmodid,xremmoddt,xremcnfid,xremcnfdt,
                       xremstus,xremsite,xremld,xremcomp,xremdocno,
                       xremdocdt,
                       xrem001,xrem002,xrem003,xrem004,xrem005,
                       xrem006,
                       xremud001,xremud002,xremud003,xremud004,xremud005,
                       xremud006,xremud007,xremud008,xremud009,xremud010,
                       xremud011,xremud012,xremud013,xremud014,xremud015,
                       xremud016,xremud017,xremud018,xremud019,xremud020,
                       xremud021,xremud022,xremud023,xremud024,xremud025,
                       xremud026,xremud027,xremud028,xremud029,xremud030
                      )
   VALUES (l_xrem.xrement,l_xrem.xremownid,l_xrem.xremowndp,l_xrem.xremcrtid,l_xrem.xremcrtdp,
           l_xrem.xremcrtdt,l_xrem.xremmodid,l_xrem.xremmoddt,l_xrem.xremcnfid,l_xrem.xremcnfdt,
           l_xrem.xremstus,l_xrem.xremsite,l_xrem.xremld,l_xrem.xremcomp,l_xrem.xremdocno,
           l_xrem.xremdocdt,
           l_xrem.xrem001,l_xrem.xrem002,l_xrem.xrem003,l_xrem.xrem004,l_xrem.xrem005,
           l_xrem.xrem006,
           l_xrem.xremud001,l_xrem.xremud002,l_xrem.xremud003,l_xrem.xremud004,l_xrem.xremud005,
           l_xrem.xremud006,l_xrem.xremud007,l_xrem.xremud008,l_xrem.xremud009,l_xrem.xremud010,
           l_xrem.xremud011,l_xrem.xremud012,l_xrem.xremud013,l_xrem.xremud014,l_xrem.xremud015,
           l_xrem.xremud016,l_xrem.xremud017,l_xrem.xremud018,l_xrem.xremud019,l_xrem.xremud020,
           l_xrem.xremud021,l_xrem.xremud022,l_xrem.xremud023,l_xrem.xremud024,l_xrem.xremud025,
           l_xrem.xremud026,l_xrem.xremud027,l_xrem.xremud028,l_xrem.xremud029,l_xrem.xremud030
          )
   #161108-00017#4 add end---
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins xrem_t"
      LET g_errparam.popup = TRUE
      LET r_success = FALSE
      CALL cl_err()
      RETURN r_success,r_xremdocno
   END IF
   CALL aapt930_01_ins_xren(r_xremdocno)RETURNING g_sub_success 
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins xren_t"
      LET g_errparam.popup = TRUE
      LET r_success = FALSE
      CALL cl_err()   
   END IF   
   
   RETURN r_success,r_xremdocno
END FUNCTION

################################################################################
# Descriptions...: 產生單身
# Memo...........:
# Usage..........: CALL aapt930_01_ins_xren(p_xremdocno)
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt930_01_ins_xren(p_xremdocno)
#DEFINE l_xren RECORD LIKE xren_t.* #161104-00024#6 mark
#DEFINE l_xrea RECORD LIKE xrea_t.* #161104-00024#6 mark
#DEFINE l_xrem RECORD LIKE xrem_t.* #161104-00024#6 mark
#161104-00024#6-add(s)
DEFINE l_xren  RECORD  #暫估帳務明細檔
       xrenent   LIKE xren_t.xrenent, #企業編號
       xrendocno LIKE xren_t.xrendocno, #單據編號
       xrenseq   LIKE xren_t.xrenseq, #序號
       xren001   LIKE xren_t.xren001, #年度
       xren002   LIKE xren_t.xren002, #期別
       xren003   LIKE xren_t.xren003, #來源模組
       xren004   LIKE xren_t.xren004, #帳款單性質
       xren005   LIKE xren_t.xren005, #立帳單據號碼
       xren006   LIKE xren_t.xren006, #項次
       xren007   LIKE xren_t.xren007, #分期帳款序
       xren008   LIKE xren_t.xren008, #立帳日期
       xren009   LIKE xren_t.xren009, #帳款對象
       xren010   LIKE xren_t.xren010, #收款對象
       xren011   LIKE xren_t.xren011, #部門
       xren012   LIKE xren_t.xren012, #責任中心
       xren013   LIKE xren_t.xren013, #區域
       xren014   LIKE xren_t.xren014, #客群
       xren015   LIKE xren_t.xren015, #產品類別
       xren016   LIKE xren_t.xren016, #人員
       xren017   LIKE xren_t.xren017, #專案編號
       xren018   LIKE xren_t.xren018, #WBS編號
       xren019   LIKE xren_t.xren019, #應收付科目
       xrenorga  LIKE xren_t.xrenorga, #來源組織
       xren020   LIKE xren_t.xren020, #經營方式
       xren021   LIKE xren_t.xren021, #通路
       xren022   LIKE xren_t.xren022, #品牌
       xren023   LIKE xren_t.xren023, #自由核算項一
       xren024   LIKE xren_t.xren024, #自由核算項二
       xren025   LIKE xren_t.xren025, #自由核算項三
       xren026   LIKE xren_t.xren026, #自由核算項四
       xren027   LIKE xren_t.xren027, #自由核算項五
       xren028   LIKE xren_t.xren028, #自由核算項六
       xren029   LIKE xren_t.xren029, #自由核算項七
       xren030   LIKE xren_t.xren030, #自由核算項八
       xren031   LIKE xren_t.xren031, #自由核算項九
       xren032   LIKE xren_t.xren032, #自由核算項十
       xren033   LIKE xren_t.xren033, #摘要
       xren040   LIKE xren_t.xren040, #稅別
       xren041   LIKE xren_t.xren041, #稅率
       xren042   LIKE xren_t.xren042, #稅別會科
       xren043   LIKE xren_t.xren043, #暫估費用/暫估收入科目
       xren100   LIKE xren_t.xren100, #幣別
       xren101   LIKE xren_t.xren101, #匯率
       xren103   LIKE xren_t.xren103, #原幣暫估金額
       xren104   LIKE xren_t.xren104, #原幣暫估稅額
       xren105   LIKE xren_t.xren105, #原幣暫估含稅金額
       xren113   LIKE xren_t.xren113, #本幣暫估金額
       xren114   LIKE xren_t.xren114, #本幣暫估稅額
       xren115   LIKE xren_t.xren115, #本幣暫估含稅金額
       xren121   LIKE xren_t.xren121, #本位幣二匯率
       xren123   LIKE xren_t.xren123, #本位幣二暫估金額
       xren124   LIKE xren_t.xren124, #本位幣二暫估稅額
       xren125   LIKE xren_t.xren125, #本位幣二暫估含稅金額
       xren131   LIKE xren_t.xren131, #本位幣三匯率
       xren133   LIKE xren_t.xren133, #本位幣三暫估金額
       xren134   LIKE xren_t.xren134, #本位幣三暫估稅額
       xren135   LIKE xren_t.xren135, #本位幣三暫估含稅金額
       xrenud001 LIKE xren_t.xrenud001, #自定義欄位(文字)001
       xrenud002 LIKE xren_t.xrenud002, #自定義欄位(文字)002
       xrenud003 LIKE xren_t.xrenud003, #自定義欄位(文字)003
       xrenud004 LIKE xren_t.xrenud004, #自定義欄位(文字)004
       xrenud005 LIKE xren_t.xrenud005, #自定義欄位(文字)005
       xrenud006 LIKE xren_t.xrenud006, #自定義欄位(文字)006
       xrenud007 LIKE xren_t.xrenud007, #自定義欄位(文字)007
       xrenud008 LIKE xren_t.xrenud008, #自定義欄位(文字)008
       xrenud009 LIKE xren_t.xrenud009, #自定義欄位(文字)009
       xrenud010 LIKE xren_t.xrenud010, #自定義欄位(文字)010
       xrenud011 LIKE xren_t.xrenud011, #自定義欄位(數字)011
       xrenud012 LIKE xren_t.xrenud012, #自定義欄位(數字)012
       xrenud013 LIKE xren_t.xrenud013, #自定義欄位(數字)013
       xrenud014 LIKE xren_t.xrenud014, #自定義欄位(數字)014
       xrenud015 LIKE xren_t.xrenud015, #自定義欄位(數字)015
       xrenud016 LIKE xren_t.xrenud016, #自定義欄位(數字)016
       xrenud017 LIKE xren_t.xrenud017, #自定義欄位(數字)017
       xrenud018 LIKE xren_t.xrenud018, #自定義欄位(數字)018
       xrenud019 LIKE xren_t.xrenud019, #自定義欄位(數字)019
       xrenud020 LIKE xren_t.xrenud020, #自定義欄位(數字)020
       xrenud021 LIKE xren_t.xrenud021, #自定義欄位(日期時間)021
       xrenud022 LIKE xren_t.xrenud022, #自定義欄位(日期時間)022
       xrenud023 LIKE xren_t.xrenud023, #自定義欄位(日期時間)023
       xrenud024 LIKE xren_t.xrenud024, #自定義欄位(日期時間)024
       xrenud025 LIKE xren_t.xrenud025, #自定義欄位(日期時間)025
       xrenud026 LIKE xren_t.xrenud026, #自定義欄位(日期時間)026
       xrenud027 LIKE xren_t.xrenud027, #自定義欄位(日期時間)027
       xrenud028 LIKE xren_t.xrenud028, #自定義欄位(日期時間)028
       xrenud029 LIKE xren_t.xrenud029, #自定義欄位(日期時間)029
       xrenud030 LIKE xren_t.xrenud030  #自定義欄位(日期時間)030
           END RECORD
DEFINE l_xrea  RECORD  #往來帳科目月結檔
       xreaent   LIKE xrea_t.xreaent, #企業編號
       xreacomp  LIKE xrea_t.xreacomp, #法人
       xreasite  LIKE xrea_t.xreasite, #帳務組織
       xreald    LIKE xrea_t.xreald, #帳套
       xrea001   LIKE xrea_t.xrea001, #年度
       xrea002   LIKE xrea_t.xrea002, #期別
       xrea003   LIKE xrea_t.xrea003, #來源模組
       xrea004   LIKE xrea_t.xrea004, #帳款單性質
       xrea005   LIKE xrea_t.xrea005, #單據號碼
       xrea006   LIKE xrea_t.xrea006, #項次
       xrea007   LIKE xrea_t.xrea007, #分期帳款序
       xrea008   LIKE xrea_t.xrea008, #立帳日期
       xrea009   LIKE xrea_t.xrea009, #帳款對象
       xrea010   LIKE xrea_t.xrea010, #收款對象
       xrea011   LIKE xrea_t.xrea011, #部門
       xrea012   LIKE xrea_t.xrea012, #責任中心
       xrea013   LIKE xrea_t.xrea013, #區域
       xrea014   LIKE xrea_t.xrea014, #客群
       xrea015   LIKE xrea_t.xrea015, #產品類別
       xrea016   LIKE xrea_t.xrea016, #人員
       xrea017   LIKE xrea_t.xrea017, #專案編號
       xrea018   LIKE xrea_t.xrea018, #WBS編號
       xrea019   LIKE xrea_t.xrea019, #應收付科目
       xreaorga  LIKE xrea_t.xreaorga, #來源組織
       xrea020   LIKE xrea_t.xrea020, #經營方式
       xrea021   LIKE xrea_t.xrea021, #通路
       xrea022   LIKE xrea_t.xrea022, #品牌
       xrea023   LIKE xrea_t.xrea023, #自由核算項一
       xrea024   LIKE xrea_t.xrea024, #自由核算項二
       xrea025   LIKE xrea_t.xrea025, #自由核算項三
       xrea026   LIKE xrea_t.xrea026, #自由核算項四
       xrea027   LIKE xrea_t.xrea027, #自由核算項五
       xrea028   LIKE xrea_t.xrea028, #自由核算項六
       xrea029   LIKE xrea_t.xrea029, #自由核算項七
       xrea030   LIKE xrea_t.xrea030, #自由核算項八
       xrea031   LIKE xrea_t.xrea031, #自由核算項九
       xrea032   LIKE xrea_t.xrea032, #自由核算項十
       xrea033   LIKE xrea_t.xrea033, #摘要
       xrea034   LIKE xrea_t.xrea034, #發票日期
       xrea035   LIKE xrea_t.xrea035, #出貨單據日期
       xrea036   LIKE xrea_t.xrea036, #交易認定日期
       xrea037   LIKE xrea_t.xrea037, #出入庫扣帳日期
       xrea038   LIKE xrea_t.xrea038, #應收款日
       xrea039   LIKE xrea_t.xrea039, #信評等級
       xrea040   LIKE xrea_t.xrea040, #稅別
       xrea041   LIKE xrea_t.xrea041, #稅率
       xrea042   LIKE xrea_t.xrea042, #No Use
       xrea043   LIKE xrea_t.xrea043, #No Use
       xrea100   LIKE xrea_t.xrea100, #幣別
       xrea101   LIKE xrea_t.xrea101, #交易匯率
       xrea102   LIKE xrea_t.xrea102, #重評匯率
       xrea103   LIKE xrea_t.xrea103, #原幣未沖含稅金額
       xrea104   LIKE xrea_t.xrea104, #原幣暫估未沖未稅金額
       xrea105   LIKE xrea_t.xrea105, #原幣暫估未沖稅額
       xrea106   LIKE xrea_t.xrea106, #原幣暫估未沖含稅金額
       xrea113   LIKE xrea_t.xrea113, #本幣未沖含稅金額
       xrea114   LIKE xrea_t.xrea114, #本幣暫估未沖未稅金額
       xrea115   LIKE xrea_t.xrea115, #本幣暫估未沖稅額
       xrea116   LIKE xrea_t.xrea116, #本幣暫估未沖含稅金額
       xrea122   LIKE xrea_t.xrea122, #本位幣二重評匯率
       xrea123   LIKE xrea_t.xrea123, #本位幣二未沖含稅金額
       xrea132   LIKE xrea_t.xrea132, #本位幣三重評匯率
       xrea133   LIKE xrea_t.xrea133, #本位幣三未沖含稅金額
       xreaud001 LIKE xrea_t.xreaud001, #自定義欄位(文字)001
       xreaud002 LIKE xrea_t.xreaud002, #自定義欄位(文字)002
       xreaud003 LIKE xrea_t.xreaud003, #自定義欄位(文字)003
       xreaud004 LIKE xrea_t.xreaud004, #自定義欄位(文字)004
       xreaud005 LIKE xrea_t.xreaud005, #自定義欄位(文字)005
       xreaud006 LIKE xrea_t.xreaud006, #自定義欄位(文字)006
       xreaud007 LIKE xrea_t.xreaud007, #自定義欄位(文字)007
       xreaud008 LIKE xrea_t.xreaud008, #自定義欄位(文字)008
       xreaud009 LIKE xrea_t.xreaud009, #自定義欄位(文字)009
       xreaud010 LIKE xrea_t.xreaud010, #自定義欄位(文字)010
       xreaud011 LIKE xrea_t.xreaud011, #自定義欄位(數字)011
       xreaud012 LIKE xrea_t.xreaud012, #自定義欄位(數字)012
       xreaud013 LIKE xrea_t.xreaud013, #自定義欄位(數字)013
       xreaud014 LIKE xrea_t.xreaud014, #自定義欄位(數字)014
       xreaud015 LIKE xrea_t.xreaud015, #自定義欄位(數字)015
       xreaud016 LIKE xrea_t.xreaud016, #自定義欄位(數字)016
       xreaud017 LIKE xrea_t.xreaud017, #自定義欄位(數字)017
       xreaud018 LIKE xrea_t.xreaud018, #自定義欄位(數字)018
       xreaud019 LIKE xrea_t.xreaud019, #自定義欄位(數字)019
       xreaud020 LIKE xrea_t.xreaud020, #自定義欄位(數字)020
       xreaud021 LIKE xrea_t.xreaud021, #自定義欄位(日期時間)021
       xreaud022 LIKE xrea_t.xreaud022, #自定義欄位(日期時間)022
       xreaud023 LIKE xrea_t.xreaud023, #自定義欄位(日期時間)023
       xreaud024 LIKE xrea_t.xreaud024, #自定義欄位(日期時間)024
       xreaud025 LIKE xrea_t.xreaud025, #自定義欄位(日期時間)025
       xreaud026 LIKE xrea_t.xreaud026, #自定義欄位(日期時間)026
       xreaud027 LIKE xrea_t.xreaud027, #自定義欄位(日期時間)027
       xreaud028 LIKE xrea_t.xreaud028, #自定義欄位(日期時間)028
       xreaud029 LIKE xrea_t.xreaud029, #自定義欄位(日期時間)029
       xreaud030 LIKE xrea_t.xreaud030, #自定義欄位(日期時間)030
       xrea044   LIKE xrea_t.xrea044, #發票號碼
       xrea045   LIKE xrea_t.xrea045  #交易條件
           END RECORD
DEFINE l_xrem  RECORD  #暫估帳務主檔
       xrement   LIKE xrem_t.xrement, #企業編號
       xremownid LIKE xrem_t.xremownid, #資料所有者
       xremowndp LIKE xrem_t.xremowndp, #資料所屬部門
       xremcrtid LIKE xrem_t.xremcrtid, #資料建立者
       xremcrtdp LIKE xrem_t.xremcrtdp, #資料建立部門
       xremcrtdt LIKE xrem_t.xremcrtdt, #資料創建日
       xremmodid LIKE xrem_t.xremmodid, #資料修改者
       xremmoddt LIKE xrem_t.xremmoddt, #最近修改日
       xremcnfid LIKE xrem_t.xremcnfid, #資料確認者
       xremcnfdt LIKE xrem_t.xremcnfdt, #資料確認日
       xremstus  LIKE xrem_t.xremstus, #狀態碼
       xremsite  LIKE xrem_t.xremsite, #營運據點
       xremld    LIKE xrem_t.xremld, #帳套
       xremcomp  LIKE xrem_t.xremcomp, #法人
       xremdocno LIKE xrem_t.xremdocno, #單據編號
       xremdocdt LIKE xrem_t.xremdocdt, #單據日期
       xrem001   LIKE xrem_t.xrem001, #年度
       xrem002   LIKE xrem_t.xrem002, #期別
       xrem003   LIKE xrem_t.xrem003, #來源模組
       xrem004   LIKE xrem_t.xrem004, #帳務人員
       xrem005   LIKE xrem_t.xrem005, #傳票號碼
       xrem006   LIKE xrem_t.xrem006, #暫估類型
       xremud001 LIKE xrem_t.xremud001, #自定義欄位(文字)001
       xremud002 LIKE xrem_t.xremud002, #自定義欄位(文字)002
       xremud003 LIKE xrem_t.xremud003, #自定義欄位(文字)003
       xremud004 LIKE xrem_t.xremud004, #自定義欄位(文字)004
       xremud005 LIKE xrem_t.xremud005, #自定義欄位(文字)005
       xremud006 LIKE xrem_t.xremud006, #自定義欄位(文字)006
       xremud007 LIKE xrem_t.xremud007, #自定義欄位(文字)007
       xremud008 LIKE xrem_t.xremud008, #自定義欄位(文字)008
       xremud009 LIKE xrem_t.xremud009, #自定義欄位(文字)009
       xremud010 LIKE xrem_t.xremud010, #自定義欄位(文字)010
       xremud011 LIKE xrem_t.xremud011, #自定義欄位(數字)011
       xremud012 LIKE xrem_t.xremud012, #自定義欄位(數字)012
       xremud013 LIKE xrem_t.xremud013, #自定義欄位(數字)013
       xremud014 LIKE xrem_t.xremud014, #自定義欄位(數字)014
       xremud015 LIKE xrem_t.xremud015, #自定義欄位(數字)015
       xremud016 LIKE xrem_t.xremud016, #自定義欄位(數字)016
       xremud017 LIKE xrem_t.xremud017, #自定義欄位(數字)017
       xremud018 LIKE xrem_t.xremud018, #自定義欄位(數字)018
       xremud019 LIKE xrem_t.xremud019, #自定義欄位(數字)019
       xremud020 LIKE xrem_t.xremud020, #自定義欄位(數字)020
       xremud021 LIKE xrem_t.xremud021, #自定義欄位(日期時間)021
       xremud022 LIKE xrem_t.xremud022, #自定義欄位(日期時間)022
       xremud023 LIKE xrem_t.xremud023, #自定義欄位(日期時間)023
       xremud024 LIKE xrem_t.xremud024, #自定義欄位(日期時間)024
       xremud025 LIKE xrem_t.xremud025, #自定義欄位(日期時間)025
       xremud026 LIKE xrem_t.xremud026, #自定義欄位(日期時間)026
       xremud027 LIKE xrem_t.xremud027, #自定義欄位(日期時間)027
       xremud028 LIKE xrem_t.xremud028, #自定義欄位(日期時間)028
       xremud029 LIKE xrem_t.xremud029, #自定義欄位(日期時間)029
       xremud030 LIKE xrem_t.xremud030  #自定義欄位(日期時間)030
           END RECORD
#161104-00024#6-add(e)
DEFINE p_xremdocno   LIKE xrem_t.xremdocno
DEFINE r_success     LIKE type_t.chr1
DEFINE l_docdt       LIKE xrea_t.xrea008
DEFINE l_apca007     LIKE apca_t.apca007
DEFINE l_count       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   #SELECT * INTO l_xrem.*   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xrement,xremownid,xremowndp,xremcrtid,xremcrtdp,
          xremcrtdt,xremmodid,xremmoddt,xremcnfid,xremcnfdt,
          xremstus,xremsite,xremld,xremcomp,xremdocno,
          xremdocdt,xrem001,xrem002,xrem003,xrem004,
          xrem005,xrem006,xremud001,xremud002,xremud003,
          xremud004,xremud005,xremud006,xremud007,xremud008,
          xremud009,xremud010,xremud011,xremud012,xremud013,
          xremud014,xremud015,xremud016,xremud017,xremud018,
          xremud019,xremud020,xremud021,xremud022,xremud023,
          xremud024,xremud025,xremud026,xremud027,xremud028,
          xremud029,xremud030
     INTO l_xrem.xrement,l_xrem.xremownid,l_xrem.xremowndp,l_xrem.xremcrtid,l_xrem.xremcrtdp,
          l_xrem.xremcrtdt,l_xrem.xremmodid,l_xrem.xremmoddt,l_xrem.xremcnfid,l_xrem.xremcnfdt,
          l_xrem.xremstus,l_xrem.xremsite,l_xrem.xremld,l_xrem.xremcomp,l_xrem.xremdocno,
          l_xrem.xremdocdt,l_xrem.xrem001,l_xrem.xrem002,l_xrem.xrem003,l_xrem.xrem004,
          l_xrem.xrem005,l_xrem.xrem006,l_xrem.xremud001,l_xrem.xremud002,l_xrem.xremud003,
          l_xrem.xremud004,l_xrem.xremud005,l_xrem.xremud006,l_xrem.xremud007,l_xrem.xremud008,
          l_xrem.xremud009,l_xrem.xremud010,l_xrem.xremud011,l_xrem.xremud012,l_xrem.xremud013,
          l_xrem.xremud014,l_xrem.xremud015,l_xrem.xremud016,l_xrem.xremud017,l_xrem.xremud018,
          l_xrem.xremud019,l_xrem.xremud020,l_xrem.xremud021,l_xrem.xremud022,l_xrem.xremud023,
          l_xrem.xremud024,l_xrem.xremud025,l_xrem.xremud026,l_xrem.xremud027,l_xrem.xremud028,
          l_xrem.xremud029,l_xrem.xremud030
     FROM xrem_t
    WHERE xrement = g_enterprise
      AND xremdocno = p_xremdocno
      
   LET l_docdt = MDY(l_xrem.xrem002,1,l_xrem.xrem001) #年度期別第一天
   #LET g_sql = " SELECT *                               ",   #161208-00026#15   mark
   #161208-00026#15   add---s
   LET g_sql = " SELECT xreaent,xreacomp,xreasite,xreald,xrea001,
                        xrea002,xrea003,xrea004,xrea005,xrea006,
                        xrea007,xrea008,xrea009,xrea010,xrea011,
                        xrea012,xrea013,xrea014,xrea015,xrea016,
                        xrea017,xrea018,xrea019,xreaorga,xrea020,
                        xrea021,xrea022,xrea023,xrea024,xrea025,
                        xrea026,xrea027,xrea028,xrea029,xrea030,
                        xrea031,xrea032,xrea033,xrea034,xrea035,
                        xrea036,xrea037,xrea038,xrea039,xrea040,
                        xrea041,xrea042,xrea043,xrea100,xrea101,
                        xrea102,xrea103,xrea104,xrea105,xrea106,
                        xrea113,xrea114,xrea115,xrea116,xrea122,
                        xrea123,xrea132,xrea133,xreaud001,xreaud002,
                        xreaud003,xreaud004,xreaud005,xreaud006,xreaud007,
                        xreaud008,xreaud009,xreaud010,xreaud011,xreaud012,
                        xreaud013,xreaud014,xreaud015,xreaud016,xreaud017,
                        xreaud018,xreaud019,xreaud020,xreaud021,xreaud022,
                        xreaud023,xreaud024,xreaud025,xreaud026,xreaud027,
                        xreaud028,xreaud029,xreaud030,xrea044,xrea045 ",
   #161208-00026#15   add---e
               "   FROM xrea_t                          ",
               "  WHERE xrea004 LIKE '0%'               ",
               "    AND xreaent = ",g_enterprise,"      ",
               "    AND xreald  = '",l_xrem.xremld,"'   ",
               "    AND xrea003 = 'AP'                  ",
               "    AND xrea001 = '",l_xrem.xrem001,"'  ",
               "    AND xrea002 = '",l_xrem.xrem002,"'  "
               
   IF g_argv1 = '2' THEN
      LET g_sql = g_sql CLIPPED, " AND xrea008 < '",l_docdt,"' "
   END IF                          
   PREPARE aapt931_ins_prep FROM g_sql
   DECLARE aapt931_ins_curs CURSOR FOR aapt931_ins_prep

   #FOREACH aapt931_ins_curs INTO l_xrea.*     #161208-00026#15   mark
   #161208-00026#15   add---s
   FOREACH aapt931_ins_curs 
      INTO l_xrea.xreaent,l_xrea.xreacomp,l_xrea.xreasite,l_xrea.xreald,l_xrea.xrea001,
           l_xrea.xrea002,l_xrea.xrea003,l_xrea.xrea004,l_xrea.xrea005,l_xrea.xrea006,
           l_xrea.xrea007,l_xrea.xrea008,l_xrea.xrea009,l_xrea.xrea010,l_xrea.xrea011,
           l_xrea.xrea012,l_xrea.xrea013,l_xrea.xrea014,l_xrea.xrea015,l_xrea.xrea016,
           l_xrea.xrea017,l_xrea.xrea018,l_xrea.xrea019,l_xrea.xreaorga,l_xrea.xrea020,
           l_xrea.xrea021,l_xrea.xrea022,l_xrea.xrea023,l_xrea.xrea024,l_xrea.xrea025,
           l_xrea.xrea026,l_xrea.xrea027,l_xrea.xrea028,l_xrea.xrea029,l_xrea.xrea030,
           l_xrea.xrea031,l_xrea.xrea032,l_xrea.xrea033,l_xrea.xrea034,l_xrea.xrea035,
           l_xrea.xrea036,l_xrea.xrea037,l_xrea.xrea038,l_xrea.xrea039,l_xrea.xrea040,
           l_xrea.xrea041,l_xrea.xrea042,l_xrea.xrea043,l_xrea.xrea100,l_xrea.xrea101,
           l_xrea.xrea102,l_xrea.xrea103,l_xrea.xrea104,l_xrea.xrea105,l_xrea.xrea106,
           l_xrea.xrea113,l_xrea.xrea114,l_xrea.xrea115,l_xrea.xrea116,l_xrea.xrea122,
           l_xrea.xrea123,l_xrea.xrea132,l_xrea.xrea133,l_xrea.xreaud001,l_xrea.xreaud002,
           l_xrea.xreaud003,l_xrea.xreaud004,l_xrea.xreaud005,l_xrea.xreaud006,l_xrea.xreaud007,
           l_xrea.xreaud008,l_xrea.xreaud009,l_xrea.xreaud010,l_xrea.xreaud011,l_xrea.xreaud012,
           l_xrea.xreaud013,l_xrea.xreaud014,l_xrea.xreaud015,l_xrea.xreaud016,l_xrea.xreaud017,
           l_xrea.xreaud018,l_xrea.xreaud019,l_xrea.xreaud020,l_xrea.xreaud021,l_xrea.xreaud022,
           l_xrea.xreaud023,l_xrea.xreaud024,l_xrea.xreaud025,l_xrea.xreaud026,l_xrea.xreaud027,
           l_xrea.xreaud028,l_xrea.xreaud029,l_xrea.xreaud030,l_xrea.xrea044,l_xrea.xrea045
   #161208-00026#15   add---e
      #暫估費用/暫估收入科目
      SELECT apca036,apca007 INTO l_xren.xren043,l_apca007
        FROM apca_t
       WHERE apcaent   = g_enterprise
         AND apcadocno = l_xrea.xrea005   
     #稅別會科
      SELECT glab005 INTO l_xren.xren042
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glab003 = '8504_08'
         AND glabld  = g_xrem_m.xremld
         AND glab002 = l_apca007      
      
      IF cl_null(l_xren.xrenseq) OR l_xren.xrenseq = 0 THEN
         LET l_xren.xrenseq = 1
      ELSE 
         LET l_xren.xrenseq = l_xren.xrenseq +1
      END IF      
      LET l_xren.xrenent = g_enterprise 
      LET l_xren.xrendocno = p_xremdocno
      LET l_xren.xren001 = l_xrea.xrea001    #年度
      LET l_xren.xren002 = l_xrea.xrea002    #期別
      LET l_xren.xren003 = l_xrea.xrea003    #來源模
      LET l_xren.xren004 = l_xrea.xrea004    #帳款單性質
      LET l_xren.xren005 = l_xrea.xrea005    #單據號碼
      LET l_xren.xren006 = l_xrea.xrea006
      LET l_xren.xren007 = l_xrea.xrea007
      LET l_xren.xren008 = l_xrea.xrea008
      LET l_xren.xren009 = l_xrea.xrea009
      LET l_xren.xren010 = l_xrea.xrea010
      LET l_xren.xren011 = l_xrea.xrea011
      LET l_xren.xren012 = l_xrea.xrea012
      LET l_xren.xren013 = l_xrea.xrea013 
      LET l_xren.xren014 = l_xrea.xrea014 
      LET l_xren.xren015 = l_xrea.xrea015 
      LET l_xren.xren016 = l_xrea.xrea016 
      LET l_xren.xren017 = l_xrea.xrea017 
      LET l_xren.xren018 = l_xrea.xrea018 
      LET l_xren.xren019 = l_xrea.xrea019    #應收付科目
      LET l_xren.xrenorga = l_xrea.xreaorga
      LET l_xren.xren020 = l_xrea.xrea020 
      LET l_xren.xren021 = l_xrea.xrea021 
      LET l_xren.xren022 = l_xrea.xrea022 
      LET l_xren.xren023 = l_xrea.xrea023 
      LET l_xren.xren024 = l_xrea.xrea024 
      LET l_xren.xren025 = l_xrea.xrea025 
      LET l_xren.xren026 = l_xrea.xrea026 
      LET l_xren.xren027 = l_xrea.xrea027 
      LET l_xren.xren028 = l_xrea.xrea028 
      LET l_xren.xren029 = l_xrea.xrea029 
      LET l_xren.xren030 = l_xrea.xrea030 
      LET l_xren.xren031 = l_xrea.xrea031 
      LET l_xren.xren032 = l_xrea.xrea032
      LET l_xren.xren033 = l_xrea.xrea033
      LET l_xren.xren040 = l_xrea.xrea040
      LET l_xren.xren041 = l_xrea.xrea041 
      LET l_xren.xren100 = l_xrea.xrea100 
      LET l_xren.xren101 = l_xrea.xrea102 #重評匯率 
      LET l_xren.xren103 = l_xrea.xrea104 
      LET l_xren.xren104 = l_xrea.xrea105 
      LET l_xren.xren105 = l_xrea.xrea106 
      LET l_xren.xren113 = l_xrea.xrea114 
      LET l_xren.xren114 = l_xrea.xrea115 
      LET l_xren.xren115 = l_xrea.xrea116 
      LET l_xren.xren121 = l_xrea.xrea122 #重評匯率
      LET l_xren.xren131 = l_xrea.xrea132 #重評匯率

      
      #INSERT INTO xren_t VALUES (l_xren.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO xren_t (xrenent,xrendocno,xrenseq,
                          xren001,xren002,xren003,xren004,xren005,
                          xren006,xren007,xren008,xren009,xren010,
                          xren011,xren012,xren013,xren014,xren015,
                          xren016,xren017,xren018,xren019,xrenorga,xren020,
                          xren021,xren022,xren023,xren024,xren025,
                          xren026,xren027,xren028,xren029,xren030,
                          xren031,xren032,xren033,xren040,xren041,
                          xren042,xren043,xren100,xren101,xren103,
                          xren104,xren105,xren113,xren114,xren115,
                          xren121,xren123,xren124,xren125,xren131,
                          xren133,xren134,xren135,
                          xrenud001,xrenud002,xrenud003,xrenud004,xrenud005,
                          xrenud006,xrenud007,xrenud008,xrenud009,xrenud010,
                          xrenud011,xrenud012,xrenud013,xrenud014,xrenud015,
                          xrenud016,xrenud017,xrenud018,xrenud019,xrenud020,
                          xrenud021,xrenud022,xrenud023,xrenud024,xrenud025,
                          xrenud026,xrenud027,xrenud028,xrenud029,xrenud030
                         )
      VALUES (l_xren.xrenent,l_xren.xrendocno,l_xren.xrenseq,
              l_xren.xren001,l_xren.xren002,l_xren.xren003,l_xren.xren004,l_xren.xren005,
              l_xren.xren006,l_xren.xren007,l_xren.xren008,l_xren.xren009,l_xren.xren010,
              l_xren.xren011,l_xren.xren012,l_xren.xren013,l_xren.xren014,l_xren.xren015,
              l_xren.xren016,l_xren.xren017,l_xren.xren018,l_xren.xren019,l_xren.xrenorga,l_xren.xren020,
              l_xren.xren021,l_xren.xren022,l_xren.xren023,l_xren.xren024,l_xren.xren025,
              l_xren.xren026,l_xren.xren027,l_xren.xren028,l_xren.xren029,l_xren.xren030,
              l_xren.xren031,l_xren.xren032,l_xren.xren033,l_xren.xren040,l_xren.xren041,
              l_xren.xren042,l_xren.xren043,l_xren.xren100,l_xren.xren101,l_xren.xren103,
              l_xren.xren104,l_xren.xren105,l_xren.xren113,l_xren.xren114,l_xren.xren115,
              l_xren.xren121,l_xren.xren123,l_xren.xren124,l_xren.xren125,l_xren.xren131,
              l_xren.xren133,l_xren.xren134,l_xren.xren135,
              l_xren.xrenud001,l_xren.xrenud002,l_xren.xrenud003,l_xren.xrenud004,l_xren.xrenud005,
              l_xren.xrenud006,l_xren.xrenud007,l_xren.xrenud008,l_xren.xrenud009,l_xren.xrenud010,
              l_xren.xrenud011,l_xren.xrenud012,l_xren.xrenud013,l_xren.xrenud014,l_xren.xrenud015,
              l_xren.xrenud016,l_xren.xrenud017,l_xren.xrenud018,l_xren.xrenud019,l_xren.xrenud020,
              l_xren.xrenud021,l_xren.xrenud022,l_xren.xrenud023,l_xren.xrenud024,l_xren.xrenud025,
              l_xren.xrenud026,l_xren.xrenud027,l_xren.xrenud028,l_xren.xrenud029,l_xren.xrenud030
             )
      #161108-00017#4 add end---
      IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xren_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   
   END FOREACH
   
   SELECT COUNT(*) INTO l_count
     FROM xren_t
    WHERE xrenent   = g_enterprise
      AND xrendocno = p_xremdocno
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
       INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'
         LET g_errparam.extend = "ins xren_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 立即審核
# Memo...........:
# Usage..........: CALL aapt930_01_immediately_conf()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt930_01_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_xremcomp        LIKE xrem_t.xremcomp
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE  g_xremcnfdt    LIKE xrem_t.xremcnfdt
   #DEFINE  l_xrem       RECORD LIKE xrem_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xrem  RECORD  #暫估帳務主檔
          xrement   LIKE xrem_t.xrement, #企業編號
          xremownid LIKE xrem_t.xremownid, #資料所有者
          xremowndp LIKE xrem_t.xremowndp, #資料所屬部門
          xremcrtid LIKE xrem_t.xremcrtid, #資料建立者
          xremcrtdp LIKE xrem_t.xremcrtdp, #資料建立部門
          xremcrtdt LIKE xrem_t.xremcrtdt, #資料創建日
          xremmodid LIKE xrem_t.xremmodid, #資料修改者
          xremmoddt LIKE xrem_t.xremmoddt, #最近修改日
          xremcnfid LIKE xrem_t.xremcnfid, #資料確認者
          xremcnfdt LIKE xrem_t.xremcnfdt, #資料確認日
          xremstus  LIKE xrem_t.xremstus, #狀態碼
          xremsite  LIKE xrem_t.xremsite, #營運據點
          xremld    LIKE xrem_t.xremld, #帳套
          xremcomp  LIKE xrem_t.xremcomp, #法人
          xremdocno LIKE xrem_t.xremdocno, #單據編號
          xremdocdt LIKE xrem_t.xremdocdt, #單據日期
          xrem001   LIKE xrem_t.xrem001, #年度
          xrem002   LIKE xrem_t.xrem002, #期別
          xrem003   LIKE xrem_t.xrem003, #來源模組
          xrem004   LIKE xrem_t.xrem004, #帳務人員
          xrem005   LIKE xrem_t.xrem005, #傳票號碼
          xrem006   LIKE xrem_t.xrem006, #暫估類型
          xremud001 LIKE xrem_t.xremud001, #自定義欄位(文字)001
          xremud002 LIKE xrem_t.xremud002, #自定義欄位(文字)002
          xremud003 LIKE xrem_t.xremud003, #自定義欄位(文字)003
          xremud004 LIKE xrem_t.xremud004, #自定義欄位(文字)004
          xremud005 LIKE xrem_t.xremud005, #自定義欄位(文字)005
          xremud006 LIKE xrem_t.xremud006, #自定義欄位(文字)006
          xremud007 LIKE xrem_t.xremud007, #自定義欄位(文字)007
          xremud008 LIKE xrem_t.xremud008, #自定義欄位(文字)008
          xremud009 LIKE xrem_t.xremud009, #自定義欄位(文字)009
          xremud010 LIKE xrem_t.xremud010, #自定義欄位(文字)010
          xremud011 LIKE xrem_t.xremud011, #自定義欄位(數字)011
          xremud012 LIKE xrem_t.xremud012, #自定義欄位(數字)012
          xremud013 LIKE xrem_t.xremud013, #自定義欄位(數字)013
          xremud014 LIKE xrem_t.xremud014, #自定義欄位(數字)014
          xremud015 LIKE xrem_t.xremud015, #自定義欄位(數字)015
          xremud016 LIKE xrem_t.xremud016, #自定義欄位(數字)016
          xremud017 LIKE xrem_t.xremud017, #自定義欄位(數字)017
          xremud018 LIKE xrem_t.xremud018, #自定義欄位(數字)018
          xremud019 LIKE xrem_t.xremud019, #自定義欄位(數字)019
          xremud020 LIKE xrem_t.xremud020, #自定義欄位(數字)020
          xremud021 LIKE xrem_t.xremud021, #自定義欄位(日期時間)021
          xremud022 LIKE xrem_t.xremud022, #自定義欄位(日期時間)022
          xremud023 LIKE xrem_t.xremud023, #自定義欄位(日期時間)023
          xremud024 LIKE xrem_t.xremud024, #自定義欄位(日期時間)024
          xremud025 LIKE xrem_t.xremud025, #自定義欄位(日期時間)025
          xremud026 LIKE xrem_t.xremud026, #自定義欄位(日期時間)026
          xremud027 LIKE xrem_t.xremud027, #自定義欄位(日期時間)027
          xremud028 LIKE xrem_t.xremud028, #自定義欄位(日期時間)028
          xremud029 LIKE xrem_t.xremud029, #自定義欄位(日期時間)029
          xremud030 LIKE xrem_t.xremud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   IF cl_null(g_xrem_m.xremld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrem_m.xremsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrem_m.xremdocno) THEN RETURN END IF   #無資料直接返回不做處理
   #SELECT *  INTO  l_xrem.*  FROM xrem_t   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xrement,xremownid,xremowndp,xremcrtid,xremcrtdp,
          xremcrtdt,xremmodid,xremmoddt,xremcnfid,xremcnfdt,
          xremstus,xremsite,xremld,xremcomp,xremdocno,
          xremdocdt,xrem001,xrem002,xrem003,xrem004,
          xrem005,xrem006,xremud001,xremud002,xremud003,
          xremud004,xremud005,xremud006,xremud007,xremud008,
          xremud009,xremud010,xremud011,xremud012,xremud013,
          xremud014,xremud015,xremud016,xremud017,xremud018,
          xremud019,xremud020,xremud021,xremud022,xremud023,
          xremud024,xremud025,xremud026,xremud027,xremud028,
          xremud029,xremud030
     INTO l_xrem.xrement,l_xrem.xremownid,l_xrem.xremowndp,l_xrem.xremcrtid,l_xrem.xremcrtdp,
          l_xrem.xremcrtdt,l_xrem.xremmodid,l_xrem.xremmoddt,l_xrem.xremcnfid,l_xrem.xremcnfdt,
          l_xrem.xremstus,l_xrem.xremsite,l_xrem.xremld,l_xrem.xremcomp,l_xrem.xremdocno,
          l_xrem.xremdocdt,l_xrem.xrem001,l_xrem.xrem002,l_xrem.xrem003,l_xrem.xrem004,
          l_xrem.xrem005,l_xrem.xrem006,l_xrem.xremud001,l_xrem.xremud002,l_xrem.xremud003,
          l_xrem.xremud004,l_xrem.xremud005,l_xrem.xremud006,l_xrem.xremud007,l_xrem.xremud008,
          l_xrem.xremud009,l_xrem.xremud010,l_xrem.xremud011,l_xrem.xremud012,l_xrem.xremud013,
          l_xrem.xremud014,l_xrem.xremud015,l_xrem.xremud016,l_xrem.xremud017,l_xrem.xremud018,
          l_xrem.xremud019,l_xrem.xremud020,l_xrem.xremud021,l_xrem.xremud022,l_xrem.xremud023,
          l_xrem.xremud024,l_xrem.xremud025,l_xrem.xremud026,l_xrem.xremud027,l_xrem.xremud028,
          l_xrem.xremud029,l_xrem.xremud030
     FROM xrem_t
   #161208-00026#15   add---e
    #WHERE xremld = g_xrem_m.xremld AND xremsite = g_xrem_m.xremsite AND xremdocno =  g_xrem_m.xremdocno                            #160905-00002#4 mark
    WHERE xrement = g_enterprise AND xremld = g_xrem_m.xremld AND xremsite = g_xrem_m.xremsite AND xremdocno =  g_xrem_m.xremdocno  #160905-00002#4 add
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM xren_t WHERE xrenent = g_enterprise
      AND xrendocno = g_xrem_m.xremdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
#   #只能執行大於等於關帳年月之資料
#   SELECT xremcomp INTO l_xremcomp FROM xrem_t WHERE xrement = g_enterprise AND xremdocno = g_xrem_m.xremdocno AND xrem003 = 'AP' 
#   CALL cl_get_para(g_enterprise,l_xremcomp,'S-FIN-3007') RETURNING l_sfin3007 
#   IF g_xrem_m.xremdocdt < l_sfin3007 THEN RETURN END IF
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_xrem_m.xremdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_xrem_m.xremld,l_xrem.xremcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
      

   IF NOT s_aapt930_conf_chk(g_xrem_m.xremdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_aapt930_conf_upd(g_xrem_m.xremdocno) THEN
      LET l_doc_success = FALSE
   END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET g_xremcnfdt = cl_get_current()
   UPDATE xrem_t SET xremstus = 'Y',
                     xremmodid= g_user,
                     xremcnfid= g_user,
                     xremcnfdt= g_xremcnfdt
    WHERE xrement = g_enterprise AND xremld = g_xrem_m.xremld
      AND xremdocno = g_xrem_m.xremdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#2--e
END FUNCTION

################################################################################
# Descriptions...: 立即拋轉傳票
# Memo...........:
# Usage..........: CALL aapt930_01_immediately_gen()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt930_01_immediately_gen()
#151125-00006#2---s
   DEFINE l_cnt            LIKE type_t.num10
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_date            LIKE glap_t.glapdocdt
   DEFINE l_chr             LIKE type_t.chr1       #狀態碼
   DEFINE l_gl_slip         LIKE ooba_t.ooba002      #總帳單別
   DEFINE l_sfin3007        LIKE type_t.dat
   DEFINE l_glaacomp        LIKE glaa_t.glaacomp
   DEFINE l_docno           LIKE xrem_t.xremdocno
   DEFINE l_start_no        LIKE glap_t.glapdocno
   DEFINE g_glaa102         LIKE glaa_t.glaa102
   DEFINE g_ap_slip         LIKE apca_t.apcadocno
   #DEFINE l_xrem            RECORD LIKE xrem_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xrem  RECORD  #暫估帳務主檔
          xrement   LIKE xrem_t.xrement, #企業編號
          xremownid LIKE xrem_t.xremownid, #資料所有者
          xremowndp LIKE xrem_t.xremowndp, #資料所屬部門
          xremcrtid LIKE xrem_t.xremcrtid, #資料建立者
          xremcrtdp LIKE xrem_t.xremcrtdp, #資料建立部門
          xremcrtdt LIKE xrem_t.xremcrtdt, #資料創建日
          xremmodid LIKE xrem_t.xremmodid, #資料修改者
          xremmoddt LIKE xrem_t.xremmoddt, #最近修改日
          xremcnfid LIKE xrem_t.xremcnfid, #資料確認者
          xremcnfdt LIKE xrem_t.xremcnfdt, #資料確認日
          xremstus  LIKE xrem_t.xremstus, #狀態碼
          xremsite  LIKE xrem_t.xremsite, #營運據點
          xremld    LIKE xrem_t.xremld, #帳套
          xremcomp  LIKE xrem_t.xremcomp, #法人
          xremdocno LIKE xrem_t.xremdocno, #單據編號
          xremdocdt LIKE xrem_t.xremdocdt, #單據日期
          xrem001   LIKE xrem_t.xrem001, #年度
          xrem002   LIKE xrem_t.xrem002, #期別
          xrem003   LIKE xrem_t.xrem003, #來源模組
          xrem004   LIKE xrem_t.xrem004, #帳務人員
          xrem005   LIKE xrem_t.xrem005, #傳票號碼
          xrem006   LIKE xrem_t.xrem006, #暫估類型
          xremud001 LIKE xrem_t.xremud001, #自定義欄位(文字)001
          xremud002 LIKE xrem_t.xremud002, #自定義欄位(文字)002
          xremud003 LIKE xrem_t.xremud003, #自定義欄位(文字)003
          xremud004 LIKE xrem_t.xremud004, #自定義欄位(文字)004
          xremud005 LIKE xrem_t.xremud005, #自定義欄位(文字)005
          xremud006 LIKE xrem_t.xremud006, #自定義欄位(文字)006
          xremud007 LIKE xrem_t.xremud007, #自定義欄位(文字)007
          xremud008 LIKE xrem_t.xremud008, #自定義欄位(文字)008
          xremud009 LIKE xrem_t.xremud009, #自定義欄位(文字)009
          xremud010 LIKE xrem_t.xremud010, #自定義欄位(文字)010
          xremud011 LIKE xrem_t.xremud011, #自定義欄位(數字)011
          xremud012 LIKE xrem_t.xremud012, #自定義欄位(數字)012
          xremud013 LIKE xrem_t.xremud013, #自定義欄位(數字)013
          xremud014 LIKE xrem_t.xremud014, #自定義欄位(數字)014
          xremud015 LIKE xrem_t.xremud015, #自定義欄位(數字)015
          xremud016 LIKE xrem_t.xremud016, #自定義欄位(數字)016
          xremud017 LIKE xrem_t.xremud017, #自定義欄位(數字)017
          xremud018 LIKE xrem_t.xremud018, #自定義欄位(數字)018
          xremud019 LIKE xrem_t.xremud019, #自定義欄位(數字)019
          xremud020 LIKE xrem_t.xremud020, #自定義欄位(數字)020
          xremud021 LIKE xrem_t.xremud021, #自定義欄位(日期時間)021
          xremud022 LIKE xrem_t.xremud022, #自定義欄位(日期時間)022
          xremud023 LIKE xrem_t.xremud023, #自定義欄位(日期時間)023
          xremud024 LIKE xrem_t.xremud024, #自定義欄位(日期時間)024
          xremud025 LIKE xrem_t.xremud025, #自定義欄位(日期時間)025
          xremud026 LIKE xrem_t.xremud026, #自定義欄位(日期時間)026
          xremud027 LIKE xrem_t.xremud027, #自定義欄位(日期時間)027
          xremud028 LIKE xrem_t.xremud028, #自定義欄位(日期時間)028
          xremud029 LIKE xrem_t.xremud029, #自定義欄位(日期時間)029
          xremud030 LIKE xrem_t.xremud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   IF cl_null(g_xrem_m.xremld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrem_m.xremsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrem_m.xremdocno) THEN RETURN END IF   #無資料直接返回不做處理
   #SELECT *  INTO  l_xrem.*  FROM xrem_t   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xrement,xremownid,xremowndp,xremcrtid,xremcrtdp,
          xremcrtdt,xremmodid,xremmoddt,xremcnfid,xremcnfdt,
          xremstus,xremsite,xremld,xremcomp,xremdocno,
          xremdocdt,xrem001,xrem002,xrem003,xrem004,
          xrem005,xrem006,xremud001,xremud002,xremud003,
          xremud004,xremud005,xremud006,xremud007,xremud008,
          xremud009,xremud010,xremud011,xremud012,xremud013,
          xremud014,xremud015,xremud016,xremud017,xremud018,
          xremud019,xremud020,xremud021,xremud022,xremud023,
          xremud024,xremud025,xremud026,xremud027,xremud028,
          xremud029,xremud030
     INTO l_xrem.xrement,l_xrem.xremownid,l_xrem.xremowndp,l_xrem.xremcrtid,l_xrem.xremcrtdp,
          l_xrem.xremcrtdt,l_xrem.xremmodid,l_xrem.xremmoddt,l_xrem.xremcnfid,l_xrem.xremcnfdt,
          l_xrem.xremstus,l_xrem.xremsite,l_xrem.xremld,l_xrem.xremcomp,l_xrem.xremdocno,
          l_xrem.xremdocdt,l_xrem.xrem001,l_xrem.xrem002,l_xrem.xrem003,l_xrem.xrem004,
          l_xrem.xrem005,l_xrem.xrem006,l_xrem.xremud001,l_xrem.xremud002,l_xrem.xremud003,
          l_xrem.xremud004,l_xrem.xremud005,l_xrem.xremud006,l_xrem.xremud007,l_xrem.xremud008,
          l_xrem.xremud009,l_xrem.xremud010,l_xrem.xremud011,l_xrem.xremud012,l_xrem.xremud013,
          l_xrem.xremud014,l_xrem.xremud015,l_xrem.xremud016,l_xrem.xremud017,l_xrem.xremud018,
          l_xrem.xremud019,l_xrem.xremud020,l_xrem.xremud021,l_xrem.xremud022,l_xrem.xremud023,
          l_xrem.xremud024,l_xrem.xremud025,l_xrem.xremud026,l_xrem.xremud027,l_xrem.xremud028,
          l_xrem.xremud029,l_xrem.xremud030
     FROM xrem_t
   #161208-00026#15   add---e
    #WHERE xremld = g_xrem_m.xremld AND xremsite = g_xrem_m.xremsite AND xremdocno =  g_xrem_m.xremdocno                            #160905-00002#4 mark
    WHERE xrement = g_enterprise AND xremld = g_xrem_m.xremld AND xremsite = g_xrem_m.xremsite AND xremdocno =  g_xrem_m.xremdocno  #160905-00002#4 add
   IF  l_xrem.xremstus != 'Y' OR cl_null(l_xrem.xremstus) THEN
      RETURN
    END IF
   IF NOT cl_null(l_xrem.xrem005)  THEN RETURN END IF #传票号码已经存在返回不做处理
   #傳票成立時,借貸不平衡的處理方式
   CALL s_ld_sel_glaa(g_xrem_m.xremld,'glaacomp|glaa102')
        RETURNING g_sub_success,l_glaacomp,g_glaa102
   #取所屬法人關帳日
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
   
   
   # D-FIN-0030 产生分录传票否
   CALL s_aooi200_fin_get_slip(g_xrem_m.xremdocno) RETURNING g_sub_success,g_ap_slip
   CALL s_fin_get_doc_para(g_xrem_m.xremld,l_xrem.xremcomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
   IF l_chr <> 'Y' OR  cl_null(l_chr) THEN RETURN END IF 
    
   #取得單別
   CALL s_aooi200_fin_get_slip(g_xrem_m.xremdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(g_xrem_m.xremld,l_xrem.xremcomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032
    
   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      RETURN 
   END IF 
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(g_xrem_m.xremld,l_xrem.xremcomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
   
   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
   IF cl_null(l_gl_slip) THEN
      #產生單別/日期
      CALL aapp330_01(g_xrem_m.xremld,g_xrem_m.xremdocdt,'',g_xrem_m.xremdocno) RETURNING l_gl_slip,l_date  #161213-00023#2 add g_xrem_m.xremdocno
      #必須大於帳套關帳日期才可拋轉
      IF l_date < l_sfin3007 THEN 
         RETURN
      END IF
   ELSE 
      LET l_date = g_xrem_m.xremdocdt
   END IF 
   
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
   CALL s_fin_continue_no_tmp()               
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   CALL s_transaction_begin()
   
   DELETE FROM s_voucher_tmp
   
   INSERT INTO s_voucher_tmp (docno,type)
          VALUES (g_xrem_m.xremdocno, '0' )
   SELECT docno INTO l_docno FROM s_voucher_tmp WHERE type = 0
   
   SELECT count(*) INTO l_count
     FROM s_voucher_tmp
   IF l_count > 0 THEN
      IF g_argv1 = 1 THEN 
         CALL s_aapp330_gen_ac('1','P50',g_xrem_m.xremld,'','','1','!#@',l_xrem.xremstus) RETURNING g_sub_success,l_start_no,l_start_no                     
      ELSE
         CALL s_aapp330_gen_ac('1','P51',g_xrem_m.xremld,'','','1','!#@',l_xrem.xremstus) RETURNING g_sub_success,l_start_no,l_start_no
      END IF
      
      IF g_sub_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')
      END IF
   
      #傳票拋轉
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      IF g_argv1 = 1 THEN 
         CALL s_aapp330_generate_voucher('P50',l_gl_slip,l_date,g_xrem_m.xremld,'1','Y',g_glaa102,'AP')
              RETURNING g_sub_success,l_xrem.xrem005,l_xrem.xrem005
      ELSE
         CALL s_aapp330_generate_voucher('P51',l_gl_slip,l_date,g_xrem_m.xremld,'1','Y',g_glaa102,'AP')
              RETURNING g_sub_success,l_xrem.xrem005,l_xrem.xrem005
      END IF
      
      #成功則更新aapt920的傳票號碼
      IF g_sub_success THEN
         UPDATE xrem_t SET xrem005 = l_xrem.xrem005
          WHERE xrement = g_enterprise
            AND xremdocno = g_xrem_m.xremdocno
            AND xrem003 ='AP'
        
         UPDATE glga_t SET glga007 =  l_xrem.xrem005
          WHERE glgaent = g_enterprise AND glgald = g_xrem_m.xremld 
            AND glgadocno=g_xrem_m.xremdocno AND glga100 = 'AP' AND glga101 = 'P60'
        
         CALL s_transaction_end('Y','Y')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00217'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         CALL s_transaction_end('N','Y')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      CALL cl_err_collect_show()
   END IF
     
#151125-00006#2---e

END FUNCTION

 
{</section>}
 
