#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt940_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-03-06 17:36:17), PR版次:0008(2017-01-12 10:45:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000091
#+ Filename...: aapt940_01
#+ Description: 批次產生
#+ Creator....: 03080(2014-10-29 17:30:49)
#+ Modifier...: 04152 -SD/PR- 06694
 
{</section>}
 
{<section id="aapt940_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160905-00002#4  2016/09/05 By 06821     補入WHERE條件漏掉ENT的部分
#161006-00005#6  2016/10/12 By 08732     組織類型與職能開窗調整
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#161104-00024#6  2016/11/10 By 08729     處理DEFINE有星號
#161208-00026#15 2016/12/12 By 08732     SUB_程式中DEFINE / INSERT INTO 有星號整批調整(針對SELECT *的部份)
#161104-00046#8  2017/01/03 By 06821     單別預設值;資料依照單別user dept權限過濾單號
#161213-00023#2  2017/01/12 By 06694    新增aapp330_01元件單別參數，默認拋轉單別
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
PRIVATE type type_g_xrej_m        RECORD
       xrejsite LIKE xrej_t.xrejsite, 
   l_xrejsite_desc LIKE type_t.chr80, 
   xrejld LIKE xrej_t.xrejld, 
   l_xrejld_desc LIKE type_t.chr80, 
   xrej004 LIKE xrej_t.xrej004, 
   l_xrej004_desc LIKE type_t.chr80, 
   xrejdocno LIKE xrej_t.xrejdocno, 
   xrej001 LIKE xrej_t.xrej001, 
   xrej002 LIKE xrej_t.xrej002, 
   xrejdocdt LIKE xrej_t.xrejdocdt, 
   glcb003 LIKE glcb_t.glcb003, 
   l_xrad004 LIKE type_t.chr10, 
   l_xred014_21 LIKE type_t.chr1, 
   l_xred014_22 LIKE type_t.chr1
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_successdoc    LIKE xrej_t.xrejdocno
#161104-00046#8 --s add     
DEFINE g_user_slip_wc      STRING      
#161104-00046#8 --e add
#end add-point
 
DEFINE g_xrej_m        type_g_xrej_m
 
   DEFINE g_xrejdocno_t LIKE xrej_t.xrejdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt940_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt940_01(--)
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_origin_str    STRING
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_strdat  LIKE type_t.dat
   DEFINE l_enddat  LIKE type_t.dat
   DEFINE l_glaa003 LIKE glaa_t.glaa003
   DEFINE r_success_doc   LIKE xrej_t.xrejdocno
   DEFINE l_glcb002       LIKE glcb_t.glcb002   #agli172-壞帳準備提列方式
   DEFINE l_flag          LIKE type_t.num5   #161104-00046#8 
   WHENEVER ERROR CONTINUE
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt940_01 WITH FORM cl_ap_formpath("aap","aapt940_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL aapt940_01_default_g_xrej()
   LET r_success = TRUE
   
   #161104-00046#8 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_xrej_m','','','','','','')RETURNING g_sub_success
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#8 --e add    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrej_m.xrejsite,g_xrej_m.xrejld,g_xrej_m.xrej004,g_xrej_m.xrejdocno,g_xrej_m.xrej001, 
          g_xrej_m.xrej002,g_xrej_m.xrejdocdt,g_xrej_m.glcb003,g_xrej_m.l_xrad004,g_xrej_m.l_xred014_21, 
          g_xrej_m.l_xred014_22 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejsite
            
            #add-point:AFTER FIELD xrejsite name="input.a.xrejsite"
            LET g_xrej_m.l_xrejsite_desc = ''
            IF NOT cl_null(g_xrej_m.xrejsite) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrej_m.xrejsite,'','','3','N','',g_today) 
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrej_m.xrejsite = ''
                  LET g_xrej_m.l_xrejsite_desc = ''
                  DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.l_xrejsite_desc
                  NEXT FIELD xrejsite
               END IF
            END IF
            LET g_xrej_m.l_xrejsite_desc = s_desc_get_department_desc(g_xrej_m.xrejsite)
            DISPLAY BY NAME g_xrej_m.l_xrejsite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejsite
            #add-point:BEFORE FIELD xrejsite name="input.b.xrejsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejsite
            #add-point:ON CHANGE xrejsite name="input.g.xrejsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejld
            
            #add-point:AFTER FIELD xrejld name="input.a.xrejld"
            LET g_xrej_m.l_xrejld_desc = ''
            IF NOT cl_null(g_xrej_m.xrejld) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrej_m.xrejsite,g_xrej_m.xrejld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrej_m.xrejld = '' 
                  LET g_xrej_m.l_xrejld_desc = ''
                  DISPLAY BY NAME g_xrej_m.xrejld,g_xrej_m.l_xrejld_desc
                  NEXT FIELD CURRENT
                END IF
             END IF
            #重新取得會計週期參照表,最大期別,月份下拉
            CALL aapt940_01_set_comp(g_xrej_m.xrejld,g_xrej_m.xrej001)
            CALL s_desc_get_ld_desc(g_xrej_m.xrejld) RETURNING g_xrej_m.l_xrejld_desc
            DISPLAY BY NAME g_xrej_m.l_xrejld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejld
            #add-point:BEFORE FIELD xrejld name="input.b.xrejld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejld
            #add-point:ON CHANGE xrejld name="input.g.xrejld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej004
            
            #add-point:AFTER FIELD xrej004 name="input.a.xrej004"
            LET g_xrej_m.l_xrej004_desc = ' '
            IF NOT cl_null(g_xrej_m.xrej004) THEN        
               CALL s_employee_chk(g_xrej_m.xrej004) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_xrej_m.xrej004 = ''
                  LET g_xrej_m.l_xrej004_desc = ''
                  DISPLAY BY NAME g_xrej_m.l_xrej004_desc,g_xrej_m.xrej004
                  NEXT FIELD CURRENT
               END IF     
            END IF
            CALL s_desc_get_person_desc(g_xrej_m.xrej004) RETURNING g_xrej_m.l_xrej004_desc
            DISPLAY BY NAME g_xrej_m.l_xrej004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej004
            #add-point:BEFORE FIELD xrej004 name="input.b.xrej004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej004
            #add-point:ON CHANGE xrej004 name="input.g.xrej004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejdocno
            #add-point:BEFORE FIELD xrejdocno name="input.b.xrejdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejdocno
            
            #add-point:AFTER FIELD xrejdocno name="input.a.xrejdocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_xrej_m.xrejld
            IF NOT cl_null(g_xrej_m.xrejdocno) THEN
               CALL s_fin_slip_chk(g_xrej_m.xrejdocno,g_prog,g_xrej_m.xrejld,l_glaa024)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrej_m.xrejdocno = ''
                  NEXT FIELD CURRENT
               END IF
               #161104-00046#8 --s add
               CALL s_control_chk_doc('1',g_xrej_m.xrejdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_xrej_m.xrejdocno = ''
                  NEXT FIELD CURRENT             
               END IF
               #161104-00046#8 --e add                 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejdocno
            #add-point:ON CHANGE xrejdocno name="input.g.xrejdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej001
            #add-point:BEFORE FIELD xrej001 name="input.b.xrej001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej001
            
            #add-point:AFTER FIELD xrej001 name="input.a.xrej001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej001
            #add-point:ON CHANGE xrej001 name="input.g.xrej001"
            LET l_glaa003 = NULL
            SELECT glaa003 INTO l_glaa003
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_xrej_m.xrejld
            IF NOT cl_null(l_glaa003)THEN
               CALL s_fin_date_get_period_range(l_glaa003,g_xrej_m.xrej001,g_xrej_m.xrej002)RETURNING l_strdat,l_enddat
               LET g_xrej_m.xrejdocdt = l_enddat 
            END IF
            DISPLAY BY NAME g_xrej_m.xrejdocdt
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrej002
            #add-point:BEFORE FIELD xrej002 name="input.b.xrej002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrej002
            
            #add-point:AFTER FIELD xrej002 name="input.a.xrej002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrej002
            #add-point:ON CHANGE xrej002 name="input.g.xrej002"
            LET l_glaa003 = NULL
            SELECT glaa003 INTO l_glaa003
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_xrej_m.xrejld
            IF NOT cl_null(l_glaa003)THEN
               CALL s_fin_date_get_period_range(l_glaa003,g_xrej_m.xrej001,g_xrej_m.xrej002)RETURNING l_strdat,l_enddat
               LET g_xrej_m.xrejdocdt = l_enddat
            END IF            
            DISPLAY BY NAME g_xrej_m.xrejdocdt
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrejdocdt
            #add-point:BEFORE FIELD xrejdocdt name="input.b.xrejdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrejdocdt
            
            #add-point:AFTER FIELD xrejdocdt name="input.a.xrejdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrejdocdt
            #add-point:ON CHANGE xrejdocdt name="input.g.xrejdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glcb003
            #add-point:BEFORE FIELD glcb003 name="input.b.glcb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glcb003
            
            #add-point:AFTER FIELD glcb003 name="input.a.glcb003"
            LET g_xrej_m.l_xrad004 = ' '
            IF NOT cl_null(g_xrej_m.glcb003) THEN        
               CALL aapt940_01_glcb003_chk(g_xrej_m.glcb003) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_xrej_m.glcb003 = ''
                  LET g_xrej_m.l_xrad004 = ''
                  DISPLAY BY NAME g_xrej_m.glcb003,g_xrej_m.xrej004
                  NEXT FIELD CURRENT
               END IF     
            END IF
            CALL aapt940_01_get_xrad004(g_xrej_m.glcb003)RETURNING g_xrej_m.l_xrad004
            DISPLAY BY NAME g_xrej_m.l_xrad004
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glcb003
            #add-point:ON CHANGE glcb003 name="input.g.glcb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrad004
            #add-point:BEFORE FIELD l_xrad004 name="input.b.l_xrad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrad004
            
            #add-point:AFTER FIELD l_xrad004 name="input.a.l_xrad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrad004
            #add-point:ON CHANGE l_xrad004 name="input.g.l_xrad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xred014_21
            #add-point:BEFORE FIELD l_xred014_21 name="input.b.l_xred014_21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xred014_21
            
            #add-point:AFTER FIELD l_xred014_21 name="input.a.l_xred014_21"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xred014_21
            #add-point:ON CHANGE l_xred014_21 name="input.g.l_xred014_21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xred014_22
            #add-point:BEFORE FIELD l_xred014_22 name="input.b.l_xred014_22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xred014_22
            
            #add-point:AFTER FIELD l_xred014_22 name="input.a.l_xred014_22"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xred014_22
            #add-point:ON CHANGE l_xred014_22 name="input.g.l_xred014_22"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrejsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejsite
            #add-point:ON ACTION controlp INFIELD xrejsite name="input.c.xrejsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrej_m.xrejsite
            #LET g_qryparam.where = " ooef201 = 'Y' "   #161006-00005#6   mark
            #CALL q_ooef001()                           #161006-00005#6   mark
            CALL q_ooef001_46()                         #161006-00005#6   add 
            LET g_xrej_m.xrejsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_xrej_m.xrejsite) RETURNING g_xrej_m.l_xrejsite_desc
            DISPLAY BY NAME g_xrej_m.xrejsite,g_xrej_m.l_xrejsite_desc
            NEXT FIELD xrejsite
            #END add-point
 
 
         #Ctrlp:input.c.xrejld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejld
            #add-point:ON ACTION controlp INFIELD xrejld name="input.c.xrejld"
            INITIALIZE g_qryparam.* TO NULL
            CALL s_fin_account_center_sons_query('3',g_xrej_m.xrejsite,g_today,'1')
            CALL s_fin_account_center_ld_str()RETURNING l_origin_str
            CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrej_m.xrejld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            LET g_qryparam.where = " glaald IN ",l_origin_str CLIPPED," "
            CALL q_authorised_ld()
            LET g_xrej_m.xrejld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_xrej_m.xrejld) RETURNING g_xrej_m.l_xrejld_desc     
            DISPLAY BY NAME g_xrej_m.xrejld,g_xrej_m.l_xrejld_desc
            NEXT FIELD xrejld 
            #END add-point
 
 
         #Ctrlp:input.c.xrej004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej004
            #add-point:ON ACTION controlp INFIELD xrej004 name="input.c.xrej004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrej_m.xrej004
            CALL q_ooag001()
            LET g_xrej_m.xrej004 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_xrej_m.xrej004) RETURNING g_xrej_m.l_xrej004_desc
            DISPLAY BY NAME g_xrej_m.xrej004,g_xrej_m.l_xrej004_desc
            NEXT FIELD xrej004
            #END add-point
 
 
         #Ctrlp:input.c.xrejdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocno
            #add-point:ON ACTION controlp INFIELD xrejdocno name="input.c.xrejdocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_xrej_m.xrejld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrej_m.xrejdocno
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#8 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF            
            #161104-00046#8 --e add            
            CALL q_ooba002_1()
            LET g_xrej_m.xrejdocno = g_qryparam.return1
             DISPLAY BY NAME g_xrej_m.xrejdocno
            NEXT FIELD xrejdocno
            #END add-point
 
 
         #Ctrlp:input.c.xrej001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej001
            #add-point:ON ACTION controlp INFIELD xrej001 name="input.c.xrej001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrej002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrej002
            #add-point:ON ACTION controlp INFIELD xrej002 name="input.c.xrej002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrejdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocdt
            #add-point:ON ACTION controlp INFIELD xrejdocdt name="input.c.xrejdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.glcb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glcb003
            #add-point:ON ACTION controlp INFIELD glcb003 name="input.c.glcb003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.default1 = g_xrej_m.glcb003
            CALL q_xrad001()    
            LET g_xrej_m.glcb003 = g_qryparam.return1 
            CALL aapt940_01_get_xrad004(g_xrej_m.glcb003)RETURNING g_xrej_m.l_xrad004
            DISPLAY BY NAME g_xrej_m.l_xrad004
            NEXT FIELD glcb003            
            #END add-point
 
 
         #Ctrlp:input.c.l_xrad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrad004
            #add-point:ON ACTION controlp INFIELD l_xrad004 name="input.c.l_xrad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xred014_21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xred014_21
            #add-point:ON ACTION controlp INFIELD l_xred014_21 name="input.c.l_xred014_21"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xred014_22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xred014_22
            #add-point:ON ACTION controlp INFIELD l_xred014_22 name="input.c.l_xred014_22"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            LET l_count = NULL 
            SELECT COUNT(*) INTO l_count
              FROM xrej_t
             WHERE xrejent = g_enterprise
               AND xrejld  = g_xrej_m.xrejld
               AND xrej001 = g_xrej_m.xrej001
               AND xrej002 = g_xrej_m.xrej002
               AND xrej003 = 'AP'
               AND xrejstus <> 'X'
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            
            IF l_count > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00006'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt940_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success_doc = NULL
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
   ELSE
      CALL cl_err_collect_init()

      SELECT glcb002 INTO l_glcb002
        FROM glcb_t
       WHERE glcbent = g_enterprise
         AND glcbld  = g_xrej_m.xrejld
         AND glcb001 ='AP'
      #壞帳準備提列方式非[1:不扣除]才往下產生
      IF l_glcb002 <> '1' THEN
         CALL aapt940_01_ins_xrej(g_xrej_m.*)RETURNING g_sub_success,r_success_doc
         IF NOT g_sub_success THEN
            LET r_success = FALSE
         END IF
      ELSE
         LET r_success = FALSE
      END IF
      CALL cl_err_collect_show()
   END IF
   #151125-00006#2---s
   LET g_xrej_m.xrejdocno = r_success_doc
   CALL aapt940_01_immediately_conf()
   CALL aapt940_01_immediately_gen()
   #151125-00006#2---e
   RETURN r_success,r_success_doc
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt940_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt940_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 開臨時表
# Memo...........:
# Date & Author..: 141030 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt940_01_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE aapt940_01tmp1
   
   SELECT * FROM xrek_t 
    WHERE 1=2 INTO TEMP aapt940_01tmp1
