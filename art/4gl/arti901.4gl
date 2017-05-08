#該程式未解開Section, 採用最新樣板產出!
{<section id="arti901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-11-06 18:24:21), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: arti901
#+ Description: 預算指標參數設定維護作業
#+ Creator....: 06815(2015-06-30 19:56:10)
#+ Modifier...: 06815 -SD/PR- 00000
 
{</section>}
 
{<section id="arti901.global" >}
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
PRIVATE TYPE type_g_rtca_d RECORD
       rtca001 LIKE rtca_t.rtca001, 
   rtcal003 LIKE rtcal_t.rtcal003, 
   rtcal004 LIKE rtcal_t.rtcal004, 
   rtca002 LIKE rtca_t.rtca002, 
   rtca002_desc LIKE type_t.chr500, 
   rtca003 LIKE rtca_t.rtca003, 
   rtca004 LIKE rtca_t.rtca004, 
   rtca004_desc LIKE type_t.chr500, 
   rtca005 LIKE rtca_t.rtca005, 
   rtca006 LIKE rtca_t.rtca006, 
   rtcastus LIKE rtca_t.rtcastus
       END RECORD
PRIVATE TYPE type_g_rtca2_d RECORD
       rtca001 LIKE rtca_t.rtca001, 
   rtcaownid LIKE rtca_t.rtcaownid, 
   rtcaownid_desc LIKE type_t.chr500, 
   rtcaowndp LIKE rtca_t.rtcaowndp, 
   rtcaowndp_desc LIKE type_t.chr500, 
   rtcacrtid LIKE rtca_t.rtcacrtid, 
   rtcacrtid_desc LIKE type_t.chr500, 
   rtcacrtdp LIKE rtca_t.rtcacrtdp, 
   rtcacrtdp_desc LIKE type_t.chr500, 
   rtcacrtdt DATETIME YEAR TO SECOND, 
   rtcamodid LIKE rtca_t.rtcamodid, 
   rtcamodid_desc LIKE type_t.chr500, 
   rtcamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      rtcal001 LIKE rtcal_t.rtcal001,
      rtcal002 LIKE rtcal_t.rtcal002,
      rtcal003 LIKE rtcal_t.rtcal003,
      rtcal004 LIKE rtcal_t.rtcal004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtca_d          DYNAMIC ARRAY OF type_g_rtca_d #單身變數
DEFINE g_rtca_d_t        type_g_rtca_d                  #單身備份
DEFINE g_rtca_d_o        type_g_rtca_d                  #單身備份
DEFINE g_rtca_d_mask_o   DYNAMIC ARRAY OF type_g_rtca_d #單身變數
DEFINE g_rtca_d_mask_n   DYNAMIC ARRAY OF type_g_rtca_d #單身變數
DEFINE g_rtca2_d   DYNAMIC ARRAY OF type_g_rtca2_d
DEFINE g_rtca2_d_t type_g_rtca2_d
DEFINE g_rtca2_d_o type_g_rtca2_d
DEFINE g_rtca2_d_mask_o DYNAMIC ARRAY OF type_g_rtca2_d
DEFINE g_rtca2_d_mask_n DYNAMIC ARRAY OF type_g_rtca2_d
 
      
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
 
{<section id="arti901.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtca001,rtca002,rtca003,rtca004,rtca005,rtca006,rtcastus,rtca001,rtcaownid, 
       rtcaowndp,rtcacrtid,rtcacrtdp,rtcacrtdt,rtcamodid,rtcamoddt FROM rtca_t WHERE rtcaent=? AND rtca001=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti901_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti901 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti901_init()   
 
      #進入選單 Menu (="N")
      CALL arti901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti901
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti901.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION arti901_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('rtca003','6835') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL arti901_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="arti901.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION arti901_ui_dialog()
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
         CALL g_rtca_d.clear()
         CALL g_rtca2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL arti901_init()
      END IF
   
      CALL arti901_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_rtca2_d[g_detail_idx].rtcaownid   #(ver:35)
               LET g_data_dept = g_rtca2_d[g_detail_idx].rtcaowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtca2_d TO s_detail2.*
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
   CALL arti901_set_pk_array()
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
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL arti901_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti901_modify()
            #add-point:ON ACTION modify name="menu.modify"
       
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL arti901_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti901_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL arti901_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti901_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti901_insert()
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
               CALL arti901_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_rtca_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtca2_d)
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
            CALL arti901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti901_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti901_set_pk_array()
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
 
{<section id="arti901.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti901_query()
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
   CALL g_rtca_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON rtca001,rtcal003,rtcal004,rtca002,rtca003,rtca004,rtca005,rtca006,rtcastus, 
          rtcaownid,rtcaowndp,rtcacrtid,rtcacrtdp,rtcacrtdt,rtcamodid,rtcamoddt 
 
         FROM s_detail1[1].rtca001,s_detail1[1].rtcal003,s_detail1[1].rtcal004,s_detail1[1].rtca002, 
             s_detail1[1].rtca003,s_detail1[1].rtca004,s_detail1[1].rtca005,s_detail1[1].rtca006,s_detail1[1].rtcastus, 
             s_detail2[1].rtcaownid,s_detail2[1].rtcaowndp,s_detail2[1].rtcacrtid,s_detail2[1].rtcacrtdp, 
             s_detail2[1].rtcacrtdt,s_detail2[1].rtcamodid,s_detail2[1].rtcamoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtcacrtdt>>----
         AFTER FIELD rtcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtcamoddt>>----
         AFTER FIELD rtcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtcacnfdt>>----
         
         #----<<rtcapstdt>>----
 
 
 
      
                  #Ctrlp:construct.c.page1.rtca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca001
            #add-point:ON ACTION controlp INFIELD rtca001 name="construct.c.page1.rtca001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001_02()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtca001  #顯示到畫面上
            NEXT FIELD rtca001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca001
            #add-point:BEFORE FIELD rtca001 name="query.b.page1.rtca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca001
            
            #add-point:AFTER FIELD rtca001 name="query.a.page1.rtca001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcal003
            #add-point:BEFORE FIELD rtcal003 name="query.b.page1.rtcal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcal003
            
            #add-point:AFTER FIELD rtcal003 name="query.a.page1.rtcal003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcal003
            #add-point:ON ACTION controlp INFIELD rtcal003 name="query.c.page1.rtcal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcal004
            #add-point:BEFORE FIELD rtcal004 name="query.b.page1.rtcal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcal004
            
            #add-point:AFTER FIELD rtcal004 name="query.a.page1.rtcal004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcal004
            #add-point:ON ACTION controlp INFIELD rtcal004 name="query.c.page1.rtcal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca002
            #add-point:BEFORE FIELD rtca002 name="query.b.page1.rtca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca002
            
            #add-point:AFTER FIELD rtca002 name="query.a.page1.rtca002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca002
            #add-point:ON ACTION controlp INFIELD rtca002 name="query.c.page1.rtca002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='2138'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtca002  #顯示到畫面上
            NEXT FIELD rtca002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca003
            #add-point:BEFORE FIELD rtca003 name="query.b.page1.rtca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca003
            
            #add-point:AFTER FIELD rtca003 name="query.a.page1.rtca003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca003
            #add-point:ON ACTION controlp INFIELD rtca003 name="query.c.page1.rtca003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca004
            #add-point:ON ACTION controlp INFIELD rtca004 name="construct.c.page1.rtca004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtca004  #顯示到畫面上
            NEXT FIELD rtca004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca004
            #add-point:BEFORE FIELD rtca004 name="query.b.page1.rtca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca004
            
            #add-point:AFTER FIELD rtca004 name="query.a.page1.rtca004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca005
            #add-point:BEFORE FIELD rtca005 name="query.b.page1.rtca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca005
            
            #add-point:AFTER FIELD rtca005 name="query.a.page1.rtca005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca005
            #add-point:ON ACTION controlp INFIELD rtca005 name="query.c.page1.rtca005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca006
            #add-point:BEFORE FIELD rtca006 name="query.b.page1.rtca006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca006
            
            #add-point:AFTER FIELD rtca006 name="query.a.page1.rtca006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtca006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca006
            #add-point:ON ACTION controlp INFIELD rtca006 name="query.c.page1.rtca006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcastus
            #add-point:BEFORE FIELD rtcastus name="query.b.page1.rtcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcastus
            
            #add-point:AFTER FIELD rtcastus name="query.a.page1.rtcastus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcastus
            #add-point:ON ACTION controlp INFIELD rtcastus name="query.c.page1.rtcastus"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.rtcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcaownid
            #add-point:ON ACTION controlp INFIELD rtcaownid name="construct.c.page2.rtcaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcaownid  #顯示到畫面上
            NEXT FIELD rtcaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcaownid
            #add-point:BEFORE FIELD rtcaownid name="query.b.page2.rtcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcaownid
            
            #add-point:AFTER FIELD rtcaownid name="query.a.page2.rtcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcaowndp
            #add-point:ON ACTION controlp INFIELD rtcaowndp name="construct.c.page2.rtcaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcaowndp  #顯示到畫面上
            NEXT FIELD rtcaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcaowndp
            #add-point:BEFORE FIELD rtcaowndp name="query.b.page2.rtcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcaowndp
            
            #add-point:AFTER FIELD rtcaowndp name="query.a.page2.rtcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcacrtid
            #add-point:ON ACTION controlp INFIELD rtcacrtid name="construct.c.page2.rtcacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcacrtid  #顯示到畫面上
            NEXT FIELD rtcacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcacrtid
            #add-point:BEFORE FIELD rtcacrtid name="query.b.page2.rtcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcacrtid
            
            #add-point:AFTER FIELD rtcacrtid name="query.a.page2.rtcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcacrtdp
            #add-point:ON ACTION controlp INFIELD rtcacrtdp name="construct.c.page2.rtcacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcacrtdp  #顯示到畫面上
            NEXT FIELD rtcacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcacrtdp
            #add-point:BEFORE FIELD rtcacrtdp name="query.b.page2.rtcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcacrtdp
            
            #add-point:AFTER FIELD rtcacrtdp name="query.a.page2.rtcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcacrtdt
            #add-point:BEFORE FIELD rtcacrtdt name="query.b.page2.rtcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcamodid
            #add-point:ON ACTION controlp INFIELD rtcamodid name="construct.c.page2.rtcamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcamodid  #顯示到畫面上
            NEXT FIELD rtcamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcamodid
            #add-point:BEFORE FIELD rtcamodid name="query.b.page2.rtcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcamodid
            
            #add-point:AFTER FIELD rtcamodid name="query.a.page2.rtcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcamoddt
            #add-point:BEFORE FIELD rtcamoddt name="query.b.page2.rtcamoddt"
            
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
    
   CALL arti901_b_fill(g_wc2)
   LET g_data_owner = g_rtca2_d[g_detail_idx].rtcaownid   #(ver:35)
   LET g_data_dept = g_rtca2_d[g_detail_idx].rtcaowndp   #(ver:35)
 
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
 
{<section id="arti901.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti901_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL arti901_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti901.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti901_modify()
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
      INPUT ARRAY g_rtca_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
               IF NOT cl_null(g_rtca_d[l_ac].rtca001)  THEN
                 CALL n_rtcal(g_rtca_d[l_ac].rtca001)
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = g_rtca_d[l_ac].rtca001
                 CALL ap_ref_array2(g_ref_fields," SELECT rtcal003,rtcal004 FROM rtcal_t WHERE rtcalent = '"||g_enterprise||"'
                       AND rtcal001 = ? AND rtcal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_rtca_d[l_ac].rtcal003 = g_rtn_fields[1]
                 LET g_rtca_d[l_ac].rtcal004 = g_rtn_fields[2]
                 DISPLAY BY NAME g_rtca_d[l_ac].rtcal003
                 DISPLAY BY NAME g_rtca_d[l_ac].rtcal004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtca_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL arti901_b_fill(g_wc2)
            LET g_detail_cnt = g_rtca_d.getLength()
         
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
            DISPLAY g_rtca_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtca_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtca_d[l_ac].rtca001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtca_d_t.* = g_rtca_d[l_ac].*  #BACKUP
               LET g_rtca_d_o.* = g_rtca_d[l_ac].*  #BACKUP
               IF NOT arti901_lock_b("rtca_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti901_bcl INTO g_rtca_d[l_ac].rtca001,g_rtca_d[l_ac].rtca002,g_rtca_d[l_ac].rtca003, 
                      g_rtca_d[l_ac].rtca004,g_rtca_d[l_ac].rtca005,g_rtca_d[l_ac].rtca006,g_rtca_d[l_ac].rtcastus, 
                      g_rtca2_d[l_ac].rtca001,g_rtca2_d[l_ac].rtcaownid,g_rtca2_d[l_ac].rtcaowndp,g_rtca2_d[l_ac].rtcacrtid, 
                      g_rtca2_d[l_ac].rtcacrtdp,g_rtca2_d[l_ac].rtcacrtdt,g_rtca2_d[l_ac].rtcamodid, 
                      g_rtca2_d[l_ac].rtcamoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtca_d_t.rtca001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtca_d_mask_o[l_ac].* =  g_rtca_d[l_ac].*
                  CALL arti901_rtca_t_mask()
                  LET g_rtca_d_mask_n[l_ac].* =  g_rtca_d[l_ac].*
                  
                  CALL arti901_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti901_set_entry_b(l_cmd)
            CALL arti901_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL arti901_set_entry_b(l_cmd)
            CALL arti901_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.rtcal001 = g_rtca_d[l_ac].rtca001
LET g_detail_multi_table_t.rtcal002 = g_dlang
LET g_detail_multi_table_t.rtcal003 = g_rtca_d[l_ac].rtcal003
LET g_detail_multi_table_t.rtcal004 = g_rtca_d[l_ac].rtcal004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rtcalent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rtcal001'
            LET l_var_keys[02] = g_rtca_d[l_ac].rtca001
            LET l_field_keys[03] = 'rtcal002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rtcal_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtca_d_t.* TO NULL
            INITIALIZE g_rtca_d_o.* TO NULL
            INITIALIZE g_rtca_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtca2_d[l_ac].rtcaownid = g_user
      LET g_rtca2_d[l_ac].rtcaowndp = g_dept
      LET g_rtca2_d[l_ac].rtcacrtid = g_user
      LET g_rtca2_d[l_ac].rtcacrtdp = g_dept 
      LET g_rtca2_d[l_ac].rtcacrtdt = cl_get_current()
      LET g_rtca2_d[l_ac].rtcamodid = g_user
      LET g_rtca2_d[l_ac].rtcamoddt = cl_get_current()
      LET g_rtca_d[l_ac].rtcastus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_rtca_d[l_ac].rtca005 = "N"
      LET g_rtca_d[l_ac].rtca006 = "Y"
      LET g_rtca_d[l_ac].rtcastus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_rtca_d_t.* = g_rtca_d[l_ac].*     #新輸入資料
            LET g_rtca_d_o.* = g_rtca_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtca_d[li_reproduce_target].* = g_rtca_d[li_reproduce].*
               LET g_rtca2_d[li_reproduce_target].* = g_rtca2_d[li_reproduce].*
 
               LET g_rtca_d[g_rtca_d.getLength()].rtca001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.rtcal001 = g_rtca_d[l_ac].rtca001
LET g_detail_multi_table_t.rtcal002 = g_dlang
LET g_detail_multi_table_t.rtcal003 = g_rtca_d[l_ac].rtcal003
LET g_detail_multi_table_t.rtcal004 = g_rtca_d[l_ac].rtcal004
 
 
            CALL arti901_set_entry_b(l_cmd)
            CALL arti901_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM rtca_t 
             WHERE rtcaent = g_enterprise AND rtca001 = g_rtca_d[l_ac].rtca001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtca_d[g_detail_idx].rtca001
               CALL arti901_insert_b('rtca_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtca_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtca_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti901_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtca_d[l_ac].rtca001 = g_detail_multi_table_t.rtcal001 AND
         g_rtca_d[l_ac].rtcal003 = g_detail_multi_table_t.rtcal003 AND
         g_rtca_d[l_ac].rtcal004 = g_detail_multi_table_t.rtcal004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtcalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtca_d[l_ac].rtca001
            LET l_field_keys[02] = 'rtcal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtcal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtcal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtcal002
            LET l_vars[01] = g_rtca_d[l_ac].rtcal003
            LET l_fields[01] = 'rtcal003'
            LET l_vars[02] = g_rtca_d[l_ac].rtcal004
            LET l_fields[02] = 'rtcal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtcal_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (rtca001 = '", g_rtca_d[l_ac].rtca001, "' "
 
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
               
               DELETE FROM rtca_t
                WHERE rtcaent = g_enterprise AND 
                      rtca001 = g_rtca_d_t.rtca001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtca_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtcalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtcal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtcal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtcal_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL arti901_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_rtca_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE arti901_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_rtca_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtca_d_t.rtca001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti901_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL arti901_delete_b('rtca_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtca_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca001
            #add-point:BEFORE FIELD rtca001 name="input.b.page1.rtca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca001
            
            #add-point:AFTER FIELD rtca001 name="input.a.page1.rtca001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtca_d[g_detail_idx].rtca001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtca_d[g_detail_idx].rtca001 != g_rtca_d_t.rtca001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtca_t WHERE "||"rtcaent = '" ||g_enterprise|| "' AND "||"rtca001 = '"||g_rtca_d[g_detail_idx].rtca001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtca001
            #add-point:ON CHANGE rtca001 name="input.g.page1.rtca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcal003
            #add-point:BEFORE FIELD rtcal003 name="input.b.page1.rtcal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcal003
            
            #add-point:AFTER FIELD rtcal003 name="input.a.page1.rtcal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcal003
            #add-point:ON CHANGE rtcal003 name="input.g.page1.rtcal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcal004
            #add-point:BEFORE FIELD rtcal004 name="input.b.page1.rtcal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcal004
            
            #add-point:AFTER FIELD rtcal004 name="input.a.page1.rtcal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcal004
            #add-point:ON CHANGE rtcal004 name="input.g.page1.rtcal004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca002
            
            #add-point:AFTER FIELD rtca002 name="input.a.page1.rtca002"
            LET g_rtca_d[l_ac].rtca002_desc = ''
            DISPLAY BY NAME g_rtca_d[l_ac].rtca002_desc
            IF NOT cl_null(g_rtca_d[l_ac].rtca002) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rtca_d[l_ac].rtca002 != g_rtca_d_t.rtca002 OR g_rtca_d_t.rtca002 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('2138',g_rtca_d[l_ac].rtca002) THEN
                     LET g_rtca_d[l_ac].rtca002 = g_rtca_d_t.rtca002
                     CALL s_desc_get_acc_desc('2138',g_rtca_d[l_ac].rtca002) RETURNING g_rtca_d[l_ac].rtca002_desc
                     DISPLAY BY NAME g_rtca_d[l_ac].rtca002,g_rtca_d[l_ac].rtca002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2138',g_rtca_d[l_ac].rtca002) RETURNING g_rtca_d[l_ac].rtca002_desc
            DISPLAY BY NAME g_rtca_d[l_ac].rtca002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca002
            #add-point:BEFORE FIELD rtca002 name="input.b.page1.rtca002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtca002
            #add-point:ON CHANGE rtca002 name="input.g.page1.rtca002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca003
            #add-point:BEFORE FIELD rtca003 name="input.b.page1.rtca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca003
            
            #add-point:AFTER FIELD rtca003 name="input.a.page1.rtca003"
            CALL arti901_set_entry_b(l_cmd)
            CALL arti901_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtca003
            #add-point:ON CHANGE rtca003 name="input.g.page1.rtca003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca004
            
            #add-point:AFTER FIELD rtca004 name="input.a.page1.rtca004"
            IF g_rtca_d[l_ac].rtca004 != g_rtca_d_o.rtca004 OR cl_null(g_rtca_d_o.rtca004) THEN          
            LET l_cnt = 0                            
            SELECT COUNT(*) INTO l_cnt
              FROM rtca_t 
             WHERE rtcaent = g_enterprise
               AND rtca001 = g_rtca_d[l_ac].rtca004
               AND rtca003 = 2
               
             IF l_cnt=0 AND NOT cl_null(g_rtca_d[l_ac].rtca004) OR g_rtca_d[l_ac].rtca004 !=1 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00664'
             LET g_errparam.extend ='' 
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET g_rtca_d[l_ac].rtca004 = g_rtca_d_o.rtca004
             END IF           
             
             SELECT rtcal003 INTO g_rtca_d[l_ac].rtca004_desc
              FROM rtcal_t
             WHERE rtcalent = g_enterprise AND rtcal001 = g_rtca_d[l_ac].rtca004 AND rtcal002 = g_dlang            
             DISPLAY BY NAME  g_rtca_d[l_ac].rtca004_desc  #顯示到畫面上
             
            END IF
            LET g_rtca_d_o.rtca004 = g_rtca_d[l_ac].rtca004
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca004
            #add-point:BEFORE FIELD rtca004 name="input.b.page1.rtca004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtca004
            #add-point:ON CHANGE rtca004 name="input.g.page1.rtca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca005
            #add-point:BEFORE FIELD rtca005 name="input.b.page1.rtca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca005
            
            #add-point:AFTER FIELD rtca005 name="input.a.page1.rtca005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtca005
            #add-point:ON CHANGE rtca005 name="input.g.page1.rtca005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtca006
            #add-point:BEFORE FIELD rtca006 name="input.b.page1.rtca006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtca006
            
            #add-point:AFTER FIELD rtca006 name="input.a.page1.rtca006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtca006
            #add-point:ON CHANGE rtca006 name="input.g.page1.rtca006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcastus
            #add-point:BEFORE FIELD rtcastus name="input.b.page1.rtcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcastus
            
            #add-point:AFTER FIELD rtcastus name="input.a.page1.rtcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcastus
            #add-point:ON CHANGE rtcastus name="input.g.page1.rtcastus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca001
            #add-point:ON ACTION controlp INFIELD rtca001 name="input.c.page1.rtca001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcal003
            #add-point:ON ACTION controlp INFIELD rtcal003 name="input.c.page1.rtcal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcal004
            #add-point:ON ACTION controlp INFIELD rtcal004 name="input.c.page1.rtcal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca002
            #add-point:ON ACTION controlp INFIELD rtca002 name="input.c.page1.rtca002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtca_d[l_ac].rtca002             #給予default值
            LET g_qryparam.default2 = "" # g_rtca_d[l_ac].rtca002 #說明
            #給予arg
            LET g_qryparam.arg1 = '2138' 
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtca_d[l_ac].rtca002 = g_qryparam.return1  

            #reference      
            CALL s_desc_get_acc_desc('2138',g_rtca_d[l_ac].rtca002) RETURNING g_rtca_d[l_ac].rtca002_desc
         
            DISPLAY g_rtca_d[l_ac].rtca002 TO rtca002              
            DISPLAY BY NAME g_rtca_d[l_ac].rtca002_desc   
            #DISPLAY g_imck_m.oocql004 TO oocql004 #說明
            NEXT FIELD rtca002
            
            #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca003
            #add-point:ON ACTION controlp INFIELD rtca003 name="input.c.page1.rtca003"
          
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca004
            #add-point:ON ACTION controlp INFIELD rtca004 name="input.c.page1.rtca004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001_01()                           #呼叫開窗
            LET g_rtca_d[l_ac].rtca004 = g_qryparam.return1  
            SELECT rtcal003 INTO g_rtca_d[l_ac].rtca004_desc
              FROM rtcal_t
             WHERE rtcalent = g_enterprise AND rtcal001 = g_rtca_d[l_ac].rtca004 AND rtcal002 = g_dlang            
            DISPLAY BY NAME  g_rtca_d[l_ac].rtca004  #顯示到畫面上
            DISPLAY BY NAME  g_rtca_d[l_ac].rtca004_desc
            NEXT FIELD rtca004                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca005
            #add-point:ON ACTION controlp INFIELD rtca005 name="input.c.page1.rtca005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtca006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtca006
            #add-point:ON ACTION controlp INFIELD rtca006 name="input.c.page1.rtca006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcastus
            #add-point:ON ACTION controlp INFIELD rtcastus name="input.c.page1.rtcastus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE arti901_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_rtca_d[l_ac].* = g_rtca_d_t.*
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
               LET g_errparam.extend = g_rtca_d[l_ac].rtca001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtca_d[l_ac].* = g_rtca_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtca2_d[l_ac].rtcamodid = g_user 
LET g_rtca2_d[l_ac].rtcamoddt = cl_get_current()
LET g_rtca2_d[l_ac].rtcamodid_desc = cl_get_username(g_rtca2_d[l_ac].rtcamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti901_rtca_t_mask_restore('restore_mask_o')
 
               UPDATE rtca_t SET (rtca001,rtca002,rtca003,rtca004,rtca005,rtca006,rtcastus,rtcaownid, 
                   rtcaowndp,rtcacrtid,rtcacrtdp,rtcacrtdt,rtcamodid,rtcamoddt) = (g_rtca_d[l_ac].rtca001, 
                   g_rtca_d[l_ac].rtca002,g_rtca_d[l_ac].rtca003,g_rtca_d[l_ac].rtca004,g_rtca_d[l_ac].rtca005, 
                   g_rtca_d[l_ac].rtca006,g_rtca_d[l_ac].rtcastus,g_rtca2_d[l_ac].rtcaownid,g_rtca2_d[l_ac].rtcaowndp, 
                   g_rtca2_d[l_ac].rtcacrtid,g_rtca2_d[l_ac].rtcacrtdp,g_rtca2_d[l_ac].rtcacrtdt,g_rtca2_d[l_ac].rtcamodid, 
                   g_rtca2_d[l_ac].rtcamoddt)
                WHERE rtcaent = g_enterprise AND
                  rtca001 = g_rtca_d_t.rtca001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtca_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtca_d[g_detail_idx].rtca001
               LET gs_keys_bak[1] = g_rtca_d_t.rtca001
               CALL arti901_update_b('rtca_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtca_d[l_ac].rtca001 = g_detail_multi_table_t.rtcal001 AND
         g_rtca_d[l_ac].rtcal003 = g_detail_multi_table_t.rtcal003 AND
         g_rtca_d[l_ac].rtcal004 = g_detail_multi_table_t.rtcal004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtcalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtca_d[l_ac].rtca001
            LET l_field_keys[02] = 'rtcal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtcal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtcal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtcal002
            LET l_vars[01] = g_rtca_d[l_ac].rtcal003
            LET l_fields[01] = 'rtcal003'
            LET l_vars[02] = g_rtca_d[l_ac].rtcal004
            LET l_fields[02] = 'rtcal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtcal_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtca_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtca_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL arti901_rtca_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti901_unlock_b("rtca_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtca_d[l_ac].* = g_rtca_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            CALL cl_multitable_unlock()
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
               LET g_rtca_d[li_reproduce_target].* = g_rtca_d[li_reproduce].*
               LET g_rtca2_d[li_reproduce_target].* = g_rtca2_d[li_reproduce].*
 
               LET g_rtca_d[li_reproduce_target].rtca001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtca_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtca_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_rtca2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL arti901_b_fill(g_wc2)
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
               NEXT FIELD rtca001
            WHEN "s_detail2"
               NEXT FIELD rtca001_2
 
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
      IF INT_FLAG OR cl_null(g_rtca_d[g_detail_idx].rtca001) THEN
         CALL g_rtca_d.deleteElement(g_detail_idx)
         CALL g_rtca2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_rtca_d[g_detail_idx].* = g_rtca_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE arti901_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="arti901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti901_delete()
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
   FOR li_idx = 1 TO g_rtca_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT arti901_lock_b("rtca_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("rtca_t","rtcaownid") THEN
            LET g_data_owner = g_rtca2_d[g_detail_idx].rtcaownid
            LET g_data_dept = g_rtca2_d[g_detail_idx].rtcaowndp
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
   
   FOR li_idx = 1 TO g_rtca_d.getLength()
      IF g_rtca_d[li_idx].rtca001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM rtca_t
          WHERE rtcaent = g_enterprise AND 
                rtca001 = g_rtca_d[li_idx].rtca001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtca_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.rtcal001 = g_rtca_d[l_ac].rtca001
LET g_detail_multi_table_t.rtcal002 = g_dlang
LET g_detail_multi_table_t.rtcal003 = g_rtca_d[l_ac].rtcal003
LET g_detail_multi_table_t.rtcal004 = g_rtca_d[l_ac].rtcal004
 
 
            
LET g_detail_multi_table_t.rtcal001 = g_rtca_d[l_ac].rtca001
LET g_detail_multi_table_t.rtcal002 = g_dlang
LET g_detail_multi_table_t.rtcal003 = g_rtca_d[l_ac].rtcal003
LET g_detail_multi_table_t.rtcal004 = g_rtca_d[l_ac].rtcal004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtcalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtcal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtcal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtcal_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtcalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtcal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtcal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtcal_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtca_d_t.rtca001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL arti901_delete_b('rtca_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti901_set_pk_array()
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
   CALL arti901_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="arti901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti901_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.rtca001,t0.rtca002,t0.rtca003,t0.rtca004,t0.rtca005,t0.rtca006,t0.rtcastus, 
       t0.rtca001,t0.rtcaownid,t0.rtcaowndp,t0.rtcacrtid,t0.rtcacrtdp,t0.rtcacrtdt,t0.rtcamodid,t0.rtcamoddt , 
       t1.oocql004 ,t2.rtcal003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 FROM rtca_t t0", 
 
               " LEFT JOIN rtcal_t ON rtcalent = "||g_enterprise||" AND rtca001 = rtcal001 AND rtcal002 = '",g_dlang,"'",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2138' AND t1.oocql002=t0.rtca002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtcal_t t2 ON t2.rtcalent="||g_enterprise||" AND t2.rtcal001=t0.rtca004 AND t2.rtcal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.rtcaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtcaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtcacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rtcacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.rtcamodid  ",
 
               " WHERE t0.rtcaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("rtca_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND rtcaowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("rtca_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND rtcaownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = "SELECT  UNIQUE t0.rtca001,t0.rtca002,t0.rtca003,t0.rtca004,t0.rtca005,t0.rtca006,t0.rtcastus, 
       t0.rtca001,t0.rtcaownid,t0.rtcaowndp,t0.rtcacrtid,t0.rtcacrtdp,t0.rtcacrtdt,t0.rtcamodid,t0.rtcamoddt , 
       t1.oocql004 ,t2.rtcal003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 FROM rtca_t t0", 

               " LEFT JOIN rtcal_t ON rtcalent = '"||g_enterprise||"' AND t0.rtca001 = rtcal001 AND rtcal002 = '",g_dlang,"'",
               " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='2138' AND t1.oocql002=t0.rtca002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtcal_t t2 ON t2.rtcalent='"||g_enterprise||"' AND t2.rtcal001=t0.rtca004 AND t2.rtcal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.rtcaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.rtcaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.rtcacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.rtcacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.rtcamodid  ",
 
               " WHERE t0.rtcaent= ?  AND  1=1 AND (", p_wc2, ") "  
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtca_t"),
                      " ORDER BY t0.rtca001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtca_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti901_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR arti901_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtca_d.clear()
   CALL g_rtca2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtca_d[l_ac].rtca001,g_rtca_d[l_ac].rtca002,g_rtca_d[l_ac].rtca003,g_rtca_d[l_ac].rtca004, 
       g_rtca_d[l_ac].rtca005,g_rtca_d[l_ac].rtca006,g_rtca_d[l_ac].rtcastus,g_rtca2_d[l_ac].rtca001, 
       g_rtca2_d[l_ac].rtcaownid,g_rtca2_d[l_ac].rtcaowndp,g_rtca2_d[l_ac].rtcacrtid,g_rtca2_d[l_ac].rtcacrtdp, 
       g_rtca2_d[l_ac].rtcacrtdt,g_rtca2_d[l_ac].rtcamodid,g_rtca2_d[l_ac].rtcamoddt,g_rtca_d[l_ac].rtca002_desc, 
       g_rtca_d[l_ac].rtca004_desc,g_rtca2_d[l_ac].rtcaownid_desc,g_rtca2_d[l_ac].rtcaowndp_desc,g_rtca2_d[l_ac].rtcacrtid_desc, 
       g_rtca2_d[l_ac].rtcacrtdp_desc,g_rtca2_d[l_ac].rtcamodid_desc
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
      
      CALL arti901_detail_show()      
 
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
   
 
   
   CALL g_rtca_d.deleteElement(g_rtca_d.getLength())   
   CALL g_rtca2_d.deleteElement(g_rtca2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtca_d.getLength()
      LET g_rtca2_d[l_ac].rtca001 = g_rtca_d[l_ac].rtca001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_rtca_d.getLength() THEN
      LET l_ac = g_rtca_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtca_d.getLength()
      LET g_rtca_d_mask_o[l_ac].* =  g_rtca_d[l_ac].*
      CALL arti901_rtca_t_mask()
      LET g_rtca_d_mask_n[l_ac].* =  g_rtca_d[l_ac].*
   END FOR
   
   LET g_rtca2_d_mask_o.* =  g_rtca2_d.*
   FOR l_ac = 1 TO g_rtca2_d.getLength()
      LET g_rtca2_d_mask_o[l_ac].* =  g_rtca2_d[l_ac].*
      CALL arti901_rtca_t_mask()
      LET g_rtca2_d_mask_n[l_ac].* =  g_rtca2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_rtca_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE arti901_pb
   
END FUNCTION
 
{</section>}
 
{<section id="arti901.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION arti901_detail_show()
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
   #指標說明 助記碼
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_rtca_d[l_ac].rtca001
   CALL ap_ref_array2(g_ref_fields," SELECT rtcal003,rtcal004 FROM rtcal_t WHERE rtcalent = '"||g_enterprise||"' AND rtcal001 = ? AND rtcal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_rtca_d[l_ac].rtcal003 = g_rtn_fields[1] 
   LET g_rtca_d[l_ac].rtcal004 = g_rtn_fields[2]
   DISPLAY BY NAME g_rtca_d[l_ac].rtcal003
   DISPLAY BY NAME g_rtca_d[l_ac].rtcal004
 
   #組別說明 
   CALL s_desc_get_acc_desc('2138',g_rtca_d[l_ac].rtca002) RETURNING g_rtca_d[l_ac].rtca002_desc
   DISPLAY BY NAME g_rtca_d[l_ac].rtca002_desc

      
    
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti901_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("rtca004",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="arti901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti901_set_no_entry_b(p_cmd)                                               
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
   IF g_rtca_d[l_ac].rtca003 != 1 THEN
   CALL cl_set_comp_entry("rtca004",FALSE)
   END IF   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="arti901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti901_default_search()
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
      LET ls_wc = ls_wc, " rtca001 = '", g_argv[01], "' AND "
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
 
{<section id="arti901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti901_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "rtca_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtca_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM rtca_t
          WHERE rtcaent = g_enterprise AND
            rtca001 = ps_keys_bak[1]
         
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
         CALL g_rtca_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_rtca2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti901_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "rtca_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO rtca_t
                  (rtcaent,
                   rtca001
                   ,rtca002,rtca003,rtca004,rtca005,rtca006,rtcastus,rtcaownid,rtcaowndp,rtcacrtid,rtcacrtdp,rtcacrtdt,rtcamodid,rtcamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_rtca_d[l_ac].rtca002,g_rtca_d[l_ac].rtca003,g_rtca_d[l_ac].rtca004,g_rtca_d[l_ac].rtca005, 
                       g_rtca_d[l_ac].rtca006,g_rtca_d[l_ac].rtcastus,g_rtca2_d[l_ac].rtcaownid,g_rtca2_d[l_ac].rtcaowndp, 
                       g_rtca2_d[l_ac].rtcacrtid,g_rtca2_d[l_ac].rtcacrtdp,g_rtca2_d[l_ac].rtcacrtdt, 
                       g_rtca2_d[l_ac].rtcamodid,g_rtca2_d[l_ac].rtcamoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "rtca_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtca_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE rtca_t 
         SET (rtca001
              ,rtca002,rtca003,rtca004,rtca005,rtca006,rtcastus,rtcaownid,rtcaowndp,rtcacrtid,rtcacrtdp,rtcacrtdt,rtcamodid,rtcamoddt) 
              = 
             (ps_keys[1]
              ,g_rtca_d[l_ac].rtca002,g_rtca_d[l_ac].rtca003,g_rtca_d[l_ac].rtca004,g_rtca_d[l_ac].rtca005, 
                  g_rtca_d[l_ac].rtca006,g_rtca_d[l_ac].rtcastus,g_rtca2_d[l_ac].rtcaownid,g_rtca2_d[l_ac].rtcaowndp, 
                  g_rtca2_d[l_ac].rtcacrtid,g_rtca2_d[l_ac].rtcacrtdp,g_rtca2_d[l_ac].rtcacrtdt,g_rtca2_d[l_ac].rtcamodid, 
                  g_rtca2_d[l_ac].rtcamoddt) 
         WHERE rtcaent = g_enterprise AND rtca001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtca_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtca_t:",SQLERRMESSAGE 
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
 
{<section id="arti901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti901_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL arti901_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtca_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN arti901_bcl USING g_enterprise,
                                       g_rtca_d[g_detail_idx].rtca001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti901_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti901_unlock_b(ps_table)
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
      CLOSE arti901_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti901.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION arti901_modify_detail_chk(ps_record)
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
         LET ls_return = "rtca001"
      WHEN "s_detail2"
         LET ls_return = "rtca001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="arti901.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION arti901_show_ownid_msg()
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
 
{<section id="arti901.mask_functions" >}
&include "erp/art/arti901_mask.4gl"
 
{</section>}
 
{<section id="arti901.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti901_set_pk_array()
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
   LET g_pk_array[1].values = g_rtca_d[l_ac].rtca001
   LET g_pk_array[1].column = 'rtca001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti901.state_change" >}
   
 
{</section>}
 
{<section id="arti901.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti901.other_function" readonly="Y" >}

 
{</section>}
 
