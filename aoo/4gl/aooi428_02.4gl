#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi428_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2013-11-08 15:29:35), PR版次:0002(2016-11-14 10:59:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000147
#+ Filename...: aooi428_02
#+ Description: 組員快速產生子程式
#+ Creator....: 01996(2013-11-08 09:26:36)
#+ Modifier...: 01996 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi428_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#161108-00012#2    2016/11/09 By 08734   g_browser_cnt 由num5改為num10
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="aooi428_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_oogf_m        RECORD
       oogf003    LIKE oogf_t.oogf003
       END RECORD

#單身 type 宣告
 TYPE type_g_ooag_d        RECORD
       chkbox   LIKE type_t.chr1,
       ooag003  LIKE ooag_t.ooag003,
       ooefl003 LIKE ooefl_t.ooefl003,
       ooag001  LIKE ooag_t.ooag001,
       oofa011 	LIKE oofa_t.oofa011
       END RECORD


#模組變數(Module Variables)
DEFINE g_oogf_m          type_g_oogf_m



DEFINE g_ooag_d          DYNAMIC ARRAY OF type_g_ooag_d
DEFINE g_ooag_d_t        type_g_ooag_d





DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING


DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_ac                  LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#2 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#2 num5==》num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#2 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#2 num5==》num10
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_oogf001             LIKE oogf_t.oogf001
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="aooi428_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aooi428_02.other_dialog" >}

 
{</section>}
 
{<section id="aooi428_02.other_function" readonly="Y" >}

PUBLIC FUNCTION aooi428_02(--)
   p_oogf001
   )
