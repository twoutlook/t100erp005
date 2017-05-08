#+ 程式版本......:
#
#+ 程式代碼......: adzq056
#+ 設計人員......: madey
# Prog. Version..:
#
# Program name   : adzq056.4gl
# Description    : 查詢客製中或已簽出或topstd修改過的清單
# Modify         : 20161230 161230-00049 by madey : 新建程式
 
 
IMPORT os
IMPORT util
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
 
#單身 type 宣告
PRIVATE TYPE type_g_dzaf_d RECORD
   dzaf001 LIKE dzaf_t.dzaf001, 
   cust LIKE type_t.chr500, 
   checkout LIKE type_t.chr500, 
   topstd LIKE type_t.chr500 
   END RECORD

 
#模組變數(Module Variables)
DEFINE g_master             type_g_dzaf_d
DEFINE g_master_t           type_g_dzaf_d
DEFINE g_dzaf_d             DYNAMIC ARRAY OF type_g_dzaf_d
DEFINE g_dzaf_d_t           type_g_dzaf_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#+ 作業開始(主程式類型)
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING

   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT

   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()
 
   #LOCK CURSOR (identifier)
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE adzq056_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   PREPARE adzq056_master_referesh FROM g_sql
 
   LET g_forupd_sql = ""
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzq056_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #Service Call name="main.servicecall"
      
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzq056 WITH FORM cl_ap_formpath("adz",g_code)
   
      #瀏覽頁簽資料初始化
     #CALL cl_ui_init()
   
      #程式初始化
      CALL adzq056_init()   
 
      #Begin:modify by Hiko
      CALL cl_ui_wintitle(1) #工具抬頭名稱
      
      #讓ON ACITON controlg的Button從畫面上消失, 改成用Ctrl-G來觸發
      CALL cl_load_4ad_interface(NULL)
      
      LET lw_window = ui.Window.getCurrent()
      LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
      CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
      
      LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
      LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
      CALL ui.Interface.loadStyles(ls_4st_path)
      
      LET lf_form = lw_window.getForm()
      LET ls_4tb_path = os.Path.join(os.Path.join(ls_cfg_path, "4tb"), "toolbar_designer.4tb")
      CALL lf_form.loadToolBar(ls_4tb_path)
      #End
 
      #進入選單 Menu (="N")
      CALL adzq056_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_adzq056
      
   END IF 
   
   CLOSE adzq056_cl
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
#+ 畫面資料初始化
PRIVATE FUNCTION adzq056_init()
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   CALL adzq056_default_search()  
END FUNCTION
 
PRIVATE FUNCTION adzq056_default_search()
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " dzaf001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=1" #全查
   END IF
END FUNCTION
 
#+ 功能選單 
PRIVATE FUNCTION adzq056_ui_dialog()
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL adzq056_b_fill()
   ELSE
      CALL adzq056_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_dzaf_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL adzq056_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dzaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adzq056_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adzq056_detail_action_trans()
            
            #自訂ACTION(detail_show,page_1)
 
         END DISPLAY
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adzq056_detail_action_trans()
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            CALL adzq056_query()
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL adzq056_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_dzaf_d)
            LET g_export_id[1]   = "s_detail1"
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL adzq056_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adzq056_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adzq056_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adzq056_b_fill()
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
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
 
#+ QBE資料查詢
PRIVATE FUNCTION adzq056_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_dzaf_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON dzaf001
           FROM s_detail1[1].b_dzaf001
                      
         BEFORE CONSTRUCT
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_dzaf001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dzaf001
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dzaf001
            
 
         #Ctrlp:construct.c.page1.b_dzaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dzaf001
 
 
         #----<<b_cust>>----
         #----<<b_checkout>>----
         #----<<b_topstd>>----
      END CONSTRUCT
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
   END DIALOG
 
   LET g_wc = g_wc_table 
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   LET g_error_show = 1
   CALL adzq056_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