END FUNCTION

################################################################################
# Descriptions...: 批次產生壞帳資料
# Memo...........:
# Date & Author..: 141030 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt940_01_ins_xrej(p_master)
   #DEFINE l_xrej      RECORD LIKE xrej_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xrej  RECORD  #壞帳提列主檔
          xrejent   LIKE xrej_t.xrejent, #企業編號
          xrejownid LIKE xrej_t.xrejownid, #資料所有者
          xrejowndp LIKE xrej_t.xrejowndp, #資料所屬部門
          xrejcrtid LIKE xrej_t.xrejcrtid, #資料建立者
          xrejcrtdp LIKE xrej_t.xrejcrtdp, #資料建立部門
          xrejcrtdt LIKE xrej_t.xrejcrtdt, #資料創建日
          xrejmodid LIKE xrej_t.xrejmodid, #資料修改者
          xrejmoddt LIKE xrej_t.xrejmoddt, #最近修改日
          xrejcnfid LIKE xrej_t.xrejcnfid, #資料確認者
          xrejcnfdt LIKE xrej_t.xrejcnfdt, #資料確認日
          xrejstus  LIKE xrej_t.xrejstus, #狀態碼
          xrejsite  LIKE xrej_t.xrejsite, #帳務中心
          xrejld    LIKE xrej_t.xrejld, #帳套
          xrejcomp  LIKE xrej_t.xrejcomp, #法人
          xrejdocno LIKE xrej_t.xrejdocno, #單號
          xrejdocdt LIKE xrej_t.xrejdocdt, #單據日期
          xrej001   LIKE xrej_t.xrej001, #年度
          xrej002   LIKE xrej_t.xrej002, #期別
          xrej003   LIKE xrej_t.xrej003, #來源模組
          xrej004   LIKE xrej_t.xrej004, #帳務人員
          xrej005   LIKE xrej_t.xrej005, #傳票號碼
          xrejud001 LIKE xrej_t.xrejud001, #自定義欄位(文字)001
          xrejud002 LIKE xrej_t.xrejud002, #自定義欄位(文字)002
          xrejud003 LIKE xrej_t.xrejud003, #自定義欄位(文字)003
          xrejud004 LIKE xrej_t.xrejud004, #自定義欄位(文字)004
          xrejud005 LIKE xrej_t.xrejud005, #自定義欄位(文字)005
          xrejud006 LIKE xrej_t.xrejud006, #自定義欄位(文字)006
          xrejud007 LIKE xrej_t.xrejud007, #自定義欄位(文字)007
          xrejud008 LIKE xrej_t.xrejud008, #自定義欄位(文字)008
          xrejud009 LIKE xrej_t.xrejud009, #自定義欄位(文字)009
          xrejud010 LIKE xrej_t.xrejud010, #自定義欄位(文字)010
          xrejud011 LIKE xrej_t.xrejud011, #自定義欄位(數字)011
          xrejud012 LIKE xrej_t.xrejud012, #自定義欄位(數字)012
          xrejud013 LIKE xrej_t.xrejud013, #自定義欄位(數字)013
          xrejud014 LIKE xrej_t.xrejud014, #自定義欄位(數字)014
          xrejud015 LIKE xrej_t.xrejud015, #自定義欄位(數字)015
          xrejud016 LIKE xrej_t.xrejud016, #自定義欄位(數字)016
          xrejud017 LIKE xrej_t.xrejud017, #自定義欄位(數字)017
          xrejud018 LIKE xrej_t.xrejud018, #自定義欄位(數字)018
          xrejud019 LIKE xrej_t.xrejud019, #自定義欄位(數字)019
          xrejud020 LIKE xrej_t.xrejud020, #自定義欄位(數字)020
          xrejud021 LIKE xrej_t.xrejud021, #自定義欄位(日期時間)021
          xrejud022 LIKE xrej_t.xrejud022, #自定義欄位(日期時間)022
          xrejud023 LIKE xrej_t.xrejud023, #自定義欄位(日期時間)023
          xrejud024 LIKE xrej_t.xrejud024, #自定義欄位(日期時間)024
          xrejud025 LIKE xrej_t.xrejud025, #自定義欄位(日期時間)025
          xrejud026 LIKE xrej_t.xrejud026, #自定義欄位(日期時間)026
          xrejud027 LIKE xrej_t.xrejud027, #自定義欄位(日期時間)027
          xrejud028 LIKE xrej_t.xrejud028, #自定義欄位(日期時間)028
          xrejud029 LIKE xrej_t.xrejud029, #自定義欄位(日期時間)029
          xrejud030 LIKE xrej_t.xrejud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   DEFINE p_master    type_g_xrej_m
   DEFINE r_success   LIKE type_t.num5   
   DEFINE l_dat       LIKE type_t.dat
   DEFINE l_comp      LIKE ooef_t.ooef001
   DEFINE l_sql       STRING
   DEFINE l_glcb008   LIKE glcb_t.glcb008
   DEFINE l_count     LIKE type_t.num10
   DEFINE r_success_doc LIKE xrej_t.xrejdocno
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   #依INPUT 資料產生單頭
   LET l_comp = NULL
   SELECT glaacomp INTO l_comp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_master.xrejld
   LET r_success_doc = NULL
   INITIALIZE l_xrej.* TO NULL
   LET l_xrej.xrejent   = g_enterprise
   LET l_xrej.xrejsite  = p_master.xrejsite
   LET l_xrej.xrejld    = p_master.xrejld
   LET l_xrej.xrejcomp  = l_comp
   LET l_xrej.xrejdocdt = p_master.xrejdocdt
   CALL s_aooi200_fin_gen_docno(p_master.xrejld,'','',p_master.xrejdocno,l_xrej.xrejdocdt,'aapt940')
      RETURNING g_sub_success,l_xrej.xrejdocno
   LET l_xrej.xrej001   = p_master.xrej001
   LET l_xrej.xrej002   = p_master.xrej002
   LET l_xrej.xrej003   = 'AP'
   LET l_xrej.xrej004   = p_master.xrej004
   LET l_dat = cl_get_current()
   LET l_xrej.xrejcrtid = g_user
   LET l_xrej.xrejcrtdt = l_dat
   LET l_xrej.xrejcrtdp = g_dept
   LET l_xrej.xrejstus  = 'N'
   #INSERT INTO xrej_t VALUES(l_xrej.*) #161108-00017#4 mark
   #161108-00017#4 add ------
   INSERT INTO xrej_t (xrejent,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,
                       xrejcrtdt,xrejmodid,xrejmoddt,xrejcnfid,xrejcnfdt,
                       xrejstus,xrejsite,xrejld,xrejcomp,xrejdocno,xrejdocdt,
                       xrej001,xrej002,xrej003,xrej004,xrej005,
                       xrejud001,xrejud002,xrejud003,xrejud004,xrejud005,
                       xrejud006,xrejud007,xrejud008,xrejud009,xrejud010,
                       xrejud011,xrejud012,xrejud013,xrejud014,xrejud015,
                       xrejud016,xrejud017,xrejud018,xrejud019,xrejud020,
                       xrejud021,xrejud022,xrejud023,xrejud024,xrejud025,
                       xrejud026,xrejud027,xrejud028,xrejud029,xrejud030
                      )
   VALUES (l_xrej.xrejent,l_xrej.xrejownid,l_xrej.xrejowndp,l_xrej.xrejcrtid,l_xrej.xrejcrtdp,
           l_xrej.xrejcrtdt,l_xrej.xrejmodid,l_xrej.xrejmoddt,l_xrej.xrejcnfid,l_xrej.xrejcnfdt,
           l_xrej.xrejstus,l_xrej.xrejsite,l_xrej.xrejld,l_xrej.xrejcomp,l_xrej.xrejdocno,l_xrej.xrejdocdt,
           l_xrej.xrej001,l_xrej.xrej002,l_xrej.xrej003,l_xrej.xrej004,l_xrej.xrej005,
           l_xrej.xrejud001,l_xrej.xrejud002,l_xrej.xrejud003,l_xrej.xrejud004,l_xrej.xrejud005,
           l_xrej.xrejud006,l_xrej.xrejud007,l_xrej.xrejud008,l_xrej.xrejud009,l_xrej.xrejud010,
           l_xrej.xrejud011,l_xrej.xrejud012,l_xrej.xrejud013,l_xrej.xrejud014,l_xrej.xrejud015,
           l_xrej.xrejud016,l_xrej.xrejud017,l_xrej.xrejud018,l_xrej.xrejud019,l_xrej.xrejud020,
           l_xrej.xrejud021,l_xrej.xrejud022,l_xrej.xrejud023,l_xrej.xrejud024,l_xrej.xrejud025,
           l_xrej.xrejud026,l_xrej.xrejud027,l_xrej.xrejud028,l_xrej.xrejud029,l_xrej.xrejud030
          )
   #161108-00017#4 add end---
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xrej'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF  
   
   LET l_glcb008 = NULL
   SELECT glcb008 INTO l_glcb008 FROM glcb_t
    WHERE glcbent = g_enterprise AND glcbld  = p_master.xrejld AND glcb001='AP'
   #step 1 處理當期
       #依規則塞入tmp table
   #LET l_sql = " SELECT * FROM xrea_t ",   #161208-00026#15   mark
   #161208-00026#15   add---s
   LET l_sql = " SELECT xreaent,xreacomp,xreasite,xreald,xrea001,
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
                        xreaud028,xreaud029,xreaud030,xrea044,xrea045 
                   FROM xrea_t ",
   #161208-00026#15   add---e
               "  WHERE xreaent = ",g_enterprise," ",
               "    AND xreald  = '",p_master.xrejld,"' ",
               "    AND xrea001 = '",p_master.xrej001,"' ",
               "    AND xrea002 = '",p_master.xrej002,"' ",
               "    AND xrea003 = 'AP' "
               
   LET l_sql = l_sql CLIPPED,
               " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "
   #暫估單               
   IF p_master.l_xred014_21 = 'Y' THEN
      LET l_sql = l_sql CLIPPED,
               " OR (xrea004 LIKE '0%') "
   END IF
   #折讓待抵
   IF p_master.l_xred014_22 = 'Y' THEN
      LET l_sql = l_sql CLIPPED,
               " OR (xrea004 LIKE '2%') "   
   END IF
   
   
   LET l_sql = l_sql CLIPPED,")"
   PREPARE aapp94001_xreap1 FROM l_sql 
   DECLARE aapp94001_xreac1 CURSOR FOR aapp94001_xreap1
   
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql CLIPPED,")"
   PREPARE aapp94001_countp1 FROM l_sql
   
   LET l_count = NULL
   EXECUTE aapp94001_countp1 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   CALL aapt940_01_ins_xrek(l_xrej.xrejld,l_xrej.xrejdocno,
                            l_xrej.xrej001,l_xrej.xrej002,p_master.glcb003)
      RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF
   IF NOT r_success THEN
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00125'
      LET g_errparam.replace[1] = l_xrej.xrejdocno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success_doc = l_xrej.xrejdocno
   END IF
   RETURN r_success,r_success_doc
END FUNCTION

