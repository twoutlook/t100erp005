#該程式已解開Section, 不再透過樣板產出!
{<section id="awsq500.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000009
#+ 
#+ Filename...: awsq500
#+ Description: PLM中間表資訊查詢作業
#+ Creator....: 05775(2015-10-19 09:09:13)
#+ Modifier...: 05775(2015-10-19 10:15:18) -SD/PR- 00000
 
{</section>}
 
{<section id="awsq500.global" >}
#應用 q02 樣板自動產生(Version:28)

 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_logv_d RECORD
       #statepic       LIKE type_t.chr1,
        
       l_logm         LIKE type_t.typeud021, 
       l_entid        LIKE type_t.chr10, 
       l_trantime     LIKE type_t.typeud021, 
       l_seqkey       LIKE type_t.chr20, 
       l_seqkeytotcnt LIKE type_t.num10, 
       l_reqxmltime   LIKE type_t.typeud021, 
       l_formid       LIKE type_t.chr5, 
       l_datastatus   LIKE type_t.chr1, 
       l_efseqkey     LIKE type_t.chr20, 
       l_starttime    LIKE type_t.typeud021, 
       l_endtime      LIKE type_t.typeud021 
                      END RECORD
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
DEFINE g_msgtxt       LIKE logr_t.logr005
DEFINE g_plm_db       STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_logv_d
DEFINE g_master_t                   type_g_logv_d
DEFINE g_logv_d          DYNAMIC ARRAY OF type_g_logv_d
DEFINE g_logv_d_t        type_g_logv_d
 
      
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
 
 
 
#add-point:自定義模組變數-客製(Module Variable)

##end add-point
 
#add-point:傳入參數說明
 
#end add-point
 
{</section>}
 
{<section id="awsq500.main" >}
 #應用 a26 樣板自動產生(Version:5)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用)

   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aws","")
 
   #add-point:作業初始化
   LET g_plm_db = ''
   CALL cl_eai_get_middb(g_dbs) RETURNING g_plm_db
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
 
   #end add-point
   
   #add-point:SQL_define
 
   #end add-point 
   #add-point:SQL_define
 
   #end add-point
 
   #add-point:main段define_sql
 
   #end add-point 
 
   #add-point:main段define_sql

   #end add-point 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsq500 WITH FORM cl_ap_formpath("aws",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL awsq500_init()   
 
      #進入選單 Menu (="N")
      CALL awsq500_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_awsq500
      
   END IF   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="awsq500.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION awsq500_init()
   #add-point:init段define-客製
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化
 
   #end add-point
 
   CALL awsq500_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="awsq500.default_search" >}