DEFINE p_oogf001   LIKE oogf_t.oogf001

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi428_02 WITH FORM cl_ap_formpath("aoo","aooi428_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET g_oogf001 = p_oogf001
   CALL aooi428_02_construct()
   
   #畫面關閉
   CLOSE WINDOW w_aooi428_02


END FUNCTION

PRIVATE FUNCTION aooi428_02_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   DEFINE l_ooeg001   LIKE ooeg_t.ooeg001
   DEFINE l_n         LIKE type_t.num5

   #清除畫面
   CLEAR FORM
   INITIALIZE g_oogf_m.* TO NULL
   CALL g_ooag_d.clear()


   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL

   INITIALIZE g_wc2_table1 TO NULL


   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #單頭
      CONSTRUCT BY NAME g_wc ON ooag003

         BEFORE CONSTRUCT
            CALL cl_qbe_init()

         AFTER FIELD ooag003
            LET l_n = 0
            LET g_sql = " SELECT 'N',ooag003,ooefl003,ooag001,oofa011 FROM ooag_t  ",
                        " LEFT OUTER JOIN ooefl_t ON ooag003 = ooefl001 AND ooeflent = ooagent AND ooefl002 ='",g_dlang,"'",
                        " LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = ooagent",
                        "  WHERE ooagent=? AND ",g_wc CLIPPED,
                        "  AND ooag001 NOT IN (SELECT oogf002 FROM oogf_t WHERE oogfent = ooagent AND oogf001 = '",g_oogf001,"'",
                        "  AND oogfsite = '",g_site,"')"
            PREPARE count_pre FROM g_sql
            EXECUTE count_pre INTO l_n USING g_enterprise
            IF l_n = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00242'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               DISPLAY '' TO ooag003
               NEXT FIELD CURRENT
            END IF

         ON ACTION controlp INFIELD ooag003
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = "c"
             LET g_qryparam.reqry = FALSE
             CALL q_ooeg001()
             DISPLAY g_qryparam.return1 TO ooag003

          ON ACTION qbe_select     #條件查詢
#             CALL cl_qbe_list() RETURNING lc_qbe_sn
#             CALL cl_qbe_display_condition(lc_qbe_sn)
     
          ON ACTION qbe_save       #條件儲存
             CALL cl_qbe_save()
     
          ON ACTION accept
             ACCEPT DIALOG
     
          ON ACTION cancel
             LET INT_FLAG = 1
             EXIT DIALOG

      END CONSTRUCT
   END DIALOG    

   IF INT_FLAG THEN
      RETURN
   ELSE
      CALL aooi428_02_input()
   END IF

END FUNCTION

PRIVATE FUNCTION aooi428_02_input()
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num10                #未取消的ARRAY CNT   #161108-00012#2 num5==》num10
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  l_success       LIKE type_t.chr1
   DEFINE  l_oogfownid     LIKE oogf_t.oogfownid
   DEFINE  l_oogfowndp     LIKE oogf_t.oogfowndp
   DEFINE  l_oogfcrtid     LIKE oogf_t.oogfcrtid
   DEFINE  l_oogfcrtdp     LIKE oogf_t.oogfcrtdp
   DEFINE  l_oogfcrtdt     DATETIME YEAR TO SECOND
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point

   #切換畫面
   #該樣板不需此段落IF g_main_hidden THEN
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("mainlayout",0)
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("worksheet",1)
   #該樣板不需此段落   LET g_main_hidden = 0
   #該樣板不需此段落END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""



   LET g_oogf_m.oogf003 = g_today
   DISPLAY BY NAME g_oogf_m.oogf003


   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_oogf_m.oogf003
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         BEFORE INPUT
            CALL aooi428_02_b_fill()
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF


         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

      END INPUT

      #Page1 預設值產生於此處
      INPUT ARRAY g_ooag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)


         BEFORE INPUT

            CALL aooi428_02_b_fill()
            LET g_rec_b = g_ooag_d.getLength()


         BEFORE ROW
             LET l_ac = ARR_CURR()

      END INPUT



      BEFORE DIALOG

      ON ACTION all
         FOR l_i = 1 TO g_ooag_d.getLength()
             LET g_ooag_d[l_i].chkbox = 'Y'
         END FOR
         DISPLAY ARRAY g_ooag_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY 
      ON ACTION unall
         FOR l_i = 1 TO g_ooag_d.getLength()
             LET g_ooag_d[l_i].chkbox = 'N'
         END FOR
         DISPLAY ARRAY g_ooag_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   IF NOT INT_FLAG THEN
      CALL s_transaction_begin()
      LET l_success = 'Y'
      FOR l_i = 1 TO g_ooag_d.getLength()
          IF g_ooag_d[l_i].chkbox = 'N' THEN
             CONTINUE FOR
          END IF
          LET l_oogfownid = g_user
          LET l_oogfowndp = g_dept
          LET l_oogfcrtid = g_user
          LET l_oogfcrtdp = g_dept
          LET l_oogfcrtdt = cl_get_current()
          INSERT INTO oogf_t (oogfent,oogf001,oogf002,oogf003,oogfsite,oogfstus,oogfownid,oogfowndp,oogfcrtid,oogfcrtdp,oogfcrtdt)
                      VALUES (g_enterprise,g_oogf001,g_ooag_d[l_i].ooag001,g_oogf_m.oogf003,g_site,'Y',l_oogfownid,l_oogfowndp,l_oogfcrtid,l_oogfcrtdp,l_oogfcrtdt)
          IF SQLCA.SQLCODE THEN
             LET l_success = 'N'
             EXIT FOR
          END IF
      END FOR
      CALL s_transaction_end(l_success,'1')
   END IF

END FUNCTION

PRIVATE FUNCTION aooi428_02_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   CALL g_ooag_d.clear()    #g_pmcb_d 單頭及單身



   LET g_sql = " SELECT 'N',ooag003,ooefl003,ooag001,oofa011 FROM ooag_t  ",
               " LEFT OUTER JOIN ooefl_t ON ooag003 = ooefl001 AND ooeflent = ooagent AND ooefl002 ='",g_dlang,"'",
               " LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = ooagent",
               "  WHERE ooagent=? AND ",g_wc CLIPPED,
               "  AND ooag001 NOT IN (SELECT oogf002 FROM oogf_t WHERE oogfent = ooagent AND oogf001 = '",g_oogf001,"'",
               "  AND oogfsite = '",g_site,"')"


      PREPARE aooi428_02_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR aooi428_02_pb

      LET g_cnt = l_ac
      LET l_ac = 1

      OPEN b_fill_cs USING g_enterprise


      FOREACH b_fill_cs INTO g_ooag_d[l_ac].chkbox,g_ooag_d[l_ac].ooag003,g_ooag_d[l_ac].ooefl003,g_ooag_d[l_ac].ooag001,g_ooag_d[l_ac].oofa011
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF



         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

      END FOREACH
      LET g_error_show = 0

   


   CALL g_ooag_d.deleteElement(g_ooag_d.getLength())

   DISPLAY ARRAY g_ooag_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY 
   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE aooi428_02_pb


END FUNCTION

 
{</section>}
 
