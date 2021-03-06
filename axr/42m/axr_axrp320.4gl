#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-01-16 09:30:07), PR版次:0007(2016-11-24 16:38:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000244
#+ Filename...: axrp320
#+ Description: 應收帳款單傳票自動產生作業(停用)
#+ Creator....: ()
#+ Modifier...: 01727 -SD/PR- 01727
 
{</section>}
 
{<section id="axrp320.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#52 2016/03/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#35 2016/08/11 By 08734    临时表长度超过15码的减少到15码以下 s_voucher_gen_tmp ——> s_vr_tmp01
#160731-00372#1  2016/08/16 By 07900    客户开窗不要开供应商
#160913-00017#10 2016/09/22 By 07900    AXR模组调整交易客商开窗
#161017-00011#2  2016/10/19 By 02599    增加控制组权限控管
#161111-00049#6  2016/11/24 By 01727    控制组权限修改

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#模組變數(Module Variables)
DEFINE g_xrca_m   RECORD
    xrcald        LIKE xrca_t.xrcald,
    xrcald_desc   LIKE glaal_t.glaal002,
    glaacomp      LIKE glaa_t.glaacomp,
    glaacomp_desc LIKE ooefl_t.ooefl003,
    type          LIKE type_t.chr1,
    glapdocno     LIKE glap_t.glapdocno,
    glapdocdt    LIKE glap_t.glapdocdt 
    END RECORD 

DEFINE g_wc           STRING                       
DEFINE g_sql          STRING
DEFINE g_forupd_sql   STRING
      
DEFINE g_ref_fields   DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields   DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ooef004      LIKE ooef_t.ooef004      
DEFINE g_sql_ctrl     STRING #161017-00011#2 add
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="axrp320.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT xrcadocno,xrcald,'',xrca001,xrca004,xrcadocdt,xrca038 FROM xrca_t WHERE xrcaent= ? AND xrcald=? AND xrcadocno=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE axrp320_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp320 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp320_init()
 
      #進入選單 Menu (='N')
      CALL axrp320_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_axrp320
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axrp320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axrp320_init()
   CALL cl_set_combo_scc('xrca001','8302')
   
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) AND NOT cl_null(g_argv[4]) AND NOT cl_null(g_argv[5]) THEN 
      CALL cl_set_comp_entry("xrcald",FALSE)
   END IF
   #161017-00011#2--add--str--
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #161017-00011#2--add--end
END FUNCTION

PRIVATE FUNCTION axrp320_ui_dialog()
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) AND NOT cl_null(g_argv[4]) AND NOT cl_null(g_argv[5]) THEN 
      CALL axrp320_construct2()
   ELSE
      CALL axrp320_construct()
   END IF
END FUNCTION

PRIVATE FUNCTION axrp320_construct()
   WHILE TRUE
      CLEAR FORM
      INITIALIZE g_wc TO NULL
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         INPUT BY NAME g_xrca_m.xrcald,g_xrca_m.glaacomp    
            BEFORE FIELD xrcald
               CALL axrp320_xrcald_desc()
            
            AFTER FIELD xrcald
               CALL axrp320_xrcald_desc()
               IF NOT cl_null(g_xrca_m.xrcald) THEN 
                  IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN 
                     LET g_xrca_m.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF 
