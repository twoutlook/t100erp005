#該程式未解開Section, 採用最新樣板產出!
{<section id="adbi220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-05-31 12:41:35), PR版次:0010(2017-02-16 18:31:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000153
#+ Filename...: adbi220
#+ Description: 銷售範圍維護作業
#+ Creator....: 04226(2014-04-28 11:30:05)
#+ Modifier...: 02749 -SD/PR- 05599
 
{</section>}
 
{<section id="adbi220.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#43  2016/04/26  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161006-00008#5   2016/10/19  By 08729    處理組織開窗
#170210-00025#1   2017/02/16  By Charles4m 增加組織校驗FUNCTION
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
PRIVATE TYPE type_g_dbbc_d RECORD
       dbbcstus LIKE dbbc_t.dbbcstus, 
   dbbc001 LIKE dbbc_t.dbbc001, 
   dbbcl003 LIKE type_t.chr500, 
   dbbcl004 LIKE type_t.chr500, 
   dbbc002 LIKE dbbc_t.dbbc002, 
   dbbc002_desc LIKE type_t.chr500, 
   dbbc003 LIKE dbbc_t.dbbc003, 
   dbbc003_desc LIKE type_t.chr500, 
   dbbc004 LIKE dbbc_t.dbbc004, 
   dbbc004_desc LIKE type_t.chr500, 
   dbbc005 LIKE dbbc_t.dbbc005, 
   dbbc005_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_dbbc2_d RECORD
       dbbc001 LIKE dbbc_t.dbbc001, 
   dbbcownid LIKE dbbc_t.dbbcownid, 
   dbbcownid_desc LIKE type_t.chr500, 
   dbbcowndp LIKE dbbc_t.dbbcowndp, 
   dbbcowndp_desc LIKE type_t.chr500, 
   dbbccrtid LIKE dbbc_t.dbbccrtid, 
   dbbccrtid_desc LIKE type_t.chr500, 
   dbbccrtdp LIKE dbbc_t.dbbccrtdp, 
   dbbccrtdp_desc LIKE type_t.chr500, 
   dbbccrtdt DATETIME YEAR TO SECOND, 
   dbbcmodid LIKE dbbc_t.dbbcmodid, 
   dbbcmodid_desc LIKE type_t.chr500, 
   dbbcmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      dbbcl001 LIKE dbbcl_t.dbbcl001,
      dbbcl002 LIKE dbbcl_t.dbbcl002,
      dbbcl003 LIKE dbbcl_t.dbbcl003,
      dbbcl004 LIKE dbbcl_t.dbbcl004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_dbbc_d          DYNAMIC ARRAY OF type_g_dbbc_d #單身變數
DEFINE g_dbbc_d_t        type_g_dbbc_d                  #單身備份
DEFINE g_dbbc_d_o        type_g_dbbc_d                  #單身備份
DEFINE g_dbbc_d_mask_o   DYNAMIC ARRAY OF type_g_dbbc_d #單身變數
DEFINE g_dbbc_d_mask_n   DYNAMIC ARRAY OF type_g_dbbc_d #單身變數
DEFINE g_dbbc2_d   DYNAMIC ARRAY OF type_g_dbbc2_d
DEFINE g_dbbc2_d_t type_g_dbbc2_d
DEFINE g_dbbc2_d_o type_g_dbbc2_d
DEFINE g_dbbc2_d_mask_o DYNAMIC ARRAY OF type_g_dbbc2_d
DEFINE g_dbbc2_d_mask_n DYNAMIC ARRAY OF type_g_dbbc2_d
 
      
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
 
{<section id="adbi220.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT dbbcstus,dbbc001,dbbc002,dbbc003,dbbc004,dbbc005,dbbc001,dbbcownid,dbbcowndp, 
       dbbccrtid,dbbccrtdp,dbbccrtdt,dbbcmodid,dbbcmoddt FROM dbbc_t WHERE dbbcent=? AND dbbc001=? FOR  
       UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbi220_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi220 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi220_init()   
 
      #進入選單 Menu (="N")
      CALL adbi220_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi220
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbi220.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi220_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   LET g_errshow = 1
   #end add-point
   
   CALL adbi220_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi220.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi220_ui_dialog()
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
         CALL g_dbbc_d.clear()
         CALL g_dbbc2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL adbi220_init()
      END IF
   
      CALL adbi220_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dbbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_dbbc2_d[g_detail_idx].dbbcownid   #(ver:35)
               LET g_data_dept = g_dbbc2_d[g_detail_idx].dbbcowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL adbi220_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               #150424-00018#4 150531 by lori522612 add---(S)
               CALL adbi220_set_act_visible()
               CALL adbi220_set_act_no_visible()
               #150424-00018#4 150531 by lori522612 add---(S)
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_dbbc2_d TO s_detail2.*
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
   CALL adbi220_set_pk_array()
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
            CALL adbi220_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi220_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL adbi220_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi220_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL adbi220_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi220_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbi220_insert()
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
               CALL adbi220_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_dbbc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_dbbc2_d)
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
            CALL adbi220_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbi220_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbi220_set_pk_array()
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
 
{<section id="adbi220.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi220_query()
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
   CALL g_dbbc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dbbcstus,dbbc001,dbbcl003,dbbcl004,dbbc002,dbbc003,dbbc004,dbbc005,dbbcownid, 
          dbbcowndp,dbbccrtid,dbbccrtdp,dbbccrtdt,dbbcmodid,dbbcmoddt 
 
         FROM s_detail1[1].dbbcstus,s_detail1[1].dbbc001,s_detail1[1].dbbcl003,s_detail1[1].dbbcl004, 
             s_detail1[1].dbbc002,s_detail1[1].dbbc003,s_detail1[1].dbbc004,s_detail1[1].dbbc005,s_detail2[1].dbbcownid, 
             s_detail2[1].dbbcowndp,s_detail2[1].dbbccrtid,s_detail2[1].dbbccrtdp,s_detail2[1].dbbccrtdt, 
             s_detail2[1].dbbcmodid,s_detail2[1].dbbcmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbbccrtdt>>----
         AFTER FIELD dbbccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbbcmoddt>>----
         AFTER FIELD dbbcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbccnfdt>>----
         
         #----<<dbbcpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcstus
            #add-point:BEFORE FIELD dbbcstus name="query.b.page1.dbbcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcstus
            
            #add-point:AFTER FIELD dbbcstus name="query.a.page1.dbbcstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbbcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcstus
            #add-point:ON ACTION controlp INFIELD dbbcstus name="query.c.page1.dbbcstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc001
            #add-point:ON ACTION controlp INFIELD dbbc001 name="construct.c.page1.dbbc001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbbc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbc001  #顯示到畫面上
            NEXT FIELD dbbc001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc001
            #add-point:BEFORE FIELD dbbc001 name="query.b.page1.dbbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc001
            
            #add-point:AFTER FIELD dbbc001 name="query.a.page1.dbbc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcl003
            #add-point:BEFORE FIELD dbbcl003 name="query.b.page1.dbbcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcl003
            
            #add-point:AFTER FIELD dbbcl003 name="query.a.page1.dbbcl003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbbcl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcl003
            #add-point:ON ACTION controlp INFIELD dbbcl003 name="query.c.page1.dbbcl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcl004
            #add-point:BEFORE FIELD dbbcl004 name="query.b.page1.dbbcl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcl004
            
            #add-point:AFTER FIELD dbbcl004 name="query.a.page1.dbbcl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbbcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcl004
            #add-point:ON ACTION controlp INFIELD dbbcl004 name="query.c.page1.dbbcl004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc002
            #add-point:ON ACTION controlp INFIELD dbbc002 name="construct.c.page1.dbbc002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'dbbc002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbbc002',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               #161006-00008#5 mark-(s)
               #LET g_qryparam.arg1 = g_site
               #LET g_qryparam.arg2 = '9'
               #CALL q_ooed004()                    #呼叫開窗
               #161006-00008#5 mark-(e)
               #161006-00008#5-add(s)
               LET g_qryparam.where = " ooef208 = 'Y' "
               CALL q_ooef001()
               #161006-00008#5-add(e)
            END IF
            DISPLAY g_qryparam.return1 TO dbbc002  #顯示到畫面上
            NEXT FIELD dbbc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc002
            #add-point:BEFORE FIELD dbbc002 name="query.b.page1.dbbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc002
            
            #add-point:AFTER FIELD dbbc002 name="query.a.page1.dbbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc003
            #add-point:ON ACTION controlp INFIELD dbbc003 name="construct.c.page1.dbbc003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbc003  #顯示到畫面上
            NEXT FIELD dbbc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc003
            #add-point:BEFORE FIELD dbbc003 name="query.b.page1.dbbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc003
            
            #add-point:AFTER FIELD dbbc003 name="query.a.page1.dbbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc004
            #add-point:ON ACTION controlp INFIELD dbbc004 name="construct.c.page1.dbbc004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbc004  #顯示到畫面上
            NEXT FIELD dbbc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc004
            #add-point:BEFORE FIELD dbbc004 name="query.b.page1.dbbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc004
            
            #add-point:AFTER FIELD dbbc004 name="query.a.page1.dbbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbbc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc005
            #add-point:ON ACTION controlp INFIELD dbbc005 name="construct.c.page1.dbbc005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'dbbc005') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbbc005',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef305 = 'Y'" 
               CALL q_ooef001()                    #呼叫開窗
            END IF
            DISPLAY g_qryparam.return1 TO dbbc005  #顯示到畫面上
            NEXT FIELD dbbc005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc005
            #add-point:BEFORE FIELD dbbc005 name="query.b.page1.dbbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc005
            
            #add-point:AFTER FIELD dbbc005 name="query.a.page1.dbbc005"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page2.dbbcownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcownid
            #add-point:ON ACTION controlp INFIELD dbbcownid name="construct.c.page2.dbbcownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbcownid  #顯示到畫面上
            NEXT FIELD dbbcownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcownid
            #add-point:BEFORE FIELD dbbcownid name="query.b.page2.dbbcownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcownid
            
            #add-point:AFTER FIELD dbbcownid name="query.a.page2.dbbcownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbbcowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcowndp
            #add-point:ON ACTION controlp INFIELD dbbcowndp name="construct.c.page2.dbbcowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbcowndp  #顯示到畫面上
            NEXT FIELD dbbcowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcowndp
            #add-point:BEFORE FIELD dbbcowndp name="query.b.page2.dbbcowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcowndp
            
            #add-point:AFTER FIELD dbbcowndp name="query.a.page2.dbbcowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbbccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbccrtid
            #add-point:ON ACTION controlp INFIELD dbbccrtid name="construct.c.page2.dbbccrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbccrtid  #顯示到畫面上
            NEXT FIELD dbbccrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbccrtid
            #add-point:BEFORE FIELD dbbccrtid name="query.b.page2.dbbccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbccrtid
            
            #add-point:AFTER FIELD dbbccrtid name="query.a.page2.dbbccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbbccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbccrtdp
            #add-point:ON ACTION controlp INFIELD dbbccrtdp name="construct.c.page2.dbbccrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbccrtdp  #顯示到畫面上
            NEXT FIELD dbbccrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbccrtdp
            #add-point:BEFORE FIELD dbbccrtdp name="query.b.page2.dbbccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbccrtdp
            
            #add-point:AFTER FIELD dbbccrtdp name="query.a.page2.dbbccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbccrtdt
            #add-point:BEFORE FIELD dbbccrtdt name="query.b.page2.dbbccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbbcmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcmodid
            #add-point:ON ACTION controlp INFIELD dbbcmodid name="construct.c.page2.dbbcmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbcmodid  #顯示到畫面上
            NEXT FIELD dbbcmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcmodid
            #add-point:BEFORE FIELD dbbcmodid name="query.b.page2.dbbcmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcmodid
            
            #add-point:AFTER FIELD dbbcmodid name="query.a.page2.dbbcmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcmoddt
            #add-point:BEFORE FIELD dbbcmoddt name="query.b.page2.dbbcmoddt"
            
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
    
   CALL adbi220_b_fill(g_wc2)
   LET g_data_owner = g_dbbc2_d[g_detail_idx].dbbcownid   #(ver:35)
   LET g_data_dept = g_dbbc2_d[g_detail_idx].dbbcowndp   #(ver:35)
 
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
 
{<section id="adbi220.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbi220_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL adbi220_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi220.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbi220_modify()
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
   DEFINE  l_errno                LIKE type_t.chr10
   #DEFINE  l_insert               LIKE type_t.num5  #151015-00010#2 Mark By Ken 
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
      INPUT ARRAY g_dbbc_d FROM s_detail1.*
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
            IF NOT cl_null(g_dbbc_d[g_detail_idx].dbbc001)  THEN
               CALL n_dbbcl(g_dbbc_d[g_detail_idx].dbbc001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_dbbc_d[g_detail_idx].dbbc001
               CALL ap_ref_array2(g_ref_fields," SELECT dbbcl003,dbbcl004 FROM dbbcl_t WHERE dbbclent = '"
                   ||g_enterprise||"' AND dbbcl001 = ? AND dbbcl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_dbbc_d[g_detail_idx].dbbcl003 = g_rtn_fields[1]
               LET g_dbbc_d[g_detail_idx].dbbcl004 = g_rtn_fields[2]
               DISPLAY BY NAME g_dbbc_d[g_detail_idx].dbbcl003
               DISPLAY BY NAME g_dbbc_d[g_detail_idx].dbbcl004
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbbc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbi220_b_fill(g_wc2)
            LET g_detail_cnt = g_dbbc_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            #150424-00018#4 150531 by lori522612 add---(S)
            CALL adbi220_set_act_visible()
            CALL adbi220_set_act_no_visible()
            #150424-00018#4 150531 by lori522612 add---(S)
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_dbbc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbbc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbbc_d[l_ac].dbbc001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbbc_d_t.* = g_dbbc_d[l_ac].*  #BACKUP
               LET g_dbbc_d_o.* = g_dbbc_d[l_ac].*  #BACKUP
               IF NOT adbi220_lock_b("dbbc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi220_bcl INTO g_dbbc_d[l_ac].dbbcstus,g_dbbc_d[l_ac].dbbc001,g_dbbc_d[l_ac].dbbc002, 
                      g_dbbc_d[l_ac].dbbc003,g_dbbc_d[l_ac].dbbc004,g_dbbc_d[l_ac].dbbc005,g_dbbc2_d[l_ac].dbbc001, 
                      g_dbbc2_d[l_ac].dbbcownid,g_dbbc2_d[l_ac].dbbcowndp,g_dbbc2_d[l_ac].dbbccrtid, 
                      g_dbbc2_d[l_ac].dbbccrtdp,g_dbbc2_d[l_ac].dbbccrtdt,g_dbbc2_d[l_ac].dbbcmodid, 
                      g_dbbc2_d[l_ac].dbbcmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbbc_d_t.dbbc001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbbc_d_mask_o[l_ac].* =  g_dbbc_d[l_ac].*
                  CALL adbi220_dbbc_t_mask()
                  LET g_dbbc_d_mask_n[l_ac].* =  g_dbbc_d[l_ac].*
                  
                  CALL adbi220_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi220_set_entry_b(l_cmd)
            CALL adbi220_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            LET g_dbbc_d_o.* = g_dbbc_d[l_ac].*
            CALL adbi220_set_entry_b(l_cmd)
            CALL adbi220_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.dbbcl001 = g_dbbc_d[l_ac].dbbc001
LET g_detail_multi_table_t.dbbcl002 = g_dlang
LET g_detail_multi_table_t.dbbcl003 = g_dbbc_d[l_ac].dbbcl003
LET g_detail_multi_table_t.dbbcl004 = g_dbbc_d[l_ac].dbbcl004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'dbbclent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'dbbcl001'
            LET l_var_keys[02] = g_dbbc_d[l_ac].dbbc001
            LET l_field_keys[03] = 'dbbcl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'dbbcl_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbbc_d_t.* TO NULL
            INITIALIZE g_dbbc_d_o.* TO NULL
            INITIALIZE g_dbbc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbbc2_d[l_ac].dbbcownid = g_user
      LET g_dbbc2_d[l_ac].dbbcowndp = g_dept
      LET g_dbbc2_d[l_ac].dbbccrtid = g_user
      LET g_dbbc2_d[l_ac].dbbccrtdp = g_dept 
      LET g_dbbc2_d[l_ac].dbbccrtdt = cl_get_current()
      LET g_dbbc2_d[l_ac].dbbcmodid = g_user
      LET g_dbbc2_d[l_ac].dbbcmoddt = cl_get_current()
      LET g_dbbc_d[l_ac].dbbcstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_dbbc_d[l_ac].dbbcstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            IF s_aooi500_setpoint(g_prog,'dbbc002') THEN
               CALL s_aooi500_default(g_prog,'dbbc002',g_site)
                  RETURNING l_insert,g_dbbc_d[l_ac].dbbc002
               IF l_insert = FALSE THEN
                  #因[作業組織應用設定維護作業aooi500]設定可輸入的值，已存在！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adb-00321'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  CANCEL INSERT
               END IF
            ELSE
               LET g_dbbc_d[l_ac].dbbc002 = g_site
            END IF
            CALL adbi220_dbbc002_ref()
            #end add-point
            LET g_dbbc_d_t.* = g_dbbc_d[l_ac].*     #新輸入資料
            LET g_dbbc_d_o.* = g_dbbc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbbc_d[li_reproduce_target].* = g_dbbc_d[li_reproduce].*
               LET g_dbbc2_d[li_reproduce_target].* = g_dbbc2_d[li_reproduce].*
 
               LET g_dbbc_d[g_dbbc_d.getLength()].dbbc001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.dbbcl001 = g_dbbc_d[l_ac].dbbc001
LET g_detail_multi_table_t.dbbcl002 = g_dlang
LET g_detail_multi_table_t.dbbcl003 = g_dbbc_d[l_ac].dbbcl003
LET g_detail_multi_table_t.dbbcl004 = g_dbbc_d[l_ac].dbbcl004
 
 
            CALL adbi220_set_entry_b(l_cmd)
            CALL adbi220_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM dbbc_t 
             WHERE dbbcent = g_enterprise AND dbbc001 = g_dbbc_d[l_ac].dbbc001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbbc_d[g_detail_idx].dbbc001
               CALL adbi220_insert_b('dbbc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               IF NOT adbi220_ins_ooef(gs_keys[1]) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_dbbc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "dbbc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi220_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbbc_d[l_ac].dbbc001 = g_detail_multi_table_t.dbbcl001 AND
         g_dbbc_d[l_ac].dbbcl003 = g_detail_multi_table_t.dbbcl003 AND
         g_dbbc_d[l_ac].dbbcl004 = g_detail_multi_table_t.dbbcl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbbclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbbc_d[l_ac].dbbc001
            LET l_field_keys[02] = 'dbbcl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbcl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbbcl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbbcl002
            LET l_vars[01] = g_dbbc_d[l_ac].dbbcl003
            LET l_fields[01] = 'dbbcl003'
            LET l_vars[02] = g_dbbc_d[l_ac].dbbcl004
            LET l_fields[02] = 'dbbcl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbbcl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (dbbc001 = '", g_dbbc_d[l_ac].dbbc001, "' "
 
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
               
               DELETE FROM dbbc_t
                WHERE dbbcent = g_enterprise AND 
                      dbbc001 = g_dbbc_d_t.dbbc001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbbc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbbclent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbbcl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbcl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbbcl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  IF NOT adbi220_del_ooef(g_dbbc_d_t.dbbc001) THEN
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL adbi220_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_dbbc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE adbi220_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_dbbc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbbc_d_t.dbbc001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi220_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
 
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL adbi220_delete_b('dbbc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dbbc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcstus
            #add-point:BEFORE FIELD dbbcstus name="input.b.page1.dbbcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcstus
            
            #add-point:AFTER FIELD dbbcstus name="input.a.page1.dbbcstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbcstus
            #add-point:ON CHANGE dbbcstus name="input.g.page1.dbbcstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc001
            #add-point:BEFORE FIELD dbbc001 name="input.b.page1.dbbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc001
            
            #add-point:AFTER FIELD dbbc001 name="input.a.page1.dbbc001"
            #此段落由子樣板a05產生
            IF  g_dbbc_d[g_detail_idx].dbbc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbbc_d[g_detail_idx].dbbc001 != g_dbbc_d_t.dbbc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbbc_t WHERE "||"dbbcent = '" ||g_enterprise|| "' AND "||"dbbc001 = '"||g_dbbc_d[g_detail_idx].dbbc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
           #170210-00025#1 ---add (s)---
            IF NOT adbi220_dbbc001_chk() THEN
               LET g_dbbc_d[l_ac].dbbc001 = g_dbbc_d_t.dbbc001
               NEXT FIELD CURRENT
            END IF
           #170210-00025#1 ---add (e)---


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbc001
            #add-point:ON CHANGE dbbc001 name="input.g.page1.dbbc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcl003
            #add-point:BEFORE FIELD dbbcl003 name="input.b.page1.dbbcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcl003
            
            #add-point:AFTER FIELD dbbcl003 name="input.a.page1.dbbcl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbcl003
            #add-point:ON CHANGE dbbcl003 name="input.g.page1.dbbcl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbcl004
            #add-point:BEFORE FIELD dbbcl004 name="input.b.page1.dbbcl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbcl004
            
            #add-point:AFTER FIELD dbbcl004 name="input.a.page1.dbbcl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbcl004
            #add-point:ON CHANGE dbbcl004 name="input.g.page1.dbbcl004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc002
            
            #add-point:AFTER FIELD dbbc002 name="input.a.page1.dbbc002"
            LET g_dbbc_d[l_ac].dbbc002_desc = ' '
            DISPLAY BY NAME g_dbbc_d[l_ac].dbbc002_desc
            IF NOT cl_null(g_dbbc_d[l_ac].dbbc002) THEN
               IF g_dbbc_d[l_ac].dbbc002 != g_dbbc_d_o.dbbc002 OR g_dbbc_d_o.dbbc002 IS NULL THEN
                  IF s_aooi500_setpoint(g_prog,'dbbc002') THEN
                     CALL s_aooi500_chk(g_prog,'dbbc002',g_dbbc_d[l_ac].dbbc002,g_site)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_dbbc_d[l_ac].dbbc002 = g_dbbc_d_o.dbbc002
                        CALL adbi220_dbbc002_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_dbbc_d[l_ac].dbbc002
                     LET g_chkparam.arg2 = '9'
                     LET g_chkparam.arg3 = g_site
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        LET g_dbbc_d[l_ac].dbbc002 = g_dbbc_d_o.dbbc002
                        CALL adbi220_dbbc002_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL adbi220_chk_only()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbbc_d[l_ac].dbbc002 = g_dbbc_d_o.dbbc002
                     CALL adbi220_dbbc002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adbi220_dbbc002_ref()
            LET  g_dbbc_d_o.dbbc002 = g_dbbc_d[l_ac].dbbc002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc002
            #add-point:BEFORE FIELD dbbc002 name="input.b.page1.dbbc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbc002
            #add-point:ON CHANGE dbbc002 name="input.g.page1.dbbc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc003
            
            #add-point:AFTER FIELD dbbc003 name="input.a.page1.dbbc003"
            LET g_dbbc_d[l_ac].dbbc003_desc = ' '
            DISPLAY BY NAME g_dbbc_d[l_ac].dbbc003_desc
            IF NOT cl_null(g_dbbc_d[l_ac].dbbc003) THEN
               IF g_dbbc_d[l_ac].dbbc003 != g_dbbc_d_o.dbbc003 OR g_dbbc_d_o.dbbc003 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbbc_d[l_ac].dbbc003
                  LET g_chkparam.arg2 = '1'
                  IF NOT cl_chk_exist("v_oojd001") THEN
                     LET g_dbbc_d[l_ac].dbbc003 = g_dbbc_d_o.dbbc003
                     CALL adbi220_dbbc003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL adbi220_chk_only()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbbc_d[l_ac].dbbc003 = g_dbbc_d_o.dbbc003
                     CALL adbi220_dbbc003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adbi220_dbbc003_ref()
            LET  g_dbbc_d_o.dbbc003 = g_dbbc_d[l_ac].dbbc003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc003
            #add-point:BEFORE FIELD dbbc003 name="input.b.page1.dbbc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbc003
            #add-point:ON CHANGE dbbc003 name="input.g.page1.dbbc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc004
            
            #add-point:AFTER FIELD dbbc004 name="input.a.page1.dbbc004"
            LET g_dbbc_d[l_ac].dbbc004_desc = ' '
            DISPLAY BY NAME g_dbbc_d[l_ac].dbbc004_desc
            IF NOT cl_null(g_dbbc_d[l_ac].dbbc004) THEN
               IF g_dbbc_d[l_ac].dbbc004 != g_dbbc_d_o.dbbc004 OR g_dbbc_d_o.dbbc004 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbbc_d[l_ac].dbbc004
                  IF NOT cl_chk_exist("v_dbba001") THEN
                     LET g_dbbc_d[l_ac].dbbc004 = g_dbbc_d_o.dbbc004
                     CALL adbi220_dbbc004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL adbi220_chk_only()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbbc_d[l_ac].dbbc004 = g_dbbc_d_o.dbbc004
                     CALL adbi220_dbbc004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adbi220_dbbc004_ref()
            LET  g_dbbc_d_o.dbbc004 = g_dbbc_d[l_ac].dbbc004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc004
            #add-point:BEFORE FIELD dbbc004 name="input.b.page1.dbbc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbc004
            #add-point:ON CHANGE dbbc004 name="input.g.page1.dbbc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbc005
            
            #add-point:AFTER FIELD dbbc005 name="input.a.page1.dbbc005"
            LET g_dbbc_d[l_ac].dbbc005_desc = ' '
            DISPLAY BY NAME g_dbbc_d[l_ac].dbbc005_desc
            IF NOT cl_null(g_dbbc_d[l_ac].dbbc005) THEN
               IF g_dbbc_d[l_ac].dbbc005 != g_dbbc_d_o.dbbc005 OR g_dbbc_d_o.dbbc005 IS NULL THEN
                  IF s_aooi500_setpoint(g_prog,'dbbc005') THEN
                     CALL s_aooi500_chk(g_prog,'dbbc005',g_dbbc_d[l_ac].dbbc005,g_site)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_dbbc_d[l_ac].dbbc005 = g_dbbc_d_o.dbbc005
                        CALL adbi220_dbbc005_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_dbbc_d[l_ac].dbbc005
                     IF NOT cl_chk_exist("v_ooef001_36") THEN
                        LET g_dbbc_d[l_ac].dbbc005 = g_dbbc_d_o.dbbc005
                        CALL adbi220_dbbc005_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL adbi220_chk_only()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbbc_d[l_ac].dbbc005 = g_dbbc_d_o.dbbc005
                     CALL adbi220_dbbc005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adbi220_dbbc005_ref()
            LET  g_dbbc_d_o.dbbc005 = g_dbbc_d[l_ac].dbbc005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbc005
            #add-point:BEFORE FIELD dbbc005 name="input.b.page1.dbbc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbc005
            #add-point:ON CHANGE dbbc005 name="input.g.page1.dbbc005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbbcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcstus
            #add-point:ON ACTION controlp INFIELD dbbcstus name="input.c.page1.dbbcstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc001
            #add-point:ON ACTION controlp INFIELD dbbc001 name="input.c.page1.dbbc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbcl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcl003
            #add-point:ON ACTION controlp INFIELD dbbcl003 name="input.c.page1.dbbcl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbcl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbcl004
            #add-point:ON ACTION controlp INFIELD dbbcl004 name="input.c.page1.dbbcl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc002
            #add-point:ON ACTION controlp INFIELD dbbc002 name="input.c.page1.dbbc002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbbc_d[l_ac].dbbc002             #給予default值
            
            #給予arg
            IF s_aooi500_setpoint(g_prog,'dbbc002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbbc002',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               #161006-00008#5 mark-(s)
               #LET g_qryparam.arg1 = g_site
               #LET g_qryparam.arg2 = '9'
               #CALL q_ooed004()                   #呼叫開窗  
               #161006-00008#5 mark-(e)
               #161006-00008#5-add(s)
               LET g_qryparam.where = " ooef208 = 'Y' "
               CALL q_ooef001()
               #161006-00008#5-add(e)
            END IF
            LET g_dbbc_d[l_ac].dbbc002 = g_qryparam.return1      
            DISPLAY g_dbbc_d[l_ac].dbbc002 TO dbbc002
            CALL adbi220_dbbc002_ref()
            NEXT FIELD dbbc002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc003
            #add-point:ON ACTION controlp INFIELD dbbc003 name="input.c.page1.dbbc003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbbc_d[l_ac].dbbc003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001_1()                                #呼叫開窗
            LET g_dbbc_d[l_ac].dbbc003 = g_qryparam.return1       
            DISPLAY g_dbbc_d[l_ac].dbbc003 TO dbbc003
            CALL adbi220_dbbc003_ref()
            NEXT FIELD dbbc003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc004
            #add-point:ON ACTION controlp INFIELD dbbc004 name="input.c.page1.dbbc004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbbc_d[l_ac].dbbc004             #給予default值

            CALL q_dbba001()                                #呼叫開窗
            LET g_dbbc_d[l_ac].dbbc004 = g_qryparam.return1   
            DISPLAY g_dbbc_d[l_ac].dbbc004 TO dbbc004
            CALL adbi220_dbbc004_ref()
            NEXT FIELD dbbc004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbc005
            #add-point:ON ACTION controlp INFIELD dbbc005 name="input.c.page1.dbbc005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbbc_d[l_ac].dbbc005             #給予default值

            #給予arg
            IF s_aooi500_setpoint(g_prog,'dbbc005') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbbc005',g_site,'i') #150308-00001#1  By Ken add 'i' 150309
               CALL q_ooef001_24()                 #呼叫開窗
            ELSE
               LET g_qryparam.where = " ooef305 = 'Y'" 
               CALL q_ooef001()                    #呼叫開窗
            END IF
            LET g_dbbc_d[l_ac].dbbc005 = g_qryparam.return1  
            DISPLAY g_dbbc_d[l_ac].dbbc005 TO dbbc005
            CALL adbi220_dbbc005_ref()
            NEXT FIELD dbbc005                          #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE adbi220_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_dbbc_d[l_ac].* = g_dbbc_d_t.*
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
               LET g_errparam.extend = g_dbbc_d[l_ac].dbbc001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_dbbc_d[l_ac].* = g_dbbc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_dbbc2_d[l_ac].dbbcmodid = g_user 
LET g_dbbc2_d[l_ac].dbbcmoddt = cl_get_current()
LET g_dbbc2_d[l_ac].dbbcmodid_desc = cl_get_username(g_dbbc2_d[l_ac].dbbcmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL adbi220_dbbc_t_mask_restore('restore_mask_o')
 
               UPDATE dbbc_t SET (dbbcstus,dbbc001,dbbc002,dbbc003,dbbc004,dbbc005,dbbcownid,dbbcowndp, 
                   dbbccrtid,dbbccrtdp,dbbccrtdt,dbbcmodid,dbbcmoddt) = (g_dbbc_d[l_ac].dbbcstus,g_dbbc_d[l_ac].dbbc001, 
                   g_dbbc_d[l_ac].dbbc002,g_dbbc_d[l_ac].dbbc003,g_dbbc_d[l_ac].dbbc004,g_dbbc_d[l_ac].dbbc005, 
                   g_dbbc2_d[l_ac].dbbcownid,g_dbbc2_d[l_ac].dbbcowndp,g_dbbc2_d[l_ac].dbbccrtid,g_dbbc2_d[l_ac].dbbccrtdp, 
                   g_dbbc2_d[l_ac].dbbccrtdt,g_dbbc2_d[l_ac].dbbcmodid,g_dbbc2_d[l_ac].dbbcmoddt)
                WHERE dbbcent = g_enterprise AND
                  dbbc001 = g_dbbc_d_t.dbbc001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbbc_d[g_detail_idx].dbbc001
               LET gs_keys_bak[1] = g_dbbc_d_t.dbbc001
               CALL adbi220_update_b('dbbc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbbc_d[l_ac].dbbc001 = g_detail_multi_table_t.dbbcl001 AND
         g_dbbc_d[l_ac].dbbcl003 = g_detail_multi_table_t.dbbcl003 AND
         g_dbbc_d[l_ac].dbbcl004 = g_detail_multi_table_t.dbbcl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbbclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbbc_d[l_ac].dbbc001
            LET l_field_keys[02] = 'dbbcl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbcl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbbcl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbbcl002
            LET l_vars[01] = g_dbbc_d[l_ac].dbbcl003
            LET l_fields[01] = 'dbbcl003'
            LET l_vars[02] = g_dbbc_d[l_ac].dbbcl004
            LET l_fields[02] = 'dbbcl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbbcl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_dbbc_d_t)
                     LET g_log2 = util.JSON.stringify(g_dbbc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL adbi220_dbbc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT adbi220_upd_ooef(g_dbbc_d[l_ac].dbbc001) THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adbi220_unlock_b("dbbc_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbbc_d[l_ac].* = g_dbbc_d_t.*
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
               LET g_dbbc_d[li_reproduce_target].* = g_dbbc_d[li_reproduce].*
               LET g_dbbc2_d[li_reproduce_target].* = g_dbbc2_d[li_reproduce].*
 
               LET g_dbbc_d[li_reproduce_target].dbbc001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbbc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbbc_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_dbbc2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL adbi220_b_fill(g_wc2)
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
               NEXT FIELD dbbcstus
            WHEN "s_detail2"
               NEXT FIELD dbbc001_2
 
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
      IF INT_FLAG OR cl_null(g_dbbc_d[g_detail_idx].dbbc001) THEN
         CALL g_dbbc_d.deleteElement(g_detail_idx)
         CALL g_dbbc2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_dbbc_d[g_detail_idx].* = g_dbbc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE adbi220_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi220.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi220_delete()
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
   FOR li_idx = 1 TO g_dbbc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT adbi220_lock_b("dbbc_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("dbbc_t","dbbcownid") THEN
            LET g_data_owner = g_dbbc2_d[g_detail_idx].dbbcownid
            LET g_data_dept = g_dbbc2_d[g_detail_idx].dbbcowndp
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
   
   FOR li_idx = 1 TO g_dbbc_d.getLength()
      IF g_dbbc_d[li_idx].dbbc001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
 
         #end add-point   
         
         DELETE FROM dbbc_t
          WHERE dbbcent = g_enterprise AND 
                dbbc001 = g_dbbc_d[li_idx].dbbc001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.dbbcl001 = g_dbbc_d[l_ac].dbbc001
LET g_detail_multi_table_t.dbbcl002 = g_dlang
LET g_detail_multi_table_t.dbbcl003 = g_dbbc_d[l_ac].dbbcl003
LET g_detail_multi_table_t.dbbcl004 = g_dbbc_d[l_ac].dbbcl004
 
 
            
LET g_detail_multi_table_t.dbbcl001 = g_dbbc_d[l_ac].dbbc001
LET g_detail_multi_table_t.dbbcl002 = g_dlang
LET g_detail_multi_table_t.dbbcl003 = g_dbbc_d[l_ac].dbbcl003
LET g_detail_multi_table_t.dbbcl004 = g_dbbc_d[l_ac].dbbcl004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbbclent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbbcl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbcl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbbcl_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbbclent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbbcl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbcl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbbcl_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbbc_d_t.dbbc001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL adbi220_delete_b('dbbc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            IF NOT adbi220_del_ooef(gs_keys[1]) THEN
               CALL s_transaction_end('N','0')
            END IF
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi220_set_pk_array()
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
   CALL adbi220_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="adbi220.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi220_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where  STRING   #161006-00008#5 add
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   #161006-00008#5-add(s)
   LET l_where = s_aooi500_sql_where(g_prog,'dbbc002')
   LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   #161006-00008#5-add(e)
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.dbbcstus,t0.dbbc001,t0.dbbc002,t0.dbbc003,t0.dbbc004,t0.dbbc005, 
       t0.dbbc001,t0.dbbcownid,t0.dbbcowndp,t0.dbbccrtid,t0.dbbccrtdp,t0.dbbccrtdt,t0.dbbcmodid,t0.dbbcmoddt , 
       t1.ooefl003 ,t2.oojdl003 ,t3.dbbal003 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 , 
       t9.ooag011 FROM dbbc_t t0",
               " LEFT JOIN dbbcl_t ON dbbclent = "||g_enterprise||" AND dbbc001 = dbbcl001 AND dbbcl002 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.dbbc002 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t2 ON t2.oojdlent="||g_enterprise||" AND t2.oojdl001=t0.dbbc003 AND t2.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN dbbal_t t3 ON t3.dbbalent="||g_enterprise||" AND t3.dbbal001=t0.dbbc004 AND t3.dbbal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.dbbc005 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.dbbcownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.dbbcowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.dbbccrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.dbbccrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.dbbcmodid  ",
 
               " WHERE t0.dbbcent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("dbbc_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND dbbcowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("dbbc_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND dbbcownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("dbbc_t"),
                      " ORDER BY t0.dbbc001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbbc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adbi220_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi220_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dbbc_d.clear()
   CALL g_dbbc2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dbbc_d[l_ac].dbbcstus,g_dbbc_d[l_ac].dbbc001,g_dbbc_d[l_ac].dbbc002,g_dbbc_d[l_ac].dbbc003, 
       g_dbbc_d[l_ac].dbbc004,g_dbbc_d[l_ac].dbbc005,g_dbbc2_d[l_ac].dbbc001,g_dbbc2_d[l_ac].dbbcownid, 
       g_dbbc2_d[l_ac].dbbcowndp,g_dbbc2_d[l_ac].dbbccrtid,g_dbbc2_d[l_ac].dbbccrtdp,g_dbbc2_d[l_ac].dbbccrtdt, 
       g_dbbc2_d[l_ac].dbbcmodid,g_dbbc2_d[l_ac].dbbcmoddt,g_dbbc_d[l_ac].dbbc002_desc,g_dbbc_d[l_ac].dbbc003_desc, 
       g_dbbc_d[l_ac].dbbc004_desc,g_dbbc_d[l_ac].dbbc005_desc,g_dbbc2_d[l_ac].dbbcownid_desc,g_dbbc2_d[l_ac].dbbcowndp_desc, 
       g_dbbc2_d[l_ac].dbbccrtid_desc,g_dbbc2_d[l_ac].dbbccrtdp_desc,g_dbbc2_d[l_ac].dbbcmodid_desc
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
      
      CALL adbi220_detail_show()      
 
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
   
 
   
   CALL g_dbbc_d.deleteElement(g_dbbc_d.getLength())   
   CALL g_dbbc2_d.deleteElement(g_dbbc2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dbbc_d.getLength()
      LET g_dbbc2_d[l_ac].dbbc001 = g_dbbc_d[l_ac].dbbc001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_dbbc_d.getLength() THEN
      LET l_ac = g_dbbc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbbc_d.getLength()
      LET g_dbbc_d_mask_o[l_ac].* =  g_dbbc_d[l_ac].*
      CALL adbi220_dbbc_t_mask()
      LET g_dbbc_d_mask_n[l_ac].* =  g_dbbc_d[l_ac].*
   END FOR
   
   LET g_dbbc2_d_mask_o.* =  g_dbbc2_d.*
   FOR l_ac = 1 TO g_dbbc2_d.getLength()
      LET g_dbbc2_d_mask_o[l_ac].* =  g_dbbc2_d[l_ac].*
      CALL adbi220_dbbc_t_mask()
      LET g_dbbc2_d_mask_n[l_ac].* =  g_dbbc2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_dbbc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE adbi220_pb
   
END FUNCTION
 
{</section>}
 
{<section id="adbi220.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi220_detail_show()
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
   CALL adbi220_dbbc002_ref()
   CALL adbi220_dbbc003_ref()
   CALL adbi220_dbbc004_ref()
   CALL adbi220_dbbc005_ref()

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_dbbc_d[l_ac].dbbc001
   CALL ap_ref_array2(g_ref_fields," SELECT dbbcl003 FROM dbbcl_t WHERE dbbclent = '"||g_enterprise||"' AND dbbcl001 = ? AND dbbcl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_dbbc_d[l_ac].dbbcl003 = g_rtn_fields[1] 
   DISPLAY BY NAME g_dbbc_d[l_ac].dbbcl003
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_dbbc_d[l_ac].dbbc001
   CALL ap_ref_array2(g_ref_fields," SELECT dbbcl004 FROM dbbcl_t WHERE dbbclent = '"||g_enterprise||"' AND dbbcl001 = ? AND dbbcl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_dbbc_d[l_ac].dbbcl004 = g_rtn_fields[1] 
   DISPLAY BY NAME g_dbbc_d[l_ac].dbbcl004
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbbc2_d[l_ac].dbbcownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbbc2_d[l_ac].dbbcownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbbc2_d[l_ac].dbbcownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbbc2_d[l_ac].dbbcowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbbc2_d[l_ac].dbbcowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbbc2_d[l_ac].dbbcowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbbc2_d[l_ac].dbbccrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbbc2_d[l_ac].dbbccrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbbc2_d[l_ac].dbbccrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbbc2_d[l_ac].dbbccrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbbc2_d[l_ac].dbbccrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbbc2_d[l_ac].dbbccrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbbc2_d[l_ac].dbbcmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbbc2_d[l_ac].dbbcmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbbc2_d[l_ac].dbbcmodid_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi220.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi220_set_entry_b(p_cmd)                                                  
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
      CALL cl_set_comp_entry("dbbc001",TRUE)
   END IF
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="adbi220.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi220_set_no_entry_b(p_cmd)                                               
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
      CALL cl_set_comp_entry("dbbc001",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="adbi220.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi220_default_search()
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
      LET ls_wc = ls_wc, " dbbc001 = '", g_argv[01], "' AND "
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
 
{<section id="adbi220.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi220_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "dbbc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'dbbc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM dbbc_t
          WHERE dbbcent = g_enterprise AND
            dbbc001 = ps_keys_bak[1]
         
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
         CALL g_dbbc_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_dbbc2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
 
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi220.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi220_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "dbbc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO dbbc_t
                  (dbbcent,
                   dbbc001
                   ,dbbcstus,dbbc002,dbbc003,dbbc004,dbbc005,dbbcownid,dbbcowndp,dbbccrtid,dbbccrtdp,dbbccrtdt,dbbcmodid,dbbcmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_dbbc_d[l_ac].dbbcstus,g_dbbc_d[l_ac].dbbc002,g_dbbc_d[l_ac].dbbc003,g_dbbc_d[l_ac].dbbc004, 
                       g_dbbc_d[l_ac].dbbc005,g_dbbc2_d[l_ac].dbbcownid,g_dbbc2_d[l_ac].dbbcowndp,g_dbbc2_d[l_ac].dbbccrtid, 
                       g_dbbc2_d[l_ac].dbbccrtdp,g_dbbc2_d[l_ac].dbbccrtdt,g_dbbc2_d[l_ac].dbbcmodid, 
                       g_dbbc2_d[l_ac].dbbcmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
 
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi220.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi220_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "dbbc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbbc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE dbbc_t 
         SET (dbbc001
              ,dbbcstus,dbbc002,dbbc003,dbbc004,dbbc005,dbbcownid,dbbcowndp,dbbccrtid,dbbccrtdp,dbbccrtdt,dbbcmodid,dbbcmoddt) 
              = 
             (ps_keys[1]
              ,g_dbbc_d[l_ac].dbbcstus,g_dbbc_d[l_ac].dbbc002,g_dbbc_d[l_ac].dbbc003,g_dbbc_d[l_ac].dbbc004, 
                  g_dbbc_d[l_ac].dbbc005,g_dbbc2_d[l_ac].dbbcownid,g_dbbc2_d[l_ac].dbbcowndp,g_dbbc2_d[l_ac].dbbccrtid, 
                  g_dbbc2_d[l_ac].dbbccrtdp,g_dbbc2_d[l_ac].dbbccrtdt,g_dbbc2_d[l_ac].dbbcmodid,g_dbbc2_d[l_ac].dbbcmoddt)  
 
         WHERE dbbcent = g_enterprise AND dbbc001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbc_t:",SQLERRMESSAGE 
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
 
{<section id="adbi220.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi220_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL adbi220_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dbbc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi220_bcl USING g_enterprise,
                                       g_dbbc_d[g_detail_idx].dbbc001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi220_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi220.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi220_unlock_b(ps_table)
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
      CLOSE adbi220_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi220.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION adbi220_modify_detail_chk(ps_record)
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
         LET ls_return = "dbbcstus"
      WHEN "s_detail2"
         LET ls_return = "dbbc001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adbi220.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION adbi220_show_ownid_msg()
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
 
{<section id="adbi220.mask_functions" >}
&include "erp/adb/adbi220_mask.4gl"
 
{</section>}
 
{<section id="adbi220.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbi220_set_pk_array()
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
   LET g_pk_array[1].values = g_dbbc_d[l_ac].dbbc001
   LET g_pk_array[1].column = 'dbbc001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbi220.state_change" >}
   
 
{</section>}
 
{<section id="adbi220.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adbi220.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 銷售組織編號帶出说明
# Memo...........:
# Usage..........: CALL adbi220_dbbc002_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi220_dbbc002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dbbc_d[l_ac].dbbc002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_dbbc_d[l_ac].dbbc002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_dbbc_d[l_ac].dbbc002_desc
END FUNCTION

################################################################################
# Descriptions...: 渠道編號帶出说明
# Memo...........:
# Usage..........: CALL adbi220_dbbc003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi220_dbbc003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dbbc_d[l_ac].dbbc003
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_dbbc_d[l_ac].dbbc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_dbbc_d[l_ac].dbbc003_desc
END FUNCTION

################################################################################
# Descriptions...: 產品組編號帶出说明
# Memo...........:
# Usage..........: CALL adbi220_dbbc004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi220_dbbc004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dbbc_d[l_ac].dbbc004
   CALL ap_ref_array2(g_ref_fields,"SELECT dbbal003 FROM dbbal_t WHERE dbbalent='"||g_enterprise||"' AND dbbal001=? AND dbbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_dbbc_d[l_ac].dbbc004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_dbbc_d[l_ac].dbbc004_desc
END FUNCTION

################################################################################
# Descriptions...: 辦事處編號帶出说明
# Memo...........:
# Usage..........: CALL adbi220_dbbc005_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi220_dbbc005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dbbc_d[l_ac].dbbc005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_dbbc_d[l_ac].dbbc005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_dbbc_d[l_ac].dbbc005_desc
END FUNCTION

################################################################################
# Descriptions...: 銷售組織+渠道編號+產品組編號+便是處編號為唯一，不可重複
# Memo...........:
# Usage..........: CALL adbi220_chk_only()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/28 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi220_chk_only()
DEFINE l_cnt           LIKE type_t.num5

   LET g_errno = ''
   IF cl_null(g_dbbc_d[l_ac].dbbc002) THEN
      RETURN
   END IF
   
   IF cl_null(g_dbbc_d[l_ac].dbbc003) THEN
      RETURN
   END IF
   
   IF cl_null(g_dbbc_d[l_ac].dbbc004) THEN
      RETURN
   END IF
   
   IF cl_null(g_dbbc_d[l_ac].dbbc005) THEN
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM dbbc_t
    WHERE dbbcent = g_enterprise
      AND dbbc002 = g_dbbc_d[l_ac].dbbc002
      AND dbbc003 = g_dbbc_d[l_ac].dbbc003
      AND dbbc004 = g_dbbc_d[l_ac].dbbc004
      AND dbbc005 = g_dbbc_d[l_ac].dbbc005
      AND dbbc001 <> NVL(g_dbbc_d_t.dbbc001,' ')
   IF l_cnt >= 1 THEN
      LET g_errno = 'adb-00032'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 同步刪除aooi100的資料
# Memo...........:
# Usage..........: CALL adbi220_del_ooef(p_dbbc001)
#                  RETURNING r_success
# Input parameter: p_dbbc001   銷售範圍編號
# Return code....: r_success   處理結果
# Date & Author..: 2014/11/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi220_del_ooef(p_dbbc001)
   DEFINE p_dbbc001       LIKE dbbc_t.dbbc001
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING   
   DEFINE l_ooef012       LIKE ooef_t.ooef012   
   
   LET r_success = TRUE
   
   #同步至aooi100
   LET l_ooef012 = ''
   SELECT ooef012 INTO l_ooef012 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = p_dbbc001
   
   DELETE FROM ooef_t
         WHERE ooefent = g_enterprise
           AND ooef001 = p_dbbc001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ooef_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      
      RETURN r_success
   END IF          

   INITIALIZE l_var_keys_bak TO NULL
   INITIALIZE l_field_keys   TO NULL
   LET l_var_keys_bak[01] = p_dbbc001
   LET l_field_keys[01] = 'ooefl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'ooefl_t')
   
   IF NOT cl_null(l_ooef012) THEN
      IF NOT s_aooi350_del(l_ooef012) THEN
         LET r_success = FALSE
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooef_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增銷售範圍時同步新增aooi100的資料
# Memo...........:
# Usage..........: CALL adbi220_ins_ooef(p_dbbc001)
#                  RETURNING r_success
# Input parameter: p_dbbc001   銷售範圍組織
# Return code....: r_success   處理結果
# Date & Author..: 2014/11/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi220_ins_ooef(p_dbbc001)
   DEFINE p_dbbc001       LIKE dbbc_t.dbbc001
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_oofa001       LIKE oofa_t.oofa001
   DEFINE l_success       LIKE type_t.num5
   
   LET r_success = TRUE
   
   #同步至aooi100
   INSERT INTO ooef_t (ooefent,ooef001,ooef200,ooef003,ooef209,ooefstus,
                       ooefownid,ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,
                       ooef201,ooef202,ooef203,ooef204,ooef205,
                       ooef206,ooef207,ooef208,ooef210,ooef211,
                       ooef212,ooef301,ooef302,ooef303,ooef304,
                       ooef305)
        VALUES (g_enterprise,p_dbbc001,'','N','Y',g_dbbc_d[l_ac].dbbcstus,
                g_dbbc2_d[l_ac].dbbcownid,g_dbbc2_d[l_ac].dbbcowndp,
                g_dbbc2_d[l_ac].dbbccrtid,g_dbbc2_d[l_ac].dbbccrtdp,g_dbbc2_d[l_ac].dbbccrtdt,
                'N','N','N','N','N',
                'N','N','N','N','N',
                'N','N','N','N','N',
                'N') 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ooef_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   INITIALIZE l_var_keys TO NULL
   INITIALIZE l_field_keys TO NULL
   INITIALIZE l_vars TO NULL
   INITIALIZE l_fields TO NULL
   IF p_dbbc001  = g_detail_multi_table_t.dbbcl001 AND
      g_dbbc_d[l_ac].dbbcl003 = g_detail_multi_table_t.dbbcl003 AND
      g_dbbc_d[l_ac].dbbcl004 = g_detail_multi_table_t.dbbcl004 THEN
   ELSE
      LET l_var_keys[01] = p_dbbc001
      LET l_field_keys[01] = 'ooefl001'
      LET l_var_keys_bak[01] = g_detail_multi_table_t.dbbcl001
      LET l_var_keys[02] = g_dlang
      LET l_field_keys[02] = 'ooefl002'
      LET l_var_keys_bak[02] = g_dlang
      LET l_vars[01] = g_dbbc_d[l_ac].dbbcl003
      LET l_fields[01] = 'ooefl003'
      LET l_vars[02] = g_dbbc_d[l_ac].dbbcl003
      LET l_fields[02] = 'ooefl004'
      LET l_vars[03] = g_dbbc_d[l_ac].dbbcl003
      LET l_fields[03] = 'ooefl006'
      LET l_vars[04] = g_dbbc_d[l_ac].dbbcl004 
      LET l_fields[04] = 'ooefl005'
      LET l_vars[05] = g_enterprise
      LET l_fields[05] = 'ooeflent'
      CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'ooefl_t')
   END IF    

   CALL s_aooi350_ins_oofa('1',p_dbbc001,'') RETURNING l_success,l_oofa001
   IF l_success THEN
      UPDATE ooef_t set ooef012 = l_oofa001 WHERE ooefent = g_enterprise AND ooef001 = p_dbbc001
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooef_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()         
      END IF
   ELSE
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "oofa_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新銷售範圍時同步更新aooi100的資料
# Memo...........:
# Usage..........: CALL adbi220_upd_ooef(p_dbbc001)
#                  RETURNING r_success
# Input parameter: p_dbbc001   銷售範圍編號
# Return code....: r_success   處理結果
# Date & Author..: 2014/11/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi220_upd_ooef(p_dbbc001)
   DEFINE p_dbbc001        LIKE dbbc_t.dbbc001
   DEFINE r_success        LIKE type_t.num5
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   
   LET r_success = TRUE
   
   #同步至aooi100
   UPDATE ooef_t 
      SET ooefent   = g_enterprise,
          ooef001   = p_dbbc001,
          ooefstus  = g_dbbc_d[l_ac].dbbcstus,
          ooefmodid = g_dbbc2_d[l_ac].dbbcmodid,
          ooefmoddt = g_dbbc2_d[l_ac].dbbcmoddt
    WHERE ooefent   = g_enterprise
      AND ooef001   = p_dbbc001
    CASE
       WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
          LET r_success = FALSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ooef_t"
          LET g_errparam.code   = "std-00009"
          LET g_errparam.popup  = TRUE
          CALL cl_err()

          RETURN r_success
       WHEN SQLCA.sqlcode #其他錯誤
          LET r_success = FALSE        
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ooef_t"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = TRUE
          CALL cl_err()

          RETURN r_success
       OTHERWISE
          INITIALIZE l_var_keys TO NULL
          INITIALIZE l_field_keys TO NULL
          INITIALIZE l_vars TO NULL
          INITIALIZE l_fields TO NULL
          IF p_dbbc001  = g_detail_multi_table_t.dbbcl001 AND
             g_dbbc_d[l_ac].dbbcl003 = g_detail_multi_table_t.dbbcl003 AND
             g_dbbc_d[l_ac].dbbcl004 = g_detail_multi_table_t.dbbcl004 THEN
          ELSE
             LET l_var_keys[01] = p_dbbc001
             LET l_field_keys[01] = 'ooefl001'
             LET l_var_keys_bak[01] = g_detail_multi_table_t.dbbcl001
             LET l_var_keys[02] = g_dlang
             LET l_field_keys[02] = 'ooefl002'
             LET l_var_keys_bak[02] = g_dlang
             LET l_vars[01] = g_dbbc_d[l_ac].dbbcl003
             LET l_fields[01] = 'ooefl003'
             LET l_vars[02] = g_dbbc_d[l_ac].dbbcl003
             LET l_fields[02] = 'ooefl004'
             LET l_vars[03] = g_dbbc_d[l_ac].dbbcl003
             LET l_fields[03] = 'ooefl006'
             LET l_vars[04] = g_dbbc_d[l_ac].dbbcl004 
             LET l_fields[04] = 'ooefl005'
             LET l_vars[05] = g_enterprise
             LET l_fields[05] = 'ooeflent'
             CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'ooefl_t')
          END IF 
   END CASE

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 功能鍵取消隱藏
# Memo...........:
# Usage..........: CALL adbi220_set_act_no_visible()
# Date & Author..: 2015/05/31 By Lori  
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi220_set_act_no_visible()
   #150424-00018#4 150531 by lori522612 add---(S)
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0036') ='Y' THEN
      CALL cl_set_act_visible("insert,modify,delete,modify_detail,reproduce",FALSE)
   END IF   
   #150424-00018#4 150531 by lori522612 add---(E)
END FUNCTION

################################################################################
# Descriptions...: 功能鍵隱藏
# Memo...........:
# Usage..........: CALL adbi220_set_act_visible()
# Date & Author..: 2015/05/31 By Lori 
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi220_set_act_visible()
   CALL cl_set_act_visible("insert,modify,delete,modify_detail,reproduce",TRUE)   #150424-00018#4 150531 by lori522612 add
END FUNCTION

################################################################################
# Descriptions...: 組織編號校驗
# Memo...........:
# Usage..........: CALL adbi220_dbbc001_chk()
#                  RETURNING r_success
# Return code....: r_success 校驗結果
# Date & Author..: 2017/02/16 By Charles4m
# Modify.........: #170210-00025#1
################################################################################
PRIVATE FUNCTION adbi220_dbbc001_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_exist     LIKE type_t.chr1
   DEFINE l_ooef209   LIKE ooef_t.ooef209   #銷售範圍
   DEFINE l_ooef305   LIKE ooef_t.ooef305   #辦事處
   DEFINE l_gzze003   LIKE gzze_t.gzze003
   DEFINE l_cnt       LIKE type_t.num5

   LET r_success = TRUE
   LET l_exist   = NULL
   LET l_ooef209 = NULL
   LET l_ooef305 = NULL
   LET l_gzze003 = NULL
   LET l_cnt = 0

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM oojm_t,oojl_t
    WHERE oojment = oojlent
      AND oojmdocno = oojldocno
      AND oojment = g_enterprise
      AND oojm001 = g_dbbc_d[l_ac].dbbc001
      AND oojlstus ='N'
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aoo-00394"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   SELECT 'Y',ooef209,ooef305
     INTO l_exist,l_ooef209,l_ooef305
     FROM ooef_t
    WHERE ooef001 = g_dbbc_d[l_ac].dbbc001
      AND ooefent = g_enterprise 
    
   CASE
      WHEN l_ooef209 = 'Y'
         LET l_gzze003 = cl_getmsg('aoo-00330',g_dlang)
      WHEN l_ooef209 = 'Y'
         LET l_gzze003 = cl_getmsg('aoo-00330',g_dlang)
      OTHERWISE
         LET l_gzze003 = cl_getmsg('aoo-00328',g_dlang)
   END CASE
    
   IF l_exist = 'Y' THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aoo-00331"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_gzze003
      CALL cl_err()
    
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
