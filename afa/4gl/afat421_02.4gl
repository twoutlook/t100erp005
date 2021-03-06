#該程式未解開Section, 採用最新樣板產出!
{<section id="afat421_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-08-25 17:48:00), PR版次:0004(2016-11-23 10:35:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: afat421_02
#+ Description: 拋轉產生資產科目異動資料
#+ Creator....: 02599(2015-08-21 16:46:23)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="afat421_02.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#add-point:註解編寫項目
#151125-00006#1  2015/12/13 by 06862  生成单据后立即审核
#160318-00025#6  2016/04/18 By 07675  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161111-00028#7  2016/11/23 by 02481  标准程式定义采用宣告模式,弃用.*写法
#end add-point
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master              RECORD
       fabgsite              LIKE fabg_t.fabgsite,
       fabgsite_desc         LIKE ooefl_t.ooefl003,
       fabgld                LIKE fabg_t.fabgld,
       fabgld_desc           LIKE glaal_t.glaal002,
       fabgdocno             LIKE fabg_t.fabgdocno,
       fabgdocdt             LIKE fabg_t.fabgdocdt,
       fabg005               LIKE fabg_t.fabg005,
       fabg001               LIKE fabg_t.fabg001,
       fabg001_desc          LIKE ooag_t.ooag011
       END RECORD
DEFINE g_glaacomp            LIKE glaa_t.glaacomp
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_bookno              LIKE glaa_t.glaald
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="afat421_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat421_02(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE l_para_data     LIKE fabg_t.fabgdocdt
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_origin_str    STRING   #組織範圍
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat421_02 WITH FORM cl_ap_formpath("afa","afat421_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET INT_FLAG = FALSE
   CALL cl_set_combo_scc_part('fabg005','9910','31')
   INITIALIZE g_master.* TO NULL
   CALL s_afat503_default(g_bookno) RETURNING l_success,g_master.fabgsite,g_master.fabgld,g_glaacomp
   CALL s_desc_get_department_desc(g_master.fabgsite) RETURNING g_master.fabgsite_desc
   CALL s_desc_get_ld_desc(g_master.fabgld) RETURNING g_master.fabgld_desc
   #账务人员 
   IF cl_null(g_master.fabgsite) THEN
      LET g_master.fabg001 = NULL
   ELSE
      LET g_master.fabg001 = g_user
      IF NOT s_afat502_site_user_chk(g_master.fabgsite,g_master.fabg001) THEN 
         LET g_master.fabg001 = NULL
      END IF 
   END IF
   CALL s_desc_get_person_desc(g_master.fabg001) RETURNING g_master.fabg001_desc
   #單據日期
   LET g_master.fabgdocdt = g_today
   LET g_master.fabg005 = '31'
   DISPLAY BY NAME g_master.fabgld,g_master.fabgld_desc,g_master.fabgdocdt,g_master.fabg005,
                   g_master.fabg001,g_master.fabg001_desc,g_master.fabgsite,g_master.fabgsite_desc
   IF NOT cl_null(g_master.fabgld) THEN
      SELECT glaa001,glaa004,glaa024 INTO g_glaa001,g_glaa004,g_glaa024 FROM glaa_t 
      WHERE glaaent=g_enterprise AND glaald=g_master.fabgld
   END IF
   
   WHILE TRUE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON fabadocno,fabb001,fabb002,fabb000,fabb015,fabb017,fabb021 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"

         ON ACTION controlp INFIELD fabadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " faba003 = '27' AND fabastus='Y' "
			   IF NOT cl_null(g_master.fabgsite) THEN
			      LET g_qryparam.where = g_qryparam.where," AND fabasite = '",g_master.fabgsite,"'"
			   END IF
            CALL q_fabadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabadocno  #顯示到畫面上

            NEXT FIELD fabadocno
        
         ON ACTION controlp INFIELD fabb001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabb001  #顯示到畫面上
            NEXT FIELD fabb001
            
         ON ACTION controlp INFIELD fabb002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO fabb002  #顯示到畫面上
            NEXT FIELD fabb002
            
         ON ACTION controlp INFIELD fabb000
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return3 TO fabb000  #顯示到畫面上
            NEXT FIELD fabb000
            
        ON ACTION controlp INFIELD fabb015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003<>'1'"
            IF NOT cl_null(g_glaa004) THEN
               LET g_qryparam.where = g_qryparam.where," AND glac001 = '",g_glaa004,"'"
            END IF
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabb015  #顯示到畫面上
            NEXT FIELD fabb015
            
         ON ACTION controlp INFIELD fabb017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003<>'1'"
            IF NOT cl_null(g_glaa004) THEN
               LET g_qryparam.where = g_qryparam.where," AND glac001 = '",g_glaa004,"'"
            END IF
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabb017  #顯示到畫面上
            NEXT FIELD fabb017
            
         ON ACTION controlp INFIELD fabb021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003<>'1'"
            IF NOT cl_null(g_glaa004) THEN
               LET g_qryparam.where = g_qryparam.where," AND glac001 = '",g_glaa004,"'"
            END IF
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabb021  #顯示到畫面上
            NEXT FIELD fabb021
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      INPUT BY NAME g_master.fabgsite,g_master.fabgsite_desc,g_master.fabgld,g_master.fabgld_desc,g_master.fabgdocno,
                    g_master.fabgdocdt,g_master.fabg005,g_master.fabg001,g_master.fabg001_desc
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL cl_get_para(g_enterprise,g_site,'S-FIN-9003') RETURNING l_para_data
         
         AFTER FIELD fabgsite
            IF NOT cl_null(g_master.fabgsite) THEN
               #检查组织资料的合理性             
               IF NOT s_afat502_site_chk(g_master.fabgsite) THEN
                  LET g_master.fabgsite = ''
                  LET g_master.fabgsite_desc = ''
                  DISPLAY BY NAME g_master.fabgsite_desc
                  NEXT FIELD CURRENT
               END IF 
               #帳務人員不為空需要檢查和資產中心的權限
               IF NOT cl_null(g_master.fabg001) THEN
                  IF NOT s_afat502_site_user_chk(g_master.fabgsite,g_master.fabg001) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.fabgsite
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_master.fabgsite = ''
                     LET g_master.fabgsite_desc = ''
                     DISPLAY BY NAME g_master.fabgsite_desc
                     NEXT FIELD CURRENT  
                  END IF
               END IF   
               #帐套不为空检查法人归属是否相同
               IF NOT cl_null(g_master.fabgld) THEN
                  IF NOT s_afat502_site_ld_chk(g_master.fabgsite,g_master.fabgld) THEN
                     LET g_master.fabgsite = ''
                     LET g_master.fabgsite_desc = ''
                     DISPLAY BY NAME g_master.fabgsite_desc
                     NEXT FIELD CURRENT  
                  END IF
               END IF 
            END IF
            CALL s_desc_get_department_desc(g_master.fabgsite) RETURNING g_master.fabgsite_desc
            DISPLAY BY NAME g_master.fabgsite_desc
            
         AFTER FIELD fabgld
            IF NOT cl_null(g_master.fabgld) THEN  
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master.fabgld
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fabgld") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.fabgld = ''
                  LET g_master.fabgld_desc = ''
                  DISPLAY BY NAME g_master.fabgld_desc
                  NEXT FIELD CURRENT
               END IF
               #帐套不为空检查法人归属是否相同
               IF NOT cl_null(g_master.fabgsite) THEN
                  IF NOT s_afat502_site_ld_chk(g_master.fabgsite,g_master.fabgld) THEN
                     LET g_master.fabgld = ''
                     LET g_master.fabgld_desc = ''
                     DISPLAY BY NAME g_master.fabgld_desc
                     NEXT FIELD CURRENT  
                  END IF
               END IF
               #帐套人员不为空时
               IF NOT cl_null(g_master.fabg001) THEN
                  IF NOT s_ld_chk_authorization(g_master.fabg001,g_master.fabgld) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_master.fabgld
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_master.fabgld = ''
                     LET g_master.fabgld_desc = ''
                     DISPLAY BY NAME g_master.fabgld_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            SELECT glaacomp,glaa001,glaa004,glaa024 
              INTO g_glaacomp,g_glaa001,g_glaa004,g_glaa024 
              FROM glaa_t 
             WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
            CALL s_desc_get_ld_desc(g_master.fabgld) RETURNING g_master.fabgld_desc
            DISPLAY BY NAME g_master.fabgld_desc
         
         AFTER FIELD fabgdocno
            #確認資料無重複
            IF NOT cl_null(g_master.fabgdocno) THEN 
               IF NOT s_aooi200_fin_chk_slip(g_master.fabgld,g_glaa024,g_master.fabgdocno,'afat521') THEN
                  LET g_master.fabgdocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD fabgdocdt
            IF NOT cl_null(g_master.fabgdocdt) THEN
               IF NOT cl_null(l_para_data) AND g_master.fabgdocdt<=l_para_data THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "afa-00060"
                  LET g_errparam.extend = g_master.fabgdocdt
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  
                  LET g_master.fabgdocdt = g_today
                  NEXT FIELD fabgdocdt
               END IF
               #现行年月检查
               CALL cl_get_para(g_enterprise,g_glaacomp,'S-FIN-9018') RETURNING l_year
               CALL cl_get_para(g_enterprise,g_glaacomp,'S-FIN-9019') RETURNING l_month
               IF l_year <> YEAR(g_master.fabgdocdt) OR l_month <> MONTH(g_master.fabgdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00283'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.fabgdocdt = g_today
                  NEXT FIELD fabgdocdt
               END IF
            END IF
            
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001
            IF NOT cl_null(g_master.fabg001) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master.fabg001
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#6--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #帳套不為空時
                  IF NOT cl_null(g_master.fabgld) THEN
                     IF NOT s_ld_chk_authorization(g_master.fabg001,g_master.fabgld) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axr-00022'     
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err() 
                        LET g_master.fabg001 = ''
                        LET g_master.fabg001_desc = ''
                        DISPLAY BY NAME g_master.fabg001_desc
                        NEXT FIELD CURRENT
                     END IF  
                  END IF
                  #資產中心不為空的情況下
                  IF NOT cl_null(g_master.fabgsite) THEN 
                     IF NOT s_afat502_site_user_chk(g_master.fabgsite,g_master.fabg001) THEN
                        LET g_master.fabg001 = ''
                        LET g_master.fabg001_desc = ''
                        DISPLAY BY NAME g_master.fabg001_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.fabg001 = ''
                  LET g_master.fabg001_desc = ''
                  DISPLAY BY NAME g_master.fabg001_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_master.fabg001) RETURNING g_master.fabg001_desc
            DISPLAY BY NAME g_master.fabg001_desc

         ON ACTION controlp INFIELD fabgsite
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.fabgsite             #給予default值
            LET g_qryparam.where = " ooef207 = 'Y' "
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooef001()                               #呼叫開窗
            LET g_master.fabgsite = g_qryparam.return1  
            DISPLAY g_master.fabgsite TO fabgsite              #
            CALL s_desc_get_department_desc(g_master.fabgsite) RETURNING g_master.fabgsite_desc
            DISPLAY BY NAME g_master.fabgsite_desc
            NEXT FIELD fabgsite    

         
         ON ACTION controlp INFIELD fabgld  
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.fabgld             #給予default值
            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_master.fabgsite,g_master.fabgdocdt,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
 
            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.fabgld = g_qryparam.return1              

            DISPLAY g_master.fabgld TO fabgld              #
            CALL s_desc_get_ld_desc(g_master.fabgld) RETURNING g_master.fabgld_desc
            DISPLAY BY NAME g_master.fabgld_desc
            NEXT FIELD fabgld
         
         ON ACTION controlp INFIELD fabgdocno
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.fabgdocno             #給予default值
            #給予arg 
            SELECT glaa024 INTO g_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld   
            LET g_qryparam.arg1 = g_glaa024 #
            LET g_qryparam.arg2 = "afat521" #
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_master.fabgdocno = g_qryparam.return1 
            DISPLAY g_master.fabgdocno TO fabgdocno
            NEXT FIELD fabgdocno 

         ON ACTION controlp INFIELD fabg001
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.fabg001             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooag001_8()                                #呼叫開窗
            LET g_master.fabg001 = g_qryparam.return1 
            DISPLAY g_master.fabg001 TO fabg001              #
            CALL s_desc_get_person_desc(g_master.fabg001) RETURNING g_master.fabg001_desc
            DISPLAY BY NAME g_master.fabg001_desc
            NEXT FIELD fabg001
            
            
         AFTER INPUT
      END INPUT
      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
      IF NOT INT_FLAG THEN
         CALL afat421_02_p() RETURNING l_success
         CONTINUE WHILE
      ELSE
         EXIT WHILE
      END IF
   END WHILE
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_afat421_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat421_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat421_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: afat421_02_immediately_conf(p_fabgdocno,p_fabgcomp,p_fabgld,p_fabgdocdt)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afat421_02_immediately_conf(p_fabgdocno,p_fabgcomp,p_fabgld,p_fabgdocdt)
   DEFINE p_fabgcomp        LIKE faba_t.fabacomp
   DEFINE p_fabgdocno       LIKE faba_t.fabadocno
   DEFINE p_fabgld          LIKE fabg_t.fabgld
   DEFINE p_fabgdocdt       LIKE faba_t.fabadocdt
   DEFINE l_moddt           LIKE faba_t.fabamoddt
   DEFINE l_cnfdt           LIKE faba_t.fabacnfdt
   DEFINE l_success         LIKE type_t.num5
   #161111-00028#7---modify----begin--------- 
  #DEFINE l_glaa            RECORD LIKE glaa_t.*   
   DEFINE l_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
   #161111-00028#3---modify----end---------
   
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_n               LIKE type_t.num5
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_colname         STRING
   DEFINE l_comment         STRING
   DEFINE l_table           LIKE type_t.chr10
   DEFINE l_table000        LIKE type_t.chr20
   DEFINE l_table001        LIKE type_t.chr20
   DEFINE l_table002        LIKE type_t.chr20
   DEFINE l_glgbdocno       LIKE glgb_t.glgbdocno
   DEFINE l_glgbseq         LIKE glgb_t.glgbseq
   DEFINE l_sql             STRING
   DEFINE l_today           DATETIME YEAR TO SECOND
   DEFINE l_glgb003         LIKE glgb_t.glgb003
   DEFINE l_fabh010         LIKE fabh_t.fabh010
   DEFINE l_glaa121         LIKE glaa_t.glaa121
   
   LET r_success = TRUE 
   IF cl_null(p_fabgdocno) THEN RETURN r_success = FALSE END IF   #無資料直接返回不做處理
    
   #获取法人账套 
   #161111-00028#3---MODIFY----begin---------
   #SELECT * INTO l_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
           glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,
           glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,
           glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,
           glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO l_glaa.*
   #161111-00028#3---MODIFY----end---------
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_fabgcomp
      AND glaa014 = 'Y'
  
   LET l_success = TRUE
   
   CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
   LET g_coll_title[1] = l_colname
   CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
   LET g_coll_title[2] = l_colname
   CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
   LET g_coll_title[3] = l_colname
   
   CALL s_afa_p_faan_chk(p_fabgld,p_fabgdocno,p_fabgdocdt,'fabh_t','fabh000','fabh001','fabh002') RETURNING l_success
   IF l_success = FALSE THEN 
      LET r_success = FALSE
   END IF
   
   CALL s_afat503_conf_chk_fabg(p_fabgld,p_fabgdocno) RETURNING l_success
   IF l_success = TRUE THEN
      #add by yangxf ---如果启用分录底稿，需要判断借方金额总和是否等于折旧单身折旧金额总和
      IF l_glaa.glaa121 = 'Y' THEN
         #检查汇率为1，但是借/贷金额不等于原币金额的资料
         LET l_sql = "SELECT a.glgbdocno,a.glgbseq ",
                     "  FROM glgb_t a,glgb_t b ",
                     " WHERE a.glgbdocno = b.glgbdocno ",
                     "   AND a.glgbld = b.glgbld ",
                     "   AND a.glgbseq = b.glgbseq ",
                     "   AND a.glgb100 = b.glgb100 ",
                     "   AND a.glgb101 = b.glgb101 ",
                     "   AND a.glgbent = b.glgbent ",
                     "   AND a.glgb006 = 1 ",
                     "   AND a.glgbdocno = '",p_fabgdocno,"'",
                     "   AND a.glgbent = '",g_enterprise,"'",
                     "   AND a.glgbld = '",p_fabgld,"'",
                     "   AND ((a.glgb003 <> b.glgb010 AND a.glgb003 > 0) ",
                     "    OR (a.glgb004 <> b.glgb010 AND a.glgb004 > 0))" 
         PREPARE sel_glgb FROM l_sql
         DECLARE sel_glgb_cs CURSOR FOR sel_glgb
         LET l_n = 0
         FOREACH sel_glgb_cs INTO l_glgbdocno,l_glgbseq
            IF STATUS THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "sel_glgb_cs"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = FALSE
               CALL cl_err()         
            END IF 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00455'
            LET g_errparam.extend = ''
            LET g_errparam.replace[1] = l_glgbdocno
            LET g_errparam.replace[2] = l_glgbseq
            LET g_errparam.sqlerr = 0
            CALL cl_err()
            LET r_success = FALSE
            LET l_n = l_n + 1
         END FOREACH 
         IF l_n > 0 THEN 
            LET r_success = FALSE
         END IF 
      END IF
      #add by yangxf ---
      CALL s_afat503_conf_upd_fabg(p_fabgld,p_fabgdocno) RETURNING l_success 
      
   END IF 
   
   IF l_success = TRUE THEN 
       LET l_today  = cl_get_current()
       #检查完毕，更新狀態碼=已確認,確認人=登入user,確認日期=g_today
       UPDATE fabg_t SET fabgstus = 'Y',
                         fabgcnfid = g_user,
                         fabgcnfdt = l_today
                   WHERE fabgent = g_enterprise
                     AND fabgdocno = p_fabgdocno
        IF SQLCA.SQLCODE THEN
           LET l_success = FALSE
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = 'fabgstus'||p_fabgdocno
           LET g_errparam.popup = TRUE
           CALL cl_err()            
        END IF                
    END IF 
    
    IF l_success = FALSE THEN 
       LET r_success = FALSE 
    END IF
   
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 产生科目异动资料
# Memo...........:
# Usage..........: CALL afat421_02_p()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afat421_02_p()
   DEFINE r_success                LIKE type_t.num5
   DEFINE l_sql                    STRING
   #161111-00028#7---modify--begin-----------
   #DEFINE l_fabg                   RECORD LIKE fabg_t.*
   #DEFINE l_fabh                   RECORD LIKE fabh_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabg020 LIKE fabg_t.fabg020  #資產性質
       END RECORD
   DEFINE l_fabh RECORD  #資產異動單身檔
       fabhent LIKE fabh_t.fabhent, #企業編號
       fabhld LIKE fabh_t.fabhld, #帳套
       fabhsite LIKE fabh_t.fabhsite, #營運據點
       fabhdocno LIKE fabh_t.fabhdocno, #異動單號
       fabhseq LIKE fabh_t.fabhseq, #項次
       fabh000 LIKE fabh_t.fabh000, #卡片編號
       fabh001 LIKE fabh_t.fabh001, #財產編號
       fabh002 LIKE fabh_t.fabh002, #附號
       fabh003 LIKE fabh_t.fabh003, #資產狀態
       fabh004 LIKE fabh_t.fabh004, #未折減餘額
       fabh005 LIKE fabh_t.fabh005, #單位
       fabh006 LIKE fabh_t.fabh006, #數量
       fabh007 LIKE fabh_t.fabh007, #處置數量
       fabh008 LIKE fabh_t.fabh008, #成本
       fabh009 LIKE fabh_t.fabh009, #累計調整成本
       fabh010 LIKE fabh_t.fabh010, #調整成本/公允價值
       fabh011 LIKE fabh_t.fabh011, #累折
       fabh012 LIKE fabh_t.fabh012, #重估累計折舊
       fabh013 LIKE fabh_t.fabh013, #未用年限
       fabh014 LIKE fabh_t.fabh014, #重估未用年限
       fabh015 LIKE fabh_t.fabh015, #預留殘值
       fabh016 LIKE fabh_t.fabh016, #重估預留殘值
       fabh017 LIKE fabh_t.fabh017, #已計提減值準備
       fabh018 LIKE fabh_t.fabh018, #異動
       fabh019 LIKE fabh_t.fabh019, #減值準備金額
       fabh020 LIKE fabh_t.fabh020, #異動原因
       fabh021 LIKE fabh_t.fabh021, #異動科目
       fabh022 LIKE fabh_t.fabh022, #調整成本
       fabh023 LIKE fabh_t.fabh023, #累計折舊科目
       fabh024 LIKE fabh_t.fabh024, #資產科目
       fabh025 LIKE fabh_t.fabh025, #減值準備科目
       fabh026 LIKE fabh_t.fabh026, #營運據點
       fabh027 LIKE fabh_t.fabh027, #部門
       fabh028 LIKE fabh_t.fabh028, #利潤/成本中心
       fabh029 LIKE fabh_t.fabh029, #區域
       fabh030 LIKE fabh_t.fabh030, #交易客商
       fabh031 LIKE fabh_t.fabh031, #帳款客商
       fabh032 LIKE fabh_t.fabh032, #客群
       fabh033 LIKE fabh_t.fabh033, #人員
       fabh034 LIKE fabh_t.fabh034, #專案編號
       fabh035 LIKE fabh_t.fabh035, #WBS
       fabh036 LIKE fabh_t.fabh036, #摘要
       fabh037 LIKE fabh_t.fabh037, #來源編號
       fabh038 LIKE fabh_t.fabh038, #來源項次
       fabh039 LIKE fabh_t.fabh039, #盤點編號
       fabh040 LIKE fabh_t.fabh040, #盤點序號
       fabh041 LIKE fabh_t.fabh041, #經營方式
       fabh042 LIKE fabh_t.fabh042, #通路
       fabh043 LIKE fabh_t.fabh043, #品牌
       fabh060 LIKE fabh_t.fabh060, #自由核算項一
       fabh061 LIKE fabh_t.fabh061, #自由核算項二
       fabh062 LIKE fabh_t.fabh062, #自由核算項三
       fabh063 LIKE fabh_t.fabh063, #自由核算項四
       fabh064 LIKE fabh_t.fabh064, #自由核算項五
       fabh065 LIKE fabh_t.fabh065, #自由核算項六
       fabh066 LIKE fabh_t.fabh066, #自由核算項七
       fabh067 LIKE fabh_t.fabh067, #自由核算項八
       fabh068 LIKE fabh_t.fabh068, #自由核算項九
       fabh069 LIKE fabh_t.fabh069, #自由核算項十
       fabh100 LIKE fabh_t.fabh100, #本位幣二幣別
       fabh101 LIKE fabh_t.fabh101, #本位幣二匯率
       fabh102 LIKE fabh_t.fabh102, #本位幣二成本
       fabh103 LIKE fabh_t.fabh103, #本位幣二調整成本
       fabh104 LIKE fabh_t.fabh104, #本位幣二累折
       fabh105 LIKE fabh_t.fabh105, #本位幣二重估累折
       fabh106 LIKE fabh_t.fabh106, #本位幣二預留殘值
       fabh107 LIKE fabh_t.fabh107, #本位幣二重估殘值
       fabh108 LIKE fabh_t.fabh108, #本位幣二未折減額
       fabh109 LIKE fabh_t.fabh109, #本位幣二已計提減值準備
       fabh110 LIKE fabh_t.fabh110, #本位幣二減值準備金額
       fabh150 LIKE fabh_t.fabh150, #本位幣三幣別
       fabh151 LIKE fabh_t.fabh151, #本位幣三匯率
       fabh152 LIKE fabh_t.fabh152, #本位幣三成本
       fabh153 LIKE fabh_t.fabh153, #本位幣三調整成本
       fabh154 LIKE fabh_t.fabh154, #本位幣三累折
       fabh155 LIKE fabh_t.fabh155, #本位幣三重估累折
       fabh156 LIKE fabh_t.fabh156, #本位幣三預留殘值
       fabh157 LIKE fabh_t.fabh157, #本位幣三重估殘值
       fabh158 LIKE fabh_t.fabh158, #本位幣三未折減額
       fabh159 LIKE fabh_t.fabh159, #本位幣三已計提減值準備
       fabh160 LIKE fabh_t.fabh160, #本位幣三減值準備金額
       fabh070 LIKE fabh_t.fabh070, #累計折舊科目(舊)
       fabh071 LIKE fabh_t.fabh071, #資產科目(舊)
       fabh072 LIKE fabh_t.fabh072, #減值準備科目(舊)
       fabh073 LIKE fabh_t.fabh073, #處置本年累折
       fabh111 LIKE fabh_t.fabh111, #本位幣二處置本年累折
       fabh161 LIKE fabh_t.fabh161, #本位幣三處置本年累折
       fabh074 LIKE fabh_t.fabh074, #保險費用科目
       fabh075 LIKE fabh_t.fabh075, #主要類別
       fabh076 LIKE fabh_t.fabh076  #主要類別新
       END RECORD
   #161111-00028#7---modify--end-----------
   DEFINE l_success                LIKE type_t.num5
   DEFINE l_seq                    LIKE type_t.num5
   DEFINE l_cnt                    LIKE type_t.num5
   #151125-00006#1-add-s
   DEFINE  l_ooba002               LIKE ooba_t.ooba002
   DEFINE  l_dfin0031              LIKE type_t.chr1
   DEFINE  l_dfin0032              LIKE type_t.chr1
   DEFINE  l_fabgstus              LIKE fabg_t.fabgstus
   DEFINE  l_fabg008               LIKE fabg_t.fabg008
   DEFINE  l_conf_success          LIKE type_t.num5
   #151125-00006#1-add-e
   
   LET r_success = TRUE
   CALL cl_err_collect_init()
   CALL afap280_01_cre_fa_tmp_table() RETURNING l_success  #151125-0006#1---add by aiqq
   CALL s_transaction_begin()
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
               #财产编号/附号/卡片编号/资产科目/累折科目/减值准备科目
   LET l_sql = " SELECT fabb001,fabb002,fabb000,fabb015,fabb017,fabb021,",
               #旧资产科目/旧累折科目/旧减值准备科目
               "        fabb014,fabb016,fabb020,",
               #异动原因码/部门/人员/单据编号/项次
               "        fabb022,fabb003,fabb004,fabbdocno,fabbseq",
               "   FROM faba_t,fabb_t",
               "  WHERE fabaent=fabbent AND fabadocno=fabbdocno",
               "    AND fabaent=",g_enterprise,
               "    AND fabasite='",g_master.fabgsite,"'",
               "    AND fabacomp='",g_glaacomp,"'",
               "    AND (fabb014<>fabb015 OR fabb016<>fabb017 OR fabb020<>fabb021)",
               "    AND fabbdocno||fabbseq NOT IN (SELECT fabh037||fabh038 FROM fabh_t,fabg_t",
               "                                    WHERE fabhent=fabgent AND fabhld=fabgld AND fabhdocno=fabgdocno",
               "                                      AND fabgent=",g_enterprise," AND fabgld='",g_master.fabgld,"'",
               "                                      AND fabg005='31' AND fabh037 IS NOT NULL AND fabh038 IS NOT NULL AND fabgstus<>'X' )",
               "    AND fabastus='Y'",
               "    AND faba003='27'",
               "    AND ",g_wc
   PREPARE afat421_02_pr FROM l_sql
   DECLARE afat421_02_cs CURSOR FOR afat421_02_pr
   
   INITIALIZE l_fabg.* TO NULL
   LET l_fabg.fabgent=g_enterprise
   LET l_fabg.fabgsite=g_master.fabgsite
   LET l_fabg.fabg001=g_master.fabg001
   LET l_fabg.fabgld=g_master.fabgld
   LET l_fabg.fabgcomp=g_glaacomp
   LET l_fabg.fabg005=g_master.fabg005
   LET l_fabg.fabgdocdt=g_master.fabgdocdt
   CALL s_aooi200_fin_gen_docno(l_fabg.fabgld,'','',g_master.fabgdocno,l_fabg.fabgdocdt,'afat521')
   RETURNING l_success,l_fabg.fabgdocno
   IF l_success=FALSE  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_fabg.fabgdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN r_success
   END IF
   #申請人員、部門、時間
   LET l_fabg.fabg002=g_user
   LET l_fabg.fabg003=g_dept 
   LET l_fabg.fabg004=g_today
   #幣別、匯率
   LET l_fabg.fabg015=g_glaa001
   LET l_fabg.fabg016=1
   LET l_fabg.fabgownid = g_user
   LET l_fabg.fabgowndp = g_dept
   LET l_fabg.fabgcrtid = g_user
   LET l_fabg.fabgcrtdp = g_dept 
   LET l_fabg.fabgcrtdt = cl_get_current()
   LET l_fabg.fabgstus = 'N'
   INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabgcomp,
                      fabg002,fabg003,fabg004,fabgdocno,fabgdocdt,
                      fabg005,fabg006,fabg007,fabg015,fabg016,
                      fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,
                      fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,
                      fabgpstid,fabgpstdt)
   VALUES (g_enterprise,l_fabg.fabgsite,l_fabg.fabg001,l_fabg.fabgld,l_fabg.fabgcomp, 
           l_fabg.fabg002,l_fabg.fabg003,l_fabg.fabg004,l_fabg.fabgdocno,l_fabg.fabgdocdt, 
           l_fabg.fabg005,l_fabg.fabg006,l_fabg.fabg007,l_fabg.fabg015,l_fabg.fabg016, 
           l_fabg.fabgstus,l_fabg.fabgownid,l_fabg.fabgowndp,l_fabg.fabgcrtid,l_fabg.fabgcrtdp, 
           l_fabg.fabgcrtdt,l_fabg.fabgmodid,l_fabg.fabgmoddt,l_fabg.fabgcnfid,l_fabg.fabgcnfdt, 
           l_fabg.fabgpstid,l_fabg.fabgpstdt) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins fabg_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN r_success
   END IF
   INITIALIZE l_fabh.* TO NULL
   LET l_fabh.fabhent=g_enterprise
   LET l_fabh.fabhld=l_fabg.fabgld
   LET l_fabh.fabhsite=l_fabg.fabgsite
   LET l_fabh.fabhdocno=l_fabg.fabgdocno
   LET l_seq=1
   FOREACH afat421_02_cs INTO l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh000,l_fabh.fabh024,l_fabh.fabh023,
                              l_fabh.fabh025,l_fabh.fabh071,l_fabh.fabh070,l_fabh.fabh072,l_fabh.fabh020,
                              l_fabh.fabh027,l_fabh.fabh033,l_fabh.fabh037,l_fabh.fabh038
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH afat421_02_cs " 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #当财产编号+附号+卡号存在于afat521中未审核或者审核的单据中，不在产生到afat521中
      SELECT COUNT(*) INTO l_cnt 
        FROM fabh_t,fabg_t
       WHERE fabhent=fabgent AND fabhld=fabgld AND fabhdocno=fabgdocno
         AND fabhent = g_enterprise
         AND fabhld = l_fabh.fabhld
         AND fabh001 = l_fabh.fabh001 
         AND fabh002 = l_fabh.fabh002
         AND fabh000 = l_fabh.fabh000
         AND fabg005 = '31'
         AND fabgstus IN ('N','S')
      IF l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_fabh.fabhseq=l_seq
      #成本、累折、已計提減值金額和科目   
      SELECT faaj016,faaj017,faaj021,
             faaj101,faaj102,faaj103,faaj104,faaj112,
             faaj151,faaj152,faaj153,faaj154,faaj162
        INTO l_fabh.fabh008,l_fabh.fabh011,l_fabh.fabh017,
             l_fabh.fabh100,l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh104,l_fabh.fabh109,
             l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh154,l_fabh.fabh159
        FROM faaj_t
       WHERE faajent=g_enterprise AND faajld=l_fabh.fabhld
         AND faaj001=l_fabh.fabh001 AND faaj002=l_fabh.fabh002
         AND faaj037=l_fabh.fabh000
         
      INSERT INTO fabh_t(fabhent,fabhld,fabhsite,fabhdocno,fabhseq,
                         fabh001,fabh002,fabh000,fabh003,fabh008,
                         fabh011,fabh017,fabh020,fabh070,fabh023,
                         fabh071,fabh024,fabh072,fabh025,
                         fabh027,fabh033,fabh037,fabh038,
                         fabh100,fabh101,fabh102,fabh104,fabh109,
                         fabh150,fabh151,fabh152,fabh154,fabh159) 
      VALUES(l_fabh.fabhent,l_fabh.fabhld,l_fabh.fabhsite,l_fabh.fabhdocno,l_fabh.fabhseq,
             l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh000,l_fabh.fabh003,l_fabh.fabh008, 
             l_fabh.fabh011,l_fabh.fabh017,l_fabh.fabh020,l_fabh.fabh070,l_fabh.fabh023,
             l_fabh.fabh071,l_fabh.fabh024,l_fabh.fabh072,l_fabh.fabh025,
             l_fabh.fabh027,l_fabh.fabh033,l_fabh.fabh037,l_fabh.fabh038,
             l_fabh.fabh100,l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh104,l_fabh.fabh109, 
             l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh154,l_fabh.fabh159)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins fabh_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
      LET l_seq = l_seq + 1
   END FOREACH
   
   IF l_seq = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00241" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF 
   
   #151125-00006#1 --s  
   IF r_success THEN 
      #立即审核
      CALL s_aooi200_fin_get_slip(l_fabg.fabgdocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(l_fabg.fabgld,l_fabg.fabgcomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
          #CALL s_afat503_immediately_conf(l_fabg.fabgdocno,l_fabg.fabgcomp,l_fabg.fabgld,l_fabg.fabgdocdt,'afat421_02')
          CALL afat421_02_immediately_conf(l_fabg.fabgdocno,l_fabg.fabgcomp,l_fabg.fabgld,l_fabg.fabgdocdt)
               RETURNING l_conf_success
          IF l_conf_success = FALSE THEN 
             LET r_success = FALSE
          END IF     
      END IF  
   END IF 
   #151125-00006#1 --e
   
   #CALL cl_err_collect_show()  #151125-00006#1----mark by aiqq
   IF r_success = FALSE THEN 
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show()
   ELSE
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = l_fabg.fabgdocno
      LET g_errparam.code   = "afa-00464" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
#   #151125-00006#1 --s
#   #立即抛转
#   CALL s_fin_get_doc_para(l_fabg.fabgld,l_fabg.fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
#   IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN
#      IF cl_ask_confirm('axr-00888') THEN    
#         SELECT fabg008,fabgstus INTO l_fabg008,l_fabgstus FROM fabg_t
#                WHERE fabgent = g_enterprise AND fabgdocno = l_fabg.fabgdocno AND fabgld = l_fabg.fabgld 
#                
#         CALL s_afat503_fabg_immediately_gen(l_fabg.fabgld,l_fabg.fabgdocno,l_fabgstus,l_fabg.fabg005,l_fabg008)
#      END IF 
#   END IF 
#   #151125-00006#1 --e
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
