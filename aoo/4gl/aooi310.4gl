#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-08-06 14:36:25), PR版次:0006(2016-10-19 17:08:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000201
#+ Filename...: aooi310
#+ Description: 庫存管理標籤維護作業
#+ Creator....: 02299(2013-07-01 00:00:00)
#+ Modifier...: 02294 -SD/PR- 05384
 
{</section>}
 
{<section id="aooi310.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160816-00058#1 2016/08/26 By 01258       修改时，只有当编号发生改变时才充抓标签位置，否则只有要异动（非key值）就会导致标签位置变更，导致后面查询不对
#160809-00047#2 2016/10/11 By shiun       刪除前先判斷s_azzi610_check
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
PRIVATE TYPE type_g_oocq_d RECORD
       oocqstus LIKE oocq_t.oocqstus, 
   oocq001 LIKE oocq_t.oocq001, 
   oocq002 LIKE oocq_t.oocq002, 
   oocql004 LIKE oocql_t.oocql004, 
   oocql005 LIKE oocql_t.oocql005, 
   oocq005 LIKE oocq_t.oocq005, 
   oocq004 LIKE oocq_t.oocq004
       END RECORD
PRIVATE TYPE type_g_oocq1_info_d RECORD
       oocq001 LIKE oocq_t.oocq001, 
   oocq002 LIKE oocq_t.oocq002, 
   oocqmodid LIKE oocq_t.oocqmodid, 
   oocqmodid_desc LIKE type_t.chr500, 
   oocqmoddt DATETIME YEAR TO SECOND, 
   oocqownid LIKE oocq_t.oocqownid, 
   oocqownid_desc LIKE type_t.chr500, 
   oocqowndp LIKE oocq_t.oocqowndp, 
   oocqowndp_desc LIKE type_t.chr500, 
   oocqcrtid LIKE oocq_t.oocqcrtid, 
   oocqcrtid_desc LIKE type_t.chr500, 
   oocqcrtdp LIKE oocq_t.oocqcrtdp, 
   oocqcrtdp_desc LIKE type_t.chr500, 
   oocqcrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      oocql001 LIKE oocql_t.oocql001,
      oocql002 LIKE oocql_t.oocql002,
      oocql003 LIKE oocql_t.oocql003,
      oocql004 LIKE oocql_t.oocql004,
      oocql005 LIKE oocql_t.oocql005
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_oocq001    LIKE oocq_t.oocq001
#end add-point
 
#模組變數(Module Variables)
DEFINE g_oocq_d          DYNAMIC ARRAY OF type_g_oocq_d #單身變數
DEFINE g_oocq_d_t        type_g_oocq_d                  #單身備份
DEFINE g_oocq_d_o        type_g_oocq_d                  #單身備份
DEFINE g_oocq_d_mask_o   DYNAMIC ARRAY OF type_g_oocq_d #單身變數
DEFINE g_oocq_d_mask_n   DYNAMIC ARRAY OF type_g_oocq_d #單身變數
DEFINE g_oocq1_info_d   DYNAMIC ARRAY OF type_g_oocq1_info_d
DEFINE g_oocq1_info_d_t type_g_oocq1_info_d
DEFINE g_oocq1_info_d_o type_g_oocq1_info_d
DEFINE g_oocq1_info_d_mask_o DYNAMIC ARRAY OF type_g_oocq1_info_d
DEFINE g_oocq1_info_d_mask_n DYNAMIC ARRAY OF type_g_oocq1_info_d
 
      
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
 
{<section id="aooi310.main" >}
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
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   IF NOT cl_null(g_argv[1]) THEN
      LET g_oocq001 = g_argv[1]
      CALL aooi310_check_oocq001(g_oocq001)
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_oocq001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL cl_ap_exitprogram("0")
      END IF
   ELSE
      #若傳入的第一個參數為空值，則顯示錯誤並結束程式
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00084'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL cl_ap_exitprogram("0")
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT oocqstus,oocq001,oocq002,oocq005,oocq004,oocq001,oocq002,oocqmodid,oocqmoddt, 
       oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt FROM oocq_t WHERE oocqent=? AND oocq001=? AND  
       oocq002=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi310_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi310 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi310_init()   
 
      #進入選單 Menu (="N")
      CALL aooi310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi310
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi310.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aooi310_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_visible("oocq001",FALSE)
   #end add-point
   
   CALL aooi310_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi310.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aooi310_ui_dialog()
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
         CALL g_oocq_d.clear()
         CALL g_oocq1_info_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aooi310_init()
      END IF
   
      CALL aooi310_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_oocq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_oocq1_info_d[g_detail_idx].oocqownid   #(ver:35)
               LET g_data_dept = g_oocq1_info_d[g_detail_idx].oocqowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_oocq1_info_d TO s_detail1_info.*
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
   CALL aooi310_set_pk_array()
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
            CALL aooi310_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi310_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aooi310_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi310_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aooi310_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi310_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi310_insert()
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
               CALL aooi310_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_oocq_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_oocq1_info_d)
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
            CALL aooi310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi310_set_pk_array()
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
 
