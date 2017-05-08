#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-02-18 14:19:15), PR版次:0008(2016-09-19 17:00:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000266
#+ Filename...: azzi110
#+ Description: 基本資料字典檔
#+ Creator....: 01856(2013-09-16 10:17:14)
#+ Modifier...: 00824 -SD/PR- 00824
 
{</section>}
 
{<section id="azzi110.global" >}
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
PRIVATE TYPE type_g_gzoz_d RECORD
       gzozstus LIKE gzoz_t.gzozstus, 
   gzoz000 LIKE gzoz_t.gzoz000, 
   gzoz501 LIKE gzoz_t.gzoz501, 
   gzoz101 LIKE gzoz_t.gzoz101, 
   gzoz001 LIKE gzoz_t.gzoz001, 
   gzoz102 LIKE gzoz_t.gzoz102, 
   gzoz002 LIKE gzoz_t.gzoz002, 
   gzoz103 LIKE gzoz_t.gzoz103, 
   gzoz003 LIKE gzoz_t.gzoz003, 
   gzoz104 LIKE gzoz_t.gzoz104, 
   gzoz004 LIKE gzoz_t.gzoz004, 
   gzoz105 LIKE gzoz_t.gzoz105, 
   gzoz005 LIKE gzoz_t.gzoz005, 
   gzoz106 LIKE gzoz_t.gzoz106, 
   gzoz006 LIKE gzoz_t.gzoz006, 
   gzoz503 LIKE gzoz_t.gzoz503, 
   image LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_gzoz2_d RECORD
       gzoz000 LIKE gzoz_t.gzoz000, 
   gzozownid LIKE gzoz_t.gzozownid, 
   gzozownid_desc LIKE type_t.chr500, 
   gzozowndp LIKE gzoz_t.gzozowndp, 
   gzozowndp_desc LIKE type_t.chr500, 
   gzozcrtid LIKE gzoz_t.gzozcrtid, 
   gzozcrtid_desc LIKE type_t.chr500, 
   gzozcrtdp LIKE gzoz_t.gzozcrtdp, 
   gzozcrtdp_desc LIKE type_t.chr500, 
   gzozcrtdt DATETIME YEAR TO SECOND, 
   gzozmodid LIKE gzoz_t.gzozmodid, 
   gzozmodid_desc LIKE type_t.chr500, 
   gzozmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
GLOBALS
   DEFINE g_docno              LIKE type_t.chr20
   DEFINE g_seq                LIKE type_t.num5
   CONSTANT lc_max_rows = 10000     #紀錄每張過單單號+項次最多可以過幾筆資料
END GLOBALS
DEFINE ma_gzzy DYNAMIC ARRAY OF RECORD
       gzzy001 LIKE gzzy_t.gzzy001,
       gzozcol LIKE type_t.chr10
               END RECORD
DEFINE mi_enable_cursor LIKE type_t.num5
DEFINE g_gzoz_d_changed DYNAMIC ARRAY OF RECORD
               gzoz501           LIKE gzoz_t.gzoz501,
               gzoz000           LIKE gzoz_t.gzoz000,
               gzoz000_changed   LIKE gzoz_t.gzoz000,
               exp_lang_data     LIKE gzoz_t.gzoz000
                        END RECORD
DEFINE g_exp_lang       LIKE type_t.chr10
#end add-point
 
#模組變數(Module Variables)
DEFINE g_gzoz_d          DYNAMIC ARRAY OF type_g_gzoz_d #單身變數
DEFINE g_gzoz_d_t        type_g_gzoz_d                  #單身備份
DEFINE g_gzoz_d_o        type_g_gzoz_d                  #單身備份
DEFINE g_gzoz_d_mask_o   DYNAMIC ARRAY OF type_g_gzoz_d #單身變數
DEFINE g_gzoz_d_mask_n   DYNAMIC ARRAY OF type_g_gzoz_d #單身變數
DEFINE g_gzoz2_d   DYNAMIC ARRAY OF type_g_gzoz2_d
DEFINE g_gzoz2_d_t type_g_gzoz2_d
DEFINE g_gzoz2_d_o type_g_gzoz2_d
DEFINE g_gzoz2_d_mask_o DYNAMIC ARRAY OF type_g_gzoz2_d
DEFINE g_gzoz2_d_mask_n DYNAMIC ARRAY OF type_g_gzoz2_d
 
      
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
 
{<section id="azzi110.main" >}
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
   LET g_forupd_sql = "SELECT gzozstus,gzoz000,gzoz501,gzoz101,gzoz001,gzoz102,gzoz002,gzoz103,gzoz003, 
       gzoz104,gzoz004,gzoz105,gzoz005,gzoz106,gzoz006,gzoz503,gzoz000,gzozownid,gzozowndp,gzozcrtid, 
       gzozcrtdp,gzozcrtdt,gzozmodid,gzozmoddt FROM gzoz_t WHERE gzoz000=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi110_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi110 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi110_init()   
 
      #進入選單 Menu (="N")
      CALL azzi110_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi110
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi110.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzi110_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('gzoz101','55') 
   CALL cl_set_combo_scc('gzoz102','55') 
   CALL cl_set_combo_scc('gzoz103','55') 
   CALL cl_set_combo_scc('gzoz104','55') 
   CALL cl_set_combo_scc('gzoz105','55') 
   CALL cl_set_combo_scc('gzoz106','55') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL azzi110_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi110.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzi110_ui_dialog()
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
         CALL g_gzoz_d.clear()
         CALL g_gzoz2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL azzi110_init()
      END IF
   
      CALL azzi110_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzoz_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_gzoz2_d[g_detail_idx].gzozownid   #(ver:35)
               LET g_data_dept = g_gzoz2_d[g_detail_idx].gzozowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL azzi110_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_gzoz2_d TO s_detail2.*
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
   CALL azzi110_set_pk_array()
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
         ON ACTION chk_where_use
            LET g_action_choice="chk_where_use"
            IF cl_auth_chk_act("chk_where_use") THEN
               
               #add-point:ON ACTION chk_where_use name="menu.chk_where_use"
               CALL azzi110_chk_where_use()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL azzi110_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL azzi110_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL azzi110_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL azzi110_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL azzi110_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL azzi110_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi110_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION imp_gzoz
            LET g_action_choice="imp_gzoz"
            IF cl_auth_chk_act("imp_gzoz") THEN
               
               #add-point:ON ACTION imp_gzoz name="menu.imp_gzoz"
               CALL azzi110_01("imp")
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
               CALL azzi110_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION chk_table_twcn
            LET g_action_choice="chk_table_twcn"
            IF cl_auth_chk_act("chk_table_twcn") THEN
               
               #add-point:ON ACTION chk_table_twcn name="menu.chk_table_twcn"
               CALL azzi110_01("chk")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exp_trans_data
            LET g_action_choice="exp_trans_data"
            IF cl_auth_chk_act("exp_trans_data") THEN
               
               #add-point:ON ACTION exp_trans_data name="menu.exp_trans_data"
               CALL azzi110_export_to_trans()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exp_to_langtable
            LET g_action_choice="exp_to_langtable"
            IF cl_auth_chk_act("exp_to_langtable") THEN
               
               #add-point:ON ACTION exp_to_langtable name="menu.exp_to_langtable"
               CALL azzi110_01("exp")
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzoz_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_gzoz2_d)
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
            CALL azzi110_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi110_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi110_set_pk_array()
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
 
