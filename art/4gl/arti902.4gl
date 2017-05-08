#該程式未解開Section, 採用最新樣板產出!
{<section id="arti902.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-07-01 15:27:33), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: arti902
#+ Description: 預算設定維護作業
#+ Creator....: 06814(2015-06-30 19:15:38)
#+ Modifier...: 06814 -SD/PR- 00000
 
{</section>}
 
{<section id="arti902.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#47 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
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
PRIVATE TYPE type_g_rtcb_d RECORD
       rtcb001 LIKE rtcb_t.rtcb001, 
   rtcbsite LIKE rtcb_t.rtcbsite, 
   rtcbsite_desc LIKE type_t.chr500, 
   rtcb002 LIKE rtcb_t.rtcb002, 
   rtcb002_desc LIKE type_t.chr500, 
   rtcb003 LIKE rtcb_t.rtcb003, 
   rtcb003_desc LIKE type_t.chr500, 
   rtcb004 LIKE rtcb_t.rtcb004, 
   rtcb004_desc LIKE type_t.chr500, 
   rtcb005 LIKE rtcb_t.rtcb005, 
   rtcb006 LIKE rtcb_t.rtcb006, 
   rtcb007 LIKE rtcb_t.rtcb007, 
   rtcb008 LIKE rtcb_t.rtcb008, 
   rtcb009 LIKE rtcb_t.rtcb009, 
   rtcb010 LIKE rtcb_t.rtcb010, 
   rtcb011 LIKE rtcb_t.rtcb011, 
   rtcb012 LIKE rtcb_t.rtcb012, 
   rtcb013 LIKE rtcb_t.rtcb013, 
   rtcb014 LIKE rtcb_t.rtcb014, 
   rtcb015 LIKE rtcb_t.rtcb015, 
   rtcb016 LIKE rtcb_t.rtcb016, 
   rtcbstus LIKE rtcb_t.rtcbstus
       END RECORD
PRIVATE TYPE type_g_rtcb2_d RECORD
       rtcb001 LIKE rtcb_t.rtcb001, 
   rtcbsite LIKE rtcb_t.rtcbsite, 
   rtcbsite_2_desc LIKE type_t.chr500, 
   rtcb002 LIKE rtcb_t.rtcb002, 
   rtcb002_2_desc LIKE type_t.chr500, 
   rtcb003 LIKE rtcb_t.rtcb003, 
   rtcb003_2_desc LIKE type_t.chr500, 
   rtcb004 LIKE rtcb_t.rtcb004, 
   rtcb004_2_desc LIKE type_t.chr500, 
   rtcbownid LIKE rtcb_t.rtcbownid, 
   rtcbownid_desc LIKE type_t.chr500, 
   rtcbowndp LIKE rtcb_t.rtcbowndp, 
   rtcbowndp_desc LIKE type_t.chr500, 
   rtcbcrtid LIKE rtcb_t.rtcbcrtid, 
   rtcbcrtid_desc LIKE type_t.chr500, 
   rtcbcrtdp LIKE rtcb_t.rtcbcrtdp, 
   rtcbcrtdp_desc LIKE type_t.chr500, 
   rtcbcrtdt DATETIME YEAR TO SECOND, 
   rtcbmodid LIKE rtcb_t.rtcbmodid, 
   rtcbmodid_desc LIKE type_t.chr500, 
   rtcbmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtcb_d          DYNAMIC ARRAY OF type_g_rtcb_d #單身變數
DEFINE g_rtcb_d_t        type_g_rtcb_d                  #單身備份
DEFINE g_rtcb_d_o        type_g_rtcb_d                  #單身備份
DEFINE g_rtcb_d_mask_o   DYNAMIC ARRAY OF type_g_rtcb_d #單身變數
DEFINE g_rtcb_d_mask_n   DYNAMIC ARRAY OF type_g_rtcb_d #單身變數
DEFINE g_rtcb2_d   DYNAMIC ARRAY OF type_g_rtcb2_d
DEFINE g_rtcb2_d_t type_g_rtcb2_d
DEFINE g_rtcb2_d_o type_g_rtcb2_d
DEFINE g_rtcb2_d_mask_o DYNAMIC ARRAY OF type_g_rtcb2_d
DEFINE g_rtcb2_d_mask_n DYNAMIC ARRAY OF type_g_rtcb2_d
 
      
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
 
{<section id="arti902.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 
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
   LET g_forupd_sql = "SELECT rtcb001,rtcbsite,rtcb002,rtcb003,rtcb004,rtcb005,rtcb006,rtcb007,rtcb008, 
       rtcb009,rtcb010,rtcb011,rtcb012,rtcb013,rtcb014,rtcb015,rtcb016,rtcbstus,rtcb001,rtcbsite,rtcb002, 
       rtcb003,rtcb004,rtcbownid,rtcbowndp,rtcbcrtid,rtcbcrtdp,rtcbcrtdt,rtcbmodid,rtcbmoddt FROM rtcb_t  
       WHERE rtcbent=? AND rtcbsite=? AND rtcb001=? AND rtcb002=? AND rtcb003=? AND rtcb004=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti902_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti902 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti902_init()   
 
      #進入選單 Menu (="N")
      CALL arti902_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti902
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti902.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION arti902_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   LET g_errshow = 1   #150626-00010#3 20151106 add by beckxie
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
   CALL arti902_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="arti902.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION arti902_ui_dialog()
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
         CALL g_rtcb_d.clear()
         CALL g_rtcb2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL arti902_init()
      END IF
   
      CALL arti902_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtcb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_rtcb2_d[g_detail_idx].rtcbownid   #(ver:35)
               LET g_data_dept = g_rtcb2_d[g_detail_idx].rtcbowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti902_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtcb2_d TO s_detail2.*
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
   CALL arti902_set_pk_array()
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
            CALL cl_set_act_visible("reproduce",FALSE)
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL arti902_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti902_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL arti902_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti902_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL arti902_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti902_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti902_insert()
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
               CALL arti902_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_rtcb_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtcb2_d)
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
            CALL arti902_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti902_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti902_set_pk_array()
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
 
{<section id="arti902.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti902_query()
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
   CALL g_rtcb_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON rtcb001,rtcbsite,rtcb002,rtcb003,rtcb004,rtcb005,rtcb006,rtcb007,rtcb008,rtcb009, 
          rtcb010,rtcb011,rtcb012,rtcb013,rtcb014,rtcb015,rtcb016,rtcbstus,rtcbownid,rtcbowndp,rtcbcrtid, 
          rtcbcrtdp,rtcbcrtdt,rtcbmodid,rtcbmoddt 
 
         FROM s_detail1[1].rtcb001,s_detail1[1].rtcbsite,s_detail1[1].rtcb002,s_detail1[1].rtcb003,s_detail1[1].rtcb004, 
             s_detail1[1].rtcb005,s_detail1[1].rtcb006,s_detail1[1].rtcb007,s_detail1[1].rtcb008,s_detail1[1].rtcb009, 
             s_detail1[1].rtcb010,s_detail1[1].rtcb011,s_detail1[1].rtcb012,s_detail1[1].rtcb013,s_detail1[1].rtcb014, 
             s_detail1[1].rtcb015,s_detail1[1].rtcb016,s_detail1[1].rtcbstus,s_detail2[1].rtcbownid, 
             s_detail2[1].rtcbowndp,s_detail2[1].rtcbcrtid,s_detail2[1].rtcbcrtdp,s_detail2[1].rtcbcrtdt, 
             s_detail2[1].rtcbmodid,s_detail2[1].rtcbmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtcbcrtdt>>----
         AFTER FIELD rtcbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtcbmoddt>>----
         AFTER FIELD rtcbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtcbcnfdt>>----
         
         #----<<rtcbpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb001
            #add-point:BEFORE FIELD rtcb001 name="query.b.page1.rtcb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb001
            
            #add-point:AFTER FIELD rtcb001 name="query.a.page1.rtcb001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb001
            #add-point:ON ACTION controlp INFIELD rtcb001 name="query.c.page1.rtcb001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtcbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbsite
            #add-point:ON ACTION controlp INFIELD rtcbsite name="construct.c.page1.rtcbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtcbsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcbsite  #顯示到畫面上
            NEXT FIELD rtcbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbsite
            #add-point:BEFORE FIELD rtcbsite name="query.b.page1.rtcbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbsite
            
            #add-point:AFTER FIELD rtcbsite name="query.a.page1.rtcbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb002
            #add-point:ON ACTION controlp INFIELD rtcb002 name="construct.c.page1.rtcb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcb002  #顯示到畫面上
            NEXT FIELD rtcb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb002
            #add-point:BEFORE FIELD rtcb002 name="query.b.page1.rtcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb002
            
            #add-point:AFTER FIELD rtcb002 name="query.a.page1.rtcb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtcb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb003
            #add-point:ON ACTION controlp INFIELD rtcb003 name="construct.c.page1.rtcb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcb003  #顯示到畫面上
            NEXT FIELD rtcb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb003
            #add-point:BEFORE FIELD rtcb003 name="query.b.page1.rtcb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb003
            
            #add-point:AFTER FIELD rtcb003 name="query.a.page1.rtcb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtcb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb004
            #add-point:ON ACTION controlp INFIELD rtcb004 name="construct.c.page1.rtcb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcb004  #顯示到畫面上
            NEXT FIELD rtcb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb004
            #add-point:BEFORE FIELD rtcb004 name="query.b.page1.rtcb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb004
            
            #add-point:AFTER FIELD rtcb004 name="query.a.page1.rtcb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb005
            #add-point:BEFORE FIELD rtcb005 name="query.b.page1.rtcb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb005
            
            #add-point:AFTER FIELD rtcb005 name="query.a.page1.rtcb005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb005
            #add-point:ON ACTION controlp INFIELD rtcb005 name="query.c.page1.rtcb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb006
            #add-point:BEFORE FIELD rtcb006 name="query.b.page1.rtcb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb006
            
            #add-point:AFTER FIELD rtcb006 name="query.a.page1.rtcb006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb006
            #add-point:ON ACTION controlp INFIELD rtcb006 name="query.c.page1.rtcb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb007
            #add-point:BEFORE FIELD rtcb007 name="query.b.page1.rtcb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb007
            
            #add-point:AFTER FIELD rtcb007 name="query.a.page1.rtcb007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb007
            #add-point:ON ACTION controlp INFIELD rtcb007 name="query.c.page1.rtcb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb008
            #add-point:BEFORE FIELD rtcb008 name="query.b.page1.rtcb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb008
            
            #add-point:AFTER FIELD rtcb008 name="query.a.page1.rtcb008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb008
            #add-point:ON ACTION controlp INFIELD rtcb008 name="query.c.page1.rtcb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb009
            #add-point:BEFORE FIELD rtcb009 name="query.b.page1.rtcb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb009
            
            #add-point:AFTER FIELD rtcb009 name="query.a.page1.rtcb009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb009
            #add-point:ON ACTION controlp INFIELD rtcb009 name="query.c.page1.rtcb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb010
            #add-point:BEFORE FIELD rtcb010 name="query.b.page1.rtcb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb010
            
            #add-point:AFTER FIELD rtcb010 name="query.a.page1.rtcb010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb010
            #add-point:ON ACTION controlp INFIELD rtcb010 name="query.c.page1.rtcb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb011
            #add-point:BEFORE FIELD rtcb011 name="query.b.page1.rtcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb011
            
            #add-point:AFTER FIELD rtcb011 name="query.a.page1.rtcb011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb011
            #add-point:ON ACTION controlp INFIELD rtcb011 name="query.c.page1.rtcb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb012
            #add-point:BEFORE FIELD rtcb012 name="query.b.page1.rtcb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb012
            
            #add-point:AFTER FIELD rtcb012 name="query.a.page1.rtcb012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb012
            #add-point:ON ACTION controlp INFIELD rtcb012 name="query.c.page1.rtcb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb013
            #add-point:BEFORE FIELD rtcb013 name="query.b.page1.rtcb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb013
            
            #add-point:AFTER FIELD rtcb013 name="query.a.page1.rtcb013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb013
            #add-point:ON ACTION controlp INFIELD rtcb013 name="query.c.page1.rtcb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb014
            #add-point:BEFORE FIELD rtcb014 name="query.b.page1.rtcb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb014
            
            #add-point:AFTER FIELD rtcb014 name="query.a.page1.rtcb014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb014
            #add-point:ON ACTION controlp INFIELD rtcb014 name="query.c.page1.rtcb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb015
            #add-point:BEFORE FIELD rtcb015 name="query.b.page1.rtcb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb015
            
            #add-point:AFTER FIELD rtcb015 name="query.a.page1.rtcb015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb015
            #add-point:ON ACTION controlp INFIELD rtcb015 name="query.c.page1.rtcb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb016
            #add-point:BEFORE FIELD rtcb016 name="query.b.page1.rtcb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb016
            
            #add-point:AFTER FIELD rtcb016 name="query.a.page1.rtcb016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb016
            #add-point:ON ACTION controlp INFIELD rtcb016 name="query.c.page1.rtcb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbstus
            #add-point:BEFORE FIELD rtcbstus name="query.b.page1.rtcbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbstus
            
            #add-point:AFTER FIELD rtcbstus name="query.a.page1.rtcbstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtcbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbstus
            #add-point:ON ACTION controlp INFIELD rtcbstus name="query.c.page1.rtcbstus"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.rtcbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbownid
            #add-point:ON ACTION controlp INFIELD rtcbownid name="construct.c.page2.rtcbownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcbownid  #顯示到畫面上
            NEXT FIELD rtcbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbownid
            #add-point:BEFORE FIELD rtcbownid name="query.b.page2.rtcbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbownid
            
            #add-point:AFTER FIELD rtcbownid name="query.a.page2.rtcbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbowndp
            #add-point:ON ACTION controlp INFIELD rtcbowndp name="construct.c.page2.rtcbowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcbowndp  #顯示到畫面上
            NEXT FIELD rtcbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbowndp
            #add-point:BEFORE FIELD rtcbowndp name="query.b.page2.rtcbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbowndp
            
            #add-point:AFTER FIELD rtcbowndp name="query.a.page2.rtcbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbcrtid
            #add-point:ON ACTION controlp INFIELD rtcbcrtid name="construct.c.page2.rtcbcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcbcrtid  #顯示到畫面上
            NEXT FIELD rtcbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbcrtid
            #add-point:BEFORE FIELD rtcbcrtid name="query.b.page2.rtcbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbcrtid
            
            #add-point:AFTER FIELD rtcbcrtid name="query.a.page2.rtcbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtcbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbcrtdp
            #add-point:ON ACTION controlp INFIELD rtcbcrtdp name="construct.c.page2.rtcbcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcbcrtdp  #顯示到畫面上
            NEXT FIELD rtcbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbcrtdp
            #add-point:BEFORE FIELD rtcbcrtdp name="query.b.page2.rtcbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbcrtdp
            
            #add-point:AFTER FIELD rtcbcrtdp name="query.a.page2.rtcbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbcrtdt
            #add-point:BEFORE FIELD rtcbcrtdt name="query.b.page2.rtcbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtcbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbmodid
            #add-point:ON ACTION controlp INFIELD rtcbmodid name="construct.c.page2.rtcbmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtcbmodid  #顯示到畫面上
            NEXT FIELD rtcbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbmodid
            #add-point:BEFORE FIELD rtcbmodid name="query.b.page2.rtcbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbmodid
            
            #add-point:AFTER FIELD rtcbmodid name="query.a.page2.rtcbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbmoddt
            #add-point:BEFORE FIELD rtcbmoddt name="query.b.page2.rtcbmoddt"
            
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
    
   CALL arti902_b_fill(g_wc2)
   LET g_data_owner = g_rtcb2_d[g_detail_idx].rtcbownid   #(ver:35)
   LET g_data_dept = g_rtcb2_d[g_detail_idx].rtcbowndp   #(ver:35)
 
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
 
{<section id="arti902.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti902_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL arti902_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti902.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti902_modify()
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
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_errno               LIKE type_t.chr10 
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
      INPUT ARRAY g_rtcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtcb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL arti902_b_fill(g_wc2)
            LET g_detail_cnt = g_rtcb_d.getLength()
         
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
            DISPLAY g_rtcb_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtcb_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtcb_d[l_ac].rtcbsite IS NOT NULL
               AND g_rtcb_d[l_ac].rtcb001 IS NOT NULL
               AND g_rtcb_d[l_ac].rtcb002 IS NOT NULL
               AND g_rtcb_d[l_ac].rtcb003 IS NOT NULL
               AND g_rtcb_d[l_ac].rtcb004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtcb_d_t.* = g_rtcb_d[l_ac].*  #BACKUP
               LET g_rtcb_d_o.* = g_rtcb_d[l_ac].*  #BACKUP
               IF NOT arti902_lock_b("rtcb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti902_bcl INTO g_rtcb_d[l_ac].rtcb001,g_rtcb_d[l_ac].rtcbsite,g_rtcb_d[l_ac].rtcb002, 
                      g_rtcb_d[l_ac].rtcb003,g_rtcb_d[l_ac].rtcb004,g_rtcb_d[l_ac].rtcb005,g_rtcb_d[l_ac].rtcb006, 
                      g_rtcb_d[l_ac].rtcb007,g_rtcb_d[l_ac].rtcb008,g_rtcb_d[l_ac].rtcb009,g_rtcb_d[l_ac].rtcb010, 
                      g_rtcb_d[l_ac].rtcb011,g_rtcb_d[l_ac].rtcb012,g_rtcb_d[l_ac].rtcb013,g_rtcb_d[l_ac].rtcb014, 
                      g_rtcb_d[l_ac].rtcb015,g_rtcb_d[l_ac].rtcb016,g_rtcb_d[l_ac].rtcbstus,g_rtcb2_d[l_ac].rtcb001, 
                      g_rtcb2_d[l_ac].rtcbsite,g_rtcb2_d[l_ac].rtcb002,g_rtcb2_d[l_ac].rtcb003,g_rtcb2_d[l_ac].rtcb004, 
                      g_rtcb2_d[l_ac].rtcbownid,g_rtcb2_d[l_ac].rtcbowndp,g_rtcb2_d[l_ac].rtcbcrtid, 
                      g_rtcb2_d[l_ac].rtcbcrtdp,g_rtcb2_d[l_ac].rtcbcrtdt,g_rtcb2_d[l_ac].rtcbmodid, 
                      g_rtcb2_d[l_ac].rtcbmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtcb_d_t.rtcbsite,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtcb_d_mask_o[l_ac].* =  g_rtcb_d[l_ac].*
                  CALL arti902_rtcb_t_mask()
                  LET g_rtcb_d_mask_n[l_ac].* =  g_rtcb_d[l_ac].*
                  
                  CALL arti902_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti902_set_entry_b(l_cmd)
            CALL arti902_set_no_entry_b(l_cmd)
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
            INITIALIZE g_rtcb_d_t.* TO NULL
            INITIALIZE g_rtcb_d_o.* TO NULL
            INITIALIZE g_rtcb_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtcb2_d[l_ac].rtcbownid = g_user
      LET g_rtcb2_d[l_ac].rtcbowndp = g_dept
      LET g_rtcb2_d[l_ac].rtcbcrtid = g_user
      LET g_rtcb2_d[l_ac].rtcbcrtdp = g_dept 
      LET g_rtcb2_d[l_ac].rtcbcrtdt = cl_get_current()
      LET g_rtcb2_d[l_ac].rtcbmodid = g_user
      LET g_rtcb2_d[l_ac].rtcbmoddt = cl_get_current()
      LET g_rtcb_d[l_ac].rtcbstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_rtcb_d[l_ac].rtcb005 = "0"
      LET g_rtcb_d[l_ac].rtcb006 = "0"
      LET g_rtcb_d[l_ac].rtcb007 = "0"
      LET g_rtcb_d[l_ac].rtcb008 = "0"
      LET g_rtcb_d[l_ac].rtcb009 = "0"
      LET g_rtcb_d[l_ac].rtcb010 = "0"
      LET g_rtcb_d[l_ac].rtcb011 = "0"
      LET g_rtcb_d[l_ac].rtcb012 = "0"
      LET g_rtcb_d[l_ac].rtcb013 = "0"
      LET g_rtcb_d[l_ac].rtcb014 = "0"
      LET g_rtcb_d[l_ac].rtcb015 = "0"
      LET g_rtcb_d[l_ac].rtcb016 = "0"
      LET g_rtcb_d[l_ac].rtcbstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_rtcb_d_t.* = g_rtcb_d[l_ac].*     #新輸入資料
            LET g_rtcb_d_o.* = g_rtcb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtcb_d[li_reproduce_target].* = g_rtcb_d[li_reproduce].*
               LET g_rtcb2_d[li_reproduce_target].* = g_rtcb2_d[li_reproduce].*
 
               LET g_rtcb_d[g_rtcb_d.getLength()].rtcbsite = NULL
               LET g_rtcb_d[g_rtcb_d.getLength()].rtcb001 = NULL
               LET g_rtcb_d[g_rtcb_d.getLength()].rtcb002 = NULL
               LET g_rtcb_d[g_rtcb_d.getLength()].rtcb003 = NULL
               LET g_rtcb_d[g_rtcb_d.getLength()].rtcb004 = NULL
 
            END IF
            
 
 
            CALL arti902_set_entry_b(l_cmd)
            CALL arti902_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM rtcb_t 
             WHERE rtcbent = g_enterprise AND rtcbsite = g_rtcb_d[l_ac].rtcbsite
                                       AND rtcb001 = g_rtcb_d[l_ac].rtcb001
                                       AND rtcb002 = g_rtcb_d[l_ac].rtcb002
                                       AND rtcb003 = g_rtcb_d[l_ac].rtcb003
                                       AND rtcb004 = g_rtcb_d[l_ac].rtcb004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcb_d[g_detail_idx].rtcbsite
               LET gs_keys[2] = g_rtcb_d[g_detail_idx].rtcb001
               LET gs_keys[3] = g_rtcb_d[g_detail_idx].rtcb002
               LET gs_keys[4] = g_rtcb_d[g_detail_idx].rtcb003
               LET gs_keys[5] = g_rtcb_d[g_detail_idx].rtcb004
               CALL arti902_insert_b('rtcb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtcb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtcb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti902_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (rtcbsite = '", g_rtcb_d[l_ac].rtcbsite, "' "
                                  ," AND rtcb001 = '", g_rtcb_d[l_ac].rtcb001, "' "
                                  ," AND rtcb002 = '", g_rtcb_d[l_ac].rtcb002, "' "
                                  ," AND rtcb003 = '", g_rtcb_d[l_ac].rtcb003, "' "
                                  ," AND rtcb004 = '", g_rtcb_d[l_ac].rtcb004, "' "
 
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
               
               DELETE FROM rtcb_t
                WHERE rtcbent = g_enterprise AND 
                      rtcbsite = g_rtcb_d_t.rtcbsite
                      AND rtcb001 = g_rtcb_d_t.rtcb001
                      AND rtcb002 = g_rtcb_d_t.rtcb002
                      AND rtcb003 = g_rtcb_d_t.rtcb003
                      AND rtcb004 = g_rtcb_d_t.rtcb004
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtcb_t:",SQLERRMESSAGE 
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
                  CALL arti902_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_rtcb_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE arti902_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_rtcb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcb_d_t.rtcbsite
               LET gs_keys[2] = g_rtcb_d_t.rtcb001
               LET gs_keys[3] = g_rtcb_d_t.rtcb002
               LET gs_keys[4] = g_rtcb_d_t.rtcb003
               LET gs_keys[5] = g_rtcb_d_t.rtcb004
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti902_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL arti902_delete_b('rtcb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtcb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb001
            #add-point:BEFORE FIELD rtcb001 name="input.b.page1.rtcb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb001
            
            #add-point:AFTER FIELD rtcb001 name="input.a.page1.rtcb001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtcb_d[g_detail_idx].rtcbsite IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb001 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb002 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb003 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcb_d[g_detail_idx].rtcbsite != g_rtcb_d_t.rtcbsite OR g_rtcb_d[g_detail_idx].rtcb001 != g_rtcb_d_t.rtcb001 OR g_rtcb_d[g_detail_idx].rtcb002 != g_rtcb_d_t.rtcb002 OR g_rtcb_d[g_detail_idx].rtcb003 != g_rtcb_d_t.rtcb003 OR g_rtcb_d[g_detail_idx].rtcb004 != g_rtcb_d_t.rtcb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcb_t WHERE "||"rtcbent = '" ||g_enterprise|| "' AND "||"rtcbsite = '"||g_rtcb_d[g_detail_idx].rtcbsite ||"' AND "|| "rtcb001 = '"||g_rtcb_d[g_detail_idx].rtcb001 ||"' AND "|| "rtcb002 = '"||g_rtcb_d[g_detail_idx].rtcb002 ||"' AND "|| "rtcb003 = '"||g_rtcb_d[g_detail_idx].rtcb003 ||"' AND "|| "rtcb004 = '"||g_rtcb_d[g_detail_idx].rtcb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_rtcb_d[g_detail_idx].rtcb001) THEN
               IF g_rtcb_d[g_detail_idx].rtcb001 > 2100 OR g_rtcb_d[g_detail_idx].rtcb001 < 2000 THEN
                  LET g_rtcb_d[g_detail_idx].rtcb001 = g_rtcb_d_o.rtcb001
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00018'
                  LET g_errparam.extend = g_rtcb_d[g_detail_idx].rtcb001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               LET g_rtcb_d_o.rtcb001=g_rtcb_d[g_detail_idx].rtcb001
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb001
            #add-point:ON CHANGE rtcb001 name="input.g.page1.rtcb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbsite
            
            #add-point:AFTER FIELD rtcbsite name="input.a.page1.rtcbsite"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtcb_d[g_detail_idx].rtcbsite IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb001 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb002 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb003 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcb_d[g_detail_idx].rtcbsite != g_rtcb_d_t.rtcbsite OR g_rtcb_d[g_detail_idx].rtcb001 != g_rtcb_d_t.rtcb001 OR g_rtcb_d[g_detail_idx].rtcb002 != g_rtcb_d_t.rtcb002 OR g_rtcb_d[g_detail_idx].rtcb003 != g_rtcb_d_t.rtcb003 OR g_rtcb_d[g_detail_idx].rtcb004 != g_rtcb_d_t.rtcb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcb_t WHERE "||"rtcbent = '" ||g_enterprise|| "' AND "||"rtcbsite = '"||g_rtcb_d[g_detail_idx].rtcbsite ||"' AND "|| "rtcb001 = '"||g_rtcb_d[g_detail_idx].rtcb001 ||"' AND "|| "rtcb002 = '"||g_rtcb_d[g_detail_idx].rtcb002 ||"' AND "|| "rtcb003 = '"||g_rtcb_d[g_detail_idx].rtcb003 ||"' AND "|| "rtcb004 = '"||g_rtcb_d[g_detail_idx].rtcb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_rtcb_d[l_ac].rtcbsite) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtcb_d[l_ac].rtcbsite

                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_null(g_rtcb_d[l_ac].rtcbsite) THEN
                  IF g_rtcb_d[l_ac].rtcbsite != g_rtcb_d_o.rtcbsite OR cl_null(g_rtcb_d_o.rtcbsite) THEN
                     CALL s_aooi500_chk(g_prog,'rtcbsite',g_rtcb_d[l_ac].rtcbsite,g_rtcb_d[l_ac].rtcbsite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        LET g_rtcb_d[l_ac].rtcbsite = g_rtcb_d_o.rtcbsite
                        CALL s_desc_get_department_desc(g_rtcb_d[l_ac].rtcbsite) RETURNING g_rtcb_d[l_ac].rtcbsite_desc
                        DISPLAY BY NAME g_rtcb_d[l_ac].rtcbsite_desc
                        NEXT FIELD CURRENT
                     END IF
                     LET g_rtcb_d_o.rtcbsite = g_rtcb_d[l_ac].rtcbsite
                  END IF
               END IF


            END IF 
            CALL arti902_rtcbsite_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbsite
            #add-point:BEFORE FIELD rtcbsite name="input.b.page1.rtcbsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcbsite
            #add-point:ON CHANGE rtcbsite name="input.g.page1.rtcbsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb002
            
            #add-point:AFTER FIELD rtcb002 name="input.a.page1.rtcb002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtcb_d[g_detail_idx].rtcbsite IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb001 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb002 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb003 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcb_d[g_detail_idx].rtcbsite != g_rtcb_d_t.rtcbsite OR g_rtcb_d[g_detail_idx].rtcb001 != g_rtcb_d_t.rtcb001 OR g_rtcb_d[g_detail_idx].rtcb002 != g_rtcb_d_t.rtcb002 OR g_rtcb_d[g_detail_idx].rtcb003 != g_rtcb_d_t.rtcb003 OR g_rtcb_d[g_detail_idx].rtcb004 != g_rtcb_d_t.rtcb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcb_t WHERE "||"rtcbent = '" ||g_enterprise|| "' AND "||"rtcbsite = '"||g_rtcb_d[g_detail_idx].rtcbsite ||"' AND "|| "rtcb001 = '"||g_rtcb_d[g_detail_idx].rtcb001 ||"' AND "|| "rtcb002 = '"||g_rtcb_d[g_detail_idx].rtcb002 ||"' AND "|| "rtcb003 = '"||g_rtcb_d[g_detail_idx].rtcb003 ||"' AND "|| "rtcb004 = '"||g_rtcb_d[g_detail_idx].rtcb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_rtcb_d[l_ac].rtcb002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtcb_d[l_ac].rtcb002
               LET g_chkparam.arg2 = g_today
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_2") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 

            CALL arti902_rtcb002_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb002
            #add-point:BEFORE FIELD rtcb002 name="input.b.page1.rtcb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb002
            #add-point:ON CHANGE rtcb002 name="input.g.page1.rtcb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb003
            
            #add-point:AFTER FIELD rtcb003 name="input.a.page1.rtcb003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtcb_d[g_detail_idx].rtcbsite IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb001 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb002 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb003 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcb_d[g_detail_idx].rtcbsite != g_rtcb_d_t.rtcbsite OR g_rtcb_d[g_detail_idx].rtcb001 != g_rtcb_d_t.rtcb001 OR g_rtcb_d[g_detail_idx].rtcb002 != g_rtcb_d_t.rtcb002 OR g_rtcb_d[g_detail_idx].rtcb003 != g_rtcb_d_t.rtcb003 OR g_rtcb_d[g_detail_idx].rtcb004 != g_rtcb_d_t.rtcb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcb_t WHERE "||"rtcbent = '" ||g_enterprise|| "' AND "||"rtcbsite = '"||g_rtcb_d[g_detail_idx].rtcbsite ||"' AND "|| "rtcb001 = '"||g_rtcb_d[g_detail_idx].rtcb001 ||"' AND "|| "rtcb002 = '"||g_rtcb_d[g_detail_idx].rtcb002 ||"' AND "|| "rtcb003 = '"||g_rtcb_d[g_detail_idx].rtcb003 ||"' AND "|| "rtcb004 = '"||g_rtcb_d[g_detail_idx].rtcb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_rtcb_d[l_ac].rtcb003) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtcb_d[l_ac].rtcb003
               LET g_chkparam.arg2 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
               #160318-00025#47  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
               #160318-00025#47  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_2") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 

            CALL arti902_rtcb003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb003
            #add-point:BEFORE FIELD rtcb003 name="input.b.page1.rtcb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb003
            #add-point:ON CHANGE rtcb003 name="input.g.page1.rtcb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb004
            
            #add-point:AFTER FIELD rtcb004 name="input.a.page1.rtcb004"
            #確認資料無重複
            IF  g_rtcb_d[g_detail_idx].rtcbsite IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb001 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb002 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb003 IS NOT NULL AND g_rtcb_d[g_detail_idx].rtcb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtcb_d[g_detail_idx].rtcbsite != g_rtcb_d_t.rtcbsite OR g_rtcb_d[g_detail_idx].rtcb001 != g_rtcb_d_t.rtcb001 OR g_rtcb_d[g_detail_idx].rtcb002 != g_rtcb_d_t.rtcb002 OR g_rtcb_d[g_detail_idx].rtcb003 != g_rtcb_d_t.rtcb003 OR g_rtcb_d[g_detail_idx].rtcb004 != g_rtcb_d_t.rtcb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtcb_t WHERE "||"rtcbent = '" ||g_enterprise|| "' AND "||"rtcbsite = '"||g_rtcb_d[g_detail_idx].rtcbsite ||"' AND "|| "rtcb001 = '"||g_rtcb_d[g_detail_idx].rtcb001 ||"' AND "|| "rtcb002 = '"||g_rtcb_d[g_detail_idx].rtcb002 ||"' AND "|| "rtcb003 = '"||g_rtcb_d[g_detail_idx].rtcb003 ||"' AND "|| "rtcb004 = '"||g_rtcb_d[g_detail_idx].rtcb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtcb_d[l_ac].rtcb004

               #160318-00025#47  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "art-00050:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#47  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtca001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 

            CALL arti902_rtcb004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb004
            #add-point:BEFORE FIELD rtcb004 name="input.b.page1.rtcb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb004
            #add-point:ON CHANGE rtcb004 name="input.g.page1.rtcb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb005
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb005 name="input.a.page1.rtcb005"
            IF (NOT cl_null(g_rtcb_d[l_ac].rtcb005)) AND g_rtcb_d[l_ac].rtcb005<>0
                AND g_rtcb_d[l_ac].rtcb006=0 AND g_rtcb_d[l_ac].rtcb007=0
                AND g_rtcb_d[l_ac].rtcb008=0 AND g_rtcb_d[l_ac].rtcb009=0
                AND g_rtcb_d[l_ac].rtcb010=0 AND g_rtcb_d[l_ac].rtcb011=0
                AND g_rtcb_d[l_ac].rtcb012=0 AND g_rtcb_d[l_ac].rtcb013=0
                AND g_rtcb_d[l_ac].rtcb014=0 AND g_rtcb_d[l_ac].rtcb015=0 
                AND g_rtcb_d[l_ac].rtcb016=0 THEN 
                
                
               IF cl_ask_confirm('art-00663') THEN
                  LET g_rtcb_d[l_ac].rtcb006=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb007=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb008=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb009=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb010=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb011=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb012=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb013=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb014=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb015=g_rtcb_d[l_ac].rtcb005
                  LET g_rtcb_d[l_ac].rtcb016=g_rtcb_d[l_ac].rtcb005
               END IF
               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb005
            #add-point:BEFORE FIELD rtcb005 name="input.b.page1.rtcb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb005
            #add-point:ON CHANGE rtcb005 name="input.g.page1.rtcb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb006
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb006 name="input.a.page1.rtcb006"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb006
            #add-point:BEFORE FIELD rtcb006 name="input.b.page1.rtcb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb006
            #add-point:ON CHANGE rtcb006 name="input.g.page1.rtcb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb007
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb007 name="input.a.page1.rtcb007"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb007
            #add-point:BEFORE FIELD rtcb007 name="input.b.page1.rtcb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb007
            #add-point:ON CHANGE rtcb007 name="input.g.page1.rtcb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb008
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb008 name="input.a.page1.rtcb008"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb008
            #add-point:BEFORE FIELD rtcb008 name="input.b.page1.rtcb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb008
            #add-point:ON CHANGE rtcb008 name="input.g.page1.rtcb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb009
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb009 name="input.a.page1.rtcb009"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb009
            #add-point:BEFORE FIELD rtcb009 name="input.b.page1.rtcb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb009
            #add-point:ON CHANGE rtcb009 name="input.g.page1.rtcb009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb010
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb010 name="input.a.page1.rtcb010"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb010
            #add-point:BEFORE FIELD rtcb010 name="input.b.page1.rtcb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb010
            #add-point:ON CHANGE rtcb010 name="input.g.page1.rtcb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb011
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb011 name="input.a.page1.rtcb011"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb011
            #add-point:BEFORE FIELD rtcb011 name="input.b.page1.rtcb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb011
            #add-point:ON CHANGE rtcb011 name="input.g.page1.rtcb011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb012
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb012 name="input.a.page1.rtcb012"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb012
            #add-point:BEFORE FIELD rtcb012 name="input.b.page1.rtcb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb012
            #add-point:ON CHANGE rtcb012 name="input.g.page1.rtcb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb013
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb013 name="input.a.page1.rtcb013"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb013) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb013
            #add-point:BEFORE FIELD rtcb013 name="input.b.page1.rtcb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb013
            #add-point:ON CHANGE rtcb013 name="input.g.page1.rtcb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb014
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb014 name="input.a.page1.rtcb014"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb014
            #add-point:BEFORE FIELD rtcb014 name="input.b.page1.rtcb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb014
            #add-point:ON CHANGE rtcb014 name="input.g.page1.rtcb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb015,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb015
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb015 name="input.a.page1.rtcb015"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb015
            #add-point:BEFORE FIELD rtcb015 name="input.b.page1.rtcb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb015
            #add-point:ON CHANGE rtcb015 name="input.g.page1.rtcb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcb016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtcb_d[l_ac].rtcb016,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtcb016
            END IF 
 
 
 
            #add-point:AFTER FIELD rtcb016 name="input.a.page1.rtcb016"
            IF NOT cl_null(g_rtcb_d[l_ac].rtcb016) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcb016
            #add-point:BEFORE FIELD rtcb016 name="input.b.page1.rtcb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcb016
            #add-point:ON CHANGE rtcb016 name="input.g.page1.rtcb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtcbstus
            #add-point:BEFORE FIELD rtcbstus name="input.b.page1.rtcbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtcbstus
            
            #add-point:AFTER FIELD rtcbstus name="input.a.page1.rtcbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtcbstus
            #add-point:ON CHANGE rtcbstus name="input.g.page1.rtcbstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtcb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb001
            #add-point:ON ACTION controlp INFIELD rtcb001 name="input.c.page1.rtcb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbsite
            #add-point:ON ACTION controlp INFIELD rtcbsite name="input.c.page1.rtcbsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtcb_d[l_ac].rtcbsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtcbsite',g_site,'c')
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtcb_d[l_ac].rtcbsite = g_qryparam.return1              

            DISPLAY g_rtcb_d[l_ac].rtcbsite TO rtcbsite              #
            CALL arti902_rtcbsite_ref()
            NEXT FIELD rtcbsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb002
            #add-point:ON ACTION controlp INFIELD rtcb002 name="input.c.page1.rtcb002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtcb_d[l_ac].rtcb002             #給予default值
            LET g_qryparam.default2 = "" #g_rtcb_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today #s


            CALL q_ooeg001()                                #呼叫開窗

            LET g_rtcb_d[l_ac].rtcb002 = g_qryparam.return1              
            #LET g_rtcb_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_rtcb_d[l_ac].rtcb002 TO rtcb002              #
            #DISPLAY g_rtcb_d[l_ac].ooeg001 TO ooeg001 #部門編號
            CALL arti902_rtcb002_ref()
            NEXT FIELD rtcb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb003
            #add-point:ON ACTION controlp INFIELD rtcb003 name="input.c.page1.rtcb003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtcb_d[l_ac].rtcb003             #給予default值

            #給予arg
            
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001') #s


            CALL q_rtax001_3()                                #呼叫開窗

            LET g_rtcb_d[l_ac].rtcb003 = g_qryparam.return1              

            DISPLAY g_rtcb_d[l_ac].rtcb003 TO rtcb003              #
            CALL arti902_rtcb003_ref()
            NEXT FIELD rtcb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb004
            #add-point:ON ACTION controlp INFIELD rtcb004 name="input.c.page1.rtcb004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtcb_d[l_ac].rtcb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rtca001()                                #呼叫開窗

            LET g_rtcb_d[l_ac].rtcb004 = g_qryparam.return1              

            DISPLAY g_rtcb_d[l_ac].rtcb004 TO rtcb004              #
            CALL arti902_rtcb004_ref()
            NEXT FIELD rtcb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb005
            #add-point:ON ACTION controlp INFIELD rtcb005 name="input.c.page1.rtcb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb006
            #add-point:ON ACTION controlp INFIELD rtcb006 name="input.c.page1.rtcb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb007
            #add-point:ON ACTION controlp INFIELD rtcb007 name="input.c.page1.rtcb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb008
            #add-point:ON ACTION controlp INFIELD rtcb008 name="input.c.page1.rtcb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb009
            #add-point:ON ACTION controlp INFIELD rtcb009 name="input.c.page1.rtcb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb010
            #add-point:ON ACTION controlp INFIELD rtcb010 name="input.c.page1.rtcb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb011
            #add-point:ON ACTION controlp INFIELD rtcb011 name="input.c.page1.rtcb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb012
            #add-point:ON ACTION controlp INFIELD rtcb012 name="input.c.page1.rtcb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb013
            #add-point:ON ACTION controlp INFIELD rtcb013 name="input.c.page1.rtcb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb014
            #add-point:ON ACTION controlp INFIELD rtcb014 name="input.c.page1.rtcb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb015
            #add-point:ON ACTION controlp INFIELD rtcb015 name="input.c.page1.rtcb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcb016
            #add-point:ON ACTION controlp INFIELD rtcb016 name="input.c.page1.rtcb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtcbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtcbstus
            #add-point:ON ACTION controlp INFIELD rtcbstus name="input.c.page1.rtcbstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE arti902_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_rtcb_d[l_ac].* = g_rtcb_d_t.*
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
               LET g_errparam.extend = g_rtcb_d[l_ac].rtcbsite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtcb_d[l_ac].* = g_rtcb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtcb2_d[l_ac].rtcbmodid = g_user 
LET g_rtcb2_d[l_ac].rtcbmoddt = cl_get_current()
LET g_rtcb2_d[l_ac].rtcbmodid_desc = cl_get_username(g_rtcb2_d[l_ac].rtcbmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti902_rtcb_t_mask_restore('restore_mask_o')
 
               UPDATE rtcb_t SET (rtcb001,rtcbsite,rtcb002,rtcb003,rtcb004,rtcb005,rtcb006,rtcb007,rtcb008, 
                   rtcb009,rtcb010,rtcb011,rtcb012,rtcb013,rtcb014,rtcb015,rtcb016,rtcbstus,rtcbownid, 
                   rtcbowndp,rtcbcrtid,rtcbcrtdp,rtcbcrtdt,rtcbmodid,rtcbmoddt) = (g_rtcb_d[l_ac].rtcb001, 
                   g_rtcb_d[l_ac].rtcbsite,g_rtcb_d[l_ac].rtcb002,g_rtcb_d[l_ac].rtcb003,g_rtcb_d[l_ac].rtcb004, 
                   g_rtcb_d[l_ac].rtcb005,g_rtcb_d[l_ac].rtcb006,g_rtcb_d[l_ac].rtcb007,g_rtcb_d[l_ac].rtcb008, 
                   g_rtcb_d[l_ac].rtcb009,g_rtcb_d[l_ac].rtcb010,g_rtcb_d[l_ac].rtcb011,g_rtcb_d[l_ac].rtcb012, 
                   g_rtcb_d[l_ac].rtcb013,g_rtcb_d[l_ac].rtcb014,g_rtcb_d[l_ac].rtcb015,g_rtcb_d[l_ac].rtcb016, 
                   g_rtcb_d[l_ac].rtcbstus,g_rtcb2_d[l_ac].rtcbownid,g_rtcb2_d[l_ac].rtcbowndp,g_rtcb2_d[l_ac].rtcbcrtid, 
                   g_rtcb2_d[l_ac].rtcbcrtdp,g_rtcb2_d[l_ac].rtcbcrtdt,g_rtcb2_d[l_ac].rtcbmodid,g_rtcb2_d[l_ac].rtcbmoddt) 
 
                WHERE rtcbent = g_enterprise AND
                  rtcbsite = g_rtcb_d_t.rtcbsite #項次   
                  AND rtcb001 = g_rtcb_d_t.rtcb001  
                  AND rtcb002 = g_rtcb_d_t.rtcb002  
                  AND rtcb003 = g_rtcb_d_t.rtcb003  
                  AND rtcb004 = g_rtcb_d_t.rtcb004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtcb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtcb_d[g_detail_idx].rtcbsite
               LET gs_keys_bak[1] = g_rtcb_d_t.rtcbsite
               LET gs_keys[2] = g_rtcb_d[g_detail_idx].rtcb001
               LET gs_keys_bak[2] = g_rtcb_d_t.rtcb001
               LET gs_keys[3] = g_rtcb_d[g_detail_idx].rtcb002
               LET gs_keys_bak[3] = g_rtcb_d_t.rtcb002
               LET gs_keys[4] = g_rtcb_d[g_detail_idx].rtcb003
               LET gs_keys_bak[4] = g_rtcb_d_t.rtcb003
               LET gs_keys[5] = g_rtcb_d[g_detail_idx].rtcb004
               LET gs_keys_bak[5] = g_rtcb_d_t.rtcb004
               CALL arti902_update_b('rtcb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtcb_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtcb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL arti902_rtcb_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti902_unlock_b("rtcb_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtcb_d[l_ac].* = g_rtcb_d_t.*
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
               LET g_rtcb_d[li_reproduce_target].* = g_rtcb_d[li_reproduce].*
               LET g_rtcb2_d[li_reproduce_target].* = g_rtcb2_d[li_reproduce].*
 
               LET g_rtcb_d[li_reproduce_target].rtcbsite = NULL
               LET g_rtcb_d[li_reproduce_target].rtcb001 = NULL
               LET g_rtcb_d[li_reproduce_target].rtcb002 = NULL
               LET g_rtcb_d[li_reproduce_target].rtcb003 = NULL
               LET g_rtcb_d[li_reproduce_target].rtcb004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtcb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtcb_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_rtcb2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL arti902_b_fill(g_wc2)
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
               NEXT FIELD rtcb001
            WHEN "s_detail2"
               NEXT FIELD rtcb001_2
 
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
      IF INT_FLAG OR cl_null(g_rtcb_d[g_detail_idx].rtcbsite) THEN
         CALL g_rtcb_d.deleteElement(g_detail_idx)
         CALL g_rtcb2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_rtcb_d[g_detail_idx].* = g_rtcb_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE arti902_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="arti902.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti902_delete()
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
   FOR li_idx = 1 TO g_rtcb_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT arti902_lock_b("rtcb_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("rtcb_t","rtcbownid") THEN
            LET g_data_owner = g_rtcb2_d[g_detail_idx].rtcbownid
            LET g_data_dept = g_rtcb2_d[g_detail_idx].rtcbowndp
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
   
   FOR li_idx = 1 TO g_rtcb_d.getLength()
      IF g_rtcb_d[li_idx].rtcbsite IS NOT NULL
         AND g_rtcb_d[li_idx].rtcb001 IS NOT NULL
         AND g_rtcb_d[li_idx].rtcb002 IS NOT NULL
         AND g_rtcb_d[li_idx].rtcb003 IS NOT NULL
         AND g_rtcb_d[li_idx].rtcb004 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM rtcb_t
          WHERE rtcbent = g_enterprise AND 
                rtcbsite = g_rtcb_d[li_idx].rtcbsite
                AND rtcb001 = g_rtcb_d[li_idx].rtcb001
                AND rtcb002 = g_rtcb_d[li_idx].rtcb002
                AND rtcb003 = g_rtcb_d[li_idx].rtcb003
                AND rtcb004 = g_rtcb_d[li_idx].rtcb004
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtcb_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_rtcb_d_t.rtcbsite
               LET gs_keys[2] = g_rtcb_d_t.rtcb001
               LET gs_keys[3] = g_rtcb_d_t.rtcb002
               LET gs_keys[4] = g_rtcb_d_t.rtcb003
               LET gs_keys[5] = g_rtcb_d_t.rtcb004
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL arti902_delete_b('rtcb_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti902_set_pk_array()
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
   CALL arti902_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="arti902.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti902_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtcbsite') RETURNING l_where
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.rtcb001,t0.rtcbsite,t0.rtcb002,t0.rtcb003,t0.rtcb004,t0.rtcb005, 
       t0.rtcb006,t0.rtcb007,t0.rtcb008,t0.rtcb009,t0.rtcb010,t0.rtcb011,t0.rtcb012,t0.rtcb013,t0.rtcb014, 
       t0.rtcb015,t0.rtcb016,t0.rtcbstus,t0.rtcb001,t0.rtcbsite,t0.rtcb002,t0.rtcb003,t0.rtcb004,t0.rtcbownid, 
       t0.rtcbowndp,t0.rtcbcrtid,t0.rtcbcrtdp,t0.rtcbcrtdt,t0.rtcbmodid,t0.rtcbmoddt ,t1.ooefl003 ,t2.ooefl003 , 
       t3.rtaxl003 ,t4.rtcal003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 FROM rtcb_t t0", 
 
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtcbsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rtcb002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.rtcb003 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN rtcal_t t4 ON t4.rtcalent="||g_enterprise||" AND t4.rtcal001=t0.rtcb004 AND t4.rtcal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.rtcbownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.rtcbowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.rtcbcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.rtcbcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rtcbmodid  ",
 
               " WHERE t0.rtcbent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("rtcb_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND rtcbowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("rtcb_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND rtcbownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = g_sql," AND ", l_where
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtcb_t"),
                      " ORDER BY t0.rtcbsite,t0.rtcb001,t0.rtcb002,t0.rtcb003,t0.rtcb004"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtcb_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti902_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR arti902_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtcb_d.clear()
   CALL g_rtcb2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtcb_d[l_ac].rtcb001,g_rtcb_d[l_ac].rtcbsite,g_rtcb_d[l_ac].rtcb002,g_rtcb_d[l_ac].rtcb003, 
       g_rtcb_d[l_ac].rtcb004,g_rtcb_d[l_ac].rtcb005,g_rtcb_d[l_ac].rtcb006,g_rtcb_d[l_ac].rtcb007,g_rtcb_d[l_ac].rtcb008, 
       g_rtcb_d[l_ac].rtcb009,g_rtcb_d[l_ac].rtcb010,g_rtcb_d[l_ac].rtcb011,g_rtcb_d[l_ac].rtcb012,g_rtcb_d[l_ac].rtcb013, 
       g_rtcb_d[l_ac].rtcb014,g_rtcb_d[l_ac].rtcb015,g_rtcb_d[l_ac].rtcb016,g_rtcb_d[l_ac].rtcbstus, 
       g_rtcb2_d[l_ac].rtcb001,g_rtcb2_d[l_ac].rtcbsite,g_rtcb2_d[l_ac].rtcb002,g_rtcb2_d[l_ac].rtcb003, 
       g_rtcb2_d[l_ac].rtcb004,g_rtcb2_d[l_ac].rtcbownid,g_rtcb2_d[l_ac].rtcbowndp,g_rtcb2_d[l_ac].rtcbcrtid, 
       g_rtcb2_d[l_ac].rtcbcrtdp,g_rtcb2_d[l_ac].rtcbcrtdt,g_rtcb2_d[l_ac].rtcbmodid,g_rtcb2_d[l_ac].rtcbmoddt, 
       g_rtcb_d[l_ac].rtcbsite_desc,g_rtcb_d[l_ac].rtcb002_desc,g_rtcb_d[l_ac].rtcb003_desc,g_rtcb_d[l_ac].rtcb004_desc, 
       g_rtcb2_d[l_ac].rtcbownid_desc,g_rtcb2_d[l_ac].rtcbowndp_desc,g_rtcb2_d[l_ac].rtcbcrtid_desc, 
       g_rtcb2_d[l_ac].rtcbcrtdp_desc,g_rtcb2_d[l_ac].rtcbmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL arti902_rtcbsite_ref()
      CALL arti902_rtcb002_ref()
      CALL arti902_rtcb003_ref()
      CALL arti902_rtcb004_ref()
      #end add-point
      
      CALL arti902_detail_show()      
 
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
   
 
   
   CALL g_rtcb_d.deleteElement(g_rtcb_d.getLength())   
   CALL g_rtcb2_d.deleteElement(g_rtcb2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtcb_d.getLength()
      LET g_rtcb2_d[l_ac].rtcbsite = g_rtcb_d[l_ac].rtcbsite 
      LET g_rtcb2_d[l_ac].rtcb001 = g_rtcb_d[l_ac].rtcb001 
      LET g_rtcb2_d[l_ac].rtcb002 = g_rtcb_d[l_ac].rtcb002 
      LET g_rtcb2_d[l_ac].rtcb003 = g_rtcb_d[l_ac].rtcb003 
      LET g_rtcb2_d[l_ac].rtcb004 = g_rtcb_d[l_ac].rtcb004 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_rtcb_d.getLength() THEN
      LET l_ac = g_rtcb_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtcb_d.getLength()
      LET g_rtcb_d_mask_o[l_ac].* =  g_rtcb_d[l_ac].*
      CALL arti902_rtcb_t_mask()
      LET g_rtcb_d_mask_n[l_ac].* =  g_rtcb_d[l_ac].*
   END FOR
   
   LET g_rtcb2_d_mask_o.* =  g_rtcb2_d.*
   FOR l_ac = 1 TO g_rtcb2_d.getLength()
      LET g_rtcb2_d_mask_o[l_ac].* =  g_rtcb2_d[l_ac].*
      CALL arti902_rtcb_t_mask()
      LET g_rtcb2_d_mask_n[l_ac].* =  g_rtcb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_rtcb_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE arti902_pb
   
END FUNCTION
 
{</section>}
 
{<section id="arti902.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION arti902_detail_show()
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
 
{<section id="arti902.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti902_set_entry_b(p_cmd)                                                  
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
 
{<section id="arti902.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti902_set_no_entry_b(p_cmd)                                               
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
 
{<section id="arti902.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti902_default_search()
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
      LET ls_wc = ls_wc, " rtcbsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtcb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " rtcb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " rtcb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " rtcb004 = '", g_argv[05], "' AND "
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
 
{<section id="arti902.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti902_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "rtcb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtcb_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM rtcb_t
          WHERE rtcbent = g_enterprise AND
            rtcbsite = ps_keys_bak[1] AND rtcb001 = ps_keys_bak[2] AND rtcb002 = ps_keys_bak[3] AND rtcb003 = ps_keys_bak[4] AND rtcb004 = ps_keys_bak[5]
         
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
         CALL g_rtcb_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_rtcb2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti902.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti902_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "rtcb_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO rtcb_t
                  (rtcbent,
                   rtcbsite,rtcb001,rtcb002,rtcb003,rtcb004
                   ,rtcb005,rtcb006,rtcb007,rtcb008,rtcb009,rtcb010,rtcb011,rtcb012,rtcb013,rtcb014,rtcb015,rtcb016,rtcbstus,rtcbownid,rtcbowndp,rtcbcrtid,rtcbcrtdp,rtcbcrtdt,rtcbmodid,rtcbmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_rtcb_d[l_ac].rtcb005,g_rtcb_d[l_ac].rtcb006,g_rtcb_d[l_ac].rtcb007,g_rtcb_d[l_ac].rtcb008, 
                       g_rtcb_d[l_ac].rtcb009,g_rtcb_d[l_ac].rtcb010,g_rtcb_d[l_ac].rtcb011,g_rtcb_d[l_ac].rtcb012, 
                       g_rtcb_d[l_ac].rtcb013,g_rtcb_d[l_ac].rtcb014,g_rtcb_d[l_ac].rtcb015,g_rtcb_d[l_ac].rtcb016, 
                       g_rtcb_d[l_ac].rtcbstus,g_rtcb2_d[l_ac].rtcbownid,g_rtcb2_d[l_ac].rtcbowndp,g_rtcb2_d[l_ac].rtcbcrtid, 
                       g_rtcb2_d[l_ac].rtcbcrtdp,g_rtcb2_d[l_ac].rtcbcrtdt,g_rtcb2_d[l_ac].rtcbmodid, 
                       g_rtcb2_d[l_ac].rtcbmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti902.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti902_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "rtcb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtcb_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE rtcb_t 
         SET (rtcbsite,rtcb001,rtcb002,rtcb003,rtcb004
              ,rtcb005,rtcb006,rtcb007,rtcb008,rtcb009,rtcb010,rtcb011,rtcb012,rtcb013,rtcb014,rtcb015,rtcb016,rtcbstus,rtcbownid,rtcbowndp,rtcbcrtid,rtcbcrtdp,rtcbcrtdt,rtcbmodid,rtcbmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_rtcb_d[l_ac].rtcb005,g_rtcb_d[l_ac].rtcb006,g_rtcb_d[l_ac].rtcb007,g_rtcb_d[l_ac].rtcb008, 
                  g_rtcb_d[l_ac].rtcb009,g_rtcb_d[l_ac].rtcb010,g_rtcb_d[l_ac].rtcb011,g_rtcb_d[l_ac].rtcb012, 
                  g_rtcb_d[l_ac].rtcb013,g_rtcb_d[l_ac].rtcb014,g_rtcb_d[l_ac].rtcb015,g_rtcb_d[l_ac].rtcb016, 
                  g_rtcb_d[l_ac].rtcbstus,g_rtcb2_d[l_ac].rtcbownid,g_rtcb2_d[l_ac].rtcbowndp,g_rtcb2_d[l_ac].rtcbcrtid, 
                  g_rtcb2_d[l_ac].rtcbcrtdp,g_rtcb2_d[l_ac].rtcbcrtdt,g_rtcb2_d[l_ac].rtcbmodid,g_rtcb2_d[l_ac].rtcbmoddt)  
 
         WHERE rtcbent = g_enterprise AND rtcbsite = ps_keys_bak[1] AND rtcb001 = ps_keys_bak[2] AND rtcb002 = ps_keys_bak[3] AND rtcb003 = ps_keys_bak[4] AND rtcb004 = ps_keys_bak[5]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtcb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtcb_t:",SQLERRMESSAGE 
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
 
{<section id="arti902.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti902_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL arti902_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtcb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN arti902_bcl USING g_enterprise,
                                       g_rtcb_d[g_detail_idx].rtcbsite,g_rtcb_d[g_detail_idx].rtcb001, 
                                           g_rtcb_d[g_detail_idx].rtcb002,g_rtcb_d[g_detail_idx].rtcb003, 
                                           g_rtcb_d[g_detail_idx].rtcb004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti902_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti902.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti902_unlock_b(ps_table)
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
      CLOSE arti902_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti902.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION arti902_modify_detail_chk(ps_record)
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
         LET ls_return = "rtcb001"
      WHEN "s_detail2"
         LET ls_return = "rtcb001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="arti902.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION arti902_show_ownid_msg()
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
 
{<section id="arti902.mask_functions" >}
&include "erp/art/arti902_mask.4gl"
 
{</section>}
 
{<section id="arti902.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti902_set_pk_array()
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
   LET g_pk_array[1].values = g_rtcb_d[l_ac].rtcbsite
   LET g_pk_array[1].column = 'rtcbsite'
   LET g_pk_array[2].values = g_rtcb_d[l_ac].rtcb001
   LET g_pk_array[2].column = 'rtcb001'
   LET g_pk_array[3].values = g_rtcb_d[l_ac].rtcb002
   LET g_pk_array[3].column = 'rtcb002'
   LET g_pk_array[4].values = g_rtcb_d[l_ac].rtcb003
   LET g_pk_array[4].column = 'rtcb003'
   LET g_pk_array[5].values = g_rtcb_d[l_ac].rtcb004
   LET g_pk_array[5].column = 'rtcb004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti902.state_change" >}
   
 
{</section>}
 
{<section id="arti902.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti902.other_function" readonly="Y" >}

PRIVATE FUNCTION arti902_rtcbsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtcb_d[l_ac].rtcbsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'  ","") RETURNING g_rtn_fields
   LET g_rtcb_d[l_ac].rtcbsite_desc = '', g_rtn_fields[1] , ''
   LET g_rtcb2_d[l_ac].rtcbsite_2_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION arti902_rtcb002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtcb_d[l_ac].rtcb002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'  ","") RETURNING g_rtn_fields
   LET g_rtcb_d[l_ac].rtcb002_desc = '', g_rtn_fields[1] , ''
   LET g_rtcb2_d[l_ac].rtcb002_2_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION arti902_rtcb003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtcb_d[l_ac].rtcb003
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'  ","") RETURNING g_rtn_fields
   LET g_rtcb_d[l_ac].rtcb003_desc = '', g_rtn_fields[1] , ''
   LET g_rtcb2_d[l_ac].rtcb003_2_desc = '', g_rtn_fields[1] , ''
END FUNCTION

PRIVATE FUNCTION arti902_rtcb004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtcb_d[l_ac].rtcb004
   CALL ap_ref_array2(g_ref_fields,"SELECT rtcal003 FROM rtcal_t WHERE rtcalent='"||g_enterprise||"' AND rtcal001=? AND rtcal002='"||g_dlang||"'  ","") RETURNING g_rtn_fields
   LET g_rtcb_d[l_ac].rtcb004_desc = '', g_rtn_fields[1] , ''
   LET g_rtcb2_d[l_ac].rtcb004_2_desc = '', g_rtn_fields[1] , ''
END FUNCTION

 
{</section>}
 