{<section id="aooi310.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi310_query()
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
   CALL g_oocq_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON oocqstus,oocq001,oocq002,oocql004,oocql005,oocq005,oocqmodid,oocqmoddt,oocqownid, 
          oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt 
 
         FROM s_detail1[1].oocqstus,s_detail1[1].oocq001,s_detail1[1].oocq002,s_detail1[1].oocql004, 
             s_detail1[1].oocql005,s_detail1[1].oocq005,s_detail1_info[1].oocqmodid,s_detail1_info[1].oocqmoddt, 
             s_detail1_info[1].oocqownid,s_detail1_info[1].oocqowndp,s_detail1_info[1].oocqcrtid,s_detail1_info[1].oocqcrtdp, 
             s_detail1_info[1].oocqcrtdt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oocqcrtdt>>----
         AFTER FIELD oocqcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oocqmoddt>>----
         AFTER FIELD oocqmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oocqcnfdt>>----
         
         #----<<oocqpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqstus
            #add-point:BEFORE FIELD oocqstus name="query.b.page1.oocqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqstus
            
            #add-point:AFTER FIELD oocqstus name="query.a.page1.oocqstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oocqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqstus
            #add-point:ON ACTION controlp INFIELD oocqstus name="query.c.page1.oocqstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq001
            #add-point:BEFORE FIELD oocq001 name="query.b.page1.oocq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq001
            
            #add-point:AFTER FIELD oocq001 name="query.a.page1.oocq001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oocq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq001
            #add-point:ON ACTION controlp INFIELD oocq001 name="query.c.page1.oocq001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.oocq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="construct.c.page1.oocq002"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.arg1 = g_oocq001
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002  #顯示到畫面上

            NEXT FIELD oocq002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="query.b.page1.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="query.a.page1.oocq002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="query.b.page1.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="query.a.page1.oocql004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="query.c.page1.oocql004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="query.b.page1.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="query.a.page1.oocql005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="query.c.page1.oocql005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.oocq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq005
            #add-point:ON ACTION controlp INFIELD oocq005 name="construct.c.page1.oocq005"
#此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.arg1 = g_oocq001
            LET g_qryparam.reqry = FALSE
            CALL q_oocq005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq005  #顯示到畫面上

            NEXT FIELD oocq005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq005
            #add-point:BEFORE FIELD oocq005 name="query.b.page1.oocq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq005
            
            #add-point:AFTER FIELD oocq005 name="query.a.page1.oocq005"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page1_info.oocqmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqmodid
            #add-point:ON ACTION controlp INFIELD oocqmodid name="construct.c.page1_info.oocqmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqmodid  #顯示到畫面上

            NEXT FIELD oocqmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqmodid
            #add-point:BEFORE FIELD oocqmodid name="query.b.page1_info.oocqmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqmodid
            
            #add-point:AFTER FIELD oocqmodid name="query.a.page1_info.oocqmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqmoddt
            #add-point:BEFORE FIELD oocqmoddt name="query.b.page1_info.oocqmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_info.oocqownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqownid
            #add-point:ON ACTION controlp INFIELD oocqownid name="construct.c.page1_info.oocqownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqownid  #顯示到畫面上

            NEXT FIELD oocqownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqownid
            #add-point:BEFORE FIELD oocqownid name="query.b.page1_info.oocqownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqownid
            
            #add-point:AFTER FIELD oocqownid name="query.a.page1_info.oocqownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.oocqowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqowndp
            #add-point:ON ACTION controlp INFIELD oocqowndp name="construct.c.page1_info.oocqowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqowndp  #顯示到畫面上

            NEXT FIELD oocqowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqowndp
            #add-point:BEFORE FIELD oocqowndp name="query.b.page1_info.oocqowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqowndp
            
            #add-point:AFTER FIELD oocqowndp name="query.a.page1_info.oocqowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.oocqcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqcrtid
            #add-point:ON ACTION controlp INFIELD oocqcrtid name="construct.c.page1_info.oocqcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqcrtid  #顯示到畫面上

            NEXT FIELD oocqcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtid
            #add-point:BEFORE FIELD oocqcrtid name="query.b.page1_info.oocqcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqcrtid
            
            #add-point:AFTER FIELD oocqcrtid name="query.a.page1_info.oocqcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.oocqcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqcrtdp
            #add-point:ON ACTION controlp INFIELD oocqcrtdp name="construct.c.page1_info.oocqcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqcrtdp  #顯示到畫面上

            NEXT FIELD oocqcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtdp
            #add-point:BEFORE FIELD oocqcrtdp name="query.b.page1_info.oocqcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqcrtdp
            
            #add-point:AFTER FIELD oocqcrtdp name="query.a.page1_info.oocqcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtdt
            #add-point:BEFORE FIELD oocqcrtdt name="query.b.page1_info.oocqcrtdt"
            
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
    
   CALL aooi310_b_fill(g_wc2)
   LET g_data_owner = g_oocq1_info_d[g_detail_idx].oocqownid   #(ver:35)
   LET g_data_dept = g_oocq1_info_d[g_detail_idx].oocqowndp   #(ver:35)
 
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
 
{<section id="aooi310.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi310_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aooi310_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi310.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi310_modify()
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
   DEFINE  l_result        LIKE type_t.num5
   DEFINE  l_oocq004       LIKE oocq_t.oocq004
   #add--160809-00047#2 By shiun--(S)
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_use                 LIKE type_t.num5
   #add--160809-00047#2 By shiun--(E)
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
      INPUT ARRAY g_oocq_d FROM s_detail1.*
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
               IF (NOT cl_null(g_oocq_d[l_ac].oocq001)) AND (NOT cl_null(g_oocq_d[l_ac].oocq002)) THEN
                  CALL n_oocql(g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oocq_d[l_ac].oocq001
                  LET g_ref_fields[2] = g_oocq_d[l_ac].oocq002
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oocq_d[l_ac].oocql004 = g_rtn_fields[1]
                  LET g_oocq_d[l_ac].oocql005 = g_rtn_fields[2]

                  DISPLAY BY NAME g_oocq_d[l_ac].oocql004,g_oocq_d[l_ac].oocql005
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oocq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi310_b_fill(g_wc2)
            LET g_detail_cnt = g_oocq_d.getLength()
         
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
            DISPLAY g_oocq_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_oocq_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_oocq_d[l_ac].oocq001 IS NOT NULL
               AND g_oocq_d[l_ac].oocq002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_oocq_d_t.* = g_oocq_d[l_ac].*  #BACKUP
               LET g_oocq_d_o.* = g_oocq_d[l_ac].*  #BACKUP
               IF NOT aooi310_lock_b("oocq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi310_bcl INTO g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002, 
                      g_oocq_d[l_ac].oocq005,g_oocq_d[l_ac].oocq004,g_oocq1_info_d[l_ac].oocq001,g_oocq1_info_d[l_ac].oocq002, 
                      g_oocq1_info_d[l_ac].oocqmodid,g_oocq1_info_d[l_ac].oocqmoddt,g_oocq1_info_d[l_ac].oocqownid, 
                      g_oocq1_info_d[l_ac].oocqowndp,g_oocq1_info_d[l_ac].oocqcrtid,g_oocq1_info_d[l_ac].oocqcrtdp, 
                      g_oocq1_info_d[l_ac].oocqcrtdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_oocq_d_t.oocq001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oocq_d_mask_o[l_ac].* =  g_oocq_d[l_ac].*
                  CALL aooi310_oocq_t_mask()
                  LET g_oocq_d_mask_n[l_ac].* =  g_oocq_d[l_ac].*
                  
                  CALL aooi310_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi310_set_entry_b(l_cmd)
            CALL aooi310_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.oocql001 = g_oocq_d[l_ac].oocq001
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys[02] = g_oocq_d[l_ac].oocq001
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys[03] = g_oocq_d[l_ac].oocq002
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'oocql_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oocq_d_t.* TO NULL
            INITIALIZE g_oocq_d_o.* TO NULL
            INITIALIZE g_oocq_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oocq1_info_d[l_ac].oocqownid = g_user
      LET g_oocq1_info_d[l_ac].oocqowndp = g_dept
      LET g_oocq1_info_d[l_ac].oocqcrtid = g_user
      LET g_oocq1_info_d[l_ac].oocqcrtdp = g_dept 
      LET g_oocq1_info_d[l_ac].oocqcrtdt = cl_get_current()
      LET g_oocq1_info_d[l_ac].oocqmodid = g_user
      LET g_oocq1_info_d[l_ac].oocqmoddt = cl_get_current()
      LET g_oocq_d[l_ac].oocqstus = ''
 
 
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_oocq_d_t.* = g_oocq_d[l_ac].*     #新輸入資料
            LET g_oocq_d_o.* = g_oocq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oocq_d[li_reproduce_target].* = g_oocq_d[li_reproduce].*
               LET g_oocq1_info_d[li_reproduce_target].* = g_oocq1_info_d[li_reproduce].*
 
               LET g_oocq_d[g_oocq_d.getLength()].oocq001 = NULL
               LET g_oocq_d[g_oocq_d.getLength()].oocq002 = NULL
 
            END IF
            
LET g_detail_multi_table_t.oocql001 = g_oocq_d[l_ac].oocq001
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
            CALL aooi310_set_entry_b(l_cmd)
            CALL aooi310_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_oocq_d[l_ac].oocq001 = g_oocq001
            LET g_oocq_d[l_ac].oocqstus = 'Y'
            #判斷若超過256筆有效資料，則不允許新增
            CALL aooi310_check_count(g_oocq_d[l_ac].oocq001) RETURNING l_result
            IF NOT l_result THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00096'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               ROLLBACK WORK
               CANCEL INSERT
            END IF
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
            SELECT COUNT(1) INTO l_count FROM oocq_t 
             WHERE oocqent = g_enterprise AND oocq001 = g_oocq_d[l_ac].oocq001
                                       AND oocq002 = g_oocq_d[l_ac].oocq002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               CALL aooi310_check_count(g_oocq_d[l_ac].oocq001) RETURNING l_result
               IF NOT l_result THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00096'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  INITIALIZE g_oocq_d[l_ac].* TO NULL
                  ROLLBACK WORK
                  CANCEL INSERT
               END IF
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               CALL aooi310_insert_b('oocq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               CALL aooi310_get_oocq004() RETURNING l_oocq004
               UPDATE oocq_t SET oocq004 = l_oocq004
                WHERE oocqent = g_enterprise
                  AND oocq001 = g_oocq_d[l_ac].oocq001
                  AND oocq002 = g_oocq_d[l_ac].oocq002
               LET g_oocq_d[l_ac].oocq004 = l_oocq004
               DISPLAY BY NAME g_oocq_d[l_ac].oocq004
               #end add-point
            ELSE    
               INITIALIZE g_oocq_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi310_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_oocq_d[l_ac].oocq001 = g_detail_multi_table_t.oocql001 AND
         g_oocq_d[l_ac].oocq002 = g_detail_multi_table_t.oocql002 AND
         g_oocq_d[l_ac].oocql004 = g_detail_multi_table_t.oocql004 AND
         g_oocq_d[l_ac].oocql005 = g_detail_multi_table_t.oocql005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oocq_d[l_ac].oocq001
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
            LET l_var_keys[03] = g_oocq_d[l_ac].oocq002
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.oocql003
            LET l_vars[01] = g_oocq_d[l_ac].oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_oocq_d[l_ac].oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (oocq001 = '", g_oocq_d[l_ac].oocq001, "' "
                                  ," AND oocq002 = '", g_oocq_d[l_ac].oocq002, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               #add--160809-00047#2 By shiun--(S)
               CALL s_azzi610_check('4',g_oocq_d_t.oocq002,g_site) RETURNING l_success,l_use
               IF l_use THEN
                  INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'azz-01159'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   CANCEL DELETE 
               END IF
               #add--160809-00047#2 By shiun--(E)
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
               CALL aooi310_check_oocq002() RETURNING l_result
               IF NOT l_result THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00098'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               #end add-point   
               
               DELETE FROM oocq_t
                WHERE oocqent = g_enterprise AND 
                      oocq001 = g_oocq_d_t.oocq001
                      AND oocq002 = g_oocq_d_t.oocq002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oocqlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oocql001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
                  LET l_field_keys[03] = 'oocql002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL aooi310_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_oocq_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aooi310_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_oocq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d_t.oocq001
               LET gs_keys[2] = g_oocq_d_t.oocq002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aooi310_delete_b('oocq_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_oocq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqstus
            #add-point:BEFORE FIELD oocqstus name="input.b.page1.oocqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqstus
            
            #add-point:AFTER FIELD oocqstus name="input.a.page1.oocqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocqstus
            #add-point:ON CHANGE oocqstus name="input.g.page1.oocqstus"
            IF g_oocq_d[l_ac].oocqstus <> g_oocq_d_t.oocqstus THEN
               IF g_oocq_d[l_ac].oocqstus = 'Y' THEN
                  CALL aooi310_check_count(g_oocq_d[l_ac].oocq001) RETURNING l_result
                  IF NOT l_result THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00097'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_oocq_d[l_ac].oocqstus = g_oocq_d_t.oocqstus
                     DISPLAY BY NAME g_oocq_d[l_ac].oocqstus
                     NEXT FIELD oocqstus
                  END IF
               ELSE
                  CALL aooi310_check_oocq002() RETURNING l_result
                  IF NOT l_result THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00098'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_oocq_d[l_ac].oocqstus = g_oocq_d_t.oocqstus
                     DISPLAY BY NAME g_oocq_d[l_ac].oocqstus
                     NEXT FIELD oocqstus
                  END IF
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq001
            #add-point:BEFORE FIELD oocq001 name="input.b.page1.oocq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq001
            
            #add-point:AFTER FIELD oocq001 name="input.a.page1.oocq001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_oocq_d[l_ac].oocq001) AND NOT cl_null(g_oocq_d[l_ac].oocq002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oocq_d[l_ac].oocq001 != g_oocq_d_t.oocq001 OR g_oocq_d[l_ac].oocq002 != g_oocq_d_t.oocq002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq001 = '"||g_oocq_d[l_ac].oocq001 ||"' AND "|| "oocq002 = '"||g_oocq_d[l_ac].oocq002 ||"'",'std-00004',0) THEN 
                     LET g_oocq_d[l_ac].oocq001 = g_oocq_d_t.oocq001
                     DISPLAY BY NAME g_oocq_d[l_ac].oocq001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq001
            #add-point:ON CHANGE oocq001 name="input.g.page1.oocq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="input.b.page1.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="input.a.page1.oocq002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_oocq_d[l_ac].oocq001) AND NOT cl_null(g_oocq_d[l_ac].oocq002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oocq_d[l_ac].oocq001 != g_oocq_d_t.oocq001 OR g_oocq_d[l_ac].oocq002 != g_oocq_d_t.oocq002))) THEN 
                  CALL aooi310_check_oocq002() RETURNING l_result
                  IF NOT l_result THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00098'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_oocq_d[l_ac].oocq002 = g_oocq_d_t.oocq002
                     DISPLAY BY NAME g_oocq_d[l_ac].oocq002
                     NEXT FIELD oocq002
                  END IF
            
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq001 = '"||g_oocq_d[l_ac].oocq001 ||"' AND "|| "oocq002 = '"||g_oocq_d[l_ac].oocq002 ||"'",'std-00004',0) THEN 
                     LET g_oocq_d[l_ac].oocq002 = g_oocq_d_t.oocq002
                     DISPLAY BY NAME g_oocq_d[l_ac].oocq002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq002
            #add-point:ON CHANGE oocq002 name="input.g.page1.oocq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="input.b.page1.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="input.a.page1.oocql004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql004
            #add-point:ON CHANGE oocql004 name="input.g.page1.oocql004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="input.b.page1.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="input.a.page1.oocql005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql005
            #add-point:ON CHANGE oocql005 name="input.g.page1.oocql005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq005
            #add-point:BEFORE FIELD oocq005 name="input.b.page1.oocq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq005
            
            #add-point:AFTER FIELD oocq005 name="input.a.page1.oocq005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq005
            #add-point:ON CHANGE oocq005 name="input.g.page1.oocq005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oocqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqstus
            #add-point:ON ACTION controlp INFIELD oocqstus name="input.c.page1.oocqstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq001
            #add-point:ON ACTION controlp INFIELD oocq001 name="input.c.page1.oocq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="input.c.page1.oocq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="input.c.page1.oocql004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="input.c.page1.oocql005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oocq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq005
            #add-point:ON ACTION controlp INFIELD oocq005 name="input.c.page1.oocq005"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aooi310_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_oocq_d[l_ac].* = g_oocq_d_t.*
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
               LET g_errparam.extend = g_oocq_d[l_ac].oocq001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_oocq_d[l_ac].* = g_oocq_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_oocq1_info_d[l_ac].oocqmodid = g_user 
LET g_oocq1_info_d[l_ac].oocqmoddt = cl_get_current()
LET g_oocq1_info_d[l_ac].oocqmodid_desc = cl_get_username(g_oocq1_info_d[l_ac].oocqmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF g_oocq_d[l_ac].oocqstus <> g_oocq_d_t.oocqstus AND g_oocq_d[l_ac].oocqstus = 'Y' THEN
                  CALL aooi310_check_count(g_oocq_d[l_ac].oocq001) RETURNING l_result
               ELSE
                  LET l_result = TRUE
               END IF
               IF NOT l_result THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00097'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oocq_d[l_ac].* = g_oocq_d_t.*
               ELSE
                  IF g_oocq_d[l_ac].oocq001 != g_oocq_d_t.oocq001 OR g_oocq_d[l_ac].oocq002 != g_oocq_d_t.oocq002 THEN  #160816-00058#1 add
                     CALL aooi310_get_oocq004() RETURNING l_oocq004
                     UPDATE oocq_t SET oocq004 = l_oocq004
                      WHERE oocqent = g_enterprise
                        AND oocq001 = g_oocq_d[l_ac].oocq001
                        AND oocq002 = g_oocq_d[l_ac].oocq002
                     LET g_oocq_d[l_ac].oocq004 = l_oocq004
                     DISPLAY BY NAME g_oocq_d[l_ac].oocq004
                  END IF   #160816-00058#1 add
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi310_oocq_t_mask_restore('restore_mask_o')
 
               UPDATE oocq_t SET (oocqstus,oocq001,oocq002,oocq005,oocq004,oocqmodid,oocqmoddt,oocqownid, 
                   oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt) = (g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq001, 
                   g_oocq_d[l_ac].oocq002,g_oocq_d[l_ac].oocq005,g_oocq_d[l_ac].oocq004,g_oocq1_info_d[l_ac].oocqmodid, 
                   g_oocq1_info_d[l_ac].oocqmoddt,g_oocq1_info_d[l_ac].oocqownid,g_oocq1_info_d[l_ac].oocqowndp, 
                   g_oocq1_info_d[l_ac].oocqcrtid,g_oocq1_info_d[l_ac].oocqcrtdp,g_oocq1_info_d[l_ac].oocqcrtdt) 
 
                WHERE oocqent = g_enterprise AND
                  oocq001 = g_oocq_d_t.oocq001 #項次   
                  AND oocq002 = g_oocq_d_t.oocq002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d[g_detail_idx].oocq001
               LET gs_keys_bak[1] = g_oocq_d_t.oocq001
               LET gs_keys[2] = g_oocq_d[g_detail_idx].oocq002
               LET gs_keys_bak[2] = g_oocq_d_t.oocq002
               CALL aooi310_update_b('oocq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_oocq_d[l_ac].oocq001 = g_detail_multi_table_t.oocql001 AND
         g_oocq_d[l_ac].oocq002 = g_detail_multi_table_t.oocql002 AND
         g_oocq_d[l_ac].oocql004 = g_detail_multi_table_t.oocql004 AND
         g_oocq_d[l_ac].oocql005 = g_detail_multi_table_t.oocql005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oocq_d[l_ac].oocq001
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
            LET l_var_keys[03] = g_oocq_d[l_ac].oocq002
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.oocql003
            LET l_vars[01] = g_oocq_d[l_ac].oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_oocq_d[l_ac].oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_oocq_d_t)
                     LET g_log2 = util.JSON.stringify(g_oocq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi310_oocq_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aooi310_unlock_b("oocq_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oocq_d[l_ac].* = g_oocq_d_t.*
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
               LET g_oocq_d[li_reproduce_target].* = g_oocq_d[li_reproduce].*
               LET g_oocq1_info_d[li_reproduce_target].* = g_oocq1_info_d[li_reproduce].*
 
               LET g_oocq_d[li_reproduce_target].oocq001 = NULL
               LET g_oocq_d[li_reproduce_target].oocq002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_oocq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oocq_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_oocq1_info_d TO s_detail1_info.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aooi310_b_fill(g_wc2)
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
               NEXT FIELD oocqstus
            WHEN "s_detail1_info"
               NEXT FIELD oocq001_2
 
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
      IF INT_FLAG OR cl_null(g_oocq_d[g_detail_idx].oocq001) THEN
         CALL g_oocq_d.deleteElement(g_detail_idx)
         CALL g_oocq1_info_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_oocq_d[g_detail_idx].* = g_oocq_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aooi310_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi310_delete()
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
   #add--160809-00047#2 By shiun--(S)
   DEFINE l_success               LIKE type_t.num5
   DEFINE l_use                   LIKE type_t.num5
   #add--160809-00047#2 By shiun--(E)
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_oocq_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aooi310_lock_b("oocq_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("oocq_t","oocqownid") THEN
            LET g_data_owner = g_oocq1_info_d[g_detail_idx].oocqownid
            LET g_data_dept = g_oocq1_info_d[g_detail_idx].oocqowndp
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
   #add--160809-00047#2 By shiun--(S)
   CALL s_azzi610_check('4',g_oocq_d[li_detail_tmp].oocq002,g_site) RETURNING l_success,l_use
   IF l_use THEN
      INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'azz-01159'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N','0')
       RETURN
   END IF
   #add--160809-00047#2 By shiun--(E)
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_oocq_d.getLength()
      IF g_oocq_d[li_idx].oocq001 IS NOT NULL
         AND g_oocq_d[li_idx].oocq002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM oocq_t
          WHERE oocqent = g_enterprise AND 
                oocq001 = g_oocq_d[li_idx].oocq001
                AND oocq002 = g_oocq_d[li_idx].oocq002
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.oocql001 = g_oocq_d[l_ac].oocq001
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
            
LET g_detail_multi_table_t.oocql001 = g_oocq_d[l_ac].oocq001
LET g_detail_multi_table_t.oocql002 = g_oocq_d[l_ac].oocq002
LET g_detail_multi_table_t.oocql003 = g_dlang
LET g_detail_multi_table_t.oocql004 = g_oocq_d[l_ac].oocql004
LET g_detail_multi_table_t.oocql005 = g_oocq_d[l_ac].oocql005
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oocqlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oocql001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
                  LET l_field_keys[03] = 'oocql002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'oocqlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'oocql001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.oocql001
                  LET l_field_keys[03] = 'oocql002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.oocql002
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_d_t.oocq001
               LET gs_keys[2] = g_oocq_d_t.oocq002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aooi310_delete_b('oocq_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi310_set_pk_array()
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
   CALL aooi310_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aooi310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi310_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.oocqstus,t0.oocq001,t0.oocq002,t0.oocq005,t0.oocq004,t0.oocq001, 
       t0.oocq002,t0.oocqmodid,t0.oocqmoddt,t0.oocqownid,t0.oocqowndp,t0.oocqcrtid,t0.oocqcrtdp,t0.oocqcrtdt , 
       t1.ooag011 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 FROM oocq_t t0",
               " LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.oocqmodid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.oocqownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.oocqowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.oocqcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.oocqcrtdp AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.oocqent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("oocq_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND oocqowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("oocq_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND oocqownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("oocq_t"),
                      " ORDER BY t0.oocq001,t0.oocq002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"oocq_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aooi310_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aooi310_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_oocq_d.clear()
   CALL g_oocq1_info_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq001,g_oocq_d[l_ac].oocq002,g_oocq_d[l_ac].oocq005, 
       g_oocq_d[l_ac].oocq004,g_oocq1_info_d[l_ac].oocq001,g_oocq1_info_d[l_ac].oocq002,g_oocq1_info_d[l_ac].oocqmodid, 
       g_oocq1_info_d[l_ac].oocqmoddt,g_oocq1_info_d[l_ac].oocqownid,g_oocq1_info_d[l_ac].oocqowndp, 
       g_oocq1_info_d[l_ac].oocqcrtid,g_oocq1_info_d[l_ac].oocqcrtdp,g_oocq1_info_d[l_ac].oocqcrtdt, 
       g_oocq1_info_d[l_ac].oocqmodid_desc,g_oocq1_info_d[l_ac].oocqownid_desc,g_oocq1_info_d[l_ac].oocqowndp_desc, 
       g_oocq1_info_d[l_ac].oocqcrtid_desc,g_oocq1_info_d[l_ac].oocqcrtdp_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_oocq_d[l_ac].oocq001 <> g_oocq001 THEN
         CONTINUE FOREACH
      END IF
      #end add-point
      
      CALL aooi310_detail_show()      
 
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
   
 
   
   CALL g_oocq_d.deleteElement(g_oocq_d.getLength())   
   CALL g_oocq1_info_d.deleteElement(g_oocq1_info_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_oocq_d.getLength()
      LET g_oocq1_info_d[l_ac].oocq001 = g_oocq_d[l_ac].oocq001 
      LET g_oocq1_info_d[l_ac].oocq002 = g_oocq_d[l_ac].oocq002 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_oocq_d.getLength() THEN
      LET l_ac = g_oocq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_oocq_d.getLength()
      LET g_oocq_d_mask_o[l_ac].* =  g_oocq_d[l_ac].*
      CALL aooi310_oocq_t_mask()
      LET g_oocq_d_mask_n[l_ac].* =  g_oocq_d[l_ac].*
   END FOR
   
   LET g_oocq1_info_d_mask_o.* =  g_oocq1_info_d.*
   FOR l_ac = 1 TO g_oocq1_info_d.getLength()
      LET g_oocq1_info_d_mask_o[l_ac].* =  g_oocq1_info_d[l_ac].*
      CALL aooi310_oocq_t_mask()
      LET g_oocq1_info_d_mask_n[l_ac].* =  g_oocq1_info_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_oocq_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aooi310_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aooi310.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooi310_detail_show()
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
   LET g_ref_fields[1] = g_oocq_d[l_ac].oocq001
   LET g_ref_fields[2] = g_oocq_d[l_ac].oocq002
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_oocq_d[l_ac].oocql004 = g_rtn_fields[1] 
   LET g_oocq_d[l_ac].oocql005 = g_rtn_fields[2] 
   DISPLAY BY NAME g_oocq_d[l_ac].oocql004,g_oocq_d[l_ac].oocql005
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body1_info.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq1_info_d[l_ac].oocqmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oocq1_info_d[l_ac].oocqmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq1_info_d[l_ac].oocqmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq1_info_d[l_ac].oocqownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oocq1_info_d[l_ac].oocqownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq1_info_d[l_ac].oocqownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq1_info_d[l_ac].oocqowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oocq1_info_d[l_ac].oocqowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq1_info_d[l_ac].oocqowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq1_info_d[l_ac].oocqcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oocq1_info_d[l_ac].oocqcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq1_info_d[l_ac].oocqcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq1_info_d[l_ac].oocqcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oocq1_info_d[l_ac].oocqcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq1_info_d[l_ac].oocqcrtdp_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi310_set_entry_b(p_cmd)                                                  
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
 
{<section id="aooi310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi310_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aooi310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi310_default_search()
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
      LET ls_wc = ls_wc, " oocq001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " oocq002 = '", g_argv[02], "' AND "
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
 
{<section id="aooi310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi310_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "oocq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'oocq_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM oocq_t
          WHERE oocqent = g_enterprise AND
            oocq001 = ps_keys_bak[1] AND oocq002 = ps_keys_bak[2]
         
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
         CALL g_oocq_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_oocq1_info_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi310_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "oocq_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO oocq_t
                  (oocqent,
                   oocq001,oocq002
                   ,oocqstus,oocq005,oocq004,oocqmodid,oocqmoddt,oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq005,g_oocq_d[l_ac].oocq004,g_oocq1_info_d[l_ac].oocqmodid, 
                       g_oocq1_info_d[l_ac].oocqmoddt,g_oocq1_info_d[l_ac].oocqownid,g_oocq1_info_d[l_ac].oocqowndp, 
                       g_oocq1_info_d[l_ac].oocqcrtid,g_oocq1_info_d[l_ac].oocqcrtdp,g_oocq1_info_d[l_ac].oocqcrtdt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "oocq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "oocq_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE oocq_t 
         SET (oocq001,oocq002
              ,oocqstus,oocq005,oocq004,oocqmodid,oocqmoddt,oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oocq_d[l_ac].oocqstus,g_oocq_d[l_ac].oocq005,g_oocq_d[l_ac].oocq004,g_oocq1_info_d[l_ac].oocqmodid, 
                  g_oocq1_info_d[l_ac].oocqmoddt,g_oocq1_info_d[l_ac].oocqownid,g_oocq1_info_d[l_ac].oocqowndp, 
                  g_oocq1_info_d[l_ac].oocqcrtid,g_oocq1_info_d[l_ac].oocqcrtdp,g_oocq1_info_d[l_ac].oocqcrtdt)  
 
         WHERE oocqent = g_enterprise AND oocq001 = ps_keys_bak[1] AND oocq002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oocq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
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
 
{<section id="aooi310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi310_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aooi310_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "oocq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi310_bcl USING g_enterprise,
                                       g_oocq_d[g_detail_idx].oocq001,g_oocq_d[g_detail_idx].oocq002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi310_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi310_unlock_b(ps_table)
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
      CLOSE aooi310_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi310.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aooi310_modify_detail_chk(ps_record)
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
         LET ls_return = "oocqstus"
      WHEN "s_detail1_info"
         LET ls_return = "oocq001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi310.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aooi310_show_ownid_msg()
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
 
{<section id="aooi310.mask_functions" >}
&include "erp/aoo/aooi310_mask.4gl"
 
{</section>}
 
{<section id="aooi310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi310_set_pk_array()
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
   LET g_pk_array[1].values = g_oocq_d[l_ac].oocq001
   LET g_pk_array[1].column = 'oocq001'
   LET g_pk_array[2].values = g_oocq_d[l_ac].oocq002
   LET g_pk_array[2].column = 'oocq002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi310.state_change" >}
   
 
{</section>}
 
{<section id="aooi310.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi310.other_function" readonly="Y" >}
# 檢查有效筆數
# 若小於256，回傳true
# 反之，回傳false
PUBLIC FUNCTION aooi310_check_count(p_oocq001)
DEFINE p_oocq001    LIKE oocq_t.oocq001
DEFINE l_cnt        LIKE type_t.num10
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocqstus = 'Y'
   IF NOT cl_null(l_cnt) AND l_cnt >= 256 THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION
# 1~256，且不存在其他有效的oocq_t(庫存標籤檔)的oocq004內，找最小的數值
PUBLIC FUNCTION aooi310_get_oocq004()
DEFINE i           LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_oocq004   LIKE oocq_t.oocq004

   IF g_oocq_d[l_ac].oocqstus = 'N' THEN 
      SELECT oocq004 INTO l_oocq004 FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = g_oocq_d_t.oocq001
         AND oocq002 = g_oocq_d_t.oocq002
      RETURN l_oocq004
   END IF

   FOR i=1 TO 256
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = g_oocq_d[l_ac].oocq001
         AND oocq004 = i
         AND oocqstus= 'Y'
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         LET l_oocq004 = i
         EXIT FOR
      END IF
   END FOR
   
   RETURN l_oocq004
END FUNCTION

PUBLIC FUNCTION aooi310_check_oocq002()
DEFINE l_cnt    LIKE type_t.num10

   #修改時，先判斷是否存在於inac_t，存在則不允許修改
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM inac_t
    WHERE inacent = g_enterprise
      AND inac003 = g_oocq_d_t.oocq002
   IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION
#+ 檢查是否存在應用分類檔內，且有效
PRIVATE FUNCTION aooi310_check_oocq001(p_oocq001)
DEFINE p_oocq001    LIKE oocq_t.oocq001
DEFINE l_gzaastus   LIKE gzaa_t.gzaastus

   LET g_errno = ''
   SELECT gzaastus INTO l_gzaastus FROM gzaa_t
    WHERE gzaa001 = p_oocq001
    
   CASE
      WHEN SQLCA.sqlcode = 100  LET g_errno = 'aoo-00086'
      WHEN l_gzaastus = 'N'     LET g_errno = 'aoo-00087'
      OTHERWISE                 LET g_errno = SQLCA.sqlcode USING '-----'
   END CASE
   
END FUNCTION

 
{</section>}
 
