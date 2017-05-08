#該程式未解開Section, 採用最新樣板產出!
{<section id="arti037.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-03-11 21:56:51), PR版次:0002(2016-09-06 11:34:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: arti037
#+ Description: 供應商生命週期維護作業
#+ Creator....: 06189(2015-03-11 17:52:18)
#+ Modifier...: 06189 -SD/PR- 07900
 
{</section>}
 
{<section id="arti037.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#14 2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
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
PRIVATE TYPE type_g_rtdb_d RECORD
       rtdb001 LIKE rtdb_t.rtdb001, 
   rtdb003 LIKE rtdb_t.rtdb003, 
   rtdb003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_rtdb2_d RECORD
       rtdb001 LIKE rtdb_t.rtdb001, 
   rtdb003 LIKE rtdb_t.rtdb003, 
   rtdbownid LIKE rtdb_t.rtdbownid, 
   rtdbownid_desc LIKE type_t.chr500, 
   rtdbowndp LIKE rtdb_t.rtdbowndp, 
   rtdbowndp_desc LIKE type_t.chr500, 
   rtdbcrtid LIKE rtdb_t.rtdbcrtid, 
   rtdbcrtid_desc LIKE type_t.chr500, 
   rtdbcrtdp LIKE rtdb_t.rtdbcrtdp, 
   rtdbcrtdp_desc LIKE type_t.chr500, 
   rtdbcrtdt DATETIME YEAR TO SECOND, 
   rtdbmodid LIKE rtdb_t.rtdbmodid, 
   rtdbmodid_desc LIKE type_t.chr500, 
   rtdbmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_rtdb3_d RECORD
       rtdbstus LIKE rtdb_t.rtdbstus, 
   rtdb001 LIKE rtdb_t.rtdb001, 
   rtdbl003 LIKE rtdbl_t.rtdbl003, 
   rtdbl004 LIKE rtdbl_t.rtdbl004, 
   rtdb002 LIKE rtdb_t.rtdb002,  
   rtdb003 LIKE rtdb_t.rtdb003
       END RECORD
       
DEFINE g_rtdb3_d   DYNAMIC ARRAY OF type_g_rtdb3_d
DEFINE g_rtdb3_d_t type_g_rtdb3_d
DEFINE g_rtdb3_d_o type_g_rtdb3_d     
DEFINE g_wc               STRING
DEFINE g_detail_cnt2         LIKE type_t.num10  #第一个页签资料笔数
DEFINE g_detail_idx1         LIKE type_t.num10             #單身 1所在筆數(所有資料)
DEFINE l_ac1                LIKE type_t.num5         #單身 1所在筆數(所有資料)

DEFINE g_detail_multi_table_t    RECORD
      rtdbl001 LIKE rtdbl_t.rtdbl001,
      rtdbl002 LIKE rtdbl_t.rtdbl002,
      rtdbl003 LIKE rtdbl_t.rtdbl003,
      rtdbl004 LIKE rtdbl_t.rtdbl004
      END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtdb_d          DYNAMIC ARRAY OF type_g_rtdb_d #單身變數
DEFINE g_rtdb_d_t        type_g_rtdb_d                  #單身備份
DEFINE g_rtdb_d_o        type_g_rtdb_d                  #單身備份
DEFINE g_rtdb_d_mask_o   DYNAMIC ARRAY OF type_g_rtdb_d #單身變數
DEFINE g_rtdb_d_mask_n   DYNAMIC ARRAY OF type_g_rtdb_d #單身變數
DEFINE g_rtdb2_d   DYNAMIC ARRAY OF type_g_rtdb2_d
DEFINE g_rtdb2_d_t type_g_rtdb2_d
DEFINE g_rtdb2_d_o type_g_rtdb2_d
DEFINE g_rtdb2_d_mask_o DYNAMIC ARRAY OF type_g_rtdb2_d
DEFINE g_rtdb2_d_mask_n DYNAMIC ARRAY OF type_g_rtdb2_d
 
      
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
 
{<section id="arti037.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
    LET g_forupd_sql = "SELECT  rtdbstus,rtdb001,rtdbl003,rtdbl004,rtdb002,' '
       FROM rtdb_t LEFT JOIN rtdbl_t   ON rtdbent = rtdblent AND  rtdb001 = rtdbl001  AND rtdbl002 = ? 
       WHERE rtdbent=? AND rtdb001=? AND  rtdb003 = ? FOR UPDATE" 

   #add-point:main段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti037_bcl2 CURSOR FROM g_forupd_sql
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtdb001,rtdb003,rtdb001,rtdb003,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp, 
       rtdbcrtdt,rtdbmodid,rtdbmoddt FROM rtdb_t WHERE rtdbent=? AND rtdb001=? AND rtdb003=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti037_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti037 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti037_init()   
 
      #進入選單 Menu (="N")
      CALL arti037_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti037
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti037.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION arti037_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL arti037_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="arti037.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION arti037_ui_dialog()
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
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1"
   END IF 
   CALL arti037_b_fill_2()
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtdb_d.clear()
         CALL g_rtdb2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL arti037_init()
      END IF
   
      CALL arti037_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtdb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_rtdb2_d[g_detail_idx].rtdbownid   #(ver:35)
               LET g_data_dept = g_rtdb2_d[g_detail_idx].rtdbowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti037_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
                          
               LET g_detail_cnt = g_rtdb_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL arti037_b_fill(g_wc2)
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtdb2_d TO s_detail2.*
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
   CALL arti037_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               LET g_detail_cnt = g_rtdb2_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL arti037_b_fill(g_wc2)
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_rtdb3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display 
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx1)
               #add-point:ui_dialog段before display2

               #end add-point
               
            BEFORE ROW
               LET g_detail_idx1 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac1 = g_detail_idx1
               LET g_temp_idx = l_ac1
               DISPLAY g_detail_idx1 TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:2)
            CALL arti037_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview_set_follow_pic()
  
 
 
               #add-point:display array-before row
               LET g_detail_cnt = g_rtdb3_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL arti037_b_fill(g_wc2)
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
            IF cl_null(g_rtdb3_d[1].rtdb001) THEN  
               CALL g_rtdb3_d.deleteElement(g_detail_idx1)
            END IF    
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL arti037_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti037_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL arti037_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti037_modify()
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
               CALL arti037_query()
               #add-point:ON ACTION query name="menu.query"
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtdb_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtdb2_d)
               LET g_export_id[2]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[3] = base.typeInfo.create(g_rtdb3_d)
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
            CALL arti037_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti037_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti037_set_pk_array()
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
 
