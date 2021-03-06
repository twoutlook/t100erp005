#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt920_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-10-28 14:51:50), PR版次:0007(2016-11-22 15:03:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000134
#+ Filename...: axrt920_03
#+ Description: 傳票底稿預覽
#+ Creator....: 01727(2014-04-23 11:23:33)
#+ Modifier...: 02114 -SD/PR- 07900
 
{</section>}
 
{<section id="axrt920_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#+ Modifier...:   No.160318-00025#39 16/04/22 By pengxin 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#6   16/07/29 By 08734  axrp330_gen_ar_tmp ——> axrp330_tmp01
#160727-00019#6   16/07/29 By 08734  axrp330_gen_tmp2 ——> axrp330_tmp02
#160727-00019#37   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
#161118-00019#2   16/11/22 By 07900  numt5 to num10(需人工调整部分)
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
#單身 type 宣告
 TYPE type_g_glaq_d RECORD
   glaqdocno LIKE glaq_t.glaqdocno, 
   glaqld    LIKE glaq_t.glaqld, 
   glaqseq   LIKE glaq_t.glaqseq, 
   glaq001   LIKE glaq_t.glaq001, 
   glacl004  LIKE type_t.chr500, 
   glaq003   LIKE glaq_t.glaq003, 
   glaq004   LIKE glaq_t.glaq004,
   glaq040   LIKE glaq_t.glaq040,
   glaq041   LIKE glaq_t.glaq041,
   glaq043   LIKE glaq_t.glaq043,
   glaq044   LIKE glaq_t.glaq044
       END RECORD

#模組變數(Module Variables)
DEFINE g_glaq_d             DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t           type_g_glaq_d

DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              #目前處理的ARRAY CNT    #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10              #單身 所在筆數(暫存用)   #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10              #單身 所在筆數(所有資料) #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)   #161118-00019#2 mod  type_t.num5 -> type_t.num10
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身

#多table用wc
DEFINE g_wc_table           STRING

DEFINE g_xrebld             LIKE xreb_t.xrebld
DEFINE g_xreb001            LIKE xreb_t.xreb001
DEFINE g_xreb002            LIKE xreb_t.xreb002
DEFINE g_wc                 STRING
DEFINE g_wc_i               STRING
#end add-point
 
{</section>}
 
{<section id="axrt920_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="axrt920_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axrt920_03.other_dialog" >}

 
{</section>}
 
{<section id="axrt920_03.other_function" readonly="Y" >}

PUBLIC FUNCTION axrt920_03(--)
   p_xrebld,p_xreb001,p_xreb002,p_wc
   )
   DEFINE p_xrebld        LIKE xreb_t.xrebld
   DEFINE p_xreb001       LIKE xreb_t.xreb001
   DEFINE p_xreb002       LIKE xreb_t.xreb002
   DEFINE p_wc            STRING

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_xrebld  = p_xrebld
   LET g_xreb001 = p_xreb001
   LET g_xreb002 = p_xreb002
   LET g_wc_i    = p_wc
   IF cl_null(g_wc_i) THEN LET g_wc_i = " 1=1" END IF

   #LOCK CURSOR (identifier)

   LET g_forupd_sql = ""

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)     #轉換不同資料庫語法
   DECLARE axrt920_03_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR

   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   PREPARE axrt920_03_master_referesh FROM g_sql

   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt920_03 WITH FORM cl_ap_formpath("axr","axrt920_03")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL axrt920_03_init()

   #進入選單 Menu (="N")
   CALL axrt920_03_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_axrt920_03

   CLOSE axrt920_03_cl

   LET g_action_choice = ''

END FUNCTION

PRIVATE FUNCTION axrt920_03_init()
   LET g_error_show = 1

   CALL cl_set_act_visible('modify,modify_detail',FALSE)

END FUNCTION

