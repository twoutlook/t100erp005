#該程式未解開Section, 採用最新樣板產出!
{<section id="asti203.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-06-22 14:10:13), PR版次:0009(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000199
#+ Filename...: asti203
#+ Description: 費用編號維護作業
#+ Creator....: 01726(2013-09-27 02:49:31)
#+ Modifier...: 06189 -SD/PR- 00000
 
{</section>}
 
{<section id="asti203.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160510-00010#1    2016/05/11  By pengxin  1、增加“费用归属类型”：1-本营运组织/2-内部营运组织/3-外部营运组织。 
#.............:                                                2、增加“费用归属组织”字段，根据营运组织资料开窗，不控制上下级关系。
#.............:                                                3、增加栏位控管：“费用归属类型”=1-本营运组织时，不允许录入；“费用归属类型”=2-内部营运组织时，要求必须录入；“费用归属类型”：3-外部营运组织，不允许录入。
#+ Modifier...:   No.#160510-00010#11  2016/05/20  By pengxin  费用归属类型是3.外部营运组织 时，开放费用归属组织可以维护，选apmm801的交易对象（有效的）
#+ Modifier...:   No.#160516-00014#4   2016/06/01  By lori     新增欄位：stae015 費用帳扣優先序  
#+ Modifier...:   No.#160604-00009#93   2016/06/22  By geza     新增欄位：stae016 刷卡手续费是否入账 
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
PRIVATE TYPE type_g_stae_d RECORD
       staestus LIKE stae_t.staestus, 
   stae001 LIKE stae_t.stae001, 
   stael003 LIKE stael_t.stael003, 
   stael004 LIKE stael_t.stael004, 
   stae002 LIKE stae_t.stae002, 
   stae012 LIKE stae_t.stae012, 
   stae003 LIKE stae_t.stae003, 
   stae003_desc LIKE type_t.chr500, 
   stae004 LIKE stae_t.stae004, 
   stae005 LIKE stae_t.stae005, 
   stae006 LIKE stae_t.stae006, 
   stae011 LIKE stae_t.stae011, 
   stae007 LIKE stae_t.stae007, 
   stae008 LIKE stae_t.stae008, 
   stae008_desc LIKE type_t.chr500, 
   stae009 LIKE stae_t.stae009, 
   stae010 LIKE stae_t.stae010, 
   stae010_desc LIKE type_t.chr500, 
   stae013 LIKE stae_t.stae013, 
   stae014 LIKE stae_t.stae014, 
   stae014_desc LIKE type_t.chr500, 
   stae015 LIKE stae_t.stae015, 
   stae016 LIKE stae_t.stae016
       END RECORD
PRIVATE TYPE type_g_stae2_d RECORD
       stae001 LIKE stae_t.stae001, 
   staeownid LIKE stae_t.staeownid, 
   staeownid_desc LIKE type_t.chr500, 
   staeowndp LIKE stae_t.staeowndp, 
   staeowndp_desc LIKE type_t.chr500, 
   staecrtid LIKE stae_t.staecrtid, 
   staecrtid_desc LIKE type_t.chr500, 
   staecrtdp LIKE stae_t.staecrtdp, 
   staecrtdp_desc LIKE type_t.chr500, 
   staecrtdt DATETIME YEAR TO SECOND, 
   staemodid LIKE stae_t.staemodid, 
   staemodid_desc LIKE type_t.chr500, 
   staemoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      stael001 LIKE stael_t.stael001,
      stael002 LIKE stael_t.stael002,
      stael003 LIKE stael_t.stael003,
      stael004 LIKE stael_t.stael004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_stae_d          DYNAMIC ARRAY OF type_g_stae_d #單身變數
DEFINE g_stae_d_t        type_g_stae_d                  #單身備份
DEFINE g_stae_d_o        type_g_stae_d                  #單身備份
DEFINE g_stae_d_mask_o   DYNAMIC ARRAY OF type_g_stae_d #單身變數
DEFINE g_stae_d_mask_n   DYNAMIC ARRAY OF type_g_stae_d #單身變數
DEFINE g_stae2_d   DYNAMIC ARRAY OF type_g_stae2_d
DEFINE g_stae2_d_t type_g_stae2_d
DEFINE g_stae2_d_o type_g_stae2_d
DEFINE g_stae2_d_mask_o DYNAMIC ARRAY OF type_g_stae2_d
DEFINE g_stae2_d_mask_n DYNAMIC ARRAY OF type_g_stae2_d
 
      
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
 
{<section id="asti203.main" >}
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
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT staestus,stae001,stae002,stae012,stae003,stae004,stae005,stae006,stae011, 
       stae007,stae008,stae009,stae010,stae013,stae014,stae015,stae016,stae001,staeownid,staeowndp,staecrtid, 
       staecrtdp,staecrtdt,staemodid,staemoddt FROM stae_t WHERE staeent=? AND stae001=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asti203_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asti203 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asti203_init()   
 
      #進入選單 Menu (="N")
      CALL asti203_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asti203
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asti203.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asti203_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('stae002','6003') 
   CALL cl_set_combo_scc('stae012','6820') 
   CALL cl_set_combo_scc('stae004','6004') 
   CALL cl_set_combo_scc('stae005','6005') 
   CALL cl_set_combo_scc('stae006','6006') 
   CALL cl_set_combo_scc('stae013','6932') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('stae002','6003','1,2')  #add by geza 20150602
   CALL cl_set_combo_scc_part('stae004','6004','1,2,3')  #add by geza 20150602 #160604-00009#43  
   #end add-point
   
   CALL asti203_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asti203.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asti203_ui_dialog()
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
         CALL g_stae_d.clear()
         CALL g_stae2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL asti203_init()
      END IF
   
      CALL asti203_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stae_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_stae2_d[g_detail_idx].staeownid   #(ver:35)
               LET g_data_dept = g_stae2_d[g_detail_idx].staeowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL asti203_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_stae2_d TO s_detail2.*
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
   CALL asti203_set_pk_array()
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
            CALL asti203_set_act_visible()      #150424-00018#1 150528 add by beckxie
            CALL asti203_set_act_no_visible()   #150424-00018#1 150528 add by beckxie
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL asti203_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti203_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL asti203_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti203_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL asti203_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti203_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asti203_insert()
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
               CALL asti203_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_stae_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_stae2_d)
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
            CALL asti203_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asti203_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asti203_set_pk_array()
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
 
{<section id="asti203.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asti203_query()
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
   CALL g_stae_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON staestus,stae001,stael003,stael004,stae002,stae012,stae003,stae003_desc,stae004, 
          stae005,stae006,stae011,stae007,stae008,stae009,stae010,stae010_desc,stae013,stae014,stae015, 
          stae016,staeownid,staeowndp,staecrtid,staecrtdp,staecrtdt,staemodid,staemoddt 
 
         FROM s_detail1[1].staestus,s_detail1[1].stae001,s_detail1[1].stael003,s_detail1[1].stael004, 
             s_detail1[1].stae002,s_detail1[1].stae012,s_detail1[1].stae003,s_detail1[1].stae003_desc, 
             s_detail1[1].stae004,s_detail1[1].stae005,s_detail1[1].stae006,s_detail1[1].stae011,s_detail1[1].stae007, 
             s_detail1[1].stae008,s_detail1[1].stae009,s_detail1[1].stae010,s_detail1[1].stae010_desc, 
             s_detail1[1].stae013,s_detail1[1].stae014,s_detail1[1].stae015,s_detail1[1].stae016,s_detail2[1].staeownid, 
             s_detail2[1].staeowndp,s_detail2[1].staecrtid,s_detail2[1].staecrtdp,s_detail2[1].staecrtdt, 
             s_detail2[1].staemodid,s_detail2[1].staemoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<staecrtdt>>----
         AFTER FIELD staecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<staemoddt>>----
         AFTER FIELD staemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<staecnfdt>>----
         
         #----<<staepstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staestus
            #add-point:BEFORE FIELD staestus name="query.b.page1.staestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staestus
            
            #add-point:AFTER FIELD staestus name="query.a.page1.staestus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.staestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staestus
            #add-point:ON ACTION controlp INFIELD staestus name="query.c.page1.staestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae001
            #add-point:ON ACTION controlp INFIELD stae001 name="construct.c.page1.stae001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stae001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stael003 #說明 
               #DISPLAY g_qryparam.return3 TO stae001 #費用編號 

            NEXT FIELD stae001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae001
            #add-point:BEFORE FIELD stae001 name="query.b.page1.stae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae001
            
            #add-point:AFTER FIELD stae001 name="query.a.page1.stae001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stael003
            #add-point:BEFORE FIELD stael003 name="query.b.page1.stael003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stael003
            
            #add-point:AFTER FIELD stael003 name="query.a.page1.stael003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stael003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stael003
            #add-point:ON ACTION controlp INFIELD stael003 name="query.c.page1.stael003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stael004
            #add-point:BEFORE FIELD stael004 name="query.b.page1.stael004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stael004
            
            #add-point:AFTER FIELD stael004 name="query.a.page1.stael004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stael004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stael004
            #add-point:ON ACTION controlp INFIELD stael004 name="query.c.page1.stael004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae002
            #add-point:BEFORE FIELD stae002 name="query.b.page1.stae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae002
            
            #add-point:AFTER FIELD stae002 name="query.a.page1.stae002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae002
            #add-point:ON ACTION controlp INFIELD stae002 name="query.c.page1.stae002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae012
            #add-point:BEFORE FIELD stae012 name="query.b.page1.stae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae012
            
            #add-point:AFTER FIELD stae012 name="query.a.page1.stae012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae012
            #add-point:ON ACTION controlp INFIELD stae012 name="query.c.page1.stae012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae003
            #add-point:ON ACTION controlp INFIELD stae003 name="construct.c.page1.stae003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2058" #
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stae003  #顯示到畫面上

            NEXT FIELD stae003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae003
            #add-point:BEFORE FIELD stae003 name="query.b.page1.stae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae003
            
            #add-point:AFTER FIELD stae003 name="query.a.page1.stae003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae003_desc
            #add-point:BEFORE FIELD stae003_desc name="query.b.page1.stae003_desc"
            NEXT FIELD stae004
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae003_desc
            
            #add-point:AFTER FIELD stae003_desc name="query.a.page1.stae003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae003_desc
            #add-point:ON ACTION controlp INFIELD stae003_desc name="query.c.page1.stae003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae004
            #add-point:BEFORE FIELD stae004 name="query.b.page1.stae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae004
            
            #add-point:AFTER FIELD stae004 name="query.a.page1.stae004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae004
            #add-point:ON ACTION controlp INFIELD stae004 name="query.c.page1.stae004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae005
            #add-point:BEFORE FIELD stae005 name="query.b.page1.stae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae005
            
            #add-point:AFTER FIELD stae005 name="query.a.page1.stae005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae005
            #add-point:ON ACTION controlp INFIELD stae005 name="query.c.page1.stae005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae006
            #add-point:BEFORE FIELD stae006 name="query.b.page1.stae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae006
            
            #add-point:AFTER FIELD stae006 name="query.a.page1.stae006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae006
            #add-point:ON ACTION controlp INFIELD stae006 name="query.c.page1.stae006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae011
            #add-point:BEFORE FIELD stae011 name="query.b.page1.stae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae011
            
            #add-point:AFTER FIELD stae011 name="query.a.page1.stae011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae011
            #add-point:ON ACTION controlp INFIELD stae011 name="query.c.page1.stae011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae007
            #add-point:BEFORE FIELD stae007 name="query.b.page1.stae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae007
            
            #add-point:AFTER FIELD stae007 name="query.a.page1.stae007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae007
            #add-point:ON ACTION controlp INFIELD stae007 name="query.c.page1.stae007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stae008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae008
            #add-point:ON ACTION controlp INFIELD stae008 name="construct.c.page1.stae008"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stae008  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stael003 #說明 
               #DISPLAY g_qryparam.return3 TO stae001 #費用編號 

            NEXT FIELD stae008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae008
            #add-point:BEFORE FIELD stae008 name="query.b.page1.stae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae008
            
            #add-point:AFTER FIELD stae008 name="query.a.page1.stae008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae009
            #add-point:BEFORE FIELD stae009 name="query.b.page1.stae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae009
            
            #add-point:AFTER FIELD stae009 name="query.a.page1.stae009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae009
            #add-point:ON ACTION controlp INFIELD stae009 name="query.c.page1.stae009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stae010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae010
            #add-point:ON ACTION controlp INFIELD stae010 name="construct.c.page1.stae010"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site                      #給予arg
            CALL q_oodb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stae010  #顯示到畫面上

            NEXT FIELD stae010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae010
            #add-point:BEFORE FIELD stae010 name="query.b.page1.stae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae010
            
            #add-point:AFTER FIELD stae010 name="query.a.page1.stae010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae010_desc
            #add-point:BEFORE FIELD stae010_desc name="query.b.page1.stae010_desc"
            NEXT FIELD staeownid
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae010_desc
            
            #add-point:AFTER FIELD stae010_desc name="query.a.page1.stae010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae010_desc
            #add-point:ON ACTION controlp INFIELD stae010_desc name="query.c.page1.stae010_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae013
            #add-point:BEFORE FIELD stae013 name="query.b.page1.stae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae013
            
            #add-point:AFTER FIELD stae013 name="query.a.page1.stae013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae013
            #add-point:ON ACTION controlp INFIELD stae013 name="query.c.page1.stae013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stae014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae014
            #add-point:ON ACTION controlp INFIELD stae014 name="construct.c.page1.stae014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗      #160510-00010#11  mark
            CALL q_stae014()     #160510-00010#11  add
            DISPLAY g_qryparam.return1 TO stae014  #顯示到畫面上
            NEXT FIELD stae014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae014
            #add-point:BEFORE FIELD stae014 name="query.b.page1.stae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae014
            
            #add-point:AFTER FIELD stae014 name="query.a.page1.stae014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae015
            #add-point:BEFORE FIELD stae015 name="query.b.page1.stae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae015
            
            #add-point:AFTER FIELD stae015 name="query.a.page1.stae015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae015
            #add-point:ON ACTION controlp INFIELD stae015 name="query.c.page1.stae015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae016
            #add-point:BEFORE FIELD stae016 name="query.b.page1.stae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae016
            
            #add-point:AFTER FIELD stae016 name="query.a.page1.stae016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae016
            #add-point:ON ACTION controlp INFIELD stae016 name="query.c.page1.stae016"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.staeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staeownid
            #add-point:ON ACTION controlp INFIELD staeownid name="construct.c.page2.staeownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staeownid  #顯示到畫面上

            NEXT FIELD staeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staeownid
            #add-point:BEFORE FIELD staeownid name="query.b.page2.staeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staeownid
            
            #add-point:AFTER FIELD staeownid name="query.a.page2.staeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.staeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staeowndp
            #add-point:ON ACTION controlp INFIELD staeowndp name="construct.c.page2.staeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staeowndp  #顯示到畫面上

            NEXT FIELD staeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staeowndp
            #add-point:BEFORE FIELD staeowndp name="query.b.page2.staeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staeowndp
            
            #add-point:AFTER FIELD staeowndp name="query.a.page2.staeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.staecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staecrtid
            #add-point:ON ACTION controlp INFIELD staecrtid name="construct.c.page2.staecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staecrtid  #顯示到畫面上

            NEXT FIELD staecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staecrtid
            #add-point:BEFORE FIELD staecrtid name="query.b.page2.staecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staecrtid
            
            #add-point:AFTER FIELD staecrtid name="query.a.page2.staecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.staecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staecrtdp
            #add-point:ON ACTION controlp INFIELD staecrtdp name="construct.c.page2.staecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staecrtdp  #顯示到畫面上

            NEXT FIELD staecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staecrtdp
            #add-point:BEFORE FIELD staecrtdp name="query.b.page2.staecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staecrtdp
            
            #add-point:AFTER FIELD staecrtdp name="query.a.page2.staecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staecrtdt
            #add-point:BEFORE FIELD staecrtdt name="query.b.page2.staecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.staemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staemodid
            #add-point:ON ACTION controlp INFIELD staemodid name="construct.c.page2.staemodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staemodid  #顯示到畫面上

            NEXT FIELD staemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staemodid
            #add-point:BEFORE FIELD staemodid name="query.b.page2.staemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staemodid
            
            #add-point:AFTER FIELD staemodid name="query.a.page2.staemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staemoddt
            #add-point:BEFORE FIELD staemoddt name="query.b.page2.staemoddt"
            
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
    
   CALL asti203_b_fill(g_wc2)
   LET g_data_owner = g_stae2_d[g_detail_idx].staeownid   #(ver:35)
   LET g_data_dept = g_stae2_d[g_detail_idx].staeowndp   #(ver:35)
 
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
 
{<section id="asti203.insert" >}
#+ 資料新增
PRIVATE FUNCTION asti203_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL asti203_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asti203.modify" >}
#+ 資料修改
PRIVATE FUNCTION asti203_modify()
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
   DEFINE r_return                LIKE type_t.num10
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
      INPUT ARRAY g_stae_d FROM s_detail1.*
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
               IF NOT cl_null(g_stae_d[l_ac].stae001)  THEN
                  CALL n_stael(g_stae_d[l_ac].stae001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_stae_d[l_ac].stae001
                  CALL ap_ref_array2(g_ref_fields," SELECT stael003,stael004 FROM stael_t WHERE staelent = '"
                      ||g_enterprise||"' AND stael001 = ? AND stael002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_stae_d[l_ac].stael003 = g_rtn_fields[1]
                  LET g_stae_d[l_ac].stael004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_stae_d[l_ac].stael003
                  DISPLAY BY NAME g_stae_d[l_ac].stael004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stae_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asti203_b_fill(g_wc2)
            LET g_detail_cnt = g_stae_d.getLength()
         
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
            DISPLAY g_stae_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_stae_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_stae_d[l_ac].stae001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stae_d_t.* = g_stae_d[l_ac].*  #BACKUP
               LET g_stae_d_o.* = g_stae_d[l_ac].*  #BACKUP
               IF NOT asti203_lock_b("stae_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti203_bcl INTO g_stae_d[l_ac].staestus,g_stae_d[l_ac].stae001,g_stae_d[l_ac].stae002, 
                      g_stae_d[l_ac].stae012,g_stae_d[l_ac].stae003,g_stae_d[l_ac].stae004,g_stae_d[l_ac].stae005, 
                      g_stae_d[l_ac].stae006,g_stae_d[l_ac].stae011,g_stae_d[l_ac].stae007,g_stae_d[l_ac].stae008, 
                      g_stae_d[l_ac].stae009,g_stae_d[l_ac].stae010,g_stae_d[l_ac].stae013,g_stae_d[l_ac].stae014, 
                      g_stae_d[l_ac].stae015,g_stae_d[l_ac].stae016,g_stae2_d[l_ac].stae001,g_stae2_d[l_ac].staeownid, 
                      g_stae2_d[l_ac].staeowndp,g_stae2_d[l_ac].staecrtid,g_stae2_d[l_ac].staecrtdp, 
                      g_stae2_d[l_ac].staecrtdt,g_stae2_d[l_ac].staemodid,g_stae2_d[l_ac].staemoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stae_d_t.stae001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stae_d_mask_o[l_ac].* =  g_stae_d[l_ac].*
                  CALL asti203_stae_t_mask()
                  LET g_stae_d_mask_n[l_ac].* =  g_stae_d[l_ac].*
                  
                  CALL asti203_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asti203_set_entry_b(l_cmd)
            CALL asti203_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            LET g_stae_d[l_ac].stae009 = 'Y'
            CALL asti203_set_entry_b("u")
            CALL asti203_set_no_entry_b("u")
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.stael001 = g_stae_d[l_ac].stae001
LET g_detail_multi_table_t.stael002 = g_dlang
LET g_detail_multi_table_t.stael003 = g_stae_d[l_ac].stael003
LET g_detail_multi_table_t.stael004 = g_stae_d[l_ac].stael004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'staelent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'stael001'
            LET l_var_keys[02] = g_stae_d[l_ac].stae001
            LET l_field_keys[03] = 'stael002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'stael_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stae_d_t.* TO NULL
            INITIALIZE g_stae_d_o.* TO NULL
            INITIALIZE g_stae_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stae2_d[l_ac].staeownid = g_user
      LET g_stae2_d[l_ac].staeowndp = g_dept
      LET g_stae2_d[l_ac].staecrtid = g_user
      LET g_stae2_d[l_ac].staecrtdp = g_dept 
      LET g_stae2_d[l_ac].staecrtdt = cl_get_current()
      LET g_stae2_d[l_ac].staemodid = g_user
      LET g_stae2_d[l_ac].staemoddt = cl_get_current()
      LET g_stae_d[l_ac].staestus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_stae_d[l_ac].staestus = "Y"
      LET g_stae_d[l_ac].stae011 = "Y"
      LET g_stae_d[l_ac].stae007 = "N"
      LET g_stae_d[l_ac].stae009 = "Y"
      LET g_stae_d[l_ac].stae015 = "0"
      LET g_stae_d[l_ac].stae016 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_stae_d[l_ac].stae006 = "2"      #150613-00007#1--add by dongsz
            #end add-point
            LET g_stae_d_t.* = g_stae_d[l_ac].*     #新輸入資料
            LET g_stae_d_o.* = g_stae_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stae_d[li_reproduce_target].* = g_stae_d[li_reproduce].*
               LET g_stae2_d[li_reproduce_target].* = g_stae2_d[li_reproduce].*
 
               LET g_stae_d[g_stae_d.getLength()].stae001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.stael001 = g_stae_d[l_ac].stae001
LET g_detail_multi_table_t.stael002 = g_dlang
LET g_detail_multi_table_t.stael003 = g_stae_d[l_ac].stael003
LET g_detail_multi_table_t.stael004 = g_stae_d[l_ac].stael004
 
 
            CALL asti203_set_entry_b(l_cmd)
            CALL asti203_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            #费用归属类型新增时默认为1
            IF cl_null(g_stae_d[l_ac].stae013) THEN
               LET g_stae_d[l_ac].stae013 = 1
            END IF
            
            CALL asti203_set_entry_b("u")
            CALL asti203_set_no_entry_b("u")
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
            SELECT COUNT(1) INTO l_count FROM stae_t 
             WHERE staeent = g_enterprise AND stae001 = g_stae_d[l_ac].stae001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stae_d[g_detail_idx].stae001
               CALL asti203_insert_b('stae_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_stae_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti203_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_stae_d[l_ac].stae001 = g_detail_multi_table_t.stael001 AND
         g_stae_d[l_ac].stael003 = g_detail_multi_table_t.stael003 AND
         g_stae_d[l_ac].stael004 = g_detail_multi_table_t.stael004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'staelent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_stae_d[l_ac].stae001
            LET l_field_keys[02] = 'stael001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.stael001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'stael002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.stael002
            LET l_vars[01] = g_stae_d[l_ac].stael003
            LET l_fields[01] = 'stael003'
            LET l_vars[02] = g_stae_d[l_ac].stael004
            LET l_fields[02] = 'stael004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'stael_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (stae001 = '", g_stae_d[l_ac].stae001, "' "
 
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
               IF asti203_chk_stae001() = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00011'
                  LET g_errparam.extend = g_stae_d_t.stae001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 #该费用编号已被使用，不可删除
                  CANCEL DELETE
               END IF
               #end add-point   
               
               DELETE FROM stae_t
                WHERE staeent = g_enterprise AND 
                      stae001 = g_stae_d_t.stae001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stae_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'staelent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stael001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stael001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stael_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL asti203_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_stae_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE asti203_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_stae_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stae_d_t.stae001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti203_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asti203_delete_b('stae_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_stae_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staestus
            #add-point:BEFORE FIELD staestus name="input.b.page1.staestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staestus
            
            #add-point:AFTER FIELD staestus name="input.a.page1.staestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE staestus
            #add-point:ON CHANGE staestus name="input.g.page1.staestus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae001
            #add-point:BEFORE FIELD stae001 name="input.b.page1.stae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae001
            
            #add-point:AFTER FIELD stae001 name="input.a.page1.stae001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_stae_d[l_ac].stae001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_stae_d[l_ac].stae001 != g_stae_d_t.stae001))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stae_t WHERE "||"staeent = '" ||g_enterprise|| "' AND "||"stae001 = '"||g_stae_d[l_ac].stae001 ||"'",'std-00004',0) THEN 
                     LET g_stae_d[l_ac].stae001 = g_stae_d_t.stae001
                     DISPLAY BY NAME g_stae_d[l_ac].stae001
                     NEXT FIELD CURRENT
                  END IF
                  LET g_stae_d[l_ac].stae008 = g_stae_d[l_ac].stae001
                  DISPLAY BY NAME g_stae_d[l_ac].stae008
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae001
            #add-point:ON CHANGE stae001 name="input.g.page1.stae001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stael003
            #add-point:BEFORE FIELD stael003 name="input.b.page1.stael003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stael003
            
            #add-point:AFTER FIELD stael003 name="input.a.page1.stael003"
            IF NOT cl_null(g_stae_d[l_ac].stael003) THEN
               IF g_stae_d[l_ac].stae008 = g_stae_d[l_ac].stae001 THEN
                  LET g_stae_d[l_ac].stae008_desc = g_stae_d[l_ac].stael003
                  DISPLAY BY NAME g_stae_d[l_ac].stae008_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stael003
            #add-point:ON CHANGE stael003 name="input.g.page1.stael003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stael004
            #add-point:BEFORE FIELD stael004 name="input.b.page1.stael004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stael004
            
            #add-point:AFTER FIELD stael004 name="input.a.page1.stael004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stael004
            #add-point:ON CHANGE stael004 name="input.g.page1.stael004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae002
            #add-point:BEFORE FIELD stae002 name="input.b.page1.stae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae002
            
            #add-point:AFTER FIELD stae002 name="input.a.page1.stae002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae002
            #add-point:ON CHANGE stae002 name="input.g.page1.stae002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae012
            #add-point:BEFORE FIELD stae012 name="input.b.page1.stae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae012
            
            #add-point:AFTER FIELD stae012 name="input.a.page1.stae012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae012
            #add-point:ON CHANGE stae012 name="input.g.page1.stae012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae003
            
            #add-point:AFTER FIELD stae003 name="input.a.page1.stae003"
            IF NOT cl_null(g_stae_d[l_ac].stae003) THEN
               CALL asti203_chk_stae003()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stae_d[l_ac].stae003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stae_d[l_ac].stae003 = g_stae_d_t.stae003
                  DISPLAY BY NAME g_stae_d[l_ac].stae003
                  NEXT FIELD stae003
               END IF
            ELSE
               LET g_stae_d[l_ac].stae003_desc = ''
               DISPLAY BY NAME g_stae_d[l_ac].stae003_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae003
            #add-point:BEFORE FIELD stae003 name="input.b.page1.stae003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae003
            #add-point:ON CHANGE stae003 name="input.g.page1.stae003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae003_desc
            #add-point:BEFORE FIELD stae003_desc name="input.b.page1.stae003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae003_desc
            
            #add-point:AFTER FIELD stae003_desc name="input.a.page1.stae003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae003_desc
            #add-point:ON CHANGE stae003_desc name="input.g.page1.stae003_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae004
            #add-point:BEFORE FIELD stae004 name="input.b.page1.stae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae004
            
            #add-point:AFTER FIELD stae004 name="input.a.page1.stae004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae004
            #add-point:ON CHANGE stae004 name="input.g.page1.stae004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae005
            #add-point:BEFORE FIELD stae005 name="input.b.page1.stae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae005
            
            #add-point:AFTER FIELD stae005 name="input.a.page1.stae005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae005
            #add-point:ON CHANGE stae005 name="input.g.page1.stae005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae006
            #add-point:BEFORE FIELD stae006 name="input.b.page1.stae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae006
            
            #add-point:AFTER FIELD stae006 name="input.a.page1.stae006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae006
            #add-point:ON CHANGE stae006 name="input.g.page1.stae006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae011
            #add-point:BEFORE FIELD stae011 name="input.b.page1.stae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae011
            
            #add-point:AFTER FIELD stae011 name="input.a.page1.stae011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae011
            #add-point:ON CHANGE stae011 name="input.g.page1.stae011"
            IF g_stae_d[l_ac].stae011 = 'N' THEN
               LET g_stae_d[l_ac].stae007 = 'N'
            END IF
            CALL asti203_set_entry_b("u")
            CALL asti203_set_no_entry_b("u")
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae007
            #add-point:BEFORE FIELD stae007 name="input.b.page1.stae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae007
            
            #add-point:AFTER FIELD stae007 name="input.a.page1.stae007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae007
            #add-point:ON CHANGE stae007 name="input.g.page1.stae007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae008
            
            #add-point:AFTER FIELD stae008 name="input.a.page1.stae008"
            LET g_stae_d[l_ac].stae008_desc = ''
            DISPLAY BY NAME g_stae_d[l_ac].stae008_desc
            IF NOT cl_null(g_stae_d[l_ac].stae008) AND NOT cl_null(g_stae_d[l_ac].stae008) THEN
               IF g_stae_d[l_ac].stae008 <> g_stae_d[l_ac].stae001 THEN
                  CALL asti203_chk_stae008()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_stae_d[l_ac].stae008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_stae_d[l_ac].stae008 = g_stae_d_t.stae008
                     DISPLAY BY NAME g_stae_d[l_ac].stae008
                     CALL asti203_stae008_ref()
                     NEXT FIELD stae008
                  END IF
               END IF
            END IF
            CALL asti203_stae008_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae008
            #add-point:BEFORE FIELD stae008 name="input.b.page1.stae008"
            IF cl_null(g_stae_d[l_ac].stae001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00012'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入费用编号
               NEXT FIELD stae001
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae008
            #add-point:ON CHANGE stae008 name="input.g.page1.stae008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae009
            #add-point:BEFORE FIELD stae009 name="input.b.page1.stae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae009
            
            #add-point:AFTER FIELD stae009 name="input.a.page1.stae009"
            CALL asti203_set_entry_b("u")
            CALL asti203_set_no_entry_b("u")
            IF g_stae_d[l_ac].stae009 = 'N' THEN
               INITIALIZE g_stae_d[l_ac].stae010 TO NULL
               INITIALIZE g_stae_d[l_ac].stae010_desc TO NULL
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae009
            #add-point:ON CHANGE stae009 name="input.g.page1.stae009"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae010
            
            #add-point:AFTER FIELD stae010 name="input.a.page1.stae010"
            IF NOT cl_null(g_stae_d[l_ac].stae010) THEN
               CALL asti203_chk_stae010()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stae_d[l_ac].stae010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stae_d[l_ac].stae010 = g_stae_d_t.stae010
                  DISPLAY BY NAME g_stae_d[l_ac].stae010
                  NEXT FIELD stae010
               END IF
            ELSE
               LET g_stae_d[l_ac].stae010_desc = ''
               DISPLAY BY NAME g_stae_d[l_ac].stae010_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae010
            #add-point:BEFORE FIELD stae010 name="input.b.page1.stae010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae010
            #add-point:ON CHANGE stae010 name="input.g.page1.stae010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae010_desc
            #add-point:BEFORE FIELD stae010_desc name="input.b.page1.stae010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae010_desc
            
            #add-point:AFTER FIELD stae010_desc name="input.a.page1.stae010_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae010_desc
            #add-point:ON CHANGE stae010_desc name="input.g.page1.stae010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae013
            #add-point:BEFORE FIELD stae013 name="input.b.page1.stae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae013
            
            #add-point:AFTER FIELD stae013 name="input.a.page1.stae013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae013
            #add-point:ON CHANGE stae013 name="input.g.page1.stae013"
            #160510-00010#1   add(S)
            CALL asti203_set_entry_b("u")
            CALL asti203_set_no_entry_b("u")
            
#            IF g_stae_d[l_ac].stae013 != 2 OR cl_null(g_stae_d[l_ac].stae013) THEN
#               LET g_stae_d[l_ac].stae014 = ''
#               LET g_stae_d[l_ac].stae014_desc = ''
#               DISPLAY BY NAME g_stae_d[l_ac].stae014,g_stae_d[l_ac].stae014_desc
#            END IF
            #160510-00010#1   add(E)
            
            #改变类型时，费用归属组织和带值栏位清空   #160510-00010#11  add(S)
            LET g_stae_d[l_ac].stae014 = ''
            LET g_stae_d[l_ac].stae014_desc = ''
            DISPLAY BY NAME g_stae_d[l_ac].stae014,g_stae_d[l_ac].stae014_desc
            #160510-00010#11  add(E)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae014
            
            #add-point:AFTER FIELD stae014 name="input.a.page1.stae014"
            
            
            IF NOT cl_null(g_stae_d[l_ac].stae014) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stae_d[l_ac].stae014

               IF g_stae_d[l_ac].stae013 = '2' THEN   #160510-00010#11  add   费用归属类型为2时的栏位校验
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF g_stae_d[l_ac].stae013 = '3' THEN   #160510-00010#11  add   费用归属类型为3时的栏位校验
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmaa001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
 
            END IF 
            
            IF  g_stae_d[l_ac].stae013 = '2' THEN  #160510-00010#11  add   费用归属类型为2时的说明栏位带值
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stae_d[l_ac].stae014
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stae_d[l_ac].stae014_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stae_d[l_ac].stae014_desc
            END IF
            
            IF  g_stae_d[l_ac].stae013 = '3' THEN  #160510-00010#11  add   费用归属类型为3时的说明栏位带值
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stae_d[l_ac].stae014
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stae_d[l_ac].stae014_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stae_d[l_ac].stae014_desc
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae014
            #add-point:BEFORE FIELD stae014 name="input.b.page1.stae014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae014
            #add-point:ON CHANGE stae014 name="input.g.page1.stae014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae015
            #add-point:BEFORE FIELD stae015 name="input.b.page1.stae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae015
            
            #add-point:AFTER FIELD stae015 name="input.a.page1.stae015"
            IF NOT cl_null(g_stae_d[l_ac].stae015) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_stae_d[l_ac].stae015 != g_stae_d_t.stae015 OR g_stae_d_t.stae015 IS NULL )) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM stae_t
                   WHERE staeent = g_enterprise
                     AND stae001 <> g_stae_d[l_ac].stae001
                     AND stae015 = g_stae_d[l_ac].stae015    
                     
                  IF l_cnt > 0 THEN
                     #優先序不可重複
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "asf-00376"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()            
                     
                     LET g_stae_d[l_ac].stae015 = g_stae_d_t.stae015
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae015
            #add-point:ON CHANGE stae015 name="input.g.page1.stae015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stae016
            #add-point:BEFORE FIELD stae016 name="input.b.page1.stae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stae016
            
            #add-point:AFTER FIELD stae016 name="input.a.page1.stae016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stae016
            #add-point:ON CHANGE stae016 name="input.g.page1.stae016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.staestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staestus
            #add-point:ON ACTION controlp INFIELD staestus name="input.c.page1.staestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae001
            #add-point:ON ACTION controlp INFIELD stae001 name="input.c.page1.stae001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stael003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stael003
            #add-point:ON ACTION controlp INFIELD stael003 name="input.c.page1.stael003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stael004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stael004
            #add-point:ON ACTION controlp INFIELD stael004 name="input.c.page1.stael004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae002
            #add-point:ON ACTION controlp INFIELD stae002 name="input.c.page1.stae002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae012
            #add-point:ON ACTION controlp INFIELD stae012 name="input.c.page1.stae012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae003
            #add-point:ON ACTION controlp INFIELD stae003 name="input.c.page1.stae003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stae_d[l_ac].stae003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2058" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_stae_d[l_ac].stae003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stae_d[l_ac].stae003 TO stae003              #顯示到畫面上
            
            CALL asti203_chk_stae003()

            NEXT FIELD stae003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stae003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae003_desc
            #add-point:ON ACTION controlp INFIELD stae003_desc name="input.c.page1.stae003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae004
            #add-point:ON ACTION controlp INFIELD stae004 name="input.c.page1.stae004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae005
            #add-point:ON ACTION controlp INFIELD stae005 name="input.c.page1.stae005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae006
            #add-point:ON ACTION controlp INFIELD stae006 name="input.c.page1.stae006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae011
            #add-point:ON ACTION controlp INFIELD stae011 name="input.c.page1.stae011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae007
            #add-point:ON ACTION controlp INFIELD stae007 name="input.c.page1.stae007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae008
            #add-point:ON ACTION controlp INFIELD stae008 name="input.c.page1.stae008"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stae_d[l_ac].stae008             #給予default值
            LET g_qryparam.default2 = "" #g_stae_d[l_ac].stael003 #說明
            LET g_qryparam.default3 = "" #g_stae_d[l_ac].stae001 #費用編號

            #給予arg

            CALL q_stae001()                                #呼叫開窗

            LET g_stae_d[l_ac].stae008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stae_d[l_ac].stael003 = g_qryparam.return2 #說明
            #LET g_stae_d[l_ac].stae001 = g_qryparam.return3 #費用編號

            DISPLAY g_stae_d[l_ac].stae008 TO stae008              #顯示到畫面上
            #DISPLAY g_stae_d[l_ac].stael003 TO stael003 #說明
            #DISPLAY g_stae_d[l_ac].stae001 TO stae001 #費用編號
            
            CALL asti203_stae008_ref()

            NEXT FIELD stae008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stae009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae009
            #add-point:ON ACTION controlp INFIELD stae009 name="input.c.page1.stae009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae010
            #add-point:ON ACTION controlp INFIELD stae010 name="input.c.page1.stae010"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stae_d[l_ac].stae010             #給予default值

            LET g_qryparam.arg1 = g_site                      #給予arg

            CALL q_oodb002_1()                                #呼叫開窗

            LET g_stae_d[l_ac].stae010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stae_d[l_ac].stae010 TO stae010              #顯示到畫面上
            
            CALL asti203_chk_stae010()

            NEXT FIELD stae010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stae010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae010_desc
            #add-point:ON ACTION controlp INFIELD stae010_desc name="input.c.page1.stae010_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae013
            #add-point:ON ACTION controlp INFIELD stae013 name="input.c.page1.stae013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae014
            #add-point:ON ACTION controlp INFIELD stae014 name="input.c.page1.stae014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            IF g_stae_d[l_ac].stae013 = '2' THEN
               LET g_qryparam.default1 = g_stae_d[l_ac].stae014             #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = "" #s
   
    
               CALL q_ooef001()                                #呼叫開窗
    
               LET g_stae_d[l_ac].stae014 = g_qryparam.return1              
   
               DISPLAY g_stae_d[l_ac].stae014 TO stae014              #
   
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stae_d[l_ac].stae014
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stae_d[l_ac].stae014_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stae_d[l_ac].stae014_desc
            END IF
            IF g_stae_d[l_ac].stae013 = '3' THEN
               #給予arg
               LET g_qryparam.arg1 = "" #s
   
    
               CALL q_pmaa001_10()                             #呼叫開窗
    
               LET g_stae_d[l_ac].stae014 = g_qryparam.return1              
   
               DISPLAY g_stae_d[l_ac].stae014 TO stae014              #
   
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stae_d[l_ac].stae014
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stae_d[l_ac].stae014_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stae_d[l_ac].stae014_desc
            END IF
            
            NEXT FIELD stae014                          #返回原欄位

            

            #END add-point
 
 
         #Ctrlp:input.c.page1.stae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae015
            #add-point:ON ACTION controlp INFIELD stae015 name="input.c.page1.stae015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stae016
            #add-point:ON ACTION controlp INFIELD stae016 name="input.c.page1.stae016"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE asti203_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_stae_d[l_ac].* = g_stae_d_t.*
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
               LET g_errparam.extend = g_stae_d[l_ac].stae001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_stae_d[l_ac].* = g_stae_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_stae2_d[l_ac].staemodid = g_user 
LET g_stae2_d[l_ac].staemoddt = cl_get_current()
LET g_stae2_d[l_ac].staemodid_desc = cl_get_username(g_stae2_d[l_ac].staemodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asti203_stae_t_mask_restore('restore_mask_o')
 
               UPDATE stae_t SET (staestus,stae001,stae002,stae012,stae003,stae004,stae005,stae006,stae011, 
                   stae007,stae008,stae009,stae010,stae013,stae014,stae015,stae016,staeownid,staeowndp, 
                   staecrtid,staecrtdp,staecrtdt,staemodid,staemoddt) = (g_stae_d[l_ac].staestus,g_stae_d[l_ac].stae001, 
                   g_stae_d[l_ac].stae002,g_stae_d[l_ac].stae012,g_stae_d[l_ac].stae003,g_stae_d[l_ac].stae004, 
                   g_stae_d[l_ac].stae005,g_stae_d[l_ac].stae006,g_stae_d[l_ac].stae011,g_stae_d[l_ac].stae007, 
                   g_stae_d[l_ac].stae008,g_stae_d[l_ac].stae009,g_stae_d[l_ac].stae010,g_stae_d[l_ac].stae013, 
                   g_stae_d[l_ac].stae014,g_stae_d[l_ac].stae015,g_stae_d[l_ac].stae016,g_stae2_d[l_ac].staeownid, 
                   g_stae2_d[l_ac].staeowndp,g_stae2_d[l_ac].staecrtid,g_stae2_d[l_ac].staecrtdp,g_stae2_d[l_ac].staecrtdt, 
                   g_stae2_d[l_ac].staemodid,g_stae2_d[l_ac].staemoddt)
                WHERE staeent = g_enterprise AND
                  stae001 = g_stae_d_t.stae001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stae_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stae_d[g_detail_idx].stae001
               LET gs_keys_bak[1] = g_stae_d_t.stae001
               CALL asti203_update_b('stae_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_stae_d[l_ac].stae001 = g_detail_multi_table_t.stael001 AND
         g_stae_d[l_ac].stael003 = g_detail_multi_table_t.stael003 AND
         g_stae_d[l_ac].stael004 = g_detail_multi_table_t.stael004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'staelent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_stae_d[l_ac].stae001
            LET l_field_keys[02] = 'stael001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.stael001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'stael002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.stael002
            LET l_vars[01] = g_stae_d[l_ac].stael003
            LET l_fields[01] = 'stael003'
            LET l_vars[02] = g_stae_d[l_ac].stael004
            LET l_fields[02] = 'stael004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'stael_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_stae_d_t)
                     LET g_log2 = util.JSON.stringify(g_stae_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asti203_stae_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asti203_unlock_b("stae_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stae_d[l_ac].* = g_stae_d_t.*
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
               LET g_stae_d[li_reproduce_target].* = g_stae_d[li_reproduce].*
               LET g_stae2_d[li_reproduce_target].* = g_stae2_d[li_reproduce].*
 
               LET g_stae_d[li_reproduce_target].stae001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stae_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stae_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_stae2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL asti203_b_fill(g_wc2)
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
               NEXT FIELD staestus
            WHEN "s_detail2"
               NEXT FIELD stae001_2
 
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
      IF INT_FLAG OR cl_null(g_stae_d[g_detail_idx].stae001) THEN
         CALL g_stae_d.deleteElement(g_detail_idx)
         CALL g_stae2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_stae_d[g_detail_idx].* = g_stae_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE asti203_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="asti203.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asti203_delete()
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
   FOR li_idx = 1 TO g_stae_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT asti203_lock_b("stae_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("stae_t","staeownid") THEN
            LET g_data_owner = g_stae2_d[g_detail_idx].staeownid
            LET g_data_dept = g_stae2_d[g_detail_idx].staeowndp
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
   
   FOR li_idx = 1 TO g_stae_d.getLength()
      IF g_stae_d[li_idx].stae001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM stae_t
          WHERE staeent = g_enterprise AND 
                stae001 = g_stae_d[li_idx].stae001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stae_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.stael001 = g_stae_d[l_ac].stae001
LET g_detail_multi_table_t.stael002 = g_dlang
LET g_detail_multi_table_t.stael003 = g_stae_d[l_ac].stael003
LET g_detail_multi_table_t.stael004 = g_stae_d[l_ac].stael004
 
 
            
LET g_detail_multi_table_t.stael001 = g_stae_d[l_ac].stae001
LET g_detail_multi_table_t.stael002 = g_dlang
LET g_detail_multi_table_t.stael003 = g_stae_d[l_ac].stael003
LET g_detail_multi_table_t.stael004 = g_stae_d[l_ac].stael004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'staelent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stael001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stael001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stael_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'staelent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stael001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stael001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stael_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stae_d_t.stae001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL asti203_delete_b('stae_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti203_set_pk_array()
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
   CALL asti203_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="asti203.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asti203_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.staestus,t0.stae001,t0.stae002,t0.stae012,t0.stae003,t0.stae004, 
       t0.stae005,t0.stae006,t0.stae011,t0.stae007,t0.stae008,t0.stae009,t0.stae010,t0.stae013,t0.stae014, 
       t0.stae015,t0.stae016,t0.stae001,t0.staeownid,t0.staeowndp,t0.staecrtid,t0.staecrtdp,t0.staecrtdt, 
       t0.staemodid,t0.staemoddt ,t1.stael003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 FROM stae_t t0",
               " LEFT JOIN stael_t ON staelent = "||g_enterprise||" AND stae001 = stael001 AND stael002 = '",g_dlang,"'",
                              " LEFT JOIN stael_t t1 ON t1.staelent="||g_enterprise||" AND t1.stael001=t0.stae008 AND t1.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.stae014 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.staeownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.staeowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.staecrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.staecrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.staemodid  ",
 
               " WHERE t0.staeent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("stae_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND staeowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("stae_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND staeownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = "SELECT  DISTINCT t0.staestus ,t0.stae001  ,t0.stae002  ,t0.stae012  ,t0.stae003  , ",
               "                 t0.stae004  ,t0.stae005  ,t0.stae006  ,t0.stae011  ,t0.stae007  ,",
               "                 t0.stae008  ,t0.stae009  ,t0.stae010  ,t0.stae013  ,t0.stae014  , ",
               "                 t0.stae015  ,t0.stae016  ,           ",       #160516-00014#4 160601 by lori add ,#160604-00009#93 2016/06/22  By geza  add   stae016                        
               "                 t0.stae001  ,t0.staeownid,t0.staeowndp,t0.staecrtid,t0.staecrtdp, ",
               "                 t0.staecrtdt,t0.staemodid,t0.staemoddt,t1.stael003 ,t2.ooefl003 , ",
               "                 t3.ooag011  ,t4.ooefl003 ,t5.ooag011  ,t6.ooefl003 ,t7.ooag011    ",
               "  FROM stae_t t0 ",                                                                
               " LEFT JOIN stael_t ON staelent = '"||g_enterprise||"' AND stae001 = stael001 AND stael002 = '",g_dlang,"'",
               " LEFT JOIN stael_t t1 ON t1.staelent='"||g_enterprise||"' AND t1.stael001=t0.stae008 AND t1.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.stae014 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.staeownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.staeowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.staecrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.staecrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.staemodid  ",
 
               " WHERE t0.staeent= ?  AND  1=1 AND (", p_wc2, ") "
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("stae_t"),
                      " ORDER BY t0.stae001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"stae_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asti203_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asti203_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stae_d.clear()
   CALL g_stae2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_stae_d[l_ac].staestus,g_stae_d[l_ac].stae001,g_stae_d[l_ac].stae002,g_stae_d[l_ac].stae012, 
       g_stae_d[l_ac].stae003,g_stae_d[l_ac].stae004,g_stae_d[l_ac].stae005,g_stae_d[l_ac].stae006,g_stae_d[l_ac].stae011, 
       g_stae_d[l_ac].stae007,g_stae_d[l_ac].stae008,g_stae_d[l_ac].stae009,g_stae_d[l_ac].stae010,g_stae_d[l_ac].stae013, 
       g_stae_d[l_ac].stae014,g_stae_d[l_ac].stae015,g_stae_d[l_ac].stae016,g_stae2_d[l_ac].stae001, 
       g_stae2_d[l_ac].staeownid,g_stae2_d[l_ac].staeowndp,g_stae2_d[l_ac].staecrtid,g_stae2_d[l_ac].staecrtdp, 
       g_stae2_d[l_ac].staecrtdt,g_stae2_d[l_ac].staemodid,g_stae2_d[l_ac].staemoddt,g_stae_d[l_ac].stae008_desc, 
       g_stae_d[l_ac].stae014_desc,g_stae2_d[l_ac].staeownid_desc,g_stae2_d[l_ac].staeowndp_desc,g_stae2_d[l_ac].staecrtid_desc, 
       g_stae2_d[l_ac].staecrtdp_desc,g_stae2_d[l_ac].staemodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL asti203_chk_stae003()
      CALL asti203_chk_stae010()
      IF g_stae_d[l_ac].stae013 = '3' THEN
            CALL s_desc_get_trading_partner_full_desc(g_stae_d[l_ac].stae014) RETURNING g_stae_d[l_ac].stae014_desc
      END IF 
      #end add-point
      
      CALL asti203_detail_show()      
 
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
   
 
   
   CALL g_stae_d.deleteElement(g_stae_d.getLength())   
   CALL g_stae2_d.deleteElement(g_stae2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_stae_d.getLength()
      LET g_stae2_d[l_ac].stae001 = g_stae_d[l_ac].stae001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_stae_d.getLength() THEN
      LET l_ac = g_stae_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_stae_d.getLength()
      LET g_stae_d_mask_o[l_ac].* =  g_stae_d[l_ac].*
      CALL asti203_stae_t_mask()
      LET g_stae_d_mask_n[l_ac].* =  g_stae_d[l_ac].*
   END FOR
   
   LET g_stae2_d_mask_o.* =  g_stae2_d.*
   FOR l_ac = 1 TO g_stae2_d.getLength()
      LET g_stae2_d_mask_o[l_ac].* =  g_stae2_d[l_ac].*
      CALL asti203_stae_t_mask()
      LET g_stae2_d_mask_n[l_ac].* =  g_stae2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_stae_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE asti203_pb
   
END FUNCTION
 
{</section>}
 
{<section id="asti203.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asti203_detail_show()
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
            LET g_ref_fields[1] = g_stae_d[l_ac].stae008
            CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stae_d[l_ac].stae008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stae_d[l_ac].stae008_desc

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_stae_d[l_ac].stae001
   CALL ap_ref_array2(g_ref_fields," SELECT stael003,stael004 FROM stael_t WHERE staelent = '"||g_enterprise||"' AND stael001 = ? AND stael002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_stae_d[l_ac].stael003 = g_rtn_fields[1] 
   LET g_stae_d[l_ac].stael004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_stae_d[l_ac].stael003,g_stae_d[l_ac].stael004
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   CALL asti203_chk_stae003()
   CALL asti203_stae008_ref()
   CALL asti203_chk_stae010()
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stae2_d[l_ac].staeownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stae2_d[l_ac].staeownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stae2_d[l_ac].staeownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stae2_d[l_ac].staeowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stae2_d[l_ac].staeowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stae2_d[l_ac].staeowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stae2_d[l_ac].staecrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stae2_d[l_ac].staecrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stae2_d[l_ac].staecrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stae2_d[l_ac].staecrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stae2_d[l_ac].staecrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stae2_d[l_ac].staecrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stae2_d[l_ac].staemodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stae2_d[l_ac].staemodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stae2_d[l_ac].staemodid_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asti203.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asti203_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry('stae010',TRUE)
   CALL cl_set_comp_entry('stae007',TRUE)
   CALL cl_set_comp_entry('stae014',TRUE)    #160510-00010#1 add
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="asti203.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asti203_set_no_entry_b(p_cmd)                                               
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
   IF cl_null(g_stae_d[l_ac].stae009) OR g_stae_d[l_ac].stae009 = 'N' THEN
      CALL cl_set_comp_entry('stae010',FALSE)
   END IF
   IF g_stae_d[l_ac].stae011 = 'N' THEN
      CALL cl_set_comp_entry('stae007',FALSE)      
   END IF
   #160510-00010#11  mark  (S)
#   #160510-00010#1 add(S)
#   IF g_stae_d[l_ac].stae013 != '2' OR cl_null(g_stae_d[l_ac].stae013) THEN
#      CALL cl_set_comp_entry('stae014',FALSE)      
#   END IF
#   #160510-00010#1 add(E)
   #160510-00010#11  mark  (E)
   #160510-00010#11  add   (S)
   #如果费用归属类型为1时关闭费用归属组织和说明栏位
   IF g_stae_d[l_ac].stae013 = '1'  THEN     
      CALL cl_set_comp_entry('stae014',FALSE)      
   END IF
   #160510-00010#11  add   (S)
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="asti203.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asti203_default_search()
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
      LET ls_wc = ls_wc, " stae001 = '", g_argv[01], "' AND "
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
 
{<section id="asti203.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asti203_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "stae_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'stae_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM stae_t
          WHERE staeent = g_enterprise AND
            stae001 = ps_keys_bak[1]
         
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
         CALL g_stae_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_stae2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti203.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asti203_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "stae_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO stae_t
                  (staeent,
                   stae001
                   ,staestus,stae002,stae012,stae003,stae004,stae005,stae006,stae011,stae007,stae008,stae009,stae010,stae013,stae014,stae015,stae016,staeownid,staeowndp,staecrtid,staecrtdp,staecrtdt,staemodid,staemoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_stae_d[l_ac].staestus,g_stae_d[l_ac].stae002,g_stae_d[l_ac].stae012,g_stae_d[l_ac].stae003, 
                       g_stae_d[l_ac].stae004,g_stae_d[l_ac].stae005,g_stae_d[l_ac].stae006,g_stae_d[l_ac].stae011, 
                       g_stae_d[l_ac].stae007,g_stae_d[l_ac].stae008,g_stae_d[l_ac].stae009,g_stae_d[l_ac].stae010, 
                       g_stae_d[l_ac].stae013,g_stae_d[l_ac].stae014,g_stae_d[l_ac].stae015,g_stae_d[l_ac].stae016, 
                       g_stae2_d[l_ac].staeownid,g_stae2_d[l_ac].staeowndp,g_stae2_d[l_ac].staecrtid, 
                       g_stae2_d[l_ac].staecrtdp,g_stae2_d[l_ac].staecrtdt,g_stae2_d[l_ac].staemodid, 
                       g_stae2_d[l_ac].staemoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti203.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asti203_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "stae_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "stae_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE stae_t 
         SET (stae001
              ,staestus,stae002,stae012,stae003,stae004,stae005,stae006,stae011,stae007,stae008,stae009,stae010,stae013,stae014,stae015,stae016,staeownid,staeowndp,staecrtid,staecrtdp,staecrtdt,staemodid,staemoddt) 
              = 
             (ps_keys[1]
              ,g_stae_d[l_ac].staestus,g_stae_d[l_ac].stae002,g_stae_d[l_ac].stae012,g_stae_d[l_ac].stae003, 
                  g_stae_d[l_ac].stae004,g_stae_d[l_ac].stae005,g_stae_d[l_ac].stae006,g_stae_d[l_ac].stae011, 
                  g_stae_d[l_ac].stae007,g_stae_d[l_ac].stae008,g_stae_d[l_ac].stae009,g_stae_d[l_ac].stae010, 
                  g_stae_d[l_ac].stae013,g_stae_d[l_ac].stae014,g_stae_d[l_ac].stae015,g_stae_d[l_ac].stae016, 
                  g_stae2_d[l_ac].staeownid,g_stae2_d[l_ac].staeowndp,g_stae2_d[l_ac].staecrtid,g_stae2_d[l_ac].staecrtdp, 
                  g_stae2_d[l_ac].staecrtdt,g_stae2_d[l_ac].staemodid,g_stae2_d[l_ac].staemoddt) 
         WHERE staeent = g_enterprise AND stae001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stae_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stae_t:",SQLERRMESSAGE 
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
 
{<section id="asti203.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asti203_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL asti203_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "stae_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asti203_bcl USING g_enterprise,
                                       g_stae_d[g_detail_idx].stae001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asti203_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asti203.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asti203_unlock_b(ps_table)
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
      CLOSE asti203_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti203.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION asti203_modify_detail_chk(ps_record)
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
         LET ls_return = "staestus"
      WHEN "s_detail2"
         LET ls_return = "stae001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="asti203.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION asti203_show_ownid_msg()
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
 
{<section id="asti203.mask_functions" >}
&include "erp/ast/asti203_mask.4gl"
 
{</section>}
 
{<section id="asti203.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asti203_set_pk_array()
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
   LET g_pk_array[1].values = g_stae_d[l_ac].stae001
   LET g_pk_array[1].column = 'stae001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti203.state_change" >}
   
 
{</section>}
 
{<section id="asti203.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="asti203.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION asti203_chk_stae003()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus

   INITIALIZE g_errno TO NULL
   SELECT oocqstus INTO l_oocqstus 
     FROM oocq_t
    WHERE oocqent = g_enterprise AND oocq001 = '2058' AND oocq002 = g_stae_d[l_ac].stae003
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00007' #費用總類不存在
                               LET g_stae_d[l_ac].stae003_desc = ''
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'ast-00008' #費用總類已無效
                               LET g_stae_d[l_ac].stae003_desc = ''
   END CASE
   IF cl_null(g_errno) THEN
      SELECT oocql004 INTO g_stae_d[l_ac].stae003_desc
        FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '2058' AND oocql002 = g_stae_d[l_ac].stae003 AND oocql003 = g_dlang
      DISPLAY BY NAME g_stae_d[l_ac].stae003_desc
   END IF
END FUNCTION
#+
PRIVATE FUNCTION asti203_chk_stae008()
DEFINE l_staestus   LIKE stae_t.staestus

   INITIALIZE g_errno TO NULL
   SELECT staestus INTO l_staestus 
     FROM stae_t 
    WHERE staeent = g_enterprise AND stae001 = g_stae_d[l_ac].stae008
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00001' #費用編號不存在
      WHEN l_staestus <> 'Y'   LET g_errno = 'ast-00002' #用編號已無效
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION asti203_chk_stae010()
DEFINE l_oodcstus   LIKE oodc_t.oodcstus

   INITIALIZE g_errno TO NULL
   SELECT oodbstus INTO l_oodcstus
     FROM oodb_t,ooef_t
    WHERE oodbent = g_enterprise AND oodb001 = ooef019 AND oodb002 = g_stae_d[l_ac].stae010 AND oodb004 = '1'
      AND ooefent = g_enterprise AND ooef001 = g_site
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00009' #發票稅目不存在
                               LET g_stae_d[l_ac].stae010_desc = ''
      WHEN l_oodcstus <> 'Y'   LET g_errno = 'ast-00010' #發票稅目已無效
                               LET g_stae_d[l_ac].stae010_desc = ''
   END CASE
   IF cl_null(g_errno) THEN
      SELECT oodbl004 INTO g_stae_d[l_ac].stae010_desc
        FROM oodbl_t,ooef_t
       WHERE oodblent = g_enterprise AND oodbl001 = ooef019 
         AND oodbl002 = g_stae_d[l_ac].stae010 AND oodbl003 = g_dlang
         AND ooefent = g_enterprise AND ooef001 = g_site
      DISPLAY BY NAME g_stae_d[l_ac].stae010_desc
   END IF
END FUNCTION
#+
PRIVATE FUNCTION asti203_chk_stae001()
DEFINE r_success   LIKE type_t.chr1
DEFINE l_cnt       LIKE type_t.num10

   SELECT COUNT(*) INTO l_cnt
     FROM stae_t
    WHERE staeent = g_enterprise AND stae008 = g_stae_d_t.stae001 AND stae001 <> g_stae_d_t.stae001
   IF l_cnt > 0 THEN
      LET r_success = 'N'
   ELSE
      LET r_success = 'Y'
   END IF
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION asti203_stae008_ref()
   IF g_stae_d[l_ac].stae008 = g_stae_d[l_ac].stae001 THEN
      LET g_stae_d[l_ac].stae008_desc = g_stae_d[l_ac].stael003
   ELSE
      SELECT stael003 INTO g_stae_d[l_ac].stae008_desc
        FROM stael_t
       WHERE staelent = g_enterprise AND stael001 = g_stae_d[l_ac].stae008 AND stael002 = g_dlang
   END IF
   DISPLAY BY NAME g_stae_d[l_ac].stae008_desc
END FUNCTION

PRIVATE FUNCTION asti203_set_act_visible()
   #add-point:set_act_visible段define
   #150424-00018#1 150528 add by beckxie
   CALL cl_set_act_visible("insert,modify,modify_detail,reproduce,delete,statechange",TRUE)
   #end add-point   
   #add-point:set_act_visible段define(客製用)

   #end add-point   
   #add-point:set_act_visible段

   #end add-point   
END FUNCTION

PRIVATE FUNCTION asti203_set_act_no_visible()
   #add-point:set_act_no_visible段define
   #150424-00018#1 150529 add by beckxie---S
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0002')='Y' THEN
      CALL cl_set_act_visible("insert,modify,modify_detail,reproduce,delete,statechange",FALSE)
   END IF
   #150424-00018#1 150529 add by beckxie---E
   #end add-point   
   #add-point:set_act_no_visible段define(客製用)

   #end add-point   
   #add-point:set_act_no_visible段
   
   #end add-point   
END FUNCTION

 
{</section>}
 