{<section id="arti037.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti037_query()
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
   CALL g_rtdb_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON rtdb001,rtdb003,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt,rtdbmodid, 
          rtdbmoddt 
 
         FROM s_detail1[1].rtdb001,s_detail1[1].rtdb003,s_detail2[1].rtdbownid,s_detail2[1].rtdbowndp, 
             s_detail2[1].rtdbcrtid,s_detail2[1].rtdbcrtdp,s_detail2[1].rtdbcrtdt,s_detail2[1].rtdbmodid, 
             s_detail2[1].rtdbmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdbcrtdt>>----
         AFTER FIELD rtdbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdbmoddt>>----
         AFTER FIELD rtdbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdbcnfdt>>----
         
         #----<<rtdbpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdb001
            #add-point:BEFORE FIELD rtdb001 name="query.b.page1.rtdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdb001
            
            #add-point:AFTER FIELD rtdb001 name="query.a.page1.rtdb001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdb001
            #add-point:ON ACTION controlp INFIELD rtdb001 name="query.c.page1.rtdb001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdb003
            #add-point:ON ACTION controlp INFIELD rtdb003 name="construct.c.page1.rtdb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '6766'
            CALL q_gzcb002_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdb003  #顯示到畫面上
            NEXT FIELD rtdb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdb003
            #add-point:BEFORE FIELD rtdb003 name="query.b.page1.rtdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdb003
            
            #add-point:AFTER FIELD rtdb003 name="query.a.page1.rtdb003"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page2.rtdbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdbownid
            #add-point:ON ACTION controlp INFIELD rtdbownid name="construct.c.page2.rtdbownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdbownid  #顯示到畫面上
            NEXT FIELD rtdbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbownid
            #add-point:BEFORE FIELD rtdbownid name="query.b.page2.rtdbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdbownid
            
            #add-point:AFTER FIELD rtdbownid name="query.a.page2.rtdbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdbowndp
            #add-point:ON ACTION controlp INFIELD rtdbowndp name="construct.c.page2.rtdbowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdbowndp  #顯示到畫面上
            NEXT FIELD rtdbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbowndp
            #add-point:BEFORE FIELD rtdbowndp name="query.b.page2.rtdbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdbowndp
            
            #add-point:AFTER FIELD rtdbowndp name="query.a.page2.rtdbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdbcrtid
            #add-point:ON ACTION controlp INFIELD rtdbcrtid name="construct.c.page2.rtdbcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdbcrtid  #顯示到畫面上
            NEXT FIELD rtdbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbcrtid
            #add-point:BEFORE FIELD rtdbcrtid name="query.b.page2.rtdbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdbcrtid
            
            #add-point:AFTER FIELD rtdbcrtid name="query.a.page2.rtdbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdbcrtdp
            #add-point:ON ACTION controlp INFIELD rtdbcrtdp name="construct.c.page2.rtdbcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdbcrtdp  #顯示到畫面上
            NEXT FIELD rtdbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbcrtdp
            #add-point:BEFORE FIELD rtdbcrtdp name="query.b.page2.rtdbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdbcrtdp
            
            #add-point:AFTER FIELD rtdbcrtdp name="query.a.page2.rtdbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbcrtdt
            #add-point:BEFORE FIELD rtdbcrtdt name="query.b.page2.rtdbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtdbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdbmodid
            #add-point:ON ACTION controlp INFIELD rtdbmodid name="construct.c.page2.rtdbmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdbmodid  #顯示到畫面上
            NEXT FIELD rtdbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbmodid
            #add-point:BEFORE FIELD rtdbmodid name="query.b.page2.rtdbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdbmodid
            
            #add-point:AFTER FIELD rtdbmodid name="query.a.page2.rtdbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdbmoddt
            #add-point:BEFORE FIELD rtdbmoddt name="query.b.page2.rtdbmoddt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc ON rtdbstus,rtdb001,rtdb002,rtdb0032
         
 
         FROM s_detail3[1].rtdbstus,s_detail3[1].rtdb001,
         s_detail3[1].rtdb002,s_detail3[1].rtdb0032
   
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdbstus
            #add-point:BEFORE FIELD rtdbstus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdbstus
            
            #add-point:AFTER FIELD rtdbstus

            #END add-point
            
 
         #Ctrlp:query.c.page1.rtdbstus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdbstus
            #add-point:ON ACTION controlp INFIELD rtdbstus

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdb001
            #add-point:BEFORE FIELD rtdb003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdb001
            
            #add-point:AFTER FIELD rtdb003

            #END add-point
            
 
         #Ctrlp:query.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdb001
            #add-point:ON ACTION controlp INFIELD rtdb001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtdb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdb001  #顯示到畫面上
            NEXT FIELD rtdb001  
            #END add-point
 
  
         
                
 
      
            
 
         #Ctrlp:construct.c.page2.rtdbcrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdb002
            #add-point:ON ACTION controlp INFIELD rtdb002
            #應用 a08 樣板自動產生(Version:2)
         
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdb002
            #add-point:BEFORE FIELD rtdb002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdb002
            
            #add-point:AFTER FIELD rtdb002

            #END add-point
            
               
            
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdb0032
            #add-point:ON ACTION controlp INFIELD rtdb003
     
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdb0032
            #add-point:BEFORE FIELD rtdb003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdb0032
            
            #add-point:AFTER FIELD rtdb003

            #END add-point
 
      
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
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   ELSE
      LET g_error_show = 1
      LET g_detail_idx1 = 1
   END IF
    
   CALL arti037_b_fill_2()
   
   IF g_detail_cnt = 0 AND g_detail_cnt2 = 0 AND   NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   RETURN 
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
    
   CALL arti037_b_fill(g_wc2)
   LET g_data_owner = g_rtdb2_d[g_detail_idx].rtdbownid   #(ver:35)
   LET g_data_dept = g_rtdb2_d[g_detail_idx].rtdbowndp   #(ver:35)
 
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
 
{<section id="arti037.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti037_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL arti037_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti037.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti037_modify()
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
   DEFINE  l_rtdb002              LIKE rtdb_t.rtdb002
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
      INPUT ARRAY g_rtdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL arti037_b_fill(g_wc2)
            LET g_detail_cnt = g_rtdb_d.getLength()
         
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
            DISPLAY g_rtdb_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtdb_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtdb_d[l_ac].rtdb001 IS NOT NULL
               AND g_rtdb_d[l_ac].rtdb003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtdb_d_t.* = g_rtdb_d[l_ac].*  #BACKUP
               LET g_rtdb_d_o.* = g_rtdb_d[l_ac].*  #BACKUP
               IF NOT arti037_lock_b("rtdb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti037_bcl INTO g_rtdb_d[l_ac].rtdb001,g_rtdb_d[l_ac].rtdb003,g_rtdb2_d[l_ac].rtdb001, 
                      g_rtdb2_d[l_ac].rtdb003,g_rtdb2_d[l_ac].rtdbownid,g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid, 
                      g_rtdb2_d[l_ac].rtdbcrtdp,g_rtdb2_d[l_ac].rtdbcrtdt,g_rtdb2_d[l_ac].rtdbmodid, 
                      g_rtdb2_d[l_ac].rtdbmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtdb_d_t.rtdb001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtdb_d_mask_o[l_ac].* =  g_rtdb_d[l_ac].*
                  CALL arti037_rtdb_t_mask()
                  LET g_rtdb_d_mask_n[l_ac].* =  g_rtdb_d[l_ac].*
                  
                  CALL arti037_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti037_set_entry_b(l_cmd)
            CALL arti037_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
#            CALL arti037_set_entry_b(l_cmd)
#            CALL arti037_set_no_entry_b(l_cmd)
#            CALL arti037_b_fill(g_wc2)
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
            INITIALIZE g_rtdb_d_t.* TO NULL
            INITIALIZE g_rtdb_d_o.* TO NULL
            INITIALIZE g_rtdb_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtdb2_d[l_ac].rtdbownid = g_user
      LET g_rtdb2_d[l_ac].rtdbowndp = g_dept
      LET g_rtdb2_d[l_ac].rtdbcrtid = g_user
      LET g_rtdb2_d[l_ac].rtdbcrtdp = g_dept 
      LET g_rtdb2_d[l_ac].rtdbcrtdt = cl_get_current()
      LET g_rtdb2_d[l_ac].rtdbmodid = g_user
      LET g_rtdb2_d[l_ac].rtdbmoddt = cl_get_current()
 
 
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body.before_bak"
           
            #end add-point
            LET g_rtdb_d_t.* = g_rtdb_d[l_ac].*     #新輸入資料
            LET g_rtdb_d_o.* = g_rtdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdb_d[li_reproduce_target].* = g_rtdb_d[li_reproduce].*
               LET g_rtdb2_d[li_reproduce_target].* = g_rtdb2_d[li_reproduce].*
 
               LET g_rtdb_d[g_rtdb_d.getLength()].rtdb001 = NULL
               LET g_rtdb_d[g_rtdb_d.getLength()].rtdb003 = NULL
 
            END IF
            
 
 
            CALL arti037_set_entry_b(l_cmd)
            CALL arti037_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
           LET g_rtdb_d[l_ac].rtdb001 = g_rtdb3_d[g_detail_idx1].rtdb001
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
            SELECT COUNT(1) INTO l_count FROM rtdb_t 
             WHERE rtdbent = g_enterprise AND rtdb001 = g_rtdb_d[l_ac].rtdb001
                                       AND rtdb003 = g_rtdb_d[l_ac].rtdb003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdb_d[g_detail_idx].rtdb001
               LET gs_keys[2] = g_rtdb_d[g_detail_idx].rtdb003
               CALL arti037_insert_b('rtdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtdb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti037_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (rtdb001 = '", g_rtdb_d[l_ac].rtdb001, "' "
                                  ," AND rtdb003 = '", g_rtdb_d[l_ac].rtdb003, "' "
 
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
               
               DELETE FROM rtdb_t
                WHERE rtdbent = g_enterprise AND 
                      rtdb001 = g_rtdb_d_t.rtdb001
                      AND rtdb003 = g_rtdb_d_t.rtdb003
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtdb_t:",SQLERRMESSAGE 
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
                  CALL arti037_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_rtdb_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE arti037_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_rtdb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdb_d_t.rtdb001
               LET gs_keys[2] = g_rtdb_d_t.rtdb003
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti037_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL arti037_delete_b('rtdb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdb001
            #add-point:BEFORE FIELD rtdb001 name="input.b.page1.rtdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdb001
            
            #add-point:AFTER FIELD rtdb001 name="input.a.page1.rtdb001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtdb_d[g_detail_idx].rtdb001 IS NOT NULL AND g_rtdb_d[g_detail_idx].rtdb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdb_d[g_detail_idx].rtdb001 != g_rtdb_d_t.rtdb001 OR g_rtdb_d[g_detail_idx].rtdb003 != g_rtdb_d_t.rtdb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM rtdb_t WHERE "||"rtdbent = '" ||g_enterprise|| "' AND "||"rtdb001 = '"||g_rtdb_d[g_detail_idx].rtdb001 ||"' AND "|| "rtdb003 = '"||g_rtdb_d[g_detail_idx].rtdb003 ||"'",'std-00004',0) THEN   #160905-00007#14 SELECT COUNT(*) -> SELECT COUNT(1)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdb001
            #add-point:ON CHANGE rtdb001 name="input.g.page1.rtdb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdb003
            
            #add-point:AFTER FIELD rtdb003 name="input.a.page1.rtdb003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtdb_d[g_detail_idx].rtdb001 IS NOT NULL AND g_rtdb_d[g_detail_idx].rtdb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdb_d[g_detail_idx].rtdb001 != g_rtdb_d_t.rtdb001 OR g_rtdb_d[g_detail_idx].rtdb003 != g_rtdb_d_t.rtdb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM rtdb_t WHERE "||"rtdbent = '" ||g_enterprise|| "' AND "||"rtdb001 = '"||g_rtdb_d[g_detail_idx].rtdb001 ||"' AND "|| "rtdb003 = '"||g_rtdb_d[g_detail_idx].rtdb003 ||"'",'std-00004',0) THEN   #160905-00007#14 SELECT COUNT(*) -> SELECT COUNT(1)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_rtdb_d[l_ac].rtdb003) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '6766'
               LET g_chkparam.arg2 = g_rtdb_d[l_ac].rtdb003
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_gzcb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_rtdb_d[l_ac].rtdb003 = g_rtdb_d_t.rtdb003
                  LET g_rtdb_d[l_ac].rtdb003_desc = ""
                  DISPLAY BY NAME g_rtdb_d[l_ac].rtdb003,g_rtdb_d[l_ac].rtdb003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdb_d[l_ac].rtdb003
            CALL ap_ref_array2(g_ref_fields," SELECT gzzal003 FROM gzzal_t WHERE  gzzal001 = ? AND gzzal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtdb_d[l_ac].rtdb003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_rtdb_d[l_ac].rtdb003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdb003
            #add-point:BEFORE FIELD rtdb003 name="input.b.page1.rtdb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdb003
            #add-point:ON CHANGE rtdb003 name="input.g.page1.rtdb003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtdb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdb001
            #add-point:ON ACTION controlp INFIELD rtdb001 name="input.c.page1.rtdb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdb003
            #add-point:ON ACTION controlp INFIELD rtdb003 name="input.c.page1.rtdb003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtdb_d[l_ac].rtdb003             #給予default值
            LET g_qryparam.default2 = g_rtdb_d[l_ac].rtdb003_desc  #程式名稱
            #給予arg
            LET g_qryparam.arg1 = "6766" #

            
            CALL q_gzcb002_01()                                #呼叫開窗

            LET g_rtdb_d[l_ac].rtdb003 = g_qryparam.return1              
            LET g_rtdb_d[l_ac].rtdb003_desc = g_qryparam.return2 
            DISPLAY g_rtdb_d[l_ac].rtdb003 TO rtdb003              #
            DISPLAY g_rtdb_d[l_ac].rtdb003_desc TO rtdb003_desc #程式名稱
            NEXT FIELD rtdb003     
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE arti037_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_rtdb_d[l_ac].* = g_rtdb_d_t.*
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
               LET g_errparam.extend = g_rtdb_d[l_ac].rtdb001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtdb_d[l_ac].* = g_rtdb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtdb2_d[l_ac].rtdbmodid = g_user 
LET g_rtdb2_d[l_ac].rtdbmoddt = cl_get_current()
LET g_rtdb2_d[l_ac].rtdbmodid_desc = cl_get_username(g_rtdb2_d[l_ac].rtdbmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti037_rtdb_t_mask_restore('restore_mask_o')
 
               UPDATE rtdb_t SET (rtdb001,rtdb003,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt, 
                   rtdbmodid,rtdbmoddt) = (g_rtdb_d[l_ac].rtdb001,g_rtdb_d[l_ac].rtdb003,g_rtdb2_d[l_ac].rtdbownid, 
                   g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp,g_rtdb2_d[l_ac].rtdbcrtdt, 
                   g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt)
                WHERE rtdbent = g_enterprise AND
                  rtdb001 = g_rtdb_d_t.rtdb001 #項次   
                  AND rtdb003 = g_rtdb_d_t.rtdb003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdb_d[g_detail_idx].rtdb001
               LET gs_keys_bak[1] = g_rtdb_d_t.rtdb001
               LET gs_keys[2] = g_rtdb_d[g_detail_idx].rtdb003
               LET gs_keys_bak[2] = g_rtdb_d_t.rtdb003
               CALL arti037_update_b('rtdb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtdb_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtdb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL arti037_rtdb_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti037_unlock_b("rtdb_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtdb_d[l_ac].* = g_rtdb_d_t.*
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
               LET g_rtdb_d[li_reproduce_target].* = g_rtdb_d[li_reproduce].*
               LET g_rtdb2_d[li_reproduce_target].* = g_rtdb2_d[li_reproduce].*
 
               LET g_rtdb_d[li_reproduce_target].rtdb001 = NULL
               LET g_rtdb_d[li_reproduce_target].rtdb003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtdb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtdb_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_rtdb2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL arti037_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body2.action"
            LET g_detail_cnt = g_rtdb2_d.getLength() 
            DISPLAY g_detail_cnt TO FORMONLY.cnt
            CALL arti037_b_fill(g_wc2)
         #end add-point
            
      END DISPLAY
 
      
      #add-point:before_more_input name="input.more_input"
     INPUT ARRAY g_rtdb3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_detail_cnt2,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF NOT cl_null(g_rtdb3_d[l_ac1].rtdb001) THEN
                  CALL n_rtdbl(g_rtdb3_d[l_ac1].rtdb001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtdb3_d[l_ac1].rtdb001
                  CALL ap_ref_array2(g_ref_fields," SELECT rtdbl003,rtdbl004 FROM rtdbl_t WHERE rtdblent = '"||g_enterprise||"' AND rtdbl001 = ? AND rtdbl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rtdb3_d[l_ac1].rtdbl003 = g_rtn_fields[1]
                  LET g_rtdb3_d[l_ac1].rtdbl004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_rtdb3_d[l_ac1].rtdbl003,g_rtdb3_d[l_ac1].rtdbl003
               END IF
               #END add-point
            END IF
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdb3_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
 
            CALL arti037_b_fill_2()
            LET g_detail_cnt2 = g_rtdb3_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET g_detail_idx1 = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac1 = g_detail_idx1
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
            DISPLAY g_rtdb3_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt2 = g_rtdb3_d.getLength()
            
            IF g_detail_cnt2 >= l_ac1 
               AND g_rtdb3_d[l_ac1].rtdb001 IS NOT NULL
               AND g_rtdb3_d[l_ac1].rtdb003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtdb3_d_t.* = g_rtdb3_d[l_ac1].*  #BACKUP
               LET g_rtdb3_d_o.* = g_rtdb3_d[l_ac1].*  #BACKUP
               IF NOT arti037_lock_b_2("rtdb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti037_bcl2 INTO g_rtdb3_d[l_ac1].rtdbstus,g_rtdb3_d[l_ac1].rtdb001,
                  g_rtdb3_d[l_ac1].rtdbl003,g_rtdb3_d[l_ac1].rtdbl004,g_rtdb3_d[l_ac1].rtdb002,
                  g_rtdb3_d[l_ac1].rtdb003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtdb3_d_t.rtdb001 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL arti037_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            CALL arti037_set_entry_b(l_cmd)
            CALL arti037_set_no_entry_b(l_cmd)
            CALL arti037_b_fill(g_wc2)
      
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rtdblent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rtdbl001'
            LET l_var_keys[02] = g_rtdb3_d[l_ac1].rtdb001
            LET l_field_keys[03] = 'rtdbl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rtdbl_t') THEN
                RETURN 
            END IF 
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtdb3_d_t.* TO NULL
            INITIALIZE g_rtdb3_d_o.* TO NULL
            INITIALIZE g_rtdb3_d[l_ac1].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
            
            
            LET l_ac = g_detail_idx 
      SELECT MAX(rtdb002) 
            INTO l_rtdb002
            FROM rtdb_t 
           WHERE rtdbent = g_enterprise   #160905-00007#14 add 
      LET g_rtdb3_d[l_ac1].rtdbstus = 'Y'     
      LET g_rtdb3_d[l_ac1].rtdb002 = l_rtdb002+1
      LET g_rtdb2_d[l_ac].rtdbownid = g_user
      LET g_rtdb2_d[l_ac].rtdbowndp = g_dept
      LET g_rtdb2_d[l_ac].rtdbcrtid = g_user
      LET g_rtdb2_d[l_ac].rtdbcrtdp = g_dept 
      LET g_rtdb2_d[l_ac].rtdbcrtdt = cl_get_current()
      LET g_rtdb2_d[l_ac].rtdbmodid = g_user
      LET g_rtdb2_d[l_ac].rtdbmoddt = cl_get_current()
      LET g_rtdb3_d[l_ac1].rtdb003 = ' '
 
            #自定義預設值(單身2)
            LET g_rtdb3_d[l_ac1].rtdbstus = 'Y'
            #add-point:modify段before備份

            #end add-point
            LET g_rtdb3_d_t.* = g_rtdb3_d[l_ac1].*     #新輸入資料
            LET g_rtdb3_d_o.* = g_rtdb3_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL arti037_set_entry_b("a")
            CALL arti037_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdb_d[li_reproduce_target].* = g_rtdb_d[li_reproduce].*
               LET g_rtdb2_d[li_reproduce_target].* = g_rtdb2_d[li_reproduce].*
               LET g_rtdb3_d[li_reproduce_target].* = g_rtdb3_d[li_reproduce].*
 
               LET g_rtdb3_d[g_rtdb_d.getLength()].rtdb001 = NULL
               LET g_rtdb3_d[g_rtdb_d.getLength()].rtdb003 = NULL
 
            END IF
            
            #add-point:modify段before insert

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
            SELECT COUNT(1) INTO l_count FROM rtdb_t    #160905-00007#14 SELECT COUNT(*) -> SELECT COUNT(1)
             WHERE rtdbent = g_enterprise AND rtdb001 = g_rtdb3_d[l_ac1].rtdb001
                                       AND rtdb003 = g_rtdb3_d[l_ac1].rtdb003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
#               LET g_rtdb3_d[g_detail_idx].rtdb003 = ' '
               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdb3_d[g_detail_idx1].rtdb001
               LET gs_keys[2] = g_rtdb3_d[g_detail_idx1].rtdb003
               CALL arti037_insert_b_2('rtdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_rtdb3_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtdb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti037_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_rtdb3_d[l_ac1].rtdb001 = g_detail_multi_table_t.rtdbl001 AND
               g_rtdb3_d[l_ac1].rtdbl003 = g_detail_multi_table_t.rtdbl003 AND
               g_rtdb3_d[l_ac1].rtdbl004 = g_detail_multi_table_t.rtdbl004 THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'rtdblent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_rtdb3_d[l_ac1].rtdb001
                  LET l_field_keys[02] = 'rtdbl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdbl001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'rtdbl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdbl002
                  LET l_vars[01] = g_rtdb3_d[l_ac1].rtdbl003
                  LET l_fields[01] = 'rtdbl003'
                  LET l_vars[02] = g_rtdb3_d[l_ac1].rtdbl004
                  LET l_fields[02] = 'rtdbl004'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdbl_t')
               END IF 
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt2 = g_detail_cnt2 + 1
               
               LET g_wc2 = g_wc2, " OR (rtdb001 = '", g_rtdb3_d[l_ac1].rtdb001, "' "
                                  ," AND rtdb003 = '", g_rtdb3_d[l_ac1].rtdb003, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前

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
               
               #add-point:單身刪除前

               #end add-point   
               
               DELETE FROM rtdb_t
                WHERE rtdbent = g_enterprise AND 
                      rtdb001 = g_rtdb3_d_t.rtdb001
                      
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtdb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt2 = g_detail_cnt2-1
                  
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE arti037_bcl2
               #add-point:單身關閉bcl

               #end add-point
               LET l_count = g_rtdb3_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdb3_d_t.rtdb001
               LET gs_keys[2] = g_rtdb3_d_t.rtdb003
 
               #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL arti037_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL arti037_delete_b('rtdb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac1 = (g_rtdb3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac1-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdb001
            #add-point:BEFORE FIELD rtdb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdb001
            
            #add-point:AFTER FIELD rtdb001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtdb3_d[g_detail_idx1].rtdb001 IS NOT NULL AND g_rtdb3_d[g_detail_idx1].rtdb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdb3_d[g_detail_idx1].rtdb001 != g_rtdb3_d_t.rtdb001 OR g_rtdb3_d[g_detail_idx1].rtdb003 != g_rtdb3_d_t.rtdb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM rtdb_t WHERE "||"rtdbent = '" ||g_enterprise|| "' AND "||"rtdb001 = '"||g_rtdb3_d[g_detail_idx1].rtdb001 ||"'  ",'std-00004',0) THEN   #160905-00007#14 SELECT COUNT(*) -> SELECT COUNT(1)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdb001
            #add-point:ON CHANGE rtdb001

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdb0032
            
            #add-point:AFTER FIELD rtdb003
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  g_rtdb3_d[g_detail_idx1].rtdb001 IS NOT NULL AND g_rtdb3_d[g_detail_idx1].rtdb003 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdb3_d[g_detail_idx1].rtdb001 != g_rtdb3_d_t.rtdb001 OR g_rtdb3_d[g_detail_idx1].rtdb003 != g_rtdb3_d_t.rtdb003)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdb_t WHERE "||"rtdbent = '" ||g_enterprise|| "' AND "||"rtdb001 = '"||g_rtdb3_d[g_detail_idx1].rtdb001 ||"' AND "|| "rtdb003 = '"||g_rtdb3_d[g_detail_idx1].rtdb003 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdb0032
            #add-point:BEFORE FIELD rtdb003

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdb0032
            #add-point:ON CHANGE rtdb003

            #END add-point 
 
         
         BEFORE FIELD rtdbl003
            #add-point:BEFORE FIELD rtdb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdbl003
            
            #add-point:AFTER FIELD rtdb001
            #應用 a05 樣板自動產生(Version:2)
       
          

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdbl003
            #add-point:ON CHANGE rtdb001

            #END add-point 
         
         BEFORE FIELD rtdbl004
            #add-point:BEFORE FIELD rtdb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdbl004
            
            #add-point:AFTER FIELD rtdb001
            #應用 a05 樣板自動產生(Version:2)
       
          

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdbl004
            #add-point:ON CHANGE rtdb001

            #END add-point    
         
         BEFORE FIELD rtdb002
            #add-point:BEFORE FIELD rtdb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdb002
            
            #add-point:AFTER FIELD rtdb001
            #應用 a05 樣板自動產生(Version:2)
       
           IF NOT cl_null(g_rtdb3_d[g_detail_idx1].rtdb002) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdb3_d[g_detail_idx1].rtdb002 != g_rtdb3_d_t.rtdb002 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM rtdb_t WHERE "||"rtdbent = '" ||g_enterprise|| "' AND "||"rtdb002 = '"||g_rtdb3_d[g_detail_idx1].rtdb002 ||"'",'std-00004',0) THEN   #160905-00007#14 SELECT COUNT(*) -> SELECT COUNT(1)
                     NEXT FIELD CURRENT
                  END IF
               END IF
           END IF 

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdb002
            #add-point:ON CHANGE rtdb001

            #END add-point 
         
       
         
      
         
         #Ctrlp:input.c.page1.rtdb001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdb001
            #add-point:ON ACTION controlp INFIELD rtdb001

            #END add-point
 
         #Ctrlp:input.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdb0032
            #add-point:ON ACTION controlp INFIELD rtdb003

            #END add-point
        
        #Ctrlp:input.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdbl003
            #add-point:ON ACTION controlp INFIELD rtdb003

            #END add-point
         
         #Ctrlp:input.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdbl004
            #add-point:ON ACTION controlp INFIELD rtdb003

            #END add-point
         
         #Ctrlp:input.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdb002
            #add-point:ON ACTION controlp INFIELD rtdb003

            #END add-point
         
         #Ctrlp:input.c.page1.rtdb003
         #應用 a03 樣板自動產生(Version:2)
        
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_rtdb_d[l_ac].* = g_rtdb_d_t.*
               CLOSE arti037_bcl
               #add-point:單身取消時

               #end add-point
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtdb_d[l_ac].rtdb001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtdb_d[l_ac].* = g_rtdb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtdb2_d[l_ac].rtdbmodid = g_user 
LET g_rtdb2_d[l_ac].rtdbmoddt = cl_get_current()
LET g_rtdb2_d[l_ac].rtdbmodid_desc = cl_get_username(g_rtdb2_d[l_ac].rtdbmodid)
            
               #add-point:單身修改前

               #end add-point
               
#               UPDATE rtdb_t SET (rtdbstus,rtdb001,rtdb003,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt, 
#                   rtdbmodid,rtdbmoddt) = (g_rtdb3_d[l_ac1].rtdbstus,g_rtdb3_d[l_ac1].rtdb001,g_rtdb3_d[l_ac1].rtdb003,g_rtdb2_d[l_ac1].rtdbownid, 
#                   g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp,g_rtdb2_d[l_ac].rtdbcrtdt, 
#                   g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt)
#                WHERE rtdbent = g_enterprise AND
#                  rtdb001 = g_rtdb3_d_t.rtdb001 #項次   
#                  AND rtdb003 = g_rtdb3_d_t.rtdb003  
 
                  
               UPDATE rtdb_t SET (rtdbstus,rtdb001,rtdb002, 
                   rtdbmodid,rtdbmoddt) = (g_rtdb3_d[l_ac1].rtdbstus,g_rtdb3_d[l_ac1].rtdb001,
                   g_rtdb3_d[l_ac1].rtdb002,g_rtdb2_d[l_ac1].rtdbmodid,g_rtdb2_d[l_ac1].rtdbmoddt)
                WHERE rtdbent = g_enterprise AND
                  rtdb001 = g_rtdb3_d_t.rtdb001 #項次   
                  
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdb_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdb3_d[g_detail_idx1].rtdb001
               LET gs_keys_bak[1] = g_rtdb3_d_t.rtdb001

               CALL arti037_update_b_2('rtdb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_rtdb3_d[l_ac1].rtdb001 = g_detail_multi_table_t.rtdbl001 AND
               g_rtdb3_d[l_ac1].rtdbl003 = g_detail_multi_table_t.rtdbl003 AND
               g_rtdb3_d[l_ac1].rtdbl004 = g_detail_multi_table_t.rtdbl004 THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'rtdblent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_rtdb3_d[l_ac1].rtdb001
                  LET l_field_keys[02] = 'rtdbl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdbl001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'rtdbl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdbl002
                  LET l_vars[01] = g_rtdb3_d[l_ac1].rtdbl003
                  LET l_fields[01] = 'rtdbl003'
                  LET l_vars[02] = g_rtdb3_d[l_ac1].rtdbl004
                  LET l_fields[02] = 'rtdbl004'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdbl_t')
               END IF 
                     
                     
                     LET g_log1 = util.JSON.stringify(g_rtdb3_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtdb3_d[l_ac1])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti037_unlock_b("rtdb_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row
            IF l_cmd = 'a' THEN
               NEXT FIELD rtdb003
            END IF
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_rtdb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_rtdb_d.getLength()+1
            
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
               NEXT FIELD rtdb001
            WHEN "s_detail2"
               NEXT FIELD rtdb001_2
 
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
      IF INT_FLAG OR cl_null(g_rtdb_d[g_detail_idx].rtdb001) THEN
         CALL g_rtdb_d.deleteElement(g_detail_idx)
         CALL g_rtdb2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_rtdb_d[g_detail_idx].* = g_rtdb_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   CALL arti037_b_fill_2()
   #end add-point
 
   CLOSE arti037_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="arti037.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti037_delete()
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
   FOR li_idx = 1 TO g_rtdb_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT arti037_lock_b("rtdb_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("rtdb_t","rtdbownid") THEN
            LET g_data_owner = g_rtdb2_d[g_detail_idx].rtdbownid
            LET g_data_dept = g_rtdb2_d[g_detail_idx].rtdbowndp
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
   
   FOR li_idx = 1 TO g_rtdb_d.getLength()
      IF g_rtdb_d[li_idx].rtdb001 IS NOT NULL
         AND g_rtdb_d[li_idx].rtdb003 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM rtdb_t
          WHERE rtdbent = g_enterprise AND 
                rtdb001 = g_rtdb_d[li_idx].rtdb001
                AND rtdb003 = g_rtdb_d[li_idx].rtdb003
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdb_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_rtdb_d_t.rtdb001
               LET gs_keys[2] = g_rtdb_d_t.rtdb003
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL arti037_delete_b('rtdb_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti037_set_pk_array()
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
   CALL arti037_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="arti037.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti037_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE li_ac           LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"

   CALL g_rtdb_d.clear()
   CALL g_rtdb2_d.clear()
   #判定單頭是否有資料
   
   
  
   IF cl_null(g_rtdb3_d[g_detail_idx1].rtdb001) THEN
      RETURN
   END IF
   
   
   
   LET g_sql = "SELECT  UNIQUE t0.rtdb001,t0.rtdb003,t0.rtdb001,t0.rtdb003,t0.rtdbownid,t0.rtdbowndp, 
       t0.rtdbcrtid,t0.rtdbcrtdp,t0.rtdbcrtdt,t0.rtdbmodid,t0.rtdbmoddt ,t1.gzzal003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM rtdb_t t0",
               "",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.rtdb003 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.rtdbownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.rtdbowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.rtdbcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.rtdbcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.rtdbmodid  ",
 
               " WHERE t0.rtdbent= ? AND t0.rtdb001=?  AND  1=1 AND (", p_wc2, ") " 
             
  
 
   LET g_sql = g_sql, cl_sql_add_filter("rtdb_t"),
                      " ORDER BY t0.rtdb001,t0.rtdb003"
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti037_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR arti037_pb3
   
   OPEN b_fill_curs3 USING g_enterprise,g_rtdb3_d[g_detail_idx1].rtdb001
 
   CALL g_rtdb_d.clear()
   CALL g_rtdb2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs3 INTO g_rtdb_d[l_ac].rtdb001,g_rtdb_d[l_ac].rtdb003,g_rtdb2_d[l_ac].rtdb001,g_rtdb2_d[l_ac].rtdb003, 
       g_rtdb2_d[l_ac].rtdbownid,g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp, 
       g_rtdb2_d[l_ac].rtdbcrtdt,g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt,g_rtdb_d[l_ac].rtdb003_desc, 
       g_rtdb2_d[l_ac].rtdbownid_desc,g_rtdb2_d[l_ac].rtdbowndp_desc,g_rtdb2_d[l_ac].rtdbcrtid_desc, 
       g_rtdb2_d[l_ac].rtdbcrtdp_desc,g_rtdb2_d[l_ac].rtdbmodid_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL arti037_detail_show()      
 
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
   
 
   
   CALL g_rtdb_d.deleteElement(g_rtdb_d.getLength())   
   CALL g_rtdb2_d.deleteElement(g_rtdb2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtdb_d.getLength()
      LET g_rtdb2_d[l_ac].rtdb001 = g_rtdb_d[l_ac].rtdb001 
      LET g_rtdb2_d[l_ac].rtdb003 = g_rtdb_d[l_ac].rtdb003 
 
   END FOR
   
   IF g_cnt > g_rtdb_d.getLength() THEN
      LET l_ac = g_rtdb_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)
    
   #end add-point
   
   ERROR "" 
 
   
   
   CLOSE b_fill_curs3
   FREE arti037_pb3
   
   RETURN 
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.rtdb001,t0.rtdb003,t0.rtdb001,t0.rtdb003,t0.rtdbownid,t0.rtdbowndp, 
       t0.rtdbcrtid,t0.rtdbcrtdp,t0.rtdbcrtdt,t0.rtdbmodid,t0.rtdbmoddt ,t1.gzzal003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM rtdb_t t0",
               "",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.rtdb003 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtdbownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtdbowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtdbcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtdbcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtdbmodid  ",
 
               " WHERE t0.rtdbent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("rtdb_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND rtdbowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("rtdb_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND rtdbownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtdb_t"),
                      " ORDER BY t0.rtdb001,t0.rtdb003"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtdb_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti037_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR arti037_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtdb_d.clear()
   CALL g_rtdb2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtdb_d[l_ac].rtdb001,g_rtdb_d[l_ac].rtdb003,g_rtdb2_d[l_ac].rtdb001,g_rtdb2_d[l_ac].rtdb003, 
       g_rtdb2_d[l_ac].rtdbownid,g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp, 
       g_rtdb2_d[l_ac].rtdbcrtdt,g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt,g_rtdb_d[l_ac].rtdb003_desc, 
       g_rtdb2_d[l_ac].rtdbownid_desc,g_rtdb2_d[l_ac].rtdbowndp_desc,g_rtdb2_d[l_ac].rtdbcrtid_desc, 
       g_rtdb2_d[l_ac].rtdbcrtdp_desc,g_rtdb2_d[l_ac].rtdbmodid_desc
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
      
      CALL arti037_detail_show()      
 
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
   
 
   
   CALL g_rtdb_d.deleteElement(g_rtdb_d.getLength())   
   CALL g_rtdb2_d.deleteElement(g_rtdb2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtdb_d.getLength()
      LET g_rtdb2_d[l_ac].rtdb001 = g_rtdb_d[l_ac].rtdb001 
      LET g_rtdb2_d[l_ac].rtdb003 = g_rtdb_d[l_ac].rtdb003 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_rtdb_d.getLength() THEN
      LET l_ac = g_rtdb_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtdb_d.getLength()
      LET g_rtdb_d_mask_o[l_ac].* =  g_rtdb_d[l_ac].*
      CALL arti037_rtdb_t_mask()
      LET g_rtdb_d_mask_n[l_ac].* =  g_rtdb_d[l_ac].*
   END FOR
   
   LET g_rtdb2_d_mask_o.* =  g_rtdb2_d.*
   FOR l_ac = 1 TO g_rtdb2_d.getLength()
      LET g_rtdb2_d_mask_o[l_ac].* =  g_rtdb2_d[l_ac].*
      CALL arti037_rtdb_t_mask()
      LET g_rtdb2_d_mask_n[l_ac].* =  g_rtdb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL arti037_b_fill_2()      
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_rtdb_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE arti037_pb
   
END FUNCTION
 
{</section>}
 
{<section id="arti037.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION arti037_detail_show()
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
 
{<section id="arti037.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti037_set_entry_b(p_cmd)                                                  
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
 
{<section id="arti037.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti037_set_no_entry_b(p_cmd)                                               
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
 
{<section id="arti037.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti037_default_search()
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
      LET ls_wc = ls_wc, " rtdb001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtdb003 = '", g_argv[02], "' AND "
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
 
{<section id="arti037.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti037_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "rtdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtdb_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM rtdb_t
          WHERE rtdbent = g_enterprise AND
            rtdb001 = ps_keys_bak[1] AND rtdb003 = ps_keys_bak[2]
         
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
         CALL g_rtdb_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_rtdb2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti037.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti037_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_rtdb003   LIKE rtdb_t.rtdb003 
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "rtdb_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      SELECT rtdb003 
        INTO l_rtdb003
        FROM rtdb_t
       WHERE rtdb001 = g_rtdb3_d[l_ac1].rtdb001 
         AND rtdbent = g_enterprise  #160905-00007#14 add 
      IF  l_rtdb003 = ' ' THEN  
          UPDATE rtdb_t SET (rtdb003) = (g_rtdb_d[l_ac].rtdb003)
                WHERE rtdbent = g_enterprise AND
                  rtdb001 = g_rtdb3_d[l_ac1].rtdb001 
                  
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "rtdb_t" 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = FALSE 
             CALL cl_err()
 
          END IF    
          RETURN           
      END IF 
      
  
      INSERT INTO rtdb_t
                  (rtdbent,rtdbstus,rtdb002,
                   rtdb001,rtdb003
                   ,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt,rtdbmodid,rtdbmoddt) 
            VALUES(g_enterprise,g_rtdb3_d[g_detail_idx1].rtdbstus
                ,g_rtdb3_d[g_detail_idx1].rtdb002,
                   ps_keys[1],ps_keys[2]
                   ,g_rtdb2_d[l_ac].rtdbownid,g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp, 
                       g_rtdb2_d[l_ac].rtdbcrtdt,g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt) 

      #add-point:insert_b段新增中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      
      RETURN
      #end add-point    
      INSERT INTO rtdb_t
                  (rtdbent,
                   rtdb001,rtdb003
                   ,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt,rtdbmodid,rtdbmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtdb2_d[l_ac].rtdbownid,g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp, 
                       g_rtdb2_d[l_ac].rtdbcrtdt,g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti037.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti037_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "rtdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtdb_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE rtdb_t 
         SET (rtdb001,rtdb003
              ,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt,rtdbmodid,rtdbmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtdb2_d[l_ac].rtdbownid,g_rtdb2_d[l_ac].rtdbowndp,g_rtdb2_d[l_ac].rtdbcrtid,g_rtdb2_d[l_ac].rtdbcrtdp, 
                  g_rtdb2_d[l_ac].rtdbcrtdt,g_rtdb2_d[l_ac].rtdbmodid,g_rtdb2_d[l_ac].rtdbmoddt) 
         WHERE rtdbent = g_enterprise AND rtdb001 = ps_keys_bak[1] AND rtdb003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdb_t:",SQLERRMESSAGE 
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
 
{<section id="arti037.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti037_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL arti037_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN arti037_bcl USING g_enterprise,
                                       g_rtdb_d[g_detail_idx].rtdb001,g_rtdb_d[g_detail_idx].rtdb003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti037_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti037.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti037_unlock_b(ps_table)
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
      CLOSE arti037_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti037.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION arti037_modify_detail_chk(ps_record)
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
         LET ls_return = "rtdb001"
      WHEN "s_detail2"
         LET ls_return = "rtdb001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="arti037.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION arti037_show_ownid_msg()
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
 
{<section id="arti037.mask_functions" >}
&include "erp/art/arti037_mask.4gl"
 
{</section>}
 
{<section id="arti037.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti037_set_pk_array()
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
   LET g_pk_array[1].values = g_rtdb_d[l_ac].rtdb001
   LET g_pk_array[1].column = 'rtdb001'
   LET g_pk_array[2].values = g_rtdb_d[l_ac].rtdb003
   LET g_pk_array[2].column = 'rtdb003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti037.state_change" >}
   
 
{</section>}
 
{<section id="arti037.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti037.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 单身阵列填充2
# Date & Author..: 2015/03/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION arti037_b_fill_2()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define

   #end add-point
   
   #判定单身1是否有資料

   
   CALL g_rtdb3_d.clear()
   
 
   
   LET li_ac = l_ac1 
   
   LET g_sql = "SELECT UNIQUE t0.rtdbstus, t0.rtdb001,  t2.rtdbl003,  t2.rtdbl004,
                       t0.rtdb002,' '
                  FROM rtdb_t t0",   
               " LEFT JOIN rtdbl_t t2 ON t2.rtdblent='"||g_enterprise||"' AND t2.rtdbl001=t0.rtdb001 AND t2.rtdbl002='"||g_dlang||"' ",
               " WHERE t0.rtdbent=?  AND  1=1 AND ", g_wc,
               " AND rtdb001 IN (SELECT rtdb001 FROM rtdb_t WHERE rtdbent="||g_enterprise||" AND ",g_wc2,")" #160905-00007#14 rtdbent='"||g_enterprise||"'
 
   
 
   LET g_sql = g_sql, " ORDER BY t0.rtdb002" 
                      
   #add-point:單身填充前

   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
   PREPARE arti037_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR arti037_pb2
   
   LET l_ac1 = g_detail_idx1
   OPEN b_fill_curs2 USING g_enterprise
   
   LET l_ac1 = 1
   FOREACH b_fill_curs2
      INTO g_rtdb3_d[l_ac1].rtdbstus,g_rtdb3_d[l_ac1].rtdb001,g_rtdb3_d[l_ac1].rtdbl003,
           g_rtdb3_d[l_ac1].rtdbl004,g_rtdb3_d[l_ac1].rtdb002,g_rtdb3_d[l_ac1].rtdb003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
#      #add-point:b_fill段資料填充
#      IF cl_null(g_ooez2_d[l_ac].ooez002) THEN
#         CONTINUE FOREACH
#      END IF
#      IF g_ooez2_d[l_ac].ooezacti IS NULL THEN
#         LET g_ooez2_d[l_ac].ooezacti = 'Y'
#      END IF
      CALL arti037_detail_show()
      #end add-point
      
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
 
 
   #add-point:單身填充後
   IF g_detail_idx1 = 0 THEN 
      LET g_detail_idx1 = 1
   END IF    
   CALL arti037_b_fill(g_wc2)
   #end add-point
   
   CALL g_rtdb3_d.deleteElement(g_rtdb3_d.getLength())   
   
   
#   LET g_loc = 'd'
   CALL arti037_detail_show()
   LET g_detail_cnt2 = g_rtdb3_d.getLength()
   LET l_ac1 = li_ac
   
END FUNCTION

################################################################################
# Descriptions...: lock 单身2
# Date & Author..: 2015/03/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION arti037_lock_b_2(ps_table)
 DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   DEFINE l_rtdb003  LIKE rtdb_t.rtdb003 
   #end add-point   
   #add-point:lock_b段define

   #end add-point
   
   #先刷新資料
   #CALL arti037_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      SELECT rtdb003 
        INTO l_rtdb003
        FROM rtdb_t 
       WHERE rtdb001 =  g_rtdb3_d[g_detail_idx1].rtdb001
         AND rtdbent = g_enterprise 
      OPEN arti037_bcl2 USING g_dlang,g_enterprise,
                                       g_rtdb3_d[g_detail_idx1].rtdb001,l_rtdb003
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti037_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION

################################################################################
# Descriptions...: 更新单身1
# Date & Author..: 2015/03/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION arti037_update_b_2(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   #add-point:update_b段define

   #end add-point     
   #add-point:update_b段define

   #end add-point
   
  
    
   #若有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
 
      #add-point:update_b段修改前

      #end add-point     
      UPDATE rtdb_t 
         SET (rtdbstus,rtdb001,rtdb002
              ,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt,rtdbmodid,rtdbmoddt) 
              = 
             (g_rtdb3_d[g_detail_idx1].rtdbstus,ps_keys[1]
              ,g_rtdb3_d[g_detail_idx1].rtdb002
              ,g_rtdb2_d[g_detail_idx1].rtdbownid,g_rtdb2_d[g_detail_idx1].rtdbowndp,g_rtdb2_d[g_detail_idx1].rtdbcrtid,g_rtdb2_d[g_detail_idx1].rtdbcrtdp, 
                  g_rtdb2_d[g_detail_idx1].rtdbcrtdt,g_rtdb2_d[g_detail_idx1].rtdbmodid,g_rtdb2_d[g_detail_idx1].rtdbmoddt) 
         WHERE rtdb001 = ps_keys_bak[1] AND rtdbent = g_enterprise  #160905-00007#14 add rtdbent = g_enterprise
      #add-point:update_b段修改中

      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdb_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdb_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point 
      RETURN
   
END FUNCTION

################################################################################
# Descriptions...: 单身1新增
# Date & Author..: 2015/03/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION arti037_insert_b_2(ps_table,ps_keys,ps_page)
DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   DEFINE l_rtdb003   LIKE rtdb_t.rtdb003 
   #end add-point     
   #add-point:insert_b段define

   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "rtdb_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
     
      #end add-point    
      INSERT INTO rtdb_t
                  (rtdbent,rtdbstus,rtdb002,
                   rtdb001,rtdb003
                   ,rtdbownid,rtdbowndp,rtdbcrtid,rtdbcrtdp,rtdbcrtdt,rtdbmodid,rtdbmoddt) 
            VALUES(g_enterprise,g_rtdb3_d[g_detail_idx1].rtdbstus
                ,g_rtdb3_d[g_detail_idx1].rtdb002
                   ,ps_keys[1],ps_keys[2]
                   ,g_rtdb2_d[g_detail_idx].rtdbownid,g_rtdb2_d[g_detail_idx].rtdbowndp,g_rtdb2_d[g_detail_idx].rtdbcrtid,g_rtdb2_d[g_detail_idx].rtdbcrtdp, 
                       g_rtdb2_d[g_detail_idx].rtdbcrtdt,g_rtdb2_d[g_detail_idx].rtdbmodid,g_rtdb2_d[g_detail_idx].rtdbmoddt) 

      #add-point:insert_b段新增中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後

      #end add-point    
   #END IF
END FUNCTION

 
{</section>}
 
