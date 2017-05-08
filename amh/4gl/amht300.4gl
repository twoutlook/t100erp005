#該程式未解開Section, 採用最新樣板產出!
{<section id="amht300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-11-16 15:32:16), PR版次:0005(2016-10-17 17:37:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: amht300
#+ Description: 非庫存物料領用維護作業
#+ Creator....: 06540(2015-11-16 15:32:16)
#+ Modifier...: 06540 -SD/PR- 06814
 
{</section>}
 
{<section id="amht300.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#47 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161006-00008#2  2016/10/17 By 06814   加上aooi500控卡邏輯
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
PRIVATE TYPE type_g_mhap_d RECORD
       sel LIKE type_t.chr1, 
   mhapdocno LIKE mhap_t.mhapdocno, 
   mhapsite LIKE mhap_t.mhapsite, 
   mhapsite_desc LIKE type_t.chr500, 
   mhap002 LIKE mhap_t.mhap002, 
   mhap010 LIKE mhap_t.mhap010, 
   mhap010_desc LIKE type_t.chr500, 
   mhap013 LIKE mhap_t.mhap013, 
   mhap013_desc LIKE type_t.chr500, 
   mhap001 LIKE mhap_t.mhap001, 
   mhap005 LIKE mhap_t.mhap005, 
   mhap005_desc LIKE type_t.chr500, 
   mhap006 LIKE mhap_t.mhap006, 
   mhap006_desc LIKE type_t.chr500, 
   mhap007 LIKE mhap_t.mhap007, 
   mhap008 LIKE mhap_t.mhap008, 
   mhap009 LIKE mhap_t.mhap009, 
   mhap003 LIKE mhap_t.mhap003, 
   mhap004 LIKE mhap_t.mhap004, 
   mhap011 LIKE mhap_t.mhap011, 
   mhap012 LIKE mhap_t.mhap012, 
   mhap014 LIKE mhap_t.mhap014, 
   mhapownid LIKE mhap_t.mhapownid, 
   mhapownid_desc LIKE type_t.chr500, 
   mhapowndp LIKE mhap_t.mhapowndp, 
   mhapowndp_desc LIKE type_t.chr500, 
   mhapcrtid LIKE mhap_t.mhapcrtid, 
   mhapcrtid_desc LIKE type_t.chr500, 
   mhapcrtdp LIKE mhap_t.mhapcrtdp, 
   mhapcrtdp_desc LIKE type_t.chr500, 
   mhapcrtdt DATETIME YEAR TO SECOND, 
   mhapmodid LIKE mhap_t.mhapmodid, 
   mhapmodid_desc LIKE type_t.chr500, 
   mhapmoddt DATETIME YEAR TO SECOND, 
   mhapcnfid LIKE mhap_t.mhapcnfid, 
   mhapcnfid_desc LIKE type_t.chr500, 
   mhapcnfdt DATETIME YEAR TO SECOND, 
   mhapstus LIKE mhap_t.mhapstus
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_str            STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_mhap_d          DYNAMIC ARRAY OF type_g_mhap_d #單身變數
DEFINE g_mhap_d_t        type_g_mhap_d                  #單身備份
DEFINE g_mhap_d_o        type_g_mhap_d                  #單身備份
DEFINE g_mhap_d_mask_o   DYNAMIC ARRAY OF type_g_mhap_d #單身變數
DEFINE g_mhap_d_mask_n   DYNAMIC ARRAY OF type_g_mhap_d #單身變數
 
      
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
 
{<section id="amht300.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#2 20161017 add by beckxie
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amh","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mhapdocno,mhapsite,mhap002,mhap010,mhap013,mhap001,mhap005,mhap006,mhap007, 
       mhap008,mhap009,mhap003,mhap004,mhap011,mhap012,mhap014,mhapownid,mhapowndp,mhapcrtid,mhapcrtdp, 
       mhapcrtdt,mhapmodid,mhapmoddt,mhapcnfid,mhapcnfdt,mhapstus FROM mhap_t WHERE mhapent=? AND mhapdocno=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amht300_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amht300 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amht300_init()   
 
      #進入選單 Menu (="N")
      CALL amht300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amht300
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#2 20161017 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amht300.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION amht300_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#2 20161017 add by beckxie
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
      CALL cl_set_combo_scc_part('mhapstus','13','N,X,Y')
 
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('mhap002','6834') 
   LET g_site_str = 'mhapsite'
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#2 20161017 add by beckxie
   #end add-point
   
   CALL amht300_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="amht300.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION amht300_ui_dialog()
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
   DEFINE l_ac1      LIKE type_t.num5
   DEFINE l_ac2      LIKE type_t.num5
   DEFINE l_success  LIKE type_t.chr5
   DEFINE l_mhap012  LIKE mhap_t.mhap012
   DEFINE l_stbastus LIKE stba_t.stbastus
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
         CALL g_mhap_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL amht300_init()
      END IF
   
      CALL amht300_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mhap_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_mhap_d[g_detail_idx].mhapownid   #(ver:35)
               LET g_data_dept = g_mhap_d[g_detail_idx].mhapowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL amht300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
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
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL amht300_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amht300_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL amht300_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amht300_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unexpense
            LET g_action_choice="unexpense"
            IF cl_auth_chk_act("unexpense") THEN
               
               #add-point:ON ACTION unexpense name="menu.unexpense"

               CALL amht300_onaction_unexpense()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION expense_1
            LET g_action_choice="expense_1"
            IF cl_auth_chk_act("expense_1") THEN
               
               #add-point:ON ACTION expense_1 name="menu.expense_1"
               CALL amht300_onaction_expense_1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unexpense_1
            LET g_action_choice="unexpense_1"
            IF cl_auth_chk_act("unexpense_1") THEN
               
               #add-point:ON ACTION unexpense_1 name="menu.unexpense_1"
               CALL amht300_onaction_unexpense_1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL amht300_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amht300_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION expense
            LET g_action_choice="expense"
            IF cl_auth_chk_act("expense") THEN
               
               #add-point:ON ACTION expense name="menu.expense"
                CALL amht300_onaction_expense()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amht300_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amh/amht300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amh/amht300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
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
         ON ACTION unexpens_1
            LET g_action_choice="unexpens_1"
            IF cl_auth_chk_act("unexpens_1") THEN
               
               #add-point:ON ACTION unexpens_1 name="menu.unexpens_1"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amht300_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_mhap_d)
               LET g_export_id[1]   = "s_detail1"
 
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
            CALL amht300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amht300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amht300_set_pk_array()
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
 
{<section id="amht300.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION amht300_query()
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
   CALL g_mhap_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sel,mhapdocno,mhapsite,mhap002,mhap010,mhap013,mhap001,mhap005,mhap006,mhap007, 
          mhap008,mhap009,mhap003,mhap004,mhap011,mhap012,mhap014,mhapownid,mhapowndp,mhapcrtid,mhapcrtdp, 
          mhapcrtdt,mhapmodid,mhapmoddt,mhapcnfid,mhapcnfdt,mhapstus 
 
         FROM s_detail1[1].sel,s_detail1[1].mhapdocno,s_detail1[1].mhapsite,s_detail1[1].mhap002,s_detail1[1].mhap010, 
             s_detail1[1].mhap013,s_detail1[1].mhap001,s_detail1[1].mhap005,s_detail1[1].mhap006,s_detail1[1].mhap007, 
             s_detail1[1].mhap008,s_detail1[1].mhap009,s_detail1[1].mhap003,s_detail1[1].mhap004,s_detail1[1].mhap011, 
             s_detail1[1].mhap012,s_detail1[1].mhap014,s_detail1[1].mhapownid,s_detail1[1].mhapowndp, 
             s_detail1[1].mhapcrtid,s_detail1[1].mhapcrtdp,s_detail1[1].mhapcrtdt,s_detail1[1].mhapmodid, 
             s_detail1[1].mhapmoddt,s_detail1[1].mhapcnfid,s_detail1[1].mhapcnfdt,s_detail1[1].mhapstus  
 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mhapcrtdt>>----
         AFTER FIELD mhapcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mhapmoddt>>----
         AFTER FIELD mhapmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhapcnfdt>>----
         AFTER FIELD mhapcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhappstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="query.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="query.a.page1.sel"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="query.c.page1.sel"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapdocno
            #add-point:BEFORE FIELD mhapdocno name="query.b.page1.mhapdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapdocno
            
            #add-point:AFTER FIELD mhapdocno name="query.a.page1.mhapdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapdocno
            #add-point:ON ACTION controlp INFIELD mhapdocno name="query.c.page1.mhapdocno"

            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhapdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapdocno  #顯示到畫面上
            NEXT FIELD mhapdocno                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapsite
            #add-point:BEFORE FIELD mhapsite name="query.b.page1.mhapsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapsite
            
            #add-point:AFTER FIELD mhapsite name="query.a.page1.mhapsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhapsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapsite
            #add-point:ON ACTION controlp INFIELD mhapsite name="query.c.page1.mhapsite"

               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhapsite',g_site,'c')            
               CALL q_ooef001_24()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhapsite  #顯示到畫面上
               NEXT FIELD mhapsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap002
            #add-point:BEFORE FIELD mhap002 name="query.b.page1.mhap002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap002
            
            #add-point:AFTER FIELD mhap002 name="query.a.page1.mhap002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap002
            #add-point:ON ACTION controlp INFIELD mhap002 name="query.c.page1.mhap002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap010
            #add-point:BEFORE FIELD mhap010 name="query.b.page1.mhap010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap010
            
            #add-point:AFTER FIELD mhap010 name="query.a.page1.mhap010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap010
            #add-point:ON ACTION controlp INFIELD mhap010 name="query.c.page1.mhap010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_mhap_d[l_ac].mhap002
            CALL q_mhap010()                     
            DISPLAY g_qryparam.return1 TO mhap010  
            NEXT FIELD mhap010  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap013
            #add-point:BEFORE FIELD mhap013 name="query.b.page1.mhap013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap013
            
            #add-point:AFTER FIELD mhap013 name="query.a.page1.mhap013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap013
            #add-point:ON ACTION controlp INFIELD mhap013 name="query.c.page1.mhap013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhap013  #顯示到畫面上
            NEXT FIELD mhap013                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap001
            #add-point:BEFORE FIELD mhap001 name="query.b.page1.mhap001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap001
            
            #add-point:AFTER FIELD mhap001 name="query.a.page1.mhap001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap001
            #add-point:ON ACTION controlp INFIELD mhap001 name="query.c.page1.mhap001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap005
            #add-point:BEFORE FIELD mhap005 name="query.b.page1.mhap005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap005
            
            #add-point:AFTER FIELD mhap005 name="query.a.page1.mhap005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap005
            #add-point:ON ACTION controlp INFIELD mhap005 name="query.c.page1.mhap005"
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO mhap005
               NEXT FIELD mhap005                    #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap006
            #add-point:BEFORE FIELD mhap006 name="query.b.page1.mhap006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap006
            
            #add-point:AFTER FIELD mhap006 name="query.a.page1.mhap006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap006
            #add-point:ON ACTION controlp INFIELD mhap006 name="query.c.page1.mhap006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhap006  #顯示到畫面上
            NEXT FIELD mhap006                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap007
            #add-point:BEFORE FIELD mhap007 name="query.b.page1.mhap007"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap007
            
            #add-point:AFTER FIELD mhap007 name="query.a.page1.mhap007"
 
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap007
            #add-point:ON ACTION controlp INFIELD mhap007 name="query.c.page1.mhap007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap008
            #add-point:BEFORE FIELD mhap008 name="query.b.page1.mhap008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap008
            
            #add-point:AFTER FIELD mhap008 name="query.a.page1.mhap008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap008
            #add-point:ON ACTION controlp INFIELD mhap008 name="query.c.page1.mhap008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap009
            #add-point:BEFORE FIELD mhap009 name="query.b.page1.mhap009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap009
            
            #add-point:AFTER FIELD mhap009 name="query.a.page1.mhap009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap009
            #add-point:ON ACTION controlp INFIELD mhap009 name="query.c.page1.mhap009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap003
            #add-point:BEFORE FIELD mhap003 name="query.b.page1.mhap003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap003
            
            #add-point:AFTER FIELD mhap003 name="query.a.page1.mhap003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap003
            #add-point:ON ACTION controlp INFIELD mhap003 name="query.c.page1.mhap003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                       
            DISPLAY g_qryparam.return1 TO mhap003
            NEXT FIELD mhap003       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap004
            #add-point:BEFORE FIELD mhap004 name="query.b.page1.mhap004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap004
            
            #add-point:AFTER FIELD mhap004 name="query.a.page1.mhap004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap004
            #add-point:ON ACTION controlp INFIELD mhap004 name="query.c.page1.mhap004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                      
            DISPLAY g_qryparam.return1 TO mhap004 
            NEXT FIELD mhap004   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap011
            #add-point:BEFORE FIELD mhap011 name="query.b.page1.mhap011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap011
            
            #add-point:AFTER FIELD mhap011 name="query.a.page1.mhap011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap011
            #add-point:ON ACTION controlp INFIELD mhap011 name="query.c.page1.mhap011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap012
            #add-point:BEFORE FIELD mhap012 name="query.b.page1.mhap012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap012
            
            #add-point:AFTER FIELD mhap012 name="query.a.page1.mhap012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap012
            #add-point:ON ACTION controlp INFIELD mhap012 name="query.c.page1.mhap012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap014
            #add-point:BEFORE FIELD mhap014 name="query.b.page1.mhap014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap014
            
            #add-point:AFTER FIELD mhap014 name="query.a.page1.mhap014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhap014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap014
            #add-point:ON ACTION controlp INFIELD mhap014 name="query.c.page1.mhap014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhapownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapownid
            #add-point:ON ACTION controlp INFIELD mhapownid name="construct.c.page1.mhapownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapownid  #顯示到畫面上
            NEXT FIELD mhapownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapownid
            #add-point:BEFORE FIELD mhapownid name="query.b.page1.mhapownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapownid
            
            #add-point:AFTER FIELD mhapownid name="query.a.page1.mhapownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhapowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapowndp
            #add-point:ON ACTION controlp INFIELD mhapowndp name="construct.c.page1.mhapowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapowndp  #顯示到畫面上
            NEXT FIELD mhapowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapowndp
            #add-point:BEFORE FIELD mhapowndp name="query.b.page1.mhapowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapowndp
            
            #add-point:AFTER FIELD mhapowndp name="query.a.page1.mhapowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhapcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapcrtid
            #add-point:ON ACTION controlp INFIELD mhapcrtid name="construct.c.page1.mhapcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapcrtid  #顯示到畫面上
            NEXT FIELD mhapcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapcrtid
            #add-point:BEFORE FIELD mhapcrtid name="query.b.page1.mhapcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapcrtid
            
            #add-point:AFTER FIELD mhapcrtid name="query.a.page1.mhapcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhapcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapcrtdp
            #add-point:ON ACTION controlp INFIELD mhapcrtdp name="construct.c.page1.mhapcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapcrtdp  #顯示到畫面上
            NEXT FIELD mhapcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapcrtdp
            #add-point:BEFORE FIELD mhapcrtdp name="query.b.page1.mhapcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapcrtdp
            
            #add-point:AFTER FIELD mhapcrtdp name="query.a.page1.mhapcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapcrtdt
            #add-point:BEFORE FIELD mhapcrtdt name="query.b.page1.mhapcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhapmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapmodid
            #add-point:ON ACTION controlp INFIELD mhapmodid name="construct.c.page1.mhapmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapmodid  #顯示到畫面上
            NEXT FIELD mhapmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapmodid
            #add-point:BEFORE FIELD mhapmodid name="query.b.page1.mhapmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapmodid
            
            #add-point:AFTER FIELD mhapmodid name="query.a.page1.mhapmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapmoddt
            #add-point:BEFORE FIELD mhapmoddt name="query.b.page1.mhapmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhapcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapcnfid
            #add-point:ON ACTION controlp INFIELD mhapcnfid name="construct.c.page1.mhapcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhapcnfid  #顯示到畫面上
            NEXT FIELD mhapcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapcnfid
            #add-point:BEFORE FIELD mhapcnfid name="query.b.page1.mhapcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapcnfid
            
            #add-point:AFTER FIELD mhapcnfid name="query.a.page1.mhapcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapcnfdt
            #add-point:BEFORE FIELD mhapcnfdt name="query.b.page1.mhapcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapstus
            #add-point:BEFORE FIELD mhapstus name="query.b.page1.mhapstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapstus
            
            #add-point:AFTER FIELD mhapstus name="query.a.page1.mhapstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhapstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapstus
            #add-point:ON ACTION controlp INFIELD mhapstus name="query.c.page1.mhapstus"
            
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
    
   CALL amht300_b_fill(g_wc2)
   LET g_data_owner = g_mhap_d[g_detail_idx].mhapownid   #(ver:35)
   LET g_data_dept = g_mhap_d[g_detail_idx].mhapowndp   #(ver:35)
 
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
 
{<section id="amht300.insert" >}
#+ 資料新增
PRIVATE FUNCTION amht300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
 
   #end add-point
   
   LET g_insert = 'Y'
   CALL amht300_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amht300.modify" >}
#+ 資料修改
PRIVATE FUNCTION amht300_modify()
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
   DEFINE  r_success              LIKE type_t.num5
   DEFINE  r_doctype              LIKE rtai_t.rtai004
   DEFINE  mhap009_t              LIKE mhap_t.mhap009
   DEFINE  l_success              LIKE type_t.num5
   DEFINE  l_errno                STRING
   DEFINE  l_ooef004              LIKE ooef_t.ooef004   
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
      INPUT ARRAY g_mhap_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhap_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amht300_b_fill(g_wc2)
            LET g_detail_cnt = g_mhap_d.getLength()
         
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
            DISPLAY g_mhap_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mhap_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mhap_d[l_ac].mhapdocno IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhap_d_t.* = g_mhap_d[l_ac].*  #BACKUP
               LET g_mhap_d_o.* = g_mhap_d[l_ac].*  #BACKUP
               IF NOT amht300_lock_b("mhap_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amht300_bcl INTO g_mhap_d[l_ac].mhapdocno,g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhap002, 
                      g_mhap_d[l_ac].mhap010,g_mhap_d[l_ac].mhap013,g_mhap_d[l_ac].mhap001,g_mhap_d[l_ac].mhap005, 
                      g_mhap_d[l_ac].mhap006,g_mhap_d[l_ac].mhap007,g_mhap_d[l_ac].mhap008,g_mhap_d[l_ac].mhap009, 
                      g_mhap_d[l_ac].mhap003,g_mhap_d[l_ac].mhap004,g_mhap_d[l_ac].mhap011,g_mhap_d[l_ac].mhap012, 
                      g_mhap_d[l_ac].mhap014,g_mhap_d[l_ac].mhapownid,g_mhap_d[l_ac].mhapowndp,g_mhap_d[l_ac].mhapcrtid, 
                      g_mhap_d[l_ac].mhapcrtdp,g_mhap_d[l_ac].mhapcrtdt,g_mhap_d[l_ac].mhapmodid,g_mhap_d[l_ac].mhapmoddt, 
                      g_mhap_d[l_ac].mhapcnfid,g_mhap_d[l_ac].mhapcnfdt,g_mhap_d[l_ac].mhapstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhap_d_t.mhapdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhap_d_mask_o[l_ac].* =  g_mhap_d[l_ac].*
                  CALL amht300_mhap_t_mask()
                  LET g_mhap_d_mask_n[l_ac].* =  g_mhap_d[l_ac].*
                  
                  CALL amht300_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL amht300_set_entry_b(l_cmd)
            CALL amht300_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL amht300_set_no_entry_b("u")
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
            INITIALIZE g_mhap_d_t.* TO NULL
            INITIALIZE g_mhap_d_o.* TO NULL
            INITIALIZE g_mhap_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhap_d[l_ac].mhapownid = g_user
      LET g_mhap_d[l_ac].mhapowndp = g_dept
      LET g_mhap_d[l_ac].mhapcrtid = g_user
      LET g_mhap_d[l_ac].mhapcrtdp = g_dept 
      LET g_mhap_d[l_ac].mhapcrtdt = cl_get_current()
      LET g_mhap_d[l_ac].mhapmodid = g_user
      LET g_mhap_d[l_ac].mhapmoddt = cl_get_current()
      LET g_mhap_d[l_ac].mhapstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_mhap_d[l_ac].sel = "N"
      LET g_mhap_d[l_ac].mhap007 = "0"
      LET g_mhap_d[l_ac].mhap008 = "0"
      LET g_mhap_d[l_ac].mhap009 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
     #defult值
      LET g_mhap_d[l_ac].mhap001 = g_today
      LET g_mhap_d[l_ac].mhap011 = 'N'
      LET g_mhap_d[l_ac].mhapstus = 'N'
      LET g_mhap_d[l_ac].sel = 'N'
      #LET g_mhap_d[l_ac].mhapunit = g_site
      LET g_mhap_d[l_ac].mhapsite = g_site
      
     ##預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_mhap_d[l_ac].mhapdocno = r_doctype
      
      DISPLAY BY NAME g_mhap_d[l_ac].mhap001,g_mhap_d[l_ac].mhap011,g_mhap_d[l_ac].mhapstus,g_mhap_d[l_ac].sel,g_mhap_d[l_ac].mhapdocno,g_mhap_d[l_ac].mhapsite
      
            #end add-point
            LET g_mhap_d_t.* = g_mhap_d[l_ac].*     #新輸入資料
            LET g_mhap_d_o.* = g_mhap_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhap_d[li_reproduce_target].* = g_mhap_d[li_reproduce].*
 
               LET g_mhap_d[g_mhap_d.getLength()].mhapdocno = NULL
 
            END IF
            
 
            CALL amht300_set_entry_b(l_cmd)
            CALL amht300_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM mhap_t 
             WHERE mhapent = g_enterprise AND mhapdocno = g_mhap_d[l_ac].mhapdocno
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"

               #自动编号 
                CALL s_aooi200_gen_docno(g_site,g_mhap_d[l_ac].mhapdocno,g_mhap_d[l_ac].mhap001,g_prog) RETURNING l_success,g_mhap_d[l_ac].mhapdocno
                IF NOT l_success THEN
                   CALL s_transaction_end('N','0')
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00003'
                   LET g_errparam.extend = g_mhap_d[l_ac].mhapdocno
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                  # CONTINUE DIALOG                  
                END IF 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhap_d[g_detail_idx].mhapdocno
               CALL amht300_insert_b('mhap_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mhap_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mhap_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amht300_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (mhapdocno = '", g_mhap_d[l_ac].mhapdocno, "' "
 
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
               
               DELETE FROM mhap_t
                WHERE mhapent = g_enterprise AND 
                      mhapdocno = g_mhap_d_t.mhapdocno
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mhap_t:",SQLERRMESSAGE 
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
                  CALL amht300_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_mhap_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE amht300_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_mhap_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhap_d_t.mhapdocno
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amht300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL amht300_delete_b('mhap_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mhap_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapdocno
            #add-point:BEFORE FIELD mhapdocno name="input.b.page1.mhapdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapdocno
            
            #add-point:AFTER FIELD mhapdocno name="input.a.page1.mhapdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mhap_d[g_detail_idx].mhapdocno IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhap_d[g_detail_idx].mhapdocno != g_mhap_d_t.mhapdocno)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhap_t WHERE "||"mhapent = '" ||g_enterprise|| "' AND "||"mhapdocno = '"||g_mhap_d[g_detail_idx].mhapdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhapdocno
            #add-point:ON CHANGE mhapdocno name="input.g.page1.mhapdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapsite
            
            #add-point:AFTER FIELD mhapsite name="input.a.page1.mhapsite"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mhap_d[l_ac].mhapsite
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mhap_d[l_ac].mhapsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mhap_d[l_ac].mhapsite_desc
#
            LET g_mhap_d[l_ac].mhapsite_desc = ' '
            DISPLAY BY NAME g_mhap_d[l_ac].mhapsite_desc
            IF NOT cl_null(g_mhap_d[l_ac].mhapsite) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mhap_d[l_ac].mhapsite != g_mhap_d_t.mhapsite OR g_mhap_d_t.mhapsite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,g_site_str,g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhapsite )
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()                  
                     
                     LET g_mhap_d[l_ac].mhapsite = g_mhap_d_t.mhapsite
                     LET g_mhap_d[l_ac].mhapsite_desc = s_desc_get_department_desc(g_mhap_d[l_ac].mhapsite)
                     DISPLAY BY NAME g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhapsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
#                  CALL s_arti200_get_def_doc_type(g_mhap_d[l_ac].mhapsite,g_prog,'1')
#                     RETURNING l_success,g_mhap_d[l_ac].mhapdocno
#                  DISPLAY BY NAME g_mhap_d[l_ac].mhapdocno             
                
               END IF
            ELSE
               NEXT FIELD CURRENT
            END IF
            LET g_mhap_d[l_ac].mhapsite_desc = s_desc_get_department_desc(g_mhap_d[l_ac].mhapsite)
            DISPLAY BY NAME g_mhap_d[l_ac].mhapsite_desc
            CALL amht300_set_no_entry_b("z")
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapsite
            #add-point:BEFORE FIELD mhapsite name="input.b.page1.mhapsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhapsite
            #add-point:ON CHANGE mhapsite name="input.g.page1.mhapsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap002
            #add-point:BEFORE FIELD mhap002 name="input.b.page1.mhap002"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap002
            
            #add-point:AFTER FIELD mhap002 name="input.a.page1.mhap002"
            IF cl_null(g_mhap_d[l_ac].mhap002) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "ain-00611" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()            
               NEXT FIELD mhap002
            ELSE
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mhap_d[l_ac].mhap002 != g_mhap_d_t.mhap002 OR g_mhap_d_t.mhap002 IS NULL )) THEN
                  LET g_mhap_d[l_ac].mhap010 = NULL
                  LET g_mhap_d[l_ac].mhap010_desc = NULL
                  DISPLAY BY NAME g_mhap_d[l_ac].mhap010
                  DISPLAY g_mhap_d[l_ac].mhap010_desc TO mhap010_desc
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap002
            #add-point:ON CHANGE mhap002 name="input.g.page1.mhap002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap010
            
            #add-point:AFTER FIELD mhap010 name="input.a.page1.mhap010"

#            LET g_mhap_d[l_ac].mhap010_desc = ' '
#            DISPLAY BY NAME g_mhap_d[l_ac].mhap010_desc
#            IF NOT cl_null(g_mhap_d[l_ac].mhap010) THEN
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mhap_d[l_ac].mhap010 != g_mhap_d_t.mhap010 OR g_mhap_d_t.mhap010 IS NULL )) THEN
#                  CASE g_mhap_d[l_ac].mhap002
#                     WHEN '1'   #供應商 
#                        INITIALIZE g_chkparam.* TO NULL
#                        LET g_chkparam.arg1 = g_mhap_d[l_ac].mhap010
#                        IF NOT cl_chk_exist("v_pmaa001_1") THEN
#                           LET g_mhap_d[l_ac].mhap010 = g_mhap_d_t.mhap010 
#                           DISPLAY BY NAME g_mhap_d[l_ac].mhap010
#                           CALL amht300_mhap010_ref()
#                           
#                           NEXT FIELD CURRENT
#                        END IF         
#
#                        LET l_cnt = 0
#                        SELECT COUNT(*) INTO l_cnt
#                          FROM stan_t
#                         WHERE stanent = g_enterprise
#                           AND stan005 = g_mhap_d[l_ac].mhap010
#                           AND stan002 = '1'
#                           AND stan029 NOT IN ('1','7')
#                           AND stanstus = 'Y'
#                           AND EXISTS(SELECT 1 FROM stbo_t
#                                       WHERE stboent = stanent
#                                         AND stbo001 = stan001
#                                         AND stbo003 = g_mhap_d[l_ac].mhapsite)
#                        IF l_cnt = 0 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code       = "ain-00625"
#                           LET g_errparam.replace[1] = g_mhap_d[l_ac].mhap010
#                           LET g_errparam.popup      = TRUE
#                           CALL cl_err()
#
#                           LET g_mhap_d[l_ac].mhap010 = g_mhap_d_t.mhap010 
#                           DISPLAY BY NAME g_mhap_d[l_ac].mhap010
#                           CALL amht300_mhap010_ref()
#                           NEXT FIELD CURRENT
#                        END IF
#                        
#                     WHEN '2'   #專櫃     
#                        INITIALIZE g_chkparam.* TO NULL
#                        LET g_chkparam.arg1 = g_mhap_d[l_ac].mhapsite
#                        LET g_chkparam.arg2 = g_mhap_d[l_ac].mhap010
#                        IF NOT cl_chk_exist("v_mhae001_1") THEN
#                           LET g_mhap_d[l_ac].mhap010 = g_mhap_d_t.mhap010                       
#                           DISPLAY BY NAME g_mhap_d[l_ac].mhap010
#                           CALL amht300_mhap010_ref()
#                           NEXT FIELD CURRENT
#                        END IF   
#                        
#                        LET l_cnt = 0
#                        SELECT COUNT(*) INTO l_cnt
#                          FROM stfa_t
#                         WHERE stfaent = g_enterprise
#                           AND stfa005 = g_mhap_d[l_ac].mhap010
#                           AND stfa004 NOT IN ('1','7')
#                           AND stfastus = 'Y'
#                        IF l_cnt = 0 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code       = "ain-00626"
#                           LET g_errparam.replace[1] = g_mhap_d[l_ac].mhap010
#                           LET g_errparam.popup      = TRUE
#                           CALL cl_err()
#
#                           LET g_mhap_d[l_ac].mhap010 = g_mhap_d_t.mhap010
#                           DISPLAY BY NAME g_mhap_d[l_ac].mhap010
#                           CALL amht300_mhap010_ref()
#                           NEXT FIELD CURRENT
#                        END IF
#                        
#                     WHEN '3'   #內部員工 
#                        INITIALIZE g_chkparam.* TO NULL
#                        LET g_chkparam.arg1 = g_mhap_d[l_ac].mhap010
#                        IF cl_null(g_mhap_d[l_ac].mhap001) THEN
#                           LET g_chkparam.arg2 = g_today
#                        ELSE
#                           LET g_chkparam.arg2 = g_mhap_d[l_ac].mhap001
#                        END IF
#                        
#                        IF NOT cl_chk_exist("v_ooeg001") THEN
#                           LET g_mhap_d[l_ac].mhap010 = g_mhap_d_t.mhap010 
#                           DISPLAY BY NAME g_mhap_d[l_ac].mhap010
#                           CALL amht300_mhap010_ref()
#                           NEXT FIELD CURRENT
#                        END IF     
#                  END CASE
#                  
#                  DISPLAY BY NAME g_mhap_d[l_ac].mhap010,g_mhap_d[l_ac].mhap010_desc   
#               END IF
#            END IF
#
           CALL amht300_mhap010_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap010
            #add-point:BEFORE FIELD mhap010 name="input.b.page1.mhap010"
            IF cl_null(g_mhap_d[l_ac].mhap002) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "ain-00611" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()            
               NEXT FIELD mhap002
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap010
            #add-point:ON CHANGE mhap010 name="input.g.page1.mhap010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap013
            
            #add-point:AFTER FIELD mhap013 name="input.a.page1.mhap013"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhap_d[l_ac].mhap013
            CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? ","") RETURNING g_rtn_fields
            LET g_mhap_d[l_ac].mhap013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhap_d[l_ac].mhap013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap013
            #add-point:BEFORE FIELD mhap013 name="input.b.page1.mhap013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap013
            #add-point:ON CHANGE mhap013 name="input.g.page1.mhap013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap001
            #add-point:BEFORE FIELD mhap001 name="input.b.page1.mhap001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap001
            
            #add-point:AFTER FIELD mhap001 name="input.a.page1.mhap001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap001
            #add-point:ON CHANGE mhap001 name="input.g.page1.mhap001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap005
            
            #add-point:AFTER FIELD mhap005 name="input.a.page1.mhap005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhap_d[l_ac].mhap005
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? ","") RETURNING g_rtn_fields
            LET g_mhap_d[l_ac].mhap005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhap_d[l_ac].mhap005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap005
            #add-point:BEFORE FIELD mhap005 name="input.b.page1.mhap005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap005
            #add-point:ON CHANGE mhap005 name="input.g.page1.mhap005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap006
            
            #add-point:AFTER FIELD mhap006 name="input.a.page1.mhap006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhap_d[l_ac].mhap006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? ","") RETURNING g_rtn_fields
            LET g_mhap_d[l_ac].mhap006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhap_d[l_ac].mhap006_desc

            SELECT rtaw001 INTO g_mhap_d[l_ac].mhap005
              FROM rtaw_t,imaa_t
             WHERE rtawent = imaaent
               AND rtaw002 = imaa009
               AND rtaw003 = cl_get_para(g_enterprise,"","E-CIR-0001")
               AND imaa001 = g_mhap_d[l_ac].mhap006
            DISPLAY BY NAME g_mhap_d[l_ac].mhap005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap006
            #add-point:BEFORE FIELD mhap006 name="input.b.page1.mhap006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap006
            #add-point:ON CHANGE mhap006 name="input.g.page1.mhap006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap007
            #add-point:BEFORE FIELD mhap007 name="input.b.page1.mhap007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap007
            
            #add-point:AFTER FIELD mhap007 name="input.a.page1.mhap007"
            LET g_mhap_d[l_ac].mhap009 = g_mhap_d[l_ac].mhap007 * g_mhap_d[l_ac].mhap008
            DISPLAY BY NAME g_mhap_d[l_ac].mhap009
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap007
            #add-point:ON CHANGE mhap007 name="input.g.page1.mhap007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap008
            #add-point:BEFORE FIELD mhap008 name="input.b.page1.mhap008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap008
            
            #add-point:AFTER FIELD mhap008 name="input.a.page1.mhap008"
            LET g_mhap_d[l_ac].mhap009 = g_mhap_d[l_ac].mhap007 * g_mhap_d[l_ac].mhap008
            DISPLAY BY NAME g_mhap_d[l_ac].mhap009
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap008
            #add-point:ON CHANGE mhap008 name="input.g.page1.mhap008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap009
            #add-point:BEFORE FIELD mhap009 name="input.b.page1.mhap009"
            LET g_mhap_d[l_ac].mhap009 = g_mhap_d[l_ac].mhap007 * g_mhap_d[l_ac].mhap008
            DISPLAY BY NAME g_mhap_d[l_ac].mhap009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap009
            
            #add-point:AFTER FIELD mhap009 name="input.a.page1.mhap009"
            LET mhap009_t = g_mhap_d[l_ac].mhap007 * g_mhap_d[l_ac].mhap008 
            IF g_mhap_d[l_ac].mhap009 != mhap009_t THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "注意～！费用金额不等于费用单价乘以数量～～" 
               LET g_errparam.code   = "adz-00482"
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
#               CANCEL DELETE
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap009
            #add-point:ON CHANGE mhap009 name="input.g.page1.mhap009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap003
            #add-point:BEFORE FIELD mhap003 name="input.b.page1.mhap003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap003
            
            #add-point:AFTER FIELD mhap003 name="input.a.page1.mhap003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap003
            #add-point:ON CHANGE mhap003 name="input.g.page1.mhap003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap004
            #add-point:BEFORE FIELD mhap004 name="input.b.page1.mhap004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap004
            
            #add-point:AFTER FIELD mhap004 name="input.a.page1.mhap004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap004
            #add-point:ON CHANGE mhap004 name="input.g.page1.mhap004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap011
            #add-point:BEFORE FIELD mhap011 name="input.b.page1.mhap011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap011
            
            #add-point:AFTER FIELD mhap011 name="input.a.page1.mhap011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap011
            #add-point:ON CHANGE mhap011 name="input.g.page1.mhap011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap012
            #add-point:BEFORE FIELD mhap012 name="input.b.page1.mhap012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap012
            
            #add-point:AFTER FIELD mhap012 name="input.a.page1.mhap012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap012
            #add-point:ON CHANGE mhap012 name="input.g.page1.mhap012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhap014
            #add-point:BEFORE FIELD mhap014 name="input.b.page1.mhap014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhap014
            
            #add-point:AFTER FIELD mhap014 name="input.a.page1.mhap014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhap014
            #add-point:ON CHANGE mhap014 name="input.g.page1.mhap014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhapstus
            #add-point:BEFORE FIELD mhapstus name="input.b.page1.mhapstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhapstus
            
            #add-point:AFTER FIELD mhapstus name="input.a.page1.mhapstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhapstus
            #add-point:ON CHANGE mhapstus name="input.g.page1.mhapstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapdocno
            #add-point:ON ACTION controlp INFIELD mhapdocno name="input.c.page1.mhapdocno"
            LET l_ooef004 = ''
            SELECT ooef004 
              INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise 
               AND ooef001 = g_site 
               AND ooefstus = 'Y'
               
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhap_d[l_ac].mhapdocno             #給予default值
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_mhap_d[l_ac].mhapdocno = g_qryparam.return1              
            DISPLAY g_mhap_d[l_ac].mhapdocno TO mhapdocno              #
            NEXT FIELD mhapdocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.mhapsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapsite
            #add-point:ON ACTION controlp INFIELD mhapsite name="input.c.page1.mhapsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhap_d[l_ac].mhapsite         
            LET g_qryparam.where = s_aooi500_q_where(g_prog,g_site_str,g_mhap_d[l_ac].mhapsite,'i') 
            CALL q_ooef001_24()

            LET g_mhap_d[l_ac].mhapsite = g_qryparam.return1       
            LET g_mhap_d[l_ac].mhapsite_desc = s_desc_get_department_desc(g_mhap_d[l_ac].mhapsite)
            DISPLAY BY NAME g_mhap_d[l_ac].mhapsite ,g_mhap_d[l_ac].mhapsite_desc
            
            NEXT FIELD mhapsite 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap002
            #add-point:ON ACTION controlp INFIELD mhap002 name="input.c.page1.mhap002"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap010
            #add-point:ON ACTION controlp INFIELD mhap010 name="input.c.page1.mhap010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_mhap_d[l_ac].mhap002
                  
            CASE g_mhap_d[l_ac].mhap002
               WHEN '1'   #供應商
                  CALL q_pmaa001_10()                             
                  LET g_mhap_d[l_ac].mhap010 = g_qryparam.return1   
                  LET g_mhap_d[l_ac].mhap010_desc = s_desc_get_trading_partner_abbr_desc(g_mhap_d[l_ac].mhap010)
                  
               WHEN '2'   #專櫃                  
                  LET g_qryparam.arg1 = g_mhap_d[l_ac].mhapsite 
                  
                  CALL q_mhae001_2()                             
                  LET g_mhap_d[l_ac].mhap010 = g_qryparam.return1   
                  LET g_mhap_d[l_ac].mhap010_desc = s_desc_get_counter_desc(g_mhap_d[l_ac].mhap010)
                  
               WHEN '3'   #內部員工       
                  IF cl_null(g_mhap_d[l_ac].mhap001) THEN
                     LET g_qryparam.arg1 = g_today
                  ELSE
                     LET g_qryparam.arg1 = g_mhap_d[l_ac].mhap001
                  END IF
                  CALL q_ooeg001()
                  LET g_mhap_d[l_ac].mhap010 = g_qryparam.return1   
                  LET g_mhap_d[l_ac].mhap010_desc = s_desc_get_department_desc(g_mhap_d[l_ac].mhap010)
            END CASE

            DISPLAY BY NAME g_mhap_d[l_ac].mhap010           
            DISPLAY BY NAME g_mhap_d[l_ac].mhap010_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap013
            #add-point:ON ACTION controlp INFIELD mhap013 name="input.c.page1.mhap013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhap_d[l_ac].mhap013 
            
            CALL q_stae001()                                #呼叫開窗

            LET g_mhap_d[l_ac].mhap013  = g_qryparam.return1 
            
            SELECT stael003 INTO g_mhap_d[l_ac].mhap013_desc
              FROM stael_t
             WHERE staelent = g_enterprise
               AND stael001 = g_mhap_d[l_ac].mhap013
               AND stael002 = g_dlang            
            
            DISPLAY BY NAME g_mhap_d[l_ac].mhap013,g_mhap_d[l_ac].mhap013_desc         
            NEXT FIELD mhap013 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap001
            #add-point:ON ACTION controlp INFIELD mhap001 name="input.c.page1.mhap001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap005
            #add-point:ON ACTION controlp INFIELD mhap005 name="input.c.page1.mhap005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhap_d[l_ac].mhap005
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,"","E-CIR-0001")
            CALL q_rtax001_3()
            LET g_mhap_d[l_ac].mhap005 = g_qryparam.return1 
            DISPLAY BY NAME g_mhap_d[l_ac].mhap005
            NEXT FIELD mhap005
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap006
            #add-point:ON ACTION controlp INFIELD mhap006 name="input.c.page1.mhap006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhap_d[l_ac].mhap006 
            
               LET g_qryparam.arg1 = 'ALL'
               LET g_qryparam.arg2 = g_mhap_d[l_ac].mhapsite

               IF NOT cl_null(g_mhap_d[l_ac].mhap005) THEN
                  LET g_qryparam.where = " EXISTS(SELECT 1 FROM rtaw_t",
                                         "         WHERE imaaent = rtawent",
                                         "           AND imaa009 = rtaw002",
                                         "           AND rtaw001 = '",g_mhap_d[l_ac].mhap005,"'",
                                         "           AND rtaw003 = ",cl_get_para(g_enterprise,"","E-CIR-0001"),")"
               END IF
               CALL q_imaf001_18()
               LET g_mhap_d[l_ac].mhap006 = g_qryparam.return1
            DISPLAY BY NAME g_mhap_d[l_ac].mhap006           
            NEXT FIELD mhap006    
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap007
            #add-point:ON ACTION controlp INFIELD mhap007 name="input.c.page1.mhap007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap008
            #add-point:ON ACTION controlp INFIELD mhap008 name="input.c.page1.mhap008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap009
            #add-point:ON ACTION controlp INFIELD mhap009 name="input.c.page1.mhap009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap003
            #add-point:ON ACTION controlp INFIELD mhap003 name="input.c.page1.mhap003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhap_d[l_ac].mhap003 
            IF cl_null(g_mhap_d[l_ac].mhap001) THEN
               LET g_qryparam.arg1 = g_today
            ELSE
               LET g_qryparam.arg1 = g_mhap_d[l_ac].mhap001
            END IF

            CALL q_ooeg001()                              
            
            LET g_mhap_d[l_ac].mhap003 = g_qryparam.return1      
            #LET g_mhap_d[l_ac].mhap003_desc = s_desc_get_department_desc(g_mhap_d[l_ac].mhap003)  
            DISPLAY BY NAME g_mhap_d[l_ac].mhap003#,g_mhap_d[l_ac].mhap003_desc 
            
            NEXT FIELD mhap003  
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap004
            #add-point:ON ACTION controlp INFIELD mhap004 name="input.c.page1.mhap004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhap_d[l_ac].mhap004  
            CALL q_ooag001()                                
            LET g_mhap_d[l_ac].mhap004 = g_qryparam.return1              

            #說明欄位
            #LET g_mhap_d[l_ac].mhap004_desc = s_desc_get_person_desc(g_mhap_d[l_ac].mhap004)             
            DISPLAY BY NAME g_mhap_d[l_ac].mhap004#,g_mhap_d[l_ac].mhap004_desc 

            NEXT FIELD mhap004
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap011
            #add-point:ON ACTION controlp INFIELD mhap011 name="input.c.page1.mhap011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap012
            #add-point:ON ACTION controlp INFIELD mhap012 name="input.c.page1.mhap012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhap014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhap014
            #add-point:ON ACTION controlp INFIELD mhap014 name="input.c.page1.mhap014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhapstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhapstus
            #add-point:ON ACTION controlp INFIELD mhapstus name="input.c.page1.mhapstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE amht300_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_mhap_d[l_ac].* = g_mhap_d_t.*
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
               LET g_errparam.extend = g_mhap_d[l_ac].mhapdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mhap_d[l_ac].* = g_mhap_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_mhap_d[l_ac].mhapmodid = g_user 
LET g_mhap_d[l_ac].mhapmoddt = cl_get_current()
LET g_mhap_d[l_ac].mhapmodid_desc = cl_get_username(g_mhap_d[l_ac].mhapmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL amht300_mhap_t_mask_restore('restore_mask_o')
 
               UPDATE mhap_t SET (mhapdocno,mhapsite,mhap002,mhap010,mhap013,mhap001,mhap005,mhap006, 
                   mhap007,mhap008,mhap009,mhap003,mhap004,mhap011,mhap012,mhap014,mhapownid,mhapowndp, 
                   mhapcrtid,mhapcrtdp,mhapcrtdt,mhapmodid,mhapmoddt,mhapcnfid,mhapcnfdt,mhapstus) = (g_mhap_d[l_ac].mhapdocno, 
                   g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhap002,g_mhap_d[l_ac].mhap010,g_mhap_d[l_ac].mhap013, 
                   g_mhap_d[l_ac].mhap001,g_mhap_d[l_ac].mhap005,g_mhap_d[l_ac].mhap006,g_mhap_d[l_ac].mhap007, 
                   g_mhap_d[l_ac].mhap008,g_mhap_d[l_ac].mhap009,g_mhap_d[l_ac].mhap003,g_mhap_d[l_ac].mhap004, 
                   g_mhap_d[l_ac].mhap011,g_mhap_d[l_ac].mhap012,g_mhap_d[l_ac].mhap014,g_mhap_d[l_ac].mhapownid, 
                   g_mhap_d[l_ac].mhapowndp,g_mhap_d[l_ac].mhapcrtid,g_mhap_d[l_ac].mhapcrtdp,g_mhap_d[l_ac].mhapcrtdt, 
                   g_mhap_d[l_ac].mhapmodid,g_mhap_d[l_ac].mhapmoddt,g_mhap_d[l_ac].mhapcnfid,g_mhap_d[l_ac].mhapcnfdt, 
                   g_mhap_d[l_ac].mhapstus)
                WHERE mhapent = g_enterprise AND
                  mhapdocno = g_mhap_d_t.mhapdocno #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhap_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhap_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhap_d[g_detail_idx].mhapdocno
               LET gs_keys_bak[1] = g_mhap_d_t.mhapdocno
               CALL amht300_update_b('mhap_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_mhap_d_t)
                     LET g_log2 = util.JSON.stringify(g_mhap_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amht300_mhap_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL amht300_unlock_b("mhap_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mhap_d[l_ac].* = g_mhap_d_t.*
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
               LET g_mhap_d[li_reproduce_target].* = g_mhap_d[li_reproduce].*
 
               LET g_mhap_d[li_reproduce_target].mhapdocno = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhap_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhap_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
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
               NEXT FIELD sel
 
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
      IF INT_FLAG OR cl_null(g_mhap_d[g_detail_idx].mhapdocno) THEN
         CALL g_mhap_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_mhap_d[g_detail_idx].* = g_mhap_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE amht300_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="amht300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amht300_delete()
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
   FOR li_idx = 1 TO g_mhap_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT amht300_lock_b("mhap_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("mhap_t","mhapownid") THEN
            LET g_data_owner = g_mhap_d[g_detail_idx].mhapownid
            LET g_data_dept = g_mhap_d[g_detail_idx].mhapowndp
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
   
   FOR li_idx = 1 TO g_mhap_d.getLength()
      IF g_mhap_d[li_idx].mhapdocno IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM mhap_t
          WHERE mhapent = g_enterprise AND 
                mhapdocno = g_mhap_d[li_idx].mhapdocno
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhap_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_mhap_d_t.mhapdocno
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL amht300_delete_b('mhap_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amht300_set_pk_array()
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
   CALL amht300_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="amht300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amht300_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where  STRING   #161006-00008#2 20161017 add by beckxie
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   #161006-00008#2 20161017 add by beckxie---S
   LET l_where = s_aooi500_sql_where(g_prog,'mhapsite')
   LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   #161006-00008#2 20161017 add by beckxie---E
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.mhapdocno,t0.mhapsite,t0.mhap002,t0.mhap010,t0.mhap013,t0.mhap001, 
       t0.mhap005,t0.mhap006,t0.mhap007,t0.mhap008,t0.mhap009,t0.mhap003,t0.mhap004,t0.mhap011,t0.mhap012, 
       t0.mhap014,t0.mhapownid,t0.mhapowndp,t0.mhapcrtid,t0.mhapcrtdp,t0.mhapcrtdt,t0.mhapmodid,t0.mhapmoddt, 
       t0.mhapcnfid,t0.mhapcnfdt,t0.mhapstus ,t1.ooefl003 ,t3.stael003 ,t4.rtaxl003 ,t5.imaal003 ,t6.ooag011 , 
       t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011 FROM mhap_t t0",
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhapsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t3 ON t3.staelent="||g_enterprise||" AND t3.stael001=t0.mhap013 AND t3.stael002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.mhap005 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=t0.mhap006 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mhapownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mhapowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mhapcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.mhapcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.mhapmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.mhapcnfid  ",
 
               " WHERE t0.mhapent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("mhap_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND mhapowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("mhap_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND mhapownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("mhap_t"),
                      " ORDER BY t0.mhapdocno"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
 
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhap_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE amht300_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR amht300_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mhap_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mhap_d[l_ac].mhapdocno,g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhap002, 
       g_mhap_d[l_ac].mhap010,g_mhap_d[l_ac].mhap013,g_mhap_d[l_ac].mhap001,g_mhap_d[l_ac].mhap005,g_mhap_d[l_ac].mhap006, 
       g_mhap_d[l_ac].mhap007,g_mhap_d[l_ac].mhap008,g_mhap_d[l_ac].mhap009,g_mhap_d[l_ac].mhap003,g_mhap_d[l_ac].mhap004, 
       g_mhap_d[l_ac].mhap011,g_mhap_d[l_ac].mhap012,g_mhap_d[l_ac].mhap014,g_mhap_d[l_ac].mhapownid, 
       g_mhap_d[l_ac].mhapowndp,g_mhap_d[l_ac].mhapcrtid,g_mhap_d[l_ac].mhapcrtdp,g_mhap_d[l_ac].mhapcrtdt, 
       g_mhap_d[l_ac].mhapmodid,g_mhap_d[l_ac].mhapmoddt,g_mhap_d[l_ac].mhapcnfid,g_mhap_d[l_ac].mhapcnfdt, 
       g_mhap_d[l_ac].mhapstus,g_mhap_d[l_ac].mhapsite_desc,g_mhap_d[l_ac].mhap013_desc,g_mhap_d[l_ac].mhap005_desc, 
       g_mhap_d[l_ac].mhap006_desc,g_mhap_d[l_ac].mhapownid_desc,g_mhap_d[l_ac].mhapowndp_desc,g_mhap_d[l_ac].mhapcrtid_desc, 
       g_mhap_d[l_ac].mhapcrtdp_desc,g_mhap_d[l_ac].mhapmodid_desc,g_mhap_d[l_ac].mhapcnfid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_mhap_d[l_ac].sel = 'N'
      #end add-point
      
      CALL amht300_detail_show()      
 
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
   
 
   
   CALL g_mhap_d.deleteElement(g_mhap_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_mhap_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_mhap_d.getLength() THEN
      LET l_ac = g_mhap_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhap_d.getLength()
      LET g_mhap_d_mask_o[l_ac].* =  g_mhap_d[l_ac].*
      CALL amht300_mhap_t_mask()
      LET g_mhap_d_mask_n[l_ac].* =  g_mhap_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_mhap_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE amht300_pb
   
END FUNCTION
 
{</section>}
 
{<section id="amht300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION amht300_detail_show()
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
#
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_mhap_d[l_ac].mhapdocno
#   CALL ap_ref_array2(g_ref_fields," SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '"||g_enterprise||"' AND ooefl001 = ? AND ooefl002 = ? ","") RETURNING g_rtn_fields 
#   LET g_mhap_d[l_ac].ooefl003 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhap_d[l_ac].ooefl003
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_mhap_d[l_ac].mhapdocno
#   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = ? ","") RETURNING g_rtn_fields 
#   LET g_mhap_d[l_ac].oocql004 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhap_d[l_ac].oocql004
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_mhap_d[l_ac].mhapdocno
#   CALL ap_ref_array2(g_ref_fields," SELECT stael003 FROM stael_t WHERE staelent = '"||g_enterprise||"' AND stael001 = ? AND stael002 = ? ","") RETURNING g_rtn_fields 
#   LET g_mhap_d[l_ac].stael003 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhap_d[l_ac].stael003
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_mhap_d[l_ac].mhapdocno
#   CALL ap_ref_array2(g_ref_fields," SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = '"||g_enterprise||"' AND rtaxl001 = ? AND rtaxl002 = ? ","") RETURNING g_rtn_fields 
#   LET g_mhap_d[l_ac].rtaxl003 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhap_d[l_ac].rtaxl003
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_mhap_d[l_ac].mhapdocno
#   CALL ap_ref_array2(g_ref_fields," SELECT imaal003 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = ? ","") RETURNING g_rtn_fields 
#   LET g_mhap_d[l_ac].imaal003 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhap_d[l_ac].imaal003
   CALL amht300_mhap010_ref()
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amht300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amht300_set_entry_b(p_cmd)                                                  
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
 
{<section id="amht300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amht300_set_no_entry_b(p_cmd)                                               
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
   CASE p_cmd 
      WHEN "u" 
         IF g_mhap_d[l_ac].mhapstus = 'Y' THEN 
            CALL cl_set_comp_entry("mhapdocno",FALSE)
            CALL cl_set_comp_entry("mhapsite",FALSE)
            CALL cl_set_comp_entry("mhapsite_desc",FALSE)
            CALL cl_set_comp_entry("mhap002",FALSE)
            CALL cl_set_comp_entry("mhap010",FALSE)
            CALL cl_set_comp_entry("mhap010_desc",FALSE)
            CALL cl_set_comp_entry("mhap013",FALSE)
            CALL cl_set_comp_entry("mhap013_desc",FALSE)
            CALL cl_set_comp_entry("mhap001",FALSE)
            CALL cl_set_comp_entry("mhap005",FALSE)
            CALL cl_set_comp_entry("mhap005_desc",FALSE)
            CALL cl_set_comp_entry("mhap006",FALSE)
            CALL cl_set_comp_entry("mhap006_desc",FALSE)
            CALL cl_set_comp_entry("mhap007",FALSE)
            CALL cl_set_comp_entry("mhap008",FALSE)
            CALL cl_set_comp_entry("mhap009",FALSE)
            CALL cl_set_comp_entry("mhap003",FALSE)
            CALL cl_set_comp_entry("mhap004",FALSE)
            CALL cl_set_comp_entry("mhap011",FALSE)
            CALL cl_set_comp_entry("mhap012",FALSE)
            CALL cl_set_comp_entry("mhap014",FALSE)
            CALL cl_set_comp_entry("mhapownid",FALSE)
            CALL cl_set_comp_entry("mhapownid_desc",FALSE)
            CALL cl_set_comp_entry("mhapowndp",FALSE)
            CALL cl_set_comp_entry("mhapowndp_desc",FALSE)
            CALL cl_set_comp_entry("mhapcrtid",FALSE)
            CALL cl_set_comp_entry("mhapcrtid_desc",FALSE)
            CALL cl_set_comp_entry("mhapcrtdp",FALSE)
            CALL cl_set_comp_entry("mhapcrtdp_desc",FALSE)
            CALL cl_set_comp_entry("mhapcrtdt",FALSE)
            CALL cl_set_comp_entry("mhapmodid_desc",FALSE)
            CALL cl_set_comp_entry("mhapmodid",FALSE)
            CALL cl_set_comp_entry("mhapmoddt_desc",FALSE)
            CALL cl_set_comp_entry("mhapcnfid",FALSE)
            CALL cl_set_comp_entry("mhapcnfid_desc",FALSE)
            CALL cl_set_comp_entry("mhapcnfdt",FALSE)
         ELSE
            CALL cl_set_comp_entry("mhapstus",TRUE)
            CALL cl_set_comp_entry("mhapdocno",TRUE)
            CALL cl_set_comp_entry("mhapsite",TRUE)
            CALL cl_set_comp_entry("mhapsite_desc",FALSE)
            CALL cl_set_comp_entry("mhap002",TRUE)
            CALL cl_set_comp_entry("mhap010",TRUE)
            CALL cl_set_comp_entry("mhap010_desc",FALSE)
            CALL cl_set_comp_entry("mhap013",TRUE)
            CALL cl_set_comp_entry("mhap013_desc",FALSE)
            CALL cl_set_comp_entry("mhap001",TRUE)
            CALL cl_set_comp_entry("mhap005",TRUE)
            CALL cl_set_comp_entry("mhap005_desc",FALSE)
            CALL cl_set_comp_entry("mhap006",TRUE)
            CALL cl_set_comp_entry("mhap006_desc",FALSE)
            CALL cl_set_comp_entry("mhap007",TRUE)
            CALL cl_set_comp_entry("mhap008",TRUE)
            CALL cl_set_comp_entry("mhap009",TRUE)
            CALL cl_set_comp_entry("mhap003",TRUE)
            CALL cl_set_comp_entry("mhap004",TRUE)
            CALL cl_set_comp_entry("mhap011",FALSE)
            CALL cl_set_comp_entry("mhap012",FALSE)
            CALL cl_set_comp_entry("mhap014",TRUE)
            CALL cl_set_comp_entry("mhapownid",FALSE)
            CALL cl_set_comp_entry("mhapownid_desc",FALSE)
            CALL cl_set_comp_entry("mhapowndp",FALSE)
            CALL cl_set_comp_entry("mhapowndp_desc",FALSE)
            CALL cl_set_comp_entry("mhapcrtid",FALSE)
            CALL cl_set_comp_entry("mhapcrtid_desc",FALSE)
            CALL cl_set_comp_entry("mhapcrtdp",FALSE)
            CALL cl_set_comp_entry("mhapcrtdp_desc",FALSE)
            CALL cl_set_comp_entry("mhapcrtdt",FALSE)
            CALL cl_set_comp_entry("mhapmodid_desc",FALSE)
            CALL cl_set_comp_entry("mhapmodid",FALSE)
            CALL cl_set_comp_entry("mhapmoddt_desc",FALSE)
            CALL cl_set_comp_entry("mhapcnfid",FALSE)
            CALL cl_set_comp_entry("mhapcnfid_desc",FALSE)
            CALL cl_set_comp_entry("mhapcnfdt",FALSE)
         END IF
      WHEN "a" 
         CALL cl_set_comp_entry("mhapstus",FALSE)
         CALL cl_set_comp_entry("mhapdocno",TRUE)
         CALL cl_set_comp_entry("mhapsite",TRUE)
         CALL cl_set_comp_entry("mhapsite_desc",FALSE)
         CALL cl_set_comp_entry("mhap002",TRUE)
         CALL cl_set_comp_entry("mhap010",TRUE)
         CALL cl_set_comp_entry("mhap010_desc",FALSE)
         CALL cl_set_comp_entry("mhap013",TRUE)
         CALL cl_set_comp_entry("mhap013_desc",FALSE)
         CALL cl_set_comp_entry("mhap001",TRUE)
         CALL cl_set_comp_entry("mhap005",TRUE)
         CALL cl_set_comp_entry("mhap005_desc",FALSE)
         CALL cl_set_comp_entry("mhap006",TRUE)
         CALL cl_set_comp_entry("mhap006_desc",FALSE)
         CALL cl_set_comp_entry("mhap007",TRUE)
         CALL cl_set_comp_entry("mhap008",TRUE)
         CALL cl_set_comp_entry("mhap009",TRUE)
         CALL cl_set_comp_entry("mhap003",TRUE)
         CALL cl_set_comp_entry("mhap004",TRUE)
         CALL cl_set_comp_entry("mhap011",FALSE)
         CALL cl_set_comp_entry("mhap012",FALSE)
         CALL cl_set_comp_entry("mhap014",TRUE)
         CALL cl_set_comp_entry("mhapownid",FALSE)
         CALL cl_set_comp_entry("mhapownid_desc",FALSE)
         CALL cl_set_comp_entry("mhapowndp",FALSE)
         CALL cl_set_comp_entry("mhapowndp_desc",FALSE)
         CALL cl_set_comp_entry("mhapcrtid",FALSE)
         CALL cl_set_comp_entry("mhapcrtid_desc",FALSE)
         CALL cl_set_comp_entry("mhapcrtdp",FALSE)
         CALL cl_set_comp_entry("mhapcrtdp_desc",FALSE)
         CALL cl_set_comp_entry("mhapcrtdt",FALSE)
         CALL cl_set_comp_entry("mhapmodid_desc",FALSE)
         CALL cl_set_comp_entry("mhapmodid",FALSE)
         CALL cl_set_comp_entry("mhapmoddt_desc",FALSE)
         CALL cl_set_comp_entry("mhapcnfid",FALSE)
         CALL cl_set_comp_entry("mhapcnfid_desc",FALSE)
         CALL cl_set_comp_entry("mhapcnfdt",FALSE)
      WHEN "o"
         CALL cl_set_comp_entry("mhapstus",FALSE)
         CALL cl_set_comp_entry("sel",TRUE)
         CALL cl_set_comp_entry("mhapdocno",FALSE)
         CALL cl_set_comp_entry("mhapsite",FALSE)
         CALL cl_set_comp_entry("mhapsite_desc",FALSE)
         CALL cl_set_comp_entry("mhap002",FALSE)
         CALL cl_set_comp_entry("mhap010",FALSE)
         CALL cl_set_comp_entry("mhap010_desc",FALSE)
         CALL cl_set_comp_entry("mhap013",FALSE)
         CALL cl_set_comp_entry("mhap013_desc",FALSE)
         CALL cl_set_comp_entry("mhap001",FALSE)
         CALL cl_set_comp_entry("mhap005",FALSE)
         CALL cl_set_comp_entry("mhap005_desc",FALSE)
         CALL cl_set_comp_entry("mhap006",FALSE)
         CALL cl_set_comp_entry("mhap006_desc",FALSE)
         CALL cl_set_comp_entry("mhap007",FALSE)
         CALL cl_set_comp_entry("mhap008",FALSE)
         CALL cl_set_comp_entry("mhap009",FALSE)
         CALL cl_set_comp_entry("mhap003",FALSE)
         CALL cl_set_comp_entry("mhap004",FALSE)
         CALL cl_set_comp_entry("mhap011",FALSE)
         CALL cl_set_comp_entry("mhap012",FALSE)
         CALL cl_set_comp_entry("mhap014",FALSE)
         CALL cl_set_comp_entry("mhapownid",FALSE)
         CALL cl_set_comp_entry("mhapownid_desc",FALSE)
         CALL cl_set_comp_entry("mhapowndp",FALSE)
         CALL cl_set_comp_entry("mhapowndp_desc",FALSE)
         CALL cl_set_comp_entry("mhapcrtid",FALSE)
         CALL cl_set_comp_entry("mhapcrtid_desc",FALSE)
         CALL cl_set_comp_entry("mhapcrtdp",FALSE)
         CALL cl_set_comp_entry("mhapcrtdp_desc",FALSE)
         CALL cl_set_comp_entry("mhapcrtdt",FALSE)
         CALL cl_set_comp_entry("mhapmodid_desc",FALSE)
         CALL cl_set_comp_entry("mhapmodid",FALSE)
         CALL cl_set_comp_entry("mhapmoddt_desc",FALSE)
         CALL cl_set_comp_entry("mhapcnfid",FALSE)
         CALL cl_set_comp_entry("mhapcnfid_desc",FALSE)
         CALL cl_set_comp_entry("mhapcnfdt",FALSE)
         CALL cl_set_comp_entry("mhapstus",FALSE)
      WHEN "z"
         CALL cl_set_comp_entry("mhapsite",FALSE)
   END CASE
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="amht300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amht300_default_search()
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
      LET ls_wc = ls_wc, " mhapdocno = '", g_argv[01], "' AND "
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
 
{<section id="amht300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amht300_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "mhap_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'mhap_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM mhap_t
          WHERE mhapent = g_enterprise AND
            mhapdocno = ps_keys_bak[1]
         
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
         CALL g_mhap_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="amht300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amht300_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_success   LIKE type_t.chr1
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "mhap_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      IF g_mhap_d[l_ac].mhapstus = 'Y' THEN 
         CALL amht300_expense(ps_keys[1]) RETURNING l_success,g_mhap_d[l_ac].mhap012
      END IF
      IF l_success = TRUE THEN 
         LET g_mhap_d[l_ac].mhap011 = 'Y'
         LET g_mhap_d[l_ac].mhapcnfid = g_user
         LET g_mhap_d[l_ac].mhapcnfdt = g_today
      ELSE 
         LET g_mhap_d[l_ac].mhap011 = 'N'
      END IF
      #end add-point    
      INSERT INTO mhap_t
                  (mhapent,
                   mhapdocno
                   ,mhapsite,mhap002,mhap010,mhap013,mhap001,mhap005,mhap006,mhap007,mhap008,mhap009,mhap003,mhap004,mhap011,mhap012,mhap014,mhapownid,mhapowndp,mhapcrtid,mhapcrtdp,mhapcrtdt,mhapmodid,mhapmoddt,mhapcnfid,mhapcnfdt,mhapstus) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhap002,g_mhap_d[l_ac].mhap010,g_mhap_d[l_ac].mhap013, 
                       g_mhap_d[l_ac].mhap001,g_mhap_d[l_ac].mhap005,g_mhap_d[l_ac].mhap006,g_mhap_d[l_ac].mhap007, 
                       g_mhap_d[l_ac].mhap008,g_mhap_d[l_ac].mhap009,g_mhap_d[l_ac].mhap003,g_mhap_d[l_ac].mhap004, 
                       g_mhap_d[l_ac].mhap011,g_mhap_d[l_ac].mhap012,g_mhap_d[l_ac].mhap014,g_mhap_d[l_ac].mhapownid, 
                       g_mhap_d[l_ac].mhapowndp,g_mhap_d[l_ac].mhapcrtid,g_mhap_d[l_ac].mhapcrtdp,g_mhap_d[l_ac].mhapcrtdt, 
                       g_mhap_d[l_ac].mhapmodid,g_mhap_d[l_ac].mhapmoddt,g_mhap_d[l_ac].mhapcnfid,g_mhap_d[l_ac].mhapcnfdt, 
                       g_mhap_d[l_ac].mhapstus)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      UPDATE mhap_t 
         SET mhapunit = g_site
         #WHERE mhapdocno = ps_keys[1]   #160905-00003#6 20160905 mark  by beckxie
         WHERE mhapent = g_enterprise AND mhapdocno = ps_keys[1]   #160905-00003#6 20160905 add by beckxie
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhap_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
 
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="amht300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amht300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   DEFINE l_success        LIKE type_t.chr5
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
   LET ls_group = "mhap_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mhap_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      IF g_mhap_d[l_ac].mhapstus = 'Y' THEN 
         CALL amht300_expense(ps_keys[1]) RETURNING l_success,g_mhap_d[l_ac].mhap012
      END IF
      IF l_success = TRUE THEN 
         LET g_mhap_d[l_ac].mhap011 = 'Y'
         LET g_mhap_d[l_ac].mhapcnfid = g_user
         LET g_mhap_d[l_ac].mhapcnfdt = g_today
      ELSE 
         LET g_mhap_d[l_ac].mhap011 = 'N'
      END IF
      #end add-point     
      UPDATE mhap_t 
         SET (mhapdocno
              ,mhapsite,mhap002,mhap010,mhap013,mhap001,mhap005,mhap006,mhap007,mhap008,mhap009,mhap003,mhap004,mhap011,mhap012,mhap014,mhapownid,mhapowndp,mhapcrtid,mhapcrtdp,mhapcrtdt,mhapmodid,mhapmoddt,mhapcnfid,mhapcnfdt,mhapstus) 
              = 
             (ps_keys[1]
              ,g_mhap_d[l_ac].mhapsite,g_mhap_d[l_ac].mhap002,g_mhap_d[l_ac].mhap010,g_mhap_d[l_ac].mhap013, 
                  g_mhap_d[l_ac].mhap001,g_mhap_d[l_ac].mhap005,g_mhap_d[l_ac].mhap006,g_mhap_d[l_ac].mhap007, 
                  g_mhap_d[l_ac].mhap008,g_mhap_d[l_ac].mhap009,g_mhap_d[l_ac].mhap003,g_mhap_d[l_ac].mhap004, 
                  g_mhap_d[l_ac].mhap011,g_mhap_d[l_ac].mhap012,g_mhap_d[l_ac].mhap014,g_mhap_d[l_ac].mhapownid, 
                  g_mhap_d[l_ac].mhapowndp,g_mhap_d[l_ac].mhapcrtid,g_mhap_d[l_ac].mhapcrtdp,g_mhap_d[l_ac].mhapcrtdt, 
                  g_mhap_d[l_ac].mhapmodid,g_mhap_d[l_ac].mhapmoddt,g_mhap_d[l_ac].mhapcnfid,g_mhap_d[l_ac].mhapcnfdt, 
                  g_mhap_d[l_ac].mhapstus) 
         WHERE mhapent = g_enterprise AND mhapdocno = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhap_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhap_t:",SQLERRMESSAGE 
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
 
{<section id="amht300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amht300_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL amht300_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mhap_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amht300_bcl USING g_enterprise,
                                       g_mhap_d[g_detail_idx].mhapdocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amht300_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amht300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amht300_unlock_b(ps_table)
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
      CLOSE amht300_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amht300.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION amht300_modify_detail_chk(ps_record)
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
         LET ls_return = "sel"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="amht300.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION amht300_show_ownid_msg()
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
 
{<section id="amht300.mask_functions" >}
&include "erp/amh/amht300_mask.4gl"
 
{</section>}
 
{<section id="amht300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amht300_set_pk_array()
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
   LET g_pk_array[1].values = g_mhap_d[l_ac].mhapdocno
   LET g_pk_array[1].column = 'mhapdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amht300.state_change" >}
   
 
{</section>}
 
{<section id="amht300.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="amht300.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-11-17 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION amht300_mhap010_ref()
   CASE g_mhap_d[l_ac].mhap002
      WHEN '1'   #供應商 
         LET g_mhap_d[l_ac].mhap010_desc = s_desc_get_trading_partner_abbr_desc(g_mhap_d[l_ac].mhap010) 
      WHEN '2'   #專櫃     
         LET g_mhap_d[l_ac].mhap010_desc = s_desc_get_counter_desc(g_mhap_d[l_ac].mhap010)
      WHEN '3'   #內部員工 
         LET g_mhap_d[l_ac].mhap010_desc = s_desc_get_department_desc(g_mhap_d[l_ac].mhap010)
   END CASE
   
   DISPLAY BY NAME g_mhap_d[l_ac].mhap010_desc   
END FUNCTION

################################################################################
# Descriptions...: 生成费用单
# Memo...........:
# Usage..........: CALL amht300_expense(领用单号)
#                  RETURNING r_success,l_stba.stbadocno
# Return code....: 回传 费用单号
# Date & Author..: 2015-11-19 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION amht300_expense(p_mhapdocno)
   DEFINE p_mhapdocno       LIKE mhap_t.mhapdocno
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_err_cnt         LIKE type_t.num5
   DEFINE l_prog            STRING
   DEFINE l_sql             STRING
   DEFINE l_slip_def        STRING                    #預設單據別
   DEFINE l_slip_no         STRING                    #單據編號
   DEFINE l_date            DATETIME YEAR TO SECOND
   DEFINE l_seq             LIKE type_t.num5
   DEFINE l_mhap            RECORD
             mhapsite        LIKE mhap_t.mhapsite, #营运据点
             mhapunit        LIKE mhap_t.mhapunit, #应用组织
             mhap001         LIKE mhap_t.mhap001 , #单据日期
             mhap004         LIKE mhap_t.mhap004 , #申请人员
             mhap003         LIKE mhap_t.mhap003 , #申请部门
             mhap002         LIKE mhap_t.mhap002 , #领用类型
             mhap010         LIKE mhap_t.mhap010   #费用对象
             #inba014         LIKE inba_t.inba014
                            END RECORD
                            
   DEFINE l_stba            RECORD  
             stbaent         LIKE stba_t.stbaent  ,   #企業編號
             stbasite        LIKE stba_t.stbasite ,   #營運據點
             stbaunit        LIKE stba_t.stbaunit ,   #應用組織
             stbadocno       LIKE stba_t.stbadocno,   #單據編號
             stbadocdt       LIKE stba_t.stbadocdt,   #單據日期
             stba001         LIKE stba_t.stba001  ,   #結算中心
             stba002         LIKE stba_t.stba002  ,   #供應商編號
             stba003         LIKE stba_t.stba003  ,   #經營方式
             stba004         LIKE stba_t.stba004  ,   #結算方式
             stba005         LIKE stba_t.stba005  ,   #結算類型 
             stba006         LIKE stba_t.stba006  ,   #來源類型
             stba007         LIKE stba_t.stba007  ,   #來源單號
             stba008         LIKE stba_t.stba008  ,   #人員
             stba009         LIKE stba_t.stba009  ,   #部門
             stba010         LIKE stba_t.stba010  ,   #合同編號
             stba011         LIKE stba_t.stba011  ,   #幣別
             stba012         LIKE stba_t.stba012  ,   #稅別
             stba013         LIKE stba_t.stba013  ,   #專櫃編號
             stba014         LIKE stba_t.stba014  ,   #費用類型
             stba015         LIKE stba_t.stba015  ,   #交款狀態
             stba000         LIKE stba_t.stba000  ,   #程式編號
             stba016         LIKE stba_t.stba016  ,   #交款人
             stbastus        LIKE stba_t.stbastus ,   #狀態碼                     
             stbaownid       LIKE stba_t.stbaownid,   #資料所有者
             stbaowndp       LIKE stba_t.stbaowndp,   #資料所有部門
             stbacrtid       LIKE stba_t.stbacrtid,   #資料建立者
             stbacrtdp       LIKE stba_t.stbacrtdp,   #資料建立部門
             stbacrtdt       LIKE stba_t.stbacrtdt,   #資料創建日
             stbamodid       LIKE stba_t.stbamodid,   #資料修改者
             stbamoddt       LIKE stba_t.stbamoddt    #最近修改日
                            END RECORD
   DEFINE l_stbb            RECORD                              
             stbbent         LIKE stbb_t.stbbent  ,   #企業編號
             stbbunit        LIKE stbb_t.stbbunit ,   #應用組織
             stbbsite        LIKE stbb_t.stbbsite ,   #營運據點
             stbbdocno       LIKE stbb_t.stbbdocno,   #單據編號
             stbbseq         LIKE stbb_t.stbbseq  ,   #項次
             stbb001         LIKE stbb_t.stbb001  ,   #費用編號
             stbb002         LIKE stbb_t.stbb002  ,   #幣別
             stbb003         LIKE stbb_t.stbb003  ,   #稅別
             stbb004         LIKE stbb_t.stbb004  ,   #價款類別
             stbb005         LIKE stbb_t.stbb005  ,   #起始日期
             stbb006         LIKE stbb_t.stbb006  ,   #截止日期
             stbb007         LIKE stbb_t.stbb007  ,   #結算會計期
             stbb008         LIKE stbb_t.stbb008  ,   #財務會計期
             stbb009         LIKE stbb_t.stbb009  ,   #費用金額
             stbb010         LIKE stbb_t.stbb010  ,   #承擔對象
             stbb011         LIKE stbb_t.stbb011  ,   #所屬品類
             stbb012         LIKE stbb_t.stbb012  ,   #所屬部門
             stbb013         LIKE stbb_t.stbb013  ,   #結算對象
             stbb014         LIKE stbb_t.stbb014  ,   #財務會計期別
             stbb015         LIKE stbb_t.stbb015  ,   #納入結算單否
             stbb016         LIKE stbb_t.stbb016  ,   #票扣否
             stbb017         LIKE stbb_t.stbb017  ,   #備註
             stbb018         LIKE stbb_t.stbb018  ,   #結算帳期
             stbb019         LIKE stbb_t.stbb019  ,   #结算日期        
             stbbud001       LIKE stbb_t.stbbud001    #含发票否        
                            END RECORD
                            
   DEFINE l_rtaw003_para     LIKE rtaw_t.rtaw003      #管理品類層級-參數
   DEFINE l_stfa050         LIKE stfa_t.stfa050      
   LET r_success   = TRUE
   LET l_err_cnt   = 0
   LET l_date      = cl_get_current()
   LET l_prog      = NULL
   LET l_slip_def  = NULL
   LET l_slip_no   = NULL
   LET l_rtaw003_para = cl_get_para(g_enterprise,"","E-CIR-0001")
   INITIALIZE l_mhap.* TO NULL
   INITIALIZE l_stba.* TO NULL
   INITIALIZE l_stbb.* TO NULL
   
   LET l_sql = "SELECT  mhapsite, ",   #营运据点
               "        mhapunit, ",   #应用组织
               "        mhap001 , ",   #单据日期
               "        mhap004 , ",   #申请人员
               "        mhap003 , ",   #申请部门
               "        mhap002 , ",   #领用类型
               "        mhap010   ",   #费用对象
               "  FROM mhap_t ",
               " WHERE mhapent = ",g_enterprise,
               "   AND mhapdocno = '",p_mhapdocno,"' "    
   PREPARE s_expense_mhap_sel FROM l_sql
   
   #取供應商合約
   LET l_sql = "SELECT UNIQUE stan001,stan002,stan006,stan007,stan009, ",  #合約編號,經營方式,幣別,稅別,結算方式
               "              stan010,stan015 ",                           #結算類別,結算中心
               "  FROM stan_t ",
               " WHERE stanent = ",g_enterprise,
               "   AND stan005 = ? ",#费用对象-供应商
               "   AND stan002 = '1' ",
              #"   AND ? BETWEEN stan017 AND stan018 ",
               "   AND stan029 IN ('3','4','5') ",
               "   AND stanstus = 'Y' ",
               "   AND EXISTS(SELECT 1 FROM stbo_t WHERE stboent = stanent AND stbo001 = stan001 AND stbo003 = ?) ",
               " ORDER BY stan007 DESC "
   PREPARE s_expense_stan_sel_pre FROM l_sql
   DECLARE s_expense_stan_sel_cur SCROLL CURSOR FOR s_expense_stan_sel_pre
   
   #取專櫃合約     
   LET l_sql = "SELECT stfa001,stfa003,stfa032,stfa034,stfa036, ",        #合約編號,經營方式,幣別,稅別,結算方式
               "       stfa037,stfa038 ",                                 #結算類別,結算中心
               "  FROM stfa_t ",
               " WHERE stfaent = ",g_enterprise,
               "   AND stfa005 = ? ",#费用对象-专柜
               "   AND stfa004 NOT IN ('1','7') ",
               "   AND stfastus = 'Y' ",
               " ORDER BY stfa019 DESC "            
   PREPARE s_expense_stfa_sel_pre FROM l_sql
   DECLARE s_expense_stfa_sel_cur SCROLL CURSOR FOR s_expense_stfa_sel_pre

   #取領用明細    
   LET l_sql = "SELECT mhap013,SUM(mhap009),mhap005 ",  #費用編號,領用金額,品類層級
               "  FROM mhap_t ",
               " WHERE mhapent = '",g_enterprise,"' ",
               "   AND mhapdocno = '",p_mhapdocno,"' ",
               " GROUP BY mhap013,mhap005 "               
   PREPARE s_expense_detail_sel_pre FROM l_sql
   DECLARE s_expense_detail_sel_cur CURSOR FOR s_expense_detail_sel_pre
   
   #寫入費用單/交款單單頭
   LET l_sql = "INSERT INTO stba_t(stbaent  ,stbasite ,stbaunit ,stbadocno,stbadocdt, ",   #企業編號,營運據點,應用組織,單據編號,單據日期
               "                   stba001  ,stba002  ,stba003  ,stba004  ,stba005  , ",   #結算中心,供應商編號,經營方式,結算方式,結算類型
               "                   stba006  ,stba007  ,stba008  ,stba009  ,stba010  , ",   #來源類型,來源單號,人員,部門,合同編號
               "                   stba011  ,stba012  ,stba013  ,stba014  ,stba015  , ",   #幣別,稅別,專櫃編號,費用類型,交款狀態
               "                   stba000  ,stba016  ,stbastus ,                     ",   #程式編號,交款人,狀態碼
               "                   stbaownid,stbaowndp,stbacrtid,stbacrtdp,stbacrtdt, ",   #資料所有者,資料所有部門,資料建立者,資料建立部門,資料創建日
               "                   stbamodid,stbamoddt)                               ",   #資料修改者,最近修改日
               "VALUES (?   ,?   ,?   ,?   ,?   , ",     #企業編號,營運據點,應用組織,單據編號,單據日期
               "        ?   ,?   ,?   ,?   ,?   , ",     #結算中心,供應商編號,經營方式,結算方式,結算類型
               "        ?   ,?   ,?   ,?   ,?   , ",     #來源類型,來源單號,人員,部門,合同編號
               "        ?   ,?   ,?   ,?   ,?   , ",     #幣別,稅別,專櫃編號,費用類型,交款狀態
               "        ?   ,?   ,?   ,           ",     #程式編號,交款人,狀態碼
               "        ?   ,?   ,?   ,?   ,?   , ",     #資料所有者,資料所有部門,資料建立者,資料建立部門,資料創建日
               "        ?   ,?   ) "                     #資料修改者,最近修改日
   PREPARE s_expense_amht300_stba_ins FROM l_sql
  
   #寫入費用單/交款單單身
   LET l_sql = "INSERT INTO stbb_t(stbbent  ,stbbunit ,stbbsite ,stbbdocno,stbbseq  , ",   #企業編號,應用組織,營運據點,單據編號,項次
               "                   stbb001  ,stbb002  ,stbb003  ,stbb004  ,stbb005  , ",   #費用編號,幣別,稅別,價款類別,起始日期
               "                   stbb006  ,stbb007  ,stbb008  ,stbb009  ,stbb010  , ",   #截止日期,結算會計期,財務會計期,費用金額,承擔對象
               "                   stbb011  ,stbb012  ,stbb013  ,stbb014  ,stbb015  , ",   #所屬品類,所屬部門,結算對象,財務會計期別,納入結算單否
               "                   stbb016  ,stbb017  ,stbb018  ,stbb019  ,stbbud001) ",   #票扣否,備註,結算帳期,结算日期,含发票否 #add by geza 20150831 add stbb019 20151010 stbbud001
               "VALUES (?   ,?   ,?   ,?   ,?   , ", 
               "        ?   ,?   ,?   ,?   ,?   , ",
               "        ?   ,?   ,?   ,?   ,?   , ",
               "        ?   ,?   ,?   ,?   ,?   , ",
               "        ?   ,?   ,?   ,?   ,?)    "
   PREPARE s_expense_amht300_stbb_ins FROM l_sql  
   
   EXECUTE s_expense_mhap_sel INTO l_mhap.mhapsite,
                                   l_mhap.mhapunit,
                                   l_mhap.mhap001 ,
                                   l_mhap.mhap004 ,
                                   l_mhap.mhap003 ,
                                   l_mhap.mhap002 ,
                                   l_mhap.mhap010 
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE:s_expense_mhap_sel" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success,''
   END IF             
   
   #费用单类型
      CASE l_mhap.mhap002
         WHEN '1'   #供应商领用
            LET l_prog = 'astt320'                  
            LET l_stba.stba014 = '1'   #供应商费用单
            LET l_stba.stba015 = ''             
         WHEN '2'   #专柜领用
            LET l_prog = 'astt510'
            LET l_stba.stba014 = '2'   #专柜费用单
            LET l_stba.stba015 = ''
      END CASE

   
   #写费用单
   LET l_stba.stbaent   = g_enterprise     #企業編號
   LET l_stba.stbasite  = l_mhap.mhapsite  #營運據點
   LET l_stba.stbaunit  = l_mhap.mhapunit  #應用組織   
   LET l_stba.stbadocdt = g_today          #單據日期
   LET l_stba.stba006   = '16'             #來源類型 ---物料领用
   LET l_stba.stba007   = p_mhapdocno      #來源單號
   LET l_stba.stba008   = l_mhap.mhap004   #人員
   LET l_stba.stba009   = l_mhap.mhap003   #部門
   LET l_stba.stba015   = 'N'              #交款狀態
   LET l_stba.stba000   = l_prog           #程式編號
   LET l_stba.stbastus  = 'N'              #狀態碼                     
   LET l_stba.stbaownid = g_user           #資料所有者
   LET l_stba.stbaowndp = g_dept           #資料所有部門
   LET l_stba.stbacrtid = g_user           #資料建立者
   LET l_stba.stbacrtdp = g_dept           #資料建立部門
   LET l_stba.stbacrtdt = l_date           #資料創建日
   LET l_stba.stbamodid = g_user           #資料修改者
   LET l_stba.stbamoddt = l_date           #最近修改日   

   LET l_stbb.stbbent    = g_enterprise     #企業編號
   LET l_stbb.stbbunit   = l_mhap.mhapunit  #應用組織
   LET l_stbb.stbbsite   = l_mhap.mhapsite  #營運據點
   LET l_stbb.stbb005    = g_today          #起始日期
   LET l_stbb.stbb006    = g_today          #截止日期
   
   CASE l_mhap.mhap002
      WHEN '1'        #供應商領用
         LET l_stba.stba002 = l_mhap.mhap010 
         LET l_stba.stba013 = '' 

         OPEN s_expense_stan_sel_cur USING l_mhap.mhap010,l_mhap.mhapsite
         FETCH FIRST s_expense_stan_sel_cur INTO l_stba.stba010,l_stba.stba003,l_stba.stba011,l_stba.stba012,l_stba.stba004,   #合約編號,經營方式,幣別,稅別,結算方式
                                                 l_stba.stba005,l_stba.stba001                                                 #結算類別,結算中心,管理品類

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:s_expense_stan_sel_cur" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            
            LET r_success = FALSE
            RETURN r_success,''
         END IF   
         
         CLOSE s_expense_stan_sel_pre
                 
      WHEN '2'     #專櫃領用 
          LET l_stba.stba002 = ''  
          LET l_stba.stba013 = l_mhap.mhap010 
         #获取供应商
          CALL s_astt401_stey003_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stba.stba002
          
          OPEN s_expense_stfa_sel_cur USING l_mhap.mhap010 
          FETCH FIRST s_expense_stfa_sel_cur INTO l_stba.stba010,l_stba.stba003,l_stba.stba011,l_stba.stba012,l_stba.stba004,   #合約編號,經營方式,幣別,稅別,結算方式
                                                  l_stba.stba005,l_stba.stba001                                                 #結算類別,結算中心
         
          CALL s_astt401_stey004_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stba.stba012   #税别 lanjj add on 2016-07-28
          CALL s_astt401_stey006_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stba.stba001   #结算中心 anjj add on 2016-07-28
          
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "FETCH:s_expense_stfa_sel_cur" 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             
             LET r_success = FALSE
             RETURN r_success,''
          END IF    
          
          CLOSE s_expense_stfa_sel_cur  
                     
#      WHEN '3'   #內部員工領用
#          LET l_stba.stba002  = ''
#          LET l_stba.stba013  = ''
   END CASE
  
  #单别  
   LET l_success = ''
   CALL s_arti200_get_def_doc_type(l_mhap.mhapsite,l_prog,'1') RETURNING l_success,l_slip_def
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success,''
   END IF  
  #自动编号    
   LET l_success = ''
   CALL s_aooi200_gen_docno(g_site,l_slip_def,g_today,l_prog) RETURNING l_success,l_slip_no 
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success,''
   END IF
    
   LET l_stba.stbadocno = l_slip_no        #單據編號


   EXECUTE s_expense_amht300_stba_ins
     USING l_stba.stbaent  ,l_stba.stbasite ,l_stba.stbaunit ,l_stba.stbadocno,l_stba.stbadocdt,    #企業編號,營運據點,應用組織,單據編號,單據日期
           l_stba.stba001  ,l_stba.stba002  ,l_stba.stba003  ,l_stba.stba004  ,l_stba.stba005  ,    #結算中心,供應商編號,經營方式,結算方式,結算類型
           l_stba.stba006  ,l_stba.stba007  ,l_stba.stba008  ,l_stba.stba009  ,l_stba.stba010  ,    #來源類型,來源單號,人員,部門,合同編號
           l_stba.stba011  ,l_stba.stba012  ,l_stba.stba013  ,l_stba.stba014  ,l_stba.stba015  ,    #幣別,稅別,專櫃編號,費用類型,交款狀態
           l_stba.stba000  ,l_stba.stba016  ,l_stba.stbastus ,                                      #程式編號,交款人,狀態碼
           l_stba.stbaownid,l_stba.stbaowndp,l_stba.stbacrtid,l_stba.stbacrtdp,l_stba.stbacrtdt,    #資料所有者,資料所有部門,資料建立者,資料建立部門,資料創建日
           l_stba.stbamodid,l_stba.stbamoddt                                                        #資料修改者,最近修改日         
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE:s_expense_amht300_stba_ins" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success,''
   END IF  
    
   LET l_stbb.stbbdocno  = l_slip_no        #單據編號
   LET l_stbb.stbb002    = l_stba.stba011   #幣別
   LET l_stbb.stbb003    = l_stba.stba012   #稅別
   LET l_stbb.stbb010    = '1'              #承擔對象
   LET l_stbb.stbb012    = l_mhap.mhap004   #所屬部門
   LET l_stbb.stbb013    = '1'              #結算對象
   
   LET l_seq = 0
   
   FOREACH s_expense_detail_sel_cur INTO l_stbb.stbb001,l_stbb.stbb009,l_stbb.stbb011 #费用编号，金额，品类
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:s_expense_detail_sel_cur" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success,''
      END IF
      
      SELECT MAX(stbbseq) INTO l_seq
        FROM stbb_t
       WHERE stbbent = g_enterprise
         AND stbbdocno = l_stbb.stbbdocno

      IF cl_null(l_seq) THEN
         LET l_seq = 0
      END IF
      
      LET l_stbb.stbbseq    = l_seq + 1 #項次

      #價款類別,納入結算單否,票扣否
      SELECT stae006,stae011,stae007
        INTO l_stbb.stbb004,l_stbb.stbb015,l_stbb.stbb016
        FROM stae_t
       WHERE staeent = g_enterprise
         AND stae001 = l_stbb.stbb001

      IF cl_null(l_stbb.stbb015) THEN
         LET l_stbb.stbb015 = 'Y'
      END IF
      IF cl_null(l_stbb.stbb016) THEN
         LET l_stbb.stbb016 = 'N'
      END IF
      
      CASE l_mhap.mhap002
         WHEN '1'        #供應商領用
             #根据开始日期结束日期抓取专柜合同结算账期和结算日期
             CALL s_settle_date_get_stbb019(l_stba.stba010,l_stbb.stbb005,l_stbb.stbb006,'1') 
                RETURNING  l_stbb.stbb018,l_stbb.stbb019      
                    
         WHEN '2'     #專櫃領用 
             #根据开始日期结束日期抓取专柜合同结算账期和结算日期
             CALL s_settle_date_get_stbb019(l_stba.stba010,l_stbb.stbb005,l_stbb.stbb006,'2') 
                RETURNING  l_stbb.stbb018,l_stbb.stbb019  

             #抓取纳入结算单否
             INITIALIZE l_stfa050 TO NULL
             SELECT stfa050 INTO l_stfa050
               FROM stfa_t
              WHERE stfaent = g_enterprise
                AND stfastus = 'Y' 
                AND stfa001 = l_stba.stba010
             CALL s_astt401_get_stae007(l_stfa050,l_stbb.stbb001)  RETURNING  l_stbb.stbb015,l_stbb.stbb016   

#             #抓取合同的管理品类
#             SELECT stfa051 INTO l_stbb.stbb011
#               FROM stfa_t 
#              WHERE stfaent= g_enterprise
#                AND stfa001 = l_stba.stba010
#                AND stfastus = 'Y'
                
#             SELECT stfa050 INTO l_stbb.stbbud001
#               FROM stfa_t
#              WHERE stfaent = g_enterprise
#                AND stfa001 = l_stba.stba010
             CALL s_astt401_stey005_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stbb.stbbud001 #含发票否 lanjj add on 2016-07-28
             
             #票扣否=Y，税带合同里面的，票扣否=N，税带费用编号asti203里面的
             IF l_stbb.stbb016 = 'Y' THEN
#               SELECT stfa033 INTO l_stbb.stbb003
#                 FROM stfa_t
#                WHERE stfaent=g_enterprise
#                  AND stfa001=l_stba.stba010
                CALL s_astt401_stey004_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stbb.stbb003   #税别 lanjj add on 2016-07-28   
             ELSE
                SELECT stae010 INTO l_stbb.stbb003
                  FROM stae_t
                 WHERE staeent = g_enterprise
                   AND stae001 = l_stbb.stbb001
             END IF

      END CASE
      
      
      #結算會計期,財務會計期,財務會計期別
      LET l_success = ''
      CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,l_prog)
        RETURNING l_success,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb014   
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success,''
      END IF
      
      
#      #若為退回單,金額為負數
#      IF g_prog = 'aint912' THEN
#         LET l_stbb.stbb009 = l_stbb.stbb009 * (-1)
#      END IF
      CALL s_curr_round(l_stbb.stbbsite,l_stba.stba011,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009   #add by yangxf 
      
      EXECUTE s_expense_amht300_stbb_ins
       USING l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,   #企業編號,應用組織,營運據點,單據編號,項次
              l_stbb.stbb001,l_stbb.stbb002 ,l_stbb.stbb003 ,l_stbb.stbb004  ,l_stbb.stbb005,  #費用編號,幣別,稅別,價款類別,起始日期
              l_stbb.stbb006,l_stbb.stbb007 ,l_stbb.stbb008 ,l_stbb.stbb009  ,l_stbb.stbb010,  #截止日期,結算會計期,財務會計期,費用金額,承擔對象
              l_stbb.stbb011,l_stbb.stbb012 ,l_stbb.stbb013 ,l_stbb.stbb014  ,l_stbb.stbb015,  #所屬品類,所屬部門,結算對象,財務會計期別,納入結算單否
              l_stbb.stbb016,l_stbb.stbb017 ,l_stbb.stbb018 ,l_stbb.stbb019  ,l_stbb.stbbud001 #票扣否,備註,結算帳期,结算日期,含发票否  #add by geza 20150831 add stbb019,20151010 stbbud001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "EXECUTE:s_expense_amht300_stbb_ins" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET l_err_cnt = l_err_cnt + 1
      END IF                    
   END FOREACH 

   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success,l_stba.stbadocno
END FUNCTION

################################################################################
# Descriptions...: 批量审核按钮功能
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-11-23 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION amht300_onaction_expense()
   DEFINE l_ac1      LIKE type_t.num5
   DEFINE i          LIKE type_t.num5
   DEFINE l_success  LIKE type_t.chr5
   DEFINE l_mhap012  LIKE mhap_t.mhap012
   DEFINE l_result   LIKE type_t.num5
   DEFINE l_str      STRING 

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhap_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         #自訂ACTION(detail_input,page_1)
         BEFORE INPUT
            CALL FGL_SET_ARR_CURR(1) 
            CALL amht300_b_fill(g_wc2)
            LET g_detail_cnt = g_mhap_d.getLength()
         
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.h_index
            CALL amht300_set_no_entry_b("o")
      END INPUT 
      
   ON ACTION accept
      FOR i = 1 TO g_mhap_d.getLength()
         IF g_mhap_d[i].sel = 'Y' THEN
            LET l_str = l_str,"\n",g_mhap_d[i].mhapdocno
         ELSE 
            LET l_str = l_str
         END IF
      END FOR 
      
      IF cl_ask_confirm_parm('amh-00620',l_str) THEN
         CALL cl_err_collect_init() 
         CALL s_transaction_begin()
         FOR l_ac1 = 1 TO g_mhap_d.getLength()
            IF g_mhap_d[l_ac1].sel = 'Y' THEN
               IF g_mhap_d[l_ac1].mhapstus = 'N' THEN 
                  IF cl_null(g_mhap_d[l_ac1].mhap006) THEN 
                     IF g_mhap_d[l_ac1].mhap002 = '1' OR g_mhap_d[l_ac1].mhap002 = '2' THEN 
                        CALL amht300_expense(g_mhap_d[l_ac1].mhapdocno) RETURNING l_success,l_mhap012
                        IF l_success = TRUE THEN 
                           UPDATE mhap_t 
                              SET mhap011 = 'Y',
                                  mhap012 = l_mhap012,
                                  mhapstus = 'Y',
                                  mhapcnfid = g_user,
                                  mhapcnfdt = g_today
                            #WHERE mhapdocno = g_mhap_d[l_ac1].mhapdocno   #160905-00003#6 20160905 mark  by beckxie
                            WHERE mhapent = g_enterprise                   #160905-00003#6 20160905 add  by beckxie
                              AND mhapdocno = g_mhap_d[l_ac1].mhapdocno    #160905-00003#6 20160905 add  by beckxie
                            
                        ELSE 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = g_mhap_d[l_ac1].mhapdocno,"费用单生成失败～" 
                           LET g_errparam.code   = "adz-00482"
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err() 
                           CONTINUE FOR
                        END IF
                     ELSE 
                        UPDATE mhap_t 
                           SET mhapstus = 'Y',
                               mhapcnfid = g_user,
                               mhapcnfdt = g_today
                         #WHERE mhapdocno = g_mhap_d[l_ac1].mhapdocno   #160905-00003#6 20160905 mark  by beckxie
                         WHERE mhapent = g_enterprise                   #160905-00003#6 20160905 add  by beckxie
                           AND mhapdocno = g_mhap_d[l_ac1].mhapdocno    #160905-00003#6 20160905 add  by beckxie
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_mhap_d[l_ac1].mhapdocno,"TIPS：内部领用不产生费用单～" 
                        LET g_errparam.code   = "adz-00482"
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     END IF
                  ELSE 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhap_d[l_ac1].mhapdocno,"商品编号为空，不能审核～" 
                     LET g_errparam.code   = "adz-00482"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     CONTINUE FOR
                  END IF 
               ELSE 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_mhap_d[l_ac1].mhapdocno,"费用单已经生成,不用再次生成～" 
                  LET g_errparam.code   = "adz-00482"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE FOR
               END IF
            ELSE 
               CONTINUE FOR
            END IF                   
         END FOR 
      ELSE 
         RETURN
      END IF
      CALL cl_err_collect_show()
      CALL s_transaction_end('Y',1) 
      CALL amht300_b_fill(g_wc2)
 
   ON ACTION cancel
      LET INT_FLAG = TRUE 
      CANCEL DIALOG
   
   END DIALOG 


END FUNCTION

################################################################################
# Descriptions...: 批量取消审核按钮
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-11-23 BY lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION amht300_onaction_unexpense()
   DEFINE l_ac2      LIKE type_t.num5
   DEFINE i          LIKE type_t.num5
   DEFINE l_success  LIKE type_t.chr5
   DEFINE l_mhap012  LIKE mhap_t.mhap012
   DEFINE l_stbastus LIKE stba_t.stbastus
   DEFINE l_result   LIKE type_t.num5
   DEFINE l_str      STRING 

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhap_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         #自訂ACTION(detail_input,page_1)
         BEFORE INPUT
            CALL FGL_SET_ARR_CURR(1) 
            CALL amht300_b_fill(g_wc2)
            LET g_detail_cnt = g_mhap_d.getLength()
         
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.h_index
            CALL amht300_set_no_entry_b("o")
          
      END INPUT 
      
   ON ACTION accept
      FOR i = 1 TO g_mhap_d.getLength()
         IF g_mhap_d[i].sel = 'Y' THEN
            LET l_str = l_str,"\n",g_mhap_d[i].mhapdocno
         ELSE 
            LET l_str = l_str
         END IF
      END FOR 
      
      IF cl_ask_confirm_parm('amh-00621',l_str) THEN 
         CALL cl_err_collect_init() 
            CALL s_transaction_begin()
            FOR l_ac2 = 1 TO g_mhap_d.getLength()
               IF g_mhap_d[l_ac2].sel = 'Y' THEN
                  IF NOT cl_null(g_mhap_d[l_ac2].mhap012) THEN 
                     IF g_mhap_d[l_ac2].mhapstus = 'Y' THEN 
                        SELECT stbastus INTO l_stbastus
                          FROM stba_t 
                         WHERE stbaent = g_enterprise 
                           AND stbadocno = g_mhap_d[l_ac2].mhap012
                        IF l_stbastus = 'N' THEN 
                           DELETE FROM stbb_t
                            WHERE stbbent = g_enterprise 
                              AND stbbdocno = g_mhap_d[l_ac2].mhap012    
                           DELETE FROM stba_t
                            WHERE stbaent = g_enterprise 
                              AND stbadocno = g_mhap_d[l_ac2].mhap012                             
                           UPDATE mhap_t 
                              SET mhap012 = '',
                                  mhap011 = 'N',
                                  mhapstus = 'N',                                  
                                  mhapcnfid = '',
                                  mhapcnfdt = ''
                            WHERE mhapent = g_enterprise 
                              AND mhapdocno = g_mhap_d[l_ac2].mhapdocno
                        ELSE 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = g_mhap_d[l_ac2].mhap012,"费用单不是未审核状态，无法取消审核噢～" 
                           LET g_errparam.code   = "adz-00482"
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err() 
                           CONTINUE FOR
                        END IF
                     ELSE 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_mhap_d[l_ac2].mhapdocno,"费用单还未生成,无法取消审核～～" 
                        LET g_errparam.code   = "adz-00482"
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CONTINUE FOR
                     END IF
                  ELSE 
                     UPDATE mhap_t 
                        SET mhapstus = 'N',                                  
                            mhapcnfid = '',
                            mhapcnfdt = ''
                      WHERE mhapent = g_enterprise 
                        AND mhapdocno = g_mhap_d[l_ac2].mhapdocno
                  END IF
               ELSE 
                  CONTINUE FOR
               END IF                   
            END FOR 
            CALL cl_err_collect_show()
            CALL s_transaction_end('Y',1) 
            CALL amht300_b_fill(g_wc2)
         ELSE 
            RETURN
         END IF
 
   ON ACTION cancel
      LET INT_FLAG = TRUE 
      CANCEL DIALOG
   
   END DIALOG 


END FUNCTION

################################################################################
# Descriptions...: 当前单张单据审核
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-11-23 BY lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION amht300_onaction_expense_1()
   DEFINE l_ac1      LIKE type_t.num5
   DEFINE i          LIKE type_t.num5
   DEFINE l_success  LIKE type_t.chr5
   DEFINE l_mhap012  LIKE mhap_t.mhap012
   DEFINE l_result   LIKE type_t.num5
   DEFINE l_str      STRING 

   LET l_str = ''
   LET l_str = l_str,"\n",g_mhap_d[g_detail_idx].mhapdocno

   IF cl_ask_confirm_parm('amh-00620',l_str) THEN 
      CALL cl_err_collect_init() 
      CALL s_transaction_begin()
      IF g_mhap_d[g_detail_idx].mhapstus = 'N' THEN 
         IF cl_null(g_mhap_d[g_detail_idx].mhap006) THEN
            IF g_mhap_d[g_detail_idx].mhap002 = '1' OR g_mhap_d[g_detail_idx].mhap002 = '2' THEN 
               CALL amht300_expense(g_mhap_d[g_detail_idx].mhapdocno) RETURNING l_success,l_mhap012
               IF l_success = TRUE THEN 
                  UPDATE mhap_t 
                     SET mhap011 = 'Y',
                         mhap012 = l_mhap012,
                         mhapstus = 'Y',
                         mhapcnfid = g_user,
                         mhapcnfdt = g_today
                   #WHERE mhapdocno = g_mhap_d[g_detail_idx].mhapdocno   #160905-00003#6 20160905 mark by beckxie
                   WHERE mhapent = g_enterprise                          #160905-00003#6 20160905 add by beckxie
                     AND mhapdocno = g_mhap_d[g_detail_idx].mhapdocno    #160905-00003#6 20160905 add by beckxie
               ELSE 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_mhap_d[g_detail_idx].mhapdocno,"费用单生成失败～～" 
                  LET g_errparam.code   = "adz-00482"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
               END IF
            ELSE 
               UPDATE mhap_t 
                  SET mhapstus = 'Y',
                      mhapcnfid = g_user,
                      mhapcnfdt = g_today
                #WHERE mhapdocno = g_mhap_d[g_detail_idx].mhapdocno   #160905-00003#6 20160905 mark by beckxie
                WHERE mhapent = g_enterprise                          #160905-00003#6 20160905 add by beckxie
                  AND mhapdocno = g_mhap_d[g_detail_idx].mhapdocno    #160905-00003#6 20160905 add by beckxie
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mhap_d[g_detail_idx].mhapdocno,"TIPS：内部领用不产生费用单～～" 
               LET g_errparam.code   = "adz-00482"
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
         ELSE 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_mhap_d[g_detail_idx].mhapdocno,"商品编号为空，不能审核～" 
            LET g_errparam.code   = "adz-00482"
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
         END IF
      ELSE 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mhap_d[g_detail_idx].mhapdocno,"费用单已经生成,不用再次生成～～" 
         LET g_errparam.code   = "adz-00482"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   ELSE 
      RETURN
   END IF
   CALL cl_err_collect_show()
   CALL s_transaction_end('Y',1) 
   CALL amht300_b_fill(g_wc2)
   
END FUNCTION

################################################################################
# Descriptions...: 单张单据取消审核
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-11-23 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION amht300_onaction_unexpense_1()
   DEFINE l_ac2      LIKE type_t.num5
   DEFINE i          LIKE type_t.num5
   DEFINE l_success  LIKE type_t.chr5
   DEFINE l_mhap012  LIKE mhap_t.mhap012
   DEFINE l_stbastus LIKE stba_t.stbastus
   DEFINE l_result   LIKE type_t.num5
   DEFINE l_str      STRING 

   LET l_str = l_str,"\n",g_mhap_d[g_detail_idx].mhapdocno
 
   IF cl_ask_confirm_parm('amh-00621',l_str) THEN 
      CALL cl_err_collect_init() 
      CALL s_transaction_begin()
      IF g_mhap_d[g_detail_idx].mhapstus = 'Y' THEN 
         IF NOT cl_null(g_mhap_d[g_detail_idx].mhap012) THEN
            SELECT stbastus INTO l_stbastus
              FROM stba_t 
             WHERE stbaent = g_enterprise 
               AND stbadocno = g_mhap_d[g_detail_idx].mhap012
            IF l_stbastus = 'N' THEN 
               DELETE FROM stbb_t
                WHERE stbbent = g_enterprise 
                  AND stbbdocno = g_mhap_d[g_detail_idx].mhap012    
               DELETE FROM stba_t
                WHERE stbaent = g_enterprise 
                  AND stbadocno = g_mhap_d[g_detail_idx].mhap012                             
               UPDATE mhap_t 
                  SET mhap012 = '',
                      mhap011 = 'N',
                      mhapstus = 'N',                                  
                      mhapcnfid = '',
                      mhapcnfdt = ''
                WHERE mhapent = g_enterprise 
                  AND mhapdocno = g_mhap_d[g_detail_idx].mhapdocno
            ELSE 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mhap_d[g_detail_idx].mhap012,"费用单不是未审核状态，无法取消审核噢～" 
               LET g_errparam.code   = "adz-00482"
               LET g_errparam.popup  = TRUE 
               CALL cl_err() 
            END IF
         ELSE 
            UPDATE mhap_t 
               SET mhapstus = 'N',                                  
                   mhapcnfid = '',
                   mhapcnfdt = ''
             WHERE mhapent = g_enterprise 
               AND mhapdocno = g_mhap_d[g_detail_idx].mhapdocno
         END IF
      ELSE 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mhap_d[g_detail_idx].mhapdocno,"费用单还未生成,无法取消审核～～" 
         LET g_errparam.code   = "adz-00482"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF 
      CALL cl_err_collect_show()
      CALL s_transaction_end('Y',1) 
      CALL amht300_b_fill(g_wc2)
   ELSE 
      RETURN
   END IF

END FUNCTION

 
{</section>}
 
