#該程式未解開Section, 採用最新樣板產出!
{<section id="azzq901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-08-27 16:57:09), PR版次:0001(2015-08-27 16:55:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: azzq901
#+ Description: 欄位對應程式編號查詢
#+ Creator....: 00845(2015-08-27 13:20:08)
#+ Modifier...: 00845 -SD/PR- 00845
 
{</section>}
 
{<section id="azzq901.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單身 type 宣告
 TYPE type_g_gzdg_d RECORD
   dzeb001 LIKE dzeb_t.dzeb001,
   dzeal003 LIKE dzeal_t.dzeal003,
   dzeb002 LIKE dzeb_t.dzeb002,
   dzebl003 LIKE dzebl_t.dzebl003
       END RECORD
PRIVATE TYPE type_g_gzdg2_d RECORD
   gzdg001 LIKE gzdg_t.gzdg001,
   gzdel003 LIKE gzdel_t.gzdel003,
   gzdg003 LIKE gzdg_t.gzdg003,
   gzdg004 LIKE gzdg_t.gzdg004
       END RECORD
#模組變數(Module Variables)
DEFINE g_gzdg_d          DYNAMIC ARRAY OF type_g_gzdg_d
DEFINE g_gzdg_d_t        type_g_gzdg_d
DEFINE g_gzdg2_d          DYNAMIC ARRAY OF type_g_gzdg2_d
DEFINE g_gzdg2_d_t        type_g_gzdg2_d

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
DEFINE g_current_idx        LIKE type_t.num10
DEFINE g_qbe_hidden         LIKE type_t.num5

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzq901.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = " "
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzq901_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq901 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzq901_init()
 
      #進入選單 Menu (='N')
      CALL azzq901_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzq901
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzq901.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzq901_init()

   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   CALL cl_set_combo_scc('l_gzdg003','212')

   CALL azzq901_default_search()
END FUNCTION

PRIVATE FUNCTION azzq901_default_search()

   #應用 qs27 樣板自動產生(Version:2)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " dzeb002 = '", g_argv[01], "' AND "
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF

END FUNCTION

PRIVATE FUNCTION azzq901_ui_dialog()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD

   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page

   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1

   CALL azzq901_b_fill()

   WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         CONSTRUCT g_wc ON dzeb002 FROM dzeb002

            ON ACTION controlp

         END CONSTRUCT
         CONSTRUCT g_wc2 ON dzebl003 FROM dzebl003

            ON ACTION controlp

         END CONSTRUCT
         
         DISPLAY ARRAY g_gzdg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL azzq901_detail_action_trans()

               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL azzq901_b_fill2()
               LET g_action_choice = lc_action_choice_old
         END DISPLAY

         DISPLAY ARRAY g_gzdg2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
         END DISPLAY

         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL azzq901_detail_action_trans()

         AFTER DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
            IF cl_null(g_wc) THEN
               LET g_wc2 = " 1=1"
            END IF
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL azzq901_b_fill()

            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF

         ON ACTION agendum   # 待辦事項
            CALL cl_user_overview()

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzdg_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_gzdg2_d)
               LET g_export_id[2]   = "s_detail2"

               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION datarefresh   # 重新整理
            CALL azzq901_b_fill()

         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF

         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL azzq901_b_fill()

         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL azzq901_b_fill()

         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL azzq901_b_fill()

         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL azzq901_b_fill()

         #應用 qs16 樣板自動產生(Version:2)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL azzq901_filter()
            EXIT DIALOG

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
            END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
            END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
            END IF

         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

         ON ACTION qbeclear   # 條件清除
            CLEAR FORM

      END DIALOG
      
      IF li_exit THEN
         EXIT WHILE
      END IF

   END WHILE

END FUNCTION

PRIVATE FUNCTION azzq901_b_fill()
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
else display g_wc2
   END IF
   
   LET ls_sql_rank = "SELECT dzeb001,dzeb002,DENSE_RANK() OVER( ORDER BY dzeb001,dzeb002) AS RANK ",
                      " FROM dzeb_t "

display "bg:",g_wc2
   IF g_wc2.getIndexOf("1=1",1) THEN
      LET ls_sql_rank = ls_sql_rank," WHERE 1=1 AND ",g_wc
   ELSE
      #如果來自於另一張表dzebl_t
      LET ls_sql_rank = ls_sql_rank,",dzebl_t WHERE dzebl001=dzeb002 AND dzebl002 ='",g_lang CLIPPED,"' ",
                                    " AND ",g_wc," AND ",g_wc2                           
   END IF

   LET ls_sql_rank = ls_sql_rank, " AND ", g_wc_filter

   CALL g_gzdg_d.clear()
   CALL g_gzdg2_d.clear()

   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1

   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:6)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)

   LET ls_sql_rank = ls_sql_rank,
                     " ORDER BY dzeb001,dzeb002 "

   LET g_sql = "SELECT COUNT(*) FROM (",ls_sql_rank,")"

   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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

   LET g_sql = "SELECT dzeb001,dzeb002 ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page

   PREPARE azzq901_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzq901_pb

   OPEN b_fill_curs

   FOREACH b_fill_curs INTO g_gzdg_d[l_ac].dzeb001,g_gzdg_d[l_ac].dzeb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      SELECT dzeal003 INTO g_gzdg_d[l_ac].dzeal003 FROM dzeal_t 
       WHERE dzeal001 = g_gzdg_d[l_ac].dzeb001 AND dzeal002 = g_lang
      SELECT dzebl003 INTO g_gzdg_d[l_ac].dzebl003 FROM dzebl_t 
       WHERE dzebl001 = g_gzdg_d[l_ac].dzeb002 AND dzebl002 = g_lang
       
      CALL azzq901_detail_show("'1'")

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

   CALL g_gzdg_d.deleteElement(g_gzdg_d.getLength())
   CALL g_gzdg2_d.deleteElement(g_gzdg2_d.getLength())

   LET g_error_show = 0

   LET g_detail_cnt = g_gzdg_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0

   #應用 qs06 樣板自動產生(Version:2)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE azzq901_pb

   #調整單身index指標，避免翻頁後指到空白筆數
   CALL azzq901_detail_index_setting()

   #重新計算單身筆數並呈現
   CALL azzq901_detail_action_trans()

   LET l_ac = 1
   CALL azzq901_b_fill2()

