#該程式未解開Section, 採用最新樣板產出!
{<section id="agcm300_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-06-30 16:50:05), PR版次:0006(2016-10-24 11:21:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000192
#+ Filename...: agcm300_03
#+ Description: 券種基本資料維護作業 -提貨商品設定
#+ Creator....: 01726(2013-11-12 10:44:52)
#+ Modifier...: 01726 -SD/PR- 06814
 
{</section>}
 
{<section id="agcm300_03.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160421-00007#1  2016/04/21 by 08172 已审核的资料不能修改
#160824-00007#97 2016/10/24 by 06814 新舊值備份修正
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
PRIVATE TYPE type_g_gcas_d RECORD
       gcas001 LIKE gcas_t.gcas001, 
   gcasseq LIKE gcas_t.gcasseq, 
   gcas002 LIKE gcas_t.gcas002, 
   gcas002_desc LIKE type_t.chr500, 
   gcas008 LIKE gcas_t.gcas008, 
   gcas006 LIKE gcas_t.gcas006, 
   gcas003 LIKE gcas_t.gcas003, 
   gcas003_desc LIKE type_t.chr500, 
   gcas005 LIKE gcas_t.gcas005, 
   gcas009 LIKE gcas_t.gcas009, 
   gcas007 LIKE gcas_t.gcas007, 
   gcasstus LIKE gcas_t.gcasstus
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gcas001   LIKE gcas_t.gcas001
DEFINE g_gcafunit  LIKE gcaf_t.gcafunit
#end add-point
 
#模組變數(Module Variables)
DEFINE g_gcas_d          DYNAMIC ARRAY OF type_g_gcas_d #單身變數
DEFINE g_gcas_d_t        type_g_gcas_d                  #單身備份
DEFINE g_gcas_d_o        type_g_gcas_d                  #單身備份
DEFINE g_gcas_d_mask_o   DYNAMIC ARRAY OF type_g_gcas_d #單身變數
DEFINE g_gcas_d_mask_n   DYNAMIC ARRAY OF type_g_gcas_d #單身變數
 
      
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
 
{<section id="agcm300_03.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION agcm300_03(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_gcas001,p_gcafunit
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_gcas001   LIKE gcas_t.gcas001
   DEFINE p_gcafunit  LIKE gcaf_t.gcafunit
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   IF cl_null(p_gcas001) OR cl_null(p_gcafunit) THEN
      RETURN
   END IF
   LET g_gcas001  = p_gcas001
   LET g_gcafunit = p_gcafunit
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT gcas001,gcasseq,gcas002,gcas008,gcas006,gcas003,gcas005,gcas009,gcas007, 
       gcasstus FROM gcas_t WHERE gcasent=? AND gcas001=? AND gcasseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcm300_03_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agcm300_03 WITH FORM cl_ap_formpath("agc","agcm300_03")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL agcm300_03_init()   
 
   #進入選單 Menu (="N")
   CALL agcm300_03_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_agcm300_03
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agcm300_03.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION agcm300_03_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('gcas006','6531') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL agcm300_03_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION agcm300_03_ui_dialog()
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
   DEFINE l_gcafstus   LIKE gcaf_t.gcafstus
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF
   LET g_wc2 = g_wc2 CLIPPED," AND gcas001 = '",g_gcas001,"' "
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gcas_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL agcm300_03_init()
      END IF
   
      CALL agcm300_03_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gcas_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL agcm300_03_set_pk_array()
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
            SELECT gcafstus INTO l_gcafstus
              FROM gcaf_t
             WHERE gcafent = g_enterprise AND gcaf001 = g_gcas001
            IF NOT cl_null(l_gcafstus) AND (l_gcafstus = 'Y' OR l_gcafstus = 'X') THEN
              #CALL cl_set_act_visible("modify",FALSE)
               CALL DIALOG.setActionActive("modify",FALSE)
            ELSE
              #CALL cl_set_act_visible("modify",TRUE)
               CALL DIALOG.setActionActive("modify",TRUE)
            END IF
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL agcm300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agcm300_03_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL agcm300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agcm300_03_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL agcm300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agcm300_03_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agcm300_03_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gcas_d)
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
            CALL agcm300_03_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agcm300_03_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agcm300_03_set_pk_array()
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
 
{<section id="agcm300_03.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION agcm300_03_query()
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
   CALL g_gcas_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON gcas001,gcasseq,gcas002,gcas008,gcas006,gcas003,gcas005,gcas009,gcas007,gcasstus  
 
 
         FROM s_detail1[1].gcas001,s_detail1[1].gcasseq,s_detail1[1].gcas002,s_detail1[1].gcas008,s_detail1[1].gcas006, 
             s_detail1[1].gcas003,s_detail1[1].gcas005,s_detail1[1].gcas009,s_detail1[1].gcas007,s_detail1[1].gcasstus  
 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcascrtdt>>----
 
         #----<<gcasmoddt>>----
         
         #----<<gcascnfdt>>----
         
         #----<<gcaspstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas001
            #add-point:BEFORE FIELD gcas001 name="query.b.page1.gcas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas001
            
            #add-point:AFTER FIELD gcas001 name="query.a.page1.gcas001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcas001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas001
            #add-point:ON ACTION controlp INFIELD gcas001 name="query.c.page1.gcas001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcasseq
            #add-point:BEFORE FIELD gcasseq name="query.b.page1.gcasseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcasseq
            
            #add-point:AFTER FIELD gcasseq name="query.a.page1.gcasseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcasseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcasseq
            #add-point:ON ACTION controlp INFIELD gcasseq name="query.c.page1.gcasseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcas002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas002
            #add-point:ON ACTION controlp INFIELD gcas002 name="construct.c.page1.gcas002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2071'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcas002  #顯示到畫面上

            NEXT FIELD gcas002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas002
            #add-point:BEFORE FIELD gcas002 name="query.b.page1.gcas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas002
            
            #add-point:AFTER FIELD gcas002 name="query.a.page1.gcas002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas008
            #add-point:BEFORE FIELD gcas008 name="query.b.page1.gcas008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas008
            
            #add-point:AFTER FIELD gcas008 name="query.a.page1.gcas008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcas008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas008
            #add-point:ON ACTION controlp INFIELD gcas008 name="query.c.page1.gcas008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas006
            #add-point:BEFORE FIELD gcas006 name="query.b.page1.gcas006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas006
            
            #add-point:AFTER FIELD gcas006 name="query.a.page1.gcas006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcas006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas006
            #add-point:ON ACTION controlp INFIELD gcas006 name="query.c.page1.gcas006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas003
            #add-point:ON ACTION controlp INFIELD gcas003 name="construct.c.page1.gcas003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gcas003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcas003  #顯示到畫面上

            NEXT FIELD gcas003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas003
            #add-point:BEFORE FIELD gcas003 name="query.b.page1.gcas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas003
            
            #add-point:AFTER FIELD gcas003 name="query.a.page1.gcas003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas005
            #add-point:BEFORE FIELD gcas005 name="query.b.page1.gcas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas005
            
            #add-point:AFTER FIELD gcas005 name="query.a.page1.gcas005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas005
            #add-point:ON ACTION controlp INFIELD gcas005 name="query.c.page1.gcas005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas009
            #add-point:BEFORE FIELD gcas009 name="query.b.page1.gcas009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas009
            
            #add-point:AFTER FIELD gcas009 name="query.a.page1.gcas009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcas009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas009
            #add-point:ON ACTION controlp INFIELD gcas009 name="query.c.page1.gcas009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas007
            #add-point:BEFORE FIELD gcas007 name="query.b.page1.gcas007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas007
            
            #add-point:AFTER FIELD gcas007 name="query.a.page1.gcas007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcas007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas007
            #add-point:ON ACTION controlp INFIELD gcas007 name="query.c.page1.gcas007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcasstus
            #add-point:BEFORE FIELD gcasstus name="query.b.page1.gcasstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcasstus
            
            #add-point:AFTER FIELD gcasstus name="query.a.page1.gcasstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcasstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcasstus
            #add-point:ON ACTION controlp INFIELD gcasstus name="query.c.page1.gcasstus"
            
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
    
   CALL agcm300_03_b_fill(g_wc2)
 
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
 
{<section id="agcm300_03.insert" >}
#+ 資料新增
PRIVATE FUNCTION agcm300_03_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL agcm300_03_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.modify" >}
#+ 資料修改
PRIVATE FUNCTION agcm300_03_modify()
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
   DEFINE l_gcafstus              LIKE gcaf_t.gcafstus  #160421-00007#1
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
   SELECT gcafstus INTO l_gcafstus  FROM gcaf_t WHERE gcafent = g_enterprise AND gcaf001 = g_gcas001
   IF l_gcafstus != 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_gcas_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcas_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agcm300_03_b_fill(g_wc2)
            LET g_detail_cnt = g_gcas_d.getLength()
         
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
            DISPLAY g_gcas_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gcas_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gcas_d[l_ac].gcas001 IS NOT NULL
               AND g_gcas_d[l_ac].gcasseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gcas_d_t.* = g_gcas_d[l_ac].*  #BACKUP
               LET g_gcas_d_o.* = g_gcas_d[l_ac].*  #BACKUP
               IF NOT agcm300_03_lock_b("gcas_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agcm300_03_bcl INTO g_gcas_d[l_ac].gcas001,g_gcas_d[l_ac].gcasseq,g_gcas_d[l_ac].gcas002, 
                      g_gcas_d[l_ac].gcas008,g_gcas_d[l_ac].gcas006,g_gcas_d[l_ac].gcas003,g_gcas_d[l_ac].gcas005, 
                      g_gcas_d[l_ac].gcas009,g_gcas_d[l_ac].gcas007,g_gcas_d[l_ac].gcasstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gcas_d_t.gcas001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcas_d_mask_o[l_ac].* =  g_gcas_d[l_ac].*
                  CALL agcm300_03_gcas_t_mask()
                  LET g_gcas_d_mask_n[l_ac].* =  g_gcas_d[l_ac].*
                  
                  CALL agcm300_03_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL agcm300_03_set_entry_b(l_cmd)
            CALL agcm300_03_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL agcm300_03_set_entry_b(l_cmd)
            CALL agcm300_03_set_no_entry_b(l_cmd)
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
            INITIALIZE g_gcas_d_t.* TO NULL
            INITIALIZE g_gcas_d_o.* TO NULL
            INITIALIZE g_gcas_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcas_d[l_ac].gcasstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_gcas_d[l_ac].gcasseq = "1"
      LET g_gcas_d[l_ac].gcas006 = "1"
      LET g_gcas_d[l_ac].gcasstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_gcas_d_t.* = g_gcas_d[l_ac].*     #新輸入資料
            LET g_gcas_d_o.* = g_gcas_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcas_d[li_reproduce_target].* = g_gcas_d[li_reproduce].*
 
               LET g_gcas_d[g_gcas_d.getLength()].gcas001 = NULL
               LET g_gcas_d[g_gcas_d.getLength()].gcasseq = NULL
 
            END IF
            
 
            CALL agcm300_03_set_entry_b(l_cmd)
            CALL agcm300_03_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_gcas_d[l_ac].gcas001 = g_gcas001
            CALL agcm300_03_gcasseq_init()
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
            SELECT COUNT(1) INTO l_count FROM gcas_t 
             WHERE gcasent = g_enterprise AND gcas001 = g_gcas_d[l_ac].gcas001
                                       AND gcasseq = g_gcas_d[l_ac].gcasseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcas_d[g_detail_idx].gcas001
               LET gs_keys[2] = g_gcas_d[g_detail_idx].gcasseq
               CALL agcm300_03_insert_b('gcas_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gcas_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcas_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agcm300_03_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (gcas001 = '", g_gcas_d[l_ac].gcas001, "' "
                                  ," AND gcasseq = '", g_gcas_d[l_ac].gcasseq, "' "
 
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
               
               DELETE FROM gcas_t
                WHERE gcasent = g_enterprise AND 
                      gcas001 = g_gcas_d_t.gcas001
                      AND gcasseq = g_gcas_d_t.gcasseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gcas_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL agcm300_03_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_gcas_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE agcm300_03_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_gcas_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcas_d_t.gcas001
               LET gs_keys[2] = g_gcas_d_t.gcasseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agcm300_03_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL agcm300_03_delete_b('gcas_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gcas_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas001
            #add-point:BEFORE FIELD gcas001 name="input.b.page1.gcas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas001
            
            #add-point:AFTER FIELD gcas001 name="input.a.page1.gcas001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcas_d[g_detail_idx].gcas001) AND NOT cl_null(g_gcas_d[g_detail_idx].gcas002) AND NOT cl_null(g_gcas_d[g_detail_idx].gcas003) AND NOT cl_null(g_gcas_d[g_detail_idx].gcas005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcas_d[g_detail_idx].gcas001 != g_gcas_d_t.gcas001 OR g_gcas_d[g_detail_idx].gcas002 != g_gcas_d_t.gcas002 OR g_gcas_d[g_detail_idx].gcas003 != g_gcas_d_t.gcas003 OR g_gcas_d[g_detail_idx].gcas005 != g_gcas_d_t.gcas005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcas_t WHERE "||"gcasent = '" ||g_enterprise|| "' AND "||"gcas001 = '"||g_gcas_d[g_detail_idx].gcas001 ||"' AND "|| "gcas002 = '"||g_gcas_d[g_detail_idx].gcas002 ||"' AND "|| "gcas003 = '"||g_gcas_d[g_detail_idx].gcas003 ||"' AND "|| "gcas005 = '"||g_gcas_d[g_detail_idx].gcas005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas001
            #add-point:ON CHANGE gcas001 name="input.g.page1.gcas001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcasseq
            #add-point:BEFORE FIELD gcasseq name="input.b.page1.gcasseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcasseq
            
            #add-point:AFTER FIELD gcasseq name="input.a.page1.gcasseq"
            #此段落由子樣板a05產生
            IF  g_gcas_d[g_detail_idx].gcas001 IS NOT NULL AND g_gcas_d[g_detail_idx].gcas002 IS NOT NULL AND g_gcas_d[g_detail_idx].gcasseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcas_d[g_detail_idx].gcas001 != g_gcas_d_t.gcas001 OR g_gcas_d[g_detail_idx].gcas002 != g_gcas_d_t.gcas002 OR g_gcas_d[g_detail_idx].gcasseq != g_gcas_d_t.gcasseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcas_t WHERE "||"gcasent = '" ||g_enterprise|| "' AND "||"gcas001 = '"||g_gcas_d[g_detail_idx].gcas001 ||"' AND "|| "gcas002 = '"||g_gcas_d[g_detail_idx].gcas002 ||"' AND "|| "gcasseq = '"||g_gcas_d[g_detail_idx].gcasseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcasseq
            #add-point:ON CHANGE gcasseq name="input.g.page1.gcasseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas002
            
            #add-point:AFTER FIELD gcas002 name="input.a.page1.gcas002"
            LET g_gcas_d[l_ac].gcas002_desc = ''
            DISPLAY BY NAME g_gcas_d[l_ac].gcas002_desc
            IF NOT cl_null(g_gcas_d[l_ac].gcas002) THEN
               CALL agcm300_03_gcas002_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcas_d[l_ac].gcas002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcas_d[l_ac].gcas002 = g_gcas_d_t.gcas002
                  DISPLAY BY NAME g_gcas_d[l_ac].gcas002
                  CALL agcm300_03_gcas002_ref()
                  CALL agcm300_03_gcas008_init()
                  NEXT FIELD CURRENT
               END IF
               
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcas_d[l_ac].gcas002 != g_gcas_d_t.gcas002 OR g_gcas_d[l_ac].gcas003 != g_gcas_d_t.gcas003 OR g_gcas_d[l_ac].gcas005 != g_gcas_d_t.gcas005)) THEN   #160824-00007#97 20161024 mark by beckxie
               IF g_gcas_d[l_ac].gcas002 != g_gcas_d_o.gcas002 OR g_gcas_d[l_ac].gcas003 != g_gcas_d_o.gcas003 OR g_gcas_d[l_ac].gcas005 != g_gcas_d_o.gcas005      #160824-00007#97 20161024 add by beckxie
                  OR cl_null(g_gcas_d_o.gcas002) OR cl_null(g_gcas_d_o.gcas003) OR cl_null(g_gcas_d_o.gcas005) THEN                                                 #160824-00007#97 20161024 add by beckxie
               
                  CALL agcm300_03_repeat_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcas_d[l_ac].gcas002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_gcas_d[l_ac].gcas002 = g_gcas_d_t.gcas002   #160824-00007#97 20161024 mark by beckxie
                     #160824-00007#97 20161024 add by beckxie---S
                     LET g_gcas_d[l_ac].gcas002 = g_gcas_d_o.gcas002    
                     LET g_gcas_d[l_ac].gcas008 = g_gcas_d_o.gcas008
                     DISPLAY BY NAME g_gcas_d[l_ac].gcas008
                     #160824-00007#97 20161024 add by beckxie---E
                     DISPLAY BY NAME g_gcas_d[l_ac].gcas002
                     CALL agcm300_03_gcas002_ref()
                     #CALL agcm300_03_gcas008_init()   #160824-00007#97 20161024 mark by beckxie
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agcm300_03_gcas002_ref()
            CALL agcm300_03_gcas008_init()
            LET g_gcas_d_o.* = g_gcas_d[l_ac].*   #160824-00007#97 20161024 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas002
            #add-point:BEFORE FIELD gcas002 name="input.b.page1.gcas002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas002
            #add-point:ON CHANGE gcas002 name="input.g.page1.gcas002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas008
            #add-point:BEFORE FIELD gcas008 name="input.b.page1.gcas008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas008
            
            #add-point:AFTER FIELD gcas008 name="input.a.page1.gcas008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas008
            #add-point:ON CHANGE gcas008 name="input.g.page1.gcas008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas006
            #add-point:BEFORE FIELD gcas006 name="input.b.page1.gcas006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas006
            
            #add-point:AFTER FIELD gcas006 name="input.a.page1.gcas006"
            IF NOT cl_null(g_gcas_d[l_ac].gcas006) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcas_d[l_ac].gcas002 != g_gcas_d_t.gcas002 OR g_gcas_d[l_ac].gcas003 != g_gcas_d_t.gcas003 OR g_gcas_d[l_ac].gcas005 != g_gcas_d_t.gcas005 OR g_gcas_d[l_ac].gcas006 != g_gcas_d_t.gcas006)) THEN   #160824-00007#97 20161024 mark by beckxie
               IF g_gcas_d[l_ac].gcas002 != g_gcas_d_o.gcas002 OR g_gcas_d[l_ac].gcas003 != g_gcas_d_o.gcas003 OR g_gcas_d[l_ac].gcas005 != g_gcas_d_o.gcas005 OR g_gcas_d[l_ac].gcas006 != g_gcas_d_o.gcas006     #160824-00007#97 20161024 add by beckxie
                OR cl_null(g_gcas_d_o.gcas002) OR cl_null(g_gcas_d_o.gcas003) OR cl_null(g_gcas_d_o.gcas005) OR cl_null(g_gcas_d_o.gcas006) THEN                                                                   #160824-00007#97 20161024 add by beckxie
                  IF g_gcas_d[l_ac].gcas006 = '3' THEN
                     CALL agcm300_03_repeat_chk()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_gcas_d[l_ac].gcas006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_gcas_d[l_ac].gcas006 = g_gcas_d_t.gcas006   #160824-00007#97 20161024 mark by beckxie
                        #160824-00007#97 20161024 add by beckxie---S
                        LET g_gcas_d[l_ac].gcas003 = g_gcas_d_o.gcas003
                        LET g_gcas_d[l_ac].gcas003_desc = g_gcas_d_o.gcas003_desc
                        LET g_gcas_d[l_ac].gcas006 = g_gcas_d_o.gcas006
                        LET g_gcas_d[l_ac].gcas007 = g_gcas_d_o.gcas007
                        LET g_gcas_d[l_ac].gcas009 = g_gcas_d_o.gcas009
                        #160824-00007#97 20161024 add by beckxie---E
                        DISPLAY BY NAME g_gcas_d[l_ac].gcas006
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               IF g_gcas_d[l_ac].gcas006 = '1' THEN
                  LET g_gcas_d[l_ac].gcas007 = ''
               ELSE
                  IF cl_null(g_gcas_d[l_ac].gcas007) THEN
                     LET g_gcas_d[l_ac].gcas007 = 0
                  END IF
               END IF
               IF g_gcas_d[l_ac].gcas006 = '3' THEN
                  LET g_gcas_d[l_ac].gcas003 = ''
                  LET g_gcas_d[l_ac].gcas003_desc = ''
                  LET g_gcas_d[l_ac].gcas009 = 0
               ELSE
                  LET g_gcas_d[l_ac].gcas009 = ''
               END IF
            END IF
            CALL agcm300_03_set_entry_b(l_cmd)
            CALL agcm300_03_set_no_entry_b(l_cmd)
            
            LET g_gcas_d_o.* = g_gcas_d[l_ac].*   #160824-00007#97 20161024 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas006
            #add-point:ON CHANGE gcas006 name="input.g.page1.gcas006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas003
            
            #add-point:AFTER FIELD gcas003 name="input.a.page1.gcas003"
            LET g_gcas_d[l_ac].gcas003_desc = ''
            DISPLAY BY NAME g_gcas_d[l_ac].gcas003
            IF NOT cl_null(g_gcas_d[l_ac].gcas003) THEN
               CALL agcm300_03_gcas003_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcas_d[l_ac].gcas003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcas_d[l_ac].gcas003 = g_gcas_d_t.gcas003
                  DISPLAY BY NAME g_gcas_d[l_ac].gcas003
                  CALL agcm300_03_gcas003_ref()
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcas_d[l_ac].gcas002 != g_gcas_d_t.gcas002 OR g_gcas_d[l_ac].gcas003 != g_gcas_d_t.gcas003 OR g_gcas_d[l_ac].gcas005 != g_gcas_d_t.gcas005 OR cl_null(g_gcas_d_t.gcas003))) THEN
                  CALL agcm300_03_repeat_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcas_d[l_ac].gcas003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     LET g_gcas_d[l_ac].gcas003 = g_gcas_d_t.gcas003
                     DISPLAY BY NAME g_gcas_d[l_ac].gcas003
                     CALL agcm300_03_gcas003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agcm300_03_gcas003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas003
            #add-point:BEFORE FIELD gcas003 name="input.b.page1.gcas003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas003
            #add-point:ON CHANGE gcas003 name="input.g.page1.gcas003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcas_d[l_ac].gcas005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcas005
            END IF 
 
 
 
            #add-point:AFTER FIELD gcas005 name="input.a.page1.gcas005"
            IF NOT cl_null(g_gcas_d[l_ac].gcas005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcas_d[l_ac].gcas002 != g_gcas_d_t.gcas002 OR g_gcas_d[l_ac].gcas003 != g_gcas_d_t.gcas003 OR g_gcas_d[l_ac].gcas005 != g_gcas_d_t.gcas005)) THEN
                  CALL agcm300_03_repeat_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcas_d[l_ac].gcas005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcas_d[l_ac].gcas005 = g_gcas_d_t.gcas005
                     DISPLAY BY NAME g_gcas_d[l_ac].gcas005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas005
            #add-point:BEFORE FIELD gcas005 name="input.b.page1.gcas005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas005
            #add-point:ON CHANGE gcas005 name="input.g.page1.gcas005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas009
            #add-point:BEFORE FIELD gcas009 name="input.b.page1.gcas009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas009
            
            #add-point:AFTER FIELD gcas009 name="input.a.page1.gcas009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas009
            #add-point:ON CHANGE gcas009 name="input.g.page1.gcas009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcas007
            #add-point:BEFORE FIELD gcas007 name="input.b.page1.gcas007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcas007
            
            #add-point:AFTER FIELD gcas007 name="input.a.page1.gcas007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcas007
            #add-point:ON CHANGE gcas007 name="input.g.page1.gcas007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcasstus
            #add-point:BEFORE FIELD gcasstus name="input.b.page1.gcasstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcasstus
            
            #add-point:AFTER FIELD gcasstus name="input.a.page1.gcasstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcasstus
            #add-point:ON CHANGE gcasstus name="input.g.page1.gcasstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gcas001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas001
            #add-point:ON ACTION controlp INFIELD gcas001 name="input.c.page1.gcas001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcasseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcasseq
            #add-point:ON ACTION controlp INFIELD gcasseq name="input.c.page1.gcasseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas002
            #add-point:ON ACTION controlp INFIELD gcas002 name="input.c.page1.gcas002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcas_d[l_ac].gcas002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2071" #
            LET g_qryparam.where = " oocq002 IN (SELECT gcar002 ",
                                   "               FROM gcar_t ",
                                   "              WHERE gcarent = '",g_enterprise,"' AND gcar001 = '",g_gcas_d[l_ac].gcas001,"') "

            CALL q_oocq002()                                #呼叫開窗

            LET g_gcas_d[l_ac].gcas002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcas_d[l_ac].gcas002 TO gcas002              #顯示到畫面上
            
            CALL agcm300_03_gcas002_ref()
            
            CALL agcm300_03_gcas008_init()

            NEXT FIELD gcas002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas008
            #add-point:ON ACTION controlp INFIELD gcas008 name="input.c.page1.gcas008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas006
            #add-point:ON ACTION controlp INFIELD gcas006 name="input.c.page1.gcas006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas003
            #add-point:ON ACTION controlp INFIELD gcas003 name="input.c.page1.gcas003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcas_d[l_ac].gcas003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_gcafunit #

            CALL q_rtdx001_1()                                #呼叫開窗

            LET g_gcas_d[l_ac].gcas003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcas_d[l_ac].gcas003 TO gcas003              #顯示到畫面上
            
            CALL agcm300_03_gcas003_ref()

            NEXT FIELD gcas003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas005
            #add-point:ON ACTION controlp INFIELD gcas005 name="input.c.page1.gcas005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas009
            #add-point:ON ACTION controlp INFIELD gcas009 name="input.c.page1.gcas009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcas007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcas007
            #add-point:ON ACTION controlp INFIELD gcas007 name="input.c.page1.gcas007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcasstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcasstus
            #add-point:ON ACTION controlp INFIELD gcasstus name="input.c.page1.gcasstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE agcm300_03_bcl
               LET INT_FLAG = 0
               LET g_gcas_d[l_ac].* = g_gcas_d_t.*
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
               LET g_errparam.extend = g_gcas_d[l_ac].gcas001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gcas_d[l_ac].* = g_gcas_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL agcm300_03_gcas_t_mask_restore('restore_mask_o')
 
               UPDATE gcas_t SET (gcas001,gcasseq,gcas002,gcas008,gcas006,gcas003,gcas005,gcas009,gcas007, 
                   gcasstus) = (g_gcas_d[l_ac].gcas001,g_gcas_d[l_ac].gcasseq,g_gcas_d[l_ac].gcas002, 
                   g_gcas_d[l_ac].gcas008,g_gcas_d[l_ac].gcas006,g_gcas_d[l_ac].gcas003,g_gcas_d[l_ac].gcas005, 
                   g_gcas_d[l_ac].gcas009,g_gcas_d[l_ac].gcas007,g_gcas_d[l_ac].gcasstus)
                WHERE gcasent = g_enterprise AND
                  gcas001 = g_gcas_d_t.gcas001 #項次   
                  AND gcasseq = g_gcas_d_t.gcasseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcas_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcas_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcas_d[g_detail_idx].gcas001
               LET gs_keys_bak[1] = g_gcas_d_t.gcas001
               LET gs_keys[2] = g_gcas_d[g_detail_idx].gcasseq
               LET gs_keys_bak[2] = g_gcas_d_t.gcasseq
               CALL agcm300_03_update_b('gcas_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gcas_d_t)
                     LET g_log2 = util.JSON.stringify(g_gcas_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agcm300_03_gcas_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL agcm300_03_unlock_b("gcas_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gcas_d[l_ac].* = g_gcas_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
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
               LET g_gcas_d[li_reproduce_target].* = g_gcas_d[li_reproduce].*
 
               LET g_gcas_d[li_reproduce_target].gcas001 = NULL
               LET g_gcas_d[li_reproduce_target].gcasseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcas_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcas_d.getLength()+1
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
               NEXT FIELD gcas001
 
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
      IF INT_FLAG OR cl_null(g_gcas_d[g_detail_idx].gcas001) THEN
         CALL g_gcas_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_gcas_d[g_detail_idx].* = g_gcas_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE agcm300_03_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agcm300_03_delete()
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
   DEFINE l_gcafstus              LIKE gcaf_t.gcafstus  #160421-00007#1
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   SELECT gcafstus INTO l_gcafstus  FROM gcaf_t WHERE gcafent = g_enterprise AND gcaf001 = g_gcas001
   IF l_gcafstus != 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_gcas_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT agcm300_03_lock_b("gcas_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("gcas_t","gcasownid") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
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
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_gcas_d.getLength()
      IF g_gcas_d[li_idx].gcas001 IS NOT NULL
         AND g_gcas_d[li_idx].gcasseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM gcas_t
          WHERE gcasent = g_enterprise AND 
                gcas001 = g_gcas_d[li_idx].gcas001
                AND gcasseq = g_gcas_d[li_idx].gcasseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcas_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcas_d_t.gcas001
               LET gs_keys[2] = g_gcas_d_t.gcasseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL agcm300_03_delete_b('gcas_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agcm300_03_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL agcm300_03_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agcm300_03_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.gcas001,t0.gcasseq,t0.gcas002,t0.gcas008,t0.gcas006,t0.gcas003,t0.gcas005, 
       t0.gcas009,t0.gcas007,t0.gcasstus ,t1.oocql004 ,t2.imaal003 FROM gcas_t t0",
               "",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2071' AND t1.oocql002=t0.gcas002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.gcas003 AND t2.imaal002='"||g_dlang||"' ",
 
               " WHERE t0.gcasent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gcas_t"),
                      " ORDER BY t0.gcas001,t0.gcasseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gcas_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE agcm300_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR agcm300_03_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_gcas_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gcas_d[l_ac].gcas001,g_gcas_d[l_ac].gcasseq,g_gcas_d[l_ac].gcas002,g_gcas_d[l_ac].gcas008, 
       g_gcas_d[l_ac].gcas006,g_gcas_d[l_ac].gcas003,g_gcas_d[l_ac].gcas005,g_gcas_d[l_ac].gcas009,g_gcas_d[l_ac].gcas007, 
       g_gcas_d[l_ac].gcasstus,g_gcas_d[l_ac].gcas002_desc,g_gcas_d[l_ac].gcas003_desc
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
      
      CALL agcm300_03_detail_show()      
 
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
   
 
   
   CALL g_gcas_d.deleteElement(g_gcas_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gcas_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_gcas_d.getLength() THEN
      LET l_ac = g_gcas_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gcas_d.getLength()
      LET g_gcas_d_mask_o[l_ac].* =  g_gcas_d[l_ac].*
      CALL agcm300_03_gcas_t_mask()
      LET g_gcas_d_mask_n[l_ac].* =  g_gcas_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_gcas_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE agcm300_03_pb
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION agcm300_03_detail_show()
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
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcas_d[l_ac].gcas002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcas_d[l_ac].gcas002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcas_d[l_ac].gcas002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcas_d[l_ac].gcas003
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcas_d[l_ac].gcas003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcas_d[l_ac].gcas003_desc

   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agcm300_03_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry('gcas003',TRUE)
   CALL cl_set_comp_entry('gcas007',TRUE)
   CALL cl_set_comp_entry('gcas009',TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="agcm300_03.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agcm300_03_set_no_entry_b(p_cmd)                                               
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
   IF cl_null(g_gcas_d[l_ac].gcas006) OR g_gcas_d[l_ac].gcas006 = '1' THEN
      CALL cl_set_comp_entry('gcas007',FALSE)
   END IF
   IF cl_null(g_gcas_d[l_ac].gcas006) OR g_gcas_d[l_ac].gcas006 = '3' THEN
      CALL cl_set_comp_entry('gcas003',FALSE)
   END IF
   IF cl_null(g_gcas_d[l_ac].gcas006) OR g_gcas_d[l_ac].gcas006 <> '3' THEN
      CALL cl_set_comp_entry('gcas009',FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agcm300_03_default_search()
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
      LET ls_wc = ls_wc, " gcas001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gcasseq = '", g_argv[02], "' AND "
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
 
{<section id="agcm300_03.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agcm300_03_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "gcas_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'gcas_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM gcas_t
          WHERE gcasent = g_enterprise AND
            gcas001 = ps_keys_bak[1] AND gcasseq = ps_keys_bak[2]
         
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
         CALL g_gcas_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agcm300_03_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "gcas_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO gcas_t
                  (gcasent,
                   gcas001,gcasseq
                   ,gcas002,gcas008,gcas006,gcas003,gcas005,gcas009,gcas007,gcasstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gcas_d[l_ac].gcas002,g_gcas_d[l_ac].gcas008,g_gcas_d[l_ac].gcas006,g_gcas_d[l_ac].gcas003, 
                       g_gcas_d[l_ac].gcas005,g_gcas_d[l_ac].gcas009,g_gcas_d[l_ac].gcas007,g_gcas_d[l_ac].gcasstus) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcas_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agcm300_03_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "gcas_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gcas_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE gcas_t 
         SET (gcas001,gcasseq
              ,gcas002,gcas008,gcas006,gcas003,gcas005,gcas009,gcas007,gcasstus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gcas_d[l_ac].gcas002,g_gcas_d[l_ac].gcas008,g_gcas_d[l_ac].gcas006,g_gcas_d[l_ac].gcas003, 
                  g_gcas_d[l_ac].gcas005,g_gcas_d[l_ac].gcas009,g_gcas_d[l_ac].gcas007,g_gcas_d[l_ac].gcasstus)  
 
         WHERE gcasent = g_enterprise AND gcas001 = ps_keys_bak[1] AND gcasseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcas_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcas_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agcm300_03_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL agcm300_03_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gcas_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agcm300_03_bcl USING g_enterprise,
                                       g_gcas_d[g_detail_idx].gcas001,g_gcas_d[g_detail_idx].gcasseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agcm300_03_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agcm300_03_unlock_b(ps_table)
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
      CLOSE agcm300_03_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION agcm300_03_modify_detail_chk(ps_record)
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
         LET ls_return = "gcas001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="agcm300_03.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION agcm300_03_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="agcm300_03.mask_functions" >}
&include "erp/agc/agcm300_03_mask.4gl"
 
{</section>}
 
{<section id="agcm300_03.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agcm300_03_set_pk_array()
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
   LET g_pk_array[1].values = g_gcas_d[l_ac].gcas001
   LET g_pk_array[1].column = 'gcas001'
   LET g_pk_array[2].values = g_gcas_d[l_ac].gcasseq
   LET g_pk_array[2].column = 'gcasseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agcm300_03.state_change" >}
   
 
{</section>}
 
{<section id="agcm300_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agcm300_03.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agcm300_03_gcas002_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcas_d[l_ac].gcas002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcas_d[l_ac].gcas002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcas_d[l_ac].gcas002_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_03_gcas002_chk()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus
DEFINE l_cnt        LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET l_cnt = 0
   
   SELECT oocqstus INTO l_oocqstus
     FROM oocq_t
    WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcas_d[l_ac].gcas002
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00011' #该券面额编号不存在
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'agc-00012' #该券面额编号已无效
   END CASE
   IF cl_null(g_errno) THEN
      #判斷券是否存在于券發行面額設定中
      SELECT COUNT(*) INTO l_cnt
        FROM gcar_t
       WHERE gcarent = g_enterprise AND gcar001 = g_gcas_d[l_ac].gcas001 AND gcar002 = g_gcas_d[l_ac].gcas002 AND gcarstus = 'Y'
      IF l_cnt = 0 THEN
         LET g_errno = 'agc-00056' #券面額編號必須存在于該券種的發行面額設定中
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_03_gcas003_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcas_d[l_ac].gcas003
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcas_d[l_ac].gcas003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcas_d[l_ac].gcas003_desc
END FUNCTION
#+
PRIVATE FUNCTION agcm300_03_gcas003_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus

   INITIALIZE g_errno TO NULL
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdxsite = g_gcafunit AND rtdx001 = g_gcas_d[l_ac].gcas003
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00013' #该商品不存在或在当前组织不可使用
      WHEN l_rtdxstus <> 'Y'   LET g_errno = 'agc-00014' #该商品在当前组织已无效
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agcm300_03_gcas008_init()
   
   IF NOT cl_null(g_gcas_d[l_ac].gcas002) THEN
      SELECT oocq009 INTO g_gcas_d[l_ac].gcas008
        FROM oocq_t
       WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcas_d[l_ac].gcas002
   ELSE
      LET g_gcas_d[l_ac].gcas008 = ''
   END IF
   DISPLAY BY NAME g_gcas_d[l_ac].gcas008
END FUNCTION
#+
PRIVATE FUNCTION agcm300_03_gcasseq_init()
   SELECT MAX(gcasseq)+1 INTO g_gcas_d[l_ac].gcasseq
     FROM gcas_t
    WHERE gcasent = g_enterprise AND gcas001 = g_gcas_d[l_ac].gcas001
   IF cl_null(g_gcas_d[l_ac].gcasseq) THEN
      LET g_gcas_d[l_ac].gcasseq = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agcm300_03_repeat_chk()
DEFINE l_cnt   LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET l_cnt = 0
   
   IF cl_null(g_gcas_d[l_ac].gcas006) THEN RETURN END IF
   
   CASE g_gcas_d[l_ac].gcas006
      WHEN '3'
         IF cl_null(g_gcas_d[l_ac].gcas002) OR cl_null(g_gcas_d[l_ac].gcas005) THEN RETURN END IF
         SELECT COUNT(*) INTO l_cnt
           FROM gcas_t
          WHERE gcasent = g_enterprise AND gcas001 = g_gcas001 AND gcas006 = '3'
            AND gcas002 = g_gcas_d[l_ac].gcas002 AND gcas005 = g_gcas_d[l_ac].gcas005
         IF l_cnt > 0 THEN
            LET g_errno = 'agc-00052' #當提貨商品類型為3.換貨不限定商品時，券面額編號+提貨數量不可重複!
         END IF
      OTHERWISE
         IF cl_null(g_gcas_d[l_ac].gcas002) OR cl_null(g_gcas_d[l_ac].gcas003) OR cl_null(g_gcas_d[l_ac].gcas005) THEN RETURN END IF
         SELECT COUNT(*) INTO l_cnt
           FROM gcas_t
          WHERE gcasent = g_enterprise AND gcas001 = g_gcas001
            AND gcas002 = g_gcas_d[l_ac].gcas002 AND gcas003 = g_gcas_d[l_ac].gcas003 AND gcas005 = g_gcas_d[l_ac].gcas005
         IF l_cnt > 0 THEN
            LET g_errno = 'agc-00053' #券面額編號+提貨商品編號+提貨數量不可重複!
         END IF
   END CASE
END FUNCTION

 
{</section>}
 