#                  IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',1) THEN    #160318-00005#52  mark
                  IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN     #160318-00005#52  add
                     LET g_xrca_m.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF 
                  IF NOT ap_chk_isExist(g_xrca_m.xrcald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND (glaa014 = 'Y' OR glaa008 = 'Y') AND glaastus = 'Y' ",'axr-00021',1) THEN 
                     LET g_xrca_m.xrcald = ''
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_ld_chk_authorization(g_user,g_xrca_m.xrcald) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_xrca_m.xrcald
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xrca_m.xrcald = ''
                     NEXT FIELD CURRENT               
                  END IF  
                  #161111-00049#6 Add  ---(S)---
                  CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xrca_m.glaacomp)
                     RETURNING g_sub_success,g_sql_ctrl
                  #161111-00049#6 Add  ---(E)---                
               END IF
               
            ON ACTION controlp INFIELD xrcald
		   	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		       LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xrca_m.xrcald      #給予default值
               LET g_qryparam.where = " (glaa008 ='Y' OR glaa014 ='Y') "
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()                                  #呼叫開窗
               LET g_xrca_m.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_xrca_m.xrcald TO xrcald              #顯示到畫面上
               CALL axrp320_xrcald_desc()
               NEXT FIELD xrcald                              #返回原欄位  
               
            AFTER INPUT

         END INPUT 

         #螢幕上取條件
         CONSTRUCT BY NAME g_wc ON xrca001,xrca004,xrcadocdt,xrcadocno
   
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
   
            ON ACTION controlp INFIELD xrcadocno
		       INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		       LET g_qryparam.reqry = FALSE
		         #161017-00011#2--add--str--
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                         "          WHERE pmaaent = ",g_enterprise,
                                         "            AND ",g_sql_ctrl,
                                         "            AND pmaaent = xrcaent ",
                                         "            AND pmaa001 = xrca004 )"
                                        ," AND xrcald = '",g_xrca_m.xrcald,"'"   #161111-00049#6 Add
               END IF
               #161017-00011#2--add--end
               CALL q_xrcadocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上  
               NEXT FIELD xrcadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD xrca004
		       INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		       LET g_qryparam.reqry = FALSE
		      # LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"  #160731-00372#1 2016/08/16 By 07900 add   #160913-00017#10  mark 
               # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗
               #160913-00017#10--ADD(S)--
               LET g_qryparam.arg1="('2','3')"
               #161017-00011#2--add--str--
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161017-00011#2--add--end
               CALL q_pmaa001_1()
               #160913-00017#10--ADD(E)- 
               DISPLAY g_qryparam.return1 TO xrca004  #顯示到畫面上
               NEXT FIELD xrca004                     #返回原欄位  
               
         END CONSTRUCT
             
         INPUT BY NAME g_xrca_m.type,g_xrca_m.glapdocno,g_xrca_m.glapdocdt   
    
            AFTER FIELD type
              IF g_xrca_m.type NOT MATCHES "[123]" THEN 
                 NEXT FIELD type
              END IF 
            ON CHANGE type
               IF g_xrca_m.type MATCHES "[3]" THEN 
                  CALL cl_set_comp_required("glapdocdt",TRUE)
               ELSE
                  CALL cl_set_comp_required("glapdocdt",FALSE)               
               END IF
              
            AFTER FIELD glapdocno
               IF NOT cl_null(g_xrca_m.glapdocno) THEN
                  CALL axrp320_glapdocno_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrca_m.glapdocno
                     #160318-00005#52 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi200'
                           LET g_errparam.replace[2] = cl_get_progname('aooi200',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi200'
                     END CASE
                     #160318-00005#52 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xrca_m.glapdocno = ''
                     NEXT FIELD glapdocno
                  END IF   
               END IF    


            ON ACTION controlp INFIELD glapdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = 'i'
               LET g_qryparam.default1 = g_xrca_m.glapdocno            #給予default值
               #給予arg
               LET g_qryparam.where = " ooba001 = '",g_ooef004,"' AND oobx003 = 'aglt310' AND oobx002 = 'AGL' "
               CALL q_ooba002_4()                                #呼叫開窗
               LET g_xrca_m.glapdocno = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_xrca_m.glapdocno TO glapdocno           #顯示到畫面上
               NEXT FIELD glapdocno                              #返回原欄位
    
            AFTER INPUT

         END INPUT 

         BEFORE DIALOG
            SELECT glaald INTO g_xrca_m.xrcald FROM ooef_t,ooag_t,glaa_t
             WHERE ooef001 = ooag004 AND ooefent = ooagent
               AND ooef017 = glaacomp AND ooefent = glaaent
               AND ooagent = g_enterprise
               AND ooag001 = g_user
            CALL axrp320_xrcald_desc()          
            LET g_xrca_m.type = 1
            DISPLAY g_xrca_m.type TO type  
            
         ON ACTION accept
            ACCEPT DIALOG
   
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT WHILE

         ON ACTION qbeclear
            #add-point:ui_dialog段
            CLEAR FORM
            INITIALIZE g_xrca_m.* TO NULL
            SELECT glaald INTO g_xrca_m.xrcald FROM ooef_t,ooag_t,glaa_t
             WHERE ooef001 = ooag004 AND ooefent = ooagent
               AND ooef017 = glaacomp AND ooefent = glaaent
               AND ooagent = g_enterprise
               AND ooag001 = g_user
            CALL axrp320_xrcald_desc()          
            LET g_xrca_m.type = 1
            DISPLAY g_xrca_m.type TO type  

   
         #查詢CONSTRUCT共用ACTION
         &include "construct_action.4gl"
   
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
   
     #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")

      DISPLAY g_wc,g_xrca_m.*
      
      CALL axrp320_gen_glap()
      IF g_intrans THEN
         CONTINUE WHILE
      ELSE
         EXIT WHILE
      END IF      
   END WHILE
END FUNCTION
################################################################################
# Descriptions...: 應收產生傳票
# Memo...........:
# Usage..........: CALL axrp320_gen_glap(传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp320_gen_glap()
DEFINE p_type LIKE type_t.chr2
DEFINE p_ld LIKE glaa_t.glaald
DEFINE p_date LIKE glap_t.glapdocdt
DEFINE p_slip LIKE ooba_t.ooba002
DEFINE p_sum_type LIKE type_t.chr1
DEFINE p_wc LIKE type_t.chr1000
DEFINE r_success LIKE type_t.num5
DEFINE r_start_no LIKE glap_t.glapdocno
DEFINE r_end_no LIKE glap_t.glapdocno
DEFINE l_cmd STRING
 
    LET g_intrans= 'N'
    CALL s_voucher_cre_tmp_table() RETURNING r_success

    CALL s_transaction_begin()
    #传入参数赋值
    LET p_type = '1'
    LET p_ld = g_xrca_m.xrcald
    LET p_date = g_xrca_m.glapdocdt
    LET p_slip = g_xrca_m.glapdocno
    LET p_sum_type = g_xrca_m.type
    LET p_wc = g_wc
    
    #161017-00011#2--add--str--
    IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
       LET p_wc = p_wc,"   AND EXISTS (SELECT 1 FROM pmaa_t ",
                       "                WHERE pmaaent = ",g_enterprise,
                       "                  AND ",g_sql_ctrl,
                       "                  AND pmaaent = xrcaent ",
                       "                  AND pmaa001 = xrca004 )"
    END IF 
    #161017-00011#2--add--end

    #测试元件
    CALL s_voucher_gen(p_type,p_ld,p_date,p_slip,p_sum_type,p_wc) RETURNING r_success,r_start_no,r_end_no

    IF r_success THEN
       DISPLAY 'Begin:',r_start_no
       DISPLAY 'End  :',r_end_no
       CALL s_transaction_end('Y','0')
       CALL cl_ask_end2(1) RETURNING g_intrans
    ELSE
       CALL s_transaction_end('N','0')
       CALL cl_ask_end2(2) RETURNING g_intrans
    END IF
    DROP TABLE s_vr_tmp01;  #160727-00019#35   16/08/11 By 08734 临时表长度超过15码的减少到15码以下 s_voucher_gen_tmp ——> s_vr_tmp01

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
PRIVATE FUNCTION axrp320_xrcald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.xrcald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrca_m.xrcald_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xrca_m.xrcald_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.xrcald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_xrca_m.glaacomp = g_rtn_fields[1]
   DISPLAY BY NAME g_xrca_m.glaacomp

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrca_m.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xrca_m.glaacomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooef004 FROM ooef_t WHERE ooefent='"||g_enterprise||"' AND ooef001=? ","") RETURNING g_rtn_fields
   LET g_ooef004 = g_rtn_fields[1]
   
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
PRIVATE FUNCTION axrp320_glapdocno_chk()
DEFINE p_glapdocno      LIKE glap_t.glapdocno
DEFINE l_oobastus       LIKE ooba_t.oobastus
DEFINE l_oobg003        LIKE oobg_t.oobg003
   
   LET g_errno = '' 
    
   SELECT oobastus INTO l_oobastus FROM ooba_t,oobx_t
    WHERE oobaent = oobxent
      AND ooba002 = oobx001
      AND oobaent = g_enterprise
      AND ooba001 = g_ooef004             #单据别参照表号
      AND ooba002 = g_xrca_m.glapdocno    #单据别
      AND oobx002 = 'AGL'                 
      AND oobx003 = 'aglt310'             #单据性质
   CASE
      WHEN SQLCA.SQLCODE =100  LET g_errno = 'aim-00056'
#      WHEN l_oobastus = 'N'    LET g_errno = 'aim-00057'   #160318-00005#52  mark
      WHEN l_oobastus = 'N'    LET g_errno = 'sub-01302'    #160318-00005#52  add
   END CASE
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
PRIVATE FUNCTION axrp320_construct2()
   WHILE TRUE
      CLEAR FORM
      INITIALIZE g_wc TO NULL
      LET g_wc = " 1=1"
      IF NOT cl_null(g_argv[1]) THEN   #帳款帳別
         LET g_xrca_m.xrcald = g_argv[1]
      END IF
      DISPLAY BY NAME g_xrca_m.xrcald
      CALL axrp320_xrcald_desc()      
      IF NOT cl_null(g_argv[2]) THEN   #帳款單性質
         LET g_wc = g_wc," AND xrca001 = '",g_argv[2],"'"
      END IF
      IF NOT cl_null(g_argv[3]) THEN   #帳款客户範圍
         LET g_wc = g_wc," AND xrca004 = '",g_argv[3],"'"
      END IF
      IF NOT cl_null(g_argv[4]) THEN   #立帳日期範圍
         LET g_wc = g_wc," AND xrcadocdt = '",g_argv[4],"'"
      END IF
      IF NOT cl_null(g_argv[5]) THEN   #帳款单號範圍
         LET g_wc = g_wc," AND xrcadocno = '",g_argv[5],"'"
      END IF  
      DISPLAY g_argv[2] TO xrca001
      DISPLAY g_argv[3] TO xrca004
      DISPLAY g_argv[4] TO xrcadocdt
      DISPLAY g_argv[5] TO xrcadocno

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
             
         INPUT BY NAME g_xrca_m.type,g_xrca_m.glapdocno,g_xrca_m.glapdocdt   
    
            AFTER FIELD type
              IF g_xrca_m.type NOT MATCHES "[123]" THEN 
                 NEXT FIELD type
              END IF
              
            ON CHANGE type
               IF g_xrca_m.type MATCHES "[3]" THEN 
                  CALL cl_set_comp_required("glapdocdt",TRUE)
               ELSE
                  CALL cl_set_comp_required("glapdocdt",FALSE)               
               END IF
               
            AFTER FIELD glapdocno
               IF NOT cl_null(g_xrca_m.glapdocno) THEN
                  CALL axrp320_glapdocno_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrca_m.glapdocno
                     #160318-00005#52 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi200'
                           LET g_errparam.replace[2] = cl_get_progname('aooi200',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi200'
                     END CASE
                     #160318-00005#52 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xrca_m.glapdocno = ''
                     NEXT FIELD glapdocno
                  END IF   
               END IF    


            ON ACTION controlp INFIELD glapdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = 'i'
               LET g_qryparam.default1 = g_xrca_m.glapdocno            #給予default值
               #給予arg
               LET g_qryparam.where = "ooba001 = '",g_ooef004,"' AND ooba004 = 'aglt310' AND ooba003 = 'AGL' "
               CALL q_ooba002_4()                                #呼叫開窗
               LET g_xrca_m.glapdocno = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_xrca_m.glapdocno TO glapdocno           #顯示到畫面上
               NEXT FIELD glapdocno                              #返回原欄位
    
            AFTER INPUT

         END INPUT 
   
         BEFORE DIALOG
            LET g_xrca_m.type = 1
            DISPLAY g_xrca_m.type TO type         

         ON ACTION accept
            ACCEPT DIALOG
   
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG

         ON ACTION qbeclear
            #add-point:ui_dialog段
            CLEAR FORM
            INITIALIZE g_xrca_m.* TO NULL
            LET g_wc = " 1=1"
            IF NOT cl_null(g_argv[1]) THEN   #帳款帳別
               LET g_xrca_m.xrcald = g_argv[1]
            END IF
            DISPLAY BY NAME g_xrca_m.xrcald
            CALL axrp320_xrcald_desc()      
            IF NOT cl_null(g_argv[2]) THEN   #帳款單性質
               LET g_wc = g_wc," AND xrca001 = '",g_argv[2],"'"
            END IF
            IF NOT cl_null(g_argv[3]) THEN   #帳款客户範圍
               LET g_wc = g_wc," AND xrca004 = '",g_argv[3],"'"
            END IF
            IF NOT cl_null(g_argv[4]) THEN   #立帳日期範圍
               LET g_wc = g_wc," AND xrcadocdt = '",g_argv[4],"'"
            END IF
            IF NOT cl_null(g_argv[5]) THEN   #帳款单號範圍
               LET g_wc = g_wc," AND xrcadocno = '",g_argv[5],"'"
            END IF  
            DISPLAY g_argv[2] TO xrca001
            DISPLAY g_argv[3] TO xrca004
            DISPLAY g_argv[4] TO xrcadocdt
            DISPLAY g_argv[5] TO xrcadocno
            LET g_xrca_m.type = 1
            DISPLAY g_xrca_m.type TO type  
   
         #查詢CONSTRUCT共用ACTION
         &include "construct_action.4gl"
   
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
   
     #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")
    

      DISPLAY g_wc,g_xrca_m.*
      
      IF NOT INT_FLAG THEN 
         CALL axrp320_gen_glap()
      END IF   
      IF INT_FLAG = 1 THEN
         LET INT_FLAG = 0
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

#end add-point
 
{</section>}
 
