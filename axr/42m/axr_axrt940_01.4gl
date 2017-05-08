#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt940_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-11-18 17:11:27), PR版次:0009(2017-01-03 16:56:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000092
#+ Filename...: axrt940_01
#+ Description: 批次產生
#+ Creator....: 02599(2014-10-30 16:51:16)
#+ Modifier...: 02599 -SD/PR- 03080
 
{</section>}
 
{<section id="axrt940_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151125-00006#1  2015/12/03 by 06862    新增/修改/複製單據后立即審核，立即拋轉傳票
#160318-00025#53 2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160811-00009#3  2016/08/15  By 01531   账务中心/法人/账套权限控管
#161026-00013#1  2016/10/26  By 06821   組織類型與職能開窗調整
#161128-00061#5  2016/12/05  by 02481   标准程式定义采用宣告模式,弃用.*写法
#161104-00046#10 170103      By albireo 增加單別控制組
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
PRIVATE type type_g_xrea_m        RECORD
       xreasite LIKE xrea_t.xreasite, 
   xreasite_desc LIKE type_t.chr80, 
   xreald LIKE xrea_t.xreald, 
   xreald_desc LIKE type_t.chr80, 
   xrea016 LIKE xrea_t.xrea016, 
   xrea016_desc LIKE type_t.chr80, 
   docno_01 LIKE type_t.chr500, 
   xrea001 LIKE xrea_t.xrea001, 
   xrea002 LIKE xrea_t.xrea002, 
   xrejdocdt LIKE xrej_t.xrejdocdt, 
   xrad001 LIKE xrad_t.xrad001, 
   xrad001_desc LIKE type_t.chr80, 
   xrad004 LIKE xrad_t.xrad004, 
   chk_a LIKE type_t.chr500, 
   chk_b LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bookno              LIKE glaa_t.glaald
DEFINE g_glcb008             LIKE glcb_t.glcb008
DEFINE g_xrea_m_t            type_g_xrea_m
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_success             LIKE type_t.num5
DEFINE g_glaa121             LIKE glaa_t.glaa121   #20150529 add lujh 
#151125-00006#1--add--s
DEFINE l_ooba002         LIKE ooba_t.ooba002   
DEFINE l_xreacomp        LIKE xrea_t.xreacomp
DEFINE l_dfin0031        LIKE type_t.chr1
DEFINE l_dfin0032        LIKE type_t.chr1
DEFINE r_success         LIKE type_t.chr1
#151125-00006#1--add--e
DEFINE g_user_slip_wc    STRING      #161104-00046#10
#end add-point
 
DEFINE g_xrea_m        type_g_xrea_m
 
   DEFINE g_xreald_t LIKE xrea_t.xreald
DEFINE g_xrea001_t LIKE xrea_t.xrea001
DEFINE g_xrea002_t LIKE xrea_t.xrea002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt940_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt940_01(--)
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
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_glcb003       LIKE glcb_t.glcb003
   DEFINE l_ooag003       LIKE ooag_t.ooag003
   DEFINE ls_wc           STRING
   DEFINE l_xrejstus      LIKE xrej_t.xrejstus
   DEFINE r_xrejdocno     LIKE xrej_t.xrejdocno
   DEFINE l_ooac004       LIKE ooac_t.ooac004    #20150529 add lujh
   DEFINE l_flag          LIKE type_t.num5       #161104-00046#10
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt940_01 WITH FORM cl_ap_formpath("axr","axrt940_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL s_fin_set_comp_scc('xrea001','43')
   CALL cl_set_combo_scc('xrad004','8312')
   CALL axrt940_01_default()
   DISPLAY BY NAME g_xrea_m.xreasite,g_xrea_m.xreasite_desc,g_xrea_m.xreald,g_xrea_m.xreald_desc,
                   g_xrea_m.xrea016,g_xrea_m.xrea016_desc,g_xrea_m.docno_01,g_xrea_m.xrea001, 
                   g_xrea_m.xrea002,g_xrea_m.xrejdocdt,g_xrea_m.xrad001,g_xrea_m.xrad001_desc,
                   g_xrea_m.xrad004,g_xrea_m.chk_a,g_xrea_m.chk_b
   #161104-00046#10-----s
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc
   #161104-00046#10-----e
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrea_m.xreasite,g_xrea_m.xreald,g_xrea_m.xrea016,g_xrea_m.docno_01,g_xrea_m.xrea001, 
          g_xrea_m.xrea002,g_xrea_m.xrejdocdt,g_xrea_m.xrad001,g_xrea_m.xrad004,g_xrea_m.chk_a,g_xrea_m.chk_b  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_xrea_m_t.* = g_xrea_m.*
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreasite
            
            #add-point:AFTER FIELD xreasite name="input.a.xreasite"
            CALL axrt940_01_ref('xreasite')
            #160811-00009#3 mod s---
#            IF NOT cl_null(g_xrea_m.xreasite) THEN
#               CALL s_fin_account_center_with_ld_chk(g_xrea_m.xreasite,g_xrea_m.xreald,g_user,'3','N','',g_xrea_m.xrejdocdt) RETURNING l_success,g_errno
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_xrea_m.xreasite
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_xrea_m.xreasite = g_xrea_m_t.xreasite
#                  CALL axrt940_01_ref('xreasite')
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
            IF NOT cl_null(g_xrea_m.xreasite) THEN
               IF p_cmd = 'a' THEN
                  #161026-00013#1 --s add
                  #檢核是否結算組織
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrea_m.xreasite
                  IF NOT cl_chk_exist("v_ooef001_212") THEN  
                     LET g_xrea_m.xreasite = ''
                     LET g_xrea_m.xreasite_desc = s_desc_get_department_desc(g_xrea_m.xreasite)
                     DISPLAY BY NAME g_xrea_m.xreasite_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161026-00013#1 --e add
               
                  CALL s_axrt300_site_geared_ld(g_xrea_m.xreasite,g_xrea_m.xreald,g_xrea_m.xrea016,g_xrea_m.xrejdocdt,'site')
                     RETURNING l_success,g_xrea_m.xreasite,g_xrea_m.xreasite_desc,g_xrea_m.xreald,g_xrea_m.xreald_desc
                  DISPLAY BY NAME g_xrea_m.xreasite,g_xrea_m.xreasite_desc
                  DISPLAY BY NAME g_xrea_m.xreald,g_xrea_m.xreald_desc
                  IF NOT l_success THEN NEXT FIELD CURRENT END IF
               END IF
            ELSE
               LET g_xrea_m.xreasite_desc = ''
            END IF    
            #160811-00009#3 mod e---

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreasite
            #add-point:BEFORE FIELD xreasite name="input.b.xreasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreasite
            #add-point:ON CHANGE xreasite name="input.g.xreasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreald
            
            #add-point:AFTER FIELD xreald name="input.a.xreald"
            CALL axrt940_01_ref('xreald')
            IF NOT cl_null(g_xrea_m.xreald) THEN
               CALL s_fin_account_center_with_ld_chk(g_xrea_m.xreasite,g_xrea_m.xreald,g_user,'3','N','',g_xrea_m.xrejdocdt) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrea_m.xreald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrea_m.xreald = g_xrea_m_t.xreald
                  CALL axrt940_01_ref('xreald')
                  NEXT FIELD CURRENT
               END IF
               SELECT glaa003,glaa024,glaa121 INTO g_glaa003,g_glaa024,g_glaa121 FROM glaa_t   #20150529 add glaa121 lujh
               WHERE glaaent=g_enterprise AND glaald=g_xrea_m.xreald
               CALL axrt940_01_set_xrea002_scc()
               #帳齡類型
               SELECT glcb003,glcb008 INTO l_glcb003,g_glcb008 FROM glcb_t
               WHERE glcbent=g_enterprise AND glcbld=g_xrea_m.xreald AND glcb001='AR'
               IF cl_null(g_xrea_m.xrad001) THEN
                  LET g_xrea_m.xrad001=l_glcb003
                  CALL axrt940_01_ref('xrad001')
               END IF
               #納入帳齡分析選項
               IF g_glcb008='1' THEN
                  LET g_xrea_m.chk_a='N'
                  LET g_xrea_m.chk_b='N'
                  CALL cl_set_comp_visible('chk_a,chk_b',FALSE)
               ELSE
                  LET g_xrea_m.chk_a='N'
                  LET g_xrea_m.chk_b='Y'
                  CALL cl_set_comp_visible('chk_a,chk_b',TRUE)
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreald
            #add-point:BEFORE FIELD xreald name="input.b.xreald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreald
            #add-point:ON CHANGE xreald name="input.g.xreald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrea016
            
            #add-point:AFTER FIELD xrea016 name="input.a.xrea016"
            CALL axrt940_01_ref('xrea016')
            IF NOT cl_null(g_xrea_m.xrea016) THEN
               #資料存在性、有效性檢查
               CALL s_employee_chk(g_xrea_m.xrea016) RETURNING l_success
               IF NOT l_success THEN
                  LET g_xrea_m.xrea016 = g_xrea_m_t.xrea016
                  CALL axrt940_01_ref('xrea016')
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF cl_null(g_xrea_m.xrea016) AND cl_null(g_xrea_m.xreald) THEN
               LET g_xrea_m.xrea016 = g_user
            END IF
            CALL axrt940_01_ref('xrea016')

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrea016
            #add-point:BEFORE FIELD xrea016 name="input.b.xrea016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrea016
            #add-point:ON CHANGE xrea016 name="input.g.xrea016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno_01
            #add-point:BEFORE FIELD docno_01 name="input.b.docno_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno_01
            
            #add-point:AFTER FIELD docno_01 name="input.a.docno_01"
            #161104-00046#10-----s
            IF NOT cl_null(g_xrea_m.docno_01) THEN
               IF NOT s_aooi200_fin_chk_slip(g_xrea_m.xreald,g_glaa024,g_xrea_m.docno_01,g_prog) THEN
                  LET g_xrea_m.docno_01 = ''
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_control_chk_doc('1',g_xrea_m.docno_01,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN
               ELSE
                  LET g_xrea_m.docno_01 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #161104-00046#10-----e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno_01
            #add-point:ON CHANGE docno_01 name="input.g.docno_01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrea001
            #add-point:BEFORE FIELD xrea001 name="input.b.xrea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrea001
            
            #add-point:AFTER FIELD xrea001 name="input.a.xrea001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrea001
            #add-point:ON CHANGE xrea001 name="input.g.xrea001"
            IF NOT cl_null(g_xrea_m.xrea001) THEN
                  CALL axrt940_01_date_chk()
                  IF NOT cl_null(g_errno) THEN
                     LET g_errparam.extend = g_xrea_m.xrea001
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_xrea_m.xrea001 = g_xrea_m_t.xrea001
                     NEXT FIELD CURRENT
                  END IF
                  CALL axrt940_01_set_xrea002_scc()
               END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrea002
            #add-point:BEFORE FIELD xrea002 name="input.b.xrea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrea002
            
            #add-point:AFTER FIELD xrea002 name="input.a.xrea002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrea002
            #add-point:ON CHANGE xrea002 name="input.g.xrea002"
            IF NOT cl_null(g_xrea_m.xrea002) THEN
               CALL axrt940_01_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = g_xrea_m.xrea002
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_xrea_m.xrea002 = g_xrea_m_t.xrea002
                  NEXT FIELD CURRENT
               END IF
            END IF
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrad001
            
            #add-point:AFTER FIELD xrad001 name="input.a.xrad001"
            CALL axrt940_01_ref('xrad001')
            IF NOT cl_null(g_xrea_m.xrad001) THEN
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xrea_m.xrad001
               LET g_errshow = TRUE   #160318-00025#53
               LET g_chkparam.err_str[1] = "agl-00140:sub-01302|axri014|",cl_get_progname("axri014",g_lang,"2"),"|:EXEPROGaxri014"    #160318-00025#53   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xrad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  LET g_xrea_m.xrad001=g_xrea_m_t.xrad001
                  CALL axrt940_01_ref("xrad001")
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL axrt940_01_ref("xrad001")

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrad001
            #add-point:BEFORE FIELD xrad001 name="input.b.xrad001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrad001
            #add-point:ON CHANGE xrad001 name="input.g.xrad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrad004
            #add-point:BEFORE FIELD xrad004 name="input.b.xrad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrad004
            
            #add-point:AFTER FIELD xrad004 name="input.a.xrad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrad004
            #add-point:ON CHANGE xrad004 name="input.g.xrad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_a
            #add-point:BEFORE FIELD chk_a name="input.b.chk_a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_a
            
            #add-point:AFTER FIELD chk_a name="input.a.chk_a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_a
            #add-point:ON CHANGE chk_a name="input.g.chk_a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_b
            #add-point:BEFORE FIELD chk_b name="input.b.chk_b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_b
            
            #add-point:AFTER FIELD chk_b name="input.a.chk_b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_b
            #add-point:ON CHANGE chk_b name="input.g.chk_b"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xreasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreasite
            #add-point:ON ACTION controlp INFIELD xreasite name="input.c.xreasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrea_m.xreasite             #給予default值
            LET g_qryparam.default2 = "" #g_xrea_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#3
            
            #CALL q_ooef001()                                #呼叫開窗  #161026-00013#1 mark
            CALL q_ooef001_46()                                        #161026-00013#1 add

            LET g_xrea_m.xreasite = g_qryparam.return1              
            #LET g_xrea_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xrea_m.xreasite TO xreasite              #
            #DISPLAY g_xrea_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL axrt940_01_ref('xreasite')
            NEXT FIELD xreasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xreald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreald
            #add-point:ON ACTION controlp INFIELD xreald name="input.c.xreald"
            CALL s_fin_create_account_center_tmp()   
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xrea_m.xreasite,g_xrea_m.xrejdocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrea_m.xreald             #給予default值
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""

            #給予arg
            SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooagent = g_enterprise
               AND ooag001 = g_xrea_m.xrea016
            LET g_qryparam.arg1 = g_xrea_m.xrea016
            LET g_qryparam.arg2 = l_ooag003

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xrea_m.xreald = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xrea_m.xreald TO xreald              #顯示到畫面上
            CALL axrt940_01_ref('xreald')
            NEXT FIELD xreald                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xrea016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrea016
            #add-point:ON ACTION controlp INFIELD xrea016 name="input.c.xrea016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrea_m.xrea016             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_xrea_m.xrea016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xrea_m.xrea016 TO xrea016              #顯示到畫面上
            CALL axrt940_01_ref('xrea016')
            NEXT FIELD xrea003                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.docno_01
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno_01
            #add-point:ON ACTION controlp INFIELD docno_01 name="input.c.docno_01"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrea_m.docno_01             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = "axrt940"
            #161104-00046#10-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#10-----e   
            CALL q_ooba002_3()                                #呼叫開窗

            LET g_xrea_m.docno_01 = g_qryparam.return1              

            DISPLAY g_xrea_m.docno_01 TO docno_01              #

            NEXT FIELD docno_01                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrea001
            #add-point:ON ACTION controlp INFIELD xrea001 name="input.c.xrea001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrea002
            #add-point:ON ACTION controlp INFIELD xrea002 name="input.c.xrea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrejdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrejdocdt
            #add-point:ON ACTION controlp INFIELD xrejdocdt name="input.c.xrejdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrad001
            #add-point:ON ACTION controlp INFIELD xrad001 name="input.c.xrad001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrea_m.xrad001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL axri014_01()                                #呼叫開窗

            LET g_xrea_m.xrad001 = g_qryparam.return1              

            DISPLAY g_xrea_m.xrad001 TO xrad001              #
            CALL axrt940_01_ref('xrad001')
            NEXT FIELD xrad001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrad004
            #add-point:ON ACTION controlp INFIELD xrad004 name="input.c.xrad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_a
            #add-point:ON ACTION controlp INFIELD chk_a name="input.c.chk_a"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_b
            #add-point:ON ACTION controlp INFIELD chk_b name="input.c.chk_b"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            SELECT xrejstus INTO l_xrejstus FROM xrej_t 
            WHERE xrejent=g_enterprise AND xrejld=g_xrea_m.xreald 
            AND xrej001=g_xrea_m.xrea001 AND xrej002=g_xrea_m.xrea002
            AND xrej003='AR'
            IF l_xrejstus = 'Y' THEN
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axr-00244'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD xreald
            END IF
            SELECT COUNT(*) INTO l_count FROM xrej_t 
            WHERE xrejent=g_enterprise AND xrejld=g_xrea_m.xreald 
            AND xrej001=g_xrea_m.xrea001 AND xrej002=g_xrea_m.xrea002
            AND xrej003='AR'
            IF l_count>0 THEN
               IF NOT cl_ask_confirm('axr-00230') THEN   #是，删除资料新增,否，放弃执行操作
                  NEXT FIELD xreald
               END IF
            END IF
            CALL s_transaction_begin()
            CALL cl_err_collect_init()
            LET g_success = TRUE
            CALL axrt940_01_ins() RETURNING r_xrejdocno
            
            #20150529--add--str--lujh
            #是否抛傳票    
            SELECT ooac004 INTO l_ooac004
              FROM ooac_t
             WHERE ooacent = g_enterprise
               AND ooac001 = g_glaa024
               AND ooac002 = g_xrea_m.docno_01
               AND ooac003 = 'D-FIN-0030'
               
            IF g_glaa121 = 'Y' AND l_ooac004 = 'Y' THEN 
               CALL s_pre_voucher_ins('AR','R60',g_xrea_m.xreald,r_xrejdocno,g_xrea_m.xrejdocdt,'4') RETURNING l_success
            
               LET g_success = l_success
            END IF 
            #20150529--add--end--lujh
            
            IF g_success = FALSE THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')
               LET r_xrejdocno=''
            ELSE
               CALL s_transaction_end('Y','0')
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
   CLOSE WINDOW w_axrt940_01 
   
   #add-point:input段after input name="input.post_input"
   #151125-00006#1--add--s
   IF NOT INT_FLAG THEN 
      CALL s_aooi200_fin_get_slip(g_xrea_m.docno_01) RETURNING l_success,l_ooba002
      LET l_xreacomp = null
      SELECT glaacomp INTO l_xreacomp FROM glaa_t 
                                     WHERE glaaent = g_enterprise 
                                       AND glaald =  g_xrea_m.xreald
      CALL s_fin_get_doc_para(g_xrea_m.xreald,l_xreacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      CALL s_fin_get_doc_para(g_xrea_m.xreald,l_xreacomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         IF cl_ask_confirm('aap-00403') THEN
            CALL axrt940_01_immediately_conf() RETURNING r_success
            IF r_success = 'Y' THEN
               IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN 
                  IF cl_ask_confirm('axr-00888') THEN              
                     CALL axrt940_01_immediately_gen()
                  END IF 
                END IF 
            END IF 
         END IF 
      END IF       
   END IF 
   #151125-00006#1--add--e
   
   RETURN r_xrejdocno
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt940_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt940_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 默認設置
# Memo...........:
# Usage..........: CALL axrt940_01_default()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_default()
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_comp          LIKE xrea_t.xreacomp
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_strdat        LIKE type_t.dat
   DEFINE l_enddat        LIKE type_t.dat
   
   #單據日期
   LET g_xrea_m.xrejdocdt=g_today
   #帳務中心
   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'3',g_xrea_m.xrejdocdt) RETURNING l_success,g_xrea_m.xreasite,g_errno
   CALL axrt940_01_ref('xreasite')

   #g_bookno,先做帳務中心及g_bookno的勾稽,登入人員帳務人員時,基本上會有該g_bookno的帳務中心權限
   IF NOT cl_null(g_bookno) THEN
      #帳務中心與帳別勾稽
      CALL s_fin_account_center_with_ld_chk(g_xrea_m.xreasite,g_bookno,g_user,'3','N','',g_xrea_m.xrejdocdt) RETURNING l_success,g_errno
   END IF
   #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
   IF NOT l_success OR cl_null(g_bookno) THEN
      CALL s_fin_ld_carry('',g_user) RETURNING l_success,g_xrea_m.xreald,l_comp,g_errno
      CALL s_fin_account_center_with_ld_chk(g_xrea_m.xreasite,g_xrea_m.xreald,g_user,'3','N','',g_xrea_m.xrejdocdt) RETURNING l_success,g_errno
   ELSE
      LET g_xrea_m.xreald = g_bookno
   END IF
   #若取不出資料,則不預設帳別
   IF NOT l_success THEN
      LET g_xrea_m.xreald = ''
   END IF 
   IF NOT cl_null(g_xrea_m.xreald) THEN
      CALL axrt940_01_ref('xreald') 
      SELECT glaa003,glaa024,glaa121 INTO g_glaa003,g_glaa024,g_glaa121 FROM glaa_t    #20150529 add glaa121 lujh
       WHERE glaaent=g_enterprise AND glaald=g_xrea_m.xreald
   END IF
   #帳務人員
   LET g_xrea_m.xrea016 = g_user  
   CALL axrt940_01_ref('xrea016')
   #年度/期別
   LET l_date = cl_get_para(g_enterprise,g_xrea_m.xreasite,'S-FIN-2007')   #关账日期
   LET g_xrea_m.xrea001 = YEAR(l_date)
   LET g_xrea_m.xrea002 = MONTH(l_date)
   CALL axrt940_01_set_xrea002_scc()
   #單據日期
   IF NOT cl_null(g_glaa003) THEN
      CALL s_fin_date_get_period_range(g_glaa003,g_xrea_m.xrea001,g_xrea_m.xrea002)
          RETURNING l_strdat,l_enddat
      LET g_xrea_m.xrejdocdt = l_enddat
   END IF
   #帳齡類型
   SELECT glcb003,glcb008 INTO g_xrea_m.xrad001,g_glcb008 FROM glcb_t
   WHERE glcbent=g_enterprise AND glcbld=g_xrea_m.xreald AND glcb001='AR'
   CALL axrt940_01_ref("xrad001")
   #納入帳齡分析選項
   IF g_glcb008='1' THEN
      LET g_xrea_m.chk_a='N'
      LET g_xrea_m.chk_b='N'
      CALL cl_set_comp_visible('chk_a,chk_b',FALSE)
   ELSE
      LET g_xrea_m.chk_a='N'
      LET g_xrea_m.chk_b='Y'
      CALL cl_set_comp_visible('chk_a,chk_b',TRUE)
   END IF
   #單號 151125-00006#1--add
   LET g_xrea_m.docno_01 = null 
   
END FUNCTION

################################################################################
# Descriptions...: 欄位說明
# Memo...........:
# Usage..........: CALL axrt940_01_ref(p_field)
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_ref(p_field)
   DEFINE p_field       LIKE type_t.chr10
   
   CASE p_field
      WHEN 'xreasite'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrea_m.xreasite
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrea_m.xreasite_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrea_m.xreasite_desc
      WHEN 'xreald'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrea_m.xreald
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrea_m.xreald_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrea_m.xreald_desc
      WHEN 'xrea016'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrea_m.xrea016
         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         LET g_xrea_m.xrea016_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrea_m.xrea016_desc
      WHEN 'xrad001'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrea_m.xrad001
         CALL ap_ref_array2(g_ref_fields,"SELECT xradl003 FROM xradl_t WHERE xradlent='"||g_enterprise||"' AND xradl001=? AND xradl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrea_m.xrad001_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrea_m.xrad001_desc
         #帳齡起算日基準
         SELECT xrad004 INTO g_xrea_m.xrad004 FROM xrad_t
         WHERE xradent=g_enterprise AND xrad001=g_xrea_m.xrad001
         DISPLAY BY NAME g_xrea_m.xrad004
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 年度/期別檢查
# Memo...........:
# Usage..........: CALL axrt940_01_date_chk()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_date_chk()
   DEFINE l_date         LIKE type_t.dat
   DEFINE l_xrea001      LIKE xrea_t.xrea001
   DEFINE l_xrea002      LIKE xrea_t.xrea002
   DEFINE l_strdat       LIKE type_t.dat
   DEFINE l_enddat       LIKE type_t.dat
   DEFINE l_glaa003      LIKE glaa_t.glaa003
   
   IF cl_null(g_xrea_m.xreasite) THEN RETURN END IF
   IF cl_null(g_xrea_m.xrea001) THEN RETURN END IF
   IF cl_null(g_xrea_m.xrea002) THEN RETURN END IF

   LET l_date = cl_get_para(g_enterprise,g_xrea_m.xreasite,'S-FIN-2007')   #关账日期

   LET l_xrea001 = YEAR(l_date)
   LET l_xrea002 = MONTH(l_date)

   LET g_errno = ' '
   IF g_xrea_m.xrea001 < l_xrea001 THEN
      LET g_errno = 'anm-00248'
   END IF

   IF l_xrea001 = g_xrea_m.xrea001 AND  g_xrea_m.xrea002 < l_xrea002 THEN
      LET g_errno = 'axr-00321'
   END IF
   IF cl_null(g_errno) THEN
      LET l_glaa003 = NULL
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = g_xrea_m.xreald
      CALL s_fin_date_get_period_range(l_glaa003,g_xrea_m.xrea001,g_xrea_m.xrea002)
          RETURNING l_strdat,l_enddat
      LET g_xrea_m.xrejdocdt = l_enddat
   END IF
END FUNCTION

################################################################################
# Descriptions...: 產生帳齡資料ins xrej_t xrek_t
# Memo...........:
# Usage..........: CALL axrt940_01_ins()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_ins()
   #161128-00061#5---modify----begin-------------  
  # DEFINE l_xrej        RECORD LIKE xrej_t.*
  # DEFINE l_xrek        RECORD LIKE xrek_t.*
  # DEFINE l_xrea        RECORD LIKE xrea_t.*
  DEFINE l_xrej RECORD  #壞帳提列主檔
       xrejent LIKE xrej_t.xrejent, #企業編號
       xrejownid LIKE xrej_t.xrejownid, #資料所有者
       xrejowndp LIKE xrej_t.xrejowndp, #資料所屬部門
       xrejcrtid LIKE xrej_t.xrejcrtid, #資料建立者
       xrejcrtdp LIKE xrej_t.xrejcrtdp, #資料建立部門
       xrejcrtdt LIKE xrej_t.xrejcrtdt, #資料創建日
       xrejmodid LIKE xrej_t.xrejmodid, #資料修改者
       xrejmoddt LIKE xrej_t.xrejmoddt, #最近修改日
       xrejcnfid LIKE xrej_t.xrejcnfid, #資料確認者
       xrejcnfdt LIKE xrej_t.xrejcnfdt, #資料確認日
       xrejstus LIKE xrej_t.xrejstus, #狀態碼
       xrejsite LIKE xrej_t.xrejsite, #帳務中心
       xrejld LIKE xrej_t.xrejld, #帳套
       xrejcomp LIKE xrej_t.xrejcomp, #法人
       xrejdocno LIKE xrej_t.xrejdocno, #單號
       xrejdocdt LIKE xrej_t.xrejdocdt, #單據日期
       xrej001 LIKE xrej_t.xrej001, #年度
       xrej002 LIKE xrej_t.xrej002, #期別
       xrej003 LIKE xrej_t.xrej003, #來源模組
       xrej004 LIKE xrej_t.xrej004, #帳務人員
       xrej005 LIKE xrej_t.xrej005  #傳票號碼
       END RECORD
DEFINE l_xrek RECORD  #壞帳提列明細檔
       xrekent LIKE xrek_t.xrekent, #企業編號
       xrekcomp LIKE xrek_t.xrekcomp, #法人
       xrekld LIKE xrek_t.xrekld, #帳套
       xrekdocno LIKE xrek_t.xrekdocno, #單據號碼
       xrekseq LIKE xrek_t.xrekseq, #序號
       xrek001 LIKE xrek_t.xrek001, #年度
       xrek002 LIKE xrek_t.xrek002, #期別
       xrek003 LIKE xrek_t.xrek003, #來源模組
       xrek004 LIKE xrek_t.xrek004, #帳款單性質
       xrek005 LIKE xrek_t.xrek005, #帳款單號碼
       xrek006 LIKE xrek_t.xrek006, #帳款單項次
       xrek007 LIKE xrek_t.xrek007, #分期帳款序
       xrek008 LIKE xrek_t.xrek008, #立帳日期
       xrek009 LIKE xrek_t.xrek009, #帳款對象
       xrek010 LIKE xrek_t.xrek010, #收款對象
       xrek011 LIKE xrek_t.xrek011, #部門
       xrek012 LIKE xrek_t.xrek012, #責任中心
       xrek013 LIKE xrek_t.xrek013, #區域
       xrek014 LIKE xrek_t.xrek014, #客群
       xrek015 LIKE xrek_t.xrek015, #產品類別
       xrek016 LIKE xrek_t.xrek016, #人員
       xrek017 LIKE xrek_t.xrek017, #專案編號
       xrek018 LIKE xrek_t.xrek018, #WBS編號
       xrek019 LIKE xrek_t.xrek019, #壞帳科目
       xrekorga LIKE xrek_t.xrekorga, #來源組織
       xrek020 LIKE xrek_t.xrek020, #經營方式
       xrek021 LIKE xrek_t.xrek021, #通路
       xrek022 LIKE xrek_t.xrek022, #品牌
       xrek023 LIKE xrek_t.xrek023, #自由核算項一
       xrek024 LIKE xrek_t.xrek024, #自由核算項二
       xrek025 LIKE xrek_t.xrek025, #自由核算項三
       xrek026 LIKE xrek_t.xrek026, #自由核算項四
       xrek027 LIKE xrek_t.xrek027, #自由核算項五
       xrek028 LIKE xrek_t.xrek028, #自由核算項六
       xrek029 LIKE xrek_t.xrek029, #自由核算項七
       xrek030 LIKE xrek_t.xrek030, #自由核算項八
       xrek031 LIKE xrek_t.xrek031, #自由核算項九
       xrek032 LIKE xrek_t.xrek032, #自由核算項十
       xrek033 LIKE xrek_t.xrek033, #摘要
       xrek034 LIKE xrek_t.xrek034, #信評等級
       xrek035 LIKE xrek_t.xrek035, #帳齡類型
       xrek036 LIKE xrek_t.xrek036, #帳齡起算日
       xrek037 LIKE xrek_t.xrek037, #本期帳齡天數
       xrek038 LIKE xrek_t.xrek038, #前期帳齡天數
       xrek039 LIKE xrek_t.xrek039, #本期壞帳提列率
       xrek040 LIKE xrek_t.xrek040, #前期壞帳提列率
       xrek041 LIKE xrek_t.xrek041, #備抵科目
       xrek100 LIKE xrek_t.xrek100, #幣別
       xrek101 LIKE xrek_t.xrek101, #匯率
       xrek103 LIKE xrek_t.xrek103, #本期原幣未沖金額
       xrek104 LIKE xrek_t.xrek104, #前期原幣未沖金額
       xrek105 LIKE xrek_t.xrek105, #本期原幣應計提壞帳金額
       xrek106 LIKE xrek_t.xrek106, #前期原幣應計提壞帳金額
       xrek107 LIKE xrek_t.xrek107, #本期實提原幣金額
       xrek113 LIKE xrek_t.xrek113, #本期本幣未沖金額
       xrek114 LIKE xrek_t.xrek114, #前期本幣未沖金額
       xrek115 LIKE xrek_t.xrek115, #本期本幣應計提壞帳金額
       xrek116 LIKE xrek_t.xrek116, #前期本幣應計提壞帳金額
       xrek117 LIKE xrek_t.xrek117, #本期實提本幣金額
       xrek121 LIKE xrek_t.xrek121, #本位幣二匯率
       xrek123 LIKE xrek_t.xrek123, #本期本位幣二未沖金額
       xrek124 LIKE xrek_t.xrek124, #前期本位幣二未沖金額
       xrek125 LIKE xrek_t.xrek125, #本期本位幣二應計提壞帳金額
       xrek126 LIKE xrek_t.xrek126, #前期本位幣二應計提壞帳金額
       xrek127 LIKE xrek_t.xrek127, #本期實提本位幣二壞帳金額
       xrek131 LIKE xrek_t.xrek131, #本位幣三匯率
       xrek133 LIKE xrek_t.xrek133, #本期本位幣三未沖金額
       xrek134 LIKE xrek_t.xrek134, #前期本位幣三未沖金額
       xrek135 LIKE xrek_t.xrek135, #本期本位幣三應計提壞帳金額
       xrek136 LIKE xrek_t.xrek136, #前期本位幣三應計提壞帳金額
       xrek137 LIKE xrek_t.xrek137  #本期實提本位幣三壞帳金額
       END RECORD
 DEFINE l_xrea RECORD  #往來帳科目月結檔
       xreaent LIKE xrea_t.xreaent, #企業編號
       xreacomp LIKE xrea_t.xreacomp, #法人
       xreasite LIKE xrea_t.xreasite, #帳務組織
       xreald LIKE xrea_t.xreald, #帳套
       xrea001 LIKE xrea_t.xrea001, #年度
       xrea002 LIKE xrea_t.xrea002, #期別
       xrea003 LIKE xrea_t.xrea003, #來源模組
       xrea004 LIKE xrea_t.xrea004, #帳款單性質
       xrea005 LIKE xrea_t.xrea005, #單據號碼
       xrea006 LIKE xrea_t.xrea006, #項次
       xrea007 LIKE xrea_t.xrea007, #分期帳款序
       xrea008 LIKE xrea_t.xrea008, #立帳日期
       xrea009 LIKE xrea_t.xrea009, #帳款對象
       xrea010 LIKE xrea_t.xrea010, #收款對象
       xrea011 LIKE xrea_t.xrea011, #部門
       xrea012 LIKE xrea_t.xrea012, #責任中心
       xrea013 LIKE xrea_t.xrea013, #區域
       xrea014 LIKE xrea_t.xrea014, #客群
       xrea015 LIKE xrea_t.xrea015, #產品類別
       xrea016 LIKE xrea_t.xrea016, #人員
       xrea017 LIKE xrea_t.xrea017, #專案編號
       xrea018 LIKE xrea_t.xrea018, #WBS編號
       xrea019 LIKE xrea_t.xrea019, #應收付科目
       xreaorga LIKE xrea_t.xreaorga, #來源組織
       xrea020 LIKE xrea_t.xrea020, #經營方式
       xrea021 LIKE xrea_t.xrea021, #通路
       xrea022 LIKE xrea_t.xrea022, #品牌
       xrea023 LIKE xrea_t.xrea023, #自由核算項一
       xrea024 LIKE xrea_t.xrea024, #自由核算項二
       xrea025 LIKE xrea_t.xrea025, #自由核算項三
       xrea026 LIKE xrea_t.xrea026, #自由核算項四
       xrea027 LIKE xrea_t.xrea027, #自由核算項五
       xrea028 LIKE xrea_t.xrea028, #自由核算項六
       xrea029 LIKE xrea_t.xrea029, #自由核算項七
       xrea030 LIKE xrea_t.xrea030, #自由核算項八
       xrea031 LIKE xrea_t.xrea031, #自由核算項九
       xrea032 LIKE xrea_t.xrea032, #自由核算項十
       xrea033 LIKE xrea_t.xrea033, #摘要
       xrea034 LIKE xrea_t.xrea034, #發票日期
       xrea035 LIKE xrea_t.xrea035, #出貨單據日期
       xrea036 LIKE xrea_t.xrea036, #交易認定日期
       xrea037 LIKE xrea_t.xrea037, #出入庫扣帳日期
       xrea038 LIKE xrea_t.xrea038, #應收款日
       xrea039 LIKE xrea_t.xrea039, #信評等級
       xrea040 LIKE xrea_t.xrea040, #稅別
       xrea041 LIKE xrea_t.xrea041, #稅率
       xrea042 LIKE xrea_t.xrea042, #No Use
       xrea043 LIKE xrea_t.xrea043, #No Use
       xrea100 LIKE xrea_t.xrea100, #幣別
       xrea101 LIKE xrea_t.xrea101, #交易匯率
       xrea102 LIKE xrea_t.xrea102, #重評匯率
       xrea103 LIKE xrea_t.xrea103, #原幣未沖含稅金額
       xrea104 LIKE xrea_t.xrea104, #原幣暫估未沖未稅金額
       xrea105 LIKE xrea_t.xrea105, #原幣暫估未沖稅額
       xrea106 LIKE xrea_t.xrea106, #原幣暫估未沖含稅金額
       xrea113 LIKE xrea_t.xrea113, #本幣未沖含稅金額
       xrea114 LIKE xrea_t.xrea114, #本幣暫估未沖未稅金額
       xrea115 LIKE xrea_t.xrea115, #本幣暫估未沖稅額
       xrea116 LIKE xrea_t.xrea116, #本幣暫估未沖含稅金額
       xrea122 LIKE xrea_t.xrea122, #本位幣二重評匯率
       xrea123 LIKE xrea_t.xrea123, #本位幣二未沖含稅金額
       xrea132 LIKE xrea_t.xrea132, #本位幣三重評匯率
       xrea133 LIKE xrea_t.xrea133, #本位幣三未沖含稅金額
       xrea044 LIKE xrea_t.xrea044, #發票號碼
       xrea045 LIKE xrea_t.xrea045  #交易條件
       END RECORD


   #161128-00061#5---modify----end-------------    
   DEFINE l_dat         LIKE type_t.dat
   DEFINE l_comp        LIKE ooef_t.ooef001
   DEFINE l_sql         STRING
   DEFINE l_xrek1       RECORD
                        xrekdocno LIKE xrek_t.xrekdocno,
                        xrekseq   LIKE xrek_t.xrekseq,
                        xrek037   LIKE xrek_t.xrek037,
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
                        xrek037   LIKE xrek_t.xrek037,
                        xrek103   LIKE xrek_t.xrek103,
                        xrek113   LIKE xrek_t.xrek113,
                        xrek123   LIKE xrek_t.xrek123,
                        xrek133   LIKE xrek_t.xrek133
                        END RECORD
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xraf        RECORD LIKE xraf_t.*
   DEFINE l_xraf RECORD  #壞帳提列率依信評級設定檔
       xrafent LIKE xraf_t.xrafent, #企業編號
       xraf001 LIKE xraf_t.xraf001, #帳齡類型編號
       xraf002 LIKE xraf_t.xraf002, #信評等級
       xraf003 LIKE xraf_t.xraf003, #分段一壞帳提列率
       xraf004 LIKE xraf_t.xraf004, #分段二壞帳提列率
       xraf005 LIKE xraf_t.xraf005, #分段三壞帳提列率
       xraf006 LIKE xraf_t.xraf006, #分段四壞帳提列率
       xraf007 LIKE xraf_t.xraf007, #分段五壞帳提列率
       xraf008 LIKE xraf_t.xraf008, #分段六壞帳提列率
       xraf009 LIKE xraf_t.xraf009, #分段七壞帳提列率
       xraf010 LIKE xraf_t.xraf010, #分段八壞帳提列率
       xraf011 LIKE xraf_t.xraf011, #分段九壞帳提列率
       xraf012 LIKE xraf_t.xraf012, #分段十壞帳提列率
       xraf013 LIKE xraf_t.xraf013, #分段十一壞帳提列率
       xraf014 LIKE xraf_t.xraf014, #分段十二壞帳提列率
       xraf015 LIKE xraf_t.xraf015, #分段十三壞帳提列率
       xraf016 LIKE xraf_t.xraf016, #分段十四壞帳提列率
       xraf017 LIKE xraf_t.xraf017, #分段十五壞帳提列率
       xraf018 LIKE xraf_t.xraf018, #分段十六壞帳提列率
       xraf019 LIKE xraf_t.xraf019, #分段十七壞帳提列率
       xraf020 LIKE xraf_t.xraf020, #分段十八壞帳提列率
       xraf021 LIKE xraf_t.xraf021, #分段十九壞帳提列率
       xraf022 LIKE xraf_t.xraf022  #分段二十壞帳提列率
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE l_glcb007     LIKE glcb_t.glcb007
   DEFINE l_xrad004     LIKE xrad_t.xrad004
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_strdat      LIKE type_t.dat
   DEFINE l_enddat      LIKE type_t.dat
   DEFINE l_xrae002     LIKE xrae_t.xrae002
   DEFINE l_seq         LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   #刪除同帳別+年度+期別的帳齡資料
   #單頭
   DELETE FROM xrej_t
   WHERE xrejent=g_enterprise AND xrejld=g_xrea_m.xreald 
   AND xrej001=g_xrea_m.xrea001 AND xrej002=g_xrea_m.xrea002
   AND xrej003='AR' 
   #單身
   DELETE FROM xrek_t
   WHERE xrekent=g_enterprise AND xrekld=g_xrea_m.xreald 
   AND xrek001=g_xrea_m.xrea001 AND xrek002=g_xrea_m.xrea002
   AND xrek003='AR'
   
   #建立臨時表處理資料    
   DROP TABLE axrt940_01_tmp
   SELECT * FROM xrek_t WHERE 1=2 INTO TEMP axrt940_01_tmp 
   
   #依INPUT 資料產生單頭
   LET l_comp = NULL
   SELECT glaacomp INTO l_comp FROM glaa_t
    WHERE glaaent = g_enterprise  AND glaald  = g_xrea_m.xreald
   INITIALIZE l_xrej.* TO NULL
   LET l_xrej.xrejent = g_enterprise
   LET l_xrej.xrejsite = g_xrea_m.xreasite
   LET l_xrej.xrejcomp = l_comp
   LET l_xrej.xrejld = g_xrea_m.xreald
   LET l_xrej.xrejdocdt = g_xrea_m.xrejdocdt
   CALL s_aooi200_fin_gen_docno(l_xrej.xrejld,'','',g_xrea_m.docno_01,l_xrej.xrejdocdt,'axrt940')
      RETURNING g_sub_success,l_xrej.xrejdocno
   LET l_xrej.xrej001 = g_xrea_m.xrea001
   LET l_xrej.xrej002 = g_xrea_m.xrea002
   LET l_xrej.xrej003 = 'AR'
   LET l_xrej.xrej004 = g_xrea_m.xrea016
   LET l_dat = cl_get_current()
   LET l_xrej.xrejownid = g_user
   LET l_xrej.xrejowndp = g_dept
   LET l_xrej.xrejcrtid = g_user
   LET l_xrej.xrejcrtdt = l_dat
   LET l_xrej.xrejcrtdp = g_dept
   LET l_xrej.xrejstus  = 'N'
   LET g_xrea_m.docno_01 = l_xrej.xrejdocno   #151125-00006#1--add
   #161128-00061#5---modify----begin------------- 
   #INSERT INTO xrej_t VALUES(l_xrej.*)
   INSERT INTO xrej_t (xrejent,xrejownid,xrejowndp,xrejcrtid,xrejcrtdp,xrejcrtdt,xrejmodid,xrejmoddt,xrejcnfid,
                      xrejcnfdt,xrejstus,xrejsite,xrejld,xrejcomp,xrejdocno,xrejdocdt,xrej001,xrej002,xrej003,
                      xrej004,xrej005)
    VALUES(l_xrej.xrejent,l_xrej.xrejownid,l_xrej.xrejowndp,l_xrej.xrejcrtid,l_xrej.xrejcrtdp,l_xrej.xrejcrtdt,l_xrej.xrejmodid,l_xrej.xrejmoddt,l_xrej.xrejcnfid,
           l_xrej.xrejcnfdt,l_xrej.xrejstus,l_xrej.xrejsite,l_xrej.xrejld,l_xrej.xrejcomp,l_xrej.xrejdocno,l_xrej.xrejdocdt,l_xrej.xrej001,l_xrej.xrej002,l_xrej.xrej003,
           l_xrej.xrej004,l_xrej.xrej005)
   #161128-00061#5---modify----end------------- 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xrej_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
   END IF
   
   #插入單身xrek_t
   SELECT glcb007,glcb008 INTO l_glcb007,g_glcb008 FROM glcb_t
    WHERE glcbent = g_enterprise AND glcbld  = g_xrea_m.xreald AND glcb001='AR'
      
   LET l_year = g_xrea_m.xrea001
   LET l_month = g_xrea_m.xrea002
   LET l_month = l_month - 1 
   IF l_month = 0 THEN
      LET l_month = 12
      LET l_year = l_year - 1
   END IF 
    
   #step 1 處理當期
   #依規則塞入tmp table
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = " SELECT * FROM xrea_t ",
   LET l_sql = " SELECT xreaent,xreacomp,xreasite,xreald,xrea001,xrea002,xrea003,xrea004,xrea005,xrea006,xrea007,",
               "xrea008,xrea009,xrea010,xrea011,xrea012,xrea013,xrea014,xrea015,xrea016,xrea017,xrea018,xrea019,",
               "xreaorga,xrea020,xrea021,xrea022,xrea023,xrea024,xrea025,xrea026,xrea027,xrea028,xrea029,xrea030,",
               "xrea031,xrea032,xrea033,xrea034,xrea035,xrea036,xrea037,xrea038,xrea039,xrea040,xrea041,xrea042,",
               "xrea043,xrea100,xrea101,xrea102,xrea103,xrea104,xrea105,xrea106,xrea113,xrea114,xrea115,xrea116,",
               "xrea122,xrea123,xrea132,xrea133,xrea044,xrea045 FROM xrea_t",           
   #161128-00061#5---modify----end------------- 
               "  WHERE xreaent = ",g_enterprise," ",
               "    AND xreald  = '",g_xrea_m.xreald,"' ",
               "    AND xrea001 = '",g_xrea_m.xrea001,"' ",
               "    AND xrea002 = '",g_xrea_m.xrea002,"' ",
               "    AND xrea003 = 'AR' "
   #暫估類帳款納入分析否
   IF l_glcb007 <> 'Y' THEN
      LET l_sql=l_sql," AND xrea004 NOT LIKE '0%'"
   END IF
   #待抵及帳款減項扣除
   IF g_glcb008 = '1' THEN
      LET l_sql=l_sql," AND xrea004 NOT LIKE '2%'"
   ELSE
      #溢(預)收待抵單(非22的2*帳款類型) 
      IF g_xrea_m.chk_a ='N' THEN
         LET l_sql=l_sql," AND xrea004 NOT IN ('21','23','24','25','29')"
      END IF
      #销退待抵(22)
      IF  g_xrea_m.chk_b ='N' THEN
         LET l_sql=l_sql," AND xrea004 <> '22'"
      END IF
   END IF
   PREPARE axrt940_01_pr FROM l_sql 
   DECLARE axrt940_01_cs CURSOR FOR axrt940_01_pr
       
   INITIALIZE l_xrea.* TO NULL
   LET l_seq=1
   FOREACH axrt940_01_cs INTO l_xrea.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "axrt940_01_cs:FOREACH "
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_xrek.* TO NULL
      LET l_xrek.xrekent   = g_enterprise
      LET l_xrek.xrekcomp  = l_xrea.xreacomp
      LET l_xrek.xrekld    = l_xrea.xreald
      LET l_xrek.xrekdocno = l_xrej.xrejdocno
      LET l_xrek.xrekseq = NULL
      LET l_xrek.xrekseq = l_seq
      LET l_xrek.xrek001 = l_xrea.xrea001
      LET l_xrek.xrek002 = l_xrea.xrea002
      LET l_xrek.xrek003 = 'AR'
      LET l_xrek.xrek004 = l_xrea.xrea004
      LET l_xrek.xrek005 = l_xrea.xrea005
      LET l_xrek.xrek006 = l_xrea.xrea006
      LET l_xrek.xrek007 = l_xrea.xrea007
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
      #費用科目：取 agli172 壞帳損失科目
      SELECT glab005 INTO l_xrek.xrek019 FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = l_xrea.xreald
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
      LET l_xrek.xrek035  = g_xrea_m.xrad001 #帳齡類型
      #帳齡起算日
      CASE g_xrea_m.xrad004
         WHEN '01' #依單據日
            LET l_xrek.xrek036 = l_xrea.xrea008
         WHEN '03' #依發票日
            LET l_xrek.xrek036 = l_xrea.xrea034 
         WHEN '05' #依入帳日
            LET l_xrek.xrek036 = l_xrea.xrea035
         WHEN '07' #依出入庫日
            LET l_xrek.xrek036 = l_xrea.xrea037
         WHEN '09' #交易認定日
            LET l_xrek.xrek036 = l_xrea.xrea036
         WHEN '90' #收付款日
            LET l_xrek.xrek036 = l_xrea.xrea038
      END CASE
      #本期帳齡天數
      #條件期別最大日期-帳齡起算日(負數則給0) 
      LET l_glaa003 = NULL
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = l_xrea.xreald
      CALL s_fin_date_get_period_range(l_glaa003,g_xrea_m.xrea001,g_xrea_m.xrea002)
          RETURNING l_strdat,l_enddat
      LET l_xrek.xrek037 = l_enddat - l_xrek.xrek036
      IF cl_null(l_xrek.xrek037) OR l_xrek.xrek037 <= 0 THEN
         LET l_xrek.xrek037 = 0
      END IF
      
      #本期壞帳提列率
      CALL axrt940_01_get_xrek039(l_xrek.xrekcomp,l_xrek.xrek009,l_xrek.xrek037) RETURNING l_xrek.xrek039  
      
      #xrek040	前期壞帳提列率
      #備抵科目
      #LET l_xrek.xrek041
      SELECT glab005 INTO l_xrek.xrek041 FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = l_xrea.xreald
         AND glab001 = '23'
         AND glab002 = '8319'
         AND glab003 = '8319_21'
      
      #########################################
      #抓前期資料
      #前期帳齡天數
      #LET l_xrek.xrek038 old 037  
      #LET l_xrek.xrek040 old 039
      #LET l_xrek.xrek104 old 103
      #LET l_xrek.xrek106 old 105
      #LET l_xrek.xrek114 old 113
      #LET l_xrek.xrek116 old 115
      #LET l_xrek.xrek124 old 123
      #LET l_xrek.xrek126 old 125
      #LET l_xrek.xrek134 old 133
      #LET l_xrek.xrek136 old 135
      SELECT xrek037,xrek039,xrek103,xrek105,
             xrek113,xrek115,xrek123,xrek125
             xrek133,xrek135
        INTO l_xrek.xrek038,l_xrek.xrek040,l_xrek.xrek104,l_xrek.xrek106,
             l_xrek.xrek114,l_xrek.xrek116,l_xrek.xrek124,l_xrek.xrek126,
             l_xrek.xrek134,l_xrek.xrek136
        FROM xrek_t
       WHERE xrekent = g_enterprise
         AND xrekld  = l_xrek.xrekld
         AND xrek005 = l_xrek.xrek005
         AND xrek006 = l_xrek.xrek006
         AND xrek007 = l_xrek.xrek007
         AND xrek001 = l_year
         AND xrek002 = l_month
         AND xrek003 = 'AR'
      IF cl_null(l_xrek.xrek038)THEN LET l_xrek.xrek038=0 END IF   
      IF cl_null(l_xrek.xrek040)THEN LET l_xrek.xrek040=0 END IF
      IF cl_null(l_xrek.xrek104)THEN LET l_xrek.xrek104 = 0 END IF
      IF cl_null(l_xrek.xrek106)THEN LET l_xrek.xrek106 = 0 END IF  
      IF cl_null(l_xrek.xrek114)THEN LET l_xrek.xrek114 = 0 END IF
      IF cl_null(l_xrek.xrek116)THEN LET l_xrek.xrek116 = 0 END IF
      IF cl_null(l_xrek.xrek124)THEN LET l_xrek.xrek124 = 0 END IF
      IF cl_null(l_xrek.xrek126)THEN LET l_xrek.xrek126 = 0 END IF
      IF cl_null(l_xrek.xrek134)THEN LET l_xrek.xrek134 = 0 END IF
      IF cl_null(l_xrek.xrek136)THEN LET l_xrek.xrek136 = 0 END IF      
      #########################################
      
      LET l_xrek.xrek100 = l_xrea.xrea100
      LET l_xrek.xrek101 = l_xrea.xrea102
      LET l_xrek.xrek103 = l_xrea.xrea103
      LET l_xrek.xrek105 = l_xrek.xrek103 * l_xrek.xrek039 / 100
      LET l_xrek.xrek107 = l_xrek.xrek105 - l_xrek.xrek106
      
      LET l_xrek.xrek113 = l_xrea.xrea113
      LET l_xrek.xrek115 = l_xrek.xrek113 * l_xrek.xrek039 / 100
      LET l_xrek.xrek117 = l_xrek.xrek115 - l_xrek.xrek116
      
      LET l_xrek.xrek121 = l_xrea.xrea122
      LET l_xrek.xrek123 = l_xrea.xrea123
      LET l_xrek.xrek125 = l_xrek.xrek123 * l_xrek.xrek039 / 100
      LET l_xrek.xrek127 = l_xrek.xrek125 - l_xrek.xrek126
      
      LET l_xrek.xrek131  = l_xrea.xrea132
      LET l_xrek.xrek133  = l_xrea.xrea133
      LET l_xrek.xrek135 = l_xrek.xrek133 * l_xrek.xrek039 / 100
      LET l_xrek.xrek137 = l_xrek.xrek135 - l_xrek.xrek136 

      #161128-00061#5---modify----begin------------- 
      #INSERT INTO axrt940_01_tmp VALUES(l_xrek.*)
      INSERT INTO axrt940_01_tmp (xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,xrek001,xrek002,xrek003,xrek004,
                          xrek005,xrek006,xrek007,xrek008,xrek009,xrek010,xrek011,xrek012,xrek013,xrek014,
                          xrek015,xrek016,xrek017,xrek018,xrek019,xrekorga,xrek020,xrek021,xrek022,xrek023,
                          xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,xrek030,xrek031,xrek032,xrek033,
                          xrek034,xrek035,xrek036,xrek037,xrek038,xrek039,xrek040,xrek041,xrek100,xrek101,
                          xrek103,xrek104,xrek105,xrek106,xrek107,xrek113,xrek114,xrek115,xrek116,xrek117,
                          xrek121,xrek123,xrek124,xrek125,xrek126,xrek127,xrek131,xrek133,xrek134,xrek135,
                          xrek136,xrek137)
       VALUES(l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,
              l_xrek.xrek005,l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,
              l_xrek.xrek015,l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,l_xrek.xrek020,l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,
              l_xrek.xrek024,l_xrek.xrek025,l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,l_xrek.xrek030,l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,
              l_xrek.xrek034,l_xrek.xrek035,l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,l_xrek.xrek040,l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,
              l_xrek.xrek103,l_xrek.xrek104,l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,l_xrek.xrek114,l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,
              l_xrek.xrek121,l_xrek.xrek123,l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,l_xrek.xrek131,l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,
              l_xrek.xrek136,l_xrek.xrek137)
      #161128-00061#5---modify----end-------------
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "axrt940_01_tmp "
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE
         CALL cl_err()      
         LET g_success=FALSE
      END IF
      LET l_seq=l_seq+1
   END FOREACH   
            
   #待抵及帳款減項處理glcb008=2：先進先出法或3：後進先出法
   IF g_glcb008 = '2' OR g_glcb008 = '3' THEN
      #有扣除就要看是哪種
      #重新組SQL
      #把全部1類的資料都抓進來(負)
      LET l_sql = "SELECT xrekdocno,xrekseq,xrek037,xrek009,xrek100,xrek103,xrek113,xrek123,xrek133 ",
                  "  FROM axrt940_01_tmp ",
                  " WHERE xrek004 LIKE '2%' ",
                  "   AND xrek103 <> 0"
      IF g_glcb008 = '2' THEN
         LET l_sql = l_sql," ORDER BY xrek037 DESC"
      ELSE
          LET l_sql = l_sql," ORDER BY xrek037 "
      END IF
      PREPARE axrt940_01_pr1 FROM l_sql
      DECLARE axrt940_01_cs1 CURSOR FOR axrt940_01_pr1
   
      #2類資料要根據1類的交易對象 幣別去抓原幣> 0(正)
      LET l_sql = "SELECT xrekdocno,xrekseq,xrek037,xrek103,xrek113,xrek123,xrek133 ",
                  "  FROM axrt940_01_tmp ",
                  " WHERE xrek009 = ? ",
                  "   AND xrek100 = ? ",
                  "   AND xrek004 NOT LIKE '2%' ",
                  "   AND xrek103 > 0 "
      IF g_glcb008 = '2' THEN
         LET l_sql = l_sql," ORDER BY xrek037 DESC"
      ELSE
          LET l_sql = l_sql," ORDER BY xrek037 "
      END IF
      PREPARE axrt940_01_pr2 FROM l_sql
      DECLARE axrt940_01_cs2 CURSOR FOR axrt940_01_pr2
      
      FOREACH axrt940_01_pr1 INTO l_xrek1.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.extend = 'FOREACH:axrt940_01_pr1'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH         
         END IF
         
         FOREACH axrt940_01_cs2 USING l_xrek1.xrek009,l_xrek1.xrek100 INTO l_xrek2.*
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.extend = 'FOREACH:axrt940_01_cs2'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH   
            END IF
            
            #判斷少的扣除
            IF l_xrek2.xrek103 > l_xrek1.xrek103 THEN
               LET l_xrek2.xrek103 = l_xrek2.xrek103 - l_xrek1.xrek103
               LET l_xrek1.xrek103 = l_xrek1.xrek103 - l_xrek1.xrek103
               LET l_xrek2.xrek113 = l_xrek2.xrek113 - l_xrek1.xrek113
               LET l_xrek1.xrek113 = l_xrek1.xrek113 - l_xrek1.xrek113
               LET l_xrek2.xrek123 = l_xrek2.xrek123 - l_xrek1.xrek123
               LET l_xrek1.xrek123 = l_xrek1.xrek123 - l_xrek1.xrek123
               LET l_xrek2.xrek133 = l_xrek2.xrek133 - l_xrek1.xrek133
               LET l_xrek1.xrek133 = l_xrek1.xrek133 - l_xrek1.xrek133               
            ELSE
               LET l_xrek2.xrek103 = l_xrek2.xrek103 - l_xrek2.xrek103
               LET l_xrek1.xrek103 = l_xrek1.xrek103 - l_xrek2.xrek103
               LET l_xrek2.xrek113 = l_xrek2.xrek113 - l_xrek2.xrek113
               LET l_xrek1.xrek113 = l_xrek1.xrek113 - l_xrek2.xrek113
               LET l_xrek2.xrek123 = l_xrek2.xrek123 - l_xrek2.xrek123
               LET l_xrek1.xrek123 = l_xrek1.xrek123 - l_xrek2.xrek123
               LET l_xrek2.xrek133 = l_xrek2.xrek133 - l_xrek2.xrek133
               LET l_xrek1.xrek133 = l_xrek1.xrek133 - l_xrek2.xrek133              
            END IF
            
            UPDATE axrt940_01_tmp SET xrek103 = l_xrek1.xrek103,
                                      xrek113 = l_xrek1.xrek113,
                                      xrek123 = l_xrek1.xrek123,
                                      xrek133 = l_xrek1.xrek133
             WHERE xrekseq = l_xrek1.xrekseq
               AND xrekdocno = l_xrek1.xrekdocno
               
            UPDATE axrt940_01_tmp SET xrek103 = l_xrek2.xrek103,
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
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM axrt940_01_tmp ",
   LET l_sql = "SELECT xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,xrek001,xrek002,xrek003,xrek004,xrek005,xrek006,",
               "xrek007,xrek008,xrek009,xrek010,xrek011,xrek012,xrek013,xrek014,xrek015,xrek016,xrek017,xrek018,",
               "xrek019,xrekorga,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,",
               "xrek030,xrek031,xrek032,xrek033,xrek034,xrek035,xrek036,xrek037,xrek038,xrek039,xrek040,xrek041,",
               "xrek100,xrek101,xrek103,xrek104,xrek105,xrek106,xrek107,xrek113,xrek114,xrek115,xrek116,xrek117,",
               "xrek121,xrek123,xrek124,xrek125,xrek126,xrek127,xrek131,xrek133,xrek134,xrek135,xrek136,xrek137 FROM axrt940_01_tmp ",
   #161128-00061#5---modify----end------------- 
               " WHERE xrek103 > 0 "
   PREPARE axrt940_01_pr3 FROM l_sql
   DECLARE axrt940_01_cs3 CURSOR FOR axrt940_01_pr3
   
   FOREACH axrt940_01_cs3 INTO l_xrek.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'FOREACH:axrt940_01_cs3'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
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

      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrek_t VALUES(l_xrek.*)
      INSERT INTO xrek_t (xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,xrek001,xrek002,xrek003,xrek004,
                          xrek005,xrek006,xrek007,xrek008,xrek009,xrek010,xrek011,xrek012,xrek013,xrek014,
                          xrek015,xrek016,xrek017,xrek018,xrek019,xrekorga,xrek020,xrek021,xrek022,xrek023,
                          xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,xrek030,xrek031,xrek032,xrek033,
                          xrek034,xrek035,xrek036,xrek037,xrek038,xrek039,xrek040,xrek041,xrek100,xrek101,
                          xrek103,xrek104,xrek105,xrek106,xrek107,xrek113,xrek114,xrek115,xrek116,xrek117,
                          xrek121,xrek123,xrek124,xrek125,xrek126,xrek127,xrek131,xrek133,xrek134,xrek135,
                          xrek136,xrek137)
       VALUES(l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,
              l_xrek.xrek005,l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,
              l_xrek.xrek015,l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,l_xrek.xrek020,l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,
              l_xrek.xrek024,l_xrek.xrek025,l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,l_xrek.xrek030,l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,
              l_xrek.xrek034,l_xrek.xrek035,l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,l_xrek.xrek040,l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,
              l_xrek.xrek103,l_xrek.xrek104,l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,l_xrek.xrek114,l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,
              l_xrek.xrek121,l_xrek.xrek123,l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,l_xrek.xrek131,l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,
              l_xrek.xrek136,l_xrek.xrek137)
      #161128-00061#5---modify----end------------- 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'insert xrek_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE      
      END IF
   END FOREACH
       
   #step 2 處理前期
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM xrek_t a ",
   LET l_sql = "SELECT xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,xrek001,xrek002,xrek003,xrek004,xrek005,xrek006,",
               "xrek007,xrek008,xrek009,xrek010,xrek011,xrek012,xrek013,xrek014,xrek015,xrek016,xrek017,xrek018,",
               "xrek019,xrekorga,xrek020,xrek021,xrek022,xrek023,xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,",
               "xrek030,xrek031,xrek032,xrek033,xrek034,xrek035,xrek036,xrek037,xrek038,xrek039,xrek040,xrek041,",
               "xrek100,xrek101,xrek103,xrek104,xrek105,xrek106,xrek107,xrek113,xrek114,xrek115,xrek116,xrek117,",
               "xrek121,xrek123,xrek124,xrek125,xrek126,xrek127,xrek131,xrek133,xrek134,xrek135,xrek136,xrek137 FROM xrek_t a ",
   #161128-00061#5---modify----end------------- 
               " WHERE a.xrekld = '",g_xrea_m.xreald,"' ",
               "   AND a.xrek001 = ",l_year," ",
               "   AND a.xrek002 = ",l_month," ",
               "   AND a.xrek003 = 'AR' ",
               "   AND a.xrekent = ",g_enterprise," ",
               "   AND NOT EXISTS(SELECT COUNT(*) FROM xrek_t b ",
               "                   WHERE b.xrek005 = a.xrek005 ",
               "                     AND b.xrekent = a.xrekent ",
               "                     AND b.xrek006 = a.xrek006 ",
               "                     AND b.xrek007 = a.xrek007 ",
               "                     AND b.xrekld  = a.xrekld ",
               "                     AND b.xrek003 = 'AR' ",
               "                     AND b.xrekdocno = '",l_xrej.xrejdocno,"' )"
   PREPARE axrt940_01_pr4 FROM l_sql
   DECLARE axrt940_01_cs4 CURSOR FOR axrt940_01_pr4
   
   FOREACH axrt940_01_cs4 INTO l_xrek.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'FOREACH:axrt940_01_cs4'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE 
      END IF
      
      #單號項次年度期別變更
      LET l_xrek.xrekdocno = l_xrej.xrejdocno
      LET l_xrek.xrek001   = g_xrea_m.xrea001
      LET l_xrek.xrek002   = g_xrea_m.xrea002
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
      
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrek_t VALUES(l_xrek.*)
      INSERT INTO xrek_t (xrekent,xrekcomp,xrekld,xrekdocno,xrekseq,xrek001,xrek002,xrek003,xrek004,
                          xrek005,xrek006,xrek007,xrek008,xrek009,xrek010,xrek011,xrek012,xrek013,xrek014,
                          xrek015,xrek016,xrek017,xrek018,xrek019,xrekorga,xrek020,xrek021,xrek022,xrek023,
                          xrek024,xrek025,xrek026,xrek027,xrek028,xrek029,xrek030,xrek031,xrek032,xrek033,
                          xrek034,xrek035,xrek036,xrek037,xrek038,xrek039,xrek040,xrek041,xrek100,xrek101,
                          xrek103,xrek104,xrek105,xrek106,xrek107,xrek113,xrek114,xrek115,xrek116,xrek117,
                          xrek121,xrek123,xrek124,xrek125,xrek126,xrek127,xrek131,xrek133,xrek134,xrek135,
                          xrek136,xrek137)
       VALUES(l_xrek.xrekent,l_xrek.xrekcomp,l_xrek.xrekld,l_xrek.xrekdocno,l_xrek.xrekseq,l_xrek.xrek001,l_xrek.xrek002,l_xrek.xrek003,l_xrek.xrek004,
              l_xrek.xrek005,l_xrek.xrek006,l_xrek.xrek007,l_xrek.xrek008,l_xrek.xrek009,l_xrek.xrek010,l_xrek.xrek011,l_xrek.xrek012,l_xrek.xrek013,l_xrek.xrek014,
              l_xrek.xrek015,l_xrek.xrek016,l_xrek.xrek017,l_xrek.xrek018,l_xrek.xrek019,l_xrek.xrekorga,l_xrek.xrek020,l_xrek.xrek021,l_xrek.xrek022,l_xrek.xrek023,
              l_xrek.xrek024,l_xrek.xrek025,l_xrek.xrek026,l_xrek.xrek027,l_xrek.xrek028,l_xrek.xrek029,l_xrek.xrek030,l_xrek.xrek031,l_xrek.xrek032,l_xrek.xrek033,
              l_xrek.xrek034,l_xrek.xrek035,l_xrek.xrek036,l_xrek.xrek037,l_xrek.xrek038,l_xrek.xrek039,l_xrek.xrek040,l_xrek.xrek041,l_xrek.xrek100,l_xrek.xrek101,
              l_xrek.xrek103,l_xrek.xrek104,l_xrek.xrek105,l_xrek.xrek106,l_xrek.xrek107,l_xrek.xrek113,l_xrek.xrek114,l_xrek.xrek115,l_xrek.xrek116,l_xrek.xrek117,
              l_xrek.xrek121,l_xrek.xrek123,l_xrek.xrek124,l_xrek.xrek125,l_xrek.xrek126,l_xrek.xrek127,l_xrek.xrek131,l_xrek.xrek133,l_xrek.xrek134,l_xrek.xrek135,
              l_xrek.xrek136,l_xrek.xrek137)
      #161128-00061#5---modify----end-------------
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'insert xrek_t'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
      END IF         
   END FOREACH
   #判斷是否產生單身資料,若無單身資料產生提示信息，刪除單頭資料
   SELECT COUNT(*) INTO l_cnt FROM xrek_t
   WHERE xrekent=g_enterprise AND xrekdocno=l_xrej.xrejdocno AND xrek003='AR'
   IF l_cnt=0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code = 'axr-00241'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
   END IF
   RETURN l_xrej.xrejdocno
END FUNCTION

################################################################################
# Descriptions...: 設置期別scc
# Memo...........:
# Usage..........: CALL axrt940_01_set_xrea002_scc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_set_xrea002_scc()
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glav003       LIKE glav_t.glav003
   
   SELECT DISTINCT glav003 INTO l_glav003 FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003
      AND glav002=g_xrea_m.xrea001 
   IF l_glav003='2' THEN
      CALL cl_set_combo_items('xrea002','1,2,3,4,5,6,7,8,9,10,11,12,13','1,2,3,4,5,6,7,8,9,10,11,12,13')
   ELSE
      CALL cl_set_combo_items('xrea002','1,2,3,4,5,6,7,8,9,10,11,12','1,2,3,4,5,6,7,8,9,10,11,12')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 通過客戶信評等級抓取壞帳提列比率（axri041 xraf_t）
# Memo...........:
# Usage..........: CALL axrt940_01_get_xrek039(p_comp,p_xrca004,p_xrek037)
# Modify.........: 
################################################################################
PRIVATE FUNCTION axrt940_01_get_xrek039(p_comp,p_xrca004,p_xrek037)
   DEFINE p_comp        LIKE ooef_t.ooef001
   DEFINE p_xrca004     LIKE xrca_t.xrca004
   DEFINE p_xrek037     LIKE xrek_t.xrek037
   DEFINE l_pmab004     LIKE pmab_t.pmab004
   DEFINE l_xrae002     LIKE xrae_t.xrae002
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xraf        RECORD LIKE xraf_t.*
   DEFINE l_xraf RECORD  #壞帳提列率依信評級設定檔
       xrafent LIKE xraf_t.xrafent, #企業編號
       xraf001 LIKE xraf_t.xraf001, #帳齡類型編號
       xraf002 LIKE xraf_t.xraf002, #信評等級
       xraf003 LIKE xraf_t.xraf003, #分段一壞帳提列率
       xraf004 LIKE xraf_t.xraf004, #分段二壞帳提列率
       xraf005 LIKE xraf_t.xraf005, #分段三壞帳提列率
       xraf006 LIKE xraf_t.xraf006, #分段四壞帳提列率
       xraf007 LIKE xraf_t.xraf007, #分段五壞帳提列率
       xraf008 LIKE xraf_t.xraf008, #分段六壞帳提列率
       xraf009 LIKE xraf_t.xraf009, #分段七壞帳提列率
       xraf010 LIKE xraf_t.xraf010, #分段八壞帳提列率
       xraf011 LIKE xraf_t.xraf011, #分段九壞帳提列率
       xraf012 LIKE xraf_t.xraf012, #分段十壞帳提列率
       xraf013 LIKE xraf_t.xraf013, #分段十一壞帳提列率
       xraf014 LIKE xraf_t.xraf014, #分段十二壞帳提列率
       xraf015 LIKE xraf_t.xraf015, #分段十三壞帳提列率
       xraf016 LIKE xraf_t.xraf016, #分段十四壞帳提列率
       xraf017 LIKE xraf_t.xraf017, #分段十五壞帳提列率
       xraf018 LIKE xraf_t.xraf018, #分段十六壞帳提列率
       xraf019 LIKE xraf_t.xraf019, #分段十七壞帳提列率
       xraf020 LIKE xraf_t.xraf020, #分段十八壞帳提列率
       xraf021 LIKE xraf_t.xraf021, #分段十九壞帳提列率
       xraf022 LIKE xraf_t.xraf022  #分段二十壞帳提列率
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE r_xrek039     LIKE xrek_t.xrek039
   
   # 信評等級
   SELECT pmab004 INTO l_pmab004 FROM pmab_t  
     WHERE pmabent=g_enterprise AND pmab001 = p_xrca004
       AND pmabsite=p_comp    
   # 分段序號
   SELECT xrae002 INTO l_xrae002 FROM xrae_t 
     WHERE xraeent = g_enterprise
       AND xrae001 = g_xrea_m.xrad001 #帳齡類型 
       AND xrae003 <= p_xrek037 #帳齡天數 >= 起始天數
       AND xrae004 >= p_xrek037 #帳齡天數 <= 截止天數
 
   #161128-00061#5---modify----begin------------- 
   #SELECT * INTO l_xraf.* 
   SELECT xrafent,xraf001,xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010,xraf011,
          xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022 INTO l_xraf.* 
   #161128-00061#5---modify----end------------- 
   FROM xraf_t 
    WHERE xrafent = g_enterprise
      AND xraf001 = g_xrea_m.xrad001 #帳齡類型 
      AND xraf002 = l_pmab004 # 信評等級
         
    CASE l_xrae002   # 分段序號
       WHEN 1  LET r_xrek039= l_xraf.xraf003 
       WHEN 2  LET r_xrek039= l_xraf.xraf004
       WHEN 3  LET r_xrek039= l_xraf.xraf005
       WHEN 4  LET r_xrek039= l_xraf.xraf006
       WHEN 5  LET r_xrek039= l_xraf.xraf007
       WHEN 6  LET r_xrek039= l_xraf.xraf008
       WHEN 7  LET r_xrek039= l_xraf.xraf009
       WHEN 8  LET r_xrek039= l_xraf.xraf010
       WHEN 9  LET r_xrek039= l_xraf.xraf011
       WHEN 10  LET r_xrek039= l_xraf.xraf012
       WHEN 11  LET r_xrek039= l_xraf.xraf013
       WHEN 12  LET r_xrek039= l_xraf.xraf014
       WHEN 13  LET r_xrek039= l_xraf.xraf015
       WHEN 14  LET r_xrek039= l_xraf.xraf016
       WHEN 15  LET r_xrek039= l_xraf.xraf017
       WHEN 16  LET r_xrek039= l_xraf.xraf018
       WHEN 17  LET r_xrek039= l_xraf.xraf019
       WHEN 18  LET r_xrek039= l_xraf.xraf020
       WHEN 19  LET r_xrek039= l_xraf.xraf021
       WHEN 20  LET r_xrek039= l_xraf.xraf022
       OTHERWISE  LET r_xrek039= 0 
   END CASE
   IF SQLCA.sqlcode = 100 THEN   
      # 分段序號
      SELECT xrae005 INTO r_xrek039 FROM xrae_t 
       WHERE xraeent = g_enterprise
         AND xrae001 = g_xrea_m.xrad001 #帳齡類型 
         AND xrae003 <= p_xrek037 #帳齡天數 >= 起始天數
         AND xrae004 >= p_xrek037 #帳齡天數 <= 截止天數
   END IF
   RETURN r_xrek039
END FUNCTION

################################################################################
# Descriptions...: 直接审核功能
# Memo...........:
# Usage..........: CALL axrt940_01_immediately_conf()
#                  RETURNING r_succesee
# Date & Author..: 2015/12/01 By aiqq
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_immediately_conf()
   DEFINE l_xreacomp        LIKE xrea_t.xreacomp
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE r_success         LIKE type_t.chr1
   DEFINE l_efin5001        LIKE type_t.chr1
   DEFINE l_ooba002         LIKE ooba_t.ooba002

   LET r_success = 'Y' 
   #無資料直接返回不做處理
   IF cl_null(g_xrea_m.xreald)  THEN 
      LET r_success='N'
      RETURN r_success
   END IF   
   
   LET l_xreacomp = null
   SELECT glaacomp INTO l_xreacomp FROM glaa_t 
                                  WHERE glaaent = g_enterprise 
                                    AND glaald =  g_xrea_m.xreald
   #無資料直接返回不做處理                                 
   IF cl_null(l_xreacomp)  THEN 
      LET r_success='N'
      RETURN r_success
   END IF
   #無資料直接返回不做處理   
   IF cl_null(g_xrea_m.docno_01) THEN 
      LET r_success='N'
      RETURN r_success
   END IF        
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   LET l_doc_success = TRUE 
   
   CALL s_aooi200_fin_get_slip(g_xrea_m.docno_01) RETURNING l_doc_success,l_ooba002                                    
   CALL s_fin_chk_E5001(g_xrea_m.xreald,l_xreacomp,l_ooba002) RETURNING l_efin5001
   
   IF l_efin5001 = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00346'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      LET r_success='N'
      RETURN r_success
   END IF 
   
   CALL s_axrt940_conf_chk(g_xrea_m.docno_01) RETURNING l_success 
   
   IF l_success = TRUE THEN
      CALL s_axrt940_conf_upd(g_xrea_m.docno_01) RETURNING l_success
      LET r_success = 'Y'
   ELSE
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show() 
      LET r_success='N'
      RETURN r_success
   END IF         
  
  #異動狀態碼欄位/修改人/修改日期
   UPDATE xrej_t SET xrejstus = 'Y',
                     xrejmodid= g_user
    WHERE xrejent = g_enterprise AND xrejld = g_xrea_m.xreald
      AND xrejdocno = g_xrea_m.docno_01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
  
   IF l_doc_success THEN
      CALL s_transaction_end('Y',1)
      LET r_success = 'Y'
   ELSE
      LET r_success = 'N'
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 審核完單據立即拋轉傳票
# Memo...........:
# Usage..........: CALL axrt940_01_immediately_gen()
# Date & Author..: 2015/12/01 By aiqq
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt940_01_immediately_gen()
   DEFINE l_xreacomp        LIKE xrea_t.xreacomp
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE l_prog            STRING 
   DEFINE ls_js             STRING
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_ooac004         LIKE ooac_t.ooac004
   DEFINE l_wc_t            STRING
   DEFINE l_glaa121         LIKE glaa_t.glaa121
   DEFINE l_success_t       LIKE type_t.num5
   DEFINE r_start_no        LIKE glap_t.glapdocno
   DEFINE r_end_no          LIKE glap_t.glapdocno   
   DEFINE l_s               LIKE type_t.chr1  
   DEFINE l_glca002         LIKE glca_t.glca002
   DEFINE l_xrea006         LIKE xrea_t.xrea006
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_xrea005         LIKE xrea_t.xrea005
  
   
   IF cl_null(g_xrea_m.xreald)    THEN RETURN END IF   #無資料直接返回不做處理
   
   LET l_xreacomp = null
   SELECT glaacomp INTO l_xreacomp FROM glaa_t 
                                  WHERE glaaent = g_enterprise 
                                    AND glaald =  g_xrea_m.xreald
                                    
   IF cl_null(l_xreacomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xrea_m.docno_01) THEN RETURN END IF   #無資料直接返回不做處理

    #取得單別
    CALL s_aooi200_fin_get_slip(g_xrea_m.docno_01) RETURNING l_success,l_slip
    LET l_glaa024 = NULL
    LET l_glaa121 = NULL
    SELECT glaa024,glaa121 INTO l_glaa024,l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrea_m.xreald
   
    SELECT ooac004 INTO l_ooac004 FROM ooac_t WHERE ooacent = g_enterprise
                                   AND ooac001 = l_glaa024
                                   AND ooac002 = l_slip
                                   AND ooac003 = 'D-FIN-2002'
    
    SELECT glca002 INTO l_glca002 FROM glca_t WHERE glcaent = g_enterprise AND glcald = g_xrea_m.xreald AND glca001 = 'AR'    
    IF l_glca002 = '2' THEN
       LET l_prog = 'aglt350'
    ELSE
       LET l_prog = 'aglt310'
    END IF
    
    IF NOT cl_null(l_ooac004) THEN 
       CALL s_transaction_begin()
       LET l_wc_t = "xrejdocno = '",l_ooac004,"'"
       
       IF l_prog = 'aglt350' THEN 
          LET g_prog = 'aglt350'
       END IF
       
       IF g_glaa121 = 'Y' THEN 
          LET l_wc_t = "glgbdocno = '",g_xrea_m.docno_01,"'"
          CALL s_pre_voucher_ins_glap('AR','R60',g_xrea_m.xreald,g_xrea_m.xrejdocdt,l_ooac004,'1',l_wc_t) 
          RETURNING r_success,r_start_no,r_end_no
       ELSE
          LET l_wc_t = "xrejdocno = '",g_xrea_m.docno_01,"'"
          CALL s_axrt940_gen_ar('4',g_xrea_m.xreald,g_xrea_m.xrejdocdt,l_ooac004,1,l_wc_t,'N') 
          RETURNING r_success,r_start_no,r_end_no
       END IF
       
       LET g_prog = 'axrt940' 
       
       IF r_success = TRUE AND NOT cl_null(r_start_no) THEN
          UPDATE xrej_t SET xrej005=r_start_no 
                      WHERE xrejent=g_enterprise 
                        AND xrejdocno=g_xrea_m.docno_01
                        
          IF SQLCA.SQLCODE THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "update xrej_t"
             LET g_errparam.code   = SQLCA.SQLCODE
             LET g_errparam.popup  = TRUE      
             CALL cl_err()
             LET r_success = FALSE 
          END IF 
       END IF
       
    ELSE 
    
        CALL axrt940_02(g_xrea_m.xreald,l_xreacomp,g_xrea_m.docno_01,'1') RETURNING l_xrea005
        
    END IF
    
    IF NOT cl_null(l_xrea005) THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = g_xrea_m.docno_01
       LET g_errparam.code   = "axr-00119"
       LET g_errparam.popup  = FALSE      
       CALL cl_err()    
    ELSE 
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = g_xrea_m.docno_01
       LET g_errparam.code   = "axr-00120"
       LET g_errparam.popup  = FALSE      
       CALL cl_err()    
       LET l_xrea005=''
    END IF
    #當未拋轉傳票時，‘傳票還原’action灰掉
    IF cl_null(l_xrea005) THEN 
       CALL cl_set_act_visible('un_voucher',FALSE)
       CALL cl_set_act_visible('open_axrt940_02',TRUE)
    ELSE
       CALL cl_set_act_visible('un_voucher',TRUE)
       CALL cl_set_act_visible('open_axrt940_02',FALSE)
    END IF
    
END FUNCTION

 
{</section>}
 
