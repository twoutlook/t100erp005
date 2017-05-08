#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi180.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-06-27 14:24:12), PR版次:0007(2016-11-10 16:51:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000142
#+ Filename...: aooi180
#+ Description: 銷售通路基本資料維護作業
#+ Creator....: 04226(2014-04-29 11:42:18)
#+ Modifier...: 06814 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi180.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160324-00038#35  160705 By Polly 應開帳需求，將檢查改為元件
#161108-00012#2   2016/11/09 By 08734   g_browser_cnt 由num5改為num10
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
PRIVATE TYPE type_g_oojd_d RECORD
       oojdstus LIKE oojd_t.oojdstus, 
   oojd001 LIKE oojd_t.oojd001, 
   oojdl003 LIKE type_t.chr500, 
   oojdl004 LIKE type_t.chr500, 
   oojd002 LIKE oojd_t.oojd002, 
   oojd003 LIKE oojd_t.oojd003, 
   oojd004 LIKE oojd_t.oojd004
       END RECORD
PRIVATE TYPE type_g_oojd2_d RECORD
       oojd001 LIKE oojd_t.oojd001, 
   oojdownid LIKE oojd_t.oojdownid, 
   oojdownid_desc LIKE type_t.chr500, 
   oojdowndp LIKE oojd_t.oojdowndp, 
   oojdowndp_desc LIKE type_t.chr500, 
   oojdcrtid LIKE oojd_t.oojdcrtid, 
   oojdcrtid_desc LIKE type_t.chr500, 
   oojdcrtdp LIKE oojd_t.oojdcrtdp, 
   oojdcrtdp_desc LIKE type_t.chr500, 
   oojdcrtdt DATETIME YEAR TO SECOND, 
   oojdmodid LIKE oojd_t.oojdmodid, 
   oojdmodid_desc LIKE type_t.chr500, 
   oojdmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      oojdl001 LIKE oojdl_t.oojdl001,
      oojdl002 LIKE oojdl_t.oojdl002,
      oojdl003 LIKE oojdl_t.oojdl003,
      oojdl004 LIKE oojdl_t.oojdl004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#Tree:變數---
DEFINE g_tree    DYNAMIC ARRAY OF RECORD      #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
       b_oojd003       LIKE oojd_t.oojd003,
       b_oojd001       LIKE oojd_t.oojd001
                       END RECORD
DEFINE g_root_search   BOOLEAN
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
#DEFINE g_browser_cnt   LIKE type_t.num5            #total count   #161108-00012#2  2016/11/09 By 08734 mark
DEFINE g_browser_cnt   LIKE type_t.num10            #total count   #161108-00012#2  2016/11/09 By 08734 add
DEFINE g_first         LIKE type_t.chr1            #紀錄是否是程式剛開始進入狀態
DEFINE g_current_idx   LIKE type_t.num10           #Browser所在筆數
DEFINE g_current_row   LIKE type_t.num10  #161108-00012#2 num5==》num10
#Tree:變數---
#end add-point
 
#模組變數(Module Variables)
DEFINE g_oojd_d          DYNAMIC ARRAY OF type_g_oojd_d #單身變數
DEFINE g_oojd_d_t        type_g_oojd_d                  #單身備份
DEFINE g_oojd_d_o        type_g_oojd_d                  #單身備份
DEFINE g_oojd_d_mask_o   DYNAMIC ARRAY OF type_g_oojd_d #單身變數
DEFINE g_oojd_d_mask_n   DYNAMIC ARRAY OF type_g_oojd_d #單身變數
DEFINE g_oojd2_d   DYNAMIC ARRAY OF type_g_oojd2_d
DEFINE g_oojd2_d_t type_g_oojd2_d
DEFINE g_oojd2_d_o type_g_oojd2_d
DEFINE g_oojd2_d_mask_o DYNAMIC ARRAY OF type_g_oojd2_d
DEFINE g_oojd2_d_mask_n DYNAMIC ARRAY OF type_g_oojd2_d
 
      
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
 
{<section id="aooi180.main" >}
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
   LET g_forupd_sql = "SELECT oojdstus,oojd001,oojd002,oojd003,oojd004,oojd001,oojdownid,oojdowndp,oojdcrtid, 
       oojdcrtdp,oojdcrtdt,oojdmodid,oojdmoddt FROM oojd_t WHERE oojdent=? AND oojd001=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi180_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi180 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi180_init()   
 
      #進入選單 Menu (="N")
      CALL aooi180_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi180
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi180.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aooi180_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_gzze003  LIKE gzze_t.gzze003
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('oojd002','6060') 
   CALL cl_set_combo_scc('oojd004','6739') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   CASE g_argv[1]
      WHEN '1'    #銷售
         CALL cl_set_combo_scc('oojd003','6061')
         CALL cl_set_combo_scc('oojd004','6739') #ken
      WHEN '2'    #採購
         CALL cl_set_combo_scc('oojd003','6062')
         LET l_gzze003 = cl_getmsg('aoo-00309',g_dlang)
         CALL cl_set_comp_att_text('name',l_gzze003)
         CALL cl_set_combo_scc('oojd004','6742') #ken
   END CASE

   #Tree---
   DROP TABLE aooi180_status
   CREATE TEMP TABLE aooi180_status(
      oojd003   LIKE oojd_t.oojd003,
      expanded  LIKE type_t.chr1)
   LET g_first = 0
   #Tree---
   #end add-point
   
   CALL aooi180_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi180.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aooi180_ui_dialog()
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
   #Tree
   CALL aooi180_browser_fill(g_wc2)
   LET g_first = 1
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_oojd_d.clear()
         CALL g_oojd2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aooi180_init()
      END IF
   
      CALL aooi180_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_oojd_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_oojd2_d[g_detail_idx].oojdownid   #(ver:35)
               LET g_data_dept = g_oojd2_d[g_detail_idx].oojdowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi180_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_oojd2_d TO s_detail2.*
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
   CALL aooi180_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #Tree
         DISPLAY ARRAY g_tree TO s_tree.*
            BEFORE DISPLAY
               CALL DIALOG.setSelectionMode("s_tree",1) #設定為單選

            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_tree")
               IF g_current_row > 1 THEN
                  CALL DIALOG.setCurrentRow("s_tree",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               CALL cl_show_fld_cont()
               CALL DIALOG.setCurrentRow("s_tree",g_current_row)

            ON EXPAND (g_current_row)
               #樹展開
               CALL aooi180_node_open(g_tree[g_current_row].b_oojd003)
            ON COLLAPSE (g_current_row)
               #樹關閉
               CALL aooi180_node_close(g_tree[g_current_row].b_oojd003)
         END DISPLAY
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
            CALL aooi180_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi180_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aooi180_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi180_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aooi180_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi180_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi180_insert()
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
               CALL aooi180_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_oojd_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_oojd2_d)
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
            CALL aooi180_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi180_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi180_set_pk_array()
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
 
