#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi330.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-08-08 16:34:16), PR版次:0002(2016-09-05 14:52:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000016
#+ Filename...: abgi330
#+ Description: 模擬收入項目計價因子設置
#+ Creator....: 08732(2016-08-05 09:06:26)
#+ Modifier...: 08732 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi330.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00002#2   2016/09/05   Hans  修改sql未加ent
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
PRIVATE TYPE type_g_bgcc_d RECORD
       bgcc001 LIKE bgcc_t.bgcc001, 
   bgcc001_desc LIKE type_t.chr500, 
   bgccstus LIKE bgcc_t.bgccstus, 
   bgccownid LIKE bgcc_t.bgccownid, 
   bgccownid_desc LIKE type_t.chr500, 
   bgccowndp LIKE bgcc_t.bgccowndp, 
   bgccowndp_desc LIKE type_t.chr500, 
   bgcccrtid LIKE bgcc_t.bgcccrtid, 
   bgcccrtid_desc LIKE type_t.chr500, 
   bgcccrtdp LIKE bgcc_t.bgcccrtdp, 
   bgcccrtdp_desc LIKE type_t.chr500, 
   bgcccrtdt DATETIME YEAR TO SECOND, 
   bgccmodid LIKE bgcc_t.bgccmodid, 
   bgccmodid_desc LIKE type_t.chr500, 
   bgccmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      bgccl001 LIKE bgccl_t.bgccl001,
      bgccl002 LIKE bgccl_t.bgccl002,
      bgcc001_desc LIKE bgccl_t.bgccl003
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_bgcc2_d RECORD
   bgcd001 LIKE bgcd_t.bgcd001, 
   bgcd001_desc LIKE type_t.chr500, 
   bgcdstus LIKE bgcd_t.bgcdstus, 
   bgcdownid LIKE bgcd_t.bgcdownid, 
   bgcdownid_desc LIKE type_t.chr500, 
   bgcdowndp LIKE bgcd_t.bgcdowndp, 
   bgcdowndp_desc LIKE type_t.chr500, 
   bgcdcrtid LIKE bgcd_t.bgcdcrtid, 
   bgcdcrtid_desc LIKE type_t.chr500, 
   bgcdcrtdp LIKE bgcd_t.bgcdcrtdp, 
   bgcdcrtdp_desc LIKE type_t.chr500, 
   bgcdcrtdt DATETIME YEAR TO SECOND, 
   bgcdmodid LIKE bgcd_t.bgcdmodid, 
   bgcdmodid_desc LIKE type_t.chr500, 
   bgcdmoddt DATETIME YEAR TO SECOND
   END RECORD
   
   
DEFINE g_detail2_multi_table_t    RECORD
    bgcdl001 LIKE bgcdl_t.bgcdl001,
    bgcdl002 LIKE bgcdl_t.bgcdl002,
    bgcd001_desc LIKE bgcdl_t.bgcdl003
    END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_bgcc_d          DYNAMIC ARRAY OF type_g_bgcc_d #單身變數
DEFINE g_bgcc_d_t        type_g_bgcc_d                  #單身備份
DEFINE g_bgcc_d_o        type_g_bgcc_d                  #單身備份
DEFINE g_bgcc_d_mask_o   DYNAMIC ARRAY OF type_g_bgcc_d #單身變數
DEFINE g_bgcc_d_mask_n   DYNAMIC ARRAY OF type_g_bgcc_d #單身變數
 
      
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
DEFINE g_bgcc2_d          DYNAMIC ARRAY OF type_g_bgcc2_d #單身變數
DEFINE g_bgcc2_d_t        type_g_bgcc2_d                  #單身備份
DEFINE g_bgcc2_d_o        type_g_bgcc2_d                  #單身備份
DEFINE g_bgcc2_d_mask_o   DYNAMIC ARRAY OF type_g_bgcc2_d #單身變數
DEFINE g_bgcc2_d_mask_n   DYNAMIC ARRAY OF type_g_bgcc2_d #單身變數
 
      
DEFINE g_wc3                STRING #組g_bgcc2_d查詢條件
DEFINE g_sql2               STRING 
DEFINE g_forupd_sql2        STRING
DEFINE g_temp2_idx          LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail2_idx        LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail2_cnt        LIKE type_t.num10             #單身 總筆數(所有資料)
#end add-point
 
{</section>}
 
{<section id="abgi330.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT bgcc001,bgccstus,bgccownid,bgccowndp,bgcccrtid,bgcccrtdp,bgcccrtdt,bgccmodid, 
       bgccmoddt FROM bgcc_t WHERE bgccent=? AND bgcc001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   LET g_forupd_sql2 = "SELECT bgcd001,bgcdstus,bgcdownid,bgcdowndp,bgcdcrtid,bgcdcrtdp,bgcdcrtdt,bgcdmodid, 
       bgcdmoddt FROM bgcd_t WHERE bgcdent=? AND bgcd001=? FOR UPDATE"
       
   LET g_forupd_sql2 = cl_sql_forupd(g_forupd_sql2)
   LET g_forupd_sql2 = cl_sql_add_mask(g_forupd_sql2)              #遮蔽特定資料
   DECLARE abgi330_bcl2 CURSOR FROM g_forupd_sql2
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi330_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgi330 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgi330_init()   
 
      #進入選單 Menu (="N")
      CALL abgi330_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgi330
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgi330.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abgi330_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL abgi330_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION abgi330_ui_dialog()
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
   LET g_detail2_idx = 1
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_bgcc_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL abgi330_init()
      END IF
   
      CALL abgi330_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bgcc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               LET g_aw = 's_detail1'
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
               LET g_data_owner = g_bgcc_d[g_detail_idx].bgccownid   #(ver:35)
               LET g_data_dept = g_bgcc_d[g_detail_idx].bgccowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL abgi330_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   LET g_detail_cnt = g_bgcc_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_bgcc2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt) 
            BEFORE DISPLAY 
               #讓各頁籤能夠同步指到特定資料
               LET g_aw = 's_detail2'
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
            
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail2_idx
               LET g_temp2_idx = l_ac
               DISPLAY g_detail2_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
               CALL abgi330_set_pk_array()
               
               CALL cl_user_overview_set_follow_pic()
               
               LET g_detail2_cnt = g_bgcc2_d.getLength()
               DISPLAY g_detail2_cnt TO FORMONLY.cnt
         
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
            IF g_temp2_idx > 0 THEN
               LET l_ac = g_temp2_idx
               CALL DIALOG.setCurrentRow("s_detail2",l_ac)
               LET g_temp2_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            
            
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL abgi330_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL abgi330_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL abgi330_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL abgi330_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL abgi330_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL abgi330_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgi330_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgi330_query()
               #add-point:ON ACTION query name="menu.query"
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bgcc_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_bgcc2_d)
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
            CALL abgi330_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgi330_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgi330_set_pk_array()
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
 
