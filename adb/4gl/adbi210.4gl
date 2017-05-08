#該程式未解開Section, 採用最新樣板產出!
{<section id="adbi210.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-01-09 15:23:18), PR版次:0008(2016-09-05 14:55:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000209
#+ Filename...: adbi210
#+ Description: 產品組資料維護作業
#+ Creator....: 04226(2014-04-24 15:03:16)
#+ Modifier...: 06137 -SD/PR- 00700
 
{</section>}
 
{<section id="adbi210.global" >}
#應用 t02 樣板自動產生(Version:46)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#6  160321 By Jessy 修正azzi920重複定義之錯誤訊息
#160318-00025#51 160427 By 07673 將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00003#1 2016/09/05 By Rainy 修正WHERE 條件沒下ent
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
    
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_dbba_d RECORD
       dbbastus LIKE dbba_t.dbbastus, 
   dbba001 LIKE dbba_t.dbba001, 
   dbbal003 LIKE type_t.chr500, 
   dbbal004 LIKE type_t.chr500, 
   dbba002 LIKE dbba_t.dbba002
       END RECORD
PRIVATE TYPE type_g_dbba2_d RECORD
       dbba001 LIKE dbba_t.dbba001, 
   dbbaownid LIKE dbba_t.dbbaownid, 
   dbbaownid_desc LIKE type_t.chr500, 
   dbbaowndp LIKE dbba_t.dbbaowndp, 
   dbbaowndp_desc LIKE type_t.chr500, 
   dbbacrtid LIKE dbba_t.dbbacrtid, 
   dbbacrtid_desc LIKE type_t.chr500, 
   dbbacrtdp LIKE dbba_t.dbbacrtdp, 
   dbbacrtdp_desc LIKE type_t.chr500, 
   dbbacrtdt DATETIME YEAR TO SECOND, 
   dbbamodid LIKE dbba_t.dbbamodid, 
   dbbamodid_desc LIKE type_t.chr500, 
   dbbamoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_dbba3_d RECORD
       dbbbstus LIKE dbbb_t.dbbbstus, 
   dbbb002 LIKE dbbb_t.dbbb002, 
   dbbb003 LIKE dbbb_t.dbbb003, 
   dbbb003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_dbba4_d RECORD
       dbbb003 LIKE dbbb_t.dbbb003, 
   dbbbownid LIKE dbbb_t.dbbbownid, 
   dbbbownid_desc LIKE type_t.chr500, 
   dbbbowndp LIKE dbbb_t.dbbbowndp, 
   dbbbowndp_desc LIKE type_t.chr500, 
   dbbbcrtid LIKE dbbb_t.dbbbcrtid, 
   dbbbcrtid_desc LIKE type_t.chr500, 
   dbbbcrtdp LIKE dbbb_t.dbbbcrtdp, 
   dbbbcrtdp_desc LIKE type_t.chr500, 
   dbbbcrtdt DATETIME YEAR TO SECOND, 
   dbbbmodid LIKE dbbb_t.dbbbmodid, 
   dbbbmodid_desc LIKE type_t.chr500, 
   dbbbmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      dbbal001 LIKE dbbal_t.dbbal001,
      dbbal002 LIKE dbbal_t.dbbal002,
      dbbal003 LIKE dbbal_t.dbbal003,
      dbbal004 LIKE dbbal_t.dbbal004
      END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooaa002   LIKE ooaa_t.ooaa002
DEFINE tok         base.StringTokenizer
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_dbba_d
DEFINE g_master_t                   type_g_dbba_d
DEFINE g_dbba_d          DYNAMIC ARRAY OF type_g_dbba_d
DEFINE g_dbba_d_t        type_g_dbba_d
DEFINE g_dbba_d_o        type_g_dbba_d
DEFINE g_dbba_d_mask_o   DYNAMIC ARRAY OF type_g_dbba_d #轉換遮罩前資料
DEFINE g_dbba_d_mask_n   DYNAMIC ARRAY OF type_g_dbba_d #轉換遮罩後資料
DEFINE g_dbba2_d          DYNAMIC ARRAY OF type_g_dbba2_d
DEFINE g_dbba2_d_t        type_g_dbba2_d
DEFINE g_dbba2_d_o        type_g_dbba2_d
DEFINE g_dbba2_d_mask_o   DYNAMIC ARRAY OF type_g_dbba2_d #轉換遮罩前資料
DEFINE g_dbba2_d_mask_n   DYNAMIC ARRAY OF type_g_dbba2_d #轉換遮罩後資料
DEFINE g_dbba3_d          DYNAMIC ARRAY OF type_g_dbba3_d
DEFINE g_dbba3_d_t        type_g_dbba3_d
DEFINE g_dbba3_d_o        type_g_dbba3_d
DEFINE g_dbba3_d_mask_o   DYNAMIC ARRAY OF type_g_dbba3_d #轉換遮罩前資料
DEFINE g_dbba3_d_mask_n   DYNAMIC ARRAY OF type_g_dbba3_d #轉換遮罩後資料
DEFINE g_dbba4_d          DYNAMIC ARRAY OF type_g_dbba4_d
DEFINE g_dbba4_d_t        type_g_dbba4_d
DEFINE g_dbba4_d_o        type_g_dbba4_d
DEFINE g_dbba4_d_mask_o   DYNAMIC ARRAY OF type_g_dbba4_d #轉換遮罩前資料
DEFINE g_dbba4_d_mask_n   DYNAMIC ARRAY OF type_g_dbba4_d #轉換遮罩後資料
 
      
DEFINE g_wc                 STRING
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             
DEFINE g_ac_last            LIKE type_t.num10             
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_detail_idx         LIKE type_t.num10             #單身所在筆數(第一階單身)
DEFINE g_detail_idx2        LIKE type_t.num10             #單身所在筆數(第二階單身)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身總筆數 (第一階單身)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身總筆數 (第二階單身)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_current_page       LIKE type_t.num10             #判斷單身筆數用
DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adbi210.main" >}
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
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi210 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi210_init()   
 
      #進入選單 Menu (="N")
      CALL adbi210_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi210
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbi210.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi210_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   
      CALL cl_set_combo_scc('dbba002','6059') 
   CALL cl_set_combo_scc('dbbb002','6059') 
 
   LET l_ac = 1
   
LET g_detail_multi_table_t.dbbal001 = g_dbba_d[l_ac].dbba001
LET g_detail_multi_table_t.dbbal002 = g_dlang
LET g_detail_multi_table_t.dbbal003 = g_dbba_d[l_ac].dbbal003
LET g_detail_multi_table_t.dbbal004 = g_dbba_d[l_ac].dbbal004
 
 
   
LET g_detail_multi_table_t.dbbal001 = g_dbba_d[l_ac].dbba001
LET g_detail_multi_table_t.dbbal002 = g_dlang
LET g_detail_multi_table_t.dbbal003 = g_dbba_d[l_ac].dbbal003
LET g_detail_multi_table_t.dbbal004 = g_dbba_d[l_ac].dbbal004
 
 
   
 
 
   
 
 
 
   #避免USER直接進入第二單身時無資料
   IF g_dbba_d.getLength() > 0 THEN
      LET g_master_t.* = g_dbba_d[1].*
      LET g_master.* = g_dbba_d[1].*
   END IF
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_ooaa002 = ''
#   SELECT ooaa002 INTO g_ooaa002
#     FROM ooaa_t
#    WHERE ooaaent = g_enterprise
#      AND ooaa001 = 'E-CIR-0001'
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING g_ooaa002
   LET g_errshow = 1
   #end add-point
   
   CALL adbi210_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi210_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx   LIKE type_t.num10
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
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_dbba_d.clear()
         CALL g_dbba2_d.clear()
         CALL g_dbba3_d.clear()
         CALL g_dbba4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbi210_init()
      END IF
   
      #add-point:ui_dialog段before while name="ui_dialog.before_while"
      LET g_current_page = 0
      #end add-point
   
      CALL adbi210_b_fill(g_wc)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dbba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 1
      
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_master.* = g_dbba_d[g_detail_idx].*
               CALL cl_show_fld_cont()
               LET g_action_choice = "fetch"
               CALL adbi210_fetch()
               CALL adbi210_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL adbi210_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_dbba2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET g_current_page = 2
               
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_master.* = g_dbba_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               LET g_action_choice = "fetch"
               CALL adbi210_fetch()
               CALL adbi210_idx_chk('m')
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL adbi210_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         
         DISPLAY ARRAY g_dbba3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               CALL adbi210_idx_chk('d')
               LET g_master.* = g_dbba_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         DISPLAY ARRAY g_dbba4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET g_current_page = 4
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               CALL adbi210_idx_chk('d')
               LET g_master.* = g_dbba_d[g_detail_idx].*
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_4)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            IF g_detail_idx > 0 THEN
               IF g_detail_idx > g_dbba_d.getLength() THEN
                  LET g_detail_idx = g_dbba_d.getLength()
               END IF
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET l_ac = g_detail_idx
            END IF 
            LET g_detail_idx = l_ac
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point  
            NEXT FIELD CURRENT
        
         AFTER DIALOG
            #add-point:ui_dialog段after dialog name="ui_dialog.after_dialog"
            
            #end add-point
         
      ON ACTION exporttoexcel
         LET g_action_choice="exporttoexcel"
         IF cl_auth_chk_act("exporttoexcel") THEN
            CALL g_export_node.clear()
            LET g_export_node[1] = base.typeInfo.create(g_dbba_d)
            LET g_export_id[1]   = "s_detail1"
            LET g_export_node[2] = base.typeInfo.create(g_dbba2_d)
            LET g_export_id[2]   = "s_detail2"
            LET g_export_node[3] = base.typeInfo.create(g_dbba3_d)
            LET g_export_id[3]   = "s_detail3"
            LET g_export_node[4] = base.typeInfo.create(g_dbba4_d)
            LET g_export_id[4]   = "s_detail4"
 
            #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
            
            #END add-point
            CALL cl_export_to_excel_getpage()
            CALL cl_export_to_excel()
         END IF
         
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adbi210_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi210_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbi210_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
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
            CALL adbi210_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbi210_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbi210_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi210_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_dbba_d.clear()
   CALL g_dbba2_d.clear()
   CALL g_dbba3_d.clear()
   CALL g_dbba4_d.clear()
 
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc
   LET g_detail_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON dbbastus,dbba001,dbbal003,dbbal004,dbba002,dbbaownid,dbbaowndp,dbbacrtid, 
          dbbacrtdp,dbbacrtdt,dbbamodid,dbbamoddt
           FROM s_detail1[1].dbbastus,s_detail1[1].dbba001,s_detail1[1].dbbal003,s_detail1[1].dbbal004, 
               s_detail1[1].dbba002,s_detail2[1].dbbaownid,s_detail2[1].dbbaowndp,s_detail2[1].dbbacrtid, 
               s_detail2[1].dbbacrtdp,s_detail2[1].dbbacrtdt,s_detail2[1].dbbamodid,s_detail2[1].dbbamoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbbacrtdt>>----
         AFTER FIELD dbbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbbamoddt>>----
         AFTER FIELD dbbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbacnfdt>>----
         
         #----<<dbbapstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbastus
            #add-point:BEFORE FIELD dbbastus name="construct.b.page1.dbbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbastus
            
            #add-point:AFTER FIELD dbbastus name="construct.a.page1.dbbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbastus
            #add-point:ON ACTION controlp INFIELD dbbastus name="construct.c.page1.dbbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbba001
            #add-point:ON ACTION controlp INFIELD dbba001 name="construct.c.page1.dbba001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbba001  #顯示到畫面上
            NEXT FIELD dbba001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbba001
            #add-point:BEFORE FIELD dbba001 name="construct.b.page1.dbba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbba001
            
            #add-point:AFTER FIELD dbba001 name="construct.a.page1.dbba001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbal003
            #add-point:BEFORE FIELD dbbal003 name="construct.b.page1.dbbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbal003
            
            #add-point:AFTER FIELD dbbal003 name="construct.a.page1.dbbal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbal003
            #add-point:ON ACTION controlp INFIELD dbbal003 name="construct.c.page1.dbbal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbal004
            #add-point:BEFORE FIELD dbbal004 name="construct.b.page1.dbbal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbal004
            
            #add-point:AFTER FIELD dbbal004 name="construct.a.page1.dbbal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbal004
            #add-point:ON ACTION controlp INFIELD dbbal004 name="construct.c.page1.dbbal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbba002
            #add-point:BEFORE FIELD dbba002 name="construct.b.page1.dbba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbba002
            
            #add-point:AFTER FIELD dbba002 name="construct.a.page1.dbba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbba002
            #add-point:ON ACTION controlp INFIELD dbba002 name="construct.c.page1.dbba002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbaownid
            #add-point:ON ACTION controlp INFIELD dbbaownid name="construct.c.page2.dbbaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbaownid  #顯示到畫面上
            NEXT FIELD dbbaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbaownid
            #add-point:BEFORE FIELD dbbaownid name="construct.b.page2.dbbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbaownid
            
            #add-point:AFTER FIELD dbbaownid name="construct.a.page2.dbbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbaowndp
            #add-point:ON ACTION controlp INFIELD dbbaowndp name="construct.c.page2.dbbaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbaowndp  #顯示到畫面上
            NEXT FIELD dbbaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbaowndp
            #add-point:BEFORE FIELD dbbaowndp name="construct.b.page2.dbbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbaowndp
            
            #add-point:AFTER FIELD dbbaowndp name="construct.a.page2.dbbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbacrtid
            #add-point:ON ACTION controlp INFIELD dbbacrtid name="construct.c.page2.dbbacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbacrtid  #顯示到畫面上
            NEXT FIELD dbbacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbacrtid
            #add-point:BEFORE FIELD dbbacrtid name="construct.b.page2.dbbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbacrtid
            
            #add-point:AFTER FIELD dbbacrtid name="construct.a.page2.dbbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbacrtdp
            #add-point:ON ACTION controlp INFIELD dbbacrtdp name="construct.c.page2.dbbacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbacrtdp  #顯示到畫面上
            NEXT FIELD dbbacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbacrtdp
            #add-point:BEFORE FIELD dbbacrtdp name="construct.b.page2.dbbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbacrtdp
            
            #add-point:AFTER FIELD dbbacrtdp name="construct.a.page2.dbbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbacrtdt
            #add-point:BEFORE FIELD dbbacrtdt name="construct.b.page2.dbbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbamodid
            #add-point:ON ACTION controlp INFIELD dbbamodid name="construct.c.page2.dbbamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbamodid  #顯示到畫面上
            NEXT FIELD dbbamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbamodid
            #add-point:BEFORE FIELD dbbamodid name="construct.b.page2.dbbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbamodid
            
            #add-point:AFTER FIELD dbbamodid name="construct.a.page2.dbbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbamoddt
            #add-point:BEFORE FIELD dbbamoddt name="construct.b.page2.dbbamoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON dbbbstus,dbbb002,dbbb003,dbbb003_desc,dbbbownid,dbbbowndp,dbbbcrtid, 
          dbbbcrtdp,dbbbcrtdt,dbbbmodid,dbbbmoddt
           FROM s_detail3[1].dbbbstus,s_detail3[1].dbbb002,s_detail3[1].dbbb003,s_detail3[1].dbbb003_desc, 
               s_detail4[1].dbbbownid,s_detail4[1].dbbbowndp,s_detail4[1].dbbbcrtid,s_detail4[1].dbbbcrtdp, 
               s_detail4[1].dbbbcrtdt,s_detail4[1].dbbbmodid,s_detail4[1].dbbbmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbbbcrtdt>>----
         AFTER FIELD dbbbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbbbmoddt>>----
         AFTER FIELD dbbbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbbbcnfdt>>----
         
         #----<<dbbbpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbstus
            #add-point:BEFORE FIELD dbbbstus name="construct.b.page3.dbbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbstus
            
            #add-point:AFTER FIELD dbbbstus name="construct.a.page3.dbbbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbstus
            #add-point:ON ACTION controlp INFIELD dbbbstus name="construct.c.page3.dbbbstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbb002
            #add-point:BEFORE FIELD dbbb002 name="construct.b.page3.dbbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbb002
            
            #add-point:AFTER FIELD dbbb002 name="construct.a.page3.dbbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbb002
            #add-point:ON ACTION controlp INFIELD dbbb002 name="construct.c.page3.dbbb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.dbbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbb003
            #add-point:ON ACTION controlp INFIELD dbbb003 name="construct.c.page3.dbbb003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_ooaa002
            CALL q_rtax001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbb003  #顯示到畫面上
            NEXT FIELD dbbb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbb003
            #add-point:BEFORE FIELD dbbb003 name="construct.b.page3.dbbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbb003
            
            #add-point:AFTER FIELD dbbb003 name="construct.a.page3.dbbb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbb003_desc
            #add-point:BEFORE FIELD dbbb003_desc name="construct.b.page3.dbbb003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbb003_desc
            
            #add-point:AFTER FIELD dbbb003_desc name="construct.a.page3.dbbb003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.dbbb003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbb003_desc
            #add-point:ON ACTION controlp INFIELD dbbb003_desc name="construct.c.page3.dbbb003_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.dbbbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbownid
            #add-point:ON ACTION controlp INFIELD dbbbownid name="construct.c.page4.dbbbownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbbownid  #顯示到畫面上
            NEXT FIELD dbbbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbownid
            #add-point:BEFORE FIELD dbbbownid name="construct.b.page4.dbbbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbownid
            
            #add-point:AFTER FIELD dbbbownid name="construct.a.page4.dbbbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.dbbbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbowndp
            #add-point:ON ACTION controlp INFIELD dbbbowndp name="construct.c.page4.dbbbowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbbowndp  #顯示到畫面上
            NEXT FIELD dbbbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbowndp
            #add-point:BEFORE FIELD dbbbowndp name="construct.b.page4.dbbbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbowndp
            
            #add-point:AFTER FIELD dbbbowndp name="construct.a.page4.dbbbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.dbbbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbcrtid
            #add-point:ON ACTION controlp INFIELD dbbbcrtid name="construct.c.page4.dbbbcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbbcrtid  #顯示到畫面上
            NEXT FIELD dbbbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbcrtid
            #add-point:BEFORE FIELD dbbbcrtid name="construct.b.page4.dbbbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbcrtid
            
            #add-point:AFTER FIELD dbbbcrtid name="construct.a.page4.dbbbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.dbbbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbcrtdp
            #add-point:ON ACTION controlp INFIELD dbbbcrtdp name="construct.c.page4.dbbbcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbbcrtdp  #顯示到畫面上
            NEXT FIELD dbbbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbcrtdp
            #add-point:BEFORE FIELD dbbbcrtdp name="construct.b.page4.dbbbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbcrtdp
            
            #add-point:AFTER FIELD dbbbcrtdp name="construct.a.page4.dbbbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbcrtdt
            #add-point:BEFORE FIELD dbbbcrtdt name="construct.b.page4.dbbbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.dbbbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbmodid
            #add-point:ON ACTION controlp INFIELD dbbbmodid name="construct.c.page4.dbbbmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbbbmodid  #顯示到畫面上
            NEXT FIELD dbbbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbmodid
            #add-point:BEFORE FIELD dbbbmodid name="construct.b.page4.dbbbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbmodid
            
            #add-point:AFTER FIELD dbbbmodid name="construct.a.page4.dbbbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbmoddt
            #add-point:BEFORE FIELD dbbbmoddt name="construct.b.page4.dbbbmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="query.b_dialog"
         
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
      ON ACTION qbe_save       #條件儲存
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
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      #資料導回第一筆
      LET g_detail_idx  = 1
      LET g_detail_idx2 = 1
   END IF
   
   LET g_wc = g_wc_table 
 
              , " AND ", g_wc2_table2
 
 
        
   LET g_wc2 = " 1=1"
               , " AND ", g_wc2_table2
 
 
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   LET g_error_show = 1
   CALL adbi210_b_fill(g_wc)
   LET l_ac = g_detail_idx
   
   CALL adbi210_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
 
   #資料導回第一筆(假設有資料)
   IF g_dbba_d.getLength() > 0 THEN
      DISPLAY g_detail_idx  TO FORMONLY.h_index
   ELSE
      DISPLAY ' ' TO FORMONLY.h_index
   END IF
   IF g_dbba3_d.getLength() > 0 THEN
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.insert" >}
#+ 資料修改
PRIVATE FUNCTION adbi210_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point 
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="insert.before_insert"
   
   #end add-point 
   
   LET g_insert = 'Y'
   CALL adbi210_input('a')
   
   #add-point:insert段新增後 name="insert.after_insert"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.modify" >}
