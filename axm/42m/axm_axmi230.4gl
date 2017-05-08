#該程式未解開Section, 採用最新樣板產出!
{<section id="axmi230.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-09-09 13:53:00), PR版次:0004(2016-10-05 11:43:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: axmi230
#+ Description: 包裝方式維護作業
#+ Creator....: 03079(2014-09-01 17:04:43)
#+ Modifier...: 01588 -SD/PR- 05384
 
{</section>}
 
{<section id="axmi230.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#17  2016/04/11  By 07900       校验代码的重复错误讯息修改
#160912-00037#1   2016/10/05  By shiun       當有維護內包裝方式時，以包裝方式的總體積除以內包裝方式的總體機來推算總包裝數量。
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
PRIVATE TYPE type_g_xmam_d RECORD
       xmam001 LIKE xmam_t.xmam001, 
   xmaml003 LIKE xmaml_t.xmaml003, 
   xmaml004 LIKE xmaml_t.xmaml004, 
   xmam003 LIKE xmam_t.xmam003, 
   xmam004 LIKE xmam_t.xmam004, 
   xmam004_desc LIKE type_t.chr500, 
   xmam004_desc_1 LIKE type_t.chr500, 
   xmam010 LIKE xmam_t.xmam010, 
   xmam011 LIKE xmam_t.xmam011, 
   xmam012 LIKE xmam_t.xmam012, 
   xmam014 LIKE xmam_t.xmam014, 
   xmam014_desc LIKE type_t.chr500, 
   xmam013 LIKE xmam_t.xmam013, 
   xmam019 LIKE xmam_t.xmam019, 
   xmam019_desc LIKE type_t.chr500, 
   xmam015 LIKE xmam_t.xmam015, 
   xmam016 LIKE xmam_t.xmam016, 
   xmam016_desc LIKE type_t.chr500, 
   xmam017 LIKE xmam_t.xmam017, 
   xmam018 LIKE xmam_t.xmam018, 
   xmam018_desc LIKE type_t.chr500, 
   xmam005 LIKE xmam_t.xmam005, 
   xmam006 LIKE xmam_t.xmam006, 
   xmam007 LIKE xmam_t.xmam007, 
   xmam008 LIKE xmam_t.xmam008, 
   xmam009 LIKE xmam_t.xmam009, 
   xmam009_desc LIKE type_t.chr500, 
   xmamstus LIKE xmam_t.xmamstus
       END RECORD
PRIVATE TYPE type_g_xmam2_d RECORD
       xmam001 LIKE xmam_t.xmam001, 
   xmamownid LIKE xmam_t.xmamownid, 
   xmamownid_desc LIKE type_t.chr500, 
   xmamowndp LIKE xmam_t.xmamowndp, 
   xmamowndp_desc LIKE type_t.chr500, 
   xmamcrtid LIKE xmam_t.xmamcrtid, 
   xmamcrtid_desc LIKE type_t.chr500, 
   xmamcrtdp LIKE xmam_t.xmamcrtdp, 
   xmamcrtdp_desc LIKE type_t.chr500, 
   xmamcrtdt DATETIME YEAR TO SECOND, 
   xmammodid LIKE xmam_t.xmammodid, 
   xmammodid_desc LIKE type_t.chr500, 
   xmammoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      xmaml001 LIKE xmaml_t.xmaml001,
      xmaml002 LIKE xmaml_t.xmaml002,
      xmaml003 LIKE xmaml_t.xmaml003,
      xmaml004 LIKE xmaml_t.xmaml004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmam_d          DYNAMIC ARRAY OF type_g_xmam_d #單身變數
DEFINE g_xmam_d_t        type_g_xmam_d                  #單身備份
DEFINE g_xmam_d_o        type_g_xmam_d                  #單身備份
DEFINE g_xmam_d_mask_o   DYNAMIC ARRAY OF type_g_xmam_d #單身變數
DEFINE g_xmam_d_mask_n   DYNAMIC ARRAY OF type_g_xmam_d #單身變數
DEFINE g_xmam2_d   DYNAMIC ARRAY OF type_g_xmam2_d
DEFINE g_xmam2_d_t type_g_xmam2_d
DEFINE g_xmam2_d_o type_g_xmam2_d
DEFINE g_xmam2_d_mask_o DYNAMIC ARRAY OF type_g_xmam2_d
DEFINE g_xmam2_d_mask_n DYNAMIC ARRAY OF type_g_xmam2_d
 
      
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
 
{<section id="axmi230.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xmam001,xmam003,xmam004,xmam010,xmam011,xmam012,xmam014,xmam013,xmam019, 
       xmam015,xmam016,xmam017,xmam018,xmam005,xmam006,xmam007,xmam008,xmam009,xmamstus,xmam001,xmamownid, 
       xmamowndp,xmamcrtid,xmamcrtdp,xmamcrtdt,xmammodid,xmammoddt FROM xmam_t WHERE xmament=? AND xmam001=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi230_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmi230 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmi230_init()   
 
      #進入選單 Menu (="N")
      CALL axmi230_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmi230
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmi230.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmi230_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('xmam003','2098') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL axmi230_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="axmi230.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axmi230_ui_dialog()
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
         CALL g_xmam_d.clear()
         CALL g_xmam2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL axmi230_init()
      END IF
   
      CALL axmi230_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xmam_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_xmam2_d[g_detail_idx].xmamownid   #(ver:35)
               LET g_data_dept = g_xmam2_d[g_detail_idx].xmamowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axmi230_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_xmam2_d TO s_detail2.*
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
   CALL axmi230_set_pk_array()
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
            CALL axmi230_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axmi230_modify()
            #add-point:ON ACTION modify name="menu.modify"
               CALL axmi230_b_fill(g_wc2) 
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL axmi230_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axmi230_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL axmi230_b_fill(g_wc2) 
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL axmi230_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axmi230_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi230_insert()
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
               CALL axmi230_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_xmam_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xmam2_d)
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
            CALL axmi230_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmi230_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmi230_set_pk_array()
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
 
{<section id="axmi230.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmi230_query()
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
   CALL g_xmam_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON xmam001,xmaml003,xmaml004,xmam003,xmam004,xmam010,xmam011,xmam012,xmam014,xmam013, 
          xmam019,xmam015,xmam016,xmam017,xmam018,xmam018_desc,xmam005,xmam006,xmam007,xmam008,xmam009, 
          xmamstus,xmamownid,xmamowndp,xmamcrtid,xmamcrtdp,xmamcrtdt,xmammodid,xmammoddt 
 
         FROM s_detail1[1].xmam001,s_detail1[1].xmaml003,s_detail1[1].xmaml004,s_detail1[1].xmam003, 
             s_detail1[1].xmam004,s_detail1[1].xmam010,s_detail1[1].xmam011,s_detail1[1].xmam012,s_detail1[1].xmam014, 
             s_detail1[1].xmam013,s_detail1[1].xmam019,s_detail1[1].xmam015,s_detail1[1].xmam016,s_detail1[1].xmam017, 
             s_detail1[1].xmam018,s_detail1[1].xmam018_desc,s_detail1[1].xmam005,s_detail1[1].xmam006, 
             s_detail1[1].xmam007,s_detail1[1].xmam008,s_detail1[1].xmam009,s_detail1[1].xmamstus,s_detail2[1].xmamownid, 
             s_detail2[1].xmamowndp,s_detail2[1].xmamcrtid,s_detail2[1].xmamcrtdp,s_detail2[1].xmamcrtdt, 
             s_detail2[1].xmammodid,s_detail2[1].xmammoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmamcrtdt>>----
         AFTER FIELD xmamcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmammoddt>>----
         AFTER FIELD xmammoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmamcnfdt>>----
         
         #----<<xmampstdt>>----
 
 
 
      
                  #Ctrlp:construct.c.page1.xmam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam001
            #add-point:ON ACTION controlp INFIELD xmam001 name="construct.c.page1.xmam001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmam001  #顯示到畫面上
            NEXT FIELD xmam001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam001
            #add-point:BEFORE FIELD xmam001 name="query.b.page1.xmam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam001
            
            #add-point:AFTER FIELD xmam001 name="query.a.page1.xmam001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaml003
            #add-point:BEFORE FIELD xmaml003 name="query.b.page1.xmaml003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaml003
            
            #add-point:AFTER FIELD xmaml003 name="query.a.page1.xmaml003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmaml003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaml003
            #add-point:ON ACTION controlp INFIELD xmaml003 name="query.c.page1.xmaml003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaml004
            #add-point:BEFORE FIELD xmaml004 name="query.b.page1.xmaml004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaml004
            
            #add-point:AFTER FIELD xmaml004 name="query.a.page1.xmaml004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmaml004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaml004
            #add-point:ON ACTION controlp INFIELD xmaml004 name="query.c.page1.xmaml004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam003
            #add-point:BEFORE FIELD xmam003 name="query.b.page1.xmam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam003
            
            #add-point:AFTER FIELD xmam003 name="query.a.page1.xmam003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam003
            #add-point:ON ACTION controlp INFIELD xmam003 name="query.c.page1.xmam003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmam004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam004
            #add-point:ON ACTION controlp INFIELD xmam004 name="construct.c.page1.xmam004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmam004()                       #呼叫開窗 
            DISPLAY g_qryparam.return1 TO xmam004  #顯示到畫面上
            NEXT FIELD xmam004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam004
            #add-point:BEFORE FIELD xmam004 name="query.b.page1.xmam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam004
            
            #add-point:AFTER FIELD xmam004 name="query.a.page1.xmam004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam010
            #add-point:BEFORE FIELD xmam010 name="query.b.page1.xmam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam010
            
            #add-point:AFTER FIELD xmam010 name="query.a.page1.xmam010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam010
            #add-point:ON ACTION controlp INFIELD xmam010 name="query.c.page1.xmam010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam011
            #add-point:BEFORE FIELD xmam011 name="query.b.page1.xmam011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam011
            
            #add-point:AFTER FIELD xmam011 name="query.a.page1.xmam011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam011
            #add-point:ON ACTION controlp INFIELD xmam011 name="query.c.page1.xmam011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam012
            #add-point:BEFORE FIELD xmam012 name="query.b.page1.xmam012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam012
            
            #add-point:AFTER FIELD xmam012 name="query.a.page1.xmam012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam012
            #add-point:ON ACTION controlp INFIELD xmam012 name="query.c.page1.xmam012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam014
            #add-point:ON ACTION controlp INFIELD xmam014 name="construct.c.page1.xmam014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.where = " ooca003 = '2' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmam014  #顯示到畫面上
            NEXT FIELD xmam014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam014
            #add-point:BEFORE FIELD xmam014 name="query.b.page1.xmam014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam014
            
            #add-point:AFTER FIELD xmam014 name="query.a.page1.xmam014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam013
            #add-point:BEFORE FIELD xmam013 name="query.b.page1.xmam013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam013
            
            #add-point:AFTER FIELD xmam013 name="query.a.page1.xmam013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam013
            #add-point:ON ACTION controlp INFIELD xmam013 name="query.c.page1.xmam013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmam019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam019
            #add-point:ON ACTION controlp INFIELD xmam019 name="construct.c.page1.xmam019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.where = " ooca003 = '5' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmam019  #顯示到畫面上
            NEXT FIELD xmam019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam019
            #add-point:BEFORE FIELD xmam019 name="query.b.page1.xmam019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam019
            
            #add-point:AFTER FIELD xmam019 name="query.a.page1.xmam019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam015
            #add-point:BEFORE FIELD xmam015 name="query.b.page1.xmam015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam015
            
            #add-point:AFTER FIELD xmam015 name="query.a.page1.xmam015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam015
            #add-point:ON ACTION controlp INFIELD xmam015 name="query.c.page1.xmam015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmam016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam016
            #add-point:ON ACTION controlp INFIELD xmam016 name="construct.c.page1.xmam016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.where = " ooca003 = '3' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmam016  #顯示到畫面上
            NEXT FIELD xmam016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam016
            #add-point:BEFORE FIELD xmam016 name="query.b.page1.xmam016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam016
            
            #add-point:AFTER FIELD xmam016 name="query.a.page1.xmam016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam017
            #add-point:BEFORE FIELD xmam017 name="query.b.page1.xmam017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam017
            
            #add-point:AFTER FIELD xmam017 name="query.a.page1.xmam017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam017
            #add-point:ON ACTION controlp INFIELD xmam017 name="query.c.page1.xmam017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmam018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam018
            #add-point:ON ACTION controlp INFIELD xmam018 name="construct.c.page1.xmam018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmam001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmam018  #顯示到畫面上
            NEXT FIELD xmam018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam018
            #add-point:BEFORE FIELD xmam018 name="query.b.page1.xmam018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam018
            
            #add-point:AFTER FIELD xmam018 name="query.a.page1.xmam018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam018_desc
            #add-point:BEFORE FIELD xmam018_desc name="query.b.page1.xmam018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam018_desc
            
            #add-point:AFTER FIELD xmam018_desc name="query.a.page1.xmam018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam018_desc
            #add-point:ON ACTION controlp INFIELD xmam018_desc name="query.c.page1.xmam018_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam005
            #add-point:BEFORE FIELD xmam005 name="query.b.page1.xmam005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam005
            
            #add-point:AFTER FIELD xmam005 name="query.a.page1.xmam005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam005
            #add-point:ON ACTION controlp INFIELD xmam005 name="query.c.page1.xmam005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam006
            #add-point:BEFORE FIELD xmam006 name="query.b.page1.xmam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam006
            
            #add-point:AFTER FIELD xmam006 name="query.a.page1.xmam006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam006
            #add-point:ON ACTION controlp INFIELD xmam006 name="query.c.page1.xmam006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam007
            #add-point:BEFORE FIELD xmam007 name="query.b.page1.xmam007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam007
            
            #add-point:AFTER FIELD xmam007 name="query.a.page1.xmam007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam007
            #add-point:ON ACTION controlp INFIELD xmam007 name="query.c.page1.xmam007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam008
            #add-point:BEFORE FIELD xmam008 name="query.b.page1.xmam008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam008
            
            #add-point:AFTER FIELD xmam008 name="query.a.page1.xmam008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmam008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam008
            #add-point:ON ACTION controlp INFIELD xmam008 name="query.c.page1.xmam008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmam009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam009
            #add-point:ON ACTION controlp INFIELD xmam009 name="construct.c.page1.xmam009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmam009  #顯示到畫面上
            NEXT FIELD xmam009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam009
            #add-point:BEFORE FIELD xmam009 name="query.b.page1.xmam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam009
            
            #add-point:AFTER FIELD xmam009 name="query.a.page1.xmam009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamstus
            #add-point:BEFORE FIELD xmamstus name="query.b.page1.xmamstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmamstus
            
            #add-point:AFTER FIELD xmamstus name="query.a.page1.xmamstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmamstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmamstus
            #add-point:ON ACTION controlp INFIELD xmamstus name="query.c.page1.xmamstus"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.xmamownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmamownid
            #add-point:ON ACTION controlp INFIELD xmamownid name="construct.c.page2.xmamownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmamownid  #顯示到畫面上
            NEXT FIELD xmamownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamownid
            #add-point:BEFORE FIELD xmamownid name="query.b.page2.xmamownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmamownid
            
            #add-point:AFTER FIELD xmamownid name="query.a.page2.xmamownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmamowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmamowndp
            #add-point:ON ACTION controlp INFIELD xmamowndp name="construct.c.page2.xmamowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmamowndp  #顯示到畫面上
            NEXT FIELD xmamowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamowndp
            #add-point:BEFORE FIELD xmamowndp name="query.b.page2.xmamowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmamowndp
            
            #add-point:AFTER FIELD xmamowndp name="query.a.page2.xmamowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmamcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmamcrtid
            #add-point:ON ACTION controlp INFIELD xmamcrtid name="construct.c.page2.xmamcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmamcrtid  #顯示到畫面上
            NEXT FIELD xmamcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamcrtid
            #add-point:BEFORE FIELD xmamcrtid name="query.b.page2.xmamcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmamcrtid
            
            #add-point:AFTER FIELD xmamcrtid name="query.a.page2.xmamcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmamcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmamcrtdp
            #add-point:ON ACTION controlp INFIELD xmamcrtdp name="construct.c.page2.xmamcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmamcrtdp  #顯示到畫面上
            NEXT FIELD xmamcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamcrtdp
            #add-point:BEFORE FIELD xmamcrtdp name="query.b.page2.xmamcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmamcrtdp
            
            #add-point:AFTER FIELD xmamcrtdp name="query.a.page2.xmamcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamcrtdt
            #add-point:BEFORE FIELD xmamcrtdt name="query.b.page2.xmamcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmammodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmammodid
            #add-point:ON ACTION controlp INFIELD xmammodid name="construct.c.page2.xmammodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmammodid  #顯示到畫面上
            NEXT FIELD xmammodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmammodid
            #add-point:BEFORE FIELD xmammodid name="query.b.page2.xmammodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmammodid
            
            #add-point:AFTER FIELD xmammodid name="query.a.page2.xmammodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmammoddt
            #add-point:BEFORE FIELD xmammoddt name="query.b.page2.xmammoddt"
            
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
    
   CALL axmi230_b_fill(g_wc2)
   LET g_data_owner = g_xmam2_d[g_detail_idx].xmamownid   #(ver:35)
   LET g_data_dept = g_xmam2_d[g_detail_idx].xmamowndp   #(ver:35)
 
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
 
{<section id="axmi230.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmi230_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL axmi230_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   CALL axmi230_b_fill(g_wc2) 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmi230.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmi230_modify()
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
      INPUT ARRAY g_xmam_d FROM s_detail1.*
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
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmam_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmi230_b_fill(g_wc2)
            LET g_detail_cnt = g_xmam_d.getLength()
         
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
            DISPLAY g_xmam_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_xmam_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xmam_d[l_ac].xmam001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmam_d_t.* = g_xmam_d[l_ac].*  #BACKUP
               LET g_xmam_d_o.* = g_xmam_d[l_ac].*  #BACKUP
               IF NOT axmi230_lock_b("xmam_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmi230_bcl INTO g_xmam_d[l_ac].xmam001,g_xmam_d[l_ac].xmam003,g_xmam_d[l_ac].xmam004, 
                      g_xmam_d[l_ac].xmam010,g_xmam_d[l_ac].xmam011,g_xmam_d[l_ac].xmam012,g_xmam_d[l_ac].xmam014, 
                      g_xmam_d[l_ac].xmam013,g_xmam_d[l_ac].xmam019,g_xmam_d[l_ac].xmam015,g_xmam_d[l_ac].xmam016, 
                      g_xmam_d[l_ac].xmam017,g_xmam_d[l_ac].xmam018,g_xmam_d[l_ac].xmam005,g_xmam_d[l_ac].xmam006, 
                      g_xmam_d[l_ac].xmam007,g_xmam_d[l_ac].xmam008,g_xmam_d[l_ac].xmam009,g_xmam_d[l_ac].xmamstus, 
                      g_xmam2_d[l_ac].xmam001,g_xmam2_d[l_ac].xmamownid,g_xmam2_d[l_ac].xmamowndp,g_xmam2_d[l_ac].xmamcrtid, 
                      g_xmam2_d[l_ac].xmamcrtdp,g_xmam2_d[l_ac].xmamcrtdt,g_xmam2_d[l_ac].xmammodid, 
                      g_xmam2_d[l_ac].xmammoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmam_d_t.xmam001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmam_d_mask_o[l_ac].* =  g_xmam_d[l_ac].*
                  CALL axmi230_xmam_t_mask()
                  LET g_xmam_d_mask_n[l_ac].* =  g_xmam_d[l_ac].*
                  
                  CALL axmi230_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axmi230_set_entry_b(l_cmd)
            CALL axmi230_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            LET g_xmam_d_o.* = g_xmam_d[l_ac].*

            CALL axmi230_set_entry_b(l_cmd)
            CALL axmi230_set_no_required_b(l_cmd)
            CALL axmi230_set_required_b(l_cmd)
            CALL axmi230_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.xmaml001 = g_xmam_d[l_ac].xmam001
LET g_detail_multi_table_t.xmaml002 = g_dlang
LET g_detail_multi_table_t.xmaml003 = g_xmam_d[l_ac].xmaml003
LET g_detail_multi_table_t.xmaml004 = g_xmam_d[l_ac].xmaml004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'xmamlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'xmaml001'
            LET l_var_keys[02] = g_xmam_d[l_ac].xmam001
            LET l_field_keys[03] = 'xmaml002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'xmaml_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmam_d_t.* TO NULL
            INITIALIZE g_xmam_d_o.* TO NULL
            INITIALIZE g_xmam_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmam2_d[l_ac].xmamownid = g_user
      LET g_xmam2_d[l_ac].xmamowndp = g_dept
      LET g_xmam2_d[l_ac].xmamcrtid = g_user
      LET g_xmam2_d[l_ac].xmamcrtdp = g_dept 
      LET g_xmam2_d[l_ac].xmamcrtdt = cl_get_current()
      LET g_xmam2_d[l_ac].xmammodid = g_user
      LET g_xmam2_d[l_ac].xmammoddt = cl_get_current()
      LET g_xmam_d[l_ac].xmamstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_xmam_d[l_ac].xmam003 = "1"
      LET g_xmam_d[l_ac].xmam017 = "N"
      LET g_xmam_d[l_ac].xmamstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_xmam_d_t.* = g_xmam_d[l_ac].*     #新輸入資料
            LET g_xmam_d_o.* = g_xmam_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmam_d[li_reproduce_target].* = g_xmam_d[li_reproduce].*
               LET g_xmam2_d[li_reproduce_target].* = g_xmam2_d[li_reproduce].*
 
               LET g_xmam_d[g_xmam_d.getLength()].xmam001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.xmaml001 = g_xmam_d[l_ac].xmam001
LET g_detail_multi_table_t.xmaml002 = g_dlang
LET g_detail_multi_table_t.xmaml003 = g_xmam_d[l_ac].xmaml003
LET g_detail_multi_table_t.xmaml004 = g_xmam_d[l_ac].xmaml004
 
 
            CALL axmi230_set_entry_b(l_cmd)
            CALL axmi230_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM xmam_t 
             WHERE xmament = g_enterprise AND xmam001 = g_xmam_d[l_ac].xmam001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmam_d[g_detail_idx].xmam001
               CALL axmi230_insert_b('xmam_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmam_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmam_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmi230_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xmam_d[l_ac].xmam001 = g_detail_multi_table_t.xmaml001 AND
         g_xmam_d[l_ac].xmaml003 = g_detail_multi_table_t.xmaml003 AND
         g_xmam_d[l_ac].xmaml004 = g_detail_multi_table_t.xmaml004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xmamlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xmam_d[l_ac].xmam001
            LET l_field_keys[02] = 'xmaml001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xmaml001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'xmaml002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.xmaml002
            LET l_vars[01] = g_xmam_d[l_ac].xmaml003
            LET l_fields[01] = 'xmaml003'
            LET l_vars[02] = g_xmam_d[l_ac].xmaml004
            LET l_fields[02] = 'xmaml004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xmaml_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (xmam001 = '", g_xmam_d[l_ac].xmam001, "' "
 
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
               
               DELETE FROM xmam_t
                WHERE xmament = g_enterprise AND 
                      xmam001 = g_xmam_d_t.xmam001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmam_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xmamlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'xmaml001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xmaml001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xmaml_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axmi230_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xmam_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE axmi230_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_xmam_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmam_d_t.xmam001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmi230_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL axmi230_delete_b('xmam_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xmam_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam001
            #add-point:BEFORE FIELD xmam001 name="input.b.page1.xmam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam001
            
            #add-point:AFTER FIELD xmam001 name="input.a.page1.xmam001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xmam_d[g_detail_idx].xmam001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmam_d[g_detail_idx].xmam001 != g_xmam_d_t.xmam001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmam_t WHERE "||"xmament = '" ||g_enterprise|| "' AND "||"xmam001 = '"||g_xmam_d[g_detail_idx].xmam001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam001
            #add-point:ON CHANGE xmam001 name="input.g.page1.xmam001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaml003
            #add-point:BEFORE FIELD xmaml003 name="input.b.page1.xmaml003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaml003
            
            #add-point:AFTER FIELD xmaml003 name="input.a.page1.xmaml003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaml003
            #add-point:ON CHANGE xmaml003 name="input.g.page1.xmaml003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaml004
            #add-point:BEFORE FIELD xmaml004 name="input.b.page1.xmaml004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaml004
            
            #add-point:AFTER FIELD xmaml004 name="input.a.page1.xmaml004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaml004
            #add-point:ON CHANGE xmaml004 name="input.g.page1.xmaml004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam003
            #add-point:BEFORE FIELD xmam003 name="input.b.page1.xmam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam003
            
            #add-point:AFTER FIELD xmam003 name="input.a.page1.xmam003"
            IF g_xmam_d[l_ac].xmam003 = '2' THEN
               LET g_xmam_d[l_ac].xmam005      = ''
               LET g_xmam_d[l_ac].xmam006      = ''
               LET g_xmam_d[l_ac].xmam007      = ''
               LET g_xmam_d[l_ac].xmam008      = ''
               LET g_xmam_d[l_ac].xmam009      = ''
               LET g_xmam_d[l_ac].xmam009_desc = ''

               #備份舊值 
               LET g_xmam_d_o.xmam005 = g_xmam_d[l_ac].xmam005
               LET g_xmam_d_o.xmam006 = g_xmam_d[l_ac].xmam006
               LET g_xmam_d_o.xmam007 = g_xmam_d[l_ac].xmam007
               LET g_xmam_d_o.xmam008 = g_xmam_d[l_ac].xmam008
               LET g_xmam_d_o.xmam009 = g_xmam_d[l_ac].xmam009
            END IF
            
            CALL axmi230_set_entry_b(l_cmd) 
            CALL axmi230_set_no_required_b(l_cmd)
            CALL axmi230_set_required_b(l_cmd)
            CALL axmi230_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam003
            #add-point:ON CHANGE xmam003 name="input.g.page1.xmam003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam004
            
            #add-point:AFTER FIELD xmam004 name="input.a.page1.xmam004"
            LET g_xmam_d[l_ac].xmam004_desc = ' '
            LET g_xmam_d[l_ac].xmam004_desc_1 = ' '
            CALL s_desc_get_item_desc(g_xmam_d[l_ac].xmam004)
                 RETURNING g_xmam_d[l_ac].xmam004_desc,
                           g_xmam_d[l_ac].xmam004_desc_1
            IF NOT cl_null(g_xmam_d[l_ac].xmam004) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam004 != g_xmam_d_o.xmam004 OR
                                                   g_xmam_d_o.xmam004 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmam_d[l_ac].xmam004
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
                  #160318-00025#17  by 07900 --add-end
                  IF cl_chk_exist("v_imaa001_3") THEN
                     IF cl_chk_exist("v_imaf001_2") THEN

                     ELSE
                        LET g_xmam_d[l_ac].xmam004 = g_xmam_d_o.xmam004
                        CALL s_desc_get_item_desc(g_xmam_d[l_ac].xmam004)
                             RETURNING g_xmam_d[l_ac].xmam004_desc,
                                       g_xmam_d[l_ac].xmam004_desc_1
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     LET g_xmam_d[l_ac].xmam004 = g_xmam_d_o.xmam004
                     CALL s_desc_get_item_desc(g_xmam_d[l_ac].xmam004)
                          RETURNING g_xmam_d[l_ac].xmam004_desc,
                                    g_xmam_d[l_ac].xmam004_desc_1
                     NEXT FIELD CURRENT
                  END IF 
                  
                  #將包裝容器基本資料的長度、寬度、高度、體積、長度單位、重量、重量單位等值
                  #預設到相關欄位上
                  #      長      寬      高      長度單位 體積    體積單位 毛重    重量單位  
                  SELECT imaa019,imaa020,imaa021,imaa022, imaa025,imaa026, imaa016,imaa018
                    INTO g_xmam_d[l_ac].xmam010, g_xmam_d[l_ac].xmam011,
                         g_xmam_d[l_ac].xmam012, g_xmam_d[l_ac].xmam014,
                         g_xmam_d[l_ac].xmam013, g_xmam_d[l_ac].xmam019,
                         g_xmam_d[l_ac].xmam015, g_xmam_d[l_ac].xmam016
                    FROM imaa_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_xmam_d[l_ac].xmam004

                  #取得長度單位說明 
                  IF NOT cl_null(g_xmam_d[l_ac].xmam014) THEN
                     CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam014)
                          RETURNING g_xmam_d[l_ac].xmam014_desc
                  END IF
                  #取得體積單位說明 
                  IF NOT cl_null(g_xmam_d[l_ac].xmam019) THEN
                     CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam019)
                          RETURNING g_xmam_d[l_ac].xmam019_desc
                  END IF
                  #取得重量單位說明 
                  IF NOT cl_null(g_xmam_d[l_ac].xmam016) THEN
                     CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam016)
                          RETURNING g_xmam_d[l_ac].xmam016_desc
                  END IF 
                  
                  #舊值備份 
                  LET g_xmam_d_o.xmam010 = g_xmam_d[l_ac].xmam010
                  LET g_xmam_d_o.xmam011 = g_xmam_d[l_ac].xmam011
                  LET g_xmam_d_o.xmam012 = g_xmam_d[l_ac].xmam012
                  LET g_xmam_d_o.xmam014 = g_xmam_d[l_ac].xmam014
                  LET g_xmam_d_o.xmam013 = g_xmam_d[l_ac].xmam013
                  LET g_xmam_d_o.xmam019 = g_xmam_d[l_ac].xmam019
                  LET g_xmam_d_o.xmam015 = g_xmam_d[l_ac].xmam015
                  LET g_xmam_d_o.xmam016 = g_xmam_d[l_ac].xmam016
               END IF
            END IF 
            
            CALL s_desc_get_item_desc(g_xmam_d[l_ac].xmam004)
                 RETURNING g_xmam_d[l_ac].xmam004_desc,
                           g_xmam_d[l_ac].xmam004_desc_1

            LET g_xmam_d_o.xmam004 = g_xmam_d[l_ac].xmam004

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam004
            #add-point:BEFORE FIELD xmam004 name="input.b.page1.xmam004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam004
            #add-point:ON CHANGE xmam004 name="input.g.page1.xmam004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam010,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmam010
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam010 name="input.a.page1.xmam010"
            IF NOT cl_null(g_xmam_d[l_ac].xmam010) THEN  
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam010 != g_xmam_d_o.xmam010 OR
                                                   g_xmam_d_o.xmam010 IS NULL)) THEN
                  #長 寬 高有值時 自動推算 體積 
                  IF (NOT cl_null(g_xmam_d[l_ac].xmam011)) AND
                     (NOT cl_null(g_xmam_d[l_ac].xmam012)) THEN
                     LET g_xmam_d[l_ac].xmam013 = g_xmam_d[l_ac].xmam010 *
                                                  g_xmam_d[l_ac].xmam011 *
                                                  g_xmam_d[l_ac].xmam012
                     
                     #add--160912-00037#1 By shiun--(S)
                     IF g_xmam_d[l_ac].xmam003 = '2' AND g_xmam_d[l_ac].xmam017 = 'Y' THEN
                        CALL axmi230_xmam008_ref() RETURNING g_xmam_d[l_ac].xmam008
                     END IF
                     #add--160912-00037#1 By shiun--(E)
                  END IF
               END IF
            END IF 
            
            LET g_xmam_d_o.xmam010 = g_xmam_d[l_ac].xmam010 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam010
            #add-point:BEFORE FIELD xmam010 name="input.b.page1.xmam010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam010
            #add-point:ON CHANGE xmam010 name="input.g.page1.xmam010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam011,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmam011
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam011 name="input.a.page1.xmam011"
            IF NOT cl_null(g_xmam_d[l_ac].xmam011) THEN  
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam011 != g_xmam_d_o.xmam011 OR
                                                   g_xmam_d_o.xmam011 IS NULL)) THEN
                  #長 寬 高有值時 自動推算 體積 
                  IF (NOT cl_null(g_xmam_d[l_ac].xmam010)) AND
                     (NOT cl_null(g_xmam_d[l_ac].xmam012)) THEN
                     LET g_xmam_d[l_ac].xmam013 = g_xmam_d[l_ac].xmam010 *
                                                  g_xmam_d[l_ac].xmam011 *
                                                  g_xmam_d[l_ac].xmam012
                  
                     #add--160912-00037#1 By shiun--(S)
                     IF g_xmam_d[l_ac].xmam003 = '2' AND g_xmam_d[l_ac].xmam017 = 'Y' THEN
                        CALL axmi230_xmam008_ref() RETURNING g_xmam_d[l_ac].xmam008
                     END IF
                     #add--160912-00037#1 By shiun--(E)
                  END IF
               END IF
            END IF 
 
            LET g_xmam_d_o.xmam011 = g_xmam_d[l_ac].xmam011

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam011
            #add-point:BEFORE FIELD xmam011 name="input.b.page1.xmam011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam011
            #add-point:ON CHANGE xmam011 name="input.g.page1.xmam011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam012,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmam012
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam012 name="input.a.page1.xmam012"
            IF NOT cl_null(g_xmam_d[l_ac].xmam012) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam012 != g_xmam_d_o.xmam012 OR
                                                   g_xmam_d_o.xmam012 IS NULL)) THEN
                  #長 寬 高有值時 自動推算 體積 
                  IF (NOT cl_null(g_xmam_d[l_ac].xmam010)) AND
                     (NOT cl_null(g_xmam_d[l_ac].xmam011)) THEN
                     LET g_xmam_d[l_ac].xmam013 = g_xmam_d[l_ac].xmam010 *
                                                  g_xmam_d[l_ac].xmam011 *
                                                  g_xmam_d[l_ac].xmam012
                  
                     #add--160912-00037#1 By shiun--(S)
                     IF g_xmam_d[l_ac].xmam003 = '2' AND g_xmam_d[l_ac].xmam017 = 'Y' THEN
                        CALL axmi230_xmam008_ref() RETURNING g_xmam_d[l_ac].xmam008
                     END IF
                     #add--160912-00037#1 By shiun--(E)
                  END IF
               END IF
            END IF 

            LET g_xmam_d_o.xmam012 = g_xmam_d[l_ac].xmam012

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam012
            #add-point:BEFORE FIELD xmam012 name="input.b.page1.xmam012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam012
            #add-point:ON CHANGE xmam012 name="input.g.page1.xmam012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam014
            
            #add-point:AFTER FIELD xmam014 name="input.a.page1.xmam014"
            LET g_xmam_d[l_ac].xmam014_desc = ' '
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam014)
                 RETURNING g_xmam_d[l_ac].xmam014_desc
            
            IF NOT cl_null(g_xmam_d[l_ac].xmam014) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam014 != g_xmam_d_o.xmam014 OR
                                                   g_xmam_d_o.xmam014 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmam_d[l_ac].xmam014
                  #160318-00025#17 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#17 by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooca001_3") THEN
                     LET g_xmam_d[l_ac].xmam014 = g_xmam_d_o.xmam014
                     CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam014)
                          RETURNING g_xmam_d[l_ac].xmam014_desc
                     NEXT FIELD CURRENT
                  END IF

                  #取得體積單位 
                  SELECT ooca007 INTO g_xmam_d[l_ac].xmam019
                    FROM ooca_t
                   WHERE oocaent = g_enterprise
                     AND ooca001 = g_xmam_d[l_ac].xmam014

                  #取得體積單位的說明 
                  CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam019)
                       RETURNING g_xmam_d[l_ac].xmam019_desc
               END IF
            
            END IF 
            
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam014)
                 RETURNING g_xmam_d[l_ac].xmam014_desc

            LET g_xmam_d_o.xmam014 = g_xmam_d[l_ac].xmam014


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam014
            #add-point:BEFORE FIELD xmam014 name="input.b.page1.xmam014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam014
            #add-point:ON CHANGE xmam014 name="input.g.page1.xmam014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam013
            #add-point:BEFORE FIELD xmam013 name="input.b.page1.xmam013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam013
            
            #add-point:AFTER FIELD xmam013 name="input.a.page1.xmam013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam013
            #add-point:ON CHANGE xmam013 name="input.g.page1.xmam013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam019
            
            #add-point:AFTER FIELD xmam019 name="input.a.page1.xmam019"
            #備註：基本上此欄位應該是不會被修改 但還是先寫完基本的檢查 
            LET g_xmam_d[l_ac].xmam019_desc = ' '
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam019)
                 RETURNING g_xmam_d[l_ac].xmam019_desc
            IF NOT cl_null(g_xmam_d[l_ac].xmam019) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam019 != g_xmam_d_o.xmam019 OR
                                                   g_xmam_d_o.xmam019 IS NULL)) THEN
                  #先寫好 以後有需要的話只需補上校驗即可 
                  #IF NOT cl_chk_exist("") THEN 
                  #   LET g_xmam_d[l_ac].xmam019 = g_xmam_d_o.xmam019 
                  #   CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam019) 
                  #        RETURNING g_xmam_d[l_ac].xmam019_desc 
                  #   NEXT FIELD CURRENT 
                  #END IF 
               END IF
            END IF

            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam019)
                 RETURNING g_xmam_d[l_ac].xmam019_desc

            LET g_xmam_d_o.xmam019 = g_xmam_d[l_ac].xmam019

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam019
            #add-point:BEFORE FIELD xmam019 name="input.b.page1.xmam019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam019
            #add-point:ON CHANGE xmam019 name="input.g.page1.xmam019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam015,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmam015
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam015 name="input.a.page1.xmam015"
            IF NOT cl_null(g_xmam_d[l_ac].xmam015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam015
            #add-point:BEFORE FIELD xmam015 name="input.b.page1.xmam015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam015
            #add-point:ON CHANGE xmam015 name="input.g.page1.xmam015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam016
            
            #add-point:AFTER FIELD xmam016 name="input.a.page1.xmam016"
            LET g_xmam_d[l_ac].xmam016_desc = ' '
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam016)
                 RETURNING g_xmam_d[l_ac].xmam016_desc
            
            IF NOT cl_null(g_xmam_d[l_ac].xmam016) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam016 != g_xmam_d_o.xmam016 OR
                                                   g_xmam_d_o.xmam016 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmam_d[l_ac].xmam016
                  LET g_chkparam.arg2 = '3'
                  #160318-00025#17 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#17 by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooca001_2") THEN
                     LET g_xmam_d[l_ac].xmam016 = g_xmam_d_o.xmam016
                     CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam016)
                          RETURNING g_xmam_d[l_ac].xmam016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam016)
                 RETURNING g_xmam_d[l_ac].xmam016_desc

            LET g_xmam_d_o.xmam016 = g_xmam_d[l_ac].xmam016

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam016
            #add-point:BEFORE FIELD xmam016 name="input.b.page1.xmam016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam016
            #add-point:ON CHANGE xmam016 name="input.g.page1.xmam016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam017
            #add-point:BEFORE FIELD xmam017 name="input.b.page1.xmam017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam017
            
            #add-point:AFTER FIELD xmam017 name="input.a.page1.xmam017"
            IF g_xmam_d[l_ac].xmam017 = 'N' THEN
               LET g_xmam_d[l_ac].xmam018      = ''
               LET g_xmam_d[l_ac].xmam018_desc = ''

               #備份舊值 
               LET g_xmam_d_o.xmam018 = g_xmam_d[l_ac].xmam018
            END IF
            
            CALL axmi230_set_entry_b(l_cmd)
            CALL axmi230_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam017
            #add-point:ON CHANGE xmam017 name="input.g.page1.xmam017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam018
            
            #add-point:AFTER FIELD xmam018 name="input.a.page1.xmam018"
            LET g_xmam_d[l_ac].xmam018_desc = ' '
            CALL axmi230_xmam018_ref(g_xmam_d[l_ac].xmam018)
                 RETURNING g_xmam_d[l_ac].xmam018_desc
            
            IF NOT cl_null(g_xmam_d[l_ac].xmam018) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam018 != g_xmam_d_o.xmam018 OR
                                                   g_xmam_d_o.xmam018 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmam_d[l_ac].xmam018
                  IF NOT cl_chk_exist("v_xmam001") THEN
                     LET g_xmam_d[l_ac].xmam018 = g_xmam_d_o.xmam018
                     CALL axmi230_xmam018_ref(g_xmam_d[l_ac].xmam018)
                          RETURNING g_xmam_d[l_ac].xmam018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            #add--160912-00037#1 By shiun--(S)
            IF (NOT cl_null(g_xmam_d[l_ac].xmam010)) AND (NOT cl_null(g_xmam_d[l_ac].xmam011)) AND (NOT cl_null(g_xmam_d[l_ac].xmam012)) THEN               
               IF g_xmam_d[l_ac].xmam003 = '2' AND g_xmam_d[l_ac].xmam017 = 'Y' THEN
                  CALL axmi230_xmam008_ref() RETURNING g_xmam_d[l_ac].xmam008
               END IF               
            END IF
            #add--160912-00037#1 By shiun--(E)
            CALL axmi230_xmam018_ref(g_xmam_d[l_ac].xmam018)
                 RETURNING g_xmam_d[l_ac].xmam018_desc

            LET g_xmam_d_o.xmam018 = g_xmam_d[l_ac].xmam018

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam018
            #add-point:BEFORE FIELD xmam018 name="input.b.page1.xmam018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam018
            #add-point:ON CHANGE xmam018 name="input.g.page1.xmam018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam018_desc
            #add-point:BEFORE FIELD xmam018_desc name="input.b.page1.xmam018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam018_desc
            
            #add-point:AFTER FIELD xmam018_desc name="input.a.page1.xmam018_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam018_desc
            #add-point:ON CHANGE xmam018_desc name="input.g.page1.xmam018_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmam005
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam005 name="input.a.page1.xmam005"
            IF NOT cl_null(g_xmam_d[l_ac].xmam005) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam005 != g_xmam_d_o.xmam005 OR
                                                   g_xmam_d_o.xmam005 IS NULL)) THEN
                  #長面個數 寬面個數 高面個數都有值時 自動推算包裝總數量 
                  IF (NOT cl_null(g_xmam_d[l_ac].xmam006)) AND
                     (NOT cl_null(g_xmam_d[l_ac].xmam007)) THEN
                     LET g_xmam_d[l_ac].xmam008 = g_xmam_d[l_ac].xmam005 *
                                                  g_xmam_d[l_ac].xmam006 *
                                                  g_xmam_d[l_ac].xmam007
                  END IF
               END IF
            END IF 

            LET g_xmam_d_o.xmam005 = g_xmam_d[l_ac].xmam005

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam005
            #add-point:BEFORE FIELD xmam005 name="input.b.page1.xmam005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam005
            #add-point:ON CHANGE xmam005 name="input.g.page1.xmam005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmam006
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam006 name="input.a.page1.xmam006"
            IF NOT cl_null(g_xmam_d[l_ac].xmam006) THEN  
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam006 != g_xmam_d_o.xmam006 OR
                                                   g_xmam_d_o.xmam006 IS NULL)) THEN
                  #長面個數 寬面個數 高面個數都有值時 自動推算包裝總數量 
                  IF (NOT cl_null(g_xmam_d[l_ac].xmam005)) AND
                     (NOT cl_null(g_xmam_d[l_ac].xmam007)) THEN
                     LET g_xmam_d[l_ac].xmam008 = g_xmam_d[l_ac].xmam005 *
                                                  g_xmam_d[l_ac].xmam006 *
                                                  g_xmam_d[l_ac].xmam007
                  END IF
               END IF
            END IF 

            LET g_xmam_d_o.xmam006 = g_xmam_d[l_ac].xmam006

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam006
            #add-point:BEFORE FIELD xmam006 name="input.b.page1.xmam006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam006
            #add-point:ON CHANGE xmam006 name="input.g.page1.xmam006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmam007
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam007 name="input.a.page1.xmam007"
            IF NOT cl_null(g_xmam_d[l_ac].xmam007) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam007 != g_xmam_d_o.xmam007 OR
                                                   g_xmam_d_o.xmam007 IS NULL)) THEN
                  #長面個數 寬面個數 高面個數都有值時 自動推算包裝總數量 
                  IF (NOT cl_null(g_xmam_d[l_ac].xmam005)) AND
                     (NOT cl_null(g_xmam_d[l_ac].xmam006)) THEN
                     LET g_xmam_d[l_ac].xmam008 = g_xmam_d[l_ac].xmam005 *
                                                  g_xmam_d[l_ac].xmam006 *
                                                  g_xmam_d[l_ac].xmam007
                  END IF
               END IF
            END IF 

            LET g_xmam_d_o.xmam007 = g_xmam_d[l_ac].xmam007

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam007
            #add-point:BEFORE FIELD xmam007 name="input.b.page1.xmam007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam007
            #add-point:ON CHANGE xmam007 name="input.g.page1.xmam007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmam_d[l_ac].xmam008,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmam008
            END IF 
 
 
 
            #add-point:AFTER FIELD xmam008 name="input.a.page1.xmam008"
            IF NOT cl_null(g_xmam_d[l_ac].xmam008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam008
            #add-point:BEFORE FIELD xmam008 name="input.b.page1.xmam008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam008
            #add-point:ON CHANGE xmam008 name="input.g.page1.xmam008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmam009
            
            #add-point:AFTER FIELD xmam009 name="input.a.page1.xmam009"
            LET g_xmam_d[l_ac].xmam009_desc = ' '
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam009)
                 RETURNING g_xmam_d[l_ac].xmam009_desc
            
            IF NOT cl_null(g_xmam_d[l_ac].xmam009) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xmam_d[l_ac].xmam009 != g_xmam_d_o.xmam009 OR
                                                   g_xmam_d_o.xmam009 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmam_d[l_ac].xmam009
                  #160318-00025#17 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#17 by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_xmam_d[l_ac].xmam009 = g_xmam_d_o.xmam009
                     CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam009)
                          RETURNING g_xmam_d[l_ac].xmam009_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam009)
                 RETURNING g_xmam_d[l_ac].xmam009_desc

            LET g_xmam_d_o.xmam009 = g_xmam_d[l_ac].xmam009

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmam009
            #add-point:BEFORE FIELD xmam009 name="input.b.page1.xmam009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmam009
            #add-point:ON CHANGE xmam009 name="input.g.page1.xmam009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmamstus
            #add-point:BEFORE FIELD xmamstus name="input.b.page1.xmamstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmamstus
            
            #add-point:AFTER FIELD xmamstus name="input.a.page1.xmamstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmamstus
            #add-point:ON CHANGE xmamstus name="input.g.page1.xmamstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmam001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam001
            #add-point:ON ACTION controlp INFIELD xmam001 name="input.c.page1.xmam001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaml003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaml003
            #add-point:ON ACTION controlp INFIELD xmaml003 name="input.c.page1.xmaml003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaml004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaml004
            #add-point:ON ACTION controlp INFIELD xmaml004 name="input.c.page1.xmaml004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam003
            #add-point:ON ACTION controlp INFIELD xmam003 name="input.c.page1.xmam003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam004
            #add-point:ON ACTION controlp INFIELD xmam004 name="input.c.page1.xmam004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmam_d[l_ac].xmam004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001_5()                                #呼叫開窗

            LET g_xmam_d[l_ac].xmam004 = g_qryparam.return1              

            DISPLAY g_xmam_d[l_ac].xmam004 TO xmam004              #
            CALL s_desc_get_item_desc(g_xmam_d[l_ac].xmam004)
                 RETURNING g_xmam_d[l_ac].xmam004_desc,
                           g_xmam_d[l_ac].xmam004_desc_1
            NEXT FIELD xmam004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam010
            #add-point:ON ACTION controlp INFIELD xmam010 name="input.c.page1.xmam010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam011
            #add-point:ON ACTION controlp INFIELD xmam011 name="input.c.page1.xmam011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam012
            #add-point:ON ACTION controlp INFIELD xmam012 name="input.c.page1.xmam012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam014
            #add-point:ON ACTION controlp INFIELD xmam014 name="input.c.page1.xmam014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmam_d[l_ac].xmam014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " ooca003 = '2' "
            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xmam_d[l_ac].xmam014 = g_qryparam.return1              

            DISPLAY g_xmam_d[l_ac].xmam014 TO xmam014              #
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam014)
                 RETURNING g_xmam_d[l_ac].xmam014_desc
            NEXT FIELD xmam014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam013
            #add-point:ON ACTION controlp INFIELD xmam013 name="input.c.page1.xmam013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam019
            #add-point:ON ACTION controlp INFIELD xmam019 name="input.c.page1.xmam019"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmam_d[l_ac].xmam019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " ooca003 = '5' "
            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xmam_d[l_ac].xmam019 = g_qryparam.return1              

            DISPLAY g_xmam_d[l_ac].xmam019 TO xmam019              #
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam019)
                 RETURNING g_xmam_d[l_ac].xmam019_desc
            NEXT FIELD xmam019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam015
            #add-point:ON ACTION controlp INFIELD xmam015 name="input.c.page1.xmam015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam016
            #add-point:ON ACTION controlp INFIELD xmam016 name="input.c.page1.xmam016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmam_d[l_ac].xmam016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " ooca003 = '3' "
            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xmam_d[l_ac].xmam016 = g_qryparam.return1              

            DISPLAY g_xmam_d[l_ac].xmam016 TO xmam016              #
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam016)
                 RETURNING g_xmam_d[l_ac].xmam016_desc
            NEXT FIELD xmam016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam017
            #add-point:ON ACTION controlp INFIELD xmam017 name="input.c.page1.xmam017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam018
            #add-point:ON ACTION controlp INFIELD xmam018 name="input.c.page1.xmam018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmam_d[l_ac].xmam018             #給予default值
            LET g_qryparam.default2 = "" #g_xmam_d[l_ac].xmaml003 #包裝說明
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xmam001()                                #呼叫開窗

            LET g_xmam_d[l_ac].xmam018 = g_qryparam.return1              
            #LET g_xmam_d[l_ac].xmaml003 = g_qryparam.return2 
            DISPLAY g_xmam_d[l_ac].xmam018 TO xmam018              #
            #DISPLAY g_xmam_d[l_ac].xmaml003 TO xmaml003 #包裝說明 
            CALL axmi230_xmam018_ref(g_xmam_d[l_ac].xmam018)
                 RETURNING g_xmam_d[l_ac].xmam018_desc
            NEXT FIELD xmam018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam018_desc
            #add-point:ON ACTION controlp INFIELD xmam018_desc name="input.c.page1.xmam018_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam005
            #add-point:ON ACTION controlp INFIELD xmam005 name="input.c.page1.xmam005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam006
            #add-point:ON ACTION controlp INFIELD xmam006 name="input.c.page1.xmam006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam007
            #add-point:ON ACTION controlp INFIELD xmam007 name="input.c.page1.xmam007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam008
            #add-point:ON ACTION controlp INFIELD xmam008 name="input.c.page1.xmam008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmam009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmam009
            #add-point:ON ACTION controlp INFIELD xmam009 name="input.c.page1.xmam009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmam_d[l_ac].xmam009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xmam_d[l_ac].xmam009 = g_qryparam.return1              

            DISPLAY g_xmam_d[l_ac].xmam009 TO xmam009              #
            CALL s_desc_get_unit_desc(g_xmam_d[l_ac].xmam009)
                 RETURNING g_xmam_d[l_ac].xmam009_desc
            NEXT FIELD xmam009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmamstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmamstus
            #add-point:ON ACTION controlp INFIELD xmamstus name="input.c.page1.xmamstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE axmi230_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_xmam_d[l_ac].* = g_xmam_d_t.*
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
               LET g_errparam.extend = g_xmam_d[l_ac].xmam001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmam_d[l_ac].* = g_xmam_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_xmam2_d[l_ac].xmammodid = g_user 
