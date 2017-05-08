#該程式未解開Section, 採用最新樣板產出!
{<section id="asti205.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-06-27 15:36:58), PR版次:0005(2016-09-05 20:28:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000345
#+ Filename...: asti205
#+ Description: 合約計算及條件基準維護作業(分銷)
#+ Creator....: 03247(2014-06-23 16:33:41)
#+ Modifier...: 03247 -SD/PR- 08172
 
{</section>}
 
{<section id="asti205.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#15 2016/09/05 by 08172 调整系统中无ENT的SQL条件增加ent
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
PRIVATE TYPE type_g_stab_d RECORD
       stabstus LIKE stab_t.stabstus, 
   stab001 LIKE stab_t.stab001, 
   stabl003 LIKE stabl_t.stabl003, 
   stabl004 LIKE stabl_t.stabl004, 
   stab002 LIKE stab_t.stab002, 
   stab003 LIKE stab_t.stab003, 
   stab004 LIKE stab_t.stab004, 
   stab005 LIKE stab_t.stab005, 
   stab006 LIKE stab_t.stab006, 
   stab007 LIKE stab_t.stab007, 
   stab008 LIKE stab_t.stab008, 
   stab009 LIKE stab_t.stab009, 
   stab010 LIKE stab_t.stab010, 
   stab011 LIKE stab_t.stab011
       END RECORD
PRIVATE TYPE type_g_stab2_d RECORD
       stab001 LIKE stab_t.stab001, 
   stabownid LIKE stab_t.stabownid, 
   stabownid_desc LIKE type_t.chr500, 
   stabowndp LIKE stab_t.stabowndp, 
   stabowndp_desc LIKE type_t.chr500, 
   stabcrtid LIKE stab_t.stabcrtid, 
   stabcrtid_desc LIKE type_t.chr500, 
   stabcrtdp LIKE stab_t.stabcrtdp, 
   stabcrtdp_desc LIKE type_t.chr500, 
   stabcrtdt DATETIME YEAR TO SECOND, 
   stabmodid LIKE stab_t.stabmodid, 
   stabmodid_desc LIKE type_t.chr500, 
   stabmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      stabl001 LIKE stabl_t.stabl001,
      stabl002 LIKE stabl_t.stabl002,
      stabl003 LIKE stabl_t.stabl003,
      stabl004 LIKE stabl_t.stabl004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_stat_d             DYNAMIC ARRAY OF RECORD
   stat001 LIKE stat_t.stat001,
   stat002 LIKE stat_t.stat002,
   stat002_desc LIKE type_t.chr500,
   stat003 LIKE stat_t.stat003
       END RECORD
DEFINE g_stat_d_t           RECORD
   stat001 LIKE stat_t.stat001,
   stat002 LIKE stat_t.stat002,
   stat002_desc LIKE type_t.chr500,
   stat003 LIKE stat_t.stat003
       END RECORD
DEFINE g_detail_idx2        LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_wc2_table2   STRING
DEFINE l_ac1                LIKE type_t.num5
DEFINE g_wc3                STRING
DEFINE g_flag               LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_stab_d          DYNAMIC ARRAY OF type_g_stab_d #單身變數
DEFINE g_stab_d_t        type_g_stab_d                  #單身備份
DEFINE g_stab_d_o        type_g_stab_d                  #單身備份
DEFINE g_stab_d_mask_o   DYNAMIC ARRAY OF type_g_stab_d #單身變數
DEFINE g_stab_d_mask_n   DYNAMIC ARRAY OF type_g_stab_d #單身變數
DEFINE g_stab2_d   DYNAMIC ARRAY OF type_g_stab2_d
DEFINE g_stab2_d_t type_g_stab2_d
DEFINE g_stab2_d_o type_g_stab2_d
DEFINE g_stab2_d_mask_o DYNAMIC ARRAY OF type_g_stab2_d
DEFINE g_stab2_d_mask_n DYNAMIC ARRAY OF type_g_stab2_d
 
      
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
 
{<section id="asti205.main" >}
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
   LET g_forupd_sql = "SELECT stat001,stat002,'',stat003 FROM stat_t WHERE statent=? AND stat001=? AND stat002=? AND stat003=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asti205_bcl2 CURSOR FROM g_forupd_sql
   #end add-point 
   LET g_forupd_sql = "SELECT stabstus,stab001,stab002,stab003,stab004,stab005,stab006,stab007,stab008, 
       stab009,stab010,stab011,stab001,stabownid,stabowndp,stabcrtid,stabcrtdp,stabcrtdt,stabmodid,stabmoddt  
       FROM stab_t WHERE stabent=? AND stab001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asti205_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asti205 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asti205_init()   
 
      #進入選單 Menu (="N")
      CALL asti205_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asti205
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asti205.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asti205_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('stat001','6013','11,12,13')
   #end add-point
   
   CALL asti205_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asti205.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asti205_ui_dialog()
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
         CALL g_stab_d.clear()
         CALL g_stab2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL asti205_init()
      END IF
   
      CALL asti205_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stab_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_stab2_d[g_detail_idx].stabownid   #(ver:35)
               LET g_data_dept = g_stab2_d[g_detail_idx].stabowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL asti205_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               LET g_detail_cnt = g_stab_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL asti205_b_fill2()
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_stab2_d TO s_detail2.*
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
   CALL asti205_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_stat_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt2) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 

               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               #add-point:ui_dialog段before display2

               #end add-point
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac1 = g_detail_idx2
               LET g_temp_idx = l_ac1
               
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               LET g_detail_cnt2 = g_stat_d.getLength() 
               DISPLAY g_detail_cnt2 TO FORMONLY.cnt
               CALL cl_show_fld_cont() 
               #add-point:display array-before row

               #end add-point                        
      
            #自訂ACTION(detail_show,page_1)
            
               
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
         ON ACTION delete
            LET g_action_choice="delete"
            CALL asti205_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti205_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asti205_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asti205_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
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
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL asti205_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti205_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL asti205_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti205_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stab_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_stab2_d)
               LET g_export_id[2]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[3] = base.typeInfo.create(g_stat_d)
               LET g_export_id[3]   = "s_detail3"
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
            CALL asti205_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asti205_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asti205_set_pk_array()
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
 