#+ 資料新增
PRIVATE FUNCTION adbi210_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
  
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   LET l_ac_t = g_detail_idx
 
   #add-point:modify段新增前 name="modify.before_modify"
   
   #end add-point 
   
   #進入資料輸入段落
   CALL adbi210_input('u')
    
   IF INT_FLAG AND g_dbba_d.getLength() > 0 THEN
      LET g_detail_idx = l_ac_t
      LET l_ac = l_ac_t
      CALL adbi210_b_fill(g_wc)
      CALL adbi210_detail_show() 
   END IF
   
   #add-point:modify段新增後 name="modify.after_modify"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi210_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point 
   DEFINE li_ac LIKE type_t.num10
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF NOT cl_ask_delete() THEN
      #不刪除
      RETURN
   END IF
   
   LET li_ac = ARR_CURR()
   LET g_dbba_d_t.* = g_dbba_d[li_ac].*
   LET g_dbba_d_o.* = g_dbba_d[li_ac].*
   
   CALL s_transaction_begin()  
   
   #add-point:delete段刪除前 name="delete.before_delete"
   
   #end add-point 
   
   #刪除單頭
   DELETE FROM dbba_t 
         WHERE dbbaent = g_enterprise AND
           dbba001 = g_dbba_d_t.dbba001
 
           
   #add-point:delete段刪除中 name="delete.m_delete"
   
   #end add-point 
           
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbba_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi210_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
    
   
   #add-point:delete段刪除後 name="delete.after_delete"
   
   #end add-point 
   
   #刪除單頭
   #add-point:delete段刪除前 name="delete.before_delete2"
   
   #end add-point 
   DELETE FROM dbbb_t 
         WHERE dbbbent = g_enterprise AND
           dbbb001 = g_dbba_d_t.dbba001
 
   #add-point:delete段刪除中 name="delete.m_delete2"
   
   #end add-point 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #add-point:delete段刪除後 name="delete.after_delete2"
   
   #end add-point 
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.input" >}
#+ 資料輸入
PRIVATE FUNCTION adbi210_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point 
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT dbbastus,dbba001,dbba002,dbba001,dbbaownid,dbbaowndp,dbbacrtid,dbbacrtdp, 
       dbbacrtdt,dbbamodid,dbbamoddt FROM dbba_t WHERE dbbaent=? AND dbba001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi210_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT dbbbstus,dbbb002,dbbb003,dbbb003,dbbbownid,dbbbowndp,dbbbcrtid,dbbbcrtdp, 
       dbbbcrtdt,dbbbmodid,dbbbmoddt FROM dbbb_t WHERE dbbbent=? AND dbbb001=? AND dbbb003=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adbi210_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
      
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:input段修改前 name="input.before_input"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbba_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
            IF NOT cl_null(g_dbba_d[l_ac].dbba001)  THEN
               CALL n_dbbal(g_dbba_d[l_ac].dbba001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_dbba_d[l_ac].dbba001
               CALL ap_ref_array2(g_ref_fields," SELECT dbbal003,dbbal004 FROM dbbal_t WHERE dbbalent = '"||g_enterprise||"' AND dbbal001 = ? AND dbbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_dbba_d[l_ac].dbbal003 = g_rtn_fields[1]
               LET g_dbba_d[l_ac].dbbal004 = g_rtn_fields[2]
               DISPLAY BY NAME g_dbba_d[l_ac].dbbal003,g_dbba_d[l_ac].dbbal004
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbba_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_current_page = 1
            IF p_cmd = 'u' THEN
               CALL adbi210_b_fill(g_wc)
            END IF
            LET g_loc = 'm'
            LET g_detail_cnt = g_dbba_d.getLength()
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_ac_last = l_ac
            LET l_insert = FALSE
            LET g_detail_idx = l_ac
            LET g_master_t.* = g_dbba_d[l_ac].*
            LET g_master.* = g_dbba_d[l_ac].*
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_detail_idx = l_ac
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbba_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbba_d[l_ac].dbba001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbba_d_t.* = g_dbba_d[l_ac].*  #BACKUP
               LET g_dbba_d_o.* = g_dbba_d[l_ac].*  #BACKUP
               IF NOT adbi210_lock_b("dbba_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi210_bcl INTO g_dbba_d[l_ac].dbbastus,g_dbba_d[l_ac].dbba001,g_dbba_d[l_ac].dbba002, 
                      g_dbba2_d[l_ac].dbba001,g_dbba2_d[l_ac].dbbaownid,g_dbba2_d[l_ac].dbbaowndp,g_dbba2_d[l_ac].dbbacrtid, 
                      g_dbba2_d[l_ac].dbbacrtdp,g_dbba2_d[l_ac].dbbacrtdt,g_dbba2_d[l_ac].dbbamodid, 
                      g_dbba2_d[l_ac].dbbamoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbba_d_t.dbba001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
 
                  #遮罩相關處理
                  LET g_dbba_d_mask_o[l_ac].* =  g_dbba_d[l_ac].*
                  CALL adbi210_dbba_t_mask()
                  LET g_dbba_d_mask_n[l_ac].* =  g_dbba_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL adbi210_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi210_set_entry_b(l_cmd)
            CALL adbi210_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.dbbal001 = g_dbba_d[l_ac].dbba001
LET g_detail_multi_table_t.dbbal002 = g_dlang
LET g_detail_multi_table_t.dbbal003 = g_dbba_d[l_ac].dbbal003
LET g_detail_multi_table_t.dbbal004 = g_dbba_d[l_ac].dbbal004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'dbbalent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'dbbal001'
            LET l_var_keys[02] = g_dbba_d[l_ac].dbba001
            LET l_field_keys[03] = 'dbbal002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'dbbal_t') THEN
               RETURN 
            END IF 
 
 
            #讀取對應的單身資料
            LET g_action_choice = "fetch"
            CALL adbi210_fetch()
            CALL adbi210_idx_chk('m')
 
         BEFORE INSERT
            
LET g_detail_multi_table_t.dbbal001 = g_dbba_d[l_ac].dbba001
LET g_detail_multi_table_t.dbbal002 = g_dlang
LET g_detail_multi_table_t.dbbal003 = g_dbba_d[l_ac].dbbal003
LET g_detail_multi_table_t.dbbal004 = g_dbba_d[l_ac].dbbal004
 
 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            #清空下層單身
                        CALL g_dbba3_d.clear()
            CALL g_dbba4_d.clear()
 
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbba_d[l_ac].* TO NULL 
            INITIALIZE g_dbba_d_t.* TO NULL 
            INITIALIZE g_dbba_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbba2_d[l_ac].dbbaownid = g_user
      LET g_dbba2_d[l_ac].dbbaowndp = g_dept
      LET g_dbba2_d[l_ac].dbbacrtid = g_user
      LET g_dbba2_d[l_ac].dbbacrtdp = g_dept 
      LET g_dbba2_d[l_ac].dbbacrtdt = cl_get_current()
      LET g_dbba2_d[l_ac].dbbamodid = g_user
      LET g_dbba2_d[l_ac].dbbamoddt = cl_get_current()
      LET g_dbba_d[l_ac].dbbastus = ''
 
 
 
                  LET g_dbba_d[l_ac].dbbastus = "Y"
      LET g_dbba_d[l_ac].dbba002 = "1"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_dbba_d_t.* = g_dbba_d[l_ac].*     #新輸入資料
            LET g_dbba_d_o.* = g_dbba_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi210_set_entry_b(l_cmd)
            CALL adbi210_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbba_d[li_reproduce_target].* = g_dbba_d[li_reproduce].*
               LET g_dbba2_d[li_reproduce_target].* = g_dbba2_d[li_reproduce].*
 
               LET g_dbba_d[g_dbba_d.getLength()].dbba001 = NULL
 
            END IF
            #add-point:input段before insert name="input.body.before_insert"
            LET g_dbba_d_o.* = g_dbba_d[l_ac].*     #新輸入資料
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM dbba_t 
             WHERE dbbaent = g_enterprise AND dbba001 = g_dbba_d[l_ac].dbba001 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbba_d[g_detail_idx].dbba001
               CALL adbi210_insert_b('dbba_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_dbba_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbba_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi210_b_fill(g_wc)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbba_d[l_ac].dbba001 = g_detail_multi_table_t.dbbal001 AND
         g_dbba_d[l_ac].dbbal003 = g_detail_multi_table_t.dbbal003 AND
         g_dbba_d[l_ac].dbbal004 = g_detail_multi_table_t.dbbal004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbba_d[l_ac].dbba001
            LET l_field_keys[02] = 'dbbal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbbal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbbal002
            LET l_vars[01] = g_dbba_d[l_ac].dbbal003
            LET l_fields[01] = 'dbbal003'
            LET l_vars[02] = g_dbba_d[l_ac].dbbal004
            LET l_fields[02] = 'dbbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbbal_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_master.* = g_dbba_d[l_ac].*
            END IF
              
         BEFORE DELETE  #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               DELETE FROM dbba_t
                WHERE dbbaent = g_enterprise AND 
                      dbba001 = g_dbba_d_t.dbba001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbba_t:",SQLERRMESSAGE  
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbbalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbbal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbbal_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  LET g_log1 = util.JSON.stringify(g_dbba_d[l_ac])   #(ver:45)
                  IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:45)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE adbi210_bcl
               LET l_count = g_dbba_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbba_d_t.dbba001
    
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi210_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
        
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL adbi210_delete_b('dbba_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dbba_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbastus
            #add-point:BEFORE FIELD dbbastus name="input.b.page1.dbbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbastus
            
            #add-point:AFTER FIELD dbbastus name="input.a.page1.dbbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbastus
            #add-point:ON CHANGE dbbastus name="input.g.page1.dbbastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbba001
            #add-point:BEFORE FIELD dbba001 name="input.b.page1.dbba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbba001
            
            #add-point:AFTER FIELD dbba001 name="input.a.page1.dbba001"
            #此段落由子樣板a05產生
            IF  g_dbba_d[g_detail_idx].dbba001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbba_d[g_detail_idx].dbba001 != g_dbba_d_t.dbba001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbba_t WHERE "||"dbbaent = '" ||g_enterprise|| "' AND "||"dbba001 = '"||g_dbba_d[g_detail_idx].dbba001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbba001
            #add-point:ON CHANGE dbba001 name="input.g.page1.dbba001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbal003
            #add-point:BEFORE FIELD dbbal003 name="input.b.page1.dbbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbal003
            
            #add-point:AFTER FIELD dbbal003 name="input.a.page1.dbbal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbal003
            #add-point:ON CHANGE dbbal003 name="input.g.page1.dbbal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbal004
            #add-point:BEFORE FIELD dbbal004 name="input.b.page1.dbbal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbal004
            
            #add-point:AFTER FIELD dbbal004 name="input.a.page1.dbbal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbal004
            #add-point:ON CHANGE dbbal004 name="input.g.page1.dbbal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbba002
            #add-point:BEFORE FIELD dbba002 name="input.b.page1.dbba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbba002
            
            #add-point:AFTER FIELD dbba002 name="input.a.page1.dbba002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbba002
            #add-point:ON CHANGE dbba002 name="input.g.page1.dbba002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbastus
            #add-point:ON ACTION controlp INFIELD dbbastus name="input.c.page1.dbbastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbba001
            #add-point:ON ACTION controlp INFIELD dbba001 name="input.c.page1.dbba001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbal003
            #add-point:ON ACTION controlp INFIELD dbbal003 name="input.c.page1.dbbal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbal004
            #add-point:ON ACTION controlp INFIELD dbbal004 name="input.c.page1.dbbal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbba002
            #add-point:ON ACTION controlp INFIELD dbba002 name="input.c.page1.dbba002"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_dbba_d[l_ac].* = g_dbba_d_t.*
               CLOSE adbi210_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dbba_d[l_ac].dbba001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_dbba_d[l_ac].* = g_dbba_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身)
               LET g_dbba2_d[l_ac].dbbamodid = g_user 
LET g_dbba2_d[l_ac].dbbamoddt = cl_get_current()
LET g_dbba2_d[l_ac].dbbamodid_desc = cl_get_username(g_dbba2_d[l_ac].dbbamodid)
               
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL adbi210_dbba_t_mask_restore('restore_mask_o')
      
               UPDATE dbba_t SET (dbbastus,dbba001,dbba002,dbbaownid,dbbaowndp,dbbacrtid,dbbacrtdp,dbbacrtdt, 
                   dbbamodid,dbbamoddt) = (g_dbba_d[l_ac].dbbastus,g_dbba_d[l_ac].dbba001,g_dbba_d[l_ac].dbba002, 
                   g_dbba2_d[l_ac].dbbaownid,g_dbba2_d[l_ac].dbbaowndp,g_dbba2_d[l_ac].dbbacrtid,g_dbba2_d[l_ac].dbbacrtdp, 
                   g_dbba2_d[l_ac].dbbacrtdt,g_dbba2_d[l_ac].dbbamodid,g_dbba2_d[l_ac].dbbamoddt)
                WHERE dbbaent = g_enterprise AND
                  dbba001 = g_dbba_d_t.dbba001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_dbba_d[l_ac].* = g_dbba_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbba_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_dbba_d[l_ac].* = g_dbba_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbba_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbba_d[g_detail_idx].dbba001
               LET gs_keys_bak[1] = g_dbba_d_t.dbba001
               CALL adbi210_update_b('dbba_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbba_d[l_ac].dbba001 = g_detail_multi_table_t.dbbal001 AND
         g_dbba_d[l_ac].dbbal003 = g_detail_multi_table_t.dbbal003 AND
         g_dbba_d[l_ac].dbbal004 = g_detail_multi_table_t.dbbal004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbba_d[l_ac].dbba001
            LET l_field_keys[02] = 'dbbal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbbal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbbal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbbal002
            LET l_vars[01] = g_dbba_d[l_ac].dbbal003
            LET l_fields[01] = 'dbbal003'
            LET l_vars[02] = g_dbba_d[l_ac].dbbal004
            LET l_fields[02] = 'dbbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbbal_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL adbi210_dbba_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_dbba_d_t)
                     LET g_log2 = util.JSON.stringify(g_dbba_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #若Key欄位有變動
               LET g_master.* = g_dbba_d[l_ac].*
               CALL adbi210_key_update_b()
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_dbba_d_t.dbbastus = 'Y' AND g_dbba_d[l_ac].dbbastus = 'N' THEN
                  UPDATE dbbb_t SET dbbbstus = 'N'
                  WHERE dbbbent = g_enterprise
                    AND dbbb001 = g_dbba_d[l_ac].dbba001
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "std-00009"
                        LET g_errparam.extend = "dbbb_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "dbbb_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                  END CASE
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adbi210_unlock_b("dbba_t")
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbba_d[l_ac].* = g_dbba_d_t.*
               END IF
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            CALL cl_multitable_unlock()
            IF l_cmd = 'u' AND INT_FLAG THEN
               LET g_dbba_d[l_ac].* = g_dbba_d_t.*
            END IF
            LET l_cmd = ''
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
 
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()      
            #CALL cl_showmsg()            
    
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_dbba_d[li_reproduce_target].* = g_dbba_d[li_reproduce].*
               LET g_dbba2_d[li_reproduce_target].* = g_dbba2_d[li_reproduce].*
 
               LET g_dbba_d[li_reproduce_target].dbba001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbba_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbba_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      #實際單身段落
      INPUT ARRAY g_dbba3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page3.update_item"
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #檢查上層單身是否有資料
            IF cl_null(g_dbba_d[g_detail_idx].dbba001) THEN
               NEXT FIELD dbbastus
            END IF
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbba3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            LET g_loc = 'd'
            LET g_detail_cnt = g_dbba3_d.getLength()
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            IF cl_null(g_dbba_d[l_ac].dbba001) THEN
               LET p_cmd = 'u'
               #尚未選擇產品組編號!
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00024'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL g_dbba_d.deleteElement(l_ac)
               IF g_detail_idx >= 1 THEN
                  LET g_detail_idx = g_detail_idx - 1
               END IF
               NEXT FIELD dbba001
            END IF
            #end add-point
 
         BEFORE INSERT
            IF g_dbba_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 'std-00013' 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD dbba001
            END IF 
            #判斷能否在此頁面進行資料新增
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbba3_d[l_ac].* TO NULL 
            INITIALIZE g_dbba3_d_t.* TO NULL 
            INITIALIZE g_dbba3_d_o.* TO NULL 
                  LET g_dbba3_d[l_ac].dbbbstus = "Y"
      LET g_dbba3_d[l_ac].dbbb002 = "1"
 
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_dbba3_d_t.* = g_dbba3_d[l_ac].*     #新輸入資料
            LET g_dbba3_d_o.* = g_dbba3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi210_set_entry_b(l_cmd)
            CALL adbi210_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbba3_d[li_reproduce_target].* = g_dbba3_d[li_reproduce].*
               LET g_dbba4_d[li_reproduce_target].* = g_dbba4_d[li_reproduce].*
 
               LET g_dbba3_d[li_reproduce_target].dbbb003 = NULL
            END IF
            #add-point:input段before insert name="input.body3.before_insert"
            LET g_dbba3_d[l_ac].dbbb002 = g_master.dbba002
            LET g_dbba3_d[l_ac].dbbbstus = g_master.dbbastus
            LET g_dbba3_d_t.* = g_dbba3_d[l_ac].*     #新輸入資料
            LET g_dbba3_d_o.* = g_dbba3_d[l_ac].*     #新輸入資
            #end add-point  
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET l_insert = FALSE
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbba3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbba3_d[l_ac].dbbb003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_dbba3_d_t.* = g_dbba3_d[l_ac].*  #BACKUP
               LET g_dbba3_d_o.* = g_dbba3_d[l_ac].*  #BACKUP
               IF NOT adbi210_lock_b("dbbb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi210_bcl2 INTO g_dbba3_d[l_ac].dbbbstus,g_dbba3_d[l_ac].dbbb002,g_dbba3_d[l_ac].dbbb003, 
                      g_dbba4_d[l_ac].dbbb003,g_dbba4_d[l_ac].dbbbownid,g_dbba4_d[l_ac].dbbbowndp,g_dbba4_d[l_ac].dbbbcrtid, 
                      g_dbba4_d[l_ac].dbbbcrtdp,g_dbba4_d[l_ac].dbbbcrtdt,g_dbba4_d[l_ac].dbbbmodid, 
                      g_dbba4_d[l_ac].dbbbmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbba3_d_mask_o[l_ac].* =  g_dbba3_d[l_ac].*
                  CALL adbi210_dbbb_t_mask()
                  LET g_dbba3_d_mask_n[l_ac].* =  g_dbba3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  #CALL adbi210_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi210_set_entry_b(l_cmd)
            CALL adbi210_set_no_entry_b(l_cmd)
            #add-point:input段before row name="input.body3.before_row"
            CALL adbi210_dbbb003_ref()
            LET g_dbba3_d_o.* = g_dbba3_d[l_ac].*
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            CALL adbi210_idx_chk('d')
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point  
               
               DELETE FROM dbbb_t
                WHERE dbbbent = g_enterprise AND
                   dbbb001 = g_master.dbba001
                   AND dbbb003 = g_dbba3_d_t.dbbb003
                   
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point  
                   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE adbi210_bcl
               LET l_count = g_dbba_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbba_d[g_detail_idx].dbba001
               LET gs_keys[2] = g_dbba3_d_t.dbbb003
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL adbi210_delete_b('dbbb_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dbba3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
    
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_insert = FALSE   
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM dbbb_t 
             WHERE dbbbent = g_enterprise AND
                   dbbb001 = g_master.dbba001
                   AND dbbb003 = g_dbba3_d[g_detail_idx2].dbbb003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbba_d[g_detail_idx].dbba001
               LET gs_keys[2] = g_dbba3_d[g_detail_idx2].dbbb003
               CALL adbi210_insert_b('dbbb_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_dbba_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi210_b_fill(g_wc)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_dbba3_d[l_ac].* = g_dbba3_d_t.*
               CLOSE adbi210_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_dbba3_d[l_ac].* = g_dbba3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身3)
               LET g_dbba4_d[l_ac].dbbbmodid = g_user 
LET g_dbba4_d[l_ac].dbbbmoddt = cl_get_current()
LET g_dbba4_d[l_ac].dbbbmodid_desc = cl_get_username(g_dbba4_d[l_ac].dbbbmodid)
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL adbi210_dbbb_t_mask_restore('restore_mask_o')
               
               UPDATE dbbb_t SET (dbbbstus,dbbb002,dbbb003,dbbbownid,dbbbowndp,dbbbcrtid,dbbbcrtdp,dbbbcrtdt, 
                   dbbbmodid,dbbbmoddt) = (g_dbba3_d[l_ac].dbbbstus,g_dbba3_d[l_ac].dbbb002,g_dbba3_d[l_ac].dbbb003, 
                   g_dbba4_d[l_ac].dbbbownid,g_dbba4_d[l_ac].dbbbowndp,g_dbba4_d[l_ac].dbbbcrtid,g_dbba4_d[l_ac].dbbbcrtdp, 
                   g_dbba4_d[l_ac].dbbbcrtdt,g_dbba4_d[l_ac].dbbbmodid,g_dbba4_d[l_ac].dbbbmoddt) #自訂欄位頁簽 
 
                WHERE dbbbent = g_enterprise AND
                   dbbb001 = g_master.dbba001
                   AND dbbb003 = g_dbba3_d_t.dbbb003
                   
               #add-point:單身修改中 name="input.body3.m_update"
 
               #end add-point
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     LET g_dbba3_d[l_ac].* = g_dbba3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_dbba3_d[l_ac].* = g_dbba3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbba_d[g_detail_idx].dbba001
               LET gs_keys_bak[1] = g_dbba_d[g_detail_idx].dbba001
               LET gs_keys[2] = g_dbba3_d[g_detail_idx2].dbbb003
               LET gs_keys_bak[2] = g_dbba3_d_t.dbbb003
               CALL adbi210_update_b('dbbb_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL adbi210_dbbb_t_mask_restore('restore_mask_n')
                     #修改歷程記錄(下層修改)
                     LET g_log1 = util.JSON.stringify(g_dbba3_d_t)
                     LET g_log2 = util.JSON.stringify(g_dbba3_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               #add-point:單身page3修改後 name="input.body3.a_update"
 
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbbstus
            #add-point:BEFORE FIELD dbbbstus name="input.b.page3.dbbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbbstus
            
            #add-point:AFTER FIELD dbbbstus name="input.a.page3.dbbbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbbstus
            #add-point:ON CHANGE dbbbstus name="input.g.page3.dbbbstus"
            IF g_master.dbbastus = 'N' AND g_dbba3_d[l_ac].dbbbstus = 'Y' THEN
               LET g_dbba3_d[l_ac].dbbbstus = 'N'
               #單頭資料為無效，單身無法變更狀態為有效！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'adb-00036'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD dbbbstus
            END IF
            #改為有效時需判斷是否有存在另為有效的產品組中
            IF g_dbba3_d[l_ac].dbbbstus = 'Y' AND g_dbba3_d_t.dbbbstus = 'N' THEN
               CALL adbi210_chk_dbbb003('1',g_dbba3_d[l_ac].dbbb003)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#6 --s add
                  LET g_errparam.replace[1] = 'aimi010'
                  LET g_errparam.replace[2] = cl_get_progname('aimi010',g_lang,"2")
                  LET g_errparam.exeprog = 'aimi010'
                  #160318-00005#6 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_dbba3_d[l_ac].dbbbstus = g_dbba3_d_t.dbbbstus
                  NEXT FIELD dbbbstus
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbb002
            #add-point:BEFORE FIELD dbbb002 name="input.b.page3.dbbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbb002
            
            #add-point:AFTER FIELD dbbb002 name="input.a.page3.dbbb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbb002
            #add-point:ON CHANGE dbbb002 name="input.g.page3.dbbb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbb003
            
            #add-point:AFTER FIELD dbbb003 name="input.a.page3.dbbb003"
            #此段落由子樣板a05產生
            LET g_dbba3_d[l_ac].dbbb003_desc = ' '
            DISPLAY BY NAME g_dbba3_d[l_ac].dbbb003_desc
            IF NOT cl_null(g_dbba3_d[l_ac].dbbb003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbba3_d[l_ac].dbbb003 != g_dbba3_d_o.dbbb003 OR g_dbba3_d_o.dbbb003 IS NULL )) THEN
                  CALL adbi210_chk_dbbb003('1',g_dbba3_d[l_ac].dbbb003)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#6 --s add
                     LET g_errparam.replace[1] = 'aimi010'
                     LET g_errparam.replace[2] = cl_get_progname('aimi010',g_lang,"2")
                     LET g_errparam.exeprog = 'aimi010'
                     #160318-00005#6 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_dbba3_d[l_ac].dbbb003 = g_dbba3_d_o.dbbb003
                     CALL adbi210_dbbb003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CASE g_master.dbba002
                     WHEN '1'
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_dbba3_d[l_ac].dbbb003
                        LET g_chkparam.arg2 = g_ooaa002
                        LET g_errshow = TRUE   #160318-00025#51
                        LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"    #160318-00025#51
                        IF NOT cl_chk_exist("v_rtax001_2") THEN
                           LET g_dbba3_d[l_ac].dbbb003 = g_dbba3_d_o.dbbb003
                           CALL adbi210_dbbb003_ref()
                           NEXT FIELD CURRENT
                        END IF
                     WHEN '2'
                        IF NOT s_azzi650_chk_exist('2002',g_dbba3_d[l_ac].dbbb003) THEN
                           LET g_dbba3_d[l_ac].dbbb003 = g_dbba3_d_o.dbbb003
                           CALL adbi210_dbbb003_ref()
                        END IF
                  END CASE
               END IF
            END IF
            CALL adbi210_dbbb003_ref()
            LET g_dbba3_d_o.dbbb003 = g_dbba3_d[l_ac].dbbb003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbb003
            #add-point:BEFORE FIELD dbbb003 name="input.b.page3.dbbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbb003
            #add-point:ON CHANGE dbbb003 name="input.g.page3.dbbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbbb003_desc
            #add-point:BEFORE FIELD dbbb003_desc name="input.b.page3.dbbb003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbbb003_desc
            
            #add-point:AFTER FIELD dbbb003_desc name="input.a.page3.dbbb003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbbb003_desc
            #add-point:ON CHANGE dbbb003_desc name="input.g.page3.dbbb003_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.dbbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbbstus
            #add-point:ON ACTION controlp INFIELD dbbbstus name="input.c.page3.dbbbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbb002
            #add-point:ON ACTION controlp INFIELD dbbb002 name="input.c.page3.dbbb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbb003
            #add-point:ON ACTION controlp INFIELD dbbb003 name="input.c.page3.dbbb003"
            #此段落由子樣板a07產生            
            #開窗i段
            IF l_cmd = 'u' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_dbba3_d[l_ac].dbbb003       #給予default值
               
               CASE g_dbba3_d[l_ac].dbbb002
                  WHEN '1'
                     #給予arg
                     LET g_qryparam.arg1 = g_ooaa002
                     CALL q_rtax001_3()                                #呼叫開窗
                  WHEN '2'
                     #給予arg
                     LET g_qryparam.arg1 = "2002"
                     CALL q_oocq002()
               END CASE
               LET g_dbba3_d[l_ac].dbbb003 = g_qryparam.return1  
               DISPLAY g_dbba3_d[l_ac].dbbb003 TO dbbb003
               CALL adbi210_dbbb003_ref()
               NEXT FIELD dbbb003                          #返回原欄位
            ELSE
               CALL adbi210_ins_dbbb()
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page3.dbbb003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbbb003_desc
            #add-point:ON ACTION controlp INFIELD dbbb003_desc name="input.c.page3.dbbb003_desc"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbba3_d[l_ac].* = g_dbba3_d_t.*
               END IF
               CLOSE adbi210_bcl2
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               CANCEL DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL adbi210_unlock_b("dbbb_t")
            CALL s_transaction_end('Y','0')
            LET l_cmd = ''
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
 
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_dbba3_d[li_reproduce_target].* = g_dbba3_d[li_reproduce].*
               LET g_dbba4_d[li_reproduce_target].* = g_dbba4_d[li_reproduce].*
 
               LET g_dbba3_d[li_reproduce_target].dbbb003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbba3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbba3_d.getLength()+1
            END IF
 
      END INPUT
 
      
      DISPLAY ARRAY g_dbba2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            CALL adbi210_b_fill(g_wc)
            LET g_current_page = 2
        
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            LET g_action_choice = "fetch"
            CALL adbi210_fetch()
            CALL adbi210_idx_chk('m')
            
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
            
      END DISPLAY
 
    
      DISPLAY ARRAY g_dbba4_d TO s_detail4.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)
            LET g_current_page = 4
            
         BEFORE ROW
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
            LET l_ac = g_detail_idx
            CALL cl_show_fld_cont() 
            CALL adbi210_idx_chk('d')
            
         #add-point:page4自定義行為 name="input.body4.action"
         
         #end add-point
            
      END DISPLAY
 
      
      #add-point:input段input_array" name="input.more_inputarray"
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         LET g_curr_diag = ui.DIALOG.getCurrent()
         IF g_detail_idx > 0 THEN
            IF g_detail_idx > g_dbba_d.getLength() THEN
               LET g_detail_idx = g_dbba_d.getLength()
            END IF
            CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            LET l_ac = g_detail_idx
         END IF 
         LET g_detail_idx = l_ac
         #add-point:input段input_array" name="input.before_dialog"
         
         #end add-point
         #先確定單頭(第一單身)是否有資料
         IF g_dbba_d.getLength() > 0 THEN
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dbbastus
               WHEN "s_detail2"
                  NEXT FIELD dbba001_2
               WHEN "s_detail3"
                  NEXT FIELD dbbbstus
               WHEN "s_detail4"
                  NEXT FIELD dbbb003_4
 
            END CASE
         ELSE
            NEXT FIELD dbbastus
         END IF
            
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION close
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
   
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx2)
   CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx2)
 
   
   #add-point:input段修改後 name="input.after_input"
   
   #end add-point
 
   CLOSE adbi210_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi210_b_fill(p_wc2)
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2           STRING
   DEFINE l_ac_t          LIKE type_t.num10
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT t0.dbbastus,t0.dbba001,t0.dbba002,t0.dbba001,t0.dbbaownid,t0.dbbaowndp, 
       t0.dbbacrtid,t0.dbbacrtdp,t0.dbbacrtdt,t0.dbbamodid,t0.dbbamoddt ,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 FROM dbba_t t0",
 
               " LEFT JOIN dbbb_t ON dbbbent = dbbaent AND dbba001 = dbbb001",
 
 
               " LEFT JOIN dbbal_t ON dbbalent = "||g_enterprise||" AND dbba001 = dbbal001 AND dbbal002 = '",g_dlang,"'",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.dbbaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.dbbaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.dbbacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.dbbacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.dbbamodid  ",
 
               " WHERE t0.dbbaent= ?  AND  1=1 AND (", p_wc2, ") "
   #add-point:b_fill段sql_wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("dbba_t"),
                      " ORDER BY t0.dbba001"
  
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
  
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbba_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  
   PREPARE adbi210_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi210_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dbba_d.clear()
   CALL g_dbba2_d.clear()   
   CALL g_dbba3_d.clear()   
   CALL g_dbba4_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dbba_d[l_ac].dbbastus,g_dbba_d[l_ac].dbba001,g_dbba_d[l_ac].dbba002,g_dbba2_d[l_ac].dbba001, 
       g_dbba2_d[l_ac].dbbaownid,g_dbba2_d[l_ac].dbbaowndp,g_dbba2_d[l_ac].dbbacrtid,g_dbba2_d[l_ac].dbbacrtdp, 
       g_dbba2_d[l_ac].dbbacrtdt,g_dbba2_d[l_ac].dbbamodid,g_dbba2_d[l_ac].dbbamoddt,g_dbba2_d[l_ac].dbbaownid_desc, 
       g_dbba2_d[l_ac].dbbaowndp_desc,g_dbba2_d[l_ac].dbbacrtid_desc,g_dbba2_d[l_ac].dbbacrtdp_desc, 
       g_dbba2_d[l_ac].dbbamodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   CALL g_dbba_d.deleteElement(g_dbba_d.getLength())   
   CALL g_dbba2_d.deleteElement(g_dbba2_d.getLength())
   CALL g_dbba3_d.deleteElement(g_dbba3_d.getLength())
   CALL g_dbba4_d.deleteElement(g_dbba4_d.getLength())
 
   
   #確定指標無超過上限, 超過則指到最後一筆
   IF g_detail_idx > g_dbba_d.getLength() THEN
       IF g_dbba_d.getLength() > 0 THEN
          LET g_detail_idx = g_dbba_d.getLength()
       ELSE
          LET g_detail_idx = 1
      END IF
   END IF
   
   #將key欄位填到每個page
   LET l_ac_t = g_detail_idx
   FOR g_detail_idx = 1 TO g_dbba_d.getLength()
      LET g_dbba2_d[g_detail_idx].dbba001 = g_dbba_d[g_detail_idx].dbba001 
      #LET g_dbba3_d[g_detail_idx2].dbbb003 = g_dbba_d[g_detail_idx].dbba001 
      #LET g_dbba4_d[g_detail_idx2].dbbb003 = g_dbba_d[g_detail_idx].dbba001 
 
   END FOR
   LET g_detail_idx = l_ac_t
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_cnt TO FORMONLY.h_count
   END IF
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adbi210_pb
   
   LET g_loc = 'm'
   CALL adbi210_detail_show() 
   
   LET l_ac = 1
   IF g_dbba_d.getLength() > 0 THEN
      CALL adbi210_fetch()
   END IF
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbba_d.getLength()
      LET g_dbba_d_mask_o[l_ac].* =  g_dbba_d[l_ac].*
      CALL adbi210_dbba_t_mask()
      LET g_dbba_d_mask_n[l_ac].* =  g_dbba_d[l_ac].*
   END FOR
   
   LET g_dbba2_d_mask_o.* =  g_dbba2_d.*
   FOR l_ac = 1 TO g_dbba2_d.getLength()
      LET g_dbba2_d_mask_o[l_ac].* =  g_dbba2_d[l_ac].*
      CALL adbi210_dbba_t_mask()
      LET g_dbba2_d_mask_n[l_ac].* =  g_dbba2_d[l_ac].*
   END FOR
   LET g_dbba3_d_mask_o.* =  g_dbba3_d.*
   FOR l_ac = 1 TO g_dbba3_d.getLength()
      LET g_dbba3_d_mask_o[l_ac].* =  g_dbba3_d[l_ac].*
      CALL adbi210_dbbb_t_mask()
      LET g_dbba3_d_mask_n[l_ac].* =  g_dbba3_d[l_ac].*
   END FOR
   LET g_dbba4_d_mask_o.* =  g_dbba4_d.*
   FOR l_ac = 1 TO g_dbba4_d.getLength()
      LET g_dbba4_d_mask_o[l_ac].* =  g_dbba4_d[l_ac].*
      CALL adbi210_dbbb_t_mask()
      LET g_dbba4_d_mask_n[l_ac].* =  g_dbba4_d[l_ac].*
   END FOR
 
   
   ERROR "" 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbi210_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_dbba_d.getLength() = 0 THEN
      RETURN
   END IF
   
   #CALL g_dbba2_d.clear()
   CALL g_dbba3_d.clear()
   CALL g_dbba4_d.clear()
 
   
   LET li_ac = l_ac 
    
   IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
      
      #end add-point
   THEN
      LET g_sql = "SELECT  DISTINCT t0.dbbbstus,t0.dbbb002,t0.dbbb003,t0.dbbb003,t0.dbbbownid,t0.dbbbowndp, 
          t0.dbbbcrtid,t0.dbbbcrtdp,t0.dbbbcrtdt,t0.dbbbmodid,t0.dbbbmoddt ,t6.ooag011 ,t7.ooefl003 , 
          t8.ooag011 ,t9.ooefl003 ,t10.ooag011 FROM dbbb_t t0",    
                  "",
                                 " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.dbbbownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.dbbbowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.dbbbcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.dbbbcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.dbbbmodid  ",
 
                  " WHERE t0.dbbbent=?  AND t0. dbbb001=?"
      #add-point:單身sql wc name="fetch.sql_wc2"
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY t0.dbbb003" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料    
      PREPARE adbi210_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adbi210_pb2
   END IF
   
#  LET l_ac = g_detail_idx   #(ver:45)
#  OPEN b_fill_curs2 USING g_enterprise,g_dbba_d[l_ac].dbba001   #(ver:45)
   
   LET l_ac = 1
#  FOREACH b_fill_curs2 USING g_enterprise,g_dbba_d[l_ac].dbba001 INTO g_dbba3_d[l_ac].dbbbstus,g_dbba3_d[l_ac].dbbb002, 
#    g_dbba3_d[l_ac].dbbb003,g_dbba4_d[l_ac].dbbb003,g_dbba4_d[l_ac].dbbbownid,g_dbba4_d[l_ac].dbbbowndp, 
#    g_dbba4_d[l_ac].dbbbcrtid,g_dbba4_d[l_ac].dbbbcrtdp,g_dbba4_d[l_ac].dbbbcrtdt,g_dbba4_d[l_ac].dbbbmodid, 
#    g_dbba4_d[l_ac].dbbbmoddt,g_dbba4_d[l_ac].dbbbownid_desc,g_dbba4_d[l_ac].dbbbowndp_desc,g_dbba4_d[l_ac].dbbbcrtid_desc, 
#    g_dbba4_d[l_ac].dbbbcrtdp_desc,g_dbba4_d[l_ac].dbbbmodid_desc   #(ver:45) #(ver:46)mark
   FOREACH b_fill_curs2 USING g_enterprise,g_dbba_d[g_detail_idx].dbba001 INTO g_dbba3_d[l_ac].dbbbstus, 
       g_dbba3_d[l_ac].dbbb002,g_dbba3_d[l_ac].dbbb003,g_dbba4_d[l_ac].dbbb003,g_dbba4_d[l_ac].dbbbownid, 
       g_dbba4_d[l_ac].dbbbowndp,g_dbba4_d[l_ac].dbbbcrtid,g_dbba4_d[l_ac].dbbbcrtdp,g_dbba4_d[l_ac].dbbbcrtdt, 
       g_dbba4_d[l_ac].dbbbmodid,g_dbba4_d[l_ac].dbbbmoddt,g_dbba4_d[l_ac].dbbbownid_desc,g_dbba4_d[l_ac].dbbbowndp_desc, 
       g_dbba4_d[l_ac].dbbbcrtid_desc,g_dbba4_d[l_ac].dbbbcrtdp_desc,g_dbba4_d[l_ac].dbbbmodid_desc  
         #(ver:45) #(ver:46)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="fetch.fill2"
      CALL adbi210_dbbb003_ref()
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbownid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_dbba4_d[l_ac].dbbbownid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dbba4_d[l_ac].dbbbownid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbowndp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_dbba4_d[l_ac].dbbbowndp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dbba4_d[l_ac].dbbbowndp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbcrtid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_dbba4_d[l_ac].dbbbcrtid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dbba4_d[l_ac].dbbbcrtid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbcrtdp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_dbba4_d[l_ac].dbbbcrtdp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dbba4_d[l_ac].dbbbcrtdp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbmodid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_dbba4_d[l_ac].dbbbmodid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_dbba4_d[l_ac].dbbbmodid_desc
      #end add-point
      
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
 
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point
   
   #CALL g_dbba2_d.deleteElement(g_dbba2_d.getLength())   
   CALL g_dbba3_d.deleteElement(g_dbba3_d.getLength())   
   CALL g_dbba4_d.deleteElement(g_dbba4_d.getLength())   
 
   
   LET g_dbba3_d_mask_o.* =  g_dbba3_d.*
   FOR l_ac = 1 TO g_dbba3_d.getLength()
      LET g_dbba3_d_mask_o[l_ac].* =  g_dbba3_d[l_ac].*
      CALL adbi210_dbbb_t_mask()
      LET g_dbba3_d_mask_n[l_ac].* =  g_dbba3_d[l_ac].*
   END FOR
   LET g_dbba4_d_mask_o.* =  g_dbba4_d.*
   FOR l_ac = 1 TO g_dbba4_d.getLength()
      LET g_dbba4_d_mask_o[l_ac].* =  g_dbba4_d[l_ac].*
      CALL adbi210_dbbb_t_mask()
      LET g_dbba4_d_mask_n[l_ac].* =  g_dbba4_d[l_ac].*
   END FOR
 
   
   DISPLAY g_dbba3_d.getLength() TO FORMONLY.cnt
   #LET g_loc = 'd'
   CALL adbi210_detail_show()
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi210_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   DEFINE l_ac_t LIKE type_t.num10
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   #帶出公用欄位reference值page3
   
   #帶出公用欄位reference值page4
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   
   IF g_loc = 'm' THEN
      #讀入ref值
      FOR l_ac = 1 TO g_dbba_d.getLength()
         #add-point:show段單頭reference name="detail_show.body.reference"
         IF g_current_page = '0' OR g_current_page = '1' OR g_current_page = '2' THEN
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbba_d[l_ac].dbba001
            CALL ap_ref_array2(g_ref_fields," SELECT dbbal003,dbbal004 FROM dbbal_t WHERE dbbalent = '"||g_enterprise||"' AND dbbal001 = ? AND dbbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbba_d[l_ac].dbbal003 = g_rtn_fields[1]
            LET g_dbba_d[l_ac].dbbal004 = g_rtn_fields[2]
            DISPLAY BY NAME g_dbba_d[l_ac].dbbal003,g_dbba_d[l_ac].dbbal004
         END IF
         #end add-point
         #add-point:show段單頭reference name="detail_show.body2.reference"
         IF g_current_page = '0' OR g_current_page = '1' OR g_current_page = '2' THEN
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbba2_d[l_ac].dbbaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbba2_d[l_ac].dbbaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbba2_d[l_ac].dbbaownid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbba2_d[l_ac].dbbaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbba2_d[l_ac].dbbaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbba2_d[l_ac].dbbaowndp_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbba2_d[l_ac].dbbacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbba2_d[l_ac].dbbacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbba2_d[l_ac].dbbacrtid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbba2_d[l_ac].dbbacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dbba2_d[l_ac].dbbacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbba2_d[l_ac].dbbacrtdp_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dbba2_d[l_ac].dbbamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_dbba2_d[l_ac].dbbamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dbba2_d[l_ac].dbbamodid_desc
         END IF
         #end add-point
 
      END FOR
   END IF
   
   IF g_loc = 'd' THEN
      FOR l_ac = 1 TO g_dbba3_d.getLength()
        #add-point:show段單身reference name="detail_show.body3.reference"
        CALL adbi210_dbbb003_ref()
        #end add-point
      END FOR
      FOR l_ac = 1 TO g_dbba4_d.getLength()
        #add-point:show段單身reference name="detail_show.body4.reference"
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbownid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_dbba4_d[l_ac].dbbbownid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_dbba4_d[l_ac].dbbbownid_desc
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbowndp
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_dbba4_d[l_ac].dbbbowndp_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_dbba4_d[l_ac].dbbbowndp_desc
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbcrtid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_dbba4_d[l_ac].dbbbcrtid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_dbba4_d[l_ac].dbbbcrtid_desc
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbcrtdp
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_dbba4_d[l_ac].dbbbcrtdp_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_dbba4_d[l_ac].dbbbcrtdp_desc
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_dbba4_d[l_ac].dbbbmodid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_dbba4_d[l_ac].dbbbmodid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_dbba4_d[l_ac].dbbbmodid_desc
        #end add-point
      END FOR
 
      
      #add-point:detail_show段之後 name="detail_show.after"
      
      #end add-point
   END IF
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi210_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段欄位控制後 name="set_entry.after_control"
   IF g_current_page = '1' THEN
      IF p_cmd = 'a' THEN
         CALL cl_set_comp_entry('dbba001',TRUE)
      END IF
      CALL cl_set_comp_entry('dbba002',TRUE)
   END IF
   #end add-point 
                                                                     
END FUNCTION                                                                    
 
{</section>}
 
{<section id="adbi210.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi210_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
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
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_current_page = '1' THEN
      IF p_cmd = 'u' THEN
         CALL cl_set_comp_entry('dbba001',FALSE)
         
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM dbbb_t
          WHERE dbbbent = g_enterprise
            AND dbbb001 = g_dbba_d[l_ac].dbba001
         IF l_cnt >= 1 THEN
            CALL cl_set_comp_entry('dbba002',FALSE)
         END IF
      END IF
   END IF
   #end add-point 
                                                                          
END FUNCTION  
 
{</section>}
 
{<section id="adbi210.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi210_default_search()
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
      LET ls_wc = ls_wc, " dbba001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      LET g_wc = " 1=2"
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi210_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
  
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "dbba_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete"
      
      #end add-point  
      DELETE FROM dbba_t
       WHERE dbbaent = g_enterprise AND
         dbba001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete"
      
      #end add-point  
   END IF
   
 
   
   LET ls_group = "dbbb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_delete2"
      
      #end add-point  
      DELETE FROM dbbb_t
       WHERE dbbbent = g_enterprise AND
         dbbb001 = ps_keys_bak[1] AND dbbb003 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
   #單頭刪除, 連帶刪除單身
   LET ls_group = "dbba_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.before_body_delete2"
      
      #end add-point  
      DELETE FROM dbbb_t
       WHERE dbbbent = g_enterprise AND
         dbbb001 = ps_keys_bak[1]
      #add-point:delete_b段刪除中 name="delete_b.m_body_delete2"
      
      #end add-point  
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:delete_b段刪除後 name="delete_b.after_body_delete2"
      
      #end add-point  
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi210_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "dbba_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert"
      
      #end add-point
      INSERT INTO dbba_t
                  (dbbaent,
                   dbba001
                   ,dbbastus,dbba002,dbbaownid,dbbaowndp,dbbacrtid,dbbacrtdp,dbbacrtdt,dbbamodid,dbbamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_dbba_d[g_detail_idx].dbbastus,g_dbba_d[g_detail_idx].dbba002,g_dbba2_d[g_detail_idx].dbbaownid, 
                       g_dbba2_d[g_detail_idx].dbbaowndp,g_dbba2_d[g_detail_idx].dbbacrtid,g_dbba2_d[g_detail_idx].dbbacrtdp, 
                       g_dbba2_d[g_detail_idx].dbbacrtdt,g_dbba2_d[g_detail_idx].dbbamodid,g_dbba2_d[g_detail_idx].dbbamoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbba_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert"
      
      #end add-point
   END IF
   
 
   
   LET ls_group = "dbbb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.before_insert2"
      LET g_dbba3_d[g_detail_idx2].dbbbstus = g_master.dbbastus
      LET g_dbba3_d[g_detail_idx2].dbbb002 = g_master.dbba002
      LET g_dbba4_d[g_detail_idx2].dbbbownid = g_user
      LET g_dbba4_d[g_detail_idx2].dbbbowndp = g_dept
      LET g_dbba4_d[g_detail_idx2].dbbbcrtid = g_user
      LET g_dbba4_d[g_detail_idx2].dbbbcrtdp = g_dept 
      LET g_dbba4_d[g_detail_idx2].dbbbcrtdt = cl_get_current()
      #end add-point
      INSERT INTO dbbb_t
                  (dbbbent,
                   dbbb001,dbbb003
                   ,dbbbstus,dbbb002,dbbbownid,dbbbowndp,dbbbcrtid,dbbbcrtdp,dbbbcrtdt,dbbbmodid,dbbbmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_dbba3_d[g_detail_idx2].dbbbstus,g_dbba3_d[g_detail_idx2].dbbb002,g_dbba4_d[g_detail_idx2].dbbbownid, 
                       g_dbba4_d[g_detail_idx2].dbbbowndp,g_dbba4_d[g_detail_idx2].dbbbcrtid,g_dbba4_d[g_detail_idx2].dbbbcrtdp, 
                       g_dbba4_d[g_detail_idx2].dbbbcrtdt,g_dbba4_d[g_detail_idx2].dbbbmodid,g_dbba4_d[g_detail_idx2].dbbbmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         RETURN
      END IF
      #add-point:insert_b段新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi210_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
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
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "dbba_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbba_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point     
   
      #將遮罩欄位還原
      CALL adbi210_dbba_t_mask_restore('restore_mask_o')
               
      UPDATE dbba_t 
         SET (dbba001
              ,dbbastus,dbba002,dbbaownid,dbbaowndp,dbbacrtid,dbbacrtdp,dbbacrtdt,dbbamodid,dbbamoddt) 
              = 
             (ps_keys[1]
              ,g_dbba_d[g_detail_idx].dbbastus,g_dbba_d[g_detail_idx].dbba002,g_dbba2_d[g_detail_idx].dbbaownid, 
                  g_dbba2_d[g_detail_idx].dbbaowndp,g_dbba2_d[g_detail_idx].dbbacrtid,g_dbba2_d[g_detail_idx].dbbacrtdp, 
                  g_dbba2_d[g_detail_idx].dbbacrtdt,g_dbba2_d[g_detail_idx].dbbamodid,g_dbba2_d[g_detail_idx].dbbamoddt)  
 
         WHERE dbbaent = g_enterprise AND
               dbba001 = ps_keys_bak[1]
 
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbba_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbba_t:",SQLERRMESSAGE  
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'dbbalent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'dbbal001'
LET l_new_key[03] = g_dlang 
LET l_old_key[03] = g_dlang 
LET l_field_key[03] = 'dbbal002'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'dbbal_t')
      END CASE
 
      #將遮罩欄位進行遮蔽
      CALL adbi210_dbba_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
   LET ls_group = "dbbb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbbb_t" THEN
   
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point    
      
      #將遮罩欄位還原
      CALL adbi210_dbbb_t_mask_restore('restore_mask_o')
      
      UPDATE dbbb_t 
         SET (dbbb001,dbbb003
              ,dbbbstus,dbbb002,dbbbownid,dbbbowndp,dbbbcrtid,dbbbcrtdp,dbbbcrtdt,dbbbmodid,dbbbmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dbba3_d[g_detail_idx2].dbbbstus,g_dbba3_d[g_detail_idx2].dbbb002,g_dbba4_d[g_detail_idx2].dbbbownid, 
                  g_dbba4_d[g_detail_idx2].dbbbowndp,g_dbba4_d[g_detail_idx2].dbbbcrtid,g_dbba4_d[g_detail_idx2].dbbbcrtdp, 
                  g_dbba4_d[g_detail_idx2].dbbbcrtdt,g_dbba4_d[g_detail_idx2].dbbbmodid,g_dbba4_d[g_detail_idx2].dbbbmoddt)  
 
         WHERE dbbbent = g_enterprise AND
               dbbb001 = ps_keys_bak[1] AND dbbb003 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point 
         
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adbi210_dbbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point 
      
      RETURN
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.key_update_b" >}
#+ 單頭key欄位變動後, 連帶修正其他單身table
PRIVATE FUNCTION adbi210_key_update_b()
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)   #(ver:44)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   
   IF g_master.dbba001 <> g_master_t.dbba001 THEN
      LET lb_chk = FALSE
   END IF
 
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #add-point:update_b段修改前 name="key_update_b.before_update2"
   
   #end add-point
   
   UPDATE dbbb_t 
      SET (dbbb001) 
           = 
          (g_master.dbba001) 
      WHERE dbbbent = g_enterprise AND
           dbbb001 = g_master_t.dbba001
 
           
   #add-point:update_b段修改中 name="key_update_b.m_update2"
   
   #end add-point
           
   CASE
      WHEN SQLCA.SQLCODE #其他錯誤
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         
      OTHERWISE
         #若有多語言table資料一同更新
         
   END CASE
   
   #add-point:update_b段修改後 name="key_update_b.after_update2"
   
   #end add-point
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi210_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL adbi210_b_fill(g_wc)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dbba_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi210_bcl USING g_enterprise,
                                       g_dbba_d[g_detail_idx].dbba001
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi210_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "dbbb_t,"
   #僅鎖定自身table
   LET ls_group = "dbbb_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbi210_bcl2 USING g_enterprise,
                                             g_master.dbba001,
                                             g_dbba3_d[g_detail_idx2].dbbb003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi210_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi210_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi210_bcl
   END IF
   
 
    
   LET ls_group = "dbbb_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE adbi210_bcl2
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi210.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION adbi210_idx_chk(ps_loc)
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   DEFINE ps_loc   LIKE type_t.chr10
   DEFINE li_idx   LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_dbba_d.getLength() THEN
         LET g_detail_idx = g_dbba_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbba_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_dbba_d.getLength()
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_dbba2_d.getLength() THEN
         LET g_detail_idx = g_dbba2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbba2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      LET li_idx = g_detail_idx
      LET li_cnt = g_dbba2_d.getLength()
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_dbba3_d.getLength() THEN
         LET g_detail_idx2 = g_dbba3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_dbba3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_dbba3_d.getLength()
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_dbba4_d.getLength() THEN
         LET g_detail_idx2 = g_dbba4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_dbba4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      LET li_idx = g_detail_idx2
      LET li_cnt = g_dbba4_d.getLength()
   END IF
 
    
   IF ps_loc = 'm' THEN
      DISPLAY li_idx TO FORMONLY.h_index
      DISPLAY li_cnt TO FORMONLY.h_count
      IF g_dbba3_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_dbba3_d.getLength() TO FORMONLY.cnt
      END IF
      IF g_dbba4_d.getLength() = 0 THEN
         DISPLAY '' TO FORMONLY.idx
         DISPLAY '' TO FORMONLY.cnt
      ELSE
         DISPLAY 1 TO FORMONLY.idx
         DISPLAY g_dbba4_d.getLength() TO FORMONLY.cnt
      END IF
 
   ELSE
      DISPLAY li_idx TO FORMONLY.idx
      DISPLAY li_cnt TO FORMONLY.cnt
   END IF
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbi210.mask_functions" >}
&include "erp/adb/adbi210_mask.4gl"
 
{</section>}
 
{<section id="adbi210.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbi210_set_pk_array()
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
   LET g_pk_array[1].values = g_dbba_d[g_detail_idx].dbba001
   LET g_pk_array[1].column = 'dbba001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbi210.state_change" >}
    
 
{</section>}
 
{<section id="adbi210.func_signature" >}
   
 
{</section>}
 
{<section id="adbi210.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adbi210.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 條件編號帶出说明
# Memo...........:
# Usage..........: CALL adbi210_dbbb003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/04/24 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi210_dbbb003_ref()
   CASE g_dbba3_d[l_ac].dbbb002
      WHEN '1'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_dbba3_d[l_ac].dbbb003
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_dbba3_d[l_ac].dbbb003_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_dbba3_d[l_ac].dbbb003_desc
      WHEN '2'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_dbba3_d[l_ac].dbbb003
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_dbba3_d[l_ac].dbbb003_desc = '', g_rtn_fields[1] , ''
         #DISPLAY BY NAME g_dbba3_d[l_ac].dbbb003_desc
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 同一品類or品牌不可以存在不同產品組中
# Memo...........:
# Usage..........: CALL adbi210_chk_dbbb003(p_type,p_dbbb003)
# Input parameter: p_type     1過欄位的檢查 2輸入多選的檢查
#                : p_dbbb003  條件編號
# Return code....: 無
# Date & Author..: 2014/04/24 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi210_chk_dbbb003(p_type,p_dbbb003)
DEFINE p_type      LIKE type_t.chr1
DEFINE p_dbbb003   LIKE dbbb_t.dbbb003
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_rtaxstus  LIKE rtax_t.rtaxstus
DEFINE l_rtax004   LIKE rtax_t.rtax004
DEFINE l_oocqstus  LIKE oocq_t.oocqstus

   LET g_errno = ''
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM dbbb_t
    WHERE dbbbent = g_enterprise
      AND dbbb002 = g_master.dbba002
      AND dbbb003 = p_dbbb003
      AND dbbbstus = 'Y'
   IF l_cnt >= 1 THEN
      #此條件編號已存在其他產品組中為有效！
      LET g_errno = 'adb-00025'
      RETURN
   END IF
   
   IF p_type = '2' THEN
      CASE g_master.dbba002
         WHEN '1'
            LET l_rtaxstus = ''
            LET l_rtax004 = ''
            SELECT rtaxstus,rtax004 INTO l_rtaxstus,l_rtax004
              FROM rtax_t
             WHERE rtaxent = g_enterprise
               AND rtax001 = p_dbbb003
            CASE
               WHEN SQLCA.sqlcode = 100
                  LET g_errno = 'anm-00080'
                  RETURN
               WHEN l_rtax004 <> g_ooaa002
                  LET g_errno = 'amm-00243'
                  RETURN
               WHEN l_rtaxstus <> 'Y'
                  #LET g_errno = 'anm-00081'#160318-00005#6 mark
                  LET g_errno = 'sub-01302' #160318-00005#6 add
                  RETURN
            END CASE
         WHEN '2'
            LET l_oocqstus = ''
            SELECT oocqstus INTO l_oocqstus
              FROM oocq_t
             WHERE oocqent = g_enterprise         #160905-00003#1 modify by rainy 加上ent條件
               AND oocq001 = '2002'
               AND oocq002 = p_dbbb003
            CASE
               WHEN SQLCA.sqlcode = 100
                  LET g_errno = 'sub-00294'
               WHEN l_oocqstus <> 'Y'
                  LET g_errno = 'sub-00295'
            END CASE
      END CASE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 當多選時，自動新增
# Memo...........:
# Usage..........: CALL adbi210_ins_dbbb()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/07 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi210_ins_dbbb()
DEFINE l_return               STRING
DEFINE l_count                LIKE type_t.num5
DEFINE l_dbbb003              LIKE dbbb_t.dbbb003
DEFINE l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT  

   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = 'c'
   LET g_qryparam.reqry = FALSE
   LET g_qryparam.default1 = g_dbba3_d[l_ac].dbbb003       #給予default值
   
   CASE g_dbba3_d[l_ac].dbbb002
      WHEN '1'
         #給予arg
         LET g_qryparam.arg1 = g_ooaa002
         LET g_qryparam.where = " rtaxstus = 'Y'"
         CALL q_rtax001_3()                                #呼叫開窗
      WHEN '2'
         #給予arg
         LET g_qryparam.arg1 = "2002"
         LET g_qryparam.where = " oocqstus = 'Y'"
         CALL q_oocq002()
   END CASE
   LET l_return = g_qryparam.return1
   LET l_ac_t = l_ac
   IF NOT cl_null(l_return) THEN
      LET l_count = 0
      LET tok = base.StringTokenizer.create(l_return,"|")
      WHILE tok.hasMoreTokens()
         LET l_dbbb003  = tok.nextToken()
         CALL adbi210_chk_dbbb003('2',l_dbbb003)
         IF cl_null(g_errno) THEN
            LET l_count = l_count + 1
            IF l_count > 1 THEN
               LET l_ac = g_dbba3_d.getLength() + 1
               LET g_detail_idx2 = l_ac
               LET g_dbba3_d[l_ac].dbbb003 = l_dbbb003
               INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_master.dbba001
               LET gs_keys[2] = g_dbba3_d[l_ac].dbbb003
               CALL adbi210_insert_b('dbbb_t',gs_keys,"'3'")
               IF SQLCA.sqlcode THEN
                  CALL g_dbba3_d.deleteElement(l_ac)
               ELSE
                  CALL adbi210_dbbb003_ref()
               END IF
            ELSE
               LET g_dbba3_d[l_ac].dbbb003 = l_dbbb003
               DISPLAY BY NAME g_dbba3_d[l_ac].dbbb003
               CALL adbi210_dbbb003_ref()
            END IF
         END IF

         LET l_ac = l_ac_t
      END WHILE
      IF l_count = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
   LET g_detail_idx2 = l_ac_t
END FUNCTION

 
{</section>}
 
