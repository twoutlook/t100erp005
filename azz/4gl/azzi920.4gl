#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2015-03-12 09:28:51), PR版次:0018(2016-09-23 15:09:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000363
#+ Filename...: azzi920
#+ Description: 錯誤訊息維護作業
#+ Creator....: 00845(2013-06-01 00:00:00)
#+ Modifier...: 01101 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi920.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#14 2016/04/18 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00005#55 2016/04/20 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#160512-00012#01 2016/05/12 By jrg542  行業別錯誤訊息調整
#160919-00020#01 2016/09/19 By jrg542  修正azzi920限制只能輸入c開頭的錯誤訊息
#160919-00067#01 2016/09/19 By jrg542  修正 tsd- 錯誤訊息開頭在客戶家可以修改
#160923-00018#01 2016/09/19 By jrg542  檢查原則要在『同一語系』下，才算數
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
PRIVATE TYPE type_g_gzze_d RECORD
       gzzestus LIKE gzze_t.gzzestus, 
   gzze001 LIKE gzze_t.gzze001, 
   gzze002 LIKE gzze_t.gzze002, 
   gzze003 LIKE gzze_t.gzze003, 
   gzze004 LIKE gzze_t.gzze004, 
   gzze005 LIKE gzze_t.gzze005, 
   gzze005_desc LIKE type_t.chr500, 
   gzze006 LIKE gzze_t.gzze006, 
   gzze007 LIKE gzze_t.gzze007, 
   gzze008 LIKE gzze_t.gzze008, 
   gzze009 LIKE gzze_t.gzze009
       END RECORD
PRIVATE TYPE type_g_gzze1_info_d RECORD
       gzze001 LIKE gzze_t.gzze001, 
   gzze002 LIKE gzze_t.gzze002, 
   gzzemodid LIKE gzze_t.gzzemodid, 
   gzzemodid_desc LIKE type_t.chr500, 
   gzzemoddt DATETIME YEAR TO SECOND, 
   gzzeownid LIKE gzze_t.gzzeownid, 
   gzzeownid_desc LIKE type_t.chr500, 
   gzzeowndp LIKE gzze_t.gzzeowndp, 
   gzzeowndp_desc LIKE type_t.chr500, 
   gzzecrtid LIKE gzze_t.gzzecrtid, 
   gzzecrtid_desc LIKE type_t.chr500, 
   gzzecrtdp LIKE gzze_t.gzzecrtdp, 
   gzzecrtdp_desc LIKE type_t.chr500, 
   gzzecrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_gzze_d          DYNAMIC ARRAY OF type_g_gzze_d #單身變數
DEFINE g_gzze_d_t        type_g_gzze_d                  #單身備份
DEFINE g_gzze_d_o        type_g_gzze_d                  #單身備份
DEFINE g_gzze_d_mask_o   DYNAMIC ARRAY OF type_g_gzze_d #單身變數
DEFINE g_gzze_d_mask_n   DYNAMIC ARRAY OF type_g_gzze_d #單身變數
DEFINE g_gzze1_info_d   DYNAMIC ARRAY OF type_g_gzze1_info_d
DEFINE g_gzze1_info_d_t type_g_gzze1_info_d
DEFINE g_gzze1_info_d_o type_g_gzze1_info_d
DEFINE g_gzze1_info_d_mask_o DYNAMIC ARRAY OF type_g_gzze1_info_d
DEFINE g_gzze1_info_d_mask_n DYNAMIC ARRAY OF type_g_gzze1_info_d
 
      
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
 
