#該程式未解開Section, 採用最新樣板產出!
{<section id="aini802.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-10-19 14:13:16), PR版次:0005(2016-11-24 16:09:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000023
#+ Filename...: aini802
#+ Description: 貨架商品關係維護作業
#+ Creator....: 06540(2016-06-24 17:23:45)
#+ Modifier...: 02159 -SD/PR- 06137
 
{</section>}
 
{<section id="aini802.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#8   2016/10/19 by sakura 整批修改組織
#161104-00002#3   2016/11/04 By 06137  調整系統*寫法
#161123-00042#3  161124 By 06137  161104-00002 星號寫法, 應補上自定義欄位
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
PRIVATE TYPE type_g_infq_d RECORD
       infqsite LIKE infq_t.infqsite, 
   infqsite_desc LIKE type_t.chr500, 
   infq001 LIKE infq_t.infq001, 
   infq001_desc LIKE type_t.chr500, 
   infq003 LIKE infq_t.infq003, 
   infq003_desc LIKE type_t.chr500, 
   infq002 LIKE infq_t.infq002
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_infq_d          DYNAMIC ARRAY OF type_g_infq_d #單身變數
DEFINE g_infq_d_t        type_g_infq_d                  #單身備份
DEFINE g_infq_d_o        type_g_infq_d                  #單身備份
DEFINE g_infq_d_mask_o   DYNAMIC ARRAY OF type_g_infq_d #單身變數
DEFINE g_infq_d_mask_n   DYNAMIC ARRAY OF type_g_infq_d #單身變數
 
      
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
 
{<section id="aini802.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#8 by sakura add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT infqsite,infq001,infq003,infq002 FROM infq_t WHERE infqent=? AND infqsite=?  
       AND infq001=? AND infq002=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aini802_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aini802 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aini802_init()   
 
      #進入選單 Menu (="N")
      CALL aini802_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aini802
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#8 by sakura add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aini802.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aini802_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#8 by sakura add
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#8 by sakura add
   #end add-point
   
   CALL aini802_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aini802.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aini802_ui_dialog()
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
         CALL g_infq_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aini802_init()
      END IF
   
      CALL aini802_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_infq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL aini802_set_pk_array()
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
            CALL aini802_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aini802_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aini802_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aini802_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION downloadtemplet
            LET g_action_choice="downloadtemplet"
            IF cl_auth_chk_act("downloadtemplet") THEN
               
               #add-point:ON ACTION downloadtemplet name="menu.downloadtemplet"
               CALL s_excel_templet_download()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL aini802_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aini802_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aini802_insert()
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
               CALL aini802_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION uploadtemplet
            LET g_action_choice="uploadtemplet"
            IF cl_auth_chk_act("uploadtemplet") THEN
               
               #add-point:ON ACTION uploadtemplet name="menu.uploadtemplet"
               CALL s_excel_templet_upload() 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
              CALL aini802_excel()
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_infq_d)
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
            CALL aini802_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aini802_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aini802_set_pk_array()
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
 
{<section id="aini802.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aini802_query()
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
   CALL g_infq_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON infqsite,infq001,infq003,infq002 
 
         FROM s_detail1[1].infqsite,s_detail1[1].infq001,s_detail1[1].infq003,s_detail1[1].infq002 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infqsite
            #add-point:BEFORE FIELD infqsite name="query.b.page1.infqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infqsite
            
            #add-point:AFTER FIELD infqsite name="query.a.page1.infqsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.infqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infqsite
            #add-point:ON ACTION controlp INFIELD infqsite name="query.c.page1.infqsite"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infqsite',g_site,'c') 
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO infqsite  #顯示到畫面上
            NEXT FIELD infqsite                     #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infq001
            #add-point:BEFORE FIELD infq001 name="query.b.page1.infq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infq001
            
            #add-point:AFTER FIELD infq001 name="query.a.page1.infq001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.infq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infq001
            #add-point:ON ACTION controlp INFIELD infq001 name="query.c.page1.infq001"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infq001  #顯示到畫面上
            NEXT FIELD infq001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infq003
            #add-point:BEFORE FIELD infq003 name="query.b.page1.infq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infq003
            
            #add-point:AFTER FIELD infq003 name="query.a.page1.infq003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.infq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infq003
            #add-point:ON ACTION controlp INFIELD infq003 name="query.c.page1.infq003"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = g_site
            CALL q_rtdx001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infq003  #顯示到畫面上
            NEXT FIELD infq003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infq002
            #add-point:BEFORE FIELD infq002 name="query.b.page1.infq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infq002
            
            #add-point:AFTER FIELD infq002 name="query.a.page1.infq002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.infq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infq002
            #add-point:ON ACTION controlp INFIELD infq002 name="query.c.page1.infq002"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_infq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infq002  #顯示到畫面上4
            NEXT FIELD infq002                     #返回原欄位
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
    
   CALL aini802_b_fill(g_wc2)
 
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
 
{<section id="aini802.insert" >}
#+ 資料新增
PRIVATE FUNCTION aini802_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aini802_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aini802.modify" >}
#+ 資料修改
PRIVATE FUNCTION aini802_modify()
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
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_errno      STRING
   DEFINE l_t          INT  
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
      INPUT ARRAY g_infq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_infq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aini802_b_fill(g_wc2)
            LET g_detail_cnt = g_infq_d.getLength()
         
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
            DISPLAY g_infq_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_infq_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_infq_d[l_ac].infqsite IS NOT NULL
               AND g_infq_d[l_ac].infq001 IS NOT NULL
               AND g_infq_d[l_ac].infq002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_infq_d_t.* = g_infq_d[l_ac].*  #BACKUP
               LET g_infq_d_o.* = g_infq_d[l_ac].*  #BACKUP
               IF NOT aini802_lock_b("infq_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini802_bcl INTO g_infq_d[l_ac].infqsite,g_infq_d[l_ac].infq001,g_infq_d[l_ac].infq003, 
                      g_infq_d[l_ac].infq002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_infq_d_t.infqsite,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_infq_d_mask_o[l_ac].* =  g_infq_d[l_ac].*
                  CALL aini802_infq_t_mask()
                  LET g_infq_d_mask_n[l_ac].* =  g_infq_d[l_ac].*
                  
                  CALL aini802_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aini802_set_entry_b(l_cmd)
            CALL aini802_set_no_entry_b(l_cmd)
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
            INITIALIZE g_infq_d_t.* TO NULL
            INITIALIZE g_infq_d_o.* TO NULL
            INITIALIZE g_infq_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_infq_d_t.* = g_infq_d[l_ac].*     #新輸入資料
            LET g_infq_d_o.* = g_infq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_infq_d[li_reproduce_target].* = g_infq_d[li_reproduce].*
 
               LET g_infq_d[g_infq_d.getLength()].infqsite = NULL
               LET g_infq_d[g_infq_d.getLength()].infq001 = NULL
               LET g_infq_d[g_infq_d.getLength()].infq002 = NULL
 
            END IF
            
 
            CALL aini802_set_entry_b(l_cmd)
            CALL aini802_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM infq_t 
             WHERE infqent = g_enterprise AND infqsite = g_infq_d[l_ac].infqsite
                                       AND infq001 = g_infq_d[l_ac].infq001
                                       AND infq002 = g_infq_d[l_ac].infq002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infq_d[g_detail_idx].infqsite
               LET gs_keys[2] = g_infq_d[g_detail_idx].infq001
               LET gs_keys[3] = g_infq_d[g_detail_idx].infq002
               CALL aini802_insert_b('infq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_infq_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "infq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aini802_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (infqsite = '", g_infq_d[l_ac].infqsite, "' "
                                  ," AND infq001 = '", g_infq_d[l_ac].infq001, "' "
                                  ," AND infq002 = '", g_infq_d[l_ac].infq002, "' "
 
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
               
               DELETE FROM infq_t
                WHERE infqent = g_enterprise AND 
                      infqsite = g_infq_d_t.infqsite
                      AND infq001 = g_infq_d_t.infq001
                      AND infq002 = g_infq_d_t.infq002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "infq_t:",SQLERRMESSAGE 
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
                  CALL aini802_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_infq_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aini802_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_infq_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infq_d_t.infqsite
               LET gs_keys[2] = g_infq_d_t.infq001
               LET gs_keys[3] = g_infq_d_t.infq002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aini802_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aini802_delete_b('infq_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_infq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infqsite
            
            #add-point:AFTER FIELD infqsite name="input.a.page1.infqsite"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_infq_d[l_ac].infqsite IS NOT NULL THEN 
                 CALL s_aooi500_chk(g_prog,'infqsite',g_infq_d[l_ac].infqsite,g_site) RETURNING l_success,l_errno
                 IF NOT l_success THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ''
                    LET g_errparam.code   = l_errno
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()
                    NEXT FIELD infqsite
                  END IF
            ELSE
                 NEXT FIELD infqsite  
            END IF 
            
            IF  g_infq_d[g_detail_idx].infqsite IS NOT NULL AND g_infq_d[g_detail_idx].infq001 IS NOT NULL AND g_infq_d[g_detail_idx].infq002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_infq_d[g_detail_idx].infqsite != g_infq_d_t.infqsite OR g_infq_d[g_detail_idx].infq001 != g_infq_d_t.infq001 OR g_infq_d[g_detail_idx].infq002 != g_infq_d_t.infq002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM infq_t WHERE "||"infqent = '" ||g_enterprise|| "' AND "||"infqsite = '"||g_infq_d[g_detail_idx].infqsite ||"' AND "|| "infq001 = '"||g_infq_d[g_detail_idx].infq001 ||"' AND "|| "infq002 = '"||g_infq_d[g_detail_idx].infq002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infq_d[l_ac].infqsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_infq_d[l_ac].infqsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infq_d[l_ac].infqsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infqsite
            #add-point:BEFORE FIELD infqsite name="input.b.page1.infqsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infqsite
            #add-point:ON CHANGE infqsite name="input.g.page1.infqsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infq001
            
            #add-point:AFTER FIELD infq001 name="input.a.page1.infq001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
             
            IF NOT cl_null(g_infq_d[l_ac].infq001) THEN
               LET l_t=0   
               SELECT count(*) INTO l_t FROM inaa_t 
               WHERE inaasite=g_infq_d[l_ac].infqsite AND inaaent=g_enterprise AND inaa001=g_infq_d[l_ac].infq001 AND inaastus='Y' 
               IF l_t=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ain-00767"
                  LET g_errparam.extend = g_infq_d[l_ac].infq001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD infq001                        
               END IF   
                  
            END IF       
            IF  g_infq_d[g_detail_idx].infqsite IS NOT NULL AND g_infq_d[g_detail_idx].infq001 IS NOT NULL AND g_infq_d[g_detail_idx].infq002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_infq_d[g_detail_idx].infqsite != g_infq_d_t.infqsite OR g_infq_d[g_detail_idx].infq001 != g_infq_d_t.infq001 OR g_infq_d[g_detail_idx].infq002 != g_infq_d_t.infq002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM infq_t WHERE "||"infqent = '" ||g_enterprise|| "' AND "||"infqsite = '"||g_infq_d[g_detail_idx].infqsite ||"' AND "|| "infq001 = '"||g_infq_d[g_detail_idx].infq001 ||"' AND "|| "infq002 = '"||g_infq_d[g_detail_idx].infq002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infq_d[l_ac].infq001
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_infq_d[l_ac].infq001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infq_d[l_ac].infq001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infq001
            #add-point:BEFORE FIELD infq001 name="input.b.page1.infq001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infq001
            #add-point:ON CHANGE infq001 name="input.g.page1.infq001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infq003
            
            #add-point:AFTER FIELD infq003 name="input.a.page1.infq003"
            IF NOT cl_null(g_infq_d[l_ac].infq003) THEN 
            
               SELECT COUNT(*) INTO l_cnt
               FROM rtdx_t
               WHERE rtdxent = g_enterprise
               AND rtdxsite = g_infq_d[l_ac].infqsite
               AND rtdx001 = g_infq_d[l_ac].infq003
               #AND rtdx003 = '5'
      
              IF l_cnt = 0 THEN         
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "art-00151"
                 LET g_errparam.extend = g_infq_d[l_ac].infq003
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 NEXT FIELD infq003                        
               END IF   
             END IF                  
            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infq_d[l_ac].infq003
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_infq_d[l_ac].infq003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infq_d[l_ac].infq003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infq003
            #add-point:BEFORE FIELD infq003 name="input.b.page1.infq003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infq003
            #add-point:ON CHANGE infq003 name="input.g.page1.infq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infq002
            #add-point:BEFORE FIELD infq002 name="input.b.page1.infq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infq002
            
            #add-point:AFTER FIELD infq002 name="input.a.page1.infq002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
           
            IF  g_infq_d[g_detail_idx].infqsite IS NOT NULL AND g_infq_d[g_detail_idx].infq001 IS NOT NULL AND g_infq_d[g_detail_idx].infq002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_infq_d[g_detail_idx].infqsite != g_infq_d_t.infqsite OR g_infq_d[g_detail_idx].infq001 != g_infq_d_t.infq001 OR g_infq_d[g_detail_idx].infq002 != g_infq_d_t.infq002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM infq_t WHERE "||"infqent = '" ||g_enterprise|| "' AND "||"infqsite = '"||g_infq_d[g_detail_idx].infqsite ||"' AND "|| "infq001 = '"||g_infq_d[g_detail_idx].infq001 ||"' AND "|| "infq002 = '"||g_infq_d[g_detail_idx].infq002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infq002
            #add-point:ON CHANGE infq002 name="input.g.page1.infq002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.infqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infqsite
            #add-point:ON ACTION controlp INFIELD infqsite name="input.c.page1.infqsite"
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infqsite',g_site,'c') 
            CALL q_ooef001_24()
            let g_infq_d[l_ac].infqsite=g_qryparam.return1
            DISPLAY g_infq_d[l_ac].infqsite TO infqsite  #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infq_d[l_ac].infqsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_infq_d[l_ac].infqsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infq_d[l_ac].infqsite_desc
            NEXT FIELD infqsite                     #返回原欄位
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.infq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infq001
            #add-point:ON ACTION controlp INFIELD infq001 name="input.c.page1.infq001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            let g_infq_d[l_ac].infq001=g_qryparam.return1
            DISPLAY g_infq_d[l_ac].infq001 TO infq001  #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infq_d[l_ac].infq001
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_infq_d[l_ac].infq001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infq_d[l_ac].infq001_desc
            NEXT FIELD infq001                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.infq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infq003
            #add-point:ON ACTION controlp INFIELD infq003 name="input.c.page1.infq003"

		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = g_infq_d[l_ac].infqsite
            CALL q_rtdx001_1()                           #呼叫開窗
            LET g_infq_d[l_ac].infq003=g_qryparam.return1
            DISPLAY g_infq_d[l_ac].infq003 TO infq003  #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infq_d[l_ac].infq003
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_infq_d[l_ac].infq003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infq_d[l_ac].infq003_desc
            NEXT FIELD infq003                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.infq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infq002
            #add-point:ON ACTION controlp INFIELD infq002 name="input.c.page1.infq002"

#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#		   	LET g_qryparam.reqry = FALSE
#            CALL q_infq002()                           #呼叫開窗
#            let g_infq_d[l_ac].infq002= g_qryparam.return1
#            DISPLAY g_infq_d[l_ac].infq002 TO infq002  #顯示到畫面上4
#            NEXT FIELD infq002                     #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aini802_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_infq_d[l_ac].* = g_infq_d_t.*
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
               LET g_errparam.extend = g_infq_d[l_ac].infqsite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_infq_d[l_ac].* = g_infq_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aini802_infq_t_mask_restore('restore_mask_o')
 
               UPDATE infq_t SET (infqsite,infq001,infq003,infq002) = (g_infq_d[l_ac].infqsite,g_infq_d[l_ac].infq001, 
                   g_infq_d[l_ac].infq003,g_infq_d[l_ac].infq002)
                WHERE infqent = g_enterprise AND
                  infqsite = g_infq_d_t.infqsite #項次   
                  AND infq001 = g_infq_d_t.infq001  
                  AND infq002 = g_infq_d_t.infq002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "infq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "infq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infq_d[g_detail_idx].infqsite
               LET gs_keys_bak[1] = g_infq_d_t.infqsite
               LET gs_keys[2] = g_infq_d[g_detail_idx].infq001
               LET gs_keys_bak[2] = g_infq_d_t.infq001
               LET gs_keys[3] = g_infq_d[g_detail_idx].infq002
               LET gs_keys_bak[3] = g_infq_d_t.infq002
               CALL aini802_update_b('infq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_infq_d_t)
                     LET g_log2 = util.JSON.stringify(g_infq_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aini802_infq_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aini802_unlock_b("infq_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_infq_d[l_ac].* = g_infq_d_t.*
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
               LET g_infq_d[li_reproduce_target].* = g_infq_d[li_reproduce].*
 
               LET g_infq_d[li_reproduce_target].infqsite = NULL
               LET g_infq_d[li_reproduce_target].infq001 = NULL
               LET g_infq_d[li_reproduce_target].infq002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_infq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_infq_d.getLength()+1
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
               NEXT FIELD infqsite
 
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
      IF INT_FLAG OR cl_null(g_infq_d[g_detail_idx].infqsite) THEN
         CALL g_infq_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_infq_d[g_detail_idx].* = g_infq_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aini802_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aini802.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aini802_delete()
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
   FOR li_idx = 1 TO g_infq_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aini802_lock_b("infq_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("infq_t","") THEN
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
   
   FOR li_idx = 1 TO g_infq_d.getLength()
      IF g_infq_d[li_idx].infqsite IS NOT NULL
         AND g_infq_d[li_idx].infq001 IS NOT NULL
         AND g_infq_d[li_idx].infq002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM infq_t
          WHERE infqent = g_enterprise AND 
                infqsite = g_infq_d[li_idx].infqsite
                AND infq001 = g_infq_d[li_idx].infq001
                AND infq002 = g_infq_d[li_idx].infq002
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infq_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_infq_d_t.infqsite
               LET gs_keys[2] = g_infq_d_t.infq001
               LET gs_keys[3] = g_infq_d_t.infq002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aini802_delete_b('infq_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aini802_set_pk_array()
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
   CALL aini802_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aini802.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aini802_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   define l_where  string 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
  CALL s_aooi500_sql_where(g_prog,'infqsite') RETURNING l_where
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.infqsite,t0.infq001,t0.infq003,t0.infq002 ,t1.ooefl003 ,t2.inayl003 , 
       t3.imaal003 FROM infq_t t0",
               "",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.infqsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=t0.infq001 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.infq003 AND t3.imaal002='"||g_dlang||"' ",
 
               " WHERE t0.infqent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   let g_sql=g_sql," and ",l_where
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("infq_t"),
                      " ORDER BY t0.infqsite,t0.infq001,t0.infq002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"infq_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aini802_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aini802_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_infq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_infq_d[l_ac].infqsite,g_infq_d[l_ac].infq001,g_infq_d[l_ac].infq003,g_infq_d[l_ac].infq002, 
       g_infq_d[l_ac].infqsite_desc,g_infq_d[l_ac].infq001_desc,g_infq_d[l_ac].infq003_desc
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
      
      CALL aini802_detail_show()      
 
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
   
 
   
   CALL g_infq_d.deleteElement(g_infq_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_infq_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_infq_d.getLength() THEN
      LET l_ac = g_infq_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_infq_d.getLength()
      LET g_infq_d_mask_o[l_ac].* =  g_infq_d[l_ac].*
      CALL aini802_infq_t_mask()
      LET g_infq_d_mask_n[l_ac].* =  g_infq_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_infq_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aini802_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aini802.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aini802_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aini802.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aini802_set_entry_b(p_cmd)                                                  
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
 
{<section id="aini802.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aini802_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aini802.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aini802_default_search()
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
      LET ls_wc = ls_wc, " infqsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " infq001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " infq002 = '", g_argv[03], "' AND "
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
 
{<section id="aini802.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aini802_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "infq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'infq_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM infq_t
          WHERE infqent = g_enterprise AND
            infqsite = ps_keys_bak[1] AND infq001 = ps_keys_bak[2] AND infq002 = ps_keys_bak[3]
         
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
         CALL g_infq_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aini802.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aini802_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "infq_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO infq_t
                  (infqent,
                   infqsite,infq001,infq002
                   ,infq003) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_infq_d[l_ac].infq003)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aini802.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aini802_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "infq_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "infq_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE infq_t 
         SET (infqsite,infq001,infq002
              ,infq003) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_infq_d[l_ac].infq003) 
         WHERE infqent = g_enterprise AND infqsite = ps_keys_bak[1] AND infq001 = ps_keys_bak[2] AND infq002 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infq_t:",SQLERRMESSAGE 
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
 
{<section id="aini802.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aini802_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aini802_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "infq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aini802_bcl USING g_enterprise,
                                       g_infq_d[g_detail_idx].infqsite,g_infq_d[g_detail_idx].infq001, 
                                           g_infq_d[g_detail_idx].infq002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aini802_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aini802.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aini802_unlock_b(ps_table)
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
      CLOSE aini802_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aini802.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aini802_modify_detail_chk(ps_record)
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
         LET ls_return = "infqsite"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aini802.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aini802_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="aini802.mask_functions" >}
&include "erp/ain/aini802_mask.4gl"
 
{</section>}
 
{<section id="aini802.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aini802_set_pk_array()
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
   LET g_pk_array[1].values = g_infq_d[l_ac].infqsite
   LET g_pk_array[1].column = 'infqsite'
   LET g_pk_array[2].values = g_infq_d[l_ac].infq001
   LET g_pk_array[2].column = 'infq001'
   LET g_pk_array[3].values = g_infq_d[l_ac].infq002
   LET g_pk_array[3].column = 'infq002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aini802.state_change" >}
   
 
{</section>}
 
{<section id="aini802.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aini802.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aini802_excel()

   DEFINE ls_str        STRING,
          ls_file       STRING,
          ls_location   STRING
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_suc         LIKE type_t.chr1
   DEFINE l_path   STRING
   DEFINE xlapp,iRes,iRow,i,j     INTEGER
   DEFINE sValue                  STRING
   DEFINE gs_location   STRING
   DEFINE g_fileloc               STRING
   DEFINE p_row,p_col,l_n         SMALLINT
   DEFINE l_msg        STRING
   DEFINE l_msg1       STRING #lanjj ADD ON 2016-03-30
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_t         LIKE type_t.num10
   DEFINE l_cnt1         LIKE type_t.num10
   DEFINE l_count   LIKE rtdv_t.rtdv019   #進價*訂貨數(計稅基礎)  
   DEFINE l_str             STRING 
   DEFINE l_sql             STRING 
   #DEFINE l_infq  RECORD LIKE infq_t.*    #161104-00002#3 Mark By Ken 161105
   #161104-00002#3 Add By Ken 161105(S)
DEFINE l_infq RECORD  #貨架位置商品關係表
       infqent LIKE infq_t.infqent,   #企業代碼
       infqsite LIKE infq_t.infqsite, #營運據點
       infq001 LIKE infq_t.infq001,   #庫區編號
       infq002 LIKE infq_t.infq002,   #貨架位置
       infq003 LIKE infq_t.infq003    #商品編號
END RECORD
   #161104-00002#3 Add By Ken 161105(E)
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_insert       LIKE type_t.num5
      

   WHENEVER ERROR CALL cl_err_msg_log      
   LET l_success = 'Y'
   #获取EXCEL文档所在位置
   CALL ui.Interface.frontCall("standard","openfile",["C:", "All Files", "*.*", "File Browser"],[gs_location])
   
   LET g_fileloc=gs_location
   
   IF cl_null(g_fileloc) THEN 
      RETURN
   END IF
   
   IF l_success='Y' THEN
   #创建EXCEL实例进程
      #MS OFFICE EXCEL
      CALL ui.interface.frontCall('WinCOM','CreateInstance',['Excel.Application'],[xlApp])
      IF xlApp = -1 THEN
         #KS WPS 9.0 KET
         CALL ui.interface.frontCall('WinCOM','CreateInstance',['Ket.Application'],[xlApp])
      END IF
      IF xlApp = -1 THEN
         #KS WPS 8.0及以下 ET
         CALL ui.interface.frontCall('WinCOM','CreateInstance',['ET.Application'],[xlApp])
      END IF
      IF xlApp <> -1 THEN
         #打开EXCEL文件
         CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Workbooks.Open',g_fileloc],[iRes])
         IF iRes <> -1 THEN
            #获取EXCEL中的行数
            CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
            
            IF iRow > 1 THEN
               LET l_n = 0
               CALL cl_showmsg_init()
               #显示进度条，EXCEL中有多少行不算正式数据就减多少
               CALL cl_progress_bar(iRow-2)              
               #BEGIN WORK
               CALL s_transaction_begin() 
               CALL cl_err_collect_init()              
               FOR i = 3 TO iRow             
                  LET l_n = l_n +1                   
                  IF iRow > = l_n THEN
                     CALL cl_progress_ing('正在导入第'||i||'行数据')
                  END IF 
                  
                  INITIALIZE l_infq.* TO NULL
                  
                  CALL ui.interface.frontcall('WinCOM','GetProperty',
                                              [xlApp,'ActiveSheet.Range("A'||i||':D'||i||'").value'],                                                                                      
                                              [l_infq.infq002,l_infq.infq003,l_infq.infq001,l_infq.infqsite ])
                                                                  
                  LET l_msg = "导入excel中第",i,"行数据失败"
                  LET l_msg1 = "导入excel中第",i,"行"
                  CALL aini802_excel_chk(l_infq.*,'') RETURNING l_suc
                  IF NOT l_suc THEN
                     LET l_success='N'                  
                     CONTINUE FOR
                  END IF
                   LET r_insert=TRUE
                  CALL s_aooi500_default(g_prog,'infqsite',l_infq.infqsite) RETURNING r_insert,l_infq.infqsite
                     IF NOT r_insert THEN
                        LET l_success='N'  
                     END IF 
                   LET l_t=0   
                   SELECT count(*) INTO l_t FROM inaa_t 
                   WHERE inaasite=l_infq.infqsite AND inaaent=g_enterprise AND inaa001=l_infq.infq001 AND inaastus='Y' 
                   IF l_t=0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = "第",i,"行数据"
                      LET g_errparam.code = "ain-00767"                     
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                     LET l_success='N'                      
                   END IF
                   LET l_cnt=0
                   SELECT COUNT(*) INTO l_cnt
                   FROM rtdx_t
                   WHERE rtdxent = g_enterprise
                   AND rtdxsite = l_infq.infqsite
                   AND rtdx001 =  l_infq.infq003
                   #AND rtdx003 = '5'                  
                   IF l_cnt = 0 THEN         
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "第",i,"行数据"
                     LET g_errparam.code = "art-00151"
                     LET g_errparam.popup = TRUE
                     CALL cl_err() 
                     LET l_success='N'                     
                   END IF   
                                        
                  LET g_sql=" INSERT INTO infq_t (infqent,infqsite,infq001,infq002,infq003)",
                        "VALUES (?,?,?,?,?)"
                  PREPARE ins_infq FROM g_sql
                  EXECUTE ins_infq  USING g_enterprise,l_infq.infqsite,l_infq.infq001,l_infq.infq002,l_infq.infq003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "第",i,"行数据" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_success='N'
                     CONTINUE FOR
                  END IF
               END FOR
               
               #如果意外停职循环则关闭进度条
               IF i<> iRow  THEN  
                  CALL cl_progress_counter_increase()  
               END IF               
               IF l_success='Y' THEN
                  CALL s_transaction_end('Y','0')
                  CALL aini802_dr()
                  CALL aini802_b_fill('')
               ELSE
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
               END IF
            END IF
         ELSE 
            DISPLAY 'NO FILE'
         END IF
      ELSE
   	   DISPLAY 'NO EXCEL'
      END IF 
   
      CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
      CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])
      
      CALL cl_showmsg()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aini802_excel_chk(p_infq,p_msg)
   DEFINE  p_msg      STRING 
   #DEFINE  p_infq  RECORD LIKE infq_t.*   #161104-00002#3 Mark By Ken 161105
   #161104-00002#3 Add By Ken 161105(S)
DEFINE p_infq RECORD  #貨架位置商品關係表
       infqent LIKE infq_t.infqent,   #企業代碼
       infqsite LIKE infq_t.infqsite, #營運據點
       infq001 LIKE infq_t.infq001,   #庫區編號
       infq002 LIKE infq_t.infq002,   #貨架位置
       infq003 LIKE infq_t.infq003    #商品編號
END RECORD   
   #161104-00002#3 Add By Ken 161105(E)
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_errno      STRING   
   DEFINE  l_cnt LIKE type_t.num5
   
   CASE
      WHEN (cl_null(p_infq.infqsite)) 
         CALL cl_errmsg('infqsite','营运组织不可为空',p_msg,'!',1)
         RETURN FALSE 
      WHEN (cl_null(p_infq.infq001)) 
         CALL cl_errmsg('infq001','库区编号不可为空',p_msg,'!',1)
         RETURN FALSE 
      WHEN (cl_null(p_infq.infq002))
         CALL cl_errmsg('infq002','货架位置不可为空',p_msg,'!',1)
         RETURN FALSE 
      WHEN (cl_null(p_infq.infq003))
         CALL cl_errmsg('infq003','商品编号不可为空',p_msg,'!',1)
         RETURN FALSE 
   END CASE      
   IF NOT cl_null(p_infq.infqsite) THEN 
       CALL s_aooi500_chk(g_prog,'infqsite',p_infq.infqsite,g_site) RETURNING l_success,l_errno
       IF NOT l_success THEN
         CALL cl_errmsg('infqsite','营运据点错误，请核实！',p_msg,'!',1)
         RETURN FALSE 
       END IF
   END IF     
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aini802_dr()
 DEFINE ls_msg     STRING
   DEFINE ls_title   STRING

   WHENEVER ERROR CALL cl_err_msg_log

   LET ls_msg = cl_getmsg("ast-00782",g_lang)
   LET ls_title = cl_getmsg("lib-041",g_lang)

   #若為背景進入(Y)時,不詢問直接離開 (0729)
   IF g_bgjob = "Y" THEN
   ELSE
      MENU ls_title ATTRIBUTE (STYLE="dialog", COMMENT=ls_msg CLIPPED, IMAGE="information")
         ON ACTION ok
            EXIT MENU
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE MENU
      END MENU

      IF INT_FLAG THEN
         LET INT_FLAG = 0
      END IF
   END IF
END FUNCTION

 
{</section>}
 
