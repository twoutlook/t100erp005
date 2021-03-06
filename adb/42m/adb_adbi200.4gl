#該程式未解開Section, 採用最新樣板產出!
{<section id="adbi200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-05-04 10:31:09), PR版次:0007(2017-01-23 10:07:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000466
#+ Filename...: adbi200
#+ Description: 銷售層級維護作業
#+ Creator....: 04226(2014-02-19 11:02:47)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="adbi200.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00003#1   2016/09/05  By Rainy       修正WHERE 條件沒下ent
#161108-00027#1   2016/11/08  By lori        調整g_browser_cnt長度變數定義為num10
#170120-00038#1   2017/01/23  By 06814       修正WHERE 條件沒下ent(補)
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
PRIVATE TYPE type_g_dbaa_d RECORD
       dbaastus LIKE dbaa_t.dbaastus, 
   dbaa001 LIKE dbaa_t.dbaa001, 
   dbaal003 LIKE dbaal_t.dbaal003, 
   dbaa002 LIKE dbaa_t.dbaa002, 
   dbaa003 LIKE dbaa_t.dbaa003, 
   dbaa003_desc LIKE type_t.chr500, 
   dbaa004 LIKE dbaa_t.dbaa004
       END RECORD
PRIVATE TYPE type_g_dbaa2_d RECORD
       dbaa001 LIKE dbaa_t.dbaa001, 
   dbaa001_2_desc LIKE type_t.chr500, 
   dbaaownid LIKE dbaa_t.dbaaownid, 
   dbaaownid_desc LIKE type_t.chr500, 
   dbaaowndp LIKE dbaa_t.dbaaowndp, 
   dbaaowndp_desc LIKE type_t.chr500, 
   dbaacrtid LIKE dbaa_t.dbaacrtid, 
   dbaacrtid_desc LIKE type_t.chr500, 
   dbaacrtdp LIKE dbaa_t.dbaacrtdp, 
   dbaacrtdp_desc LIKE type_t.chr500, 
   dbaacrtdt DATETIME YEAR TO SECOND, 
   dbaamodid LIKE dbaa_t.dbaamodid, 
   dbaamodid_desc LIKE type_t.chr500, 
   dbaamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      dbaal001 LIKE dbaal_t.dbaal001,
      dbaal002 LIKE dbaal_t.dbaal002,
      dbaal003 LIKE dbaal_t.dbaal003
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tree          DYNAMIC ARRAY OF RECORD     #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,         #外顯欄位
       b_pid           LIKE type_t.chr100,         #父節點id
       b_id            LIKE type_t.chr100,         #本身節點id
       b_exp           LIKE type_t.chr100,         #是否展開
       b_hasC          LIKE type_t.num5,           #是否有子節點
       b_isExp         LIKE type_t.num5,           #是否已展開
       b_expcode       LIKE type_t.num5,           #展開值
       b_dbaa001       LIKE dbaa_t.dbaa001,        #地域編號
       b_dbaa003       LIKE dbaa_t.dbaa003,        #上層地域編號
       b_dbaa004       LIKE dbaa_t.dbaa004,        #上層地域類型
       b_dbaastus      LIKE dbaa_t.dbaastus        #有效否
                       END RECORD
 
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
#DEFINE g_browser_cnt  LIKE type_t.num5            #total count   #161108-00027#1 161108 by lori mark
DEFINE g_browser_cnt   LIKE type_t.num10           #total count   #161108-00027#1 161108 by lori add
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_current_row   LIKE type_t.num5            #Browser所在筆數
DEFINE g_current_sw    LIKE type_t.num5            #Browser所在筆數用開關
DEFINE g_row_index     LIKE type_t.num5
DEFINE g_root_search   BOOLEAN
DEFINE g_searchtype    LIKE type_t.chr200
DEFINE g_wc            STRING
DEFINE g_first         LIKE type_t.chr1            #紀錄是否是程式剛開始進入狀態
DEFINE g_update        LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_dbaa_d          DYNAMIC ARRAY OF type_g_dbaa_d #單身變數
DEFINE g_dbaa_d_t        type_g_dbaa_d                  #單身備份
DEFINE g_dbaa_d_o        type_g_dbaa_d                  #單身備份
DEFINE g_dbaa_d_mask_o   DYNAMIC ARRAY OF type_g_dbaa_d #單身變數
DEFINE g_dbaa_d_mask_n   DYNAMIC ARRAY OF type_g_dbaa_d #單身變數
DEFINE g_dbaa2_d   DYNAMIC ARRAY OF type_g_dbaa2_d
DEFINE g_dbaa2_d_t type_g_dbaa2_d
DEFINE g_dbaa2_d_o type_g_dbaa2_d
DEFINE g_dbaa2_d_mask_o DYNAMIC ARRAY OF type_g_dbaa2_d
DEFINE g_dbaa2_d_mask_n DYNAMIC ARRAY OF type_g_dbaa2_d
 
      
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
 
{<section id="adbi200.main" >}
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
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT dbaastus,dbaa001,dbaa002,dbaa003,dbaa004,dbaa001,dbaaownid,dbaaowndp,dbaacrtid, 
       dbaacrtdp,dbaacrtdt,dbaamodid,dbaamoddt FROM dbaa_t WHERE dbaaent=? AND dbaa001=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbi200_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi200 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi200_init()   
 
      #進入選單 Menu (="N")
      CALL adbi200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi200
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbi200.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi200_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('dbaa002','6701') 
   CALL cl_set_combo_scc('dbaa004','6701') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   LET g_update = FALSE
   DROP TABLE adbi200_tmp
   
   #Create temp table
   CREATE TEMP TABLE adbi200_tmp
   (
      dbaa001   VARCHAR(500),
      dbaa003   VARCHAR(500),
      dbaa004   VARCHAR(500),
      dbaastus  VARCHAR(1),
      exp_code  VARCHAR(5)          
   );
   DROP TABLE adbi200_status
   CREATE TEMP TABLE adbi200_status(
      dbaa001   VARCHAR(500),
      expanded  VARCHAR(1)
   );
   LET g_first = 0
   #end add-point
   
   CALL adbi200_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi200.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi200_ui_dialog()
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
   DEFINE i        LIKE type_t.num10
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL adbi200_browser_fill(g_wc,g_searchtype)
   FOR i = 1 TO g_tree.getLength()
      LET g_tree[i].b_exp = '1'          #是否展開 1展開 2不展開
      LET g_tree[i].b_isExp = 1
   END FOR
   FOR i = 1 TO g_tree.getLength()
      INSERT INTO adbi200_status(dbaa001,expanded)
         VALUES(g_tree[i].b_dbaa001,g_tree[i].b_exp)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode 
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END FOR
   LET g_first = 1
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_dbaa_d.clear()
         CALL g_dbaa2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL adbi200_init()
      END IF
   
      CALL adbi200_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dbaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_dbaa2_d[g_detail_idx].dbaaownid   #(ver:35)
               LET g_data_dept = g_dbaa2_d[g_detail_idx].dbaaowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL adbi200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_dbaa2_d TO s_detail2.*
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
   CALL adbi200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_tree TO s_tree.*
            BEFORE DISPLAY
               CALL DIALOG.setSelectionMode("s_tree",1) #設定為單選
 
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_tree")
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_tree",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont() 
               CALL DIALOG.setCurrentRow("s_tree",g_current_row)
 
            ON EXPAND (g_row_index)
               #樹展開
               LET g_tree[g_row_index].b_isExp = 1
               UPDATE adbi200_status SET expanded = '1'
                WHERE dbaa001 = g_tree[g_row_index].b_dbaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
 
            ON COLLAPSE (g_row_index)
               #樹關閉
               LET g_tree[g_row_index].b_isExp = 0
               UPDATE adbi200_status SET expanded = '0'
                WHERE dbaa001 = g_tree[g_row_index].b_dbaa001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
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
            CALL adbi200_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi200_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL adbi200_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi200_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL adbi200_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi200_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbi200_insert()
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
               CALL adbi200_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_dbaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_dbaa2_d)
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
            CALL adbi200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbi200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbi200_set_pk_array()
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
 
