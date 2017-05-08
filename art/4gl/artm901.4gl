#該程式未解開Section, 採用最新樣板產出!
{<section id="artm901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-08-28 23:15:03), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: artm901
#+ Description: 預算每日係數設定作業
#+ Creator....: 01752(2015-06-30 19:42:19)
#+ Modifier...: 01752 -SD/PR- 00000
 
{</section>}
 
{<section id="artm901.global" >}
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
PRIVATE TYPE type_g_rtcc_d RECORD
       rtcc001 LIKE rtcc_t.rtcc001, 
   rtcc002 LIKE rtcc_t.rtcc002, 
   rtcc003 LIKE rtcc_t.rtcc003, 
   rtcc004 LIKE rtcc_t.rtcc004, 
   rtcc005 LIKE rtcc_t.rtcc005, 
   rtcc006 LIKE rtcc_t.rtcc006, 
   rtcc007 LIKE rtcc_t.rtcc007, 
   rtcc008 LIKE rtcc_t.rtcc008, 
   rtcc009 LIKE rtcc_t.rtcc009, 
   rtcc010 LIKE rtcc_t.rtcc010, 
   rtcc011 LIKE rtcc_t.rtcc011, 
   rtcc012 LIKE rtcc_t.rtcc012, 
   rtcc013 LIKE rtcc_t.rtcc013, 
   rtcc014 LIKE rtcc_t.rtcc014, 
   rtcc015 LIKE rtcc_t.rtcc015, 
   rtcc016 LIKE rtcc_t.rtcc016, 
   rtcc017 LIKE rtcc_t.rtcc017, 
   rtcc018 LIKE rtcc_t.rtcc018, 
   rtcc019 LIKE rtcc_t.rtcc019, 
   rtcc020 LIKE rtcc_t.rtcc020, 
   rtcc021 LIKE rtcc_t.rtcc021, 
   rtcc022 LIKE rtcc_t.rtcc022, 
   rtcc023 LIKE rtcc_t.rtcc023, 
   rtcc024 LIKE rtcc_t.rtcc024, 
   rtcc025 LIKE rtcc_t.rtcc025, 
   rtcc026 LIKE rtcc_t.rtcc026, 
   rtcc027 LIKE rtcc_t.rtcc027, 
   rtcc028 LIKE rtcc_t.rtcc028, 
   rtcc029 LIKE rtcc_t.rtcc029, 
   rtcc030 LIKE rtcc_t.rtcc030, 
   rtcc031 LIKE rtcc_t.rtcc031, 
   rtcc032 LIKE rtcc_t.rtcc032, 
   rtcc033 LIKE rtcc_t.rtcc033, 
   rtccunit LIKE rtcc_t.rtccunit, 
   rtccstus LIKE rtcc_t.rtccstus
       END RECORD
PRIVATE TYPE type_g_rtcc2_d RECORD
       rtcc001 LIKE rtcc_t.rtcc001, 
   rtcc002 LIKE rtcc_t.rtcc002, 
   rtccownid LIKE rtcc_t.rtccownid, 
   rtccownid_desc LIKE type_t.chr500, 
   rtccowndp LIKE rtcc_t.rtccowndp, 
   rtccowndp_desc LIKE type_t.chr500, 
   rtcccrtid LIKE rtcc_t.rtcccrtid, 
   rtcccrtid_desc LIKE type_t.chr500, 
   rtcccrtdp LIKE rtcc_t.rtcccrtdp, 
   rtcccrtdp_desc LIKE type_t.chr500, 
   rtcccrtdt DATETIME YEAR TO SECOND, 
   rtccmodid LIKE rtcc_t.rtccmodid, 
   rtccmodid_desc LIKE type_t.chr500, 
   rtccmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rtcc          DYNAMIC ARRAY OF type_g_rtcc_d  #rowtype 暫存陣列
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtcc_d          DYNAMIC ARRAY OF type_g_rtcc_d #單身變數
DEFINE g_rtcc_d_t        type_g_rtcc_d                  #單身備份
DEFINE g_rtcc_d_o        type_g_rtcc_d                  #單身備份
DEFINE g_rtcc_d_mask_o   DYNAMIC ARRAY OF type_g_rtcc_d #單身變數
DEFINE g_rtcc_d_mask_n   DYNAMIC ARRAY OF type_g_rtcc_d #單身變數
DEFINE g_rtcc2_d   DYNAMIC ARRAY OF type_g_rtcc2_d
DEFINE g_rtcc2_d_t type_g_rtcc2_d
DEFINE g_rtcc2_d_o type_g_rtcc2_d
DEFINE g_rtcc2_d_mask_o DYNAMIC ARRAY OF type_g_rtcc2_d
DEFINE g_rtcc2_d_mask_n DYNAMIC ARRAY OF type_g_rtcc2_d
 
      
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
 
{<section id="artm901.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtcc001,rtcc002,rtcc003,rtcc004,rtcc005,rtcc006,rtcc007,rtcc008,rtcc009, 
       rtcc010,rtcc011,rtcc012,rtcc013,rtcc014,rtcc015,rtcc016,rtcc017,rtcc018,rtcc019,rtcc020,rtcc021, 
       rtcc022,rtcc023,rtcc024,rtcc025,rtcc026,rtcc027,rtcc028,rtcc029,rtcc030,rtcc031,rtcc032,rtcc033, 
       rtccunit,rtccstus,rtcc001,rtcc002,rtccownid,rtccowndp,rtcccrtid,rtcccrtdp,rtcccrtdt,rtccmodid, 
       rtccmoddt FROM rtcc_t WHERE rtccent=? AND rtcc001=? AND rtcc002=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artm901_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artm901 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artm901_init()   
 
      #進入選單 Menu (="N")
      CALL artm901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artm901
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL artm901_01_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artm901.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION artm901_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('rtcc002','6833') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL artm901_01_create_temp() RETURNING l_success
   CALL cl_set_combo_scc('rtcc002_2','6833') 
   #end add-point
   
   CALL artm901_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="artm901.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION artm901_ui_dialog()
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
         CALL g_rtcc_d.clear()
         CALL g_rtcc2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL artm901_init()
      END IF
   
      CALL artm901_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtcc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_rtcc2_d[g_detail_idx].rtccownid   #(ver:35)
               LET g_data_dept = g_rtcc2_d[g_detail_idx].rtccowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL artm901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtcc2_d TO s_detail2.*
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
   CALL artm901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
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
            CALL DIALOG.setSelectionMode("s_detail2", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_rtcd
            LET g_action_choice="gen_rtcd"
            IF cl_auth_chk_act("gen_rtcd") THEN
               
               #add-point:ON ACTION gen_rtcd name="menu.gen_rtcd"
               CALL s_transaction_begin()
               IF artm901_01() THEN
                  IF NOT INT_FLAG THEN
                     CALL s_transaction_end('Y','1')
                  END IF
               ELSE
                  CALL s_transaction_end('N','1')
               END IF         

               LET INT_FLAG = 0 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL artm901_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL artm901_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL artm901_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL artm901_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL artm901_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL artm901_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artm901_insert()
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artm901_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtcc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtcc2_d)
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
            CALL artm901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artm901_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artm901_set_pk_array()
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
 
{<section id="artm901.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION artm901_query()
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
   CALL g_rtcc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON rtcc001,rtcc002,rtcc003,rtcc004,rtcc005,rtcc006,rtcc007,rtcc008,rtcc009,rtcc010, 
          rtcc011,rtcc012,rtcc013,rtcc014,rtcc015,rtcc016,rtcc017,rtcc018,rtcc019,rtcc020,rtcc021,rtcc022, 
          rtcc023,rtcc024,rtcc025,rtcc026,rtcc027,rtcc028,rtcc029,rtcc030,rtcc031,rtcc032,rtcc033,rtccunit, 
          rtccstus,rtccownid,rtccowndp,rtcccrtid,rtcccrtdp,rtcccrtdt,rtccmodid,rtccmoddt 
 
         FROM s_detail1[1].rtcc001,s_detail1[1].rtcc002,s_detail1[1].rtcc003,s_detail1[1].rtcc004,s_detail1[1].rtcc005, 
             s_detail1[1].rtcc006,s_detail1[1].rtcc007,s_detail1[1].rtcc008,s_detail1[1].rtcc009,s_detail1[1].rtcc010, 
             s_detail1[1].rtcc011,s_detail1[1].rtcc012,s_detail1[1].rtcc013,s_detail1[1].rtcc014,s_detail1[1].rtcc015, 
             s_detail1[1].rtcc016,s_detail1[1].rtcc017,s_detail1[1].rtcc018,s_detail1[1].rtcc019,s_detail1[1].rtcc020, 
             s_detail1[1].rtcc021,s_detail1[1].rtcc022,s_detail1[1].rtcc023,s_detail1[1].rtcc024,s_detail1[1].rtcc025, 
             s_detail1[1].rtcc026,s_detail1[1].rtcc027,s_detail1[1].rtcc028,s_detail1[1].rtcc029,s_detail1[1].rtcc030, 
             s_detail1[1].rtcc031,s_detail1[1].rtcc032,s_detail1[1].rtcc033,s_detail1[1].rtccunit,s_detail1[1].rtccstus, 
             s_detail2[1].rtccownid,s_detail2[1].rtccowndp,s_detail2[1].rtcccrtid,s_detail2[1].rtcccrtdp, 
             s_detail2[1].rtcccrtdt,s_detail2[1].rtccmodid,s_detail2[1].rtccmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtcccrtdt>>----
         AFTER FIELD rtcccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtccmoddt>>----
         AFTER FIELD rtccmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtcccnfdt>>----
         
         #----<<rtccpstdt>>----
 
 
 
      
                  #Ctrlp:construct.c.page1.rtcc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc001
            #add-point:ON ACTION controlp INFIELD rtcc001 name="construct.c.page1.rtcc001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtcc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcc001  #顯示到畫面上
            NEXT FIELD rtcc001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc001
            #add-point:BEFORE FIELD rtcc001 name="query.b.page1.rtcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc001
            
            #add-point:AFTER FIELD rtcc001 name="query.a.page1.rtcc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc002
            #add-point:BEFORE FIELD rtcc002 name="query.b.page1.rtcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc002
            
            #add-point:AFTER FIELD rtcc002 name="query.a.page1.rtcc002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc002
            #add-point:ON ACTION controlp INFIELD rtcc002 name="query.c.page1.rtcc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc003
            #add-point:BEFORE FIELD rtcc003 name="query.b.page1.rtcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc003
            
            #add-point:AFTER FIELD rtcc003 name="query.a.page1.rtcc003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc003
            #add-point:ON ACTION controlp INFIELD rtcc003 name="query.c.page1.rtcc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc004
            #add-point:BEFORE FIELD rtcc004 name="query.b.page1.rtcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc004
            
            #add-point:AFTER FIELD rtcc004 name="query.a.page1.rtcc004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc004
            #add-point:ON ACTION controlp INFIELD rtcc004 name="query.c.page1.rtcc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc005
            #add-point:BEFORE FIELD rtcc005 name="query.b.page1.rtcc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc005
            
            #add-point:AFTER FIELD rtcc005 name="query.a.page1.rtcc005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc005
            #add-point:ON ACTION controlp INFIELD rtcc005 name="query.c.page1.rtcc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc006
            #add-point:BEFORE FIELD rtcc006 name="query.b.page1.rtcc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc006
            
            #add-point:AFTER FIELD rtcc006 name="query.a.page1.rtcc006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc006
            #add-point:ON ACTION controlp INFIELD rtcc006 name="query.c.page1.rtcc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc007
            #add-point:BEFORE FIELD rtcc007 name="query.b.page1.rtcc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc007
            
            #add-point:AFTER FIELD rtcc007 name="query.a.page1.rtcc007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc007
            #add-point:ON ACTION controlp INFIELD rtcc007 name="query.c.page1.rtcc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc008
            #add-point:BEFORE FIELD rtcc008 name="query.b.page1.rtcc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc008
            
            #add-point:AFTER FIELD rtcc008 name="query.a.page1.rtcc008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc008
            #add-point:ON ACTION controlp INFIELD rtcc008 name="query.c.page1.rtcc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc009
            #add-point:BEFORE FIELD rtcc009 name="query.b.page1.rtcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc009
            
            #add-point:AFTER FIELD rtcc009 name="query.a.page1.rtcc009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc009
            #add-point:ON ACTION controlp INFIELD rtcc009 name="query.c.page1.rtcc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc010
            #add-point:BEFORE FIELD rtcc010 name="query.b.page1.rtcc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc010
            
            #add-point:AFTER FIELD rtcc010 name="query.a.page1.rtcc010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc010
            #add-point:ON ACTION controlp INFIELD rtcc010 name="query.c.page1.rtcc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc011
            #add-point:BEFORE FIELD rtcc011 name="query.b.page1.rtcc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc011
            
            #add-point:AFTER FIELD rtcc011 name="query.a.page1.rtcc011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc011
            #add-point:ON ACTION controlp INFIELD rtcc011 name="query.c.page1.rtcc011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc012
            #add-point:BEFORE FIELD rtcc012 name="query.b.page1.rtcc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc012
            
            #add-point:AFTER FIELD rtcc012 name="query.a.page1.rtcc012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc012
            #add-point:ON ACTION controlp INFIELD rtcc012 name="query.c.page1.rtcc012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc013
            #add-point:BEFORE FIELD rtcc013 name="query.b.page1.rtcc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc013
            
            #add-point:AFTER FIELD rtcc013 name="query.a.page1.rtcc013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc013
            #add-point:ON ACTION controlp INFIELD rtcc013 name="query.c.page1.rtcc013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc014
            #add-point:BEFORE FIELD rtcc014 name="query.b.page1.rtcc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc014
            
            #add-point:AFTER FIELD rtcc014 name="query.a.page1.rtcc014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc014
            #add-point:ON ACTION controlp INFIELD rtcc014 name="query.c.page1.rtcc014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc015
            #add-point:BEFORE FIELD rtcc015 name="query.b.page1.rtcc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc015
            
            #add-point:AFTER FIELD rtcc015 name="query.a.page1.rtcc015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc015
            #add-point:ON ACTION controlp INFIELD rtcc015 name="query.c.page1.rtcc015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc016
            #add-point:BEFORE FIELD rtcc016 name="query.b.page1.rtcc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc016
            
            #add-point:AFTER FIELD rtcc016 name="query.a.page1.rtcc016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc016
            #add-point:ON ACTION controlp INFIELD rtcc016 name="query.c.page1.rtcc016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc017
            #add-point:BEFORE FIELD rtcc017 name="query.b.page1.rtcc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc017
            
            #add-point:AFTER FIELD rtcc017 name="query.a.page1.rtcc017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc017
            #add-point:ON ACTION controlp INFIELD rtcc017 name="query.c.page1.rtcc017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc018
            #add-point:BEFORE FIELD rtcc018 name="query.b.page1.rtcc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc018
            
            #add-point:AFTER FIELD rtcc018 name="query.a.page1.rtcc018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc018
            #add-point:ON ACTION controlp INFIELD rtcc018 name="query.c.page1.rtcc018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc019
            #add-point:BEFORE FIELD rtcc019 name="query.b.page1.rtcc019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc019
            
            #add-point:AFTER FIELD rtcc019 name="query.a.page1.rtcc019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc019
            #add-point:ON ACTION controlp INFIELD rtcc019 name="query.c.page1.rtcc019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc020
            #add-point:BEFORE FIELD rtcc020 name="query.b.page1.rtcc020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc020
            
            #add-point:AFTER FIELD rtcc020 name="query.a.page1.rtcc020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc020
            #add-point:ON ACTION controlp INFIELD rtcc020 name="query.c.page1.rtcc020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc021
            #add-point:BEFORE FIELD rtcc021 name="query.b.page1.rtcc021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc021
            
            #add-point:AFTER FIELD rtcc021 name="query.a.page1.rtcc021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc021
            #add-point:ON ACTION controlp INFIELD rtcc021 name="query.c.page1.rtcc021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc022
            #add-point:BEFORE FIELD rtcc022 name="query.b.page1.rtcc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc022
            
            #add-point:AFTER FIELD rtcc022 name="query.a.page1.rtcc022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc022
            #add-point:ON ACTION controlp INFIELD rtcc022 name="query.c.page1.rtcc022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc023
            #add-point:BEFORE FIELD rtcc023 name="query.b.page1.rtcc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc023
            
            #add-point:AFTER FIELD rtcc023 name="query.a.page1.rtcc023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc023
            #add-point:ON ACTION controlp INFIELD rtcc023 name="query.c.page1.rtcc023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc024
            #add-point:BEFORE FIELD rtcc024 name="query.b.page1.rtcc024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc024
            
            #add-point:AFTER FIELD rtcc024 name="query.a.page1.rtcc024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc024
            #add-point:ON ACTION controlp INFIELD rtcc024 name="query.c.page1.rtcc024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc025
            #add-point:BEFORE FIELD rtcc025 name="query.b.page1.rtcc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc025
            
            #add-point:AFTER FIELD rtcc025 name="query.a.page1.rtcc025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc025
            #add-point:ON ACTION controlp INFIELD rtcc025 name="query.c.page1.rtcc025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc026
            #add-point:BEFORE FIELD rtcc026 name="query.b.page1.rtcc026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc026
            
            #add-point:AFTER FIELD rtcc026 name="query.a.page1.rtcc026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc026
            #add-point:ON ACTION controlp INFIELD rtcc026 name="query.c.page1.rtcc026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc027
            #add-point:BEFORE FIELD rtcc027 name="query.b.page1.rtcc027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc027
            
            #add-point:AFTER FIELD rtcc027 name="query.a.page1.rtcc027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc027
            #add-point:ON ACTION controlp INFIELD rtcc027 name="query.c.page1.rtcc027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc028
            #add-point:BEFORE FIELD rtcc028 name="query.b.page1.rtcc028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc028
            
            #add-point:AFTER FIELD rtcc028 name="query.a.page1.rtcc028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc028
            #add-point:ON ACTION controlp INFIELD rtcc028 name="query.c.page1.rtcc028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc029
            #add-point:BEFORE FIELD rtcc029 name="query.b.page1.rtcc029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc029
            
            #add-point:AFTER FIELD rtcc029 name="query.a.page1.rtcc029"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc029
            #add-point:ON ACTION controlp INFIELD rtcc029 name="query.c.page1.rtcc029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc030
            #add-point:BEFORE FIELD rtcc030 name="query.b.page1.rtcc030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc030
            
            #add-point:AFTER FIELD rtcc030 name="query.a.page1.rtcc030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc030
            #add-point:ON ACTION controlp INFIELD rtcc030 name="query.c.page1.rtcc030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc031
            #add-point:BEFORE FIELD rtcc031 name="query.b.page1.rtcc031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc031
            
            #add-point:AFTER FIELD rtcc031 name="query.a.page1.rtcc031"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc031
            #add-point:ON ACTION controlp INFIELD rtcc031 name="query.c.page1.rtcc031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc032
            #add-point:BEFORE FIELD rtcc032 name="query.b.page1.rtcc032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc032
            
            #add-point:AFTER FIELD rtcc032 name="query.a.page1.rtcc032"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc032
            #add-point:ON ACTION controlp INFIELD rtcc032 name="query.c.page1.rtcc032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc033
            #add-point:BEFORE FIELD rtcc033 name="query.b.page1.rtcc033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc033
            
            #add-point:AFTER FIELD rtcc033 name="query.a.page1.rtcc033"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcc033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc033
            #add-point:ON ACTION controlp INFIELD rtcc033 name="query.c.page1.rtcc033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccunit
            #add-point:BEFORE FIELD rtccunit name="query.b.page1.rtccunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccunit
            
            #add-point:AFTER FIELD rtccunit name="query.a.page1.rtccunit"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtccunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccunit
            #add-point:ON ACTION controlp INFIELD rtccunit name="query.c.page1.rtccunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccstus
            #add-point:BEFORE FIELD rtccstus name="query.b.page1.rtccstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccstus
            
            #add-point:AFTER FIELD rtccstus name="query.a.page1.rtccstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccstus
            #add-point:ON ACTION controlp INFIELD rtccstus name="query.c.page1.rtccstus"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.rtccownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccownid
            #add-point:ON ACTION controlp INFIELD rtccownid name="construct.c.page2.rtccownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtccownid  #顯示到畫面上
            NEXT FIELD rtccownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccownid
            #add-point:BEFORE FIELD rtccownid name="query.b.page2.rtccownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccownid
            
            #add-point:AFTER FIELD rtccownid name="query.a.page2.rtccownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtccowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccowndp
            #add-point:ON ACTION controlp INFIELD rtccowndp name="construct.c.page2.rtccowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtccowndp  #顯示到畫面上
            NEXT FIELD rtccowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccowndp
            #add-point:BEFORE FIELD rtccowndp name="query.b.page2.rtccowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccowndp
            
            #add-point:AFTER FIELD rtccowndp name="query.a.page2.rtccowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcccrtid
            #add-point:ON ACTION controlp INFIELD rtcccrtid name="construct.c.page2.rtcccrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcccrtid  #顯示到畫面上
            NEXT FIELD rtcccrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcccrtid
            #add-point:BEFORE FIELD rtcccrtid name="query.b.page2.rtcccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcccrtid
            
            #add-point:AFTER FIELD rtcccrtid name="query.a.page2.rtcccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcccrtdp
            #add-point:ON ACTION controlp INFIELD rtcccrtdp name="construct.c.page2.rtcccrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcccrtdp  #顯示到畫面上
            NEXT FIELD rtcccrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcccrtdp
            #add-point:BEFORE FIELD rtcccrtdp name="query.b.page2.rtcccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcccrtdp
            
            #add-point:AFTER FIELD rtcccrtdp name="query.a.page2.rtcccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcccrtdt
            #add-point:BEFORE FIELD rtcccrtdt name="query.b.page2.rtcccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtccmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccmodid
            #add-point:ON ACTION controlp INFIELD rtccmodid name="construct.c.page2.rtccmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtccmodid  #顯示到畫面上
            NEXT FIELD rtccmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccmodid
            #add-point:BEFORE FIELD rtccmodid name="query.b.page2.rtccmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccmodid
            
            #add-point:AFTER FIELD rtccmodid name="query.a.page2.rtccmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccmoddt
            #add-point:BEFORE FIELD rtccmoddt name="query.b.page2.rtccmoddt"
            
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
    
   CALL artm901_b_fill(g_wc2)
   LET g_data_owner = g_rtcc2_d[g_detail_idx].rtccownid   #(ver:35)
   LET g_data_dept = g_rtcc2_d[g_detail_idx].rtccowndp   #(ver:35)
 
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
 
{<section id="artm901.insert" >}
#+ 資料新增
PRIVATE FUNCTION artm901_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL artm901_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artm901.modify" >}
#+ 資料修改
PRIVATE FUNCTION artm901_modify()
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
   DEFINE  l_year                 LIKE type_t.num5
   DEFINE  l_month                LIKE type_t.num5
   DEFINE  l_ooef008              LIKE ooef_t.ooef008
   DEFINE  l_ooef010              LIKE ooef_t.ooef010
   DEFINE  l_num                  LIKE type_t.num20_6
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
      INPUT ARRAY g_rtcc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtcc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artm901_b_fill(g_wc2)
            LET g_detail_cnt = g_rtcc_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            #控制使用者只能維護 行類型=3.預算係數的資料
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc002) AND g_rtcc_d[l_ac].rtcc002 != '3' THEN
               LET l_ac = l_ac + 1
               LET g_detail_idx = l_ac
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_rtcc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtcc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtcc_d[l_ac].rtcc001 IS NOT NULL
               AND g_rtcc_d[l_ac].rtcc002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtcc_d_t.* = g_rtcc_d[l_ac].*  #BACKUP
               LET g_rtcc_d_o.* = g_rtcc_d[l_ac].*  #BACKUP
               IF NOT artm901_lock_b("rtcc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artm901_bcl INTO g_rtcc_d[l_ac].rtcc001,g_rtcc_d[l_ac].rtcc002,g_rtcc_d[l_ac].rtcc003, 
                      g_rtcc_d[l_ac].rtcc004,g_rtcc_d[l_ac].rtcc005,g_rtcc_d[l_ac].rtcc006,g_rtcc_d[l_ac].rtcc007, 
                      g_rtcc_d[l_ac].rtcc008,g_rtcc_d[l_ac].rtcc009,g_rtcc_d[l_ac].rtcc010,g_rtcc_d[l_ac].rtcc011, 
                      g_rtcc_d[l_ac].rtcc012,g_rtcc_d[l_ac].rtcc013,g_rtcc_d[l_ac].rtcc014,g_rtcc_d[l_ac].rtcc015, 
                      g_rtcc_d[l_ac].rtcc016,g_rtcc_d[l_ac].rtcc017,g_rtcc_d[l_ac].rtcc018,g_rtcc_d[l_ac].rtcc019, 
                      g_rtcc_d[l_ac].rtcc020,g_rtcc_d[l_ac].rtcc021,g_rtcc_d[l_ac].rtcc022,g_rtcc_d[l_ac].rtcc023, 
                      g_rtcc_d[l_ac].rtcc024,g_rtcc_d[l_ac].rtcc025,g_rtcc_d[l_ac].rtcc026,g_rtcc_d[l_ac].rtcc027, 
                      g_rtcc_d[l_ac].rtcc028,g_rtcc_d[l_ac].rtcc029,g_rtcc_d[l_ac].rtcc030,g_rtcc_d[l_ac].rtcc031, 
                      g_rtcc_d[l_ac].rtcc032,g_rtcc_d[l_ac].rtcc033,g_rtcc_d[l_ac].rtccunit,g_rtcc_d[l_ac].rtccstus, 
                      g_rtcc2_d[l_ac].rtcc001,g_rtcc2_d[l_ac].rtcc002,g_rtcc2_d[l_ac].rtccownid,g_rtcc2_d[l_ac].rtccowndp, 
                      g_rtcc2_d[l_ac].rtcccrtid,g_rtcc2_d[l_ac].rtcccrtdp,g_rtcc2_d[l_ac].rtcccrtdt, 
                      g_rtcc2_d[l_ac].rtccmodid,g_rtcc2_d[l_ac].rtccmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtcc_d_t.rtcc001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtcc_d_mask_o[l_ac].* =  g_rtcc_d[l_ac].*
                  CALL artm901_rtcc_t_mask()
                  LET g_rtcc_d_mask_n[l_ac].* =  g_rtcc_d[l_ac].*
                  
                  CALL artm901_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL artm901_set_entry_b(l_cmd)
            CALL artm901_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL artm901_set_entry_b(l_cmd)
            #160406-00005#1 Add By Ken 160411(S)
            #CALL artm901_set_no_required_b(l_cmd)
            #CALL artm901_set_required_b(l_cmd)
            #160406-00005#1 Add By Ken 160411(E)
            CALL artm901_set_no_entry_b(l_cmd)
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
            INITIALIZE g_rtcc_d_t.* TO NULL
            INITIALIZE g_rtcc_d_o.* TO NULL
            INITIALIZE g_rtcc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtcc2_d[l_ac].rtccownid = g_user
      LET g_rtcc2_d[l_ac].rtccowndp = g_dept
      LET g_rtcc2_d[l_ac].rtcccrtid = g_user
      LET g_rtcc2_d[l_ac].rtcccrtdp = g_dept 
      LET g_rtcc2_d[l_ac].rtcccrtdt = cl_get_current()
      LET g_rtcc2_d[l_ac].rtccmodid = g_user
      LET g_rtcc2_d[l_ac].rtccmoddt = cl_get_current()
      LET g_rtcc_d[l_ac].rtccstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_rtcc_d[l_ac].rtcc002 = "1"
      LET g_rtcc_d[l_ac].rtccstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_rtcc_d[l_ac].rtccunit = g_site
            #end add-point
            LET g_rtcc_d_t.* = g_rtcc_d[l_ac].*     #新輸入資料
            LET g_rtcc_d_o.* = g_rtcc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtcc_d[li_reproduce_target].* = g_rtcc_d[li_reproduce].*
               LET g_rtcc2_d[li_reproduce_target].* = g_rtcc2_d[li_reproduce].*
 
               LET g_rtcc_d[g_rtcc_d.getLength()].rtcc001 = NULL
               LET g_rtcc_d[g_rtcc_d.getLength()].rtcc002 = NULL
 
            END IF
            
 
 
            CALL artm901_set_entry_b(l_cmd)
            CALL artm901_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM rtcc_t 
             WHERE rtccent = g_enterprise AND rtcc001 = g_rtcc_d[l_ac].rtcc001
                                       AND rtcc002 = g_rtcc_d[l_ac].rtcc002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               CALL artm901_def_rowtype_1()
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcc_d[g_detail_idx].rtcc001
               LET gs_keys[2] = g_rtcc_d[g_detail_idx].rtcc002
               CALL artm901_insert_b('rtcc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtcc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artm901_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               LET l_ac = g_rtcc_d.getLength() + 1
               CALL artm901_def_rowtype_2()
               INITIALIZE gs_keys TO NULL                
               LET gs_keys[1] = g_rtcc_d[l_ac].rtcc001
               LET gs_keys[2] = g_rtcc_d[l_ac].rtcc002
               CALL artm901_insert_b('rtcc_t',gs_keys,"'1'")             
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtcc_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
               
               LET l_ac = g_rtcc_d.getLength() + 1
               CALL artm901_def_rowtype_3()
               INITIALIZE gs_keys TO NULL                
               LET gs_keys[1] = g_rtcc_d[l_ac].rtcc001
               LET gs_keys[2] = g_rtcc_d[l_ac].rtcc002
               CALL artm901_insert_b('rtcc_t',gs_keys,"'1'")             
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtcc_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
               
               #後續修改注意,此段為新增程序都完成後 才可以執行 --- S
               LET g_detail_cnt = g_detail_cnt + 2
               LET g_wc2 = g_wc2, " OR (rtcc001 = '", g_rtcc_d[l_ac].rtcc001, "' "
                                  ," AND rtcc002 = '1' )"
                 LET g_wc2 = g_wc2, " OR (rtcc001 = '", g_rtcc_d[l_ac].rtcc001, "' "
                                  ," AND rtcc002 = '2' )"
               #後續修改注意,此段為新增程序都完成後 才可以執行 --- E
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (rtcc001 = '", g_rtcc_d[l_ac].rtcc001, "' "
                                  ," AND rtcc002 = '", g_rtcc_d[l_ac].rtcc002, "' "
 
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
               DELETE FROM rtcc_t
                WHERE rtccent = g_enterprise AND rtcc001 = g_rtcc_d_t.rtcc001                        
#               #end add-point   
#               
#               DELETE FROM rtcc_t
#                WHERE rtccent = g_enterprise AND 
#                      rtcc001 = g_rtcc_d_t.rtcc001
#                      AND rtcc002 = g_rtcc_d_t.rtcc002
# 
#                      
#               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtcc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  LET g_detail_cnt = g_detail_cnt-2
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL artm901_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_rtcc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE artm901_bcl
               #add-point:單身關閉bcl name="input.body.close"
 
               #end add-point
               LET l_count = g_rtcc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcc_d_t.rtcc001
               LET gs_keys[2] = g_rtcc_d_t.rtcc002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artm901_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
 
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
 
               #end add-point
                              CALL artm901_delete_b('rtcc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtcc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            CALL artm901_b_fill(g_wc2)
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc001
            #add-point:BEFORE FIELD rtcc001 name="input.b.page1.rtcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc001
            
            #add-point:AFTER FIELD rtcc001 name="input.a.page1.rtcc001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtcc_d[l_ac].rtcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcc_d[l_ac].rtcc001 != g_rtcc_d_t.rtcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcc_t WHERE "||"rtccent = '" ||g_enterprise|| "' AND "||"rtcc001 = '"||g_rtcc_d[l_ac].rtcc001 ||"'",'std-00004',0) THEN 
                     LET g_rtcc_d[l_ac].rtcc001 = g_rtcc_d_t.rtcc001
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF NOT artm901_def_rowtype() THEN
                  LET g_rtcc_d[l_ac].rtcc001 = g_rtcc_d_t.rtcc001
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc001
            #add-point:ON CHANGE rtcc001 name="input.g.page1.rtcc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc002
            #add-point:BEFORE FIELD rtcc002 name="input.b.page1.rtcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc002
            
            #add-point:AFTER FIELD rtcc002 name="input.a.page1.rtcc002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtcc_d[g_detail_idx].rtcc001 IS NOT NULL AND g_rtcc_d[g_detail_idx].rtcc002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcc_d[g_detail_idx].rtcc001 != g_rtcc_d_t.rtcc001 OR g_rtcc_d[g_detail_idx].rtcc002 != g_rtcc_d_t.rtcc002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcc_t WHERE "||"rtccent = '" ||g_enterprise|| "' AND "||"rtcc001 = '"||g_rtcc_d[g_detail_idx].rtcc001 ||"' AND "|| "rtcc002 = '"||g_rtcc_d[g_detail_idx].rtcc002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc002
            #add-point:ON CHANGE rtcc002 name="input.g.page1.rtcc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc003
            #add-point:BEFORE FIELD rtcc003 name="input.b.page1.rtcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc003
            
            #add-point:AFTER FIELD rtcc003 name="input.a.page1.rtcc003"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc003) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc003
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc003 = g_rtcc_d_o.rtcc003
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc003 = g_rtcc_d[l_ac].rtcc003
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc003
            #add-point:ON CHANGE rtcc003 name="input.g.page1.rtcc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc004
            #add-point:BEFORE FIELD rtcc004 name="input.b.page1.rtcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc004
            
            #add-point:AFTER FIELD rtcc004 name="input.a.page1.rtcc004"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc004) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc004
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc004 = g_rtcc_d_o.rtcc004
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc004 = g_rtcc_d[l_ac].rtcc004
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc004
            #add-point:ON CHANGE rtcc004 name="input.g.page1.rtcc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc005
            #add-point:BEFORE FIELD rtcc005 name="input.b.page1.rtcc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc005
            
            #add-point:AFTER FIELD rtcc005 name="input.a.page1.rtcc005"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc005) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc005
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc005 = g_rtcc_d_o.rtcc005
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc005 = g_rtcc_d[l_ac].rtcc005
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc005
            #add-point:ON CHANGE rtcc005 name="input.g.page1.rtcc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc006
            #add-point:BEFORE FIELD rtcc006 name="input.b.page1.rtcc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc006
            
            #add-point:AFTER FIELD rtcc006 name="input.a.page1.rtcc006"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc006) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc006
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc006 = g_rtcc_d_o.rtcc006
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc006 = g_rtcc_d[l_ac].rtcc006
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc006
            #add-point:ON CHANGE rtcc006 name="input.g.page1.rtcc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc007
            #add-point:BEFORE FIELD rtcc007 name="input.b.page1.rtcc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc007
            
            #add-point:AFTER FIELD rtcc007 name="input.a.page1.rtcc007"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc007) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc007
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc007 = g_rtcc_d_o.rtcc007
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc007 = g_rtcc_d[l_ac].rtcc007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc007
            #add-point:ON CHANGE rtcc007 name="input.g.page1.rtcc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc008
            #add-point:BEFORE FIELD rtcc008 name="input.b.page1.rtcc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc008
            
            #add-point:AFTER FIELD rtcc008 name="input.a.page1.rtcc008"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc008) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc008
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc008 = g_rtcc_d_o.rtcc008
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc008 = g_rtcc_d[l_ac].rtcc008
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc008
            #add-point:ON CHANGE rtcc008 name="input.g.page1.rtcc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc009
            #add-point:BEFORE FIELD rtcc009 name="input.b.page1.rtcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc009
            
            #add-point:AFTER FIELD rtcc009 name="input.a.page1.rtcc009"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc009) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc009
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc009 = g_rtcc_d_o.rtcc009
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc009 = g_rtcc_d[l_ac].rtcc009
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc009
            #add-point:ON CHANGE rtcc009 name="input.g.page1.rtcc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc010
            #add-point:BEFORE FIELD rtcc010 name="input.b.page1.rtcc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc010
            
            #add-point:AFTER FIELD rtcc010 name="input.a.page1.rtcc010"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc010) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc010
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc010 = g_rtcc_d_o.rtcc010
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc010 = g_rtcc_d[l_ac].rtcc010
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc010
            #add-point:ON CHANGE rtcc010 name="input.g.page1.rtcc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc011
            #add-point:BEFORE FIELD rtcc011 name="input.b.page1.rtcc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc011
            
            #add-point:AFTER FIELD rtcc011 name="input.a.page1.rtcc011"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc011) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc011
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc011 = g_rtcc_d_o.rtcc011
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc011 = g_rtcc_d[l_ac].rtcc011
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc011
            #add-point:ON CHANGE rtcc011 name="input.g.page1.rtcc011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc012
            #add-point:BEFORE FIELD rtcc012 name="input.b.page1.rtcc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc012
            
            #add-point:AFTER FIELD rtcc012 name="input.a.page1.rtcc012"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc012) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc012
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc012 = g_rtcc_d_o.rtcc012
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_rtcc_d_o.rtcc012 = g_rtcc_d[l_ac].rtcc012           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc012
            #add-point:ON CHANGE rtcc012 name="input.g.page1.rtcc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc013
            #add-point:BEFORE FIELD rtcc013 name="input.b.page1.rtcc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc013
            
            #add-point:AFTER FIELD rtcc013 name="input.a.page1.rtcc013"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc013) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc013
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc013
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc013 = g_rtcc_d_o.rtcc013
                  NEXT FIELD CURRENT
               END IF
            END IF  
            LET g_rtcc_d_o.rtcc013 = g_rtcc_d[l_ac].rtcc013
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc013
            #add-point:ON CHANGE rtcc013 name="input.g.page1.rtcc013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc014
            #add-point:BEFORE FIELD rtcc014 name="input.b.page1.rtcc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc014
            
            #add-point:AFTER FIELD rtcc014 name="input.a.page1.rtcc014"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc014) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc014
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc014
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc014 = g_rtcc_d_o.rtcc014
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc014 = g_rtcc_d[l_ac].rtcc014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc014
            #add-point:ON CHANGE rtcc014 name="input.g.page1.rtcc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc015
            #add-point:BEFORE FIELD rtcc015 name="input.b.page1.rtcc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc015
            
            #add-point:AFTER FIELD rtcc015 name="input.a.page1.rtcc015"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc015) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc015
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc015 = g_rtcc_d_o.rtcc015
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc015 = g_rtcc_d[l_ac].rtcc015
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc015
            #add-point:ON CHANGE rtcc015 name="input.g.page1.rtcc015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc016
            #add-point:BEFORE FIELD rtcc016 name="input.b.page1.rtcc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc016
            
            #add-point:AFTER FIELD rtcc016 name="input.a.page1.rtcc016"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc016) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc016
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc016
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc016 = g_rtcc_d_o.rtcc016
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc016 = g_rtcc_d[l_ac].rtcc016
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc016
            #add-point:ON CHANGE rtcc016 name="input.g.page1.rtcc016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc017
            #add-point:BEFORE FIELD rtcc017 name="input.b.page1.rtcc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc017
            
            #add-point:AFTER FIELD rtcc017 name="input.a.page1.rtcc017"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc017) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc017
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc017
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc017 = g_rtcc_d_o.rtcc017
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc017 = g_rtcc_d[l_ac].rtcc017
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc017
            #add-point:ON CHANGE rtcc017 name="input.g.page1.rtcc017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc018
            #add-point:BEFORE FIELD rtcc018 name="input.b.page1.rtcc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc018
            
            #add-point:AFTER FIELD rtcc018 name="input.a.page1.rtcc018"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc018) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc018
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc018 = g_rtcc_d_o.rtcc018
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc018 = g_rtcc_d[l_ac].rtcc018
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc018
            #add-point:ON CHANGE rtcc018 name="input.g.page1.rtcc018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc019
            #add-point:BEFORE FIELD rtcc019 name="input.b.page1.rtcc019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc019
            
            #add-point:AFTER FIELD rtcc019 name="input.a.page1.rtcc019"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc019) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc019
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc019
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc019 = g_rtcc_d_o.rtcc019
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc019 = g_rtcc_d[l_ac].rtcc019
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc019
            #add-point:ON CHANGE rtcc019 name="input.g.page1.rtcc019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc020
            #add-point:BEFORE FIELD rtcc020 name="input.b.page1.rtcc020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc020
            
            #add-point:AFTER FIELD rtcc020 name="input.a.page1.rtcc020"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc020) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc020
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc020
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc020 = g_rtcc_d_o.rtcc020
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc020 = g_rtcc_d[l_ac].rtcc020
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc020
            #add-point:ON CHANGE rtcc020 name="input.g.page1.rtcc020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc021
            #add-point:BEFORE FIELD rtcc021 name="input.b.page1.rtcc021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc021
            
            #add-point:AFTER FIELD rtcc021 name="input.a.page1.rtcc021"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc021) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc021
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc021
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc021 = g_rtcc_d_o.rtcc021
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc021 = g_rtcc_d[l_ac].rtcc021
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc021
            #add-point:ON CHANGE rtcc021 name="input.g.page1.rtcc021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc022
            #add-point:BEFORE FIELD rtcc022 name="input.b.page1.rtcc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc022
            
            #add-point:AFTER FIELD rtcc022 name="input.a.page1.rtcc022"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc022) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc022
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc022 = g_rtcc_d_o.rtcc022
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc022 = g_rtcc_d[l_ac].rtcc022
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc022
            #add-point:ON CHANGE rtcc022 name="input.g.page1.rtcc022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc023
            #add-point:BEFORE FIELD rtcc023 name="input.b.page1.rtcc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc023
            
            #add-point:AFTER FIELD rtcc023 name="input.a.page1.rtcc023"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc023) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc023
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc023
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc023 = g_rtcc_d_o.rtcc023
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc023 = g_rtcc_d[l_ac].rtcc023
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc023
            #add-point:ON CHANGE rtcc023 name="input.g.page1.rtcc023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc024
            #add-point:BEFORE FIELD rtcc024 name="input.b.page1.rtcc024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc024
            
            #add-point:AFTER FIELD rtcc024 name="input.a.page1.rtcc024"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc024) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc024
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc024
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc024 = g_rtcc_d_o.rtcc024
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc024 = g_rtcc_d[l_ac].rtcc024
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc024
            #add-point:ON CHANGE rtcc024 name="input.g.page1.rtcc024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc025
            #add-point:BEFORE FIELD rtcc025 name="input.b.page1.rtcc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc025
            
            #add-point:AFTER FIELD rtcc025 name="input.a.page1.rtcc025"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc025) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc025
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc025
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc025 = g_rtcc_d_o.rtcc025
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc025 = g_rtcc_d[l_ac].rtcc025
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc025
            #add-point:ON CHANGE rtcc025 name="input.g.page1.rtcc025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc026
            #add-point:BEFORE FIELD rtcc026 name="input.b.page1.rtcc026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc026
            
            #add-point:AFTER FIELD rtcc026 name="input.a.page1.rtcc026"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc026) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc026
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc026
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc026 = g_rtcc_d_o.rtcc026
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc026 = g_rtcc_d[l_ac].rtcc026
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc026
            #add-point:ON CHANGE rtcc026 name="input.g.page1.rtcc026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc027
            #add-point:BEFORE FIELD rtcc027 name="input.b.page1.rtcc027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc027
            
            #add-point:AFTER FIELD rtcc027 name="input.a.page1.rtcc027"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc027) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc027
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc027
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc027 = g_rtcc_d_o.rtcc027
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc027 = g_rtcc_d[l_ac].rtcc027
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc027
            #add-point:ON CHANGE rtcc027 name="input.g.page1.rtcc027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc028
            #add-point:BEFORE FIELD rtcc028 name="input.b.page1.rtcc028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc028
            
            #add-point:AFTER FIELD rtcc028 name="input.a.page1.rtcc028"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc028) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc028
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc028
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc028 = g_rtcc_d_o.rtcc028
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc028 = g_rtcc_d[l_ac].rtcc028
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc028
            #add-point:ON CHANGE rtcc028 name="input.g.page1.rtcc028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc029
            #add-point:BEFORE FIELD rtcc029 name="input.b.page1.rtcc029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc029
            
            #add-point:AFTER FIELD rtcc029 name="input.a.page1.rtcc029"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc029) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc029
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc029
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc029 = g_rtcc_d_o.rtcc029
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc029 = g_rtcc_d[l_ac].rtcc029
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc029
            #add-point:ON CHANGE rtcc029 name="input.g.page1.rtcc029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc030
            #add-point:BEFORE FIELD rtcc030 name="input.b.page1.rtcc030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc030
            
            #add-point:AFTER FIELD rtcc030 name="input.a.page1.rtcc030"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc030) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc030
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc030
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc030 = g_rtcc_d_o.rtcc030
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc030 = g_rtcc_d[l_ac].rtcc030
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc030
            #add-point:ON CHANGE rtcc030 name="input.g.page1.rtcc030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc031
            #add-point:BEFORE FIELD rtcc031 name="input.b.page1.rtcc031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc031
            
            #add-point:AFTER FIELD rtcc031 name="input.a.page1.rtcc031"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc031) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc031
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc031
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc031 = g_rtcc_d_o.rtcc031
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc031 = g_rtcc_d[l_ac].rtcc031
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc031
            #add-point:ON CHANGE rtcc031 name="input.g.page1.rtcc031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc032
            #add-point:BEFORE FIELD rtcc032 name="input.b.page1.rtcc032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc032
            
            #add-point:AFTER FIELD rtcc032 name="input.a.page1.rtcc032"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc032) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc032
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc032
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc032 = g_rtcc_d_o.rtcc032
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc032 = g_rtcc_d[l_ac].rtcc032
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc032
            #add-point:ON CHANGE rtcc032 name="input.g.page1.rtcc032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcc033
            #add-point:BEFORE FIELD rtcc033 name="input.b.page1.rtcc033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcc033
            
            #add-point:AFTER FIELD rtcc033 name="input.a.page1.rtcc033"
            IF NOT cl_null(g_rtcc_d[l_ac].rtcc033) THEN            
               LET l_num = g_rtcc_d[l_ac].rtcc033
               IF cl_null(l_num) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = g_rtcc_d[l_ac].rtcc033
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_rtcc_d[l_ac].rtcc033 = g_rtcc_d_o.rtcc033
                  NEXT FIELD CURRENT
               END IF
            END IF    
            LET g_rtcc_d_o.rtcc033 = g_rtcc_d[l_ac].rtcc033
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcc033
            #add-point:ON CHANGE rtcc033 name="input.g.page1.rtcc033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccunit
            #add-point:BEFORE FIELD rtccunit name="input.b.page1.rtccunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccunit
            
            #add-point:AFTER FIELD rtccunit name="input.a.page1.rtccunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtccunit
            #add-point:ON CHANGE rtccunit name="input.g.page1.rtccunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtccstus
            #add-point:BEFORE FIELD rtccstus name="input.b.page1.rtccstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtccstus
            
            #add-point:AFTER FIELD rtccstus name="input.a.page1.rtccstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtccstus
            #add-point:ON CHANGE rtccstus name="input.g.page1.rtccstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc001
            #add-point:ON ACTION controlp INFIELD rtcc001 name="input.c.page1.rtcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc002
            #add-point:ON ACTION controlp INFIELD rtcc002 name="input.c.page1.rtcc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc003
            #add-point:ON ACTION controlp INFIELD rtcc003 name="input.c.page1.rtcc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc004
            #add-point:ON ACTION controlp INFIELD rtcc004 name="input.c.page1.rtcc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc005
            #add-point:ON ACTION controlp INFIELD rtcc005 name="input.c.page1.rtcc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc006
            #add-point:ON ACTION controlp INFIELD rtcc006 name="input.c.page1.rtcc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc007
            #add-point:ON ACTION controlp INFIELD rtcc007 name="input.c.page1.rtcc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc008
            #add-point:ON ACTION controlp INFIELD rtcc008 name="input.c.page1.rtcc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc009
            #add-point:ON ACTION controlp INFIELD rtcc009 name="input.c.page1.rtcc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc010
            #add-point:ON ACTION controlp INFIELD rtcc010 name="input.c.page1.rtcc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc011
            #add-point:ON ACTION controlp INFIELD rtcc011 name="input.c.page1.rtcc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc012
            #add-point:ON ACTION controlp INFIELD rtcc012 name="input.c.page1.rtcc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc013
            #add-point:ON ACTION controlp INFIELD rtcc013 name="input.c.page1.rtcc013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc014
            #add-point:ON ACTION controlp INFIELD rtcc014 name="input.c.page1.rtcc014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc015
            #add-point:ON ACTION controlp INFIELD rtcc015 name="input.c.page1.rtcc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc016
            #add-point:ON ACTION controlp INFIELD rtcc016 name="input.c.page1.rtcc016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc017
            #add-point:ON ACTION controlp INFIELD rtcc017 name="input.c.page1.rtcc017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc018
            #add-point:ON ACTION controlp INFIELD rtcc018 name="input.c.page1.rtcc018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc019
            #add-point:ON ACTION controlp INFIELD rtcc019 name="input.c.page1.rtcc019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc020
            #add-point:ON ACTION controlp INFIELD rtcc020 name="input.c.page1.rtcc020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc021
            #add-point:ON ACTION controlp INFIELD rtcc021 name="input.c.page1.rtcc021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc022
            #add-point:ON ACTION controlp INFIELD rtcc022 name="input.c.page1.rtcc022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc023
            #add-point:ON ACTION controlp INFIELD rtcc023 name="input.c.page1.rtcc023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc024
            #add-point:ON ACTION controlp INFIELD rtcc024 name="input.c.page1.rtcc024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc025
            #add-point:ON ACTION controlp INFIELD rtcc025 name="input.c.page1.rtcc025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc026
            #add-point:ON ACTION controlp INFIELD rtcc026 name="input.c.page1.rtcc026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc027
            #add-point:ON ACTION controlp INFIELD rtcc027 name="input.c.page1.rtcc027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc028
            #add-point:ON ACTION controlp INFIELD rtcc028 name="input.c.page1.rtcc028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc029
            #add-point:ON ACTION controlp INFIELD rtcc029 name="input.c.page1.rtcc029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc030
            #add-point:ON ACTION controlp INFIELD rtcc030 name="input.c.page1.rtcc030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc031
            #add-point:ON ACTION controlp INFIELD rtcc031 name="input.c.page1.rtcc031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc032
            #add-point:ON ACTION controlp INFIELD rtcc032 name="input.c.page1.rtcc032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcc033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcc033
            #add-point:ON ACTION controlp INFIELD rtcc033 name="input.c.page1.rtcc033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtccunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccunit
            #add-point:ON ACTION controlp INFIELD rtccunit name="input.c.page1.rtccunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtccstus
            #add-point:ON ACTION controlp INFIELD rtccstus name="input.c.page1.rtccstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE artm901_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_rtcc_d[l_ac].* = g_rtcc_d_t.*
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
               LET g_errparam.extend = g_rtcc_d[l_ac].rtcc001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtcc_d[l_ac].* = g_rtcc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtcc2_d[l_ac].rtccmodid = g_user 
LET g_rtcc2_d[l_ac].rtccmoddt = cl_get_current()
LET g_rtcc2_d[l_ac].rtccmodid_desc = cl_get_username(g_rtcc2_d[l_ac].rtccmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL artm901_rtcc_t_mask_restore('restore_mask_o')
 
               UPDATE rtcc_t SET (rtcc001,rtcc002,rtcc003,rtcc004,rtcc005,rtcc006,rtcc007,rtcc008,rtcc009, 
                   rtcc010,rtcc011,rtcc012,rtcc013,rtcc014,rtcc015,rtcc016,rtcc017,rtcc018,rtcc019,rtcc020, 
                   rtcc021,rtcc022,rtcc023,rtcc024,rtcc025,rtcc026,rtcc027,rtcc028,rtcc029,rtcc030,rtcc031, 
                   rtcc032,rtcc033,rtccunit,rtccstus,rtccownid,rtccowndp,rtcccrtid,rtcccrtdp,rtcccrtdt, 
                   rtccmodid,rtccmoddt) = (g_rtcc_d[l_ac].rtcc001,g_rtcc_d[l_ac].rtcc002,g_rtcc_d[l_ac].rtcc003, 
                   g_rtcc_d[l_ac].rtcc004,g_rtcc_d[l_ac].rtcc005,g_rtcc_d[l_ac].rtcc006,g_rtcc_d[l_ac].rtcc007, 
                   g_rtcc_d[l_ac].rtcc008,g_rtcc_d[l_ac].rtcc009,g_rtcc_d[l_ac].rtcc010,g_rtcc_d[l_ac].rtcc011, 
                   g_rtcc_d[l_ac].rtcc012,g_rtcc_d[l_ac].rtcc013,g_rtcc_d[l_ac].rtcc014,g_rtcc_d[l_ac].rtcc015, 
                   g_rtcc_d[l_ac].rtcc016,g_rtcc_d[l_ac].rtcc017,g_rtcc_d[l_ac].rtcc018,g_rtcc_d[l_ac].rtcc019, 
                   g_rtcc_d[l_ac].rtcc020,g_rtcc_d[l_ac].rtcc021,g_rtcc_d[l_ac].rtcc022,g_rtcc_d[l_ac].rtcc023, 
                   g_rtcc_d[l_ac].rtcc024,g_rtcc_d[l_ac].rtcc025,g_rtcc_d[l_ac].rtcc026,g_rtcc_d[l_ac].rtcc027, 
                   g_rtcc_d[l_ac].rtcc028,g_rtcc_d[l_ac].rtcc029,g_rtcc_d[l_ac].rtcc030,g_rtcc_d[l_ac].rtcc031, 
                   g_rtcc_d[l_ac].rtcc032,g_rtcc_d[l_ac].rtcc033,g_rtcc_d[l_ac].rtccunit,g_rtcc_d[l_ac].rtccstus, 
                   g_rtcc2_d[l_ac].rtccownid,g_rtcc2_d[l_ac].rtccowndp,g_rtcc2_d[l_ac].rtcccrtid,g_rtcc2_d[l_ac].rtcccrtdp, 
                   g_rtcc2_d[l_ac].rtcccrtdt,g_rtcc2_d[l_ac].rtccmodid,g_rtcc2_d[l_ac].rtccmoddt)
                WHERE rtccent = g_enterprise AND
                  rtcc001 = g_rtcc_d_t.rtcc001 #項次   
                  AND rtcc002 = g_rtcc_d_t.rtcc002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcc_d[g_detail_idx].rtcc001
               LET gs_keys_bak[1] = g_rtcc_d_t.rtcc001
               LET gs_keys[2] = g_rtcc_d[g_detail_idx].rtcc002
               LET gs_keys_bak[2] = g_rtcc_d_t.rtcc002
               CALL artm901_update_b('rtcc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtcc_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtcc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL artm901_rtcc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL artm901_unlock_b("rtcc_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtcc_d[l_ac].* = g_rtcc_d_t.*
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
               LET g_rtcc_d[li_reproduce_target].* = g_rtcc_d[li_reproduce].*
               LET g_rtcc2_d[li_reproduce_target].* = g_rtcc2_d[li_reproduce].*
 
               LET g_rtcc_d[li_reproduce_target].rtcc001 = NULL
               LET g_rtcc_d[li_reproduce_target].rtcc002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtcc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtcc_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_rtcc2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL artm901_b_fill(g_wc2)
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
               NEXT FIELD rtcc001
            WHEN "s_detail2"
               NEXT FIELD rtcc001_2
 
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
      IF INT_FLAG OR cl_null(g_rtcc_d[g_detail_idx].rtcc001) THEN
         CALL g_rtcc_d.deleteElement(g_detail_idx)
         CALL g_rtcc2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_rtcc_d[g_detail_idx].* = g_rtcc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE artm901_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="artm901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artm901_delete()
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
   FOR li_idx = 1 TO g_rtcc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT artm901_lock_b("rtcc_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("rtcc_t","rtccownid") THEN
            LET g_data_owner = g_rtcc2_d[g_detail_idx].rtccownid
            LET g_data_dept = g_rtcc2_d[g_detail_idx].rtccowndp
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
   
   FOR li_idx = 1 TO g_rtcc_d.getLength()
      IF g_rtcc_d[li_idx].rtcc001 IS NOT NULL
         AND g_rtcc_d[li_idx].rtcc002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         DELETE FROM rtcc_t
          WHERE rtccent = g_enterprise AND 
                rtcc001 = g_rtcc_d[li_idx].rtcc001
#         #end add-point   
#         
#         DELETE FROM rtcc_t
#          WHERE rtccent = g_enterprise AND 
#                rtcc001 = g_rtcc_d[li_idx].rtcc001
#                AND rtcc002 = g_rtcc_d[li_idx].rtcc002
# 
#         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
 
            
 
 
            
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            LET g_detail_cnt = g_detail_cnt-2
            LET l_ac = li_idx
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcc_d_t.rtcc001
               LET gs_keys[2] = g_rtcc_d_t.rtcc002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL artm901_delete_b('rtcc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artm901_set_pk_array()
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
   CALL artm901_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="artm901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artm901_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.rtcc001,t0.rtcc002,t0.rtcc003,t0.rtcc004,t0.rtcc005,t0.rtcc006,t0.rtcc007, 
       t0.rtcc008,t0.rtcc009,t0.rtcc010,t0.rtcc011,t0.rtcc012,t0.rtcc013,t0.rtcc014,t0.rtcc015,t0.rtcc016, 
       t0.rtcc017,t0.rtcc018,t0.rtcc019,t0.rtcc020,t0.rtcc021,t0.rtcc022,t0.rtcc023,t0.rtcc024,t0.rtcc025, 
       t0.rtcc026,t0.rtcc027,t0.rtcc028,t0.rtcc029,t0.rtcc030,t0.rtcc031,t0.rtcc032,t0.rtcc033,t0.rtccunit, 
       t0.rtccstus,t0.rtcc001,t0.rtcc002,t0.rtccownid,t0.rtccowndp,t0.rtcccrtid,t0.rtcccrtdp,t0.rtcccrtdt, 
       t0.rtccmodid,t0.rtccmoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM rtcc_t t0", 
 
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rtccownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rtccowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.rtcccrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtcccrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtccmodid  ",
 
               " WHERE t0.rtccent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("rtcc_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND rtccowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("rtcc_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND rtccownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtcc_t"),
                      " ORDER BY t0.rtcc001,t0.rtcc002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtcc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artm901_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artm901_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtcc_d.clear()
   CALL g_rtcc2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtcc_d[l_ac].rtcc001,g_rtcc_d[l_ac].rtcc002,g_rtcc_d[l_ac].rtcc003,g_rtcc_d[l_ac].rtcc004, 
       g_rtcc_d[l_ac].rtcc005,g_rtcc_d[l_ac].rtcc006,g_rtcc_d[l_ac].rtcc007,g_rtcc_d[l_ac].rtcc008,g_rtcc_d[l_ac].rtcc009, 
       g_rtcc_d[l_ac].rtcc010,g_rtcc_d[l_ac].rtcc011,g_rtcc_d[l_ac].rtcc012,g_rtcc_d[l_ac].rtcc013,g_rtcc_d[l_ac].rtcc014, 
       g_rtcc_d[l_ac].rtcc015,g_rtcc_d[l_ac].rtcc016,g_rtcc_d[l_ac].rtcc017,g_rtcc_d[l_ac].rtcc018,g_rtcc_d[l_ac].rtcc019, 
       g_rtcc_d[l_ac].rtcc020,g_rtcc_d[l_ac].rtcc021,g_rtcc_d[l_ac].rtcc022,g_rtcc_d[l_ac].rtcc023,g_rtcc_d[l_ac].rtcc024, 
       g_rtcc_d[l_ac].rtcc025,g_rtcc_d[l_ac].rtcc026,g_rtcc_d[l_ac].rtcc027,g_rtcc_d[l_ac].rtcc028,g_rtcc_d[l_ac].rtcc029, 
       g_rtcc_d[l_ac].rtcc030,g_rtcc_d[l_ac].rtcc031,g_rtcc_d[l_ac].rtcc032,g_rtcc_d[l_ac].rtcc033,g_rtcc_d[l_ac].rtccunit, 
       g_rtcc_d[l_ac].rtccstus,g_rtcc2_d[l_ac].rtcc001,g_rtcc2_d[l_ac].rtcc002,g_rtcc2_d[l_ac].rtccownid, 
       g_rtcc2_d[l_ac].rtccowndp,g_rtcc2_d[l_ac].rtcccrtid,g_rtcc2_d[l_ac].rtcccrtdp,g_rtcc2_d[l_ac].rtcccrtdt, 
       g_rtcc2_d[l_ac].rtccmodid,g_rtcc2_d[l_ac].rtccmoddt,g_rtcc2_d[l_ac].rtccownid_desc,g_rtcc2_d[l_ac].rtccowndp_desc, 
       g_rtcc2_d[l_ac].rtcccrtid_desc,g_rtcc2_d[l_ac].rtcccrtdp_desc,g_rtcc2_d[l_ac].rtccmodid_desc
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
      
      CALL artm901_detail_show()      
 
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
   
 
   
   CALL g_rtcc_d.deleteElement(g_rtcc_d.getLength())   
   CALL g_rtcc2_d.deleteElement(g_rtcc2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtcc_d.getLength()
      LET g_rtcc2_d[l_ac].rtcc001 = g_rtcc_d[l_ac].rtcc001 
      LET g_rtcc2_d[l_ac].rtcc002 = g_rtcc_d[l_ac].rtcc002 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_rtcc_d.getLength() THEN
      LET l_ac = g_rtcc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtcc_d.getLength()
      LET g_rtcc_d_mask_o[l_ac].* =  g_rtcc_d[l_ac].*
      CALL artm901_rtcc_t_mask()
      LET g_rtcc_d_mask_n[l_ac].* =  g_rtcc_d[l_ac].*
   END FOR
   
   LET g_rtcc2_d_mask_o.* =  g_rtcc2_d.*
   FOR l_ac = 1 TO g_rtcc2_d.getLength()
      LET g_rtcc2_d_mask_o[l_ac].* =  g_rtcc2_d[l_ac].*
      CALL artm901_rtcc_t_mask()
      LET g_rtcc2_d_mask_n[l_ac].* =  g_rtcc2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_rtcc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE artm901_pb
   
END FUNCTION
 
{</section>}
 
{<section id="artm901.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artm901_detail_show()
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
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artm901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artm901_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("rtcc001,rtcc003,rtcc004,rtcc005,rtcc006",TRUE)
   CALL cl_set_comp_entry("rtcc007,rtcc008,rtcc009,rtcc010,rtcc011",TRUE)
   CALL cl_set_comp_entry("rtcc012,rtcc013,rtcc014,rtcc015,rtcc016",TRUE)
   CALL cl_set_comp_entry("rtcc017,rtcc018,rtcc019,rtcc020,rtcc021",TRUE)
   CALL cl_set_comp_entry("rtcc022,rtcc023,rtcc024,rtcc025,rtcc026",TRUE)
   CALL cl_set_comp_entry("rtcc027,rtcc028,rtcc029,rtcc030,rtcc031",TRUE)
   CALL cl_set_comp_entry("rtcc032,rtcc033",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="artm901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artm901_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_year           LIKE type_t.num5
   DEFINE l_month          LIKE type_t.num5
   DEFINE l_day            LIKE type_t.num5
   DEFINE l_length         LIKE type_t.num5
   DEFINE l_rtcc001        STRING
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
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtcc003,rtcc004,rtcc005,rtcc006",FALSE)
      CALL cl_set_comp_entry("rtcc007,rtcc008,rtcc009,rtcc010,rtcc011",FALSE)
      CALL cl_set_comp_entry("rtcc012,rtcc013,rtcc014,rtcc015,rtcc016",FALSE)
      CALL cl_set_comp_entry("rtcc017,rtcc018,rtcc019,rtcc020,rtcc021",FALSE)
      CALL cl_set_comp_entry("rtcc022,rtcc023,rtcc024,rtcc025,rtcc026",FALSE)
      CALL cl_set_comp_entry("rtcc027,rtcc028,rtcc029,rtcc030,rtcc031",FALSE)
      CALL cl_set_comp_entry("rtcc032,rtcc033",FALSE)
   ELSE
      CALL cl_set_comp_entry("rtcc001",FALSE)
   END IF
   
   #160406-00005#1 Add By Ken 160411(S)
   IF NOT cl_null(g_rtcc_d[l_ac].rtcc001) THEN
      LET l_rtcc001 = g_rtcc_d[l_ac].rtcc001
      LET l_length = l_rtcc001.getLength()
      LET l_year  = l_rtcc001.substring(1,4)
      LET l_month = l_rtcc001.substring(5,6)
      
      CALL s_date_get_max_day(l_year,l_month) RETURNING l_day
      IF g_rtcc_d[l_ac].rtcc002 = 3 THEN
         CASE 
           WHEN l_day = 28
              CALL cl_set_comp_entry("rtcc031,rtcc032,rtcc033",FALSE)
           WHEN l_day = 29
              CALL cl_set_comp_entry("rtcc032,rtcc033",FALSE)      
           WHEN l_day = 30
              CALL cl_set_comp_entry("rtcc033",FALSE)
         END CASE           
      END IF
   END IF   
   #160406-00005#1 Add By Ken 160411(S)
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="artm901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artm901_default_search()
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
      LET ls_wc = ls_wc, " rtcc001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtcc002 = '", g_argv[02], "' AND "
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
 
{<section id="artm901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artm901_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "rtcc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtcc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
 
         #end add-point     
         
         DELETE FROM rtcc_t
          WHERE rtccent = g_enterprise AND
            rtcc001 = ps_keys_bak[1] AND rtcc002 = ps_keys_bak[2]
         
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
         CALL g_rtcc_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_rtcc2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="artm901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artm901_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "rtcc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO rtcc_t
                  (rtccent,
                   rtcc001,rtcc002
                   ,rtcc003,rtcc004,rtcc005,rtcc006,rtcc007,rtcc008,rtcc009,rtcc010,rtcc011,rtcc012,rtcc013,rtcc014,rtcc015,rtcc016,rtcc017,rtcc018,rtcc019,rtcc020,rtcc021,rtcc022,rtcc023,rtcc024,rtcc025,rtcc026,rtcc027,rtcc028,rtcc029,rtcc030,rtcc031,rtcc032,rtcc033,rtccunit,rtccstus,rtccownid,rtccowndp,rtcccrtid,rtcccrtdp,rtcccrtdt,rtccmodid,rtccmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtcc_d[l_ac].rtcc003,g_rtcc_d[l_ac].rtcc004,g_rtcc_d[l_ac].rtcc005,g_rtcc_d[l_ac].rtcc006, 
                       g_rtcc_d[l_ac].rtcc007,g_rtcc_d[l_ac].rtcc008,g_rtcc_d[l_ac].rtcc009,g_rtcc_d[l_ac].rtcc010, 
                       g_rtcc_d[l_ac].rtcc011,g_rtcc_d[l_ac].rtcc012,g_rtcc_d[l_ac].rtcc013,g_rtcc_d[l_ac].rtcc014, 
                       g_rtcc_d[l_ac].rtcc015,g_rtcc_d[l_ac].rtcc016,g_rtcc_d[l_ac].rtcc017,g_rtcc_d[l_ac].rtcc018, 
                       g_rtcc_d[l_ac].rtcc019,g_rtcc_d[l_ac].rtcc020,g_rtcc_d[l_ac].rtcc021,g_rtcc_d[l_ac].rtcc022, 
                       g_rtcc_d[l_ac].rtcc023,g_rtcc_d[l_ac].rtcc024,g_rtcc_d[l_ac].rtcc025,g_rtcc_d[l_ac].rtcc026, 
                       g_rtcc_d[l_ac].rtcc027,g_rtcc_d[l_ac].rtcc028,g_rtcc_d[l_ac].rtcc029,g_rtcc_d[l_ac].rtcc030, 
                       g_rtcc_d[l_ac].rtcc031,g_rtcc_d[l_ac].rtcc032,g_rtcc_d[l_ac].rtcc033,g_rtcc_d[l_ac].rtccunit, 
                       g_rtcc_d[l_ac].rtccstus,g_rtcc2_d[l_ac].rtccownid,g_rtcc2_d[l_ac].rtccowndp,g_rtcc2_d[l_ac].rtcccrtid, 
                       g_rtcc2_d[l_ac].rtcccrtdp,g_rtcc2_d[l_ac].rtcccrtdt,g_rtcc2_d[l_ac].rtccmodid, 
                       g_rtcc2_d[l_ac].rtccmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="artm901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artm901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "rtcc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtcc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE rtcc_t 
         SET (rtcc001,rtcc002
              ,rtcc003,rtcc004,rtcc005,rtcc006,rtcc007,rtcc008,rtcc009,rtcc010,rtcc011,rtcc012,rtcc013,rtcc014,rtcc015,rtcc016,rtcc017,rtcc018,rtcc019,rtcc020,rtcc021,rtcc022,rtcc023,rtcc024,rtcc025,rtcc026,rtcc027,rtcc028,rtcc029,rtcc030,rtcc031,rtcc032,rtcc033,rtccunit,rtccstus,rtccownid,rtccowndp,rtcccrtid,rtcccrtdp,rtcccrtdt,rtccmodid,rtccmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtcc_d[l_ac].rtcc003,g_rtcc_d[l_ac].rtcc004,g_rtcc_d[l_ac].rtcc005,g_rtcc_d[l_ac].rtcc006, 
                  g_rtcc_d[l_ac].rtcc007,g_rtcc_d[l_ac].rtcc008,g_rtcc_d[l_ac].rtcc009,g_rtcc_d[l_ac].rtcc010, 
                  g_rtcc_d[l_ac].rtcc011,g_rtcc_d[l_ac].rtcc012,g_rtcc_d[l_ac].rtcc013,g_rtcc_d[l_ac].rtcc014, 
                  g_rtcc_d[l_ac].rtcc015,g_rtcc_d[l_ac].rtcc016,g_rtcc_d[l_ac].rtcc017,g_rtcc_d[l_ac].rtcc018, 
                  g_rtcc_d[l_ac].rtcc019,g_rtcc_d[l_ac].rtcc020,g_rtcc_d[l_ac].rtcc021,g_rtcc_d[l_ac].rtcc022, 
                  g_rtcc_d[l_ac].rtcc023,g_rtcc_d[l_ac].rtcc024,g_rtcc_d[l_ac].rtcc025,g_rtcc_d[l_ac].rtcc026, 
                  g_rtcc_d[l_ac].rtcc027,g_rtcc_d[l_ac].rtcc028,g_rtcc_d[l_ac].rtcc029,g_rtcc_d[l_ac].rtcc030, 
                  g_rtcc_d[l_ac].rtcc031,g_rtcc_d[l_ac].rtcc032,g_rtcc_d[l_ac].rtcc033,g_rtcc_d[l_ac].rtccunit, 
                  g_rtcc_d[l_ac].rtccstus,g_rtcc2_d[l_ac].rtccownid,g_rtcc2_d[l_ac].rtccowndp,g_rtcc2_d[l_ac].rtcccrtid, 
                  g_rtcc2_d[l_ac].rtcccrtdp,g_rtcc2_d[l_ac].rtcccrtdt,g_rtcc2_d[l_ac].rtccmodid,g_rtcc2_d[l_ac].rtccmoddt)  
 
         WHERE rtccent = g_enterprise AND rtcc001 = ps_keys_bak[1] AND rtcc002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtcc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtcc_t:",SQLERRMESSAGE 
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
 
{<section id="artm901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artm901_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL artm901_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtcc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artm901_bcl USING g_enterprise,
                                       g_rtcc_d[g_detail_idx].rtcc001,g_rtcc_d[g_detail_idx].rtcc002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artm901_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artm901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artm901_unlock_b(ps_table)
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
      CLOSE artm901_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artm901.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION artm901_modify_detail_chk(ps_record)
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
         LET ls_return = "rtcc001"
      WHEN "s_detail2"
         LET ls_return = "rtcc001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="artm901.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION artm901_show_ownid_msg()
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
 
{<section id="artm901.mask_functions" >}
&include "erp/art/artm901_mask.4gl"
 
{</section>}
 
{<section id="artm901.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artm901_set_pk_array()
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
   LET g_pk_array[1].values = g_rtcc_d[l_ac].rtcc001
   LET g_pk_array[1].column = 'rtcc001'
   LET g_pk_array[2].values = g_rtcc_d[l_ac].rtcc002
   LET g_pk_array[2].column = 'rtcc002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artm901.state_change" >}
   
 
{</section>}
 
{<section id="artm901.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="artm901.other_function" readonly="Y" >}
#檢查輸入的預算期別資料是否正確
PRIVATE FUNCTION artm901_chk_rtcc001(p_unit,p_rtcc001)
   DEFINE p_unit            LIKE rtcc_t.rtccunit
   DEFINE p_rtcc001         LIKE type_t.chr20   
   DEFINE r_success         LIKE type_t.num5
   DEFINE r_year            LIKE type_t.num5
   DEFINE r_month           LIKE type_t.num5
   DEFINE r_ooef008         LIKE ooef_t.ooef008
   DEFINE r_ooef010         LIKE ooef_t.ooef010
   DEFINE l_rtcc001         STRING
   DEFINE l_length          LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_rtcc001 = p_rtcc001
   LET l_length = l_rtcc001.getLength()
   
   IF l_length - 2 <= 0 THEN
      #輸入的預算期別格式錯誤,輸入值應為'YYYYMM'
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = p_rtcc001 
      LET g_errparam.code   = 'art-00652'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success,r_year,r_month,r_ooef008,r_ooef010
   END IF
   
   LET r_year  = p_rtcc001[1,l_length-2]
   LET r_month = p_rtcc001[l_length-1,l_length]
      
   IF r_month > 12 OR r_month < 1 THEN
      #輸入的預算期別後兩碼(月份)的值 應介於1~12之間
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = p_rtcc001
      LET g_errparam.code   = 'art-00653'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_year,r_month,r_ooef008,r_ooef010
   END IF 
   
   LET r_ooef008 = ''
   LET r_ooef010 = ''
   SELECT ooef008,ooef010 INTO r_ooef008,r_ooef010
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_unit
   IF cl_null(r_ooef008) OR cl_null(r_ooef010) THEN
      #組識的"行事曆參照表號"和"辦公行事曆對應類別" 資料設定不完整
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = p_unit
      LET g_errparam.code   = 'art-00654'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_year,r_month,r_ooef008,r_ooef010
   END IF
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM oogc_t 
    WHERE oogcent = g_enterprise
      AND oogc001 = r_ooef008   AND oogc002 = r_ooef010
      AND oogc015 = r_year      AND oogc016 = r_month
   
   IF l_cnt = 0 THEN
      #組織編號:%1的 行事曆參照表:%2 辦公行事曆對應類別:%3 於行事曆維護作業(aooi420)中,尚未維護 年度:%4 月份:%5 的資料
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.replace[1] = p_unit
      LET g_errparam.replace[2] = r_ooef008
      LET g_errparam.replace[3] = r_ooef010
      LET g_errparam.replace[4] = r_year
      LET g_errparam.replace[5] = r_month
      LET g_errparam.code   = 'art-00655'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_year,r_month,r_ooef008,r_ooef010
   END IF
   
   RETURN r_success,r_year,r_month,r_ooef008,r_ooef010
   
END FUNCTION
#將rowtype 1.星期 2.節日類型 3.預算係數 的值 取出
PRIVATE FUNCTION artm901_def_rowtype()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_ooef008       LIKE ooef_t.ooef008
   DEFINE l_ooef010       LIKE ooef_t.ooef010
   DEFINE l_sql           STRING
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_oogc003       LIKE oogc_t.oogc003
   DEFINE l_ooga002       LIKE rtcc_t.rtcc003
   DEFINE l_feteday       LIKE oogc_t.oogc010
   DEFINE l_param         LIKE type_t.num5
   DEFINE l_feteday_desc  LIKE type_t.chr500
   
   LET r_success = TRUE
   
   CALL artm901_chk_rtcc001(g_rtcc_d[l_ac].rtccunit,g_rtcc_d[l_ac].rtcc001)
    RETURNING l_success,l_year,l_month,l_ooef008,l_ooef010
  
   LET l_param = cl_get_para(g_enterprise,g_site,'E-CIR-0046')
    
   CALL g_rtcc.clear() 
   IF l_success THEN
   
      LET l_sql = "SELECT oogc003,ooga002"
      CASE l_param
         WHEN 1 LET l_sql = l_sql CLIPPED,",oogc010"
         WHEN 2 LET l_sql = l_sql CLIPPED,",oogc011"
         WHEN 3 LET l_sql = l_sql CLIPPED,",oogc012"
         WHEN 4 LET l_sql = l_sql CLIPPED,",oogc013"
         WHEN 5 LET l_sql = l_sql CLIPPED,",oogc014"
      END CASE
      
      LET l_sql = l_sql CLIPPED,
                  "  FROM oogc_t,ooga_t",
                  " WHERE oogcent = ",g_enterprise,
                  "   AND oogcent = oogaent    AND oogc003 = ooga001 ",
                  "   AND oogc001 = '",l_ooef008,"' AND oogc002 = '",l_ooef010,"'",
                  "   AND oogc015 = ",l_year," AND oogc016 = ",l_month,
                  " ORDER BY oogc003"
      PREPARE artm901_oogc_prep1 FROM l_sql
      DECLARE artm901_oogc_cs1 CURSOR FOR artm901_oogc_prep1
      LET l_n = 1
      FOREACH artm901_oogc_cs1 INTO l_oogc003,l_ooga002,l_feteday
         CASE l_ooga002
            WHEN '1' LET l_ooga002 = cl_getmsg('art-00656',g_dlang)
            WHEN '2' LET l_ooga002 = cl_getmsg('art-00657',g_dlang)
            WHEN '3' LET l_ooga002 = cl_getmsg('art-00658',g_dlang)
            WHEN '4' LET l_ooga002 = cl_getmsg('art-00659',g_dlang)
            WHEN '5' LET l_ooga002 = cl_getmsg('art-00660',g_dlang)
            WHEN '6' LET l_ooga002 = cl_getmsg('art-00661',g_dlang)
            WHEN '0' LET l_ooga002 = cl_getmsg('art-00662',g_dlang)
         END CASE
         
         CASE l_param
            WHEN 1 LET l_feteday_desc = s_desc_get_acc_desc('7',l_feteday)
            WHEN 2 LET l_feteday_desc = s_desc_get_acc_desc('8',l_feteday)
            WHEN 3 LET l_feteday_desc = s_desc_get_acc_desc('9',l_feteday)
            WHEN 4 LET l_feteday_desc = s_desc_get_acc_desc('10',l_feteday)
            WHEN 5 LET l_feteday_desc = s_desc_get_acc_desc('11',l_feteday)
         END CASE
         
         CASE l_n 
            WHEN 1  #rtcc003
               LET g_rtcc[1].rtcc003 = l_ooga002
               LET g_rtcc[2].rtcc003 = l_feteday_desc
               LET g_rtcc[3].rtcc003 = 1
            WHEN 2  #rtcc004
               LET g_rtcc[1].rtcc004 = l_ooga002
               LET g_rtcc[2].rtcc004 = l_feteday_desc
               LET g_rtcc[3].rtcc004 = 1
            WHEN 3  #rtcc005
               LET g_rtcc[1].rtcc005 = l_ooga002
               LET g_rtcc[2].rtcc005 = l_feteday_desc
               LET g_rtcc[3].rtcc005 = 1
            WHEN 4  #rtcc006
               LET g_rtcc[1].rtcc006 = l_ooga002
               LET g_rtcc[2].rtcc006 = l_feteday_desc
               LET g_rtcc[3].rtcc006 = 1
            WHEN 5  #rtcc007
               LET g_rtcc[1].rtcc007 = l_ooga002
               LET g_rtcc[2].rtcc007 = l_feteday_desc
               LET g_rtcc[3].rtcc007 = 1
            WHEN 6  #rtcc008
               LET g_rtcc[1].rtcc008 = l_ooga002
               LET g_rtcc[2].rtcc008 = l_feteday_desc
               LET g_rtcc[3].rtcc008 = 1
            WHEN 7  #rtcc009
               LET g_rtcc[1].rtcc009 = l_ooga002
               LET g_rtcc[2].rtcc009 = l_feteday_desc
               LET g_rtcc[3].rtcc009 = 1
            WHEN 8  #rtcc010
               LET g_rtcc[1].rtcc010 = l_ooga002
               LET g_rtcc[2].rtcc010 = l_feteday_desc
               LET g_rtcc[3].rtcc010 = 1
            WHEN 9  #rtcc011
               LET g_rtcc[1].rtcc011 = l_ooga002
               LET g_rtcc[2].rtcc011 = l_feteday_desc
               LET g_rtcc[3].rtcc011 = 1
            WHEN 10  #rtcc012
               LET g_rtcc[1].rtcc012 = l_ooga002
               LET g_rtcc[2].rtcc012 = l_feteday_desc
               LET g_rtcc[3].rtcc012 = 1
            WHEN 11  #rtcc013
               LET g_rtcc[1].rtcc013 = l_ooga002
               LET g_rtcc[2].rtcc013 = l_feteday_desc
               LET g_rtcc[3].rtcc013 = 1
            WHEN 12  #rtcc014
               LET g_rtcc[1].rtcc014 = l_ooga002
               LET g_rtcc[2].rtcc014 = l_feteday_desc
               LET g_rtcc[3].rtcc014 = 1
            WHEN 13  #rtcc015
               LET g_rtcc[1].rtcc015 = l_ooga002
               LET g_rtcc[2].rtcc015 = l_feteday_desc
               LET g_rtcc[3].rtcc015 = 1
            WHEN 14  #rtcc016
               LET g_rtcc[1].rtcc016 = l_ooga002
               LET g_rtcc[2].rtcc016 = l_feteday_desc
               LET g_rtcc[3].rtcc016 = 1
            WHEN 15  #rtcc017
               LET g_rtcc[1].rtcc017 = l_ooga002
               LET g_rtcc[2].rtcc017 = l_feteday_desc
               LET g_rtcc[3].rtcc017 = 1
            WHEN 16  #rtcc018
               LET g_rtcc[1].rtcc018 = l_ooga002
               LET g_rtcc[2].rtcc018 = l_feteday_desc
               LET g_rtcc[3].rtcc018 = 1
            WHEN 17  #rtcc019
               LET g_rtcc[1].rtcc019 = l_ooga002
               LET g_rtcc[2].rtcc019 = l_feteday_desc
               LET g_rtcc[3].rtcc019 = 1
            WHEN 18  #rtcc020
               LET g_rtcc[1].rtcc020 = l_ooga002
               LET g_rtcc[2].rtcc020 = l_feteday_desc
               LET g_rtcc[3].rtcc020 = 1
            WHEN 19  #rtcc021
               LET g_rtcc[1].rtcc021 = l_ooga002
               LET g_rtcc[2].rtcc021 = l_feteday_desc
               LET g_rtcc[3].rtcc021 = 1
            WHEN 20  #rtcc022
               LET g_rtcc[1].rtcc022 = l_ooga002
               LET g_rtcc[2].rtcc022 = l_feteday_desc
               LET g_rtcc[3].rtcc022 = 1
            WHEN 21  #rtcc023
               LET g_rtcc[1].rtcc023 = l_ooga002
               LET g_rtcc[2].rtcc023 = l_feteday_desc
               LET g_rtcc[3].rtcc023 = 1
            WHEN 22  #rtcc024
               LET g_rtcc[1].rtcc024 = l_ooga002
               LET g_rtcc[2].rtcc024 = l_feteday_desc
               LET g_rtcc[3].rtcc024 = 1
            WHEN 23  #rtcc025
               LET g_rtcc[1].rtcc025 = l_ooga002
               LET g_rtcc[2].rtcc025 = l_feteday_desc
               LET g_rtcc[3].rtcc025 = 1
            WHEN 24  #rtcc026
               LET g_rtcc[1].rtcc026 = l_ooga002
               LET g_rtcc[2].rtcc026 = l_feteday_desc
               LET g_rtcc[3].rtcc026 = 1
            WHEN 25  #rtcc027
               LET g_rtcc[1].rtcc027 = l_ooga002
               LET g_rtcc[2].rtcc027 = l_feteday_desc
               LET g_rtcc[3].rtcc027 = 1
            WHEN 26  #rtcc028
               LET g_rtcc[1].rtcc028 = l_ooga002
               LET g_rtcc[2].rtcc028 = l_feteday_desc
               LET g_rtcc[3].rtcc028 = 1
            WHEN 27  #rtcc029
               LET g_rtcc[1].rtcc029 = l_ooga002
               LET g_rtcc[2].rtcc029 = l_feteday_desc
               LET g_rtcc[3].rtcc029 = 1
            WHEN 28  #rtcc030
               LET g_rtcc[1].rtcc030 = l_ooga002
               LET g_rtcc[2].rtcc030 = l_feteday_desc
               LET g_rtcc[3].rtcc030 = 1
            WHEN 29  #rtcc031
               LET g_rtcc[1].rtcc031 = l_ooga002
               LET g_rtcc[2].rtcc031 = l_feteday_desc
               LET g_rtcc[3].rtcc031 = 1
            WHEN 30  #rtcc032
               LET g_rtcc[1].rtcc032 = l_ooga002
               LET g_rtcc[2].rtcc032 = l_feteday_desc
               LET g_rtcc[3].rtcc032 = 1
            WHEN 31  #rtcc033
               LET g_rtcc[1].rtcc033 = l_ooga002
               LET g_rtcc[2].rtcc033 = l_feteday_desc
               LET g_rtcc[3].rtcc033 = 1
         END CASE
         
         LET l_n = l_n + 1
      END FOREACH 
      
      LET l_n = l_n - 1
      IF l_n = 0 THEN 
         LET r_success = FALSE
      END IF
   ELSE
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION
#預設行類型=1.星期 的資料
PRIVATE FUNCTION artm901_def_rowtype_1()
   
   LET g_rtcc_d[l_ac].rtcc002 = 1
   LET g_rtcc_d[l_ac].rtcc003 = g_rtcc[1].rtcc003
   LET g_rtcc_d[l_ac].rtcc004 = g_rtcc[1].rtcc004
   LET g_rtcc_d[l_ac].rtcc005 = g_rtcc[1].rtcc005
   LET g_rtcc_d[l_ac].rtcc006 = g_rtcc[1].rtcc006
   LET g_rtcc_d[l_ac].rtcc007 = g_rtcc[1].rtcc007
   LET g_rtcc_d[l_ac].rtcc008 = g_rtcc[1].rtcc008
   LET g_rtcc_d[l_ac].rtcc009 = g_rtcc[1].rtcc009
   LET g_rtcc_d[l_ac].rtcc010 = g_rtcc[1].rtcc010
   LET g_rtcc_d[l_ac].rtcc011 = g_rtcc[1].rtcc011
   LET g_rtcc_d[l_ac].rtcc012 = g_rtcc[1].rtcc012
   LET g_rtcc_d[l_ac].rtcc013 = g_rtcc[1].rtcc013
   LET g_rtcc_d[l_ac].rtcc014 = g_rtcc[1].rtcc014
   LET g_rtcc_d[l_ac].rtcc015 = g_rtcc[1].rtcc015
   LET g_rtcc_d[l_ac].rtcc016 = g_rtcc[1].rtcc016
   LET g_rtcc_d[l_ac].rtcc017 = g_rtcc[1].rtcc017
   LET g_rtcc_d[l_ac].rtcc018 = g_rtcc[1].rtcc018
   LET g_rtcc_d[l_ac].rtcc019 = g_rtcc[1].rtcc019
   LET g_rtcc_d[l_ac].rtcc020 = g_rtcc[1].rtcc020
   LET g_rtcc_d[l_ac].rtcc021 = g_rtcc[1].rtcc021
   LET g_rtcc_d[l_ac].rtcc022 = g_rtcc[1].rtcc022
   LET g_rtcc_d[l_ac].rtcc023 = g_rtcc[1].rtcc023
   LET g_rtcc_d[l_ac].rtcc024 = g_rtcc[1].rtcc024
   LET g_rtcc_d[l_ac].rtcc025 = g_rtcc[1].rtcc025
   LET g_rtcc_d[l_ac].rtcc026 = g_rtcc[1].rtcc026
   LET g_rtcc_d[l_ac].rtcc027 = g_rtcc[1].rtcc027
   LET g_rtcc_d[l_ac].rtcc028 = g_rtcc[1].rtcc028
   LET g_rtcc_d[l_ac].rtcc029 = g_rtcc[1].rtcc029
   LET g_rtcc_d[l_ac].rtcc030 = g_rtcc[1].rtcc030
   LET g_rtcc_d[l_ac].rtcc031 = g_rtcc[1].rtcc031
   LET g_rtcc_d[l_ac].rtcc032 = g_rtcc[1].rtcc032
   LET g_rtcc_d[l_ac].rtcc033 = g_rtcc[1].rtcc033
END FUNCTION
#預設行類型=2.節日類型 的資料
PRIVATE FUNCTION artm901_def_rowtype_2()
   
   LET g_rtcc_d[l_ac].rtcc001 = g_rtcc_d[g_detail_idx].rtcc001
   LET g_rtcc_d[l_ac].rtccunit= g_rtcc_d[g_detail_idx].rtccunit
   LET g_rtcc_d[l_ac].rtccstus= g_rtcc_d[g_detail_idx].rtccstus
   LET g_rtcc_d[l_ac].rtcc002 = 2
   LET g_rtcc_d[l_ac].rtcc003 = g_rtcc[2].rtcc003
   LET g_rtcc_d[l_ac].rtcc004 = g_rtcc[2].rtcc004
   LET g_rtcc_d[l_ac].rtcc005 = g_rtcc[2].rtcc005
   LET g_rtcc_d[l_ac].rtcc006 = g_rtcc[2].rtcc006
   LET g_rtcc_d[l_ac].rtcc007 = g_rtcc[2].rtcc007
   LET g_rtcc_d[l_ac].rtcc008 = g_rtcc[2].rtcc008
   LET g_rtcc_d[l_ac].rtcc009 = g_rtcc[2].rtcc009
   LET g_rtcc_d[l_ac].rtcc010 = g_rtcc[2].rtcc010
   LET g_rtcc_d[l_ac].rtcc011 = g_rtcc[2].rtcc011
   LET g_rtcc_d[l_ac].rtcc012 = g_rtcc[2].rtcc012
   LET g_rtcc_d[l_ac].rtcc013 = g_rtcc[2].rtcc013
   LET g_rtcc_d[l_ac].rtcc014 = g_rtcc[2].rtcc014
   LET g_rtcc_d[l_ac].rtcc015 = g_rtcc[2].rtcc015
   LET g_rtcc_d[l_ac].rtcc016 = g_rtcc[2].rtcc016
   LET g_rtcc_d[l_ac].rtcc017 = g_rtcc[2].rtcc017
   LET g_rtcc_d[l_ac].rtcc018 = g_rtcc[2].rtcc018
   LET g_rtcc_d[l_ac].rtcc019 = g_rtcc[2].rtcc019
   LET g_rtcc_d[l_ac].rtcc020 = g_rtcc[2].rtcc020
   LET g_rtcc_d[l_ac].rtcc021 = g_rtcc[2].rtcc021
   LET g_rtcc_d[l_ac].rtcc022 = g_rtcc[2].rtcc022
   LET g_rtcc_d[l_ac].rtcc023 = g_rtcc[2].rtcc023
   LET g_rtcc_d[l_ac].rtcc024 = g_rtcc[2].rtcc024
   LET g_rtcc_d[l_ac].rtcc025 = g_rtcc[2].rtcc025
   LET g_rtcc_d[l_ac].rtcc026 = g_rtcc[2].rtcc026
   LET g_rtcc_d[l_ac].rtcc027 = g_rtcc[2].rtcc027
   LET g_rtcc_d[l_ac].rtcc028 = g_rtcc[2].rtcc028
   LET g_rtcc_d[l_ac].rtcc029 = g_rtcc[2].rtcc029
   LET g_rtcc_d[l_ac].rtcc030 = g_rtcc[2].rtcc030
   LET g_rtcc_d[l_ac].rtcc031 = g_rtcc[2].rtcc031
   LET g_rtcc_d[l_ac].rtcc032 = g_rtcc[2].rtcc032
   LET g_rtcc_d[l_ac].rtcc033 = g_rtcc[2].rtcc033
   
   LET g_rtcc2_d[l_ac].rtccownid = g_rtcc2_d[g_detail_idx].rtccownid
   LET g_rtcc2_d[l_ac].rtcccrtid = g_rtcc2_d[g_detail_idx].rtcccrtid
   LET g_rtcc2_d[l_ac].rtcccrtdp = g_rtcc2_d[g_detail_idx].rtcccrtdp
   LET g_rtcc2_d[l_ac].rtcccrtdt = g_rtcc2_d[g_detail_idx].rtcccrtdt
   LET g_rtcc2_d[l_ac].rtccmodid = g_rtcc2_d[g_detail_idx].rtccmodid
   LET g_rtcc2_d[l_ac].rtccmoddt = g_rtcc2_d[g_detail_idx].rtccmoddt   
END FUNCTION
#預設行類型=3.預算係數 的資料
PRIVATE FUNCTION artm901_def_rowtype_3()
   
   LET g_rtcc_d[l_ac].rtcc001 = g_rtcc_d[g_detail_idx].rtcc001
   LET g_rtcc_d[l_ac].rtccunit= g_rtcc_d[g_detail_idx].rtccunit
   LET g_rtcc_d[l_ac].rtccstus= g_rtcc_d[g_detail_idx].rtccstus
   LET g_rtcc_d[l_ac].rtcc002 = 3
   LET g_rtcc_d[l_ac].rtcc003 = g_rtcc[3].rtcc003
   LET g_rtcc_d[l_ac].rtcc004 = g_rtcc[3].rtcc004
   LET g_rtcc_d[l_ac].rtcc005 = g_rtcc[3].rtcc005
   LET g_rtcc_d[l_ac].rtcc006 = g_rtcc[3].rtcc006
   LET g_rtcc_d[l_ac].rtcc007 = g_rtcc[3].rtcc007
   LET g_rtcc_d[l_ac].rtcc008 = g_rtcc[3].rtcc008
   LET g_rtcc_d[l_ac].rtcc009 = g_rtcc[3].rtcc009
   LET g_rtcc_d[l_ac].rtcc010 = g_rtcc[3].rtcc010
   LET g_rtcc_d[l_ac].rtcc011 = g_rtcc[3].rtcc011
   LET g_rtcc_d[l_ac].rtcc012 = g_rtcc[3].rtcc012
   LET g_rtcc_d[l_ac].rtcc013 = g_rtcc[3].rtcc013
   LET g_rtcc_d[l_ac].rtcc014 = g_rtcc[3].rtcc014
   LET g_rtcc_d[l_ac].rtcc015 = g_rtcc[3].rtcc015
   LET g_rtcc_d[l_ac].rtcc016 = g_rtcc[3].rtcc016
   LET g_rtcc_d[l_ac].rtcc017 = g_rtcc[3].rtcc017
   LET g_rtcc_d[l_ac].rtcc018 = g_rtcc[3].rtcc018
   LET g_rtcc_d[l_ac].rtcc019 = g_rtcc[3].rtcc019
   LET g_rtcc_d[l_ac].rtcc020 = g_rtcc[3].rtcc020
   LET g_rtcc_d[l_ac].rtcc021 = g_rtcc[3].rtcc021
   LET g_rtcc_d[l_ac].rtcc022 = g_rtcc[3].rtcc022
   LET g_rtcc_d[l_ac].rtcc023 = g_rtcc[3].rtcc023
   LET g_rtcc_d[l_ac].rtcc024 = g_rtcc[3].rtcc024
   LET g_rtcc_d[l_ac].rtcc025 = g_rtcc[3].rtcc025
   LET g_rtcc_d[l_ac].rtcc026 = g_rtcc[3].rtcc026
   LET g_rtcc_d[l_ac].rtcc027 = g_rtcc[3].rtcc027
   LET g_rtcc_d[l_ac].rtcc028 = g_rtcc[3].rtcc028
   LET g_rtcc_d[l_ac].rtcc029 = g_rtcc[3].rtcc029
   LET g_rtcc_d[l_ac].rtcc030 = g_rtcc[3].rtcc030
   LET g_rtcc_d[l_ac].rtcc031 = g_rtcc[3].rtcc031
   LET g_rtcc_d[l_ac].rtcc032 = g_rtcc[3].rtcc032
   LET g_rtcc_d[l_ac].rtcc033 = g_rtcc[3].rtcc033
   
   LET g_rtcc2_d[l_ac].rtccownid = g_rtcc2_d[g_detail_idx].rtccownid
   LET g_rtcc2_d[l_ac].rtcccrtid = g_rtcc2_d[g_detail_idx].rtcccrtid
   LET g_rtcc2_d[l_ac].rtcccrtdp = g_rtcc2_d[g_detail_idx].rtcccrtdp
   LET g_rtcc2_d[l_ac].rtcccrtdt = g_rtcc2_d[g_detail_idx].rtcccrtdt
   LET g_rtcc2_d[l_ac].rtccmodid = g_rtcc2_d[g_detail_idx].rtccmodid
   LET g_rtcc2_d[l_ac].rtccmoddt = g_rtcc2_d[g_detail_idx].rtccmoddt   
END FUNCTION

 
{</section>}
 