################################################################################
# Descriptions...: 產生壞帳單身
# Memo...........:
# Date & Author..: 141030 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt940_01_ins_xrek(p_ld,p_xrejdocno,p_xrej001,p_xrej002,p_glcb003)
   DEFINE p_xrej001     LIKE xrej_t.xrej001
   DEFINE p_xrej002     LIKE xrej_t.xrej002
   DEFINE p_ld          LIKE xrej_t.xrejld
   DEFINE p_xrejdocno   LIKE xrej_t.xrejdocno
   DEFINE p_glcb003     LIKE glcb_t.glcb003
   #DEFINE l_xrek        RECORD LIKE xrek_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xrek  RECORD  #壞帳提列明細檔
          xrekent   LIKE xrek_t.xrekent, #企業編號
          xrekcomp  LIKE xrek_t.xrekcomp, #法人
          xrekld    LIKE xrek_t.xrekld, #帳套
          xrekdocno LIKE xrek_t.xrekdocno, #單據號碼
          xrekseq   LIKE xrek_t.xrekseq, #序號
          xrek001   LIKE xrek_t.xrek001, #年度
          xrek002   LIKE xrek_t.xrek002, #期別
          xrek003   LIKE xrek_t.xrek003, #來源模組
          xrek004   LIKE xrek_t.xrek004, #帳款單性質
          xrek005   LIKE xrek_t.xrek005, #帳款單號碼
          xrek006   LIKE xrek_t.xrek006, #帳款單項次
          xrek007   LIKE xrek_t.xrek007, #分期帳款序
          xrek008   LIKE xrek_t.xrek008, #立帳日期
          xrek009   LIKE xrek_t.xrek009, #帳款對象
          xrek010   LIKE xrek_t.xrek010, #收款對象
          xrek011   LIKE xrek_t.xrek011, #部門
          xrek012   LIKE xrek_t.xrek012, #責任中心
          xrek013   LIKE xrek_t.xrek013, #區域
          xrek014   LIKE xrek_t.xrek014, #客群
          xrek015   LIKE xrek_t.xrek015, #產品類別
          xrek016   LIKE xrek_t.xrek016, #人員
          xrek017   LIKE xrek_t.xrek017, #專案編號
          xrek018   LIKE xrek_t.xrek018, #WBS編號
          xrek019   LIKE xrek_t.xrek019, #壞帳科目
          xrekorga  LIKE xrek_t.xrekorga, #來源組織
          xrek020   LIKE xrek_t.xrek020, #經營方式
          xrek021   LIKE xrek_t.xrek021, #通路
          xrek022   LIKE xrek_t.xrek022, #品牌
          xrek023   LIKE xrek_t.xrek023, #自由核算項一
          xrek024   LIKE xrek_t.xrek024, #自由核算項二
          xrek025   LIKE xrek_t.xrek025, #自由核算項三
          xrek026   LIKE xrek_t.xrek026, #自由核算項四
          xrek027   LIKE xrek_t.xrek027, #自由核算項五
          xrek028   LIKE xrek_t.xrek028, #自由核算項六
          xrek029   LIKE xrek_t.xrek029, #自由核算項七
          xrek030   LIKE xrek_t.xrek030, #自由核算項八
          xrek031   LIKE xrek_t.xrek031, #自由核算項九
          xrek032   LIKE xrek_t.xrek032, #自由核算項十
          xrek033   LIKE xrek_t.xrek033, #摘要
          xrek034   LIKE xrek_t.xrek034, #信評等級
          xrek035   LIKE xrek_t.xrek035, #帳齡類型
          xrek036   LIKE xrek_t.xrek036, #帳齡起算日
          xrek037   LIKE xrek_t.xrek037, #本期帳齡天數
          xrek038   LIKE xrek_t.xrek038, #前期帳齡天數
          xrek039   LIKE xrek_t.xrek039, #本期壞帳提列率
          xrek040   LIKE xrek_t.xrek040, #前期壞帳提列率
          xrek041   LIKE xrek_t.xrek041, #備抵科目
          xrek100   LIKE xrek_t.xrek100, #幣別
          xrek101   LIKE xrek_t.xrek101, #匯率
          xrek103   LIKE xrek_t.xrek103, #本期原幣未沖金額
          xrek104   LIKE xrek_t.xrek104, #前期原幣未沖金額
          xrek105   LIKE xrek_t.xrek105, #本期原幣應計提壞帳金額
          xrek106   LIKE xrek_t.xrek106, #前期原幣應計提壞帳金額
          xrek107   LIKE xrek_t.xrek107, #本期實提原幣金額
          xrek113   LIKE xrek_t.xrek113, #本期本幣未沖金額
          xrek114   LIKE xrek_t.xrek114, #前期本幣未沖金額
          xrek115   LIKE xrek_t.xrek115, #本期本幣應計提壞帳金額
          xrek116   LIKE xrek_t.xrek116, #前期本幣應計提壞帳金額
          xrek117   LIKE xrek_t.xrek117, #本期實提本幣金額
          xrek121   LIKE xrek_t.xrek121, #本位幣二匯率
          xrek123   LIKE xrek_t.xrek123, #本期本位幣二未沖金額
          xrek124   LIKE xrek_t.xrek124, #前期本位幣二未沖金額
          xrek125   LIKE xrek_t.xrek125, #本期本位幣二應計提壞帳金額
          xrek126   LIKE xrek_t.xrek126, #前期本位幣二應計提壞帳金額
          xrek127   LIKE xrek_t.xrek127, #本期實提本位幣二壞帳金額
          xrek131   LIKE xrek_t.xrek131, #本位幣三匯率
          xrek133   LIKE xrek_t.xrek133, #本期本位幣三未沖金額
          xrek134   LIKE xrek_t.xrek134, #前期本位幣三未沖金額
          xrek135   LIKE xrek_t.xrek135, #本期本位幣三應計提壞帳金額
          xrek136   LIKE xrek_t.xrek136, #前期本位幣三應計提壞帳金額
          xrek137   LIKE xrek_t.xrek137, #本期實提本位幣三壞帳金額
          xrekud001 LIKE xrek_t.xrekud001, #自定義欄位(文字)001
          xrekud002 LIKE xrek_t.xrekud002, #自定義欄位(文字)002
          xrekud003 LIKE xrek_t.xrekud003, #自定義欄位(文字)003
          xrekud004 LIKE xrek_t.xrekud004, #自定義欄位(文字)004
          xrekud005 LIKE xrek_t.xrekud005, #自定義欄位(文字)005
          xrekud006 LIKE xrek_t.xrekud006, #自定義欄位(文字)006
          xrekud007 LIKE xrek_t.xrekud007, #自定義欄位(文字)007
          xrekud008 LIKE xrek_t.xrekud008, #自定義欄位(文字)008
          xrekud009 LIKE xrek_t.xrekud009, #自定義欄位(文字)009
          xrekud010 LIKE xrek_t.xrekud010, #自定義欄位(文字)010
          xrekud011 LIKE xrek_t.xrekud011, #自定義欄位(數字)011
          xrekud012 LIKE xrek_t.xrekud012, #自定義欄位(數字)012
          xrekud013 LIKE xrek_t.xrekud013, #自定義欄位(數字)013
          xrekud014 LIKE xrek_t.xrekud014, #自定義欄位(數字)014
          xrekud015 LIKE xrek_t.xrekud015, #自定義欄位(數字)015
          xrekud016 LIKE xrek_t.xrekud016, #自定義欄位(數字)016
          xrekud017 LIKE xrek_t.xrekud017, #自定義欄位(數字)017
          xrekud018 LIKE xrek_t.xrekud018, #自定義欄位(數字)018
          xrekud019 LIKE xrek_t.xrekud019, #自定義欄位(數字)019
          xrekud020 LIKE xrek_t.xrekud020, #自定義欄位(數字)020
          xrekud021 LIKE xrek_t.xrekud021, #自定義欄位(日期時間)021
          xrekud022 LIKE xrek_t.xrekud022, #自定義欄位(日期時間)022
          xrekud023 LIKE xrek_t.xrekud023, #自定義欄位(日期時間)023
          xrekud024 LIKE xrek_t.xrekud024, #自定義欄位(日期時間)024
          xrekud025 LIKE xrek_t.xrekud025, #自定義欄位(日期時間)025
          xrekud026 LIKE xrek_t.xrekud026, #自定義欄位(日期時間)026
          xrekud027 LIKE xrek_t.xrekud027, #自定義欄位(日期時間)027
          xrekud028 LIKE xrek_t.xrekud028, #自定義欄位(日期時間)028
          xrekud029 LIKE xrek_t.xrekud029, #自定義欄位(日期時間)029
          xrekud030 LIKE xrek_t.xrekud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   DEFINE l_sql         STRING
   #DEFINE l_xrea        RECORD LIKE xrea_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
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
   #161104-00024#6-add(e)
   DEFINE l_xrek1       RECORD
                        xrekdocno LIKE xrek_t.xrekdocno,
                        xrekseq   LIKE xrek_t.xrekseq,
                        xrek009   LIKE xrek_t.xrek009,
                        xrek100   LIKE xrek_t.xrek100,
                        xrek103   LIKE xrek_t.xrek103,
                        xrek113   LIKE xrek_t.xrek113,
                        xrek123   LIKE xrek_t.xrek123,
                        xrek133   LIKE xrek_t.xrek133
                        END RECORD
   DEFINE l_xrek2       RECORD
                        xrekdocno LIKE xrek_t.xrekdocno,
                        xrekseq   LIKE xrek_t.xrekseq,
                        xrek103   LIKE xrek_t.xrek103,
                        xrek113   LIKE xrek_t.xrek113,
                        xrek123   LIKE xrek_t.xrek123,
                        xrek133   LIKE xrek_t.xrek133
                        END RECORD
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   #DEFINE l_xraf        RECORD LIKE xraf_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xraf  RECORD  #壞帳提列率依信評級設定檔
          xrafent   LIKE xraf_t.xrafent, #企業編號
          xraf001   LIKE xraf_t.xraf001, #帳齡類型編號
          xraf002   LIKE xraf_t.xraf002, #信評等級
          xraf003   LIKE xraf_t.xraf003, #分段一壞帳提列率
          xraf004   LIKE xraf_t.xraf004, #分段二壞帳提列率
          xraf005   LIKE xraf_t.xraf005, #分段三壞帳提列率
          xraf006   LIKE xraf_t.xraf006, #分段四壞帳提列率
          xraf007   LIKE xraf_t.xraf007, #分段五壞帳提列率
          xraf008   LIKE xraf_t.xraf008, #分段六壞帳提列率
          xraf009   LIKE xraf_t.xraf009, #分段七壞帳提列率
          xraf010   LIKE xraf_t.xraf010, #分段八壞帳提列率
          xraf011   LIKE xraf_t.xraf011, #分段九壞帳提列率
          xraf012   LIKE xraf_t.xraf012, #分段十壞帳提列率
          xraf013   LIKE xraf_t.xraf013, #分段十一壞帳提列率
          xraf014   LIKE xraf_t.xraf014, #分段十二壞帳提列率
          xraf015   LIKE xraf_t.xraf015, #分段十三壞帳提列率
          xraf016   LIKE xraf_t.xraf016, #分段十四壞帳提列率
          xraf017   LIKE xraf_t.xraf017, #分段十五壞帳提列率
          xraf018   LIKE xraf_t.xraf018, #分段十六壞帳提列率
          xraf019   LIKE xraf_t.xraf019, #分段十七壞帳提列率
          xraf020   LIKE xraf_t.xraf020, #分段十八壞帳提列率
          xraf021   LIKE xraf_t.xraf021, #分段十九壞帳提列率
          xraf022   LIKE xraf_t.xraf022, #分段二十壞帳提列率
          xrafud001 LIKE xraf_t.xrafud001, #自定義欄位(文字)001
          xrafud002 LIKE xraf_t.xrafud002, #自定義欄位(文字)002
          xrafud003 LIKE xraf_t.xrafud003, #自定義欄位(文字)003
          xrafud004 LIKE xraf_t.xrafud004, #自定義欄位(文字)004
          xrafud005 LIKE xraf_t.xrafud005, #自定義欄位(文字)005
          xrafud006 LIKE xraf_t.xrafud006, #自定義欄位(文字)006
          xrafud007 LIKE xraf_t.xrafud007, #自定義欄位(文字)007
          xrafud008 LIKE xraf_t.xrafud008, #自定義欄位(文字)008
          xrafud009 LIKE xraf_t.xrafud009, #自定義欄位(文字)009
          xrafud010 LIKE xraf_t.xrafud010, #自定義欄位(文字)010
          xrafud011 LIKE xraf_t.xrafud011, #自定義欄位(數字)011
          xrafud012 LIKE xraf_t.xrafud012, #自定義欄位(數字)012
          xrafud013 LIKE xraf_t.xrafud013, #自定義欄位(數字)013
          xrafud014 LIKE xraf_t.xrafud014, #自定義欄位(數字)014
          xrafud015 LIKE xraf_t.xrafud015, #自定義欄位(數字)015
          xrafud016 LIKE xraf_t.xrafud016, #自定義欄位(數字)016
          xrafud017 LIKE xraf_t.xrafud017, #自定義欄位(數字)017
          xrafud018 LIKE xraf_t.xrafud018, #自定義欄位(數字)018
          xrafud019 LIKE xraf_t.xrafud019, #自定義欄位(數字)019
          xrafud020 LIKE xraf_t.xrafud020, #自定義欄位(數字)020
          xrafud021 LIKE xraf_t.xrafud021, #自定義欄位(日期時間)021
          xrafud022 LIKE xraf_t.xrafud022, #自定義欄位(日期時間)022
          xrafud023 LIKE xraf_t.xrafud023, #自定義欄位(日期時間)023
          xrafud024 LIKE xraf_t.xrafud024, #自定義欄位(日期時間)024
          xrafud025 LIKE xraf_t.xrafud025, #自定義欄位(日期時間)025
          xrafud026 LIKE xraf_t.xrafud026, #自定義欄位(日期時間)026
          xrafud027 LIKE xraf_t.xrafud027, #自定義欄位(日期時間)027
          xrafud028 LIKE xraf_t.xrafud028, #自定義欄位(日期時間)028
          xrafud029 LIKE xraf_t.xrafud029, #自定義欄位(日期時間)029
          xrafud030 LIKE xraf_t.xrafud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_glcb008     LIKE glcb_t.glcb008
   DEFINE l_xrad004     LIKE xrad_t.xrad004
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_strdat      LIKE type_t.dat
   DEFINE l_enddat      LIKE type_t.dat
   DEFINE l_xrae002     LIKE xrae_t.xrae002
   
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   
   LET l_glcb008 = NULL
   SELECT glcb008 INTO l_glcb008 FROM glcb_t
    WHERE glcbent = g_enterprise
      AND glcbld  = p_ld
      AND glcb001 = 'AP'
      
   LET l_year = p_xrej001
   LET l_month = p_xrej002
   LET l_month = l_month - 1 
   IF l_month = 0 THEN
      LET l_month = 12
      LET l_year = l_year - 1
   END IF
      
   DELETE FROM aapt940_01tmp1
   
       
   INITIALIZE l_xrea.* TO NULL
   #FOREACH aapp94001_xreac1 INTO l_xrea.*   #161208-00026#15   mark
   #161208-00026#15   add---s
   FOREACH aapp94001_xreac1 
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
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "aapt940_01_ins_xrek:FOREACH "
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_xrek.* TO NULL
      LET l_xrek.xrekent   = g_enterprise
      LET l_xrek.xrekcomp  = l_xrea.xreacomp
      LET l_xrek.xrekld    = l_xrea.xreald
      LET l_xrek.xrekdocno = p_xrejdocno
      LET l_xrek.xrekseq = NULL
      SELECT MAX(xrekseq) INTO l_xrek.xrekseq
        FROM aapt940_01tmp1
       WHERE xrekent   = g_enterprise
         AND xrekdocno = p_xrejdocno
      IF cl_null(l_xrek.xrekseq)THEN
         LET l_xrek.xrekseq = 0
      END IF      
      LET l_xrek.xrekseq = l_xrek.xrekseq + 1
      LET l_xrek.xrek001 = l_xrea.xrea001
      LET l_xrek.xrek002 = l_xrea.xrea002
      LET l_xrek.xrek003 = 'AP'
      LET l_xrek.xrek004 = l_xrea.xrea004
      LET l_xrek.xrek005 = l_xrea.xrea005
      LET l_xrek.xrek006 = l_xrea.xrea006
      LET l_xrek.xrek007 = l_xrea.xrea007
      #########################################
      #抓前期資料
      #LET l_xrek.xrek040 old 039
      #LET l_xrek.xrek104 old 103
      #LET l_xrek.xrek106 old 105
      #LET l_xrek.xrek114 = old 113
      #LET l_xrek.xrek116 old 115
      #LET l_xrek.xrek124 = old 123
      #LET l_xrek.xrek126 old 125
      #LET l_xrek.xrek134 = old 133
      #LET l_xrek.xrek136 old 135
      SELECT xrek039,xrek103,xrek105,
             xrek113,xrek115,xrek123,xrek125
             xrek133,xrek135
        INTO l_xrek.xrek040,l_xrek.xrek104,l_xrek.xrek106,
             l_xrek.xrek114,l_xrek.xrek116,l_xrek.xrek124,
             l_xrek.xrek126,l_xrek.xrek134,l_xrek.xrek136
        FROM xrek_t
       WHERE xrekent = g_enterprise
         AND xrekld  = p_ld
         AND xrek005 = l_xrek.xrek005
         AND xrek006 = l_xrek.xrek006
         AND xrek007 = l_xrek.xrek007
         AND xrek001 = l_year
         AND xrek002 = l_month
      IF cl_null(l_xrek.xrek040)THEN LET l_xrek.xrek040 = 0 END IF
      IF cl_null(l_xrek.xrek104)THEN LET l_xrek.xrek104 = 0 END IF
      IF cl_null(l_xrek.xrek106)THEN LET l_xrek.xrek106 = 0 END IF  
      IF cl_null(l_xrek.xrek114)THEN LET l_xrek.xrek114 = 0 END IF
      IF cl_null(l_xrek.xrek116)THEN LET l_xrek.xrek116 = 0 END IF
      IF cl_null(l_xrek.xrek124)THEN LET l_xrek.xrek124 = 0 END IF
      IF cl_null(l_xrek.xrek126)THEN LET l_xrek.xrek126 = 0 END IF
      IF cl_null(l_xrek.xrek134)THEN LET l_xrek.xrek134 = 0 END IF
      IF cl_null(l_xrek.xrek136)THEN LET l_xrek.xrek136 = 0 END IF      
      #########################################
      
      LET l_xrek.xrek008 = l_xrea.xrea008
      LET l_xrek.xrek009 = l_xrea.xrea009
      LET l_xrek.xrek010 = l_xrea.xrea010
      LET l_xrek.xrek011 = l_xrea.xrea011
      LET l_xrek.xrek012 = l_xrea.xrea012
      LET l_xrek.xrek013 = l_xrea.xrea013
      LET l_xrek.xrek014 = l_xrea.xrea014
      LET l_xrek.xrek015 = l_xrea.xrea015
      LET l_xrek.xrek016 = l_xrea.xrea016
      LET l_xrek.xrek017 = l_xrea.xrea017
      LET l_xrek.xrek018 = l_xrea.xrea018
      #LET l_xrek.xrek019 = l_xrea.xrea019
      #取 agli172 壞帳損失科目
      SELECT glab005 INTO l_xrek.xrek019 FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = p_ld
         AND glab001 = '23'
         AND glab002 = '8319'
         AND glab003 = '8319_11'
      LET l_xrek.xrekorga = l_xrea.xreaorga
      LET l_xrek.xrek020  = l_xrea.xrea020
      LET l_xrek.xrek021  = l_xrea.xrea021
      LET l_xrek.xrek022  = l_xrea.xrea022
      LET l_xrek.xrek023  = l_xrea.xrea023
      LET l_xrek.xrek024  = l_xrea.xrea024
      LET l_xrek.xrek025  = l_xrea.xrea025
      LET l_xrek.xrek026  = l_xrea.xrea026
      LET l_xrek.xrek027  = l_xrea.xrea027
      LET l_xrek.xrek028  = l_xrea.xrea028
      LET l_xrek.xrek029  = l_xrea.xrea029      
      LET l_xrek.xrek030  = l_xrea.xrea030
      LET l_xrek.xrek031  = l_xrea.xrea031
      LET l_xrek.xrek032  = l_xrea.xrea032
      LET l_xrek.xrek033  = l_xrea.xrea033
      LET l_xrek.xrek034  = l_xrea.xrea039
      LET l_xrek.xrek035  = p_glcb003
      LET l_xrad004 = NULL
      CALL aapt940_01_get_xrad004(l_xrek.xrek035)RETURNING l_xrad004
      #LET l_xrek.xrek036  = 
      CASE
         WHEN l_xrad004 = '01'
            #依單據日
            LET l_xrek.xrek036 = l_xrea.xrea008
         WHEN l_xrad004 = '03'
            #依發票日
            LET l_xrek.xrek036 = l_xrea.xrea034 
         WHEN l_xrad004 = '05'
            #依入帳日
            LET l_xrek.xrek036 = l_xrea.xrea035
         WHEN l_xrad004 = '07'
            #依出入庫日
            LET l_xrek.xrek036 = l_xrea.xrea037
         WHEN l_xrad004 = '09'
            #交易認定日
            LET l_xrek.xrek036 = l_xrea.xrea036
         WHEN l_xrad004 = '90'
            #收付款日
            LET l_xrek.xrek036 = l_xrea.xrea038
      END CASE
      #LET l_xrek.xrek037
      #條件期別最大日期-帳齡起算日(負數則給0) 
      LET l_glaa003 = NULL
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = p_ld
      CALL s_fin_date_get_period_range(l_glaa003,p_xrej001,p_xrej002)
          RETURNING l_strdat,l_enddat
      LET l_xrek.xrek037 = l_enddat - l_xrek.xrek036
      IF cl_null(l_xrek.xrek037) OR l_xrek.xrek037 <= 0 THEN
         LET l_xrek.xrek037 = 0
      END IF
      
      #LET l_xrek.xrek038  old 037   
      #LET l_xrek.xrek039  
      #本期壞帳提列率
      #l_xrek.xrek035   帳齡類型
      #先取帳齡天數在哪個區間
      LET l_xrae002 = NULL
      SELECT xrae002 INTO l_xrae002 FROM xrae_t 
       #WHERE xrae001  = p_glcb003                              #160905-00002#4 mark
       WHERE xraeent  = g_enterprise AND xrae001  = p_glcb003   #160905-00002#4 add
         AND xrae003 <= l_xrek.xrek037 
         AND xrae004 >= l_xrek.xrek037
      #抓各區段的壞帳提列率
      INITIALIZE l_xraf.* TO NULL 
      #SELECT * INTO l_xraf.* FROM xraf_t   #161208-00026#15   mark
      #161208-00026#15   add---s
      SELECT xrafent,xraf001,xraf002,xraf003,xraf004,
             xraf005,xraf006,xraf007,xraf008,xraf009,
             xraf010,xraf011,xraf012,xraf013,xraf014,
             xraf015,xraf016,xraf017,xraf018,xraf019,
             xraf020,xraf021,xraf022,xrafud001,xrafud002,
             xrafud003,xrafud004,xrafud005,xrafud006,xrafud007,
             xrafud008,xrafud009,xrafud010,xrafud011,xrafud012,
             xrafud013,xrafud014,xrafud015,xrafud016,xrafud017,
             xrafud018,xrafud019,xrafud020,xrafud021,xrafud022,
             xrafud023,xrafud024,xrafud025,xrafud026,xrafud027,
             xrafud028,xrafud029,xrafud030 
        INTO l_xraf.xrafent,l_xraf.xraf001,l_xraf.xraf002,l_xraf.xraf003,l_xraf.xraf004,
             l_xraf.xraf005,l_xraf.xraf006,l_xraf.xraf007,l_xraf.xraf008,l_xraf.xraf009,
             l_xraf.xraf010,l_xraf.xraf011,l_xraf.xraf012,l_xraf.xraf013,l_xraf.xraf014,
             l_xraf.xraf015,l_xraf.xraf016,l_xraf.xraf017,l_xraf.xraf018,l_xraf.xraf019,
             l_xraf.xraf020,l_xraf.xraf021,l_xraf.xraf022,l_xraf.xrafud001,l_xraf.xrafud002,
             l_xraf.xrafud003,l_xraf.xrafud004,l_xraf.xrafud005,l_xraf.xrafud006,l_xraf.xrafud007,
             l_xraf.xrafud008,l_xraf.xrafud009,l_xraf.xrafud010,l_xraf.xrafud011,l_xraf.xrafud012,
             l_xraf.xrafud013,l_xraf.xrafud014,l_xraf.xrafud015,l_xraf.xrafud016,l_xraf.xrafud017,
             l_xraf.xrafud018,l_xraf.xrafud019,l_xraf.xrafud020,l_xraf.xrafud021,l_xraf.xrafud022,
             l_xraf.xrafud023,l_xraf.xrafud024,l_xraf.xrafud025,l_xraf.xrafud026,l_xraf.xrafud027,
             l_xraf.xrafud028,l_xraf.xrafud029,l_xraf.xrafud030 
        FROM xraf_t 
      #161208-00026#15   add---s
       #WHERE xraf001 = p_glcb003                               #160905-00002#4 mark
       WHERE xrafent = g_enterprise AND xraf001 = p_glcb003     #160905-00002#4 add
         AND xraf002 = l_xrek.xrek034
      
      CASE
         WHEN l_xrae002 = 1
            LET l_xrek.xrek039 = l_xraf.xraf003
         WHEN l_xrae002 = 2
            LET l_xrek.xrek039 = l_xraf.xraf004
         WHEN l_xrae002 = 3
            LET l_xrek.xrek039 = l_xraf.xraf005
         WHEN l_xrae002 = 4
            LET l_xrek.xrek039 = l_xraf.xraf006
         WHEN l_xrae002 = 5
            LET l_xrek.xrek039 = l_xraf.xraf007
         WHEN l_xrae002 = 6
            LET l_xrek.xrek039 = l_xraf.xraf008
         WHEN l_xrae002 = 7
            LET l_xrek.xrek039 = l_xraf.xraf009
         WHEN l_xrae002 = 8
            LET l_xrek.xrek039 = l_xraf.xraf010
         WHEN l_xrae002 = 9
            LET l_xrek.xrek039 = l_xraf.xraf011
         WHEN l_xrae002 = 10
            LET l_xrek.xrek039 = l_xraf.xraf012
         WHEN l_xrae002 = 11
            LET l_xrek.xrek039 = l_xraf.xraf013
         WHEN l_xrae002 = 12
            LET l_xrek.xrek039 = l_xraf.xraf014
         WHEN l_xrae002 = 13
            LET l_xrek.xrek039 = l_xraf.xraf015
         WHEN l_xrae002 = 14
            LET l_xrek.xrek039 = l_xraf.xraf016
         WHEN l_xrae002 = 15
            LET l_xrek.xrek039 = l_xraf.xraf017
         WHEN l_xrae002 = 16
            LET l_xrek.xrek039 = l_xraf.xraf018
         WHEN l_xrae002 = 17
            LET l_xrek.xrek039 = l_xraf.xraf019
         WHEN l_xrae002 = 18
            LET l_xrek.xrek039 = l_xraf.xraf020
         WHEN l_xrae002 = 19
            LET l_xrek.xrek039 = l_xraf.xraf021
         WHEN l_xrae002 = 20
            LET l_xrek.xrek039 = l_xraf.xraf022
         OTHERWISE 
            LET l_xrek.xrek039 = NULL
      END CASE
      #xrek039 IS NULL 時抓axri014第一頁簽預設值
      #
      IF cl_null(l_xrek.xrek039)THEN
         SELECT xrae005 INTO l_xrek.xrek039 FROM xrae_t
          WHERE xraeent = g_enterprise
            AND xrae001 = p_glcb003
            AND xrae002 = l_xrae002
      END IF
      IF cl_null(l_xrek.xrek039)THEN LET l_xrek.xrek039 = 0 END IF
     
      #LET l_xrek.xrek041
      SELECT glab005 INTO l_xrek.xrek041 FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = p_ld
         AND glab001 = '23'
         AND glab002 = '8319'
         AND glab003 = '8319_21'
      
      LET l_xrek.xrek100 = l_xrea.xrea100
      LET l_xrek.xrek101 = l_xrea.xrea102
      #帳款性質為2*/02/04轉為負數
      IF l_xrek.xrek004[1,1] = 2 OR l_xrek.xrek004 = '02' OR l_xrek.xrek004 = '04' THEN
         LET l_xrea.xrea103 = l_xrea.xrea103 * -1
         LET l_xrea.xrea113 = l_xrea.xrea113 * -1
         LET l_xrea.xrea123 = l_xrea.xrea123 * -1
         LET l_xrea.xrea133 = l_xrea.xrea133 * -1
      END IF      
      LET l_xrek.xrek103 = l_xrea.xrea103
      LET l_xrek.xrek105 = l_xrek.xrek103 * l_xrek.xrek039 / 100

      LET l_xrek.xrek107 = l_xrek.xrek105 - l_xrek.xrek106
      LET l_xrek.xrek113 = l_xrea.xrea113
      LET l_xrek.xrek115 = l_xrek.xrek113 * l_xrek.xrek039 / 100

      LET l_xrek.xrek117 = l_xrek.xrek115 - l_xrek.xrek116
      LET l_xrek.xrek123 = l_xrea.xrea123
      LET l_xrek.xrek121 = l_xrea.xrea122   #141104 SA新增 本位幣二匯率
      LET l_xrek.xrek125 = l_xrek.xrek123 * l_xrek.xrek039 / 100

      LET l_xrek.xrek127 = l_xrek.xrek125 - l_xrek.xrek126
      
      LET l_xrek.xrek131 = l_xrea.xrea132   #141104 SA新增 本位幣三匯率 
      LET l_xrek.xrek133  = l_xrea.xrea133
      LET l_xrek.xrek135 = l_xrek.xrek133 * l_xrek.xrek039 / 100

      LET l_xrek.xrek137 = l_xrek.xrek135 - l_xrek.xrek136   
      IF cl_null(l_xrek.xrek038)THEN LET l_xrek.xrek038 = 0 END IF
      #INSERT INTO aapt940_01tmp1 VALUES(l_xrek.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO aapt940_01tmp1 (xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,
                                  xrek001,xrek002,xrek003,xrek004,xrek005,
                                  xrek006,xrek007,xrek008,xrek009,xrek010,
                                  xrek011,xrek012,xrek013,xrek014,xrek015,
                                  xrek016,xrek017,xrek018,xrek019,xrekorga,xrek020,
                                  xrek021,xrek022,xrek023,xrek024,xrek025,
                                  xrek026,xrek027,xrek028,xrek029,xrek030,
                                  xrek031,xrek032,xrek033,xrek034,xrek035,
                                  xrek036,xrek037,xrek038,xrek039,xrek040,
                                  xrek041,xrek100,xrek101,xrek103,xrek104,
                                  xrek105,xrek106,xrek107,xrek113,xrek114,
                                  xrek115,xrek116,xrek117,xrek121,xrek123,
                                  xrek124,xrek125,xrek126,xrek127,xrek131,
                                  xrek133,xrek134,xrek135,xrek136,xrek137,
                                  xrekud001,xrekud002,xrekud003,xrekud004,xrekud005,
                                  xrekud006,xrekud007,xrekud008,xrekud009,xrekud010,
                                  xrekud011,xrekud012,xrekud013,xrekud014,xrekud015,
                                  xrekud016,xrekud017,xrekud018,xrekud019,xrekud020,
                                  xrekud021,xrekud022,xrekud023,xrekud024,xrekud025,
                                  xrekud026,xrekud027,xrekud028,xrekud029,xrekud030
                                 )
      VALUES (l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,
              l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,l_xrek.xrek005,
              l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,
              l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,l_xrek.xrek015,
              l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,l_xrek.xrek020,
              l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,l_xrek.xrek024,l_xrek.xrek025,
              l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,l_xrek.xrek030,
              l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,l_xrek.xrek034,l_xrek.xrek035,
              l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,l_xrek.xrek040,
              l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,l_xrek.xrek103,l_xrek.xrek104,
              l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,l_xrek.xrek114,
              l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,l_xrek.xrek121,l_xrek.xrek123,
              l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,l_xrek.xrek131,
              l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,l_xrek.xrek136,l_xrek.xrek137,
              l_xrek.xrekud001,l_xrek.xrekud002,l_xrek.xrekud003,l_xrek.xrekud004,l_xrek.xrekud005,
              l_xrek.xrekud006,l_xrek.xrekud007,l_xrek.xrekud008,l_xrek.xrekud009,l_xrek.xrekud010,
              l_xrek.xrekud011,l_xrek.xrekud012,l_xrek.xrekud013,l_xrek.xrekud014,l_xrek.xrekud015,
              l_xrek.xrekud016,l_xrek.xrekud017,l_xrek.xrekud018,l_xrek.xrekud019,l_xrek.xrekud020,
              l_xrek.xrekud021,l_xrek.xrekud022,l_xrek.xrekud023,l_xrek.xrekud024,l_xrek.xrekud025,
              l_xrek.xrekud026,l_xrek.xrekud027,l_xrek.xrekud028,l_xrek.xrekud029,l_xrek.xrekud030
             )
      #161108-00017#4 add end---
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "aapt940_01_ins_tmp "
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()      
      END IF
   END FOREACH   
            
   #不扣除就不用處理這段
   #為持當期也是不做這段
   IF l_glcb008 <> '1' AND l_glcb008 <> '4' THEN
      #有扣除就要看是哪種
      #重新組SQL
      #把全部1類的資料都抓進來(正)
      LET l_sql = "SELECT xrekdocno,xrekseq,xrek009,xrek100,xrek103,xrek113,xrek123,xrek133 FROM aapt940_01tmp1 ",
                  " WHERE xrek004 LIKE '1%' "
      CASE l_glcb008
         #先進先出
         WHEN '2' LET l_sql = l_sql," ORDER BY xrek036 "
         #後進先出
         WHEN '3' LET l_sql = l_sql," ORDER BY xrek036 DESC "
      END CASE
      PREPARE sel_aapt940_01p2 FROM l_sql
      DECLARE sel_aapt940_01c2 CURSOR FOR sel_aapt940_01p2
   
      #2類資料要根據1類的交易對象 幣別去抓原幣> 0(負)
      LET l_sql = "SELECT xrekdocno,xrekseq,xrek103,xrek113,xrek123,xrek133 ",
                  "  FROM aapt940_01tmp1 ",
                  " WHERE xrek009 = ? ",
                  "   AND xrek100 = ? ",
                  "   AND (xrek004 LIKE '2%' OR xrek004 IN ('02','04'))",  #暫估(02/04)or待抵(2*)
                  #"   AND xrek103 > 0 "
                  "   AND xrek103 < 0 "  #因為轉負數
      CASE l_glcb008
         #先進先出
         WHEN '2' LET l_sql = l_sql," ORDER BY xrek036 "
         #後進先出
         WHEN '3' LET l_sql = l_sql," ORDER BY xrek036 DESC "
      END CASE                  
      PREPARE sel_aapt940_01p3 FROM l_sql
      DECLARE sel_aapt940_01c3 CURSOR FOR sel_aapt940_01p3
      
      FOREACH sel_aapt940_01c2 INTO l_xrek1.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.extend = 'FOREACH:sel_aapt940_01c2'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH         
         END IF
         
         FOREACH sel_aapt940_01c3 USING l_xrek1.xrek009,l_xrek1.xrek100
            INTO l_xrek2.*
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.extend = 'FOREACH:sel_aapt940_01c2'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOREACH   
            END IF
            
            #判斷少的扣除
            IF s_math_abs(l_xrek2.xrek103) > l_xrek1.xrek103 THEN
               LET l_xrek2.xrek103 = l_xrek2.xrek103 + l_xrek1.xrek103
               LET l_xrek1.xrek103 = l_xrek1.xrek103 - l_xrek1.xrek103
               LET l_xrek2.xrek113 = l_xrek2.xrek113 + l_xrek1.xrek113
               LET l_xrek1.xrek113 = l_xrek1.xrek113 - l_xrek1.xrek113
               LET l_xrek2.xrek123 = l_xrek2.xrek123 + l_xrek1.xrek123
               LET l_xrek1.xrek123 = l_xrek1.xrek123 - l_xrek1.xrek123
               LET l_xrek2.xrek133 = l_xrek2.xrek133 + l_xrek1.xrek133
               LET l_xrek1.xrek133 = l_xrek1.xrek133 - l_xrek1.xrek133               
            ELSE
