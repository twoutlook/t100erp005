#該程式未解開Section, 採用最新樣板產出!
{<section id="apri020.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-05-25 12:50:37), PR版次:0005(2016-09-05 19:42:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000164
#+ Filename...: apri020
#+ Description: 促銷策略維護作業
#+ Creator....: 03247(2014-02-27 17:21:31)
#+ Modifier...: 06189 -SD/PR- 01727
 
{</section>}
 
{<section id="apri020.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#11  2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
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
PRIVATE TYPE type_g_praa_d RECORD
       praastus LIKE praa_t.praastus, 
   praa000 LIKE praa_t.praa000, 
   praa001 LIKE praa_t.praa001, 
   praa002 LIKE praa_t.praa002, 
   praaunit LIKE praa_t.praaunit
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_prab_d RECORD
       prabstus LIKE prab_t.prabstus, 
   prab000 LIKE prab_t.prab000,     #150420-00008#1 150421 by geza add
   prab001 LIKE prab_t.prab001, 
   prab002 LIKE prab_t.prab002, 
   prabunit LIKE prab_t.prabunit
       END RECORD
       
DEFINE g_prab_d          DYNAMIC ARRAY OF type_g_prab_d
DEFINE g_prab_d_t        type_g_prab_d
DEFINE g_prab_d_o        type_g_prab_d
DEFINE g_wc3                STRING
DEFINE g_temp_idx1           LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_detail_idx1         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt1         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_praa_d_old       type_g_praa_d                  #單身備份
DEFINE g_prab_d_old       type_g_prab_d                  #單身備份
#end add-point
 
#模組變數(Module Variables)
DEFINE g_praa_d          DYNAMIC ARRAY OF type_g_praa_d #單身變數
DEFINE g_praa_d_t        type_g_praa_d                  #單身備份
DEFINE g_praa_d_o        type_g_praa_d                  #單身備份
DEFINE g_praa_d_mask_o   DYNAMIC ARRAY OF type_g_praa_d #單身變數
DEFINE g_praa_d_mask_n   DYNAMIC ARRAY OF type_g_praa_d #單身變數
 
      
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
 
{<section id="apri020.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT praastus,praa000,praa001,praa002,praaunit FROM praa_t WHERE praaent=?  
       AND praa001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apri020_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apri020 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apri020_init()   
 
      #進入選單 Menu (="N")
      CALL apri020_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apri020
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apri020.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apri020_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('praa001','6027') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_flag = 'N'
   CALL cl_set_combo_scc('prab001','6027') 
   CALL cl_set_combo_scc('prab002','6027')
   #150420-00008#1 150421 by geza add---(S) 
   CALL cl_set_combo_scc('praa000','6782') 
   CALL cl_set_combo_scc('prab000','6782') 
   #150420-00008#1 150421 by geza add---(E) 
   #end add-point
   
   CALL apri020_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="apri020.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION apri020_ui_dialog()
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
   LET g_detail_idx1 = 1
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_praa_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL apri020_init()
      END IF
   
      CALL apri020_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_praa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL apri020_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_prab_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt1) 
      
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
      
            BEFORE ROW
               LET g_detail_idx1 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx1
               LET g_temp_idx1 = l_ac
               
               DISPLAY g_detail_idx1 TO FORMONLY.idx1
               CALL cl_show_fld_cont() 
               
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
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            IF g_temp_idx1 > 0 THEN
               LET l_ac = g_temp_idx1
               CALL DIALOG.setCurrentRow("s_detail2",l_ac)
               LET g_temp_idx1 = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL apri020_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL apri020_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL apri020_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL apri020_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL apri020_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL apri020_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apri020_insert()
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
               CALL apri020_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_praa_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_prab_d)
               LET g_export_id[2]   = "s_detail2"
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
            CALL apri020_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apri020_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apri020_set_pk_array()
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
 
{<section id="apri020.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apri020_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE ls_wc1     LIKE type_t.chr500
   
   LET ls_wc1 = g_wc3
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_praa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON praastus,praa000,praa001,praa002,praaunit 
 
         FROM s_detail1[1].praastus,s_detail1[1].praa000,s_detail1[1].praa001,s_detail1[1].praa002,s_detail1[1].praaunit  
 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<praacrtdt>>----
 
         #----<<praamoddt>>----
         
         #----<<praacnfdt>>----
         
         #----<<praapstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praastus
            #add-point:BEFORE FIELD praastus name="query.b.page1.praastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praastus
            
            #add-point:AFTER FIELD praastus name="query.a.page1.praastus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.praastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praastus
            #add-point:ON ACTION controlp INFIELD praastus name="query.c.page1.praastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praa000
            #add-point:BEFORE FIELD praa000 name="query.b.page1.praa000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praa000
            
            #add-point:AFTER FIELD praa000 name="query.a.page1.praa000"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.praa000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praa000
            #add-point:ON ACTION controlp INFIELD praa000 name="query.c.page1.praa000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praa001
            #add-point:BEFORE FIELD praa001 name="query.b.page1.praa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praa001
            
            #add-point:AFTER FIELD praa001 name="query.a.page1.praa001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.praa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praa001
            #add-point:ON ACTION controlp INFIELD praa001 name="query.c.page1.praa001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praa002
            #add-point:BEFORE FIELD praa002 name="query.b.page1.praa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praa002
            
            #add-point:AFTER FIELD praa002 name="query.a.page1.praa002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.praa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praa002
            #add-point:ON ACTION controlp INFIELD praa002 name="query.c.page1.praa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praaunit
            #add-point:BEFORE FIELD praaunit name="query.b.page1.praaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praaunit
            
            #add-point:AFTER FIELD praaunit name="query.a.page1.praaunit"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.praaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praaunit
            #add-point:ON ACTION controlp INFIELD praaunit name="query.c.page1.praaunit"
            
            #END add-point
 
 
  
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc3 ON prabstus,prab001,prab002,prabunit,prab000    #150420-00008#1 150421 by geza
 
         FROM s_detail2[1].prabstus,s_detail2[1].prab001,s_detail2[1].prab002,s_detail2[1].prabunit,s_detail2[1].prab000     #150420-00008#1 150421 by geza
           
         #---------------------<  Detail: page2  >---------------------
            
         BEFORE CONSTRUCT
#saki            CALL cl_qbe_init()
            #add-point:cs段more_construct

            #end add-point 
      
         ON ACTION qbe_select
#saki            CALL cl_qbe_select()
      
         ON ACTION qbe_save
#saki            CALL cl_qbe_save()
      
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
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc3 = ls_wc1
   END IF
   IF NOT cl_null(g_wc3) OR g_wc3 <> ' 1=1' THEN
      CALL apri020_b1_fill(g_wc3)
      LET g_flag = 'Y'
   END IF
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
    
   CALL apri020_b_fill(g_wc2)
 
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
 
{<section id="apri020.insert" >}
#+ 資料新增
PRIVATE FUNCTION apri020_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL apri020_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apri020.modify" >}
#+ 資料修改
PRIVATE FUNCTION apri020_modify()
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
   DEFINE l_msg      STRING 
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
   LET g_forupd_sql = "SELECT prabstus,prab000,prab001,prab002,prabunit FROM prab_t WHERE prabent=? AND prab001=? AND prab002=? 
       FOR UPDATE"
   #add-point:modify段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apri020_bcl1 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_praa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_praa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apri020_b_fill(g_wc2)
            LET g_detail_cnt = g_praa_d.getLength()
         
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
            DISPLAY g_praa_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_praa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_praa_d[l_ac].praa001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_praa_d_t.* = g_praa_d[l_ac].*  #BACKUP
               LET g_praa_d_o.* = g_praa_d[l_ac].*  #BACKUP
               IF NOT apri020_lock_b("praa_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apri020_bcl INTO g_praa_d[l_ac].praastus,g_praa_d[l_ac].praa000,g_praa_d[l_ac].praa001, 
                      g_praa_d[l_ac].praa002,g_praa_d[l_ac].praaunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_praa_d_t.praa001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_praa_d_mask_o[l_ac].* =  g_praa_d[l_ac].*
                  CALL apri020_praa_t_mask()
                  LET g_praa_d_mask_n[l_ac].* =  g_praa_d[l_ac].*
                  
                  CALL apri020_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL apri020_set_entry_b(l_cmd)
            CALL apri020_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
#            IF NOT cl_null(g_praa_d_o.praa000) THEN
#               LET g_praa_d[l_ac].praa000 = g_praa_d_o.praa000    
#            END IF 
#            IF NOT cl_null(g_praa_d_o.praa002) THEN
#               LET g_praa_d[l_ac].praa002 = g_praa_d_o.praa002   
#            END IF
#            IF NOT cl_null(g_praa_d_o.praastus) THEN
#               LET g_praa_d[l_ac].praastus = g_praa_d_o.praastus   
#            END IF
#            IF g_praa_d[l_ac].praa000 = '1' THEN
#               CALL cl_set_combo_scc('praa001','6027')
#            ELSE
#               CALL apri020_praa001_init()
#            END IF
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
            INITIALIZE g_praa_d_t.* TO NULL
            INITIALIZE g_praa_d_o.* TO NULL
            INITIALIZE g_praa_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_praa_d[l_ac].praastus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_praa_d[l_ac].praastus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #从第二行开始，优先类型的默认值取上一行的值
            IF l_ac > 1 THEN
               LET g_praa_d[l_ac].praa000 = g_praa_d[l_ac-1].praa000
            ELSE
               LET g_praa_d[l_ac].praa000 = '1'
            END IF 
            IF NOT cl_null(g_praa_d_old.praa000) THEN
               LET g_praa_d[l_ac].praa000 = g_praa_d_old.praa000    
            END IF 
            IF NOT cl_null(g_praa_d_old.praa002) THEN
               LET g_praa_d[l_ac].praa002 = g_praa_d_old.praa002   
            END IF 
            IF NOT cl_null(g_praa_d_old.praastus) THEN
               LET g_praa_d[l_ac].praastus = g_praa_d_old.praastus   
            END IF
            IF g_praa_d[l_ac].praa002 = 0 THEN
               LET g_praa_d[l_ac].praa002 = ''
            END IF
            IF g_praa_d[l_ac].praa000 = '1' THEN
               CALL cl_set_combo_scc_part('praa001','6027','1,2,3')
            ELSE
               CALL apri020_praa001_init()
            END IF
            CALL apri020_praa001_field()
            INITIALIZE g_praa_d_old.* TO NULL
            #end add-point
            LET g_praa_d_t.* = g_praa_d[l_ac].*     #新輸入資料
            LET g_praa_d_o.* = g_praa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_praa_d[li_reproduce_target].* = g_praa_d[li_reproduce].*
 
               LET g_praa_d[g_praa_d.getLength()].praa001 = NULL
 
            END IF
            
 
            CALL apri020_set_entry_b(l_cmd)
            CALL apri020_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_praa_d[l_ac].praaunit = g_site
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
            SELECT COUNT(1) INTO l_count FROM praa_t 
             WHERE praaent = g_enterprise AND praa001 = g_praa_d[l_ac].praa001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_praa_d[g_detail_idx].praa001
               CALL apri020_insert_b('praa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_praa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "praa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apri020_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (praa001 = '", g_praa_d[l_ac].praa001, "' "
 
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
               
               DELETE FROM praa_t
                WHERE praaent = g_enterprise AND 
                      praa001 = g_praa_d_t.praa001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "praa_t:",SQLERRMESSAGE 
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
                  CALL apri020_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_praa_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE apri020_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_praa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_praa_d_t.praa001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apri020_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL apri020_delete_b('praa_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_praa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praastus
            #add-point:BEFORE FIELD praastus name="input.b.page1.praastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praastus
            
            #add-point:AFTER FIELD praastus name="input.a.page1.praastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE praastus
            #add-point:ON CHANGE praastus name="input.g.page1.praastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praa000
            #add-point:BEFORE FIELD praa000 name="input.b.page1.praa000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praa000
            
            #add-point:AFTER FIELD praa000 name="input.a.page1.praa000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE praa000
            #add-point:ON CHANGE praa000 name="input.g.page1.praa000"
            
            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt 
             FROM praa_t
            WHERE praaent = g_enterprise 
              AND praa000 <> g_praa_d[l_ac].praa000           
            IF l_cnt > 1 OR  (l_ac != 1 AND l_cnt = 1) THEN
               IF cl_ask_confirm('apr-00361') THEN
                  LET g_praa_d_old.* = g_praa_d[l_ac].*
                  
                  DELETE FROM praa_t
                   WHERE praaent = g_enterprise 
                  CALL s_transaction_end('Y','0')
                  CALL apri020_b_fill(' 1=1 ') 
                  CONTINUE DIALOG                  
               ELSE
                  LET g_praa_d[l_ac].praa000 = g_praa_d_o.praa000
             
               END IF 
            END IF
            IF g_praa_d[l_ac].praa000 = '1' THEN
               CALL cl_set_combo_scc_part('praa001','6027','1,2,3')
            ELSE
               CALL apri020_praa001_init()
            END IF  
            LET g_praa_d[l_ac].praa001 = ''            
            CALL apri020_praa001_field()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praa001
            #add-point:BEFORE FIELD praa001 name="input.b.page1.praa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praa001
            
            #add-point:AFTER FIELD praa001 name="input.a.page1.praa001"
            #此段落由子樣板a05產生
            IF  g_praa_d[g_detail_idx].praa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_praa_d[g_detail_idx].praa001 != g_praa_d_t.praa001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM praa_t WHERE "||"praaent = '" ||g_enterprise|| "' AND "||"praa001 = '"||g_praa_d[g_detail_idx].praa001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE praa001
            #add-point:ON CHANGE praa001 name="input.g.page1.praa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praa002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_praa_d[l_ac].praa002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD praa002
            END IF 
 
 
 
            #add-point:AFTER FIELD praa002 name="input.a.page1.praa002"
            IF NOT cl_null(g_praa_d[l_ac].praa002) AND 
               (g_praa_d[l_ac].praa002 <> g_praa_d_t.praa002 OR cl_null(g_praa_d_t.praa002)) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM praa_t
                WHERE praaent = g_enterprise
                  AND praa002 = g_praa_d[l_ac].praa002
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00076'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_praa_d[l_ac].praa002 = g_praa_d_t.praa002
                  NEXT FIELD praa002
               END IF                  
            END IF 
            LET g_praa_d_o.* = g_praa_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praa002
            #add-point:BEFORE FIELD praa002 name="input.b.page1.praa002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE praa002
            #add-point:ON CHANGE praa002 name="input.g.page1.praa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD praaunit
            #add-point:BEFORE FIELD praaunit name="input.b.page1.praaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD praaunit
            
            #add-point:AFTER FIELD praaunit name="input.a.page1.praaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE praaunit
            #add-point:ON CHANGE praaunit name="input.g.page1.praaunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.praastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praastus
            #add-point:ON ACTION controlp INFIELD praastus name="input.c.page1.praastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.praa000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praa000
            #add-point:ON ACTION controlp INFIELD praa000 name="input.c.page1.praa000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.praa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praa001
            #add-point:ON ACTION controlp INFIELD praa001 name="input.c.page1.praa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.praa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praa002
            #add-point:ON ACTION controlp INFIELD praa002 name="input.c.page1.praa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.praaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD praaunit
            #add-point:ON ACTION controlp INFIELD praaunit name="input.c.page1.praaunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE apri020_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_praa_d[l_ac].* = g_praa_d_t.*
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
               LET g_errparam.extend = g_praa_d[l_ac].praa001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_praa_d[l_ac].* = g_praa_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL apri020_praa_t_mask_restore('restore_mask_o')
 
               UPDATE praa_t SET (praastus,praa000,praa001,praa002,praaunit) = (g_praa_d[l_ac].praastus, 
                   g_praa_d[l_ac].praa000,g_praa_d[l_ac].praa001,g_praa_d[l_ac].praa002,g_praa_d[l_ac].praaunit) 
 
                WHERE praaent = g_enterprise AND
                  praa001 = g_praa_d_t.praa001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "praa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "praa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_praa_d[g_detail_idx].praa001
               LET gs_keys_bak[1] = g_praa_d_t.praa001
               CALL apri020_update_b('praa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_praa_d_t)
                     LET g_log2 = util.JSON.stringify(g_praa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apri020_praa_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL apri020_unlock_b("praa_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_praa_d[l_ac].* = g_praa_d_t.*
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
               LET g_praa_d[li_reproduce_target].* = g_praa_d[li_reproduce].*
 
               LET g_praa_d[li_reproduce_target].praa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_praa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_praa_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      #Page2 預設值產生於此處
      INPUT ARRAY g_prab_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_detail_cnt1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apri020_b1_fill(g_wc3)
            LET g_detail_cnt1 = g_prab_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx1 = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx1
            DISPLAY g_prab_d.getLength() TO FORMONLY.cnt1
         
            CALL s_transaction_begin()
            LET g_detail_cnt1 = g_prab_d.getLength()
            
            IF g_detail_cnt1 >= l_ac 
               AND g_prab_d[l_ac].prab001 IS NOT NULL AND g_prab_d[l_ac].prab002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prab_d_t.* = g_prab_d[l_ac].*  #BACKUP
               LET g_prab_d_o.* = g_prab_d[l_ac].*  #BACKUP
               IF NOT apri020_lock_b("prab_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apri020_bcl1 INTO g_prab_d[l_ac].prabstus,g_prab_d[l_ac].prab000,g_prab_d[l_ac].prab001,g_prab_d[l_ac].prab002, 
                      g_prab_d[l_ac].prabunit
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_prab_d_t.prab001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL apri020_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
#            IF NOT cl_null(g_prab_d_o.prab000) THEN
#               LET g_prab_d[l_ac].prab000 = g_prab_d_o.prab000    
#            END IF 
#            IF NOT cl_null(g_prab_d_o.prab002) THEN
#               LET g_prab_d[l_ac].prab002 = g_prab_d_o.prab002   
#            END IF
#            IF NOT cl_null(g_prab_d_o.prabstus) THEN
#               LET g_prab_d[l_ac].prabstus = g_prab_d_o.prabstus   
#            END IF
#            IF g_prab_d[l_ac].prab000 = '1' THEN
#               CALL cl_set_combo_scc('prab001','6027')
#            ELSE
#               CALL apri020_prab001_init()
#            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prab_d_t.* TO NULL
            INITIALIZE g_prab_d[l_ac].* TO NULL 
                  LET g_prab_d[l_ac].prabstus = "Y"
 
             #公用欄位給值(單身) 
            #从第二行开始，优先类型的默认值取上一行的值
            IF l_ac > 1 THEN
               LET g_prab_d[l_ac].prab000 = g_prab_d[l_ac-1].prab000
            ELSE
               LET g_prab_d[l_ac].prab000 = '1'
            END IF 
            IF NOT cl_null(g_prab_d_old.prab000) THEN
               LET g_prab_d[l_ac].prab000 = g_prab_d_old.prab000    
            END IF 
            IF NOT cl_null(g_prab_d_old.prab002) THEN
               LET g_prab_d[l_ac].prab002 = g_prab_d_old.prab002   
            END IF
            IF NOT cl_null(g_prab_d_old.prabstus) THEN
               LET g_prab_d[l_ac].prabstus = g_prab_d_old.prabstus   
            END IF
            IF g_prab_d[l_ac].prab000 = '1' THEN
               CALL cl_set_combo_scc_part('prab001','6027','1,2,3')
               CALL cl_set_combo_scc_part('prab002','6027','1,2,3')
            ELSE
               CALL apri020_prab001_init()
               CALL apri020_prab002_init()
            END IF   
            CALL apri020_prab001_field() 
            INITIALIZE g_prab_d_old.* TO NULL            
            LET g_prab_d_t.* = g_prab_d[l_ac].*     #新輸入資料
            LET g_prab_d_o.* = g_prab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apri020_set_entry_b("a")
            CALL apri020_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prab_d[li_reproduce_target].* = g_prab_d[li_reproduce].*
 
               LET g_prab_d[g_prab_d.getLength()].prab001 = NULL
               LET g_prab_d[g_prab_d.getLength()].prab002 = NULL
 
            END IF
           
            #add-point:modify段before insert
            LET g_prab_d[l_ac].prabunit = g_site
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
            SELECT COUNT(*) INTO l_count FROM prab_t 
             WHERE prabent = g_enterprise AND prab001 = g_prab_d[l_ac].prab001
               AND prab002 = g_prab_d[l_ac].prab002
               AND prab000 = g_prab_d[l_ac].prab000
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prab_d[g_detail_idx1].prab001
               LET gs_keys[2] = g_prab_d[g_detail_idx1].prab002
               CALL apri020_insert_b('prab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_prab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apri020_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt1 = g_detail_cnt1 + 1
               
               LET g_wc3 = g_wc3, " OR (prab001 = '", g_prab_d[l_ac].prab001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_prab_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_prab_d.deleteElement(l_ac)
               NEXT FIELD prab001
            END IF
            IF g_prab_d[l_ac].prab001 IS NOT NULL AND g_prab_d[l_ac].prab002 IS NOT NULL AND g_prab_d[l_ac].prab000 IS NOT NULL
 
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
               
               DELETE FROM prab_t
                WHERE prabent = g_enterprise AND 
                      prab001 = g_prab_d_t.prab001
                  AND prab002 = g_prab_d_t.prab002
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prab_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt1 = g_detail_cnt1-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apri020_bcl1
               LET l_count = g_prab_d.getLength()
            END IF 
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prab_d[g_detail_idx1].prab001
               LET gs_keys[2] = g_prab_d[g_detail_idx1].prab002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL apri020_delete_b('prab_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<praastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prabstus
            #add-point:BEFORE FIELD praastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prabstus
            
            #add-point:AFTER FIELD praastus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prabstus
            #add-point:ON CHANGE praastus

            #END add-point

         #----<<prab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prab000
            #add-point:BEFORE FIELD prab000

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prab000
            
            #add-point:AFTER FIELD prab000
            LET g_prab_d_o.* = g_prab_d[l_ac].*
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prab000
            #add-point:ON CHANGE prab000
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt 
              FROM prab_t
             WHERE prabent = g_enterprise 
               AND prab000 <> g_prab_d[l_ac].prab000
            IF l_cnt > 1 OR  (l_ac != 1 AND l_cnt = 1) THEN
               IF cl_ask_confirm('apr-00368') THEN
                  LET g_prab_d_old.* = g_prab_d[l_ac].*
                  DELETE FROM prab_t
                   WHERE prabent = g_enterprise 
                  CALL s_transaction_end('Y','0')
                  CALL apri020_b1_fill(' 1=1 ') 
#                  CALL apri020_praa001_field()
                  CONTINUE DIALOG                  
               ELSE
                  LET g_prab_d[l_ac].prab000 = g_prab_d_o.prab000
#                  CALL apri020_praa001_field()
               END IF 
            END IF
            IF g_prab_d[l_ac].prab000 = '1' THEN
               CALL cl_set_combo_scc_part('prab001','6027','1,2,3')
               CALL cl_set_combo_scc_part('prab002','6027','1,2,3')
            ELSE
               CALL apri020_prab001_init()
               CALL apri020_prab002_init()
            END IF 
            LET g_prab_d[l_ac].prab001 = ''     
            CALL apri020_prab001_field()            
            #END add-point
            
         #----<<praa001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prab001
            #add-point:BEFORE FIELD praa001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prab001
            
            #add-point:AFTER FIELD praa001
            #此段落由子樣板a05產生
            #IF  g_prab_d[g_detail_idx1].prab001 IS NOT NULL THEN 
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prab_d[g_detail_idx1].prab001 != g_prab_d_t.prab001)) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prab_t WHERE "||"prabent = '" ||g_enterprise|| "' AND "||"prab001 = '"||g_prab_d[g_detail_idx1].prab001 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            IF NOT cl_null(g_prab_d[l_ac].prab001) AND NOT cl_null(g_prab_d[l_ac].prab002)
               AND (g_prab_d[l_ac].prab001 != g_prab_d_t.prab001 OR cl_null(g_prab_d_t.prab001)) THEN
               IF g_prab_d[l_ac].prab001 = g_prab_d[l_ac].prab002 THEN
                   #mark by geza #150430-00005 (S)
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'apr-00001'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
                  #mark by geza #150430-00005 (E)
                  #add by geza #150430-00005 (S)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00391'
                  CALL cl_getmsg('apr-00365',g_dlang) RETURNING l_msg
                  IF g_prab_d[l_ac].prab000 = '2' THEN
                     CALL cl_getmsg('apr-00366',g_dlang) RETURNING l_msg
                  END IF
                  IF g_prab_d[l_ac].prab000 = '3' THEN
                     CALL cl_getmsg('apr-00367',g_dlang) RETURNING l_msg
                  END IF
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_msg
                  CALL cl_err()
                  #add by geza #150430-00005 (E)
                  LET g_prab_d[l_ac].prab001 = g_prab_d_t.prab001
                  DISPLAY BY NAME g_prab_d[l_ac].prab001
                  NEXT FIELD prab001
               END IF
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM prab_t
                WHERE prabent = g_enterprise 
                  AND ((prab001 = g_prab_d[l_ac].prab001 AND prab002 = g_prab_d[l_ac].prab002) 
                   OR (prab001 = g_prab_d[l_ac].prab002 AND prab002 = g_prab_d[l_ac].prab001))
               IF l_n > 0 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'apr-00002'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
                  #add by geza #150430-00005 (S)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00392'
                  CALL cl_getmsg('apr-00365',g_dlang) RETURNING l_msg
                  IF g_prab_d[l_ac].prab000 = '2' THEN
                     CALL cl_getmsg('apr-00366',g_dlang) RETURNING l_msg
                  END IF
                  IF g_prab_d[l_ac].prab000 = '3' THEN
                     CALL cl_getmsg('apr-00367',g_dlang) RETURNING l_msg
                  END IF
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_msg
                  CALL cl_err()
                  #add by geza #150430-00005 (E)
                  LET g_prab_d[l_ac].prab001 = g_prab_d_t.prab001
                  DISPLAY BY NAME g_prab_d[l_ac].prab001
                  NEXT FIELD prab001
               END IF  
            END IF

            LET g_prab_d_o.* = g_prab_d[l_ac].*
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prab001
            #add-point:ON CHANGE praa001

            #END add-point
 
         #----<<praa002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prab002
            #add-point:BEFORE FIELD praa002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prab002
            
            #add-point:AFTER FIELD praa002
            IF NOT cl_null(g_prab_d[l_ac].prab002) AND NOT cl_null(g_prab_d[l_ac].prab001) 
               AND (g_prab_d[l_ac].prab002 != g_prab_d_t.prab002 OR cl_null(g_prab_d_t.prab002)) THEN
               IF g_prab_d[l_ac].prab001 = g_prab_d[l_ac].prab002 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'apr-00001'  mark  by geza      
                  #add by geza #150430-00005 (S)
                  LET g_errparam.code = 'apr-00391'
                  CALL cl_getmsg('apr-00365',g_dlang) RETURNING l_msg
                  IF g_prab_d[l_ac].prab000 = '2' THEN
                     CALL cl_getmsg('apr-00366',g_dlang) RETURNING l_msg
                  END IF
                  IF g_prab_d[l_ac].prab000 = '3' THEN
                     CALL cl_getmsg('apr-00367',g_dlang) RETURNING l_msg
                  END IF
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_msg
                  #add by geza #150430-00005 (E)
                  CALL cl_err()

                  LET g_prab_d[l_ac].prab002 = g_prab_d_t.prab002
                  DISPLAY BY NAME g_prab_d[l_ac].prab002
                  NEXT FIELD prab002
               END IF
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM prab_t
                WHERE prabent = g_enterprise 
                  AND ((prab001 = g_prab_d[l_ac].prab001 AND prab002 = g_prab_d[l_ac].prab002) 
                   OR (prab001 = g_prab_d[l_ac].prab002 AND prab002 = g_prab_d[l_ac].prab001))
               IF l_n > 0 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'apr-00002'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
                  
                  #add by geza #150430-00005 (S)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00392'
                  CALL cl_getmsg('apr-00365',g_dlang) RETURNING l_msg
                  IF g_prab_d[l_ac].prab000 = '2' THEN
                     CALL cl_getmsg('apr-00366',g_dlang) RETURNING l_msg
                  END IF
                  IF g_prab_d[l_ac].prab000 = '3' THEN
                     CALL cl_getmsg('apr-00367',g_dlang) RETURNING l_msg
                  END IF
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = l_msg
                  CALL cl_err()
                  #add by geza #150430-00005 (E)
                  
                  LET g_prab_d[l_ac].prab002 = g_prab_d_t.prab002
                  DISPLAY BY NAME g_prab_d[l_ac].prab002
                  NEXT FIELD prab002
               END IF  
            END IF     
            LET g_prab_d_o.* = g_prab_d[l_ac].*            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prab002
            #add-point:ON CHANGE praa002

            #END add-point
 
         #----<<praaunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD prabunit
            #add-point:BEFORE FIELD praaunit

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD prabunit
            
            #add-point:AFTER FIELD praaunit

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE prabunit
            #add-point:ON CHANGE praaunit

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<praastus>>----
         #Ctrlp:input.c.page1.praastus
         ON ACTION controlp INFIELD prabstus
            #add-point:ON ACTION controlp INFIELD praastus

            #END add-point
 
         #----<<praa001>>----
         #Ctrlp:input.c.page1.praa001
         ON ACTION controlp INFIELD prab001
            #add-point:ON ACTION controlp INFIELD praa001

            #END add-point
 
         #----<<praa002>>----
         #Ctrlp:input.c.page1.praa002
         ON ACTION controlp INFIELD prab002
            #add-point:ON ACTION controlp INFIELD praa002

            #END add-point
 
         #----<<praaunit>>----
         #Ctrlp:input.c.page1.praaunit
         ON ACTION controlp INFIELD prabunit
            #add-point:ON ACTION controlp INFIELD praaunit

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_prab_d[l_ac].* = g_prab_d_t.*
               CLOSE apri020_bcl1
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_prab_d[l_ac].prab001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_prab_d[l_ac].* = g_prab_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               #LET g_praa_d[l_ac].praamodid = g_user 
#LET g_praa_d[l_ac].praamoddt = cl_get_current()
 
            
               #add-point:單身修改前

               #end add-point
               
               UPDATE prab_t SET (prabstus,prab000,prab001,prab002,prabunit) = (g_prab_d[l_ac].prabstus,g_prab_d[l_ac].prab000,g_prab_d[l_ac].prab001, 
                   g_prab_d[l_ac].prab002,g_prab_d[l_ac].prabunit)
                WHERE prabent = g_enterprise AND
                  prab001 = g_prab_d_t.prab001 AND #項次
                  prab002 = g_prab_d_t.prab002 AND #項次
                  prab000 = g_prab_d_t.prab000                    
 
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "prab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "prab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prab_d[g_detail_idx1].prab001
               LET gs_keys_bak[1] = g_prab_d_t.prab001
               LET gs_keys[2] = g_prab_d[g_detail_idx1].prab002
               LET gs_keys_bak[2] = g_prab_d_t.prab002
               CALL apri020_update_b('prab_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL apri020_unlock_b("prab_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_prab_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_prab_d.getLength()+1
            
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
         IF g_temp_idx1 > 0 THEN
            LET l_ac = g_temp_idx1
            CALL DIALOG.setCurrentRow("s_detail2",l_ac)
            LET g_temp_idx1 = 1
         END IF
         LET g_curr_diag = ui.DIALOG.getCurrent()
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD praastus
 
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
      IF INT_FLAG OR cl_null(g_praa_d[g_detail_idx].praa001) THEN
         CALL g_praa_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_praa_d[g_detail_idx].* = g_praa_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_prab_d[g_detail_idx].* = g_prab_d_t.*
   END IF
   IF NOT cl_null(g_praa_d[l_ac].praa000) THEN 
      IF g_praa_d[l_ac].praa000 = '1' THEN
         CALL cl_set_combo_scc_part('praa001','6027','1,2,3')
      ELSE
         CALL apri020_praa001_init()
      END IF
   END IF
   IF NOT cl_null(g_prab_d[l_ac].prab000) THEN 
      IF g_prab_d[l_ac].prab000 = '1' THEN
         CALL cl_set_combo_scc_part('prab001','6027','1,2,3')
         CALL cl_set_combo_scc_part('prab002','6027','1,2,3')
      ELSE
         CALL apri020_prab001_init()
         CALL apri020_prab002_init()
      END IF   
   END IF
   CALL apri020_b_fill(g_wc2)
   CALL apri020_b1_fill( " 1 = 1")
   CLOSE apri020_bcl1
   #end add-point
 
   CLOSE apri020_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="apri020.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apri020_delete()
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
   FOR li_idx = 1 TO g_praa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT apri020_lock_b("praa_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("praa_t","praaownid") THEN
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
   
   FOR li_idx = 1 TO g_praa_d.getLength()
      IF g_praa_d[li_idx].praa001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM praa_t
          WHERE praaent = g_enterprise AND 
                praa001 = g_praa_d[li_idx].praa001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "praa_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_praa_d_t.praa001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL apri020_delete_b('praa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apri020_set_pk_array()
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
   CALL apri020_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="apri020.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apri020_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.praastus,t0.praa000,t0.praa001,t0.praa002,t0.praaunit  FROM praa_t t0", 
 
               "",
               
               " WHERE t0.praaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("praa_t"),
                      " ORDER BY t0.praa001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"praa_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apri020_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apri020_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_praa_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_praa_d[l_ac].praastus,g_praa_d[l_ac].praa000,g_praa_d[l_ac].praa001,g_praa_d[l_ac].praa002, 
       g_praa_d[l_ac].praaunit
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_praa_d[l_ac].praa000 = '1' THEN
         CALL cl_set_combo_scc_part('praa001','6027','1,2,3')
      ELSE
         CALL apri020_praa001_init()
      END IF
      #end add-point
      
      CALL apri020_detail_show()      
 
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
   
 
   
   CALL g_praa_d.deleteElement(g_praa_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_praa_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_praa_d.getLength() THEN
      LET l_ac = g_praa_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_praa_d.getLength()
      LET g_praa_d_mask_o[l_ac].* =  g_praa_d[l_ac].*
      CALL apri020_praa_t_mask()
      LET g_praa_d_mask_n[l_ac].* =  g_praa_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   IF p_wc2 = " 1=1" AND g_flag = 'N' THEN
      CALL apri020_b1_fill(p_wc2)
   END IF
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_praa_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE apri020_pb
   
END FUNCTION
 
{</section>}
 
{<section id="apri020.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apri020_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apri020.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apri020_set_entry_b(p_cmd)                                                  
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
 
{<section id="apri020.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apri020_set_no_entry_b(p_cmd)                                               
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
 
{<section id="apri020.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apri020_default_search()
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
      LET ls_wc = ls_wc, " praa001 = '", g_argv[01], "' AND "
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
 
{<section id="apri020.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apri020_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   #判斷是否是同一群組的table
   LET ls_group = "prab_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
   
      #add-point:delete_b段刪除前

      #end add-point     
   
      DELETE FROM prab_t
       WHERE prabent = g_enterprise AND
         prab001 = ps_keys_bak[1] AND 
         prab002 = ps_keys_bak[2]
 
      #add-point:delete_b段刪除中

      #end add-point  
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      
      #add-point:delete_b段刪除後

      #end add-point
      
      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "praa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'praa_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM praa_t
          WHERE praaent = g_enterprise AND
            praa001 = ps_keys_bak[1]
         
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
         CALL g_praa_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apri020.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apri020_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "praa_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #end add-point    
      INSERT INTO praa_t
                  (praaent,
                   praa001
                   ,praastus,praa000,praa002,praaunit) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_praa_d[l_ac].praastus,g_praa_d[l_ac].praa000,g_praa_d[l_ac].praa002,g_praa_d[l_ac].praaunit) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "praa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
   ELSE
      INSERT INTO prab_t
                  (prabent,
                   prab001
                   ,prabstus,prab000,prab002,prabunit) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_prab_d[l_ac].prabstus,g_prab_d[l_ac].prab000,ps_keys[2],g_prab_d[l_ac].prabunit)
      #add-point:insert_b段新增中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
   END IF
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apri020.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apri020_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "praa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "praa_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE praa_t 
         SET (praa001
              ,praastus,praa000,praa002,praaunit) 
              = 
             (ps_keys[1]
              ,g_praa_d[l_ac].praastus,g_praa_d[l_ac].praa000,g_praa_d[l_ac].praa002,g_praa_d[l_ac].praaunit)  
 
         WHERE praaent = g_enterprise AND praa001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "praa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "praa_t:",SQLERRMESSAGE 
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
 
{<section id="apri020.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apri020_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   LET ls_group = "prab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apri020_bcl1 USING g_enterprise,
                                       g_prab_d[g_detail_idx1].prab001,g_prab_d[g_detail_idx1].prab002
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apri020_bcl1"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL apri020_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "praa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apri020_bcl USING g_enterprise,
                                       g_praa_d[g_detail_idx].praa001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apri020_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apri020.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apri020_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   IF ps_table = 'prab_t' THEN
      CLOSE apri020_bcl1
      RETURN
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE apri020_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apri020.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION apri020_modify_detail_chk(ps_record)
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
         LET ls_return = "praastus"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      WHEN "s_detail2" 
         LET ls_return = "prabstus"
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apri020.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION apri020_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="apri020.mask_functions" >}
&include "erp/apr/apri020_mask.4gl"
 
{</section>}
 
{<section id="apri020.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apri020_set_pk_array()
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
   LET g_pk_array[1].values = g_praa_d[l_ac].praa001
   LET g_pk_array[1].column = 'praa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apri020.state_change" >}
   
 
{</section>}
 
{<section id="apri020.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apri020.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 顯示第二單身
# Memo...........:
# Usage..........: CALL apri020_b1_fill(p_wc3)
# Input parameter: p_wc3   組合sql條件
# Date & Author..: 14/03/03 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION apri020_b1_fill(p_wc3)
   DEFINE p_wc3           STRING
   {</Local define>}
   
   IF cl_null(p_wc3) THEN
      LET p_wc3 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身)
   LET g_sql = "SELECT  UNIQUE prabstus,prab000,prab001,prab002,prabunit FROM prab_t",
               " WHERE prabent= ? AND 1=1 AND ",p_wc3
    
   LET g_sql = g_sql, " ORDER BY prab_t.prab001"
  
   #add-point:b_fill段sql之後

   #end add-point
  
   PREPARE apri020_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR apri020_pb1
   
   OPEN b_fill_curs1 USING g_enterprise
 
   CALL g_prab_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_prab_d[l_ac].prabstus,g_prab_d[l_ac].prab000,g_prab_d[l_ac].prab001,g_prab_d[l_ac].prab002,g_prab_d[l_ac].prabunit 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
      IF g_prab_d[l_ac].prab000 = '1' THEN
         CALL cl_set_combo_scc_part('prab001','6027','1,2,3')
         CALL cl_set_combo_scc_part('prab002','6027','1,2,3')
      ELSE
         CALL apri020_prab001_init()
         CALL apri020_prab002_init()
      END IF
      #end add-point
      
      CALL apri020_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF l_ac > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9035
      LET g_errparam.extend = "prab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   LET g_error_show = 0
     
   CALL g_prab_d.deleteElement(g_prab_d.getLength())

   #end add-point
 
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE apri020_pb1
   
END FUNCTION

################################################################################
# Descriptions...: 促销栏位初始化
# Memo...........:
# Date & Author..: 2015/04/21 by geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apri020_praa001_init()
DEFINE l_oocq002      LIKE oocq_t.oocq002
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE cb004          ui.ComboBox
DEFINE l_sql          STRING
DEFINE l_cnt          LIKE type_t.num5
   LET cb004 = ui.ComboBox.forName('praa001')
   CALL cb004.clear()
   LET l_cnt = 0
   IF g_praa_d[l_ac].praa000 = '2' THEN
      
      LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
                  "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  "  WHERE oocqent = ",g_enterprise," ",
#                  "    AND oocq001 = '2100' ",
                  "    AND oocq001 = '2135' ",
                  "    AND oocqstus = 'Y' "
      LET l_sql = l_sql," ORDER BY oocq002 "
   END IF
   IF g_praa_d[l_ac].praa000 = '3' THEN   
      LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
                  "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  "  WHERE oocqent = ",g_enterprise," ",
                  "    AND oocq001 = '2101' ",
                  "    AND oocqstus = 'Y' "
      LET l_sql = l_sql," ORDER BY oocq002 "
      
   END IF 
   
   PREPARE sel_rtda_pre FROM l_sql
   DECLARE sel_rtda_cs  CURSOR FOR sel_rtda_pre
   LET l_cnt = 1
   FOREACH sel_rtda_cs  INTO l_oocq002,l_oocql004
      LET l_oocql004 = l_oocq002,':',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 促销栏位说明
# Memo...........:
# Date & Author..: 2015/04/21 by geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apri020_praa001_field()
   DEFINE l_msg      STRING 
   
   CALL cl_getmsg('apr-00362',g_dlang) RETURNING l_msg
   CALL cl_set_comp_att_text("praa001",l_msg)
   
   IF g_praa_d[l_ac].praa000 = '2' THEN
      CALL cl_getmsg('apr-00363',g_dlang) RETURNING l_msg
      CALL cl_set_comp_att_text("praa001",l_msg)
   END IF
   IF g_praa_d[l_ac].praa000 = '3' THEN
      CALL cl_getmsg('apr-00364',g_dlang) RETURNING l_msg
      CALL cl_set_comp_att_text("praa001",l_msg)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 促销栏位初始化
# Memo...........:
# Date & Author..: 2015/04/21 by geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apri020_prab001_init()
DEFINE l_oocq002      LIKE oocq_t.oocq002
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE cb004          ui.ComboBox
DEFINE l_sql          STRING
DEFINE l_cnt          LIKE type_t.num5
   LET cb004 = ui.ComboBox.forName('prab001')
   CALL cb004.clear()
   LET l_cnt = 0
   IF g_prab_d[l_ac].prab000 = '2' THEN
      
      LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
                  "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  "  WHERE oocqent = ",g_enterprise," ",
#                  "    AND oocq001 = '2100' ",
                  "    AND oocq001 = '2135' ",
                  "    AND oocqstus = 'Y' "
      LET l_sql = l_sql," ORDER BY oocq002 "
   END IF
   IF g_prab_d[l_ac].prab000 = '3' THEN    
      LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
                  "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  "  WHERE oocqent = ",g_enterprise," ",
                  "    AND oocq001 = '2101' ",
                  "    AND oocqstus = 'Y' "
      LET l_sql = l_sql," ORDER BY oocq002 "
      
   END IF 
   
   PREPARE sel_rtda_pre1 FROM l_sql
   DECLARE sel_rtda_cs1  CURSOR FOR sel_rtda_pre1
   LET l_cnt = 1
   FOREACH sel_rtda_cs1  INTO l_oocq002,l_oocql004
      LET l_oocql004 = l_oocq002,':',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 促销栏位说明,叠加栏位说明
# Memo...........:
# Date & Author..: 2015/04/22 by geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apri020_prab001_field()
DEFINE l_msg      STRING 
   
   CALL cl_getmsg('apr-00362',g_dlang) RETURNING l_msg
   CALL cl_set_comp_att_text("prab001",l_msg)
   CALL cl_getmsg('apr-00365',g_dlang) RETURNING l_msg
   CALL cl_set_comp_att_text("prab002",l_msg)
   IF g_prab_d[l_ac].prab000 = '2' THEN
      CALL cl_getmsg('apr-00363',g_dlang) RETURNING l_msg
      CALL cl_set_comp_att_text("prab001",l_msg)
      CALL cl_getmsg('apr-00366',g_dlang) RETURNING l_msg
      CALL cl_set_comp_att_text("prab002",l_msg)
   END IF
   IF g_prab_d[l_ac].prab000 = '3' THEN
      CALL cl_getmsg('apr-00364',g_dlang) RETURNING l_msg
      CALL cl_set_comp_att_text("prab001",l_msg)
      CALL cl_getmsg('apr-00367',g_dlang) RETURNING l_msg
      CALL cl_set_comp_att_text("prab002",l_msg)
   END IF
END FUNCTION

################################################################################
###########################################################
PRIVATE FUNCTION apri020_prab002_init()
DEFINE l_oocq002      LIKE oocq_t.oocq002
DEFINE l_oocql004     LIKE oocql_t.oocql004
DEFINE cb004          ui.ComboBox
DEFINE l_sql          STRING
DEFINE l_cnt          LIKE type_t.num5
   LET cb004 = ui.ComboBox.forName('prab002')
   CALL cb004.clear()
   LET l_cnt = 0
   IF g_prab_d[l_ac].prab000 = '2' THEN
      
      LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
                  "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  "  WHERE oocqent = ",g_enterprise," ",
#                  "    AND oocq001 = '2100' ",
                  "    AND oocq001 = '2135' ",
                  "    AND oocqstus = 'Y' "
      LET l_sql = l_sql," ORDER BY oocq002 "
   END IF
   IF g_prab_d[l_ac].prab000 = '3' THEN    
      LET l_sql = " SELECT DISTINCT oocq002,oocql004 ",
                  "   FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  "  WHERE oocqent = ",g_enterprise," ",
                  "    AND oocq001 = '2101' ",
                  "    AND oocqstus = 'Y' "
      LET l_sql = l_sql," ORDER BY oocq002 "
      
   END IF 
   
   PREPARE sel_rtda_pre2 FROM l_sql
   DECLARE sel_rtda_cs2  CURSOR FOR sel_rtda_pre2
   LET l_cnt = 1
   FOREACH sel_rtda_cs2  INTO l_oocq002,l_oocql004
      LET l_oocql004 = l_oocq002,':',l_oocql004
      IF cl_null(l_oocql004) THEN
         CALL cb004.addItem(l_oocq002,l_oocq002)
      ELSE
         CALL cb004.addItem(l_oocq002,l_oocql004)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION

 
{</section>}
 
