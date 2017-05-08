#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi392.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-17 17:11:40), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: aooi392
#+ Description: 自動編碼最大流水號維護作業
#+ Creator....: 05384(2015-02-12 10:09:15)
#+ Modifier...: 00593 -SD/PR- 00000
 
{</section>}
 
{<section id="aooi392.global" >}
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
PRIVATE TYPE type_g_oofi_d RECORD
       oofi001 LIKE oofi_t.oofi001, 
   oofi002 LIKE oofi_t.oofi002, 
   oofi003 LIKE oofi_t.oofi003
       END RECORD
PRIVATE TYPE type_g_oofi2_d RECORD
       oofi001 LIKE oofi_t.oofi001, 
   oofi002 LIKE oofi_t.oofi002, 
   oofiownid LIKE oofi_t.oofiownid, 
   oofiownid_desc LIKE type_t.chr500, 
   oofiowndp LIKE oofi_t.oofiowndp, 
   oofiowndp_desc LIKE type_t.chr500, 
   ooficrtid LIKE oofi_t.ooficrtid, 
   ooficrtid_desc LIKE type_t.chr500, 
   ooficrtdp LIKE oofi_t.ooficrtdp, 
   ooficrtdp_desc LIKE type_t.chr500, 
   ooficrtdt DATETIME YEAR TO SECOND, 
   oofimodid LIKE oofi_t.oofimodid, 
   oofimodid_desc LIKE type_t.chr500, 
   oofimoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_length             LIKE type_t.num10
DEFINE g_sql1               STRING
DEFINE g_oofg001            LIKE oofg_t.oofg001
DEFINE g_oofg003            LIKE oofg_t.oofg003
DEFINE g_oofg005            LIKE oofg_t.oofg005
DEFINE g_oofg005_num        LIKE oofg_t.oofg005
DEFINE g_oofg006            LIKE oofg_t.oofg006
DEFINE g_oofg009            LIKE oofg_t.oofg009
DEFINE g_length_str         STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_oofi_d          DYNAMIC ARRAY OF type_g_oofi_d #單身變數
DEFINE g_oofi_d_t        type_g_oofi_d                  #單身備份
DEFINE g_oofi_d_o        type_g_oofi_d                  #單身備份
DEFINE g_oofi_d_mask_o   DYNAMIC ARRAY OF type_g_oofi_d #單身變數
DEFINE g_oofi_d_mask_n   DYNAMIC ARRAY OF type_g_oofi_d #單身變數
DEFINE g_oofi2_d   DYNAMIC ARRAY OF type_g_oofi2_d
DEFINE g_oofi2_d_t type_g_oofi2_d
DEFINE g_oofi2_d_o type_g_oofi2_d
DEFINE g_oofi2_d_mask_o DYNAMIC ARRAY OF type_g_oofi2_d
DEFINE g_oofi2_d_mask_n DYNAMIC ARRAY OF type_g_oofi2_d
 
      
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
 
{<section id="aooi392.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT oofi001,oofi002,oofi003,oofi001,oofi002,oofiownid,oofiowndp,ooficrtid, 
       ooficrtdp,ooficrtdt,oofimodid,oofimoddt FROM oofi_t WHERE oofient=? AND oofi001=? AND oofi002=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi392_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi392 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi392_init()   
 
      #進入選單 Menu (="N")
      CALL aooi392_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi392
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi392.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aooi392_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL aooi392_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi392.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aooi392_ui_dialog()
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
         CALL g_oofi_d.clear()
         CALL g_oofi2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL aooi392_init()
      END IF
   
      CALL aooi392_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_oofi_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_oofi2_d[g_detail_idx].oofiownid   #(ver:35)
               LET g_data_dept = g_oofi2_d[g_detail_idx].oofiowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL aooi392_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_oofi2_d TO s_detail2.*
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
   CALL aooi392_set_pk_array()
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
            CALL aooi392_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi392_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL aooi392_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL aooi392_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
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
               CALL aooi392_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_oofi_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_oofi2_d)
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
            CALL aooi392_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi392_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi392_set_pk_array()
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
 
