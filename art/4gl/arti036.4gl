#該程式未解開Section, 採用最新樣板產出!
{<section id="arti036.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-05-18 11:43:35), PR版次:0004(2016-09-06 11:36:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: arti036
#+ Description: 商品生命週期維護作業
#+ Creator....: 06189(2015-03-08 21:41:47)
#+ Modifier...: 07959 -SD/PR- 07900
 
{</section>}
 
{<section id="arti036.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:No.160513-00022#1    2016/05/16  by 07959 是否参与异常商品栏位需要给默认值
#+ Modifier...:No.160905-00007#14   2016/09/05  By 07900   调整系统中无ENT的SQL条件增加ent
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
PRIVATE TYPE type_g_rtda_d RECORD
       rtda001 LIKE rtda_t.rtda001, 
   rtda005 LIKE rtda_t.rtda005, 
   rtda005_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_rtda2_d RECORD
       rtda001 LIKE rtda_t.rtda001, 
   rtda005 LIKE rtda_t.rtda005, 
   rtdaownid LIKE rtda_t.rtdaownid, 
   rtdaownid_desc LIKE type_t.chr500, 
   rtdaowndp LIKE rtda_t.rtdaowndp, 
   rtdaowndp_desc LIKE type_t.chr500, 
   rtdacrtid LIKE rtda_t.rtdacrtid, 
   rtdacrtid_desc LIKE type_t.chr500, 
   rtdacrtdp LIKE rtda_t.rtdacrtdp, 
   rtdacrtdp_desc LIKE type_t.chr500, 
   rtdacrtdt DATETIME YEAR TO SECOND, 
   rtdamodid LIKE rtda_t.rtdamodid, 
   rtdamodid_desc LIKE type_t.chr500, 
   rtdamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_rtda3_d RECORD
       rtdastus LIKE rtda_t.rtdastus, 
   rtda001 LIKE rtda_t.rtda001, 
   rtdal003 LIKE rtdal_t.rtdal003, 
   rtdal004 LIKE rtdal_t.rtdal004, 
   rtda002 LIKE rtda_t.rtda002, 
   rtda003 LIKE rtda_t.rtda003, 
   rtda004 LIKE rtda_t.rtda004, 
   rtda006 LIKE rtda_t.rtda006,
   rtda005 LIKE rtda_t.rtda005,
   rtda007 LIKE rtda_t.rtda007 #是否參與異常商品統計 lanjj add on 2016-04-26 顧問 裴軍
       END RECORD
       
DEFINE g_rtda3_d   DYNAMIC ARRAY OF type_g_rtda3_d
DEFINE g_rtda3_d_t type_g_rtda3_d
DEFINE g_rtda3_d_o type_g_rtda3_d     
DEFINE g_wc               STRING
DEFINE g_detail_cnt2         LIKE type_t.num10  #第一个页签资料笔数
DEFINE g_detail_idx1         LIKE type_t.num10             #單身 1所在筆數(所有資料)
DEFINE l_ac1                LIKE type_t.num5         #單身 1所在筆數(所有資料)

DEFINE g_detail_multi_table_t    RECORD
      rtdal001 LIKE rtdal_t.rtdal001,
      rtdal002 LIKE rtdal_t.rtdal002,
      rtdal003 LIKE rtdal_t.rtdal003,
      rtdal004 LIKE rtdal_t.rtdal004
      END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtda_d          DYNAMIC ARRAY OF type_g_rtda_d #單身變數
DEFINE g_rtda_d_t        type_g_rtda_d                  #單身備份
DEFINE g_rtda_d_o        type_g_rtda_d                  #單身備份
DEFINE g_rtda_d_mask_o   DYNAMIC ARRAY OF type_g_rtda_d #單身變數
DEFINE g_rtda_d_mask_n   DYNAMIC ARRAY OF type_g_rtda_d #單身變數
DEFINE g_rtda2_d   DYNAMIC ARRAY OF type_g_rtda2_d
DEFINE g_rtda2_d_t type_g_rtda2_d
DEFINE g_rtda2_d_o type_g_rtda2_d
DEFINE g_rtda2_d_mask_o DYNAMIC ARRAY OF type_g_rtda2_d
DEFINE g_rtda2_d_mask_n DYNAMIC ARRAY OF type_g_rtda2_d
 
      
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
 
{<section id="arti036.main" >}
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
    LET g_forupd_sql = "SELECT  rtdastus,rtda001,rtdal003,rtdal004,rtda002,rtda003,rtda004,' ',rtda006,rtda007 
       FROM rtda_t LEFT JOIN rtdal_t   ON rtdaent = rtdalent AND  rtda001 = rtdal001  AND rtdal002 = ?
       WHERE rtdaent=? AND rtda001=? AND  rtda005 = ?  FOR UPDATE"  #是否參與異常商品統計 lanjj add rtda007 on 2016-04-26 顧問 裴軍

   #add-point:main段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti036_bcl2 CURSOR FROM g_forupd_sql
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtda001,rtda005,rtda001,rtda005,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp, 
       rtdacrtdt,rtdamodid,rtdamoddt FROM rtda_t WHERE rtdaent=? AND rtda001=? AND rtda005=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti036_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti036 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti036_init()   
 
      #進入選單 Menu (="N")
      CALL arti036_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti036
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti036.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION arti036_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('rtda003','6764' )
   CALL cl_set_combo_scc('rtda006','6789' )
   CALL cl_set_comp_required("rtda007",TRUE)
   #end add-point
   
   CALL arti036_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="arti036.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION arti036_ui_dialog()
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
   CALL arti036_b_fill_2()
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtda_d.clear()
         CALL g_rtda2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL arti036_init()
      END IF
   
      CALL arti036_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_rtda2_d[g_detail_idx].rtdaownid   #(ver:35)
               LET g_data_dept = g_rtda2_d[g_detail_idx].rtdaowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti036_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
                          
               LET g_detail_cnt = g_rtda_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL arti036_b_fill(g_wc2)
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtda2_d TO s_detail2.*
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
   CALL arti036_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               LET g_detail_cnt = g_rtda2_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL arti036_b_fill(g_wc2)
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_rtda3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
            CALL arti036_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview_set_follow_pic()
  
 
 
               #add-point:display array-before row
               LET g_detail_cnt = g_rtda3_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.cnt
               CALL arti036_b_fill(g_wc2)
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
            IF cl_null(g_rtda3_d[1].rtda001) THEN  
               CALL g_rtda3_d.deleteElement(g_detail_idx1)
            END IF
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL arti036_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti036_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL arti036_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti036_modify()
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
               CALL arti036_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_rtda_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtda2_d)
               LET g_export_id[2]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[3] = base.typeInfo.create(g_rtda3_d)
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
            CALL arti036_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti036_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti036_set_pk_array()
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
 
{<section id="arti036.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti036_query()
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
   CALL g_rtda_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON rtda001,rtda005,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt,rtdamodid, 
          rtdamoddt 
 
         FROM s_detail1[1].rtda001,s_detail1[1].rtda005,s_detail2[1].rtdaownid,s_detail2[1].rtdaowndp, 
             s_detail2[1].rtdacrtid,s_detail2[1].rtdacrtdp,s_detail2[1].rtdacrtdt,s_detail2[1].rtdamodid, 
             s_detail2[1].rtdamoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdacrtdt>>----
         AFTER FIELD rtdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdamoddt>>----
         AFTER FIELD rtdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdacnfdt>>----
         
         #----<<rtdapstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtda001
            #add-point:BEFORE FIELD rtda001 name="query.b.page1.rtda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtda001
            
            #add-point:AFTER FIELD rtda001 name="query.a.page1.rtda001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtda001
            #add-point:ON ACTION controlp INFIELD rtda001 name="query.c.page1.rtda001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtda005
            #add-point:ON ACTION controlp INFIELD rtda005 name="construct.c.page1.rtda005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '6765'
            CALL q_gzcb002_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtda005  #顯示到畫面上
            NEXT FIELD rtda005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtda005
            #add-point:BEFORE FIELD rtda005 name="query.b.page1.rtda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtda005
            
            #add-point:AFTER FIELD rtda005 name="query.a.page1.rtda005"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page2.rtdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdaownid
            #add-point:ON ACTION controlp INFIELD rtdaownid name="construct.c.page2.rtdaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdaownid  #顯示到畫面上
            NEXT FIELD rtdaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdaownid
            #add-point:BEFORE FIELD rtdaownid name="query.b.page2.rtdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdaownid
            
            #add-point:AFTER FIELD rtdaownid name="query.a.page2.rtdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdaowndp
            #add-point:ON ACTION controlp INFIELD rtdaowndp name="construct.c.page2.rtdaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdaowndp  #顯示到畫面上
            NEXT FIELD rtdaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdaowndp
            #add-point:BEFORE FIELD rtdaowndp name="query.b.page2.rtdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdaowndp
            
            #add-point:AFTER FIELD rtdaowndp name="query.a.page2.rtdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdacrtid
            #add-point:ON ACTION controlp INFIELD rtdacrtid name="construct.c.page2.rtdacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdacrtid  #顯示到畫面上
            NEXT FIELD rtdacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdacrtid
            #add-point:BEFORE FIELD rtdacrtid name="query.b.page2.rtdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdacrtid
            
            #add-point:AFTER FIELD rtdacrtid name="query.a.page2.rtdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdacrtdp
            #add-point:ON ACTION controlp INFIELD rtdacrtdp name="construct.c.page2.rtdacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdacrtdp  #顯示到畫面上
            NEXT FIELD rtdacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdacrtdp
            #add-point:BEFORE FIELD rtdacrtdp name="query.b.page2.rtdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdacrtdp
            
            #add-point:AFTER FIELD rtdacrtdp name="query.a.page2.rtdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdacrtdt
            #add-point:BEFORE FIELD rtdacrtdt name="query.b.page2.rtdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdamodid
            #add-point:ON ACTION controlp INFIELD rtdamodid name="construct.c.page2.rtdamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdamodid  #顯示到畫面上
            NEXT FIELD rtdamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdamodid
            #add-point:BEFORE FIELD rtdamodid name="query.b.page2.rtdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdamodid
            
            #add-point:AFTER FIELD rtdamodid name="query.a.page2.rtdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdamoddt
            #add-point:BEFORE FIELD rtdamoddt name="query.b.page2.rtdamoddt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc ON rtdastus,rtda001,rtda002,rtda003,rtda004,rtda0052,rtdal003,rtdal004,rtda006,rtda007 #是否參與異常商品統計 lanjj add rtda007 on 2016-04-26 顧問 裴軍
         
 
         FROM s_detail3[1].rtdastus,s_detail3[1].rtda001,
         s_detail3[1].rtda002,s_detail3[1].rtda003,s_detail3[1].rtda004,s_detail3[1].rtda0052,
         s_detail3[1].rtdal003,s_detail3[1].rtdal004,s_detail3[1].rtda006,s_detail3[1].rtda007
   
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtdastus
            #add-point:BEFORE FIELD rtdastus

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdastus
            
            #add-point:AFTER FIELD rtdastus

            #END add-point
            
 
         #Ctrlp:query.c.page1.rtdastus
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdastus
            #add-point:ON ACTION controlp INFIELD rtdastus

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda001
            #add-point:BEFORE FIELD rtda005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda001
            
            #add-point:AFTER FIELD rtda005

            #END add-point
            
 
         #Ctrlp:query.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda001
            #add-point:ON ACTION controlp INFIELD rtda001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtda001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtda001  #顯示到畫面上
            NEXT FIELD rtda001  
            #END add-point
 
  
         
                
 
      
            
 
         #Ctrlp:construct.c.page2.rtdacrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda002
            #add-point:ON ACTION controlp INFIELD rtda002
            #應用 a08 樣板自動產生(Version:2)
         
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda002
            #add-point:BEFORE FIELD rtda002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda002
            
            #add-point:AFTER FIELD rtda002

            #END add-point
            
 
         #Ctrlp:construct.c.page2.rtdacrtdp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda003
            #add-point:ON ACTION controlp INFIELD rtda003
            #應用 a08 樣板自動產生(Version:2)
    
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda003
            #add-point:BEFORE FIELD rtda003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda003
            
            #add-point:AFTER FIELD rtda003

            #END add-point
            
            #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda004
            #add-point:ON ACTION controlp INFIELD rtda005
     
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda004
            #add-point:BEFORE FIELD rtda004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda004
            
            #add-point:AFTER FIELD rtda004

            #END add-point    
            
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda0052
            #add-point:ON ACTION controlp INFIELD rtda005
     
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda0052
            #add-point:BEFORE FIELD rtda005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda0052
            
            #add-point:AFTER FIELD rtda005

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
    
   CALL arti036_b_fill_2()
   
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
    
   CALL arti036_b_fill(g_wc2)
   LET g_data_owner = g_rtda2_d[g_detail_idx].rtdaownid   #(ver:35)
   LET g_data_dept = g_rtda2_d[g_detail_idx].rtdaowndp   #(ver:35)
 
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
 
{<section id="arti036.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti036_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL arti036_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti036.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti036_modify()
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
   DEFINE  l_rtda002              LIKE rtda_t.rtda002
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
      INPUT ARRAY g_rtda_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtda_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL arti036_b_fill(g_wc2)
            LET g_detail_cnt = g_rtda_d.getLength()
         
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
            DISPLAY g_rtda_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtda_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtda_d[l_ac].rtda001 IS NOT NULL
               AND g_rtda_d[l_ac].rtda005 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtda_d_t.* = g_rtda_d[l_ac].*  #BACKUP
               LET g_rtda_d_o.* = g_rtda_d[l_ac].*  #BACKUP
               IF NOT arti036_lock_b("rtda_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti036_bcl INTO g_rtda_d[l_ac].rtda001,g_rtda_d[l_ac].rtda005,g_rtda2_d[l_ac].rtda001, 
                      g_rtda2_d[l_ac].rtda005,g_rtda2_d[l_ac].rtdaownid,g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid, 
                      g_rtda2_d[l_ac].rtdacrtdp,g_rtda2_d[l_ac].rtdacrtdt,g_rtda2_d[l_ac].rtdamodid, 
                      g_rtda2_d[l_ac].rtdamoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtda_d_t.rtda001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtda_d_mask_o[l_ac].* =  g_rtda_d[l_ac].*
                  CALL arti036_rtda_t_mask()
                  LET g_rtda_d_mask_n[l_ac].* =  g_rtda_d[l_ac].*
                  
                  CALL arti036_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti036_set_entry_b(l_cmd)
            CALL arti036_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
#            CALL arti036_set_entry_b(l_cmd)
#            CALL arti036_set_no_entry_b(l_cmd)
#            CALL arti036_b_fill(g_wc2)
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
            INITIALIZE g_rtda_d_t.* TO NULL
            INITIALIZE g_rtda_d_o.* TO NULL
            INITIALIZE g_rtda_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtda2_d[l_ac].rtdaownid = g_user
      LET g_rtda2_d[l_ac].rtdaowndp = g_dept
      LET g_rtda2_d[l_ac].rtdacrtid = g_user
      LET g_rtda2_d[l_ac].rtdacrtdp = g_dept 
      LET g_rtda2_d[l_ac].rtdacrtdt = cl_get_current()
      LET g_rtda2_d[l_ac].rtdamodid = g_user
      LET g_rtda2_d[l_ac].rtdamoddt = cl_get_current()
 
 
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body.before_bak"
           
            #end add-point
            LET g_rtda_d_t.* = g_rtda_d[l_ac].*     #新輸入資料
            LET g_rtda_d_o.* = g_rtda_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtda_d[li_reproduce_target].* = g_rtda_d[li_reproduce].*
               LET g_rtda2_d[li_reproduce_target].* = g_rtda2_d[li_reproduce].*
 
               LET g_rtda_d[g_rtda_d.getLength()].rtda001 = NULL
               LET g_rtda_d[g_rtda_d.getLength()].rtda005 = NULL
 
            END IF
            
 
 
            CALL arti036_set_entry_b(l_cmd)
            CALL arti036_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
           LET g_rtda_d[l_ac].rtda001 = g_rtda3_d[g_detail_idx1].rtda001
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
            SELECT COUNT(1) INTO l_count FROM rtda_t 
             WHERE rtdaent = g_enterprise AND rtda001 = g_rtda_d[l_ac].rtda001
                                       AND rtda005 = g_rtda_d[l_ac].rtda005
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtda_d[g_detail_idx].rtda001
               LET gs_keys[2] = g_rtda_d[g_detail_idx].rtda005
               CALL arti036_insert_b('rtda_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtda_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtda_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti036_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (rtda001 = '", g_rtda_d[l_ac].rtda001, "' "
                                  ," AND rtda005 = '", g_rtda_d[l_ac].rtda005, "' "
 
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
               
               DELETE FROM rtda_t
                WHERE rtdaent = g_enterprise AND 
                      rtda001 = g_rtda_d_t.rtda001
                      AND rtda005 = g_rtda_d_t.rtda005
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtda_t:",SQLERRMESSAGE 
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
                  CALL arti036_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_rtda_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE arti036_bcl
               #add-point:單身關閉bcl name="input.body.close"
              
               #end add-point
               LET l_count = g_rtda_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtda_d_t.rtda001
               LET gs_keys[2] = g_rtda_d_t.rtda005
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti036_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
            
               #end add-point
                              CALL arti036_delete_b('rtda_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtda_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtda001
            #add-point:BEFORE FIELD rtda001 name="input.b.page1.rtda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtda001
            
            #add-point:AFTER FIELD rtda001 name="input.a.page1.rtda001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtda_d[g_detail_idx].rtda001 IS NOT NULL AND g_rtda_d[g_detail_idx].rtda005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtda_d[g_detail_idx].rtda001 != g_rtda_d_t.rtda001 OR g_rtda_d[g_detail_idx].rtda005 != g_rtda_d_t.rtda005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtda_t WHERE "||"rtdaent = '" ||g_enterprise|| "' AND "||"rtda001 = '"||g_rtda_d[g_detail_idx].rtda001 ||"' AND "|| "rtda005 = '"||g_rtda_d[g_detail_idx].rtda005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtda001
            #add-point:ON CHANGE rtda001 name="input.g.page1.rtda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtda005
            
            #add-point:AFTER FIELD rtda005 name="input.a.page1.rtda005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtda_d[g_detail_idx].rtda001 IS NOT NULL AND g_rtda_d[g_detail_idx].rtda005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtda_d[g_detail_idx].rtda001 != g_rtda_d_t.rtda001 OR g_rtda_d[g_detail_idx].rtda005 != g_rtda_d_t.rtda005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtda_t WHERE "||"rtdaent = '" ||g_enterprise|| "' AND "||"rtda001 = '"||g_rtda_d[g_detail_idx].rtda001 ||"' AND "|| "rtda005 = '"||g_rtda_d[g_detail_idx].rtda005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_rtda_d[l_ac].rtda005) THEN 
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '6765'
               LET g_chkparam.arg2 = g_rtda_d[l_ac].rtda005
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_gzcb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_rtda_d[l_ac].rtda005 = g_rtda_d_t.rtda005
                  LET g_rtda_d[l_ac].rtda005_desc = ""
                  DISPLAY BY NAME g_rtda_d[l_ac].rtda005,g_rtda_d[l_ac].rtda005_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtda_d[l_ac].rtda005
            CALL ap_ref_array2(g_ref_fields," SELECT gzzal003 FROM gzzal_t WHERE  gzzal001 = ? AND gzzal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtda_d[l_ac].rtda005_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_rtda_d[l_ac].rtda005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtda005
            #add-point:BEFORE FIELD rtda005 name="input.b.page1.rtda005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtda005
            #add-point:ON CHANGE rtda005 name="input.g.page1.rtda005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtda001
            #add-point:ON ACTION controlp INFIELD rtda001 name="input.c.page1.rtda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtda005
            #add-point:ON ACTION controlp INFIELD rtda005 name="input.c.page1.rtda005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtda_d[l_ac].rtda005             #給予default值
            LET g_qryparam.default2 = g_rtda_d[l_ac].rtda005_desc  #程式名稱
            #給予arg
            LET g_qryparam.arg1 = "6765" #

            
            CALL q_gzcb002_01()                                #呼叫開窗

            LET g_rtda_d[l_ac].rtda005 = g_qryparam.return1              
            LET g_rtda_d[l_ac].rtda005_desc = g_qryparam.return2 
            DISPLAY g_rtda_d[l_ac].rtda005 TO rtda005              #
            DISPLAY g_rtda_d[l_ac].rtda005_desc TO rtda005_desc #程式名稱
            NEXT FIELD rtda005     
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE arti036_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_rtda_d[l_ac].* = g_rtda_d_t.*
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
               LET g_errparam.extend = g_rtda_d[l_ac].rtda001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtda_d[l_ac].* = g_rtda_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtda2_d[l_ac].rtdamodid = g_user 
LET g_rtda2_d[l_ac].rtdamoddt = cl_get_current()
LET g_rtda2_d[l_ac].rtdamodid_desc = cl_get_username(g_rtda2_d[l_ac].rtdamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti036_rtda_t_mask_restore('restore_mask_o')
 
               UPDATE rtda_t SET (rtda001,rtda005,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt, 
                   rtdamodid,rtdamoddt) = (g_rtda_d[l_ac].rtda001,g_rtda_d[l_ac].rtda005,g_rtda2_d[l_ac].rtdaownid, 
                   g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp,g_rtda2_d[l_ac].rtdacrtdt, 
                   g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt)
                WHERE rtdaent = g_enterprise AND
                  rtda001 = g_rtda_d_t.rtda001 #項次   
                  AND rtda005 = g_rtda_d_t.rtda005  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtda_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtda_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtda_d[g_detail_idx].rtda001
               LET gs_keys_bak[1] = g_rtda_d_t.rtda001
               LET gs_keys[2] = g_rtda_d[g_detail_idx].rtda005
               LET gs_keys_bak[2] = g_rtda_d_t.rtda005
               CALL arti036_update_b('rtda_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtda_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtda_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL arti036_rtda_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti036_unlock_b("rtda_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtda_d[l_ac].* = g_rtda_d_t.*
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
               LET g_rtda_d[li_reproduce_target].* = g_rtda_d[li_reproduce].*
               LET g_rtda2_d[li_reproduce_target].* = g_rtda2_d[li_reproduce].*
 
               LET g_rtda_d[li_reproduce_target].rtda001 = NULL
               LET g_rtda_d[li_reproduce_target].rtda005 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtda_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtda_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_rtda2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL arti036_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body2.action"
            LET g_detail_cnt = g_rtda2_d.getLength() 
            DISPLAY g_detail_cnt TO FORMONLY.cnt
            CALL arti036_b_fill(g_wc2)
         #end add-point
            
      END DISPLAY
 
      
      #add-point:before_more_input name="input.more_input"
     INPUT ARRAY g_rtda3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_detail_cnt2,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF NOT cl_null(g_rtda3_d[l_ac1].rtda001) THEN
                  CALL n_rtdal(g_rtda3_d[l_ac1].rtda001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtda3_d[l_ac1].rtda001
                  CALL ap_ref_array2(g_ref_fields," SELECT rtdal003,rtdal004 FROM rtdal_t WHERE rtdalent = '"||g_enterprise||"' AND rtdal001 = ? AND rtdal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rtda3_d[l_ac1].rtdal003 = g_rtn_fields[1]
                  LET g_rtda3_d[l_ac1].rtdal004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_rtda3_d[l_ac1].rtdal003,g_rtda3_d[l_ac1].rtdal003
               END IF
               #END add-point
            END IF
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtda3_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
 
            CALL arti036_b_fill_2()
            LET g_detail_cnt2 = g_rtda3_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET g_detail_idx1 = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac1 = g_detail_idx1
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
            DISPLAY g_rtda3_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt2 = g_rtda3_d.getLength()
            
            IF g_detail_cnt2 >= l_ac1 
               AND g_rtda3_d[l_ac1].rtda001 IS NOT NULL
               AND g_rtda3_d[l_ac1].rtda005 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtda3_d_t.* = g_rtda3_d[l_ac1].*  #BACKUP
               LET g_rtda3_d_o.* = g_rtda3_d[l_ac1].*  #BACKUP
               IF NOT arti036_lock_b_2("rtda_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti036_bcl2 INTO g_rtda3_d[l_ac1].rtdastus,g_rtda3_d[l_ac1].rtda001,
                  g_rtda3_d[l_ac1].rtdal003,g_rtda3_d[l_ac1].rtdal004,g_rtda3_d[l_ac1].rtda002,
                  g_rtda3_d[l_ac1].rtda003,g_rtda3_d[l_ac1].rtda004,g_rtda3_d[l_ac1].rtda005,g_rtda3_d[l_ac1].rtda006,g_rtda3_d[l_ac1].rtda007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtda3_d_t.rtda001 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL arti036_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            CALL arti036_set_entry_b(l_cmd)
            CALL arti036_set_no_entry_b(l_cmd)
            CALL arti036_b_fill(g_wc2)
      
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rtdalent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rtdal001'
            LET l_var_keys[02] = g_rtda3_d[l_ac1].rtda001
            LET l_field_keys[03] = 'rtdal002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rtdal_t') THEN
               RETURN 
            END IF 
        
         BEFORE INSERT
            
            CALL s_transaction_begin()
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtda3_d_t.* TO NULL
            INITIALIZE g_rtda3_d_o.* TO NULL
            INITIALIZE g_rtda3_d[l_ac1].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
            
            
            LET l_ac = g_detail_idx 
      SELECT MAX(rtda002) 
            INTO l_rtda002
            FROM rtda_t 
           WHERE rtdaent = g_enterprise  #160905-00007#14 add 
      LET g_rtda3_d[l_ac1].rtdastus = 'Y'     
      LET g_rtda3_d[l_ac1].rtda002 = l_rtda002+1
      LET g_rtda2_d[l_ac].rtdaownid = g_user
      LET g_rtda2_d[l_ac].rtdaowndp = g_dept
      LET g_rtda2_d[l_ac].rtdacrtid = g_user
      LET g_rtda2_d[l_ac].rtdacrtdp = g_dept 
      LET g_rtda2_d[l_ac].rtdacrtdt = cl_get_current()
      LET g_rtda2_d[l_ac].rtdamodid = g_user
      LET g_rtda2_d[l_ac].rtdamoddt = cl_get_current()
      LET g_rtda3_d[l_ac1].rtda005 = ' '
      #160513-00022#1   2016/05/16  by 07959 add(S)
      LET g_rtda3_d[l_ac1].rtda007 = 'N'     #是否参与异常商品栏位需要给默认值
      #160513-00022#1   2016/05/16  by 07959 add(E)
            #自定義預設值(單身2)
            LET g_rtda3_d[l_ac1].rtdastus = 'Y'
            LET g_rtda3_d[l_ac1].rtda006 = '1'
            #add-point:modify段before備份

            #end add-point
            LET g_rtda3_d_t.* = g_rtda3_d[l_ac1].*     #新輸入資料
            LET g_rtda3_d_o.* = g_rtda3_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL arti036_set_entry_b("a")
            CALL arti036_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtda_d[li_reproduce_target].* = g_rtda_d[li_reproduce].*
               LET g_rtda2_d[li_reproduce_target].* = g_rtda2_d[li_reproduce].*
               LET g_rtda3_d[li_reproduce_target].* = g_rtda3_d[li_reproduce].*
 
               LET g_rtda3_d[g_rtda_d.getLength()].rtda001 = NULL
               LET g_rtda3_d[g_rtda_d.getLength()].rtda005 = NULL
 
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
            SELECT COUNT(*) INTO l_count FROM rtda_t 
             WHERE rtdaent = g_enterprise AND rtda001 = g_rtda3_d[l_ac1].rtda001
                                       AND rtda005 = g_rtda3_d[l_ac1].rtda005
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
#               LET g_rtda3_d[g_detail_idx].rtda005 = ' '
               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtda3_d[g_detail_idx1].rtda001
               LET gs_keys[2] = g_rtda3_d[g_detail_idx1].rtda005
               CALL arti036_insert_b_2('rtda_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_rtda3_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtda_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti036_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_rtda3_d[l_ac1].rtda001 = g_detail_multi_table_t.rtdal001 AND
               g_rtda3_d[l_ac1].rtdal003 = g_detail_multi_table_t.rtdal003 AND
               g_rtda3_d[l_ac1].rtdal004 = g_detail_multi_table_t.rtdal004 THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'rtdalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_rtda3_d[l_ac1].rtda001
                  LET l_field_keys[02] = 'rtdal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdal001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'rtdal002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdal002
                  LET l_vars[01] = g_rtda3_d[l_ac1].rtdal003
                  LET l_fields[01] = 'rtdal003'
                  LET l_vars[02] = g_rtda3_d[l_ac1].rtdal004
                  LET l_fields[02] = 'rtdal004'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdal_t')
               END IF 
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt2 = g_detail_cnt2 + 1
               
               LET g_wc2 = g_wc2, " OR (rtda001 = '", g_rtda3_d[l_ac1].rtda001, "' "
                                  ," AND rtda005 = '", g_rtda3_d[l_ac1].rtda005, "' "
 
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
               
               DELETE FROM rtda_t
                WHERE rtdaent = g_enterprise AND 
                      rtda001 = g_rtda3_d_t.rtda001
                      
 
                      
               #add-point:單身刪除中

               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtda_t" 
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
               CLOSE arti036_bcl2
               #add-point:單身關閉bcl

               #end add-point
               LET l_count = g_rtda3_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtda3_d_t.rtda001
               LET gs_keys[2] = g_rtda3_d_t.rtda005
 
               #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL arti036_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL arti036_delete_b('rtda_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac1 = (g_rtda3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac1-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda001
            #add-point:BEFORE FIELD rtda001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda001
            
            #add-point:AFTER FIELD rtda001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtda3_d[g_detail_idx1].rtda001 IS NOT NULL AND g_rtda3_d[g_detail_idx1].rtda005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtda3_d[g_detail_idx1].rtda001 != g_rtda3_d_t.rtda001 OR g_rtda3_d[g_detail_idx1].rtda005 != g_rtda3_d_t.rtda005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtda_t WHERE "||"rtdaent = '" ||g_enterprise|| "' AND "||"rtda001 = '"||g_rtda3_d[g_detail_idx1].rtda001 ||"' AND "|| "rtda005 = '"||g_rtda3_d[g_detail_idx1].rtda005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtda001
            #add-point:ON CHANGE rtda001

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda0052
            
            #add-point:AFTER FIELD rtda005
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  g_rtda3_d[g_detail_idx1].rtda001 IS NOT NULL AND g_rtda3_d[g_detail_idx1].rtda005 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtda3_d[g_detail_idx1].rtda001 != g_rtda3_d_t.rtda001 OR g_rtda3_d[g_detail_idx1].rtda005 != g_rtda3_d_t.rtda005)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtda_t WHERE "||"rtdaent = '" ||g_enterprise|| "' AND "||"rtda001 = '"||g_rtda3_d[g_detail_idx1].rtda001 ||"' AND "|| "rtda005 = '"||g_rtda3_d[g_detail_idx1].rtda005 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD rtda0052
            #add-point:BEFORE FIELD rtda005

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtda0052
            #add-point:ON CHANGE rtda005

            #END add-point 
 
         
         BEFORE FIELD rtdal003
            #add-point:BEFORE FIELD rtda001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdal003
            
            #add-point:AFTER FIELD rtda001
            #應用 a05 樣板自動產生(Version:2)
       
          

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdal003
            #add-point:ON CHANGE rtda001

            #END add-point 
         
         BEFORE FIELD rtdal004
            #add-point:BEFORE FIELD rtda001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtdal004
            
            #add-point:AFTER FIELD rtda001
            #應用 a05 樣板自動產生(Version:2)
       
          

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtdal004
            #add-point:ON CHANGE rtda001

            #END add-point    
         
         BEFORE FIELD rtda002
            #add-point:BEFORE FIELD rtda001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda002
            
            #add-point:AFTER FIELD rtda001
            #應用 a05 樣板自動產生(Version:2)
       
           IF NOT cl_null(g_rtda3_d[g_detail_idx1].rtda002) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtda3_d[g_detail_idx1].rtda002 != g_rtda3_d_t.rtda002 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtda_t WHERE "||"rtdaent = '" ||g_enterprise|| "' AND "||"rtda002 = '"||g_rtda3_d[g_detail_idx1].rtda002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
           END IF 

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtda002
            #add-point:ON CHANGE rtda001

            #END add-point 
         
         BEFORE FIELD rtda003
            #add-point:BEFORE FIELD rtda001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda003
            
            #add-point:AFTER FIELD rtda001
            #應用 a05 樣板自動產生(Version:2)
            
            CALL arti036_set_entry_b(l_cmd)
            CALL arti036_set_no_entry_b(l_cmd)
#            IF g_rtda3_d[g_detail_idx1].rtda003 = 2 THEN 
#               NEXT FIELD rtda004
#            END IF 
          

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtda003
            #add-point:ON CHANGE rtda001
            IF g_rtda3_d[g_detail_idx1].rtda003 <> 2 THEN 
               LET g_rtda3_d[g_detail_idx1].rtda004 = ''
            END IF 
            
            CALL arti036_set_entry_b(l_cmd)
            CALL arti036_set_no_entry_b(l_cmd)
            
            #END add-point 
         
         BEFORE FIELD rtda004
            #add-point:BEFORE FIELD rtda001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD rtda004
            
            #add-point:AFTER FIELD rtda001
            #應用 a05 樣板自動產生(Version:2)
            IF g_rtda3_d[g_detail_idx1].rtda004 <= 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00496'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE rtda004
            #add-point:ON CHANGE rtda001

            #END add-point 
         
         #Ctrlp:input.c.page1.rtda001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda001
            #add-point:ON ACTION controlp INFIELD rtda001

            #END add-point
 
         #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda0052
            #add-point:ON ACTION controlp INFIELD rtda005

            #END add-point
        
        #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdal003
            #add-point:ON ACTION controlp INFIELD rtda005

            #END add-point
         
         #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtdal004
            #add-point:ON ACTION controlp INFIELD rtda005

            #END add-point
         
         #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda002
            #add-point:ON ACTION controlp INFIELD rtda005

            #END add-point
         
         #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda003
            #add-point:ON ACTION controlp INFIELD rtda005

            #END add-point
            
         #Ctrlp:input.c.page1.rtda005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD rtda004
            #add-point:ON ACTION controlp INFIELD rtda005

            #END add-point   
            
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_rtda_d[l_ac].* = g_rtda_d_t.*
               CLOSE arti036_bcl
               #add-point:單身取消時

               #end add-point
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtda_d[l_ac].rtda001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtda_d[l_ac].* = g_rtda_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtda2_d[l_ac].rtdamodid = g_user 
LET g_rtda2_d[l_ac].rtdamoddt = cl_get_current()
LET g_rtda2_d[l_ac].rtdamodid_desc = cl_get_username(g_rtda2_d[l_ac].rtdamodid)
            
               #add-point:單身修改前

               #end add-point
               
#               UPDATE rtda_t SET (rtdastus,rtda001,rtda005,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt, 
#                   rtdamodid,rtdamoddt) = (g_rtda3_d[l_ac1].rtdastus,g_rtda3_d[l_ac1].rtda001,g_rtda3_d[l_ac1].rtda005,g_rtda2_d[l_ac1].rtdaownid, 
#                   g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp,g_rtda2_d[l_ac].rtdacrtdt, 
#                   g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt)
#                WHERE rtdaent = g_enterprise AND
#                  rtda001 = g_rtda3_d_t.rtda001 #項次   
#                  AND rtda005 = g_rtda3_d_t.rtda005  
 
                  
               UPDATE rtda_t SET (rtdastus,rtda001,rtda002,rtda003,rtda004,rtda006,rtda007,
                   rtdamodid,rtdamoddt) = (g_rtda3_d[l_ac1].rtdastus,g_rtda3_d[l_ac1].rtda001,
                   g_rtda3_d[l_ac1].rtda002,g_rtda3_d[l_ac1].rtda003,g_rtda3_d[l_ac1].rtda004,g_rtda3_d[l_ac1].rtda006,g_rtda3_d[l_ac1].rtda007,               
                   g_rtda2_d[l_ac1].rtdamodid,g_rtda2_d[l_ac1].rtdamoddt)
                WHERE rtdaent = g_enterprise AND
                  rtda001 = g_rtda3_d_t.rtda001 #項次   
                  
                  
               #add-point:單身修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtda_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtda_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtda3_d[g_detail_idx1].rtda001
               LET gs_keys_bak[1] = g_rtda3_d_t.rtda001

               CALL arti036_update_b_2('rtda_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_rtda3_d[l_ac1].rtda001 = g_detail_multi_table_t.rtdal001 AND
               g_rtda3_d[l_ac1].rtdal003 = g_detail_multi_table_t.rtdal003 AND
               g_rtda3_d[l_ac1].rtdal004 = g_detail_multi_table_t.rtdal004 THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'rtdalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_rtda3_d[l_ac1].rtda001
                  LET l_field_keys[02] = 'rtdal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdal001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'rtdal002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdal002
                  LET l_vars[01] = g_rtda3_d[l_ac1].rtdal003
                  LET l_fields[01] = 'rtdal003'
                  LET l_vars[02] = g_rtda3_d[l_ac1].rtdal004
                  LET l_fields[02] = 'rtdal004'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdal_t')
               END IF 
                     
                     
                     LET g_log1 = util.JSON.stringify(g_rtda3_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtda3_d[l_ac1])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti036_unlock_b("rtda_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
             #add-point:單身after row
            IF l_cmd = 'a' THEN
               NEXT FIELD rtda005
            END IF
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_rtda_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_rtda_d.getLength()+1
            
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
               NEXT FIELD rtda001
            WHEN "s_detail2"
               NEXT FIELD rtda001_2
 
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
      IF INT_FLAG OR cl_null(g_rtda_d[g_detail_idx].rtda001) THEN
         CALL g_rtda_d.deleteElement(g_detail_idx)
         CALL g_rtda2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_rtda_d[g_detail_idx].* = g_rtda_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   CALL arti036_b_fill_2()

   #end add-point
 
   CLOSE arti036_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="arti036.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti036_delete()
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
   FOR li_idx = 1 TO g_rtda_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT arti036_lock_b("rtda_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("rtda_t","rtdaownid") THEN
            LET g_data_owner = g_rtda2_d[g_detail_idx].rtdaownid
            LET g_data_dept = g_rtda2_d[g_detail_idx].rtdaowndp
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
   
   FOR li_idx = 1 TO g_rtda_d.getLength()
      IF g_rtda_d[li_idx].rtda001 IS NOT NULL
         AND g_rtda_d[li_idx].rtda005 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM rtda_t
          WHERE rtdaent = g_enterprise AND 
                rtda001 = g_rtda_d[li_idx].rtda001
                AND rtda005 = g_rtda_d[li_idx].rtda005
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtda_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_rtda_d_t.rtda001
               LET gs_keys[2] = g_rtda_d_t.rtda005
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL arti036_delete_b('rtda_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti036_set_pk_array()
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
   CALL arti036_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="arti036.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti036_b_fill(p_wc2)              #BODY FILL UP
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

   CALL g_rtda_d.clear()
   CALL g_rtda2_d.clear()
   #判定單頭是否有資料
   
   
  
   IF cl_null(g_rtda3_d[g_detail_idx1].rtda001) THEN
      RETURN
   END IF
   
   
   
   LET g_sql = "SELECT  UNIQUE t0.rtda001,t0.rtda005,t0.rtda001,t0.rtda005,t0.rtdaownid,t0.rtdaowndp, 
       t0.rtdacrtid,t0.rtdacrtdp,t0.rtdacrtdt,t0.rtdamodid,t0.rtdamoddt ,t1.gzzal003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM rtda_t t0",
               "",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.rtda005 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.rtdaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.rtdaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.rtdacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.rtdacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.rtdamodid  ",
 
               " WHERE t0.rtdaent= ? AND t0.rtda001=?  AND  1=1 AND (", p_wc2, ") " 
             
  
 
   LET g_sql = g_sql, cl_sql_add_filter("rtda_t"),
                      " ORDER BY t0.rtda001,t0.rtda005"
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti036_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR arti036_pb3
   
   OPEN b_fill_curs3 USING g_enterprise,g_rtda3_d[g_detail_idx1].rtda001
 
   CALL g_rtda_d.clear()
   CALL g_rtda2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs3 INTO g_rtda_d[l_ac].rtda001,g_rtda_d[l_ac].rtda005,g_rtda2_d[l_ac].rtda001,g_rtda2_d[l_ac].rtda005, 
       g_rtda2_d[l_ac].rtdaownid,g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp, 
       g_rtda2_d[l_ac].rtdacrtdt,g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt,g_rtda_d[l_ac].rtda005_desc, 
       g_rtda2_d[l_ac].rtdaownid_desc,g_rtda2_d[l_ac].rtdaowndp_desc,g_rtda2_d[l_ac].rtdacrtid_desc, 
       g_rtda2_d[l_ac].rtdacrtdp_desc,g_rtda2_d[l_ac].rtdamodid_desc
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
      
      CALL arti036_detail_show()      
 
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
   
 
   
   CALL g_rtda_d.deleteElement(g_rtda_d.getLength())   
   CALL g_rtda2_d.deleteElement(g_rtda2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtda_d.getLength()
      LET g_rtda2_d[l_ac].rtda001 = g_rtda_d[l_ac].rtda001 
      LET g_rtda2_d[l_ac].rtda005 = g_rtda_d[l_ac].rtda005 
 
   END FOR
   
   IF g_cnt > g_rtda_d.getLength() THEN
      LET l_ac = g_rtda_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #add-point:b_fill段資料填充(其他單身)
    
   #end add-point
   
   ERROR "" 
 

   
   CLOSE b_fill_curs3
   FREE arti036_pb3
   
   RETURN 
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.rtda001,t0.rtda005,t0.rtda001,t0.rtda005,t0.rtdaownid,t0.rtdaowndp, 
       t0.rtdacrtid,t0.rtdacrtdp,t0.rtdacrtdt,t0.rtdamodid,t0.rtdamoddt ,t1.gzzal003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM rtda_t t0",
               "",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.rtda005 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtdaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtdaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtdacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtdacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtdamodid  ",
 
               " WHERE t0.rtdaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("rtda_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND rtdaowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("rtda_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND rtdaownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtda_t"),
                      " ORDER BY t0.rtda001,t0.rtda005"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtda_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti036_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR arti036_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtda_d.clear()
   CALL g_rtda2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtda_d[l_ac].rtda001,g_rtda_d[l_ac].rtda005,g_rtda2_d[l_ac].rtda001,g_rtda2_d[l_ac].rtda005, 
       g_rtda2_d[l_ac].rtdaownid,g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp, 
       g_rtda2_d[l_ac].rtdacrtdt,g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt,g_rtda_d[l_ac].rtda005_desc, 
       g_rtda2_d[l_ac].rtdaownid_desc,g_rtda2_d[l_ac].rtdaowndp_desc,g_rtda2_d[l_ac].rtdacrtid_desc, 
       g_rtda2_d[l_ac].rtdacrtdp_desc,g_rtda2_d[l_ac].rtdamodid_desc
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
      
      CALL arti036_detail_show()      
 
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
   
 
   
   CALL g_rtda_d.deleteElement(g_rtda_d.getLength())   
   CALL g_rtda2_d.deleteElement(g_rtda2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtda_d.getLength()
      LET g_rtda2_d[l_ac].rtda001 = g_rtda_d[l_ac].rtda001 
      LET g_rtda2_d[l_ac].rtda005 = g_rtda_d[l_ac].rtda005 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_rtda_d.getLength() THEN
      LET l_ac = g_rtda_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtda_d.getLength()
      LET g_rtda_d_mask_o[l_ac].* =  g_rtda_d[l_ac].*
      CALL arti036_rtda_t_mask()
      LET g_rtda_d_mask_n[l_ac].* =  g_rtda_d[l_ac].*
   END FOR
   
   LET g_rtda2_d_mask_o.* =  g_rtda2_d.*
   FOR l_ac = 1 TO g_rtda2_d.getLength()
      LET g_rtda2_d_mask_o[l_ac].* =  g_rtda2_d[l_ac].*
      CALL arti036_rtda_t_mask()
      LET g_rtda2_d_mask_n[l_ac].* =  g_rtda2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL arti036_b_fill_2()      
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_rtda_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE arti036_pb
   
END FUNCTION
 
{</section>}
 
{<section id="arti036.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION arti036_detail_show()
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
 
{<section id="arti036.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti036_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("rtda004",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="arti036.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti036_set_no_entry_b(p_cmd)                                               
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
   IF g_rtda3_d[g_detail_idx1].rtda003 <> 2 THEN
      CALL cl_set_comp_entry("rtda004",FALSE)
   END IF
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="arti036.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti036_default_search()
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
      LET ls_wc = ls_wc, " rtda001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtda005 = '", g_argv[02], "' AND "
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
 
{<section id="arti036.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti036_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "rtda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtda_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM rtda_t
          WHERE rtdaent = g_enterprise AND
            rtda001 = ps_keys_bak[1] AND rtda005 = ps_keys_bak[2]
         
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
         CALL g_rtda_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_rtda2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti036.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti036_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_rtda005   LIKE rtda_t.rtda005 
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "rtda_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      SELECT rtda005 
        INTO l_rtda005
        FROM rtda_t
       WHERE rtda001 = g_rtda3_d[l_ac1].rtda001 
         AND rtdaent = g_enterprise   #160905-00007#14  add 
      IF  l_rtda005 = ' ' THEN  
          UPDATE rtda_t SET (rtda005) = (g_rtda_d[l_ac].rtda005)
                WHERE rtdaent = g_enterprise AND
                  rtda001 = g_rtda3_d[l_ac1].rtda001 
                  
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "rtda_t" 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = FALSE 
             CALL cl_err()
 
          END IF    
          RETURN           
      END IF 
      
  
      INSERT INTO rtda_t
                  (rtdaent,rtdastus,rtda002,rtda003,rtda004,rtda006,rtda007,
                   rtda001,rtda005
                   ,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt,rtdamodid,rtdamoddt) 
            VALUES(g_enterprise,g_rtda3_d[g_detail_idx1].rtdastus
                ,g_rtda3_d[g_detail_idx1].rtda002,g_rtda3_d[g_detail_idx1].rtda003,g_rtda3_d[g_detail_idx1].rtda004,g_rtda3_d[g_detail_idx1].rtda006,g_rtda3_d[g_detail_idx1].rtda007,
                   ps_keys[1],ps_keys[2]
                   ,g_rtda2_d[l_ac].rtdaownid,g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp, 
                       g_rtda2_d[l_ac].rtdacrtdt,g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt) 

      #add-point:insert_b段新增中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtda_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      
      RETURN
      #end add-point    
      INSERT INTO rtda_t
                  (rtdaent,
                   rtda001,rtda005
                   ,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt,rtdamodid,rtdamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtda2_d[l_ac].rtdaownid,g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp, 
                       g_rtda2_d[l_ac].rtdacrtdt,g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtda_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti036.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti036_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "rtda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtda_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE rtda_t 
         SET (rtda001,rtda005
              ,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt,rtdamodid,rtdamoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtda2_d[l_ac].rtdaownid,g_rtda2_d[l_ac].rtdaowndp,g_rtda2_d[l_ac].rtdacrtid,g_rtda2_d[l_ac].rtdacrtdp, 
                  g_rtda2_d[l_ac].rtdacrtdt,g_rtda2_d[l_ac].rtdamodid,g_rtda2_d[l_ac].rtdamoddt) 
         WHERE rtdaent = g_enterprise AND rtda001 = ps_keys_bak[1] AND rtda005 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtda_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtda_t:",SQLERRMESSAGE 
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
 
{<section id="arti036.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti036_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL arti036_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtda_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN arti036_bcl USING g_enterprise,
                                       g_rtda_d[g_detail_idx].rtda001,g_rtda_d[g_detail_idx].rtda005
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti036_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti036.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti036_unlock_b(ps_table)
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
      CLOSE arti036_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti036.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION arti036_modify_detail_chk(ps_record)
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
         LET ls_return = "rtda001"
      WHEN "s_detail2"
         LET ls_return = "rtda001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="arti036.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION arti036_show_ownid_msg()
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
 
{<section id="arti036.mask_functions" >}
&include "erp/art/arti036_mask.4gl"
 
{</section>}
 
{<section id="arti036.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti036_set_pk_array()
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
   LET g_pk_array[1].values = g_rtda_d[l_ac].rtda001
   LET g_pk_array[1].column = 'rtda001'
   LET g_pk_array[2].values = g_rtda_d[l_ac].rtda005
   LET g_pk_array[2].column = 'rtda005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti036.state_change" >}
   
 
{</section>}
 
{<section id="arti036.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti036.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 单身阵列填充2
# Date & Author..: 2015/03/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION arti036_b_fill_2()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define

   #end add-point
   
   #判定单身1是否有資料

   
   CALL g_rtda3_d.clear()
   
 
   
   LET li_ac = l_ac1 
   
   LET g_sql = "SELECT UNIQUE t0.rtdastus, t0.rtda001,  t2.rtdal003,  t2.rtdal004,
                       t0.rtda002,  t0.rtda003,  t0.rtda004,t0.rtda006,' ',t0.rtda007
                  FROM rtda_t t0",   
               " LEFT JOIN rtdal_t t2 ON t2.rtdalent='"||g_enterprise||"' AND t2.rtdal001=t0.rtda001 AND t2.rtdal002='"||g_dlang||"' ",
               " WHERE t0.rtdaent=?  AND  1=1 AND ", g_wc,
               " AND rtda001 IN (SELECT rtda001 FROM rtda_t WHERE rtdaent= "||g_enterprise||" AND ",g_wc2,")" #160905-00007#14 add  rtdaent="||g_enterprise||"
 
   
 
   LET g_sql = g_sql, " ORDER BY t0.rtda002" 
                      
   #add-point:單身填充前

   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
   PREPARE arti036_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR arti036_pb2
   
   LET l_ac1 = g_detail_idx1
   OPEN b_fill_curs2 USING g_enterprise
   
   LET l_ac1 = 1
   FOREACH b_fill_curs2
      INTO g_rtda3_d[l_ac1].rtdastus,g_rtda3_d[l_ac1].rtda001,g_rtda3_d[l_ac1].rtdal003,
           g_rtda3_d[l_ac1].rtdal004,g_rtda3_d[l_ac1].rtda002,g_rtda3_d[l_ac1].rtda003,
           g_rtda3_d[l_ac1].rtda004,g_rtda3_d[l_ac1].rtda006,g_rtda3_d[l_ac1].rtda005,g_rtda3_d[l_ac1].rtda007
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
      CALL arti036_detail_show()
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
   
   CALL arti036_b_fill(g_wc2)
   #end add-point
   
   CALL g_rtda3_d.deleteElement(g_rtda3_d.getLength())   
   
   
#   LET g_loc = 'd'
   CALL arti036_detail_show()
   LET g_detail_cnt2 = g_rtda3_d.getLength()
   LET l_ac1 = li_ac
   
END FUNCTION

################################################################################
# Descriptions...: lock 单身2
# Date & Author..: 2015/03/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION arti036_lock_b_2(ps_table)
 DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   DEFINE l_rtda005  LIKE rtda_t.rtda005 
   #end add-point   
   #add-point:lock_b段define

   #end add-point
   
   #先刷新資料
   #CALL arti036_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtda_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      SELECT rtda005 
        INTO l_rtda005
        FROM rtda_t 
       WHERE rtda001 =  g_rtda3_d[g_detail_idx1].rtda001
         AND rtdaent = g_enterprise 
      OPEN arti036_bcl2 USING g_dlang,g_enterprise,
                                       g_rtda3_d[g_detail_idx1].rtda001,l_rtda005
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti036_bcl2" 
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
PRIVATE FUNCTION arti036_update_b_2(ps_table,ps_keys,ps_keys_bak,ps_page)
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
      UPDATE rtda_t 
         SET (rtdastus,rtda001,rtda002,rtda003,rtda004,rtda006,rtda007
              ,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt,rtdamodid,rtdamoddt) 
              = 
             (g_rtda3_d[g_detail_idx1].rtdastus,ps_keys[1]
              ,g_rtda3_d[g_detail_idx1].rtda002,g_rtda3_d[g_detail_idx1].rtda003,g_rtda3_d[g_detail_idx1].rtda004,g_rtda3_d[g_detail_idx1].rtda006,g_rtda3_d[g_detail_idx1].rtda007
              ,g_rtda2_d[g_detail_idx1].rtdaownid,g_rtda2_d[g_detail_idx1].rtdaowndp,g_rtda2_d[g_detail_idx1].rtdacrtid,g_rtda2_d[g_detail_idx1].rtdacrtdp, 
                  g_rtda2_d[g_detail_idx1].rtdacrtdt,g_rtda2_d[g_detail_idx1].rtdamodid,g_rtda2_d[g_detail_idx1].rtdamoddt) 
         WHERE rtda001 = ps_keys_bak[1]  AND rtdaent = g_enterprise  #160905-00007#14 add  rtdaent = g_enterprise 
      #add-point:update_b段修改中

      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtda_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtda_t" 
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
PRIVATE FUNCTION arti036_insert_b_2(ps_table,ps_keys,ps_page)
DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define
   DEFINE l_rtda005   LIKE rtda_t.rtda005 
   #end add-point     
   #add-point:insert_b段define

   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "rtda_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前
     
      #end add-point    
      INSERT INTO rtda_t
                  (rtdaent,rtdastus,rtda002,rtda003,rtda004,rtda006,rtda007,
                   rtda001,rtda005
                   ,rtdaownid,rtdaowndp,rtdacrtid,rtdacrtdp,rtdacrtdt,rtdamodid,rtdamoddt) 
            VALUES(g_enterprise,g_rtda3_d[g_detail_idx1].rtdastus
                ,g_rtda3_d[g_detail_idx1].rtda002,g_rtda3_d[g_detail_idx1].rtda003,g_rtda3_d[g_detail_idx1].rtda004,g_rtda3_d[g_detail_idx1].rtda006,g_rtda3_d[g_detail_idx1].rtda007
                   ,ps_keys[1],ps_keys[2]
                   ,g_rtda2_d[g_detail_idx].rtdaownid,g_rtda2_d[g_detail_idx].rtdaowndp,g_rtda2_d[g_detail_idx].rtdacrtid,g_rtda2_d[g_detail_idx].rtdacrtdp, 
                       g_rtda2_d[g_detail_idx].rtdacrtdt,g_rtda2_d[g_detail_idx].rtdamodid,g_rtda2_d[g_detail_idx].rtdamoddt) 

      #add-point:insert_b段新增中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtda_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後

      #end add-point    
   #END IF
END FUNCTION

 
{</section>}
 