{<section id="adbi200.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi200_query()
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
   CALL g_dbaa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dbaastus,dbaa001,dbaal003,dbaa002,dbaa003,dbaa004,dbaaownid,dbaaowndp,dbaacrtid, 
          dbaacrtdp,dbaacrtdt,dbaamodid,dbaamoddt 
 
         FROM s_detail1[1].dbaastus,s_detail1[1].dbaa001,s_detail1[1].dbaal003,s_detail1[1].dbaa002, 
             s_detail1[1].dbaa003,s_detail1[1].dbaa004,s_detail2[1].dbaaownid,s_detail2[1].dbaaowndp, 
             s_detail2[1].dbaacrtid,s_detail2[1].dbaacrtdp,s_detail2[1].dbaacrtdt,s_detail2[1].dbaamodid, 
             s_detail2[1].dbaamoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbaacrtdt>>----
         AFTER FIELD dbaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbaamoddt>>----
         AFTER FIELD dbaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbaacnfdt>>----
         
         #----<<dbaapstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaastus
            #add-point:BEFORE FIELD dbaastus name="query.b.page1.dbaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaastus
            
            #add-point:AFTER FIELD dbaastus name="query.a.page1.dbaastus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaastus
            #add-point:ON ACTION controlp INFIELD dbaastus name="query.c.page1.dbaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa001
            #add-point:ON ACTION controlp INFIELD dbaa001 name="construct.c.page1.dbaa001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_dbaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaa001  #顯示到畫面上

            NEXT FIELD dbaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa001
            #add-point:BEFORE FIELD dbaa001 name="query.b.page1.dbaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa001
            
            #add-point:AFTER FIELD dbaa001 name="query.a.page1.dbaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaal003
            #add-point:BEFORE FIELD dbaal003 name="query.b.page1.dbaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaal003
            
            #add-point:AFTER FIELD dbaal003 name="query.a.page1.dbaal003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaal003
            #add-point:ON ACTION controlp INFIELD dbaal003 name="query.c.page1.dbaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa002
            #add-point:BEFORE FIELD dbaa002 name="query.b.page1.dbaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa002
            
            #add-point:AFTER FIELD dbaa002 name="query.a.page1.dbaa002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa002
            #add-point:ON ACTION controlp INFIELD dbaa002 name="query.c.page1.dbaa002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa003
            #add-point:ON ACTION controlp INFIELD dbaa003 name="construct.c.page1.dbaa003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_dbaa003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaa003  #顯示到畫面上

            NEXT FIELD dbaa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa003
            #add-point:BEFORE FIELD dbaa003 name="query.b.page1.dbaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa003
            
            #add-point:AFTER FIELD dbaa003 name="query.a.page1.dbaa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa004
            #add-point:BEFORE FIELD dbaa004 name="query.b.page1.dbaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa004
            
            #add-point:AFTER FIELD dbaa004 name="query.a.page1.dbaa004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa004
            #add-point:ON ACTION controlp INFIELD dbaa004 name="query.c.page1.dbaa004"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.dbaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaaownid
            #add-point:ON ACTION controlp INFIELD dbaaownid name="construct.c.page2.dbaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaaownid  #顯示到畫面上
            NEXT FIELD dbaaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaaownid
            #add-point:BEFORE FIELD dbaaownid name="query.b.page2.dbaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaaownid
            
            #add-point:AFTER FIELD dbaaownid name="query.a.page2.dbaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaaowndp
            #add-point:ON ACTION controlp INFIELD dbaaowndp name="construct.c.page2.dbaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaaowndp  #顯示到畫面上
            NEXT FIELD dbaaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaaowndp
            #add-point:BEFORE FIELD dbaaowndp name="query.b.page2.dbaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaaowndp
            
            #add-point:AFTER FIELD dbaaowndp name="query.a.page2.dbaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaacrtid
            #add-point:ON ACTION controlp INFIELD dbaacrtid name="construct.c.page2.dbaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaacrtid  #顯示到畫面上
            NEXT FIELD dbaacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaacrtid
            #add-point:BEFORE FIELD dbaacrtid name="query.b.page2.dbaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaacrtid
            
            #add-point:AFTER FIELD dbaacrtid name="query.a.page2.dbaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaacrtdp
            #add-point:ON ACTION controlp INFIELD dbaacrtdp name="construct.c.page2.dbaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaacrtdp  #顯示到畫面上
            NEXT FIELD dbaacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaacrtdp
            #add-point:BEFORE FIELD dbaacrtdp name="query.b.page2.dbaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaacrtdp
            
            #add-point:AFTER FIELD dbaacrtdp name="query.a.page2.dbaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaacrtdt
            #add-point:BEFORE FIELD dbaacrtdt name="query.b.page2.dbaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaamodid
            #add-point:ON ACTION controlp INFIELD dbaamodid name="construct.c.page2.dbaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaamodid  #顯示到畫面上
            NEXT FIELD dbaamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaamodid
            #add-point:BEFORE FIELD dbaamodid name="query.b.page2.dbaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaamodid
            
            #add-point:AFTER FIELD dbaamodid name="query.a.page2.dbaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaamoddt
            #add-point:BEFORE FIELD dbaamoddt name="query.b.page2.dbaamoddt"
            
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
    
   CALL adbi200_b_fill(g_wc2)
   LET g_data_owner = g_dbaa2_d[g_detail_idx].dbaaownid   #(ver:35)
   LET g_data_dept = g_dbaa2_d[g_detail_idx].dbaaowndp   #(ver:35)
 
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
 
{<section id="adbi200.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbi200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL adbi200_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi200.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbi200_modify()
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
   DEFINE  l_seat                 LIKE type_t.num5
   DEFINE  l_id                   STRING
   DEFINE  l_pid                  STRING
   DEFINE  l_len                  LIKE type_t.num10
   DEFINE  l_chk                  STRING
   DEFINE  l_dbaastus             LIKE dbaa_t.dbaastus
   DEFINE  l_msg                  STRING
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
      INPUT ARRAY g_dbaa_d FROM s_detail1.*
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
            IF NOT cl_null(g_dbaa_d[g_detail_idx].dbaa001)  THEN
               CALL n_dbaal(g_dbaa_d[g_detail_idx].dbaa001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_dbaa_d[g_detail_idx].dbaa001
               CALL ap_ref_array2(g_ref_fields," SELECT dbaal003,dbaal004 FROM dbaal_t WHERE dbaalent = '"
                   ||g_enterprise||"' AND dbaal001 = ? AND dbaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_dbaa_d[g_detail_idx].dbaal003 = g_rtn_fields[1]
               DISPLAY BY NAME g_dbaa_d[g_detail_idx].dbaal003
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbi200_b_fill(g_wc2)
            LET g_detail_cnt = g_dbaa_d.getLength()
         
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
            DISPLAY g_dbaa_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbaa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbaa_d[l_ac].dbaa001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbaa_d_t.* = g_dbaa_d[l_ac].*  #BACKUP
               LET g_dbaa_d_o.* = g_dbaa_d[l_ac].*  #BACKUP
               IF NOT adbi200_lock_b("dbaa_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi200_bcl INTO g_dbaa_d[l_ac].dbaastus,g_dbaa_d[l_ac].dbaa001,g_dbaa_d[l_ac].dbaa002, 
                      g_dbaa_d[l_ac].dbaa003,g_dbaa_d[l_ac].dbaa004,g_dbaa2_d[l_ac].dbaa001,g_dbaa2_d[l_ac].dbaaownid, 
                      g_dbaa2_d[l_ac].dbaaowndp,g_dbaa2_d[l_ac].dbaacrtid,g_dbaa2_d[l_ac].dbaacrtdp, 
                      g_dbaa2_d[l_ac].dbaacrtdt,g_dbaa2_d[l_ac].dbaamodid,g_dbaa2_d[l_ac].dbaamoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbaa_d_t.dbaa001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbaa_d_mask_o[l_ac].* =  g_dbaa_d[l_ac].*
                  CALL adbi200_dbaa_t_mask()
                  LET g_dbaa_d_mask_n[l_ac].* =  g_dbaa_d[l_ac].*
                  
                  CALL adbi200_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi200_set_entry_b(l_cmd)
            CALL adbi200_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            LET g_dbaa_d_o.* = g_dbaa_d[l_ac].*
            LET g_update = FALSE
            CALL adbi200_set_entry_b(l_cmd)
            CALL adbi200_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.dbaal001 = g_dbaa_d[l_ac].dbaa001
LET g_detail_multi_table_t.dbaal002 = g_dlang
LET g_detail_multi_table_t.dbaal003 = g_dbaa_d[l_ac].dbaal003
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'dbaalent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'dbaal001'
            LET l_var_keys[02] = g_dbaa_d[l_ac].dbaa001
            LET l_field_keys[03] = 'dbaal002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'dbaal_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbaa_d_t.* TO NULL
            INITIALIZE g_dbaa_d_o.* TO NULL
            INITIALIZE g_dbaa_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbaa2_d[l_ac].dbaaownid = g_user
      LET g_dbaa2_d[l_ac].dbaaowndp = g_dept
      LET g_dbaa2_d[l_ac].dbaacrtid = g_user
      LET g_dbaa2_d[l_ac].dbaacrtdp = g_dept 
      LET g_dbaa2_d[l_ac].dbaacrtdt = cl_get_current()
      LET g_dbaa2_d[l_ac].dbaamodid = g_user
      LET g_dbaa2_d[l_ac].dbaamoddt = cl_get_current()
      LET g_dbaa_d[l_ac].dbaastus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_dbaa_d[l_ac].dbaastus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_dbaa_d_t.* = g_dbaa_d[l_ac].*     #新輸入資料
            LET g_dbaa_d_o.* = g_dbaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbaa_d[li_reproduce_target].* = g_dbaa_d[li_reproduce].*
               LET g_dbaa2_d[li_reproduce_target].* = g_dbaa2_d[li_reproduce].*
 
               LET g_dbaa_d[g_dbaa_d.getLength()].dbaa001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.dbaal001 = g_dbaa_d[l_ac].dbaa001
LET g_detail_multi_table_t.dbaal002 = g_dlang
LET g_detail_multi_table_t.dbaal003 = g_dbaa_d[l_ac].dbaal003
 
 
            CALL adbi200_set_entry_b(l_cmd)
            CALL adbi200_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM dbaa_t 
             WHERE dbaaent = g_enterprise AND dbaa001 = g_dbaa_d[l_ac].dbaa001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaa_d[g_detail_idx].dbaa001
               CALL adbi200_insert_b('dbaa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_dbaa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "dbaa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi200_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbaa_d[l_ac].dbaa001 = g_detail_multi_table_t.dbaal001 AND
         g_dbaa_d[l_ac].dbaal003 = g_detail_multi_table_t.dbaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbaa_d[l_ac].dbaa001
            LET l_field_keys[02] = 'dbaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbaal002
            LET l_vars[01] = g_dbaa_d[l_ac].dbaal003
            LET l_fields[01] = 'dbaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbaal_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               INSERT INTO adbi200_status(dbaa001,expanded) VALUES(g_dbaa_d[l_ac].dbaa001,'0')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL adbi200_browser_fill(g_wc,g_searchtype)
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (dbaa001 = '", g_dbaa_d[l_ac].dbaa001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM dbaa_t
                WHERE dbaaent = g_enterprise      #160905-00003#1 add by rainy 加上ent條件
                  AND dbaa003 = g_dbaa_d_t.dbaa001
               IF l_n >= 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adb-00004'
                  LET g_errparam.extend = g_dbaa_d_t.dbaa001
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
               
               DELETE FROM dbaa_t
                WHERE dbaaent = g_enterprise AND 
                      dbaa001 = g_dbaa_d_t.dbaa001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbaal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbaal_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  #DELETE FROM adbi200_status WHERE dbaaent = g_enterprise AND dbaa001 = g_dbaa_d_t.dbaa001  #160905-00003#1 modify by rainy 加上ent條件
                  DELETE FROM adbi200_status WHERE  dbaa001 = g_dbaa_d_t.dbaa001  #161027-00037#1 mod by tangyi 161027 临时表里没ent字段
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  END IF
                  CALL adbi200_browser_fill(g_wc,g_searchtype)
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL adbi200_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_dbaa_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE adbi200_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_dbaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaa_d_t.dbaa001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL adbi200_delete_b('dbaa_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dbaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaastus
            #add-point:BEFORE FIELD dbaastus name="input.b.page1.dbaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaastus
            
            #add-point:AFTER FIELD dbaastus name="input.a.page1.dbaastus"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaastus
            #add-point:ON CHANGE dbaastus name="input.g.page1.dbaastus"
            IF NOT cl_null(g_dbaa_d[l_ac].dbaastus) THEN
               #有效更改成無效
               IF g_dbaa_d[l_ac].dbaastus = 'N' AND g_dbaa_d_o.dbaastus = 'Y' THEN
                  #先找到此地域編號在g_tree陣列裡的位置
                  LET l_seat = 0
                  FOR l_i = 1 TO g_tree.getLength()
                     IF g_tree[l_i].b_dbaa001 = g_dbaa_d[l_ac].dbaa001 THEN
                        LET l_seat = l_i
                     END IF
                  END FOR
                  LET l_count = 0
                  #利用樹去找出他的下層
                  LET l_id = g_tree[l_seat].b_id
                  LET l_len = l_id.getLength()
                  FOR l_i = 1 TO g_tree.getLength()
                     LET l_pid = g_tree[l_i].b_pid
                     IF l_id = l_pid.subString(1,l_len) AND g_tree[l_i].b_dbaastus = 'Y' THEN
                        LET l_count = l_count + 1
                     END IF
                  END FOR
                  
                  #詢問是否更改為無效狀態，連同他的下層一同更改
                  IF l_count >= 1 THEN
                     IF cl_ask_confirm('adb-00009') THEN
                        LET g_update = TRUE
                     ELSE
                        LET g_dbaa_d[l_ac].dbaastus = g_dbaa_d_t.dbaastus
                     END IF
                  END IF
               END IF
               
               #無效更改成有效
               IF g_dbaa_d[l_ac].dbaastus = 'Y' AND g_dbaa_d_o.dbaastus = 'N' THEN
                  IF NOT cl_null(g_dbaa_d[l_ac].dbaa003) THEN
                     LET l_count = 0
                     SELECT COUNT(*) INTO l_count
                       FROM dbaa_t
                      WHERE dbaaent = g_enterprise             #160905-00003#1 modify by rainy 加上ent條件
                        AND dbaa001 = g_dbaa_d[l_ac].dbaa003
                        AND dbaastus = 'Y'
                     IF l_count = 0 THEN
                        LET g_dbaa_d[l_ac].dbaastus = g_dbaa_d_o.dbaastus
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "adb-00010"
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] =  g_dbaa_d[l_ac].dbaa001 
                        LET g_errparam.replace[2] =  g_dbaa_d[l_ac].dbaa003
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_dbaa_d_o.dbaastus = g_dbaa_d[l_ac].dbaastus
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa001
            #add-point:BEFORE FIELD dbaa001 name="input.b.page1.dbaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa001
            
            #add-point:AFTER FIELD dbaa001 name="input.a.page1.dbaa001"
            #此段落由子樣板a05產生
            IF  g_dbaa_d[g_detail_idx].dbaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbaa_d[g_detail_idx].dbaa001 != g_dbaa_d_t.dbaa001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbaa_t WHERE "||"dbaaent = '" ||g_enterprise|| "' AND "||"dbaa001 = '"||g_dbaa_d[g_detail_idx].dbaa001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaa001
            #add-point:ON CHANGE dbaa001 name="input.g.page1.dbaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaal003
            #add-point:BEFORE FIELD dbaal003 name="input.b.page1.dbaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaal003
            
            #add-point:AFTER FIELD dbaal003 name="input.a.page1.dbaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaal003
            #add-point:ON CHANGE dbaal003 name="input.g.page1.dbaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa002
            #add-point:BEFORE FIELD dbaa002 name="input.b.page1.dbaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa002
            
            #add-point:AFTER FIELD dbaa002 name="input.a.page1.dbaa002"
            IF g_dbaa_d[l_ac].dbaa002 <= g_dbaa_d[l_ac].dbaa004 THEN
               LET g_dbaa_d[l_ac].dbaa003 = ''
               LET g_dbaa_d[l_ac].dbaa003_desc = ''
               LET g_dbaa_d[l_ac].dbaa004 = ''
            END IF
            IF NOT cl_null(g_dbaa_d[l_ac].dbaa002) THEN
              #150427-00012#2 20150504 by BeckXie---mark 
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbaa_d[l_ac].dbaa002 != g_dbaa_d_o.dbaa002 OR g_dbaa_d_o.dbaa002 IS NULL )) THEN
               IF g_dbaa_d[l_ac].dbaa002 != g_dbaa_d_o.dbaa002 OR cl_null(g_dbaa_d_o.dbaa002)  THEN   #150427-00012#2 20150504 by BeckXie---add
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM dbaa_t
                   WHERE dbaaent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
                     AND dbaa003 = g_dbaa_d[l_ac].dbaa001
                     AND dbaa002 <= g_dbaa_d[l_ac].dbaa002
                     AND dbaastus = 'Y'
                  IF l_n >=1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'adb-00001'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbaa_d[l_ac].dbaa002 = g_dbaa_d_o.dbaa002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_dbaa_d_o.dbaa002 = g_dbaa_d[l_ac].dbaa002
            CALL adbi200_set_entry_b(l_cmd)
            CALL adbi200_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaa002
            #add-point:ON CHANGE dbaa002 name="input.g.page1.dbaa002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa003
            
            #add-point:AFTER FIELD dbaa003 name="input.a.page1.dbaa003"
            LET g_dbaa_d[l_ac].dbaa003_desc = ' '
            LET g_dbaa_d[l_ac].dbaa004 = ''
            DISPLAY BY NAME g_dbaa_d[l_ac].dbaa003_desc,g_dbaa_d[l_ac].dbaa004
            IF NOT cl_null(g_dbaa_d[l_ac].dbaa003) THEN
              #150427-00012#2 20150504 by BeckXie---mark
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbaa_d[l_ac].dbaa003 != g_dbaa_d_o.dbaa003 OR g_dbaa_d_o.dbaa003 IS NULL )) THEN
               IF g_dbaa_d[l_ac].dbaa003 != g_dbaa_d_o.dbaa003 OR cl_null(g_dbaa_d_o.dbaa003) THEN   #150427-00012#2 20150504 by BeckXie---add                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbaa_d[l_ac].dbaa003
                  LET g_chkparam.arg2 = g_dbaa_d[l_ac].dbaa002
                  IF NOT cl_chk_exist("v_dbaa001") THEN
                     LET g_dbaa_d[l_ac].dbaa003 = g_dbaa_d_o.dbaa003
                     LET g_dbaa_d[l_ac].dbaa004 = g_dbaa_d_o.dbaa004   #150427-00012#2 20150504 by BeckXie---add
                     CALL adbi200_dbaa003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adbi200_dbaa003_ref()
            LET g_dbaa_d_o.dbaa003 = g_dbaa_d[l_ac].dbaa003
            LET g_dbaa_d_o.dbaa004 = g_dbaa_d[l_ac].dbaa004   #150427-00012#2 20150504 by BeckXie---add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa003
            #add-point:BEFORE FIELD dbaa003 name="input.b.page1.dbaa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaa003
            #add-point:ON CHANGE dbaa003 name="input.g.page1.dbaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaa004
            #add-point:BEFORE FIELD dbaa004 name="input.b.page1.dbaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaa004
            
            #add-point:AFTER FIELD dbaa004 name="input.a.page1.dbaa004"
#            IF g_dbaa_d[l_ac].dbaa002 <= g_dbaa_d[l_ac].dbaa004 THEN
#               #上層層級類型不可以小於等於層級類型
#               CASE g_dbaa_d[l_ac].dbaa004
#                  WHEN '2'
#                     CALL cl_err(g_dbaa_d[l_ac].dbaa001,'adb-00005',1)
#                  WHEN '3'
#                     CALL cl_err(g_dbaa_d[l_ac].dbaa001,'adb-00006',1)
#                  WHEN '4'
#                     CALL cl_err(g_dbaa_d[l_ac].dbaa001,'adb-00007',1)
#               END CASE
#               LET g_dbaa_d[l_ac].dbaa004 = g_dbaa_d_o.dbaa004
#               NEXT FIELD CURRENT
#            END IF
#            IF NOT cl_null(g_dbaa_d[l_ac].dbaa003) AND NOT cl_null(g_dbaa_d[l_ac].dbaa004) THEN
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbaa_d[l_ac].dbaa004 != g_dbaa_d_o.dbaa004 OR g_dbaa_d_o.dbaa004 IS NULL )) THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_dbaa_d[l_ac].dbaa003
#                  IF NOT cl_chk_exist("v_dbaa001") THEN
#                     LET g_dbaa_d[l_ac].dbaa004 = g_dbaa_d_o.dbaa004
#                     LET g_dbaa_d[l_ac].dbaa003 = ''
#                  END IF
#               END IF
#            END IF
#            LET g_dbaa_d_o.dbaa003 = g_dbaa_d[l_ac].dbaa003
#            LET g_dbaa_d_o.dbaa004 = g_dbaa_d[l_ac].dbaa004
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaa004
            #add-point:ON CHANGE dbaa004 name="input.g.page1.dbaa004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaastus
            #add-point:ON ACTION controlp INFIELD dbaastus name="input.c.page1.dbaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa001
            #add-point:ON ACTION controlp INFIELD dbaa001 name="input.c.page1.dbaa001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaal003
            #add-point:ON ACTION controlp INFIELD dbaal003 name="input.c.page1.dbaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa002
            #add-point:ON ACTION controlp INFIELD dbaa002 name="input.c.page1.dbaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa003
            #add-point:ON ACTION controlp INFIELD dbaa003 name="input.c.page1.dbaa003"
            #此段落由子樣板a07產生            
            #開窗i段
            LET g_dbaa_d[l_ac].dbaa003_desc = ''
            LET g_dbaa_d[l_ac].dbaa004 = ''
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbaa_d[l_ac].dbaa003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_dbaa_d[l_ac].dbaa002
            CALL q_dbaa001()                                #呼叫開窗

            LET g_dbaa_d[l_ac].dbaa003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_dbaa_d[l_ac].dbaa003 TO dbaa003              #顯示到畫面上
            CALL adbi200_dbaa003_ref()
            NEXT FIELD dbaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaa004
            #add-point:ON ACTION controlp INFIELD dbaa004 name="input.c.page1.dbaa004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE adbi200_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_dbaa_d[l_ac].* = g_dbaa_d_t.*
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
               LET g_errparam.extend = g_dbaa_d[l_ac].dbaa001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_dbaa_d[l_ac].* = g_dbaa_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_dbaa2_d[l_ac].dbaamodid = g_user 
LET g_dbaa2_d[l_ac].dbaamoddt = cl_get_current()
LET g_dbaa2_d[l_ac].dbaamodid_desc = cl_get_username(g_dbaa2_d[l_ac].dbaamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL adbi200_dbaa_t_mask_restore('restore_mask_o')
 
               UPDATE dbaa_t SET (dbaastus,dbaa001,dbaa002,dbaa003,dbaa004,dbaaownid,dbaaowndp,dbaacrtid, 
                   dbaacrtdp,dbaacrtdt,dbaamodid,dbaamoddt) = (g_dbaa_d[l_ac].dbaastus,g_dbaa_d[l_ac].dbaa001, 
                   g_dbaa_d[l_ac].dbaa002,g_dbaa_d[l_ac].dbaa003,g_dbaa_d[l_ac].dbaa004,g_dbaa2_d[l_ac].dbaaownid, 
                   g_dbaa2_d[l_ac].dbaaowndp,g_dbaa2_d[l_ac].dbaacrtid,g_dbaa2_d[l_ac].dbaacrtdp,g_dbaa2_d[l_ac].dbaacrtdt, 
                   g_dbaa2_d[l_ac].dbaamodid,g_dbaa2_d[l_ac].dbaamoddt)
                WHERE dbaaent = g_enterprise AND
                  dbaa001 = g_dbaa_d_t.dbaa001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               #有效否先比對現在的值與資料庫的值是否相同，並且有異動
               IF g_dbaa_d[l_ac].dbaastus != g_dbaa_d_t.dbaastus AND g_update = TRUE THEN
                  #利用樹去找出他的下層
                  FOR l_i = 1 TO g_tree.getLength()
                     LET l_pid = g_tree[l_i].b_pid
                     IF l_id = l_pid.subString(1,l_len) THEN
                        UPDATE dbaa_t
                           SET (dbaastus,dbaamodid,dbaamoddt) = 
                               ('N',g_dbaa2_d[l_ac].dbaamodid,g_dbaa2_d[l_ac].dbaamoddt)
                         WHERE dbaaent = g_enterprise AND
                               dbaa001 = g_tree[l_i].b_dbaa001
                     END IF
                  END FOR
               END IF
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbaa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaa_d[g_detail_idx].dbaa001
               LET gs_keys_bak[1] = g_dbaa_d_t.dbaa001
               CALL adbi200_update_b('dbaa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbaa_d[l_ac].dbaa001 = g_detail_multi_table_t.dbaal001 AND
         g_dbaa_d[l_ac].dbaal003 = g_detail_multi_table_t.dbaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbaa_d[l_ac].dbaa001
            LET l_field_keys[02] = 'dbaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbaal002
            LET l_vars[01] = g_dbaa_d[l_ac].dbaal003
            LET l_fields[01] = 'dbaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbaal_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_dbaa_d_t)
                     LET g_log2 = util.JSON.stringify(g_dbaa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL adbi200_dbaa_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               INSERT INTO adbi200_status(dbaa001,expanded) VALUES(g_dbaa_d[l_ac].dbaa001,'0')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               CALL adbi200_browser_fill(g_wc,g_searchtype)
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adbi200_unlock_b("dbaa_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbaa_d[l_ac].* = g_dbaa_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            CALL cl_multitable_unlock()
             #add-point:單身after row name="input.body.a_row"
            CALL adbi200_b_fill(g_wc2)
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
               LET g_dbaa_d[li_reproduce_target].* = g_dbaa_d[li_reproduce].*
               LET g_dbaa2_d[li_reproduce_target].* = g_dbaa2_d[li_reproduce].*
 
               LET g_dbaa_d[li_reproduce_target].dbaa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbaa_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_dbaa2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL adbi200_b_fill(g_wc2)
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
      DISPLAY ARRAY g_tree TO s_tree.*
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_tree",1) #設定為單選
 
         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_tree")
            IF g_current_row > 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_tree",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            CALL cl_show_fld_cont() 
            CALL DIALOG.setCurrentRow("s_tree",g_current_row)
 
         ON EXPAND (g_row_index)
            #樹展開
            LET g_tree[g_row_index].b_isExp = 1
            UPDATE adbi200_status SET expanded = '1'
             WHERE dbaa001 = g_tree[g_row_index].b_dbaa001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
 
         ON COLLAPSE (g_row_index)
            #樹關閉
            LET g_tree[g_row_index].b_isExp = 0
            UPDATE adbi200_status SET expanded = '0'
             WHERE dbaa001 = g_tree[g_row_index].b_dbaa001
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
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
         NEXT FIELD dbaastus
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD dbaastus
            WHEN "s_detail2"
               NEXT FIELD dbaa001_2
 
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
      IF INT_FLAG OR cl_null(g_dbaa_d[g_detail_idx].dbaa001) THEN
         CALL g_dbaa_d.deleteElement(g_detail_idx)
         CALL g_dbaa2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_dbaa_d[g_detail_idx].* = g_dbaa_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE adbi200_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi200_delete()
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
   DEFINE l_n   LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_dbaa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT adbi200_lock_b("dbaa_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("dbaa_t","dbaaownid") THEN
            LET g_data_owner = g_dbaa2_d[g_detail_idx].dbaaownid
            LET g_data_dept = g_dbaa2_d[g_detail_idx].dbaaowndp
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
   
   FOR li_idx = 1 TO g_dbaa_d.getLength()
      IF g_dbaa_d[li_idx].dbaa001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         #161027-00037#1 add-str-
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM dbaa_t
          WHERE dbaaent = g_enterprise      #160905-00003#1 add by rainy 加上ent條件
            AND dbaa003 = g_dbaa_d[li_idx].dbaa001
         IF l_n >= 1 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'adb-00004'
           LET g_errparam.extend = g_dbaa_d[li_idx].dbaa001
           LET g_errparam.popup = TRUE
           CALL cl_err()
           continue for
         END IF
         #161027-00037#add -end-
         #end add-point   
         
         DELETE FROM dbaa_t
          WHERE dbaaent = g_enterprise AND 
                dbaa001 = g_dbaa_d[li_idx].dbaa001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbaa_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.dbaal001 = g_dbaa_d[l_ac].dbaa001
LET g_detail_multi_table_t.dbaal002 = g_dlang
LET g_detail_multi_table_t.dbaal003 = g_dbaa_d[l_ac].dbaal003
 
 
            
LET g_detail_multi_table_t.dbaal001 = g_dbaa_d[l_ac].dbaa001
LET g_detail_multi_table_t.dbaal002 = g_dlang
LET g_detail_multi_table_t.dbaal003 = g_dbaa_d[l_ac].dbaal003
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbaal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbaal_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbaal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbaal_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaa_d_t.dbaa001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL adbi200_delete_b('dbaa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi200_set_pk_array()
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
   CALL adbi200_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="adbi200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi200_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.dbaastus,t0.dbaa001,t0.dbaa002,t0.dbaa003,t0.dbaa004,t0.dbaa001, 
       t0.dbaaownid,t0.dbaaowndp,t0.dbaacrtid,t0.dbaacrtdp,t0.dbaacrtdt,t0.dbaamodid,t0.dbaamoddt ,t1.dbaal003 FROM dbaa_t t0", 
 
               " LEFT JOIN dbaal_t ON dbaalent = "||g_enterprise||" AND dbaa001 = dbaal001 AND dbaal002 = '",g_dlang,"'",
                              " LEFT JOIN dbaal_t t1 ON t1.dbaalent="||g_enterprise||" AND t1.dbaal001=t0.dbaa003 AND t1.dbaal002='"||g_dlang||"' ",
 
               " WHERE t0.dbaaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("dbaa_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND dbaaowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("dbaa_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND dbaaownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("dbaa_t"),
                      " ORDER BY t0.dbaa001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbaa_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adbi200_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi200_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dbaa_d.clear()
   CALL g_dbaa2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dbaa_d[l_ac].dbaastus,g_dbaa_d[l_ac].dbaa001,g_dbaa_d[l_ac].dbaa002,g_dbaa_d[l_ac].dbaa003, 
       g_dbaa_d[l_ac].dbaa004,g_dbaa2_d[l_ac].dbaa001,g_dbaa2_d[l_ac].dbaaownid,g_dbaa2_d[l_ac].dbaaowndp, 
       g_dbaa2_d[l_ac].dbaacrtid,g_dbaa2_d[l_ac].dbaacrtdp,g_dbaa2_d[l_ac].dbaacrtdt,g_dbaa2_d[l_ac].dbaamodid, 
       g_dbaa2_d[l_ac].dbaamoddt,g_dbaa_d[l_ac].dbaa003_desc
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
      
      CALL adbi200_detail_show()      
 
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
   
 
   
   CALL g_dbaa_d.deleteElement(g_dbaa_d.getLength())   
   CALL g_dbaa2_d.deleteElement(g_dbaa2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dbaa_d.getLength()
      LET g_dbaa2_d[l_ac].dbaa001 = g_dbaa_d[l_ac].dbaa001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_dbaa_d.getLength() THEN
      LET l_ac = g_dbaa_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbaa_d.getLength()
      LET g_dbaa_d_mask_o[l_ac].* =  g_dbaa_d[l_ac].*
      CALL adbi200_dbaa_t_mask()
      LET g_dbaa_d_mask_n[l_ac].* =  g_dbaa_d[l_ac].*
   END FOR
   
   LET g_dbaa2_d_mask_o.* =  g_dbaa2_d.*
   FOR l_ac = 1 TO g_dbaa2_d.getLength()
      LET g_dbaa2_d_mask_o[l_ac].* =  g_dbaa2_d[l_ac].*
      CALL adbi200_dbaa_t_mask()
      LET g_dbaa2_d_mask_n[l_ac].* =  g_dbaa2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_dbaa_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE adbi200_pb
   
END FUNCTION
 
{</section>}
 
{<section id="adbi200.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi200_detail_show()
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
   CALL adbi200_dbaa001_ref()
   CALL adbi200_dbaa003_ref()

   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi200_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("dbaa003",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="adbi200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi200_set_no_entry_b(p_cmd)                                               
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
   IF g_dbaa_d[l_ac].dbaa002 = '1' THEN
      CALL cl_set_comp_entry("dbaa003",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="adbi200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi200_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   IF g_searchtype = 0 OR cl_null(g_searchtype) THEN
      LET g_searchtype = 3
   END IF 
   LET g_wc = " 1=1"
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " dbaa001 = '", g_argv[01], "' AND "
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
 
{<section id="adbi200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi200_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "dbaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'dbaa_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM dbaa_t
          WHERE dbaaent = g_enterprise AND
            dbaa001 = ps_keys_bak[1]
         
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
         CALL g_dbaa_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_dbaa2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      DELETE FROM adbi200_status WHERE dbaa001 = ps_keys_bak[1]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
      CALL adbi200_browser_fill(g_wc,g_searchtype)
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi200_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "dbaa_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO dbaa_t
                  (dbaaent,
                   dbaa001
                   ,dbaastus,dbaa002,dbaa003,dbaa004,dbaaownid,dbaaowndp,dbaacrtid,dbaacrtdp,dbaacrtdt,dbaamodid,dbaamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_dbaa_d[l_ac].dbaastus,g_dbaa_d[l_ac].dbaa002,g_dbaa_d[l_ac].dbaa003,g_dbaa_d[l_ac].dbaa004, 
                       g_dbaa2_d[l_ac].dbaaownid,g_dbaa2_d[l_ac].dbaaowndp,g_dbaa2_d[l_ac].dbaacrtid, 
                       g_dbaa2_d[l_ac].dbaacrtdp,g_dbaa2_d[l_ac].dbaacrtdt,g_dbaa2_d[l_ac].dbaamodid, 
                       g_dbaa2_d[l_ac].dbaamoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbaa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "dbaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbaa_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE dbaa_t 
         SET (dbaa001
              ,dbaastus,dbaa002,dbaa003,dbaa004,dbaaownid,dbaaowndp,dbaacrtid,dbaacrtdp,dbaacrtdt,dbaamodid,dbaamoddt) 
              = 
             (ps_keys[1]
              ,g_dbaa_d[l_ac].dbaastus,g_dbaa_d[l_ac].dbaa002,g_dbaa_d[l_ac].dbaa003,g_dbaa_d[l_ac].dbaa004, 
                  g_dbaa2_d[l_ac].dbaaownid,g_dbaa2_d[l_ac].dbaaowndp,g_dbaa2_d[l_ac].dbaacrtid,g_dbaa2_d[l_ac].dbaacrtdp, 
                  g_dbaa2_d[l_ac].dbaacrtdt,g_dbaa2_d[l_ac].dbaamodid,g_dbaa2_d[l_ac].dbaamoddt) 
         WHERE dbaaent = g_enterprise AND dbaa001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbaa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbaa_t:",SQLERRMESSAGE 
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
 
{<section id="adbi200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi200_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL adbi200_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dbaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi200_bcl USING g_enterprise,
                                       g_dbaa_d[g_detail_idx].dbaa001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi200_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi200_unlock_b(ps_table)
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
      CLOSE adbi200_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi200.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION adbi200_modify_detail_chk(ps_record)
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
         LET ls_return = "dbaastus"
      WHEN "s_detail2"
         LET ls_return = "dbaa001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adbi200.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION adbi200_show_ownid_msg()
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
 
{<section id="adbi200.mask_functions" >}
&include "erp/adb/adbi200_mask.4gl"
 
{</section>}
 
{<section id="adbi200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbi200_set_pk_array()
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
   LET g_pk_array[1].values = g_dbaa_d[l_ac].dbaa001
   LET g_pk_array[1].column = 'dbaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbi200.state_change" >}
   
 
{</section>}
 
{<section id="adbi200.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adbi200.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 找出樹的根節點
# Memo...........:
# Usage..........: CALL adbi200_browser_fill(p_wc,p_type)
# Input parameter: p_wc   條件 
#                : p_type 搜尋建構樹所需的節點
# Return code....: 無
# Date & Author..: 2014/02/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_browser_fill(p_wc,p_type)
DEFINE p_wc       STRING 
DEFINE p_type     LIKE type_t.chr10
DEFINE l_cnt      LIKE type_t.num10
DEFINE l_cnt2     LIKE type_t.num10
DEFINE i          LIKE type_t.num10
DEFINE l_expanded LIKE type_t.chr1

   CALL g_tree.clear()
   CLEAR FORM
   LET l_cnt = 0
   LET l_cnt2 = 0
   
   DELETE FROM adbi200_tmp
 
   #先確定搜尋範圍(若無條件搜尋則只找root出來)
   #SELECT COUNT(*) INTO l_cnt FROM dbaa_t                               #170120-00038#1 20170123 mark by beckxie
   SELECT COUNT(*) INTO l_cnt FROM dbaa_t WHERE dbaaent = g_enterprise   #170120-00038#1 20170123  add by beckxie
   
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT COUNT(*)",
               " FROM dbaa_t  ",
               " WHERE dbaaent = '" ||g_enterprise|| "' AND ",p_wc
              
   PREPARE master_cnt FROM g_sql
   DECLARE master_cntcur CURSOR FOR master_cnt
   OPEN master_cntcur
   FETCH master_cntcur INTO l_cnt2
   LET g_root_search = FALSE
   
   IF l_cnt2 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   IF l_cnt = l_cnt2 THEN
      #未輸入條件時則只查找root節點
      LET p_wc = " dbaa003 IS NULL AND dbaa004 IS NULL"
      LET g_root_search = TRUE
   END IF

   #取得符合p_wc的所有資料  上級地域編號(dbaa003)為NULL
   LET g_sql = "SELECT dbaa001,dbaa003,dbaa004,dbaastus",
               " FROM dbaa_t",
               " WHERE dbaaent = '" ||g_enterprise|| "' AND ",p_wc
              
   PREPARE master_ext FROM g_sql
   DECLARE master_extcur CURSOR FOR master_ext

   #搜尋建構樹所需的節點
   CASE p_type
      WHEN "1" #上推
         CALL adbi200_match_node(p_wc,p_type) 
      WHEN "2" #下展
         CALL adbi200_match_node(p_wc,p_type) 
      WHEN "3" #全部
         CALL adbi200_match_node(p_wc,p_type) 
   END CASE
 
   CALL adbi200_tree_create()
   
   #查詢temp裡面的展開否紀錄
   LET g_sql = " SELECT expanded FROM adbi200_status WHERE dbaa001 = ?"
   PREPARE tree_stus FROM g_sql
   DECLARE tree_stuscur CURSOR FOR tree_stus
   
   FOR i = 1 TO g_tree.getLength()
      CALL adbi200_browser_expand(i)
      #抓取記錄在temp table裡的展開否的值
      LET l_expanded = ''
      EXECUTE tree_stuscur USING g_tree[i].b_dbaa001 INTO l_expanded
      IF cl_null(l_expanded) THEN
         LET l_expanded = '0'
      END IF
      LET g_tree[i].b_exp = l_expanded
      #程式一執行就讓樹是全部展開的狀態
      IF g_first = 0 THEN
         LET g_tree[i].b_exp = '1'          #是否展開 1展開 2不展開
         LET g_tree[i].b_isExp = 1
      END IF
      LET g_tree[i].b_isExp = g_tree[i].b_exp
   END FOR
END FUNCTION
################################################################################
# Descriptions...: 上層地域編號(dbaa003)帶出地域名稱
# Memo...........:
# Usage..........: CALL adbi200_dbaa003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/18 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_dbaa003_ref()
DEFINE l_dbaa002        LIKE dbaa_t.dbaa002

   #帶出上層層級類型
   LET l_dbaa002 = ''
   SELECT dbaa002 INTO l_dbaa002
     FROM dbaa_t
    WHERE dbaaent = g_enterprise
      AND dbaa001 = g_dbaa_d[l_ac].dbaa003
   LET g_dbaa_d[l_ac].dbaa004 = l_dbaa002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dbaa_d[l_ac].dbaa003
   CALL ap_ref_array2(g_ref_fields,"SELECT dbaal003 FROM dbaal_t WHERE dbaalent='"||g_enterprise||"' AND dbaal001=? AND dbaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_dbaa_d[l_ac].dbaa003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_dbaa_d[l_ac].dbaa003_desc,g_dbaa_d[l_ac].dbaa004
   
END FUNCTION
################################################################################
# Descriptions...: 抓取下一層的資料
# Memo...........:
# Usage..........: CALL adbi200_tree_create()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_tree_create()
DEFINE l_pid        LIKE type_t.chr50

   LET l_ac = 1
   
   #抓出LV2的所有資料
   LET g_sql = " SELECT UNIQUE dbaa001,dbaa003,dbaa004,dbaastus FROM adbi200_tmp a ", 
               " WHERE ",
               " (( SELECT COUNT(*) FROM adbi200_tmp b WHERE a.dbaa003 = b.dbaa001) = 0 ", 
               " OR (a.dbaa003 IS NULL AND a.dbaa004 IS NULL) )", 
               " ORDER BY a.dbaa001"
   PREPARE master_getLV2 FROM g_sql
   DECLARE master_getLV2cur CURSOR FOR master_getLV2
   
   LET g_cnt = l_ac
   
   FOREACH master_getLV2cur INTO g_tree[g_cnt].b_dbaa001,g_tree[g_cnt].b_dbaa003,
                                 g_tree[g_cnt].b_dbaa004,g_tree[g_cnt].b_dbaastus
      LET g_tree[g_cnt].b_pid = l_pid
      LET g_tree[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
      LET g_tree[g_cnt].b_expcode = 2
      
      IF cl_null("dbaa003") THEN
         LET g_tree[g_cnt].b_hasC = FALSE
      ELSE
         LET g_tree[g_cnt].b_hasC = TRUE
      END IF
 
      LET g_cnt = g_cnt + 1
   END FOREACH
   LET l_ac = g_tree.getLength()

   #組合描述欄位&刪除多於資料
   FOR l_ac = 1 TO g_tree.getLength()
      IF cl_null(g_tree[l_ac].b_dbaa001) THEN
         CALL g_tree.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL adbi200_desc_show(l_ac)
      END IF
   END FOR
   CALL g_tree.deleteElement(l_ac)
 
   LET g_browser_cnt = g_tree.getLength() - g_browser_root.getLength()
 
   FREE master_getLV2
   
END FUNCTION
################################################################################
# Descriptions...: 比對記錄在temp table的資料，並更新
# Memo...........:
# Usage..........: CALL adbi200_tmp_tbl_chk(ps_id,pi_code)
# Input parameter: ps_id,pi_code
# Return code....: True/False
# Date & Author..: 2014/02/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_tmp_tbl_chk(ps_id,pi_code)
DEFINE ps_id       STRING
DEFINE pi_code     LIKE type_t.num10
DEFINE ps_type     STRING
DEFINE ls_id       LIKE type_t.chr500
DEFINE ls_search   LIKE type_t.chr500
DEFINE ls_type     LIKE type_t.chr500
DEFINE li_cnt      LIKE type_t.num10
DEFINE li_code     LIKE type_t.num10  
   
   LET ls_id = ps_id
  
   IF cl_null(ls_id) THEN
      RETURN TRUE
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM adbi200_tmp ", 
               " WHERE dbaa001 = ? "
 
   PREPARE adbi200_get_cnt FROM g_sql
   EXECUTE adbi200_get_cnt USING ls_id INTO li_cnt
   FREE adbi200_get_cnt
 
   IF li_cnt = 0 OR SQLCA.sqlcode THEN
      RETURN TRUE
   ELSE
      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM adbi200_tmp ",
                  " WHERE dbaa001 = ? "
 
      PREPARE adbi200_chk_exp FROM g_sql
      EXECUTE adbi200_chk_exp USING ls_id INTO li_code
      FREE adbi200_chk_exp
      
      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE adbi200_tmp SET (exp_code) = ('",pi_code,"') ",
                      " WHERE dbaa001 = ? "
         PREPARE adbi200_upd_exp FROM g_sql
         EXECUTE adbi200_upd_exp USING ls_id 
         FREE adbi200_upd_exp
      END IF
      
      RETURN FALSE
   END IF
END FUNCTION
################################################################################
# Descriptions...: 地域編號(dbaa001)帶出地域名稱
# Memo...........:
# Usage..........: CALL adbi200_dbaa001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/18 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_dbaa001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dbaa_d[l_ac].dbaa001
   CALL ap_ref_array2(g_ref_fields," SELECT dbaal003 FROM dbaal_t WHERE dbaalent = '"||g_enterprise||"' AND dbaal001 = ? AND dbaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_dbaa_d[l_ac].dbaal003 = g_rtn_fields[1]
   DISPLAY g_dbaa_d[l_ac].dbaal003 TO dbaal003
END FUNCTION
################################################################################
# Descriptions...: 顯示樹的文字
# Memo...........:
# Usage..........: CALL adbi200_desc_show(pi_ac)
# Input parameter: pi_ac  此節點
# Return code....: 無
# Date & Author..: 2014/02/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_desc_show(pi_ac)
DEFINE pi_ac      LIKE type_t.num5
DEFINE li_tmp     LIKE type_t.num5 
DEFINE l_dbaal003 LIKE dbaal_t.dbaal003
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   LET l_dbaal003 = ''
   SELECT dbaal003 INTO l_dbaal003
     FROM dbaal_t
    WHERE dbaalent = g_enterprise
      AND dbaal001 = g_tree[l_ac].b_dbaa001 
      AND dbaal002 = g_dlang
   LET g_tree[l_ac].b_show = g_tree[l_ac].b_dbaa001, '  ',l_dbaal003 CLIPPED
   
   LET l_ac = li_tmp

END FUNCTION
################################################################################
# Descriptions...: 符合條件的資料新增至temp table裡
# Memo...........:
# Usage..........: CALL adbi200_match_node(p_wc,p_type)
# Input parameter: p_wc    條件
#                  p_type  對數的動作(上展.下展.全部)
# Return code....: 無
# Date & Author..: 2014/02/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_match_node(p_wc,p_type)
DEFINE p_wc         LIKE type_t.chr200
DEFINE p_type       LIKE type_t.chr10
DEFINE ls_code      LIKE type_t.chr50
DEFINE ls_code2     LIKE type_t.chr50
DEFINE l_bstmp      RECORD
       dbaa001      LIKE dbaa_t.dbaa001,
       dbaa003      LIKE dbaa_t.dbaa003,
       dbaa004      LIKE dbaa_t.dbaa004,
       dbaastus     LIKE dbaa_t.dbaastus
                    END RECORD 
DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位
       dbaa001      LIKE dbaa_t.dbaa001,
       dbaa003      LIKE dbaa_t.dbaa003,
       dbaa004      LIKE dbaa_t.dbaa004,
       dbaastus     LIKE dbaa_t.dbaastus
                    END RECORD

   #先找出符合條件的節點並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code = "0"
      WHEN 2
         LET ls_code = "2"
      WHEN 3
         LET ls_code = "2"
   END CASE
   
   IF cl_null("dbaa003") THEN
      LET ls_code = "0"
   END IF 
   
   LET g_sql = " INSERT INTO adbi200_tmp (dbaa001,dbaa003,dbaa004,dbaastus,exp_code) VALUES (?,?,?,?,?)"
   PREPARE master_tmp FROM g_sql
   
   IF g_root_search THEN
      FOREACH master_extcur INTO l_bstmp.*
         EXECUTE master_tmp USING l_bstmp.*,ls_code
      END FOREACH
      RETURN
   END IF
 
   FOREACH master_extcur INTO l_bstmp.*
      EXECUTE master_tmp USING l_bstmp.*,ls_code
      LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
       
      #找出符合條件的節點的所有祖先並給予展開值
      CASE p_type
         WHEN 1
            LET ls_code2 = "1"
         WHEN 2
            LET ls_code2 = "-1"
         WHEN 3
            LET ls_code2 = "1"
      END CASE
      
      #若pid欄位存在才進行後續處理
      #擷取該節點的父節點到temp table中
      LET g_sql = " SELECT dbaa001,dbaa003,dbaa004,dbaastus ",
                  " FROM dbaa_t  ",
                  " WHERE dbaaent = '" ||g_enterprise|| "' AND dbaa001 = ? "
      PREPARE master_getparent_up FROM g_sql
      
      #擷取該節點的所有父節點
      WHILE TRUE
         IF cl_null(l_child_list[1].dbaa001) THEN
            IF l_child_list.getLength() = 1 THEN
               EXIT WHILE
            ELSE
               CALL l_child_list.deleteElement(1)
               CONTINUE WHILE
            END IF
         END IF
      
         EXECUTE master_getparent_up USING l_child_list[1].dbaa003 INTO l_bstmp.*
         IF SQLCA.sqlcode THEN
            FREE master_getparent_up
            EXIT WHILE
         END IF
         FREE master_getparent_up
         #確定該節點是否存在於temp table中
         
         IF STATUS = 0 AND adbi200_tmp_tbl_chk(l_bstmp.dbaa001,ls_code2) THEN
            EXECUTE master_tmp USING l_bstmp.*,ls_code2
            LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
         END IF
         CALL l_child_list.deleteElement(1)
      
      END WHILE
   
   END FOREACH
   
   CLOSE master_tmp
   
END FUNCTION
################################################################################
# Descriptions...: 確認是否有子節點
# Memo...........:
# Usage..........: CALL adbi200_chk_hasC(pi_id)
# Input parameter: pi_id    此節點
# Return code....: True/False
# Date & Author..: 2014/02/19 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_chk_hasC(pi_id)
DEFINE pi_id    LIKE type_t.num10
DEFINE li_cnt   LIKE type_t.num10

   LET g_sql = "SELECT COUNT(dbaa003) FROM adbi200_tmp ",
               " WHERE dbaa003 = ? ",
               "   AND exp_code <> '-1'",
               "   AND dbaa001 <> dbaa003 "
 
   PREPARE adbi200_temp_chk FROM g_sql
 
   LET g_sql = "SELECT COUNT(*) FROM dbaa_t ",
               " WHERE dbaaent = '" ||g_enterprise|| "'",
               "   AND dbaa001 <> dbaa003 ",
               "   AND dbaa003 = ? "
   
   PREPARE adbi200_master_chk FROM g_sql
   
   CASE g_tree[pi_id].b_expcode 
      WHEN -1
         RETURN FALSE
      WHEN 0
         RETURN FALSE
      WHEN 1
         EXECUTE adbi200_temp_chk 
           USING g_tree[pi_id].b_dbaa001 INTO li_cnt
         FREE adbi200_temp_chk
      WHEN 2 
         EXECUTE adbi200_master_chk 
           USING g_tree[pi_id].b_dbaa001 INTO li_cnt
         FREE adbi200_master_chk
   END CASE
    
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 此父節點展開
# Memo...........:
# Usage..........: CALL adbi200_browser_expand(p_id)
# Input parameter: p_id   父節點
# Return code....: 無
# Date & Author..: 2014/02/19 By pomleo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi200_browser_expand(p_id)
DEFINE p_id          LIKE type_t.num10
DEFINE l_id          LIKE type_t.num10
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_keyvalue    LIKE type_t.chr50
DEFINE l_typevalue   LIKE type_t.chr50
DEFINE l_type        LIKE type_t.chr50
DEFINE l_sql         LIKE type_t.chr500
DEFINE ls_source     LIKE type_t.chr500
DEFINE ls_exp_code   LIKE type_t.chr500
DEFINE l_return      LIKE type_t.num5

   #若已經展開
   IF g_tree[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_return = FALSE
 
   LET l_keyvalue = g_tree[p_id].b_dbaa001
   
   CASE g_tree[p_id].b_expcode
      WHEN -1
         CALL g_tree.deleteElement(p_id)
      WHEN 0
         RETURN
      WHEN 1
         LET ls_source = "adbi200_tmp"
         LET ls_exp_code = "exp_code"
      WHEN 2
         LET ls_source = "dbaa_t"
         LET ls_exp_code = "'2'"
   END CASE
   
   LET l_sql = " SELECT UNIQUE '','','','FALSE','','',",ls_exp_code,",dbaa001,dbaa003,dbaa004,dbaastus",
               "  FROM ",ls_source,
               " WHERE dbaa003 = '", l_keyvalue,"'",
               "   AND dbaa001 <> dbaa003"
 #160905-00003#1 modify by rainy 加上ent條件 --b              
              # " ORDER BY dbaa001"
   IF g_tree[p_id].b_expcode = 2 THEN
      LET l_sql = l_sql , " AND dbaaent = ",g_enterprise
   END IF
   LET l_sql = l_sql , " ORDER BY dbaa001"
 #160905-00003#1 -e
   
   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand
  
   LET l_id = p_id + 1
   CALL g_tree.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_tree[l_id].*
      #pid=父節點id
      LET g_tree[l_id].b_pid = g_tree[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_tree[l_id].b_id = g_tree[p_id].b_id||"."||l_cnt
      #hasC=確認該節點是否有子孫
      #LET g_tree[l_id].b_dbaa001 = g_tree[l_id].b_dbaa001 CLIPPED
      CALL adbi200_desc_show(l_id)
      LET g_tree[l_id].b_hasC = adbi200_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_tree.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      
      LET l_return = TRUE
   END FOREACH
   
   #刪除空資料
   CALL g_tree.deleteElement(l_id)
END FUNCTION

 
{</section>}
 