PRIVATE FUNCTION awsq500_default_search()
   #add-point:default_search段define-客製

   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
 
   #add-point:default_search段開始前
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " logm_pk = '", g_argv[01], "' AND "
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
   
   RETURN
   #不使用底下的Code
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:2)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
 
   #add-point:default_search段開始後

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION awsq500_ui_dialog()
   #add-point:ui_dialog段define-客製

   #end add-point 
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
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL awsq500_b_fill()
   ELSE
      CALL awsq500_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_logv_d.clear()
 
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
 
         CALL awsq500_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_logv_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL awsq500_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL awsq500_detail_action_trans()
               #add-point:input段before row
               CALL awsq500_get_msg(g_logv_d[l_ac].l_logm)
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為

            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL awsq500_detail_action_trans()
 
            #add-point:ui_dialog段before dialog
 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:2)
         #ON ACTION insert
         #   LET g_action_choice="insert"
         #   IF cl_auth_chk_act("insert") THEN
         #      CALL awsq500_insert()
               #add-point:ON ACTION insert

               #END add-point      
         #   END IF
         
         ON ACTION button_site
            LET g_action_choice="button_site"
            IF cl_auth_chk_act("button_site") THEN 
               IF NOT cl_null(g_logv_d[l_ac].l_seqkey) THEN
                  LET la_param.prog = 'awsq501'
                  LET la_param.param[1] = '0'
                  LET la_param.param[2] = g_logv_d[l_ac].l_seqkey
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js) 
               END IF               
            END IF
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL awsq500_query()
               #add-point:ON ACTION query
               IF l_ac > 0 THEN
                  CALL awsq500_get_msg(g_logv_d[l_ac].l_logm)
               END IF
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               
               
            END IF
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL awsq500_filter()
            #add-point:ON ACTION filter

            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL awsq500_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_logv_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL awsq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL awsq500_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL awsq500_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL awsq500_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action

         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION awsq500_query()
   #add-point:query段define-客製

   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   LET g_msgtxt = NULL
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_logv_d.clear()
   
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
      CONSTRUCT g_wc_table ON logm_pk,entid,tran_time,seqkey,seqkey_totcnt,
                              reqxml_time,formid,datastatus,ef_seqkey,start_time,
                              end_time,msg_txt
           FROM s_detail1[1].l_logm,s_detail1[1].l_entid,s_detail1[1].l_trantime,
                s_detail1[1].l_seqkey,s_detail1[1].l_seqkeytotcnt,s_detail1[1].l_reqxmltime,
                s_detail1[1].l_formid,s_detail1[1].l_datastatus,s_detail1[1].l_efseqkey,
                s_detail1[1].l_starttime,s_detail1[1].l_endtime,l_msgtxt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<l_logm>>----
         #----<<l_entid>>----
         #----<<l_trantime>>----
         #----<<l_seqkey>>----
         #----<<l_seqkeytotcnt>>----
         #----<<l_reqxmltime>>----
         #----<<l_formid>>----
         #----<<l_datastatus>>----
         #----<<l_efseqkey>>----
         #----<<l_starttime>>----
         #----<<l_endtime>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct

      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL awsq500_b_fill()
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
 
{</section>}
 
