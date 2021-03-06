#該程式未解開Section, 採用最新樣板產出!
{<section id="ammi200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-09-22 14:37:26), PR版次:0001(2016-10-05 10:20:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ammi200
#+ Description: 會員晉級商品範圍維護作業
#+ Creator....: 06137(2016-09-22 13:47:18)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="ammi200.global" >}
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
PRIVATE TYPE type_g_mmdn_d RECORD
       mmdnstus LIKE mmdn_t.mmdnstus, 
   mmdn001 LIKE mmdn_t.mmdn001, 
   mmdn002 LIKE mmdn_t.mmdn002, 
   mmdn003 LIKE mmdn_t.mmdn003, 
   mmdn003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_mmdn2_d RECORD
       mmdn001 LIKE mmdn_t.mmdn001, 
   mmdn002 LIKE mmdn_t.mmdn002, 
   mmdn003 LIKE mmdn_t.mmdn003, 
   mmdnownid LIKE mmdn_t.mmdnownid, 
   mmdnownid_desc LIKE type_t.chr500, 
   mmdnowndp LIKE mmdn_t.mmdnowndp, 
   mmdnowndp_desc LIKE type_t.chr500, 
   mmdncrtid LIKE mmdn_t.mmdncrtid, 
   mmdncrtid_desc LIKE type_t.chr500, 
   mmdncrtdp LIKE mmdn_t.mmdncrtdp, 
   mmdncrtdp_desc LIKE type_t.chr500, 
   mmdncrtdt DATETIME YEAR TO SECOND, 
   mmdnmodid LIKE mmdn_t.mmdnmodid, 
   mmdnmodid_desc LIKE type_t.chr500, 
   mmdnmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_mmdn_d          DYNAMIC ARRAY OF type_g_mmdn_d #單身變數
DEFINE g_mmdn_d_t        type_g_mmdn_d                  #單身備份
DEFINE g_mmdn_d_o        type_g_mmdn_d                  #單身備份
DEFINE g_mmdn_d_mask_o   DYNAMIC ARRAY OF type_g_mmdn_d #單身變數
DEFINE g_mmdn_d_mask_n   DYNAMIC ARRAY OF type_g_mmdn_d #單身變數
DEFINE g_mmdn2_d   DYNAMIC ARRAY OF type_g_mmdn2_d
DEFINE g_mmdn2_d_t type_g_mmdn2_d
DEFINE g_mmdn2_d_o type_g_mmdn2_d
DEFINE g_mmdn2_d_mask_o DYNAMIC ARRAY OF type_g_mmdn2_d
DEFINE g_mmdn2_d_mask_n DYNAMIC ARRAY OF type_g_mmdn2_d
 
      
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
 
{<section id="ammi200.main" >}
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
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mmdnstus,mmdn001,mmdn002,mmdn003,mmdn001,mmdn002,mmdn003,mmdnownid,mmdnowndp, 
       mmdncrtid,mmdncrtdp,mmdncrtdt,mmdnmodid,mmdnmoddt FROM mmdn_t WHERE mmdnent=? AND mmdn001=? AND  
       mmdn002=? AND mmdn003=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammi200_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammi200 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammi200_init()   
 
      #進入選單 Menu (="N")
      CALL ammi200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammi200
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammi200.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ammi200_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('mmdn001','6761') 
   CALL cl_set_combo_scc('mmdn002','6517') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('mmdn002','6517','4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L')   
   #end add-point
   
   CALL ammi200_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="ammi200.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION ammi200_ui_dialog()
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
         CALL g_mmdn_d.clear()
         CALL g_mmdn2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL ammi200_init()
      END IF
   
      CALL ammi200_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mmdn_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_mmdn2_d[g_detail_idx].mmdnownid   #(ver:35)
               LET g_data_dept = g_mmdn2_d[g_detail_idx].mmdnowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL ammi200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_mmdn2_d TO s_detail2.*
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
   CALL ammi200_set_pk_array()
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
            CALL ammi200_set_act_visible_b()
            CALL ammi200_set_act_no_visible_b()
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL ammi200_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL ammi200_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL ammi200_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL ammi200_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL ammi200_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL ammi200_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammi200_insert()
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
               CALL ammi200_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_mmdn_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_mmdn2_d)
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
            CALL ammi200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammi200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammi200_set_pk_array()
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
 