#               LET l_xrek2.xrek103 = l_xrek2.xrek103 - l_xrek2.xrek103
#               LET l_xrek1.xrek103 = l_xrek1.xrek103 + l_xrek2.xrek103
#               LET l_xrek2.xrek113 = l_xrek2.xrek113 - l_xrek2.xrek113
#               LET l_xrek1.xrek113 = l_xrek1.xrek113 + l_xrek2.xrek113
#               LET l_xrek2.xrek123 = l_xrek2.xrek123 - l_xrek2.xrek123
#               LET l_xrek1.xrek123 = l_xrek1.xrek123 + l_xrek2.xrek123
#               LET l_xrek2.xrek133 = l_xrek2.xrek133 - l_xrek2.xrek133
#               LET l_xrek1.xrek133 = l_xrek1.xrek133 + l_xrek2.xrek133 
               LET l_xrek1.xrek103 = l_xrek1.xrek103 + l_xrek2.xrek103
               LET l_xrek2.xrek103 = l_xrek2.xrek103 - l_xrek2.xrek103
               LET l_xrek1.xrek113 = l_xrek1.xrek113 + l_xrek2.xrek113
               LET l_xrek2.xrek113 = l_xrek2.xrek113 - l_xrek2.xrek113
               LET l_xrek1.xrek123 = l_xrek1.xrek123 + l_xrek2.xrek123
               LET l_xrek2.xrek123 = l_xrek2.xrek123 - l_xrek2.xrek123
               LET l_xrek1.xrek133 = l_xrek1.xrek133 + l_xrek2.xrek133 
               LET l_xrek2.xrek133 = l_xrek2.xrek133 - l_xrek2.xrek133  
            END IF
            
            UPDATE aapt940_01tmp1 SET xrek103 = l_xrek1.xrek103,
                                      xrek113 = l_xrek1.xrek113,
                                      xrek123 = l_xrek1.xrek123,
                                      xrek133 = l_xrek1.xrek133
             WHERE xrekseq = l_xrek1.xrekseq
               AND xrekdocno = l_xrek1.xrekdocno
               
            UPDATE aapt940_01tmp1 SET xrek103 = l_xrek2.xrek103,
                                      xrek113 = l_xrek2.xrek113,
                                      xrek123 = l_xrek2.xrek123,
                                      xrek133 = l_xrek2.xrek133
             WHERE xrekseq = l_xrek2.xrekseq
               AND xrekdocno = l_xrek2.xrekdocno
             
            #正的攤完就跑下一筆正的
            IF l_xrek1.xrek103 = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
      END FOREACH
   END IF
   
   #用這些資料直接INSERT xrek
   #多做一段新的xrek103後面幾個欄位的展算
   #LET l_sql = "SELECT * FROM aapt940_01tmp1 ",      #161208-00026#15   mark
   #161208-00026#15   add---s
   LET l_sql = "SELECT xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,
                       xrek001,xrek002,xrek003,xrek004,xrek005,
                       xrek006,xrek007,xrek008,xrek009,xrek010,
                       xrek011,xrek012,xrek013,xrek014,xrek015,
                       xrek016,xrek017,xrek018,xrek019,xrekorga,
                       xrek020,xrek021,xrek022,xrek023,xrek024,
                       xrek025,xrek026,xrek027,xrek028,xrek029,
                       xrek030,xrek031,xrek032,xrek033,xrek034,
                       xrek035,xrek036,xrek037,xrek038,xrek039,
                       xrek040,xrek041,xrek100,xrek101,xrek103,
                       xrek104,xrek105,xrek106,xrek107,xrek113,
                       xrek114,xrek115,xrek116,xrek117,xrek121,
                       xrek123,xrek124,xrek125,xrek126,xrek127,
                       xrek131,xrek133,xrek134,xrek135,xrek136,
                       xrek137,xrekud001,xrekud002,xrekud003,xrekud004,
                       xrekud005,xrekud006,xrekud007,xrekud008,xrekud009,
                       xrekud010,xrekud011,xrekud012,xrekud013,xrekud014,
                       xrekud015,xrekud016,xrekud017,xrekud018,xrekud019,
                       xrekud020,xrekud021,xrekud022,xrekud023,xrekud024,
                       xrekud025,xrekud026,xrekud027,xrekud028,xrekud029,
                       xrekud030 
                  FROM aapt940_01tmp1 ",
   #161208-00026#15   add---e
               " WHERE xrek103 <> 0 "
   PREPARE sel_aapp940_01p4 FROM l_sql
   DECLARE sel_aapp940_01c4 CURSOR FOR sel_aapp940_01p4
   
   #FOREACH sel_aapp940_01c4 INTO l_xrek.*   #161208-00026#15   mark
   #161208-00026#15   add---s
   FOREACH sel_aapp940_01c4 
      INTO l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,
           l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,l_xrek.xrek005,
           l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,
           l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,l_xrek.xrek015,
           l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,
           l_xrek.xrek020,l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,l_xrek.xrek024,
           l_xrek.xrek025,l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,
           l_xrek.xrek030,l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,l_xrek.xrek034,
           l_xrek.xrek035,l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,
           l_xrek.xrek040,l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,l_xrek.xrek103,
           l_xrek.xrek104,l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,
           l_xrek.xrek114,l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,l_xrek.xrek121,
           l_xrek.xrek123,l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,
           l_xrek.xrek131,l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,l_xrek.xrek136,
           l_xrek.xrek137,l_xrek.xrekud001,l_xrek.xrekud002,l_xrek.xrekud003,l_xrek.xrekud004,
           l_xrek.xrekud005,l_xrek.xrekud006,l_xrek.xrekud007,l_xrek.xrekud008,l_xrek.xrekud009,
           l_xrek.xrekud010,l_xrek.xrekud011,l_xrek.xrekud012,l_xrek.xrekud013,l_xrek.xrekud014,
           l_xrek.xrekud015,l_xrek.xrekud016,l_xrek.xrekud017,l_xrek.xrekud018,l_xrek.xrekud019,
           l_xrek.xrekud020,l_xrek.xrekud021,l_xrek.xrekud022,l_xrek.xrekud023,l_xrek.xrekud024,
           l_xrek.xrekud025,l_xrek.xrekud026,l_xrek.xrekud027,l_xrek.xrekud028,l_xrek.xrekud029,
           l_xrek.xrekud030
   #161208-00026#15   add---e
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'FOREACH:sel_aapt940_01c4'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH            
      END IF
      
      #處理1x5  1x7 跟seq
      LET l_xrek.xrekseq = NULL
      SELECT MAX(xrekseq) INTO l_xrek.xrekseq FROM xrek_t
       WHERE xrekent = g_enterprise
         AND xrekdocno = l_xrek.xrekdocno
      IF cl_null(l_xrek.xrekseq)THEN LET l_xrek.xrekseq = 0 END IF
      LET l_xrek.xrekseq = l_xrek.xrekseq + 1
      
      LET l_xrek.xrek105 = l_xrek.xrek103 * l_xrek.xrek039 / 100
      LET l_xrek.xrek107 = l_xrek.xrek105 - l_xrek.xrek106
      LET l_xrek.xrek115 = l_xrek.xrek113 * l_xrek.xrek039 / 100
      LET l_xrek.xrek117 = l_xrek.xrek115 - l_xrek.xrek116
      LET l_xrek.xrek125 = l_xrek.xrek123 * l_xrek.xrek039 / 100
      LET l_xrek.xrek127 = l_xrek.xrek125 - l_xrek.xrek126
      LET l_xrek.xrek135 = l_xrek.xrek133 * l_xrek.xrek039 / 100
      LET l_xrek.xrek137 = l_xrek.xrek135 - l_xrek.xrek136  
      IF cl_null(l_xrek.xrek038)THEN LET l_xrek.xrek038 = 0 END IF
      IF cl_null(l_xrek.xrek040)THEN LET l_xrek.xrek040 = 0 END IF
      #INSERT INTO xrek_t VALUES(l_xrek.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO xrek_t (xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,
                          xrek001,xrek002,xrek003,xrek004,xrek005,
                          xrek006,xrek007,xrek008,xrek009,xrek010,
                          xrek011,xrek012,xrek013,xrek014,xrek015,
                          xrek016,xrek017,xrek018,xrek019,xrekorga,xrek020,
                          xrek021,xrek022,xrek023,xrek024,xrek025,
                          xrek026,xrek027,xrek028,xrek029,xrek030,
                          xrek031,xrek032,xrek033,xrek034,xrek035,
                          xrek036,xrek037,xrek038,xrek039,xrek040,
                          xrek041,xrek100,xrek101,xrek103,xrek104,
                          xrek105,xrek106,xrek107,xrek113,xrek114,
                          xrek115,xrek116,xrek117,xrek121,xrek123,
                          xrek124,xrek125,xrek126,xrek127,xrek131,
                          xrek133,xrek134,xrek135,xrek136,xrek137,
                          xrekud001,xrekud002,xrekud003,xrekud004,xrekud005,
                          xrekud006,xrekud007,xrekud008,xrekud009,xrekud010,
                          xrekud011,xrekud012,xrekud013,xrekud014,xrekud015,
                          xrekud016,xrekud017,xrekud018,xrekud019,xrekud020,
                          xrekud021,xrekud022,xrekud023,xrekud024,xrekud025,
                          xrekud026,xrekud027,xrekud028,xrekud029,xrekud030
                         )
      VALUES (l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,
              l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,l_xrek.xrek005,
              l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,
              l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,l_xrek.xrek015,
              l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,l_xrek.xrek020,
              l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,l_xrek.xrek024,l_xrek.xrek025,
              l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,l_xrek.xrek030,
              l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,l_xrek.xrek034,l_xrek.xrek035,
              l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,l_xrek.xrek040,
              l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,l_xrek.xrek103,l_xrek.xrek104,
              l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,l_xrek.xrek114,
              l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,l_xrek.xrek121,l_xrek.xrek123,
              l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,l_xrek.xrek131,
              l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,l_xrek.xrek136,l_xrek.xrek137,
              l_xrek.xrekud001,l_xrek.xrekud002,l_xrek.xrekud003,l_xrek.xrekud004,l_xrek.xrekud005,
              l_xrek.xrekud006,l_xrek.xrekud007,l_xrek.xrekud008,l_xrek.xrekud009,l_xrek.xrekud010,
              l_xrek.xrekud011,l_xrek.xrekud012,l_xrek.xrekud013,l_xrek.xrekud014,l_xrek.xrekud015,
              l_xrek.xrekud016,l_xrek.xrekud017,l_xrek.xrekud018,l_xrek.xrekud019,l_xrek.xrekud020,
              l_xrek.xrekud021,l_xrek.xrekud022,l_xrek.xrekud023,l_xrek.xrekud024,l_xrek.xrekud025,
              l_xrek.xrekud026,l_xrek.xrekud027,l_xrek.xrekud028,l_xrek.xrekud029,l_xrek.xrekud030
             )
      #161108-00017#4 add end---
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'ins_xrek1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE      
      END IF
   END FOREACH
       
   #step 2 處理前期
   #LET l_sql = "SELECT * FROM xrek_t a ",   #161208-00026#15   mark
   #161208-00026#15   add---s
   LET l_sql = "SELECT a.xrekent,a.xrekcomp,a.xrekld,a.xrekdocno,a.xrekseq,
                       a.xrek001,a.xrek002,a.xrek003,a.xrek004,a.xrek005,
                       a.xrek006,a.xrek007,a.xrek008,a.xrek009,a.xrek010,
                       a.xrek011,a.xrek012,a.xrek013,a.xrek014,a.xrek015,
                       a.xrek016,a.xrek017,a.xrek018,a.xrek019,a.xrekorga,
                       a.xrek020,a.xrek021,a.xrek022,a.xrek023,a.xrek024,
                       a.xrek025,a.xrek026,a.xrek027,a.xrek028,a.xrek029,
                       a.xrek030,a.xrek031,a.xrek032,a.xrek033,a.xrek034,
                       a.xrek035,a.xrek036,a.xrek037,a.xrek038,a.xrek039,
                       a.xrek040,a.xrek041,a.xrek100,a.xrek101,a.xrek103,
                       a.xrek104,a.xrek105,a.xrek106,a.xrek107,a.xrek113,
                       a.xrek114,a.xrek115,a.xrek116,a.xrek117,a.xrek121,
                       a.xrek123,a.xrek124,a.xrek125,a.xrek126,a.xrek127,
                       a.xrek131,a.xrek133,a.xrek134,a.xrek135,a.xrek136,
                       a.xrek137,a.xrekud001,a.xrekud002,a.xrekud003,a.xrekud004,
                       a.xrekud005,a.xrekud006,a.xrekud007,a.xrekud008,a.xrekud009,
                       a.xrekud010,a.xrekud011,a.xrekud012,a.xrekud013,a.xrekud014,
                       a.xrekud015,a.xrekud016,a.xrekud017,a.xrekud018,a.xrekud019,
                       a.xrekud020,a.xrekud021,a.xrekud022,a.xrekud023,a.xrekud024,
                       a.xrekud025,a.xrekud026,a.xrekud027,a.xrekud028,a.xrekud029,
                       a.xrekud030 
                  FROM xrek_t a ",
   #161208-00026#15   add---e
               " WHERE a.xrekld = '",p_ld,"' ",
               "   AND a.xrek001 = ",l_year," ",
               "   AND a.xrek002 = ",l_month," ",
               "   AND a.xrekent = ",g_enterprise," ",
               "   AND NOT EXISTS(SELECT COUNT(*) FROM xrek_t b ",
               "                   WHERE b.xrek005 = a.xrek005 ",
               "                     AND b.xrekent = a.xrekent ",
               "                     AND b.xrek006 = a.xrek006 ",
               "                     AND b.xrek007 = a.xrek007 ",
               "                     AND b.xrekld  = a.xrekld ",
               "                     AND b.xrekdocno = '",p_xrejdocno,"' )"
   PREPARE sel_aapt940_01p5 FROM l_sql
   DECLARE sel_aapt940_01c5 CURSOR FOR sel_aapt940_01p5
   
   #FOREACH sel_aapt940_01c5 INTO l_xrek.*   #161208-00026#15   mark
   #161208-00026#15   add---s
   FOREACH sel_aapt940_01c5 
      INTO l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,
           l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,l_xrek.xrek005,
           l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,
           l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,l_xrek.xrek015,
           l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,
           l_xrek.xrek020,l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,l_xrek.xrek024,
           l_xrek.xrek025,l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,
           l_xrek.xrek030,l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,l_xrek.xrek034,
           l_xrek.xrek035,l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,
           l_xrek.xrek040,l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,l_xrek.xrek103,
           l_xrek.xrek104,l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,
           l_xrek.xrek114,l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,l_xrek.xrek121,
           l_xrek.xrek123,l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,
           l_xrek.xrek131,l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,l_xrek.xrek136,
           l_xrek.xrek137,l_xrek.xrekud001,l_xrek.xrekud002,l_xrek.xrekud003,l_xrek.xrekud004,
           l_xrek.xrekud005,l_xrek.xrekud006,l_xrek.xrekud007,l_xrek.xrekud008,l_xrek.xrekud009,
           l_xrek.xrekud010,l_xrek.xrekud011,l_xrek.xrekud012,l_xrek.xrekud013,l_xrek.xrekud014,
           l_xrek.xrekud015,l_xrek.xrekud016,l_xrek.xrekud017,l_xrek.xrekud018,l_xrek.xrekud019,
           l_xrek.xrekud020,l_xrek.xrekud021,l_xrek.xrekud022,l_xrek.xrekud023,l_xrek.xrekud024,
           l_xrek.xrekud025,l_xrek.xrekud026,l_xrek.xrekud027,l_xrek.xrekud028,l_xrek.xrekud029,
           l_xrek.xrekud030
   #161208-00026#15   add---e
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'FOREACH:sel_aapt940_01c5'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE 
      END IF
      
      #單號項次年度期別變更
      LET l_xrek.xrekdocno = p_xrejdocno
      LET l_xrek.xrek001   = p_xrej001
      LET l_xrek.xrek002   = p_xrej002
      LET l_xrek.xrekseq = NULL
      SELECT MAX(xrekseq) INTO l_xrek.xrekseq
        FROM xrek_t
       WHERE xrekent = g_enterprise
         AND xrekdocno = l_xrek.xrekdocno
      IF cl_null(l_xrek.xrekseq)THEN LET l_xrek.xrekseq = 0 END IF
      LET l_xrek.xrekseq = l_xrek.xrekseq + 1
      #把原本期給到前期
      LET l_xrek.xrek038 = l_xrek.xrek037
      LET l_xrek.xrek040 = l_xrek.xrek039
      LET l_xrek.xrek104 = l_xrek.xrek103
      LET l_xrek.xrek106 = l_xrek.xrek105
      LET l_xrek.xrek114 = l_xrek.xrek113
      LET l_xrek.xrek116 = l_xrek.xrek115
      LET l_xrek.xrek124 = l_xrek.xrek123
      LET l_xrek.xrek126 = l_xrek.xrek125
      LET l_xrek.xrek134 = l_xrek.xrek133
      LET l_xrek.xrek136 = l_xrek.xrek135
      
      #把本期都給0
      LET l_xrek.xrek103 = 0 
      LET l_xrek.xrek105 = 0
      LET l_xrek.xrek113 = 0 
      LET l_xrek.xrek115 = 0
      LET l_xrek.xrek123 = 0 
      LET l_xrek.xrek125 = 0
      LET l_xrek.xrek133 = 0 
      LET l_xrek.xrek135 = 0      
      #計算差異
      LET l_xrek.xrek107 = l_xrek.xrek105 - l_xrek.xrek106
      LET l_xrek.xrek117 = l_xrek.xrek115 - l_xrek.xrek116
      LET l_xrek.xrek127 = l_xrek.xrek125 - l_xrek.xrek126
      LET l_xrek.xrek137 = l_xrek.xrek135 - l_xrek.xrek136
      IF cl_null(l_xrek.xrek038)THEN LET l_xrek.xrek038 = 0 END IF
      IF cl_null(l_xrek.xrek040)THEN LET l_xrek.xrek040 = 0 END IF     
      #INSERT INTO xrek_t VALUES(l_xrek.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO xrek_t (xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,
                          xrek001,xrek002,xrek003,xrek004,xrek005,
                          xrek006,xrek007,xrek008,xrek009,xrek010,
                          xrek011,xrek012,xrek013,xrek014,xrek015,
                          xrek016,xrek017,xrek018,xrek019,xrekorga,xrek020,
                          xrek021,xrek022,xrek023,xrek024,xrek025,
                          xrek026,xrek027,xrek028,xrek029,xrek030,
                          xrek031,xrek032,xrek033,xrek034,xrek035,
                          xrek036,xrek037,xrek038,xrek039,xrek040,
                          xrek041,xrek100,xrek101,xrek103,xrek104,
                          xrek105,xrek106,xrek107,xrek113,xrek114,
                          xrek115,xrek116,xrek117,xrek121,xrek123,
                          xrek124,xrek125,xrek126,xrek127,xrek131,
                          xrek133,xrek134,xrek135,xrek136,xrek137,
                          xrekud001,xrekud002,xrekud003,xrekud004,xrekud005,
                          xrekud006,xrekud007,xrekud008,xrekud009,xrekud010,
                          xrekud011,xrekud012,xrekud013,xrekud014,xrekud015,
                          xrekud016,xrekud017,xrekud018,xrekud019,xrekud020,
                          xrekud021,xrekud022,xrekud023,xrekud024,xrekud025,
                          xrekud026,xrekud027,xrekud028,xrekud029,xrekud030
                         )
      VALUES (l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,
              l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,l_xrek.xrek005,
              l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,
              l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,l_xrek.xrek015,
              l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,l_xrek.xrek020,
              l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,l_xrek.xrek024,l_xrek.xrek025,
              l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,l_xrek.xrek030,
              l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,l_xrek.xrek034,l_xrek.xrek035,
              l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,l_xrek.xrek040,
              l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,l_xrek.xrek103,l_xrek.xrek104,
              l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,l_xrek.xrek114,
              l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,l_xrek.xrek121,l_xrek.xrek123,
              l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,l_xrek.xrek131,
              l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,l_xrek.xrek136,l_xrek.xrek137,
              l_xrek.xrekud001,l_xrek.xrekud002,l_xrek.xrekud003,l_xrek.xrekud004,l_xrek.xrekud005,
              l_xrek.xrekud006,l_xrek.xrekud007,l_xrek.xrekud008,l_xrek.xrekud009,l_xrek.xrekud010,
              l_xrek.xrekud011,l_xrek.xrekud012,l_xrek.xrekud013,l_xrek.xrekud014,l_xrek.xrekud015,
              l_xrek.xrekud016,l_xrek.xrekud017,l_xrek.xrekud018,l_xrek.xrekud019,l_xrek.xrekud020,
              l_xrek.xrekud021,l_xrek.xrekud022,l_xrek.xrekud023,l_xrek.xrekud024,l_xrek.xrekud025,
              l_xrek.xrekud026,l_xrek.xrekud027,l_xrek.xrekud028,l_xrek.xrekud029,l_xrek.xrekud030
             )
      #161108-00017#4 add end---
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'ins_xrek2'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF         
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 給予輸入預設值
# Memo...........:
# Date & Author..: 141031 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt940_01_default_g_xrej()
   DEFINE l_comp    LIKE ooef_t.ooef001
   DEFINE l_strdat  LIKE type_t.dat
   DEFINE l_enddat  LIKE type_t.dat
   DEFINE l_glaa003 LIKE glaa_t.glaa003
   DEFINE l_ooef004 LIKE ooef_t.ooef004
   WHENEVER ERROR CONTINUE
   CALL cl_set_combo_scc('l_xrad004','8312')
   LET g_xrej_m.xrej001 = YEAR(g_today)
   LET g_xrej_m.xrej002 = MONTH(g_today)
   #LET g_xrej_m.xrejsite = g_site
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_xrej_m.xrejsite,g_errno
   LET g_xrej_m.xrej004  = g_user
   #取得使用者所屬帳套法人
   CALL s_fin_ld_carry('',g_user) RETURNING g_success,g_xrej_m.xrejld,l_comp,g_errno
   CALL s_desc_get_ld_desc(g_xrej_m.xrejld) RETURNING g_xrej_m.l_xrejld_desc
   CALL s_desc_get_department_desc(g_xrej_m.xrejsite)RETURNING g_xrej_m.l_xrejsite_desc           
   CALL s_desc_get_person_desc(g_xrej_m.xrej004) RETURNING g_xrej_m.l_xrej004_desc        
   #單據別參照表號
   SELECT glaa024 INTO l_ooef004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xrej_m.xrejld
   #取得會計周期參照表設定下拉   
   CALL aapt940_01_set_comp(g_xrej_m.xrejld,g_xrej_m.xrej001)
   SELECT glaa003 INTO l_glaa003
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrej_m.xrejld
   #取得該期最大最小日期       
   IF NOT cl_null(l_glaa003)THEN   
      CALL s_fin_date_get_period_range(l_glaa003,g_xrej_m.xrej001,g_xrej_m.xrej002)RETURNING l_strdat,l_enddat
      LET g_xrej_m.xrejdocdt = l_enddat   
   END IF
   
   #帳齡類型
   SELECT glcb003 INTO g_xrej_m.glcb003
     FROM glcb_t
    WHERE glcbent = g_enterprise
      AND glcbld  = g_xrej_m.xrejld
      AND glcb001 = 'AP' 

   LET g_xrej_m.l_xred014_21 = 'N' 
   LET g_xrej_m.l_xred014_22 = 'N'
   CALL aapt940_01_get_xrad004(g_xrej_m.glcb003)RETURNING g_xrej_m.l_xrad004
   DISPLAY BY NAME g_xrej_m.l_xrejld_desc,g_xrej_m.l_xrej004_desc,g_xrej_m.l_xrejsite_desc,
                   g_xrej_m.l_xrad004
   