END FUNCTION

PRIVATE FUNCTION azzq901_b_fill2()
   DEFINE li_ac           LIKE type_t.num10

   LET li_ac = l_ac
   LET g_sql = "SELECT gzdg001,gzdg003,gzdg004 ",
                " FROM gzdg_t ",
               " WHERE gzdg002 = '",g_gzdg_d[li_ac].dzeb001 CLIPPED,"' "

   PREPARE azzq901_detail2_pb FROM g_sql
   DECLARE b_fill2_curs CURSOR FOR azzq901_detail2_pb
   OPEN b_fill2_curs

   LET l_ac = 1
   FOREACH b_fill2_curs INTO g_gzdg2_d[l_ac].gzdg001,g_gzdg2_d[l_ac].gzdg003,g_gzdg2_d[l_ac].gzdg004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      SELECT gzdel003 INTO g_gzdg2_d[l_ac].gzdel003 FROM gzdel_t 
       WHERE gzdel001 = g_gzdg2_d[l_ac].gzdg001 AND gzdel002 = g_lang
      IF SQLCA.SQLCODE THEN
         SELECT gzzal003 INTO g_gzdg2_d[l_ac].gzdel003 FROM gzzal_t 
          WHERE gzzal001 = g_gzdg2_d[l_ac].gzdg001 AND gzzal002 = g_lang
      END IF
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

   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx

   LET l_ac = li_ac

END FUNCTION

PRIVATE FUNCTION azzq901_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING

   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
   END IF

   IF ps_page.getIndexOf("'2'",1) > 0 THEN
   END IF

END FUNCTION

PRIVATE FUNCTION azzq901_filter()
   DEFINE  ls_result   STRING

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:4)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON gzdg002,gzdg001,gzdg004
                          FROM s_detail1[1].b_gzdg002,s_detail2[1].b_gzdg001,s_detail2[1].b_gzdg004

         BEFORE CONSTRUCT
                     DISPLAY azzq901_filter_parser('gzdg002') TO s_detail1[1].b_gzdg002
            DISPLAY azzq901_filter_parser('gzdg001') TO s_detail2[1].b_gzdg001
            DISPLAY azzq901_filter_parser('gzdg004') TO s_detail2[1].b_gzdg004


         #單身公用欄位開窗相關處理


         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_gzdg002>>----
         #Ctrlp:construct.c.filter.page1.b_gzdg002
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_gzdg002
            #add-point:ON ACTION controlp INFIELD b_gzdg002

            #END add-point

         #----<<b_gzdg001>>----
         #Ctrlp:construct.c.filter.page2.b_gzdg001
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_gzdg001
            #add-point:ON ACTION controlp INFIELD b_gzdg001

            #END add-point

         #----<<b_gzdg004>>----
         #Ctrlp:construct.c.filter.page2.b_gzdg004
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_gzdg004
            #add-point:ON ACTION controlp INFIELD b_gzdg004

            #END add-point



      END CONSTRUCT

      #add-point:filter段add_cs

      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG






   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF

      CALL azzq901_filter_show('gzdg002','b_gzdg002')
   CALL azzq901_filter_show('gzdg001','b_gzdg001')
   CALL azzq901_filter_show('gzdg004','b_gzdg004')


   CALL azzq901_b_fill()

   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)

END FUNCTION

PRIVATE FUNCTION azzq901_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}

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

PRIVATE FUNCTION azzq901_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = azzq901_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

PRIVATE FUNCTION azzq901_detail_action_trans()

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

PRIVATE FUNCTION azzq901_detail_index_setting()
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog


   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gzdg_d.getLength() AND g_gzdg_d.getLength() > 0
            LET g_detail_idx = g_gzdg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gzdg_d.getLength() THEN
               LET g_detail_idx = g_gzdg_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF

   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
