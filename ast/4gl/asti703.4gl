#該程式未解開Section, 採用最新樣板產出!
{<section id="asti703.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-01-28 14:54:24), PR版次:0006(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: asti703
#+ Description: 內部結算虛擬庫位維護作業
#+ Creator....: 01533(2014-09-15 15:41:35)
#+ Modifier...: 06189 -SD/PR- 00000
 
{</section>}
 
{<section id="asti703.global" >}
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
PRIVATE TYPE type_g_inaa_d RECORD
       inaastus LIKE inaa_t.inaastus, 
   inaasite LIKE inaa_t.inaasite, 
   inaasite_desc LIKE type_t.chr500, 
   ooef017 LIKE type_t.chr500, 
   ooef017_desc LIKE type_t.chr500, 
   inaa001 LIKE inaa_t.inaa001, 
   inayl003 LIKE inayl_t.inayl003, 
   inayl004 LIKE inayl_t.inayl004, 
   inaa101 LIKE inaa_t.inaa101, 
   inaaunit LIKE inaa_t.inaaunit
       END RECORD
PRIVATE TYPE type_g_inaa2_d RECORD
       inaasite LIKE inaa_t.inaasite, 
   inaasite_2_desc LIKE type_t.chr500, 
   inaa001 LIKE inaa_t.inaa001, 
   inaa001_2_desc_1 LIKE type_t.chr500, 
   inaa001_2_desc LIKE type_t.chr10, 
   inaaownid LIKE inaa_t.inaaownid, 
   inaaownid_desc LIKE type_t.chr500, 
   inaaowndp LIKE inaa_t.inaaowndp, 
   inaaowndp_desc LIKE type_t.chr500, 
   inaacrtid LIKE inaa_t.inaacrtid, 
   inaacrtid_desc LIKE type_t.chr500, 
   inaacrtdp LIKE inaa_t.inaacrtdp, 
   inaacrtdp_desc LIKE type_t.chr500, 
   inaacrtdt DATETIME YEAR TO SECOND, 
   inaamodid LIKE inaa_t.inaamodid, 
   inaamodid_desc LIKE type_t.chr500, 
   inaamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      inayl001 LIKE inayl_t.inayl001,
      inayl002 LIKE inayl_t.inayl002,
      inayl003 LIKE inayl_t.inayl003,
      inayl004 LIKE inayl_t.inayl004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_inaa_d          DYNAMIC ARRAY OF type_g_inaa_d #單身變數
DEFINE g_inaa_d_t        type_g_inaa_d                  #單身備份
DEFINE g_inaa_d_o        type_g_inaa_d                  #單身備份
DEFINE g_inaa_d_mask_o   DYNAMIC ARRAY OF type_g_inaa_d #單身變數
DEFINE g_inaa_d_mask_n   DYNAMIC ARRAY OF type_g_inaa_d #單身變數
DEFINE g_inaa2_d   DYNAMIC ARRAY OF type_g_inaa2_d
DEFINE g_inaa2_d_t type_g_inaa2_d
DEFINE g_inaa2_d_o type_g_inaa2_d
DEFINE g_inaa2_d_mask_o DYNAMIC ARRAY OF type_g_inaa2_d
DEFINE g_inaa2_d_mask_n DYNAMIC ARRAY OF type_g_inaa2_d
 
      
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
 
{<section id="asti703.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
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
   
   #end add-point 
   LET g_forupd_sql = "SELECT inaastus,inaasite,inaa001,inaa101,inaaunit,inaasite,inaa001,inaaownid, 
       inaaowndp,inaacrtid,inaacrtdp,inaacrtdt,inaamodid,inaamoddt FROM inaa_t WHERE inaaent=? AND inaasite=?  
       AND inaa001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asti703_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asti703 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asti703_init()   
 
      #進入選單 Menu (="N")
      CALL asti703_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asti703
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asti703.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asti703_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
   
   CALL asti703_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asti703_ui_dialog()
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
         CALL g_inaa_d.clear()
         CALL g_inaa2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL asti703_init()
      END IF
   
      CALL asti703_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_inaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_inaa2_d[g_detail_idx].inaaownid   #(ver:35)
               LET g_data_dept = g_inaa2_d[g_detail_idx].inaaowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL asti703_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_inaa2_d TO s_detail2.*
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
   CALL asti703_set_pk_array()
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
            CALL asti703_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti703_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL asti703_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti703_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL asti703_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asti703_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asti703_insert()
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
               CALL asti703_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_inaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_inaa2_d)
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
            CALL asti703_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asti703_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asti703_set_pk_array()
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
 
{<section id="asti703.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asti703_query()
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
   CALL g_inaa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON inaastus,inaasite,inaa001,inayl003,inayl004,inaa101,inaaunit,inaaownid,inaaowndp, 
          inaacrtid,inaacrtdp,inaacrtdt,inaamodid,inaamoddt 
 
         FROM s_detail1[1].inaastus,s_detail1[1].inaasite,s_detail1[1].inaa001,s_detail1[1].inayl003, 
             s_detail1[1].inayl004,s_detail1[1].inaa101,s_detail1[1].inaaunit,s_detail2[1].inaaownid, 
             s_detail2[1].inaaowndp,s_detail2[1].inaacrtid,s_detail2[1].inaacrtdp,s_detail2[1].inaacrtdt, 
             s_detail2[1].inaamodid,s_detail2[1].inaamoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inaacrtdt>>----
         AFTER FIELD inaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inaamoddt>>----
         AFTER FIELD inaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inaacnfdt>>----
         
         #----<<inaapstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus name="query.b.page1.inaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus name="query.a.page1.inaastus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus name="query.c.page1.inaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaasite
            #add-point:ON ACTION controlp INFIELD inaasite name="construct.c.page1.inaasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001_14()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inaasite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaasite  #顯示到畫面上
            NEXT FIELD inaasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaasite
            #add-point:BEFORE FIELD inaasite name="query.b.page1.inaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaasite
            
            #add-point:AFTER FIELD inaasite name="query.a.page1.inaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="construct.c.page1.inaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_25()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上
            NEXT FIELD inaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="query.b.page1.inaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="query.a.page1.inaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inayl003
            #add-point:BEFORE FIELD inayl003 name="query.b.page1.inayl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inayl003
            
            #add-point:AFTER FIELD inayl003 name="query.a.page1.inayl003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inayl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inayl003
            #add-point:ON ACTION controlp INFIELD inayl003 name="query.c.page1.inayl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inayl004
            #add-point:BEFORE FIELD inayl004 name="query.b.page1.inayl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inayl004
            
            #add-point:AFTER FIELD inayl004 name="query.a.page1.inayl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inayl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inayl004
            #add-point:ON ACTION controlp INFIELD inayl004 name="query.c.page1.inayl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa101
            #add-point:BEFORE FIELD inaa101 name="query.b.page1.inaa101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa101
            
            #add-point:AFTER FIELD inaa101 name="query.a.page1.inaa101"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inaa101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa101
            #add-point:ON ACTION controlp INFIELD inaa101 name="query.c.page1.inaa101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaunit
            #add-point:BEFORE FIELD inaaunit name="query.b.page1.inaaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaunit
            
            #add-point:AFTER FIELD inaaunit name="query.a.page1.inaaunit"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.inaaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaunit
            #add-point:ON ACTION controlp INFIELD inaaunit name="query.c.page1.inaaunit"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.inaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaownid
            #add-point:ON ACTION controlp INFIELD inaaownid name="construct.c.page2.inaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaaownid  #顯示到畫面上
            NEXT FIELD inaaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaownid
            #add-point:BEFORE FIELD inaaownid name="query.b.page2.inaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaownid
            
            #add-point:AFTER FIELD inaaownid name="query.a.page2.inaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaowndp
            #add-point:ON ACTION controlp INFIELD inaaowndp name="construct.c.page2.inaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaaowndp  #顯示到畫面上
            NEXT FIELD inaaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaowndp
            #add-point:BEFORE FIELD inaaowndp name="query.b.page2.inaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaowndp
            
            #add-point:AFTER FIELD inaaowndp name="query.a.page2.inaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaacrtid
            #add-point:ON ACTION controlp INFIELD inaacrtid name="construct.c.page2.inaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaacrtid  #顯示到畫面上
            NEXT FIELD inaacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtid
            #add-point:BEFORE FIELD inaacrtid name="query.b.page2.inaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaacrtid
            
            #add-point:AFTER FIELD inaacrtid name="query.a.page2.inaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaacrtdp
            #add-point:ON ACTION controlp INFIELD inaacrtdp name="construct.c.page2.inaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaacrtdp  #顯示到畫面上
            NEXT FIELD inaacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtdp
            #add-point:BEFORE FIELD inaacrtdp name="query.b.page2.inaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaacrtdp
            
            #add-point:AFTER FIELD inaacrtdp name="query.a.page2.inaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaacrtdt
            #add-point:BEFORE FIELD inaacrtdt name="query.b.page2.inaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.inaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaamodid
            #add-point:ON ACTION controlp INFIELD inaamodid name="construct.c.page2.inaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaamodid  #顯示到畫面上
            NEXT FIELD inaamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaamodid
            #add-point:BEFORE FIELD inaamodid name="query.b.page2.inaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaamodid
            
            #add-point:AFTER FIELD inaamodid name="query.a.page2.inaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaamoddt
            #add-point:BEFORE FIELD inaamoddt name="query.b.page2.inaamoddt"
            
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
    
   CALL asti703_b_fill(g_wc2)
   LET g_data_owner = g_inaa2_d[g_detail_idx].inaaownid   #(ver:35)
   LET g_data_dept = g_inaa2_d[g_detail_idx].inaaowndp   #(ver:35)
 
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
 
{<section id="asti703.insert" >}
#+ 資料新增
PRIVATE FUNCTION asti703_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL asti703_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asti703.modify" >}
#+ 資料修改
PRIVATE FUNCTION asti703_modify()
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
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
      INPUT ARRAY g_inaa_d FROM s_detail1.*
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
               IF NOT cl_null(g_inaa_d[l_ac].inaa001) THEN
                  CALL n_inayl(g_inaa_d[l_ac].inaa001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_inaa_d[l_ac].inaa001
                  CALL ap_ref_array2(g_ref_fields," SELECT inayl003,inayl004 FROM inayl_t WHERE inaylent = '"||g_enterprise||"' AND inayl001 = ? AND inayl002 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#15 by 08172 add ent
                  LET g_inaa_d[l_ac].inayl003 = g_rtn_fields[1]
                  LET g_inaa_d[l_ac].inayl004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_inaa_d[l_ac].inayl003
                  DISPLAY BY NAME g_inaa_d[l_ac].inayl004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asti703_b_fill(g_wc2)
            LET g_detail_cnt = g_inaa_d.getLength()
         
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
            DISPLAY g_inaa_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_inaa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_inaa_d[l_ac].inaasite IS NOT NULL
               AND g_inaa_d[l_ac].inaa001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inaa_d_t.* = g_inaa_d[l_ac].*  #BACKUP
               LET g_inaa_d_o.* = g_inaa_d[l_ac].*  #BACKUP
               IF NOT asti703_lock_b("inaa_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asti703_bcl INTO g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001, 
                      g_inaa_d[l_ac].inaa101,g_inaa_d[l_ac].inaaunit,g_inaa2_d[l_ac].inaasite,g_inaa2_d[l_ac].inaa001, 
                      g_inaa2_d[l_ac].inaaownid,g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid, 
                      g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt,g_inaa2_d[l_ac].inaamodid, 
                      g_inaa2_d[l_ac].inaamoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inaa_d_t.inaasite,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inaa_d_mask_o[l_ac].* =  g_inaa_d[l_ac].*
                  CALL asti703_inaa_t_mask()
                  LET g_inaa_d_mask_n[l_ac].* =  g_inaa_d[l_ac].*
                  
                  CALL asti703_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asti703_set_entry_b(l_cmd)
            CALL asti703_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            CALL asti703_set_entry_b(l_cmd)
            CALL asti703_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.inayl001 = g_inaa_d[l_ac].inaa001
LET g_detail_multi_table_t.inayl002 = g_dlang
LET g_detail_multi_table_t.inayl003 = g_inaa_d[l_ac].inayl003
LET g_detail_multi_table_t.inayl004 = g_inaa_d[l_ac].inayl004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'inaylent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'inayl001'
            LET l_var_keys[02] = g_inaa_d[l_ac].inaa001
            LET l_field_keys[03] = 'inayl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'inayl_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_inaa_d_t.* TO NULL
            INITIALIZE g_inaa_d_o.* TO NULL
            INITIALIZE g_inaa_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inaa2_d[l_ac].inaaownid = g_user
      LET g_inaa2_d[l_ac].inaaowndp = g_dept
      LET g_inaa2_d[l_ac].inaacrtid = g_user
      LET g_inaa2_d[l_ac].inaacrtdp = g_dept 
      LET g_inaa2_d[l_ac].inaacrtdt = cl_get_current()
      LET g_inaa2_d[l_ac].inaamodid = g_user
      LET g_inaa2_d[l_ac].inaamoddt = cl_get_current()
      LET g_inaa_d[l_ac].inaastus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_inaa_d[l_ac].inaastus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_inaa_d[l_ac].inaa101 = '3'
            LET g_inaa_d[l_ac].inaaunit =  g_inaa_d[l_ac].inaasite
            #end add-point
            LET g_inaa_d_t.* = g_inaa_d[l_ac].*     #新輸入資料
            LET g_inaa_d_o.* = g_inaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inaa_d[li_reproduce_target].* = g_inaa_d[li_reproduce].*
               LET g_inaa2_d[li_reproduce_target].* = g_inaa2_d[li_reproduce].*
 
               LET g_inaa_d[g_inaa_d.getLength()].inaasite = NULL
               LET g_inaa_d[g_inaa_d.getLength()].inaa001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.inayl001 = g_inaa_d[l_ac].inaa001
LET g_detail_multi_table_t.inayl002 = g_dlang
LET g_detail_multi_table_t.inayl003 = g_inaa_d[l_ac].inayl003
LET g_detail_multi_table_t.inayl004 = g_inaa_d[l_ac].inayl004
 
 
            CALL asti703_set_entry_b(l_cmd)
            CALL asti703_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM inaa_t 
             WHERE inaaent = g_enterprise AND inaasite = g_inaa_d[l_ac].inaasite
                                       AND inaa001 = g_inaa_d[l_ac].inaa001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               CALL asti703_insert_b('inaa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_inaa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asti703_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_inaa_d[l_ac].inaa001 = g_detail_multi_table_t.inayl001 AND
         g_inaa_d[l_ac].inayl003 = g_detail_multi_table_t.inayl003 AND
         g_inaa_d[l_ac].inayl004 = g_detail_multi_table_t.inayl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'inaylent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_inaa_d[l_ac].inaa001
            LET l_field_keys[02] = 'inayl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.inayl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'inayl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.inayl002
            LET l_vars[01] = g_inaa_d[l_ac].inayl003
            LET l_fields[01] = 'inayl003'
            LET l_vars[02] = g_inaa_d[l_ac].inayl004
            LET l_fields[02] = 'inayl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'inayl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (inaasite = '", g_inaa_d[l_ac].inaasite, "' "
                                  ," AND inaa001 = '", g_inaa_d[l_ac].inaa001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               IF NOT asti703_del_chk() THEN
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
                DELETE FROM inay_t
                 WHERE inayent = g_enterprise AND inay001 = g_inaa_d_t.inaa001
 
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "del inay_t" 
                   LET g_errparam.code   = SQLCA.sqlcode 
                   LET g_errparam.popup  = FALSE 
                   CALL cl_err()
                   CALL s_transaction_end('N','0')
                   CANCEL DELETE   
                END IF  
               #end add-point   
               
               DELETE FROM inaa_t
                WHERE inaaent = g_enterprise AND 
                      inaasite = g_inaa_d_t.inaasite
                      AND inaa001 = g_inaa_d_t.inaa001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'inaylent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'inayl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.inayl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'inayl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL asti703_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_inaa_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE asti703_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_inaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d_t.inaasite
               LET gs_keys[2] = g_inaa_d_t.inaa001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti703_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asti703_delete_b('inaa_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_inaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaastus
            #add-point:BEFORE FIELD inaastus name="input.b.page1.inaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaastus
            
            #add-point:AFTER FIELD inaastus name="input.a.page1.inaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaastus
            #add-point:ON CHANGE inaastus name="input.g.page1.inaastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaasite
            
            #add-point:AFTER FIELD inaasite name="input.a.page1.inaasite"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_inaa_d[l_ac].inaasite) THEN
#               IF NOT asti703_inaasite_chk(l_cmd) THEN
#                  LET g_inaa_d[l_ac].inaasite = g_inaa_d_t.inaasite
#                  CALL asti703_inaasite_ref()
#                  NEXT FIELD CURRENT 
#               END IF
               CALL s_aooi500_chk(g_prog,'inaasite',g_inaa_d[l_ac].inaasite,g_site) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_inaa_d[l_ac].inaasite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_inaa_d[l_ac].inaasite = g_inaa_d_t.inaasite
                  CALL s_desc_get_department_desc(g_inaa_d[l_ac].inaasite) RETURNING g_inaa_d[l_ac].inaasite_desc
                  DISPLAY BY NAME g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaasite_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF  g_inaa_d[g_detail_idx].inaasite IS NOT NULL AND g_inaa_d[g_detail_idx].inaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inaa_d[g_detail_idx].inaasite != g_inaa_d_t.inaasite OR g_inaa_d[g_detail_idx].inaa001 != g_inaa_d_t.inaa001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM inaa_t WHERE "||"inaaent = '" ||g_enterprise|| "' AND "||"inaasite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "inaa001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"'",'std-00004',0) THEN #160905-00007#15 by 08172 *变1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL asti703_inaasite_ref()
            LET g_inaa_d[l_ac].inaaunit =  g_inaa_d[l_ac].inaasite
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaasite
            #add-point:BEFORE FIELD inaasite name="input.b.page1.inaasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaasite
            #add-point:ON CHANGE inaasite name="input.g.page1.inaasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="input.a.page1.inaa001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_inaa_d[l_ac].inaa001) THEN
               IF NOT asti703_inaa001_chk(l_cmd) THEN
                  LET g_inaa_d[l_ac].inaa001 = g_inaa_d[l_ac].inaa001
                  CALL asti703_inaa001_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL asti703_inaa001_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="input.b.page1.inaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa001
            #add-point:ON CHANGE inaa001 name="input.g.page1.inaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inayl003
            #add-point:BEFORE FIELD inayl003 name="input.b.page1.inayl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inayl003
            
            #add-point:AFTER FIELD inayl003 name="input.a.page1.inayl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inayl003
            #add-point:ON CHANGE inayl003 name="input.g.page1.inayl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inayl004
            #add-point:BEFORE FIELD inayl004 name="input.b.page1.inayl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inayl004
            
            #add-point:AFTER FIELD inayl004 name="input.a.page1.inayl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inayl004
            #add-point:ON CHANGE inayl004 name="input.g.page1.inayl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa101
            #add-point:BEFORE FIELD inaa101 name="input.b.page1.inaa101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa101
            
            #add-point:AFTER FIELD inaa101 name="input.a.page1.inaa101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaa101
            #add-point:ON CHANGE inaa101 name="input.g.page1.inaa101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaunit
            #add-point:BEFORE FIELD inaaunit name="input.b.page1.inaaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaunit
            
            #add-point:AFTER FIELD inaaunit name="input.a.page1.inaaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inaaunit
            #add-point:ON CHANGE inaaunit name="input.g.page1.inaaunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaastus
            #add-point:ON ACTION controlp INFIELD inaastus name="input.c.page1.inaastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaasite
            #add-point:ON ACTION controlp INFIELD inaasite name="input.c.page1.inaasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inaa_d[l_ac].inaasite             #給予default值
            LET g_qryparam.default2 = "" #g_inaa_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
#            LET g_qryparam.arg1 = g_site #
#            LET g_qryparam.arg2 = '8' #
#            
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inaasite',g_inaa_d[l_ac].inaasite,'i')   #150308-00001#5  By benson add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_inaa_d[l_ac].inaasite = g_qryparam.return1              
            #LET g_inaa_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_inaa_d[l_ac].inaasite TO inaasite              #             
            #DISPLAY g_inaa_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            CALL asti703_inaasite_ref()
            NEXT FIELD inaasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="input.c.page1.inaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inayl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inayl003
            #add-point:ON ACTION controlp INFIELD inayl003 name="input.c.page1.inayl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inayl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inayl004
            #add-point:ON ACTION controlp INFIELD inayl004 name="input.c.page1.inayl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaa101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa101
            #add-point:ON ACTION controlp INFIELD inaa101 name="input.c.page1.inaa101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inaaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaunit
            #add-point:ON ACTION controlp INFIELD inaaunit name="input.c.page1.inaaunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE asti703_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
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
               LET g_errparam.extend = g_inaa_d[l_ac].inaasite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_inaa_d[l_ac].* = g_inaa_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_inaa2_d[l_ac].inaamodid = g_user 
LET g_inaa2_d[l_ac].inaamoddt = cl_get_current()
LET g_inaa2_d[l_ac].inaamodid_desc = cl_get_username(g_inaa2_d[l_ac].inaamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asti703_inaa_t_mask_restore('restore_mask_o')
 
               UPDATE inaa_t SET (inaastus,inaasite,inaa001,inaa101,inaaunit,inaaownid,inaaowndp,inaacrtid, 
                   inaacrtdp,inaacrtdt,inaamodid,inaamoddt) = (g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaasite, 
                   g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa101,g_inaa_d[l_ac].inaaunit,g_inaa2_d[l_ac].inaaownid, 
                   g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt, 
                   g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt)
                WHERE inaaent = g_enterprise AND
                  inaasite = g_inaa_d_t.inaasite #項次   
                  AND inaa001 = g_inaa_d_t.inaa001  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inaa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d[g_detail_idx].inaasite
               LET gs_keys_bak[1] = g_inaa_d_t.inaasite
               LET gs_keys[2] = g_inaa_d[g_detail_idx].inaa001
               LET gs_keys_bak[2] = g_inaa_d_t.inaa001
               CALL asti703_update_b('inaa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_inaa_d[l_ac].inaa001 = g_detail_multi_table_t.inayl001 AND
         g_inaa_d[l_ac].inayl003 = g_detail_multi_table_t.inayl003 AND
         g_inaa_d[l_ac].inayl004 = g_detail_multi_table_t.inayl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'inaylent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_inaa_d[l_ac].inaa001
            LET l_field_keys[02] = 'inayl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.inayl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'inayl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.inayl002
            LET l_vars[01] = g_inaa_d[l_ac].inayl003
            LET l_fields[01] = 'inayl003'
            LET l_vars[02] = g_inaa_d[l_ac].inayl004
            LET l_fields[02] = 'inayl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'inayl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_inaa_d_t)
                     LET g_log2 = util.JSON.stringify(g_inaa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asti703_inaa_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asti703_unlock_b("inaa_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_inaa_d[l_ac].* = g_inaa_d_t.*
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
               LET g_inaa_d[li_reproduce_target].* = g_inaa_d[li_reproduce].*
               LET g_inaa2_d[li_reproduce_target].* = g_inaa2_d[li_reproduce].*
 
               LET g_inaa_d[li_reproduce_target].inaasite = NULL
               LET g_inaa_d[li_reproduce_target].inaa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inaa_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_inaa2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL asti703_b_fill(g_wc2)
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
               NEXT FIELD inaastus
            WHEN "s_detail2"
               NEXT FIELD inaasite_2
 
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
      IF INT_FLAG OR cl_null(g_inaa_d[g_detail_idx].inaasite) THEN
         CALL g_inaa_d.deleteElement(g_detail_idx)
         CALL g_inaa2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_inaa_d[g_detail_idx].* = g_inaa_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
      CALL asti703_b_fill(g_wc2)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
    
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
 
   CLOSE asti703_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asti703_delete()
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
   FOR li_idx = 1 TO g_inaa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT asti703_lock_b("inaa_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("inaa_t","inaaownid") THEN
            LET g_data_owner = g_inaa2_d[g_detail_idx].inaaownid
            LET g_data_dept = g_inaa2_d[g_detail_idx].inaaowndp
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
   
   FOR li_idx = 1 TO g_inaa_d.getLength()
      IF g_inaa_d[li_idx].inaasite IS NOT NULL
         AND g_inaa_d[li_idx].inaa001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM inaa_t
          WHERE inaaent = g_enterprise AND 
                inaasite = g_inaa_d[li_idx].inaasite
                AND inaa001 = g_inaa_d[li_idx].inaa001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.inayl001 = g_inaa_d[l_ac].inaa001
LET g_detail_multi_table_t.inayl002 = g_dlang
LET g_detail_multi_table_t.inayl003 = g_inaa_d[l_ac].inayl003
LET g_detail_multi_table_t.inayl004 = g_inaa_d[l_ac].inayl004
 
 
            
LET g_detail_multi_table_t.inayl001 = g_inaa_d[l_ac].inaa001
LET g_detail_multi_table_t.inayl002 = g_dlang
LET g_detail_multi_table_t.inayl003 = g_inaa_d[l_ac].inayl003
LET g_detail_multi_table_t.inayl004 = g_inaa_d[l_ac].inayl004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'inaylent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'inayl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.inayl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'inayl_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'inaylent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'inayl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.inayl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'inayl_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inaa_d_t.inaasite
               LET gs_keys[2] = g_inaa_d_t.inaa001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL asti703_delete_b('inaa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asti703_set_pk_array()
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
   CALL asti703_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="asti703.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asti703_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'inaasite') RETURNING l_where
   LET p_wc2 = p_wc2," AND ",l_where
   LET p_wc2  = p_wc2.trim() 
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.inaastus,t0.inaasite,t0.inaa001,t0.inaa101,t0.inaaunit,t0.inaasite, 
       t0.inaa001,t0.inaaownid,t0.inaaowndp,t0.inaacrtid,t0.inaacrtdp,t0.inaacrtdt,t0.inaamodid,t0.inaamoddt , 
       t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM inaa_t t0",
               " LEFT JOIN inayl_t ON inaylent = "||g_enterprise||" AND inaa001 = inayl001 AND inayl002 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inaaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inaaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.inaacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.inaacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inaamodid  ",
 
               " WHERE t0.inaaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("inaa_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND inaaowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("inaa_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND inaaownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = g_sql," AND t0.inaa101 = '3' "
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("inaa_t"),
                      " ORDER BY t0.inaasite,t0.inaa001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"inaa_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asti703_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asti703_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_inaa_d.clear()
   CALL g_inaa2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaasite,g_inaa_d[l_ac].inaa001,g_inaa_d[l_ac].inaa101, 
       g_inaa_d[l_ac].inaaunit,g_inaa2_d[l_ac].inaasite,g_inaa2_d[l_ac].inaa001,g_inaa2_d[l_ac].inaaownid, 
       g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt, 
       g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt,g_inaa_d[l_ac].inaasite_desc,g_inaa2_d[l_ac].inaaownid_desc, 
       g_inaa2_d[l_ac].inaaowndp_desc,g_inaa2_d[l_ac].inaacrtid_desc,g_inaa2_d[l_ac].inaacrtdp_desc, 
       g_inaa2_d[l_ac].inaamodid_desc
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
      
      CALL asti703_detail_show()      
 
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
   
 
   
   CALL g_inaa_d.deleteElement(g_inaa_d.getLength())   
   CALL g_inaa2_d.deleteElement(g_inaa2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_inaa_d.getLength()
      LET g_inaa2_d[l_ac].inaasite = g_inaa_d[l_ac].inaasite 
      LET g_inaa2_d[l_ac].inaa001 = g_inaa_d[l_ac].inaa001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_inaa_d.getLength() THEN
      LET l_ac = g_inaa_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_inaa_d.getLength()
      LET g_inaa_d_mask_o[l_ac].* =  g_inaa_d[l_ac].*
      CALL asti703_inaa_t_mask()
      LET g_inaa_d_mask_n[l_ac].* =  g_inaa_d[l_ac].*
   END FOR
   
   LET g_inaa2_d_mask_o.* =  g_inaa2_d.*
   FOR l_ac = 1 TO g_inaa2_d.getLength()
      LET g_inaa2_d_mask_o[l_ac].* =  g_inaa2_d[l_ac].*
      CALL asti703_inaa_t_mask()
      LET g_inaa2_d_mask_n[l_ac].* =  g_inaa2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_inaa_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE asti703_pb
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asti703_detail_show()
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
   CALL asti703_inaasite_ref()
   CALL asti703_inaa001_ref()
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   LET g_inaa2_d[l_ac].inaasite_2_desc =  g_inaa_d[l_ac].inaasite_desc
   LET g_inaa2_d[l_ac].inaa001_2_desc =  g_inaa_d[l_ac].inayl003
   LET g_inaa2_d[l_ac].inaa001_2_desc_1 =  g_inaa_d[l_ac].inayl004
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asti703.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asti703_set_entry_b(p_cmd)                                                  
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
 
{<section id="asti703.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asti703_set_no_entry_b(p_cmd)                                               
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
      CALL cl_set_comp_entry("inaasite,inaa001",FALSE)
   ELSE
      CALL cl_set_comp_entry("inaasite,inaa001",TRUE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="asti703.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asti703_default_search()
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
      LET ls_wc = ls_wc, " inaasite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inaa001 = '", g_argv[02], "' AND "
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
 
{<section id="asti703.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asti703_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'inaa_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM inaa_t
          WHERE inaaent = g_enterprise AND
            inaasite = ps_keys_bak[1] AND inaa001 = ps_keys_bak[2]
         
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
         CALL g_inaa_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_inaa2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
     
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asti703_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "inaa_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO inaa_t
                  (inaaent,
                   inaasite,inaa001
                   ,inaastus,inaa101,inaaunit,inaaownid,inaaowndp,inaacrtid,inaacrtdp,inaacrtdt,inaamodid,inaamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaa101,g_inaa_d[l_ac].inaaunit,g_inaa2_d[l_ac].inaaownid, 
                       g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp, 
                       g_inaa2_d[l_ac].inaacrtdt,g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      INSERT INTO inay_t
                  (inayent,inay001,
                   inaystus,inayownid,inayowndp,inaycrtid,inaycrtdp,inaycrtdt,inaymodid,inaymoddt) 
           VALUES(g_enterprise,ps_keys[2]
                   ,g_inaa_d[l_ac].inaastus,g_inaa2_d[l_ac].inaaownid,g_inaa2_d[l_ac].inaaowndp, 
                       g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt, 
                       g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inay_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asti703_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "inaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "inaa_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE inaa_t 
         SET (inaasite,inaa001
              ,inaastus,inaa101,inaaunit,inaaownid,inaaowndp,inaacrtid,inaacrtdp,inaacrtdt,inaamodid,inaamoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inaa_d[l_ac].inaastus,g_inaa_d[l_ac].inaa101,g_inaa_d[l_ac].inaaunit,g_inaa2_d[l_ac].inaaownid, 
                  g_inaa2_d[l_ac].inaaowndp,g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt, 
                  g_inaa2_d[l_ac].inaamodid,g_inaa2_d[l_ac].inaamoddt) 
         WHERE inaaent = g_enterprise AND inaasite = ps_keys_bak[1] AND inaa001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inaa_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
       UPDATE inay_t 
         SET (inay001
              ,inaystus,inayownid,inayowndp,inaycrtid,inaycrtdp,inaycrtdt,inaymodid,inaymoddt) 
              = 
             (ps_keys[2]
              ,g_inaa_d[l_ac].inaastus,g_inaa2_d[l_ac].inaaownid,g_inaa2_d[l_ac].inaaowndp, 
                  g_inaa2_d[l_ac].inaacrtid,g_inaa2_d[l_ac].inaacrtdp,g_inaa2_d[l_ac].inaacrtdt,g_inaa2_d[l_ac].inaamodid, 
                  g_inaa2_d[l_ac].inaamoddt) 
         WHERE inayent = g_enterprise AND inay001 = ps_keys_bak[2]  #160905-00007#15 by 08172
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inay_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inay_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE    
         
         
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asti703_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL asti703_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "inaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asti703_bcl USING g_enterprise,
                                       g_inaa_d[g_detail_idx].inaasite,g_inaa_d[g_detail_idx].inaa001 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asti703_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asti703.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asti703_unlock_b(ps_table)
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
      CLOSE asti703_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asti703.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION asti703_modify_detail_chk(ps_record)
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
         LET ls_return = "inaastus"
      WHEN "s_detail2"
         LET ls_return = "inaasite_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="asti703.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION asti703_show_ownid_msg()
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
 
{<section id="asti703.mask_functions" >}
&include "erp/ast/asti703_mask.4gl"
 
{</section>}
 
{<section id="asti703.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asti703_set_pk_array()
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
   LET g_pk_array[1].values = g_inaa_d[l_ac].inaasite
   LET g_pk_array[1].column = 'inaasite'
   LET g_pk_array[2].values = g_inaa_d[l_ac].inaa001
   LET g_pk_array[2].column = 'inaa001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asti703.state_change" >}
   
 
{</section>}
 
{<section id="asti703.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="asti703.other_function" readonly="Y" >}

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
PUBLIC FUNCTION asti703_del_chk()
DEFINE l_n    LIKE type_t.num5

   SELECT COUNT(1) INTO l_n FROM inag_t  #160905-00007#15 by 08172 *变1
    WHERE inagent = g_enterprise AND inagsite =  g_inaa_d[l_ac].inaasite AND inag004 = g_inaa_d[l_ac].inaa001 

   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_inaa_d[l_ac].inaasite||'|'||g_inaa_d[l_ac].inaa001  
      LET g_errparam.code   = 'art-00150'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
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
PUBLIC FUNCTION asti703_inaa001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa_d[l_ac].inaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003,inayl004 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa_d[l_ac].inayl003 = '', g_rtn_fields[1] , ''
   LET g_inaa_d[l_ac].inayl004 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inaa_d[l_ac].inayl003,g_inaa_d[l_ac].inayl004
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
PUBLIC FUNCTION asti703_inaasite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa_d[l_ac].inaasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa_d[l_ac].inaasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa_d[l_ac].inaasite_desc
   
   SELECT ooef017 INTO g_inaa_d[l_ac].ooef017 FROM ooef_t  WHERE ooef001 = g_inaa_d[l_ac].inaasite 
      AND ooefent = g_enterprise  #160905-00007#15 by 08172
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inaa_d[l_ac].ooef017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inaa_d[l_ac].ooef017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inaa_d[l_ac].ooef017,g_inaa_d[l_ac].ooef017_desc
   
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
PUBLIC FUNCTION asti703_inaasite_chk(p_cmd)
DEFINE l_n      LIKE type_t.num5
DEFINE p_cmd    LIKE type_t.chr1

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = g_inaa_d[l_ac].inaasite
   LET g_chkparam.arg2 = '8'
   LET g_chkparam.arg3 = g_site
   IF NOT cl_chk_exist("v_ooed004") THEN
      RETURN FALSE
   END IF
   #一个库区组只能存在一笔有效的虚拟库位设定
   
   SELECT COUNT(1) INTO l_n FROM inaa_t  #160905-00007#15 by 08172 *变1
    WHERE inaasite = g_inaa_d[l_ac].inaasite
      AND inaastus = 'Y' AND inaa101 = '3'
      AND inaaent = g_enterprise   #160905-00007#15 by 08172

   IF p_cmd = 'a' THEN
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inaa_d[l_ac].inaasite
         LET g_errparam.code   = 'ast-00192'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   ELSE
      IF l_n > 0 AND g_inaa_d[l_ac].inaasite <> g_inaa_d_t.inaasite THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inaa_d[l_ac].inaasite
         LET g_errparam.code   = 'ast-00192'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
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
PUBLIC FUNCTION asti703_inaa001_chk(p_cmd)
DEFINE  p_cmd  LIKE type_t.chr1
DEFINE  l_n    LIKE type_t.num5
DEFINE  l_n1   LIKE type_t.num5

   IF  g_inaa_d[l_ac].inaa001 IS NOT NULL THEN 
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inaa_d[l_ac].inaa001 != g_inaa_d_t.inaa001)) THEN 
        # IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inaa_t WHERE "||"inaaent = '" ||g_enterprise|| "' AND "||"inaasite = '"||g_inaa_d[g_detail_idx].inaasite ||"' AND "|| "inaa001 = '"||g_inaa_d[g_detail_idx].inaa001 ||"'",'std-00004',0) THEN 
        #    RETURN FALSE
        # END IF
         SELECT COUNT(1) INTO l_n FROM inaa_t #160905-00007#15 by 08172 *变1
          WHERE inaaent = g_enterprise AND inaa001 = g_inaa_d[l_ac].inaa001 AND inaa101 <> '3'
          
         SELECT COUNT(1) INTO l_n1 FROM inay_t #160905-00007#15 by 08172 *变1
          WHERE inayent = g_enterprise AND inay001 = g_inaa_d[l_ac].inaa001 
          
         IF l_n > 0 OR l_n1 > 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  g_inaa_d[l_ac].inaa001
            LET g_errparam.code   = 'ast-00193'
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN FALSE   
         END IF
         
         SELECT COUNT(1) INTO l_n FROM inaa_t  #160905-00007#15 by 08172 *变1
          WHERE inaaent = g_enterprise  AND inaa001 = g_inaa_d[l_ac].inaa001 AND inaa101 = '3'
         IF l_n > 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  g_inaa_d[l_ac].inaa001
            LET g_errparam.code   = 'ast-00194'
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN FALSE   
         END IF
      END IF
   END IF

   RETURN TRUE
END FUNCTION

 
{</section>}
 