END FUNCTION

PUBLIC FUNCTION aapt940_01_set_comp(p_ld,p_xrej001)
    DEFINE p_ld       LIKE glaa_t.glaald
    DEFINE p_xrej001  LIKE xrej_t.xrej001
    DEFINE l_glav006  LIKE glav_t.glav006
    DEFINE l_item_str STRING
    DEFINE l_i        LIKE type_t.num10
        
    WHENEVER ERROR CONTINUE
    LET l_glav006 = NULL
    SELECT MAX(glav006) INTO l_glav006 FROM glav_t,glaa_t
     WHERE glaaent = g_enterprise
       AND glaald  = p_ld
       AND glavent = glaaent
       AND glav001 = glaa003
       AND glav002 = p_xrej001
    IF cl_null(l_glav006)THEN LET l_glav006 = 0 END IF
    IF l_glav006 <= 0 THEN LET l_glav006 = 12 END IF
    
   LET l_item_str = NULL
   FOR l_i = 1 TO l_glav006
      IF cl_null(l_glav006)THEN
         LET l_item_str = l_i USING '<<<<'
      ELSE
         LET l_item_str = l_item_str CLIPPED,
                          ",",l_i USING '<<<<'
      END IF
   END FOR
   CALL s_fin_set_comp_scc('xrej001','43')   #年度
   CALL cl_set_combo_items('xrej002',l_item_str,l_item_str)
   