#+ 單身陣列填充
PRIVATE FUNCTION adzq056_b_fill()
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   #LET ls_sql_rank = "SELECT  UNIQUE dzaf001,'','',''  ,DENSE_RANK() OVER( ORDER BY dzaf_t.dzaf001) AS RANK FROM dzaf_t",
   LET ls_sql_rank = 
     " select dzaf001,cust,checkout,topstd, ",
     "        DENSE_RANK() OVER(ORDER BY dzaf001) AS RANK ",
     " from( ",
     " select all_list.dzaf001, ",
     "        NVL(cust_list.cust,'N') cust, ",
     "        NVL(checkout_list.checkout,'N') checkout, ",
     "        NVL(topstd_list.topstd,'N') topstd ",
     "   from (select distinct dzaf001 ",
     "           from dzaf_t ",
     "          where dzaf005 not in ('T', 'MT', 'MG', 'MV')) all_list ",
     "   left join (select af5.dzaf001, af5.dzaf005, 'Y' cust ",
     "                from (select af3.dzaf001, ",
     "                             af3.dzaf002, ",
     "                             af3.dzaf003, ",
     "                             af3.dzaf004, ",
     "                             af3.dzaf005, ",
     "                             af3.dzaf010 ",
     "                        from dzaf_t af3, ",
     "                             (select dzaf001, max(dzaf002) dzaf002, dzaf010 ",
     "                                from dzaf_t af0 ",
     "                               where af0.dzaf010 = ",
     "                                     (select min(dzaf010) ",
     "                                        from dzaf_t af1 ",
     "                                       where af1.dzaf001 = af0.dzaf001) ",
     "                                 and af0.dzaf005 not in ('T', 'MT', 'MG', 'MV') ",
     "                               group by dzaf001, dzaf010) af4 ",
     "                       where af3.dzaf001 = af4.dzaf001 ",
     "                         and af3.dzaf002 = af4.dzaf002 ",
     "                         and af3.dzaf010 = af4.dzaf010) af5 ",
     "               where af5.dzaf010 = 'c') cust_list ",
     "     on cust_list.dzaf001 = all_list.dzaf001 ",
     "   left join (select af5.dzaf001, af5.dzaf005, 'Y' checkout ",
     "                from (select af3.dzaf001, ",
     "                             af3.dzaf002, ",
     "                             af3.dzaf003, ",
     "                             af3.dzaf004, ",
     "                             af3.dzaf005, ",
     "                             af3.dzaf010 ",
     "                        from dzaf_t af3, ",
     "                             (select dzaf001, max(dzaf002) dzaf002, dzaf010 ",
     "                                from dzaf_t af0 ",
     "                               where af0.dzaf010 = ",
     "                                     (select min(dzaf010) ",
     "                                        from dzaf_t af1 ",
     "                                       where af1.dzaf001 = af0.dzaf001) ",
     "                                 and af0.dzaf005 not in ('T', 'MT', 'MG', 'MV') ",
     "                               group by dzaf001, dzaf010) af4 ",
     "                       where af3.dzaf001 = af4.dzaf001 ",
     "                         and af3.dzaf002 = af4.dzaf002 ",
     "                         and af3.dzaf010 = af4.dzaf010) af5 ",
     "               inner join dzlm_t ",
     "                  on dzlm002 = af5.dzaf001 ",
     "                 and (dzlm008 = 'O' or dzlm011 = 'O')) checkout_list ",
     "     on checkout_list.dzaf001 = all_list.dzaf001 ",
     "   left join (select af5.dzaf001, af5.dzaf005, 'Y' topstd ",
     "                from (select af3.dzaf001, ",
     "                             af3.dzaf002, ",
     "                             af3.dzaf003, ",
     "                             af3.dzaf004, ",
     "                             af3.dzaf005, ",
     "                             af3.dzaf010 ",
     "                        from dzaf_t af3, ",
     "                             (select dzaf001, max(dzaf002) dzaf002, dzaf010 ",
     "                                from dzaf_t af0 ",
     "                               where af0.dzaf010 = ",
     "                                     (select min(dzaf010) ",
     "                                        from dzaf_t af1 ",
     "                                       where af1.dzaf001 = af0.dzaf001) ",
     "                                 and af0.dzaf005 not in ('T', 'MT', 'MG', 'MV') ",
     "                               group by dzaf001, dzaf010) af4 ",
     "                       where af3.dzaf001 = af4.dzaf001 ",
     "                         and af3.dzaf002 = af4.dzaf002 ",
     "                         and af3.dzaf010 = af4.dzaf010) af5 ",
     "               inner join dzba_t ",
     "                  on dzba001 = af5.dzaf001 ",
     "                 and dzba002 = af5.dzaf004 ",
     "                 and dzba010 = af5.dzaf010 ",
     "                 and dzba005 = 's' ",
     "                 and ((LOWER(dzbacrtid) = 'topstd' OR ",
     "                     LOWER(dzbacrtid) = 'topdev') OR ",
     "                     (LOWER(dzbamodid) = 'topstd' OR ",
     "                     LOWER(dzbamodid) = 'topdev'))) topstd_list ",
     "     on topstd_list.dzaf001 = all_list.dzaf001 ",
     "  where cust_list.cust = 'Y' ",
     "     or checkout_list.checkout = 'Y' ",
     "     or topstd_list.topstd = 'Y' ",
     "  )",
     "",
     " WHERE 1=1 AND ", ls_wc
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT dzaf001,cust,checkout,topstd",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   PREPARE adzq056_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adzq056_pb
   
   OPEN b_fill_curs
 
   CALL g_dzaf_d.clear()
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_dzaf_d[l_ac].dzaf001,g_dzaf_d[l_ac].cust,g_dzaf_d[l_ac].checkout,g_dzaf_d[l_ac].topstd 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      CALL adzq056_detail_show("'1'")      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_dzaf_d.deleteElement(g_dzaf_d.getLength())   
 
   LET g_detail_cnt = g_dzaf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adzq056_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adzq056_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adzq056_detail_action_trans()
 
   IF g_dzaf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adzq056_fetch()
   END IF
   
   CALL adzq056_filter_show('dzaf001','b_dzaf001')
 
END FUNCTION
 
#+ 單身陣列填充2
PRIVATE FUNCTION adzq056_fetch()
   DEFINE li_ac           LIKE type_t.num10
 
   LET li_ac = l_ac 
   LET l_ac = li_ac
   
END FUNCTION
 
#+ 顯示相關資料
PRIVATE FUNCTION adzq056_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
   END IF
 
END FUNCTION
 
 
#+ filter欄位解析
PRIVATE FUNCTION adzq056_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
 
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adzq056_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = adzq056_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adzq056_detail_action_trans()
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adzq056_detail_index_setting()
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_dzaf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_dzaf_d.getLength() AND g_dzaf_d.getLength() > 0
            LET g_detail_idx = g_dzaf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_dzaf_d.getLength() THEN
               LET g_detail_idx = g_dzaf_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
