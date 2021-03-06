#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt821_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-01-08 16:45:12), PR版次:0003(2016-11-30 16:31:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: anmt821_04
#+ Description: 批次產生
#+ Creator....: 02291(2015-01-08 16:33:37)
#+ Modifier...: 02291 -SD/PR- 02481
 
{</section>}
 
{<section id="anmt821_04.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#29 2016/03/25 By 07900    重复错误信息修改
#161128-00061#2  2016/11/30 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_xreg_m        RECORD
       xregsite LIKE xreg_t.xregsite, 
   xregsite_desc LIKE type_t.chr80, 
   xregld LIKE xreg_t.xregld, 
   xregld_desc LIKE type_t.chr80, 
   xreg004 LIKE xreg_t.xreg004, 
   xreg004_desc LIKE type_t.chr80, 
   xregdocno LIKE xreg_t.xregdocno, 
   xreg001 LIKE xreg_t.xreg001, 
   xreg002 LIKE type_t.chr500, 
   xregdocdt LIKE xreg_t.xregdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa003    LIKE glaa_t.glaa003
DEFINE g_glaa004    LIKE glaa_t.glaa004
DEFINE g_glaa015    LIKE glaa_t.glaa015
DEFINE g_glaa016    LIKE glaa_t.glaa016
DEFINE g_glaa019    LIKE glaa_t.glaa019
DEFINE g_glaa020    LIKE glaa_t.glaa020
DEFINE g_glaa024    LIKE glaa_t.glaa024  
DEFINE g_prog_name  LIKE type_t.chr20 
DEFINE g_bookno     LIKE glaa_t.glaald
DEFINE g_wc         STRING  #chenying add
#end add-point
 
DEFINE g_xreg_m        type_g_xreg_m
 
   DEFINE g_xregdocno_t LIKE xreg_t.xregdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmt821_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmt821_04(--)
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
   DEFINE l_ooag003       LIKE ooag_t.ooag003
   DEFINE l_date          DATE
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_xrcacomp      LIKE xrca_t.xrcacomp
   DEFINE ls_wc           STRING
   DEFINE l_xregdocno     LIKE xreg_t.xregdocno  #chenying
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmt821_04 WITH FORM cl_ap_formpath("anm","anmt821_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004,g_xreg_m.xregdocno,g_xreg_m.xreg001, 
          g_xreg_m.xreg002,g_xreg_m.xregdocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #chenying add 1126
            #资料清空
            INITIALIZE g_xreg_m.* TO NULL
            #chenying add 1126
            
            LET g_prog_name = 'anmt821'
            CALL s_fin_set_comp_scc('xreg001','43')            
            #帐务人员
            LET g_xreg_m.xreg004 = g_user
            CALL anmt821_04_xreg004_desc()
            
            #帳務中心
            #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
            CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_xreg_m.xregsite,g_errno
            CALL anmt821_04_xregsite_desc() 
            
#            #g_bookno,先做帳務中心及g_bookno的勾稽,登入人員帳務人員時,基本上會有該g_bookno的帳務中心權限
#            IF NOT cl_null(g_bookno) THEN
#               #帳務中心與帳別勾稽
#               CALL s_fin_account_center_with_ld_chk(g_xreg_m.xregsite,g_bookno,g_user,'3','N','',g_xreg_m.xregdocdt) RETURNING l_success,g_errno
#            END IF
            #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
#            IF NOT l_success OR cl_null(g_bookno) THEN
               CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_xreg_m.xregld,l_xrcacomp,g_errno
               CALL s_fin_account_center_with_ld_chk(g_xreg_m.xregsite,g_xreg_m.xregld,g_user,'3','N','',g_today) RETURNING l_success,g_errno
#            ELSE
#               LET g_xreg_m.xregld = g_bookno
#            END IF
            #若取不出資料,則不預設帳別
            IF NOT l_success THEN
               LET g_xreg_m.xregld = ''
               LET l_xrcacomp = ''
            END IF
            
            IF cl_null(g_xreg_m.xregld) THEN 
               CALL s_fin_orga_get_comp_ld(g_xreg_m.xregsite) RETURNING l_success,g_errno,l_xrcacomp,g_xreg_m.xregld
               CALL s_fin_account_center_with_ld_chk(g_xreg_m.xregsite,g_xreg_m.xregld,g_user,'3','N','',g_today) RETURNING l_success,g_errno
            END IF
            #若取不出資料，則預設帳別/法人為空
            IF NOT l_success THEN
               LET g_xreg_m.xregld = ''
               LET l_xrcacomp = ''
            END IF    
            
            CALL anmt821_04_xregld_desc()     
           
            CALL anmt821_04_get_glaa()

            #关账日期之年度期別
            CALL cl_get_para(g_enterprise,l_xrcacomp,'S-FIN-2007') RETURNING l_date
            LET g_xreg_m.xreg001 = YEAR(l_date) 
            LET g_xreg_m.xreg002 = MONTH(l_date) 
            CALL anmt821_04_get_lastday() RETURNING g_xreg_m.xregdocdt    
            
            #site
            CALL s_fin_get_account_center('',g_user,'3',g_xreg_m.xregdocdt) RETURNING g_sub_success,g_xreg_m.xregsite,g_errno
            CALL anmt821_04_xregsite_desc()
            
            DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg004,
                            g_xreg_m.xregsite_desc,g_xreg_m.xregld_desc,g_xreg_m.xreg004_desc
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregsite
            
            #add-point:AFTER FIELD xregsite name="input.a.xregsite"
            LET g_xreg_m.xregsite_desc = ' '
            DISPLAY BY NAME g_xreg_m.xregsite_desc
            IF NOT cl_null(g_xreg_m.xregsite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_xreg_m.xregsite,g_xreg_m.xregld,g_user,'3','N','',g_xreg_m.xregdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xreg_m.xregsite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET  g_xreg_m.xregsite = ''
                     CALL anmt821_04_xregsite_desc()
                     NEXT FIELD CURRENT
                  END IF

            END IF
            CALL anmt821_04_xregsite_desc()
            DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.xregsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregsite
            #add-point:BEFORE FIELD xregsite name="input.b.xregsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregsite
            #add-point:ON CHANGE xregsite name="input.g.xregsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregld
            
            #add-point:AFTER FIELD xregld name="input.a.xregld"
            IF NOT cl_null(g_xreg_m.xregld) AND NOT cl_null(g_xreg_m.xregdocno) THEN 
                
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xreg_t WHERE "||"xregent = '" ||g_enterprise|| "' AND "||"xregld = '"||g_xreg_m.xregld ||"' AND "|| "xregdocno = '"||g_xreg_m.xregdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
 
            END IF
            
            IF NOT cl_null(g_xreg_m.xregld) THEN
               #檢查是否存在 帳別資料檔 中
               IF NOT ap_chk_isExist(g_xreg_m.xregld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN
                  LET g_xreg_m.xregld = ''
                  CALL anmt821_04_xregld_desc()                 
                  NEXT FIELD CURRENT
               END IF   
               
               #檢查是否 有效
               IF NOT ap_chk_isExist(g_xreg_m.xregld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y'",'sub-01302','agli010') THEN  #agl-00051 #160318-00005#29 by 07900 --mod
                  LET g_xreg_m.xregld = ''
                  CALL anmt821_04_xregld_desc()                  
                  NEXT FIELD CURRENT
               END IF     
            END IF             
            
            IF NOT cl_null(g_xreg_m.xregld) THEN 
               CALL anmt821_04_get_glaa()
            END IF 
            
            CALL anmt821_04_xregld_desc()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregld
            #add-point:BEFORE FIELD xregld name="input.b.xregld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregld
            #add-point:ON CHANGE xregld name="input.g.xregld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg004
            
            #add-point:AFTER FIELD xreg004 name="input.a.xreg004"
            LET g_xreg_m.xreg004_desc = ' '
            DISPLAY BY NAME g_xreg_m.xreg004_desc
            IF NOT cl_null(g_xreg_m.xreg004) THEN
              
                  #資料存在性、有效性檢查
                  CALL s_employee_chk(g_xreg_m.xreg004) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_xreg_m.xreg004 = ''
                     CALL anmt821_04_xreg004_desc()
                     DISPLAY BY NAME g_xreg_m.xreg004_desc
                     NEXT FIELD CURRENT
                  END IF

            END IF

            IF cl_null(g_xreg_m.xreg004) AND cl_null(g_xreg_m.xregld) THEN
               LET g_xreg_m.xreg004 = g_user
            END IF   
            
            CALL anmt821_04_xreg004_desc()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg004
            #add-point:BEFORE FIELD xreg004 name="input.b.xreg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg004
            #add-point:ON CHANGE xreg004 name="input.g.xreg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocno
            #add-point:BEFORE FIELD xregdocno name="input.b.xregdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocno
            
            #add-point:AFTER FIELD xregdocno name="input.a.xregdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_xreg_m.xregld) AND NOT cl_null(g_xreg_m.xregdocno) THEN 
               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xreg_t WHERE "||"xregent = '" ||g_enterprise|| "' AND "||"xregld = '"||g_xreg_m.xregld ||"' AND "|| "xregdocno = '"||g_xreg_m.xregdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF

            END IF
            
            IF NOT cl_null(g_xreg_m.xregdocno) THEN
               IF NOT s_aooi200_fin_chk_slip(g_xreg_m.xregld,g_glaa024,g_xreg_m.xregdocno,g_prog_name) THEN
                  LET g_xreg_m.xregdocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregdocno
            #add-point:ON CHANGE xregdocno name="input.g.xregdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg001
            #add-point:BEFORE FIELD xreg001 name="input.b.xreg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg001
            
            #add-point:AFTER FIELD xreg001 name="input.a.xreg001"
            IF NOT cl_null(g_xreg_m.xreg001) AND NOT cl_null(g_xreg_m.xreg002) THEN 
               IF NOT cl_null(g_xreg_m.xregdocdt) THEN 
                  #IF g_xreg_m.xreg001 <> YEAR(g_xreg_m.xregdocdt) OR g_xreg_m.xreg002 <> MONTH(g_xreg_m.xregdocdt) THEN
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "" 
                  #   LET g_errparam.code   = "axr-00228"
                  #   LET g_errparam.popup  = FALSE 
                  #   CALL cl_err()  
                  #   NEXT FIELD xregdocdt
                  #END IF
               ELSE
                  CALL anmt821_04_get_lastday() RETURNING g_xreg_m.xregdocdt 
                  DISPLAY BY NAME g_xreg_m.xregdocdt                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg001
            #add-point:ON CHANGE xreg001 name="input.g.xreg001"
            IF NOT cl_null(g_xreg_m.xreg001) AND NOT cl_null(g_xreg_m.xreg002) THEN 
               IF NOT cl_null(g_xreg_m.xregdocdt) THEN 
                  #IF g_xreg_m.xreg001 <> YEAR(g_xreg_m.xregdocdt) OR g_xreg_m.xreg002 <> MONTH(g_xreg_m.xregdocdt) THEN
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "" 
                  #   LET g_errparam.code   = "axr-00228"
                  #   LET g_errparam.popup  = FALSE 
                  #   CALL cl_err()  
                  #   NEXT FIELD xregdocdt
                  #END IF
               ELSE
                  CALL anmt821_04_get_lastday() RETURNING g_xreg_m.xregdocdt 
                  DISPLAY BY NAME g_xreg_m.xregdocdt                  
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg002
            #add-point:BEFORE FIELD xreg002 name="input.b.xreg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg002
            
            #add-point:AFTER FIELD xreg002 name="input.a.xreg002"
            IF NOT cl_null(g_xreg_m.xreg001) AND NOT cl_null(g_xreg_m.xreg002) THEN 
               IF NOT cl_null(g_xreg_m.xregdocdt) THEN 
                  #IF g_xreg_m.xreg001 <> YEAR(g_xreg_m.xregdocdt) OR g_xreg_m.xreg002 <> MONTH(g_xreg_m.xregdocdt) THEN
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "" 
                  #   LET g_errparam.code   = "axr-00228"
                  #   LET g_errparam.popup  = FALSE 
                  #   CALL cl_err()  
                  #   NEXT FIELD xregdocdt
                  #END IF
               ELSE
                  CALL anmt821_04_get_lastday() RETURNING g_xreg_m.xregdocdt 
                  DISPLAY BY NAME g_xreg_m.xregdocdt                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg002
            #add-point:ON CHANGE xreg002 name="input.g.xreg002"
            IF NOT cl_null(g_xreg_m.xreg001) AND NOT cl_null(g_xreg_m.xreg002) THEN 
               IF NOT cl_null(g_xreg_m.xregdocdt) THEN 
                 #IF g_xreg_m.xreg001 <> YEAR(g_xreg_m.xregdocdt) OR g_xreg_m.xreg002 <> MONTH(g_xreg_m.xregdocdt) THEN
                 #   INITIALIZE g_errparam TO NULL 
                 #   LET g_errparam.extend = "" 
                 #   LET g_errparam.code   = "axr-00228"
                 #   LET g_errparam.popup  = FALSE 
                 #   CALL cl_err()  
                 #   NEXT FIELD xregdocdt
                 #END IF
               ELSE
                  CALL anmt821_04_get_lastday() RETURNING g_xreg_m.xregdocdt 
                  DISPLAY BY NAME g_xreg_m.xregdocdt                  
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocdt
            #add-point:BEFORE FIELD xregdocdt name="input.b.xregdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocdt
            
            #add-point:AFTER FIELD xregdocdt name="input.a.xregdocdt"
            IF NOT cl_null(g_xreg_m.xregdocdt) THEN 
               #IF g_xreg_m.xreg001 <> YEAR(g_xreg_m.xregdocdt) OR g_xreg_m.xreg002 <> MONTH(g_xreg_m.xregdocdt) THEN
               #   INITIALIZE g_errparam TO NULL 
               #   LET g_errparam.extend = "" 
               #   LET g_errparam.code   = "axr-00228"
               #   LET g_errparam.popup  = FALSE 
               #   CALL cl_err()  
               #   NEXT FIELD xregdocdt
               #END IF            
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregdocdt
            #add-point:ON CHANGE xregdocdt name="input.g.xregdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xregsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregsite
            #add-point:ON ACTION controlp INFIELD xregsite name="input.c.xregsite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xreg_m.xregsite             #給予default值
            LET g_qryparam.default2 = "" #g_xreg_m.ooefl003 #說明(簡稱)
            LET g_qryparam.where = " ooef201 = 'Y' "
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_xreg_m.xregsite = g_qryparam.return1              
            #LET g_xreg_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xreg_m.xregsite TO xregsite           #
            CALL anmt821_04_xregsite_desc()
            #DISPLAY g_xreg_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xregsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xregld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregld
            #add-point:ON ACTION controlp INFIELD xregld name="input.c.xregld"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_fin_create_account_center_tmp()   
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xreg_m.xregsite,g_today,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xreg_m.xregld             #給予default值
            

            #給予arg
            SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooagent = g_enterprise
               AND ooag001 = g_xreg_m.xreg004
            LET g_qryparam.arg1 = g_xreg_m.xreg004
            LET g_qryparam.arg2 = l_ooag003
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xreg_m.xregld = g_qryparam.return1              
          
            DISPLAY g_xreg_m.xregld TO xregld              #
            CALL anmt821_04_xregld_desc()
            NEXT FIELD xregld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xreg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg004
            #add-point:ON ACTION controlp INFIELD xreg004 name="input.c.xreg004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xreg_m.xreg004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_xreg_m.xreg004 = g_qryparam.return1              

            DISPLAY g_xreg_m.xreg004 TO xreg004              #
            CALL anmt821_04_xreg004_desc()
            NEXT FIELD xreg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xregdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocno
            #add-point:ON ACTION controlp INFIELD xregdocno name="input.c.xregdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xreg_m.xregdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024 #s
            LET g_qryparam.arg2 = g_prog_name #s
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_xreg_m.xregdocno = g_qryparam.return1              

            DISPLAY g_xreg_m.xregdocno TO xregdocno              #

            NEXT FIELD xregdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xreg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg001
            #add-point:ON ACTION controlp INFIELD xreg001 name="input.c.xreg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg002
            #add-point:ON ACTION controlp INFIELD xreg002 name="input.c.xreg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xregdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocdt
            #add-point:ON ACTION controlp INFIELD xregdocdt name="input.c.xregdocdt"
            
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
   CLOSE WINDOW w_anmt821_04 
   
   #add-point:input段after input name="input.post_input"
   CALL s_transaction_begin()
   IF INT_FLAG THEN
      LET l_success = FALSE
   ELSE
      CALL anmt821_04_check() RETURNING l_success
      IF l_success = TRUE THEN  
         CALL anmt821_04_ins() RETURNING l_success
      END IF
   END IF
   LET INT_FLAG = FALSE 
   IF l_success = TRUE THEN
      CALL s_transaction_end('Y','0')
      #chenying add
      LET g_wc = NULL
      LET l_xregdocno = NULL
      LET g_wc = " xregdocno = '",g_xreg_m.xregdocno,"'"
      LET l_xregdocno = g_xreg_m.xregdocno
      RETURN g_wc,l_xregdocno
      #chenying add
   ELSE
      CALL s_transaction_end('N','0')
      #chenying add
      LET g_wc = NULL
      LET l_xregdocno = NULL
      RETURN g_wc,l_xregdocno
      #chenying add
   END IF   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt821_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmt821_04.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳務中心說明 
# Memo...........:
# Usage..........: CALL anmt821_04_xregsite_desc()
# Input parameter:  
# Date & Author..: 2014/10/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_xregsite_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xreg_m.xregsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xreg_m.xregsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xreg_m.xregsite_desc
END FUNCTION

################################################################################
# Descriptions...: 帳套說明
# Memo...........:
# Usage..........: CALL anmt821_04_xregld_desc()
# Input parameter:  
# Date & Author..: 2014/10/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_xregld_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xreg_m.xregld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xreg_m.xregld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xreg_m.xregld_desc            
END FUNCTION

################################################################################
# Descriptions...: 帳務人員說明
# Memo...........:
# Usage..........: CALL anmt821_04_xreg004_desc()
# Input parameter: 
# Date & Author..: 2014/10/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_xreg004_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xreg_m.xreg004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xreg_m.xreg004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xreg_m.xreg004_desc            
END FUNCTION

################################################################################
# Descriptions...: 年度／期別的最後一天
# Memo...........:
# Usage..........: CALL anmt821_04_get_lastday()
# Input parameter: 
# Date & Author..: 2014/10/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_get_lastday()
DEFINE l_errno          LIKE type_t.chr100
DEFINE l_glav002        LIKE glav_t.glav002
DEFINE l_glav005        LIKE glav_t.glav005
DEFINE l_sdate_s        LIKE glav_t.glav004
DEFINE l_sdate_e        LIKE glav_t.glav004
DEFINE l_glav006        LIKE glav_t.glav006
DEFINE l_pdate_s        LIKE glav_t.glav004
DEFINE l_pdate_e        LIKE glav_t.glav004
DEFINE l_glav007        LIKE glav_t.glav007
DEFINE l_wdate_s        LIKE glav_t.glav004
DEFINE l_wdate_e        LIKE glav_t.glav004
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_glaa003        LIKE glaa_t.glaa003

        
   SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xreg_m.xregld
   CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   RETURN l_pdate_e
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt821_04_get_glaa()
# Input parameter:  
# Date & Author..: 2014/10/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_get_glaa()
   #會計週期參照表、會計科目參照表、單據別參照表
   SELECT glaa003,glaa004,glaa015,glaa016,glaa019,glaa020,glaa024 
     INTO g_glaa003,g_glaa004,g_glaa015,g_glaa016,g_glaa019,g_glaa020,g_glaa024 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xreg_m.xregld  
END FUNCTION

################################################################################
# Descriptions...: ins xreg_t,xreh_t
# Memo...........:
# Usage..........: CALL anmt821_04_ins()
# Input parameter:  
# Date & Author..: 2014/10/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_ins()
DEFINE l_success       LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5
#161128-00061#2---modify----begin----------
#DEFINE l_xreg          RECORD LIKE xreg_t.*
#DEFINE l_xreh          RECORD LIKE xreh_t.*
#DEFINE l_xreb          RECORD LIKE xreb_t.*
 DEFINE l_xreg RECORD  #重評價帳務主檔
       xregent LIKE xreg_t.xregent, #企業編號
       xregcomp LIKE xreg_t.xregcomp, #法人
       xregsite LIKE xreg_t.xregsite, #帳務中心
       xregdocno LIKE xreg_t.xregdocno, #單據號碼
       xregdocdt LIKE xreg_t.xregdocdt, #單據日期
       xregld LIKE xreg_t.xregld, #帳套
       xreg001 LIKE xreg_t.xreg001, #年度
       xreg002 LIKE xreg_t.xreg002, #期別
       xreg003 LIKE xreg_t.xreg003, #來源模組
       xreg004 LIKE xreg_t.xreg004, #帳務人員
       xreg005 LIKE xreg_t.xreg005, #傳票號碼
       xregstus LIKE xreg_t.xregstus, #狀態碼
       xregownid LIKE xreg_t.xregownid, #資料所有者
       xregowndp LIKE xreg_t.xregowndp, #資料所屬部門
       xregcrtid LIKE xreg_t.xregcrtid, #資料建立者
       xregcrtdp LIKE xreg_t.xregcrtdp, #資料建立部門
       xregcrtdt LIKE xreg_t.xregcrtdt, #資料創建日
       xregmodid LIKE xreg_t.xregmodid, #資料修改者
       xregmoddt LIKE xreg_t.xregmoddt, #最近修改日
       xregcnfid LIKE xreg_t.xregcnfid, #資料確認者
       xregcnfdt LIKE xreg_t.xregcnfdt  #資料確認日
       END RECORD
DEFINE l_xreh RECORD  #重評價帳務明細檔
       xrehent LIKE xreh_t.xrehent, #企業編號
       xrehdocno LIKE xreh_t.xrehdocno, #單據號碼
       xrehld LIKE xreh_t.xrehld, #帳套
       xrehseq LIKE xreh_t.xrehseq, #項次
       xreh001 LIKE xreh_t.xreh001, #年度
       xreh002 LIKE xreh_t.xreh002, #期別
       xreh003 LIKE xreh_t.xreh003, #來源模組
       xreh004 LIKE xreh_t.xreh004, #帳款單性質
       xreh005 LIKE xreh_t.xreh005, #單據號碼
       xreh006 LIKE xreh_t.xreh006, #項次
       xreh007 LIKE xreh_t.xreh007, #分期帳款序
       xreh008 LIKE xreh_t.xreh008, #立帳日期
       xreh009 LIKE xreh_t.xreh009, #帳款對象
       xreh010 LIKE xreh_t.xreh010, #收款對象
       xreh011 LIKE xreh_t.xreh011, #部門
       xreh012 LIKE xreh_t.xreh012, #責任中心
       xreh013 LIKE xreh_t.xreh013, #區域
       xreh014 LIKE xreh_t.xreh014, #客群
       xreh015 LIKE xreh_t.xreh015, #產品類別
       xreh016 LIKE xreh_t.xreh016, #人員
       xreh017 LIKE xreh_t.xreh017, #專案編號
       xreh018 LIKE xreh_t.xreh018, #WBS編號
       xreh019 LIKE xreh_t.xreh019, #應收科目
       xrehorga LIKE xreh_t.xrehorga, #來源組織
       xreh020 LIKE xreh_t.xreh020, #經營方式
       xreh021 LIKE xreh_t.xreh021, #渠道
       xreh022 LIKE xreh_t.xreh022, #品牌
       xreh023 LIKE xreh_t.xreh023, #自由核算項一
       xreh024 LIKE xreh_t.xreh024, #自由核算項二
       xreh025 LIKE xreh_t.xreh025, #自由核算項三
       xreh026 LIKE xreh_t.xreh026, #自由核算項四
       xreh027 LIKE xreh_t.xreh027, #自由核算項五
       xreh028 LIKE xreh_t.xreh028, #自由核算項六
       xreh029 LIKE xreh_t.xreh029, #自由核算項七
       xreh030 LIKE xreh_t.xreh030, #自由核算項八
       xreh031 LIKE xreh_t.xreh031, #自由核算項九
       xreh032 LIKE xreh_t.xreh032, #自由核算項十
       xreh033 LIKE xreh_t.xreh033, #摘要
       xreh034 LIKE xreh_t.xreh034, #重評價會科
       xreh100 LIKE xreh_t.xreh100, #幣別
       xreh101 LIKE xreh_t.xreh101, #重評價匯率
       xreh102 LIKE xreh_t.xreh102, #上月重評匯率
       xreh103 LIKE xreh_t.xreh103, #本期原幣未衝金額
       xreh113 LIKE xreh_t.xreh113, #本期本幣未衝金額
       xreh114 LIKE xreh_t.xreh114, #本期重評價後本幣金額
       xreh115 LIKE xreh_t.xreh115, #本期匯差金額
       xreh116 LIKE xreh_t.xreh116, #本幣累計匯差
       xreh121 LIKE xreh_t.xreh121, #本位幣二重評價匯率
       xreh122 LIKE xreh_t.xreh122, #本位幣二上月重估匯率
       xreh123 LIKE xreh_t.xreh123, #本期本位幣二未衝金額
       xreh124 LIKE xreh_t.xreh124, #本期本位幣二重評價後金額
       xreh125 LIKE xreh_t.xreh125, #本期本位幣二匯差金額
       xreh126 LIKE xreh_t.xreh126, #本位幣二累計匯差
       xreh131 LIKE xreh_t.xreh131, #本位幣三重評價匯率
       xreh132 LIKE xreh_t.xreh132, #本位幣三上月重估匯率
       xreh133 LIKE xreh_t.xreh133, #本期本位幣三未衝金額
       xreh134 LIKE xreh_t.xreh134, #本期本位幣三重評價後金額
       xreh135 LIKE xreh_t.xreh135, #本期本位幣三匯差金額
       xreh136 LIKE xreh_t.xreh136  #本位幣三累計匯差
       END RECORD
DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #渠道
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136  #本位幣三累計匯差
       END RECORD

#161128-00061#2---modify----end----------
DEFINE g_sql           STRING
DEFINE ld_date         DATETIME YEAR TO SECOND
DEFINE g_cnt           LIKE type_t.num5
DEFINE l_count         LIKE type_t.num5

   LET r_success = TRUE
   LET l_xreg.xregownid = g_user
   LET l_xreg.xregowndp = g_dept
   LET l_xreg.xregcrtid = g_user
   LET l_xreg.xregcrtdp = g_dept 
   LET ld_date  = cl_get_current()
   LET l_xreg.xregcrtdt = ld_date
   LET l_xreg.xregmodid = ""
   LET l_xreg.xregmoddt = ""
   LET l_xreg.xregcnfid = ""
   LET l_xreg.xregcnfdt = ""
   
   SELECT glaacomp INTO l_xreg.xregcomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald =  g_xreg_m.xregld
   CALL s_aooi200_fin_gen_docno(g_xreg_m.xregld,'','',g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_prog_name)
    RETURNING l_success,g_xreg_m.xregdocno
   IF l_success  = FALSE  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_xreg_m.xregdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INSERT INTO xreg_t (xregent,xregsite,xregcomp,xregdocno,xregdocdt,
                       xregld,xreg001,xreg002,xreg003,xreg004,
                       xreg005,xregstus,xregownid,xregowndp,xregcrtid,
                       xregcrtdp,xregcrtdt,xregmodid,xregmoddt,xregcnfid,
                       xregcnfdt)
   VALUES (g_enterprise,g_xreg_m.xregsite,l_xreg.xregcomp,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,
           g_xreg_m.xregld,g_xreg_m.xreg001,g_xreg_m.xreg002,'NM',g_xreg_m.xreg004,
           '','Y',l_xreg.xregownid,l_xreg.xregowndp,l_xreg.xregcrtid,
           l_xreg.xregcrtdp,l_xreg.xregcrtdt,l_xreg.xregmodid,l_xreg.xregmoddt,l_xreg.xregcnfid,
           l_xreg.xregcnfdt) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins xreg"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET r_success = FALSE   
      RETURN r_success
   END IF 
   
   
   #xreb只要取期別 + 帳套為條件
   
   #检查是否有资料
   LET g_sql = " SELECT COUNT(*) FROM xreb_t ",
               "  WHERE xrebent = '",g_enterprise,"' AND xrebld = '",g_xreg_m.xregld,"'",
               "    AND xreb001 = '",g_xreg_m.xreg001,"' AND xreb002 = '",g_xreg_m.xreg002,"'",
               "    AND xreb003 = 'NM' "
   PREPARE xreb_count_prep FROM g_sql
   EXECUTE xreb_count_prep INTO l_count
   #chenying add 1126
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()         
      LET r_success = FALSE   
      RETURN r_success        
   END IF
   #chenying add 1126        
   
   #161128-00061#2---modify----begin----------
   #LET g_sql = " SELECT * FROM xreb_t ",
   LET g_sql = " SELECT xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,",
               "xreb006,xreb007,xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,",
               "xreb016,xreb017,xreb018,xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,",
               "xreb025,xreb026,xreb027,xreb028,xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,",
               "xreb100,xreb101,xreb102,xreb103,xreb113,xreb114,xreb115,xreb116,xreb121,xreb122,",
               "xreb123,xreb124,xreb125,xreb126,xreb131,xreb132,xreb133,xreb134,xreb135,xreb136 FROM xreb_t ",
   #161128-00061#2---modify----end----------
               "  WHERE xrebent = '",g_enterprise,"' AND xrebld = '",g_xreg_m.xregld,"'",
               "    AND xreb001 = '",g_xreg_m.xreg001,"' AND xreb002 = '",g_xreg_m.xreg002,"'",
               "    AND xreb003 = 'NM' "
 
   PREPARE xreb_prep FROM g_sql
   DECLARE xreb_curs CURSOR FOR xreb_prep  

   LET g_cnt = 1 
   FOREACH xreb_curs INTO l_xreh.xrehent,l_xreb.xrebcomp,l_xreb.xrebsite,l_xreh.xrehld ,l_xreh.xreh001,l_xreh.xreh002,l_xreh.xreh003,l_xreh.xreh004,
                          l_xreh.xreh005,l_xreh.xreh006 ,l_xreh.xreh007 ,l_xreh.xreh008,l_xreh.xreh009,l_xreh.xreh010,l_xreh.xreh011,l_xreh.xreh012,
                          l_xreh.xreh013,l_xreh.xreh014 ,l_xreh.xreh015 ,l_xreh.xreh016,l_xreh.xreh017,l_xreh.xreh018,l_xreh.xreh019,l_xreh.xrehorga,
                          l_xreh.xreh020,l_xreh.xreh021 ,l_xreh.xreh022 ,l_xreh.xreh023,l_xreh.xreh024,l_xreh.xreh025,l_xreh.xreh026,l_xreh.xreh027,
                          l_xreh.xreh028,l_xreh.xreh029 ,l_xreh.xreh030 ,l_xreh.xreh031,l_xreh.xreh032,l_xreh.xreh033,l_xreh.xreh034,l_xreh.xreh100,
                          l_xreh.xreh101,l_xreh.xreh102 ,l_xreh.xreh103 ,l_xreh.xreh113,l_xreh.xreh114,l_xreh.xreh115,l_xreh.xreh116,l_xreh.xreh121,
                          l_xreh.xreh122,l_xreh.xreh123 ,l_xreh.xreh124 ,l_xreh.xreh125,l_xreh.xreh126,l_xreh.xreh131,l_xreh.xreh132,l_xreh.xreh133,
                          l_xreh.xreh134,l_xreh.xreh135 ,l_xreh.xreh136
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach xreh"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE  #chenying add 1126
         RETURN r_success
         EXIT FOREACH  
      END IF                            
      
      LET l_xreh.xrehdocno = g_xreg_m.xregdocno
      LET l_xreh.xrehseq   = g_cnt

      #161128-00061#2---modify----begin----------
      #INSERT INTO xreh_t VALUES(l_xreh.*)
      INSERT INTO xreh_t (xrehent,xrehdocno,xrehld,xrehseq,xreh001,xreh002,xreh003,xreh004,xreh005,xreh006,
                          xreh007,xreh008,xreh009,xreh010,xreh011,xreh012,xreh013,xreh014,xreh015,xreh016,
                          xreh017,xreh018,xreh019,xrehorga,xreh020,xreh021,xreh022,xreh023,xreh024,xreh025,
                          xreh026,xreh027,xreh028,xreh029,xreh030,xreh031,xreh032,xreh033,xreh034,xreh100,
                          xreh101,xreh102,xreh103,xreh113,xreh114,xreh115,xreh116,xreh121,xreh122,xreh123,
                          xreh124,xreh125,xreh126,xreh131,xreh132,xreh133,xreh134,xreh135,xreh136)
       VALUES(l_xreh.xrehent,l_xreh.xrehdocno,l_xreh.xrehld,l_xreh.xrehseq,l_xreh.xreh001,l_xreh.xreh002,l_xreh.xreh003,l_xreh.xreh004,l_xreh.xreh005,l_xreh.xreh006,
              l_xreh.xreh007,l_xreh.xreh008,l_xreh.xreh009,l_xreh.xreh010,l_xreh.xreh011,l_xreh.xreh012,l_xreh.xreh013,l_xreh.xreh014,l_xreh.xreh015,l_xreh.xreh016,
              l_xreh.xreh017,l_xreh.xreh018,l_xreh.xreh019,l_xreh.xrehorga,l_xreh.xreh020,l_xreh.xreh021,l_xreh.xreh022,l_xreh.xreh023,l_xreh.xreh024,l_xreh.xreh025,
              l_xreh.xreh026,l_xreh.xreh027,l_xreh.xreh028,l_xreh.xreh029,l_xreh.xreh030,l_xreh.xreh031,l_xreh.xreh032,l_xreh.xreh033,l_xreh.xreh034,l_xreh.xreh100,
              l_xreh.xreh101,l_xreh.xreh102,l_xreh.xreh103,l_xreh.xreh113,l_xreh.xreh114,l_xreh.xreh115,l_xreh.xreh116,l_xreh.xreh121,l_xreh.xreh122,l_xreh.xreh123,
              l_xreh.xreh124,l_xreh.xreh125,l_xreh.xreh126,l_xreh.xreh131,l_xreh.xreh132,l_xreh.xreh133,l_xreh.xreh134,l_xreh.xreh135,l_xreh.xreh136)
      #161128-00061#2---modify----end----------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xreh"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF  
         
      LET g_cnt = g_cnt + 1
   END FOREACH    
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 批次产生检查-检查傳票號碼是否存在，不存在则可删除重新生成
# Memo...........:
# Usage..........: CALL anmt821_04_check()
# Input parameter:  
# Date & Author..: 2014/10/30 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt821_04_check()
DEFINE r_success    LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_cnt1       LIKE type_t.num5
DEFINE l_xregdocno  LIKE xreg_t.xregdocno
DEFINE l_xregdocdt  LIKE xreg_t.xregdocdt

   LET r_success = TRUE
 
   #檢查是否存在xreg_t中,根據帳套、年度、期別
   #1.若已存在产生传票的资料，提示已存在资料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM xreg_t
    WHERE xregent = g_enterprise AND xreg003 = 'NM'
      AND xregld  = g_xreg_m.xregld 
      AND xreg001 = g_xreg_m.xreg001 
      AND xreg002 = g_xreg_m.xreg002
      AND xregstus = 'Y'
      AND xreg005 IS NOT NULL 
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00229"
      LET g_errparam.popup  = TRUE
      CALL cl_err()  
      LET r_success = FALSE      
   END IF   
   
   #2.若不存在产生传票的资料，询问是否删除重产
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt1 FROM xreg_t
    WHERE xregent = g_enterprise AND xreg003 = 'NM'
      AND xregld  = g_xreg_m.xregld 
      AND xreg001 = g_xreg_m.xreg001 
      AND xreg002 = g_xreg_m.xreg002
      AND (xreg005 IS NULL OR xreg005 = ' ')  
   IF l_cnt1 > 0 THEN 
      IF cl_ask_confirm('axr-00230') THEN   #是，删除资料新增
         LET r_success = TRUE    
      
         #获取单据编号
         SELECT xregdocno,xregdocdt INTO l_xregdocno,l_xregdocdt FROM xreg_t
          WHERE xregent = g_enterprise
            AND xregld  = g_xreg_m.xregld 
            AND xreg001 = g_xreg_m.xreg001 
            AND xreg002 = g_xreg_m.xreg002
            AND xreg003 = 'NM'
         
         #删除单头
         DELETE FROM xreg_t  
          WHERE xregent = g_enterprise
            AND xregdocno = l_xregdocno
            AND xregld  = g_xreg_m.xregld 
            AND xreg001 = g_xreg_m.xreg001 
            AND xreg002 = g_xreg_m.xreg002
            AND xreg003 = 'NM'
         IF NOT s_aooi200_fin_del_docno(g_xreg_m.xregld ,l_xregdocno,l_xregdocdt) THEN
            LET r_success = FALSE
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "del xreg" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         
            LET r_success = FALSE
         END IF    
        
         #删除单身
         DELETE FROM xreh_t          
          WHERE xrehent = g_enterprise
            AND xrehdocno = l_xregdocno
            AND xrehld  = g_xreg_m.xregld 
            AND xreh001 = g_xreg_m.xreg001 
            AND xreh002 = g_xreg_m.xreg002
            AND xreh003 = 'NM'            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "del xreh" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         
            LET r_success = FALSE
         END IF              
      ELSE
         LET r_success = FALSE
      END IF
   END IF 
   RETURN r_success   
END FUNCTION

 
{</section>}
 