{<section id="aooi392.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi392_query()
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
   CALL g_oofi_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON oofi001,oofi002,oofi003,oofiownid,oofiowndp,ooficrtid,ooficrtdp,ooficrtdt,oofimodid, 
          oofimoddt 
 
         FROM s_detail1[1].oofi001,s_detail1[1].oofi002,s_detail1[1].oofi003,s_detail2[1].oofiownid, 
             s_detail2[1].oofiowndp,s_detail2[1].ooficrtid,s_detail2[1].ooficrtdp,s_detail2[1].ooficrtdt, 
             s_detail2[1].oofimodid,s_detail2[1].oofimoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<ooficrtdt>>----
         AFTER FIELD ooficrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oofimoddt>>----
         AFTER FIELD oofimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooficnfdt>>----
         
         #----<<oofipstdt>>----
 
 
 
      
                  #Ctrlp:construct.c.page1.oofi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofi001
            #add-point:ON ACTION controlp INFIELD oofi001 name="construct.c.page1.oofi001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oofg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofi001  #顯示到畫面上
            NEXT FIELD oofi001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofi001
            #add-point:BEFORE FIELD oofi001 name="query.b.page1.oofi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofi001
            
            #add-point:AFTER FIELD oofi001 name="query.a.page1.oofi001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofi002
            #add-point:BEFORE FIELD oofi002 name="query.b.page1.oofi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofi002
            
            #add-point:AFTER FIELD oofi002 name="query.a.page1.oofi002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oofi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofi002
            #add-point:ON ACTION controlp INFIELD oofi002 name="query.c.page1.oofi002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofi003
            #add-point:BEFORE FIELD oofi003 name="query.b.page1.oofi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofi003
            
            #add-point:AFTER FIELD oofi003 name="query.a.page1.oofi003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.oofi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofi003
            #add-point:ON ACTION controlp INFIELD oofi003 name="query.c.page1.oofi003"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.oofiownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofiownid
            #add-point:ON ACTION controlp INFIELD oofiownid name="construct.c.page2.oofiownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofiownid  #顯示到畫面上
            NEXT FIELD oofiownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofiownid
            #add-point:BEFORE FIELD oofiownid name="query.b.page2.oofiownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofiownid
            
            #add-point:AFTER FIELD oofiownid name="query.a.page2.oofiownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oofiowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofiowndp
            #add-point:ON ACTION controlp INFIELD oofiowndp name="construct.c.page2.oofiowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofiowndp  #顯示到畫面上
            NEXT FIELD oofiowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofiowndp
            #add-point:BEFORE FIELD oofiowndp name="query.b.page2.oofiowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofiowndp
            
            #add-point:AFTER FIELD oofiowndp name="query.a.page2.oofiowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.ooficrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooficrtid
            #add-point:ON ACTION controlp INFIELD ooficrtid name="construct.c.page2.ooficrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooficrtid  #顯示到畫面上
            NEXT FIELD ooficrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooficrtid
            #add-point:BEFORE FIELD ooficrtid name="query.b.page2.ooficrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooficrtid
            
            #add-point:AFTER FIELD ooficrtid name="query.a.page2.ooficrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.ooficrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooficrtdp
            #add-point:ON ACTION controlp INFIELD ooficrtdp name="construct.c.page2.ooficrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooficrtdp  #顯示到畫面上
            NEXT FIELD ooficrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooficrtdp
            #add-point:BEFORE FIELD ooficrtdp name="query.b.page2.ooficrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooficrtdp
            
            #add-point:AFTER FIELD ooficrtdp name="query.a.page2.ooficrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooficrtdt
            #add-point:BEFORE FIELD ooficrtdt name="query.b.page2.ooficrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.oofimodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofimodid
            #add-point:ON ACTION controlp INFIELD oofimodid name="construct.c.page2.oofimodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofimodid  #顯示到畫面上
            NEXT FIELD oofimodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofimodid
            #add-point:BEFORE FIELD oofimodid name="query.b.page2.oofimodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofimodid
            
            #add-point:AFTER FIELD oofimodid name="query.a.page2.oofimodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofimoddt
            #add-point:BEFORE FIELD oofimoddt name="query.b.page2.oofimoddt"
            
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
    
   CALL aooi392_b_fill(g_wc2)
   LET g_data_owner = g_oofi2_d[g_detail_idx].oofiownid   #(ver:35)
   LET g_data_dept = g_oofi2_d[g_detail_idx].oofiowndp   #(ver:35)
 
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
 
{<section id="aooi392.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi392_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL aooi392_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi392.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi392_modify()
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
   DEFINE l_oofg002               LIKE oofg_t.oofg002
   DEFINE l_oofg005               LIKE oofg_t.oofg005
   DEFINE l_oofg006               LIKE oofg_t.oofg006
   DEFINE l_max                   LIKE oofi_t.oofi003
   DEFINE l_success               LIKE type_t.num5
   DEFINE l_conform               LIKE type_t.num5
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
      INPUT ARRAY g_oofi_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oofi_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi392_b_fill(g_wc2)
            LET g_detail_cnt = g_oofi_d.getLength()
         
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
            DISPLAY g_oofi_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_oofi_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_oofi_d[l_ac].oofi001 IS NOT NULL
               AND g_oofi_d[l_ac].oofi002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_oofi_d_t.* = g_oofi_d[l_ac].*  #BACKUP
               LET g_oofi_d_o.* = g_oofi_d[l_ac].*  #BACKUP
               IF NOT aooi392_lock_b("oofi_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi392_bcl INTO g_oofi_d[l_ac].oofi001,g_oofi_d[l_ac].oofi002,g_oofi_d[l_ac].oofi003, 
                      g_oofi2_d[l_ac].oofi001,g_oofi2_d[l_ac].oofi002,g_oofi2_d[l_ac].oofiownid,g_oofi2_d[l_ac].oofiowndp, 
                      g_oofi2_d[l_ac].ooficrtid,g_oofi2_d[l_ac].ooficrtdp,g_oofi2_d[l_ac].ooficrtdt, 
                      g_oofi2_d[l_ac].oofimodid,g_oofi2_d[l_ac].oofimoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_oofi_d_t.oofi001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oofi_d_mask_o[l_ac].* =  g_oofi_d[l_ac].*
                  CALL aooi392_oofi_t_mask()
                  LET g_oofi_d_mask_n[l_ac].* =  g_oofi_d[l_ac].*
                  
                  CALL aooi392_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL aooi392_set_entry_b(l_cmd)
            CALL aooi392_set_no_entry_b(l_cmd)
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
            INITIALIZE g_oofi_d_t.* TO NULL
            INITIALIZE g_oofi_d_o.* TO NULL
            INITIALIZE g_oofi_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oofi2_d[l_ac].oofiownid = g_user
      LET g_oofi2_d[l_ac].oofiowndp = g_dept
      LET g_oofi2_d[l_ac].ooficrtid = g_user
      LET g_oofi2_d[l_ac].ooficrtdp = g_dept 
      LET g_oofi2_d[l_ac].ooficrtdt = cl_get_current()
      LET g_oofi2_d[l_ac].oofimodid = g_user
      LET g_oofi2_d[l_ac].oofimoddt = cl_get_current()
 
 
 
            #自定義預設值(單身2)
                  LET g_oofi_d[l_ac].oofi003 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_oofi_d_t.* = g_oofi_d[l_ac].*     #新輸入資料
            LET g_oofi_d_o.* = g_oofi_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oofi_d[li_reproduce_target].* = g_oofi_d[li_reproduce].*
               LET g_oofi2_d[li_reproduce_target].* = g_oofi2_d[li_reproduce].*
 
               LET g_oofi_d[g_oofi_d.getLength()].oofi001 = NULL
               LET g_oofi_d[g_oofi_d.getLength()].oofi002 = NULL
 
            END IF
            
 
 
            CALL aooi392_set_entry_b(l_cmd)
            CALL aooi392_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM oofi_t 
             WHERE oofient = g_enterprise AND oofi001 = g_oofi_d[l_ac].oofi001
                                       AND oofi002 = g_oofi_d[l_ac].oofi002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oofi_d[g_detail_idx].oofi001
               LET gs_keys[2] = g_oofi_d[g_detail_idx].oofi002
               CALL aooi392_insert_b('oofi_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oofi_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oofi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi392_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (oofi001 = '", g_oofi_d[l_ac].oofi001, "' "
                                  ," AND oofi002 = '", g_oofi_d[l_ac].oofi002, "' "
 
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
               
               DELETE FROM oofi_t
                WHERE oofient = g_enterprise AND 
                      oofi001 = g_oofi_d_t.oofi001
                      AND oofi002 = g_oofi_d_t.oofi002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "oofi_t:",SQLERRMESSAGE 
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
                  CALL aooi392_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_oofi_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE aooi392_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_oofi_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oofi_d_t.oofi001
               LET gs_keys[2] = g_oofi_d_t.oofi002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi392_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL aooi392_delete_b('oofi_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_oofi_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofi003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oofi_d[l_ac].oofi003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD oofi003
            END IF 
 
 
 
            #add-point:AFTER FIELD oofi003 name="input.a.page1.oofi003"
            IF NOT cl_null(g_oofi_d[l_ac].oofi003) THEN
               IF g_oofi_d[l_ac].oofi003 != g_oofi_d_t.oofi003 OR g_oofi_d_t.oofi003 IS NULL THEN
                  IF l_conform THEN
                     IF g_oofi_d[l_ac].oofi003 < l_max THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aoo-00630'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofi003
            #add-point:BEFORE FIELD oofi003 name="input.b.page1.oofi003"
            SELECT oofg002,oofg003,oofg005 INTO l_oofg002,g_oofg003,g_oofg005
              FROM oofg_t
             WHERE oofgent = g_enterprise
               AND oofg001 = g_oofi_d[l_ac].oofi001
               AND oofg005 = oofg006
            LET g_length_str = g_oofi_d[l_ac].oofi002
            LET g_length = g_length_str.getLength()
            IF NOT cl_null(g_oofi_d[l_ac].oofi002) THEN
               CALL aooi392_check(g_oofi_d[l_ac].oofi002) RETURNING l_success,l_conform
            ELSE
               LET l_conform = FALSE
            END IF
            SELECT oofg009 INTO g_oofg009
            FROM oofg_t
             WHERE oofgent = g_enterprise
               AND oofg001 = g_oofi_d[l_ac].oofi001
               AND oofg005 = g_oofg005_num
               AND oofg008 = '9'

            
            CALL aooi392_get_sql(l_oofg002,g_oofi_d[l_ac].oofi002) RETURNING l_success
            LET l_max = 0
            PREPARE aooi392_get_sql_pre FROM g_sql
            EXECUTE aooi392_get_sql_pre INTO l_max
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofi003
            #add-point:ON CHANGE oofi003 name="input.g.page1.oofi003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oofi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofi003
            #add-point:ON ACTION controlp INFIELD oofi003 name="input.c.page1.oofi003"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE aooi392_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_oofi_d[l_ac].* = g_oofi_d_t.*
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
               LET g_errparam.extend = g_oofi_d[l_ac].oofi001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_oofi_d[l_ac].* = g_oofi_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_oofi2_d[l_ac].oofimodid = g_user 
LET g_oofi2_d[l_ac].oofimoddt = cl_get_current()
LET g_oofi2_d[l_ac].oofimodid_desc = cl_get_username(g_oofi2_d[l_ac].oofimodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi392_oofi_t_mask_restore('restore_mask_o')
 
               UPDATE oofi_t SET (oofi001,oofi002,oofi003,oofiownid,oofiowndp,ooficrtid,ooficrtdp,ooficrtdt, 
                   oofimodid,oofimoddt) = (g_oofi_d[l_ac].oofi001,g_oofi_d[l_ac].oofi002,g_oofi_d[l_ac].oofi003, 
                   g_oofi2_d[l_ac].oofiownid,g_oofi2_d[l_ac].oofiowndp,g_oofi2_d[l_ac].ooficrtid,g_oofi2_d[l_ac].ooficrtdp, 
                   g_oofi2_d[l_ac].ooficrtdt,g_oofi2_d[l_ac].oofimodid,g_oofi2_d[l_ac].oofimoddt)
                WHERE oofient = g_enterprise AND
                  oofi001 = g_oofi_d_t.oofi001 #項次   
                  AND oofi002 = g_oofi_d_t.oofi002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oofi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oofi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oofi_d[g_detail_idx].oofi001
               LET gs_keys_bak[1] = g_oofi_d_t.oofi001
               LET gs_keys[2] = g_oofi_d[g_detail_idx].oofi002
               LET gs_keys_bak[2] = g_oofi_d_t.oofi002
               CALL aooi392_update_b('oofi_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_oofi_d_t)
                     LET g_log2 = util.JSON.stringify(g_oofi_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi392_oofi_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL aooi392_unlock_b("oofi_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oofi_d[l_ac].* = g_oofi_d_t.*
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
               LET g_oofi_d[li_reproduce_target].* = g_oofi_d[li_reproduce].*
               LET g_oofi2_d[li_reproduce_target].* = g_oofi2_d[li_reproduce].*
 
               LET g_oofi_d[li_reproduce_target].oofi001 = NULL
               LET g_oofi_d[li_reproduce_target].oofi002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_oofi_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oofi_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_oofi2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL aooi392_b_fill(g_wc2)
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
               NEXT FIELD oofi001
            WHEN "s_detail2"
               NEXT FIELD oofi001_2
 
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
      IF INT_FLAG OR cl_null(g_oofi_d[g_detail_idx].oofi001) THEN
         CALL g_oofi_d.deleteElement(g_detail_idx)
         CALL g_oofi2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_oofi_d[g_detail_idx].* = g_oofi_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE aooi392_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi392.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi392_delete()
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
   FOR li_idx = 1 TO g_oofi_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT aooi392_lock_b("oofi_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("oofi_t","oofiownid") THEN
            LET g_data_owner = g_oofi2_d[g_detail_idx].oofiownid
            LET g_data_dept = g_oofi2_d[g_detail_idx].oofiowndp
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
   
   FOR li_idx = 1 TO g_oofi_d.getLength()
      IF g_oofi_d[li_idx].oofi001 IS NOT NULL
         AND g_oofi_d[li_idx].oofi002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM oofi_t
          WHERE oofient = g_enterprise AND 
                oofi001 = g_oofi_d[li_idx].oofi001
                AND oofi002 = g_oofi_d[li_idx].oofi002
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oofi_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_oofi_d_t.oofi001
               LET gs_keys[2] = g_oofi_d_t.oofi002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL aooi392_delete_b('oofi_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi392_set_pk_array()
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
   CALL aooi392_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="aooi392.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi392_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.oofi001,t0.oofi002,t0.oofi003,t0.oofi001,t0.oofi002,t0.oofiownid, 
       t0.oofiowndp,t0.ooficrtid,t0.ooficrtdp,t0.ooficrtdt,t0.oofimodid,t0.oofimoddt ,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM oofi_t t0",
               "",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.oofiownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.oofiowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.ooficrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.ooficrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.oofimodid  ",
 
               " WHERE t0.oofient= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("oofi_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND oofiowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("oofi_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND oofiownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("oofi_t"),
                      " ORDER BY t0.oofi001,t0.oofi002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"oofi_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aooi392_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aooi392_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_oofi_d.clear()
   CALL g_oofi2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_oofi_d[l_ac].oofi001,g_oofi_d[l_ac].oofi002,g_oofi_d[l_ac].oofi003,g_oofi2_d[l_ac].oofi001, 
       g_oofi2_d[l_ac].oofi002,g_oofi2_d[l_ac].oofiownid,g_oofi2_d[l_ac].oofiowndp,g_oofi2_d[l_ac].ooficrtid, 
       g_oofi2_d[l_ac].ooficrtdp,g_oofi2_d[l_ac].ooficrtdt,g_oofi2_d[l_ac].oofimodid,g_oofi2_d[l_ac].oofimoddt, 
       g_oofi2_d[l_ac].oofiownid_desc,g_oofi2_d[l_ac].oofiowndp_desc,g_oofi2_d[l_ac].ooficrtid_desc, 
       g_oofi2_d[l_ac].ooficrtdp_desc,g_oofi2_d[l_ac].oofimodid_desc
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
      
      CALL aooi392_detail_show()      
 
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
   
 
   
   CALL g_oofi_d.deleteElement(g_oofi_d.getLength())   
   CALL g_oofi2_d.deleteElement(g_oofi2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_oofi_d.getLength()
      LET g_oofi2_d[l_ac].oofi001 = g_oofi_d[l_ac].oofi001 
      LET g_oofi2_d[l_ac].oofi002 = g_oofi_d[l_ac].oofi002 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_oofi_d.getLength() THEN
      LET l_ac = g_oofi_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_oofi_d.getLength()
      LET g_oofi_d_mask_o[l_ac].* =  g_oofi_d[l_ac].*
      CALL aooi392_oofi_t_mask()
      LET g_oofi_d_mask_n[l_ac].* =  g_oofi_d[l_ac].*
   END FOR
   
   LET g_oofi2_d_mask_o.* =  g_oofi2_d.*
   FOR l_ac = 1 TO g_oofi2_d.getLength()
      LET g_oofi2_d_mask_o[l_ac].* =  g_oofi2_d[l_ac].*
      CALL aooi392_oofi_t_mask()
      LET g_oofi2_d_mask_n[l_ac].* =  g_oofi2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_oofi_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE aooi392_pb
   
END FUNCTION
 
{</section>}
 
{<section id="aooi392.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aooi392_detail_show()
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
 
{<section id="aooi392.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi392_set_entry_b(p_cmd)                                                  
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
 
{<section id="aooi392.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi392_set_no_entry_b(p_cmd)                                               
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
 
{<section id="aooi392.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi392_default_search()
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
      LET ls_wc = ls_wc, " oofi001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " oofi002 = '", g_argv[02], "' AND "
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
 
{<section id="aooi392.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi392_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "oofi_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'oofi_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM oofi_t
          WHERE oofient = g_enterprise AND
            oofi001 = ps_keys_bak[1] AND oofi002 = ps_keys_bak[2]
         
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
         CALL g_oofi_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_oofi2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi392.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi392_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "oofi_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO oofi_t
                  (oofient,
                   oofi001,oofi002
                   ,oofi003,oofiownid,oofiowndp,ooficrtid,ooficrtdp,ooficrtdt,oofimodid,oofimoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oofi_d[l_ac].oofi003,g_oofi2_d[l_ac].oofiownid,g_oofi2_d[l_ac].oofiowndp,g_oofi2_d[l_ac].ooficrtid, 
                       g_oofi2_d[l_ac].ooficrtdp,g_oofi2_d[l_ac].ooficrtdt,g_oofi2_d[l_ac].oofimodid, 
                       g_oofi2_d[l_ac].oofimoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oofi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi392.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi392_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "oofi_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "oofi_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE oofi_t 
         SET (oofi001,oofi002
              ,oofi003,oofiownid,oofiowndp,ooficrtid,ooficrtdp,ooficrtdt,oofimodid,oofimoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oofi_d[l_ac].oofi003,g_oofi2_d[l_ac].oofiownid,g_oofi2_d[l_ac].oofiowndp,g_oofi2_d[l_ac].ooficrtid, 
                  g_oofi2_d[l_ac].ooficrtdp,g_oofi2_d[l_ac].ooficrtdt,g_oofi2_d[l_ac].oofimodid,g_oofi2_d[l_ac].oofimoddt)  
 
         WHERE oofient = g_enterprise AND oofi001 = ps_keys_bak[1] AND oofi002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oofi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oofi_t:",SQLERRMESSAGE 
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
 
{<section id="aooi392.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi392_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aooi392_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "oofi_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi392_bcl USING g_enterprise,
                                       g_oofi_d[g_detail_idx].oofi001,g_oofi_d[g_detail_idx].oofi002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi392_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi392.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi392_unlock_b(ps_table)
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
      CLOSE aooi392_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi392.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION aooi392_modify_detail_chk(ps_record)
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
         LET ls_return = "oofi001"
      WHEN "s_detail2"
         LET ls_return = "oofi001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi392.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION aooi392_show_ownid_msg()
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
 
{<section id="aooi392.mask_functions" >}
&include "erp/aoo/aooi392_mask.4gl"
 
{</section>}
 
{<section id="aooi392.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi392_set_pk_array()
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
   LET g_pk_array[1].values = g_oofi_d[l_ac].oofi001
   LET g_pk_array[1].column = 'oofi001'
   LET g_pk_array[2].values = g_oofi_d[l_ac].oofi002
   LET g_pk_array[2].column = 'oofi002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi392.state_change" >}
   
 
{</section>}
 
{<section id="aooi392.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi392.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 根據不同的編碼碼性質，抓取不同table，組成不同sql
# Memo...........:
# Usage..........: CALL aooi392_get_sql(p_oofg002)
# Input parameter: p_oofg002      編碼性質
#                : p_oofi002      流水號前編碼
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/02/12 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi392_get_sql(p_oofg002,p_oofi002)
DEFINE p_oofg002         LIKE oofg_t.oofg002
DEFINE r_success         LIKE type_t.num5
DEFINE p_oofi002         LIKE oofi_t.oofi002
   LET r_success = TRUE
   LET g_sql = ''
   LET g_sql1= ''
   
   CASE p_oofg002
      WHEN '1'
           CALL aooi392_get_sql1('imaa_t','imaa001')
           CALL aooi392_get_sql1('imba_t','imba001')
      WHEN '2'
           CALL aooi392_get_sql1('pmaa_t','pmaa001')
           CALL aooi392_get_sql1('pmba_t','pmba001')
      WHEN '3'
           CALL aooi392_get_sql1('faah_t','faah003')
      WHEN '4'
           CALL aooi392_get_sql1('inaa_t','inaa001')
      WHEN '5'
           CALL aooi392_get_sql1('inab_t','inab002')
      WHEN '6'
           CALL aooi392_get_sql1('inad_t','inad003')
      WHEN '7'
           CALL aooi392_get_sql1('inae_t','inae003')
      WHEN '8'
           CALL aooi392_get_sql1('inae_t','inae004')
      WHEN '9'
           CALL aooi392_get_sql1('mmaf_t','mmaf001')
      WHEN '10'
           CALL aooi392_get_sql1('mhad_t','mhad004')
      WHEN '11'
      WHEN '12'
      WHEN '13'
      WHEN '14'
           CALL aooi392_get_sql1('apca_t','apca063')
           CALL aooi392_get_sql1('xrca_t','xrca063')
           CALL aooi392_get_sql1('xmda_t','xmda009')
      WHEN '15'
           CALL aooi392_get_sql1('pjba_t','pjba001')
      WHEN '16'
           CALL aooi392_get_sql1('prba_t','prba002')
      WHEN '17'
      WHEN '18'
           CALL aooi392_get_sql1('prcb_t','prcb001')
      WHEN '19'
           CALL aooi392_get_sql1('prbl_t','prbl001')
      WHEN '20'
           CALL aooi392_get_sql1('prcf_t','prcf001')
      WHEN '21'
           CALL aooi392_get_sql1('prda_t','prda001')
      WHEN '22'
           CALL aooi392_get_sql1('stan_t','stan001')
           CALL aooi392_get_sql1('staj_t','staj001')
      WHEN '23'
           CALL aooi392_get_sql1('prda_t','prda001')
      WHEN '24'
           CALL aooi392_get_sql1('prda_t','prda001')
      WHEN '25'
           CALL aooi392_get_sql1('prda_t','prda001')
      WHEN '26'
           CALL aooi392_get_sql1('stce_t','stce001')
      WHEN '27'
           CALL aooi392_get_sql1('stdb_t','stdb001')
   END CASE
   
   IF cl_null(g_sql1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_sql = "SELECT MAX(b) FROM (",g_sql1,")",
               " WHERE b IS NOT NULL ",
               "   AND LENGTH(TRIM(TRANSLATE(b, '0123456789',' '))) IS NULL ",   #都是數字的才抓
               "   AND a = '",p_oofi002,"'",
               " GROUP BY a ",
               " ORDER BY a "
   
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 針對傳入的table及欄位去組SQL
# Memo...........:
# Usage..........: CALL aooi392_get_sql1(p_table,p_field)
#                  
# Input parameter: p_table        table代號
#                : p_field        編碼的欄位代號
# Return code....: 
# Date & Author..: 2015/02/12 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi392_get_sql1(p_table,p_field)
DEFINE p_table           LIKE dzeb_t.dzeb001
DEFINE p_field           LIKE dzeb_t.dzeb002

   IF NOT cl_null(g_sql1) THEN
      LET g_sql1 = g_sql1 CLIPPED," UNION "
   END IF
   
   LET g_sql1 = g_sql1 CLIPPED,
               " SELECT SUBSTR(",p_field,",1,",g_length,") As a,SUBSTR(",p_field,",",g_length+1,",",g_oofg009,") As b",
               "   FROM ",p_table,
               "  WHERE LENGTH(",p_field,")  = ",g_oofg003
END FUNCTION
################################################################################
# Descriptions...: 檢查該字串是否符合該編碼分類
# Memo...........:
# Usage..........: CALL aooi392_check(p_str)
#                  RETURNING r_success,r_conform
# Input parameter: p_str          編碼字串
# Return code....: r_success      TRUE/FALSE
#                : r_conform      是否符合
# Date & Author..: 2015/02/14 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi392_check(p_str)
DEFINE p_str             LIKE oofi_t.oofi002
DEFINE r_success         LIKE type_t.num5
DEFINE r_conform         LIKE type_t.num5
DEFINE l_oofg005         LIKE oofg_t.oofg005
DEFINE l_oofg006         LIKE oofg_t.oofg006
DEFINE l_oofg008         LIKE oofg_t.oofg008
DEFINE l_oofg009         LIKE oofg_t.oofg009
DEFINE l_level           LIKE type_t.num10
DEFINE l_sql             STRING
DEFINE l_sql_oofg005     STRING
DEFINE l_length          LIKE type_t.num10
DEFINE l_str             LIKE oofi_t.oofi002

   LET r_success = TRUE
   LET r_conform = TRUE
   LET l_length = g_length
   
   LET l_oofg006 = ''
   LET l_sql_oofg005 = " SELECT oofg005,oofg006 ",
                       "   FROM oofg_t ",
                       "  WHERE oofgent = ",g_enterprise,
                       "    AND oofg001 = '",g_oofi_d[l_ac].oofi001,"'",
                       "    AND oofg008 = '9'"
   PREPARE aooi392_oofg005_pre FROM l_sql_oofg005
   DECLARE aooi392_oofg005_cs CURSOR FOR aooi392_oofg005_pre
   FOREACH aooi392_oofg005_cs INTO g_oofg005_num,g_oofg006
      LET l_length = g_length
      LET l_sql = "  SELECT LEVEL,oofg005,oofg006,oofg008,oofg009 FROM  (SELECT oofg001,oofg005,oofg006,oofg008,oofg009 ",
                  "                                FROM oofg_t ",
                  "                                WHERE oofgent = '",g_enterprise,"' ",
                  "                                  AND oofg001 = '",g_oofi_d[l_ac].oofi001,"' ",
                  "                                  AND oofg005 <> '",g_oofg005,"' ",
                  "                                  AND oofg005 <> oofg006 ) ",
                  "   START WITH oofg005 = '",g_oofg006,"' ",
                  " CONNECT BY PRIOR oofg006 = oofg005 ",
                  " ORDER BY LEVEL"
      PREPARE aooi392_check_pre FROM l_sql
      DECLARE aooi392_check_cs CURSOR FOR aooi392_check_pre
      FOREACH aooi392_check_cs INTO l_level,l_oofg005,l_oofg006,l_oofg008,l_oofg009
         
         IF l_oofg008 = '10' THEN   #純分類
            CONTINUE FOREACH
         END IF 
         
         #檢查該段是否符合該編號
         LET l_str = p_str[l_length-l_oofg009+1,l_length]
         CALL aooi392_check1(l_str,l_oofg008,l_oofg005) 
              RETURNING r_success,r_conform
         IF NOT r_success OR NOT r_conform THEN
            EXIT FOREACH
         END IF
         
         LET l_length = l_length - l_oofg009
      END FOREACH
      IF r_success AND r_conform THEN
         EXIT FOREACH
      END IF
   END FOREACH
   IF NOT r_success OR NOT r_conform OR l_length <= 0 THEN
      RETURN r_success,r_conform
   END IF
      
   #上面sql抓不到第一層，故處理第一層資料
   LET l_oofg005 = ''
   LET l_oofg008 = ''
   LET l_oofg009 = ''
   SELECT oofg005,oofg008,oofg009 INTO l_oofg005,l_oofg008,l_oofg009
     FROM oofg_t
    WHERE oofgent = g_enterprise
      AND oofg001 = g_oofi_d[l_ac].oofi001
      AND oofg005 = l_oofg006
   IF l_oofg008 <> '10' THEN   #非純分類
      #檢查該段是否符合該編號
      LET l_str = p_str[l_length-l_oofg009+1,l_length]
      CALL aooi392_check1(l_str,l_oofg008,l_oofg005) 
           RETURNING r_success,r_conform
      IF NOT r_success OR NOT r_conform THEN
         RETURN r_success,r_conform
      END IF
   END IF
   RETURN r_success,r_conform
END FUNCTION
################################################################################
# Descriptions...: 該字段是否符合該段編碼
# Memo...........:
# Usage..........: CALL aooi392_check1(p_str,p_oofg008,p_oofg005)
#                  RETURNING r_success,r_conform
# Input parameter: p_str          檢查字段
#                : p_oofg008      節點型態
#                : p_oofg005      節點編號
# Return code....: r_success      TRUE/FALSE
#                : r_conform      符合否
# Date & Author..: 2015/02/14 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi392_check1(p_str,p_oofg008,p_oofg005)
DEFINE p_str             LIKE oofi_t.oofi002
DEFINE p_oofg008         LIKE oofg_t.oofg008
DEFINE p_oofg005         LIKE oofg_t.oofg005
DEFINE r_success         LIKE type_t.num5
DEFINE r_conform         LIKE type_t.num5
DEFINE l_oofg009         LIKE oofg_t.oofg009
DEFINE l_oofg010         LIKE oofg_t.oofg010
DEFINE l_oofg011         LIKE oofg_t.oofg011
DEFINE l_oofg012         LIKE oofg_t.oofg012
DEFINE l_oofg013         LIKE oofg_t.oofg013
DEFINE l_oofg014         LIKE oofg_t.oofg014
DEFINE l_oofg015         LIKE oofg_t.oofg015
DEFINE l_value           LIKE type_t.chr80
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_num             LIKE type_t.num10

   LET r_success = TRUE
   LET r_conform = TRUE
   
   LET l_oofg010 = ''
   LET l_oofg011 = ''
   LET l_oofg012 = ''
   LET l_oofg013 = ''
   SELECT oofg009,oofg010,oofg011,oofg012,oofg013,oofg014,oofg015
     INTO l_oofg009,l_oofg010,l_oofg011,l_oofg012,l_oofg013,l_oofg014,l_oofg015
     FROM oofg_t
    WHERE oofgent = g_enterprise
      AND oofg001 = g_oofi_d[l_ac].oofi001
      AND oofg005 = p_oofg005
   IF cl_null(l_oofg014) THEN LET l_oofg014 = 1 END IF
   IF cl_null(l_oofg015) THEN LET l_oofg015 = l_oofg009 END IF
   
   CASE p_oofg008
      WHEN '0'   #固定值
           IF p_str <> l_oofg010 THEN
              LET r_conform = FALSE
              RETURN r_success,r_conform
           END IF
      WHEN '1'   #數值
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
           IF l_num < l_oofg011 OR l_num > l_oofg012 THEN
              LET r_conform = FALSE
              RETURN r_success,r_conform
           END IF
      WHEN '2'   #欄位值
           PREPARE aooi392_oofg013_pre FROM l_oofg013
           DECLARE aooi392_oofg013_cs CURSOR FOR aooi392_oofg013_pre
           LET r_conform = FALSE
           FOREACH aooi392_oofg013_cs INTO l_value
              IF NOT cl_null(l_value) AND Length(l_value) >= l_oofg015 THEN
                 LET l_value = l_value[l_oofg014,l_oofg015]
                 
                 IF l_value = p_str THEN
                    LET r_conform = TRUE
                    EXIT FOREACH
                 END IF
              END IF
           END FOREACH
      WHEN '3'   #可選項
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt 
             FROM oofh_t
            WHERE oofhent = g_enterprise
              AND oofh001 = g_oofi_d[l_ac].oofi001
              AND oofh002 = p_oofg005
              AND oofh003 = p_str
           IF cl_null(l_cnt) OR l_cnt = 0 THEN
              LET r_conform = FALSE
           END IF
      WHEN '4'   #年
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
      WHEN '5'   #月
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
           IF l_num < 1 OR l_num > 12 THEN
              LET r_conform = FALSE
           END IF
      WHEN '6'   #期
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
           IF l_num < 1 OR l_num > 13 THEN
              LET r_conform = FALSE
           END IF
      WHEN '7'   #週
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
           IF l_num < 1 OR l_num > 53 THEN
              LET r_conform = FALSE
           END IF
      WHEN '8'   #日
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
           IF l_num < 1 OR l_num > 31 THEN
              LET r_conform = FALSE
           END IF
      WHEN '9'   #流水號
           #先判斷是否為數值
           CALL aooi392_chk_num(p_str) RETURNING r_success,r_conform,l_num
           IF NOT r_success OR NOT r_conform THEN
              RETURN r_success,r_conform
           END IF
   END CASE
   
   RETURN r_success,r_conform
END FUNCTION
################################################################################
# Descriptions...: 判斷該字串是否為數字
# Memo...........:
# Usage..........: CALL aooi392_chk_num(p_str)
#                  RETURNING r_success,r_conform
# Input parameter: p_str          字串
# Return code....: r_success      TRUE/FALSE
#                : r_conform      數字否
#                : r_num          數字
# Date & Author..: 2015/02/14 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi392_chk_num(p_str)
DEFINE p_str             LIKE oofi_t.oofi002
DEFINE r_success         LIKE type_t.num5
DEFINE r_conform         LIKE type_t.num5
DEFINE r_num             LIKE type_t.num10
DEFINE l_str             LIKE type_t.chr80

   LET r_success = TRUE
   LET r_conform = TRUE
   LET r_num = ''
   
   SELECT TRIM(TRANSLATE(p_str,'0123456789',' ')) INTO l_str
     FROM dual
   IF l_str IS NULL THEN
      LET r_conform = TRUE
      LET r_num = p_str
   ELSE
      LET r_conform = FALSE
   END IF
   
   RETURN r_success,r_conform,r_num
END FUNCTION

 
{</section>}
 