LET g_xmam2_d[l_ac].xmammoddt = cl_get_current()
LET g_xmam2_d[l_ac].xmammodid_desc = cl_get_username(g_xmam2_d[l_ac].xmammodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axmi230_xmam_t_mask_restore('restore_mask_o')
 
               UPDATE xmam_t SET (xmam001,xmam003,xmam004,xmam010,xmam011,xmam012,xmam014,xmam013,xmam019, 
                   xmam015,xmam016,xmam017,xmam018,xmam005,xmam006,xmam007,xmam008,xmam009,xmamstus, 
                   xmamownid,xmamowndp,xmamcrtid,xmamcrtdp,xmamcrtdt,xmammodid,xmammoddt) = (g_xmam_d[l_ac].xmam001, 
                   g_xmam_d[l_ac].xmam003,g_xmam_d[l_ac].xmam004,g_xmam_d[l_ac].xmam010,g_xmam_d[l_ac].xmam011, 
                   g_xmam_d[l_ac].xmam012,g_xmam_d[l_ac].xmam014,g_xmam_d[l_ac].xmam013,g_xmam_d[l_ac].xmam019, 
                   g_xmam_d[l_ac].xmam015,g_xmam_d[l_ac].xmam016,g_xmam_d[l_ac].xmam017,g_xmam_d[l_ac].xmam018, 
                   g_xmam_d[l_ac].xmam005,g_xmam_d[l_ac].xmam006,g_xmam_d[l_ac].xmam007,g_xmam_d[l_ac].xmam008, 
                   g_xmam_d[l_ac].xmam009,g_xmam_d[l_ac].xmamstus,g_xmam2_d[l_ac].xmamownid,g_xmam2_d[l_ac].xmamowndp, 
                   g_xmam2_d[l_ac].xmamcrtid,g_xmam2_d[l_ac].xmamcrtdp,g_xmam2_d[l_ac].xmamcrtdt,g_xmam2_d[l_ac].xmammodid, 
                   g_xmam2_d[l_ac].xmammoddt)
                WHERE xmament = g_enterprise AND
                  xmam001 = g_xmam_d_t.xmam001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmam_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmam_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmam_d[g_detail_idx].xmam001
               LET gs_keys_bak[1] = g_xmam_d_t.xmam001
               CALL axmi230_update_b('xmam_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xmam_d[l_ac].xmam001 = g_detail_multi_table_t.xmaml001 AND
         g_xmam_d[l_ac].xmaml003 = g_detail_multi_table_t.xmaml003 AND
         g_xmam_d[l_ac].xmaml004 = g_detail_multi_table_t.xmaml004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'xmamlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_xmam_d[l_ac].xmam001
            LET l_field_keys[02] = 'xmaml001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xmaml001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'xmaml002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.xmaml002
            LET l_vars[01] = g_xmam_d[l_ac].xmaml003
            LET l_fields[01] = 'xmaml003'
            LET l_vars[02] = g_xmam_d[l_ac].xmaml004
            LET l_fields[02] = 'xmaml004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xmaml_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xmam_d_t)
                     LET g_log2 = util.JSON.stringify(g_xmam_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmi230_xmam_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL axmi230_unlock_b("xmam_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmam_d[l_ac].* = g_xmam_d_t.*
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
               LET g_xmam_d[li_reproduce_target].* = g_xmam_d[li_reproduce].*
               LET g_xmam2_d[li_reproduce_target].* = g_xmam2_d[li_reproduce].*
 
               LET g_xmam_d[li_reproduce_target].xmam001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmam_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmam_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_xmam2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL axmi230_b_fill(g_wc2)
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
               NEXT FIELD xmam001
            WHEN "s_detail2"
               NEXT FIELD xmam001_2
 
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
      IF INT_FLAG OR cl_null(g_xmam_d[g_detail_idx].xmam001) THEN
         CALL g_xmam_d.deleteElement(g_detail_idx)
         CALL g_xmam2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_xmam_d[g_detail_idx].* = g_xmam_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE axmi230_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="axmi230.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmi230_delete()
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
   FOR li_idx = 1 TO g_xmam_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT axmi230_lock_b("xmam_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("xmam_t","xmamownid") THEN
            LET g_data_owner = g_xmam2_d[g_detail_idx].xmamownid
            LET g_data_dept = g_xmam2_d[g_detail_idx].xmamowndp
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
   
   FOR li_idx = 1 TO g_xmam_d.getLength()
      IF g_xmam_d[li_idx].xmam001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM xmam_t
          WHERE xmament = g_enterprise AND 
                xmam001 = g_xmam_d[li_idx].xmam001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmam_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.xmaml001 = g_xmam_d[l_ac].xmam001
LET g_detail_multi_table_t.xmaml002 = g_dlang
LET g_detail_multi_table_t.xmaml003 = g_xmam_d[l_ac].xmaml003
LET g_detail_multi_table_t.xmaml004 = g_xmam_d[l_ac].xmaml004
 
 
            
LET g_detail_multi_table_t.xmaml001 = g_xmam_d[l_ac].xmam001
LET g_detail_multi_table_t.xmaml002 = g_dlang
LET g_detail_multi_table_t.xmaml003 = g_xmam_d[l_ac].xmaml003
LET g_detail_multi_table_t.xmaml004 = g_xmam_d[l_ac].xmaml004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xmamlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'xmaml001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xmaml001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xmaml_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xmamlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'xmaml001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xmaml001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xmaml_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmam_d_t.xmam001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL axmi230_delete_b('xmam_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmi230_set_pk_array()
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
   CALL axmi230_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="axmi230.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmi230_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.xmam001,t0.xmam003,t0.xmam004,t0.xmam010,t0.xmam011,t0.xmam012,t0.xmam014, 
       t0.xmam013,t0.xmam019,t0.xmam015,t0.xmam016,t0.xmam017,t0.xmam018,t0.xmam005,t0.xmam006,t0.xmam007, 
       t0.xmam008,t0.xmam009,t0.xmamstus,t0.xmam001,t0.xmamownid,t0.xmamowndp,t0.xmamcrtid,t0.xmamcrtdp, 
       t0.xmamcrtdt,t0.xmammodid,t0.xmammoddt ,t1.imaal003 ,t2.oocal003 ,t3.oocal003 ,t4.oocal003 ,t5.oocal003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 FROM xmam_t t0",
               " LEFT JOIN xmaml_t ON xmamlent = "||g_enterprise||" AND xmam001 = xmaml001 AND xmaml002 = '",g_dlang,"'",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.xmam004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.xmam014 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.xmam019 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.xmam016 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.xmam009 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xmamownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.xmamowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.xmamcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.xmamcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.xmammodid  ",
 
               " WHERE t0.xmament= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("xmam_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND xmamowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("xmam_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND xmamownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("xmam_t"),
                      " ORDER BY t0.xmam001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmam_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axmi230_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmi230_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xmam_d.clear()
   CALL g_xmam2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_xmam_d[l_ac].xmam001,g_xmam_d[l_ac].xmam003,g_xmam_d[l_ac].xmam004,g_xmam_d[l_ac].xmam010, 
       g_xmam_d[l_ac].xmam011,g_xmam_d[l_ac].xmam012,g_xmam_d[l_ac].xmam014,g_xmam_d[l_ac].xmam013,g_xmam_d[l_ac].xmam019, 
       g_xmam_d[l_ac].xmam015,g_xmam_d[l_ac].xmam016,g_xmam_d[l_ac].xmam017,g_xmam_d[l_ac].xmam018,g_xmam_d[l_ac].xmam005, 
       g_xmam_d[l_ac].xmam006,g_xmam_d[l_ac].xmam007,g_xmam_d[l_ac].xmam008,g_xmam_d[l_ac].xmam009,g_xmam_d[l_ac].xmamstus, 
       g_xmam2_d[l_ac].xmam001,g_xmam2_d[l_ac].xmamownid,g_xmam2_d[l_ac].xmamowndp,g_xmam2_d[l_ac].xmamcrtid, 
       g_xmam2_d[l_ac].xmamcrtdp,g_xmam2_d[l_ac].xmamcrtdt,g_xmam2_d[l_ac].xmammodid,g_xmam2_d[l_ac].xmammoddt, 
       g_xmam_d[l_ac].xmam004_desc,g_xmam_d[l_ac].xmam014_desc,g_xmam_d[l_ac].xmam019_desc,g_xmam_d[l_ac].xmam016_desc, 
       g_xmam_d[l_ac].xmam009_desc,g_xmam2_d[l_ac].xmamownid_desc,g_xmam2_d[l_ac].xmamowndp_desc,g_xmam2_d[l_ac].xmamcrtid_desc, 
       g_xmam2_d[l_ac].xmamcrtdp_desc,g_xmam2_d[l_ac].xmammodid_desc
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
      
      CALL axmi230_detail_show()      
 
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
   
 
   
   CALL g_xmam_d.deleteElement(g_xmam_d.getLength())   
   CALL g_xmam2_d.deleteElement(g_xmam2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_xmam_d.getLength()
      LET g_xmam2_d[l_ac].xmam001 = g_xmam_d[l_ac].xmam001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_xmam_d.getLength() THEN
      LET l_ac = g_xmam_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmam_d.getLength()
      LET g_xmam_d_mask_o[l_ac].* =  g_xmam_d[l_ac].*
      CALL axmi230_xmam_t_mask()
      LET g_xmam_d_mask_n[l_ac].* =  g_xmam_d[l_ac].*
   END FOR
   
   LET g_xmam2_d_mask_o.* =  g_xmam2_d.*
   FOR l_ac = 1 TO g_xmam2_d.getLength()
      LET g_xmam2_d_mask_o[l_ac].* =  g_xmam2_d[l_ac].*
      CALL axmi230_xmam_t_mask()
      LET g_xmam2_d_mask_n[l_ac].* =  g_xmam2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_xmam_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE axmi230_pb
   
END FUNCTION
 
{</section>}
 
{<section id="axmi230.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmi230_detail_show()
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

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_xmam_d[l_ac].xmam001
   CALL ap_ref_array2(g_ref_fields," SELECT xmaml003,xmaml004 FROM xmaml_t WHERE xmamlent = '"||g_enterprise||"' AND xmaml001 = ? AND xmaml002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_xmam_d[l_ac].xmaml003 = g_rtn_fields[1] 
   LET g_xmam_d[l_ac].xmaml004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_xmam_d[l_ac].xmaml003,g_xmam_d[l_ac].xmaml004
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   CALL s_desc_get_item_desc(g_xmam_d[l_ac].xmam004)
        RETURNING g_xmam_d[l_ac].xmam004_desc,
                  g_xmam_d[l_ac].xmam004_desc_1 
                  
   CALL axmi230_xmam018_ref(g_xmam_d[l_ac].xmam018)
        RETURNING g_xmam_d[l_ac].xmam018_desc
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmi230.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmi230_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("xmam005,xmam006,xmam007,xmam008,xmam009",TRUE)

   CALL cl_set_comp_entry("xmam018",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="axmi230.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmi230_set_no_entry_b(p_cmd)                                               
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
   IF g_xmam_d[l_ac].xmam003 = '2' THEN
      CALL cl_set_comp_entry("xmam005,xmam006,xmam007,xmam008,xmam009",FALSE)
   END IF

   IF g_xmam_d[l_ac].xmam017 = 'N' THEN
      CALL cl_set_comp_entry("xmam018",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="axmi230.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmi230_default_search()
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
      LET ls_wc = ls_wc, " xmam001 = '", g_argv[01], "' AND "
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
 
{<section id="axmi230.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmi230_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "xmam_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'xmam_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM xmam_t
          WHERE xmament = g_enterprise AND
            xmam001 = ps_keys_bak[1]
         
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
         CALL g_xmam_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xmam2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmi230.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmi230_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "xmam_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO xmam_t
                  (xmament,
                   xmam001
                   ,xmam003,xmam004,xmam010,xmam011,xmam012,xmam014,xmam013,xmam019,xmam015,xmam016,xmam017,xmam018,xmam005,xmam006,xmam007,xmam008,xmam009,xmamstus,xmamownid,xmamowndp,xmamcrtid,xmamcrtdp,xmamcrtdt,xmammodid,xmammoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_xmam_d[l_ac].xmam003,g_xmam_d[l_ac].xmam004,g_xmam_d[l_ac].xmam010,g_xmam_d[l_ac].xmam011, 
                       g_xmam_d[l_ac].xmam012,g_xmam_d[l_ac].xmam014,g_xmam_d[l_ac].xmam013,g_xmam_d[l_ac].xmam019, 
                       g_xmam_d[l_ac].xmam015,g_xmam_d[l_ac].xmam016,g_xmam_d[l_ac].xmam017,g_xmam_d[l_ac].xmam018, 
                       g_xmam_d[l_ac].xmam005,g_xmam_d[l_ac].xmam006,g_xmam_d[l_ac].xmam007,g_xmam_d[l_ac].xmam008, 
                       g_xmam_d[l_ac].xmam009,g_xmam_d[l_ac].xmamstus,g_xmam2_d[l_ac].xmamownid,g_xmam2_d[l_ac].xmamowndp, 
                       g_xmam2_d[l_ac].xmamcrtid,g_xmam2_d[l_ac].xmamcrtdp,g_xmam2_d[l_ac].xmamcrtdt, 
                       g_xmam2_d[l_ac].xmammodid,g_xmam2_d[l_ac].xmammoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmam_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmi230.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmi230_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "xmam_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "xmam_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE xmam_t 
         SET (xmam001
              ,xmam003,xmam004,xmam010,xmam011,xmam012,xmam014,xmam013,xmam019,xmam015,xmam016,xmam017,xmam018,xmam005,xmam006,xmam007,xmam008,xmam009,xmamstus,xmamownid,xmamowndp,xmamcrtid,xmamcrtdp,xmamcrtdt,xmammodid,xmammoddt) 
              = 
             (ps_keys[1]
              ,g_xmam_d[l_ac].xmam003,g_xmam_d[l_ac].xmam004,g_xmam_d[l_ac].xmam010,g_xmam_d[l_ac].xmam011, 
                  g_xmam_d[l_ac].xmam012,g_xmam_d[l_ac].xmam014,g_xmam_d[l_ac].xmam013,g_xmam_d[l_ac].xmam019, 
                  g_xmam_d[l_ac].xmam015,g_xmam_d[l_ac].xmam016,g_xmam_d[l_ac].xmam017,g_xmam_d[l_ac].xmam018, 
                  g_xmam_d[l_ac].xmam005,g_xmam_d[l_ac].xmam006,g_xmam_d[l_ac].xmam007,g_xmam_d[l_ac].xmam008, 
                  g_xmam_d[l_ac].xmam009,g_xmam_d[l_ac].xmamstus,g_xmam2_d[l_ac].xmamownid,g_xmam2_d[l_ac].xmamowndp, 
                  g_xmam2_d[l_ac].xmamcrtid,g_xmam2_d[l_ac].xmamcrtdp,g_xmam2_d[l_ac].xmamcrtdt,g_xmam2_d[l_ac].xmammodid, 
                  g_xmam2_d[l_ac].xmammoddt) 
         WHERE xmament = g_enterprise AND xmam001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmam_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmam_t:",SQLERRMESSAGE 
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
 
{<section id="axmi230.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmi230_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axmi230_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "xmam_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmi230_bcl USING g_enterprise,
                                       g_xmam_d[g_detail_idx].xmam001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmi230_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmi230.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmi230_unlock_b(ps_table)
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
      CLOSE axmi230_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmi230.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION axmi230_modify_detail_chk(ps_record)
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
         LET ls_return = "xmam001"
      WHEN "s_detail2"
         LET ls_return = "xmam001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axmi230.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION axmi230_show_ownid_msg()
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
 
{<section id="axmi230.mask_functions" >}
&include "erp/axm/axmi230_mask.4gl"
 
{</section>}
 
{<section id="axmi230.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmi230_set_pk_array()
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
   LET g_pk_array[1].values = g_xmam_d[l_ac].xmam001
   LET g_pk_array[1].column = 'xmam001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi230.state_change" >}
   
 
{</section>}
 
{<section id="axmi230.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="axmi230.other_function" readonly="Y" >}

PRIVATE FUNCTION axmi230_xmam018_ref(p_xmaml001)
   DEFINE p_xmaml001     LIKE xmaml_t.xmaml001
   DEFINE r_xmaml003     LIKE xmaml_t.xmaml003

   LET r_xmaml003 = ''
   SELECT xmaml003 INTO r_xmaml003
     FROM xmaml_t
    WHERE xmamlent = g_enterprise
      AND xmaml001 = p_xmaml001
      AND xmaml002 = g_dlang

   RETURN r_xmaml003
END FUNCTION

PRIVATE FUNCTION axmi230_set_required_b(p_cmd)
   DEFINE p_cmd     LIKE type_t.chr1

   #IF g_xmam_d[l_ac].xmam003 = '1' THEN
   #   CALL cl_set_comp_required("xmam008",TRUE)
   #END IF
END FUNCTION

PRIVATE FUNCTION axmi230_set_no_required_b(p_cmd)
   DEFINE p_cmd     LIKE type_t.chr1

   #CALL cl_set_comp_required("xmam008",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 計算總包裝數量
# Memo...........: #160912-00037#1
# Usage..........: CALL axmi230_xmam008_ref()
#                  RETURNING r_xmam008
# Input parameter: 
# Return code....: r_xmam008   總包裝數量
# Date & Author..: 2016/10/05 By shiun
# Modify.........: 
################################################################################
PRIVATE FUNCTION axmi230_xmam008_ref()
   DEFINE l_xmam013   LIKE xmam_t.xmam013   #內包裝體積
   DEFINE l_xmam019   LIKE xmam_t.xmam019   #內包裝體積單位
   DEFINE l_rate      LIKE type_t.num26_10  #單位換算率
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_error     LIKE type_t.num5
   DEFINE l_xmam008   LIKE type_t.num26_10  #數量計算
   DEFINE r_xmam008   LIKE xmam_t.xmam008
   
   LET l_xmam013 = ''
   LET l_xmam019 = ''
   
   SELECT xmam013,xmam019 INTO l_xmam013,l_xmam019
     FROM xmam_t
    WHERE xmament = g_enterprise
      AND xmam001 = g_xmam_d[l_ac].xmam018
      
   LET l_rate = 1
   IF l_xmam019 <> g_xmam_d[l_ac].xmam019 THEN
#      CALL (g_xmam_d[l_ac].xmam019,l_xmam019,'1') RETURNING l_success,l_error,l_rate
      CALL s_aimi190_get_convrate('',g_xmam_d[l_ac].xmam019,l_xmam019) RETURNING l_success,l_rate
   END IF
   
   LET l_xmam008 = g_xmam_d[l_ac].xmam013 / l_xmam013 * l_rate
   
   CALL s_num_round('3',l_xmam008,0) RETURNING r_xmam008
   
   RETURN r_xmam008
   
END FUNCTION

 
{</section>}
 
