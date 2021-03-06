#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-06-28 13:47:47), PR版次:0008(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000336
#+ Filename...: aooi400
#+ Description: 日曆檔維護作業
#+ Creator....: 02482(2013-07-01 00:00:00)
#+ Modifier...: 02295 -SD/PR- 00000
 
{</section>}
 
{<section id="aooi400.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_ooga_d RECORD
       oogastus LIKE ooga_t.oogastus, 
   ooga001 LIKE ooga_t.ooga001, 
   ooga002 LIKE ooga_t.ooga002, 
   ooga003 LIKE ooga_t.ooga003, 
   ooga011 LIKE ooga_t.ooga011, 
   ooga009 LIKE ooga_t.ooga009, 
   ooga010 LIKE ooga_t.ooga010, 
   ooga012 LIKE ooga_t.ooga012, 
   ooga013 LIKE ooga_t.ooga013, 
   ooga004 LIKE ooga_t.ooga004, 
   ooga004_desc LIKE type_t.chr500, 
   ooga005 LIKE ooga_t.ooga005, 
   ooga005_desc LIKE type_t.chr500, 
   ooga006 LIKE ooga_t.ooga006, 
   ooga006_desc LIKE type_t.chr500, 
   ooga007 LIKE ooga_t.ooga007, 
   ooga007_desc LIKE type_t.chr500, 
   ooga008 LIKE ooga_t.ooga008, 
   ooga008_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_ooga2_d RECORD
       ooga001 LIKE ooga_t.ooga001, 
   oogamodid LIKE ooga_t.oogamodid, 
   oogamodid_desc LIKE type_t.chr500, 
   oogamoddt DATETIME YEAR TO SECOND, 
   oogaownid LIKE ooga_t.oogaownid, 
   oogaownid_desc LIKE type_t.chr500, 
   oogaowndp LIKE ooga_t.oogaowndp, 
   oogaowndp_desc LIKE type_t.chr500, 
   oogacrtid LIKE ooga_t.oogacrtid, 
   oogacrtid_desc LIKE type_t.chr500, 
   oogacrtdp LIKE ooga_t.oogacrtdp, 
   oogacrtdp_desc LIKE type_t.chr500, 
   oogacrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_year               LIKE type_t.num5
DEFINE l_year_str           STRING
DEFINE l_date1              LIKE type_t.dat
DEFINE l_wc                 STRING
DEFINE l_date2              LIKE type_t.dat
#end add-point
 
#模組變數(Module Variables)
DEFINE g_ooga_d          DYNAMIC ARRAY OF type_g_ooga_d #單身變數
DEFINE g_ooga_d_t        type_g_ooga_d                  #單身備份
DEFINE g_ooga_d_o        type_g_ooga_d                  #單身備份
DEFINE g_ooga_d_mask_o   DYNAMIC ARRAY OF type_g_ooga_d #單身變數
DEFINE g_ooga_d_mask_n   DYNAMIC ARRAY OF type_g_ooga_d #單身變數
DEFINE g_ooga2_d   DYNAMIC ARRAY OF type_g_ooga2_d
DEFINE g_ooga2_d_t type_g_ooga2_d
DEFINE g_ooga2_d_o type_g_ooga2_d
DEFINE g_ooga2_d_mask_o DYNAMIC ARRAY OF type_g_ooga2_d
DEFINE g_ooga2_d_mask_n DYNAMIC ARRAY OF type_g_ooga2_d
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi400.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT oogastus,ooga001,ooga002,ooga003,ooga011,ooga009,ooga010,ooga012,ooga013, 
       ooga004,ooga005,ooga006,ooga007,ooga008,ooga001,oogamodid,oogamoddt,oogaownid,oogaowndp,oogacrtid, 
       oogacrtdp,oogacrtdt FROM ooga_t WHERE oogaent=? AND ooga001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi400_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi400 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi400_init()   
 
      #進入選單 Menu (="N")
      CALL aooi400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi400
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aooi400_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("ooga002",30)
   CALL cl_set_combo_scc("ooga002",30)
   LET l_year = YEAR(g_today)
   DISPLAY l_year TO year
   #end add-point
   
   CALL aooi400_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aooi400_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_ooga_d.clear()
         CALL g_ooga2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aooi400_init()
      END IF
   
      CALL aooi400_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_ooga_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               LET g_data_owner = g_ooga2_d[g_detail_idx].oogaownid   #(ver:35)
               LET g_data_dept = g_ooga2_d[g_detail_idx].oogaowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_ooga2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body2.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body2.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT l_year FROM year
            ATTRIBUTE(WITHOUT DEFAULTS)
               
            ON CHANGE year
               CALL aooi400_b_fill(g_wc2)
               
         END INPUT

         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail2", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL aooi400_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi400_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aooi400_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi400_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION week
            LET g_action_choice="week"
            IF cl_auth_chk_act("week") THEN
               
               #add-point:ON ACTION week name="menu.week"
                CALL aooi400_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi400_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pre
            LET g_action_choice="pre"
            IF cl_auth_chk_act("pre") THEN
               
               #add-point:ON ACTION pre name="menu.pre"
                LET l_year = l_year - 1
                CALL aooi400_b_fill(g_wc2)
                DISPLAY l_year TO year
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi400_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION nt
            LET g_action_choice="nt"
            IF cl_auth_chk_act("nt") THEN
               
               #add-point:ON ACTION nt name="menu.nt"
                LET l_year = l_year + 1
                CALL aooi400_b_fill(g_wc2)
                DISPLAY l_year TO year
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_ooga_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_ooga2_d)
               LET g_export_id[2]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG
            
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aooi400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi400_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_ooga_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON oogastus,ooga001,ooga002,ooga003,ooga011,ooga009,ooga010,ooga012,ooga013,ooga004, 
          ooga005,ooga006,ooga007,ooga008,oogamodid,oogamoddt,oogaownid,oogaowndp,oogacrtid,oogacrtdp, 
          oogacrtdt 
 
         FROM s_detail1[1].oogastus,s_detail1[1].ooga001,s_detail1[1].ooga002,s_detail1[1].ooga003,s_detail1[1].ooga011, 
             s_detail1[1].ooga009,s_detail1[1].ooga010,s_detail1[1].ooga012,s_detail1[1].ooga013,s_detail1[1].ooga004, 
             s_detail1[1].ooga005,s_detail1[1].ooga006,s_detail1[1].ooga007,s_detail1[1].ooga008,s_detail2[1].oogamodid, 
             s_detail2[1].oogamoddt,s_detail2[1].oogaownid,s_detail2[1].oogaowndp,s_detail2[1].oogacrtid, 
             s_detail2[1].oogacrtdp,s_detail2[1].oogacrtdt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oogacrtdt>>----
         AFTER FIELD oogacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oogamoddt>>----
         AFTER FIELD oogamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oogacnfdt>>----
         
         #----<<oogapstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogastus
            #add-point:BEFORE FIELD oogastus name="query.b.page1.oogastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogastus
            
            #add-point:AFTER FIELD oogastus name="query.a.page1.oogastus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oogastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogastus
            #add-point:ON ACTION controlp INFIELD oogastus name="query.c.page1.oogastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga001
            #add-point:BEFORE FIELD ooga001 name="query.b.page1.ooga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga001
            
            #add-point:AFTER FIELD ooga001 name="query.a.page1.ooga001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga001
            #add-point:ON ACTION controlp INFIELD ooga001 name="query.c.page1.ooga001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga002
            #add-point:BEFORE FIELD ooga002 name="query.b.page1.ooga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga002
            
            #add-point:AFTER FIELD ooga002 name="query.a.page1.ooga002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga002
            #add-point:ON ACTION controlp INFIELD ooga002 name="query.c.page1.ooga002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga003
            #add-point:BEFORE FIELD ooga003 name="query.b.page1.ooga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga003
            
            #add-point:AFTER FIELD ooga003 name="query.a.page1.ooga003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga003
            #add-point:ON ACTION controlp INFIELD ooga003 name="query.c.page1.ooga003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga011
            #add-point:BEFORE FIELD ooga011 name="query.b.page1.ooga011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga011
            
            #add-point:AFTER FIELD ooga011 name="query.a.page1.ooga011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga011
            #add-point:ON ACTION controlp INFIELD ooga011 name="query.c.page1.ooga011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga009
            #add-point:BEFORE FIELD ooga009 name="query.b.page1.ooga009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga009
            
            #add-point:AFTER FIELD ooga009 name="query.a.page1.ooga009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga009
            #add-point:ON ACTION controlp INFIELD ooga009 name="query.c.page1.ooga009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga010
            #add-point:BEFORE FIELD ooga010 name="query.b.page1.ooga010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga010
            
            #add-point:AFTER FIELD ooga010 name="query.a.page1.ooga010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga010
            #add-point:ON ACTION controlp INFIELD ooga010 name="query.c.page1.ooga010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga012
            #add-point:BEFORE FIELD ooga012 name="query.b.page1.ooga012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga012
            
            #add-point:AFTER FIELD ooga012 name="query.a.page1.ooga012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga012
            #add-point:ON ACTION controlp INFIELD ooga012 name="query.c.page1.ooga012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga013
            #add-point:BEFORE FIELD ooga013 name="query.b.page1.ooga013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga013
            
            #add-point:AFTER FIELD ooga013 name="query.a.page1.ooga013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.ooga013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga013
            #add-point:ON ACTION controlp INFIELD ooga013 name="query.c.page1.ooga013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ooga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga004
            #add-point:ON ACTION controlp INFIELD ooga004 name="construct.c.page1.ooga004"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "7" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件
            CALL q_oocq002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooga004  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooga004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga004
            #add-point:BEFORE FIELD ooga004 name="query.b.page1.ooga004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga004
            
            #add-point:AFTER FIELD ooga004 name="query.a.page1.ooga004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooga005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga005
            #add-point:ON ACTION controlp INFIELD ooga005 name="construct.c.page1.ooga005"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "8" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件
            CALL q_oocq002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooga005  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooga005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga005
            #add-point:BEFORE FIELD ooga005 name="query.b.page1.ooga005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga005
            
            #add-point:AFTER FIELD ooga005 name="query.a.page1.ooga005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooga006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga006
            #add-point:ON ACTION controlp INFIELD ooga006 name="construct.c.page1.ooga006"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "9" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件
            CALL q_oocq002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooga006  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooga006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga006
            #add-point:BEFORE FIELD ooga006 name="query.b.page1.ooga006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga006
            
            #add-point:AFTER FIELD ooga006 name="query.a.page1.ooga006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga007
            #add-point:ON ACTION controlp INFIELD ooga007 name="construct.c.page1.ooga007"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "10" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件
            CALL q_oocq002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooga007  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooga007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga007
            #add-point:BEFORE FIELD ooga007 name="query.b.page1.ooga007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga007
            
            #add-point:AFTER FIELD ooga007 name="query.a.page1.ooga007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooga008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga008
            #add-point:ON ACTION controlp INFIELD ooga008 name="construct.c.page1.ooga008"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "11" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件
            CALL q_oocq002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooga008  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooga008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga008
            #add-point:BEFORE FIELD ooga008 name="query.b.page1.ooga008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga008
            
            #add-point:AFTER FIELD ooga008 name="query.a.page1.ooga008"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page2.oogamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogamodid
            #add-point:ON ACTION controlp INFIELD oogamodid name="construct.c.page2.oogamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oogamodid  #顯示到畫面上

            NEXT FIELD oogamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogamodid
            #add-point:BEFORE FIELD oogamodid name="query.b.page2.oogamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogamodid
            
            #add-point:AFTER FIELD oogamodid name="query.a.page2.oogamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogamoddt
            #add-point:BEFORE FIELD oogamoddt name="query.b.page2.oogamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.oogaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogaownid
            #add-point:ON ACTION controlp INFIELD oogaownid name="construct.c.page2.oogaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oogaownid  #顯示到畫面上

            NEXT FIELD oogaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogaownid
            #add-point:BEFORE FIELD oogaownid name="query.b.page2.oogaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogaownid
            
            #add-point:AFTER FIELD oogaownid name="query.a.page2.oogaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oogaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogaowndp
            #add-point:ON ACTION controlp INFIELD oogaowndp name="construct.c.page2.oogaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oogaowndp  #顯示到畫面上

            NEXT FIELD oogaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogaowndp
            #add-point:BEFORE FIELD oogaowndp name="query.b.page2.oogaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogaowndp
            
            #add-point:AFTER FIELD oogaowndp name="query.a.page2.oogaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oogacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogacrtid
            #add-point:ON ACTION controlp INFIELD oogacrtid name="construct.c.page2.oogacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oogacrtid  #顯示到畫面上

            NEXT FIELD oogacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogacrtid
            #add-point:BEFORE FIELD oogacrtid name="query.b.page2.oogacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogacrtid
            
            #add-point:AFTER FIELD oogacrtid name="query.a.page2.oogacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oogacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogacrtdp
            #add-point:ON ACTION controlp INFIELD oogacrtdp name="construct.c.page2.oogacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oogacrtdp  #顯示到畫面上

            NEXT FIELD oogacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogacrtdp
            #add-point:BEFORE FIELD oogacrtdp name="query.b.page2.oogacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogacrtdp
            
            #add-point:AFTER FIELD oogacrtdp name="query.a.page2.oogacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogacrtdt
            #add-point:BEFORE FIELD oogacrtdt name="query.b.page2.oogacrtdt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT l_year FROM year

      END INPUT
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog name="query.before_dialog"
         
         #end add-point 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG 
   END DIALOG
 
   #add-point:query段after_construct name="query.after_construct"
   
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL aooi400_b_fill(g_wc2)
   LET g_data_owner = g_ooga2_d[g_detail_idx].oogaownid   #(ver:35)
   LET g_data_dept = g_ooga2_d[g_detail_idx].oogaowndp   #(ver:35)
 
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi400_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aooi400_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi400.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi400_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num10
   DEFINE  l_i                    LIKE type_t.num10
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num10
   DEFINE  li_reproduce_target    LIKE type_t.num10
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_insert               BOOLEAN
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_success               LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
 
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_ooga_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooga_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi400_b_fill(g_wc2)
            LET g_detail_cnt = g_ooga_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_ooga_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_ooga_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_ooga_d[l_ac].ooga001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ooga_d_t.* = g_ooga_d[l_ac].*  #BACKUP
               LET g_ooga_d_o.* = g_ooga_d[l_ac].*  #BACKUP
               IF NOT aooi400_lock_b("ooga_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi400_bcl INTO g_ooga_d[l_ac].oogastus,g_ooga_d[l_ac].ooga001,g_ooga_d[l_ac].ooga002, 
                      g_ooga_d[l_ac].ooga003,g_ooga_d[l_ac].ooga011,g_ooga_d[l_ac].ooga009,g_ooga_d[l_ac].ooga010, 
                      g_ooga_d[l_ac].ooga012,g_ooga_d[l_ac].ooga013,g_ooga_d[l_ac].ooga004,g_ooga_d[l_ac].ooga005, 
                      g_ooga_d[l_ac].ooga006,g_ooga_d[l_ac].ooga007,g_ooga_d[l_ac].ooga008,g_ooga2_d[l_ac].ooga001, 
                      g_ooga2_d[l_ac].oogamodid,g_ooga2_d[l_ac].oogamoddt,g_ooga2_d[l_ac].oogaownid, 
                      g_ooga2_d[l_ac].oogaowndp,g_ooga2_d[l_ac].oogacrtid,g_ooga2_d[l_ac].oogacrtdp, 
                      g_ooga2_d[l_ac].oogacrtdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ooga_d_t.ooga001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_ooga_d_mask_o[l_ac].* =  g_ooga_d[l_ac].*
                  CALL aooi400_ooga_t_mask()
                  LET g_ooga_d_mask_n[l_ac].* =  g_ooga_d[l_ac].*
                  
                  CALL aooi400_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi400_set_entry_b(l_cmd)
            CALL aooi400_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooga_d_t.* TO NULL
            INITIALIZE g_ooga_d_o.* TO NULL
            INITIALIZE g_ooga_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooga2_d[l_ac].oogaownid = g_user
      LET g_ooga2_d[l_ac].oogaowndp = g_dept
      LET g_ooga2_d[l_ac].oogacrtid = g_user
      LET g_ooga2_d[l_ac].oogacrtdp = g_dept 
      LET g_ooga2_d[l_ac].oogacrtdt = cl_get_current()
      LET g_ooga2_d[l_ac].oogamodid = g_user
      LET g_ooga2_d[l_ac].oogamoddt = cl_get_current()
      LET g_ooga_d[l_ac].oogastus = ''
 
 
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_ooga_d_t.* = g_ooga_d[l_ac].*     #新輸入資料
            LET g_ooga_d_o.* = g_ooga_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ooga_d[li_reproduce_target].* = g_ooga_d[li_reproduce].*
               LET g_ooga2_d[li_reproduce_target].* = g_ooga2_d[li_reproduce].*
 
               LET g_ooga_d[g_ooga_d.getLength()].ooga001 = NULL
 
            END IF
            
 
 
            CALL aooi400_set_entry_b(l_cmd)
            CALL aooi400_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_ooga2_d[l_ac].oogaownid = g_user
            LET g_ooga2_d[l_ac].oogaowndp = g_dept
            LET g_ooga2_d[l_ac].oogacrtid = g_user
            LET g_ooga2_d[l_ac].oogacrtdp = g_dept 
            LET g_ooga2_d[l_ac].oogacrtdt = cl_get_current()
            LET g_ooga2_d[l_ac].oogamodid = g_user
            LET g_ooga2_d[l_ac].oogamoddt = cl_get_current()
            LET g_ooga_d[l_ac].oogastus = "Y"
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM ooga_t 
             WHERE oogaent = g_enterprise AND ooga001 = g_ooga_d[l_ac].ooga001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooga_d[g_detail_idx].ooga001
               CALL aooi400_insert_b('ooga_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_ooga_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ooga_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi400_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (ooga001 = '", g_ooga_d[l_ac].ooga001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               
               #end add-point   
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point   
               
               DELETE FROM ooga_t
                WHERE oogaent = g_enterprise AND 
                      ooga001 = g_ooga_d_t.ooga001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ooga_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aooi400_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_ooga_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aooi400_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_ooga_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooga_d_t.ooga001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aooi400_delete_b('ooga_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_ooga_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogastus
            #add-point:BEFORE FIELD oogastus name="input.b.page1.oogastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogastus
            
            #add-point:AFTER FIELD oogastus name="input.a.page1.oogastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogastus
            #add-point:ON CHANGE oogastus name="input.g.page1.oogastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga001
            #add-point:BEFORE FIELD ooga001 name="input.b.page1.ooga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga001
            
            #add-point:AFTER FIELD ooga001 name="input.a.page1.ooga001"
 
            DISPLAY "" TO s_detail1[l_ac].ooga002
            DISPLAY "" TO s_detail1[l_ac].ooga003
            IF NOT aooi400_chk_ooga001(l_cmd) THEN
               LET g_ooga_d[l_ac].ooga001 = g_ooga_d_t.ooga001
               CALL aooi400_desc()
               IF cl_null(g_ooga_d[l_ac].ooga003) THEN
                  LET g_ooga_d[l_ac].ooga003 = g_ooga_d_t.ooga003
               END IF
               NEXT FIELD ooga001
            END IF
            CALL aooi400_desc()
            IF cl_null(g_ooga_d[l_ac].ooga003) THEN
               LET g_ooga_d[l_ac].ooga003 = g_ooga_d_t.ooga003
               NEXT FIELD ooga003
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga001
            #add-point:ON CHANGE ooga001 name="input.g.page1.ooga001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga002
            #add-point:BEFORE FIELD ooga002 name="input.b.page1.ooga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga002
            
            #add-point:AFTER FIELD ooga002 name="input.a.page1.ooga002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga002
            #add-point:ON CHANGE ooga002 name="input.g.page1.ooga002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga003
            #add-point:BEFORE FIELD ooga003 name="input.b.page1.ooga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga003
            
            #add-point:AFTER FIELD ooga003 name="input.a.page1.ooga003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga003
            #add-point:ON CHANGE ooga003 name="input.g.page1.ooga003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooga_d[l_ac].ooga011,"1","1","53","1","azz-00087",1) THEN
               NEXT FIELD ooga011
            END IF 
 
 
 
            #add-point:AFTER FIELD ooga011 name="input.a.page1.ooga011"
            IF NOT cl_null(g_ooga_d[l_ac].ooga011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga011
            #add-point:BEFORE FIELD ooga011 name="input.b.page1.ooga011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga011
            #add-point:ON CHANGE ooga011 name="input.g.page1.ooga011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooga_d[l_ac].ooga009,"1","1","13","1","azz-00087",1) THEN
               NEXT FIELD ooga009
            END IF 
 
 
 
            #add-point:AFTER FIELD ooga009 name="input.a.page1.ooga009"
            IF NOT cl_null(g_ooga_d[l_ac].ooga009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga009
            #add-point:BEFORE FIELD ooga009 name="input.b.page1.ooga009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga009
            #add-point:ON CHANGE ooga009 name="input.g.page1.ooga009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooga_d[l_ac].ooga010,"1","1","4","1","azz-00087",1) THEN
               NEXT FIELD ooga010
            END IF 
 
 
 
            #add-point:AFTER FIELD ooga010 name="input.a.page1.ooga010"
            IF NOT cl_null(g_ooga_d[l_ac].ooga010) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga010
            #add-point:BEFORE FIELD ooga010 name="input.b.page1.ooga010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga010
            #add-point:ON CHANGE ooga010 name="input.g.page1.ooga010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooga_d[l_ac].ooga012,"1","1","12","1","azz-00087",1) THEN
               NEXT FIELD ooga012
            END IF 
 
 
 
            #add-point:AFTER FIELD ooga012 name="input.a.page1.ooga012"
            IF NOT cl_null(g_ooga_d[l_ac].ooga012) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga012
            #add-point:BEFORE FIELD ooga012 name="input.b.page1.ooga012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga012
            #add-point:ON CHANGE ooga012 name="input.g.page1.ooga012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooga_d[l_ac].ooga013,"1","1","5","1","azz-00087",1) THEN
               NEXT FIELD ooga013
            END IF 
 
 
 
            #add-point:AFTER FIELD ooga013 name="input.a.page1.ooga013"
            IF NOT cl_null(g_ooga_d[l_ac].ooga013) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga013
            #add-point:BEFORE FIELD ooga013 name="input.b.page1.ooga013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga013
            #add-point:ON CHANGE ooga013 name="input.g.page1.ooga013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga004
            
            #add-point:AFTER FIELD ooga004 name="input.a.page1.ooga004"
            DISPLAY  "" TO s_detail1[l_ac].ooga004_desc
            IF NOT cl_null(g_ooga_d[l_ac].ooga004) THEN   
               CALL s_azzi650_chk_exist('7',g_ooga_d[l_ac].ooga004) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ooga_d[l_ac].ooga004 = g_ooga_d_t.ooga004
                  CALL aooi400_desc1()
                  NEXT FIELD ooga004
               END IF
            END IF
            CALL aooi400_desc1()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga004
            #add-point:BEFORE FIELD ooga004 name="input.b.page1.ooga004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga004
            #add-point:ON CHANGE ooga004 name="input.g.page1.ooga004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga005
            
            #add-point:AFTER FIELD ooga005 name="input.a.page1.ooga005"
            DISPLAY  "" TO s_detail1[l_ac].ooga005_desc
            IF NOT cl_null(g_ooga_d[l_ac].ooga005) THEN   
               CALL s_azzi650_chk_exist('8',g_ooga_d[l_ac].ooga005) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ooga_d[l_ac].ooga005 = g_ooga_d_t.ooga005
                  CALL aooi400_desc1()
                  NEXT FIELD ooga005
               END IF
            END IF
            CALL aooi400_desc1()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga005
            #add-point:BEFORE FIELD ooga005 name="input.b.page1.ooga005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga005
            #add-point:ON CHANGE ooga005 name="input.g.page1.ooga005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga006
            
            #add-point:AFTER FIELD ooga006 name="input.a.page1.ooga006"
            DISPLAY  "" TO s_detail1[l_ac].ooga006_desc
            IF NOT cl_null(g_ooga_d[l_ac].ooga006) THEN   
               CALL s_azzi650_chk_exist('9',g_ooga_d[l_ac].ooga006) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ooga_d[l_ac].ooga006 = g_ooga_d_t.ooga006
                  CALL aooi400_desc1()
                  NEXT FIELD ooga006
               END IF
            END IF
            CALL aooi400_desc1()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga006
            #add-point:BEFORE FIELD ooga006 name="input.b.page1.ooga006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga006
            #add-point:ON CHANGE ooga006 name="input.g.page1.ooga006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga007
            
            #add-point:AFTER FIELD ooga007 name="input.a.page1.ooga007"
           DISPLAY  "" TO s_detail1[l_ac].ooga007_desc
           IF NOT cl_null(g_ooga_d[l_ac].ooga007) THEN   
               CALL s_azzi650_chk_exist('10',g_ooga_d[l_ac].ooga007) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ooga_d[l_ac].ooga007 = g_ooga_d_t.ooga007
                  CALL aooi400_desc1()
                  NEXT FIELD ooga007
               END IF
            END IF
            CALL aooi400_desc1()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga007
            #add-point:BEFORE FIELD ooga007 name="input.b.page1.ooga007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga007
            #add-point:ON CHANGE ooga007 name="input.g.page1.ooga007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooga008
            
            #add-point:AFTER FIELD ooga008 name="input.a.page1.ooga008"
            DISPLAY  "" TO s_detail1[l_ac].ooga008_desc
            IF NOT cl_null(g_ooga_d[l_ac].ooga008) THEN   
               CALL s_azzi650_chk_exist('11',g_ooga_d[l_ac].ooga008) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ooga_d[l_ac].ooga008 = g_ooga_d_t.ooga008
                  CALL aooi400_desc1()
                  NEXT FIELD ooga008
               END IF
            END IF
            CALL aooi400_desc1()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooga008
            #add-point:BEFORE FIELD ooga008 name="input.b.page1.ooga008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooga008
            #add-point:ON CHANGE ooga008 name="input.g.page1.ooga008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oogastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogastus
            #add-point:ON ACTION controlp INFIELD oogastus name="input.c.page1.oogastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga001
            #add-point:ON ACTION controlp INFIELD ooga001 name="input.c.page1.ooga001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga002
            #add-point:ON ACTION controlp INFIELD ooga002 name="input.c.page1.ooga002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga003
            #add-point:ON ACTION controlp INFIELD ooga003 name="input.c.page1.ooga003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga011
            #add-point:ON ACTION controlp INFIELD ooga011 name="input.c.page1.ooga011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga009
            #add-point:ON ACTION controlp INFIELD ooga009 name="input.c.page1.ooga009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga010
            #add-point:ON ACTION controlp INFIELD ooga010 name="input.c.page1.ooga010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga012
            #add-point:ON ACTION controlp INFIELD ooga012 name="input.c.page1.ooga012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga013
            #add-point:ON ACTION controlp INFIELD ooga013 name="input.c.page1.ooga013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga004
            #add-point:ON ACTION controlp INFIELD ooga004 name="input.c.page1.ooga004"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooga_d[l_ac].ooga004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "7" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooga_d[l_ac].ooga004 = g_qryparam.return1       #將開窗取得的值回傳到變數
            
            DISPLAY g_ooga_d[l_ac].ooga004 TO ooga004              #顯示到畫面上
            CALL aooi400_desc1()
            LET g_qryparam.where = ""                                             #清空條件
            NEXT FIELD ooga004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga005
            #add-point:ON ACTION controlp INFIELD ooga005 name="input.c.page1.ooga005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooga_d[l_ac].ooga005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooga_d[l_ac].ooga005 = g_qryparam.return1              #將開窗取得的值回傳到變數
           
            DISPLAY g_ooga_d[l_ac].ooga005 TO ooga005              #顯示到畫面上
            CALL aooi400_desc1()
            LET g_qryparam.where = ""                                             #清空條件
            NEXT FIELD ooga005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga006
            #add-point:ON ACTION controlp INFIELD ooga006 name="input.c.page1.ooga006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooga_d[l_ac].ooga006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "9" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooga_d[l_ac].ooga006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooga_d[l_ac].ooga006 TO ooga006              #顯示到畫面上
            CALL aooi400_desc1()
            LET g_qryparam.where = ""                                             #清空條件
            NEXT FIELD ooga006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga007
            #add-point:ON ACTION controlp INFIELD ooga007 name="input.c.page1.ooga007"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooga_d[l_ac].ooga007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "10" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooga_d[l_ac].ooga007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooga_d[l_ac].ooga007 TO ooga007              #顯示到畫面上
            CALL aooi400_desc1()
            LET g_qryparam.where = ""                                             #清空條件
            NEXT FIELD ooga007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooga008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooga008
            #add-point:ON ACTION controlp INFIELD ooga008 name="input.c.page1.ooga008"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooga_d[l_ac].ooga008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "11" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #過濾條件

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooga_d[l_ac].ooga008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooga_d[l_ac].ooga008 TO ooga008              #顯示到畫面上
            CALL aooi400_desc1()
            LET g_qryparam.where = ""                                             #清空條件
            NEXT FIELD ooga008                          #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aooi400_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_ooga_d[l_ac].* = g_ooga_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #add-point:單身取消時 name="input.body.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_ooga_d[l_ac].ooga001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_ooga_d[l_ac].* = g_ooga_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_ooga2_d[l_ac].oogamodid = g_user 
LET g_ooga2_d[l_ac].oogamoddt = cl_get_current()
LET g_ooga2_d[l_ac].oogamodid_desc = cl_get_username(g_ooga2_d[l_ac].oogamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi400_ooga_t_mask_restore('restore_mask_o')
 
               UPDATE ooga_t SET (oogastus,ooga001,ooga002,ooga003,ooga011,ooga009,ooga010,ooga012,ooga013, 
                   ooga004,ooga005,ooga006,ooga007,ooga008,oogamodid,oogamoddt,oogaownid,oogaowndp,oogacrtid, 
                   oogacrtdp,oogacrtdt) = (g_ooga_d[l_ac].oogastus,g_ooga_d[l_ac].ooga001,g_ooga_d[l_ac].ooga002, 
                   g_ooga_d[l_ac].ooga003,g_ooga_d[l_ac].ooga011,g_ooga_d[l_ac].ooga009,g_ooga_d[l_ac].ooga010, 
                   g_ooga_d[l_ac].ooga012,g_ooga_d[l_ac].ooga013,g_ooga_d[l_ac].ooga004,g_ooga_d[l_ac].ooga005, 
                   g_ooga_d[l_ac].ooga006,g_ooga_d[l_ac].ooga007,g_ooga_d[l_ac].ooga008,g_ooga2_d[l_ac].oogamodid, 
                   g_ooga2_d[l_ac].oogamoddt,g_ooga2_d[l_ac].oogaownid,g_ooga2_d[l_ac].oogaowndp,g_ooga2_d[l_ac].oogacrtid, 
                   g_ooga2_d[l_ac].oogacrtdp,g_ooga2_d[l_ac].oogacrtdt)
                WHERE oogaent = g_enterprise AND
                  ooga001 = g_ooga_d_t.ooga001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooga_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooga_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooga_d[g_detail_idx].ooga001
               LET gs_keys_bak[1] = g_ooga_d_t.ooga001
               CALL aooi400_update_b('ooga_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_ooga_d_t)
                     LET g_log2 = util.JSON.stringify(g_ooga_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi400_ooga_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aooi400_unlock_b("ooga_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_ooga_d[l_ac].* = g_ooga_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_ooga_d[li_reproduce_target].* = g_ooga_d[li_reproduce].*
               LET g_ooga2_d[li_reproduce_target].* = g_ooga2_d[li_reproduce].*
 
               LET g_ooga_d[li_reproduce_target].ooga001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_ooga_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_ooga_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_ooga2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aooi400_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
      
      #add-point:before_more_input name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD oogastus
            WHEN "s_detail2"
               NEXT FIELD ooga001_2
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
    
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_ooga_d[g_detail_idx].ooga001) THEN
         CALL g_ooga_d.deleteElement(g_detail_idx)
         CALL g_ooga2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_ooga_d[g_detail_idx].* = g_ooga_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aooi400_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi400_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_ooga_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aooi400_lock_b("ooga_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("ooga_t","oogaownid") THEN
            LET g_data_owner = g_ooga2_d[g_detail_idx].oogaownid
            LET g_data_dept = g_ooga2_d[g_detail_idx].oogaowndp
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_ooga_d.getLength()
      IF g_ooga_d[li_idx].ooga001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM ooga_t
          WHERE oogaent = g_enterprise AND 
                ooga001 = g_ooga_d[li_idx].ooga001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooga_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
 
            
 
 
            
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooga_d_t.ooga001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aooi400_delete_b('ooga_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   CALL s_transaction_end('Y','0')
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL aooi400_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aooi400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi400_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   IF cl_null(l_year) THEN
      LET l_wc = ""
   ELSE
      LET l_year_str = l_year,'01','01'
      LET l_date1 = l_year_str
      LET l_year_str = l_year,'12','31'
      LET l_date2 = l_year_str
      LET l_wc = " AND ooga001 >= '",l_date1,"' AND ooga001 <= '",l_date2,"'"
   END IF
   LET p_wc2 = p_wc2 CLIPPED,l_wc
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.oogastus,t0.ooga001,t0.ooga002,t0.ooga003,t0.ooga011,t0.ooga009, 
       t0.ooga010,t0.ooga012,t0.ooga013,t0.ooga004,t0.ooga005,t0.ooga006,t0.ooga007,t0.ooga008,t0.ooga001, 
       t0.oogamodid,t0.oogamoddt,t0.oogaownid,t0.oogaowndp,t0.oogacrtid,t0.oogacrtdp,t0.oogacrtdt ,t1.oocql004 , 
       t2.oocql004 ,t3.oocql004 ,t4.oocql004 ,t5.oocql004 ,t6.ooag011 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooefl003 FROM ooga_t t0",
               "",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='7' AND t1.oocql002=t0.ooga004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='8' AND t2.oocql002=t0.ooga005 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='9' AND t3.oocql002=t0.ooga006 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='10' AND t4.oocql002=t0.ooga007 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='11' AND t5.oocql002=t0.ooga008 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.oogamodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.oogaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.oogaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.oogacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.oogacrtdp AND t10.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.oogaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("ooga_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND oogaowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("ooga_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND oogaownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("ooga_t"),
                      " ORDER BY t0.ooga001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooga_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aooi400_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aooi400_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_ooga_d.clear()
   CALL g_ooga2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_ooga_d[l_ac].oogastus,g_ooga_d[l_ac].ooga001,g_ooga_d[l_ac].ooga002,g_ooga_d[l_ac].ooga003, 
       g_ooga_d[l_ac].ooga011,g_ooga_d[l_ac].ooga009,g_ooga_d[l_ac].ooga010,g_ooga_d[l_ac].ooga012,g_ooga_d[l_ac].ooga013, 
       g_ooga_d[l_ac].ooga004,g_ooga_d[l_ac].ooga005,g_ooga_d[l_ac].ooga006,g_ooga_d[l_ac].ooga007,g_ooga_d[l_ac].ooga008, 
       g_ooga2_d[l_ac].ooga001,g_ooga2_d[l_ac].oogamodid,g_ooga2_d[l_ac].oogamoddt,g_ooga2_d[l_ac].oogaownid, 
       g_ooga2_d[l_ac].oogaowndp,g_ooga2_d[l_ac].oogacrtid,g_ooga2_d[l_ac].oogacrtdp,g_ooga2_d[l_ac].oogacrtdt, 
       g_ooga_d[l_ac].ooga004_desc,g_ooga_d[l_ac].ooga005_desc,g_ooga_d[l_ac].ooga006_desc,g_ooga_d[l_ac].ooga007_desc, 
       g_ooga_d[l_ac].ooga008_desc,g_ooga2_d[l_ac].oogamodid_desc,g_ooga2_d[l_ac].oogaownid_desc,g_ooga2_d[l_ac].oogaowndp_desc, 
       g_ooga2_d[l_ac].oogacrtid_desc,g_ooga2_d[l_ac].oogacrtdp_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
#      CALL aooi400_desc1()
      #end add-point
      
      CALL aooi400_detail_show()      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_ooga_d.deleteElement(g_ooga_d.getLength())   
   CALL g_ooga2_d.deleteElement(g_ooga2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_ooga_d.getLength()
      LET g_ooga2_d[l_ac].ooga001 = g_ooga_d[l_ac].ooga001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_ooga_d.getLength() THEN
      LET l_ac = g_ooga_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_ooga_d.getLength()
      LET g_ooga_d_mask_o[l_ac].* =  g_ooga_d[l_ac].*
      CALL aooi400_ooga_t_mask()
      LET g_ooga_d_mask_n[l_ac].* =  g_ooga_d[l_ac].*
   END FOR
   
   LET g_ooga2_d_mask_o.* =  g_ooga2_d.*
   FOR l_ac = 1 TO g_ooga2_d.getLength()
      LET g_ooga2_d_mask_o[l_ac].* =  g_ooga2_d[l_ac].*
      CALL aooi400_ooga_t_mask()
      LET g_ooga2_d_mask_n[l_ac].* =  g_ooga2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_ooga_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aooi400_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooi400_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga_d[l_ac].ooga004
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='7' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga_d[l_ac].ooga004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga_d[l_ac].ooga004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga_d[l_ac].ooga005
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga_d[l_ac].ooga005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga_d[l_ac].ooga005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga_d[l_ac].ooga006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='9' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga_d[l_ac].ooga006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga_d[l_ac].ooga006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga_d[l_ac].ooga007
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='10' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga_d[l_ac].ooga007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga_d[l_ac].ooga007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga_d[l_ac].ooga008
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='11' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga_d[l_ac].ooga008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga_d[l_ac].ooga008_desc

   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga2_d[l_ac].oogamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_ooga2_d[l_ac].oogamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga2_d[l_ac].oogamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga2_d[l_ac].oogaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_ooga2_d[l_ac].oogaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga2_d[l_ac].oogaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga2_d[l_ac].oogaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga2_d[l_ac].oogaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga2_d[l_ac].oogaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga2_d[l_ac].oogacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_ooga2_d[l_ac].oogacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga2_d[l_ac].oogacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_ooga2_d[l_ac].oogacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_ooga2_d[l_ac].oogacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_ooga2_d[l_ac].oogacrtdp_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi400_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
 
   #end add-point
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段control name="set_entry_b.set_entry_b"
   
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aooi400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi400_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
 
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aooi400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi400_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " ooga001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aooi400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi400_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "ooga_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'ooga_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM ooga_t
          WHERE oogaent = g_enterprise AND
            ooga001 = ps_keys_bak[1]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_ooga_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_ooga2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi400_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "ooga_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO ooga_t
                  (oogaent,
                   ooga001
                   ,oogastus,ooga002,ooga003,ooga011,ooga009,ooga010,ooga012,ooga013,ooga004,ooga005,ooga006,ooga007,ooga008,oogamodid,oogamoddt,oogaownid,oogaowndp,oogacrtid,oogacrtdp,oogacrtdt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_ooga_d[l_ac].oogastus,g_ooga_d[l_ac].ooga002,g_ooga_d[l_ac].ooga003,g_ooga_d[l_ac].ooga011, 
                       g_ooga_d[l_ac].ooga009,g_ooga_d[l_ac].ooga010,g_ooga_d[l_ac].ooga012,g_ooga_d[l_ac].ooga013, 
                       g_ooga_d[l_ac].ooga004,g_ooga_d[l_ac].ooga005,g_ooga_d[l_ac].ooga006,g_ooga_d[l_ac].ooga007, 
                       g_ooga_d[l_ac].ooga008,g_ooga2_d[l_ac].oogamodid,g_ooga2_d[l_ac].oogamoddt,g_ooga2_d[l_ac].oogaownid, 
                       g_ooga2_d[l_ac].oogaowndp,g_ooga2_d[l_ac].oogacrtid,g_ooga2_d[l_ac].oogacrtdp, 
                       g_ooga2_d[l_ac].oogacrtdt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooga_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "ooga_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "ooga_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE ooga_t 
         SET (ooga001
              ,oogastus,ooga002,ooga003,ooga011,ooga009,ooga010,ooga012,ooga013,ooga004,ooga005,ooga006,ooga007,ooga008,oogamodid,oogamoddt,oogaownid,oogaowndp,oogacrtid,oogacrtdp,oogacrtdt) 
              = 
             (ps_keys[1]
              ,g_ooga_d[l_ac].oogastus,g_ooga_d[l_ac].ooga002,g_ooga_d[l_ac].ooga003,g_ooga_d[l_ac].ooga011, 
                  g_ooga_d[l_ac].ooga009,g_ooga_d[l_ac].ooga010,g_ooga_d[l_ac].ooga012,g_ooga_d[l_ac].ooga013, 
                  g_ooga_d[l_ac].ooga004,g_ooga_d[l_ac].ooga005,g_ooga_d[l_ac].ooga006,g_ooga_d[l_ac].ooga007, 
                  g_ooga_d[l_ac].ooga008,g_ooga2_d[l_ac].oogamodid,g_ooga2_d[l_ac].oogamoddt,g_ooga2_d[l_ac].oogaownid, 
                  g_ooga2_d[l_ac].oogaowndp,g_ooga2_d[l_ac].oogacrtid,g_ooga2_d[l_ac].oogacrtdp,g_ooga2_d[l_ac].oogacrtdt)  
 
         WHERE oogaent = g_enterprise AND ooga001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooga_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ooga_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi400_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aooi400_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "ooga_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi400_bcl USING g_enterprise,
                                       g_ooga_d[g_detail_idx].ooga001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi400_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi400_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aooi400_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi400.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aooi400_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define(客製用) name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前 name="modify_detail_chk.before"
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "oogastus"
      WHEN "s_detail2"
         LET ls_return = "ooga001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi400.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aooi400_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   IF g_action_choice = 'modify' OR g_action_choice = 'modify_detail' THEN
      IF mc_data_owner_check THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'lib-00419'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   END IF
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aooi400.mask_functions" >}
&include "erp/aoo/aooi400_mask.4gl"
 
{</section>}
 
{<section id="aooi400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi400_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_ooga_d[l_ac].ooga001
   LET g_pk_array[1].column = 'ooga001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi400.state_change" >}
   
 
{</section>}
 
{<section id="aooi400.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi400.other_function" readonly="Y" >}
# 檢查KEY值是否重複
PRIVATE FUNCTION aooi400_chk_ooga001(p_cmd)
DEFINE p_cmd       LIKE type_t.chr1
  
  IF NOT cl_null(g_ooga_d[l_ac].ooga001) THEN 
     IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooga_d[l_ac].ooga001 != g_ooga_d_t.ooga001))) THEN 
        IF NOT ap_chk_notDup(g_ooga_d[l_ac].ooga001,"SELECT COUNT(*) FROM ooga_t WHERE "||
                                "oogaent = '" ||g_enterprise|| "' AND "||"ooga001 = '"||
                                g_ooga_d[l_ac].ooga001 ||"'",'std-00004',0) THEN 
           RETURN FALSE
        END IF
     END IF
  END IF
  RETURN TRUE
END FUNCTION
# 應用分類碼檢查
PRIVATE FUNCTION aooi400_chk_ooga(p_oocq001,p_oocq002)
DEFINE p_oocq001 LIKE oocq_t.oocq001
   DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE l_n       LIKE type_t.num5
   
   
   LET g_errno = ''
   IF NOT cl_null(p_oocq002) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM oocq_t
       WHERE oocq001 = p_oocq001
         AND oocq002 = p_oocq002
         AND oocqent = g_enterprise
       IF l_n = 0 THEN
          CASE p_oocq001
             WHEN '7'
                LET g_errno = 'aoo-00055'
             WHEN '8'
                LET g_errno = 'aoo-00057'
             WHEN '9'
                LET g_errno = 'aoo-00059'
             WHEN '10'
                LET g_errno = 'aoo-00061'
             WHEN '11'
                LET g_errno = 'aoo-00063'
          END CASE
       ELSE
          LET l_n = 0
          SELECT COUNT(*) INTO l_n
            FROM oocq_t
           WHERE oocq001 = p_oocq001
             AND oocq002 = p_oocq002
             AND oocqent = g_enterprise 
             AND oocqstus = 'Y'
          IF l_n = 0 THEN
             CASE p_oocq001
                WHEN '7'
                   LET g_errno = 'aoo-00056'
                WHEN '8'
                   LET g_errno = 'aoo-00058'
                WHEN '9'
                   LET g_errno = 'aoo-00060'
                WHEN '10'
                   LET g_errno = 'aoo-00062'
                WHEN '11'
                   LET g_errno = 'aoo-00064'
             END CASE
          END IF        
       END IF
    END IF
END FUNCTION
#分類說明顯示
PRIVATE FUNCTION aooi400_desc1()
 
   IF cl_null(g_ooga_d[l_ac].ooga004) THEN
      LET g_ooga_d[l_ac].ooga004_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooga_d[l_ac].ooga004
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '7' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooga_d[l_ac].ooga004_desc =  g_rtn_fields[1]
   END IF
   DISPLAY  g_ooga_d[l_ac].ooga004_desc TO s_detail1[l_ac].ooga004_desc
   
   IF cl_null(g_ooga_d[l_ac].ooga005) THEN
      LET g_ooga_d[l_ac].ooga005_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooga_d[l_ac].ooga005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '8' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooga_d[l_ac].ooga005_desc =  g_rtn_fields[1]
   END IF
   DISPLAY  g_ooga_d[l_ac].ooga005_desc TO s_detail1[l_ac].ooga005_desc

   IF cl_null(g_ooga_d[l_ac].ooga006) THEN
      LET g_ooga_d[l_ac].ooga006_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooga_d[l_ac].ooga006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '9' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooga_d[l_ac].ooga006_desc = g_rtn_fields[1]
   END IF
  DISPLAY  g_ooga_d[l_ac].ooga006_desc TO s_detail1[l_ac].ooga006_desc
   
   IF cl_null(g_ooga_d[l_ac].ooga007) THEN
      LET g_ooga_d[l_ac].ooga007_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooga_d[l_ac].ooga007
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '10' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooga_d[l_ac].ooga007_desc = g_rtn_fields[1]
   END IF
   DISPLAY  g_ooga_d[l_ac].ooga007_desc TO s_detail1[l_ac].ooga007_desc

   IF cl_null(g_ooga_d[l_ac].ooga008) THEN
      LET g_ooga_d[l_ac].ooga008_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooga_d[l_ac].ooga008
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '11' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooga_d[l_ac].ooga008_desc =  g_rtn_fields[1]
   END IF
   DISPLAY  g_ooga_d[l_ac].ooga008_desc TO s_detail1[l_ac].ooga008_desc

END FUNCTION
#帶值
PRIVATE FUNCTION aooi400_desc()
  IF cl_null(g_ooga_d[l_ac].ooga001) THEN 
     LET g_ooga_d[l_ac].ooga002 = ""
     LET g_ooga_d[l_ac].ooga003 = ""
     LET g_ooga_d[l_ac].ooga012 = ""
  ELSE
     LET g_ooga_d[l_ac].ooga002 = WEEKDAY(g_ooga_d[l_ac].ooga001)
     CALL s_date_get_lunar_date(g_ooga_d[l_ac].ooga001) RETURNING g_ooga_d[l_ac].ooga003
     LET g_ooga_d[l_ac].ooga012 = MONTH(g_ooga_d[l_ac].ooga001)
  END IF
  DISPLAY g_ooga_d[l_ac].ooga002 TO s_detail1[l_ac].ooga002
  DISPLAY g_ooga_d[l_ac].ooga003 TO s_detail1[l_ac].ooga003
  DISPLAY g_ooga_d[l_ac].ooga012 TO s_detail1[l_ac].ooga012
END FUNCTION

 
{</section>}
 