PRIVATE FUNCTION axrt920_03_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1

   WHILE TRUE

      CALL axrt920_03_b_fill(g_wc2)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac

               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()

         END DISPLAY

         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            NEXT FIELD CURRENT

         ON ACTION go_gen
            LET g_action_choice="go_gen"
            IF cl_auth_chk_act("go_gen") THEN
               CALL axrt920_03_gen()
               EXIT DIALOG
            END IF

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION axrt920_03_b_fill(p_wc2)
   #BODY FILL UP
   DEFINE p_wc2           STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_sql           STRING
   DEFINE l_xrcadocno     LIKE xrca_t.xrcadocno

   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF

   LET l_sql = "SELECT DISTINCT xreb005 FROM xreb_t WHERE xrebent = '",g_enterprise,"'",
               "   AND xrebld  = '",g_xrebld,"'",
               "   AND xreb001 = '",g_xreb001,"'",
               "   AND xreb002 = '",g_xreb002,"'",
               "   AND ",g_wc_i
   PREPARE axrt920_03_prep FROM l_sql
   DECLARE axrt920_03_curs CURSOR FOR axrt920_03_prep

   LET g_wc = ""
   LET l_xrcadocno = ""

   FOREACH axrt920_03_curs INTO l_xrcadocno
      IF cl_null(g_wc) THEN
         LET g_wc = "xrcadocno IN ('",l_xrcadocno,"'"
      ELSE
         LET g_wc = g_wc,",'",l_xrcadocno,"'"
      END IF
   END FOREACH
   LET g_wc = g_wc,")"

   CALL axrt920_03_create_tmp() RETURNING r_success

   CALL s_transaction_begin()
   CALL s_voucher_gen_ar(3,g_xrebld,'','',1,g_wc,'Y') RETURNING r_success,r_start_no,r_end_no

   IF r_success THEN
      CALL s_transaction_end('Y','Y')
   ELSE
      CALL s_transaction_end('N','Y')
      RETURN
   END IF

   LET g_sql= " SELECT DISTINCT docno,glaqld,seq,glaq001,glaq002,d,c,glaq040,glaq041,glaq043,glaq044 FROM s_vr_tmp05 ",   #160727-00019#37   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
              "  WHERE glaqent = ?",      #增加此段是为了规避下方的：OPEN b_fill_curs USING g_enterprise
              "  ORDER BY d DESC"

   PREPARE axrt920_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrt920_03_pb

   OPEN b_fill_curs USING g_enterprise

   CALL g_glaq_d.clear()


   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs INTO g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaqld,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001,
                            g_glaq_d[l_ac].glacl004,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,
                            g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET g_glaq_d[l_ac].glacl004 = g_glaq_d[l_ac].glacl004,'\n',axrt920_03_glaq002_desc(g_glaq_d[l_ac].glacl004)

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   IF l_ac > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = "glaq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
   LET g_error_show = 0

   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())

   IF g_cnt > g_glaq_d.getLength() THEN
      LET l_ac = g_glaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac

   LET g_detail_cnt = g_glaq_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt

   CLOSE b_fill_curs
   FREE axrt920_03_pb

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
PRIVATE FUNCTION axrt920_03_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF 
   
   DROP TABLE axrp330_tmp01;  #160727-00019#6   16/07/29 By 08734  axrp330_gen_ar_tmp ——> axrp330_tmp01
   CREATE TEMP TABLE axrp330_tmp01(  #160727-00019#6   16/07/29 By 08734  axrp330_gen_ar_tmp ——> axrp330_tmp01
   docno     VARCHAR(20),
   docdt     DATE, 
   sw        VARCHAR(1),   
   glaqent   SMALLINT,
   glaqcomp  VARCHAR(10),
   glaqld    VARCHAR(5),
   glaq001   VARCHAR(255),
   glaq002   VARCHAR(24),
   glaq005   VARCHAR(10),
   glaq006   DECIMAL(20,10),
   glaq007   VARCHAR(10),
   glaq009   DECIMAL(20,6),
   glaq011   VARCHAR(20),
   glaq012   DATE,
   glaq013   VARCHAR(20),
   glaq014   VARCHAR(30),
   glaq015   VARCHAR(10),
   glaq016   VARCHAR(10),   
   glaq017   VARCHAR(10),
   glaq018   VARCHAR(10),
   glaq019   VARCHAR(10),
   glaq020   VARCHAR(10),
   glaq021   VARCHAR(10),
   glaq022   VARCHAR(10),
   glaq023   VARCHAR(10),
   glaq024   VARCHAR(10),
   glaq025   VARCHAR(20),
   glaq026   VARCHAR(10),
   glaq027   VARCHAR(20),
   glaq028   VARCHAR(30),
   glaq029   VARCHAR(30),
   glaq030   VARCHAR(30),
   glaq031   VARCHAR(30),
   glaq032   VARCHAR(30),
   glaq033   VARCHAR(30),
   glaq034   VARCHAR(30),
   glaq035   VARCHAR(30),
   glaq036   VARCHAR(30),
   glaq037   VARCHAR(30),
   glaq038   VARCHAR(30),
   d         DECIMAL(20,6),
   c         DECIMAL(20,6),
   qty       DECIMAL(20,6),
   sum       DECIMAL(20,6),
   glaq039   DECIMAL(20,10),
   glaq040   DECIMAL(20,6),
   glaq041   DECIMAL(20,6),
   glaq042   DECIMAL(20,10),
   glaq043   DECIMAL(20,6),
   glaq044   DECIMAL(20,6),
   seq       INTEGER,
   source    VARCHAR(100),
   glaqseq   INTEGER,
   xrca039   INTEGER
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   
   DROP TABLE axrp330_tmp02;   #160727-00019#6   16/07/29 By 08734  axrp330_gen_tmp2 ——> axrp330_tmp02
   CREATE TEMP TABLE axrp330_tmp02(   #160727-00019#6   16/07/29 By 08734  axrp330_gen_tmp2 ——> axrp330_tmp02
   docno     VARCHAR(20),
   docdt     DATE, 
   sw        VARCHAR(1),   
   glaqent   SMALLINT,
   glaqcomp  VARCHAR(10),
   glaqld    VARCHAR(5),
   glaq001   VARCHAR(255),
   glaq002   VARCHAR(24),
   glaq005   VARCHAR(10),
   glaq006   DECIMAL(20,10),
   glaq007   VARCHAR(10),
   glaq009   DECIMAL(20,6),
   glaq011   VARCHAR(20),
   glaq012   DATE,
   glaq013   VARCHAR(20),
   glaq014   VARCHAR(30),
   glaq015   VARCHAR(10),
   glaq016   VARCHAR(10),   
   glaq017   VARCHAR(10),
   glaq018   VARCHAR(10),
   glaq019   VARCHAR(10),
   glaq020   VARCHAR(10),
   glaq021   VARCHAR(10),
   glaq022   VARCHAR(10),
   glaq023   VARCHAR(10),
   glaq024   VARCHAR(10),
   glaq025   VARCHAR(20),
   glaq026   VARCHAR(10),
   glaq027   VARCHAR(20),
   glaq028   VARCHAR(30),
   glaq029   VARCHAR(30),
   glaq030   VARCHAR(30),
   glaq031   VARCHAR(30),
   glaq032   VARCHAR(30),
   glaq033   VARCHAR(30),
   glaq034   VARCHAR(30),
   glaq035   VARCHAR(30),
   glaq036   VARCHAR(30),
   glaq037   VARCHAR(30),
   glaq038   VARCHAR(30),
   d         DECIMAL(20,6),
   c         DECIMAL(20,6),
   qty       DECIMAL(20,6),
   sum       DECIMAL(20,6),
   glaq039   DECIMAL(20,10),
   glaq040   DECIMAL(20,6),
   glaq041   DECIMAL(20,6),
   glaq042   DECIMAL(20,10),
   glaq043   DECIMAL(20,6),
   glaq044   DECIMAL(20,6),
   seq       INTEGER,
   source    VARCHAR(100),
   glaqseq   INTEGER,
   xrca039   INTEGER
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
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
PRIVATE FUNCTION axrt920_03_glaq002_desc(p_glaq002)
DEFINE p_glaq002           LIKE glaq_t.glaq002
DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
DEFINE r_glaq002           STRING
DEFINE l_oogf002_desc      LIKE oofa_t.oofa011
DEFINE l_glaq      RECORD 
         glaq017   LIKE glaq_t.glaq017,
         glaq018   LIKE glaq_t.glaq018,
         glaq019   LIKE glaq_t.glaq019,
         glaq020   LIKE glaq_t.glaq020,
         glaq021   LIKE glaq_t.glaq021,
         glaq022   LIKE glaq_t.glaq022,
         glaq023   LIKE glaq_t.glaq023,
         glaq024   LIKE glaq_t.glaq024,
         glaq025   LIKE glaq_t.glaq025,
         glaq026   LIKE glaq_t.glaq026,
         glaq027   LIKE glaq_t.glaq027,
         glaq028   LIKE glaq_t.glaq028        
                   END RECORD
   
   SELECT glaq017,glaq018,glaq019,glaq020,
          glaq021,glaq022,glaq023,glaq024,
          glaq025,glaq026,glaq027,glaq028
     INTO l_glaq.*
     FROM s_voucher_group_tmp
    WHERE glaqent = g_enterprise
      AND glaqld = g_xrebld
      AND glaq002 = p_glaq002      
   
   #抓取科目名称
   LET l_glaq002_desc = ''
   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t,glaa_t
    WHERE glaaent = glaclent 
      AND glaa004 = glacl001
      AND glaclent = g_enterprise
      AND glaald = g_xrebld
      AND glacl002 = p_glaq002
      AND glacl003 = g_dlang  


   #组合名称以及核算项
   LET r_glaq002 = ''
   #部门
   IF NOT cl_null(l_glaq.glaq018) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq018
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_glaq002 = g_rtn_fields[1]     
   END IF 
   #成本利润中心
   IF NOT cl_null(l_glaq.glaq019) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq019
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   
   #区域
   IF NOT cl_null(l_glaq.glaq020) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = l_glaq.glaq020
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields  
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #交易客商
   IF NOT cl_null(l_glaq.glaq021) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq021
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1] 
      ELSE
         LET r_glaq002 = g_rtn_fields[1] 
      END IF      
   END IF 
   #帐款客商
   IF NOT cl_null(l_glaq.glaq022) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq022
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #客群
   IF NOT cl_null(l_glaq.glaq023) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = l_glaq.glaq023
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   
   #产品分类
   IF NOT cl_null(l_glaq.glaq024) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq024
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #人员
   IF NOT cl_null(l_glaq.glaq025) THEN
      LET  l_oogf002_desc = ''
      SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
       WHERE oofaent = g_enterprise
         AND oofa001 IN (SELECT ooag002 FROM ooag_t
                          WHERE ooagent = g_enterprise
                            AND ooag001 = l_glaq.glaq025)
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_oogf002_desc
      ELSE
         LET r_glaq002 = l_oogf002_desc
      END IF      
   END IF 
   #预算编号
   IF NOT cl_null(l_glaq.glaq026) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaq.glaq026
      CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_rtn_fields[1]
      ELSE
         LET r_glaq002 = g_rtn_fields[1]
      END IF      
   END IF 
   #专案编号
   IF NOT cl_null(l_glaq.glaq027) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq027
      ELSE
         LET r_glaq002 = l_glaq.glaq027
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(l_glaq.glaq028) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq028
      ELSE
         LET r_glaq002 = l_glaq.glaq028
      END IF      
   END IF 
   #组合科目名称以及核算项
   LET r_glaq002 = l_glaq002_desc,'\n',
                   r_glaq002
                   
   RETURN r_glaq002 
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
PRIVATE FUNCTION axrt920_03_gen()
   DEFINE sr         RECORD
             glapdocno     LIKE glap_t.glapdocno,
             glapdocdt     LIKE glap_t.glapdocdt,
             check         LIKE type_t.chr1
                     END RECORD
   DEFINE l_s        LIKE type_t.chr1
   DEFINE l_glaacomp LIKE glaa_t.glaacomp
   DEFINE l_ooef004  LIKE ooef_t.ooef004
   DEFINE r_success  LIKE type_t.chr1
   DEFINE r_start_no LIKE glap_t.glapdocno
   DEFINE r_end_no   LIKE glap_t.glapdocno

   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xrebld

   SELECT ooef004 INTO l_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = l_glaacomp

   OPEN WINDOW w_axrt920_03_s01 WITH FORM cl_ap_formpath("axr",'axrt920_03_s01')

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
     
         INPUT BY NAME sr.glapdocno,sr.glapdocdt,sr.check ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT
               LET sr.glapdocdt = g_today
               LET sr.check = 'N'
               DISPLAY BY NAME sr.glapdocdt,sr.check

            AFTER FIELD glapdocno
               IF NOT cl_null(sr.glapdocno) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = l_ooef004
                  LET g_chkparam.arg2 = sr.glapdocno
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooba002_07") THEN
                     #檢查失敗時後續處理
                     LET sr.glapdocno = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF 

            AFTER FIELD glapdocdt

         ON ACTION controlp INFIELD glapdocno        
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = sr.glapdocno    #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = 'aglt310'

            CALL q_ooba002_3()                              #呼叫開窗

            LET sr.glapdocno = g_qryparam.return1           #將開窗取得的值回傳到變數
            DISPLAY sr.glapdocno TO glapdocno               #顯示到畫面上
            NEXT FIELD glapdocno                            #返回原欄位

         END INPUT

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

      END DIALOG

      IF INT_FLAG = 0 THEN
         CALL s_voucher_gen_ar_2_ins_glap('3',sr.glapdocno,sr.glapdocdt,g_xrebld,'1')
              RETURNING r_success,r_start_no,r_end_no
         IF NOT r_success THEN
            CALL s_transaction_end('N','Y')
            CALL cl_ask_confirm('axr-00120') RETURNING l_s
         ELSE
            DISPLAY r_start_no,r_end_no TO b_xrca038,e_xrca038
            CALL s_transaction_end('Y','Y')
            CALL cl_ask_confirm('axr-00119') RETURNING l_s
         END IF
         
      ELSE
         LET INT_FLAG = FALSE
      END IF

   CLOSE WINDOW w_axrt920_03_s01














END FUNCTION

 
{</section>}
 