{<section id="abgi330.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgi330_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE ls_wc2      LIKE type_t.chr500
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_bgcc_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON bgcc001,bgcc001_desc,bgccstus,bgccownid,bgccowndp,bgcccrtid,bgcccrtdp,bgcccrtdt, 
          bgccmodid,bgccmoddt 
 
         FROM s_detail1[1].bgcc001,s_detail1[1].bgcc001_desc,s_detail1[1].bgccstus,s_detail1[1].bgccownid, 
             s_detail1[1].bgccowndp,s_detail1[1].bgcccrtid,s_detail1[1].bgcccrtdp,s_detail1[1].bgcccrtdt, 
             s_detail1[1].bgccmodid,s_detail1[1].bgccmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgcccrtdt>>----
         AFTER FIELD bgcccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgccmoddt>>----
         AFTER FIELD bgccmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgcccnfdt>>----
         
         #----<<bgccpstdt>>----
 
 
 
      
                  #Ctrlp:construct.c.page1.bgcc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcc001
            #add-point:ON ACTION controlp INFIELD bgcc001 name="construct.c.page1.bgcc001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgcc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcc001  #顯示到畫面上
            NEXT FIELD bgcc001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcc001
            #add-point:BEFORE FIELD bgcc001 name="query.b.page1.bgcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcc001
            
            #add-point:AFTER FIELD bgcc001 name="query.a.page1.bgcc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcc001_desc
            #add-point:BEFORE FIELD bgcc001_desc name="query.b.page1.bgcc001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcc001_desc
            
            #add-point:AFTER FIELD bgcc001_desc name="query.a.page1.bgcc001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgcc001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcc001_desc
            #add-point:ON ACTION controlp INFIELD bgcc001_desc name="query.c.page1.bgcc001_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgccstus
            #add-point:BEFORE FIELD bgccstus name="query.b.page1.bgccstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgccstus
            
            #add-point:AFTER FIELD bgccstus name="query.a.page1.bgccstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgccstus
            #add-point:ON ACTION controlp INFIELD bgccstus name="query.c.page1.bgccstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgccownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgccownid
            #add-point:ON ACTION controlp INFIELD bgccownid name="construct.c.page1.bgccownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgccownid  #顯示到畫面上
            NEXT FIELD bgccownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgccownid
            #add-point:BEFORE FIELD bgccownid name="query.b.page1.bgccownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgccownid
            
            #add-point:AFTER FIELD bgccownid name="query.a.page1.bgccownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgccowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgccowndp
            #add-point:ON ACTION controlp INFIELD bgccowndp name="construct.c.page1.bgccowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgccowndp  #顯示到畫面上
            NEXT FIELD bgccowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgccowndp
            #add-point:BEFORE FIELD bgccowndp name="query.b.page1.bgccowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgccowndp
            
            #add-point:AFTER FIELD bgccowndp name="query.a.page1.bgccowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcccrtid
            #add-point:ON ACTION controlp INFIELD bgcccrtid name="construct.c.page1.bgcccrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcccrtid  #顯示到畫面上
            NEXT FIELD bgcccrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcccrtid
            #add-point:BEFORE FIELD bgcccrtid name="query.b.page1.bgcccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcccrtid
            
            #add-point:AFTER FIELD bgcccrtid name="query.a.page1.bgcccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgcccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcccrtdp
            #add-point:ON ACTION controlp INFIELD bgcccrtdp name="construct.c.page1.bgcccrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcccrtdp  #顯示到畫面上
            NEXT FIELD bgcccrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcccrtdp
            #add-point:BEFORE FIELD bgcccrtdp name="query.b.page1.bgcccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcccrtdp
            
            #add-point:AFTER FIELD bgcccrtdp name="query.a.page1.bgcccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcccrtdt
            #add-point:BEFORE FIELD bgcccrtdt name="query.b.page1.bgcccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgccmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgccmodid
            #add-point:ON ACTION controlp INFIELD bgccmodid name="construct.c.page1.bgccmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgccmodid  #顯示到畫面上
            NEXT FIELD bgccmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgccmodid
            #add-point:BEFORE FIELD bgccmodid name="query.b.page1.bgccmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgccmodid
            
            #add-point:AFTER FIELD bgccmodid name="query.a.page1.bgccmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgccmoddt
            #add-point:BEFORE FIELD bgccmoddt name="query.b.page1.bgccmoddt"
            
            #END add-point
 
 
  
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      #CALL g_bgcc2_d.clear()
      
      #wc備份
      #LET ls_wc2 = g_wc3
      CONSTRUCT g_wc3 ON bgcd001,bgcd001_desc,bgcdstus,bgcdownid,bgcdowndp,bgcdcrtid,bgcdcrtdp,bgcdcrtdt, 
          bgcdmodid,bgcdmoddt 
 
         FROM s_detail2[1].bgcd001,s_detail2[1].bgcd001_desc,s_detail2[1].bgcdstus,s_detail2[1].bgcdownid, 
             s_detail2[1].bgcdowndp,s_detail2[1].bgcdcrtid,s_detail2[1].bgcdcrtdp,s_detail2[1].bgcdcrtdt, 
             s_detail2[1].bgcdmodid,s_detail2[1].bgcdmoddt 
      
         #共用欄位查詢處理  
         ##----<<bgcccrtdt>>----
         AFTER FIELD bgcdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgccmoddt>>----
         AFTER FIELD bgcdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgcccnfdt>>----
         
         #----<<bgccpstdt>>----
 

         ON ACTION controlp INFIELD bgcd001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgcd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcd001  #顯示到畫面上
            NEXT FIELD bgcd001                     #返回原欄位
    

         BEFORE FIELD bgcd001


         AFTER FIELD bgcd001
            

         BEFORE FIELD bgcd001_desc


         AFTER FIELD bgcd001_desc
            


         ON ACTION controlp INFIELD bgcd001_desc


         BEFORE FIELD bgcdstus


         AFTER FIELD bgcdstus
            


         ON ACTION controlp INFIELD bgcdstus


         ON ACTION controlp INFIELD bgcdownid

            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcdownid  #顯示到畫面上
            NEXT FIELD bgcdownid                     #返回原欄位
    

         BEFORE FIELD bgcdownid


         AFTER FIELD bgcdownid
            


         ON ACTION controlp INFIELD bgcdowndp
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcdowndp  #顯示到畫面上
            NEXT FIELD bgcdowndp                     #返回原欄位
    

         BEFORE FIELD bgcdowndp


         AFTER FIELD bgcdowndp
            


         ON ACTION controlp INFIELD bgcdcrtid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcdcrtid  #顯示到畫面上
            NEXT FIELD bgcdcrtid                     #返回原欄位
    

         BEFORE FIELD bgcdcrtid


         AFTER FIELD bgcdcrtid
            


         ON ACTION controlp INFIELD bgcdcrtdp
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcdcrtdp  #顯示到畫面上
            NEXT FIELD bgcdcrtdp                     #返回原欄位



         BEFORE FIELD bgcdcrtdp


         AFTER FIELD bgcdcrtdp
            


         BEFORE FIELD bgcdcrtdt



         ON ACTION controlp INFIELD bgcdmodid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcdmodid  #顯示到畫面上
            NEXT FIELD bgcdmodid                     #返回原欄位
    

         BEFORE FIELD bgcdmodid


         AFTER FIELD bgcdmodid
            

         BEFORE FIELD bgcdmoddt
 
 
      
         BEFORE CONSTRUCT

      
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
   LET g_wc2 = cl_replace_str(g_wc2,'bgcc001_desc','bgccl003')
   LET g_wc3 = cl_replace_str(g_wc3,'bgcd001_desc','bgcdl003')
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc3 = ls_wc
      LET g_wc3 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail2_idx = 1
   END IF
    
   CALL abgi330_b_fill(g_wc3)
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
    
   CALL abgi330_b_fill(g_wc2)
   LET g_data_owner = g_bgcc_d[g_detail_idx].bgccownid   #(ver:35)
   LET g_data_dept = g_bgcc_d[g_detail_idx].bgccowndp   #(ver:35)
 
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
 
{<section id="abgi330.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgi330_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL abgi330_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgi330.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgi330_modify()
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
   DEFINE  l_idx                  LIKE type_t.num10
   DEFINE  l_times                LIKE type_t.num10
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
      INPUT ARRAY g_bgcc_d FROM s_detail1.*
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
               IF  NOT cl_null(g_bgcc_d[l_ac].bgcc001)  THEN
                  CALL n_bgccl(g_bgcc_d[l_ac].bgcc001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_bgcc_d[l_ac].bgcc001
                  CALL ap_ref_array2(g_ref_fields," SELECT bgccl003 FROM bgccl_t WHERE bgcclent = '"
                      ||g_enterprise||"' AND bgccl001 = ? AND bgccl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bgcc_d[l_ac].bgcc001_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_bgcc_d[l_ac].bgcc001_desc
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgcc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi330_b_fill(g_wc2)
            LET g_detail_cnt = g_bgcc_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            LET g_aw = 's_detail1'
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_bgcc_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_bgcc_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_bgcc_d[l_ac].bgcc001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgcc_d_t.* = g_bgcc_d[l_ac].*  #BACKUP
               LET g_bgcc_d_o.* = g_bgcc_d[l_ac].*  #BACKUP
               IF NOT abgi330_lock_b("bgcc_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi330_bcl INTO g_bgcc_d[l_ac].bgcc001,g_bgcc_d[l_ac].bgccstus,g_bgcc_d[l_ac].bgccownid, 
                      g_bgcc_d[l_ac].bgccowndp,g_bgcc_d[l_ac].bgcccrtid,g_bgcc_d[l_ac].bgcccrtdp,g_bgcc_d[l_ac].bgcccrtdt, 
                      g_bgcc_d[l_ac].bgccmodid,g_bgcc_d[l_ac].bgccmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bgcc_d_t.bgcc001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgcc_d_mask_o[l_ac].* =  g_bgcc_d[l_ac].*
                  CALL abgi330_bgcc_t_mask()
                  LET g_bgcc_d_mask_n[l_ac].* =  g_bgcc_d[l_ac].*
                  
                  CALL abgi330_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL abgi330_set_entry_b(l_cmd)
            CALL abgi330_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            LET g_detail_multi_table_t.bgccl001 = g_bgcc_d[l_ac].bgcc001
            LET g_detail_multi_table_t.bgccl002 = g_dlang
            LET g_detail_multi_table_t.bgcc001_desc = g_bgcc_d[l_ac].bgcc001_desc
            
            
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'bgcclent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'bgccl001'
            LET l_var_keys[02] = g_bgcc_d[l_ac].bgcc001
            LET l_field_keys[03] = 'bgccl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'bgccl_t') THEN
               RETURN 
            END IF 
 
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
            INITIALIZE g_bgcc_d_t.* TO NULL
            INITIALIZE g_bgcc_d_o.* TO NULL
            INITIALIZE g_bgcc_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgcc_d[l_ac].bgccownid = g_user
      LET g_bgcc_d[l_ac].bgccowndp = g_dept
      LET g_bgcc_d[l_ac].bgcccrtid = g_user
      LET g_bgcc_d[l_ac].bgcccrtdp = g_dept 
      LET g_bgcc_d[l_ac].bgcccrtdt = cl_get_current()
      LET g_bgcc_d[l_ac].bgccmodid = g_user
      LET g_bgcc_d[l_ac].bgccmoddt = cl_get_current()
      LET g_bgcc_d[l_ac].bgccstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_bgcc_d[l_ac].bgccstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_bgcc_d[l_ac].bgccownid_desc = s_desc_get_person_desc(g_user)
            LET g_bgcc_d[l_ac].bgccowndp_desc = s_desc_get_department_desc(g_dept)
            LET g_bgcc_d[l_ac].bgcccrtid_desc = s_desc_get_person_desc(g_user)
            LET g_bgcc_d[l_ac].bgcccrtdp_desc = s_desc_get_department_desc(g_dept)
            LET g_bgcc_d[l_ac].bgccmodid_desc = s_desc_get_person_desc(g_user)
            
            DISPLAY BY NAME g_bgcc_d[l_ac].bgccownid_desc, g_bgcc_d[l_ac].bgccowndp_desc, g_bgcc_d[l_ac].bgcccrtid_desc,
                            g_bgcc_d[l_ac].bgcccrtdp_desc, g_bgcc_d[l_ac].bgccmodid_desc     
            #end add-point
            LET g_bgcc_d_t.* = g_bgcc_d[l_ac].*     #新輸入資料
            LET g_bgcc_d_o.* = g_bgcc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgcc_d[li_reproduce_target].* = g_bgcc_d[li_reproduce].*
 
               LET g_bgcc_d[g_bgcc_d.getLength()].bgcc001 = NULL
 
            END IF
            
 
            CALL abgi330_set_entry_b(l_cmd)
            CALL abgi330_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_detail_multi_table_t.bgccl001 = g_bgcc_d[l_ac].bgcc001
            LET g_detail_multi_table_t.bgccl002 = g_dlang
            LET g_detail_multi_table_t.bgcc001_desc = g_bgcc_d[l_ac].bgcc001_desc
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
            SELECT COUNT(1) INTO l_count FROM bgcc_t 
             WHERE bgccent = g_enterprise AND bgcc001 = g_bgcc_d[l_ac].bgcc001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc_d[g_detail_idx].bgcc001
               CALL abgi330_insert_b('bgcc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_bgcc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgi330_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_bgcc_d[l_ac].bgcc001 = g_detail_multi_table_t.bgccl001 AND
               g_bgcc_d[l_ac].bgcc001_desc = g_detail_multi_table_t.bgcc001_desc THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'bgcclent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_bgcc_d[l_ac].bgcc001
                  LET l_field_keys[02] = 'bgccl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.bgccl001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'bgccl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.bgccl002
                  LET l_vars[01] = g_bgcc_d[l_ac].bgcc001_desc
                  LET l_fields[01] = 'bgccl003'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bgccl_t')
               END IF 
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (bgcc001 = '", g_bgcc_d[l_ac].bgcc001, "' "
 
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
               
               DELETE FROM bgcc_t
                WHERE bgccent = g_enterprise AND 
                      bgcc001 = g_bgcc_d_t.bgcc001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bgcc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'bgcclent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'bgccl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.bgccl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgccl_t')
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL abgi330_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_bgcc_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE abgi330_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_bgcc_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc_d_t.bgcc001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi330_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL abgi330_delete_b('bgcc_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgcc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcc001
            #add-point:BEFORE FIELD bgcc001 name="input.b.page1.bgcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcc001
            
            #add-point:AFTER FIELD bgcc001 name="input.a.page1.bgcc001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgcc_d[g_detail_idx].bgcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcc_d[g_detail_idx].bgcc001 != g_bgcc_d_t.bgcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcc_t WHERE "||"bgccent = '" ||g_enterprise|| "' AND "||"bgcc001 = '"||g_bgcc_d[g_detail_idx].bgcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcc001
            #add-point:ON CHANGE bgcc001 name="input.g.page1.bgcc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcc001_desc
            #add-point:BEFORE FIELD bgcc001_desc name="input.b.page1.bgcc001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcc001_desc
            
            #add-point:AFTER FIELD bgcc001_desc name="input.a.page1.bgcc001_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcc001_desc
            #add-point:ON CHANGE bgcc001_desc name="input.g.page1.bgcc001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgccstus
            #add-point:BEFORE FIELD bgccstus name="input.b.page1.bgccstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgccstus
            
            #add-point:AFTER FIELD bgccstus name="input.a.page1.bgccstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgccstus
            #add-point:ON CHANGE bgccstus name="input.g.page1.bgccstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcc001
            #add-point:ON ACTION controlp INFIELD bgcc001 name="input.c.page1.bgcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgcc001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcc001_desc
            #add-point:ON ACTION controlp INFIELD bgcc001_desc name="input.c.page1.bgcc001_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgccstus
            #add-point:ON ACTION controlp INFIELD bgccstus name="input.c.page1.bgccstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE abgi330_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_bgcc_d[l_ac].* = g_bgcc_d_t.*
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
               LET g_errparam.extend = g_bgcc_d[l_ac].bgcc001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgcc_d[l_ac].* = g_bgcc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_bgcc_d[l_ac].bgccmodid = g_user 
LET g_bgcc_d[l_ac].bgccmoddt = cl_get_current()
LET g_bgcc_d[l_ac].bgccmodid_desc = cl_get_username(g_bgcc_d[l_ac].bgccmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL abgi330_bgcc_t_mask_restore('restore_mask_o')
 
               UPDATE bgcc_t SET (bgcc001,bgccstus,bgccownid,bgccowndp,bgcccrtid,bgcccrtdp,bgcccrtdt, 
                   bgccmodid,bgccmoddt) = (g_bgcc_d[l_ac].bgcc001,g_bgcc_d[l_ac].bgccstus,g_bgcc_d[l_ac].bgccownid, 
                   g_bgcc_d[l_ac].bgccowndp,g_bgcc_d[l_ac].bgcccrtid,g_bgcc_d[l_ac].bgcccrtdp,g_bgcc_d[l_ac].bgcccrtdt, 
                   g_bgcc_d[l_ac].bgccmodid,g_bgcc_d[l_ac].bgccmoddt)
                WHERE bgccent = g_enterprise AND
                  bgcc001 = g_bgcc_d_t.bgcc001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc_d[g_detail_idx].bgcc001
               LET gs_keys_bak[1] = g_bgcc_d_t.bgcc001
               CALL abgi330_update_b('bgcc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_bgcc_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgcc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgi330_bgcc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               #資料多語言用-增/改
               IF SQLCA.sqlerrd[3] <> 0 AND  NOT SQLCA.sqlcode THEN               
                  INITIALIZE l_var_keys TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  INITIALIZE l_vars TO NULL 
                  INITIALIZE l_fields TO NULL 
                  INITIALIZE l_var_keys_bak TO NULL 
                  IF g_bgcc_d[l_ac].bgcc001 = g_detail_multi_table_t.bgccl001 AND
                  g_bgcc_d[l_ac].bgcc001_desc = g_detail_multi_table_t.bgcc001_desc THEN
                  ELSE 
                     LET l_var_keys[01] = g_enterprise
                     LET l_field_keys[01] = 'bgcclent'
                     LET l_var_keys_bak[01] = g_enterprise
                     LET l_var_keys[02] = g_bgcc_d[l_ac].bgcc001
                     LET l_field_keys[02] = 'bgccl001'
                     LET l_var_keys_bak[02] = g_detail_multi_table_t.bgccl001
                     LET l_var_keys[03] = g_dlang
                     LET l_field_keys[03] = 'bgccl002'
                     LET l_var_keys_bak[03] = g_detail_multi_table_t.bgccl002
                     LET l_vars[01] = g_bgcc_d[l_ac].bgcc001_desc
                     LET l_fields[01] = 'bgccl003'
                     CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bgccl_t')
                  END IF 
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL abgi330_unlock_b("bgcc_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgcc_d[l_ac].* = g_bgcc_d_t.*
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
               LET g_bgcc_d[li_reproduce_target].* = g_bgcc_d[li_reproduce].*
 
               LET g_bgcc_d[li_reproduce_target].bgcc001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgcc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgcc_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      INPUT ARRAY g_bgcc2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_detail2_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 

         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               IF  NOT cl_null(g_bgcc2_d[l_ac].bgcd001)  THEN
                  CALL n_bgcdl(g_bgcc2_d[l_ac].bgcd001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_bgcc2_d[l_ac].bgcd001
                  CALL ap_ref_array2(g_ref_fields," SELECT bgcdl003 FROM bgcdl_t WHERE bgcdlent = '"
                      ||g_enterprise||"' AND bgcdl001 = ? AND bgcdl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bgcc2_d[l_ac].bgcd001_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_bgcc2_d[l_ac].bgcd001_desc
               END IF
            END IF
 

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgcc2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi330_b_fill(g_wc3)
            LET g_detail2_cnt = g_bgcc2_d.getLength()
         
         BEFORE ROW
            LET g_aw = 's_detail2'
            LET l_insert = FALSE
            LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail2_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_bgcc2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail2_cnt = g_bgcc2_d.getLength()
            
            IF g_detail2_cnt >= l_ac 
               AND g_bgcc2_d[l_ac].bgcd001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgcc2_d_t.* = g_bgcc2_d[l_ac].*  #BACKUP
               LET g_bgcc2_d_o.* = g_bgcc2_d[l_ac].*  #BACKUP
               IF NOT abgi330_lock_b("bgcd_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi330_bcl2 INTO g_bgcc2_d[l_ac].bgcd001,g_bgcc2_d[l_ac].bgcdstus,g_bgcc2_d[l_ac].bgcdownid, 
                      g_bgcc2_d[l_ac].bgcdowndp,g_bgcc2_d[l_ac].bgcdcrtid,g_bgcc2_d[l_ac].bgcdcrtdp,g_bgcc2_d[l_ac].bgcdcrtdt, 
                      g_bgcc2_d[l_ac].bgcdmodid,g_bgcc2_d[l_ac].bgcdmoddt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bgcc2_d_t.bgcd001,":",SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgcc2_d_mask_o[l_ac].* =  g_bgcc2_d[l_ac].*  
                  CALL abgi330_bgcc_t_mask()
                  LET g_bgcc2_d_mask_n[l_ac].* =  g_bgcc2_d[l_ac].*
                  
                  CALL abgi330_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL abgi330_set_entry_b(l_cmd)
            CALL abgi330_set_no_entry_b(l_cmd)
            
            LET g_detail2_multi_table_t.bgcdl001 = g_bgcc2_d[l_ac].bgcd001
            LET g_detail2_multi_table_t.bgcdl002 = g_dlang
            LET g_detail2_multi_table_t.bgcd001_desc = g_bgcc2_d[l_ac].bgcd001_desc
            
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'bgcdlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'bgcdl001'
            LET l_var_keys[02] = g_bgcc2_d[l_ac].bgcd001
            LET l_field_keys[03] = 'bgcdl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'bgcdl_t') THEN
               RETURN 
            END IF 
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgcc2_d_t.* TO NULL
            INITIALIZE g_bgcc2_d_o.* TO NULL
            INITIALIZE g_bgcc2_d[l_ac].* TO NULL 
            #公用欄位給值(單身)

      #公用欄位新增給值  
      LET g_bgcc2_d[l_ac].bgcdownid = g_user
      LET g_bgcc2_d[l_ac].bgcdowndp = g_dept
      LET g_bgcc2_d[l_ac].bgcdcrtid = g_user
      LET g_bgcc2_d[l_ac].bgcdcrtdp = g_dept 
      LET g_bgcc2_d[l_ac].bgcdcrtdt = cl_get_current()
      LET g_bgcc2_d[l_ac].bgcdmodid = g_user
      LET g_bgcc2_d[l_ac].bgcdmoddt = cl_get_current()
      LET g_bgcc2_d[l_ac].bgcdstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_bgcc2_d[l_ac].bgcdstus = "Y"
            
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_bgcc2_d[l_ac].bgcdownid_desc = s_desc_get_person_desc(g_user)
            LET g_bgcc2_d[l_ac].bgcdowndp_desc = s_desc_get_department_desc(g_dept)
            LET g_bgcc2_d[l_ac].bgcdcrtid_desc = s_desc_get_person_desc(g_user)
            LET g_bgcc2_d[l_ac].bgcdcrtdp_desc = s_desc_get_department_desc(g_dept)
            LET g_bgcc2_d[l_ac].bgcdmodid_desc = s_desc_get_person_desc(g_user)
            
            DISPLAY BY NAME g_bgcc2_d[l_ac].bgcdownid_desc, g_bgcc2_d[l_ac].bgcdowndp_desc, g_bgcc2_d[l_ac].bgcdcrtid_desc,
                            g_bgcc2_d[l_ac].bgcdcrtdp_desc, g_bgcc2_d[l_ac].bgcdmodid_desc     
            #end add-point
            LET g_bgcc2_d_t.* = g_bgcc2_d[l_ac].*     #新輸入資料
            LET g_bgcc2_d_o.* = g_bgcc2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgcc2_d[li_reproduce_target].* = g_bgcc2_d[li_reproduce].*
 
               LET g_bgcc2_d[g_bgcc2_d.getLength()].bgcd001 = NULL
 
            END IF
            
 
            CALL abgi330_set_entry_b(l_cmd)
            CALL abgi330_set_no_entry_b(l_cmd)
            
  
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
            SELECT COUNT(1) INTO l_count FROM bgcd_t 
             WHERE bgcdent = g_enterprise AND bgcd001 = g_bgcc2_d[l_ac].bgcd001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 

               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc2_d[g_detail2_idx].bgcd001
               CALL abgi330_insert_b('bgcd_t',gs_keys,"'1'")
                           
            ELSE    
               INITIALIZE g_bgcc2_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgcd_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgi330_b_fill(g_wc3)
               #資料多語言用-增/改

               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_bgcc2_d[l_ac].bgcd001 = g_detail2_multi_table_t.bgcdl001 AND
               g_bgcc2_d[l_ac].bgcd001_desc = g_detail2_multi_table_t.bgcd001_desc THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'bgcdlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_bgcc2_d[l_ac].bgcd001
                  LET l_field_keys[02] = 'bgcdl001'
                  LET l_var_keys_bak[02] = g_detail2_multi_table_t.bgcdl001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'bgcdl002'
                  LET l_var_keys_bak[03] = g_detail2_multi_table_t.bgcdl002
                  LET l_vars[01] = g_bgcc2_d[l_ac].bgcd001_desc
                  LET l_fields[01] = 'bgcdl003'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bgcdl_t')
               END IF 

               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail2_cnt = g_detail2_cnt + 1
               
               LET g_wc3 = g_wc3, " OR (bgcd001 = '", g_bgcc2_d[l_ac].bgcd001, "' " ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE

               
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
               
               
               DELETE FROM bgcd_t
                WHERE bgcdent = g_enterprise AND 
                      bgcd001 = g_bgcc2_d_t.bgcd001
 
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bgcd_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail2_cnt = g_detail2_cnt-1
                  
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'bgcdlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'bgcdl001'
                  LET l_var_keys_bak[02] = g_detail2_multi_table_t.bgcdl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgcdl_t')
                  
                  #修改歷程記錄(刪除)
                  CALL abgi330_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE abgi330_bcl2

               LET l_count = g_bgcc2_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc2_d_t.bgcd001
 
      #刪除相關文件
      CALL abgi330_set_pk_array()

      CALL cl_doc_remove()  
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               CALL abgi330_delete_b('bgcd_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgcc2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF

 
         BEFORE FIELD bgcd001


         AFTER FIELD bgcd001
            

            #確認資料無重複
            IF  g_bgcc2_d[g_detail2_idx].bgcd001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgcc2_d[g_detail2_idx].bgcd001 != g_bgcc2_d_t.bgcd001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgcd_t WHERE "||"bgcdent = '" ||g_enterprise|| "' AND "||"bgcd001 = '"||g_bgcc2_d[g_detail2_idx].bgcd001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


         ON CHANGE bgcd001


         BEFORE FIELD bgcd001_desc
 
 
         AFTER FIELD bgcd001_desc
            

         ON CHANGE bgcd001_desc


         BEFORE FIELD bgcdstus


         AFTER FIELD bgcdstus
            

         ON CHANGE bgcdstus


         ON ACTION controlp INFIELD bgcd001


         ON ACTION controlp INFIELD bgcd001_desc


         ON ACTION controlp INFIELD bgcdstus


 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE abgi330_bcl2
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_bgcc2_d[l_ac].* = g_bgcc2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bgcc2_d[l_ac].bgcd001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgcc2_d[l_ac].* = g_bgcc2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_bgcc2_d[l_ac].bgcdmodid = g_user 
               LET g_bgcc2_d[l_ac].bgcdmoddt = cl_get_current()
               LET g_bgcc2_d[l_ac].bgcdmodid_desc = cl_get_username(g_bgcc2_d[l_ac].bgcdmodid)
            
               
               #將遮罩欄位還原
               CALL abgi330_bgcc_t_mask_restore('restore_mask_o')  
 
               UPDATE bgcd_t SET (bgcd001,bgcdstus,bgcdownid,bgcdowndp,bgcdcrtid,bgcdcrtdp,bgcdcrtdt, 
                   bgcdmodid,bgcdmoddt) = (g_bgcc2_d[l_ac].bgcd001,g_bgcc2_d[l_ac].bgcdstus,g_bgcc2_d[l_ac].bgcdownid, 
                   g_bgcc2_d[l_ac].bgcdowndp,g_bgcc2_d[l_ac].bgcdcrtid,g_bgcc2_d[l_ac].bgcdcrtdp,g_bgcc2_d[l_ac].bgcdcrtdt, 
                   g_bgcc2_d[l_ac].bgcdmodid,g_bgcc2_d[l_ac].bgcdmoddt)
                WHERE bgcdent = g_enterprise AND
                  bgcd001 = g_bgcc2_d_t.bgcd001 #項次   
 
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc2_d[g_detail2_idx].bgcd001
               LET gs_keys_bak[1] = g_bgcc2_d_t.bgcd001
               CALL abgi330_update_b('bgcd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     INITIALIZE l_var_keys TO NULL 
                     INITIALIZE l_field_keys TO NULL 
                     INITIALIZE l_vars TO NULL 
                     INITIALIZE l_fields TO NULL 
                     INITIALIZE l_var_keys_bak TO NULL 
                     IF g_bgcc2_d[l_ac].bgcd001 = g_detail2_multi_table_t.bgcdl001 AND
                     g_bgcc2_d[l_ac].bgcd001_desc = g_detail2_multi_table_t.bgcd001_desc THEN
                     ELSE 
                        LET l_var_keys[01] = g_enterprise
                        LET l_field_keys[01] = 'bgcdlent'
                        LET l_var_keys_bak[01] = g_enterprise
                        LET l_var_keys[02] = g_bgcc2_d[l_ac].bgcd001
                        LET l_field_keys[02] = 'bgcdl001'
                        LET l_var_keys_bak[02] = g_detail2_multi_table_t.bgcdl001
                        LET l_var_keys[03] = g_dlang
                        LET l_field_keys[03] = 'bgcdl002'
                        LET l_var_keys_bak[03] = g_detail2_multi_table_t.bgcdl002
                        LET l_vars[01] = g_bgcc2_d[l_ac].bgcd001_desc
                        LET l_fields[01] = 'bgcdl003'
                        CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bgcdl_t')
                     END IF 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_bgcc2_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgcc2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgi330_bgcc_t_mask_restore('restore_mask_n')  
               
            END IF
            
         AFTER ROW
            CALL abgi330_unlock_b("bgcd_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgcc2_d[l_ac].* = g_bgcc2_d_t.*
               END IF
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            
            
         AFTER INPUT
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgcc2_d[li_reproduce_target].* = g_bgcc2_d[li_reproduce].*
 
               LET g_bgcc2_d[li_reproduce_target].bgcd001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgcc2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgcc2_d.getLength()+1
            END IF
            
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
         IF g_temp2_idx > 0 THEN
            LET l_ac = g_temp2_idx
            CALL DIALOG.setCurrentRow("s_detail2",l_ac)
            LET g_temp2_idx = 1
         END IF
         
         CASE g_aw
            WHEN "s_detail2"
               NEXT FIELD bgcd001    
         END CASE
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD bgcc001
 
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
      IF INT_FLAG OR cl_null(g_bgcc_d[g_detail_idx].bgcc001) THEN
         CALL g_bgcc_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_bgcc_d[g_detail_idx].* = g_bgcc_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_bgcc2_d[g_detail2_idx].bgcd001) THEN
         CALL g_bgcc2_d.deleteElement(g_detail2_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_bgcc2_d[g_detail2_idx].* = g_bgcc2_d_t.*
   END IF
   
   CLOSE abgi330_bcl2
   #end add-point
 
   CLOSE abgi330_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgi330_delete()
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
   FOR li_idx = 1 TO g_bgcc_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT abgi330_lock_b("bgcc_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("bgcc_t","bgccownid") THEN
            LET g_data_owner = g_bgcc_d[g_detail_idx].bgccownid
            LET g_data_dept = g_bgcc_d[g_detail_idx].bgccowndp
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
   FOR li_idx = 1 TO g_bgcc2_d.getLength()
      LET g_detail2_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT abgi330_lock_b("bgcd_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
   END FOR
   
IF g_aw = 's_detail1' THEN
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_bgcc_d.getLength()
      IF g_bgcc_d[li_idx].bgcc001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM bgcc_t
          WHERE bgccent = g_enterprise AND 
                bgcc001 = g_bgcc_d[li_idx].bgcc001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            LET g_detail_multi_table_t.bgccl001 = g_bgcc_d[l_ac].bgcc001
            LET g_detail_multi_table_t.bgccl002 = g_dlang
            LET g_detail_multi_table_t.bgcc001_desc = g_bgcc_d[l_ac].bgcc001_desc


            INITIALIZE l_var_keys_bak TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'bgcclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_field_keys[02] = 'bgccl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.bgccl001
            CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgccl_t')
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc_d_t.bgcc001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL abgi330_delete_b('bgcc_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi330_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   CALL s_transaction_end('Y','0')
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
ELSE
   LET li_detail_tmp = g_detail2_idx
   
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_bgcc2_d.getLength()
      IF g_bgcc2_d[li_idx].bgcd001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 

         
         DELETE FROM bgcd_t
          WHERE bgcdent = g_enterprise AND 
                bgcd001 = g_bgcc2_d[li_idx].bgcd001
 
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcd_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail2_cnt = g_detail2_cnt-1
            LET l_ac = li_idx
           
                  LET g_detail2_multi_table_t.bgcdl001 = g_bgcc2_d[l_ac].bgcd001
                  LET g_detail2_multi_table_t.bgcdl002 = g_dlang
                  LET g_detail2_multi_table_t.bgcd001_desc = g_bgcc2_d[l_ac].bgcd001_desc
                   
                   
                   
                              
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'bgcdlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'bgcdl001'
                  LET l_var_keys_bak[02] = g_detail2_multi_table_t.bgcdl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgcdl_t')
            #end add-point
            LET g_detail2_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc_d_t.bgcc001           

            LET g_detail2_idx = li_idx
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgcc2_d_t.bgcd001

               CALL abgi330_delete_b('bgcd_t',gs_keys,"'1'")

      #刪除相關文件
      CALL abgi330_set_pk_array()
      CALL cl_doc_remove()  

         END IF 
      END IF 
    
   END FOR
   CALL s_transaction_end('Y','0')
  
   LET g_detail2_idx = li_detail_tmp

   LET l_ac = li_ac_t
   
   #刷新資料
   CALL abgi330_b_fill(g_wc3)
END IF
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL abgi330_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="abgi330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgi330_b_fill(p_wc2)              #BODY FILL UP
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
   LET p_wc2 = g_wc2
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.bgcc001,t0.bgccstus,t0.bgccownid,t0.bgccowndp,t0.bgcccrtid,t0.bgcccrtdp, 
       t0.bgcccrtdt,t0.bgccmodid,t0.bgccmoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM bgcc_t t0", 
 
               " LEFT JOIN bgccl_t ON bgcclent = "||g_enterprise||" AND bgcc001 = bgccl001 AND bgccl002 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bgccownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bgccowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bgcccrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bgcccrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bgccmodid  ",
 
               " WHERE t0.bgccent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("bgcc_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND bgccowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("bgcc_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND bgccownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("bgcc_t"),
                      " ORDER BY t0.bgcc001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgcc_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abgi330_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abgi330_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_bgcc_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_bgcc_d[l_ac].bgcc001,g_bgcc_d[l_ac].bgccstus,g_bgcc_d[l_ac].bgccownid, 
       g_bgcc_d[l_ac].bgccowndp,g_bgcc_d[l_ac].bgcccrtid,g_bgcc_d[l_ac].bgcccrtdp,g_bgcc_d[l_ac].bgcccrtdt, 
       g_bgcc_d[l_ac].bgccmodid,g_bgcc_d[l_ac].bgccmoddt,g_bgcc_d[l_ac].bgccownid_desc,g_bgcc_d[l_ac].bgccowndp_desc, 
       g_bgcc_d[l_ac].bgcccrtid_desc,g_bgcc_d[l_ac].bgcccrtdp_desc,g_bgcc_d[l_ac].bgccmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_aw = 's_detail1'
      #end add-point
      
      CALL abgi330_detail_show()      
 
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
   
 
   
   CALL g_bgcc_d.deleteElement(g_bgcc_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_bgcc_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_bgcc_d.getLength() THEN
      LET l_ac = g_bgcc_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgcc_d.getLength()
      LET g_bgcc_d_mask_o[l_ac].* =  g_bgcc_d[l_ac].*
      CALL abgi330_bgcc_t_mask()
      LET g_bgcc_d_mask_n[l_ac].* =  g_bgcc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_sql2 = "SELECT  DISTINCT t0.bgcd001,t0.bgcdstus,t0.bgcdownid,t0.bgcdowndp,t0.bgcdcrtid,bgcdcrtdp, 
       t0.bgcdcrtdt,t0.bgcdmodid,t0.bgcdmoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM bgcd_t t0", 

               " LEFT JOIN bgcdl_t t6 ON t6.bgcdlent = '"||g_enterprise||"' AND t0.bgcd001 = t6.bgcdl001 AND t6.bgcdl002 = '",g_dlang,"'",
               " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=bgcdownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=bgcdowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=bgcdcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=bgcdcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=bgcdmodid  ", 
               " WHERE t0.bgcdent= ?  AND  1=1 AND (", g_wc3, ") " 

   LET g_sql2 = g_sql2, cl_sql_add_filter("bgcd_t"),
                      " ORDER BY t0.bgcd001"
   

   
   #LET g_sql2 = cl_sql_add_tabid(g_sql2,"bgcd_t")            #WC重組
   LET g_sql2 = cl_sql_add_mask(g_sql2)              #遮蔽特定資料
   PREPARE abgi330_pb2 FROM g_sql2
   DECLARE b_fill_curs2 CURSOR FOR abgi330_pb2
   
   OPEN b_fill_curs2 USING g_enterprise
 
   CALL g_bgcc2_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 INTO g_bgcc2_d[l_ac].bgcd001,g_bgcc2_d[l_ac].bgcdstus,g_bgcc2_d[l_ac].bgcdownid, 
       g_bgcc2_d[l_ac].bgcdowndp,g_bgcc2_d[l_ac].bgcdcrtid,g_bgcc2_d[l_ac].bgcdcrtdp,g_bgcc2_d[l_ac].bgcdcrtdt, 
       g_bgcc2_d[l_ac].bgcdmodid,g_bgcc2_d[l_ac].bgcdmoddt,g_bgcc2_d[l_ac].bgcdownid_desc,g_bgcc2_d[l_ac].bgcdowndp_desc, 
       g_bgcc2_d[l_ac].bgcdcrtid_desc,g_bgcc2_d[l_ac].bgcdcrtdp_desc,g_bgcc2_d[l_ac].bgcdmodid_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET g_aw = 's_deatil2'
      
      CALL abgi330_detail_show()      
 
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
   
   CALL g_bgcc2_d.deleteElement(g_bgcc2_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_bgcc2_d.getLength()
 

   END FOR
   
   IF g_cnt > g_bgcc2_d.getLength() THEN
      LET l_ac = g_bgcc2_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgcc2_d.getLength()
      LET g_bgcc2_d_mask_o[l_ac].* =  g_bgcc2_d[l_ac].*
      CALL abgi330_bgcc_t_mask()
      LET g_bgcc2_d_mask_n[l_ac].* =  g_bgcc2_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt

   ERROR "" 
 
   LET g_detail2_cnt = g_bgcc2_d.getLength()
   DISPLAY g_detail2_idx TO FORMONLY.idx
   DISPLAY g_detail2_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs2
   FREE abgi330_pb
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_bgcc_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE abgi330_pb
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgi330_detail_show()
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
   IF g_aw = 's_detail1' THEN   #模擬收入項目
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_bgcc_d[l_ac].bgcc001
      CALL ap_ref_array2(g_ref_fields," SELECT bgccl003 FROM bgccl_t WHERE bgcclent = '"
          ||g_enterprise||"' AND bgccl001 = ? AND bgccl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_bgcc_d[l_ac].bgcc001_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_bgcc_d[l_ac].bgcc001_desc
   
   ELSE   #計價因子
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_bgcc2_d[l_ac].bgcd001
      CALL ap_ref_array2(g_ref_fields," SELECT bgcdl003 FROM bgcdl_t WHERE bgcdlent = '"
          ||g_enterprise||"' AND bgcdl001 = ? AND bgcdl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_bgcc2_d[l_ac].bgcd001_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_bgcc2_d[l_ac].bgcd001_desc
   END IF
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgi330.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgi330_set_entry_b(p_cmd)                                                  
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
 
{<section id="abgi330.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgi330_set_no_entry_b(p_cmd)                                               
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
 
{<section id="abgi330.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgi330_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   DEFINE li_idx2  LIKE type_t.num10
   DEFINE li_cnt2  LIKE type_t.num10
   DEFINE ls_wc2   STRING
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bgcc001 = '", g_argv[01], "' AND "
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
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc2 = ls_wc2, " bgcd001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(ls_wc2) THEN
      LET ls_wc2 = ls_wc2.subString(1,ls_wc2.getLength()-5)
      LET g_wc3 = ls_wc2
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc3 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc3) THEN
         LET g_wc3 = " 1=1"
      END IF
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abgi330.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgi330_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE ps_table2    STRING
   DEFINE ps_page2     STRING
   DEFINE ps_keys_bak2 DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group2    STRING
   DEFINE li_idx2      LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   IF g_aw = 's_detail1' THEN
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "bgcc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'bgcc_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
 
         #end add-point     
         
         DELETE FROM bgcc_t
          WHERE bgccent = g_enterprise AND
            bgcc001 = ps_keys_bak[1]
         
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
         CALL g_bgcc_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      RETURN
   ELSE  
      LET ls_group = "bgcd_t,"
      IF ls_group.getIndexOf(ps_table,1) > 0 THEN
         IF ps_table <> 'bgcd_t' THEN
         
            DELETE FROM bgcd_t
             WHERE bgcdent = g_enterprise 
               AND bgcd001 = ps_keys_bak[1]
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ":",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
            END IF
         END IF
         
         LET li_idx = g_detail2_idx
         IF ps_page <> "'1'" THEN 
            CALL g_bgcc2_d.deleteElement(li_idx) 
         END IF
      END IF
   END IF
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgi330_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE ls_group2   STRING
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
      
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "bgcc_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
     IF g_aw = 's_detail1' THEN
      #end add-point    
      INSERT INTO bgcc_t
                  (bgccent,
                   bgcc001
                   ,bgccstus,bgccownid,bgccowndp,bgcccrtid,bgcccrtdp,bgcccrtdt,bgccmodid,bgccmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_bgcc_d[l_ac].bgccstus,g_bgcc_d[l_ac].bgccownid,g_bgcc_d[l_ac].bgccowndp,g_bgcc_d[l_ac].bgcccrtid, 
                       g_bgcc_d[l_ac].bgcccrtdp,g_bgcc_d[l_ac].bgcccrtdt,g_bgcc_d[l_ac].bgccmodid,g_bgcc_d[l_ac].bgccmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
     
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
     ELSE 
         INSERT INTO bgcd_t
                        (bgcdent,
                         bgcd001
                         ,bgcdstus,bgcdownid,bgcdowndp,bgcdcrtid,bgcdcrtdp,bgcdcrtdt,bgcdmodid,bgcdmoddt) 
                  VALUES(g_enterprise,
                         ps_keys[1]
                         ,g_bgcc2_d[l_ac].bgcdstus,g_bgcc2_d[l_ac].bgcdownid,g_bgcc2_d[l_ac].bgcdowndp,g_bgcc2_d[l_ac].bgcdcrtid, 
                             g_bgcc2_d[l_ac].bgcdcrtdp,g_bgcc2_d[l_ac].bgcdcrtdt,g_bgcc2_d[l_ac].bgcdmodid,g_bgcc2_d[l_ac].bgcdmoddt)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcd_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
         END IF
     END IF
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgi330_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "bgcc_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "bgcc_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
    IF g_aw = 's_detail1' THEN
      #end add-point     
      UPDATE bgcc_t 
         SET (bgcc001
              ,bgccstus,bgccownid,bgccowndp,bgcccrtid,bgcccrtdp,bgcccrtdt,bgccmodid,bgccmoddt) 
              = 
             (ps_keys[1]
              ,g_bgcc_d[l_ac].bgccstus,g_bgcc_d[l_ac].bgccownid,g_bgcc_d[l_ac].bgccowndp,g_bgcc_d[l_ac].bgcccrtid, 
                  g_bgcc_d[l_ac].bgcccrtdp,g_bgcc_d[l_ac].bgcccrtdt,g_bgcc_d[l_ac].bgccmodid,g_bgcc_d[l_ac].bgccmoddt)  
 
         WHERE bgccent = g_enterprise AND bgcc001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
    ELSE 
      UPDATE bgcd_t 
         SET (bgcd001
              ,bgcdstus,bgcdownid,bgcdowndp,bgcdcrtid,bgcdcrtdp,bgcdcrtdt,bgcdmodid,bgcdmoddt) 
              = 
             (ps_keys[1]
              ,g_bgcc2_d[l_ac].bgcdstus,g_bgcc2_d[l_ac].bgcdownid,g_bgcc2_d[l_ac].bgcdowndp,g_bgcc2_d[l_ac].bgcdcrtid, 
                  g_bgcc2_d[l_ac].bgcdcrtdp,g_bgcc2_d[l_ac].bgcdcrtdt,g_bgcc2_d[l_ac].bgcdmodid,g_bgcc2_d[l_ac].bgcdmoddt)  

         WHERE bgcd001 = ps_keys_bak[1]
           AND bgcdent = g_enterprise          #160905-00002#2
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcd_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgcd_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
         OTHERWISE
            
      END CASE
    END IF
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgi330_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   DEFINE ls_group2 STRING
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   LET ls_group2 = "bgcd_t"
   
   IF ls_group2.getIndexOf(ps_table,1) THEN
   
      OPEN abgi330_bcl2 USING g_enterprise,
                              g_bgcc2_d[g_detail2_idx].bgcd001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgi330_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
   #end add-point
   
   #先刷新資料
   #CALL abgi330_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "bgcc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abgi330_bcl USING g_enterprise,
                                       g_bgcc_d[g_detail_idx].bgcc001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgi330_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi330.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgi330_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   DEFINE ls_group2 STRING
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE abgi330_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   LET ls_group2 = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE abgi330_bcl2
   #END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi330.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION abgi330_modify_detail_chk(ps_record)
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
         LET ls_return = "bgcc001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      WHEN "s_detail2" 
         LET ls_return = "bgcd001"
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgi330.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION abgi330_show_ownid_msg()
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
 
{<section id="abgi330.mask_functions" >}
&include "erp/abg/abgi330_mask.4gl"
 
{</section>}
 
{<section id="abgi330.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgi330_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   IF g_aw = 's_detail' THEN
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_bgcc_d[l_ac].bgcc001
   LET g_pk_array[1].column = 'bgcc001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   END IF
   IF g_aw = 's_detail2' THEN
      IF l_ac <= 0 THEN
         RETURN
      END IF   
      LET g_pk_array[1].values = g_bgcc2_d[l_ac].bgcd001
      LET g_pk_array[1].column = 'bgcd001'
   END IF
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi330.state_change" >}
   
 
{</section>}
 
{<section id="abgi330.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="abgi330.other_function" readonly="Y" >}

 
{</section>}
 