{<section id="asti205.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asti205_query()
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
   CALL g_stab_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON stabstus,stab001,stabl003,stabl004,stab002,stab003,stab004,stab005,stab006, 
          stab007,stab008,stab009,stab010,stab011,stabownid,stabowndp,stabcrtid,stabcrtdp,stabcrtdt, 
          stabmodid,stabmoddt 
 
         FROM s_detail1[1].stabstus,s_detail1[1].stab001,s_detail1[1].stabl003,s_detail1[1].stabl004, 
             s_detail1[1].stab002,s_detail1[1].stab003,s_detail1[1].stab004,s_detail1[1].stab005,s_detail1[1].stab006, 
             s_detail1[1].stab007,s_detail1[1].stab008,s_detail1[1].stab009,s_detail1[1].stab010,s_detail1[1].stab011, 
             s_detail2[1].stabownid,s_detail2[1].stabowndp,s_detail2[1].stabcrtid,s_detail2[1].stabcrtdp, 
             s_detail2[1].stabcrtdt,s_detail2[1].stabmodid,s_detail2[1].stabmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stabcrtdt>>----
         AFTER FIELD stabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stabmoddt>>----
         AFTER FIELD stabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stabcnfdt>>----
         
         #----<<stabpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabstus
            #add-point:BEFORE FIELD stabstus name="query.b.page1.stabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabstus
            
            #add-point:AFTER FIELD stabstus name="query.a.page1.stabstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabstus
            #add-point:ON ACTION controlp INFIELD stabstus name="query.c.page1.stabstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab001
            #add-point:ON ACTION controlp INFIELD stab001 name="construct.c.page1.stab001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " stab001 IN (SELECT stat003 FROM stat_t WHERE statent = '",g_enterprise,"' AND stat001 IN ('11','12','13')) "
            CALL q_stab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stab001  #顯示到畫面上
            NEXT FIELD stab001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab001
            #add-point:BEFORE FIELD stab001 name="query.b.page1.stab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab001
            
            #add-point:AFTER FIELD stab001 name="query.a.page1.stab001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabl003
            #add-point:BEFORE FIELD stabl003 name="query.b.page1.stabl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabl003
            
            #add-point:AFTER FIELD stabl003 name="query.a.page1.stabl003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stabl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabl003
            #add-point:ON ACTION controlp INFIELD stabl003 name="query.c.page1.stabl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabl004
            #add-point:BEFORE FIELD stabl004 name="query.b.page1.stabl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabl004
            
            #add-point:AFTER FIELD stabl004 name="query.a.page1.stabl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stabl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabl004
            #add-point:ON ACTION controlp INFIELD stabl004 name="query.c.page1.stabl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab002
            #add-point:BEFORE FIELD stab002 name="query.b.page1.stab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab002
            
            #add-point:AFTER FIELD stab002 name="query.a.page1.stab002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab002
            #add-point:ON ACTION controlp INFIELD stab002 name="query.c.page1.stab002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab003
            #add-point:BEFORE FIELD stab003 name="query.b.page1.stab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab003
            
            #add-point:AFTER FIELD stab003 name="query.a.page1.stab003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab003
            #add-point:ON ACTION controlp INFIELD stab003 name="query.c.page1.stab003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab004
            #add-point:BEFORE FIELD stab004 name="query.b.page1.stab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab004
            
            #add-point:AFTER FIELD stab004 name="query.a.page1.stab004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab004
            #add-point:ON ACTION controlp INFIELD stab004 name="query.c.page1.stab004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab005
            #add-point:BEFORE FIELD stab005 name="query.b.page1.stab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab005
            
            #add-point:AFTER FIELD stab005 name="query.a.page1.stab005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab005
            #add-point:ON ACTION controlp INFIELD stab005 name="query.c.page1.stab005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab006
            #add-point:BEFORE FIELD stab006 name="query.b.page1.stab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab006
            
            #add-point:AFTER FIELD stab006 name="query.a.page1.stab006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab006
            #add-point:ON ACTION controlp INFIELD stab006 name="query.c.page1.stab006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab007
            #add-point:BEFORE FIELD stab007 name="query.b.page1.stab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab007
            
            #add-point:AFTER FIELD stab007 name="query.a.page1.stab007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab007
            #add-point:ON ACTION controlp INFIELD stab007 name="query.c.page1.stab007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab008
            #add-point:BEFORE FIELD stab008 name="query.b.page1.stab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab008
            
            #add-point:AFTER FIELD stab008 name="query.a.page1.stab008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab008
            #add-point:ON ACTION controlp INFIELD stab008 name="query.c.page1.stab008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab009
            #add-point:BEFORE FIELD stab009 name="query.b.page1.stab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab009
            
            #add-point:AFTER FIELD stab009 name="query.a.page1.stab009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab009
            #add-point:ON ACTION controlp INFIELD stab009 name="query.c.page1.stab009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab010
            #add-point:BEFORE FIELD stab010 name="query.b.page1.stab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab010
            
            #add-point:AFTER FIELD stab010 name="query.a.page1.stab010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab010
            #add-point:ON ACTION controlp INFIELD stab010 name="query.c.page1.stab010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab011
            #add-point:BEFORE FIELD stab011 name="query.b.page1.stab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab011
            
            #add-point:AFTER FIELD stab011 name="query.a.page1.stab011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.stab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab011
            #add-point:ON ACTION controlp INFIELD stab011 name="query.c.page1.stab011"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.stabownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabownid
            #add-point:ON ACTION controlp INFIELD stabownid name="construct.c.page2.stabownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stabownid  #顯示到畫面上
            NEXT FIELD stabownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabownid
            #add-point:BEFORE FIELD stabownid name="query.b.page2.stabownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabownid
            
            #add-point:AFTER FIELD stabownid name="query.a.page2.stabownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stabowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabowndp
            #add-point:ON ACTION controlp INFIELD stabowndp name="construct.c.page2.stabowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stabowndp  #顯示到畫面上
            NEXT FIELD stabowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabowndp
            #add-point:BEFORE FIELD stabowndp name="query.b.page2.stabowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabowndp
            
            #add-point:AFTER FIELD stabowndp name="query.a.page2.stabowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stabcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabcrtid
            #add-point:ON ACTION controlp INFIELD stabcrtid name="construct.c.page2.stabcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stabcrtid  #顯示到畫面上
            NEXT FIELD stabcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabcrtid
            #add-point:BEFORE FIELD stabcrtid name="query.b.page2.stabcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabcrtid
            
            #add-point:AFTER FIELD stabcrtid name="query.a.page2.stabcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stabcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabcrtdp
            #add-point:ON ACTION controlp INFIELD stabcrtdp name="construct.c.page2.stabcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stabcrtdp  #顯示到畫面上
            NEXT FIELD stabcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabcrtdp
            #add-point:BEFORE FIELD stabcrtdp name="query.b.page2.stabcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabcrtdp
            
            #add-point:AFTER FIELD stabcrtdp name="query.a.page2.stabcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabcrtdt
            #add-point:BEFORE FIELD stabcrtdt name="query.b.page2.stabcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.stabmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabmodid
            #add-point:ON ACTION controlp INFIELD stabmodid name="construct.c.page2.stabmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stabmodid  #顯示到畫面上
            NEXT FIELD stabmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabmodid
            #add-point:BEFORE FIELD stabmodid name="query.b.page2.stabmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabmodid
            
            #add-point:AFTER FIELD stabmodid name="query.a.page2.stabmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabmoddt
            #add-point:BEFORE FIELD stabmoddt name="query.b.page2.stabmoddt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_table ON stat001,stat002 
 
         FROM s_detail3[1].stat001,s_detail3[1].stat002
      
         
      
         #---------------------<  Detail: page1  >---------------------
         #----<<stat003>>----
         #Ctrlp:construct.c.page1.stat003
         ON ACTION controlp INFIELD stat002
            #add-point:ON ACTION controlp INFIELD stat003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2060"
            CALL q_oocq002_02()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO stat002    #顯示到畫面上
            NEXT FIELD stat002                       #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD stat001
            #add-point:BEFORE FIELD stat001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stat001
            
            #add-point:AFTER FIELD stat001

            #END add-point
            
         BEFORE FIELD stat002
            #add-point:BEFORE FIELD stat002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stat002
            
            #add-point:AFTER FIELD stat002

            #END add-point
            
 
         #----<<stat003_desc>>----
  
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
      
      END CONSTRUCT    
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
    
   CALL asti205_b_fill(g_wc2)
   LET g_data_owner = g_stab2_d[g_detail_idx].stabownid   #(ver:35)
   LET g_data_dept = g_stab2_d[g_detail_idx].stabowndp   #(ver:35)
 
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
 
{<section id="asti205.insert" >}
#+ 資料新增
PRIVATE FUNCTION asti205_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL asti205_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asti205.modify" >}
#+ 資料修改
PRIVATE FUNCTION asti205_modify()
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
   DEFINE  l_oocqstus             LIKE oocq_t.oocqstus
   DEFINE  l_statcrtdt            DATETIME YEAR TO SECOND
   DEFINE  l_statmoddt            DATETIME YEAR TO SECOND
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
      INPUT ARRAY g_stab_d FROM s_detail1.*
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
               IF NOT cl_null(g_stab_d[l_ac].stab001) THEN
                  CALL n_stabl(g_stab_d[l_ac].stab001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_stab_d[l_ac].stab001
                  CALL ap_ref_array2(g_ref_fields," SELECT stabl003,stabl004 FROM stabl_t WHERE stablent = '"||g_enterprise||"' AND stabl001 = ? AND stabl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_stab_d[l_ac].stabl003 = g_rtn_fields[1]
                  LET g_stab_d[l_ac].stabl004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_stab_d[l_ac].stabl003,g_stab_d[l_ac].stabl004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asti205_b_fill(g_wc2)
            LET g_detail_cnt = g_stab_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            LET g_flag = '1'
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_stab_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_stab_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_stab_d[l_ac].stab001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stab_d_t.* = g_stab_d[l_ac].*  #BACKUP
               LET g_stab_d_o.* = g_stab_d[l_ac].*  #BACKUP
               IF NOT asti205_lock_b("stab_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti205_bcl INTO g_stab_d[l_ac].stabstus,g_stab_d[l_ac].stab001,g_stab_d[l_ac].stab002, 
                      g_stab_d[l_ac].stab003,g_stab_d[l_ac].stab004,g_stab_d[l_ac].stab005,g_stab_d[l_ac].stab006, 
                      g_stab_d[l_ac].stab007,g_stab_d[l_ac].stab008,g_stab_d[l_ac].stab009,g_stab_d[l_ac].stab010, 
                      g_stab_d[l_ac].stab011,g_stab2_d[l_ac].stab001,g_stab2_d[l_ac].stabownid,g_stab2_d[l_ac].stabowndp, 
                      g_stab2_d[l_ac].stabcrtid,g_stab2_d[l_ac].stabcrtdp,g_stab2_d[l_ac].stabcrtdt, 
                      g_stab2_d[l_ac].stabmodid,g_stab2_d[l_ac].stabmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stab_d_t.stab001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stab_d_mask_o[l_ac].* =  g_stab_d[l_ac].*
                  CALL asti205_stab_t_mask()
                  LET g_stab_d_mask_n[l_ac].* =  g_stab_d[l_ac].*
                  
                  CALL asti205_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asti205_set_entry_b(l_cmd)
            CALL asti205_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL asti205_set_entry_b(l_cmd)
            CALL asti205_set_no_entry_b(l_cmd)
            CALL asti205_b_fill2()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.stabl001 = g_stab_d[l_ac].stab001
LET g_detail_multi_table_t.stabl002 = g_dlang
LET g_detail_multi_table_t.stabl003 = g_stab_d[l_ac].stabl003
LET g_detail_multi_table_t.stabl004 = g_stab_d[l_ac].stabl004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'stablent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'stabl001'
            LET l_var_keys[02] = g_stab_d[l_ac].stab001
            LET l_field_keys[03] = 'stabl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'stabl_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stab_d_t.* TO NULL
            INITIALIZE g_stab_d_o.* TO NULL
            INITIALIZE g_stab_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stab2_d[l_ac].stabownid = g_user
      LET g_stab2_d[l_ac].stabowndp = g_dept
      LET g_stab2_d[l_ac].stabcrtid = g_user
      LET g_stab2_d[l_ac].stabcrtdp = g_dept 
      LET g_stab2_d[l_ac].stabcrtdt = cl_get_current()
      LET g_stab2_d[l_ac].stabmodid = g_user
      LET g_stab2_d[l_ac].stabmoddt = cl_get_current()
      LET g_stab_d[l_ac].stabstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_stab_d[l_ac].stabstus = "Y"
      LET g_stab_d[l_ac].stab002 = "N"
      LET g_stab_d[l_ac].stab003 = "N"
      LET g_stab_d[l_ac].stab004 = "N"
      LET g_stab_d[l_ac].stab005 = "N"
      LET g_stab_d[l_ac].stab006 = "N"
      LET g_stab_d[l_ac].stab007 = "N"
      LET g_stab_d[l_ac].stab008 = "N"
      LET g_stab_d[l_ac].stab009 = "N"
      LET g_stab_d[l_ac].stab010 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_stab_d_t.* = g_stab_d[l_ac].*     #新輸入資料
            LET g_stab_d_o.* = g_stab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stab_d[li_reproduce_target].* = g_stab_d[li_reproduce].*
               LET g_stab2_d[li_reproduce_target].* = g_stab2_d[li_reproduce].*
 
               LET g_stab_d[g_stab_d.getLength()].stab001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.stabl001 = g_stab_d[l_ac].stab001
LET g_detail_multi_table_t.stabl002 = g_dlang
LET g_detail_multi_table_t.stabl003 = g_stab_d[l_ac].stabl003
LET g_detail_multi_table_t.stabl004 = g_stab_d[l_ac].stabl004
 
 
            CALL asti205_set_entry_b(l_cmd)
            CALL asti205_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM stab_t 
             WHERE stabent = g_enterprise AND stab001 = g_stab_d[l_ac].stab001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF g_stab_d[l_ac].stab007 = 'N' AND g_stab_d[l_ac].stab008 = 'N' THEN
                  LET g_flag = '2'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00087'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD stab007
               END IF
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stab_d[g_detail_idx].stab001
               CALL asti205_insert_b('stab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_stab_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti205_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_stab_d[l_ac].stab001 = g_detail_multi_table_t.stabl001 AND
         g_stab_d[l_ac].stabl003 = g_detail_multi_table_t.stabl003 AND
         g_stab_d[l_ac].stabl004 = g_detail_multi_table_t.stabl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'stablent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_stab_d[l_ac].stab001
            LET l_field_keys[02] = 'stabl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.stabl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'stabl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.stabl002
            LET l_vars[01] = g_stab_d[l_ac].stabl003
            LET l_fields[01] = 'stabl003'
            LET l_vars[02] = g_stab_d[l_ac].stabl004
            LET l_fields[02] = 'stabl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'stabl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
 
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (stab001 = '", g_stab_d[l_ac].stab001, "' "
 
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
               
               DELETE FROM stab_t
                WHERE stabent = g_enterprise AND 
                      stab001 = g_stab_d_t.stab001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stab_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'stablent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stabl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stabl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stabl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL asti205_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_stab_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE asti205_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_stab_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stab_d_t.stab001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti205_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asti205_delete_b('stab_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_stab_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabstus
            #add-point:BEFORE FIELD stabstus name="input.b.page1.stabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabstus
            
            #add-point:AFTER FIELD stabstus name="input.a.page1.stabstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stabstus
            #add-point:ON CHANGE stabstus name="input.g.page1.stabstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab001
            #add-point:BEFORE FIELD stab001 name="input.b.page1.stab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab001
            
            #add-point:AFTER FIELD stab001 name="input.a.page1.stab001"
            #此段落由子樣板a05產生
            IF  g_stab_d[g_detail_idx].stab001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stab_d[g_detail_idx].stab001 != g_stab_d_t.stab001)) THEN 
                  SELECT COUNT(*) INTO l_n FROM stab_t
                   WHERE stabent = g_enterprise
                     AND stab001 = g_stab_d[g_detail_idx].stab001
                     AND stab001 IN (SELECT DISTINCT stat003 FROM stat_t WHERE statent = g_enterprise AND stat001 IN ('1','2','3','4','5'))
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00094'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_stab_d[g_detail_idx].stab001 = g_stab_d_t.stab001
                     DISPLAY BY NAME g_stab_d[g_detail_idx].stab001
                     NEXT FIELD stab001
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stab_t WHERE "||"stabent = '" ||g_enterprise|| "' AND "||"stab001 = '"||g_stab_d[g_detail_idx].stab001 ||"'",'std-00004',0) THEN
                     LET g_stab_d[g_detail_idx].stab001 = g_stab_d_t.stab001
                     DISPLAY BY NAME g_stab_d[g_detail_idx].stab001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab001
            #add-point:ON CHANGE stab001 name="input.g.page1.stab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabl003
            #add-point:BEFORE FIELD stabl003 name="input.b.page1.stabl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabl003
            
            #add-point:AFTER FIELD stabl003 name="input.a.page1.stabl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stabl003
            #add-point:ON CHANGE stabl003 name="input.g.page1.stabl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stabl004
            #add-point:BEFORE FIELD stabl004 name="input.b.page1.stabl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stabl004
            
            #add-point:AFTER FIELD stabl004 name="input.a.page1.stabl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stabl004
            #add-point:ON CHANGE stabl004 name="input.g.page1.stabl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab002
            #add-point:BEFORE FIELD stab002 name="input.b.page1.stab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab002
            
            #add-point:AFTER FIELD stab002 name="input.a.page1.stab002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab002
            #add-point:ON CHANGE stab002 name="input.g.page1.stab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab003
            #add-point:BEFORE FIELD stab003 name="input.b.page1.stab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab003
            
            #add-point:AFTER FIELD stab003 name="input.a.page1.stab003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab003
            #add-point:ON CHANGE stab003 name="input.g.page1.stab003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab004
            #add-point:BEFORE FIELD stab004 name="input.b.page1.stab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab004
            
            #add-point:AFTER FIELD stab004 name="input.a.page1.stab004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab004
            #add-point:ON CHANGE stab004 name="input.g.page1.stab004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab005
            #add-point:BEFORE FIELD stab005 name="input.b.page1.stab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab005
            
            #add-point:AFTER FIELD stab005 name="input.a.page1.stab005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab005
            #add-point:ON CHANGE stab005 name="input.g.page1.stab005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab006
            #add-point:BEFORE FIELD stab006 name="input.b.page1.stab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab006
            
            #add-point:AFTER FIELD stab006 name="input.a.page1.stab006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab006
            #add-point:ON CHANGE stab006 name="input.g.page1.stab006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab007
            #add-point:BEFORE FIELD stab007 name="input.b.page1.stab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab007
            
            #add-point:AFTER FIELD stab007 name="input.a.page1.stab007"
            IF g_stab_d[l_ac].stab007 = 'Y' AND g_stab_d[l_ac].stab008 = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stab_d[l_ac].stab007 = g_stab_d_t.stab007
               NEXT FIELD stab007
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab007
            #add-point:ON CHANGE stab007 name="input.g.page1.stab007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab008
            #add-point:BEFORE FIELD stab008 name="input.b.page1.stab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab008
            
            #add-point:AFTER FIELD stab008 name="input.a.page1.stab008"
            IF g_stab_d[l_ac].stab007 = 'Y' AND g_stab_d[l_ac].stab008 = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00085'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stab_d[l_ac].stab008 = g_stab_d_t.stab008
               NEXT FIELD stab008
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab008
            #add-point:ON CHANGE stab008 name="input.g.page1.stab008"
            IF g_stab_d[l_ac].stab008 = 'N' THEN
               LET g_stab_d[l_ac].stab009 = 'N'
               DISPLAY BY NAME g_stab_d[l_ac].stab009
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab009
            #add-point:BEFORE FIELD stab009 name="input.b.page1.stab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab009
            
            #add-point:AFTER FIELD stab009 name="input.a.page1.stab009"
            IF g_stab_d[l_ac].stab009 = 'Y' THEN
               IF g_stab_d[l_ac].stab008 <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00086'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stab_d[l_ac].stab009 = g_stab_d_t.stab009
                  DISPLAY BY NAME g_stab_d[l_ac].stab009
                  NEXT FIELD stab009
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab009
            #add-point:ON CHANGE stab009 name="input.g.page1.stab009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab010
            #add-point:BEFORE FIELD stab010 name="input.b.page1.stab010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab010
            
            #add-point:AFTER FIELD stab010 name="input.a.page1.stab010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab010
            #add-point:ON CHANGE stab010 name="input.g.page1.stab010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stab011
            #add-point:BEFORE FIELD stab011 name="input.b.page1.stab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stab011
            
            #add-point:AFTER FIELD stab011 name="input.a.page1.stab011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stab011
            #add-point:ON CHANGE stab011 name="input.g.page1.stab011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.stabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabstus
            #add-point:ON ACTION controlp INFIELD stabstus name="input.c.page1.stabstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab001
            #add-point:ON ACTION controlp INFIELD stab001 name="input.c.page1.stab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stabl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabl003
            #add-point:ON ACTION controlp INFIELD stabl003 name="input.c.page1.stabl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stabl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stabl004
            #add-point:ON ACTION controlp INFIELD stabl004 name="input.c.page1.stabl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab002
            #add-point:ON ACTION controlp INFIELD stab002 name="input.c.page1.stab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab003
            #add-point:ON ACTION controlp INFIELD stab003 name="input.c.page1.stab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab004
            #add-point:ON ACTION controlp INFIELD stab004 name="input.c.page1.stab004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab005
            #add-point:ON ACTION controlp INFIELD stab005 name="input.c.page1.stab005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab006
            #add-point:ON ACTION controlp INFIELD stab006 name="input.c.page1.stab006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab007
            #add-point:ON ACTION controlp INFIELD stab007 name="input.c.page1.stab007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab008
            #add-point:ON ACTION controlp INFIELD stab008 name="input.c.page1.stab008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab009
            #add-point:ON ACTION controlp INFIELD stab009 name="input.c.page1.stab009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab010
            #add-point:ON ACTION controlp INFIELD stab010 name="input.c.page1.stab010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stab011
            #add-point:ON ACTION controlp INFIELD stab011 name="input.c.page1.stab011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE asti205_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_stab_d[l_ac].* = g_stab_d_t.*
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
               LET g_errparam.extend = g_stab_d[l_ac].stab001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_stab_d[l_ac].* = g_stab_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_stab2_d[l_ac].stabmodid = g_user 
LET g_stab2_d[l_ac].stabmoddt = cl_get_current()
LET g_stab2_d[l_ac].stabmodid_desc = cl_get_username(g_stab2_d[l_ac].stabmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               IF g_stab_d[l_ac].stab007 = 'N' AND g_stab_d[l_ac].stab008 = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00087'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD stab007
               ELSE
                  IF g_flag = '2' THEN
                     CALL s_transaction_begin()
                     LET g_stab2_d[l_ac].stabmodid = ""
                     LET g_stab2_d[l_ac].stabmoddt = ""
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_stab_d[g_detail_idx].stab001
                     CALL asti205_insert_b('stab_t',gs_keys,"'1'")
                     LET g_stab_d_t.stab001 = g_stab_d[g_detail_idx].stab001
                  END IF
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL asti205_stab_t_mask_restore('restore_mask_o')
 
               UPDATE stab_t SET (stabstus,stab001,stab002,stab003,stab004,stab005,stab006,stab007,stab008, 
                   stab009,stab010,stab011,stabownid,stabowndp,stabcrtid,stabcrtdp,stabcrtdt,stabmodid, 
                   stabmoddt) = (g_stab_d[l_ac].stabstus,g_stab_d[l_ac].stab001,g_stab_d[l_ac].stab002, 
                   g_stab_d[l_ac].stab003,g_stab_d[l_ac].stab004,g_stab_d[l_ac].stab005,g_stab_d[l_ac].stab006, 
                   g_stab_d[l_ac].stab007,g_stab_d[l_ac].stab008,g_stab_d[l_ac].stab009,g_stab_d[l_ac].stab010, 
                   g_stab_d[l_ac].stab011,g_stab2_d[l_ac].stabownid,g_stab2_d[l_ac].stabowndp,g_stab2_d[l_ac].stabcrtid, 
                   g_stab2_d[l_ac].stabcrtdp,g_stab2_d[l_ac].stabcrtdt,g_stab2_d[l_ac].stabmodid,g_stab2_d[l_ac].stabmoddt) 
 
                WHERE stabent = g_enterprise AND
                  stab001 = g_stab_d_t.stab001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stab_d[g_detail_idx].stab001
               LET gs_keys_bak[1] = g_stab_d_t.stab001
               CALL asti205_update_b('stab_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_stab_d[l_ac].stab001 = g_detail_multi_table_t.stabl001 AND
         g_stab_d[l_ac].stabl003 = g_detail_multi_table_t.stabl003 AND
         g_stab_d[l_ac].stabl004 = g_detail_multi_table_t.stabl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'stablent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_stab_d[l_ac].stab001
            LET l_field_keys[02] = 'stabl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.stabl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'stabl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.stabl002
            LET l_vars[01] = g_stab_d[l_ac].stabl003
            LET l_fields[01] = 'stabl003'
            LET l_vars[02] = g_stab_d[l_ac].stabl004
            LET l_fields[02] = 'stabl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'stabl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_stab_d_t)
                     LET g_log2 = util.JSON.stringify(g_stab_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asti205_stab_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               UPDATE stat_t SET (stat003,statownid,statowndp,statcrtid,statcrtdp,statcrtdt, 
                   statmodid,statmoddt) = (g_stab_d[l_ac].stab001,g_stab2_d[l_ac].stabownid,g_stab2_d[l_ac].stabowndp,g_stab2_d[l_ac].stabcrtid,g_stab2_d[l_ac].stabcrtdp, 
                   g_stab2_d[l_ac].stabcrtdt,g_stab2_d[l_ac].stabmodid,g_stab2_d[l_ac].stabmoddt)
                WHERE statent = g_enterprise  
                  AND stat003 = g_stab_d_t.stab001
               IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "stat_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asti205_unlock_b("stab_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stab_d[l_ac].* = g_stab_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            CALL cl_multitable_unlock()
             #add-point:單身after row name="input.body.a_row"
            IF g_flag = '2' THEN
               IF g_stab_d[l_ac].stab007 = 'N' AND g_stab_d[l_ac].stab008 = 'N' THEN
                  NEXT FIELD stab007
               END IF
            END IF
            IF l_cmd = 'a' THEN
               IF g_flag = '2' THEN
                  IF l_ac = 1 THEN
                     LET g_stab2_d[l_ac].stabmodid = ""
                     LET g_stab2_d[l_ac].stabmoddt = ""
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_stab_d[g_detail_idx].stab001
                     CALL asti205_insert_b('stab_t',gs_keys,"'1'")
                  END IF
               END IF
               NEXT FIELD stat001
            END IF
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
               LET g_stab_d[li_reproduce_target].* = g_stab_d[li_reproduce].*
               LET g_stab2_d[li_reproduce_target].* = g_stab2_d[li_reproduce].*
 
               LET g_stab_d[li_reproduce_target].stab001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stab_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stab_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_stab2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL asti205_b_fill(g_wc2)
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
      INPUT ARRAY g_stat_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_detail_cnt2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stat_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
           LET g_detail_cnt2 = g_stat_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac = g_detail_idx2 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_stat_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt2 = g_stat_d.getLength()
            
            IF g_detail_cnt2 >= l_ac 
               AND g_stat_d[l_ac].stat001 IS NOT NULL
               AND g_stat_d[l_ac].stat002 IS NOT NULL
               AND g_stat_d[l_ac].stat003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stat_d_t.* = g_stat_d[l_ac].*  #BACKUP
               IF NOT asti205_lock_b1("stat_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti205_bcl2 INTO g_stat_d[l_ac].stat001,g_stat_d[l_ac].stat002,g_stat_d[l_ac].stat002_desc, 
                      g_stat_d[l_ac].stat003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_stat_d_t.stat001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL asti205_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd = 'u' THEN
               CALL asti205_b_fill2()
            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stat_d_t.* TO NULL
            INITIALIZE g_stat_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #此段落由子樣板a14產生
 
            LET g_stat_d_t.* = g_stat_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asti205_set_entry_b("a")
            CALL asti205_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stat_d[li_reproduce_target].* = g_stat_d[li_reproduce].*
 
               LET g_stat_d[g_stat_d.getLength()].stat001 = NULL
               LET g_stat_d[g_stat_d.getLength()].stat002 = NULL
               LET g_stat_d[g_stat_d.getLength()].stat003 = NULL
 
            END IF
            
            #add-point:modify段before insert
            LET g_stat_d[l_ac].stat001 = '11'
            LET g_stat_d[l_ac].stat003 = g_stab_d[g_detail_idx].stab001
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM stat_t 
             WHERE statent = g_enterprise AND stat001 = g_stat_d[l_ac].stat001
                                       AND stat002 = g_stat_d[l_ac].stat002
                                       AND stat003 = g_stat_d[l_ac].stat003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_stat_d[g_detail_idx2].stat001
#               LET gs_keys[2] = g_stat_d[g_detail_idx2].stat002
#               LET gs_keys[3] = g_stat_d[g_detail_idx2].stat003
#               CALL asti205_insert_b('stat_t',gs_keys,"'1'")
               LET l_statcrtdt = cl_get_current()
               INSERT INTO stat_t
                  (statent,stat001,stat002,stat003,statownid,statowndp,statcrtid,statcrtdp,statcrtdt,statmodid,statmoddt) 
               VALUES(g_enterprise,g_stat_d[l_ac].stat001,g_stat_d[l_ac].stat002,g_stat_d[l_ac].stat003, 
                      g_user,g_dept,g_user,g_dept,l_statcrtdt,"","")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_stat_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stat_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti205_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt2 = g_detail_cnt2 + 1
               
#               LET g_wc2 = g_wc2, " OR (stat001 = '", g_stat_d[l_ac].stat001, "' "
#                                  ," AND stat002 = '", g_stat_d[l_ac].stat002, "' "
#                                  ," AND stat003 = '", g_stat_d[l_ac].stat003, "' "
# 
#                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_stat_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_stat_d.deleteElement(l_ac)
               NEXT FIELD stat001
            END IF
            IF g_stat_d[l_ac].stat001 IS NOT NULL
               AND g_stat_d[l_ac].stat002 IS NOT NULL
               AND g_stat_d_t.stat003 IS NOT NULL
 
               THEN     
            
               #add-point:單身刪除ask前

               #end add-point   
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前

               #end add-point   
               
               DELETE FROM stat_t
                WHERE statent = g_enterprise AND 
                      stat001 = g_stat_d_t.stat001
                      AND stat002 = g_stat_d_t.stat002
                      AND stat003 = g_stat_d_t.stat003
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stat_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt2 = g_detail_cnt2-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE asti205_bcl2
               LET l_count = g_stat_d.getLength()
            END IF
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
 
         #---------------------<  Detail: page1  >---------------------
         #----<<stat001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD stat001
            #add-point:BEFORE FIELD stat001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD stat001
            
            #add-point:AFTER FIELD stat001
            IF g_stat_d[l_ac].stat001 IS NOT NULL AND g_stat_d[l_ac].stat002 IS NOT NULL AND g_stat_d[l_ac].stat003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stat_d[l_ac].stat001 != g_stat_d_t.stat001 OR g_stat_d[l_ac].stat002 != g_stat_d_t.stat002 OR g_stat_d[l_ac].stat003 != g_stat_d_t.stat003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stat_t WHERE "||"statent = '" ||g_enterprise|| "' AND "||"stat001 = '"||g_stat_d[l_ac].stat001 ||"' AND "|| "stat002 = '"||g_stat_d[l_ac].stat002 ||"' AND "|| "stat003 = '"||g_stat_d[l_ac].stat003 ||"'",'std-00004',0) THEN
                     LET g_stat_d[l_ac].stat001 = g_stat_d_t.stat001
                     DISPLAY BY NAME g_stat_d[l_ac].stat001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF l_ac = 1 THEN
               NEXT FIELD stat002
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE stat001
            #add-point:ON CHANGE stat001

            #END add-point
 
         #----<<stat002>>----
         #此段落由子樣板a02產生
         AFTER FIELD stat002
            
            #add-point:AFTER FIELD stat002
            IF g_stat_d[l_ac].stat001 IS NOT NULL AND g_stat_d[l_ac].stat002 IS NOT NULL AND g_stat_d[l_ac].stat003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stat_d[l_ac].stat001 != g_stat_d_t.stat001 OR g_stat_d[l_ac].stat002 != g_stat_d_t.stat002 OR g_stat_d[l_ac].stat003 != g_stat_d_t.stat003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stat_t WHERE "||"statent = '" ||g_enterprise|| "' AND "||"stat001 = '"||g_stat_d[l_ac].stat001 ||"' AND "|| "stat002 = '"||g_stat_d[l_ac].stat002 ||"' AND "|| "stat003 = '"||g_stat_d[l_ac].stat003 ||"'",'std-00004',0) THEN
                     LET g_stat_d[l_ac].stat002 = g_stat_d_t.stat002
                     LET g_stat_d[l_ac].stat002_desc = ''
                     DISPLAY BY NAME g_stat_d[l_ac].stat002,g_stat_d[l_ac].stat002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_stat_d[l_ac].stat002) THEN
               SELECT COUNT(*) INTO l_n
                 FROM oocq_t
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2060'
                  AND oocq002 = g_stat_d[l_ac].stat002
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00005'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stat_d[l_ac].stat002 = g_stat_d_t.stat002
                  LET g_stat_d[l_ac].stat002_desc = ''
                  DISPLAY BY NAME g_stat_d[l_ac].stat002,g_stat_d[l_ac].stat002_desc
                  NEXT FIELD stat002
               END IF
               SELECT oocqstus INTO l_oocqstus
                 FROM oocq_t
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2060'
                  AND oocq002 = g_stat_d[l_ac].stat002
               IF l_oocqstus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00006'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stat_d[l_ac].stat002 = g_stat_d_t.stat002
                  LET g_stat_d[l_ac].stat002_desc = ''
                  DISPLAY BY NAME g_stat_d[l_ac].stat002,g_stat_d[l_ac].stat002_desc
                  NEXT FIELD stat002
               END IF
            END IF
            IF l_ac = 1 AND cl_null(g_stat_d[l_ac].stat002) THEN
               NEXT FIELD stat002
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = '2060'
            LET g_ref_fields[2] = g_stat_d[l_ac].stat002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stat_d[l_ac].stat002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stat_d[l_ac].stat002_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stat002
            #add-point:BEFORE FIELD stat002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stat002
            #add-point:ON CHANGE stat002

            #END add-point
 
         #----<<stat002_desc>>----
         #----<<stat003>>----
         #此段落由子樣板a02產生
         AFTER FIELD stat003
            
            #add-point:AFTER FIELD stat003                      
            #此段落由子樣板a05產生

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD stat003
            #add-point:BEFORE FIELD stat003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE stat003
            #add-point:ON CHANGE stat003

            #END add-point
 
         #----<<stat003_desc>>----
 
         #---------------------<  Detail: page1  >---------------------
         #----<<stat001>>----
         #Ctrlp:input.c.page1.stat001
         ON ACTION controlp INFIELD stat001
            #add-point:ON ACTION controlp INFIELD stat001

            #END add-point
 
         #----<<stat002>>----
         #Ctrlp:input.c.page1.stat002
         ON ACTION controlp INFIELD stat002
            #add-point:ON ACTION controlp INFIELD stat002
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stat_d[l_ac].stat002             #給予default值
            LET g_qryparam.default2 = g_stat_d[l_ac].stat002_desc #說明
            #給予arg
            LET g_qryparam.arg1 = "2060" #

            
            CALL q_oocq002_02()                                #呼叫開窗

            LET g_stat_d[l_ac].stat002 = g_qryparam.return1              
            LET g_stat_d[l_ac].stat002_desc = g_qryparam.return2  
            DISPLAY g_stat_d[l_ac].stat002 TO stat002              #
            DISPLAY g_stat_d[l_ac].stat002_desc TO stat002_desc #說明
            NEXT FIELD stat002                        #返回原欄位
            #END add-point
 
         #----<<stat002_desc>>----
         #----<<stat003>>----
         #Ctrlp:input.c.page1.stat003
         ON ACTION controlp INFIELD stat003
            #add-point:ON ACTION controlp INFIELD stat003
            #此段落由子樣板a07產生            
#            #開窗i段


            #END add-point
 
         #----<<stat003_desc>>----
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_stat_d[l_ac].* = g_stat_d_t.*
               CLOSE asti205_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_stat_d[l_ac].stat001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_stat_d[l_ac].* = g_stat_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               #寫入修改者/修改日期資訊(單身)
               LET l_statmoddt = cl_get_current()
               #add-point:單身修改前

               #end add-point
               
               UPDATE stat_t SET (stat001,stat002,statmodid,statmoddt) = 
                  (g_stat_d[l_ac].stat001,g_stat_d[l_ac].stat002,g_user,l_statmoddt)
                WHERE statent = g_enterprise AND
                  stat001 = g_stat_d_t.stat001 #項次   
                  AND stat002 = g_stat_d_t.stat002  
                  AND stat003 = g_stat_d_t.stat003  
 
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "stat_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "stat_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CLOSE asti205_bcl2
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_stat_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_stat_d.getLength()+1
            
      END INPUT
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
               NEXT FIELD stabstus
            WHEN "s_detail2"
               NEXT FIELD stab001_2
 
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
      IF INT_FLAG OR cl_null(g_stab_d[g_detail_idx].stab001) THEN
         CALL g_stab_d.deleteElement(g_detail_idx)
         CALL g_stab2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_stab_d[g_detail_idx].* = g_stab_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   IF INT_FLAG = TRUE THEN
      DELETE FROM stab_t
       WHERE stabent = g_enterprise
         AND stab001 = g_stab_d[g_detail_idx].stab001
         AND stab001 NOT IN (SELECT stat003 FROM stat_t WHERE statent = g_enterprise)
   END IF
   #end add-point
 
   CLOSE asti205_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="asti205.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asti205_delete()
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
   FOR li_idx = 1 TO g_stab_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT asti205_lock_b("stab_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("stab_t","stabownid") THEN
            LET g_data_owner = g_stab2_d[g_detail_idx].stabownid
            LET g_data_dept = g_stab2_d[g_detail_idx].stabowndp
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
   
   FOR li_idx = 1 TO g_stab_d.getLength()
      IF g_stab_d[li_idx].stab001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM stab_t
          WHERE stabent = g_enterprise AND 
                stab001 = g_stab_d[li_idx].stab001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.stabl001 = g_stab_d[l_ac].stab001
LET g_detail_multi_table_t.stabl002 = g_dlang
LET g_detail_multi_table_t.stabl003 = g_stab_d[l_ac].stabl003
LET g_detail_multi_table_t.stabl004 = g_stab_d[l_ac].stabl004
 
 
            
LET g_detail_multi_table_t.stabl001 = g_stab_d[l_ac].stab001
LET g_detail_multi_table_t.stabl002 = g_dlang
LET g_detail_multi_table_t.stabl003 = g_stab_d[l_ac].stabl003
LET g_detail_multi_table_t.stabl004 = g_stab_d[l_ac].stabl004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'stablent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stabl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stabl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stabl_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'stablent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stabl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stabl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stabl_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stab_d_t.stab001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL asti205_delete_b('stab_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti205_set_pk_array()
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
   CALL asti205_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="asti205.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asti205_b_fill(p_wc2)              #BODY FILL UP
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
   IF cl_null(g_wc_table) THEN
      LET g_wc_table = " 1=1"
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   LET p_wc2 = p_wc2," AND ",g_wc3
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.stabstus,t0.stab001,t0.stab002,t0.stab003,t0.stab004,t0.stab005, 
       t0.stab006,t0.stab007,t0.stab008,t0.stab009,t0.stab010,t0.stab011,t0.stab001,t0.stabownid,t0.stabowndp, 
       t0.stabcrtid,t0.stabcrtdp,t0.stabcrtdt,t0.stabmodid,t0.stabmoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 FROM stab_t t0",
               " LEFT JOIN stabl_t ON stablent = "||g_enterprise||" AND stab001 = stabl001 AND stabl002 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.stabownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.stabowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.stabcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.stabcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.stabmodid  ",
 
               " WHERE t0.stabent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("stab_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND stabowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("stab_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND stabownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   #150204-00001#49--add by dongsz--str---
   LET g_wc_table = g_wc_table," AND stat001 IN ('11','12','13') "
   LET g_sql = g_sql," AND stab001 IN (SELECT stat003 FROM stat_t WHERE ",g_wc_table," AND statent = '",g_enterprise,"')" #160905-00007#15 by 08172 add ent
   #150204-00001#49--add by dongsz--end---
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("stab_t"),
                      " ORDER BY t0.stab001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   #150204-00001#49--mark by dongsz--str---
#   LET g_wc_table = g_wc_table," AND stat001 IN ('11','12','13') "
#   LET g_sql = "SELECT  UNIQUE stabstus,stab001,stab002,stab003,stab004,stab005,stab006,stab007,stab008, 
#       stab009,stab010,stab011,stab001,stabownid,stabowndp,stabcrtid,stabcrtdp,stabcrtdt,stabmodid,stabmoddt , 
#       t1.oofa011 ,t2.ooefl003 ,t3.oofa011 ,t4.ooefl003 ,t5.oofa011 FROM stab_t",
#               " LEFT JOIN stabl_t ON stab001 = stabl001 AND stabl002 = '",g_lang,"'",
#                              " LEFT JOIN oofa_t t1 ON t1.oofaent='"||g_enterprise||"' AND t1.oofa002='2' AND t1.oofa003=stabownid  ",
#               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=stabowndp AND t2.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN oofa_t t3 ON t3.oofaent='"||g_enterprise||"' AND t3.oofa002='2' AND t3.oofa003=stabcrtid  ",
#               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=stabcrtdp AND t4.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa002='2' AND t5.oofa003=stabmodid  ",
#               " WHERE stabent= ? AND 1=1 AND (", p_wc2,") AND stab001 IN (SELECT stat003 FROM stat_t WHERE ",g_wc_table,")"
#   LET g_sql = g_sql, cl_sql_add_filter("stab_t"),
#                      " ORDER BY stab_t.stab001"
   #150204-00001#49--mark by dongsz--end---
   CALL g_stat_d.clear()
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"stab_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asti205_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asti205_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stab_d.clear()
   CALL g_stab2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_stab_d[l_ac].stabstus,g_stab_d[l_ac].stab001,g_stab_d[l_ac].stab002,g_stab_d[l_ac].stab003, 
       g_stab_d[l_ac].stab004,g_stab_d[l_ac].stab005,g_stab_d[l_ac].stab006,g_stab_d[l_ac].stab007,g_stab_d[l_ac].stab008, 
       g_stab_d[l_ac].stab009,g_stab_d[l_ac].stab010,g_stab_d[l_ac].stab011,g_stab2_d[l_ac].stab001, 
       g_stab2_d[l_ac].stabownid,g_stab2_d[l_ac].stabowndp,g_stab2_d[l_ac].stabcrtid,g_stab2_d[l_ac].stabcrtdp, 
       g_stab2_d[l_ac].stabcrtdt,g_stab2_d[l_ac].stabmodid,g_stab2_d[l_ac].stabmoddt,g_stab2_d[l_ac].stabownid_desc, 
       g_stab2_d[l_ac].stabowndp_desc,g_stab2_d[l_ac].stabcrtid_desc,g_stab2_d[l_ac].stabcrtdp_desc, 
       g_stab2_d[l_ac].stabmodid_desc
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
      
      CALL asti205_detail_show()      
 
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
   
 
   
   CALL g_stab_d.deleteElement(g_stab_d.getLength())   
   CALL g_stab2_d.deleteElement(g_stab2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_stab_d.getLength()
      LET g_stab2_d[l_ac].stab001 = g_stab_d[l_ac].stab001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_stab_d.getLength() THEN
      LET l_ac = g_stab_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_stab_d.getLength()
      LET g_stab_d_mask_o[l_ac].* =  g_stab_d[l_ac].*
      CALL asti205_stab_t_mask()
      LET g_stab_d_mask_n[l_ac].* =  g_stab_d[l_ac].*
   END FOR
   
   LET g_stab2_d_mask_o.* =  g_stab2_d.*
   FOR l_ac = 1 TO g_stab2_d.getLength()
      LET g_stab2_d_mask_o[l_ac].* =  g_stab2_d[l_ac].*
      CALL asti205_stab_t_mask()
      LET g_stab2_d_mask_n[l_ac].* =  g_stab2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   IF g_stab_d.getLength() > 0 THEN
      LET g_detail_idx = 1
      CALL asti205_b_fill2()
   END IF
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_stab_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE asti205_pb
   
END FUNCTION
 
{</section>}
 
{<section id="asti205.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asti205_detail_show()
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
   LET g_ref_fields[1] = g_stab_d[l_ac].stab001
   CALL ap_ref_array2(g_ref_fields," SELECT stabl003,stabl004 FROM stabl_t WHERE stablent = '"||g_enterprise||"' AND stabl001 = ? AND stabl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stab_d[l_ac].stabl003 = g_rtn_fields[1]
   LET g_stab_d[l_ac].stabl004 = g_rtn_fields[2]
   DISPLAY BY NAME g_stab_d[l_ac].stabl003,g_stab_d[l_ac].stabl004
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
 
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asti205.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asti205_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("stab001",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="asti205.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asti205_set_no_entry_b(p_cmd)                                               
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
      CALL cl_set_comp_entry("stab001",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="asti205.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asti205_default_search()
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
      LET ls_wc = ls_wc, " stab001 = '", g_argv[01], "' AND "
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
 
{<section id="asti205.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asti205_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "stab_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'stab_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM stab_t
          WHERE stabent = g_enterprise AND
            stab001 = ps_keys_bak[1]
         
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
         CALL g_stab_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_stab2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      DELETE FROM stat_t
       WHERE statent = g_enterprise
         AND stat003 = ps_keys_bak[1]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti205.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asti205_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "stab_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO stab_t
                  (stabent,
                   stab001
                   ,stabstus,stab002,stab003,stab004,stab005,stab006,stab007,stab008,stab009,stab010,stab011,stabownid,stabowndp,stabcrtid,stabcrtdp,stabcrtdt,stabmodid,stabmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_stab_d[l_ac].stabstus,g_stab_d[l_ac].stab002,g_stab_d[l_ac].stab003,g_stab_d[l_ac].stab004, 
                       g_stab_d[l_ac].stab005,g_stab_d[l_ac].stab006,g_stab_d[l_ac].stab007,g_stab_d[l_ac].stab008, 
                       g_stab_d[l_ac].stab009,g_stab_d[l_ac].stab010,g_stab_d[l_ac].stab011,g_stab2_d[l_ac].stabownid, 
                       g_stab2_d[l_ac].stabowndp,g_stab2_d[l_ac].stabcrtid,g_stab2_d[l_ac].stabcrtdp, 
                       g_stab2_d[l_ac].stabcrtdt,g_stab2_d[l_ac].stabmodid,g_stab2_d[l_ac].stabmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
 
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti205.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asti205_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "stab_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "stab_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE stab_t 
         SET (stab001
              ,stabstus,stab002,stab003,stab004,stab005,stab006,stab007,stab008,stab009,stab010,stab011,stabownid,stabowndp,stabcrtid,stabcrtdp,stabcrtdt,stabmodid,stabmoddt) 
              = 
             (ps_keys[1]
              ,g_stab_d[l_ac].stabstus,g_stab_d[l_ac].stab002,g_stab_d[l_ac].stab003,g_stab_d[l_ac].stab004, 
                  g_stab_d[l_ac].stab005,g_stab_d[l_ac].stab006,g_stab_d[l_ac].stab007,g_stab_d[l_ac].stab008, 
                  g_stab_d[l_ac].stab009,g_stab_d[l_ac].stab010,g_stab_d[l_ac].stab011,g_stab2_d[l_ac].stabownid, 
                  g_stab2_d[l_ac].stabowndp,g_stab2_d[l_ac].stabcrtid,g_stab2_d[l_ac].stabcrtdp,g_stab2_d[l_ac].stabcrtdt, 
                  g_stab2_d[l_ac].stabmodid,g_stab2_d[l_ac].stabmoddt) 
         WHERE stabent = g_enterprise AND stab001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stab_t:",SQLERRMESSAGE 
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
 
{<section id="asti205.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asti205_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL asti205_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "stab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asti205_bcl USING g_enterprise,
                                       g_stab_d[g_detail_idx].stab001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asti205_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asti205.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asti205_unlock_b(ps_table)
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
      CLOSE asti205_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti205.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION asti205_modify_detail_chk(ps_record)
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
         LET ls_return = "stabstus"
      WHEN "s_detail2"
         LET ls_return = "stab001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="asti205.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION asti205_show_ownid_msg()
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
 
{<section id="asti205.mask_functions" >}
&include "erp/ast/asti205_mask.4gl"
 
{</section>}
 
{<section id="asti205.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asti205_set_pk_array()
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
   LET g_pk_array[1].values = g_stab_d[l_ac].stab001
   LET g_pk_array[1].column = 'stab001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti205.state_change" >}
   
 
{</section>}
 
{<section id="asti205.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="asti205.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 顯示第二單身
# Date & Author..: 20140606 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION asti205_b_fill2()
DEFINE li_ac           LIKE type_t.num5

   CALL g_stat_d.clear()

   #判定單頭是否有資料
   IF cl_null(g_stab_d[g_detail_idx].stab001) THEN
      RETURN
   END IF
   
   LET li_ac = l_ac1
   
   LET g_sql = "SELECT  UNIQUE stat001,stat002,'',stat003 FROM stat_t",
               " WHERE statent=? AND stat003=? "
   IF NOT cl_null(g_wc2_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY stat_t.stat001" 
   
   PREPARE sel_stat_pre FROM g_sql
   DECLARE sel_stat_cs  CURSOR FOR sel_stat_pre
   
   OPEN sel_stat_cs USING g_enterprise,g_stab_d[g_detail_idx].stab001
   
   LET l_ac1 = 1
   FOREACH sel_stat_cs INTO g_stat_d[l_ac1].stat001,g_stat_d[l_ac1].stat002,g_stat_d[l_ac1].stat002_desc, 
       g_stat_d[l_ac1].stat003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      #說明欄位      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_stat_d[l_ac1].stat003
#      CALL ap_ref_array2(g_ref_fields,"SELECT stabl003 FROM stabl_t WHERE stablent='"||g_enterprise||"' AND stabl001=? AND stabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_stat_d[l_ac1].stat003_2_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_stat_d[l_ac1].stat003_2_desc
      
      CALL asti205_detail_show1()
   
      LET l_ac1 = l_ac1 + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_stat_d.deleteElement(g_stat_d.getLength())
   
   LET l_ac1 = li_ac

END FUNCTION

################################################################################
# Descriptions...: 说明欄位
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asti205_detail_show1()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '2060'
   LET g_ref_fields[2] = g_stat_d[l_ac1].stat002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stat_d[l_ac1].stat002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stat_d[l_ac1].stat002_desc

END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION asti205_lock_b1(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL asti205_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "stat_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asti205_bcl2 USING g_enterprise,
                                       g_stat_d[g_detail_idx2].stat001,g_stat_d[g_detail_idx2].stat002, 
                                           g_stab_d[g_detail_idx].stab001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "asti205_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
END FUNCTION

 
{</section>}
 