END FUNCTION

PUBLIC FUNCTION aapt940_01_get_xrad004(p_glcb003)
   DEFINE p_glcb003 LIKE glcb_t.glcb003
   DEFINE r_xrad004 LIKE xrad_t.xrad004
   WHENEVER ERROR CONTINUE
   
   LET r_xrad004 = NULL
   SELECT xrad004 INTO r_xrad004 FROM xrad_t
     WHERE xradent = g_enterprise
       AND xrad001 = p_glcb003
   RETURN r_xrad004
END FUNCTION

################################################################################
# Descriptions...: 帳齡類型檢核
# Memo...........:
# Date & Author..: 141031 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt940_01_glcb003_chk(p_glcb003)
   DEFINE p_glcb003   LIKE glcb_t.glcb003
   DEFINE l_stus      LIKE type_t.chr1
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_errno  = ''
   LET l_stus = NULL
   SELECT xradstus INTO l_stus FROM xrad_t
    WHERE xradent = g_enterprise
      AND xrad001 = p_glcb003    
   
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno = 'agl-00139'
         LET r_success = FALSE
      WHEN l_stus <> 'Y'
         LET r_success = FALSE
         
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 立即審核
# Memo...........:
# Usage..........: CALL aapt940_01_immediately_conf()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt940_01_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_xrejcomp        LIKE xrej_t.xrejcomp
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE  g_xrejcnfdt    LIKE xrej_t.xrejcnfdt
   #DEFINE  l_xrej       RECORD LIKE xrej_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xrej  RECORD  #壞帳提列主檔
          xrejent   LIKE xrej_t.xrejent, #企業編號
          xrejownid LIKE xrej_t.xrejownid, #資料所有者
          xrejowndp LIKE xrej_t.xrejowndp, #資料所屬部門
          xrejcrtid LIKE xrej_t.xrejcrtid, #資料建立者
          xrejcrtdp LIKE xrej_t.xrejcrtdp, #資料建立部門
          xrejcrtdt LIKE xrej_t.xrejcrtdt, #資料創建日
          xrejmodid LIKE xrej_t.xrejmodid, #資料修改者
          xrejmoddt LIKE xrej_t.xrejmoddt, #最近修改日
          xrejcnfid LIKE xrej_t.xrejcnfid, #資料確認者
          xrejcnfdt LIKE xrej_t.xrejcnfdt, #資料確認日
          xrejstus  LIKE xrej_t.xrejstus, #狀態碼
          xrejsite  LIKE xrej_t.xrejsite, #帳務中心
          xrejld    LIKE xrej_t.xrejld, #帳套
          xrejcomp  LIKE xrej_t.xrejcomp, #法人
          xrejdocno LIKE xrej_t.xrejdocno, #單號
          xrejdocdt LIKE xrej_t.xrejdocdt, #單據日期
          xrej001   LIKE xrej_t.xrej001, #年度
          xrej002   LIKE xrej_t.xrej002, #期別
          xrej003   LIKE xrej_t.xrej003, #來源模組
          xrej004   LIKE xrej_t.xrej004, #帳務人員
          xrej005   LIKE xrej_t.xrej005, #傳票號碼
          xrejud001 LIKE xrej_t.xrejud001, #自定義欄位(文字)001
          xrejud002 LIKE xrej_t.xrejud002, #自定義欄位(文字)002
          xrejud003 LIKE xrej_t.xrejud003, #自定義欄位(文字)003
          xrejud004 LIKE xrej_t.xrejud004, #自定義欄位(文字)004
          xrejud005 LIKE xrej_t.xrejud005, #自定義欄位(文字)005
          xrejud006 LIKE xrej_t.xrejud006, #自定義欄位(文字)006
          xrejud007 LIKE xrej_t.xrejud007, #自定義欄位(文字)007
          xrejud008 LIKE xrej_t.xrejud008, #自定義欄位(文字)008
          xrejud009 LIKE xrej_t.xrejud009, #自定義欄位(文字)009
          xrejud010 LIKE xrej_t.xrejud010, #自定義欄位(文字)010
          xrejud011 LIKE xrej_t.xrejud011, #自定義欄位(數字)011
          xrejud012 LIKE xrej_t.xrejud012, #自定義欄位(數字)012
          xrejud013 LIKE xrej_t.xrejud013, #自定義欄位(數字)013
          xrejud014 LIKE xrej_t.xrejud014, #自定義欄位(數字)014
          xrejud015 LIKE xrej_t.xrejud015, #自定義欄位(數字)015
          xrejud016 LIKE xrej_t.xrejud016, #自定義欄位(數字)016
          xrejud017 LIKE xrej_t.xrejud017, #自定義欄位(數字)017
          xrejud018 LIKE xrej_t.xrejud018, #自定義欄位(數字)018
          xrejud019 LIKE xrej_t.xrejud019, #自定義欄位(數字)019
          xrejud020 LIKE xrej_t.xrejud020, #自定義欄位(數字)020
          xrejud021 LIKE xrej_t.xrejud021, #自定義欄位(日期時間)021
          xrejud022 LIKE xrej_t.xrejud022, #自定義欄位(日期時間)022
          xrejud023 LIKE xrej_t.xrejud023, #自定義欄位(日期時間)023
          xrejud024 LIKE xrej_t.xrejud024, #自定義欄位(日期時間)024
          xrejud025 LIKE xrej_t.xrejud025, #自定義欄位(日期時間)025
          xrejud026 LIKE xrej_t.xrejud026, #自定義欄位(日期時間)026
          xrejud027 LIKE xrej_t.xrejud027, #自定義欄位(日期時間)027
          xrejud028 LIKE xrej_t.xrejud028, #自定義欄位(日期時間)028
          xrejud029 LIKE xrej_t.xrejud029, #自定義欄位(日期時間)029
          xrejud030 LIKE xrej_t.xrejud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   IF cl_null(g_xrej_m.xrejld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrej_m.xrejsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrej_m.xrejdocno) THEN RETURN END IF   #無資料直接返回不做處理
   #SELECT *  INTO  l_xrej.*  FROM xrej_t   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xrejent,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,
          xrejcrtdt,xrejmodid,xrejmoddt,xrejcnfid,xrejcnfdt,
          xrejstus,xrejsite,xrejld,xrejcomp,xrejdocno,
          xrejdocdt,xrej001,xrej002,xrej003,xrej004,
          xrej005,xrejud001,xrejud002,xrejud003,xrejud004,
          xrejud005,xrejud006,xrejud007,xrejud008,xrejud009,
          xrejud010,xrejud011,xrejud012,xrejud013,xrejud014,
          xrejud015,xrejud016,xrejud017,xrejud018,xrejud019,
          xrejud020,xrejud021,xrejud022,xrejud023,xrejud024,
          xrejud025,xrejud026,xrejud027,xrejud028,xrejud029,
          xrejud030  
     INTO l_xrej.xrejent,l_xrej.xrejownid,l_xrej.xrejowndp,l_xrej.xrejcrtid,l_xrej.xrejcrtdp,
          l_xrej.xrejcrtdt,l_xrej.xrejmodid,l_xrej.xrejmoddt,l_xrej.xrejcnfid,l_xrej.xrejcnfdt,
          l_xrej.xrejstus,l_xrej.xrejsite,l_xrej.xrejld,l_xrej.xrejcomp,l_xrej.xrejdocno,
          l_xrej.xrejdocdt,l_xrej.xrej001,l_xrej.xrej002,l_xrej.xrej003,l_xrej.xrej004,
          l_xrej.xrej005,l_xrej.xrejud001,l_xrej.xrejud002,l_xrej.xrejud003,l_xrej.xrejud004,
          l_xrej.xrejud005,l_xrej.xrejud006,l_xrej.xrejud007,l_xrej.xrejud008,l_xrej.xrejud009,
          l_xrej.xrejud010,l_xrej.xrejud011,l_xrej.xrejud012,l_xrej.xrejud013,l_xrej.xrejud014,
          l_xrej.xrejud015,l_xrej.xrejud016,l_xrej.xrejud017,l_xrej.xrejud018,l_xrej.xrejud019,
          l_xrej.xrejud020,l_xrej.xrejud021,l_xrej.xrejud022,l_xrej.xrejud023,l_xrej.xrejud024,
          l_xrej.xrejud025,l_xrej.xrejud026,l_xrej.xrejud027,l_xrej.xrejud028,l_xrej.xrejud029,
          l_xrej.xrejud030    
     FROM xrej_t
   #161208-00026#15   add---e
    #WHERE xrejld = g_xrej_m.xrejld AND xrejsite = g_xrej_m.xrejsite AND xrejdocno =  g_xrej_m.xrejdocno                           #160905-00002#4 mark
    WHERE xrejent = g_enterprise AND xrejld = g_xrej_m.xrejld AND xrejsite = g_xrej_m.xrejsite AND xrejdocno =  g_xrej_m.xrejdocno #160905-00002#4 add
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM xrek_t WHERE xrekent = g_enterprise
      AND xrekdocno = g_xrej_m.xrejdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   ##只能執行大於等於關帳年月之資料
   SELECT xrejcomp INTO l_xrejcomp FROM xrej_t WHERE xrejent = g_enterprise AND xrejdocno = g_xrej_m.xrejdocno AND xrej003 = 'AP' 
   CALL cl_get_para(g_enterprise,l_xrejcomp,'S-FIN-3007') RETURNING l_sfin3007 
   #IF g_xrej_m.xrejdocdt < l_sfin3007 THEN RETURN END IF
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_xrej_m.xrejdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_xrej_m.xrejld,l_xrej.xrejcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
   
   #確認
   CALL s_aapt940_prepare_declare()
      

   IF NOT s_aapt930_conf_chk(g_xrej_m.xrejdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_aapt930_conf_upd(g_xrej_m.xrejdocno) THEN
      LET l_doc_success = FALSE
   END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET g_xrejcnfdt = cl_get_current()
   UPDATE xrej_t SET xrejstus = 'Y',
                     xrejmodid= g_user,
                     xrejcnfid= g_user,
                     xrejcnfdt= g_xrejcnfdt
    WHERE xrejent = g_enterprise AND xrejld = g_xrej_m.xrejld
      AND xrejdocno = g_xrej_m.xrejdocno
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
# Descriptions...: 立即拋轉憑證
# Memo...........:
# Usage..........: CALL aapt940_01_immediately_gen()
#                  RETURNING ---
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt940_01_immediately_gen()
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
   DEFINE l_docno           LIKE xrej_t.xrejdocno
   DEFINE l_start_no        LIKE glap_t.glapdocno
   DEFINE g_glaa102         LIKE glaa_t.glaa102
   DEFINE g_ap_slip         LIKE apca_t.apcadocno
   #DEFINE l_xrej            RECORD LIKE xrej_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xrej  RECORD  #壞帳提列主檔
          xrejent   LIKE xrej_t.xrejent, #企業編號
          xrejownid LIKE xrej_t.xrejownid, #資料所有者
          xrejowndp LIKE xrej_t.xrejowndp, #資料所屬部門
          xrejcrtid LIKE xrej_t.xrejcrtid, #資料建立者
          xrejcrtdp LIKE xrej_t.xrejcrtdp, #資料建立部門
          xrejcrtdt LIKE xrej_t.xrejcrtdt, #資料創建日
          xrejmodid LIKE xrej_t.xrejmodid, #資料修改者
          xrejmoddt LIKE xrej_t.xrejmoddt, #最近修改日
          xrejcnfid LIKE xrej_t.xrejcnfid, #資料確認者
          xrejcnfdt LIKE xrej_t.xrejcnfdt, #資料確認日
          xrejstus  LIKE xrej_t.xrejstus, #狀態碼
          xrejsite  LIKE xrej_t.xrejsite, #帳務中心
          xrejld    LIKE xrej_t.xrejld, #帳套
          xrejcomp  LIKE xrej_t.xrejcomp, #法人
          xrejdocno LIKE xrej_t.xrejdocno, #單號
          xrejdocdt LIKE xrej_t.xrejdocdt, #單據日期
          xrej001   LIKE xrej_t.xrej001, #年度
          xrej002   LIKE xrej_t.xrej002, #期別
          xrej003   LIKE xrej_t.xrej003, #來源模組
          xrej004   LIKE xrej_t.xrej004, #帳務人員
          xrej005   LIKE xrej_t.xrej005, #傳票號碼
          xrejud001 LIKE xrej_t.xrejud001, #自定義欄位(文字)001
          xrejud002 LIKE xrej_t.xrejud002, #自定義欄位(文字)002
          xrejud003 LIKE xrej_t.xrejud003, #自定義欄位(文字)003
          xrejud004 LIKE xrej_t.xrejud004, #自定義欄位(文字)004
          xrejud005 LIKE xrej_t.xrejud005, #自定義欄位(文字)005
          xrejud006 LIKE xrej_t.xrejud006, #自定義欄位(文字)006
          xrejud007 LIKE xrej_t.xrejud007, #自定義欄位(文字)007
          xrejud008 LIKE xrej_t.xrejud008, #自定義欄位(文字)008
          xrejud009 LIKE xrej_t.xrejud009, #自定義欄位(文字)009
          xrejud010 LIKE xrej_t.xrejud010, #自定義欄位(文字)010
          xrejud011 LIKE xrej_t.xrejud011, #自定義欄位(數字)011
          xrejud012 LIKE xrej_t.xrejud012, #自定義欄位(數字)012
          xrejud013 LIKE xrej_t.xrejud013, #自定義欄位(數字)013
          xrejud014 LIKE xrej_t.xrejud014, #自定義欄位(數字)014
          xrejud015 LIKE xrej_t.xrejud015, #自定義欄位(數字)015
          xrejud016 LIKE xrej_t.xrejud016, #自定義欄位(數字)016
          xrejud017 LIKE xrej_t.xrejud017, #自定義欄位(數字)017
          xrejud018 LIKE xrej_t.xrejud018, #自定義欄位(數字)018
          xrejud019 LIKE xrej_t.xrejud019, #自定義欄位(數字)019
          xrejud020 LIKE xrej_t.xrejud020, #自定義欄位(數字)020
          xrejud021 LIKE xrej_t.xrejud021, #自定義欄位(日期時間)021
          xrejud022 LIKE xrej_t.xrejud022, #自定義欄位(日期時間)022
          xrejud023 LIKE xrej_t.xrejud023, #自定義欄位(日期時間)023
          xrejud024 LIKE xrej_t.xrejud024, #自定義欄位(日期時間)024
          xrejud025 LIKE xrej_t.xrejud025, #自定義欄位(日期時間)025
          xrejud026 LIKE xrej_t.xrejud026, #自定義欄位(日期時間)026
          xrejud027 LIKE xrej_t.xrejud027, #自定義欄位(日期時間)027
          xrejud028 LIKE xrej_t.xrejud028, #自定義欄位(日期時間)028
          xrejud029 LIKE xrej_t.xrejud029, #自定義欄位(日期時間)029
          xrejud030 LIKE xrej_t.xrejud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   IF cl_null(g_xrej_m.xrejld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrej_m.xrejsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrej_m.xrejdocno) THEN RETURN END IF   #無資料直接返回不做處理
   #SELECT *  INTO  l_xrej.*  FROM xrej_t   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xrejent,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,
          xrejcrtdt,xrejmodid,xrejmoddt,xrejcnfid,xrejcnfdt,
          xrejstus,xrejsite,xrejld,xrejcomp,xrejdocno,
          xrejdocdt,xrej001,xrej002,xrej003,xrej004,
          xrej005,xrejud001,xrejud002,xrejud003,xrejud004,
          xrejud005,xrejud006,xrejud007,xrejud008,xrejud009,
          xrejud010,xrejud011,xrejud012,xrejud013,xrejud014,
          xrejud015,xrejud016,xrejud017,xrejud018,xrejud019,
          xrejud020,xrejud021,xrejud022,xrejud023,xrejud024,
          xrejud025,xrejud026,xrejud027,xrejud028,xrejud029,
          xrejud030  
     INTO l_xrej.xrejent,l_xrej.xrejownid,l_xrej.xrejowndp,l_xrej.xrejcrtid,l_xrej.xrejcrtdp,
          l_xrej.xrejcrtdt,l_xrej.xrejmodid,l_xrej.xrejmoddt,l_xrej.xrejcnfid,l_xrej.xrejcnfdt,
          l_xrej.xrejstus,l_xrej.xrejsite,l_xrej.xrejld,l_xrej.xrejcomp,l_xrej.xrejdocno,
          l_xrej.xrejdocdt,l_xrej.xrej001,l_xrej.xrej002,l_xrej.xrej003,l_xrej.xrej004,
          l_xrej.xrej005,l_xrej.xrejud001,l_xrej.xrejud002,l_xrej.xrejud003,l_xrej.xrejud004,
          l_xrej.xrejud005,l_xrej.xrejud006,l_xrej.xrejud007,l_xrej.xrejud008,l_xrej.xrejud009,
          l_xrej.xrejud010,l_xrej.xrejud011,l_xrej.xrejud012,l_xrej.xrejud013,l_xrej.xrejud014,
          l_xrej.xrejud015,l_xrej.xrejud016,l_xrej.xrejud017,l_xrej.xrejud018,l_xrej.xrejud019,
          l_xrej.xrejud020,l_xrej.xrejud021,l_xrej.xrejud022,l_xrej.xrejud023,l_xrej.xrejud024,
          l_xrej.xrejud025,l_xrej.xrejud026,l_xrej.xrejud027,l_xrej.xrejud028,l_xrej.xrejud029,
          l_xrej.xrejud030    
     FROM xrej_t
   #161208-00026#15   add---e
    #WHERE xrejld = g_xrej_m.xrejld AND xrejsite = g_xrej_m.xrejsite AND xrejdocno =  g_xrej_m.xrejdocno                             #160905-00002#4 mark
    WHERE xrejent = g_enterprise AND xrejld = g_xrej_m.xrejld AND xrejsite = g_xrej_m.xrejsite AND xrejdocno =  g_xrej_m.xrejdocno   #160905-00002#4 add
   IF  l_xrej.xrejstus != 'Y' OR cl_null(l_xrej.xrejstus)  THEN
      RETURN
    END IF
   IF NOT cl_null(l_xrej.xrej005)  THEN RETURN END IF #传票号码已经存在返回不做处理
   #傳票成立時,借貸不平衡的處理方式
   CALL s_ld_sel_glaa(g_xrej_m.xrejld,'glaacomp|glaa102')
        RETURNING g_sub_success,l_glaacomp,g_glaa102
   #取所屬法人關帳日
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
   
   
   # D-FIN-0030 产生分录传票否
   CALL s_aooi200_fin_get_slip(g_xrej_m.xrejdocno) RETURNING g_sub_success,g_ap_slip
   CALL s_fin_get_doc_para(g_xrej_m.xrejld,l_xrej.xrejcomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
   IF l_chr <> 'Y' OR  cl_null(l_chr) THEN RETURN END IF 
    
   #取得單別
   CALL s_aooi200_fin_get_slip(g_xrej_m.xrejdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(g_xrej_m.xrejld,l_xrej.xrejcomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032
    
   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      RETURN 
   END IF 
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(g_xrej_m.xrejld,l_xrej.xrejcomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
   
   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
   IF cl_null(l_gl_slip) THEN
      #產生單別/日期
      CALL aapp330_01(g_xrej_m.xrejld,g_xrej_m.xrejdocdt,'P60',g_xrej_m.xrejdocno) RETURNING l_gl_slip,l_date  #161213-00023#2 add g_xrej_m.xrejdocno
      #必須大於帳套關帳日期才可拋轉
      IF l_date < l_sfin3007 THEN 
         RETURN
      END IF
   ELSE 
      LET l_date = g_xrej_m.xrejdocdt
   END IF 
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
   CALL s_fin_continue_no_tmp()               
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   CALL s_transaction_begin()
   
   DELETE FROM s_voucher_tmp
   
   INSERT INTO s_voucher_tmp (docno,type)
          VALUES (g_xrej_m.xrejdocno, '0' )
   SELECT docno INTO l_docno FROM s_voucher_tmp WHERE type = 0
   
   SELECT count(*) INTO l_count
     FROM s_voucher_tmp
   IF l_count > 0 THEN
      
      CALL s_aapp330_gen_ac('1','P60',g_xrej_m.xrejld,'','','1','!#@',l_xrej.xrejstus) RETURNING g_sub_success,l_start_no,l_start_no                     
     
      
      IF g_sub_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')
      END IF
   
      #傳票拋轉
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      
      CALL s_aapp330_generate_voucher('P60',l_gl_slip,l_date,g_xrej_m.xrejld,'1','Y',g_glaa102,'AP')
              RETURNING g_sub_success,l_xrej.xrej005,l_xrej.xrej005
      
      
      #成功則更新aapt920的傳票號碼
      IF g_sub_success THEN
         UPDATE xrej_t SET xrej005 = l_xrej.xrej005
          WHERE xrejent = g_enterprise
            AND xrejdocno = g_xrej_m.xrejdocno
            AND xrej003 ='AP'
        
         UPDATE glga_t SET glga007 =  l_xrej.xrej005
          WHERE glgaent = g_enterprise AND glgald = g_xrej_m.xrejld 
            AND glgadocno=g_xrej_m.xrejdocno AND glga100 = 'AP' AND glga101 = 'P60'
        
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
 
