#該程式未解開Section, 採用最新樣板產出!
{<section id="apsi004.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-12-22 17:37:19), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: apsi004
#+ Description: APS料件基本資料檢視作業
#+ Creator....: 04543(2015-12-21 17:31:33)
#+ Modifier...: 04543 -SD/PR- 00000
 
{</section>}
 
{<section id="apsi004.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#2   2016/04/07  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
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
PRIVATE TYPE type_g_imaf_d RECORD
       imafsite LIKE imaf_t.imafsite, 
   imaf001 LIKE imaf_t.imaf001, 
   imaf001_desc LIKE type_t.chr500, 
   imaf001_desc_1 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr10, 
   imaa009_desc LIKE type_t.chr500, 
   imaf011 LIKE imaf_t.imaf011, 
   imaf011_desc LIKE type_t.chr500, 
   imaf013 LIKE imaf_t.imaf013, 
   imaf014 LIKE imaf_t.imaf014, 
   imaf026 LIKE imaf_t.imaf026, 
   imaf141 LIKE imaf_t.imaf141, 
   imaf141_desc LIKE type_t.chr500, 
   imaf143 LIKE imaf_t.imaf143, 
   imaf143_desc LIKE type_t.chr500, 
   imaf145 LIKE imaf_t.imaf145, 
   imaf146 LIKE imaf_t.imaf146, 
   imaf171 LIKE imaf_t.imaf171, 
   imaf172 LIKE imaf_t.imaf172, 
   imaf173 LIKE imaf_t.imaf173, 
   imaf174 LIKE imaf_t.imaf174, 
   imaf175 LIKE imaf_t.imaf175, 
   imae011 LIKE imae_t.imae011, 
   imae011_desc LIKE type_t.chr500, 
   imae012 LIKE imae_t.imae012, 
   imae012_desc LIKE type_t.chr500, 
   imae015 LIKE imae_t.imae015, 
   imae016 LIKE imae_t.imae016, 
   imae016_desc LIKE type_t.chr500, 
   imae017 LIKE imae_t.imae017, 
   imae018 LIKE imae_t.imae018, 
   imae037 LIKE imae_t.imae037, 
   imae032 LIKE imae_t.imae032, 
   imae032_desc LIKE type_t.chr500, 
   imae032_desc_1 LIKE type_t.chr500, 
   imae033 LIKE imae_t.imae033, 
   imae033_desc LIKE type_t.chr500, 
   imae022 LIKE imae_t.imae022, 
   imae036 LIKE imae_t.imae036, 
   imae062 LIKE imae_t.imae062, 
   imae064 LIKE imae_t.imae064, 
   imae077 LIKE imae_t.imae077, 
   imae078 LIKE imae_t.imae078, 
   imae079 LIKE imae_t.imae079, 
   imae080 LIKE imae_t.imae080, 
   imae071 LIKE imae_t.imae071, 
   imae072 LIKE imae_t.imae072, 
   imae073 LIKE imae_t.imae073, 
   imae074 LIKE imae_t.imae074, 
   imae081 LIKE imae_t.imae081, 
   imae081_desc LIKE type_t.chr500, 
   imae082 LIKE imae_t.imae082, 
   imae083 LIKE imae_t.imae083, 
   imae085 LIKE imae_t.imae085
       END RECORD
PRIVATE TYPE type_g_imaf2_d RECORD
       imafsite LIKE imaf_t.imafsite, 
   imaf001 LIKE imaf_t.imaf001, 
   imaf001_2_desc LIKE type_t.chr500, 
   imaf001_2_desc_1 LIKE type_t.chr500, 
   imafownid LIKE imaf_t.imafownid, 
   imafownid_desc LIKE type_t.chr500, 
   imafowndp LIKE imaf_t.imafowndp, 
   imafowndp_desc LIKE type_t.chr500, 
   imafcrtid LIKE imaf_t.imafcrtid, 
   imafcrtid_desc LIKE type_t.chr500, 
   imafcrtdp LIKE imaf_t.imafcrtdp, 
   imafcrtdp_desc LIKE type_t.chr500, 
   imafcrtdt DATETIME YEAR TO SECOND, 
   imafmodid LIKE imaf_t.imafmodid, 
   imafmodid_desc LIKE type_t.chr500, 
   imafmoddt DATETIME YEAR TO SECOND, 
   imafcnfid LIKE imaf_t.imafcnfid, 
   imafcnfid_desc LIKE type_t.chr500, 
   imafcnfdt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      imaesite LIKE imae_t.imaesite,
      imae001 LIKE imae_t.imae001,
      imae011 LIKE imae_t.imae011,
      imae012 LIKE imae_t.imae012,
      imae015 LIKE imae_t.imae015,
      imae016 LIKE imae_t.imae016,
      imae017 LIKE imae_t.imae017,
      imae018 LIKE imae_t.imae018,
      imae037 LIKE imae_t.imae037,
      imae032 LIKE imae_t.imae032,
      imae033 LIKE imae_t.imae033,
      imae022 LIKE imae_t.imae022,
      imae036 LIKE imae_t.imae036,
      imae062 LIKE imae_t.imae062,
      imae064 LIKE imae_t.imae064,
      imae077 LIKE imae_t.imae077,
      imae078 LIKE imae_t.imae078,
      imae079 LIKE imae_t.imae079,
      imae080 LIKE imae_t.imae080,
      imae071 LIKE imae_t.imae071,
      imae072 LIKE imae_t.imae072,
      imae073 LIKE imae_t.imae073,
      imae074 LIKE imae_t.imae074,
      imae081 LIKE imae_t.imae081,
      imae082 LIKE imae_t.imae082,
      imae083 LIKE imae_t.imae083,
      imae085 LIKE imae_t.imae085
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_imaf_d          DYNAMIC ARRAY OF type_g_imaf_d #單身變數
DEFINE g_imaf_d_t        type_g_imaf_d                  #單身備份
DEFINE g_imaf_d_o        type_g_imaf_d                  #單身備份
DEFINE g_imaf_d_mask_o   DYNAMIC ARRAY OF type_g_imaf_d #單身變數
DEFINE g_imaf_d_mask_n   DYNAMIC ARRAY OF type_g_imaf_d #單身變數
DEFINE g_imaf2_d   DYNAMIC ARRAY OF type_g_imaf2_d
DEFINE g_imaf2_d_t type_g_imaf2_d
DEFINE g_imaf2_d_o type_g_imaf2_d
DEFINE g_imaf2_d_mask_o DYNAMIC ARRAY OF type_g_imaf2_d
DEFINE g_imaf2_d_mask_n DYNAMIC ARRAY OF type_g_imaf2_d
 
      
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
 
{<section id="apsi004.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:作業初始化 name="main.init"
   LET g_errshow = '1'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT imafsite,imaf001,imaf011,imaf013,imaf014,imaf026,imaf141,imaf143,imaf145, 
       imaf146,imaf171,imaf172,imaf173,imaf174,imaf175,imafsite,imaf001,imafownid,imafowndp,imafcrtid, 
       imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt FROM imaf_t WHERE imafent=? AND imafsite=?  
       AND imaf001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsi004_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsi004 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsi004_init()   
 
      #進入選單 Menu (="N")
      CALL apsi004_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apsi004
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apsi004.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsi004_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('imaf013','2022') 
   CALL cl_set_combo_scc('imaf014','2023') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL apsi004_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="apsi004.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION apsi004_ui_dialog()
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
         CALL g_imaf_d.clear()
         CALL g_imaf2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL apsi004_init()
      END IF
   
      CALL apsi004_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_imaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_imaf2_d[g_detail_idx].imafownid   #(ver:35)
               LET g_data_dept = g_imaf2_d[g_detail_idx].imafowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL apsi004_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_imaf2_d TO s_detail2.*
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
   CALL apsi004_set_pk_array()
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
            
            #此作業不允許新增、刪除
            CALL cl_set_act_visible("insert,delete,reproduce", FALSE)

            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL apsi004_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL apsi004_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL apsi004_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL apsi004_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL apsi004_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL apsi004_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apsi004_insert()
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
               CALL apsi004_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_imaf_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_imaf2_d)
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
            CALL apsi004_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apsi004_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apsi004_set_pk_array()
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
 
{<section id="apsi004.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsi004_query()
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
   CALL g_imaf_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON imafsite,imaf001,imaa009,imaf011,imaf013,imaf014,imaf026,imaf141,imaf143,imaf145, 
          imaf146,imaf171,imaf172,imaf173,imaf174,imaf175,imae011,imae012,imae015,imae016,imae017,imae018, 
          imae037,imae032,imae033,imae022,imae036,imae062,imae064,imae077,imae078,imae079,imae080,imae071, 
          imae072,imae073,imae074,imae081,imae082,imae083,imae085,imafownid,imafowndp,imafcrtid,imafcrtdp, 
          imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt 
 
         FROM s_detail1[1].imafsite,s_detail1[1].imaf001,s_detail1[1].imaa009,s_detail1[1].imaf011,s_detail1[1].imaf013, 
             s_detail1[1].imaf014,s_detail1[1].imaf026,s_detail1[1].imaf141,s_detail1[1].imaf143,s_detail1[1].imaf145, 
             s_detail1[1].imaf146,s_detail1[1].imaf171,s_detail1[1].imaf172,s_detail1[1].imaf173,s_detail1[1].imaf174, 
             s_detail1[1].imaf175,s_detail1[1].imae011,s_detail1[1].imae012,s_detail1[1].imae015,s_detail1[1].imae016, 
             s_detail1[1].imae017,s_detail1[1].imae018,s_detail1[1].imae037,s_detail1[1].imae032,s_detail1[1].imae033, 
             s_detail1[1].imae022,s_detail1[1].imae036,s_detail1[1].imae062,s_detail1[1].imae064,s_detail1[1].imae077, 
             s_detail1[1].imae078,s_detail1[1].imae079,s_detail1[1].imae080,s_detail1[1].imae071,s_detail1[1].imae072, 
             s_detail1[1].imae073,s_detail1[1].imae074,s_detail1[1].imae081,s_detail1[1].imae082,s_detail1[1].imae083, 
             s_detail1[1].imae085,s_detail2[1].imafownid,s_detail2[1].imafowndp,s_detail2[1].imafcrtid, 
             s_detail2[1].imafcrtdp,s_detail2[1].imafcrtdt,s_detail2[1].imafmodid,s_detail2[1].imafmoddt, 
             s_detail2[1].imafcnfid,s_detail2[1].imafcnfdt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imafcrtdt>>----
         AFTER FIELD imafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imafmoddt>>----
         AFTER FIELD imafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imafcnfdt>>----
         AFTER FIELD imafcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imafpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafsite
            #add-point:BEFORE FIELD imafsite name="query.b.page1.imafsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafsite
            
            #add-point:AFTER FIELD imafsite name="query.a.page1.imafsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imafsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafsite
            #add-point:ON ACTION controlp INFIELD imafsite name="query.c.page1.imafsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf001
            #add-point:ON ACTION controlp INFIELD imaf001 name="construct.c.page1.imaf001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf001  #顯示到畫面上
            NEXT FIELD imaf001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf001
            #add-point:BEFORE FIELD imaf001 name="query.b.page1.imaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf001
            
            #add-point:AFTER FIELD imaf001 name="query.a.page1.imaf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.page1.imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="query.b.page1.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="query.a.page1.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf011
            #add-point:ON ACTION controlp INFIELD imaf011 name="construct.c.page1.imaf011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf011  #顯示到畫面上
            NEXT FIELD imaf011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf011
            #add-point:BEFORE FIELD imaf011 name="query.b.page1.imaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf011
            
            #add-point:AFTER FIELD imaf011 name="query.a.page1.imaf011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf013
            #add-point:BEFORE FIELD imaf013 name="query.b.page1.imaf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf013
            
            #add-point:AFTER FIELD imaf013 name="query.a.page1.imaf013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf013
            #add-point:ON ACTION controlp INFIELD imaf013 name="query.c.page1.imaf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf014
            #add-point:BEFORE FIELD imaf014 name="query.b.page1.imaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf014
            
            #add-point:AFTER FIELD imaf014 name="query.a.page1.imaf014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf014
            #add-point:ON ACTION controlp INFIELD imaf014 name="query.c.page1.imaf014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf026
            #add-point:BEFORE FIELD imaf026 name="query.b.page1.imaf026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf026
            
            #add-point:AFTER FIELD imaf026 name="query.a.page1.imaf026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf026
            #add-point:ON ACTION controlp INFIELD imaf026 name="query.c.page1.imaf026"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141 name="construct.c.page1.imaf141"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imce141()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
            NEXT FIELD imaf141                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141 name="query.b.page1.imaf141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141 name="query.a.page1.imaf141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaf143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf143
            #add-point:ON ACTION controlp INFIELD imaf143 name="construct.c.page1.imaf143"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf143  #顯示到畫面上
            NEXT FIELD imaf143                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf143
            #add-point:BEFORE FIELD imaf143 name="query.b.page1.imaf143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf143
            
            #add-point:AFTER FIELD imaf143 name="query.a.page1.imaf143"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf145
            #add-point:BEFORE FIELD imaf145 name="query.b.page1.imaf145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf145
            
            #add-point:AFTER FIELD imaf145 name="query.a.page1.imaf145"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf145
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf145
            #add-point:ON ACTION controlp INFIELD imaf145 name="query.c.page1.imaf145"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf146
            #add-point:BEFORE FIELD imaf146 name="query.b.page1.imaf146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf146
            
            #add-point:AFTER FIELD imaf146 name="query.a.page1.imaf146"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf146
            #add-point:ON ACTION controlp INFIELD imaf146 name="query.c.page1.imaf146"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf171
            #add-point:BEFORE FIELD imaf171 name="query.b.page1.imaf171"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf171
            
            #add-point:AFTER FIELD imaf171 name="query.a.page1.imaf171"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf171
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf171
            #add-point:ON ACTION controlp INFIELD imaf171 name="query.c.page1.imaf171"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf172
            #add-point:BEFORE FIELD imaf172 name="query.b.page1.imaf172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf172
            
            #add-point:AFTER FIELD imaf172 name="query.a.page1.imaf172"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf172
            #add-point:ON ACTION controlp INFIELD imaf172 name="query.c.page1.imaf172"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf173
            #add-point:BEFORE FIELD imaf173 name="query.b.page1.imaf173"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf173
            
            #add-point:AFTER FIELD imaf173 name="query.a.page1.imaf173"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf173
            #add-point:ON ACTION controlp INFIELD imaf173 name="query.c.page1.imaf173"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf174
            #add-point:BEFORE FIELD imaf174 name="query.b.page1.imaf174"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf174
            
            #add-point:AFTER FIELD imaf174 name="query.a.page1.imaf174"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf174
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf174
            #add-point:ON ACTION controlp INFIELD imaf174 name="query.c.page1.imaf174"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf175
            #add-point:BEFORE FIELD imaf175 name="query.b.page1.imaf175"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf175
            
            #add-point:AFTER FIELD imaf175 name="query.a.page1.imaf175"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imaf175
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf175
            #add-point:ON ACTION controlp INFIELD imaf175 name="query.c.page1.imaf175"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae011
            #add-point:ON ACTION controlp INFIELD imae011 name="construct.c.page1.imae011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imcf011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae011  #顯示到畫面上
            NEXT FIELD imae011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae011
            #add-point:BEFORE FIELD imae011 name="query.b.page1.imae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae011
            
            #add-point:AFTER FIELD imae011 name="query.a.page1.imae011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="construct.c.page1.imae012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae012  #顯示到畫面上
            NEXT FIELD imae012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae012
            #add-point:BEFORE FIELD imae012 name="query.b.page1.imae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae012
            
            #add-point:AFTER FIELD imae012 name="query.a.page1.imae012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae015
            #add-point:BEFORE FIELD imae015 name="query.b.page1.imae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae015
            
            #add-point:AFTER FIELD imae015 name="query.a.page1.imae015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae015
            #add-point:ON ACTION controlp INFIELD imae015 name="query.c.page1.imae015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imae016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae016
            #add-point:ON ACTION controlp INFIELD imae016 name="construct.c.page1.imae016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae016  #顯示到畫面上
            NEXT FIELD imae016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae016
            #add-point:BEFORE FIELD imae016 name="query.b.page1.imae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae016
            
            #add-point:AFTER FIELD imae016 name="query.a.page1.imae016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae017
            #add-point:BEFORE FIELD imae017 name="query.b.page1.imae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae017
            
            #add-point:AFTER FIELD imae017 name="query.a.page1.imae017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae017
            #add-point:ON ACTION controlp INFIELD imae017 name="query.c.page1.imae017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae018
            #add-point:BEFORE FIELD imae018 name="query.b.page1.imae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae018
            
            #add-point:AFTER FIELD imae018 name="query.a.page1.imae018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae018
            #add-point:ON ACTION controlp INFIELD imae018 name="query.c.page1.imae018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imae037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae037
            #add-point:ON ACTION controlp INFIELD imae037 name="construct.c.page1.imae037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae037  #顯示到畫面上
            NEXT FIELD imae037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae037
            #add-point:BEFORE FIELD imae037 name="query.b.page1.imae037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae037
            
            #add-point:AFTER FIELD imae037 name="query.a.page1.imae037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imae032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae032
            #add-point:ON ACTION controlp INFIELD imae032 name="construct.c.page1.imae032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae032  #顯示到畫面上
            NEXT FIELD imae032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae032
            #add-point:BEFORE FIELD imae032 name="query.b.page1.imae032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae032
            
            #add-point:AFTER FIELD imae032 name="query.a.page1.imae032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imae033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae033
            #add-point:ON ACTION controlp INFIELD imae033 name="construct.c.page1.imae033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ecba002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae033  #顯示到畫面上
            NEXT FIELD imae033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae033
            #add-point:BEFORE FIELD imae033 name="query.b.page1.imae033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae033
            
            #add-point:AFTER FIELD imae033 name="query.a.page1.imae033"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae022
            #add-point:BEFORE FIELD imae022 name="query.b.page1.imae022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae022
            
            #add-point:AFTER FIELD imae022 name="query.a.page1.imae022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae022
            #add-point:ON ACTION controlp INFIELD imae022 name="query.c.page1.imae022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae036
            #add-point:BEFORE FIELD imae036 name="query.b.page1.imae036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae036
            
            #add-point:AFTER FIELD imae036 name="query.a.page1.imae036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae036
            #add-point:ON ACTION controlp INFIELD imae036 name="query.c.page1.imae036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae062
            #add-point:BEFORE FIELD imae062 name="query.b.page1.imae062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae062
            
            #add-point:AFTER FIELD imae062 name="query.a.page1.imae062"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae062
            #add-point:ON ACTION controlp INFIELD imae062 name="query.c.page1.imae062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae064
            #add-point:BEFORE FIELD imae064 name="query.b.page1.imae064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae064
            
            #add-point:AFTER FIELD imae064 name="query.a.page1.imae064"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae064
            #add-point:ON ACTION controlp INFIELD imae064 name="query.c.page1.imae064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae077
            #add-point:BEFORE FIELD imae077 name="query.b.page1.imae077"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae077
            
            #add-point:AFTER FIELD imae077 name="query.a.page1.imae077"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae077
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae077
            #add-point:ON ACTION controlp INFIELD imae077 name="query.c.page1.imae077"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae078
            #add-point:BEFORE FIELD imae078 name="query.b.page1.imae078"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae078
            
            #add-point:AFTER FIELD imae078 name="query.a.page1.imae078"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae078
            #add-point:ON ACTION controlp INFIELD imae078 name="query.c.page1.imae078"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae079
            #add-point:BEFORE FIELD imae079 name="query.b.page1.imae079"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae079
            
            #add-point:AFTER FIELD imae079 name="query.a.page1.imae079"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae079
            #add-point:ON ACTION controlp INFIELD imae079 name="query.c.page1.imae079"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae080
            #add-point:BEFORE FIELD imae080 name="query.b.page1.imae080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae080
            
            #add-point:AFTER FIELD imae080 name="query.a.page1.imae080"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae080
            #add-point:ON ACTION controlp INFIELD imae080 name="query.c.page1.imae080"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae071
            #add-point:BEFORE FIELD imae071 name="query.b.page1.imae071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae071
            
            #add-point:AFTER FIELD imae071 name="query.a.page1.imae071"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae071
            #add-point:ON ACTION controlp INFIELD imae071 name="query.c.page1.imae071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae072
            #add-point:BEFORE FIELD imae072 name="query.b.page1.imae072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae072
            
            #add-point:AFTER FIELD imae072 name="query.a.page1.imae072"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae072
            #add-point:ON ACTION controlp INFIELD imae072 name="query.c.page1.imae072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae073
            #add-point:BEFORE FIELD imae073 name="query.b.page1.imae073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae073
            
            #add-point:AFTER FIELD imae073 name="query.a.page1.imae073"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae073
            #add-point:ON ACTION controlp INFIELD imae073 name="query.c.page1.imae073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae074
            #add-point:BEFORE FIELD imae074 name="query.b.page1.imae074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae074
            
            #add-point:AFTER FIELD imae074 name="query.a.page1.imae074"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae074
            #add-point:ON ACTION controlp INFIELD imae074 name="query.c.page1.imae074"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imae081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae081
            #add-point:ON ACTION controlp INFIELD imae081 name="construct.c.page1.imae081"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae081  #顯示到畫面上
            NEXT FIELD imae081                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae081
            #add-point:BEFORE FIELD imae081 name="query.b.page1.imae081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae081
            
            #add-point:AFTER FIELD imae081 name="query.a.page1.imae081"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae082
            #add-point:BEFORE FIELD imae082 name="query.b.page1.imae082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae082
            
            #add-point:AFTER FIELD imae082 name="query.a.page1.imae082"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae082
            #add-point:ON ACTION controlp INFIELD imae082 name="query.c.page1.imae082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae083
            #add-point:BEFORE FIELD imae083 name="query.b.page1.imae083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae083
            
            #add-point:AFTER FIELD imae083 name="query.a.page1.imae083"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae083
            #add-point:ON ACTION controlp INFIELD imae083 name="query.c.page1.imae083"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae085
            #add-point:BEFORE FIELD imae085 name="query.b.page1.imae085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae085
            
            #add-point:AFTER FIELD imae085 name="query.a.page1.imae085"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.imae085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae085
            #add-point:ON ACTION controlp INFIELD imae085 name="query.c.page1.imae085"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.imafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafownid
            #add-point:ON ACTION controlp INFIELD imafownid name="construct.c.page2.imafownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafownid  #顯示到畫面上
            NEXT FIELD imafownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafownid
            #add-point:BEFORE FIELD imafownid name="query.b.page2.imafownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafownid
            
            #add-point:AFTER FIELD imafownid name="query.a.page2.imafownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafowndp
            #add-point:ON ACTION controlp INFIELD imafowndp name="construct.c.page2.imafowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafowndp  #顯示到畫面上
            NEXT FIELD imafowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafowndp
            #add-point:BEFORE FIELD imafowndp name="query.b.page2.imafowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafowndp
            
            #add-point:AFTER FIELD imafowndp name="query.a.page2.imafowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafcrtid
            #add-point:ON ACTION controlp INFIELD imafcrtid name="construct.c.page2.imafcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafcrtid  #顯示到畫面上
            NEXT FIELD imafcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcrtid
            #add-point:BEFORE FIELD imafcrtid name="query.b.page2.imafcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafcrtid
            
            #add-point:AFTER FIELD imafcrtid name="query.a.page2.imafcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.imafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafcrtdp
            #add-point:ON ACTION controlp INFIELD imafcrtdp name="construct.c.page2.imafcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafcrtdp  #顯示到畫面上
            NEXT FIELD imafcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcrtdp
            #add-point:BEFORE FIELD imafcrtdp name="query.b.page2.imafcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafcrtdp
            
            #add-point:AFTER FIELD imafcrtdp name="query.a.page2.imafcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcrtdt
            #add-point:BEFORE FIELD imafcrtdt name="query.b.page2.imafcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.imafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafmodid
            #add-point:ON ACTION controlp INFIELD imafmodid name="construct.c.page2.imafmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafmodid  #顯示到畫面上
            NEXT FIELD imafmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafmodid
            #add-point:BEFORE FIELD imafmodid name="query.b.page2.imafmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafmodid
            
            #add-point:AFTER FIELD imafmodid name="query.a.page2.imafmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafmoddt
            #add-point:BEFORE FIELD imafmoddt name="query.b.page2.imafmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.imafcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafcnfid
            #add-point:ON ACTION controlp INFIELD imafcnfid name="construct.c.page2.imafcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafcnfid  #顯示到畫面上
            NEXT FIELD imafcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcnfid
            #add-point:BEFORE FIELD imafcnfid name="query.b.page2.imafcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafcnfid
            
            #add-point:AFTER FIELD imafcnfid name="query.a.page2.imafcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcnfdt
            #add-point:BEFORE FIELD imafcnfdt name="query.b.page2.imafcnfdt"
            
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
    
   CALL apsi004_b_fill(g_wc2)
   LET g_data_owner = g_imaf2_d[g_detail_idx].imafownid   #(ver:35)
   LET g_data_dept = g_imaf2_d[g_detail_idx].imafowndp   #(ver:35)
 
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
 
{<section id="apsi004.insert" >}
#+ 資料新增
PRIVATE FUNCTION apsi004_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL apsi004_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsi004.modify" >}
#+ 資料修改
PRIVATE FUNCTION apsi004_modify()
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
      INPUT ARRAY g_imaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imaf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apsi004_b_fill(g_wc2)
            LET g_detail_cnt = g_imaf_d.getLength()
         
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
            DISPLAY g_imaf_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_imaf_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_imaf_d[l_ac].imafsite IS NOT NULL
               AND g_imaf_d[l_ac].imaf001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imaf_d_t.* = g_imaf_d[l_ac].*  #BACKUP
               LET g_imaf_d_o.* = g_imaf_d[l_ac].*  #BACKUP
               IF NOT apsi004_lock_b("imaf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apsi004_bcl INTO g_imaf_d[l_ac].imafsite,g_imaf_d[l_ac].imaf001,g_imaf_d[l_ac].imaf011, 
                      g_imaf_d[l_ac].imaf013,g_imaf_d[l_ac].imaf014,g_imaf_d[l_ac].imaf026,g_imaf_d[l_ac].imaf141, 
                      g_imaf_d[l_ac].imaf143,g_imaf_d[l_ac].imaf145,g_imaf_d[l_ac].imaf146,g_imaf_d[l_ac].imaf171, 
                      g_imaf_d[l_ac].imaf172,g_imaf_d[l_ac].imaf173,g_imaf_d[l_ac].imaf174,g_imaf_d[l_ac].imaf175, 
                      g_imaf2_d[l_ac].imafsite,g_imaf2_d[l_ac].imaf001,g_imaf2_d[l_ac].imafownid,g_imaf2_d[l_ac].imafowndp, 
                      g_imaf2_d[l_ac].imafcrtid,g_imaf2_d[l_ac].imafcrtdp,g_imaf2_d[l_ac].imafcrtdt, 
                      g_imaf2_d[l_ac].imafmodid,g_imaf2_d[l_ac].imafmoddt,g_imaf2_d[l_ac].imafcnfid, 
                      g_imaf2_d[l_ac].imafcnfdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imaf_d_t.imafsite,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imaf_d_mask_o[l_ac].* =  g_imaf_d[l_ac].*
                  CALL apsi004_imaf_t_mask()
                  LET g_imaf_d_mask_n[l_ac].* =  g_imaf_d[l_ac].*
                  
                  CALL apsi004_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL apsi004_set_entry_b(l_cmd)
            CALL apsi004_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            CALL apsi004_set_required()
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.imaesite = g_imaf_d[l_ac].imafsite
LET g_detail_multi_table_t.imae001 = g_imaf_d[l_ac].imaf001
LET g_detail_multi_table_t.imae011 = g_imaf_d[l_ac].imae011
LET g_detail_multi_table_t.imae012 = g_imaf_d[l_ac].imae012
LET g_detail_multi_table_t.imae015 = g_imaf_d[l_ac].imae015
LET g_detail_multi_table_t.imae016 = g_imaf_d[l_ac].imae016
LET g_detail_multi_table_t.imae017 = g_imaf_d[l_ac].imae017
LET g_detail_multi_table_t.imae018 = g_imaf_d[l_ac].imae018
LET g_detail_multi_table_t.imae037 = g_imaf_d[l_ac].imae037
LET g_detail_multi_table_t.imae032 = g_imaf_d[l_ac].imae032
LET g_detail_multi_table_t.imae033 = g_imaf_d[l_ac].imae033
LET g_detail_multi_table_t.imae022 = g_imaf_d[l_ac].imae022
LET g_detail_multi_table_t.imae036 = g_imaf_d[l_ac].imae036
LET g_detail_multi_table_t.imae062 = g_imaf_d[l_ac].imae062
LET g_detail_multi_table_t.imae064 = g_imaf_d[l_ac].imae064
LET g_detail_multi_table_t.imae077 = g_imaf_d[l_ac].imae077
LET g_detail_multi_table_t.imae078 = g_imaf_d[l_ac].imae078
LET g_detail_multi_table_t.imae079 = g_imaf_d[l_ac].imae079
LET g_detail_multi_table_t.imae080 = g_imaf_d[l_ac].imae080
LET g_detail_multi_table_t.imae071 = g_imaf_d[l_ac].imae071
LET g_detail_multi_table_t.imae072 = g_imaf_d[l_ac].imae072
LET g_detail_multi_table_t.imae073 = g_imaf_d[l_ac].imae073
LET g_detail_multi_table_t.imae074 = g_imaf_d[l_ac].imae074
LET g_detail_multi_table_t.imae081 = g_imaf_d[l_ac].imae081
LET g_detail_multi_table_t.imae082 = g_imaf_d[l_ac].imae082
LET g_detail_multi_table_t.imae083 = g_imaf_d[l_ac].imae083
LET g_detail_multi_table_t.imae085 = g_imaf_d[l_ac].imae085
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'imaeent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'imaesite'
            LET l_var_keys[02] = g_imaf_d[l_ac].imafsite
            LET l_field_keys[03] = 'imae001'
            LET l_var_keys[03] = g_imaf_d[l_ac].imaf001
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'imae_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imaf_d_t.* TO NULL
            INITIALIZE g_imaf_d_o.* TO NULL
            INITIALIZE g_imaf_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaf2_d[l_ac].imafownid = g_user
      LET g_imaf2_d[l_ac].imafowndp = g_dept
      LET g_imaf2_d[l_ac].imafcrtid = g_user
      LET g_imaf2_d[l_ac].imafcrtdp = g_dept 
      LET g_imaf2_d[l_ac].imafcrtdt = cl_get_current()
      LET g_imaf2_d[l_ac].imafmodid = g_user
      LET g_imaf2_d[l_ac].imafmoddt = cl_get_current()
 
 
 
            #自定義預設值(單身2)
                  LET g_imaf_d[l_ac].imaf026 = "0"
      LET g_imaf_d[l_ac].imaf145 = "0"
      LET g_imaf_d[l_ac].imaf146 = "0"
      LET g_imaf_d[l_ac].imae015 = "0"
      LET g_imaf_d[l_ac].imae017 = "0"
      LET g_imaf_d[l_ac].imae018 = "0"
      LET g_imaf_d[l_ac].imae022 = "0"
      LET g_imaf_d[l_ac].imae036 = "Y"
      LET g_imaf_d[l_ac].imae064 = "0"
      LET g_imaf_d[l_ac].imae077 = "0"
      LET g_imaf_d[l_ac].imae078 = "0"
      LET g_imaf_d[l_ac].imae079 = "0"
      LET g_imaf_d[l_ac].imae080 = "N"
      LET g_imaf_d[l_ac].imae071 = "0"
      LET g_imaf_d[l_ac].imae072 = "0"
      LET g_imaf_d[l_ac].imae073 = "0"
      LET g_imaf_d[l_ac].imae074 = "0"
      LET g_imaf_d[l_ac].imae082 = "0"
      LET g_imaf_d[l_ac].imae083 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_imaf_d_t.* = g_imaf_d[l_ac].*     #新輸入資料
            LET g_imaf_d_o.* = g_imaf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imaf_d[li_reproduce_target].* = g_imaf_d[li_reproduce].*
               LET g_imaf2_d[li_reproduce_target].* = g_imaf2_d[li_reproduce].*
 
               LET g_imaf_d[g_imaf_d.getLength()].imafsite = NULL
               LET g_imaf_d[g_imaf_d.getLength()].imaf001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.imaesite = g_imaf_d[l_ac].imafsite
LET g_detail_multi_table_t.imae001 = g_imaf_d[l_ac].imaf001
LET g_detail_multi_table_t.imae011 = g_imaf_d[l_ac].imae011
LET g_detail_multi_table_t.imae012 = g_imaf_d[l_ac].imae012
LET g_detail_multi_table_t.imae015 = g_imaf_d[l_ac].imae015
LET g_detail_multi_table_t.imae016 = g_imaf_d[l_ac].imae016
LET g_detail_multi_table_t.imae017 = g_imaf_d[l_ac].imae017
LET g_detail_multi_table_t.imae018 = g_imaf_d[l_ac].imae018
LET g_detail_multi_table_t.imae037 = g_imaf_d[l_ac].imae037
LET g_detail_multi_table_t.imae032 = g_imaf_d[l_ac].imae032
LET g_detail_multi_table_t.imae033 = g_imaf_d[l_ac].imae033
LET g_detail_multi_table_t.imae022 = g_imaf_d[l_ac].imae022
LET g_detail_multi_table_t.imae036 = g_imaf_d[l_ac].imae036
LET g_detail_multi_table_t.imae062 = g_imaf_d[l_ac].imae062
LET g_detail_multi_table_t.imae064 = g_imaf_d[l_ac].imae064
LET g_detail_multi_table_t.imae077 = g_imaf_d[l_ac].imae077
LET g_detail_multi_table_t.imae078 = g_imaf_d[l_ac].imae078
LET g_detail_multi_table_t.imae079 = g_imaf_d[l_ac].imae079
LET g_detail_multi_table_t.imae080 = g_imaf_d[l_ac].imae080
LET g_detail_multi_table_t.imae071 = g_imaf_d[l_ac].imae071
LET g_detail_multi_table_t.imae072 = g_imaf_d[l_ac].imae072
LET g_detail_multi_table_t.imae073 = g_imaf_d[l_ac].imae073
LET g_detail_multi_table_t.imae074 = g_imaf_d[l_ac].imae074
LET g_detail_multi_table_t.imae081 = g_imaf_d[l_ac].imae081
LET g_detail_multi_table_t.imae082 = g_imaf_d[l_ac].imae082
LET g_detail_multi_table_t.imae083 = g_imaf_d[l_ac].imae083
LET g_detail_multi_table_t.imae085 = g_imaf_d[l_ac].imae085
 
 
            CALL apsi004_set_entry_b(l_cmd)
            CALL apsi004_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM imaf_t 
             WHERE imafent = g_enterprise AND imafsite = g_imaf_d[l_ac].imafsite
                                       AND imaf001 = g_imaf_d[l_ac].imaf001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaf_d[g_detail_idx].imafsite
               LET gs_keys[2] = g_imaf_d[g_detail_idx].imaf001
               CALL apsi004_insert_b('imaf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_imaf_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apsi004_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_imaf_d[l_ac].imafsite = g_detail_multi_table_t.imaesite AND
         g_imaf_d[l_ac].imaf001 = g_detail_multi_table_t.imae001 AND
         g_imaf_d[l_ac].imae011 = g_detail_multi_table_t.imae011 AND
         g_imaf_d[l_ac].imae012 = g_detail_multi_table_t.imae012 AND
         g_imaf_d[l_ac].imae015 = g_detail_multi_table_t.imae015 AND
         g_imaf_d[l_ac].imae016 = g_detail_multi_table_t.imae016 AND
         g_imaf_d[l_ac].imae017 = g_detail_multi_table_t.imae017 AND
         g_imaf_d[l_ac].imae018 = g_detail_multi_table_t.imae018 AND
         g_imaf_d[l_ac].imae037 = g_detail_multi_table_t.imae037 AND
         g_imaf_d[l_ac].imae032 = g_detail_multi_table_t.imae032 AND
         g_imaf_d[l_ac].imae033 = g_detail_multi_table_t.imae033 AND
         g_imaf_d[l_ac].imae022 = g_detail_multi_table_t.imae022 AND
         g_imaf_d[l_ac].imae036 = g_detail_multi_table_t.imae036 AND
         g_imaf_d[l_ac].imae062 = g_detail_multi_table_t.imae062 AND
         g_imaf_d[l_ac].imae064 = g_detail_multi_table_t.imae064 AND
         g_imaf_d[l_ac].imae077 = g_detail_multi_table_t.imae077 AND
         g_imaf_d[l_ac].imae078 = g_detail_multi_table_t.imae078 AND
         g_imaf_d[l_ac].imae079 = g_detail_multi_table_t.imae079 AND
         g_imaf_d[l_ac].imae080 = g_detail_multi_table_t.imae080 AND
         g_imaf_d[l_ac].imae071 = g_detail_multi_table_t.imae071 AND
         g_imaf_d[l_ac].imae072 = g_detail_multi_table_t.imae072 AND
         g_imaf_d[l_ac].imae073 = g_detail_multi_table_t.imae073 AND
         g_imaf_d[l_ac].imae074 = g_detail_multi_table_t.imae074 AND
         g_imaf_d[l_ac].imae081 = g_detail_multi_table_t.imae081 AND
         g_imaf_d[l_ac].imae082 = g_detail_multi_table_t.imae082 AND
         g_imaf_d[l_ac].imae083 = g_detail_multi_table_t.imae083 AND
         g_imaf_d[l_ac].imae085 = g_detail_multi_table_t.imae085 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imaeent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imaf_d[l_ac].imafsite
            LET l_field_keys[02] = 'imaesite'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.imaesite
            LET l_var_keys[03] = g_imaf_d[l_ac].imaf001
            LET l_field_keys[03] = 'imae001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.imae001
            LET l_vars[01] = g_imaf_d[l_ac].imae011
            LET l_fields[01] = 'imae011'
            LET l_vars[02] = g_imaf_d[l_ac].imae012
            LET l_fields[02] = 'imae012'
            LET l_vars[03] = g_imaf_d[l_ac].imae015
            LET l_fields[03] = 'imae015'
            LET l_vars[04] = g_imaf_d[l_ac].imae016
            LET l_fields[04] = 'imae016'
            LET l_vars[05] = g_imaf_d[l_ac].imae017
            LET l_fields[05] = 'imae017'
            LET l_vars[06] = g_imaf_d[l_ac].imae018
            LET l_fields[06] = 'imae018'
            LET l_vars[07] = g_imaf_d[l_ac].imae037
            LET l_fields[07] = 'imae037'
            LET l_vars[08] = g_imaf_d[l_ac].imae032
            LET l_fields[08] = 'imae032'
            LET l_vars[09] = g_imaf_d[l_ac].imae033
            LET l_fields[09] = 'imae033'
            LET l_vars[10] = g_imaf_d[l_ac].imae022
            LET l_fields[10] = 'imae022'
            LET l_vars[11] = g_imaf_d[l_ac].imae036
            LET l_fields[11] = 'imae036'
            LET l_vars[12] = g_imaf_d[l_ac].imae062
            LET l_fields[12] = 'imae062'
            LET l_vars[13] = g_imaf_d[l_ac].imae064
            LET l_fields[13] = 'imae064'
            LET l_vars[14] = g_imaf_d[l_ac].imae077
            LET l_fields[14] = 'imae077'
            LET l_vars[15] = g_imaf_d[l_ac].imae078
            LET l_fields[15] = 'imae078'
            LET l_vars[16] = g_imaf_d[l_ac].imae079
            LET l_fields[16] = 'imae079'
            LET l_vars[17] = g_imaf_d[l_ac].imae080
            LET l_fields[17] = 'imae080'
            LET l_vars[18] = g_imaf_d[l_ac].imae071
            LET l_fields[18] = 'imae071'
            LET l_vars[19] = g_imaf_d[l_ac].imae072
            LET l_fields[19] = 'imae072'
            LET l_vars[20] = g_imaf_d[l_ac].imae073
            LET l_fields[20] = 'imae073'
            LET l_vars[21] = g_imaf_d[l_ac].imae074
            LET l_fields[21] = 'imae074'
            LET l_vars[22] = g_imaf_d[l_ac].imae081
            LET l_fields[22] = 'imae081'
            LET l_vars[23] = g_imaf_d[l_ac].imae082
            LET l_fields[23] = 'imae082'
            LET l_vars[24] = g_imaf_d[l_ac].imae083
            LET l_fields[24] = 'imae083'
            LET l_vars[25] = g_imaf_d[l_ac].imae085
            LET l_fields[25] = 'imae085'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imae_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (imafsite = '", g_imaf_d[l_ac].imafsite, "' "
                                  ," AND imaf001 = '", g_imaf_d[l_ac].imaf001, "' "
 
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
               
               DELETE FROM imaf_t
                WHERE imafent = g_enterprise AND 
                      imafsite = g_imaf_d_t.imafsite
                      AND imaf001 = g_imaf_d_t.imaf001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'imaeent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'imaesite'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.imaesite
                  LET l_field_keys[03] = 'imae001'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.imae001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imae_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL apsi004_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_imaf_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE apsi004_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_imaf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaf_d_t.imafsite
               LET gs_keys[2] = g_imaf_d_t.imaf001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apsi004_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL apsi004_delete_b('imaf_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_imaf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafsite
            #add-point:BEFORE FIELD imafsite name="input.b.page1.imafsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafsite
            
            #add-point:AFTER FIELD imafsite name="input.a.page1.imafsite"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_imaf_d[g_detail_idx].imafsite IS NOT NULL AND g_imaf_d[g_detail_idx].imaf001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imaf_d[g_detail_idx].imafsite != g_imaf_d_t.imafsite OR g_imaf_d[g_detail_idx].imaf001 != g_imaf_d_t.imaf001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imaf_t WHERE "||"imafent = '" ||g_enterprise|| "' AND "||"imafsite = '"||g_imaf_d[g_detail_idx].imafsite ||"' AND "|| "imaf001 = '"||g_imaf_d[g_detail_idx].imaf001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imafsite
            #add-point:ON CHANGE imafsite name="input.g.page1.imafsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf001
            
            #add-point:AFTER FIELD imaf001 name="input.a.page1.imaf001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_imaf_d[g_detail_idx].imafsite IS NOT NULL AND g_imaf_d[g_detail_idx].imaf001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_imaf_d[g_detail_idx].imafsite != g_imaf_d_t.imafsite OR g_imaf_d[g_detail_idx].imaf001 != g_imaf_d_t.imaf001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imaf_t WHERE "||"imafent = '" ||g_enterprise|| "' AND "||"imafsite = '"||g_imaf_d[g_detail_idx].imafsite ||"' AND "|| "imaf001 = '"||g_imaf_d[g_detail_idx].imaf001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_d[l_ac].imaf001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_d[l_ac].imaf001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaf_d[l_ac].imaf001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf001
            #add-point:BEFORE FIELD imaf001 name="input.b.page1.imaf001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf001
            #add-point:ON CHANGE imaf001 name="input.g.page1.imaf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.page1.imaa009"
            IF NOT cl_null(g_imaf_d[l_ac].imaa009) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_d[l_ac].imaa009
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#2--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="input.b.page1.imaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009
            #add-point:ON CHANGE imaa009 name="input.g.page1.imaa009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf011
            
            #add-point:AFTER FIELD imaf011 name="input.a.page1.imaf011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_d[l_ac].imaf011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_d[l_ac].imaf011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaf_d[l_ac].imaf011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf011
            #add-point:BEFORE FIELD imaf011 name="input.b.page1.imaf011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf011
            #add-point:ON CHANGE imaf011 name="input.g.page1.imaf011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf013
            #add-point:BEFORE FIELD imaf013 name="input.b.page1.imaf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf013
            
            #add-point:AFTER FIELD imaf013 name="input.a.page1.imaf013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf013
            #add-point:ON CHANGE imaf013 name="input.g.page1.imaf013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf014
            #add-point:BEFORE FIELD imaf014 name="input.b.page1.imaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf014
            
            #add-point:AFTER FIELD imaf014 name="input.a.page1.imaf014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf014
            #add-point:ON CHANGE imaf014 name="input.g.page1.imaf014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf026
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf026,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf026
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf026 name="input.a.page1.imaf026"
            IF NOT cl_null(g_imaf_d[l_ac].imaf026) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf026
            #add-point:BEFORE FIELD imaf026 name="input.b.page1.imaf026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf026
            #add-point:ON CHANGE imaf026 name="input.g.page1.imaf026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141 name="input.a.page1.imaf141"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_d[l_ac].imaf141
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='203' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_d[l_ac].imaf141_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaf_d[l_ac].imaf141_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141 name="input.b.page1.imaf141"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf141
            #add-point:ON CHANGE imaf141 name="input.g.page1.imaf141"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf143
            
            #add-point:AFTER FIELD imaf143 name="input.a.page1.imaf143"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_d[l_ac].imaf143
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_d[l_ac].imaf143_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaf_d[l_ac].imaf143_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf143
            #add-point:BEFORE FIELD imaf143 name="input.b.page1.imaf143"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf143
            #add-point:ON CHANGE imaf143 name="input.g.page1.imaf143"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf145
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf145,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf145
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf145 name="input.a.page1.imaf145"
            IF NOT cl_null(g_imaf_d[l_ac].imaf145) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf145
            #add-point:BEFORE FIELD imaf145 name="input.b.page1.imaf145"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf145
            #add-point:ON CHANGE imaf145 name="input.g.page1.imaf145"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf146
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf146,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf146
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf146 name="input.a.page1.imaf146"
            IF NOT cl_null(g_imaf_d[l_ac].imaf146) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf146
            #add-point:BEFORE FIELD imaf146 name="input.b.page1.imaf146"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf146
            #add-point:ON CHANGE imaf146 name="input.g.page1.imaf146"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf171
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf171,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf171
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf171 name="input.a.page1.imaf171"
            IF NOT cl_null(g_imaf_d[l_ac].imaf171) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf171
            #add-point:BEFORE FIELD imaf171 name="input.b.page1.imaf171"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf171
            #add-point:ON CHANGE imaf171 name="input.g.page1.imaf171"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf172
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf172,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf172
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf172 name="input.a.page1.imaf172"
            IF NOT cl_null(g_imaf_d[l_ac].imaf172) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf172
            #add-point:BEFORE FIELD imaf172 name="input.b.page1.imaf172"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf172
            #add-point:ON CHANGE imaf172 name="input.g.page1.imaf172"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf173
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf173,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf173
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf173 name="input.a.page1.imaf173"
            IF NOT cl_null(g_imaf_d[l_ac].imaf173) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf173
            #add-point:BEFORE FIELD imaf173 name="input.b.page1.imaf173"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf173
            #add-point:ON CHANGE imaf173 name="input.g.page1.imaf173"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf174
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf174,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf174
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf174 name="input.a.page1.imaf174"
            IF NOT cl_null(g_imaf_d[l_ac].imaf174) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf174
            #add-point:BEFORE FIELD imaf174 name="input.b.page1.imaf174"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf174
            #add-point:ON CHANGE imaf174 name="input.g.page1.imaf174"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf175
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imaf175,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf175
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf175 name="input.a.page1.imaf175"
            IF NOT cl_null(g_imaf_d[l_ac].imaf175) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf175
            #add-point:BEFORE FIELD imaf175 name="input.b.page1.imaf175"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf175
            #add-point:ON CHANGE imaf175 name="input.g.page1.imaf175"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae011
            
            #add-point:AFTER FIELD imae011 name="input.a.page1.imae011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_d[l_ac].imae011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='204' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_d[l_ac].imae011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imaf_d[l_ac].imae011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae011
            #add-point:BEFORE FIELD imae011 name="input.b.page1.imae011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae011
            #add-point:ON CHANGE imae011 name="input.g.page1.imae011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae012
            
            #add-point:AFTER FIELD imae012 name="input.a.page1.imae012"
            CALL s_desc_get_person_desc(g_imaf_d[l_ac].imae012) RETURNING g_imaf_d[l_ac].imae012_desc
            DISPLAY g_imaf_d[l_ac].imae012_desc TO imae012_desc
            
            IF NOT cl_null(g_imaf_d[l_ac].imae012) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_imaf_d[l_ac].imae012
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#2--add--end
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_imaf_d[l_ac].imae012 = g_imaf_d_t.imae012
                  CALL s_desc_get_person_desc(g_imaf_d[l_ac].imae012) RETURNING g_imaf_d[l_ac].imae012_desc
                  DISPLAY g_imaf_d[l_ac].imae012_desc TO imae012_desc
                  
                  NEXT FIELD CURRENT
               END IF
               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae012
            #add-point:BEFORE FIELD imae012 name="input.b.page1.imae012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae012
            #add-point:ON CHANGE imae012 name="input.g.page1.imae012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae015,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD imae015
            END IF 
 
 
 
            #add-point:AFTER FIELD imae015 name="input.a.page1.imae015"
            IF NOT cl_null(g_imaf_d[l_ac].imae015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae015
            #add-point:BEFORE FIELD imae015 name="input.b.page1.imae015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae015
            #add-point:ON CHANGE imae015 name="input.g.page1.imae015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae016
            
            #add-point:AFTER FIELD imae016 name="input.a.page1.imae016"
            IF NOT cl_null(g_imaf_d[l_ac].imae016) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_d[l_ac].imae016
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#2--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae016
            #add-point:BEFORE FIELD imae016 name="input.b.page1.imae016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae016
            #add-point:ON CHANGE imae016 name="input.g.page1.imae016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae017
            END IF 
 
 
 
            #add-point:AFTER FIELD imae017 name="input.a.page1.imae017"
            IF NOT cl_null(g_imaf_d[l_ac].imae017) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae017
            #add-point:BEFORE FIELD imae017 name="input.b.page1.imae017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae017
            #add-point:ON CHANGE imae017 name="input.g.page1.imae017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae018
            END IF 
 
 
 
            #add-point:AFTER FIELD imae018 name="input.a.page1.imae018"
            IF NOT cl_null(g_imaf_d[l_ac].imae018) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae018
            #add-point:BEFORE FIELD imae018 name="input.b.page1.imae018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae018
            #add-point:ON CHANGE imae018 name="input.g.page1.imae018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae037
            
            #add-point:AFTER FIELD imae037 name="input.a.page1.imae037"
#            IF NOT cl_null(g_imaf_d[l_ac].imae037) THEN 
##應用 a17 樣板自動產生(Version:2)
#               #欄位存在檢查
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_imaf_d[l_ac].imae037
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_bmaa002") THEN
#                  #檢查成功時後續處理
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#
#
#            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae037
            #add-point:BEFORE FIELD imae037 name="input.b.page1.imae037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae037
            #add-point:ON CHANGE imae037 name="input.g.page1.imae037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae032
            
            #add-point:AFTER FIELD imae032 name="input.a.page1.imae032"
            CALL s_desc_get_item_desc(g_imaf_d[l_ac].imae032)
            RETURNING g_imaf_d[l_ac].imae032_desc,g_imaf_d[l_ac].imae032_desc_1
            DISPLAY g_imaf_d[l_ac].imae032_desc TO imae032_desc
            DISPLAY g_imaf_d[l_ac].imae032_desc_1 TO imae032_desc_1
            
            IF NOT cl_null(g_imaf_d[l_ac].imae032) AND g_imaf_d[l_ac].imae032 != g_imaf_d[l_ac].imaf001 THEN
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_imaf_d[l_ac].imae032
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aec-00012:sub-01302|aecm200|",cl_get_progname("aecm200",g_lang,"2"),"|:EXEPROGaecm200"
               #160318-00025#2--add--end
               IF NOT cl_chk_exist("v_ecba001") THEN
                  LET g_imaf_d[l_ac].imae032 = g_imaf_d_t.imae032
                  CALL s_desc_get_item_desc(g_imaf_d[l_ac].imae032)
                  RETURNING g_imaf_d[l_ac].imae032_desc,g_imaf_d[l_ac].imae032_desc_1
                  DISPLAY g_imaf_d[l_ac].imae032_desc TO imae032_desc
                  DISPLAY g_imaf_d[l_ac].imae032_desc_1 TO imae032_desc_1
            
                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_imaf_d[l_ac].imae033) THEN
                  IF NOT apsi004_imae032_chk(g_imaf_d[l_ac].imae032,g_imaf_d[l_ac].imae033) THEN
                     LET g_imaf_d[l_ac].imae033 = g_imaf_d_t.imae033
                  
                     CALL apsi004_imae033_ref(g_imaf_d[l_ac].imae032,g_imaf_d[l_ac].imae033)
                     RETURNING g_imaf_d[l_ac].imae033_desc
                     DISPLAY g_imaf_d[l_ac].imae033_desc TO imae033_desc

                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae032
            #add-point:BEFORE FIELD imae032 name="input.b.page1.imae032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae032
            #add-point:ON CHANGE imae032 name="input.g.page1.imae032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae033
            
            #add-point:AFTER FIELD imae033 name="input.a.page1.imae033"
#            IF NOT cl_null(g_imaf_d[l_ac].imae033) THEN 
##應用 a17 樣板自動產生(Version:2)
#               #欄位存在檢查
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_imaf_d[l_ac].imae033
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ecba002") THEN
#                  #檢查成功時後續處理
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#
#
#            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae033
            #add-point:BEFORE FIELD imae033 name="input.b.page1.imae033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae033
            #add-point:ON CHANGE imae033 name="input.g.page1.imae033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae022
            END IF 
 
 
 
            #add-point:AFTER FIELD imae022 name="input.a.page1.imae022"
            IF NOT cl_null(g_imaf_d[l_ac].imae022) AND g_imaf_d[l_ac].imae022 > 0 THEN
               #當輸入值大於0時，檢查輸入值須大於[C:生產單位批量]及[C:最小生產數量]
               IF NOT cl_null(g_imaf_d[l_ac].imae017) THEN
                  IF g_imaf_d[l_ac].imae022 <= g_imaf_d[l_ac].imae017 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00195'
                     LET g_errparam.extend = g_imaf_d[l_ac].imae022
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imaf_d[l_ac].imae022 = g_imaf_d_t.imae022
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_imaf_d[l_ac].imae018) THEN
                  IF g_imaf_d[l_ac].imae022 <= g_imaf_d[l_ac].imae018 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00196'
                     LET g_errparam.extend = g_imaf_d[l_ac].imae022
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imaf_d[l_ac].imae022 = g_imaf_d_t.imae022
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae022
            #add-point:BEFORE FIELD imae022 name="input.b.page1.imae022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae022
            #add-point:ON CHANGE imae022 name="input.g.page1.imae022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae036
            #add-point:BEFORE FIELD imae036 name="input.b.page1.imae036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae036
            
            #add-point:AFTER FIELD imae036 name="input.a.page1.imae036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae036
            #add-point:ON CHANGE imae036 name="input.g.page1.imae036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae062
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae062,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae062
            END IF 
 
 
 
            #add-point:AFTER FIELD imae062 name="input.a.page1.imae062"
            IF NOT cl_null(g_imaf_d[l_ac].imae062) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae062
            #add-point:BEFORE FIELD imae062 name="input.b.page1.imae062"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae062
            #add-point:ON CHANGE imae062 name="input.g.page1.imae062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae064
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae064,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae064
            END IF 
 
 
 
            #add-point:AFTER FIELD imae064 name="input.a.page1.imae064"
            IF NOT cl_null(g_imaf_d[l_ac].imae064) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae064
            #add-point:BEFORE FIELD imae064 name="input.b.page1.imae064"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae064
            #add-point:ON CHANGE imae064 name="input.g.page1.imae064"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae077
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae077,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae077
            END IF 
 
 
 
            #add-point:AFTER FIELD imae077 name="input.a.page1.imae077"
            IF NOT cl_null(g_imaf_d[l_ac].imae077) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae077
            #add-point:BEFORE FIELD imae077 name="input.b.page1.imae077"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae077
            #add-point:ON CHANGE imae077 name="input.g.page1.imae077"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae078
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae078,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae078
            END IF 
 
 
 
            #add-point:AFTER FIELD imae078 name="input.a.page1.imae078"
            IF NOT cl_null(g_imaf_d[l_ac].imae078) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae078
            #add-point:BEFORE FIELD imae078 name="input.b.page1.imae078"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae078
            #add-point:ON CHANGE imae078 name="input.g.page1.imae078"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae079
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae079,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae079
            END IF 
 
 
 
            #add-point:AFTER FIELD imae079 name="input.a.page1.imae079"
            IF NOT cl_null(g_imaf_d[l_ac].imae079) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae079
            #add-point:BEFORE FIELD imae079 name="input.b.page1.imae079"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae079
            #add-point:ON CHANGE imae079 name="input.g.page1.imae079"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae080
            #add-point:BEFORE FIELD imae080 name="input.b.page1.imae080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae080
            
            #add-point:AFTER FIELD imae080 name="input.a.page1.imae080"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae080
            #add-point:ON CHANGE imae080 name="input.g.page1.imae080"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae071
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae071,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae071
            END IF 
 
 
 
            #add-point:AFTER FIELD imae071 name="input.a.page1.imae071"
            IF NOT cl_null(g_imaf_d[l_ac].imae071) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae071
            #add-point:BEFORE FIELD imae071 name="input.b.page1.imae071"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae071
            #add-point:ON CHANGE imae071 name="input.g.page1.imae071"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae072
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae072,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae072
            END IF 
 
 
 
            #add-point:AFTER FIELD imae072 name="input.a.page1.imae072"
            IF NOT cl_null(g_imaf_d[l_ac].imae072) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae072
            #add-point:BEFORE FIELD imae072 name="input.b.page1.imae072"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae072
            #add-point:ON CHANGE imae072 name="input.g.page1.imae072"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae073
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae073,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae073
            END IF 
 
 
 
            #add-point:AFTER FIELD imae073 name="input.a.page1.imae073"
            IF NOT cl_null(g_imaf_d[l_ac].imae073) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae073
            #add-point:BEFORE FIELD imae073 name="input.b.page1.imae073"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae073
            #add-point:ON CHANGE imae073 name="input.g.page1.imae073"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae074
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae074,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae074
            END IF 
 
 
 
            #add-point:AFTER FIELD imae074 name="input.a.page1.imae074"
            IF NOT cl_null(g_imaf_d[l_ac].imae074) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae074
            #add-point:BEFORE FIELD imae074 name="input.b.page1.imae074"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae074
            #add-point:ON CHANGE imae074 name="input.g.page1.imae074"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae081
            
            #add-point:AFTER FIELD imae081 name="input.a.page1.imae081"
            IF NOT cl_null(g_imaf_d[l_ac].imae081) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_d[l_ac].imae081
               #160318-00025#2--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#2--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae081
            #add-point:BEFORE FIELD imae081 name="input.b.page1.imae081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae081
            #add-point:ON CHANGE imae081 name="input.g.page1.imae081"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae082
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae082,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae082
            END IF 
 
 
 
            #add-point:AFTER FIELD imae082 name="input.a.page1.imae082"
            IF NOT cl_null(g_imaf_d[l_ac].imae082) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae082
            #add-point:BEFORE FIELD imae082 name="input.b.page1.imae082"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae082
            #add-point:ON CHANGE imae082 name="input.g.page1.imae082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae083
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae083,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae083
            END IF 
 
 
 
            #add-point:AFTER FIELD imae083 name="input.a.page1.imae083"
            IF NOT cl_null(g_imaf_d[l_ac].imae083) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae083
            #add-point:BEFORE FIELD imae083 name="input.b.page1.imae083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae083
            #add-point:ON CHANGE imae083 name="input.g.page1.imae083"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae085
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_d[l_ac].imae085,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae085
            END IF 
 
 
 
            #add-point:AFTER FIELD imae085 name="input.a.page1.imae085"
            IF NOT cl_null(g_imaf_d[l_ac].imae085) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae085
            #add-point:BEFORE FIELD imae085 name="input.b.page1.imae085"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae085
            #add-point:ON CHANGE imae085 name="input.g.page1.imae085"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imafsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafsite
            #add-point:ON ACTION controlp INFIELD imafsite name="input.c.page1.imafsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf001
            #add-point:ON ACTION controlp INFIELD imaf001 name="input.c.page1.imaf001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imaf001             #給予default值
            LET g_qryparam.default2 = "" #g_imaf_d[l_ac].imaal003 #品名
            LET g_qryparam.default3 = "" #g_imaf_d[l_ac].imaal004 #規格
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_imaa001()                                #呼叫開窗

            LET g_imaf_d[l_ac].imaf001 = g_qryparam.return1              
            #LET g_imaf_d[l_ac].imaal003 = g_qryparam.return2 
            #LET g_imaf_d[l_ac].imaal004 = g_qryparam.return3 
            DISPLAY g_imaf_d[l_ac].imaf001 TO imaf001              #
            #DISPLAY g_imaf_d[l_ac].imaal003 TO imaal003 #品名
            #DISPLAY g_imaf_d[l_ac].imaal004 TO imaal004 #規格
            NEXT FIELD imaf001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.page1.imaa009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imaa009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_rtax001()                                #呼叫開窗

            LET g_imaf_d[l_ac].imaa009 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imaa009 TO imaa009              #

            NEXT FIELD imaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf011
            #add-point:ON ACTION controlp INFIELD imaf011 name="input.c.page1.imaf011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf013
            #add-point:ON ACTION controlp INFIELD imaf013 name="input.c.page1.imaf013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf014
            #add-point:ON ACTION controlp INFIELD imaf014 name="input.c.page1.imaf014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf026
            #add-point:ON ACTION controlp INFIELD imaf026 name="input.c.page1.imaf026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141 name="input.c.page1.imaf141"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imaf141             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_imce141()                                #呼叫開窗

            LET g_imaf_d[l_ac].imaf141 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imaf141 TO imaf141              #

            NEXT FIELD imaf141                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf143
            #add-point:ON ACTION controlp INFIELD imaf143 name="input.c.page1.imaf143"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imaf143             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaf_d[l_ac].imaf143 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imaf143 TO imaf143              #

            NEXT FIELD imaf143                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf145
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf145
            #add-point:ON ACTION controlp INFIELD imaf145 name="input.c.page1.imaf145"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf146
            #add-point:ON ACTION controlp INFIELD imaf146 name="input.c.page1.imaf146"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf171
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf171
            #add-point:ON ACTION controlp INFIELD imaf171 name="input.c.page1.imaf171"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf172
            #add-point:ON ACTION controlp INFIELD imaf172 name="input.c.page1.imaf172"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf173
            #add-point:ON ACTION controlp INFIELD imaf173 name="input.c.page1.imaf173"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf174
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf174
            #add-point:ON ACTION controlp INFIELD imaf174 name="input.c.page1.imaf174"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaf175
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf175
            #add-point:ON ACTION controlp INFIELD imaf175 name="input.c.page1.imaf175"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae011
            #add-point:ON ACTION controlp INFIELD imae011 name="input.c.page1.imae011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_imcf011()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae011 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imae011 TO imae011              #

            NEXT FIELD imae011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="input.c.page1.imae012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae012             #給予default值

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae012 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imae012 TO imae012              #
            
            CALL s_desc_get_person_desc(g_imaf_d[l_ac].imae012)
            RETURNING g_imaf_d[l_ac].imae012_desc
            DISPLAY g_imaf_d[l_ac].imae012_desc TO imae012_desc
            
            NEXT FIELD imae012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae015
            #add-point:ON ACTION controlp INFIELD imae015 name="input.c.page1.imae015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae016
            #add-point:ON ACTION controlp INFIELD imae016 name="input.c.page1.imae016"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae016 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imae016 TO imae016              #

            NEXT FIELD imae016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae017
            #add-point:ON ACTION controlp INFIELD imae017 name="input.c.page1.imae017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae018
            #add-point:ON ACTION controlp INFIELD imae018 name="input.c.page1.imae018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae037
            #add-point:ON ACTION controlp INFIELD imae037 name="input.c.page1.imae037"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae037             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_bmaa002()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae037 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imae037 TO imae037              #

            NEXT FIELD imae037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae032
            #add-point:ON ACTION controlp INFIELD imae032 name="input.c.page1.imae032"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae032             #給予default值
            
            CALL q_imaf001_15()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae032 = g_qryparam.return1              
            DISPLAY g_imaf_d[l_ac].imae032 TO imae032              #
            
            CALL s_desc_get_item_desc(g_imaf_d[l_ac].imae032)
            RETURNING g_imaf_d[l_ac].imae032_desc,g_imaf_d[l_ac].imae032_desc_1
            DISPLAY g_imaf_d[l_ac].imae032_desc TO imae032_desc
            DISPLAY g_imaf_d[l_ac].imae032_desc_1 TO imae032_desc_1
            
            
            NEXT FIELD imae032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae033
            #add-point:ON ACTION controlp INFIELD imae033 name="input.c.page1.imae033"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_imaf_d[l_ac].imae032


            CALL q_ecba002_1()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae033 = g_qryparam.return1
            DISPLAY g_imaf_d[l_ac].imae033 TO imae033              #

            CALL apsi004_imae033_ref(g_imaf_d[l_ac].imae032,g_imaf_d[l_ac].imae033)
            RETURNING g_imaf_d[l_ac].imae033_desc
            DISPLAY g_imaf_d[l_ac].imae033_desc TO imae033_desc

            NEXT FIELD imae033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae022
            #add-point:ON ACTION controlp INFIELD imae022 name="input.c.page1.imae022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae036
            #add-point:ON ACTION controlp INFIELD imae036 name="input.c.page1.imae036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae062
            #add-point:ON ACTION controlp INFIELD imae062 name="input.c.page1.imae062"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae064
            #add-point:ON ACTION controlp INFIELD imae064 name="input.c.page1.imae064"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae077
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae077
            #add-point:ON ACTION controlp INFIELD imae077 name="input.c.page1.imae077"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae078
            #add-point:ON ACTION controlp INFIELD imae078 name="input.c.page1.imae078"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae079
            #add-point:ON ACTION controlp INFIELD imae079 name="input.c.page1.imae079"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae080
            #add-point:ON ACTION controlp INFIELD imae080 name="input.c.page1.imae080"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae071
            #add-point:ON ACTION controlp INFIELD imae071 name="input.c.page1.imae071"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae072
            #add-point:ON ACTION controlp INFIELD imae072 name="input.c.page1.imae072"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae073
            #add-point:ON ACTION controlp INFIELD imae073 name="input.c.page1.imae073"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae074
            #add-point:ON ACTION controlp INFIELD imae074 name="input.c.page1.imae074"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae081
            #add-point:ON ACTION controlp INFIELD imae081 name="input.c.page1.imae081"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_d[l_ac].imae081             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaf_d[l_ac].imae081 = g_qryparam.return1              

            DISPLAY g_imaf_d[l_ac].imae081 TO imae081              #

            NEXT FIELD imae081                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imae082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae082
            #add-point:ON ACTION controlp INFIELD imae082 name="input.c.page1.imae082"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae083
            #add-point:ON ACTION controlp INFIELD imae083 name="input.c.page1.imae083"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imae085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae085
            #add-point:ON ACTION controlp INFIELD imae085 name="input.c.page1.imae085"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE apsi004_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_imaf_d[l_ac].* = g_imaf_d_t.*
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
               LET g_errparam.extend = g_imaf_d[l_ac].imafsite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_imaf_d[l_ac].* = g_imaf_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_imaf2_d[l_ac].imafmodid = g_user 
LET g_imaf2_d[l_ac].imafmoddt = cl_get_current()
LET g_imaf2_d[l_ac].imafmodid_desc = cl_get_username(g_imaf2_d[l_ac].imafmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
         IF g_imaf_d[l_ac].imafsite = g_detail_multi_table_t.imaesite AND
            g_imaf_d[l_ac].imaf001 = g_detail_multi_table_t.imae001 AND
            g_imaf_d[l_ac].imae011 = g_detail_multi_table_t.imae011 AND
            g_imaf_d[l_ac].imae012 = g_detail_multi_table_t.imae012 AND
            g_imaf_d[l_ac].imae015 = g_detail_multi_table_t.imae015 AND
            g_imaf_d[l_ac].imae016 = g_detail_multi_table_t.imae016 AND
            g_imaf_d[l_ac].imae017 = g_detail_multi_table_t.imae017 AND
            g_imaf_d[l_ac].imae018 = g_detail_multi_table_t.imae018 AND
            g_imaf_d[l_ac].imae037 = g_detail_multi_table_t.imae037 AND
            g_imaf_d[l_ac].imae032 = g_detail_multi_table_t.imae032 AND
            g_imaf_d[l_ac].imae033 = g_detail_multi_table_t.imae033 AND
            g_imaf_d[l_ac].imae022 = g_detail_multi_table_t.imae022 AND
            g_imaf_d[l_ac].imae036 = g_detail_multi_table_t.imae036 AND
            g_imaf_d[l_ac].imae062 = g_detail_multi_table_t.imae062 AND
            g_imaf_d[l_ac].imae064 = g_detail_multi_table_t.imae064 AND
            g_imaf_d[l_ac].imae077 = g_detail_multi_table_t.imae077 AND
            g_imaf_d[l_ac].imae078 = g_detail_multi_table_t.imae078 AND
            g_imaf_d[l_ac].imae079 = g_detail_multi_table_t.imae079 AND
            g_imaf_d[l_ac].imae080 = g_detail_multi_table_t.imae080 AND
            g_imaf_d[l_ac].imae071 = g_detail_multi_table_t.imae071 AND
            g_imaf_d[l_ac].imae072 = g_detail_multi_table_t.imae072 AND
            g_imaf_d[l_ac].imae073 = g_detail_multi_table_t.imae073 AND
            g_imaf_d[l_ac].imae074 = g_detail_multi_table_t.imae074 AND
            g_imaf_d[l_ac].imae081 = g_detail_multi_table_t.imae081 AND
            g_imaf_d[l_ac].imae082 = g_detail_multi_table_t.imae082 AND
            g_imaf_d[l_ac].imae083 = g_detail_multi_table_t.imae083 AND
            g_imaf_d[l_ac].imae085 = g_detail_multi_table_t.imae085 THEN
         ELSE
            UPDATE imae_t
               SET imaemodid = g_imaf2_d[l_ac].imafmodid,
                   imaemoddt = g_imaf2_d[l_ac].imafmoddt
             WHERE imaeent = g_enterprise
               AND imaesite = g_imaf_d_t.imafsite
               AND imae001 = g_imaf_d_t.imaf001  
                   
         END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL apsi004_imaf_t_mask_restore('restore_mask_o')
 
               UPDATE imaf_t SET (imafsite,imaf001,imaf011,imaf013,imaf014,imaf026,imaf141,imaf143,imaf145, 
                   imaf146,imaf171,imaf172,imaf173,imaf174,imaf175,imafownid,imafowndp,imafcrtid,imafcrtdp, 
                   imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt) = (g_imaf_d[l_ac].imafsite,g_imaf_d[l_ac].imaf001, 
                   g_imaf_d[l_ac].imaf011,g_imaf_d[l_ac].imaf013,g_imaf_d[l_ac].imaf014,g_imaf_d[l_ac].imaf026, 
                   g_imaf_d[l_ac].imaf141,g_imaf_d[l_ac].imaf143,g_imaf_d[l_ac].imaf145,g_imaf_d[l_ac].imaf146, 
                   g_imaf_d[l_ac].imaf171,g_imaf_d[l_ac].imaf172,g_imaf_d[l_ac].imaf173,g_imaf_d[l_ac].imaf174, 
                   g_imaf_d[l_ac].imaf175,g_imaf2_d[l_ac].imafownid,g_imaf2_d[l_ac].imafowndp,g_imaf2_d[l_ac].imafcrtid, 
                   g_imaf2_d[l_ac].imafcrtdp,g_imaf2_d[l_ac].imafcrtdt,g_imaf2_d[l_ac].imafmodid,g_imaf2_d[l_ac].imafmoddt, 
                   g_imaf2_d[l_ac].imafcnfid,g_imaf2_d[l_ac].imafcnfdt)
                WHERE imafent = g_enterprise AND
                  imafsite = g_imaf_d_t.imafsite #項次   
                  AND imaf001 = g_imaf_d_t.imaf001  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaf_d[g_detail_idx].imafsite
               LET gs_keys_bak[1] = g_imaf_d_t.imafsite
               LET gs_keys[2] = g_imaf_d[g_detail_idx].imaf001
               LET gs_keys_bak[2] = g_imaf_d_t.imaf001
               CALL apsi004_update_b('imaf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_imaf_d[l_ac].imafsite = g_detail_multi_table_t.imaesite AND
         g_imaf_d[l_ac].imaf001 = g_detail_multi_table_t.imae001 AND
         g_imaf_d[l_ac].imae011 = g_detail_multi_table_t.imae011 AND
         g_imaf_d[l_ac].imae012 = g_detail_multi_table_t.imae012 AND
         g_imaf_d[l_ac].imae015 = g_detail_multi_table_t.imae015 AND
         g_imaf_d[l_ac].imae016 = g_detail_multi_table_t.imae016 AND
         g_imaf_d[l_ac].imae017 = g_detail_multi_table_t.imae017 AND
         g_imaf_d[l_ac].imae018 = g_detail_multi_table_t.imae018 AND
         g_imaf_d[l_ac].imae037 = g_detail_multi_table_t.imae037 AND
         g_imaf_d[l_ac].imae032 = g_detail_multi_table_t.imae032 AND
         g_imaf_d[l_ac].imae033 = g_detail_multi_table_t.imae033 AND
         g_imaf_d[l_ac].imae022 = g_detail_multi_table_t.imae022 AND
         g_imaf_d[l_ac].imae036 = g_detail_multi_table_t.imae036 AND
         g_imaf_d[l_ac].imae062 = g_detail_multi_table_t.imae062 AND
         g_imaf_d[l_ac].imae064 = g_detail_multi_table_t.imae064 AND
         g_imaf_d[l_ac].imae077 = g_detail_multi_table_t.imae077 AND
         g_imaf_d[l_ac].imae078 = g_detail_multi_table_t.imae078 AND
         g_imaf_d[l_ac].imae079 = g_detail_multi_table_t.imae079 AND
         g_imaf_d[l_ac].imae080 = g_detail_multi_table_t.imae080 AND
         g_imaf_d[l_ac].imae071 = g_detail_multi_table_t.imae071 AND
         g_imaf_d[l_ac].imae072 = g_detail_multi_table_t.imae072 AND
         g_imaf_d[l_ac].imae073 = g_detail_multi_table_t.imae073 AND
         g_imaf_d[l_ac].imae074 = g_detail_multi_table_t.imae074 AND
         g_imaf_d[l_ac].imae081 = g_detail_multi_table_t.imae081 AND
         g_imaf_d[l_ac].imae082 = g_detail_multi_table_t.imae082 AND
         g_imaf_d[l_ac].imae083 = g_detail_multi_table_t.imae083 AND
         g_imaf_d[l_ac].imae085 = g_detail_multi_table_t.imae085 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imaeent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imaf_d[l_ac].imafsite
            LET l_field_keys[02] = 'imaesite'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.imaesite
            LET l_var_keys[03] = g_imaf_d[l_ac].imaf001
            LET l_field_keys[03] = 'imae001'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.imae001
            LET l_vars[01] = g_imaf_d[l_ac].imae011
            LET l_fields[01] = 'imae011'
            LET l_vars[02] = g_imaf_d[l_ac].imae012
            LET l_fields[02] = 'imae012'
            LET l_vars[03] = g_imaf_d[l_ac].imae015
            LET l_fields[03] = 'imae015'
            LET l_vars[04] = g_imaf_d[l_ac].imae016
            LET l_fields[04] = 'imae016'
            LET l_vars[05] = g_imaf_d[l_ac].imae017
            LET l_fields[05] = 'imae017'
            LET l_vars[06] = g_imaf_d[l_ac].imae018
            LET l_fields[06] = 'imae018'
            LET l_vars[07] = g_imaf_d[l_ac].imae037
            LET l_fields[07] = 'imae037'
            LET l_vars[08] = g_imaf_d[l_ac].imae032
            LET l_fields[08] = 'imae032'
            LET l_vars[09] = g_imaf_d[l_ac].imae033
            LET l_fields[09] = 'imae033'
            LET l_vars[10] = g_imaf_d[l_ac].imae022
            LET l_fields[10] = 'imae022'
            LET l_vars[11] = g_imaf_d[l_ac].imae036
            LET l_fields[11] = 'imae036'
            LET l_vars[12] = g_imaf_d[l_ac].imae062
            LET l_fields[12] = 'imae062'
            LET l_vars[13] = g_imaf_d[l_ac].imae064
            LET l_fields[13] = 'imae064'
            LET l_vars[14] = g_imaf_d[l_ac].imae077
            LET l_fields[14] = 'imae077'
            LET l_vars[15] = g_imaf_d[l_ac].imae078
            LET l_fields[15] = 'imae078'
            LET l_vars[16] = g_imaf_d[l_ac].imae079
            LET l_fields[16] = 'imae079'
            LET l_vars[17] = g_imaf_d[l_ac].imae080
            LET l_fields[17] = 'imae080'
            LET l_vars[18] = g_imaf_d[l_ac].imae071
            LET l_fields[18] = 'imae071'
            LET l_vars[19] = g_imaf_d[l_ac].imae072
            LET l_fields[19] = 'imae072'
            LET l_vars[20] = g_imaf_d[l_ac].imae073
            LET l_fields[20] = 'imae073'
            LET l_vars[21] = g_imaf_d[l_ac].imae074
            LET l_fields[21] = 'imae074'
            LET l_vars[22] = g_imaf_d[l_ac].imae081
            LET l_fields[22] = 'imae081'
            LET l_vars[23] = g_imaf_d[l_ac].imae082
            LET l_fields[23] = 'imae082'
            LET l_vars[24] = g_imaf_d[l_ac].imae083
            LET l_fields[24] = 'imae083'
            LET l_vars[25] = g_imaf_d[l_ac].imae085
            LET l_fields[25] = 'imae085'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imae_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_imaf_d_t)
                     LET g_log2 = util.JSON.stringify(g_imaf_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL apsi004_imaf_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL apsi004_unlock_b("imaf_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imaf_d[l_ac].* = g_imaf_d_t.*
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
               LET g_imaf_d[li_reproduce_target].* = g_imaf_d[li_reproduce].*
               LET g_imaf2_d[li_reproduce_target].* = g_imaf2_d[li_reproduce].*
 
               LET g_imaf_d[li_reproduce_target].imafsite = NULL
               LET g_imaf_d[li_reproduce_target].imaf001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imaf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imaf_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_imaf2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL apsi004_b_fill(g_wc2)
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
               NEXT FIELD imafsite
            WHEN "s_detail2"
               NEXT FIELD imafsite_2
 
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
      IF INT_FLAG OR cl_null(g_imaf_d[g_detail_idx].imafsite) THEN
         CALL g_imaf_d.deleteElement(g_detail_idx)
         CALL g_imaf2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_imaf_d[g_detail_idx].* = g_imaf_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE apsi004_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="apsi004.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apsi004_delete()
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
   FOR li_idx = 1 TO g_imaf_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT apsi004_lock_b("imaf_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("imaf_t","imafownid") THEN
            LET g_data_owner = g_imaf2_d[g_detail_idx].imafownid
            LET g_data_dept = g_imaf2_d[g_detail_idx].imafowndp
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
   
   FOR li_idx = 1 TO g_imaf_d.getLength()
      IF g_imaf_d[li_idx].imafsite IS NOT NULL
         AND g_imaf_d[li_idx].imaf001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM imaf_t
          WHERE imafent = g_enterprise AND 
                imafsite = g_imaf_d[li_idx].imafsite
                AND imaf001 = g_imaf_d[li_idx].imaf001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.imaesite = g_imaf_d[l_ac].imafsite
LET g_detail_multi_table_t.imae001 = g_imaf_d[l_ac].imaf001
LET g_detail_multi_table_t.imae011 = g_imaf_d[l_ac].imae011
LET g_detail_multi_table_t.imae012 = g_imaf_d[l_ac].imae012
LET g_detail_multi_table_t.imae015 = g_imaf_d[l_ac].imae015
LET g_detail_multi_table_t.imae016 = g_imaf_d[l_ac].imae016
LET g_detail_multi_table_t.imae017 = g_imaf_d[l_ac].imae017
LET g_detail_multi_table_t.imae018 = g_imaf_d[l_ac].imae018
LET g_detail_multi_table_t.imae037 = g_imaf_d[l_ac].imae037
LET g_detail_multi_table_t.imae032 = g_imaf_d[l_ac].imae032
LET g_detail_multi_table_t.imae033 = g_imaf_d[l_ac].imae033
LET g_detail_multi_table_t.imae022 = g_imaf_d[l_ac].imae022
LET g_detail_multi_table_t.imae036 = g_imaf_d[l_ac].imae036
LET g_detail_multi_table_t.imae062 = g_imaf_d[l_ac].imae062
LET g_detail_multi_table_t.imae064 = g_imaf_d[l_ac].imae064
LET g_detail_multi_table_t.imae077 = g_imaf_d[l_ac].imae077
LET g_detail_multi_table_t.imae078 = g_imaf_d[l_ac].imae078
LET g_detail_multi_table_t.imae079 = g_imaf_d[l_ac].imae079
LET g_detail_multi_table_t.imae080 = g_imaf_d[l_ac].imae080
LET g_detail_multi_table_t.imae071 = g_imaf_d[l_ac].imae071
LET g_detail_multi_table_t.imae072 = g_imaf_d[l_ac].imae072
LET g_detail_multi_table_t.imae073 = g_imaf_d[l_ac].imae073
LET g_detail_multi_table_t.imae074 = g_imaf_d[l_ac].imae074
LET g_detail_multi_table_t.imae081 = g_imaf_d[l_ac].imae081
LET g_detail_multi_table_t.imae082 = g_imaf_d[l_ac].imae082
LET g_detail_multi_table_t.imae083 = g_imaf_d[l_ac].imae083
LET g_detail_multi_table_t.imae085 = g_imaf_d[l_ac].imae085
 
 
            
LET g_detail_multi_table_t.imaesite = g_imaf_d[l_ac].imafsite
LET g_detail_multi_table_t.imae001 = g_imaf_d[l_ac].imaf001
LET g_detail_multi_table_t.imae011 = g_imaf_d[l_ac].imae011
LET g_detail_multi_table_t.imae012 = g_imaf_d[l_ac].imae012
LET g_detail_multi_table_t.imae015 = g_imaf_d[l_ac].imae015
LET g_detail_multi_table_t.imae016 = g_imaf_d[l_ac].imae016
LET g_detail_multi_table_t.imae017 = g_imaf_d[l_ac].imae017
LET g_detail_multi_table_t.imae018 = g_imaf_d[l_ac].imae018
LET g_detail_multi_table_t.imae037 = g_imaf_d[l_ac].imae037
LET g_detail_multi_table_t.imae032 = g_imaf_d[l_ac].imae032
LET g_detail_multi_table_t.imae033 = g_imaf_d[l_ac].imae033
LET g_detail_multi_table_t.imae022 = g_imaf_d[l_ac].imae022
LET g_detail_multi_table_t.imae036 = g_imaf_d[l_ac].imae036
LET g_detail_multi_table_t.imae062 = g_imaf_d[l_ac].imae062
LET g_detail_multi_table_t.imae064 = g_imaf_d[l_ac].imae064
LET g_detail_multi_table_t.imae077 = g_imaf_d[l_ac].imae077
LET g_detail_multi_table_t.imae078 = g_imaf_d[l_ac].imae078
LET g_detail_multi_table_t.imae079 = g_imaf_d[l_ac].imae079
LET g_detail_multi_table_t.imae080 = g_imaf_d[l_ac].imae080
LET g_detail_multi_table_t.imae071 = g_imaf_d[l_ac].imae071
LET g_detail_multi_table_t.imae072 = g_imaf_d[l_ac].imae072
LET g_detail_multi_table_t.imae073 = g_imaf_d[l_ac].imae073
LET g_detail_multi_table_t.imae074 = g_imaf_d[l_ac].imae074
LET g_detail_multi_table_t.imae081 = g_imaf_d[l_ac].imae081
LET g_detail_multi_table_t.imae082 = g_imaf_d[l_ac].imae082
LET g_detail_multi_table_t.imae083 = g_imaf_d[l_ac].imae083
LET g_detail_multi_table_t.imae085 = g_imaf_d[l_ac].imae085
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'imaeent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'imaesite'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.imaesite
                  LET l_field_keys[03] = 'imae001'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.imae001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imae_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'imaeent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'imaesite'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.imaesite
                  LET l_field_keys[03] = 'imae001'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.imae001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imae_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imaf_d_t.imafsite
               LET gs_keys[2] = g_imaf_d_t.imaf001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL apsi004_delete_b('imaf_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apsi004_set_pk_array()
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
   CALL apsi004_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="apsi004.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsi004_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.imafsite,t0.imaf001,t0.imaf011,t0.imaf013,t0.imaf014,t0.imaf026, 
       t0.imaf141,t0.imaf143,t0.imaf145,t0.imaf146,t0.imaf171,t0.imaf172,t0.imaf173,t0.imaf174,t0.imaf175, 
       t0.imafsite,t0.imaf001,t0.imafownid,t0.imafowndp,t0.imafcrtid,t0.imafcrtdp,t0.imafcrtdt,t0.imafmodid, 
       t0.imafmoddt,t0.imafcnfid,t0.imafcnfdt ,t1.imaal003 ,t3.oocql004 ,t4.oocql004 ,t5.oocal003 ,t12.ooag011 , 
       t13.ooefl003 ,t14.ooag011 ,t15.ooefl003 ,t16.ooag011 ,t17.ooag011 FROM imaf_t t0",
               " LEFT JOIN imae_t ON imaeent = "||g_enterprise||" AND imafsite = imaesite AND imaf001 = imae001",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.imaf001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='200' AND t3.oocql002=t0.imaf011 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='203' AND t4.oocql002=t0.imaf141 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.imaf143 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.imafownid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.imafowndp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.imafcrtid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.imafcrtdp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.imafmodid  ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.imafcnfid  ",
 
               " WHERE t0.imafent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("imaf_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND imafowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("imaf_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND imafownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = "SELECT  UNIQUE t0.imafsite,t0.imaf001,t0.imaf011,t0.imaf013,t0.imaf014,t0.imaf026,t0.imaf141, 
       t0.imaf143,t0.imaf145,t0.imaf146,t0.imaf171,t0.imaf172,t0.imaf173,t0.imaf174,t0.imaf175,t0.imafsite, 
       t0.imaf001,t0.imafownid,t0.imafowndp,t0.imafcrtid,t0.imafcrtdp,t0.imafcrtdt,t0.imafmodid,t0.imafmoddt, 
       t0.imafcnfid,t0.imafcnfdt ,t1.imaal003 ,t3.oocql004 ,t4.oocql004 ,t5.oocal003 ,t12.ooag011 ,t13.ooefl003 , 
       t14.ooag011 ,t15.ooefl003 ,t16.ooag011 ,t17.ooag011 FROM imaf_t t0",
               " LEFT JOIN imae_t ON imaeent = '"||g_enterprise||"' AND imafsite = imaesite AND imaf001 = imae001",
               " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.imaf001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='200' AND t3.oocql002=t0.imaf011 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='203' AND t4.oocql002=t0.imaf141 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=t0.imaf143 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent='"||g_enterprise||"' AND t12.ooag001=t0.imafownid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent='"||g_enterprise||"' AND t13.ooefl001=t0.imafowndp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent='"||g_enterprise||"' AND t14.ooag001=t0.imafcrtid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent='"||g_enterprise||"' AND t15.ooefl001=t0.imafcrtdp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent='"||g_enterprise||"' AND t16.ooag001=t0.imafmodid  ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent='"||g_enterprise||"' AND t17.ooag001=t0.imafcnfid  ",
 
               " LEFT JOIN imaa_t ON imaaent = '"||g_enterprise||"' AND imaa001 = imaf001 ",
 
               " WHERE t0.imafent= ?  AND  1=1 AND (", p_wc2, ") ",
               
               "   AND imafsite = '",g_site,"'"
               
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("imaf_t"),
                      " ORDER BY t0.imafsite,t0.imaf001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"imaf_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apsi004_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsi004_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_imaf_d.clear()
   CALL g_imaf2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_imaf_d[l_ac].imafsite,g_imaf_d[l_ac].imaf001,g_imaf_d[l_ac].imaf011,g_imaf_d[l_ac].imaf013, 
       g_imaf_d[l_ac].imaf014,g_imaf_d[l_ac].imaf026,g_imaf_d[l_ac].imaf141,g_imaf_d[l_ac].imaf143,g_imaf_d[l_ac].imaf145, 
       g_imaf_d[l_ac].imaf146,g_imaf_d[l_ac].imaf171,g_imaf_d[l_ac].imaf172,g_imaf_d[l_ac].imaf173,g_imaf_d[l_ac].imaf174, 
       g_imaf_d[l_ac].imaf175,g_imaf2_d[l_ac].imafsite,g_imaf2_d[l_ac].imaf001,g_imaf2_d[l_ac].imafownid, 
       g_imaf2_d[l_ac].imafowndp,g_imaf2_d[l_ac].imafcrtid,g_imaf2_d[l_ac].imafcrtdp,g_imaf2_d[l_ac].imafcrtdt, 
       g_imaf2_d[l_ac].imafmodid,g_imaf2_d[l_ac].imafmoddt,g_imaf2_d[l_ac].imafcnfid,g_imaf2_d[l_ac].imafcnfdt, 
       g_imaf_d[l_ac].imaf001_desc,g_imaf_d[l_ac].imaf011_desc,g_imaf_d[l_ac].imaf141_desc,g_imaf_d[l_ac].imaf143_desc, 
       g_imaf2_d[l_ac].imafownid_desc,g_imaf2_d[l_ac].imafowndp_desc,g_imaf2_d[l_ac].imafcrtid_desc, 
       g_imaf2_d[l_ac].imafcrtdp_desc,g_imaf2_d[l_ac].imafmodid_desc,g_imaf2_d[l_ac].imafcnfid_desc
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
      
      CALL apsi004_detail_show()      
 
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
   
 
   
   CALL g_imaf_d.deleteElement(g_imaf_d.getLength())   
   CALL g_imaf2_d.deleteElement(g_imaf2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_imaf_d.getLength()
      LET g_imaf2_d[l_ac].imafsite = g_imaf_d[l_ac].imafsite 
      LET g_imaf2_d[l_ac].imaf001 = g_imaf_d[l_ac].imaf001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_imaf_d.getLength() THEN
      LET l_ac = g_imaf_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_imaf_d.getLength()
      LET g_imaf_d_mask_o[l_ac].* =  g_imaf_d[l_ac].*
      CALL apsi004_imaf_t_mask()
      LET g_imaf_d_mask_n[l_ac].* =  g_imaf_d[l_ac].*
   END FOR
   
   LET g_imaf2_d_mask_o.* =  g_imaf2_d.*
   FOR l_ac = 1 TO g_imaf2_d.getLength()
      LET g_imaf2_d_mask_o[l_ac].* =  g_imaf2_d[l_ac].*
      CALL apsi004_imaf_t_mask()
      LET g_imaf2_d_mask_n[l_ac].* =  g_imaf2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_imaf_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE apsi004_pb
   
END FUNCTION
 
{</section>}
 
{<section id="apsi004.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsi004_detail_show()
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
   
   #品名、規格
   CALL s_desc_get_item_desc(g_imaf_d[l_ac].imaf001) RETURNING g_imaf_d[l_ac].imaf001_desc,g_imaf_d[l_ac].imaf001_desc_1
   
   LET g_imaf2_d[l_ac].imaf001_2_desc = g_imaf_d[l_ac].imaf001_desc
   LET g_imaf2_d[l_ac].imaf001_2_desc_1 = g_imaf_d[l_ac].imaf001_desc_1
   
   
   #imaa_t
   SELECT imaa009,rtaxl003
     INTO g_imaf_d[l_ac].imaa009,g_imaf_d[l_ac].imaa009_desc
     FROM imaa_t LEFT OUTER JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = g_dlang
    WHERE imaaent = g_enterprise AND imaa001 = g_imaf_d[l_ac].imaf001
   
   #imae
   SELECT imae011,oocql004,
          imae012,ooag011,
          imae015,
          imae016,a.oocal003,
          imae017,imae018,imae037,
          imae032,imaal003,imaal004,
          imae033,ecba003,
          imae022,imae036,imae062,
          imae064,imae077,imae078,
          imae079,imae080,imae071,
          imae072,imae073,imae074,
          imae081,b.oocal003,
          imae082,imae083,imae085
     INTO g_imaf_d[l_ac].imae011,g_imaf_d[l_ac].imae011_desc,
          g_imaf_d[l_ac].imae012,g_imaf_d[l_ac].imae012_desc,
          g_imaf_d[l_ac].imae015,
          g_imaf_d[l_ac].imae016,g_imaf_d[l_ac].imae016_desc,
          g_imaf_d[l_ac].imae017,g_imaf_d[l_ac].imae018,g_imaf_d[l_ac].imae037,
          g_imaf_d[l_ac].imae032,g_imaf_d[l_ac].imae032_desc,g_imaf_d[l_ac].imae032_desc_1,
          g_imaf_d[l_ac].imae033,g_imaf_d[l_ac].imae033_desc,
          g_imaf_d[l_ac].imae022,g_imaf_d[l_ac].imae036,g_imaf_d[l_ac].imae062,
          g_imaf_d[l_ac].imae064,g_imaf_d[l_ac].imae077,g_imaf_d[l_ac].imae078,
          g_imaf_d[l_ac].imae079,g_imaf_d[l_ac].imae080,g_imaf_d[l_ac].imae071,
          g_imaf_d[l_ac].imae072,g_imaf_d[l_ac].imae073,g_imaf_d[l_ac].imae074,
          g_imaf_d[l_ac].imae081,g_imaf_d[l_ac].imae081_desc,
          g_imaf_d[l_ac].imae082,g_imaf_d[l_ac].imae083,g_imaf_d[l_ac].imae085
          
    FROM imae_t LEFT OUTER JOIN oocql_t ON oocqlent = imaeent AND oocql001 = '204' AND oocql002 = imae011 AND oocql003 = g_dlang
                LEFT OUTER JOIN ooag_t ON ooagent = imaeent AND ooag001 = imae012
                LEFT OUTER JOIN oocal_t a ON a.oocalent = imaeent AND a.oocal001 = imae016 AND a.oocal002 = g_dlang
                LEFT OUTER JOIN imaal_t ON imaalent = imaeent AND imaal001 = imae001 AND imaal002 = g_dlang
                LEFT OUTER JOIN ecba_t ON ecbaent = imaeent AND ecbasite = imaesite AND ecba001 = imae032 AND ecba002 = imae033
                LEFT OUTER JOIN oocal_t b ON b.oocalent = imaeent AND b.oocal001 = imae081 AND b.oocal002 = g_dlang
   WHERE imaeent = g_enterprise
     AND imaesite = g_imaf_d[l_ac].imafsite
     AND imae001 = g_imaf_d[l_ac].imaf001



   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsi004.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apsi004_set_entry_b(p_cmd)                                                  
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
 
{<section id="apsi004.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apsi004_set_no_entry_b(p_cmd)                                               
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
 
{<section id="apsi004.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apsi004_default_search()
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
      LET ls_wc = ls_wc, " imafsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " imaf001 = '", g_argv[02], "' AND "
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
 
{<section id="apsi004.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apsi004_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "imaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'imaf_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM imaf_t
          WHERE imafent = g_enterprise AND
            imafsite = ps_keys_bak[1] AND imaf001 = ps_keys_bak[2]
         
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
         CALL g_imaf_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_imaf2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apsi004.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apsi004_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "imaf_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO imaf_t
                  (imafent,
                   imafsite,imaf001
                   ,imaf011,imaf013,imaf014,imaf026,imaf141,imaf143,imaf145,imaf146,imaf171,imaf172,imaf173,imaf174,imaf175,imafownid,imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imaf_d[l_ac].imaf011,g_imaf_d[l_ac].imaf013,g_imaf_d[l_ac].imaf014,g_imaf_d[l_ac].imaf026, 
                       g_imaf_d[l_ac].imaf141,g_imaf_d[l_ac].imaf143,g_imaf_d[l_ac].imaf145,g_imaf_d[l_ac].imaf146, 
                       g_imaf_d[l_ac].imaf171,g_imaf_d[l_ac].imaf172,g_imaf_d[l_ac].imaf173,g_imaf_d[l_ac].imaf174, 
                       g_imaf_d[l_ac].imaf175,g_imaf2_d[l_ac].imafownid,g_imaf2_d[l_ac].imafowndp,g_imaf2_d[l_ac].imafcrtid, 
                       g_imaf2_d[l_ac].imafcrtdp,g_imaf2_d[l_ac].imafcrtdt,g_imaf2_d[l_ac].imafmodid, 
                       g_imaf2_d[l_ac].imafmoddt,g_imaf2_d[l_ac].imafcnfid,g_imaf2_d[l_ac].imafcnfdt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="apsi004.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apsi004_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "imaf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "imaf_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE imaf_t 
         SET (imafsite,imaf001
              ,imaf011,imaf013,imaf014,imaf026,imaf141,imaf143,imaf145,imaf146,imaf171,imaf172,imaf173,imaf174,imaf175,imafownid,imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imaf_d[l_ac].imaf011,g_imaf_d[l_ac].imaf013,g_imaf_d[l_ac].imaf014,g_imaf_d[l_ac].imaf026, 
                  g_imaf_d[l_ac].imaf141,g_imaf_d[l_ac].imaf143,g_imaf_d[l_ac].imaf145,g_imaf_d[l_ac].imaf146, 
                  g_imaf_d[l_ac].imaf171,g_imaf_d[l_ac].imaf172,g_imaf_d[l_ac].imaf173,g_imaf_d[l_ac].imaf174, 
                  g_imaf_d[l_ac].imaf175,g_imaf2_d[l_ac].imafownid,g_imaf2_d[l_ac].imafowndp,g_imaf2_d[l_ac].imafcrtid, 
                  g_imaf2_d[l_ac].imafcrtdp,g_imaf2_d[l_ac].imafcrtdt,g_imaf2_d[l_ac].imafmodid,g_imaf2_d[l_ac].imafmoddt, 
                  g_imaf2_d[l_ac].imafcnfid,g_imaf2_d[l_ac].imafcnfdt) 
         WHERE imafent = g_enterprise AND imafsite = ps_keys_bak[1] AND imaf001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
 
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imaf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
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
 
{<section id="apsi004.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apsi004_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL apsi004_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "imaf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apsi004_bcl USING g_enterprise,
                                       g_imaf_d[g_detail_idx].imafsite,g_imaf_d[g_detail_idx].imaf001 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apsi004_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apsi004.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apsi004_unlock_b(ps_table)
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
      CLOSE apsi004_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apsi004.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION apsi004_modify_detail_chk(ps_record)
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
         LET ls_return = "imafsite"
      WHEN "s_detail2"
         LET ls_return = "imafsite_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="apsi004.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION apsi004_show_ownid_msg()
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
 
{<section id="apsi004.mask_functions" >}
&include "erp/aps/apsi004_mask.4gl"
 
{</section>}
 
{<section id="apsi004.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apsi004_set_pk_array()
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
   LET g_pk_array[1].values = g_imaf_d[l_ac].imafsite
   LET g_pk_array[1].column = 'imafsite'
   LET g_pk_array[2].values = g_imaf_d[l_ac].imaf001
   LET g_pk_array[2].column = 'imaf001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apsi004.state_change" >}
   
 
{</section>}
 
{<section id="apsi004.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="apsi004.other_function" readonly="Y" >}

PRIVATE FUNCTION apsi004_imae032_chk(p_imae032,p_imae033)
   DEFINE p_imae032      LIKE imae_t.imae032
   DEFINE p_imae033      LIKE imae_t.imae033
   DEFINE r_success      LIKE type_t.num5

   LET r_success = TRUE
   INITIALIZE g_chkparam.* TO NULL

   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = p_imae032
   #呼叫檢查存在並帶值的library
   IF cl_chk_exist("v_imaa001") THEN
      IF NOT cl_chk_exist("v_imaf001_14") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apsi004_imae033_ref(p_imae032,p_imae033)
   DEFINE p_imae032      LIKE imae_t.imae032
   DEFINE p_imae033      LIKE imae_t.imae033
   DEFINE r_imae033_desc LIKE ecba_t.ecba003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imae032
   LET g_ref_fields[2] = p_imae033
   CALL ap_ref_array2(g_ref_fields,"SELECT ecba003 FROM ecba_t WHERE ecbaent='"||g_enterprise||"' AND ecbasite='"||g_site||"' AND ecba001 = ? AND ecba002 = ? ","")
   RETURNING g_rtn_fields
    
   LET r_imae033_desc = g_rtn_fields[1]
   RETURN r_imae033_desc
END FUNCTION

PRIVATE FUNCTION apsi004_set_required()
  CALL cl_set_comp_required("imae036,imae080",TRUE)
END FUNCTION

 
{</section>}
 
