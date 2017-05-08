#該程式未解開Section, 採用最新樣板產出!
{<section id="agct300_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-06-30 15:50:59), PR版次:0006(2016-10-24 15:10:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000138
#+ Filename...: agct300_03
#+ Description: 券種基本資料申請維護作業 -提貨商品設定
#+ Creator....: 01726(2013-11-11 17:23:01)
#+ Modifier...: 01726 -SD/PR- 06814
 
{</section>}
 
{<section id="agct300_03.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
#160413-00008#1    2016/04/13 by 08172 已审核的资料不能修改
#160824-00007#100  2016/10/24 by 06814 新舊值相關調整
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gcaq_d RECORD
       gcaqdocno LIKE gcaq_t.gcaqdocno, 
   gcaqsite LIKE gcaq_t.gcaqsite, 
   gcaqunit LIKE gcaq_t.gcaqunit, 
   gcaq000 LIKE gcaq_t.gcaq000, 
   gcaq001 LIKE gcaq_t.gcaq001, 
   gcaqseq LIKE gcaq_t.gcaqseq, 
   gcaq002 LIKE gcaq_t.gcaq002, 
   gcaq002_desc LIKE type_t.chr500, 
   gcaq008 LIKE gcaq_t.gcaq008, 
   gcaq006 LIKE gcaq_t.gcaq006, 
   gcaq003 LIKE gcaq_t.gcaq003, 
   gcaq003_desc LIKE type_t.chr500, 
   gcaq005 LIKE gcaq_t.gcaq005, 
   gcaq009 LIKE gcaq_t.gcaq009, 
   gcaq007 LIKE gcaq_t.gcaq007, 
   gcaqacti LIKE gcaq_t.gcaqacti
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gcaqdocno          LIKE gcaq_t.gcaqdocno
DEFINE g_gcaqsite           LIKE gcaq_t.gcaqsite
DEFINE g_gcaqunit           LIKE gcaq_t.gcaqunit
DEFINE g_gcaq000            LIKE gcaq_t.gcaq000
DEFINE g_gcaq001            LIKE gcaq_t.gcaq001
#end add-point
 
#模組變數(Module Variables)
DEFINE g_gcaq_d          DYNAMIC ARRAY OF type_g_gcaq_d #單身變數
DEFINE g_gcaq_d_t        type_g_gcaq_d                  #單身備份
DEFINE g_gcaq_d_o        type_g_gcaq_d                  #單身備份
DEFINE g_gcaq_d_mask_o   DYNAMIC ARRAY OF type_g_gcaq_d #單身變數
DEFINE g_gcaq_d_mask_n   DYNAMIC ARRAY OF type_g_gcaq_d #單身變數
 
      
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
 
{<section id="agct300_03.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION agct300_03(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_gcaqdocno,p_gcaqsite,p_gcaqunit,p_gcaq000,p_gcaq001
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_gcaqdocno   LIKE gcaq_t.gcaqdocno
   DEFINE p_gcaqsite    LIKE gcaq_t.gcaqsite
   DEFINE p_gcaqunit    LIKE gcaq_t.gcaqunit
   DEFINE p_gcaq000     LIKE gcaq_t.gcaq000
   DEFINE p_gcaq001     LIKE gcaq_t.gcaq001
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   IF cl_null(p_gcaqdocno) OR cl_null(p_gcaqsite) OR cl_null(p_gcaqunit) OR cl_null(p_gcaq000) OR cl_null(p_gcaq001) THEN
      RETURN
   END IF 
   LET g_gcaqdocno = p_gcaqdocno
   LET g_gcaqsite  = p_gcaqsite
   LET g_gcaqunit  = p_gcaqunit
   LET g_gcaq000   = p_gcaq000
   LET g_gcaq001   = p_gcaq001
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT gcaqdocno,gcaqsite,gcaqunit,gcaq000,gcaq001,gcaqseq,gcaq002,gcaq008,gcaq006, 
       gcaq003,gcaq005,gcaq009,gcaq007,gcaqacti FROM gcaq_t WHERE gcaqent=? AND gcaqdocno=? AND gcaq001=?  
       AND gcaqseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct300_03_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agct300_03 WITH FORM cl_ap_formpath("agc","agct300_03")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL agct300_03_init()   
 
   #進入選單 Menu (="N")
   CALL agct300_03_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_agct300_03
 
   
   
 
   #add-point:離開前 name="main.exit"
   LET g_action_choice = ''
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct300_03.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION agct300_03_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('gcaq006','6531') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL agct300_03_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION agct300_03_ui_dialog()
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
   DEFINE l_gcaastus   LIKE gcaa_t.gcaastus
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
   LET g_wc2 = g_wc2 CLIPPED," AND gcaqdocno = '",g_gcaqdocno,"' ",
                             " AND gcaqsite  = '",g_gcaqsite,"' ",
                             " AND gcaqunit  = '",g_gcaqunit,"' ",
                             " AND gcaq000   = '",g_gcaq000,"' ",
                             " AND gcaq001   = '",g_gcaq001,"' "
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gcaq_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL agct300_03_init()
      END IF
   
      CALL agct300_03_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gcaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL agct300_03_set_pk_array()
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
            SELECT gcaastus INTO l_gcaastus
              FROM gcaa_t
             WHERE gcaaent = g_enterprise AND gcaadocno = g_gcaqdocno
            IF NOT cl_null(l_gcaastus) AND (l_gcaastus = 'Y' OR l_gcaastus = 'X') THEN
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
            CALL agct300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agct300_03_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL agct300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agct300_03_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL agct300_03_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agct300_03_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agct300_03_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gcaq_d)
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
            CALL agct300_03_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agct300_03_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agct300_03_set_pk_array()
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
 
{<section id="agct300_03.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION agct300_03_query()
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
   CALL g_gcaq_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON gcaqdocno,gcaqsite,gcaqunit,gcaq000,gcaq001,gcaq002,gcaq008,gcaq006,gcaq003, 
          gcaq005,gcaq007,gcaqacti 
 
         FROM s_detail1[1].gcaqdocno,s_detail1[1].gcaqsite,s_detail1[1].gcaqunit,s_detail1[1].gcaq000, 
             s_detail1[1].gcaq001,s_detail1[1].gcaq002,s_detail1[1].gcaq008,s_detail1[1].gcaq006,s_detail1[1].gcaq003, 
             s_detail1[1].gcaq005,s_detail1[1].gcaq007,s_detail1[1].gcaqacti 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqdocno
            #add-point:BEFORE FIELD gcaqdocno name="query.b.page1.gcaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqdocno
            
            #add-point:AFTER FIELD gcaqdocno name="query.a.page1.gcaqdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqdocno
            #add-point:ON ACTION controlp INFIELD gcaqdocno name="query.c.page1.gcaqdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqsite
            #add-point:BEFORE FIELD gcaqsite name="query.b.page1.gcaqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqsite
            
            #add-point:AFTER FIELD gcaqsite name="query.a.page1.gcaqsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqsite
            #add-point:ON ACTION controlp INFIELD gcaqsite name="query.c.page1.gcaqsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqunit
            #add-point:BEFORE FIELD gcaqunit name="query.b.page1.gcaqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqunit
            
            #add-point:AFTER FIELD gcaqunit name="query.a.page1.gcaqunit"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqunit
            #add-point:ON ACTION controlp INFIELD gcaqunit name="query.c.page1.gcaqunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq000
            #add-point:BEFORE FIELD gcaq000 name="query.b.page1.gcaq000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq000
            
            #add-point:AFTER FIELD gcaq000 name="query.a.page1.gcaq000"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaq000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq000
            #add-point:ON ACTION controlp INFIELD gcaq000 name="query.c.page1.gcaq000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq001
            #add-point:BEFORE FIELD gcaq001 name="query.b.page1.gcaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq001
            
            #add-point:AFTER FIELD gcaq001 name="query.a.page1.gcaq001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq001
            #add-point:ON ACTION controlp INFIELD gcaq001 name="query.c.page1.gcaq001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq002
            #add-point:ON ACTION controlp INFIELD gcaq002 name="construct.c.page1.gcaq002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1  = '2071'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcaq002  #顯示到畫面上

            NEXT FIELD gcaq002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq002
            #add-point:BEFORE FIELD gcaq002 name="query.b.page1.gcaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq002
            
            #add-point:AFTER FIELD gcaq002 name="query.a.page1.gcaq002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq008
            #add-point:BEFORE FIELD gcaq008 name="query.b.page1.gcaq008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq008
            
            #add-point:AFTER FIELD gcaq008 name="query.a.page1.gcaq008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaq008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq008
            #add-point:ON ACTION controlp INFIELD gcaq008 name="query.c.page1.gcaq008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq006
            #add-point:BEFORE FIELD gcaq006 name="query.b.page1.gcaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq006
            
            #add-point:AFTER FIELD gcaq006 name="query.a.page1.gcaq006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq006
            #add-point:ON ACTION controlp INFIELD gcaq006 name="query.c.page1.gcaq006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcaq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq003
            #add-point:ON ACTION controlp INFIELD gcaq003 name="construct.c.page1.gcaq003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gcaq003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcaq003  #顯示到畫面上

            NEXT FIELD gcaq003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq003
            #add-point:BEFORE FIELD gcaq003 name="query.b.page1.gcaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq003
            
            #add-point:AFTER FIELD gcaq003 name="query.a.page1.gcaq003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq005
            #add-point:BEFORE FIELD gcaq005 name="query.b.page1.gcaq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq005
            
            #add-point:AFTER FIELD gcaq005 name="query.a.page1.gcaq005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq005
            #add-point:ON ACTION controlp INFIELD gcaq005 name="query.c.page1.gcaq005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq007
            #add-point:BEFORE FIELD gcaq007 name="query.b.page1.gcaq007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq007
            
            #add-point:AFTER FIELD gcaq007 name="query.a.page1.gcaq007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq007
            #add-point:ON ACTION controlp INFIELD gcaq007 name="query.c.page1.gcaq007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqacti
            #add-point:BEFORE FIELD gcaqacti name="query.b.page1.gcaqacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqacti
            
            #add-point:AFTER FIELD gcaqacti name="query.a.page1.gcaqacti"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gcaqacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqacti
            #add-point:ON ACTION controlp INFIELD gcaqacti name="query.c.page1.gcaqacti"
            
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
    
   CALL agct300_03_b_fill(g_wc2)
 
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
 
{<section id="agct300_03.insert" >}
#+ 資料新增
PRIVATE FUNCTION agct300_03_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL agct300_03_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.modify" >}
#+ 資料修改
PRIVATE FUNCTION agct300_03_modify()
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
   DEFINE l_gcaastus              LIKE gcaa_t.gcaastus  # 08172
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
   # 08172
   SELECT gcaastus INTO l_gcaastus  FROM gcaa_t WHERE gcaaent = g_enterprise AND gcaadocno = g_gcaqdocno
   IF l_gcaastus != 'N' THEN
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
      INPUT ARRAY g_gcaq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcaq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct300_03_b_fill(g_wc2)
            LET g_detail_cnt = g_gcaq_d.getLength()
         
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
            DISPLAY g_gcaq_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gcaq_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gcaq_d[l_ac].gcaqdocno IS NOT NULL
               AND g_gcaq_d[l_ac].gcaq001 IS NOT NULL
               AND g_gcaq_d[l_ac].gcaqseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gcaq_d_t.* = g_gcaq_d[l_ac].*  #BACKUP
               LET g_gcaq_d_o.* = g_gcaq_d[l_ac].*  #BACKUP
               IF NOT agct300_03_lock_b("gcaq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct300_03_bcl INTO g_gcaq_d[l_ac].gcaqdocno,g_gcaq_d[l_ac].gcaqsite,g_gcaq_d[l_ac].gcaqunit, 
                      g_gcaq_d[l_ac].gcaq000,g_gcaq_d[l_ac].gcaq001,g_gcaq_d[l_ac].gcaqseq,g_gcaq_d[l_ac].gcaq002, 
                      g_gcaq_d[l_ac].gcaq008,g_gcaq_d[l_ac].gcaq006,g_gcaq_d[l_ac].gcaq003,g_gcaq_d[l_ac].gcaq005, 
                      g_gcaq_d[l_ac].gcaq009,g_gcaq_d[l_ac].gcaq007,g_gcaq_d[l_ac].gcaqacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gcaq_d_t.gcaqdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcaq_d_mask_o[l_ac].* =  g_gcaq_d[l_ac].*
                  CALL agct300_03_gcaq_t_mask()
                  LET g_gcaq_d_mask_n[l_ac].* =  g_gcaq_d[l_ac].*
                  
                  CALL agct300_03_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL agct300_03_set_entry_b(l_cmd)
            CALL agct300_03_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL agct300_03_set_entry_b(l_cmd)
            CALL agct300_03_set_no_entry_b(l_cmd)
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
            INITIALIZE g_gcaq_d_t.* TO NULL
            INITIALIZE g_gcaq_d_o.* TO NULL
            INITIALIZE g_gcaq_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_gcaq_d[l_ac].gcaqseq = "1"
      LET g_gcaq_d[l_ac].gcaq006 = "1"
      LET g_gcaq_d[l_ac].gcaqacti = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_gcaq_d_t.* = g_gcaq_d[l_ac].*     #新輸入資料
            LET g_gcaq_d_o.* = g_gcaq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcaq_d[li_reproduce_target].* = g_gcaq_d[li_reproduce].*
 
               LET g_gcaq_d[g_gcaq_d.getLength()].gcaqdocno = NULL
               LET g_gcaq_d[g_gcaq_d.getLength()].gcaq001 = NULL
               LET g_gcaq_d[g_gcaq_d.getLength()].gcaqseq = NULL
 
            END IF
            
 
            CALL agct300_03_set_entry_b(l_cmd)
            CALL agct300_03_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_gcaq_d[l_ac].gcaqdocno = g_gcaqdocno
            LET g_gcaq_d[l_ac].gcaqsite  = g_gcaqsite
            LET g_gcaq_d[l_ac].gcaqunit  = g_gcaqunit
            LET g_gcaq_d[l_ac].gcaq000   = g_gcaq000
            LET g_gcaq_d[l_ac].gcaq001   = g_gcaq001
            CALL agct300_03_gcaqseq_init()
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
            SELECT COUNT(1) INTO l_count FROM gcaq_t 
             WHERE gcaqent = g_enterprise AND gcaqdocno = g_gcaq_d[l_ac].gcaqdocno
                                       AND gcaq001 = g_gcaq_d[l_ac].gcaq001
                                       AND gcaqseq = g_gcaq_d[l_ac].gcaqseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaq_d[g_detail_idx].gcaqdocno
               LET gs_keys[2] = g_gcaq_d[g_detail_idx].gcaq001
               LET gs_keys[3] = g_gcaq_d[g_detail_idx].gcaqseq
               CALL agct300_03_insert_b('gcaq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gcaq_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcaq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct300_03_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (gcaqdocno = '", g_gcaq_d[l_ac].gcaqdocno, "' "
                                  ," AND gcaq001 = '", g_gcaq_d[l_ac].gcaq001, "' "
                                  ," AND gcaqseq = '", g_gcaq_d[l_ac].gcaqseq, "' "
 
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
               
               DELETE FROM gcaq_t
                WHERE gcaqent = g_enterprise AND 
                      gcaqdocno = g_gcaq_d_t.gcaqdocno
                      AND gcaq001 = g_gcaq_d_t.gcaq001
                      AND gcaqseq = g_gcaq_d_t.gcaqseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gcaq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL agct300_03_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_gcaq_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE agct300_03_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_gcaq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaq_d_t.gcaqdocno
               LET gs_keys[2] = g_gcaq_d_t.gcaq001
               LET gs_keys[3] = g_gcaq_d_t.gcaqseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agct300_03_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL agct300_03_delete_b('gcaq_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gcaq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqdocno
            #add-point:BEFORE FIELD gcaqdocno name="input.b.page1.gcaqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqdocno
            
            #add-point:AFTER FIELD gcaqdocno name="input.a.page1.gcaqdocno"
            #此段落由子樣板a05產生
            IF  g_gcaq_d[g_detail_idx].gcaqdocno IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq001 IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq002 IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq003 IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaq_d[g_detail_idx].gcaqdocno != g_gcaq_d_t.gcaqdocno OR g_gcaq_d[g_detail_idx].gcaq001 != g_gcaq_d_t.gcaq001 OR g_gcaq_d[g_detail_idx].gcaq002 != g_gcaq_d_t.gcaq002 OR g_gcaq_d[g_detail_idx].gcaq003 != g_gcaq_d_t.gcaq003 OR g_gcaq_d[g_detail_idx].gcaq005 != g_gcaq_d_t.gcaq005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcaq_t WHERE "||"gcaqent = '" ||g_enterprise|| "' AND "||"gcaqdocno = '"||g_gcaq_d[g_detail_idx].gcaqdocno ||"' AND "|| "gcaq001 = '"||g_gcaq_d[g_detail_idx].gcaq001 ||"' AND "|| "gcaq002 = '"||g_gcaq_d[g_detail_idx].gcaq002 ||"' AND "|| "gcaq003 = '"||g_gcaq_d[g_detail_idx].gcaq003 ||"' AND "|| "gcaq005 = '"||g_gcaq_d[g_detail_idx].gcaq005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaqdocno
            #add-point:ON CHANGE gcaqdocno name="input.g.page1.gcaqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqsite
            #add-point:BEFORE FIELD gcaqsite name="input.b.page1.gcaqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqsite
            
            #add-point:AFTER FIELD gcaqsite name="input.a.page1.gcaqsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaqsite
            #add-point:ON CHANGE gcaqsite name="input.g.page1.gcaqsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqunit
            #add-point:BEFORE FIELD gcaqunit name="input.b.page1.gcaqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqunit
            
            #add-point:AFTER FIELD gcaqunit name="input.a.page1.gcaqunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaqunit
            #add-point:ON CHANGE gcaqunit name="input.g.page1.gcaqunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq000
            #add-point:BEFORE FIELD gcaq000 name="input.b.page1.gcaq000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq000
            
            #add-point:AFTER FIELD gcaq000 name="input.a.page1.gcaq000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq000
            #add-point:ON CHANGE gcaq000 name="input.g.page1.gcaq000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq001
            #add-point:BEFORE FIELD gcaq001 name="input.b.page1.gcaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq001
            
            #add-point:AFTER FIELD gcaq001 name="input.a.page1.gcaq001"
            #此段落由子樣板a05產生
            IF  g_gcaq_d[g_detail_idx].gcaqdocno IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq001 IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq002 IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq003 IS NOT NULL AND g_gcaq_d[g_detail_idx].gcaq005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaq_d[g_detail_idx].gcaqdocno != g_gcaq_d_t.gcaqdocno OR g_gcaq_d[g_detail_idx].gcaq001 != g_gcaq_d_t.gcaq001 OR g_gcaq_d[g_detail_idx].gcaq002 != g_gcaq_d_t.gcaq002 OR g_gcaq_d[g_detail_idx].gcaq003 != g_gcaq_d_t.gcaq003 OR g_gcaq_d[g_detail_idx].gcaq005 != g_gcaq_d_t.gcaq005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gcaq_t WHERE "||"gcaqent = '" ||g_enterprise|| "' AND "||"gcaqdocno = '"||g_gcaq_d[g_detail_idx].gcaqdocno ||"' AND "|| "gcaq001 = '"||g_gcaq_d[g_detail_idx].gcaq001 ||"' AND "|| "gcaq002 = '"||g_gcaq_d[g_detail_idx].gcaq002 ||"' AND "|| "gcaq003 = '"||g_gcaq_d[g_detail_idx].gcaq003 ||"' AND "|| "gcaq005 = '"||g_gcaq_d[g_detail_idx].gcaq005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq001
            #add-point:ON CHANGE gcaq001 name="input.g.page1.gcaq001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq002
            
            #add-point:AFTER FIELD gcaq002 name="input.a.page1.gcaq002"
            LET g_gcaq_d[l_ac].gcaq002_desc = ''
            DISPLAY BY NAME g_gcaq_d[l_ac].gcaq002_desc
            IF NOT cl_null(g_gcaq_d[l_ac].gcaq002) THEN
               CALL agct300_03_gcaq002_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaq_d[l_ac].gcaq002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaq_d[l_ac].gcaq002 = g_gcaq_d_t.gcaq002
                  DISPLAY BY NAME g_gcaq_d[l_ac].gcaq002
                  CALL agct300_03_gcaq002_ref()
                  CALL agct300_03_gcaq008_init()
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaq_d[l_ac].gcaq002 != g_gcaq_d_t.gcaq002 OR g_gcaq_d[l_ac].gcaq003 != g_gcaq_d_t.gcaq003 OR g_gcaq_d[l_ac].gcaq005 != g_gcaq_d_t.gcaq005)) THEN
                  CALL agct300_03_repeat_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaq_d[l_ac].gcaq002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     LET g_gcaq_d[l_ac].gcaq002 = g_gcaq_d_t.gcaq002
                     DISPLAY BY NAME g_gcaq_d[l_ac].gcaq002
                     CALL agct300_03_gcaq002_ref()
                     CALL agct300_03_gcaq008_init()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agct300_03_gcaq002_ref()
            CALL agct300_03_gcaq008_init()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq002
            #add-point:BEFORE FIELD gcaq002 name="input.b.page1.gcaq002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq002
            #add-point:ON CHANGE gcaq002 name="input.g.page1.gcaq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq008
            #add-point:BEFORE FIELD gcaq008 name="input.b.page1.gcaq008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq008
            
            #add-point:AFTER FIELD gcaq008 name="input.a.page1.gcaq008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq008
            #add-point:ON CHANGE gcaq008 name="input.g.page1.gcaq008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq006
            #add-point:BEFORE FIELD gcaq006 name="input.b.page1.gcaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq006
            
            #add-point:AFTER FIELD gcaq006 name="input.a.page1.gcaq006"
            IF NOT cl_null(g_gcaq_d[l_ac].gcaq006) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaq_d[l_ac].gcaq002 != g_gcaq_d_t.gcaq002 OR g_gcaq_d[l_ac].gcaq003 != g_gcaq_d_t.gcaq003 OR g_gcaq_d[l_ac].gcaq005 != g_gcaq_d_t.gcaq005 OR g_gcaq_d[l_ac].gcaq006 != g_gcaq_d_t.gcaq006)) THEN   #160824-00007#100 20161024 mark by beckxie
               IF g_gcaq_d[l_ac].gcaq002 != g_gcaq_d_o.gcaq002 OR g_gcaq_d[l_ac].gcaq003 != g_gcaq_d_o.gcaq003 OR g_gcaq_d[l_ac].gcaq005 != g_gcaq_d_o.gcaq005 OR g_gcaq_d[l_ac].gcaq006 != g_gcaq_d_o.gcaq006   #160824-00007#100 20161024 add by beckxie
                  OR cl_null(g_gcaq_d_o.gcaq002) OR cl_null(g_gcaq_d_o.gcaq003) OR cl_null(g_gcaq_d_o.gcaq005) OR cl_null(g_gcaq_d_o.gcaq006) THEN                                                               #160824-00007#100 20161024 add by beckxie
                  IF g_gcaq_d[l_ac].gcaq006 = '3' THEN
                     CALL agct300_03_repeat_chk()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_gcaq_d[l_ac].gcaq006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_gcaq_d[l_ac].gcaq006 = g_gcaq_d_t.gcaq006   #160824-00007#100 20161024 mark by beckxie
                        #160824-00007#100 20161024 add by beckxie---S
                        LET g_gcaq_d[l_ac].gcaq006 = g_gcaq_d_o.gcaq006
                        LET g_gcaq_d[l_ac].gcaq003 = g_gcaq_d_o.gcaq003
                        LET g_gcaq_d[l_ac].gcaq003_desc = g_gcaq_d_o.gcaq003_desc
                        LET g_gcaq_d[l_ac].gcaq007 = g_gcaq_d_o.gcaq007
                        LET g_gcaq_d[l_ac].gcaq009 = g_gcaq_d_o.gcaq009
                        DISPLAY BY NAME g_gcaq_d[l_ac].gcaq007
                        #160824-00007#100 20161024 add by beckxie---E
                        DISPLAY BY NAME g_gcaq_d[l_ac].gcaq006
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               IF g_gcaq_d[l_ac].gcaq006 = '1' THEN
                  LET g_gcaq_d[l_ac].gcaq007 = ''
               ELSE
                  IF cl_null(g_gcaq_d[l_ac].gcaq007) THEN
                     LET g_gcaq_d[l_ac].gcaq007 = 0
                  END IF
               END IF
               IF g_gcaq_d[l_ac].gcaq006 = '3' THEN
                  LET g_gcaq_d[l_ac].gcaq003 = ''
                  LET g_gcaq_d[l_ac].gcaq003_desc = ''
                  LET g_gcaq_d[l_ac].gcaq009 = 0
               ELSE
                  LET g_gcaq_d[l_ac].gcaq009 = ''
               END IF
            END IF
            CALL agct300_03_set_entry_b(l_cmd)
            CALL agct300_03_set_no_entry_b(l_cmd)
            LET g_gcaq_d_o.* = g_gcaq_d[l_ac].*   #160824-00007#100 20161024 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq006
            #add-point:ON CHANGE gcaq006 name="input.g.page1.gcaq006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq003
            
            #add-point:AFTER FIELD gcaq003 name="input.a.page1.gcaq003"
            LET g_gcaq_d[l_ac].gcaq003_desc = ''
            DISPLAY BY NAME g_gcaq_d[l_ac].gcaq003
            IF NOT cl_null(g_gcaq_d[l_ac].gcaq003) THEN
               CALL agct300_03_gcaq003_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaq_d[l_ac].gcaq003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_gcaq_d[l_ac].gcaq003 = g_gcaq_d_t.gcaq003
                  DISPLAY BY NAME g_gcaq_d[l_ac].gcaq003
                  CALL agct300_03_gcaq003_ref()
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaq_d[l_ac].gcaq002 != g_gcaq_d_t.gcaq002 OR g_gcaq_d[l_ac].gcaq003 != g_gcaq_d_t.gcaq003 OR g_gcaq_d[l_ac].gcaq005 != g_gcaq_d_t.gcaq005 OR cl_null(g_gcaq_d_t.gcaq003))) THEN
                  CALL agct300_03_repeat_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcaq_d[l_ac].gcaq003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     LET g_gcaq_d[l_ac].gcaq003 = g_gcaq_d_t.gcaq003
                     DISPLAY BY NAME g_gcaq_d[l_ac].gcaq003
                     CALL agct300_03_gcaq003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agct300_03_gcaq003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq003
            #add-point:BEFORE FIELD gcaq003 name="input.b.page1.gcaq003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq003
            #add-point:ON CHANGE gcaq003 name="input.g.page1.gcaq003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gcaq_d[l_ac].gcaq005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD gcaq005
            END IF 
 
 
 
            #add-point:AFTER FIELD gcaq005 name="input.a.page1.gcaq005"
            IF NOT cl_null(g_gcaq_d[l_ac].gcaq005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcaq_d[l_ac].gcaq002 != g_gcaq_d_t.gcaq002 OR g_gcaq_d[l_ac].gcaq003 != g_gcaq_d_t.gcaq003 OR g_gcaq_d[l_ac].gcaq005 != g_gcaq_d_t.gcaq005)) THEN
                  CALL agct300_03_repeat_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_gcaq_d[l_ac].gcaq005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_gcaq_d[l_ac].gcaq005 = g_gcaq_d_t.gcaq005
                     DISPLAY BY NAME g_gcaq_d[l_ac].gcaq005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq005
            #add-point:BEFORE FIELD gcaq005 name="input.b.page1.gcaq005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq005
            #add-point:ON CHANGE gcaq005 name="input.g.page1.gcaq005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaq007
            #add-point:BEFORE FIELD gcaq007 name="input.b.page1.gcaq007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaq007
            
            #add-point:AFTER FIELD gcaq007 name="input.a.page1.gcaq007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaq007
            #add-point:ON CHANGE gcaq007 name="input.g.page1.gcaq007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcaqacti
            #add-point:BEFORE FIELD gcaqacti name="input.b.page1.gcaqacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcaqacti
            
            #add-point:AFTER FIELD gcaqacti name="input.a.page1.gcaqacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcaqacti
            #add-point:ON CHANGE gcaqacti name="input.g.page1.gcaqacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gcaqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqdocno
            #add-point:ON ACTION controlp INFIELD gcaqdocno name="input.c.page1.gcaqdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqsite
            #add-point:ON ACTION controlp INFIELD gcaqsite name="input.c.page1.gcaqsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqunit
            #add-point:ON ACTION controlp INFIELD gcaqunit name="input.c.page1.gcaqunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq000
            #add-point:ON ACTION controlp INFIELD gcaq000 name="input.c.page1.gcaq000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq001
            #add-point:ON ACTION controlp INFIELD gcaq001 name="input.c.page1.gcaq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq002
            #add-point:ON ACTION controlp INFIELD gcaq002 name="input.c.page1.gcaq002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcaq_d[l_ac].gcaq002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2071" #
            LET g_qryparam.where = " oocq002 IN (SELECT gcap002 ",
                                   "               FROM gcap_t ",
                                   "              WHERE gcapent = '",g_enterprise,"' AND gcapdocno = '",g_gcaq_d[l_ac].gcaqdocno,"') "

            CALL q_oocq002()                                #呼叫開窗

            LET g_gcaq_d[l_ac].gcaq002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcaq_d[l_ac].gcaq002 TO gcaq002              #顯示到畫面上
            
            CALL agct300_03_gcaq002_ref()
            
            CALL agct300_03_gcaq008_init()

            NEXT FIELD gcaq002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq008
            #add-point:ON ACTION controlp INFIELD gcaq008 name="input.c.page1.gcaq008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq006
            #add-point:ON ACTION controlp INFIELD gcaq006 name="input.c.page1.gcaq006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq003
            #add-point:ON ACTION controlp INFIELD gcaq003 name="input.c.page1.gcaq003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcaq_d[l_ac].gcaq003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_gcaqsite #

            CALL q_rtdx001_1()                                #呼叫開窗

            LET g_gcaq_d[l_ac].gcaq003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcaq_d[l_ac].gcaq003 TO gcaq003              #顯示到畫面上
            
            CALL agct300_03_gcaq003_ref()

            NEXT FIELD gcaq003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq005
            #add-point:ON ACTION controlp INFIELD gcaq005 name="input.c.page1.gcaq005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaq007
            #add-point:ON ACTION controlp INFIELD gcaq007 name="input.c.page1.gcaq007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcaqacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcaqacti
            #add-point:ON ACTION controlp INFIELD gcaqacti name="input.c.page1.gcaqacti"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE agct300_03_bcl
               LET INT_FLAG = 0
               LET g_gcaq_d[l_ac].* = g_gcaq_d_t.*
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
               LET g_errparam.extend = g_gcaq_d[l_ac].gcaqdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gcaq_d[l_ac].* = g_gcaq_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL agct300_03_gcaq_t_mask_restore('restore_mask_o')
 
               UPDATE gcaq_t SET (gcaqdocno,gcaqsite,gcaqunit,gcaq000,gcaq001,gcaqseq,gcaq002,gcaq008, 
                   gcaq006,gcaq003,gcaq005,gcaq009,gcaq007,gcaqacti) = (g_gcaq_d[l_ac].gcaqdocno,g_gcaq_d[l_ac].gcaqsite, 
                   g_gcaq_d[l_ac].gcaqunit,g_gcaq_d[l_ac].gcaq000,g_gcaq_d[l_ac].gcaq001,g_gcaq_d[l_ac].gcaqseq, 
                   g_gcaq_d[l_ac].gcaq002,g_gcaq_d[l_ac].gcaq008,g_gcaq_d[l_ac].gcaq006,g_gcaq_d[l_ac].gcaq003, 
                   g_gcaq_d[l_ac].gcaq005,g_gcaq_d[l_ac].gcaq009,g_gcaq_d[l_ac].gcaq007,g_gcaq_d[l_ac].gcaqacti) 
 
                WHERE gcaqent = g_enterprise AND
                  gcaqdocno = g_gcaq_d_t.gcaqdocno #項次   
                  AND gcaq001 = g_gcaq_d_t.gcaq001  
                  AND gcaqseq = g_gcaq_d_t.gcaqseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcaq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcaq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcaq_d[g_detail_idx].gcaqdocno
               LET gs_keys_bak[1] = g_gcaq_d_t.gcaqdocno
               LET gs_keys[2] = g_gcaq_d[g_detail_idx].gcaq001
               LET gs_keys_bak[2] = g_gcaq_d_t.gcaq001
               LET gs_keys[3] = g_gcaq_d[g_detail_idx].gcaqseq
               LET gs_keys_bak[3] = g_gcaq_d_t.gcaqseq
               CALL agct300_03_update_b('gcaq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gcaq_d_t)
                     LET g_log2 = util.JSON.stringify(g_gcaq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agct300_03_gcaq_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL agct300_03_unlock_b("gcaq_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gcaq_d[l_ac].* = g_gcaq_d_t.*
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
               LET g_gcaq_d[li_reproduce_target].* = g_gcaq_d[li_reproduce].*
 
               LET g_gcaq_d[li_reproduce_target].gcaqdocno = NULL
               LET g_gcaq_d[li_reproduce_target].gcaq001 = NULL
               LET g_gcaq_d[li_reproduce_target].gcaqseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcaq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcaq_d.getLength()+1
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
               NEXT FIELD gcaqdocno
 
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
      IF INT_FLAG OR cl_null(g_gcaq_d[g_detail_idx].gcaqdocno) THEN
         CALL g_gcaq_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_gcaq_d[g_detail_idx].* = g_gcaq_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE agct300_03_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agct300_03_delete()
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
   # 08172
   DEFINE l_gcaastus LIKE gcaa_t.gcaastus
   SELECT gcaastus INTO l_gcaastus  FROM gcaa_t WHERE gcaaent = g_enterprise AND gcaadocno = g_gcaqdocno
   IF l_gcaastus != 'N' THEN
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
   FOR li_idx = 1 TO g_gcaq_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT agct300_03_lock_b("gcaq_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("gcaq_t","") THEN
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
   
   FOR li_idx = 1 TO g_gcaq_d.getLength()
      IF g_gcaq_d[li_idx].gcaqdocno IS NOT NULL
         AND g_gcaq_d[li_idx].gcaq001 IS NOT NULL
         AND g_gcaq_d[li_idx].gcaqseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM gcaq_t
          WHERE gcaqent = g_enterprise AND 
                gcaqdocno = g_gcaq_d[li_idx].gcaqdocno
                AND gcaq001 = g_gcaq_d[li_idx].gcaq001
                AND gcaqseq = g_gcaq_d[li_idx].gcaqseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcaq_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_gcaq_d_t.gcaqdocno
               LET gs_keys[2] = g_gcaq_d_t.gcaq001
               LET gs_keys[3] = g_gcaq_d_t.gcaqseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL agct300_03_delete_b('gcaq_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agct300_03_set_pk_array()
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
   CALL agct300_03_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agct300_03_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.gcaqdocno,t0.gcaqsite,t0.gcaqunit,t0.gcaq000,t0.gcaq001,t0.gcaqseq, 
       t0.gcaq002,t0.gcaq008,t0.gcaq006,t0.gcaq003,t0.gcaq005,t0.gcaq009,t0.gcaq007,t0.gcaqacti ,t1.oocql004 , 
       t2.imaal003 FROM gcaq_t t0",
               "",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2071' AND t1.oocql002=t0.gcaq002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.gcaq003 AND t2.imaal002='"||g_dlang||"' ",
 
               " WHERE t0.gcaqent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gcaq_t"),
                      " ORDER BY t0.gcaqdocno,t0.gcaq001,t0.gcaqseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gcaq_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE agct300_03_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR agct300_03_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_gcaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gcaq_d[l_ac].gcaqdocno,g_gcaq_d[l_ac].gcaqsite,g_gcaq_d[l_ac].gcaqunit, 
       g_gcaq_d[l_ac].gcaq000,g_gcaq_d[l_ac].gcaq001,g_gcaq_d[l_ac].gcaqseq,g_gcaq_d[l_ac].gcaq002,g_gcaq_d[l_ac].gcaq008, 
       g_gcaq_d[l_ac].gcaq006,g_gcaq_d[l_ac].gcaq003,g_gcaq_d[l_ac].gcaq005,g_gcaq_d[l_ac].gcaq009,g_gcaq_d[l_ac].gcaq007, 
       g_gcaq_d[l_ac].gcaqacti,g_gcaq_d[l_ac].gcaq002_desc,g_gcaq_d[l_ac].gcaq003_desc
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
      
      CALL agct300_03_detail_show()      
 
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
   
 
   
   CALL g_gcaq_d.deleteElement(g_gcaq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gcaq_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_gcaq_d.getLength() THEN
      LET l_ac = g_gcaq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gcaq_d.getLength()
      LET g_gcaq_d_mask_o[l_ac].* =  g_gcaq_d[l_ac].*
      CALL agct300_03_gcaq_t_mask()
      LET g_gcaq_d_mask_n[l_ac].* =  g_gcaq_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_gcaq_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE agct300_03_pb
   
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION agct300_03_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaq_d[l_ac].gcaq002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcaq_d[l_ac].gcaq002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaq_d[l_ac].gcaq002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcaq_d[l_ac].gcaq003
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_gcaq_d[l_ac].gcaq003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcaq_d[l_ac].gcaq003_desc

   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agct300_03_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry('gcaq003',TRUE)
   CALL cl_set_comp_entry('gcaq007',TRUE)
   CALL cl_set_comp_entry('gcaq009',TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="agct300_03.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agct300_03_set_no_entry_b(p_cmd)                                               
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
   IF cl_null(g_gcaq_d[l_ac].gcaq006) OR g_gcaq_d[l_ac].gcaq006 != '2' THEN
      CALL cl_set_comp_entry('gcaq007',FALSE)
   END IF
   IF cl_null(g_gcaq_d[l_ac].gcaq006) OR g_gcaq_d[l_ac].gcaq006 = '3' THEN
      CALL cl_set_comp_entry('gcaq003',FALSE)
   END IF
   IF cl_null(g_gcaq_d[l_ac].gcaq006) OR g_gcaq_d[l_ac].gcaq006 <> '3' THEN
      CALL cl_set_comp_entry('gcaq009',FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agct300_03_default_search()
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
      LET ls_wc = ls_wc, " gcaqdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gcaq001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " gcaqseq = '", g_argv[03], "' AND "
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
 
{<section id="agct300_03.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agct300_03_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "gcaq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'gcaq_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM gcaq_t
          WHERE gcaqent = g_enterprise AND
            gcaqdocno = ps_keys_bak[1] AND gcaq001 = ps_keys_bak[2] AND gcaqseq = ps_keys_bak[3]
         
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
         CALL g_gcaq_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agct300_03_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "gcaq_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO gcaq_t
                  (gcaqent,
                   gcaqdocno,gcaq001,gcaqseq
                   ,gcaqsite,gcaqunit,gcaq000,gcaq002,gcaq008,gcaq006,gcaq003,gcaq005,gcaq009,gcaq007,gcaqacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_gcaq_d[l_ac].gcaqsite,g_gcaq_d[l_ac].gcaqunit,g_gcaq_d[l_ac].gcaq000,g_gcaq_d[l_ac].gcaq002, 
                       g_gcaq_d[l_ac].gcaq008,g_gcaq_d[l_ac].gcaq006,g_gcaq_d[l_ac].gcaq003,g_gcaq_d[l_ac].gcaq005, 
                       g_gcaq_d[l_ac].gcaq009,g_gcaq_d[l_ac].gcaq007,g_gcaq_d[l_ac].gcaqacti)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcaq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agct300_03_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "gcaq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gcaq_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE gcaq_t 
         SET (gcaqdocno,gcaq001,gcaqseq
              ,gcaqsite,gcaqunit,gcaq000,gcaq002,gcaq008,gcaq006,gcaq003,gcaq005,gcaq009,gcaq007,gcaqacti) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_gcaq_d[l_ac].gcaqsite,g_gcaq_d[l_ac].gcaqunit,g_gcaq_d[l_ac].gcaq000,g_gcaq_d[l_ac].gcaq002, 
                  g_gcaq_d[l_ac].gcaq008,g_gcaq_d[l_ac].gcaq006,g_gcaq_d[l_ac].gcaq003,g_gcaq_d[l_ac].gcaq005, 
                  g_gcaq_d[l_ac].gcaq009,g_gcaq_d[l_ac].gcaq007,g_gcaq_d[l_ac].gcaqacti) 
         WHERE gcaqent = g_enterprise AND gcaqdocno = ps_keys_bak[1] AND gcaq001 = ps_keys_bak[2] AND gcaqseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcaq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcaq_t:",SQLERRMESSAGE 
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
 
{<section id="agct300_03.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agct300_03_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL agct300_03_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gcaq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agct300_03_bcl USING g_enterprise,
                                       g_gcaq_d[g_detail_idx].gcaqdocno,g_gcaq_d[g_detail_idx].gcaq001, 
                                           g_gcaq_d[g_detail_idx].gcaqseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct300_03_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agct300_03_unlock_b(ps_table)
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
      CLOSE agct300_03_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION agct300_03_modify_detail_chk(ps_record)
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
         LET ls_return = "gcaqdocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="agct300_03.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION agct300_03_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="agct300_03.mask_functions" >}
&include "erp/agc/agct300_03_mask.4gl"
 
{</section>}
 
{<section id="agct300_03.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agct300_03_set_pk_array()
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
   LET g_pk_array[1].values = g_gcaq_d[l_ac].gcaqdocno
   LET g_pk_array[1].column = 'gcaqdocno'
   LET g_pk_array[2].values = g_gcaq_d[l_ac].gcaq001
   LET g_pk_array[2].column = 'gcaq001'
   LET g_pk_array[3].values = g_gcaq_d[l_ac].gcaqseq
   LET g_pk_array[3].column = 'gcaqseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct300_03.state_change" >}
   
 
{</section>}
 
{<section id="agct300_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agct300_03.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agct300_03_gcaq002_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaq_d[l_ac].gcaq002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2071' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcaq_d[l_ac].gcaq002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcaq_d[l_ac].gcaq002_desc
END FUNCTION
#+
PRIVATE FUNCTION agct300_03_gcaq002_chk()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus
DEFINE l_cnt        LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET l_cnt = 0 
   
   SELECT oocqstus INTO l_oocqstus
     FROM oocq_t
    WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcaq_d[l_ac].gcaq002
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00011' #该券面额编号不存在
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'agc-00012' #该券面额编号已无效
   END CASE
   IF cl_null(g_errno) THEN
      #判斷券是否存在于券發行面額設定中
      SELECT COUNT(*) INTO l_cnt
        FROM gcap_t
       WHERE gcapent = g_enterprise AND gcapdocno = g_gcaq_d[l_ac].gcaqdocno AND gcap002 = g_gcaq_d[l_ac].gcaq002 AND gcapacti = 'Y'
      IF l_cnt = 0 THEN
         LET g_errno = 'agc-00056' #券面額編號必須存在于該券種的發行面額設定中
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agct300_03_gcaq003_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcaq_d[l_ac].gcaq003
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcaq_d[l_ac].gcaq003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcaq_d[l_ac].gcaq003_desc
END FUNCTION
#+
PRIVATE FUNCTION agct300_03_gcaq003_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus

   INITIALIZE g_errno TO NULL
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdxsite = g_gcaqsite AND rtdx001 = g_gcaq_d[l_ac].gcaq003
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00013' #该商品不存在或在当前组织不可使用
      WHEN l_rtdxstus <> 'Y'   LET g_errno = 'agc-00014' #该商品在当前组织已无效
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agct300_03_gcaq008_init()
   
   IF NOT cl_null(g_gcaq_d[l_ac].gcaq002) THEN
      SELECT oocq009 INTO g_gcaq_d[l_ac].gcaq008
        FROM oocq_t
       WHERE oocqent = g_enterprise AND oocq001 = '2071' AND oocq002 = g_gcaq_d[l_ac].gcaq002
   ELSE
      LET g_gcaq_d[l_ac].gcaq008 = ''
   END IF
   DISPLAY BY NAME g_gcaq_d[l_ac].gcaq008
END FUNCTION
#+
PRIVATE FUNCTION agct300_03_gcaqseq_init()
   SELECT MAX(gcaqseq)+1 INTO g_gcaq_d[l_ac].gcaqseq
     FROM gcaq_t
    WHERE gcaqent = g_enterprise AND gcaqdocno = g_gcaq_d[l_ac].gcaqdocno
   IF cl_null(g_gcaq_d[l_ac].gcaqseq) THEN
      LET g_gcaq_d[l_ac].gcaqseq = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agct300_03_repeat_chk()
DEFINE l_cnt   LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET l_cnt = 0
   
   IF cl_null(g_gcaq_d[l_ac].gcaq006) THEN RETURN END IF
   
   CASE g_gcaq_d[l_ac].gcaq006
      WHEN '3'
         IF cl_null(g_gcaq_d[l_ac].gcaq002) OR cl_null(g_gcaq_d[l_ac].gcaq005) THEN RETURN END IF
         SELECT COUNT(*) INTO l_cnt
           FROM gcaq_t
          WHERE gcaqent = g_enterprise AND gcaqdocno = g_gcaqdocno AND gcaq006 = '3'
            AND gcaq002 = g_gcaq_d[l_ac].gcaq002 AND gcaq005 = g_gcaq_d[l_ac].gcaq005
         IF l_cnt > 0 THEN
            LET g_errno = 'agc-00052' #當提貨商品類型為3.換貨不限定商品時，券面額編號+提貨數量不可重複!
         END IF
      OTHERWISE
         IF cl_null(g_gcaq_d[l_ac].gcaq002) OR cl_null(g_gcaq_d[l_ac].gcaq003) OR cl_null(g_gcaq_d[l_ac].gcaq005) THEN RETURN END IF
         SELECT COUNT(*) INTO l_cnt
           FROM gcaq_t
          WHERE gcaqent = g_enterprise AND gcaqdocno = g_gcaqdocno
            AND gcaq002 = g_gcaq_d[l_ac].gcaq002 AND gcaq003 = g_gcaq_d[l_ac].gcaq003 AND gcaq005 = g_gcaq_d[l_ac].gcaq005
         IF l_cnt > 0 THEN
            LET g_errno = 'agc-00053' #券面額編號+提貨商品編號+提貨數量不可重複!
         END IF
   END CASE
END FUNCTION

 
{</section>}
 