{<section id="azzi110.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi110_query()
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
   CALL g_gzoz_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON gzozstus,gzoz000,gzoz501,gzoz101,gzoz001,gzoz102,gzoz002,gzoz103,gzoz003,gzoz104, 
          gzoz004,gzoz105,gzoz005,gzoz106,gzoz006,gzoz503,image,gzozownid,gzozowndp,gzozcrtid,gzozcrtdp, 
          gzozcrtdt,gzozmodid,gzozmoddt 
 
         FROM s_detail1[1].gzozstus,s_detail1[1].gzoz000,s_detail1[1].gzoz501,s_detail1[1].gzoz101,s_detail1[1].gzoz001, 
             s_detail1[1].gzoz102,s_detail1[1].gzoz002,s_detail1[1].gzoz103,s_detail1[1].gzoz003,s_detail1[1].gzoz104, 
             s_detail1[1].gzoz004,s_detail1[1].gzoz105,s_detail1[1].gzoz005,s_detail1[1].gzoz106,s_detail1[1].gzoz006, 
             s_detail1[1].gzoz503,s_detail1[1].image,s_detail2[1].gzozownid,s_detail2[1].gzozowndp,s_detail2[1].gzozcrtid, 
             s_detail2[1].gzozcrtdp,s_detail2[1].gzozcrtdt,s_detail2[1].gzozmodid,s_detail2[1].gzozmoddt  
 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzozcrtdt>>----
         AFTER FIELD gzozcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzozmoddt>>----
         AFTER FIELD gzozmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzozcnfdt>>----
         
         #----<<gzozpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozstus
            #add-point:BEFORE FIELD gzozstus name="query.b.page1.gzozstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozstus
            
            #add-point:AFTER FIELD gzozstus name="query.a.page1.gzozstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzozstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozstus
            #add-point:ON ACTION controlp INFIELD gzozstus name="query.c.page1.gzozstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz000
            #add-point:BEFORE FIELD gzoz000 name="query.b.page1.gzoz000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz000
            
            #add-point:AFTER FIELD gzoz000 name="query.a.page1.gzoz000"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz000
            #add-point:ON ACTION controlp INFIELD gzoz000 name="query.c.page1.gzoz000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz501
            #add-point:BEFORE FIELD gzoz501 name="query.b.page1.gzoz501"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz501
            
            #add-point:AFTER FIELD gzoz501 name="query.a.page1.gzoz501"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz501
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz501
            #add-point:ON ACTION controlp INFIELD gzoz501 name="query.c.page1.gzoz501"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz101
            #add-point:BEFORE FIELD gzoz101 name="query.b.page1.gzoz101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz101
            
            #add-point:AFTER FIELD gzoz101 name="query.a.page1.gzoz101"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz101
            #add-point:ON ACTION controlp INFIELD gzoz101 name="query.c.page1.gzoz101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz001
            #add-point:BEFORE FIELD gzoz001 name="query.b.page1.gzoz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz001
            
            #add-point:AFTER FIELD gzoz001 name="query.a.page1.gzoz001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz001
            #add-point:ON ACTION controlp INFIELD gzoz001 name="query.c.page1.gzoz001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz102
            #add-point:BEFORE FIELD gzoz102 name="query.b.page1.gzoz102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz102
            
            #add-point:AFTER FIELD gzoz102 name="query.a.page1.gzoz102"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz102
            #add-point:ON ACTION controlp INFIELD gzoz102 name="query.c.page1.gzoz102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz002
            #add-point:BEFORE FIELD gzoz002 name="query.b.page1.gzoz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz002
            
            #add-point:AFTER FIELD gzoz002 name="query.a.page1.gzoz002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz002
            #add-point:ON ACTION controlp INFIELD gzoz002 name="query.c.page1.gzoz002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz103
            #add-point:BEFORE FIELD gzoz103 name="query.b.page1.gzoz103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz103
            
            #add-point:AFTER FIELD gzoz103 name="query.a.page1.gzoz103"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz103
            #add-point:ON ACTION controlp INFIELD gzoz103 name="query.c.page1.gzoz103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz003
            #add-point:BEFORE FIELD gzoz003 name="query.b.page1.gzoz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz003
            
            #add-point:AFTER FIELD gzoz003 name="query.a.page1.gzoz003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz003
            #add-point:ON ACTION controlp INFIELD gzoz003 name="query.c.page1.gzoz003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz104
            #add-point:BEFORE FIELD gzoz104 name="query.b.page1.gzoz104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz104
            
            #add-point:AFTER FIELD gzoz104 name="query.a.page1.gzoz104"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz104
            #add-point:ON ACTION controlp INFIELD gzoz104 name="query.c.page1.gzoz104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz004
            #add-point:BEFORE FIELD gzoz004 name="query.b.page1.gzoz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz004
            
            #add-point:AFTER FIELD gzoz004 name="query.a.page1.gzoz004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz004
            #add-point:ON ACTION controlp INFIELD gzoz004 name="query.c.page1.gzoz004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz105
            #add-point:BEFORE FIELD gzoz105 name="query.b.page1.gzoz105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz105
            
            #add-point:AFTER FIELD gzoz105 name="query.a.page1.gzoz105"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz105
            #add-point:ON ACTION controlp INFIELD gzoz105 name="query.c.page1.gzoz105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz005
            #add-point:BEFORE FIELD gzoz005 name="query.b.page1.gzoz005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz005
            
            #add-point:AFTER FIELD gzoz005 name="query.a.page1.gzoz005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz005
            #add-point:ON ACTION controlp INFIELD gzoz005 name="query.c.page1.gzoz005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz106
            #add-point:BEFORE FIELD gzoz106 name="query.b.page1.gzoz106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz106
            
            #add-point:AFTER FIELD gzoz106 name="query.a.page1.gzoz106"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz106
            #add-point:ON ACTION controlp INFIELD gzoz106 name="query.c.page1.gzoz106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz006
            #add-point:BEFORE FIELD gzoz006 name="query.b.page1.gzoz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz006
            
            #add-point:AFTER FIELD gzoz006 name="query.a.page1.gzoz006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz006
            #add-point:ON ACTION controlp INFIELD gzoz006 name="query.c.page1.gzoz006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz503
            #add-point:BEFORE FIELD gzoz503 name="query.b.page1.gzoz503"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz503
            
            #add-point:AFTER FIELD gzoz503 name="query.a.page1.gzoz503"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzoz503
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz503
            #add-point:ON ACTION controlp INFIELD gzoz503 name="query.c.page1.gzoz503"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD image
            #add-point:BEFORE FIELD image name="query.b.page1.image"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD image
            
            #add-point:AFTER FIELD image name="query.a.page1.image"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.image
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD image
            #add-point:ON ACTION controlp INFIELD image name="query.c.page1.image"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.gzozownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozownid
            #add-point:ON ACTION controlp INFIELD gzozownid name="construct.c.page2.gzozownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzozownid  #顯示到畫面上

            NEXT FIELD gzozownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozownid
            #add-point:BEFORE FIELD gzozownid name="query.b.page2.gzozownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozownid
            
            #add-point:AFTER FIELD gzozownid name="query.a.page2.gzozownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzozowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozowndp
            #add-point:ON ACTION controlp INFIELD gzozowndp name="construct.c.page2.gzozowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzozowndp  #顯示到畫面上

            NEXT FIELD gzozowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozowndp
            #add-point:BEFORE FIELD gzozowndp name="query.b.page2.gzozowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozowndp
            
            #add-point:AFTER FIELD gzozowndp name="query.a.page2.gzozowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzozcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozcrtid
            #add-point:ON ACTION controlp INFIELD gzozcrtid name="construct.c.page2.gzozcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzozcrtid  #顯示到畫面上

            NEXT FIELD gzozcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozcrtid
            #add-point:BEFORE FIELD gzozcrtid name="query.b.page2.gzozcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozcrtid
            
            #add-point:AFTER FIELD gzozcrtid name="query.a.page2.gzozcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzozcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozcrtdp
            #add-point:ON ACTION controlp INFIELD gzozcrtdp name="construct.c.page2.gzozcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzozcrtdp  #顯示到畫面上

            NEXT FIELD gzozcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozcrtdp
            #add-point:BEFORE FIELD gzozcrtdp name="query.b.page2.gzozcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozcrtdp
            
            #add-point:AFTER FIELD gzozcrtdp name="query.a.page2.gzozcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozcrtdt
            #add-point:BEFORE FIELD gzozcrtdt name="query.b.page2.gzozcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzozmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozmodid
            #add-point:ON ACTION controlp INFIELD gzozmodid name="construct.c.page2.gzozmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzozmodid  #顯示到畫面上

            NEXT FIELD gzozmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozmodid
            #add-point:BEFORE FIELD gzozmodid name="query.b.page2.gzozmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozmodid
            
            #add-point:AFTER FIELD gzozmodid name="query.a.page2.gzozmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozmoddt
            #add-point:BEFORE FIELD gzozmoddt name="query.b.page2.gzozmoddt"
            
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
    
   CALL azzi110_b_fill(g_wc2)
   LET g_data_owner = g_gzoz2_d[g_detail_idx].gzozownid   #(ver:35)
   LET g_data_dept = g_gzoz2_d[g_detail_idx].gzozowndp   #(ver:35)
 
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
 
{<section id="azzi110.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi110_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL azzi110_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi110.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi110_modify()
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
   DEFINE l_success        LIKE type_t.num5
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
      INPUT ARRAY g_gzoz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzoz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi110_b_fill(g_wc2)
            LET g_detail_cnt = g_gzoz_d.getLength()
         
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
            DISPLAY g_gzoz_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzoz_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzoz_d[l_ac].gzoz000 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzoz_d_t.* = g_gzoz_d[l_ac].*  #BACKUP
               LET g_gzoz_d_o.* = g_gzoz_d[l_ac].*  #BACKUP
               IF NOT azzi110_lock_b("gzoz_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi110_bcl INTO g_gzoz_d[l_ac].gzozstus,g_gzoz_d[l_ac].gzoz000,g_gzoz_d[l_ac].gzoz501, 
                      g_gzoz_d[l_ac].gzoz101,g_gzoz_d[l_ac].gzoz001,g_gzoz_d[l_ac].gzoz102,g_gzoz_d[l_ac].gzoz002, 
                      g_gzoz_d[l_ac].gzoz103,g_gzoz_d[l_ac].gzoz003,g_gzoz_d[l_ac].gzoz104,g_gzoz_d[l_ac].gzoz004, 
                      g_gzoz_d[l_ac].gzoz105,g_gzoz_d[l_ac].gzoz005,g_gzoz_d[l_ac].gzoz106,g_gzoz_d[l_ac].gzoz006, 
                      g_gzoz_d[l_ac].gzoz503,g_gzoz2_d[l_ac].gzoz000,g_gzoz2_d[l_ac].gzozownid,g_gzoz2_d[l_ac].gzozowndp, 
                      g_gzoz2_d[l_ac].gzozcrtid,g_gzoz2_d[l_ac].gzozcrtdp,g_gzoz2_d[l_ac].gzozcrtdt, 
                      g_gzoz2_d[l_ac].gzozmodid,g_gzoz2_d[l_ac].gzozmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzoz_d_t.gzoz000,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzoz_d_mask_o[l_ac].* =  g_gzoz_d[l_ac].*
                  CALL azzi110_gzoz_t_mask()
                  LET g_gzoz_d_mask_n[l_ac].* =  g_gzoz_d[l_ac].*
                  
                  CALL azzi110_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi110_set_entry_b(l_cmd)
            CALL azzi110_set_no_entry_b(l_cmd)
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
            INITIALIZE g_gzoz_d_t.* TO NULL
            INITIALIZE g_gzoz_d_o.* TO NULL
            INITIALIZE g_gzoz_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzoz2_d[l_ac].gzozownid = g_user
      LET g_gzoz2_d[l_ac].gzozowndp = g_dept
      LET g_gzoz2_d[l_ac].gzozcrtid = g_user
      LET g_gzoz2_d[l_ac].gzozcrtdp = g_dept 
      LET g_gzoz2_d[l_ac].gzozcrtdt = cl_get_current()
      LET g_gzoz2_d[l_ac].gzozmodid = g_user
      LET g_gzoz2_d[l_ac].gzozmoddt = cl_get_current()
      LET g_gzoz_d[l_ac].gzozstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_gzoz_d[l_ac].gzozstus = "Y"
      LET g_gzoz_d[l_ac].gzoz503 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_gzoz_d[l_ac].gzoz101 = "N"
            LET g_gzoz_d[l_ac].gzoz102 = "N"
            LET g_gzoz_d[l_ac].gzoz103 = "N"
            LET g_gzoz_d[l_ac].gzoz104 = "N"
            LET g_gzoz_d[l_ac].gzoz105 = "N"
            LET g_gzoz_d[l_ac].gzoz106 = "N"
            #end add-point
            LET g_gzoz_d_t.* = g_gzoz_d[l_ac].*     #新輸入資料
            LET g_gzoz_d_o.* = g_gzoz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzoz_d[li_reproduce_target].* = g_gzoz_d[li_reproduce].*
               LET g_gzoz2_d[li_reproduce_target].* = g_gzoz2_d[li_reproduce].*
 
               LET g_gzoz_d[g_gzoz_d.getLength()].gzoz000 = NULL
 
            END IF
            
 
 
            CALL azzi110_set_entry_b(l_cmd)
            CALL azzi110_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM gzoz_t 
             WHERE  gzoz000 = g_gzoz_d[l_ac].gzoz000
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzoz_d[g_detail_idx].gzoz000
               CALL azzi110_insert_b('gzoz_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzoz_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzoz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi110_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (gzoz000 = '", g_gzoz_d[l_ac].gzoz000, "' "
 
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
               
               DELETE FROM gzoz_t
                WHERE  
                      gzoz000 = g_gzoz_d_t.gzoz000
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzoz_t:",SQLERRMESSAGE 
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
                  CALL azzi110_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_gzoz_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE azzi110_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_gzoz_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzoz_d_t.gzoz000
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi110_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL azzi110_delete_b('gzoz_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzoz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzozstus
            #add-point:BEFORE FIELD gzozstus name="input.b.page1.gzozstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzozstus
            
            #add-point:AFTER FIELD gzozstus name="input.a.page1.gzozstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzozstus
            #add-point:ON CHANGE gzozstus name="input.g.page1.gzozstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz000
            #add-point:BEFORE FIELD gzoz000 name="input.b.page1.gzoz000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz000
            
            #add-point:AFTER FIELD gzoz000 name="input.a.page1.gzoz000"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzoz_d[l_ac].gzoz000) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzoz_d[l_ac].gzoz000 != g_gzoz_d_t.gzoz000))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzoz_t WHERE "||"gzoz000 = '"||g_gzoz_d[l_ac].gzoz000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #檢查是否為純英數或符號的資料
               IF cl_chk_num(g_gzoz_d[l_ac].gzoz000,"NUL_") THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "azz-00383"
                  LET g_errparam.code   = "azz-00383"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD gzoz000
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz000
            #add-point:ON CHANGE gzoz000 name="input.g.page1.gzoz000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz501
            #add-point:BEFORE FIELD gzoz501 name="input.b.page1.gzoz501"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz501
            
            #add-point:AFTER FIELD gzoz501 name="input.a.page1.gzoz501"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_gzoz_d[g_detail_idx].gzoz000 IS NOT NULL AND g_gzoz_d[g_detail_idx].gzoz501 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzoz_d[g_detail_idx].gzoz000 != g_gzoz_d_t.gzoz000 OR g_gzoz_d[g_detail_idx].gzoz501 != g_gzoz_d_t.gzoz501)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzoz_t WHERE "||"gzoz000 = '"||g_gzoz_d[g_detail_idx].gzoz000 ||"' AND "|| "gzoz501 = '"||g_gzoz_d[g_detail_idx].gzoz501 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz501
            #add-point:ON CHANGE gzoz501 name="input.g.page1.gzoz501"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz101
            #add-point:BEFORE FIELD gzoz101 name="input.b.page1.gzoz101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz101
            
            #add-point:AFTER FIELD gzoz101 name="input.a.page1.gzoz101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz101
            #add-point:ON CHANGE gzoz101 name="input.g.page1.gzoz101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz001
            #add-point:BEFORE FIELD gzoz001 name="input.b.page1.gzoz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz001
            
            #add-point:AFTER FIELD gzoz001 name="input.a.page1.gzoz001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz001
            #add-point:ON CHANGE gzoz001 name="input.g.page1.gzoz001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz102
            #add-point:BEFORE FIELD gzoz102 name="input.b.page1.gzoz102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz102
            
            #add-point:AFTER FIELD gzoz102 name="input.a.page1.gzoz102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz102
            #add-point:ON CHANGE gzoz102 name="input.g.page1.gzoz102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz002
            #add-point:BEFORE FIELD gzoz002 name="input.b.page1.gzoz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz002
            
            #add-point:AFTER FIELD gzoz002 name="input.a.page1.gzoz002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz002
            #add-point:ON CHANGE gzoz002 name="input.g.page1.gzoz002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz103
            #add-point:BEFORE FIELD gzoz103 name="input.b.page1.gzoz103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz103
            
            #add-point:AFTER FIELD gzoz103 name="input.a.page1.gzoz103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz103
            #add-point:ON CHANGE gzoz103 name="input.g.page1.gzoz103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz003
            #add-point:BEFORE FIELD gzoz003 name="input.b.page1.gzoz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz003
            
            #add-point:AFTER FIELD gzoz003 name="input.a.page1.gzoz003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz003
            #add-point:ON CHANGE gzoz003 name="input.g.page1.gzoz003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz104
            #add-point:BEFORE FIELD gzoz104 name="input.b.page1.gzoz104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz104
            
            #add-point:AFTER FIELD gzoz104 name="input.a.page1.gzoz104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz104
            #add-point:ON CHANGE gzoz104 name="input.g.page1.gzoz104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz004
            #add-point:BEFORE FIELD gzoz004 name="input.b.page1.gzoz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz004
            
            #add-point:AFTER FIELD gzoz004 name="input.a.page1.gzoz004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz004
            #add-point:ON CHANGE gzoz004 name="input.g.page1.gzoz004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz105
            #add-point:BEFORE FIELD gzoz105 name="input.b.page1.gzoz105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz105
            
            #add-point:AFTER FIELD gzoz105 name="input.a.page1.gzoz105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz105
            #add-point:ON CHANGE gzoz105 name="input.g.page1.gzoz105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz005
            #add-point:BEFORE FIELD gzoz005 name="input.b.page1.gzoz005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz005
            
            #add-point:AFTER FIELD gzoz005 name="input.a.page1.gzoz005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz005
            #add-point:ON CHANGE gzoz005 name="input.g.page1.gzoz005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz106
            #add-point:BEFORE FIELD gzoz106 name="input.b.page1.gzoz106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz106
            
            #add-point:AFTER FIELD gzoz106 name="input.a.page1.gzoz106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz106
            #add-point:ON CHANGE gzoz106 name="input.g.page1.gzoz106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz006
            #add-point:BEFORE FIELD gzoz006 name="input.b.page1.gzoz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz006
            
            #add-point:AFTER FIELD gzoz006 name="input.a.page1.gzoz006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz006
            #add-point:ON CHANGE gzoz006 name="input.g.page1.gzoz006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzoz503
            #add-point:BEFORE FIELD gzoz503 name="input.b.page1.gzoz503"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzoz503
            
            #add-point:AFTER FIELD gzoz503 name="input.a.page1.gzoz503"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzoz503
            #add-point:ON CHANGE gzoz503 name="input.g.page1.gzoz503"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD image
            #add-point:BEFORE FIELD image name="input.b.page1.image"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD image
            
            #add-point:AFTER FIELD image name="input.a.page1.image"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE image
            #add-point:ON CHANGE image name="input.g.page1.image"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzozstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzozstus
            #add-point:ON ACTION controlp INFIELD gzozstus name="input.c.page1.gzozstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz000
            #add-point:ON ACTION controlp INFIELD gzoz000 name="input.c.page1.gzoz000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz501
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz501
            #add-point:ON ACTION controlp INFIELD gzoz501 name="input.c.page1.gzoz501"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz101
            #add-point:ON ACTION controlp INFIELD gzoz101 name="input.c.page1.gzoz101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz001
            #add-point:ON ACTION controlp INFIELD gzoz001 name="input.c.page1.gzoz001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz102
            #add-point:ON ACTION controlp INFIELD gzoz102 name="input.c.page1.gzoz102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz002
            #add-point:ON ACTION controlp INFIELD gzoz002 name="input.c.page1.gzoz002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz103
            #add-point:ON ACTION controlp INFIELD gzoz103 name="input.c.page1.gzoz103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz003
            #add-point:ON ACTION controlp INFIELD gzoz003 name="input.c.page1.gzoz003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz104
            #add-point:ON ACTION controlp INFIELD gzoz104 name="input.c.page1.gzoz104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz004
            #add-point:ON ACTION controlp INFIELD gzoz004 name="input.c.page1.gzoz004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz105
            #add-point:ON ACTION controlp INFIELD gzoz105 name="input.c.page1.gzoz105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz005
            #add-point:ON ACTION controlp INFIELD gzoz005 name="input.c.page1.gzoz005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz106
            #add-point:ON ACTION controlp INFIELD gzoz106 name="input.c.page1.gzoz106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz006
            #add-point:ON ACTION controlp INFIELD gzoz006 name="input.c.page1.gzoz006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzoz503
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzoz503
            #add-point:ON ACTION controlp INFIELD gzoz503 name="input.c.page1.gzoz503"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.image
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD image
            #add-point:ON ACTION controlp INFIELD image name="input.c.page1.image"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE azzi110_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_gzoz_d[l_ac].* = g_gzoz_d_t.*
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
               LET g_errparam.extend = g_gzoz_d[l_ac].gzoz000 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzoz_d[l_ac].* = g_gzoz_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_gzoz2_d[l_ac].gzozmodid = g_user 
LET g_gzoz2_d[l_ac].gzozmoddt = cl_get_current()
LET g_gzoz2_d[l_ac].gzozmodid_desc = cl_get_username(g_gzoz2_d[l_ac].gzozmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi110_gzoz_t_mask_restore('restore_mask_o')
 
               UPDATE gzoz_t SET (gzozstus,gzoz000,gzoz501,gzoz101,gzoz001,gzoz102,gzoz002,gzoz103,gzoz003, 
                   gzoz104,gzoz004,gzoz105,gzoz005,gzoz106,gzoz006,gzoz503,gzozownid,gzozowndp,gzozcrtid, 
                   gzozcrtdp,gzozcrtdt,gzozmodid,gzozmoddt) = (g_gzoz_d[l_ac].gzozstus,g_gzoz_d[l_ac].gzoz000, 
                   g_gzoz_d[l_ac].gzoz501,g_gzoz_d[l_ac].gzoz101,g_gzoz_d[l_ac].gzoz001,g_gzoz_d[l_ac].gzoz102, 
                   g_gzoz_d[l_ac].gzoz002,g_gzoz_d[l_ac].gzoz103,g_gzoz_d[l_ac].gzoz003,g_gzoz_d[l_ac].gzoz104, 
                   g_gzoz_d[l_ac].gzoz004,g_gzoz_d[l_ac].gzoz105,g_gzoz_d[l_ac].gzoz005,g_gzoz_d[l_ac].gzoz106, 
                   g_gzoz_d[l_ac].gzoz006,g_gzoz_d[l_ac].gzoz503,g_gzoz2_d[l_ac].gzozownid,g_gzoz2_d[l_ac].gzozowndp, 
                   g_gzoz2_d[l_ac].gzozcrtid,g_gzoz2_d[l_ac].gzozcrtdp,g_gzoz2_d[l_ac].gzozcrtdt,g_gzoz2_d[l_ac].gzozmodid, 
                   g_gzoz2_d[l_ac].gzozmoddt)
                WHERE 
                  gzoz000 = g_gzoz_d_t.gzoz000 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzoz_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzoz_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzoz_d[g_detail_idx].gzoz000
               LET gs_keys_bak[1] = g_gzoz_d_t.gzoz000
               CALL azzi110_update_b('gzoz_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gzoz_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzoz_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi110_gzoz_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
 
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL azzi110_unlock_b("gzoz_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzoz_d[l_ac].* = g_gzoz_d_t.*
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
               LET g_gzoz_d[li_reproduce_target].* = g_gzoz_d[li_reproduce].*
               LET g_gzoz2_d[li_reproduce_target].* = g_gzoz2_d[li_reproduce].*
 
               LET g_gzoz_d[li_reproduce_target].gzoz000 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzoz_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzoz_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_gzoz2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL azzi110_b_fill(g_wc2)
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
               NEXT FIELD gzozstus
            WHEN "s_detail2"
               NEXT FIELD gzoz000_2
 
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
      IF INT_FLAG OR cl_null(g_gzoz_d[g_detail_idx].gzoz000) THEN
         CALL g_gzoz_d.deleteElement(g_detail_idx)
         CALL g_gzoz2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_gzoz_d[g_detail_idx].* = g_gzoz_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE azzi110_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi110.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi110_delete()
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
   FOR li_idx = 1 TO g_gzoz_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT azzi110_lock_b("gzoz_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("gzoz_t","gzozownid") THEN
            LET g_data_owner = g_gzoz2_d[g_detail_idx].gzozownid
            LET g_data_dept = g_gzoz2_d[g_detail_idx].gzozowndp
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
   
   FOR li_idx = 1 TO g_gzoz_d.getLength()
      IF g_gzoz_d[li_idx].gzoz000 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM gzoz_t
          WHERE  
                gzoz000 = g_gzoz_d[li_idx].gzoz000
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzoz_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_gzoz_d_t.gzoz000
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL azzi110_delete_b('gzoz_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi110_set_pk_array()
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
   CALL azzi110_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="azzi110.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi110_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.gzozstus,t0.gzoz000,t0.gzoz501,t0.gzoz101,t0.gzoz001,t0.gzoz102, 
       t0.gzoz002,t0.gzoz103,t0.gzoz003,t0.gzoz104,t0.gzoz004,t0.gzoz105,t0.gzoz005,t0.gzoz106,t0.gzoz006, 
       t0.gzoz503,t0.gzoz000,t0.gzozownid,t0.gzozowndp,t0.gzozcrtid,t0.gzozcrtdp,t0.gzozcrtdt,t0.gzozmodid, 
       t0.gzozmoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM gzoz_t t0",
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.gzozownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.gzozowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzozcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gzozcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gzozmodid  ",
 
               " WHERE 1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("gzoz_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND gzozowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("gzoz_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND gzozownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = g_sql , " AND t0.gzoz503 <> 'Y' "   #不取純英數或符號的資料
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gzoz_t"),
                      " ORDER BY t0.gzoz000"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzoz_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzi110_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi110_pb
   
   OPEN b_fill_curs
 
   CALL g_gzoz_d.clear()
   CALL g_gzoz2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gzoz_d[l_ac].gzozstus,g_gzoz_d[l_ac].gzoz000,g_gzoz_d[l_ac].gzoz501,g_gzoz_d[l_ac].gzoz101, 
       g_gzoz_d[l_ac].gzoz001,g_gzoz_d[l_ac].gzoz102,g_gzoz_d[l_ac].gzoz002,g_gzoz_d[l_ac].gzoz103,g_gzoz_d[l_ac].gzoz003, 
       g_gzoz_d[l_ac].gzoz104,g_gzoz_d[l_ac].gzoz004,g_gzoz_d[l_ac].gzoz105,g_gzoz_d[l_ac].gzoz005,g_gzoz_d[l_ac].gzoz106, 
       g_gzoz_d[l_ac].gzoz006,g_gzoz_d[l_ac].gzoz503,g_gzoz2_d[l_ac].gzoz000,g_gzoz2_d[l_ac].gzozownid, 
       g_gzoz2_d[l_ac].gzozowndp,g_gzoz2_d[l_ac].gzozcrtid,g_gzoz2_d[l_ac].gzozcrtdp,g_gzoz2_d[l_ac].gzozcrtdt, 
       g_gzoz2_d[l_ac].gzozmodid,g_gzoz2_d[l_ac].gzozmoddt,g_gzoz2_d[l_ac].gzozownid_desc,g_gzoz2_d[l_ac].gzozowndp_desc, 
       g_gzoz2_d[l_ac].gzozcrtid_desc,g_gzoz2_d[l_ac].gzozcrtdp_desc,g_gzoz2_d[l_ac].gzozmodid_desc
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
      
      CALL azzi110_detail_show()      
 
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
   
 
   
   CALL g_gzoz_d.deleteElement(g_gzoz_d.getLength())   
   CALL g_gzoz2_d.deleteElement(g_gzoz2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gzoz_d.getLength()
      LET g_gzoz2_d[l_ac].gzoz000 = g_gzoz_d[l_ac].gzoz000 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_gzoz_d.getLength() THEN
      LET l_ac = g_gzoz_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzoz_d.getLength()
      LET g_gzoz_d_mask_o[l_ac].* =  g_gzoz_d[l_ac].*
      CALL azzi110_gzoz_t_mask()
      LET g_gzoz_d_mask_n[l_ac].* =  g_gzoz_d[l_ac].*
   END FOR
   
   LET g_gzoz2_d_mask_o.* =  g_gzoz2_d.*
   FOR l_ac = 1 TO g_gzoz2_d.getLength()
      LET g_gzoz2_d_mask_o[l_ac].* =  g_gzoz2_d[l_ac].*
      CALL azzi110_gzoz_t_mask()
      LET g_gzoz2_d_mask_n[l_ac].* =  g_gzoz2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_gzoz_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE azzi110_pb
   
END FUNCTION
 
{</section>}
 
{<section id="azzi110.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzi110_detail_show()
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
 
{<section id="azzi110.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi110_set_entry_b(p_cmd)                                                  
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
 
{<section id="azzi110.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi110_set_no_entry_b(p_cmd)                                               
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
 
{<section id="azzi110.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi110_default_search()
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
      LET ls_wc = ls_wc, " gzoz000 = '", g_argv[01], "' AND "
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
 
{<section id="azzi110.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi110_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "gzoz_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'gzoz_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM gzoz_t
          WHERE 
            gzoz000 = ps_keys_bak[1]
         
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
         CALL g_gzoz_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_gzoz2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi110.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi110_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "gzoz_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO gzoz_t
                  (
                   gzoz000
                   ,gzozstus,gzoz501,gzoz101,gzoz001,gzoz102,gzoz002,gzoz103,gzoz003,gzoz104,gzoz004,gzoz105,gzoz005,gzoz106,gzoz006,gzoz503,gzozownid,gzozowndp,gzozcrtid,gzozcrtdp,gzozcrtdt,gzozmodid,gzozmoddt) 
            VALUES(
                   ps_keys[1]
                   ,g_gzoz_d[l_ac].gzozstus,g_gzoz_d[l_ac].gzoz501,g_gzoz_d[l_ac].gzoz101,g_gzoz_d[l_ac].gzoz001, 
                       g_gzoz_d[l_ac].gzoz102,g_gzoz_d[l_ac].gzoz002,g_gzoz_d[l_ac].gzoz103,g_gzoz_d[l_ac].gzoz003, 
                       g_gzoz_d[l_ac].gzoz104,g_gzoz_d[l_ac].gzoz004,g_gzoz_d[l_ac].gzoz105,g_gzoz_d[l_ac].gzoz005, 
                       g_gzoz_d[l_ac].gzoz106,g_gzoz_d[l_ac].gzoz006,g_gzoz_d[l_ac].gzoz503,g_gzoz2_d[l_ac].gzozownid, 
                       g_gzoz2_d[l_ac].gzozowndp,g_gzoz2_d[l_ac].gzozcrtid,g_gzoz2_d[l_ac].gzozcrtdp, 
                       g_gzoz2_d[l_ac].gzozcrtdt,g_gzoz2_d[l_ac].gzozmodid,g_gzoz2_d[l_ac].gzozmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzoz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi110.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi110_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "gzoz_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzoz_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE gzoz_t 
         SET (gzoz000
              ,gzozstus,gzoz501,gzoz101,gzoz001,gzoz102,gzoz002,gzoz103,gzoz003,gzoz104,gzoz004,gzoz105,gzoz005,gzoz106,gzoz006,gzoz503,gzozownid,gzozowndp,gzozcrtid,gzozcrtdp,gzozcrtdt,gzozmodid,gzozmoddt) 
              = 
             (ps_keys[1]
              ,g_gzoz_d[l_ac].gzozstus,g_gzoz_d[l_ac].gzoz501,g_gzoz_d[l_ac].gzoz101,g_gzoz_d[l_ac].gzoz001, 
                  g_gzoz_d[l_ac].gzoz102,g_gzoz_d[l_ac].gzoz002,g_gzoz_d[l_ac].gzoz103,g_gzoz_d[l_ac].gzoz003, 
                  g_gzoz_d[l_ac].gzoz104,g_gzoz_d[l_ac].gzoz004,g_gzoz_d[l_ac].gzoz105,g_gzoz_d[l_ac].gzoz005, 
                  g_gzoz_d[l_ac].gzoz106,g_gzoz_d[l_ac].gzoz006,g_gzoz_d[l_ac].gzoz503,g_gzoz2_d[l_ac].gzozownid, 
                  g_gzoz2_d[l_ac].gzozowndp,g_gzoz2_d[l_ac].gzozcrtid,g_gzoz2_d[l_ac].gzozcrtdp,g_gzoz2_d[l_ac].gzozcrtdt, 
                  g_gzoz2_d[l_ac].gzozmodid,g_gzoz2_d[l_ac].gzozmoddt) 
         WHERE  gzoz000 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzoz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzoz_t:",SQLERRMESSAGE 
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
 
{<section id="azzi110.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi110_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL azzi110_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gzoz_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi110_bcl USING 
                                       g_gzoz_d[g_detail_idx].gzoz000
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi110_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi110.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi110_unlock_b(ps_table)
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
      CLOSE azzi110_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi110.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION azzi110_modify_detail_chk(ps_record)
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
         LET ls_return = "gzozstus"
      WHEN "s_detail2"
         LET ls_return = "gzoz000_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi110.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION azzi110_show_ownid_msg()
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
 
{<section id="azzi110.mask_functions" >}
&include "erp/azz/azzi110_mask.4gl"
 
{</section>}
 
{<section id="azzi110.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi110_set_pk_array()
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
   LET g_pk_array[1].values = g_gzoz_d[l_ac].gzoz000
   LET g_pk_array[1].column = 'gzoz000'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi110.state_change" >}
   
 
{</section>}
 
{<section id="azzi110.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="azzi110.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 轉換標準詞
# Memo...........:
# Usage..........: CALL azzi110_trans_standard(ps_source_str,ps_exp_lang)
#                  RETURNING ps_changed_str
# Input parameter: ps_source_str  需要被替換的字串
#                : ps_exp_lang    要被替換的語言別
# Return code....: ps_changed_str 替換後的新字串
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_trans_standard(ps_source_str,ps_exp_lang)
   DEFINE ps_source_str   STRING
   DEFINE ps_exp_lang     LIKE type_t.chr10
   DEFINE ps_return_str   STRING
   DEFINE ls_sql          STRING
   DEFINE lc_gzow000      LIKE gzow_t.gzow000
   DEFINE lc_gzow001      LIKE gzow_t.gzow001
   DEFINE lc_gzow002      LIKE gzow_t.gzow002
   DEFINE lc_gzow003      LIKE gzow_t.gzow003
   DEFINE lc_gzow004      LIKE gzow_t.gzow004
   DEFINE lc_gzow005      LIKE gzow_t.gzow005
   DEFINE lc_gzow006      LIKE gzow_t.gzow006

   
   
   LET ps_return_str = ps_source_str
   
   LET ls_sql = "SELECT gzow000,gzow001,gzow002,gzow003,gzow004,",
                      " gzow005,gzow006 ",
                 " FROM gzow_t "
   PREPARE azzi110_chk_gzow_pre FROM ls_sql
   DECLARE azzi110_chk_gzow_cs CURSOR FOR azzi110_chk_gzow_pre
   FOREACH azzi110_chk_gzow_cs INTO lc_gzow000,lc_gzow001,lc_gzow002,lc_gzow003,lc_gzow004,
                                    lc_gzow005,lc_gzow006
      
      #先檢查看看是否有符合的標準詞
      IF ps_return_str.getIndexOf(lc_gzow000,1) > 0 THEN
         #再依照要轉出的語言別做標準詞替換
         CASE
            WHEN g_exp_lang = "en_US"   #英文
               IF NOT cl_null(lc_gzow001) THEN
                  LET ps_return_str = cl_str_replace_multistr(ps_return_str,lc_gzow000,lc_gzow001)
               END IF
            WHEN g_exp_lang = "zh_CN"   #簡中
               IF NOT cl_null(lc_gzow002) THEN
                  LET ps_return_str = cl_str_replace_multistr(ps_return_str,lc_gzow000,lc_gzow002)
               END IF
            WHEN g_exp_lang = "ja_JP"   #日文
               IF NOT cl_null(lc_gzow003) THEN
                  LET ps_return_str = cl_str_replace_multistr(ps_return_str,lc_gzow000,lc_gzow003)
               END IF
            WHEN g_exp_lang = "vi_VN"   #越文
               IF NOT cl_null(lc_gzow004) THEN
                  LET ps_return_str = cl_str_replace_multistr(ps_return_str,lc_gzow000,lc_gzow004)
               END IF
            WHEN g_exp_lang = "th_TH"   #泰文
               IF NOT cl_null(lc_gzow005) THEN
                  LET ps_return_str = cl_str_replace_multistr(ps_return_str,lc_gzow000,lc_gzow005)
               END IF
            WHEN g_exp_lang = "ko_KR"   #韓文
               IF NOT cl_null(lc_gzow006) THEN
                  LET ps_return_str = cl_str_replace_multistr(ps_return_str,lc_gzow000,lc_gzow006)
               END IF
         END CASE
      END IF
   END FOREACH
   
   RETURN ps_return_str
   
END FUNCTION

################################################################################
# Descriptions...: 匯出送翻資料
# Memo...........:
# Usage..........: CALL azzi110_export_to_trans()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_export_to_trans()
   DEFINE ls_begin      STRING
   DEFINE lc_cnt        LIKE type_t.num10
   DEFINE ls_target     STRING
   DEFINE ls_source     STRING
   DEFINE ls_file_name  STRING
   DEFINE ls_url        STRING
   DEFINE ls_js         STRING
   DEFINE l_urlfile     STRING
   DEFINE li_stat       LIKE type_t.num5
   DEFINE l_channel     base.Channel
   DEFINE l_str         STRING
   DEFINE l_quote       LIKE type_t.chr10
   
   
   #開窗詢問要匯出的語言別
   LET g_exp_lang = cl_ask_prtmsg("azz-00386",g_lang)

   CALL g_gzoz_d_changed.clear()

   IF NOT cl_null(g_exp_lang) THEN
      IF g_exp_lang = "zh_CN" OR g_exp_lang = "en_US" OR g_exp_lang = "ja_JP"
          OR g_exp_lang = "vi_VN" OR g_exp_lang = "th_TH" OR g_exp_lang = "ko_KR" THEN
          
         #此次匯出的檔案
         LET l_channel = base.Channel.create()
         LET ls_begin = g_today USING "yyyymmdd"
         LET ls_file_name = "azzi110_",ls_begin CLIPPED ,"_exp_to_trans_",g_exp_lang,".xls"
         LET ls_target = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file_name)
         IF os.Path.exists(ls_target) THEN
            IF os.Path.delete(ls_target) THEN
            END IF
         END IF
         IF NOT os.Path.exists(ls_target) THEN
            CALL l_channel.openFile(ls_target, "w")
         ELSE
            CALL l_channel.openFile(ls_target, "a")
         END IF
         CALL l_channel.setDelimiter("")
         
         FOR lc_cnt = 1 TO g_gzoz_d.getLength()
            DISPLAY "export to trans:",g_gzoz_d[lc_cnt].gzoz000
            LET g_gzoz_d_changed[lc_cnt].gzoz501 = g_gzoz_d[lc_cnt].gzoz501
            LET g_gzoz_d_changed[lc_cnt].gzoz000 = g_gzoz_d[lc_cnt].gzoz000
       
            CASE
               WHEN g_exp_lang = "en_US"   #英文
                  LET g_gzoz_d_changed[lc_cnt].exp_lang_data = g_gzoz_d[lc_cnt].gzoz001
               WHEN g_exp_lang = "zh_CN"   #簡中
                  LET g_gzoz_d_changed[lc_cnt].exp_lang_data = g_gzoz_d[lc_cnt].gzoz002
               WHEN g_exp_lang = "ja_JP"   #日文
                  LET g_gzoz_d_changed[lc_cnt].exp_lang_data = g_gzoz_d[lc_cnt].gzoz003
               WHEN g_exp_lang = "vi_VN"   #越文
                  LET g_gzoz_d_changed[lc_cnt].exp_lang_data = g_gzoz_d[lc_cnt].gzoz004
               WHEN g_exp_lang = "th_TH"   #泰文
                  LET g_gzoz_d_changed[lc_cnt].exp_lang_data = g_gzoz_d[lc_cnt].gzoz005
               WHEN g_exp_lang = "ko_KR"   #韓文
                  LET g_gzoz_d_changed[lc_cnt].exp_lang_data = g_gzoz_d[lc_cnt].gzoz006
            END CASE
            
            #匯出前須做標準詞轉換
            LET g_gzoz_d_changed[lc_cnt].gzoz000_changed = azzi110_trans_standard(g_gzoz_d_changed[lc_cnt].gzoz000,g_exp_lang)

            #將匯出的檔案實體檔案
            IF g_gzoz_d_changed.getLength() > 0 THEN
               IF g_gzoz_d_changed.getLength() = 1 THEN
                  #組xml檔(表頭資訊)
                  LET l_str = "<html xmlns:o=",l_quote,"urn:schemas-microsoft-com:office:office",l_quote
                  CALL l_channel.write(l_str CLIPPED)
                  LET l_str = "xmlns:x=",l_quote,"urn:schemas-microsoft-com:office:excel",l_quote
                  CALL l_channel.write(l_str CLIPPED)
                  LET l_str = "xmlns=",l_quote,"http://www.w3.org/TR/REC-html40",l_quote,">"
                  CALL l_channel.write(l_str CLIPPED)

                  CALL l_channel.write("<head>")
                  LET l_str = "<meta http-equiv=Content-Type content=",l_quote,"text/html; charset=UTF-8",l_quote,">"
                  CALL l_channel.write(l_str CLIPPED)
                  CALL l_channel.write("<style><!--")
                  CALL l_channel.write("td  {font-family:Courier New, serif;}")
                  
                  LET l_str = ".xl24  {mso-number-format:",l_quote,"\@",l_quote,";}",
                              ".xl30 {mso-style-parent:style0; mso-number-format:\"0_ \";} ",
                              ".xl31 {mso-style-parent:style0; mso-number-format:\"0\.0_ \";} ",
                              ".xl32 {mso-style-parent:style0; mso-number-format:\"0\.00_ \";} ",
                              ".xl33 {mso-style-parent:style0; mso-number-format:\"0\.000_ \";} ",
                              ".xl34 {mso-style-parent:style0; mso-number-format:\"0\.0000_ \";} ",
                              ".xl35 {mso-style-parent:style0; mso-number-format:\"0\.00000_ \";} ",
                              ".xl36 {mso-style-parent:style0; mso-number-format:\"0\.000000_ \";} ",
                              ".xl37 {mso-style-parent:style0; mso-number-format:\"0\.0000000_ \";} ",
                              ".xl38 {mso-style-parent:style0; mso-number-format:\"0\.00000000_ \";} ",
                              ".xl39 {mso-style-parent:style0; mso-number-format:\"0\.000000000_ \";} ",
                              ".xl40 {mso-style-parent:style0; mso-number-format:\"0\.0000000000_ \";} "
                  
                  CALL l_channel.write(l_str CLIPPED)
                  CALL l_channel.write("--></style>")

                  CALL l_channel.write("<!--[if gte mso 9]><xml>")
                  CALL l_channel.write("<x:ExcelWorkbook>")
                  CALL l_channel.write("<x:DefaultRowHeight>330</x:DefaultRowHeight>")
                  CALL l_channel.write("</x:ExcelWorkbook>")
                  CALL l_channel.write("</xml><![endif]--></head>")
                  CALL l_channel.write("<body><table border=1 cellpadding=0 cellspacing=0 width=432 style='border-collapse: collapse;table-layout:fixed;width:324pt'>")
                  LET l_str = "<tr hieght=22><td class=xl24>來源程式</td>",
                                            "<td class=xl24>繁體中文</td>",
                                            "<td class=xl24>繁體中文(轉換過標準詞)</td>",
                                            "<td class=xl24>匯出語系資料(",g_exp_lang,")</td></tr>"
                  CALL l_channel.write(l_str CLIPPED)
               END IF
               
               #組xml檔案(單身)
               LET l_str = "<tr hieght=22><td class=xl24>",g_gzoz_d_changed[lc_cnt].gzoz501,"</td>",
                                         "<td class=xl24>",g_gzoz_d_changed[lc_cnt].gzoz000,"</td>",
                                         "<td class=xl24>",g_gzoz_d_changed[lc_cnt].gzoz000_changed,"</td>",
                                         "<td class=xl24>",g_gzoz_d_changed[lc_cnt].exp_lang_data,"</td></tr>"
               CALL l_channel.write(l_str CLIPPED)
            END IF
         END FOR
         
         #組xml檔案(表尾)
         CALL l_channel.write("</table></body></html>")
         CALL l_channel.close()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "azz-00387"
         LET g_errparam.code   = "azz-00387"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   END IF
   
   #複製檔案到TEMPDIR下
   IF g_gzoz_d_changed.getLength() > 0 THEN
      #開啟檔案
      LET l_urlfile = ''
      LET l_urlfile = ls_file_name
      LET l_urlfile = l_urlfile.trim()
      LET l_urlfile = cl_trans_url_encode(l_urlfile)
      LET ls_url = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),l_urlfile CLIPPED)
      LET li_stat = cl_client_open_url(ls_url)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查字典檔字詞的來源
# Memo...........:
# Usage..........: CALL azzi110_chk_where_use()
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_chk_where_use()
   DEFINE ls_sql       STRING
   DEFINE ls_gzoz000   LIKE gzoz_t.gzoz000
   DEFINE ls_gzoz501   LIKE gzoz_t.gzoz501
   DEFINE ls_cnt       LIKE type_t.num5
   DEFINE lc_i         LIKE type_t.num5
   DEFINE lc_count_1   LIKE type_t.num5
   DEFINE lc_count_2   LIKE type_t.num5
   DEFINE ls_gzzal001  LIKE gzzal_t.gzzal001
   DEFINE ls_gzzal002  LIKE gzzal_t.gzzal002
   DEFINE ls_gzszl001  LIKE gzszl_t.gzszl001
   DEFINE ls_gzszl002  LIKE gzszl_t.gzszl002
   DEFINE ls_gzsv001   LIKE gzsv_t.gzsv001
   DEFINE ls_gzgdl000  LIKE gzgdl_t.gzgdl000
   DEFINE ls_gzdfl001  LIKE gzdfl_t.gzdfl001
   DEFINE ls_gzge000   LIKE gzge_t.gzge000
   DEFINE ls_gzge001   LIKE gzge_t.gzge001
   CONSTANT lc_langtable_num = 35   #紀錄目前需要處理的多語言檔案個數
   
   
   #先清空字典檔中的來源程式欄位(gzoz501)
   UPDATE gzoz_t SET gzoz501 = ""
DISPLAY "delete old gzoz501 data"
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "adz-00089"
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = "gzoz_t"
      LET g_errparam.replace[2] = SQLCA.SQLCODE
      CALL cl_err()
      RETURN
   END IF

   LET ls_sql = "SELECT gzoz000 FROM gzoz_t"

   PREPARE azzi110_where_use_pre FROM ls_sql
   DECLARE azzi110_where_use_cur CURSOR FOR azzi110_where_use_pre
   FOREACH azzi110_where_use_cur INTO ls_gzoz000
      FOR lc_i = 1 TO lc_langtable_num
         CASE
            WHEN lc_i = 1
               #dzeal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM dzeal_t
                WHERE dzeal002 = "zh_TW" AND dzeal003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi150"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "dzeal_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF
               
            WHEN lc_i = 2
               #dzebl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM dzebl_t
                WHERE dzebl002 = "zh_TW" AND dzebl003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi150"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "dzebl_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF

            WHEN lc_i = 3
               #gzzal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzzal_t
                WHERE gzzal002 = "zh_TW" AND gzzal003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_sql = "SELECT gzzal001 FROM gzzal_t ",
                               " WHERE gzzal002 = 'zh_TW' AND gzzal003 = '",ls_gzoz000,"'",
                               " ORDER BY gzzal001"

                  DECLARE azzi110_get_gzzal_cs CURSOR FROM ls_sql
                  FOREACH azzi110_get_gzzal_cs INTO ls_gzzal001
                     IF NOT SQLCA.SQLCODE THEN
                        LET lc_count_1 = 0
                        LET lc_count_2 = 0
                        #azzi900
                        SELECT COUNT(1) INTO lc_count_1 FROM gzza_t
                         WHERE gzza001 = ls_gzzal001

                        IF lc_count_1 > 0 THEN
                           LET ls_gzoz501 = "azzi900"
                           UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                            WHERE gzoz000 = ls_gzoz000
DISPLAY "gzzal_t   ",ls_gzoz000,"   ",ls_gzoz501
                           EXIT FOR
                        ELSE
                           #azzi910
                           SELECT COUNT(1) INTO lc_count_2 FROM gzzz_t
                            WHERE gzzz001 = ls_gzzal001

                           IF lc_count_2 > 0 THEN
                              LET ls_gzoz501 = "azzi910"
                              UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                               WHERE gzoz000 = ls_gzoz000

DISPLAY "gzzal_t   ",ls_gzoz000,"   ",ls_gzoz501
                              EXIT FOR
                           END IF
                        END IF
                     END IF
                  END FOREACH
               END IF

            WHEN lc_i = 4
               #gzzd_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzzd_t
                WHERE gzzd002 = "zh_TW"
                  AND (gzzd005 = ls_gzoz000 OR gzzd006 = ls_gzoz000)

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi902"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000

DISPLAY "gzzd_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF

            WHEN lc_i = 5
               #gzdfl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzdfl_t
                WHERE gzdfl002 = "zh_TW" AND gzdfl003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_sql = "SELECT gzdfl001 FROM gzdfl_t ",
                               " WHERE gzdfl002 = 'zh_TW' AND gzdfl003 = '",ls_gzoz000,"'",
                               " ORDER BY gzdfl001"

                  DECLARE azzi110_get_gzdfl_cs CURSOR FROM ls_sql
                  FOREACH azzi110_get_gzdfl_cs INTO ls_gzdfl001
                     IF NOT SQLCA.SQLCODE THEN
                        LET lc_count_1 = 0
                        LET lc_count_2 = 0
                        #azzi900
                        SELECT COUNT(*) INTO lc_count_1 FROM gzdf_t,gzza_t
                         WHERE gzza001 = gzdf001 AND gzdf002 = ls_gzdfl001

                        IF lc_count_1 > 0 THEN
                           LET ls_gzoz501 = "azzi900"
                           UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                            WHERE gzoz000 = ls_gzoz000
DISPLAY "gzdfl_t   ",ls_gzoz000,"   ",ls_gzoz501

                           EXIT FOR
                        ELSE
                           #azzi901
                           SELECT COUNT(*) INTO lc_count_2 FROM gzdf_t,gzde_t
                            WHERE gzde001 = gzdf001 AND gzdf002 = ls_gzdfl001

                           IF lc_count_2 > 0 THEN
                              LET ls_gzoz501 = "azzi901"
                              UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                               WHERE gzoz000 = ls_gzoz000

DISPLAY "gzdfl_t   ",ls_gzoz000,"   ",ls_gzoz501
                              EXIT FOR
                           END IF
                        END IF
                     END IF
                  END FOREACH
               END IF

            WHEN lc_i = 6
               #gzzq_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzzq_t
                WHERE gzzq003 = "zh_TW"
                  AND (gzzq004 = ls_gzoz000 OR gzzq005 = ls_gzoz000)

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi903"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000

DISPLAY "gzzq_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF

            WHEN lc_i = 7
               #gzswl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzswl_t
                WHERE gzswl003 = "zh_TW" AND gzswl004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi993"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000

DISPLAY "gzawl_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF

            WHEN lc_i = 8
               #gzsxl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzsxl_t
                WHERE gzsxl004 = "zh_TW" AND gzsxl005 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi993"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000

DISPLAY "gzsxl_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF

            WHEN lc_i = 9
               #gzszl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzszl_t
                WHERE gzszl003 = "zh_TW"
                  AND (gzszl004 = ls_gzoz000 OR gzszl005 = ls_gzoz000
                       OR gzszl006 = ls_gzoz000 OR gzszl007 = ls_gzoz000)

               IF ls_cnt > 0 THEN
                  LET ls_sql = "SELECT gzszl001,gzszl002 FROM gzszl_t ",
                               " WHERE gzszl003 = 'zh_TW'",
                                 " AND (gzszl004 = '",ls_gzoz000,"'",
                                   " OR gzszl005 = '",ls_gzoz000,"'",
                                   " OR gzszl006 = '",ls_gzoz000,"'",
                                   " OR gzszl007 = '",ls_gzoz000,"')",
                               " ORDER BY gzszl001"

                  DECLARE azzi110_get_gzszl_cs CURSOR FROM ls_sql
                  FOREACH azzi110_get_gzszl_cs INTO ls_gzszl001,ls_gzszl002
                     IF NOT SQLCA.SQLCODE THEN
                        LET lc_count_1 = 0
                        LET lc_count_2 = 0
                        #azzi991
                        #雖然gzszl_t的主表是gzsz_t，所以不管是azzi991或是azzi993都會在gzsz_t有一筆資料，
                        #只是在azzi991查詢時，會限制只能查詢出'ooac_t'的資料，
                        #假設參數設定項(E-SYS-0701)雖然實際有存在於gzsz_t，但此參數項不屬於單據別設定(即非azzi991可查詢到的資料)
                        #所以在填過單資訊的時候，應填azzi993才對
                        #因此，在搜尋此筆多語言資料是否存在於主表時，在azzi991項中，也應該加上限制只能取'ooac_t'的資料
                        SELECT COUNT(1) INTO lc_count_1 FROM gzsz_t
                         WHERE gzsz001 = 'ooac_t'
                           AND gzsz001 = ls_gzsz001 AND gzsz002 = ls_gzszl002

                        IF lc_count_1 > 0 THEN
                           LET ls_gzoz501 = "azzi991"
                           UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                            WHERE gzoz000 = ls_gzoz000
DISPLAY "gzszl_t   ",ls_gzoz000,"   ",ls_gzoz501

                           EXIT FOR
                        ELSE
                           #azzi993
                           SELECT DISTINCT gzsv001 INTO ls_gzsv001 FROM gzsv_t,gzsz_t
                            WHERE gzsv005 = gzsz001 AND gzsv006 = gzsz002
                              AND gzsz001 = ls_gzsz001 AND gzsz002 = ls_gzszl002

                           SELECT COUNT(1) INTO lc_count_2 FROM gzsx_t
                            WHERE gzsx001 = ls_gzsv001

                           IF lc_count_2 > 0 THEN
                              LET ls_gzoz501 = "azzi993"
                              UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                               WHERE gzoz000 = ls_gzoz000
DISPLAY "gzszl_t   ",ls_gzoz000,"   ",ls_gzoz501

                              EXIT FOR
                           END IF
                        END IF
                     END IF
                  END FOREACH
               END IF

            WHEN lc_i = 10
               #gzwel_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzwel_t
                WHERE gzwel002 = "zh_TW" AND gzwel003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi880"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000

DISPLAY "gzwel_t   ",ls_gzoz000,"   ",ls_gzoz501
                  EXIT FOR
               END IF

            WHEN lc_i = 11
               #gzcal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzcal_t
                WHERE gzcal002 = "zh_TW" AND gzcal003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi600"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzcal_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 12
               #gzcbl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzcbl_t
                WHERE gzcbl003 = "zh_TW"
                  AND (gzcbl004 = ls_gzoz000 OR gzcbl006 = ls_gzoz000)

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi600"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzcbl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 13
               #gzgdl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzgdl_t
                WHERE gzgdl001 = "zh_TW" AND gzgdl002 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_sql = "SELECT gzgdl000 FROM gzgdl_t ",
                               " WHERE gzgdl001 = 'zh_TW' AND gzgdl002 = '",ls_gzoz000,"'",
                               " ORDER BY gzgdl000"

                  DECLARE azzi110_get_gzgdl_cs CURSOR FROM ls_sql
                  FOREACH azzi110_get_gzgdl_cs INTO ls_gzgdl000
                     IF NOT SQLCA.SQLCODE THEN
                        LET lc_count_1 = 0
                        LET lc_count_2 = 0
                        #azzi300
                        SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t
                         WHERE gzgf000 = ls_gzgdl000
                        
                        IF lc_count_1 > 0 THEN
                           LET ls_gzoz501 = "azzi300"
                           UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                            WHERE gzoz000 = ls_gzoz000
DISPLAY "gzgdl_t   ",ls_gzoz000,"   ",ls_gzoz501

                           EXIT FOR
                        ELSE
                           #azzi301
                           SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t
                            WHERE gzgd000 = ls_gzgdl000

                           IF lc_count_2 > 0 THEN
                              LET ls_gzoz501 = "azzi301"
                              UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                               WHERE gzoz000 = ls_gzoz000
DISPLAY "gzgdl_t   ",ls_gzoz000,"   ",ls_gzoz501

                              EXIT FOR
                           END IF
                        END IF
                     END IF
                  END FOREACH
               END IF
               
            WHEN lc_i = 14
               #gzge_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzge_t
                WHERE gzge002 = "zh_TW" AND gzge003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_sql = "SELECT gzge000,gzge001 FROM gzge_t ",
                               " WHERE gzge002 = 'zh_TW' AND gzge003 = '",ls_gzoz000,"'",
                               " ORDER BY gzge000,gzge001"

                  DECLARE azzi110_get_gzge_cs CURSOR FROM ls_sql
                  FOREACH azzi110_get_gzge_cs INTO ls_gzge000,ls_gzge001
                     IF NOT SQLCA.SQLCODE THEN
                        LET lc_count_1 = 0
                        LET lc_count_2 = 0
                        #azzi300
                        SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t
                         WHERE gzgf000 = ls_gzge000
                        
                        IF lc_count_1 > 0 THEN
                           LET ls_gzoz501 = "azzi300"
                           UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                            WHERE gzoz000 = ls_gzoz000
DISPLAY "gzge_t   ",ls_gzoz000,"   ",ls_gzoz501

                           EXIT FOR
                        ELSE
                           #azzi301
                           SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t
                            WHERE gzgd000 = ls_gzge000

                           IF lc_count_2 > 0 THEN
                              LET ls_gzoz501 = "azzi301"
                              UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                               WHERE gzoz000 = ls_gzoz000
DISPLAY "gzge_t   ",ls_gzoz000,"   ",ls_gzoz501

                              EXIT FOR
                           END IF
                        END IF
                     END IF
                  END FOREACH
               END IF
               
            WHEN lc_i = 15
               #dzcal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM dzcal_t
                WHERE dzcal002 = "zh_TW" AND dzcal003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "adzi210"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "dzcal_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 16
               #dzcbl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM dzcbl_t
                WHERE dzcbl003 = "zh_TW" AND dzcbl004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "adzi210"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "dzcbl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 17
               #dzcdl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM dzcdl_t
                WHERE dzcdl002 = "zh_TW" AND dzcdl003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "adzi220"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "dzcdl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 18
               #dzcel_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM dzcel_t
                WHERE dzcel003 = "zh_TW" AND dzcel004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "adzi220"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "dzcel_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 19
               #gzdel_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzdel_t
                WHERE gzdel002 = "zh_TW" AND gzdel003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi901"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzdel_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 20
               #gzhal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzhal_t
                WHERE gzhal002 = "zh_TW" AND gzhal003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi901"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzhal_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 21
               #gzial_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzial_t
                WHERE gzial002 = "zh_TW" AND gzial003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi310"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzial_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 22
               #gzidl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzidl_t
                WHERE gzidl003 = "zh_TW" AND gzidl004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi310"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzidl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 23
               #gzjal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzjal_t
                WHERE gzjal002 = "zh_TW" AND gzjal003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi700"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzjal_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 24
               #gztdl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gztdl_t
                WHERE gztdl002 = "zh_TW"
                  AND (gztdl003 = ls_gzoz000 OR gztdl004 = ls_gzoz000)

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi090"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gztdl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 25
               #gztel_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gztel_t
                WHERE gztel002 = "zh_TW" AND gztel003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi552"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gztel_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 26
               #gzzol_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzzol_t
                WHERE gzzol002 = "zh_TW" AND gzzol003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi070"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzzol_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF

            WHEN lc_i = 27
               #gzzf_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzzf_t
                WHERE gzzf002 = "zh_TW"
                  AND (gzzf005 = ls_gzoz000 OR gzzf006 = ls_gzoz000)

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi912"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzzf_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 28
               #wscal_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM wscal_t
                WHERE wscal008 = "zh_TW"
                  AND wscal009 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "awsi200"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "wscal_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 29
               #wsebl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM wsebl_t
                WHERE wsebl003 = "zh_TW"
                  AND wsebl004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "awsi220"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "wsebl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 30
               #wsecl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM wsecl_t
                WHERE wsecl002 = "zh_TW"
                  AND wsecl003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "awsi001"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "wsecl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 31
               #wsecl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzgjl_t
                WHERE gzgjl002 = "zh_TW"
                  AND gzgjl003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi330"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzgjl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 32
               #gzahl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzahl_t
                WHERE gzahl003 = "zh_TW"
                  AND gzahl004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "azzi988"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzahl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 33
               #gzahl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM gzgp_t
                WHERE gzgp003 = "zh_TW"
                  AND gzgp004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "aooi900"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "gzgp_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 34
               #gzahl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM rpdel_t
                WHERE rpdel003 = "zh_TW"
                  AND rpdel004 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "arpi900"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "rpdel_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
            
            WHEN lc_i = 35
               #gzahl_t
               LET ls_cnt = 0
               SELECT COUNT(*) INTO ls_cnt FROM rpzzl_t
                WHERE rpzzl002 = "zh_TW"
                  AND rpzzl003 = ls_gzoz000

               IF ls_cnt > 0 THEN
                  LET ls_gzoz501 = "arpi900"
                  UPDATE gzoz_t SET gzoz501 = ls_gzoz501
                   WHERE gzoz000 = ls_gzoz000
DISPLAY "rpzzl_t   ",ls_gzoz000,"   ",ls_gzoz501

                  EXIT FOR
               END IF
         END CASE

      END FOR
   END FOREACH
   
END FUNCTION

 
{</section>}
 