{<section id="ammi200.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammi200_query()
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
   CALL g_mmdn_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON mmdnstus,mmdn001,mmdn002,mmdn003,mmdnownid,mmdnowndp,mmdncrtid,mmdncrtdp,mmdncrtdt, 
          mmdnmodid,mmdnmoddt 
 
         FROM s_detail1[1].mmdnstus,s_detail1[1].mmdn001,s_detail1[1].mmdn002,s_detail1[1].mmdn003,s_detail2[1].mmdnownid, 
             s_detail2[1].mmdnowndp,s_detail2[1].mmdncrtid,s_detail2[1].mmdncrtdp,s_detail2[1].mmdncrtdt, 
             s_detail2[1].mmdnmodid,s_detail2[1].mmdnmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmdncrtdt>>----
         AFTER FIELD mmdncrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmdnmoddt>>----
         AFTER FIELD mmdnmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmdncnfdt>>----
         
         #----<<mmdnpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdnstus
            #add-point:BEFORE FIELD mmdnstus name="query.b.page1.mmdnstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdnstus
            
            #add-point:AFTER FIELD mmdnstus name="query.a.page1.mmdnstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mmdnstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdnstus
            #add-point:ON ACTION controlp INFIELD mmdnstus name="query.c.page1.mmdnstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdn001
            #add-point:BEFORE FIELD mmdn001 name="query.b.page1.mmdn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdn001
            
            #add-point:AFTER FIELD mmdn001 name="query.a.page1.mmdn001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mmdn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdn001
            #add-point:ON ACTION controlp INFIELD mmdn001 name="query.c.page1.mmdn001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdn002
            #add-point:BEFORE FIELD mmdn002 name="query.b.page1.mmdn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdn002
            
            #add-point:AFTER FIELD mmdn002 name="query.a.page1.mmdn002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mmdn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdn002
            #add-point:ON ACTION controlp INFIELD mmdn002 name="query.c.page1.mmdn002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmdn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdn003
            #add-point:ON ACTION controlp INFIELD mmdn003 name="construct.c.page1.mmdn003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmdn003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmdn003  #顯示到畫面上
            NEXT FIELD mmdn003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdn003
            #add-point:BEFORE FIELD mmdn003 name="query.b.page1.mmdn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdn003
            
            #add-point:AFTER FIELD mmdn003 name="query.a.page1.mmdn003"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page2.mmdnownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdnownid
            #add-point:ON ACTION controlp INFIELD mmdnownid name="construct.c.page2.mmdnownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmdnownid  #顯示到畫面上
            NEXT FIELD mmdnownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdnownid
            #add-point:BEFORE FIELD mmdnownid name="query.b.page2.mmdnownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdnownid
            
            #add-point:AFTER FIELD mmdnownid name="query.a.page2.mmdnownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmdnowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdnowndp
            #add-point:ON ACTION controlp INFIELD mmdnowndp name="construct.c.page2.mmdnowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmdnowndp  #顯示到畫面上
            NEXT FIELD mmdnowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdnowndp
            #add-point:BEFORE FIELD mmdnowndp name="query.b.page2.mmdnowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdnowndp
            
            #add-point:AFTER FIELD mmdnowndp name="query.a.page2.mmdnowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmdncrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdncrtid
            #add-point:ON ACTION controlp INFIELD mmdncrtid name="construct.c.page2.mmdncrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmdncrtid  #顯示到畫面上
            NEXT FIELD mmdncrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdncrtid
            #add-point:BEFORE FIELD mmdncrtid name="query.b.page2.mmdncrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdncrtid
            
            #add-point:AFTER FIELD mmdncrtid name="query.a.page2.mmdncrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmdncrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdncrtdp
            #add-point:ON ACTION controlp INFIELD mmdncrtdp name="construct.c.page2.mmdncrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmdncrtdp  #顯示到畫面上
            NEXT FIELD mmdncrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdncrtdp
            #add-point:BEFORE FIELD mmdncrtdp name="query.b.page2.mmdncrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdncrtdp
            
            #add-point:AFTER FIELD mmdncrtdp name="query.a.page2.mmdncrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdncrtdt
            #add-point:BEFORE FIELD mmdncrtdt name="query.b.page2.mmdncrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mmdnmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdnmodid
            #add-point:ON ACTION controlp INFIELD mmdnmodid name="construct.c.page2.mmdnmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmdnmodid  #顯示到畫面上
            NEXT FIELD mmdnmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdnmodid
            #add-point:BEFORE FIELD mmdnmodid name="query.b.page2.mmdnmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdnmodid
            
            #add-point:AFTER FIELD mmdnmodid name="query.a.page2.mmdnmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdnmoddt
            #add-point:BEFORE FIELD mmdnmoddt name="query.b.page2.mmdnmoddt"
            
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
         CALL ammi200_set_act_visible_b()
         CALL ammi200_set_act_no_visible_b()
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
    
   CALL ammi200_b_fill(g_wc2)
   LET g_data_owner = g_mmdn2_d[g_detail_idx].mmdnownid   #(ver:35)
   LET g_data_dept = g_mmdn2_d[g_detail_idx].mmdnowndp   #(ver:35)
 
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
 
{<section id="ammi200.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammi200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL ammi200_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammi200.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammi200_modify()
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
      INPUT ARRAY g_mmdn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmdn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammi200_b_fill(g_wc2)
            LET g_detail_cnt = g_mmdn_d.getLength()
         
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
            DISPLAY g_mmdn_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mmdn_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mmdn_d[l_ac].mmdn001 IS NOT NULL
               AND g_mmdn_d[l_ac].mmdn002 IS NOT NULL
               AND g_mmdn_d[l_ac].mmdn003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmdn_d_t.* = g_mmdn_d[l_ac].*  #BACKUP
               LET g_mmdn_d_o.* = g_mmdn_d[l_ac].*  #BACKUP
               IF NOT ammi200_lock_b("mmdn_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammi200_bcl INTO g_mmdn_d[l_ac].mmdnstus,g_mmdn_d[l_ac].mmdn001,g_mmdn_d[l_ac].mmdn002, 
                      g_mmdn_d[l_ac].mmdn003,g_mmdn2_d[l_ac].mmdn001,g_mmdn2_d[l_ac].mmdn002,g_mmdn2_d[l_ac].mmdn003, 
                      g_mmdn2_d[l_ac].mmdnownid,g_mmdn2_d[l_ac].mmdnowndp,g_mmdn2_d[l_ac].mmdncrtid, 
                      g_mmdn2_d[l_ac].mmdncrtdp,g_mmdn2_d[l_ac].mmdncrtdt,g_mmdn2_d[l_ac].mmdnmodid, 
                      g_mmdn2_d[l_ac].mmdnmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmdn_d_t.mmdn001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmdn_d_mask_o[l_ac].* =  g_mmdn_d[l_ac].*
                  CALL ammi200_mmdn_t_mask()
                  LET g_mmdn_d_mask_n[l_ac].* =  g_mmdn_d[l_ac].*
                  
                  CALL ammi200_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL ammi200_set_entry_b(l_cmd)
            CALL ammi200_set_no_entry_b(l_cmd)
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
            INITIALIZE g_mmdn_d_t.* TO NULL
            INITIALIZE g_mmdn_d_o.* TO NULL
            INITIALIZE g_mmdn_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmdn2_d[l_ac].mmdnownid = g_user
      LET g_mmdn2_d[l_ac].mmdnowndp = g_dept
      LET g_mmdn2_d[l_ac].mmdncrtid = g_user
      LET g_mmdn2_d[l_ac].mmdncrtdp = g_dept 
      LET g_mmdn2_d[l_ac].mmdncrtdt = cl_get_current()
      LET g_mmdn2_d[l_ac].mmdnmodid = g_user
      LET g_mmdn2_d[l_ac].mmdnmoddt = cl_get_current()
      LET g_mmdn_d[l_ac].mmdnstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_mmdn_d[l_ac].mmdnstus = "Y"
      LET g_mmdn_d[l_ac].mmdn001 = "-1"
      LET g_mmdn_d[l_ac].mmdn002 = "4"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_mmdn_d_t.* = g_mmdn_d[l_ac].*     #新輸入資料
            LET g_mmdn_d_o.* = g_mmdn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmdn_d[li_reproduce_target].* = g_mmdn_d[li_reproduce].*
               LET g_mmdn2_d[li_reproduce_target].* = g_mmdn2_d[li_reproduce].*
 
               LET g_mmdn_d[g_mmdn_d.getLength()].mmdn001 = NULL
               LET g_mmdn_d[g_mmdn_d.getLength()].mmdn002 = NULL
               LET g_mmdn_d[g_mmdn_d.getLength()].mmdn003 = NULL
 
            END IF
            
 
 
            CALL ammi200_set_entry_b(l_cmd)
            CALL ammi200_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM mmdn_t 
             WHERE mmdnent = g_enterprise AND mmdn001 = g_mmdn_d[l_ac].mmdn001
                                       AND mmdn002 = g_mmdn_d[l_ac].mmdn002
                                       AND mmdn003 = g_mmdn_d[l_ac].mmdn003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmdn_d[g_detail_idx].mmdn001
               LET gs_keys[2] = g_mmdn_d[g_detail_idx].mmdn002
               LET gs_keys[3] = g_mmdn_d[g_detail_idx].mmdn003
               CALL ammi200_insert_b('mmdn_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmdn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmdn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammi200_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (mmdn001 = '", g_mmdn_d[l_ac].mmdn001, "' "
                                  ," AND mmdn002 = '", g_mmdn_d[l_ac].mmdn002, "' "
                                  ," AND mmdn003 = '", g_mmdn_d[l_ac].mmdn003, "' "
 
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
               
               DELETE FROM mmdn_t
                WHERE mmdnent = g_enterprise AND 
                      mmdn001 = g_mmdn_d_t.mmdn001
                      AND mmdn002 = g_mmdn_d_t.mmdn002
                      AND mmdn003 = g_mmdn_d_t.mmdn003
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmdn_t:",SQLERRMESSAGE 
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
                  CALL ammi200_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_mmdn_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE ammi200_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_mmdn_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmdn_d_t.mmdn001
               LET gs_keys[2] = g_mmdn_d_t.mmdn002
               LET gs_keys[3] = g_mmdn_d_t.mmdn003
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammi200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL ammi200_delete_b('mmdn_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mmdn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdnstus
            #add-point:BEFORE FIELD mmdnstus name="input.b.page1.mmdnstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdnstus
            
            #add-point:AFTER FIELD mmdnstus name="input.a.page1.mmdnstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdnstus
            #add-point:ON CHANGE mmdnstus name="input.g.page1.mmdnstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdn001
            #add-point:BEFORE FIELD mmdn001 name="input.b.page1.mmdn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdn001
            
            #add-point:AFTER FIELD mmdn001 name="input.a.page1.mmdn001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mmdn_d[g_detail_idx].mmdn001 IS NOT NULL AND g_mmdn_d[g_detail_idx].mmdn002 IS NOT NULL AND g_mmdn_d[g_detail_idx].mmdn003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmdn_d[g_detail_idx].mmdn001 != g_mmdn_d_t.mmdn001 OR g_mmdn_d[g_detail_idx].mmdn002 != g_mmdn_d_t.mmdn002 OR g_mmdn_d[g_detail_idx].mmdn003 != g_mmdn_d_t.mmdn003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdn_t WHERE "||"mmdnent = " ||g_enterprise|| " AND "||"mmdn001 = '"||g_mmdn_d[g_detail_idx].mmdn001 ||"' AND "|| "mmdn002 = '"||g_mmdn_d[g_detail_idx].mmdn002 ||"' AND "|| "mmdn003 = '"||g_mmdn_d[g_detail_idx].mmdn003 ||"'",'std-00004',0) THEN 
                     LET g_mmdn_d[l_ac].mmdn001 = g_mmdn_d_t.mmdn001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdn001
            #add-point:ON CHANGE mmdn001 name="input.g.page1.mmdn001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdn002
            #add-point:BEFORE FIELD mmdn002 name="input.b.page1.mmdn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdn002
            
            #add-point:AFTER FIELD mmdn002 name="input.a.page1.mmdn002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mmdn_d[g_detail_idx].mmdn001 IS NOT NULL AND g_mmdn_d[g_detail_idx].mmdn002 IS NOT NULL AND g_mmdn_d[g_detail_idx].mmdn003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmdn_d[g_detail_idx].mmdn001 != g_mmdn_d_t.mmdn001 OR g_mmdn_d[g_detail_idx].mmdn002 != g_mmdn_d_t.mmdn002 OR g_mmdn_d[g_detail_idx].mmdn003 != g_mmdn_d_t.mmdn003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdn_t WHERE "||"mmdnent = " ||g_enterprise|| " AND "||"mmdn001 = '"||g_mmdn_d[g_detail_idx].mmdn001 ||"' AND "|| "mmdn002 = '"||g_mmdn_d[g_detail_idx].mmdn002 ||"' AND "|| "mmdn003 = '"||g_mmdn_d[g_detail_idx].mmdn003 ||"'",'std-00004',0) THEN 
                     LET g_mmdn_d[l_ac].mmdn002 = g_mmdn_d_t.mmdn002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdn002
            #add-point:ON CHANGE mmdn002 name="input.g.page1.mmdn002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdn003
            
            #add-point:AFTER FIELD mmdn003 name="input.a.page1.mmdn003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mmdn_d[g_detail_idx].mmdn001 IS NOT NULL AND g_mmdn_d[g_detail_idx].mmdn002 IS NOT NULL AND g_mmdn_d[g_detail_idx].mmdn003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmdn_d[g_detail_idx].mmdn001 != g_mmdn_d_t.mmdn001 OR g_mmdn_d[g_detail_idx].mmdn002 != g_mmdn_d_t.mmdn002 OR g_mmdn_d[g_detail_idx].mmdn003 != g_mmdn_d_t.mmdn003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdn_t WHERE "||"mmdnent = " ||g_enterprise|| " AND "||"mmdn001 = '"||g_mmdn_d[g_detail_idx].mmdn001 ||"' AND "|| "mmdn002 = '"||g_mmdn_d[g_detail_idx].mmdn002 ||"' AND "|| "mmdn003 = '"||g_mmdn_d[g_detail_idx].mmdn003 ||"'",'std-00004',0) THEN 
                     LET g_mmdn_d[l_ac].mmdn003 = g_mmdn_d_t.mmdn003
                     NEXT FIELD CURRENT
                  END IF
                  CALL ammi200_mmdn003_chk() RETURNING l_success
                  IF NOT l_success THEN                  
                     LET g_mmdn_d[l_ac].mmdn003 = g_mmdn_d_t.mmdn003
                     CALL ammi200_mmdn003_ref()  
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdn003
            #add-point:BEFORE FIELD mmdn003 name="input.b.page1.mmdn003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdn003
            #add-point:ON CHANGE mmdn003 name="input.g.page1.mmdn003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmdnstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdnstus
            #add-point:ON ACTION controlp INFIELD mmdnstus name="input.c.page1.mmdnstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdn001
            #add-point:ON ACTION controlp INFIELD mmdn001 name="input.c.page1.mmdn001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdn002
            #add-point:ON ACTION controlp INFIELD mmdn002 name="input.c.page1.mmdn002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdn003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdn003
            #add-point:ON ACTION controlp INFIELD mmdn003 name="input.c.page1.mmdn003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmdn_d[l_ac].mmdn003             #給予default值

            #給予arg

            CALL ammi200_mmdn003_ctp()

            LET g_mmdn_d[l_ac].mmdn003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmdn_d[l_ac].mmdn003 TO s_detail1[l_ac].mmdn003              #顯示到畫面上           
            CALL ammi200_mmdn003_ref()
            NEXT FIELD mmdn003 
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE ammi200_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_mmdn_d[l_ac].* = g_mmdn_d_t.*
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
               LET g_errparam.extend = g_mmdn_d[l_ac].mmdn001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mmdn_d[l_ac].* = g_mmdn_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_mmdn2_d[l_ac].mmdnmodid = g_user 
LET g_mmdn2_d[l_ac].mmdnmoddt = cl_get_current()
LET g_mmdn2_d[l_ac].mmdnmodid_desc = cl_get_username(g_mmdn2_d[l_ac].mmdnmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL ammi200_mmdn_t_mask_restore('restore_mask_o')
 
               UPDATE mmdn_t SET (mmdnstus,mmdn001,mmdn002,mmdn003,mmdnownid,mmdnowndp,mmdncrtid,mmdncrtdp, 
                   mmdncrtdt,mmdnmodid,mmdnmoddt) = (g_mmdn_d[l_ac].mmdnstus,g_mmdn_d[l_ac].mmdn001, 
                   g_mmdn_d[l_ac].mmdn002,g_mmdn_d[l_ac].mmdn003,g_mmdn2_d[l_ac].mmdnownid,g_mmdn2_d[l_ac].mmdnowndp, 
                   g_mmdn2_d[l_ac].mmdncrtid,g_mmdn2_d[l_ac].mmdncrtdp,g_mmdn2_d[l_ac].mmdncrtdt,g_mmdn2_d[l_ac].mmdnmodid, 
                   g_mmdn2_d[l_ac].mmdnmoddt)
                WHERE mmdnent = g_enterprise AND
                  mmdn001 = g_mmdn_d_t.mmdn001 #項次   
                  AND mmdn002 = g_mmdn_d_t.mmdn002  
                  AND mmdn003 = g_mmdn_d_t.mmdn003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmdn_d[g_detail_idx].mmdn001
               LET gs_keys_bak[1] = g_mmdn_d_t.mmdn001
               LET gs_keys[2] = g_mmdn_d[g_detail_idx].mmdn002
               LET gs_keys_bak[2] = g_mmdn_d_t.mmdn002
               LET gs_keys[3] = g_mmdn_d[g_detail_idx].mmdn003
               LET gs_keys_bak[3] = g_mmdn_d_t.mmdn003
               CALL ammi200_update_b('mmdn_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_mmdn_d_t)
                     LET g_log2 = util.JSON.stringify(g_mmdn_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammi200_mmdn_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL ammi200_unlock_b("mmdn_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmdn_d[l_ac].* = g_mmdn_d_t.*
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
               LET g_mmdn_d[li_reproduce_target].* = g_mmdn_d[li_reproduce].*
               LET g_mmdn2_d[li_reproduce_target].* = g_mmdn2_d[li_reproduce].*
 
               LET g_mmdn_d[li_reproduce_target].mmdn001 = NULL
               LET g_mmdn_d[li_reproduce_target].mmdn002 = NULL
               LET g_mmdn_d[li_reproduce_target].mmdn003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmdn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmdn_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_mmdn2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL ammi200_b_fill(g_wc2)
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
         CALL ammi200_set_act_visible_b()
         CALL ammi200_set_act_no_visible_b()
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD mmdnstus
            WHEN "s_detail2"
               NEXT FIELD mmdn001_2
 
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
      IF INT_FLAG OR cl_null(g_mmdn_d[g_detail_idx].mmdn001) THEN
         CALL g_mmdn_d.deleteElement(g_detail_idx)
         CALL g_mmdn2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_mmdn_d[g_detail_idx].* = g_mmdn_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE ammi200_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="ammi200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammi200_delete()
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
   FOR li_idx = 1 TO g_mmdn_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT ammi200_lock_b("mmdn_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("mmdn_t","mmdnownid") THEN
            LET g_data_owner = g_mmdn2_d[g_detail_idx].mmdnownid
            LET g_data_dept = g_mmdn2_d[g_detail_idx].mmdnowndp
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
   
   FOR li_idx = 1 TO g_mmdn_d.getLength()
      IF g_mmdn_d[li_idx].mmdn001 IS NOT NULL
         AND g_mmdn_d[li_idx].mmdn002 IS NOT NULL
         AND g_mmdn_d[li_idx].mmdn003 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM mmdn_t
          WHERE mmdnent = g_enterprise AND 
                mmdn001 = g_mmdn_d[li_idx].mmdn001
                AND mmdn002 = g_mmdn_d[li_idx].mmdn002
                AND mmdn003 = g_mmdn_d[li_idx].mmdn003
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdn_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_mmdn_d_t.mmdn001
               LET gs_keys[2] = g_mmdn_d_t.mmdn002
               LET gs_keys[3] = g_mmdn_d_t.mmdn003
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL ammi200_delete_b('mmdn_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammi200_set_pk_array()
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
   CALL ammi200_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="ammi200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammi200_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.mmdnstus,t0.mmdn001,t0.mmdn002,t0.mmdn003,t0.mmdn001,t0.mmdn002, 
       t0.mmdn003,t0.mmdnownid,t0.mmdnowndp,t0.mmdncrtid,t0.mmdncrtdp,t0.mmdncrtdt,t0.mmdnmodid,t0.mmdnmoddt , 
       t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM mmdn_t t0",
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mmdnownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mmdnowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mmdncrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.mmdncrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mmdnmodid  ",
 
               " WHERE t0.mmdnent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("mmdn_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND mmdnowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("mmdn_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND mmdnownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("mmdn_t"),
                      " ORDER BY t0.mmdn001,t0.mmdn002,t0.mmdn003"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmdn_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ammi200_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ammi200_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mmdn_d.clear()
   CALL g_mmdn2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mmdn_d[l_ac].mmdnstus,g_mmdn_d[l_ac].mmdn001,g_mmdn_d[l_ac].mmdn002,g_mmdn_d[l_ac].mmdn003, 
       g_mmdn2_d[l_ac].mmdn001,g_mmdn2_d[l_ac].mmdn002,g_mmdn2_d[l_ac].mmdn003,g_mmdn2_d[l_ac].mmdnownid, 
       g_mmdn2_d[l_ac].mmdnowndp,g_mmdn2_d[l_ac].mmdncrtid,g_mmdn2_d[l_ac].mmdncrtdp,g_mmdn2_d[l_ac].mmdncrtdt, 
       g_mmdn2_d[l_ac].mmdnmodid,g_mmdn2_d[l_ac].mmdnmoddt,g_mmdn2_d[l_ac].mmdnownid_desc,g_mmdn2_d[l_ac].mmdnowndp_desc, 
       g_mmdn2_d[l_ac].mmdncrtid_desc,g_mmdn2_d[l_ac].mmdncrtdp_desc,g_mmdn2_d[l_ac].mmdnmodid_desc
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
      
      CALL ammi200_detail_show()      
 
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
   
 
   
   CALL g_mmdn_d.deleteElement(g_mmdn_d.getLength())   
   CALL g_mmdn2_d.deleteElement(g_mmdn2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_mmdn_d.getLength()
      LET g_mmdn2_d[l_ac].mmdn001 = g_mmdn_d[l_ac].mmdn001 
      LET g_mmdn2_d[l_ac].mmdn002 = g_mmdn_d[l_ac].mmdn002 
      LET g_mmdn2_d[l_ac].mmdn003 = g_mmdn_d[l_ac].mmdn003 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_mmdn_d.getLength() THEN
      LET l_ac = g_mmdn_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmdn_d.getLength()
      LET g_mmdn_d_mask_o[l_ac].* =  g_mmdn_d[l_ac].*
      CALL ammi200_mmdn_t_mask()
      LET g_mmdn_d_mask_n[l_ac].* =  g_mmdn_d[l_ac].*
   END FOR
   
   LET g_mmdn2_d_mask_o.* =  g_mmdn2_d.*
   FOR l_ac = 1 TO g_mmdn2_d.getLength()
      LET g_mmdn2_d_mask_o[l_ac].* =  g_mmdn2_d[l_ac].*
      CALL ammi200_mmdn_t_mask()
      LET g_mmdn2_d_mask_n[l_ac].* =  g_mmdn2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_mmdn_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE ammi200_pb
   
END FUNCTION
 
{</section>}
 
{<section id="ammi200.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ammi200_detail_show()
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
   CALL ammi200_mmdn003_ref()
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammi200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammi200_set_entry_b(p_cmd)                                                  
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
 
{<section id="ammi200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammi200_set_no_entry_b(p_cmd)                                               
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
 
{<section id="ammi200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammi200_default_search()
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
      LET ls_wc = ls_wc, " mmdn001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mmdn002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " mmdn003 = '", g_argv[03], "' AND "
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
 
{<section id="ammi200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammi200_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "mmdn_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'mmdn_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM mmdn_t
          WHERE mmdnent = g_enterprise AND
            mmdn001 = ps_keys_bak[1] AND mmdn002 = ps_keys_bak[2] AND mmdn003 = ps_keys_bak[3]
         
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
         CALL g_mmdn_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_mmdn2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammi200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammi200_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "mmdn_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO mmdn_t
                  (mmdnent,
                   mmdn001,mmdn002,mmdn003
                   ,mmdnstus,mmdnownid,mmdnowndp,mmdncrtid,mmdncrtdp,mmdncrtdt,mmdnmodid,mmdnmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mmdn_d[l_ac].mmdnstus,g_mmdn2_d[l_ac].mmdnownid,g_mmdn2_d[l_ac].mmdnowndp,g_mmdn2_d[l_ac].mmdncrtid, 
                       g_mmdn2_d[l_ac].mmdncrtdp,g_mmdn2_d[l_ac].mmdncrtdt,g_mmdn2_d[l_ac].mmdnmodid, 
                       g_mmdn2_d[l_ac].mmdnmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammi200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammi200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "mmdn_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mmdn_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE mmdn_t 
         SET (mmdn001,mmdn002,mmdn003
              ,mmdnstus,mmdnownid,mmdnowndp,mmdncrtid,mmdncrtdp,mmdncrtdt,mmdnmodid,mmdnmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mmdn_d[l_ac].mmdnstus,g_mmdn2_d[l_ac].mmdnownid,g_mmdn2_d[l_ac].mmdnowndp,g_mmdn2_d[l_ac].mmdncrtid, 
                  g_mmdn2_d[l_ac].mmdncrtdp,g_mmdn2_d[l_ac].mmdncrtdt,g_mmdn2_d[l_ac].mmdnmodid,g_mmdn2_d[l_ac].mmdnmoddt)  
 
         WHERE mmdnent = g_enterprise AND mmdn001 = ps_keys_bak[1] AND mmdn002 = ps_keys_bak[2] AND mmdn003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdn_t:",SQLERRMESSAGE 
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
 
{<section id="ammi200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammi200_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL ammi200_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mmdn_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammi200_bcl USING g_enterprise,
                                       g_mmdn_d[g_detail_idx].mmdn001,g_mmdn_d[g_detail_idx].mmdn002, 
                                           g_mmdn_d[g_detail_idx].mmdn003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammi200_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammi200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammi200_unlock_b(ps_table)
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
      CLOSE ammi200_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammi200.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION ammi200_modify_detail_chk(ps_record)
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
         LET ls_return = "mmdnstus"
      WHEN "s_detail2"
         LET ls_return = "mmdn001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="ammi200.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION ammi200_show_ownid_msg()
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
 
{<section id="ammi200.mask_functions" >}
&include "erp/amm/ammi200_mask.4gl"
 
{</section>}
 
{<section id="ammi200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammi200_set_pk_array()
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
   LET g_pk_array[1].values = g_mmdn_d[l_ac].mmdn001
   LET g_pk_array[1].column = 'mmdn001'
   LET g_pk_array[2].values = g_mmdn_d[l_ac].mmdn002
   LET g_pk_array[2].column = 'mmdn002'
   LET g_pk_array[3].values = g_mmdn_d[l_ac].mmdn003
   LET g_pk_array[3].column = 'mmdn003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammi200.state_change" >}
   
 
{</section>}
 
{<section id="ammi200.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="ammi200.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 屬性開窗
# Memo...........:
# Usage..........: CALL ammi200_mmdn003_ctp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/9/22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ammi200_mmdn003_ctp()
   CASE g_mmdn_d[l_ac].mmdn002
      WHEN '4'
         LET g_qryparam.arg1 = null
      WHEN '6'
         LET g_qryparam.arg1 = '2000'
      WHEN '7'
         LET g_qryparam.arg1 = '2001'
      WHEN '8'
         LET g_qryparam.arg1 = '2002'
      WHEN '9'
         LET g_qryparam.arg1 = '2003'
      WHEN 'A'
         LET g_qryparam.arg1 = '2004'
      WHEN 'B'
         LET g_qryparam.arg1 = '2005'
      WHEN 'C'
         LET g_qryparam.arg1 = '2006'
      WHEN 'D'
         LET g_qryparam.arg1 = '2007'
      WHEN 'E'
         LET g_qryparam.arg1 = '2008'
      WHEN 'F'
         LET g_qryparam.arg1 = '2009'
      WHEN 'G'
         LET g_qryparam.arg1 = '2010'
      WHEN 'H'
         LET g_qryparam.arg1 = '2011'
      WHEN 'I'
         LET g_qryparam.arg1 = '2012'
      WHEN 'J'
         LET g_qryparam.arg1 = '2013'
      WHEN 'K'
         LET g_qryparam.arg1 = '2014'
      WHEN 'L'
         LET g_qryparam.arg1 = '2015'
   END CASE
   CASE g_mmdn_d[l_ac].mmdn002
      WHEN '4'
         CALL q_imaa001()
      WHEN '5'
         CALL q_rtax001()
      OTHERWISE
         CALL q_oocq002()
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 屬性欄位說明
# Memo...........:
# Usage..........: CALL ammi200_mmdn003_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/9/22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ammi200_mmdn003_ref()
DEFINE l_oocq001   LIKE oocq_t.oocq001
   
   IF cl_null(g_mmdn_d[l_ac].mmdn002) THEN
      RETURN
   END IF
   CASE g_mmdn_d[l_ac].mmdn002
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   CASE g_mmdn_d[l_ac].mmdn002
      WHEN '4'
         SELECT imaal003 INTO g_mmdn_d[l_ac].mmdn003_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_mmdn_d[l_ac].mmdn003 AND imaal002 = g_dlang
      WHEN '5'
         SELECT rtaxl003 INTO g_mmdn_d[l_ac].mmdn003_desc
           FROM rtaxl_t
          WHERE rtaxlent = g_enterprise AND rtaxl001 = g_mmdn_d[l_ac].mmdn003 AND rtaxl002 = g_dlang
      OTHERWISE
         SELECT oocql004 INTO g_mmdn_d[l_ac].mmdn003_desc
           FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = l_oocq001 AND oocql002 = g_mmdn_d[l_ac].mmdn003 AND oocql003 = g_dlang
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 屬性欄位校驗
# Memo...........:
# Usage..........: CALL ammi200_mmdn003_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/9/22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ammi200_mmdn003_chk()
DEFINE l_rtax005   LIKE rtax_t.rtax005
DEFINE l_stus      LIKE type_t.chr1
DEFINE l_oocq001   LIKE oocq_t.oocq001
DEFINE r_success   LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET r_success = TRUE
   IF cl_null(g_mmdn_d[l_ac].mmdn002) THEN
      RETURN r_success
   END IF
   CASE g_mmdn_d[l_ac].mmdn002
      WHEN '4'
         SELECT imaastus INTO l_stus
           FROM imaa_t
          WHERE  imaaent = g_enterprise  AND imaa001 = g_mmdn_d[l_ac].mmdn003
         CASE
            WHEN SQLCA.sqlcode = 100 LET g_errno = 'art-00763' #该商品不存在或在当前组织不可使用
            WHEN l_stus <> 'Y'       LET g_errno = 'ain-00635' #该商品在当前组织已无效
         END CASE
      WHEN '5'
         SELECT rtax005,rtaxstus INTO l_rtax005,l_stus
           FROM rtax_t
          WHERE rtaxent = g_enterprise AND rtax001 = g_mmdn_d[l_ac].mmdn003
         CASE
            WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00027' #该品类编号不存在
            WHEN l_stus <> 'Y'       LET g_errno = 'agc-00028' #该品类编号已无效
            WHEN l_rtax005 <> 0      LET g_errno = 'agc-00029' #该品类编号存在下级品类
         END CASE
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   CASE g_mmdn_d[l_ac].mmdn002
      WHEN '4'
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_mmdn_d[l_ac].mmdn003
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '5'
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmdn_d[l_ac].mmdn003
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
      OTHERWISE
         SELECT oocqstus INTO l_stus
           FROM oocq_t
          WHERE oocqent = g_enterprise AND oocq001 = l_oocq001 AND oocq002 = g_mmdn_d[l_ac].mmdn003
         CASE
            WHEN SQLCA.sqlcode = 100
               CASE g_mmdn_d[l_ac].mmdn002                 
                  WHEN '6'
                     LET g_errno="aim-00178"
                  WHEN '7'
                     LET g_errno="apr-00217"
                  WHEN '8'
                     LET g_errno="apr-00218"
                  WHEN '9'
                     LET g_errno="apr-00219"
                  WHEN 'A'
                     LET g_errno="apr-00220"
                  WHEN 'B'
                     LET g_errno="apr-00221"
                  WHEN 'C'
                     LET g_errno="apr-00222"
                  WHEN 'D'
                     LET g_errno="apr-00223"
                  WHEN 'E'
                     LET g_errno="apr-00224"
                  WHEN 'F'
                     LET g_errno="apr-00225"
                  WHEN 'G'
                     LET g_errno="apr-00226"
                  WHEN 'H'
                     LET g_errno="apr-00227"
                  WHEN 'I'
                     LET g_errno="apr-00228"
                  WHEN 'J'
                     LET g_errno="apr-00229"
                  WHEN 'K'
                     LET g_errno="apr-00230"
                  WHEN 'L'
                     LET g_errno="apr-00231"
               END CASE            
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmdn_d[l_ac].mmdn003
            LET g_errparam.popup = TRUE
            CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            WHEN l_stus <> 'Y'
               CASE g_mmdn_d[l_ac].mmdn002                 
                  WHEN '6'
                     LET g_errno="sub-01302"     
                  WHEN '7'
                     LET g_errno="apr-00232"
                  WHEN '8'
                     LET g_errno="apr-00233"
                  WHEN '9'
                     LET g_errno="apr-00234"
                  WHEN 'A'
                     LET g_errno="apr-00235"
                  WHEN 'B'
                     LET g_errno="apr-00236"
                  WHEN 'C'
                     LET g_errno="apr-00237"
                  WHEN 'D'
                     LET g_errno="apr-00238"
                  WHEN 'E'
                     LET g_errno="apr-00239"
                  WHEN 'F'
                     LET g_errno="apr-00240"
                  WHEN 'G'
                     LET g_errno="apr-00241"
                  WHEN 'H'
                     LET g_errno="apr-00242"
                  WHEN 'I'
                     LET g_errno="apr-00243"
                  WHEN 'J'
                     LET g_errno="apr-00244"
                  WHEN 'K'
                     LET g_errno="apr-00245"
                  WHEN 'L'
                     LET g_errno="apr-00246"
               END CASE
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmdn_d[l_ac].mmdn003
            IF g_errno = 'sub-01302' THEN
               LET g_errparam.replace[1] = 'arti001'
               LET g_errparam.replace[2] = cl_get_progname('arti001',g_lang,"2")
               LET g_errparam.exeprog = 'arti001'
            END IF
            LET g_errparam.popup = TRUE
            CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
         END CASE
   END CASE
   RETURN r_success
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
PRIVATE FUNCTION ammi200_set_act_visible_b()
     CALL cl_set_act_visible("insert,modify,modify_detail,delete",TRUE)
     CALL cl_set_act_visible("reproduce",TRUE)
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
PRIVATE FUNCTION ammi200_set_act_no_visible_b()
   CALL cl_set_act_visible("reproduce",FALSE)
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0076')='Y' THEN
     CALL cl_set_act_visible("insert,modify,modify_detail,reproduce,delete",FALSE)
   END IF
END FUNCTION

 
{</section>}
 