{<section id="aooi180.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi180_query()
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
   CALL g_oojd_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON oojdstus,oojd001,oojdl003,oojdl004,oojd002,oojd003,oojd004,oojdownid,oojdowndp, 
          oojdcrtid,oojdcrtdp,oojdcrtdt,oojdmodid,oojdmoddt 
 
         FROM s_detail1[1].oojdstus,s_detail1[1].oojd001,s_detail1[1].oojdl003,s_detail1[1].oojdl004, 
             s_detail1[1].oojd002,s_detail1[1].oojd003,s_detail1[1].oojd004,s_detail2[1].oojdownid,s_detail2[1].oojdowndp, 
             s_detail2[1].oojdcrtid,s_detail2[1].oojdcrtdp,s_detail2[1].oojdcrtdt,s_detail2[1].oojdmodid, 
             s_detail2[1].oojdmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oojdcrtdt>>----
         AFTER FIELD oojdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oojdmoddt>>----
         AFTER FIELD oojdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oojdcnfdt>>----
         
         #----<<oojdpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdstus
            #add-point:BEFORE FIELD oojdstus name="query.b.page1.oojdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdstus
            
            #add-point:AFTER FIELD oojdstus name="query.a.page1.oojdstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oojdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdstus
            #add-point:ON ACTION controlp INFIELD oojdstus name="query.c.page1.oojdstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.oojd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd001
            #add-point:ON ACTION controlp INFIELD oojd001 name="construct.c.page1.oojd001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_argv[1]
            CALL q_oojd001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojd001  #顯示到畫面上
            NEXT FIELD oojd001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd001
            #add-point:BEFORE FIELD oojd001 name="query.b.page1.oojd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd001
            
            #add-point:AFTER FIELD oojd001 name="query.a.page1.oojd001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdl003
            #add-point:BEFORE FIELD oojdl003 name="query.b.page1.oojdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdl003
            
            #add-point:AFTER FIELD oojdl003 name="query.a.page1.oojdl003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oojdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdl003
            #add-point:ON ACTION controlp INFIELD oojdl003 name="query.c.page1.oojdl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdl004
            #add-point:BEFORE FIELD oojdl004 name="query.b.page1.oojdl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdl004
            
            #add-point:AFTER FIELD oojdl004 name="query.a.page1.oojdl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oojdl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdl004
            #add-point:ON ACTION controlp INFIELD oojdl004 name="query.c.page1.oojdl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd002
            #add-point:BEFORE FIELD oojd002 name="query.b.page1.oojd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd002
            
            #add-point:AFTER FIELD oojd002 name="query.a.page1.oojd002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oojd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd002
            #add-point:ON ACTION controlp INFIELD oojd002 name="query.c.page1.oojd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd003
            #add-point:BEFORE FIELD oojd003 name="query.b.page1.oojd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd003
            
            #add-point:AFTER FIELD oojd003 name="query.a.page1.oojd003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oojd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd003
            #add-point:ON ACTION controlp INFIELD oojd003 name="query.c.page1.oojd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd004
            #add-point:BEFORE FIELD oojd004 name="query.b.page1.oojd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd004
            
            #add-point:AFTER FIELD oojd004 name="query.a.page1.oojd004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oojd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd004
            #add-point:ON ACTION controlp INFIELD oojd004 name="query.c.page1.oojd004"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.oojdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdownid
            #add-point:ON ACTION controlp INFIELD oojdownid name="construct.c.page2.oojdownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojdownid  #顯示到畫面上
            NEXT FIELD oojdownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdownid
            #add-point:BEFORE FIELD oojdownid name="query.b.page2.oojdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdownid
            
            #add-point:AFTER FIELD oojdownid name="query.a.page2.oojdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oojdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdowndp
            #add-point:ON ACTION controlp INFIELD oojdowndp name="construct.c.page2.oojdowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojdowndp  #顯示到畫面上
            NEXT FIELD oojdowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdowndp
            #add-point:BEFORE FIELD oojdowndp name="query.b.page2.oojdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdowndp
            
            #add-point:AFTER FIELD oojdowndp name="query.a.page2.oojdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oojdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdcrtid
            #add-point:ON ACTION controlp INFIELD oojdcrtid name="construct.c.page2.oojdcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojdcrtid  #顯示到畫面上
            NEXT FIELD oojdcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdcrtid
            #add-point:BEFORE FIELD oojdcrtid name="query.b.page2.oojdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdcrtid
            
            #add-point:AFTER FIELD oojdcrtid name="query.a.page2.oojdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oojdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdcrtdp
            #add-point:ON ACTION controlp INFIELD oojdcrtdp name="construct.c.page2.oojdcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojdcrtdp  #顯示到畫面上
            NEXT FIELD oojdcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdcrtdp
            #add-point:BEFORE FIELD oojdcrtdp name="query.b.page2.oojdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdcrtdp
            
            #add-point:AFTER FIELD oojdcrtdp name="query.a.page2.oojdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdcrtdt
            #add-point:BEFORE FIELD oojdcrtdt name="query.b.page2.oojdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.oojdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdmodid
            #add-point:ON ACTION controlp INFIELD oojdmodid name="construct.c.page2.oojdmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojdmodid  #顯示到畫面上
            NEXT FIELD oojdmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdmodid
            #add-point:BEFORE FIELD oojdmodid name="query.b.page2.oojdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdmodid
            
            #add-point:AFTER FIELD oojdmodid name="query.a.page2.oojdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdmoddt
            #add-point:BEFORE FIELD oojdmoddt name="query.b.page2.oojdmoddt"
            
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
   LET g_first = 0
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
    
   CALL aooi180_b_fill(g_wc2)
   LET g_data_owner = g_oojd2_d[g_detail_idx].oojdownid   #(ver:35)
   LET g_data_dept = g_oojd2_d[g_detail_idx].oojdowndp   #(ver:35)
 
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
 
{<section id="aooi180.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi180_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aooi180_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi180.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi180_modify()
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
      INPUT ARRAY g_oojd_d FROM s_detail1.*
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
            IF NOT cl_null(g_oojd_d[g_detail_idx].oojd001)  THEN
               CALL n_oojdl(g_oojd_d[g_detail_idx].oojd001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_oojd_d[g_detail_idx].oojd001
               CALL ap_ref_array2(g_ref_fields," SELECT oojdl003,oojdl004 FROM oojdl_t WHERE oojdlent = '"
                   ||g_enterprise||"' AND oojdl001 = ? AND oojdl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_oojd_d[g_detail_idx].oojdl003 = g_rtn_fields[1]
               LET g_oojd_d[g_detail_idx].oojdl004 = g_rtn_fields[2]
               DISPLAY BY NAME g_oojd_d[g_detail_idx].oojdl003,g_oojd_d[g_detail_idx].oojdl004
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oojd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi180_b_fill(g_wc2)
            LET g_detail_cnt = g_oojd_d.getLength()
         
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
            DISPLAY g_oojd_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_oojd_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_oojd_d[l_ac].oojd001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_oojd_d_t.* = g_oojd_d[l_ac].*  #BACKUP
               LET g_oojd_d_o.* = g_oojd_d[l_ac].*  #BACKUP
               IF NOT aooi180_lock_b("oojd_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi180_bcl INTO g_oojd_d[l_ac].oojdstus,g_oojd_d[l_ac].oojd001,g_oojd_d[l_ac].oojd002, 
                      g_oojd_d[l_ac].oojd003,g_oojd_d[l_ac].oojd004,g_oojd2_d[l_ac].oojd001,g_oojd2_d[l_ac].oojdownid, 
                      g_oojd2_d[l_ac].oojdowndp,g_oojd2_d[l_ac].oojdcrtid,g_oojd2_d[l_ac].oojdcrtdp, 
                      g_oojd2_d[l_ac].oojdcrtdt,g_oojd2_d[l_ac].oojdmodid,g_oojd2_d[l_ac].oojdmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_oojd_d_t.oojd001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oojd_d_mask_o[l_ac].* =  g_oojd_d[l_ac].*
                  CALL aooi180_oojd_t_mask()
                  LET g_oojd_d_mask_n[l_ac].* =  g_oojd_d[l_ac].*
                  
                  CALL aooi180_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi180_set_entry_b(l_cmd)
            CALL aooi180_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL aooi180_set_entry_b(l_cmd)
            CALL aooi180_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.oojdl001 = g_oojd_d[l_ac].oojd001
LET g_detail_multi_table_t.oojdl002 = g_dlang
LET g_detail_multi_table_t.oojdl003 = g_oojd_d[l_ac].oojdl003
LET g_detail_multi_table_t.oojdl004 = g_oojd_d[l_ac].oojdl004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'oojdlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'oojdl001'
            LET l_var_keys[02] = g_oojd_d[l_ac].oojd001
            LET l_field_keys[03] = 'oojdl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'oojdl_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oojd_d_t.* TO NULL
            INITIALIZE g_oojd_d_o.* TO NULL
            INITIALIZE g_oojd_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oojd2_d[l_ac].oojdownid = g_user
      LET g_oojd2_d[l_ac].oojdowndp = g_dept
      LET g_oojd2_d[l_ac].oojdcrtid = g_user
      LET g_oojd2_d[l_ac].oojdcrtdp = g_dept 
      LET g_oojd2_d[l_ac].oojdcrtdt = cl_get_current()
      LET g_oojd2_d[l_ac].oojdmodid = g_user
      LET g_oojd2_d[l_ac].oojdmoddt = cl_get_current()
      LET g_oojd_d[l_ac].oojdstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_oojd_d[l_ac].oojdstus = "Y"
      LET g_oojd_d[l_ac].oojd003 = "1"
      LET g_oojd_d[l_ac].oojd004 = "1"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_oojd_d_t.* = g_oojd_d[l_ac].*     #新輸入資料
            LET g_oojd_d_o.* = g_oojd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oojd_d[li_reproduce_target].* = g_oojd_d[li_reproduce].*
               LET g_oojd2_d[li_reproduce_target].* = g_oojd2_d[li_reproduce].*
 
               LET g_oojd_d[g_oojd_d.getLength()].oojd001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.oojdl001 = g_oojd_d[l_ac].oojd001
LET g_detail_multi_table_t.oojdl002 = g_dlang
LET g_detail_multi_table_t.oojdl003 = g_oojd_d[l_ac].oojdl003
LET g_detail_multi_table_t.oojdl004 = g_oojd_d[l_ac].oojdl004
 
 
            CALL aooi180_set_entry_b(l_cmd)
            CALL aooi180_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_oojd_d[l_ac].oojd002 = g_argv[1]
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
            SELECT COUNT(1) INTO l_count FROM oojd_t 
             WHERE oojdent = g_enterprise AND oojd001 = g_oojd_d[l_ac].oojd001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oojd_d[g_detail_idx].oojd001
               CALL aooi180_insert_b('oojd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oojd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oojd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi180_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_oojd_d[l_ac].oojd001 = g_detail_multi_table_t.oojdl001 AND
         g_oojd_d[l_ac].oojdl003 = g_detail_multi_table_t.oojdl003 AND
         g_oojd_d[l_ac].oojdl004 = g_detail_multi_table_t.oojdl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oojdlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oojd_d[l_ac].oojd001
            LET l_field_keys[02] = 'oojdl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oojdl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'oojdl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oojdl002
            LET l_vars[01] = g_oojd_d[l_ac].oojdl003
            LET l_fields[01] = 'oojdl003'
            LET l_vars[02] = g_oojd_d[l_ac].oojdl004
            LET l_fields[02] = 'oojdl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oojdl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               #Tree:重整
               LET g_wc2 = g_wc2 CLIPPED," OR oojd001 = '",g_oojd_d[l_ac].oojd001 CLIPPED,"'"
               CALL aooi180_browser_fill(g_wc2)
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (oojd001 = '", g_oojd_d[l_ac].oojd001, "' "
 
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
               
               DELETE FROM oojd_t
                WHERE oojdent = g_enterprise AND 
                      oojd001 = g_oojd_d_t.oojd001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "oojd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oojdlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oojdl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oojdl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oojdl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  #Tree:重整
                  CALL aooi180_browser_fill(g_wc2)
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aooi180_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_oojd_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aooi180_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_oojd_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oojd_d_t.oojd001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi180_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aooi180_delete_b('oojd_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_oojd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdstus
            #add-point:BEFORE FIELD oojdstus name="input.b.page1.oojdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdstus
            
            #add-point:AFTER FIELD oojdstus name="input.a.page1.oojdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojdstus
            #add-point:ON CHANGE oojdstus name="input.g.page1.oojdstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd001
            #add-point:BEFORE FIELD oojd001 name="input.b.page1.oojd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd001
            
            #add-point:AFTER FIELD oojd001 name="input.a.page1.oojd001"
            #此段落由子樣板a05產生
            IF  g_oojd_d[g_detail_idx].oojd001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oojd_d[g_detail_idx].oojd001 != g_oojd_d_t.oojd001)) THEN 
                 #CALL aooi180_oojd001_chk()                                            #160324-00038#35 mark
                  IF NOT s_aooi180_oojd001_chk(g_oojd_d[g_detail_idx].oojd001) THEN     #160324-00038#35 add
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_oojd_d[l_ac].oojd001 
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF                                            #160324-00038#35 add
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojd001
            #add-point:ON CHANGE oojd001 name="input.g.page1.oojd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdl003
            #add-point:BEFORE FIELD oojdl003 name="input.b.page1.oojdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdl003
            
            #add-point:AFTER FIELD oojdl003 name="input.a.page1.oojdl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojdl003
            #add-point:ON CHANGE oojdl003 name="input.g.page1.oojdl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojdl004
            #add-point:BEFORE FIELD oojdl004 name="input.b.page1.oojdl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojdl004
            
            #add-point:AFTER FIELD oojdl004 name="input.a.page1.oojdl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojdl004
            #add-point:ON CHANGE oojdl004 name="input.g.page1.oojdl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd002
            #add-point:BEFORE FIELD oojd002 name="input.b.page1.oojd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd002
            
            #add-point:AFTER FIELD oojd002 name="input.a.page1.oojd002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojd002
            #add-point:ON CHANGE oojd002 name="input.g.page1.oojd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd003
            #add-point:BEFORE FIELD oojd003 name="input.b.page1.oojd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd003
            
            #add-point:AFTER FIELD oojd003 name="input.a.page1.oojd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojd003
            #add-point:ON CHANGE oojd003 name="input.g.page1.oojd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojd004
            #add-point:BEFORE FIELD oojd004 name="input.b.page1.oojd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojd004
            
            #add-point:AFTER FIELD oojd004 name="input.a.page1.oojd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojd004
            #add-point:ON CHANGE oojd004 name="input.g.page1.oojd004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oojdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdstus
            #add-point:ON ACTION controlp INFIELD oojdstus name="input.c.page1.oojdstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oojd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd001
            #add-point:ON ACTION controlp INFIELD oojd001 name="input.c.page1.oojd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oojdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdl003
            #add-point:ON ACTION controlp INFIELD oojdl003 name="input.c.page1.oojdl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oojdl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojdl004
            #add-point:ON ACTION controlp INFIELD oojdl004 name="input.c.page1.oojdl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oojd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd002
            #add-point:ON ACTION controlp INFIELD oojd002 name="input.c.page1.oojd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oojd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd003
            #add-point:ON ACTION controlp INFIELD oojd003 name="input.c.page1.oojd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oojd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojd004
            #add-point:ON ACTION controlp INFIELD oojd004 name="input.c.page1.oojd004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aooi180_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_oojd_d[l_ac].* = g_oojd_d_t.*
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
               LET g_errparam.extend = g_oojd_d[l_ac].oojd001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_oojd_d[l_ac].* = g_oojd_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_oojd2_d[l_ac].oojdmodid = g_user 
LET g_oojd2_d[l_ac].oojdmoddt = cl_get_current()
LET g_oojd2_d[l_ac].oojdmodid_desc = cl_get_username(g_oojd2_d[l_ac].oojdmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi180_oojd_t_mask_restore('restore_mask_o')
 
               UPDATE oojd_t SET (oojdstus,oojd001,oojd002,oojd003,oojd004,oojdownid,oojdowndp,oojdcrtid, 
                   oojdcrtdp,oojdcrtdt,oojdmodid,oojdmoddt) = (g_oojd_d[l_ac].oojdstus,g_oojd_d[l_ac].oojd001, 
                   g_oojd_d[l_ac].oojd002,g_oojd_d[l_ac].oojd003,g_oojd_d[l_ac].oojd004,g_oojd2_d[l_ac].oojdownid, 
                   g_oojd2_d[l_ac].oojdowndp,g_oojd2_d[l_ac].oojdcrtid,g_oojd2_d[l_ac].oojdcrtdp,g_oojd2_d[l_ac].oojdcrtdt, 
                   g_oojd2_d[l_ac].oojdmodid,g_oojd2_d[l_ac].oojdmoddt)
                WHERE oojdent = g_enterprise AND
                  oojd001 = g_oojd_d_t.oojd001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oojd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oojd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oojd_d[g_detail_idx].oojd001
               LET gs_keys_bak[1] = g_oojd_d_t.oojd001
               CALL aooi180_update_b('oojd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_oojd_d[l_ac].oojd001 = g_detail_multi_table_t.oojdl001 AND
         g_oojd_d[l_ac].oojdl003 = g_detail_multi_table_t.oojdl003 AND
         g_oojd_d[l_ac].oojdl004 = g_detail_multi_table_t.oojdl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oojdlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oojd_d[l_ac].oojd001
            LET l_field_keys[02] = 'oojdl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oojdl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'oojdl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oojdl002
            LET l_vars[01] = g_oojd_d[l_ac].oojdl003
            LET l_fields[01] = 'oojdl003'
            LET l_vars[02] = g_oojd_d[l_ac].oojdl004
            LET l_fields[02] = 'oojdl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oojdl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_oojd_d_t)
                     LET g_log2 = util.JSON.stringify(g_oojd_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi180_oojd_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               #Tree:重整
               CALL aooi180_browser_fill(g_wc2)
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aooi180_unlock_b("oojd_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oojd_d[l_ac].* = g_oojd_d_t.*
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
               LET g_oojd_d[li_reproduce_target].* = g_oojd_d[li_reproduce].*
               LET g_oojd2_d[li_reproduce_target].* = g_oojd2_d[li_reproduce].*
 
               LET g_oojd_d[li_reproduce_target].oojd001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_oojd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oojd_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_oojd2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aooi180_b_fill(g_wc2)
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
      #Tree
      DISPLAY ARRAY g_tree TO s_tree.*
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_tree",1) #設定為單選

         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 THEN
               CALL DIALOG.setCurrentRow("s_tree",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            CALL cl_show_fld_cont()
            CALL DIALOG.setCurrentRow("s_tree",g_current_row)

         ON EXPAND (g_current_row)
            #樹展開
            CALL aooi180_node_open(g_tree[g_current_row].b_oojd003)

         ON COLLAPSE (g_current_row)
            #樹關閉
            CALL aooi180_node_close(g_tree[g_current_row].b_oojd003)

      END DISPLAY
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
               NEXT FIELD oojdstus
            WHEN "s_detail2"
               NEXT FIELD oojd001_2
 
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
      IF INT_FLAG OR cl_null(g_oojd_d[g_detail_idx].oojd001) THEN
         CALL g_oojd_d.deleteElement(g_detail_idx)
         CALL g_oojd2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_oojd_d[g_detail_idx].* = g_oojd_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aooi180_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi180.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi180_delete()
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
   FOR li_idx = 1 TO g_oojd_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aooi180_lock_b("oojd_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("oojd_t","oojdownid") THEN
            LET g_data_owner = g_oojd2_d[g_detail_idx].oojdownid
            LET g_data_dept = g_oojd2_d[g_detail_idx].oojdowndp
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
   
   FOR li_idx = 1 TO g_oojd_d.getLength()
      IF g_oojd_d[li_idx].oojd001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM oojd_t
          WHERE oojdent = g_enterprise AND 
                oojd001 = g_oojd_d[li_idx].oojd001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oojd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.oojdl001 = g_oojd_d[l_ac].oojd001
LET g_detail_multi_table_t.oojdl002 = g_dlang
LET g_detail_multi_table_t.oojdl003 = g_oojd_d[l_ac].oojdl003
LET g_detail_multi_table_t.oojdl004 = g_oojd_d[l_ac].oojdl004
 
 
            
LET g_detail_multi_table_t.oojdl001 = g_oojd_d[l_ac].oojd001
LET g_detail_multi_table_t.oojdl002 = g_dlang
LET g_detail_multi_table_t.oojdl003 = g_oojd_d[l_ac].oojdl003
LET g_detail_multi_table_t.oojdl004 = g_oojd_d[l_ac].oojdl004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oojdlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oojdl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oojdl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oojdl_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oojdlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oojdl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oojdl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oojdl_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oojd_d_t.oojd001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aooi180_delete_b('oojd_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi180_set_pk_array()
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
   CALL aooi180_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aooi180.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi180_b_fill(p_wc2)              #BODY FILL UP
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
   IF cl_null(p_wc2) THEN
      LET p_wc2 = "oojd002 = '",g_argv[1],"'"
   ELSE
      LET p_wc2 = "(",p_wc2,") AND oojd002 = '",g_argv[1],"'"
   END IF
   #Tree
   IF g_first = 0 THEN
      CALL aooi180_browser_fill(g_wc2)
      LET g_first = 1
   END IF
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.oojdstus,t0.oojd001,t0.oojd002,t0.oojd003,t0.oojd004,t0.oojd001, 
       t0.oojdownid,t0.oojdowndp,t0.oojdcrtid,t0.oojdcrtdp,t0.oojdcrtdt,t0.oojdmodid,t0.oojdmoddt ,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM oojd_t t0",
               " LEFT JOIN oojdl_t ON oojdlent = "||g_enterprise||" AND oojd001 = oojdl001 AND oojdl002 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.oojdownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.oojdowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.oojdcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.oojdcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.oojdmodid  ",
 
               " WHERE t0.oojdent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("oojd_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND oojdowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("oojd_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND oojdownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("oojd_t"),
                      " ORDER BY t0.oojd001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
 
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"oojd_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aooi180_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aooi180_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_oojd_d.clear()
   CALL g_oojd2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_oojd_d[l_ac].oojdstus,g_oojd_d[l_ac].oojd001,g_oojd_d[l_ac].oojd002,g_oojd_d[l_ac].oojd003, 
       g_oojd_d[l_ac].oojd004,g_oojd2_d[l_ac].oojd001,g_oojd2_d[l_ac].oojdownid,g_oojd2_d[l_ac].oojdowndp, 
       g_oojd2_d[l_ac].oojdcrtid,g_oojd2_d[l_ac].oojdcrtdp,g_oojd2_d[l_ac].oojdcrtdt,g_oojd2_d[l_ac].oojdmodid, 
       g_oojd2_d[l_ac].oojdmoddt,g_oojd2_d[l_ac].oojdownid_desc,g_oojd2_d[l_ac].oojdowndp_desc,g_oojd2_d[l_ac].oojdcrtid_desc, 
       g_oojd2_d[l_ac].oojdcrtdp_desc,g_oojd2_d[l_ac].oojdmodid_desc
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
      
      CALL aooi180_detail_show()      
 
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
   
 
   
   CALL g_oojd_d.deleteElement(g_oojd_d.getLength())   
   CALL g_oojd2_d.deleteElement(g_oojd2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_oojd_d.getLength()
      LET g_oojd2_d[l_ac].oojd001 = g_oojd_d[l_ac].oojd001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_oojd_d.getLength() THEN
      LET l_ac = g_oojd_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_oojd_d.getLength()
      LET g_oojd_d_mask_o[l_ac].* =  g_oojd_d[l_ac].*
      CALL aooi180_oojd_t_mask()
      LET g_oojd_d_mask_n[l_ac].* =  g_oojd_d[l_ac].*
   END FOR
   
   LET g_oojd2_d_mask_o.* =  g_oojd2_d.*
   FOR l_ac = 1 TO g_oojd2_d.getLength()
      LET g_oojd2_d_mask_o[l_ac].* =  g_oojd2_d[l_ac].*
      CALL aooi180_oojd_t_mask()
      LET g_oojd2_d_mask_n[l_ac].* =  g_oojd2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_oojd_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aooi180_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aooi180.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooi180_detail_show()
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
   CALL aooi180_oojd001_ref(g_oojd_d[l_ac].oojd001) RETURNING g_oojd_d[l_ac].oojdl003,g_oojd_d[l_ac].oojdl004
   DISPLAY BY NAME g_oojd_d[l_ac].oojdl003,g_oojd_d[l_ac].oojdl004
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oojd2_d[l_ac].oojdownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_oojd2_d[l_ac].oojdownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oojd2_d[l_ac].oojdownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oojd2_d[l_ac].oojdowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oojd2_d[l_ac].oojdowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oojd2_d[l_ac].oojdowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oojd2_d[l_ac].oojdcrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_oojd2_d[l_ac].oojdcrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oojd2_d[l_ac].oojdcrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oojd2_d[l_ac].oojdcrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oojd2_d[l_ac].oojdcrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oojd2_d[l_ac].oojdcrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oojd2_d[l_ac].oojdmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_oojd2_d[l_ac].oojdmodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oojd2_d[l_ac].oojdmodid_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi180.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi180_set_entry_b(p_cmd)                                                  
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
   IF p_cmd = 'a' THEN
       CALL cl_set_comp_entry("oojd001",TRUE)
   END IF
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="aooi180.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi180_set_no_entry_b(p_cmd)                                               
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
   IF p_cmd = 'u' THEN
       CALL cl_set_comp_entry("oojd001",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="aooi180.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi180_default_search()
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
      LET ls_wc = ls_wc, " oojd001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
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
 
{<section id="aooi180.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi180_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "oojd_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'oojd_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM oojd_t
          WHERE oojdent = g_enterprise AND
            oojd001 = ps_keys_bak[1]
         
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
         CALL g_oojd_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_oojd2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      #Tree:重整
      CALL aooi180_browser_fill(g_wc2)
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi180.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi180_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "oojd_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO oojd_t
                  (oojdent,
                   oojd001
                   ,oojdstus,oojd002,oojd003,oojd004,oojdownid,oojdowndp,oojdcrtid,oojdcrtdp,oojdcrtdt,oojdmodid,oojdmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_oojd_d[l_ac].oojdstus,g_oojd_d[l_ac].oojd002,g_oojd_d[l_ac].oojd003,g_oojd_d[l_ac].oojd004, 
                       g_oojd2_d[l_ac].oojdownid,g_oojd2_d[l_ac].oojdowndp,g_oojd2_d[l_ac].oojdcrtid, 
                       g_oojd2_d[l_ac].oojdcrtdp,g_oojd2_d[l_ac].oojdcrtdt,g_oojd2_d[l_ac].oojdmodid, 
                       g_oojd2_d[l_ac].oojdmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oojd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi180.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi180_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "oojd_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "oojd_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE oojd_t 
         SET (oojd001
              ,oojdstus,oojd002,oojd003,oojd004,oojdownid,oojdowndp,oojdcrtid,oojdcrtdp,oojdcrtdt,oojdmodid,oojdmoddt) 
              = 
             (ps_keys[1]
              ,g_oojd_d[l_ac].oojdstus,g_oojd_d[l_ac].oojd002,g_oojd_d[l_ac].oojd003,g_oojd_d[l_ac].oojd004, 
                  g_oojd2_d[l_ac].oojdownid,g_oojd2_d[l_ac].oojdowndp,g_oojd2_d[l_ac].oojdcrtid,g_oojd2_d[l_ac].oojdcrtdp, 
                  g_oojd2_d[l_ac].oojdcrtdt,g_oojd2_d[l_ac].oojdmodid,g_oojd2_d[l_ac].oojdmoddt) 
         WHERE oojdent = g_enterprise AND oojd001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oojd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oojd_t:",SQLERRMESSAGE 
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
 
{<section id="aooi180.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi180_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aooi180_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "oojd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi180_bcl USING g_enterprise,
                                       g_oojd_d[g_detail_idx].oojd001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi180_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi180.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi180_unlock_b(ps_table)
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
      CLOSE aooi180_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi180.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aooi180_modify_detail_chk(ps_record)
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
         LET ls_return = "oojdstus"
      WHEN "s_detail2"
         LET ls_return = "oojd001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi180.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aooi180_show_ownid_msg()
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
 
{<section id="aooi180.mask_functions" >}
&include "erp/aoo/aooi180_mask.4gl"
 
{</section>}
 
{<section id="aooi180.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi180_set_pk_array()
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
   LET g_pk_array[1].values = g_oojd_d[l_ac].oojd001
   LET g_pk_array[1].column = 'oojd001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi180.state_change" >}
   
 
{</section>}
 
{<section id="aooi180.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi180.other_function" readonly="Y" >}

################################################################################
# Descriptions...: Tree:瀏覽頁籤設定
# Memo...........:
# Usage..........: CALL aooi180_browser_fill(p_wc)
# Input parameter: p_wc      查詢條件   
# Return code....: 
# Date & Author..: 2014/04/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi180_browser_fill(p_wc)
   DEFINE p_wc       STRING
   DEFINE l_idx      LIKE type_t.num10
   DEFINE l_idx2     LIKE type_t.num10
   DEFINE l_idx3     LIKE type_t.num10
   DEFINE l_sql      STRING
   DEFINE l_expanded LIKE type_t.chr1

   CALL g_tree.clear()
   CLEAR FORM

   LET l_sql = " SELECT UNIQUE oojd003 FROM oojd_t  ",
               "  WHERE oojdent = ",g_enterprise," AND (",p_wc,")",
               "    AND oojd002 = '",g_argv[1],"'",
               "  ORDER BY oojd003"
   PREPARE tree_pre FROM l_sql
   DECLARE tree_cur CURSOR FOR tree_pre

   LET l_sql = " SELECT expanded FROM aooi180_status WHERE oojd003 = ?"
   PREPARE tree_stus FROM l_sql

   LET l_idx = 1
   FOREACH tree_cur INTO g_tree[l_idx].b_oojd003
      LET g_tree[l_idx].b_pid     = 0
      LET g_tree[l_idx].b_id      = 0, ".", l_idx USING "<<<"
      LET g_tree[l_idx].b_exp     = FALSE
      LET g_tree[l_idx].b_expcode = 1
      LET g_tree[l_idx].b_hasC    = TRUE
      LET g_tree[l_idx].b_show    = g_tree[l_idx].b_oojd003
      LET g_tree[l_idx].b_isexp   = FALSE

      CALL aooi180_desc_show(l_idx)

      LET l_idx = l_idx + 1

      IF l_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tree.deleteElement(g_tree.getLength())

   LET g_error_show = 0
   LET g_browser_cnt = g_tree.getLength()      #總筆數, 有瀏覽頁籤才需要DISPLAY

   FREE tree_pre

   FOR l_idx2 = 1 TO g_tree.getLength()
      IF g_tree[l_idx2].b_isExp = FALSE THEN
          CALL aooi180_browser_expand(l_idx2,p_wc)
          LET g_tree[l_idx2].b_isExp = TRUE
      END IF
   END FOR

   FOR l_idx3 = 1 TO g_tree.getLength()
      IF g_tree[l_idx3].b_pid <> '0' THEN
         CONTINUE FOR
      END IF
      #抓取記錄在temp table裡的展開否的值
      LET l_expanded = ''
      EXECUTE tree_stus USING g_tree[l_idx3].b_oojd003 INTO l_expanded
      IF cl_null(l_expanded) THEN
         LET l_expanded = '1'
      END IF
      LET g_tree[l_idx3].b_exp = l_expanded
      #程式一執行就讓樹是全部展開的狀態
      IF g_first = 0 THEN
         LET g_tree[l_idx3].b_exp = '1'          #是否展開 1展開 2不展開
         LET g_tree[l_idx3].b_isExp = 1
         INSERT INTO aooi180_status(oojd003,expanded)
            VALUES(g_tree[l_idx3].b_oojd003,g_tree[l_idx3].b_exp)
      END IF
      LET g_tree[l_idx3].b_isExp = g_tree[l_idx2].b_exp
   END FOR
END FUNCTION

################################################################################
# Descriptions...: Tree:子節點展開
# Memo...........:
# Usage..........: CALL aooi180_browser_expand(p_id,p_wc)
# Input parameter: p_id 
#                  p_wc  
# Return code....: 
# Date & Author..: 2014/04/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi180_browser_expand(p_id,p_wc)
DEFINE p_id     LIKE type_t.num10
   DEFINE p_wc     STRING
   DEFINE l_lv     LIKE type_t.num10
   DEFINE l_idx    LIKE type_t.num10
   DEFINE l_sql    STRING

  ##已經展開過
  #IF g_tree[p_id].b_isExp = TRUE THEN
  #   RETURN
  #END IF
  #
  ##leaf展開
  #IF g_tree[p_id].b_expcode = 1 THEN
  #   CALL adbi252_browser_expand_leaf(p_id)
  #   RETURN
  #END IF   

   LET l_lv = g_tree[p_id].b_expcode
   LET g_tree[p_id].b_isExp = TRUE

   LET l_sql = " SELECT UNIQUE oojd003,oojd001 FROM oojd_t ",
               "  WHERE oojdent = ",g_enterprise," AND (",p_wc,")",
               "    AND oojd003 = '",g_tree[p_id].b_oojd003,"' ",
               "    AND oojd002 = '",g_argv[1],"'",
               "    AND oojdstus = 'Y'",
               "  ORDER BY oojd001 "
   PREPARE expand_pre FROM l_sql
   DECLARE expand_cur CURSOR FOR expand_pre

   LET l_idx = p_id + 1
   CALL g_tree.insertElement(l_idx)
   FOREACH expand_cur INTO g_tree[l_idx].b_oojd003,g_tree[l_idx].b_oojd001
      LET g_tree[l_idx].b_pid     = g_tree[p_id].b_id
      LET g_tree[l_idx].b_id      = g_tree[p_id].b_id , ".", l_idx USING "<<<"
      LET g_tree[l_idx].b_exp     = FALSE
      LET g_tree[l_idx].b_expcode = l_lv + 1
      LET g_tree[l_idx].b_hasC    = FALSE
      LET g_tree[l_idx].b_show    = g_tree[l_idx].b_oojd001
      CALL aooi180_desc_show(l_idx)
      LET l_idx = l_idx + 1
      CALL g_tree.insertElement(l_idx)
   END FOREACH

   CALL g_tree.deleteElement(l_idx)
   LET g_browser_cnt = g_tree.getLength()
END FUNCTION

################################################################################
# Descriptions...: Tree:節點說明
# Memo...........:
# Usage..........: CALL aooi180_desc_show(pi_ac)
# Input parameter: pi_ac
# Return code....: 
# Date & Author..: 2014/04/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi180_desc_show(pi_ac)
   DEFINE pi_ac   LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE lc_show     LIKE type_t.chr100  
   DEFINE l_oojdl003  LIKE oojdl_t.oojdl003
   DEFINE l_oojdl004  LIKE oojdl_t.oojdl004

   LET lc_show = ''
   IF cl_null(g_tree[pi_ac].b_oojd001) THEN
      CASE
         #銷售
         WHEN g_argv[1] = '1' AND g_tree[pi_ac].b_oojd003 = '1'
            #批發渠道
            LET lc_show = cl_getmsg('aoo-00301',g_dlang)
         WHEN g_argv[1] = '1' AND g_tree[pi_ac].b_oojd003 = '2'
            #零售渠道
            LET lc_show = cl_getmsg('aoo-00302',g_dlang)
         WHEN g_argv[1] = '1' AND g_tree[pi_ac].b_oojd003 = '3'
            #分銷渠道
            LET lc_show = cl_getmsg('aoo-00303',g_dlang)
         #採購
         WHEN g_argv[1] = '2' AND g_tree[pi_ac].b_oojd003 = '1'
            #直接渠道
            LET lc_show = cl_getmsg('aoo-00304',g_dlang)
         WHEN g_argv[1] = '2' AND g_tree[pi_ac].b_oojd003 = '2'
            #固定渠道
            LET lc_show = cl_getmsg('aoo-00305',g_dlang)
         WHEN g_argv[1] = '2' AND g_tree[pi_ac].b_oojd003 = '3'
            #動態渠道
            LET lc_show = cl_getmsg('aoo-00306',g_dlang)
         WHEN g_argv[1] = '2' AND g_tree[pi_ac].b_oojd003 = '4'
            #區域渠道
            LET lc_show = cl_getmsg('aoo-00307',g_dlang)
         WHEN g_argv[1] = '2' AND g_tree[pi_ac].b_oojd003 = '5'
            #名優渠道
            LET lc_show = cl_getmsg('aoo-00308',g_dlang)
      END CASE
      LET g_tree[pi_ac].b_show = lc_show
   ELSE
      LET l_oojdl003 = ''
      LET l_oojdl004 = ''
      CALL aooi180_oojd001_ref(g_tree[pi_ac].b_oojd001) RETURNING l_oojdl003,l_oojdl004
      LET g_tree[pi_ac].b_show = g_tree[pi_ac].b_oojd001,' ',l_oojdl003
   END IF
END FUNCTION

################################################################################
# Descriptions...: 渠道編號帶出说明
# Memo...........:
# Usage..........: CALL aooi180_oojd001_ref(p_oojd001)
#                  RETURNING r_oojdl003,r_oojdl004
# Input parameter: p_oojd001     渠道編號
# Return code....: r_oojdl003    渠道編號說明
#                : r_oojdl004    助記碼
# Date & Author..: 2014/04/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi180_oojd001_ref(p_oojd001)
DEFINE p_oojd001                LIKE oojd_t.oojd001
DEFINE r_oojdl003               LIKE oojdl_t.oojdl003
DEFINE r_oojdl004               LIKE oojdl_t.oojdl004

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = p_oojd001
   CALL ap_ref_array2(g_ref_fields," SELECT oojdl003,oojdl004 FROM oojdl_t WHERE oojdlent = '"||g_enterprise||"' AND oojdl001 = ? AND oojdl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET r_oojdl003 = g_rtn_fields[1]
   LET r_oojdl004 = g_rtn_fields[2]
   RETURN r_oojdl003,r_oojdl004
END FUNCTION

################################################################################
# Descriptions...: Tree:節點狀態更新為展開
# Memo...........:
# Usage..........: CALL aooi180_node_open(p_oojd003)
# Input parameter: p_oojd003
# Return code....: 
# Date & Author..: 2014/04/29 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi180_node_open(p_oojd003)
   DEFINE p_oojd003   LIKE oojd_t.oojd003

   LET g_tree[g_current_row].b_isExp = 1

   UPDATE aooi180_status SET expanded = '1'
    WHERE oojd003 = p_oojd003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
END FUNCTION

################################################################################
# Descriptions...: Tree:節點狀態更新為展開
# Memo...........:
# Usage..........: CALL aooi180_node_close(p_oojd003)
# Input parameter: p_oojd003
# Return code....: 
# Date & Author..: 2014/04/29 By pomelo
################################################################################
PUBLIC FUNCTION aooi180_node_close(p_oojd003)
   DEFINE p_oojd003   LIKE oojd_t.oojd003

   LET g_tree[g_current_row].b_isExp = 0

   UPDATE aooi180_status SET expanded = '0'
    WHERE oojd003 = p_oojd003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查渠道編號是否重複
# Usage..........: CALL aooi180_oojd001_chk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/24 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi180_oojd001_chk()
DEFINE l_oojd002      LIKE oojd_t.oojd002

   LET g_errno = ''
   LET l_oojd002 = ''
   SELECT oojd002 INTO l_oojd002
     FROM oojd_t
    WHERE oojdent = g_enterprise
      AND oojd001 = g_oojd_d[g_detail_idx].oojd001
   
   CASE l_oojd002
      WHEN '1'   #銷售
         #此渠道編號 已存在 渠道類型為銷售！
         LET g_errno = 'aoo-00347'
      WHEN '2'   #採購
         #此渠道編號 已存在 渠道類型為採購！
         LET g_errno = 'aoo-00348'
   END CASE
END FUNCTION

 
{</section>}
 