{<section id="awsq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION awsq500_b_fill()
   #add-point:b_fill段define-客製

   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
 
 
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
   
   LET ls_sql_rank = "SELECT  UNIQUE logm_pk,entid,tran_time,seqkey,seqkey_totcnt,reqxml_time,formid,datastatus,ef_seqkey,start_time,end_time, ",
                     "       DENSE_RANK() OVER( ORDER BY plm_logm_t.logm_pk) AS RANK FROM ",g_plm_db CLIPPED,".plm_logm_t",
                     " WHERE entid= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("plm_logm_t"),
                     " ORDER BY plm_logm_t.logm_pk,entid,seqkey"
 
   #add-point:b_fill段rank_sql_after

   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count

   #end add-point
 
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
 
   LET g_sql = "SELECT logm_pk,entid,tran_time,seqkey,seqkey_totcnt,reqxml_time,formid,datastatus,ef_seqkey,start_time,end_time ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE awsq500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR awsq500_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_logv_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_logv_d[l_ac].l_logm,g_logv_d[l_ac].l_entid,g_logv_d[l_ac].l_trantime,g_logv_d[l_ac].l_seqkey, 
       g_logv_d[l_ac].l_seqkeytotcnt,g_logv_d[l_ac].l_reqxmltime,g_logv_d[l_ac].l_formid,g_logv_d[l_ac].l_datastatus, 
       g_logv_d[l_ac].l_efseqkey,g_logv_d[l_ac].l_starttime,g_logv_d[l_ac].l_endtime
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_logv_d[l_ac].statepic = cl_get_actipic(g_logv_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
 
      CALL awsq500_detail_show("'1'")      
 
      CALL awsq500_logv_t_mask()
 
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
   
 
   
   CALL g_logv_d.deleteElement(g_logv_d.getLength())   
 
   #add-point:陣列長度調整

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
   LET g_detail_cnt = g_logv_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE awsq500_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL awsq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL awsq500_detail_action_trans()
 
   IF g_logv_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL awsq500_fetch()
   END IF
   
   
 
   #add-point:b_fill段結束前

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION awsq500_fetch()
   #add-point:fetch段define-客製
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
 
   #add-point:陣列清空
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後
   
   #end add-point 
   
 
   #add-point:陣列筆數調整
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="awsq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION awsq500_detail_show(ps_page)
   #add-point:show段define-客製
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.filter" >}
#+ filter過濾功能
 
PRIVATE FUNCTION awsq500_filter()
   #add-point:filter段define-客製

   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭                         
      CONSTRUCT g_wc_filter ON logm_pk,entid,tran_time,seqkey,seqkey_totcnt,
                               reqxml_time,formid,datastatus,ef_seqkey,start_time,
                               end_time,msg_txt
           FROM s_detail1[1].l_logm,s_detail1[1].l_entid,s_detail1[1].l_trantime,
                s_detail1[1].l_seqkey,s_detail1[1].l_seqkeytotcnt,s_detail1[1].l_reqxmltime,
                s_detail1[1].l_formid,s_detail1[1].l_datastatus,s_detail1[1].l_efseqkey,
                s_detail1[1].l_starttime,s_detail1[1].l_endtime,l_msgtxt
 
         BEFORE CONSTRUCT
         
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
         #----<<l_logm>>----
         #----<<l_entid>>----
         #----<<l_trantime>>----
         #----<<l_seqkey>>----
         #----<<l_seqkeytotcnt>>----
         #----<<l_reqxmltime>>----
         #----<<l_formid>>----
         #----<<l_datastatus>>----
         #----<<l_efseqkey>>----
         #----<<l_starttime>>----
         #----<<l_endtime>>----
   
 
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
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
   
    
   CALL awsq500_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION awsq500_filter_parser(ps_field)
   #add-point:filter段define-客製
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
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
 
{</section>}
 
{<section id="awsq500.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION awsq500_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = awsq500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.insert" >}
#+ insert
PRIVATE FUNCTION awsq500_insert()
   #add-point:insert段define-客製
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="awsq500.modify" >}
#+ modify
PRIVATE FUNCTION awsq500_modify()
   #add-point:modify段define-客製
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.reproduce" >}
#+ reproduce
PRIVATE FUNCTION awsq500_reproduce()
   #add-point:reproduce段define-客製
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.delete" >}
#+ delete
PRIVATE FUNCTION awsq500_delete()
   #add-point:delete段define-客製
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION awsq500_detail_action_trans()
 
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
 
{</section>}
 
{<section id="awsq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION awsq500_detail_index_setting()
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
 
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_logv_d.getLength() AND g_logv_d.getLength() > 0
            LET g_detail_idx = g_logv_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_logv_d.getLength() THEN
               LET g_detail_idx = g_logv_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="awsq500.mask_functions" >}
 &include "erp/aws/awsq500_mask.4gl"
 
{</section>}
 
{<section id="awsq500.other_function" >}

################################################################################
# Descriptions...: 根據PLM中間檔key值抓取該錯誤訊息
# Memo...........:
# Usage..........: CALL awsq500_get_msg(p_logm_pk)
# Input parameter: p_logm_pk :LM中間檔key值
# Date & Author..: 15/10/19 By TSD.Tim
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq500_get_msg(p_logm_pk)
   DEFINE p_logm_pk    LIKE type_t.typeud021

   LET g_msgtxt = NULL
   LET g_sql = " SELECT msg_txt ",
               "   FROM ",g_plm_db CLIPPED,".plm_logm_t ",
               "  WHERE logm_pk = ? "
   PREPARE q500_sel_logm_t_p FROM g_sql
   DECLARE q500_sel_logm_t_c CURSOR FOR q500_sel_logm_t_p
   
   OPEN q500_sel_logm_t_c USING p_logm_pk
   FETCH q500_sel_logm_t_c INTO g_msgtxt
   CLOSE q500_sel_logm_t_c

   DISPLAY g_msgtxt TO FORMONLY.l_msgtxt
END FUNCTION

 
{</section>}
 