{<section id="azzi920.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT gzzestus,gzze001,gzze002,gzze003,gzze004,gzze005,gzze006,gzze007,gzze008, 
       gzze009,gzze001,gzze002,gzzemodid,gzzemoddt,gzzeownid,gzzeowndp,gzzecrtid,gzzecrtdp,gzzecrtdt  
       FROM gzze_t WHERE gzze001=? AND gzze002=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi920_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi920 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi920_init()   
 
      #進入選單 Menu (="N")
      CALL azzi920_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi920
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi920.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzi920_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('gzze007','106') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
CALL cl_set_combo_lang("gzze002")
CALL cl_set_combo_lang("gzze002_s_detail1_info")
    
   #end add-point
   
   CALL azzi920_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi920.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzi920_ui_dialog()
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
         CALL g_gzze_d.clear()
         CALL g_gzze1_info_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL azzi920_init()
      END IF
   
      CALL azzi920_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzze_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_gzze1_info_d[g_detail_idx].gzzeownid   #(ver:35)
               LET g_data_dept = g_gzze1_info_d[g_detail_idx].gzzeowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL azzi920_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_gzze1_info_d TO s_detail1_info.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body1_info.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body1_info.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL azzi920_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row1_info"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail1_info", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL azzi920_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL azzi920_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL azzi920_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL azzi920_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL azzi920_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL azzi920_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi920_insert()
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi920_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail1_info",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzze_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_gzze1_info_d)
               LET g_export_id[2]   = "s_detail1_info"
 
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
            CALL azzi920_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi920_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi920_set_pk_array()
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
 
{<section id="azzi920.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi920_query()
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
   CALL g_gzze_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON gzzestus,gzze001,gzze002,gzze003,gzze004,gzze005,gzze006,gzze007,gzze008,gzze009, 
          gzzemodid,gzzemoddt,gzzeownid,gzzeowndp,gzzecrtid,gzzecrtdp,gzzecrtdt 
 
         FROM s_detail1[1].gzzestus,s_detail1[1].gzze001,s_detail1[1].gzze002,s_detail1[1].gzze003,s_detail1[1].gzze004, 
             s_detail1[1].gzze005,s_detail1[1].gzze006,s_detail1[1].gzze007,s_detail1[1].gzze008,s_detail1[1].gzze009, 
             s_detail1_info[1].gzzemodid,s_detail1_info[1].gzzemoddt,s_detail1_info[1].gzzeownid,s_detail1_info[1].gzzeowndp, 
             s_detail1_info[1].gzzecrtid,s_detail1_info[1].gzzecrtdp,s_detail1_info[1].gzzecrtdt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzzecrtdt>>----
         AFTER FIELD gzzecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzzemoddt>>----
         AFTER FIELD gzzemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzzecnfdt>>----
         
         #----<<gzzepstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzestus
            #add-point:BEFORE FIELD gzzestus name="query.b.page1.gzzestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzestus
            
            #add-point:AFTER FIELD gzzestus name="query.a.page1.gzzestus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzzestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzestus
            #add-point:ON ACTION controlp INFIELD gzzestus name="query.c.page1.gzzestus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze001
            #add-point:BEFORE FIELD gzze001 name="query.b.page1.gzze001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze001
            
            #add-point:AFTER FIELD gzze001 name="query.a.page1.gzze001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze001
            #add-point:ON ACTION controlp INFIELD gzze001 name="query.c.page1.gzze001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze002
            #add-point:BEFORE FIELD gzze002 name="query.b.page1.gzze002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze002
            
            #add-point:AFTER FIELD gzze002 name="query.a.page1.gzze002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze002
            #add-point:ON ACTION controlp INFIELD gzze002 name="query.c.page1.gzze002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze003
            #add-point:BEFORE FIELD gzze003 name="query.b.page1.gzze003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze003
            
            #add-point:AFTER FIELD gzze003 name="query.a.page1.gzze003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze003
            #add-point:ON ACTION controlp INFIELD gzze003 name="query.c.page1.gzze003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze004
            #add-point:BEFORE FIELD gzze004 name="query.b.page1.gzze004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze004
            
            #add-point:AFTER FIELD gzze004 name="query.a.page1.gzze004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze004
            #add-point:ON ACTION controlp INFIELD gzze004 name="query.c.page1.gzze004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzze005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze005
            #add-point:ON ACTION controlp INFIELD gzze005 name="construct.c.page1.gzze005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzze005  #顯示到畫面上
            NEXT FIELD gzze005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze005
            #add-point:BEFORE FIELD gzze005 name="query.b.page1.gzze005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze005
            
            #add-point:AFTER FIELD gzze005 name="query.a.page1.gzze005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze006
            #add-point:BEFORE FIELD gzze006 name="query.b.page1.gzze006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze006
            
            #add-point:AFTER FIELD gzze006 name="query.a.page1.gzze006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze006
            #add-point:ON ACTION controlp INFIELD gzze006 name="query.c.page1.gzze006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze007
            #add-point:BEFORE FIELD gzze007 name="query.b.page1.gzze007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze007
            
            #add-point:AFTER FIELD gzze007 name="query.a.page1.gzze007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze007
            #add-point:ON ACTION controlp INFIELD gzze007 name="query.c.page1.gzze007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze008
            #add-point:BEFORE FIELD gzze008 name="query.b.page1.gzze008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze008
            
            #add-point:AFTER FIELD gzze008 name="query.a.page1.gzze008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze008
            #add-point:ON ACTION controlp INFIELD gzze008 name="query.c.page1.gzze008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze009
            #add-point:BEFORE FIELD gzze009 name="query.b.page1.gzze009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze009
            
            #add-point:AFTER FIELD gzze009 name="query.a.page1.gzze009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzze009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze009
            #add-point:ON ACTION controlp INFIELD gzze009 name="query.c.page1.gzze009"
            
            #END add-point
 
 
  
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzemodid
            #add-point:BEFORE FIELD gzzemodid name="query.b.page1_info.gzzemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzemodid
            
            #add-point:AFTER FIELD gzzemodid name="query.a.page1_info.gzzemodid"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_info.gzzemodid
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzemodid
            #add-point:ON ACTION controlp INFIELD gzzemodid name="query.c.page1_info.gzzemodid"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzemoddt
            #add-point:BEFORE FIELD gzzemoddt name="query.b.page1_info.gzzemoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzeownid
            #add-point:BEFORE FIELD gzzeownid name="query.b.page1_info.gzzeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzeownid
            
            #add-point:AFTER FIELD gzzeownid name="query.a.page1_info.gzzeownid"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_info.gzzeownid
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzeownid
            #add-point:ON ACTION controlp INFIELD gzzeownid name="query.c.page1_info.gzzeownid"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzeowndp
            #add-point:BEFORE FIELD gzzeowndp name="query.b.page1_info.gzzeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzeowndp
            
            #add-point:AFTER FIELD gzzeowndp name="query.a.page1_info.gzzeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_info.gzzeowndp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzeowndp
            #add-point:ON ACTION controlp INFIELD gzzeowndp name="query.c.page1_info.gzzeowndp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzecrtid
            #add-point:BEFORE FIELD gzzecrtid name="query.b.page1_info.gzzecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzecrtid
            
            #add-point:AFTER FIELD gzzecrtid name="query.a.page1_info.gzzecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_info.gzzecrtid
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzecrtid
            #add-point:ON ACTION controlp INFIELD gzzecrtid name="query.c.page1_info.gzzecrtid"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzecrtdp
            #add-point:BEFORE FIELD gzzecrtdp name="query.b.page1_info.gzzecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzecrtdp
            
            #add-point:AFTER FIELD gzzecrtdp name="query.a.page1_info.gzzecrtdp"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1_info.gzzecrtdp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzecrtdp
            #add-point:ON ACTION controlp INFIELD gzzecrtdp name="query.c.page1_info.gzzecrtdp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzecrtdt
            #add-point:BEFORE FIELD gzzecrtdt name="query.b.page1_info.gzzecrtdt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      
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
    
   CALL azzi920_b_fill(g_wc2)
   LET g_data_owner = g_gzze1_info_d[g_detail_idx].gzzeownid   #(ver:35)
   LET g_data_dept = g_gzze1_info_d[g_detail_idx].gzzeowndp   #(ver:35)
 
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
 
{<section id="azzi920.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi920_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL azzi920_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi920.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi920_modify()
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
   DEFINE  l_success              LIKE type_t.num5
   DEFINE  ls_gzze_cnt            LIKE type_t.num5
   DEFINE  ls_gzze001             LIKE gzze_t.gzze001
   DEFINE  ls_gzze002             LIKE gzze_t.gzze002
   DEFINE  ls_str                 STRING
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
      INPUT ARRAY g_gzze_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION trans_zh_cn_lang
            LET g_action_choice="trans_zh_cn_lang"
            IF cl_auth_chk_act("trans_zh_cn_lang") THEN
               
               #add-point:ON ACTION trans_zh_cn_lang name="input.detail_input.page1.trans_zh_cn_lang"
               CALL s_transaction_begin()
               CALL azzi920_trans_zh_cn_lang() RETURNING l_success
               IF l_success THEN
                   CALL s_transaction_end('Y','1')
               ELSE
                   CALL s_transaction_end('N','1')
                END IF
                CALL azzi920_b_fill(g_wc2)
                EXIT DIALOG 
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzze_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi920_b_fill(g_wc2)
            LET g_detail_cnt = g_gzze_d.getLength()
         
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
            DISPLAY g_gzze_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzze_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzze_d[l_ac].gzze001 IS NOT NULL
               AND g_gzze_d[l_ac].gzze002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzze_d_t.* = g_gzze_d[l_ac].*  #BACKUP
               LET g_gzze_d_o.* = g_gzze_d[l_ac].*  #BACKUP
               IF NOT azzi920_lock_b("gzze_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi920_bcl INTO g_gzze_d[l_ac].gzzestus,g_gzze_d[l_ac].gzze001,g_gzze_d[l_ac].gzze002, 
                      g_gzze_d[l_ac].gzze003,g_gzze_d[l_ac].gzze004,g_gzze_d[l_ac].gzze005,g_gzze_d[l_ac].gzze006, 
                      g_gzze_d[l_ac].gzze007,g_gzze_d[l_ac].gzze008,g_gzze_d[l_ac].gzze009,g_gzze1_info_d[l_ac].gzze001, 
                      g_gzze1_info_d[l_ac].gzze002,g_gzze1_info_d[l_ac].gzzemodid,g_gzze1_info_d[l_ac].gzzemoddt, 
                      g_gzze1_info_d[l_ac].gzzeownid,g_gzze1_info_d[l_ac].gzzeowndp,g_gzze1_info_d[l_ac].gzzecrtid, 
                      g_gzze1_info_d[l_ac].gzzecrtdp,g_gzze1_info_d[l_ac].gzzecrtdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzze_d_t.gzze001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzze_d_mask_o[l_ac].* =  g_gzze_d[l_ac].*
                  CALL azzi920_gzze_t_mask()
                  LET g_gzze_d_mask_n[l_ac].* =  g_gzze_d[l_ac].*
                  
                  CALL azzi920_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi920_set_entry_b(l_cmd)
            CALL azzi920_set_no_entry_b(l_cmd)
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
            INITIALIZE g_gzze_d_t.* TO NULL
            INITIALIZE g_gzze_d_o.* TO NULL
            INITIALIZE g_gzze_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzze1_info_d[l_ac].gzzeownid = g_user
      LET g_gzze1_info_d[l_ac].gzzeowndp = g_dept
      LET g_gzze1_info_d[l_ac].gzzecrtid = g_user
      LET g_gzze1_info_d[l_ac].gzzecrtdp = g_dept 
      LET g_gzze1_info_d[l_ac].gzzecrtdt = cl_get_current()
      LET g_gzze1_info_d[l_ac].gzzemodid = g_user
      LET g_gzze1_info_d[l_ac].gzzemoddt = cl_get_current()
      LET g_gzze_d[l_ac].gzzestus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_gzze_d[l_ac].gzzestus = "Y"
      LET g_gzze_d[l_ac].gzze007 = "1"
      LET g_gzze_d[l_ac].gzze008 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_gzze_d_t.* = g_gzze_d[l_ac].*     #新輸入資料
            LET g_gzze_d_o.* = g_gzze_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzze_d[li_reproduce_target].* = g_gzze_d[li_reproduce].*
               LET g_gzze1_info_d[li_reproduce_target].* = g_gzze1_info_d[li_reproduce].*
 
               LET g_gzze_d[g_gzze_d.getLength()].gzze001 = NULL
               LET g_gzze_d[g_gzze_d.getLength()].gzze002 = NULL
 
            END IF
            
 
 
            CALL azzi920_set_entry_b(l_cmd)
            CALL azzi920_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM gzze_t 
             WHERE  gzze001 = g_gzze_d[l_ac].gzze001
                                       AND gzze002 = g_gzze_d[l_ac].gzze002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzze_d[g_detail_idx].gzze001
               LET gs_keys[2] = g_gzze_d[g_detail_idx].gzze002
               CALL azzi920_insert_b('gzze_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzze_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzze_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi920_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (gzze001 = '", g_gzze_d[l_ac].gzze001, "' "
                                  ," AND gzze002 = '", g_gzze_d[l_ac].gzze002, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
                CALL azzi920_check_gzze001_3(g_gzze_d_t.gzze001)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CANCEL DELETE
                  END IF 
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
               
               DELETE FROM gzze_t
                WHERE  
                      gzze001 = g_gzze_d_t.gzze001
                      AND gzze002 = g_gzze_d_t.gzze002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzze_t:",SQLERRMESSAGE 
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
                  CALL azzi920_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_gzze_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE azzi920_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_gzze_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzze_d_t.gzze001
               LET gs_keys[2] = g_gzze_d_t.gzze002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi920_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL azzi920_delete_b('gzze_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzze_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzestus
            #add-point:BEFORE FIELD gzzestus name="input.b.page1.gzzestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzestus
            
            #add-point:AFTER FIELD gzzestus name="input.a.page1.gzzestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzestus
            #add-point:ON CHANGE gzzestus name="input.g.page1.gzzestus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze001
            #add-point:BEFORE FIELD gzze001 name="input.b.page1.gzze001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze001
            
            #add-point:AFTER FIELD gzze001 name="input.a.page1.gzze001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzze_d[l_ac].gzze001) AND NOT cl_null(g_gzze_d[l_ac].gzze002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzze_d[l_ac].gzze001 != g_gzze_d_t.gzze001 OR g_gzze_d[l_ac].gzze002 != g_gzze_d_t.gzze002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzze_t WHERE "||"gzze001 = '"||g_gzze_d[l_ac].gzze001 ||"' AND "|| "gzze002 = '"||g_gzze_d[l_ac].gzze002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF               
            END IF

            IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzze_d[l_ac].gzze001 != g_gzze_d_t.gzze001)) THEN
               #在產中不能打c開頭的訊息代碼；在客戶家一定得打c開頭的訊息代碼
               CALL azzi920_check_gzze001_2(g_gzze_d[l_ac].gzze001)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD gzze001
               END IF 
               
               CALL azzi920_check_gzze001()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #IF g_errno = "azz-00179" OR g_errno = "azz-00378" THEN 
                  #ELSE
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = g_errno
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #END IF 
                  NEXT FIELD gzze001
               END IF
            END IF
            
            IF l_cmd = 'u' AND (g_gzze_d[l_ac].gzze001 != g_gzze_d_t.gzze001) THEN
               #在客戶家不可修改 產中已經設定的錯誤訊息代碼
               CALL azzi920_check_gzze001_3(g_gzze_d_t.gzze001)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD gzze001
               END IF 
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze001
            #add-point:ON CHANGE gzze001 name="input.g.page1.gzze001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze002
            #add-point:BEFORE FIELD gzze002 name="input.b.page1.gzze002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze002
            
            #add-point:AFTER FIELD gzze002 name="input.a.page1.gzze002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzze_d[l_ac].gzze001) AND NOT cl_null(g_gzze_d[l_ac].gzze002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzze_d[l_ac].gzze001 != g_gzze_d_t.gzze001 OR g_gzze_d[l_ac].gzze002 != g_gzze_d_t.gzze002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzze_t WHERE "||"gzze001 = '"||g_gzze_d[l_ac].gzze001 ||"' AND "|| "gzze002 = '"||g_gzze_d[l_ac].gzze002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze002
            #add-point:ON CHANGE gzze002 name="input.g.page1.gzze002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze003
            #add-point:BEFORE FIELD gzze003 name="input.b.page1.gzze003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze003
            
            #add-point:AFTER FIELD gzze003 name="input.a.page1.gzze003"
            #若是輸入繁體中文或是簡體中文的訊息時，需檢查訊息是否已存在
            IF g_gzze_d[l_ac].gzze002 = "zh_TW" OR g_gzze_d[l_ac].gzze002 = "zh_CN" THEN
               LET ls_gzze_cnt = 0
               SELECT COUNT(1) INTO ls_gzze_cnt FROM gzze_t
                WHERE gzze003 = g_gzze_d[l_ac].gzze003
                 AND  gzze002 = g_gzze_d[l_ac].gzze002    #160923-00018 #1

               IF (l_cmd = "a" AND ls_gzze_cnt > 0) OR (l_cmd = "u" AND ls_gzze_cnt > 1) THEN
                  DECLARE azzi920_get_gzze001_curs CURSOR FOR
                     SELECT gzze001,gzze002 FROM gzze_t
                      WHERE gzze003 = g_gzze_d[l_ac].gzze003

                  FOREACH azzi920_get_gzze001_curs INTO ls_gzze001,ls_gzze002
                     IF cl_null(ls_str) THEN
                        LET ls_str = ls_gzze001,"(",ls_gzze002,")"
                     ELSE
                        LET ls_str = ls_str,", ",ls_gzze001,"(",ls_gzze002,")"
                     END IF
                  END FOREACH
                  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00372"
                  LET g_errparam.extend = "azz-00372"
                  LET g_errparam.replace[1] = ls_str
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  IF g_argv[1] <> "debug" THEN
                     NEXT FIELD gzze003
                  END IF
                  NEXT FIELD gzze003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze003
            #add-point:ON CHANGE gzze003 name="input.g.page1.gzze003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze004
            #add-point:BEFORE FIELD gzze004 name="input.b.page1.gzze004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze004
            
            #add-point:AFTER FIELD gzze004 name="input.a.page1.gzze004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze004
            #add-point:ON CHANGE gzze004 name="input.g.page1.gzze004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze005
            
            #add-point:AFTER FIELD gzze005 name="input.a.page1.gzze005"
            IF NOT cl_null(g_gzze_d[l_ac].gzze005) THEN 
               IF g_gzze_d[l_ac].gzze005 != ":EXEPROG" THEN   #不屬於建議執行作業編號
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_gzze_d[l_ac].gzze005
                  #呼叫檢查存在並帶值的library
                  #IF cl_chk_exist_and_ref_val("v_gzzz001") THEN
                  #檢查資料是否存在
                  LET g_errshow = TRUE   #160318-00025#14
                  LET g_chkparam.err_str[1] = "aoo-00120:sub-01302|azzi910|",cl_get_progname("azzi910",g_lang,"2"),"|:EXEPROGazzi910"    #160318-00025#14
                  IF cl_chk_exist("v_gzzz001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzze_d[l_ac].gzze005
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzze_d[l_ac].gzze005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzze_d[l_ac].gzze005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze005
            #add-point:BEFORE FIELD gzze005 name="input.b.page1.gzze005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze005
            #add-point:ON CHANGE gzze005 name="input.g.page1.gzze005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze006
            #add-point:BEFORE FIELD gzze006 name="input.b.page1.gzze006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze006
            
            #add-point:AFTER FIELD gzze006 name="input.a.page1.gzze006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze006
            #add-point:ON CHANGE gzze006 name="input.g.page1.gzze006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze007
            #add-point:BEFORE FIELD gzze007 name="input.b.page1.gzze007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze007
            
            #add-point:AFTER FIELD gzze007 name="input.a.page1.gzze007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze007
            #add-point:ON CHANGE gzze007 name="input.g.page1.gzze007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze008
            #add-point:BEFORE FIELD gzze008 name="input.b.page1.gzze008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze008
            
            #add-point:AFTER FIELD gzze008 name="input.a.page1.gzze008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze008
            #add-point:ON CHANGE gzze008 name="input.g.page1.gzze008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzze009
            #add-point:BEFORE FIELD gzze009 name="input.b.page1.gzze009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzze009
            
            #add-point:AFTER FIELD gzze009 name="input.a.page1.gzze009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzze009
            #add-point:ON CHANGE gzze009 name="input.g.page1.gzze009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzzestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzestus
            #add-point:ON ACTION controlp INFIELD gzzestus name="input.c.page1.gzzestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze001
            #add-point:ON ACTION controlp INFIELD gzze001 name="input.c.page1.gzze001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze002
            #add-point:ON ACTION controlp INFIELD gzze002 name="input.c.page1.gzze002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze003
            #add-point:ON ACTION controlp INFIELD gzze003 name="input.c.page1.gzze003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze004
            #add-point:ON ACTION controlp INFIELD gzze004 name="input.c.page1.gzze004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze005
            #add-point:ON ACTION controlp INFIELD gzze005 name="input.c.page1.gzze005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzze_d[l_ac].gzze005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_gzzz001_1()                                #呼叫開窗

            LET g_gzze_d[l_ac].gzze005 = g_qryparam.return1              

            DISPLAY g_gzze_d[l_ac].gzze005 TO gzze005              #

            NEXT FIELD gzze005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze006
            #add-point:ON ACTION controlp INFIELD gzze006 name="input.c.page1.gzze006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze007
            #add-point:ON ACTION controlp INFIELD gzze007 name="input.c.page1.gzze007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze008
            #add-point:ON ACTION controlp INFIELD gzze008 name="input.c.page1.gzze008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzze009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzze009
            #add-point:ON ACTION controlp INFIELD gzze009 name="input.c.page1.gzze009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE azzi920_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_gzze_d[l_ac].* = g_gzze_d_t.*
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
               LET g_errparam.extend = g_gzze_d[l_ac].gzze001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzze_d[l_ac].* = g_gzze_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_gzze1_info_d[l_ac].gzzemodid = g_user 
LET g_gzze1_info_d[l_ac].gzzemoddt = cl_get_current()
LET g_gzze1_info_d[l_ac].gzzemodid_desc = cl_get_username(g_gzze1_info_d[l_ac].gzzemodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #在客戶家不可修改 產中已經設定的錯誤訊息代碼
               CALL azzi920_check_gzze001_3(g_gzze_d_t.gzze001)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD gzze003
               END IF 
 
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi920_gzze_t_mask_restore('restore_mask_o')
 
               UPDATE gzze_t SET (gzzestus,gzze001,gzze002,gzze003,gzze004,gzze005,gzze006,gzze007,gzze008, 
                   gzze009,gzzemodid,gzzemoddt,gzzeownid,gzzeowndp,gzzecrtid,gzzecrtdp,gzzecrtdt) = (g_gzze_d[l_ac].gzzestus, 
                   g_gzze_d[l_ac].gzze001,g_gzze_d[l_ac].gzze002,g_gzze_d[l_ac].gzze003,g_gzze_d[l_ac].gzze004, 
                   g_gzze_d[l_ac].gzze005,g_gzze_d[l_ac].gzze006,g_gzze_d[l_ac].gzze007,g_gzze_d[l_ac].gzze008, 
                   g_gzze_d[l_ac].gzze009,g_gzze1_info_d[l_ac].gzzemodid,g_gzze1_info_d[l_ac].gzzemoddt, 
                   g_gzze1_info_d[l_ac].gzzeownid,g_gzze1_info_d[l_ac].gzzeowndp,g_gzze1_info_d[l_ac].gzzecrtid, 
                   g_gzze1_info_d[l_ac].gzzecrtdp,g_gzze1_info_d[l_ac].gzzecrtdt)
                WHERE 
                  gzze001 = g_gzze_d_t.gzze001 #項次   
                  AND gzze002 = g_gzze_d_t.gzze002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzze_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzze_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzze_d[g_detail_idx].gzze001
               LET gs_keys_bak[1] = g_gzze_d_t.gzze001
               LET gs_keys[2] = g_gzze_d[g_detail_idx].gzze002
               LET gs_keys_bak[2] = g_gzze_d_t.gzze002
               CALL azzi920_update_b('gzze_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gzze_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzze_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi920_gzze_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL azzi920_unlock_b("gzze_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzze_d[l_ac].* = g_gzze_d_t.*
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
               LET g_gzze_d[li_reproduce_target].* = g_gzze_d[li_reproduce].*
               LET g_gzze1_info_d[li_reproduce_target].* = g_gzze1_info_d[li_reproduce].*
 
               LET g_gzze_d[li_reproduce_target].gzze001 = NULL
               LET g_gzze_d[li_reproduce_target].gzze002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzze_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzze_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_gzze1_info_d TO s_detail1_info.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL azzi920_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body1_info.action"
         
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
               NEXT FIELD gzzestus
            WHEN "s_detail1_info"
               NEXT FIELD gzze001_2
 
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
      IF INT_FLAG OR cl_null(g_gzze_d[g_detail_idx].gzze001) THEN
         CALL g_gzze_d.deleteElement(g_detail_idx)
         CALL g_gzze1_info_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_gzze_d[g_detail_idx].* = g_gzze_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE azzi920_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi920.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi920_delete()
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
   FOR li_idx = 1 TO g_gzze_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT azzi920_lock_b("gzze_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("gzze_t","gzzeownid") THEN
            LET g_data_owner = g_gzze1_info_d[g_detail_idx].gzzeownid
            LET g_data_dept = g_gzze1_info_d[g_detail_idx].gzzeowndp
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
   CALL azzi920_check_gzze001_3(g_gzze_d_t.gzze001)
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF 
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_gzze_d.getLength()
      IF g_gzze_d[li_idx].gzze001 IS NOT NULL
         AND g_gzze_d[li_idx].gzze002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM gzze_t
          WHERE  
                gzze001 = g_gzze_d[li_idx].gzze001
                AND gzze002 = g_gzze_d[li_idx].gzze002
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzze_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_gzze_d_t.gzze001
               LET gs_keys[2] = g_gzze_d_t.gzze002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL azzi920_delete_b('gzze_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi920_set_pk_array()
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
   CALL azzi920_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="azzi920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi920_b_fill(p_wc2)              #BODY FILL UP
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
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.gzzestus,t0.gzze001,t0.gzze002,t0.gzze003,t0.gzze004,t0.gzze005, 
       t0.gzze006,t0.gzze007,t0.gzze008,t0.gzze009,t0.gzze001,t0.gzze002,t0.gzzemodid,t0.gzzemoddt,t0.gzzeownid, 
       t0.gzzeowndp,t0.gzzecrtid,t0.gzzecrtdp,t0.gzzecrtdt ,t1.gzzal003 ,t2.ooag011 ,t3.ooag011 ,t4.ooag011 , 
       t5.ooefl003 FROM gzze_t t0",
               "",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzze005 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.gzzemodid  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzzeownid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.gzzecrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.gzzecrtdp AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE 1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("gzze_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND gzzeowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("gzze_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND gzzeownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gzze_t"),
                      " ORDER BY t0.gzze001,t0.gzze002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzze_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzi920_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi920_pb
   
   OPEN b_fill_curs
 
   CALL g_gzze_d.clear()
   CALL g_gzze1_info_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gzze_d[l_ac].gzzestus,g_gzze_d[l_ac].gzze001,g_gzze_d[l_ac].gzze002,g_gzze_d[l_ac].gzze003, 
       g_gzze_d[l_ac].gzze004,g_gzze_d[l_ac].gzze005,g_gzze_d[l_ac].gzze006,g_gzze_d[l_ac].gzze007,g_gzze_d[l_ac].gzze008, 
       g_gzze_d[l_ac].gzze009,g_gzze1_info_d[l_ac].gzze001,g_gzze1_info_d[l_ac].gzze002,g_gzze1_info_d[l_ac].gzzemodid, 
       g_gzze1_info_d[l_ac].gzzemoddt,g_gzze1_info_d[l_ac].gzzeownid,g_gzze1_info_d[l_ac].gzzeowndp, 
       g_gzze1_info_d[l_ac].gzzecrtid,g_gzze1_info_d[l_ac].gzzecrtdp,g_gzze1_info_d[l_ac].gzzecrtdt, 
       g_gzze_d[l_ac].gzze005_desc,g_gzze1_info_d[l_ac].gzzemodid_desc,g_gzze1_info_d[l_ac].gzzeownid_desc, 
       g_gzze1_info_d[l_ac].gzzecrtid_desc,g_gzze1_info_d[l_ac].gzzecrtdp_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
      
      CALL azzi920_detail_show()      
 
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
   
 
   
   CALL g_gzze_d.deleteElement(g_gzze_d.getLength())   
   CALL g_gzze1_info_d.deleteElement(g_gzze1_info_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gzze_d.getLength()
      LET g_gzze1_info_d[l_ac].gzze001 = g_gzze_d[l_ac].gzze001 
      LET g_gzze1_info_d[l_ac].gzze002 = g_gzze_d[l_ac].gzze002 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_gzze_d.getLength() THEN
      LET l_ac = g_gzze_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzze_d.getLength()
      LET g_gzze_d_mask_o[l_ac].* =  g_gzze_d[l_ac].*
      CALL azzi920_gzze_t_mask()
      LET g_gzze_d_mask_n[l_ac].* =  g_gzze_d[l_ac].*
   END FOR
   
   LET g_gzze1_info_d_mask_o.* =  g_gzze1_info_d.*
   FOR l_ac = 1 TO g_gzze1_info_d.getLength()
      LET g_gzze1_info_d_mask_o[l_ac].* =  g_gzze1_info_d[l_ac].*
      CALL azzi920_gzze_t_mask()
      LET g_gzze1_info_d_mask_n[l_ac].* =  g_gzze1_info_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_gzze_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE azzi920_pb
   
END FUNCTION
 
{</section>}
 
{<section id="azzi920.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzi920_detail_show()
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
 
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body1_info.reference"
 
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi920.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi920_set_entry_b(p_cmd)                                                  
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
 
{<section id="azzi920.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi920_set_no_entry_b(p_cmd)                                               
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
 
{<section id="azzi920.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi920_default_search()
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
      LET ls_wc = ls_wc, " gzze001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzze002 = '", g_argv[02], "' AND "
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
 
{<section id="azzi920.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi920_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "gzze_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'gzze_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM gzze_t
          WHERE 
            gzze001 = ps_keys_bak[1] AND gzze002 = ps_keys_bak[2]
         
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
         CALL g_gzze_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_gzze1_info_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi920.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi920_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "gzze_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO gzze_t
                  (
                   gzze001,gzze002
                   ,gzzestus,gzze003,gzze004,gzze005,gzze006,gzze007,gzze008,gzze009,gzzemodid,gzzemoddt,gzzeownid,gzzeowndp,gzzecrtid,gzzecrtdp,gzzecrtdt) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzze_d[l_ac].gzzestus,g_gzze_d[l_ac].gzze003,g_gzze_d[l_ac].gzze004,g_gzze_d[l_ac].gzze005, 
                       g_gzze_d[l_ac].gzze006,g_gzze_d[l_ac].gzze007,g_gzze_d[l_ac].gzze008,g_gzze_d[l_ac].gzze009, 
                       g_gzze1_info_d[l_ac].gzzemodid,g_gzze1_info_d[l_ac].gzzemoddt,g_gzze1_info_d[l_ac].gzzeownid, 
                       g_gzze1_info_d[l_ac].gzzeowndp,g_gzze1_info_d[l_ac].gzzecrtid,g_gzze1_info_d[l_ac].gzzecrtdp, 
                       g_gzze1_info_d[l_ac].gzzecrtdt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzze_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi920.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi920_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "gzze_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzze_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE gzze_t 
         SET (gzze001,gzze002
              ,gzzestus,gzze003,gzze004,gzze005,gzze006,gzze007,gzze008,gzze009,gzzemodid,gzzemoddt,gzzeownid,gzzeowndp,gzzecrtid,gzzecrtdp,gzzecrtdt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzze_d[l_ac].gzzestus,g_gzze_d[l_ac].gzze003,g_gzze_d[l_ac].gzze004,g_gzze_d[l_ac].gzze005, 
                  g_gzze_d[l_ac].gzze006,g_gzze_d[l_ac].gzze007,g_gzze_d[l_ac].gzze008,g_gzze_d[l_ac].gzze009, 
                  g_gzze1_info_d[l_ac].gzzemodid,g_gzze1_info_d[l_ac].gzzemoddt,g_gzze1_info_d[l_ac].gzzeownid, 
                  g_gzze1_info_d[l_ac].gzzeowndp,g_gzze1_info_d[l_ac].gzzecrtid,g_gzze1_info_d[l_ac].gzzecrtdp, 
                  g_gzze1_info_d[l_ac].gzzecrtdt) 
         WHERE  gzze001 = ps_keys_bak[1] AND gzze002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzze_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzze_t:",SQLERRMESSAGE 
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
 
{<section id="azzi920.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi920_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL azzi920_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gzze_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi920_bcl USING 
                                       g_gzze_d[g_detail_idx].gzze001,g_gzze_d[g_detail_idx].gzze002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi920_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi920.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi920_unlock_b(ps_table)
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
      CLOSE azzi920_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi920.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION azzi920_modify_detail_chk(ps_record)
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
         LET ls_return = "gzzestus"
      WHEN "s_detail1_info"
         LET ls_return = "gzze001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi920.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION azzi920_show_ownid_msg()
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
 
{<section id="azzi920.mask_functions" >}
&include "erp/azz/azzi920_mask.4gl"
 
{</section>}
 
{<section id="azzi920.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi920_set_pk_array()
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
   LET g_pk_array[1].values = g_gzze_d[l_ac].gzze001
   LET g_pk_array[1].column = 'gzze001'
   LET g_pk_array[2].values = g_gzze_d[l_ac].gzze002
   LET g_pk_array[2].column = 'gzze002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi920.state_change" >}
   
 
{</section>}
 
{<section id="azzi920.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="azzi920.other_function" readonly="Y" >}
#+檢核 gzze001
#+欄位格式: 分類碼-NNNNN  分類碼為3碼英文或不存在  NNNNN 為數值  (特殊案例: !/fetch)
#+例如：-264 , -6319 (支援db或Genero)  lib-423, sui-00002 (支援 tiptop)
#+樹狀的錯誤訊息開放規則 tree-xxx (xxx為流水號, 000~999)
#+Db error 純數字  ex. -100 / -1001 / -9936
#+ 標準錯誤訊息 std-NNNNN  ex. std-00001
#+ 模組錯誤訊息  mod-NNNNN  ex. lib-00001 / lib-123 / sub-00002 / cwss-00001
#+ 行業程式內的訊息，行業代碼-NNNNNN  如 ph-000001  或   ic-000002  (兩碼)
#+ 未來行業包打包時，錯誤訊息抓取  1. 短線前面兩碼 = 這個行業的編號   2.短線前面三碼 = 這個行業轄下符合模組的編號
PRIVATE FUNCTION azzi920_check_gzze001()
   DEFINE ls_str      STRING 
   DEFINE ls_cls_code STRING    #取錯誤訊息代碼短線前面三碼
   DEFINE ls_num      STRING
   DEFINE ls_dash     STRING
   DEFINE li          LIKE type_t.num5
   DEFINE li_status   LIKE type_t.num5
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE li_pos      LIKE type_t.num5
   DEFINE lc_gzzj003  LIKE gzzj_t.gzzj003
   DEFINE ls_environment STRING 
   
   LET g_errno = NULL
   LET ls_str = g_gzze_d[l_ac].gzze001
   LET ls_str = ls_str.trim()
   
   #16/02/16 start 加入行業主機環境判規則 #160201-00011
   LET ls_environment = FGL_GETENV("DGENV")
   #(標準環境，DGENV= s ) 
   IF ls_environment IS NOT NULL AND ls_environment = "s" THEN
      #DGENV=s
      #標準環境(ERPID=T100ERP) 、100 Light(ERPID=T100EXT)、製藥業開發(ERPID=T100ERP)
      #TOPIND=sd                TOPIND=sd                 TOPIND=ph
      
      LET ls_environment = FGL_GETENV("TOPIND") #行業環境變數
      #行業環境變數標準(sd) 不檢查 
      IF ls_environment IS NULL OR ls_environment = "sd" THEN  

      ELSE
         #160512-00012#01 add
         #行業環境檢查  #找到'-' 位置
         LET li_pos = ls_str.getIndexOf("-",1)
         #確認行業是否存在
         IF NOT cl_chk_industry(ls_str.subString(1,li_pos-1)) THEN

         ELSE
            #行業不存在顯示錯誤訊息
            INITIALIZE g_errparam TO NULL
            LET g_errno = "azz-00378"
            LET g_errparam.code = g_errno
            LET g_errparam.extend = ""
            LET g_errparam.replace[1] = g_gzze_d[l_ac].gzze001
            LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
            #LET g_errparam.popup = TRUE
            IF g_argv[1] IS NULL OR g_argv[1] <> "debug" THEN
               #CALL cl_err() 
               RETURN                
            END IF             
         END IF
         #160512-00012#01 end         
      END IF  
   END IF
   #16/02/16 end
   
   #LET ls_str = g_gzze_d[l_ac].gzze001
   #LET ls_str = ls_str.trim()
   LET ls_str = ls_str.toLowerCase()
   #判斷是否數字
   IF cl_chk_num(ls_str,"N") THEN
      LET li_status = 1  #全部數字
   ELSE 
      LET li_status = 0  #其他  
   END IF 

   IF li_status = 1 THEN
      #全部數字 
      IF NOT ls_str.subString(1,1) = "-" THEN 
         LET li_status = -1 #數字開頭前面要加 -     
      END IF 
   END IF 

   #其他類型 的錯誤訊息
   IF li_status = 0 THEN 
      CASE 
         WHEN ls_str.subString(1,1) = "-" #-264
            LET ls_num = ls_str.subString(2,ls_str.getLength())
            #判斷錯誤訊息是 '-'+數字
            IF cl_chk_num(ls_num,"N") THEN 
               LET g_gzze_d[l_ac].gzze009 = "sd"             
               RETURN              #表示符合 
            ELSE 
               LET li_status = -1  #表示不符合 
            END IF
         WHEN ls_str.subString(1,4) = "tree" #樹狀的錯誤訊息開放規則tree-xxx (xxx為流水號, 000~999)
           #判斷錯誤訊息是 'tree'+'-'+流水號(3碼) 
            LET ls_num = ls_str.subString(6,ls_str.getLength())
            IF ls_num.getLength() >= 4 OR ls_num.getLength() < 3 THEN 
               LET li_status = -4  #表示不符合
            ELSE 
               IF cl_chk_num(ls_num,"N") THEN 
                  LET g_gzze_d[l_ac].gzze009 = "sd"             
                  RETURN              #表示符合
               ELSE 
                  LET li_status = -4  #表示不符合 
               END IF 
               
            END IF
         
         WHEN ls_str.subString(1,4) = "apse"   #apse開頭的錯誤訊息規則為 apse-xxxx (xxxx為流水號，0000~9999)
            #判斷錯誤訊息是 'apse'+'-'+流水號(4碼) 
            LET ls_num = ls_str.subString(6,ls_str.getLength())
            IF ls_num.getLength() > 4 OR ls_num.getLength() <= 3 THEN
               LET li_status = -4  #表示不符合
            ELSE
               IF cl_chk_num(ls_num,"N") THEN
                  LET g_gzze_d[l_ac].gzze009 = "sd"
                  RETURN              #表示符合
               ELSE
                  LET li_status = -4  #表示不符合
               END IF

            END IF
            
         WHEN ls_str = "fetch"
         #判斷錯誤訊息是 'fetch'
              LET g_gzze_d[l_ac].gzze009 = "sd"                         
              RETURN                   #表示符合
              
         WHEN ls_str.subString(1,1) = ASCII(33) #!
         #判斷錯誤訊息是 '!'
              LET g_gzze_d[l_ac].gzze009 = "sd"               
              RETURN                   #表示符合
              
         OTHERWISE #lib-423  or #azz-00001 #補加入行業別 行業程式內的訊息，行業代碼-NNNNN  如 ph-00001或ic-000002 (兩碼)
         #判斷錯誤訊息是 '模組'+'-'+流水號(5碼) 或 '行業代碼'+'-'+流水號(5碼)
         
            #標準錯誤訊息 std-NNNNN  ex. std-00001
            #模組錯誤訊息 mod-NNNNN  ex. lib-00001 / lib-123 / sub-00002 / cwss-0001
            #行業程式內的訊息，行業代碼-NNNNN  如 ph-000001 或 ic-000002 (兩碼)
            
            LET li_pos = ls_str.getIndexOf("-",1)
            LET ls_cls_code  = ls_str.subString(1,li_pos-1)
            LET ls_dash = ls_str.subString(li_pos,li_pos)
            LET ls_num = ls_str.subString(li_pos + 1 ,ls_str.getLength())

            #檢核 錯誤訊息代碼命名原則 一定要 分类码-NNNNN
            IF cl_chk_num(ls_cls_code,"L") AND ls_dash = "-" 
               AND cl_chk_num(ls_num,"N") THEN                                                      

               #檢核模組 (True:不是模組/False:是模組)
               IF cl_chk_module(UPSHIFT(ls_cls_code)) THEN 
                  #不是模組要等於 std 
                  IF ls_cls_code = "std" OR ls_cls_code = "tsd" THEN                     
                     LET li_status = 1  #還要檢核 後面5碼是否是數字                      
                  ELSE 
                     #不是 std 
                     #判斷行業別(True:不是行業/False:是行業)
                     IF cl_chk_industry(ls_cls_code) THEN
                        #表示都不符合
                        CASE 
                           WHEN ls_cls_code.getLength() >= 3 OR ls_cls_code.getLength() < 2
                                IF ls_cls_code.getLength() = 3 THEN 
                                    LET li_status = -2
                                ELSE 
                                    LET li_status = -1     
                                END IF 
                           WHEN ls_cls_code.getLength() = 2 
                                LET li_status = -3 #不符合行業訊息
                        END CASE 
                     ELSE
                        #是行業
                        CASE
                           #模組長度>=3
                           WHEN ls_cls_code.getLength() >= 3
                                LET li_status = -3
                           OTHERWISE 
                             #表示是行業
                             IF ls_num.getLength() = 5 THEN #流水號(5碼)
                                #檢查行業代碼不可以為sd
                                IF ls_cls_code = "sd" THEN 
                                   INITIALIZE g_errparam TO NULL
                                   LET g_errno = "azz-00179"
                                   LET g_errparam.code = g_errno
                                   LET g_errparam.extend = ""               
                                   #LET g_errparam.popup = FALSE
                                   #CALL cl_err()
                                   RETURN
                                END IF
                                #16/02/16 start 加入行業主機環境判規則 #160201-00011
                                #檢查在指定區域才可以設置指定的行業編號
                                IF NOT cl_chk_in_industry(ls_cls_code) THEN
                                   INITIALIZE g_errparam TO NULL
                                   LET g_errno = "azz-00378"
                                   LET g_errparam.code = g_errno
                                   LET g_errparam.extend = ""
                                   LET g_errparam.replace[1] = ls_cls_code
                                   LET g_errparam.replace[2] = FGL_GETENV("TOPIND")
                                   #LET g_errparam.popup = TRUE
                                   #CALL cl_err()
                                   RETURN
                                END IF
                                #16/02/16 END 
                                
                                LET g_gzze_d[l_ac].gzze009 = ls_cls_code                             
                                RETURN 
                             ELSE 
                                LET li_status = -3  #不符合行業後面5碼是數字 
                             END IF     
                           END CASE   
                     END IF 
                  END IF  
               ELSE 
                  LET li_status = 1  
  
               END IF #cl_chk_module 檢核模組
               
               #分类码-NNNNN 要額外檢查 NNNNN 是5碼數字流水號
               IF li_status > 0 THEN 
                   #檢核數字長度 最多5碼 lib sub qry clib csub cqry 例外
                  IF ls_cls_code = "lib" OR ls_cls_code = "sub" OR ls_cls_code = "qry" OR 
                     ls_cls_code = "clib" OR ls_cls_code = "csub" OR ls_cls_code = "cqry" THEN 
                                            #表示符合 
                     LET g_gzze_d[l_ac].gzze009 = "sd"
                     RETURN
                  ELSE 
                     IF ls_num.getLength() = 5 THEN  #表示符合
                                            
                        #確認行業模組
                        IF ls_cls_code.subString(1,1) = "b" THEN 
                           LET ls_sql = "SELECT gzzj003 FROM gzzj_t WHERE gzzj001 = '",ls_cls_code,"'" 
                           PREPARE azzi920_gzzj003_pre FROM ls_sql
                           EXECUTE azzi920_gzzj003_pre INTO lc_gzzj003 
                           FREE azzi920_gzzj003_pre
                           LET g_gzze_d[l_ac].gzze009 = DOWNSHIFT(lc_gzzj003[2,3])
                        ELSE 
                           LET g_gzze_d[l_ac].gzze009 = "sd"
                        END IF 
                     
                        RETURN
                     ELSE 
                        #-後面要5碼流水號
                        LET li_status = -1  #表示不符合
                     END IF 
                  END IF 
               END IF 
            ELSE 
               LET li_status = -1  #表示不符合 一般命名原則     
            END IF #END　IF cl_chk_num(ls_cls_code,"L") AND ls_dash = "-"
      END CASE     
   END IF 

   IF li_status < 0 THEN 
      INITIALIZE g_errparam TO NULL
         CASE 
            WHEN li_status = -1 

               IF FGL_GETENV("DGENV") = "s" THEN 
                  #標準環境下的錯誤訊息
                  LET g_errno = "azz-00041" #分类码-NNNNN分类码为3码英文或不存在NNNNN为数值(特殊案例:!)
               ELSE
                 #客製環境下的錯誤訊息
                 LET g_errno = "azz-00284"  #分类码-NNNNN分类码为3码英文或4碼英文(clib、csub、cqry、cwss)
               END IF
            WHEN li_status = -2
                 LET g_errno = "azz-00305"  #錯誤訊息編號前三碼要符合模組編號

            WHEN li_status = -3  
                  LET g_errno = "azz-00304" #不符合行業專用錯誤訊息命名原則 
            
            WHEN li_status = -4
               LET g_errno = "azz-00235"    #樹狀的錯誤訊息開頭tree-xxx(xxx為流水號000-999) 
         
         END CASE 
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ""
   END IF
END FUNCTION
#+ 把中文 轉成簡體中文
PRIVATE FUNCTION azzi920_trans_zh_cn_lang()
   DEFINE r_success     LIKE type_t.num5
   DEFINE ls_sql        STRING
   DEFINE lr_gzze_d     RECORD LIKE gzze_t.*
   DEFINE li_cnt        LIKE type_t.num5
   #DEFINE lc_count      LIKE type_t.num10
  
   LET r_success = TRUE
   LET g_action_choice=''
   
   IF NOT s_transaction_chk('Y','1') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF g_gzze_d.getLength() = 0 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET ls_sql = "SELECT COUNT(*) FROM gzze_t WHERE gzze002 = 'zh_TW'"

   PREPARE azzi920_p_count_pre FROM ls_sql
   EXECUTE azzi920_p_count_pre INTO li_cnt

   IF cl_null(li_cnt) THEN
      LET li_cnt = 0
   END IF
   IF li_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   ELSE   
      CALL cl_progress_bar(li_cnt)
   END IF 
   LET li_cnt = 0

   LET ls_sql = "SELECT * FROM gzze_t WHERE gzze002 = 'zh_TW'"
   DECLARE azzi920_zh_tw_cs CURSOR FROM ls_sql
   FOREACH azzi920_zh_tw_cs INTO lr_gzze_d.*    
       CALL cl_progress_ing(lr_gzze_d.gzze001) 

       SELECT COUNT(*) INTO li_cnt FROM gzze_t 
        WHERE gzze001 = lr_gzze_d.gzze001
          AND gzze002 = 'zh_CN'
       
       IF li_cnt = 0 THEN 
          LET lr_gzze_d.gzzestus = "Y"
          LET lr_gzze_d.gzze002 =  "zh_CN"
          IF NOT cl_null(lr_gzze_d.gzze003) THEN 
              LET lr_gzze_d.gzze003 = cl_trans_code_tw_cn("zh_CN",lr_gzze_d.gzze003)
          END IF 
          IF NOT cl_null(lr_gzze_d.gzze004) THEN 
              LET lr_gzze_d.gzze004 = cl_trans_code_tw_cn("zh_CN",lr_gzze_d.gzze004)
          END IF
          IF NOT cl_null(lr_gzze_d.gzze006) THEN 
              LET lr_gzze_d.gzze006 = cl_trans_code_tw_cn("zh_CN",lr_gzze_d.gzze006)
          END IF
          #LET lr_gzze_d.gzze004 = cl_trans_code_tw_cn("zh_CN",lr_gzze_d.gzze004)
          #LET lr_gzze_d.gzze006 = cl_trans_code_tw_cn("zh_CN",lr_gzze_d.gzze006)

          INSERT INTO gzze_t VALUES ( lr_gzze_d.* )
       END IF  
   END FOREACH 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 在產中不能打c開頭的訊息代碼；在客戶家一定得打c開頭的訊息代碼   
# Memo...........:
# Usage..........: CALL azzi920_check_gzze001_2(p_gzze001)
#                  RETURNING 回传参数
# Input parameter: p_gzze001   訊息代碼
# Return code....: 
# Date & Author..: 2014/05/30 By tsai_yen
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi920_check_gzze001_2(p_gzze001)
   DEFINE p_gzze001   LIKE gzze_t.gzze001   #g_gzze_d[l_ac].gzze001
   DEFINE l_dgenv     LIKE type_t.chr1      #環境變數DGENV使用標示(s:標準/ c:客製)
   DEFINE l_str       STRING 
   
   LET g_errno = NULL
   LET l_dgenv = FGL_GETENV("DGENV") CLIPPED   
   LET l_str = p_gzze001
   LET l_str = l_str.subString(1,1)
   LET l_str = DOWNSHIFT(l_str)
   
   CASE
      #標準區用到C開頭的
      WHEN l_dgenv = "s" AND l_str = "c"
         LET g_errno = "azz-00071"
      #客製區用到非C開頭的
      WHEN l_dgenv = "c" AND (l_str <> "c") 
         #160919-00020 #1 start
         #若為topapp帳號,增加準用 tsd-開頭
         IF g_account = "topapp" AND p_gzze001[1,4] = "tsd-" THEN
         ELSE
            LET g_errno = "azz-00198"
         END IF
         ##160919-00020 #1 end
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 標準錯誤訊息編號 在客戶家不可以修改或刪除
# Memo...........:
# Usage..........: CALL azzi920_check_gzze001_3(pc_gzze001_old)
#                  RETURNING 
# Input parameter: pc_gzze001_old 訊息編號
# Return code....: 
# Date & Author..: 2014/12/11 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi920_check_gzze001_3(pc_gzze001_old)
   DEFINE ps_gzze001_old  STRING
   DEFINE pc_gzze001_old  LIKE gzze_t.gzze001
   DEFINE li_index        LIKE type_t.num5
   DEFINE li_index2       LIKE type_t.num5
   DEFINE li_cnt          LIKE type_t.num5
   DEFINE li_chk          LIKE type_t.num5

   LET g_errno = NULL
   #只要是產中設定 標準錯誤訊息編號，在客製環境下，不可修改或刪除
   #xxx-NNNNN 、 100 、! 、tree-xxx
   SELECT COUNT(*) INTO li_cnt FROM gzze_t
    WHERE gzze001 = pc_gzze001_old 

   IF li_cnt > 0 THEN 
      LET ps_gzze001_old = DOWNSHIFT(pc_gzze001_old)
      #確定是否客製的錯誤訊息編號      
      IF ps_gzze001_old.subString(1,1) = "c" OR ps_gzze001_old.subString(1,1) = "d" OR 
            ps_gzze001_old.subString(1,3) = "enu" OR ps_gzze001_old.subString(1,4) = "tsd-" THEN  #160919-00067#01  tsd- 可以在客戶家客製修改 
         LET li_chk = TRUE 
      ELSE 
         LET li_chk = FALSE         
      END IF 
         
      IF FGL_GETENV("DGENV") = "s" THEN 
         #客製錯誤訊息碼，在產中不可以修改  
         IF li_chk THEN 
            LET g_errno = "azz-00286" #客製的錯誤訊息編號，不可修改或刪除
         END IF  
      ELSE
         #標準環境 錯誤訊息碼，在客戶家不可以修改 
         IF NOT li_chk THEN #
            LET g_errno = "azz-00285" #標準錯誤訊息編號，不可修改或刪除
         END IF     
      END IF 
   END IF  
END FUNCTION

 
{</section>}
 
