#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-10-11 09:24:15), PR版次:0011(2017-02-10 16:25:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000302
#+ Filename...: abgi010
#+ Description: 預算編號維護作業
#+ Creator....: 02298(2013-07-01 00:00:00)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi010.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150709-00008#2 150713 By Jessy 修改欄位、預算週期開窗內容，預算項目參照表條件式開窗
#160222         160222 By albireo 修正會科參照表檢核邏輯
#160318-00005#3 160318 By Jessy 修正azzi920重複定義之錯誤訊息
#160314-00023#1 160322 By Jessy 開窗項目預算參照表時會出錯誤訊息
#160425-00020#2 160426 By albireo 1.使用科目預算否預設N  ,將欄位隱藏 
#                                 2.預算項目參照表開窗 取 abgi040 已存在之預算參照表號
#161003-00014#3  161011 By Hans   2.編製起點預設值:隱藏 
#                                 3.最上層組織:預設 g_site 所屬法人 開窗:維持目前取預算組織樹最上層, 
#                                    檢核: 預算組織 ( aooi100 的 ooef205 =Y) 
#                                 4.版本可空白 
#                                 5.預算細項參照表離開欄位時要加檢核是否存在於參照表 aooi081 開窗修改: 只開 aooi081 資料, 不用串到 abgi040 
#161003-00014#21 161011 By Hans    編製匯率固定放 = 7:預算匯率檔彙編且隱藏
#170209-00020#1  170210 By Hans   預算編號存在於abgi100中 不可刪除。

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
PRIVATE TYPE type_g_bgaa_d RECORD
       bgaastus LIKE bgaa_t.bgaastus, 
   bgaa001 LIKE bgaa_t.bgaa001, 
   bgaal003 LIKE bgaal_t.bgaal003, 
   bgaa002 LIKE bgaa_t.bgaa002, 
   bgaa003 LIKE bgaa_t.bgaa003, 
   bgaa004 LIKE bgaa_t.bgaa004, 
   bgaa005 LIKE bgaa_t.bgaa005, 
   bgaa006 LIKE bgaa_t.bgaa006, 
   bgaa007 LIKE bgaa_t.bgaa007, 
   bgaa012 LIKE bgaa_t.bgaa012, 
   bgaa008 LIKE bgaa_t.bgaa008, 
   bgaa009 LIKE bgaa_t.bgaa009, 
   bgaa011 LIKE bgaa_t.bgaa011, 
   bgaa011_desc LIKE type_t.chr500, 
   bgaa010 LIKE bgaa_t.bgaa010
       END RECORD
PRIVATE TYPE type_g_bgaa1_info_d RECORD
       bgaa001 LIKE bgaa_t.bgaa001, 
   bgaaownid LIKE bgaa_t.bgaaownid, 
   bgaaownid_desc LIKE type_t.chr500, 
   bgaaowndp LIKE bgaa_t.bgaaowndp, 
   bgaaowndp_desc LIKE type_t.chr500, 
   bgaacrtid LIKE bgaa_t.bgaacrtid, 
   bgaacrtid_desc LIKE type_t.chr500, 
   bgaacrtdp LIKE bgaa_t.bgaacrtdp, 
   bgaacrtdp_desc LIKE type_t.chr500, 
   bgaacrtdt DATETIME YEAR TO SECOND, 
   bgaamodid LIKE bgaa_t.bgaamodid, 
   bgaamodid_desc LIKE type_t.chr500, 
   bgaamoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      bgaal001 LIKE bgaal_t.bgaal001,
      bgaal002 LIKE bgaal_t.bgaal002,
      bgaal003 LIKE bgaal_t.bgaal003
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_bgaa_d          DYNAMIC ARRAY OF type_g_bgaa_d #單身變數
DEFINE g_bgaa_d_t        type_g_bgaa_d                  #單身備份
DEFINE g_bgaa_d_o        type_g_bgaa_d                  #單身備份
DEFINE g_bgaa_d_mask_o   DYNAMIC ARRAY OF type_g_bgaa_d #單身變數
DEFINE g_bgaa_d_mask_n   DYNAMIC ARRAY OF type_g_bgaa_d #單身變數
DEFINE g_bgaa1_info_d   DYNAMIC ARRAY OF type_g_bgaa1_info_d
DEFINE g_bgaa1_info_d_t type_g_bgaa1_info_d
DEFINE g_bgaa1_info_d_o type_g_bgaa1_info_d
DEFINE g_bgaa1_info_d_mask_o DYNAMIC ARRAY OF type_g_bgaa1_info_d
DEFINE g_bgaa1_info_d_mask_n DYNAMIC ARRAY OF type_g_bgaa1_info_d
 
      
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
 
{<section id="abgi010.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   #
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
   LET g_forupd_sql = "SELECT bgaastus,bgaa001,bgaa002,bgaa003,bgaa004,bgaa005,bgaa006,bgaa007,bgaa012, 
       bgaa008,bgaa009,bgaa011,bgaa010,bgaa001,bgaaownid,bgaaowndp,bgaacrtid,bgaacrtdp,bgaacrtdt,bgaamodid, 
       bgaamoddt FROM bgaa_t WHERE bgaaent=? AND bgaa001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi010_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgi010 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgi010_init()   
 
      #進入選單 Menu (="N")
      CALL abgi010_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgi010
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgi010.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abgi010_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
 
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('bgaa004','9401') 
   CALL cl_set_combo_scc('bgaa005','9401') 
   CALL cl_set_combo_scc('bgaa006','9402') 
   CALL cl_set_combo_scc('bgaa007','9403') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('bgaa004',9401)
   CALL cl_set_combo_scc('bgaa005',9401)
   CALL cl_set_combo_scc('bgaa006',9402)
   CALL cl_set_combo_scc('bgaa007',9403)
   #查询条件初始化
   IF cl_null(g_wc2) THEN LET g_wc2 = '1=1'  END IF
   #end add-point
   
   CALL abgi010_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="abgi010.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION abgi010_ui_dialog()
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
         CALL g_bgaa_d.clear()
         CALL g_bgaa1_info_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL abgi010_init()
      END IF
   
      CALL abgi010_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bgaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_bgaa1_info_d[g_detail_idx].bgaaownid   #(ver:35)
               LET g_data_dept = g_bgaa1_info_d[g_detail_idx].bgaaowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL abgi010_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_bgaa1_info_d TO s_detail1_info.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body1_info.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body1_info.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL abgi010_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row1_info"
               
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
            CALL DIALOG.setSelectionMode("s_detail1_info", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL abgi010_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL abgi010_modify()
            #add-point:ON ACTION modify name="menu.modify"
 
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL abgi010_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL abgi010_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL abgi010_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL abgi010_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgi010_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgi010_query()
               #add-point:ON ACTION query name="menu.query"
 
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail1_info",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bgaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_bgaa1_info_d)
               LET g_export_id[2]   = "s_detail1_info"
 
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
            CALL abgi010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgi010_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgi010_set_pk_array()
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
 
{<section id="abgi010.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgi010_query()
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
   CALL g_bgaa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON bgaastus,bgaa001,bgaal003,bgaa002,bgaa003,bgaa004,bgaa005,bgaa006,bgaa007,bgaa012, 
          bgaa008,bgaa009,bgaa011,bgaa010,bgaaownid,bgaaowndp,bgaacrtid,bgaacrtdp,bgaacrtdt,bgaamodid, 
          bgaamoddt 
 
         FROM s_detail1[1].bgaastus,s_detail1[1].bgaa001,s_detail1[1].bgaal003,s_detail1[1].bgaa002, 
             s_detail1[1].bgaa003,s_detail1[1].bgaa004,s_detail1[1].bgaa005,s_detail1[1].bgaa006,s_detail1[1].bgaa007, 
             s_detail1[1].bgaa012,s_detail1[1].bgaa008,s_detail1[1].bgaa009,s_detail1[1].bgaa011,s_detail1[1].bgaa010, 
             s_detail1_info[1].bgaaownid,s_detail1_info[1].bgaaowndp,s_detail1_info[1].bgaacrtid,s_detail1_info[1].bgaacrtdp, 
             s_detail1_info[1].bgaacrtdt,s_detail1_info[1].bgaamodid,s_detail1_info[1].bgaamoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgaacrtdt>>----
         AFTER FIELD bgaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgaamoddt>>----
         AFTER FIELD bgaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgaacnfdt>>----
         
         #----<<bgaapstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaastus
            #add-point:BEFORE FIELD bgaastus name="query.b.page1.bgaastus"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaastus
            
            #add-point:AFTER FIELD bgaastus name="query.a.page1.bgaastus"
 
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaastus
            #add-point:ON ACTION controlp INFIELD bgaastus name="query.c.page1.bgaastus"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa001
            #add-point:ON ACTION controlp INFIELD bgaa001 name="construct.c.page1.bgaa001"
            #此段落由子樣板a08產生
            #開窗c段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa001  #顯示到畫面上

            NEXT FIELD bgaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa001
            #add-point:BEFORE FIELD bgaa001 name="query.b.page1.bgaa001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa001
            
            #add-point:AFTER FIELD bgaa001 name="query.a.page1.bgaa001"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaal003
            #add-point:BEFORE FIELD bgaal003 name="query.b.page1.bgaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaal003
            
            #add-point:AFTER FIELD bgaal003 name="query.a.page1.bgaal003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaal003
            #add-point:ON ACTION controlp INFIELD bgaal003 name="query.c.page1.bgaal003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa002
            #add-point:ON ACTION controlp INFIELD bgaa002 name="construct.c.page1.bgaa002"
            #此段落由子樣板a08產生
            #開窗c段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE
            CALL q_bgac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa002  #顯示到畫面上

            NEXT FIELD bgaa002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa002
            #add-point:BEFORE FIELD bgaa002 name="query.b.page1.bgaa002"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa002
            
            #add-point:AFTER FIELD bgaa002 name="query.a.page1.bgaa002"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa003
            #add-point:ON ACTION controlp INFIELD bgaa003 name="construct.c.page1.bgaa003"
            #此段落由子樣板a08產生
            #開窗c段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa003  #顯示到畫面上

            NEXT FIELD bgaa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa003
            #add-point:BEFORE FIELD bgaa003 name="query.b.page1.bgaa003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa003
            
            #add-point:AFTER FIELD bgaa003 name="query.a.page1.bgaa003"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa004
            #add-point:BEFORE FIELD bgaa004 name="query.b.page1.bgaa004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa004
            
            #add-point:AFTER FIELD bgaa004 name="query.a.page1.bgaa004"
 
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa004
            #add-point:ON ACTION controlp INFIELD bgaa004 name="query.c.page1.bgaa004"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa005
            #add-point:BEFORE FIELD bgaa005 name="query.b.page1.bgaa005"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa005
            
            #add-point:AFTER FIELD bgaa005 name="query.a.page1.bgaa005"
 
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa005
            #add-point:ON ACTION controlp INFIELD bgaa005 name="query.c.page1.bgaa005"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa006
            #add-point:BEFORE FIELD bgaa006 name="query.b.page1.bgaa006"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa006
            
            #add-point:AFTER FIELD bgaa006 name="query.a.page1.bgaa006"
 
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa006
            #add-point:ON ACTION controlp INFIELD bgaa006 name="query.c.page1.bgaa006"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa007
            #add-point:BEFORE FIELD bgaa007 name="query.b.page1.bgaa007"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa007
            
            #add-point:AFTER FIELD bgaa007 name="query.a.page1.bgaa007"
 
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa007
            #add-point:ON ACTION controlp INFIELD bgaa007 name="query.c.page1.bgaa007"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa012
            #add-point:BEFORE FIELD bgaa012 name="query.b.page1.bgaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa012
            
            #add-point:AFTER FIELD bgaa012 name="query.a.page1.bgaa012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.bgaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa012
            #add-point:ON ACTION controlp INFIELD bgaa012 name="query.c.page1.bgaa012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgaa008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa008
            #add-point:ON ACTION controlp INFIELD bgaa008 name="construct.c.page1.bgaa008"
            #此段落由子樣板a08產生
            #開窗c段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE
            CALL q_ooal002_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa008  #顯示到畫面上

            NEXT FIELD bgaa008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa008
            #add-point:BEFORE FIELD bgaa008 name="query.b.page1.bgaa008"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa008
            
            #add-point:AFTER FIELD bgaa008 name="query.a.page1.bgaa008"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa009
            #add-point:ON ACTION controlp INFIELD bgaa009 name="construct.c.page1.bgaa009"
            #此段落由子樣板a08產生
            #開窗c段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE
            CALL q_nmai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa009  #顯示到畫面上

            NEXT FIELD bgaa009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa009
            #add-point:BEFORE FIELD bgaa009 name="query.b.page1.bgaa009"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa009
            
            #add-point:AFTER FIELD bgaa009 name="query.a.page1.bgaa009"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgaa011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa011
            #add-point:ON ACTION controlp INFIELD bgaa011 name="construct.c.page1.bgaa011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeb005_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa011  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeb006 #版本 

            NEXT FIELD bgaa011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa011
            #add-point:BEFORE FIELD bgaa011 name="query.b.page1.bgaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa011
            
            #add-point:AFTER FIELD bgaa011 name="query.a.page1.bgaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa010
            #add-point:ON ACTION controlp INFIELD bgaa010 name="construct.c.page1.bgaa010"
            #此段落由子樣板a08產生
            #開窗c段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE
            CALL q_ooeb006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaa010  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO bgahl006 #說明 

            NEXT FIELD bgaa010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa010
            #add-point:BEFORE FIELD bgaa010 name="query.b.page1.bgaa010"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa010
            
            #add-point:AFTER FIELD bgaa010 name="query.a.page1.bgaa010"
 
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page1_info.bgaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaaownid
            #add-point:ON ACTION controlp INFIELD bgaaownid name="construct.c.page1_info.bgaaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaaownid  #顯示到畫面上

            NEXT FIELD bgaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaaownid
            #add-point:BEFORE FIELD bgaaownid name="query.b.page1_info.bgaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaaownid
            
            #add-point:AFTER FIELD bgaaownid name="query.a.page1_info.bgaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.bgaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaaowndp
            #add-point:ON ACTION controlp INFIELD bgaaowndp name="construct.c.page1_info.bgaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaaowndp  #顯示到畫面上

            NEXT FIELD bgaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaaowndp
            #add-point:BEFORE FIELD bgaaowndp name="query.b.page1_info.bgaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaaowndp
            
            #add-point:AFTER FIELD bgaaowndp name="query.a.page1_info.bgaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.bgaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaacrtid
            #add-point:ON ACTION controlp INFIELD bgaacrtid name="construct.c.page1_info.bgaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaacrtid  #顯示到畫面上

            NEXT FIELD bgaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaacrtid
            #add-point:BEFORE FIELD bgaacrtid name="query.b.page1_info.bgaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaacrtid
            
            #add-point:AFTER FIELD bgaacrtid name="query.a.page1_info.bgaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1_info.bgaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaacrtdp
            #add-point:ON ACTION controlp INFIELD bgaacrtdp name="construct.c.page1_info.bgaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaacrtdp  #顯示到畫面上

            NEXT FIELD bgaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaacrtdp
            #add-point:BEFORE FIELD bgaacrtdp name="query.b.page1_info.bgaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaacrtdp
            
            #add-point:AFTER FIELD bgaacrtdp name="query.a.page1_info.bgaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaacrtdt
            #add-point:BEFORE FIELD bgaacrtdt name="query.b.page1_info.bgaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1_info.bgaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaamodid
            #add-point:ON ACTION controlp INFIELD bgaamodid name="construct.c.page1_info.bgaamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgaamodid  #顯示到畫面上

            NEXT FIELD bgaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaamodid
            #add-point:BEFORE FIELD bgaamodid name="query.b.page1_info.bgaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaamodid
            
            #add-point:AFTER FIELD bgaamodid name="query.a.page1_info.bgaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaamoddt
            #add-point:BEFORE FIELD bgaamoddt name="query.b.page1_info.bgaamoddt"
            
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
    
   CALL abgi010_b_fill(g_wc2)
   LET g_data_owner = g_bgaa1_info_d[g_detail_idx].bgaaownid   #(ver:35)
   LET g_data_dept = g_bgaa1_info_d[g_detail_idx].bgaaowndp   #(ver:35)
 
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
 
{<section id="abgi010.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgi010_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
 
   #end add-point
   
   LET g_insert = 'Y'
   CALL abgi010_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgi010.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgi010_modify()
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
      INPUT ARRAY g_bgaa_d FROM s_detail1.*
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
               IF NOT cl_null(g_bgaa_d[l_ac].bgaa001) THEN
                  CALL n_bgaal(g_bgaa_d[l_ac].bgaa001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_bgaa_d[l_ac].bgaa001
                  CALL ap_ref_array2(g_ref_fields," SELECT bgaal003 FROM bgaal_t WHERE bgaalent = '"
                      ||g_enterprise||"' AND bgaal001 = ? AND bgaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bgaa_d[l_ac].bgaal003= g_rtn_fields[1]
                  DISPLAY BY NAME g_bgaa_d[l_ac].bgaal003
               END IF 
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi010_b_fill(g_wc2)
            LET g_detail_cnt = g_bgaa_d.getLength()
         
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
            DISPLAY g_bgaa_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_bgaa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_bgaa_d[l_ac].bgaa001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgaa_d_t.* = g_bgaa_d[l_ac].*  #BACKUP
               LET g_bgaa_d_o.* = g_bgaa_d[l_ac].*  #BACKUP
               IF NOT abgi010_lock_b("bgaa_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi010_bcl INTO g_bgaa_d[l_ac].bgaastus,g_bgaa_d[l_ac].bgaa001,g_bgaa_d[l_ac].bgaa002, 
                      g_bgaa_d[l_ac].bgaa003,g_bgaa_d[l_ac].bgaa004,g_bgaa_d[l_ac].bgaa005,g_bgaa_d[l_ac].bgaa006, 
                      g_bgaa_d[l_ac].bgaa007,g_bgaa_d[l_ac].bgaa012,g_bgaa_d[l_ac].bgaa008,g_bgaa_d[l_ac].bgaa009, 
                      g_bgaa_d[l_ac].bgaa011,g_bgaa_d[l_ac].bgaa010,g_bgaa1_info_d[l_ac].bgaa001,g_bgaa1_info_d[l_ac].bgaaownid, 
                      g_bgaa1_info_d[l_ac].bgaaowndp,g_bgaa1_info_d[l_ac].bgaacrtid,g_bgaa1_info_d[l_ac].bgaacrtdp, 
                      g_bgaa1_info_d[l_ac].bgaacrtdt,g_bgaa1_info_d[l_ac].bgaamodid,g_bgaa1_info_d[l_ac].bgaamoddt 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bgaa_d_t.bgaa001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgaa_d_mask_o[l_ac].* =  g_bgaa_d[l_ac].*
                  CALL abgi010_bgaa_t_mask()
                  LET g_bgaa_d_mask_n[l_ac].* =  g_bgaa_d[l_ac].*
                  
                  CALL abgi010_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL abgi010_set_entry_b(l_cmd)
            CALL abgi010_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.bgaal001 = g_bgaa_d[l_ac].bgaa001
LET g_detail_multi_table_t.bgaal002 = g_dlang
LET g_detail_multi_table_t.bgaal003 = g_bgaa_d[l_ac].bgaal003
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'bgaalent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'bgaal001'
            LET l_var_keys[02] = g_bgaa_d[l_ac].bgaa001
            LET l_field_keys[03] = 'bgaal002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'bgaal_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgaa_d_t.* TO NULL
            INITIALIZE g_bgaa_d_o.* TO NULL
            INITIALIZE g_bgaa_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgaa1_info_d[l_ac].bgaaownid = g_user
      LET g_bgaa1_info_d[l_ac].bgaaowndp = g_dept
      LET g_bgaa1_info_d[l_ac].bgaacrtid = g_user
      LET g_bgaa1_info_d[l_ac].bgaacrtdp = g_dept 
      LET g_bgaa1_info_d[l_ac].bgaacrtdt = cl_get_current()
      LET g_bgaa1_info_d[l_ac].bgaamodid = g_user
      LET g_bgaa1_info_d[l_ac].bgaamoddt = cl_get_current()
      LET g_bgaa_d[l_ac].bgaastus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_bgaa_d[l_ac].bgaastus = "Y"
      LET g_bgaa_d[l_ac].bgaa004 = "3"
      LET g_bgaa_d[l_ac].bgaa005 = "3"
      LET g_bgaa_d[l_ac].bgaa006 = "2"
      LET g_bgaa_d[l_ac].bgaa007 = "1"
      LET g_bgaa_d[l_ac].bgaa012 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_bgaa_d[l_ac].bgaa011 = g_site
            LET g_bgaa_d[l_ac].bgaa004 = '7'      #161003-00014#21       
            #end add-point
            LET g_bgaa_d_t.* = g_bgaa_d[l_ac].*     #新輸入資料
            LET g_bgaa_d_o.* = g_bgaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgaa_d[li_reproduce_target].* = g_bgaa_d[li_reproduce].*
               LET g_bgaa1_info_d[li_reproduce_target].* = g_bgaa1_info_d[li_reproduce].*
 
               LET g_bgaa_d[g_bgaa_d.getLength()].bgaa001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.bgaal001 = g_bgaa_d[l_ac].bgaa001
LET g_detail_multi_table_t.bgaal002 = g_dlang
LET g_detail_multi_table_t.bgaal003 = g_bgaa_d[l_ac].bgaal003
 
 
            CALL abgi010_set_entry_b(l_cmd)
            CALL abgi010_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_bgaa_d[l_ac].bgaastus = 'Y'
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
            SELECT COUNT(1) INTO l_count FROM bgaa_t 
             WHERE bgaaent = g_enterprise AND bgaa001 = g_bgaa_d[l_ac].bgaa001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgaa_d[g_detail_idx].bgaa001
               CALL abgi010_insert_b('bgaa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_bgaa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgaa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgi010_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_bgaa_d[l_ac].bgaa001 = g_detail_multi_table_t.bgaal001 AND
         g_bgaa_d[l_ac].bgaal003 = g_detail_multi_table_t.bgaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'bgaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_bgaa_d[l_ac].bgaa001
            LET l_field_keys[02] = 'bgaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.bgaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'bgaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.bgaal002
            LET l_vars[01] = g_bgaa_d[l_ac].bgaal003
            LET l_fields[01] = 'bgaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bgaal_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
 
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (bgaa001 = '", g_bgaa_d[l_ac].bgaa001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               #170209-00020#1 
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM bgaj_t WHERE bgajent = g_enterprise AND bgaj001 = g_bgaa_d_t.bgaa001
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = 'abg-00337'
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE                                             
               END IF                
               #170209-00020#1 
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
               
               DELETE FROM bgaa_t
                WHERE bgaaent = g_enterprise AND 
                      bgaa001 = g_bgaa_d_t.bgaa001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
 
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bgaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'bgaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'bgaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.bgaal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgaal_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
 
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL abgi010_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_bgaa_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE abgi010_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_bgaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgaa_d_t.bgaa001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi010_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
 
               #end add-point
                              CALL abgi010_delete_b('bgaa_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaastus
            #add-point:BEFORE FIELD bgaastus name="input.b.page1.bgaastus"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaastus
            
            #add-point:AFTER FIELD bgaastus name="input.a.page1.bgaastus"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaastus
            #add-point:ON CHANGE bgaastus name="input.g.page1.bgaastus"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa001
            #add-point:BEFORE FIELD bgaa001 name="input.b.page1.bgaa001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa001
            
            #add-point:AFTER FIELD bgaa001 name="input.a.page1.bgaa001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bgaa_d[l_ac].bgaa001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bgaa_d[l_ac].bgaa001 != g_bgaa_d_t.bgaa001))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgaa_t WHERE "||"bgaaent = '" ||g_enterprise|| "' AND "||"bgaa001 = '"||g_bgaa_d[l_ac].bgaa001 ||"'",'std-00004',0) THEN 
                     LET g_bgaa_d[l_ac].bgaa001 = g_bgaa_d_t.bgaa001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa001
            #add-point:ON CHANGE bgaa001 name="input.g.page1.bgaa001"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaal003
            #add-point:BEFORE FIELD bgaal003 name="input.b.page1.bgaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaal003
            
            #add-point:AFTER FIELD bgaal003 name="input.a.page1.bgaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaal003
            #add-point:ON CHANGE bgaal003 name="input.g.page1.bgaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa002
            #add-point:BEFORE FIELD bgaa002 name="input.b.page1.bgaa002"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa002
            
            #add-point:AFTER FIELD bgaa002 name="input.a.page1.bgaa002"
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa002) THEN 
               CALL abgi010_bgaa002_chk(g_bgaa_d[l_ac].bgaa002)
               IF NOT cl_null (g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bgaa_d[l_ac].bgaa002
                  #160318-00005#3 --s add
                  LET g_errparam.replace[1] = 'abgi030'
                  LET g_errparam.replace[2] = cl_get_progname('abgi030',g_lang,"2")
                  LET g_errparam.exeprog = 'abgi030'
                  #160318-00005#3 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaa_d[l_ac].bgaa002= g_bgaa_d_t.bgaa002
                  NEXT FIELD bgaa002
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa002
            #add-point:ON CHANGE bgaa002 name="input.g.page1.bgaa002"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa003
            #add-point:BEFORE FIELD bgaa003 name="input.b.page1.bgaa003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa003
            
            #add-point:AFTER FIELD bgaa003 name="input.a.page1.bgaa003"
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa003) THEN 
               CALL abgi010_bgaa003_chk(g_bgaa_d[l_ac].bgaa003)
               IF NOT cl_null (g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bgaa_d[l_ac].bgaa003
                  #160318-00005#3 --s add
                  LET g_errparam.replace[1] = 'aooi140'
                  LET g_errparam.replace[2] = cl_get_progname('aooi140',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi140'
                  #160318-00005#3 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaa_d[l_ac].bgaa003= g_bgaa_d_t.bgaa003
                  NEXT FIELD bgaa003
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa003
            #add-point:ON CHANGE bgaa003 name="input.g.page1.bgaa003"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa004
            #add-point:BEFORE FIELD bgaa004 name="input.b.page1.bgaa004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa004
            
            #add-point:AFTER FIELD bgaa004 name="input.a.page1.bgaa004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa004
            #add-point:ON CHANGE bgaa004 name="input.g.page1.bgaa004"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa005
            #add-point:BEFORE FIELD bgaa005 name="input.b.page1.bgaa005"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa005
            
            #add-point:AFTER FIELD bgaa005 name="input.a.page1.bgaa005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa005
            #add-point:ON CHANGE bgaa005 name="input.g.page1.bgaa005"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa006
            #add-point:BEFORE FIELD bgaa006 name="input.b.page1.bgaa006"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa006
            
            #add-point:AFTER FIELD bgaa006 name="input.a.page1.bgaa006"
            IF NOT cl_null (g_bgaa_d[l_ac].bgaa006) THEN
               IF g_bgaa_d[l_ac].bgaa006 = '1' THEN
                  CALL cl_set_comp_required ('bgaa007',TRUE)
               ELSE
                  CALL cl_set_comp_required ('bgaa007',FALSE)
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa006
            #add-point:ON CHANGE bgaa006 name="input.g.page1.bgaa006"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa007
            #add-point:BEFORE FIELD bgaa007 name="input.b.page1.bgaa007"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa007
            
            #add-point:AFTER FIELD bgaa007 name="input.a.page1.bgaa007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa007
            #add-point:ON CHANGE bgaa007 name="input.g.page1.bgaa007"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa012
            #add-point:BEFORE FIELD bgaa012 name="input.b.page1.bgaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa012
            
            #add-point:AFTER FIELD bgaa012 name="input.a.page1.bgaa012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa012
            #add-point:ON CHANGE bgaa012 name="input.g.page1.bgaa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa008
            #add-point:BEFORE FIELD bgaa008 name="input.b.page1.bgaa008"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa008
            
            #add-point:AFTER FIELD bgaa008 name="input.a.page1.bgaa008"
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa008) THEN 
               #150709-00008#2-----s
               IF g_bgaa_d[l_ac].bgaa012 = 'N' THEN
                  CALL abgi010_bgaa008_chk(g_bgaa_d[l_ac].bgaa008)
                  #160318-00005#3 --s add
                  IF NOT cl_null (g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgaa_d[l_ac].bgaa008
                     LET g_errparam.replace[1] = 'abgi040'
                     LET g_errparam.replace[2] = cl_get_progname('abgi040',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi040'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgaa_d[l_ac].bgaa008= g_bgaa_d_t.bgaa008
                     NEXT FIELD bgaa008
                  END IF 
                  #160318-00005#3 --e add
               ELSE
                  CALL abgi010_bgaa008_chk1(g_bgaa_d[l_ac].bgaa008)
                  #160318-00005#3 --s add
                  IF NOT cl_null (g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_bgaa_d[l_ac].bgaa008
                     LET g_errparam.replace[1] = 'aooi070'
                     LET g_errparam.replace[2] = cl_get_progname('aooi070',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi070'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_bgaa_d[l_ac].bgaa008= g_bgaa_d_t.bgaa008
                     NEXT FIELD bgaa008
                  END IF 
                  #160318-00005#3 --e add
               END IF
               #150709-00008#2-----e
               
               #160318-00005#3 --s mark
               #IF NOT cl_null (g_errno) THEN 
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = g_errno
               #   LET g_errparam.extend = g_bgaa_d[l_ac].bgaa008
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #
               #   LET g_bgaa_d[l_ac].bgaa008= g_bgaa_d_t.bgaa008
               #   NEXT FIELD bgaa008
               #END IF 
               #160318-00005#3 --e mark
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa008
            #add-point:ON CHANGE bgaa008 name="input.g.page1.bgaa008"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa009
            #add-point:BEFORE FIELD bgaa009 name="input.b.page1.bgaa009"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa009
            
            #add-point:AFTER FIELD bgaa009 name="input.a.page1.bgaa009"
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa009) THEN 
               CALL abgi010_bgaa009_chk(g_bgaa_d[l_ac].bgaa009)
               IF NOT cl_null (g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bgaa_d[l_ac].bgaa009
                  #160318-00005#3 --s add
                  LET g_errparam.replace[1] = 'anmi160'
                  LET g_errparam.replace[2] = cl_get_progname('anmi160',g_lang,"2")
                  LET g_errparam.exeprog = 'anmi160'
                  #160318-00005#3 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaa_d[l_ac].bgaa009= g_bgaa_d_t.bgaa009
                  NEXT FIELD bgaa009
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa009
            #add-point:ON CHANGE bgaa009 name="input.g.page1.bgaa009"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa011
            
            #add-point:AFTER FIELD bgaa011 name="input.a.page1.bgaa011"
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa011) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgaa_d[l_ac].bgaa011

                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooeb005") THEN
               IF cl_chk_exist("v_ooef001_24") THEN #161003-00014#3
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
              #161003-00014#3---s--- 不需要一定建立組織樹
              #IF NOT cl_null(g_bgaa_d[l_ac].bgaa010) THEN
              #   SELECT count(ooeb001) INTO l_cnt FROM ooeb_t
              #    WHERE ooebent = g_enterprise
              #      AND ooeb004 = '4'
              #      AND ooeb005 = g_bgaa_d[l_ac].bgaa011
              #      AND ooeb006 = g_bgaa_d[l_ac].bgaa010
              #      AND ooebstus = 'Y'
              #   IF l_cnt <= 0 THEN                 
              #      LET g_bgaa_d[l_ac].bgaa010 = ''
              #      DISPLAY BY NAME g_bgaa_d[l_ac].bgaa010
              #   END IF
              # END IF
              #161003-00014#3---e---
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgaa_d[l_ac].bgaa011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgaa_d[l_ac].bgaa011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgaa_d[l_ac].bgaa011_desc
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa011
            #add-point:BEFORE FIELD bgaa011 name="input.b.page1.bgaa011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa011
            #add-point:ON CHANGE bgaa011 name="input.g.page1.bgaa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa010
            #add-point:BEFORE FIELD bgaa010 name="input.b.page1.bgaa010"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa010
            
            #add-point:AFTER FIELD bgaa010 name="input.a.page1.bgaa010"
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa010) THEN
               CALL abgi010_bgaa010_chk(g_bgaa_d[l_ac].bgaa010)
               IF NOT cl_null (g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bgaa_d[l_ac].bgaa010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaa_d[l_ac].bgaa010= g_bgaa_d_t.bgaa010
                  NEXT FIELD bgaa010
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa010
            #add-point:ON CHANGE bgaa010 name="input.g.page1.bgaa010"
 
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaastus
            #add-point:ON ACTION controlp INFIELD bgaastus name="input.c.page1.bgaastus"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa001
            #add-point:ON ACTION controlp INFIELD bgaa001 name="input.c.page1.bgaa001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaal003
            #add-point:ON ACTION controlp INFIELD bgaal003 name="input.c.page1.bgaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa002
            #add-point:ON ACTION controlp INFIELD bgaa002 name="input.c.page1.bgaa002"
#此段落由子樣板a07產生            
            #開窗i段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaa_d[l_ac].bgaa002             #給予default值

            #給予arg

            CALL q_bgac001()                                #呼叫開窗

            LET g_bgaa_d[l_ac].bgaa002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bgaa_d[l_ac].bgaa002 TO bgaa002              #顯示到畫面上

            NEXT FIELD bgaa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa003
            #add-point:ON ACTION controlp INFIELD bgaa003 name="input.c.page1.bgaa003"
#此段落由子樣板a07產生            
            #開窗i段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaa_d[l_ac].bgaa003             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_bgaa_d[l_ac].bgaa003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bgaa_d[l_ac].bgaa003 TO bgaa003              #顯示到畫面上

            NEXT FIELD bgaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa004
            #add-point:ON ACTION controlp INFIELD bgaa004 name="input.c.page1.bgaa004"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa005
            #add-point:ON ACTION controlp INFIELD bgaa005 name="input.c.page1.bgaa005"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa006
            #add-point:ON ACTION controlp INFIELD bgaa006 name="input.c.page1.bgaa006"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa007
            #add-point:ON ACTION controlp INFIELD bgaa007 name="input.c.page1.bgaa007"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa012
            #add-point:ON ACTION controlp INFIELD bgaa012 name="input.c.page1.bgaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa008
            #add-point:ON ACTION controlp INFIELD bgaa008 name="input.c.page1.bgaa008"
#此段落由子樣板a07產生            
            #開窗i段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaa_d[l_ac].bgaa008             #給予default值
            #LET g_qryparam.where = "EXISTS (SELECT 1 FROM bgae_t WHERE bgaeent = ooalent AND bgae006 = ooal002) "   #160425-00020#2 #161003-00014#3 mark
            #給予arg
            IF g_bgaa_d[l_ac].bgaa012 = 'N' THEN
               CALL q_ooal002_12()             #呼叫開窗
            ELSE
               CALL q_ooal002_1()
            END IF
            
            LET g_bgaa_d[l_ac].bgaa008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bgaa_d[l_ac].bgaa008 TO bgaa008              #顯示到畫面上

            NEXT FIELD bgaa008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa009
            #add-point:ON ACTION controlp INFIELD bgaa009 name="input.c.page1.bgaa009"
#此段落由子樣板a07產生            
            #開窗i段
            #160314-00023#1 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            #160314-00023#1 --e
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaa_d[l_ac].bgaa009             #給予default值

            #給予arg

            CALL q_nmai001()                                #呼叫開窗

            LET g_bgaa_d[l_ac].bgaa009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bgaa_d[l_ac].bgaa009 TO bgaa009              #顯示到畫面上

            NEXT FIELD bgaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa011
            #add-point:ON ACTION controlp INFIELD bgaa011 name="input.c.page1.bgaa011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaa_d[l_ac].bgaa011             #給予default值
            LET g_qryparam.default2 = g_bgaa_d[l_ac].bgaa010 #版本

            #給予arg

            CALL q_ooeb005_1()                                #呼叫開窗

            LET g_bgaa_d[l_ac].bgaa011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaa_d[l_ac].bgaa010 = g_qryparam.return2 #版本
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgaa_d[l_ac].bgaa011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgaa_d[l_ac].bgaa011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgaa_d[l_ac].bgaa011_desc
            DISPLAY g_bgaa_d[l_ac].bgaa011 TO bgaa011              #顯示到畫面上
            DISPLAY g_bgaa_d[l_ac].bgaa010 TO bgaa010 #版本

            NEXT FIELD bgaa011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bgaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa010
            #add-point:ON ACTION controlp INFIELD bgaa010 name="input.c.page1.bgaa010"
             #開窗i段
             #160314-00023#1 --s
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             #160314-00023#1 --e
             LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaa_d[l_ac].bgaa010             #給予default值
            IF NOT cl_null(g_bgaa_d[l_ac].bgaa011) THEN
               LET g_qryparam.where = " ooeb005 = '",g_bgaa_d[l_ac].bgaa011,"'"
            END IF

            #給予arg

            CALL q_ooeb006_1()                                #呼叫開窗

            LET g_bgaa_d[l_ac].bgaa010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bgaa_d[l_ac].bgaa010 TO bgaa010              #顯示到畫面上

            NEXT FIELD bgaa010                          #返回原欄位

            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE abgi010_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_bgaa_d[l_ac].* = g_bgaa_d_t.*
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
               LET g_errparam.extend = g_bgaa_d[l_ac].bgaa001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgaa_d[l_ac].* = g_bgaa_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_bgaa1_info_d[l_ac].bgaamodid = g_user 
LET g_bgaa1_info_d[l_ac].bgaamoddt = cl_get_current()
LET g_bgaa1_info_d[l_ac].bgaamodid_desc = cl_get_username(g_bgaa1_info_d[l_ac].bgaamodid)
            
               #add-point:單身修改前 name="input.body.b_update"
 
               #end add-point
               
               #將遮罩欄位還原
               CALL abgi010_bgaa_t_mask_restore('restore_mask_o')
 
               UPDATE bgaa_t SET (bgaastus,bgaa001,bgaa002,bgaa003,bgaa004,bgaa005,bgaa006,bgaa007,bgaa012, 
                   bgaa008,bgaa009,bgaa011,bgaa010,bgaaownid,bgaaowndp,bgaacrtid,bgaacrtdp,bgaacrtdt, 
                   bgaamodid,bgaamoddt) = (g_bgaa_d[l_ac].bgaastus,g_bgaa_d[l_ac].bgaa001,g_bgaa_d[l_ac].bgaa002, 
                   g_bgaa_d[l_ac].bgaa003,g_bgaa_d[l_ac].bgaa004,g_bgaa_d[l_ac].bgaa005,g_bgaa_d[l_ac].bgaa006, 
                   g_bgaa_d[l_ac].bgaa007,g_bgaa_d[l_ac].bgaa012,g_bgaa_d[l_ac].bgaa008,g_bgaa_d[l_ac].bgaa009, 
                   g_bgaa_d[l_ac].bgaa011,g_bgaa_d[l_ac].bgaa010,g_bgaa1_info_d[l_ac].bgaaownid,g_bgaa1_info_d[l_ac].bgaaowndp, 
                   g_bgaa1_info_d[l_ac].bgaacrtid,g_bgaa1_info_d[l_ac].bgaacrtdp,g_bgaa1_info_d[l_ac].bgaacrtdt, 
                   g_bgaa1_info_d[l_ac].bgaamodid,g_bgaa1_info_d[l_ac].bgaamoddt)
                WHERE bgaaent = g_enterprise AND
                  bgaa001 = g_bgaa_d_t.bgaa001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgaa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgaa_d[g_detail_idx].bgaa001
               LET gs_keys_bak[1] = g_bgaa_d_t.bgaa001
               CALL abgi010_update_b('bgaa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_bgaa_d[l_ac].bgaa001 = g_detail_multi_table_t.bgaal001 AND
         g_bgaa_d[l_ac].bgaal003 = g_detail_multi_table_t.bgaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'bgaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_bgaa_d[l_ac].bgaa001
            LET l_field_keys[02] = 'bgaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.bgaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'bgaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.bgaal002
            LET l_vars[01] = g_bgaa_d[l_ac].bgaal003
            LET l_fields[01] = 'bgaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'bgaal_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_bgaa_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgaa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgi010_bgaa_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
 
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL abgi010_unlock_b("bgaa_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgaa_d[l_ac].* = g_bgaa_d_t.*
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
               LET g_bgaa_d[li_reproduce_target].* = g_bgaa_d[li_reproduce].*
               LET g_bgaa1_info_d[li_reproduce_target].* = g_bgaa1_info_d[li_reproduce].*
 
               LET g_bgaa_d[li_reproduce_target].bgaa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgaa_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_bgaa1_info_d TO s_detail1_info.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL abgi010_b_fill(g_wc2)
            CALL FGL_SET_ARR_CURR(g_detail_idx)
      
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1_info")
            LET l_ac = g_detail_idx
            LET g_temp_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL cl_show_fld_cont() 
            
         #add-point:page2自定義行為 name="input.body1_info.action"
         
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
               NEXT FIELD bgaastus
            WHEN "s_detail1_info"
               NEXT FIELD bgaa001_2
 
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
      IF INT_FLAG OR cl_null(g_bgaa_d[g_detail_idx].bgaa001) THEN
         CALL g_bgaa_d.deleteElement(g_detail_idx)
         CALL g_bgaa1_info_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_bgaa_d[g_detail_idx].* = g_bgaa_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
 
   #end add-point
 
   CLOSE abgi010_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi010.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgi010_delete()
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
   DEFINE l_cnt          LIKE type_t.num5 #170209-00020#1 
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_bgaa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT abgi010_lock_b("bgaa_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("bgaa_t","bgaaownid") THEN
            LET g_data_owner = g_bgaa1_info_d[g_detail_idx].bgaaownid
            LET g_data_dept = g_bgaa1_info_d[g_detail_idx].bgaaowndp
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
   
   FOR li_idx = 1 TO g_bgaa_d.getLength()
      IF g_bgaa_d[li_idx].bgaa001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         #170209-00020#1 
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM bgaj_t WHERE bgajent = g_enterprise AND bgaj001 = g_bgaa_d[li_idx].bgaa001
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 'abg-00337'
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN                                            
         END IF                
         #170209-00020#1 
         #end add-point   
         
         DELETE FROM bgaa_t
          WHERE bgaaent = g_enterprise AND 
                bgaa001 = g_bgaa_d[li_idx].bgaa001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgaa_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.bgaal001 = g_bgaa_d[l_ac].bgaa001
LET g_detail_multi_table_t.bgaal002 = g_dlang
LET g_detail_multi_table_t.bgaal003 = g_bgaa_d[l_ac].bgaal003
 
 
            
LET g_detail_multi_table_t.bgaal001 = g_bgaa_d[l_ac].bgaa001
LET g_detail_multi_table_t.bgaal002 = g_dlang
LET g_detail_multi_table_t.bgaal003 = g_bgaa_d[l_ac].bgaal003
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'bgaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'bgaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.bgaal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgaal_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'bgaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'bgaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.bgaal001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'bgaal_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgaa_d_t.bgaa001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL abgi010_delete_b('bgaa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi010_set_pk_array()
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
   CALL abgi010_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="abgi010.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgi010_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.bgaastus,t0.bgaa001,t0.bgaa002,t0.bgaa003,t0.bgaa004,t0.bgaa005, 
       t0.bgaa006,t0.bgaa007,t0.bgaa012,t0.bgaa008,t0.bgaa009,t0.bgaa011,t0.bgaa010,t0.bgaa001,t0.bgaaownid, 
       t0.bgaaowndp,t0.bgaacrtid,t0.bgaacrtdp,t0.bgaacrtdt,t0.bgaamodid,t0.bgaamoddt ,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM bgaa_t t0",
               " LEFT JOIN bgaal_t ON bgaalent = "||g_enterprise||" AND bgaa001 = bgaal001 AND bgaal002 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.bgaa011 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.bgaaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.bgaaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.bgaacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.bgaacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.bgaamodid  ",
 
               " WHERE t0.bgaaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("bgaa_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND bgaaowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("bgaa_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND bgaaownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("bgaa_t"),
                      " ORDER BY t0.bgaa001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgaa_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abgi010_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abgi010_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_bgaa_d.clear()
   CALL g_bgaa1_info_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_bgaa_d[l_ac].bgaastus,g_bgaa_d[l_ac].bgaa001,g_bgaa_d[l_ac].bgaa002,g_bgaa_d[l_ac].bgaa003, 
       g_bgaa_d[l_ac].bgaa004,g_bgaa_d[l_ac].bgaa005,g_bgaa_d[l_ac].bgaa006,g_bgaa_d[l_ac].bgaa007,g_bgaa_d[l_ac].bgaa012, 
       g_bgaa_d[l_ac].bgaa008,g_bgaa_d[l_ac].bgaa009,g_bgaa_d[l_ac].bgaa011,g_bgaa_d[l_ac].bgaa010,g_bgaa1_info_d[l_ac].bgaa001, 
       g_bgaa1_info_d[l_ac].bgaaownid,g_bgaa1_info_d[l_ac].bgaaowndp,g_bgaa1_info_d[l_ac].bgaacrtid, 
       g_bgaa1_info_d[l_ac].bgaacrtdp,g_bgaa1_info_d[l_ac].bgaacrtdt,g_bgaa1_info_d[l_ac].bgaamodid, 
       g_bgaa1_info_d[l_ac].bgaamoddt,g_bgaa_d[l_ac].bgaa011_desc,g_bgaa1_info_d[l_ac].bgaaownid_desc, 
       g_bgaa1_info_d[l_ac].bgaaowndp_desc,g_bgaa1_info_d[l_ac].bgaacrtid_desc,g_bgaa1_info_d[l_ac].bgaacrtdp_desc, 
       g_bgaa1_info_d[l_ac].bgaamodid_desc
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
      
      CALL abgi010_detail_show()      
 
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
   
 
   
   CALL g_bgaa_d.deleteElement(g_bgaa_d.getLength())   
   CALL g_bgaa1_info_d.deleteElement(g_bgaa1_info_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_bgaa_d.getLength()
      LET g_bgaa1_info_d[l_ac].bgaa001 = g_bgaa_d[l_ac].bgaa001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_bgaa_d.getLength() THEN
      LET l_ac = g_bgaa_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgaa_d.getLength()
      LET g_bgaa_d_mask_o[l_ac].* =  g_bgaa_d[l_ac].*
      CALL abgi010_bgaa_t_mask()
      LET g_bgaa_d_mask_n[l_ac].* =  g_bgaa_d[l_ac].*
   END FOR
   
   LET g_bgaa1_info_d_mask_o.* =  g_bgaa1_info_d.*
   FOR l_ac = 1 TO g_bgaa1_info_d.getLength()
      LET g_bgaa1_info_d_mask_o[l_ac].* =  g_bgaa1_info_d[l_ac].*
      CALL abgi010_bgaa_t_mask()
      LET g_bgaa1_info_d_mask_n[l_ac].* =  g_bgaa1_info_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_bgaa_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE abgi010_pb
   
END FUNCTION
 
{</section>}
 
{<section id="abgi010.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgi010_detail_show()
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
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_bgaa_d[l_ac].bgaa001
   CALL ap_ref_array2(g_ref_fields," SELECT bgaal003 FROM bgaal_t WHERE bgaalent = '"||g_enterprise||"' AND bgaal001 = ? AND bgaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_bgaa_d[l_ac].bgaal003 = g_rtn_fields[1] 
   DISPLAY BY NAME g_bgaa_d[l_ac].bgaal003       
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body1_info.reference"
 
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgi010.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgi010_set_entry_b(p_cmd)                                                  
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
 
{<section id="abgi010.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgi010_set_no_entry_b(p_cmd)                                               
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
 
{<section id="abgi010.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgi010_default_search()
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
      LET ls_wc = ls_wc, " bgaa001 = '", g_argv[01], "' AND "
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
 
{<section id="abgi010.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgi010_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_cnt LIKE type_t.num5          #170209-00020#1 
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "bgaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'bgaa_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         #170209-00020#1 
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM bgaj_t WHERE bgajent = g_enterprise AND bgaj001 = ps_keys_bak[1]
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 'abg-00337'
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN                                            
         END IF                
         #170209-00020#1 
         #end add-point     
         
         DELETE FROM bgaa_t
          WHERE bgaaent = g_enterprise AND
            bgaa001 = ps_keys_bak[1]
         
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
         CALL g_bgaa_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_bgaa1_info_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
 
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi010.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgi010_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "bgaa_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
 
      #end add-point    
      INSERT INTO bgaa_t
                  (bgaaent,
                   bgaa001
                   ,bgaastus,bgaa002,bgaa003,bgaa004,bgaa005,bgaa006,bgaa007,bgaa012,bgaa008,bgaa009,bgaa011,bgaa010,bgaaownid,bgaaowndp,bgaacrtid,bgaacrtdp,bgaacrtdt,bgaamodid,bgaamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_bgaa_d[l_ac].bgaastus,g_bgaa_d[l_ac].bgaa002,g_bgaa_d[l_ac].bgaa003,g_bgaa_d[l_ac].bgaa004, 
                       g_bgaa_d[l_ac].bgaa005,g_bgaa_d[l_ac].bgaa006,g_bgaa_d[l_ac].bgaa007,g_bgaa_d[l_ac].bgaa012, 
                       g_bgaa_d[l_ac].bgaa008,g_bgaa_d[l_ac].bgaa009,g_bgaa_d[l_ac].bgaa011,g_bgaa_d[l_ac].bgaa010, 
                       g_bgaa1_info_d[l_ac].bgaaownid,g_bgaa1_info_d[l_ac].bgaaowndp,g_bgaa1_info_d[l_ac].bgaacrtid, 
                       g_bgaa1_info_d[l_ac].bgaacrtdp,g_bgaa1_info_d[l_ac].bgaacrtdt,g_bgaa1_info_d[l_ac].bgaamodid, 
                       g_bgaa1_info_d[l_ac].bgaamoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
 
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgaa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
 
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi010.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgi010_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "bgaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "bgaa_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
 
      #end add-point     
      UPDATE bgaa_t 
         SET (bgaa001
              ,bgaastus,bgaa002,bgaa003,bgaa004,bgaa005,bgaa006,bgaa007,bgaa012,bgaa008,bgaa009,bgaa011,bgaa010,bgaaownid,bgaaowndp,bgaacrtid,bgaacrtdp,bgaacrtdt,bgaamodid,bgaamoddt) 
              = 
             (ps_keys[1]
              ,g_bgaa_d[l_ac].bgaastus,g_bgaa_d[l_ac].bgaa002,g_bgaa_d[l_ac].bgaa003,g_bgaa_d[l_ac].bgaa004, 
                  g_bgaa_d[l_ac].bgaa005,g_bgaa_d[l_ac].bgaa006,g_bgaa_d[l_ac].bgaa007,g_bgaa_d[l_ac].bgaa012, 
                  g_bgaa_d[l_ac].bgaa008,g_bgaa_d[l_ac].bgaa009,g_bgaa_d[l_ac].bgaa011,g_bgaa_d[l_ac].bgaa010, 
                  g_bgaa1_info_d[l_ac].bgaaownid,g_bgaa1_info_d[l_ac].bgaaowndp,g_bgaa1_info_d[l_ac].bgaacrtid, 
                  g_bgaa1_info_d[l_ac].bgaacrtdp,g_bgaa1_info_d[l_ac].bgaacrtdt,g_bgaa1_info_d[l_ac].bgaamodid, 
                  g_bgaa1_info_d[l_ac].bgaamoddt) 
         WHERE bgaaent = g_enterprise AND bgaa001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
 
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgaa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgaa_t:",SQLERRMESSAGE 
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
 
{<section id="abgi010.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgi010_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
 
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL abgi010_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "bgaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abgi010_bcl USING g_enterprise,
                                       g_bgaa_d[g_detail_idx].bgaa001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgi010_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi010.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgi010_unlock_b(ps_table)
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
      CLOSE abgi010_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi010.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION abgi010_modify_detail_chk(ps_record)
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
         LET ls_return = "bgaastus"
      WHEN "s_detail1_info"
         LET ls_return = "bgaa001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgi010.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION abgi010_show_ownid_msg()
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
 
{<section id="abgi010.mask_functions" >}
&include "erp/abg/abgi010_mask.4gl"
 
{</section>}
 
{<section id="abgi010.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgi010_set_pk_array()
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
   LET g_pk_array[1].values = g_bgaa_d[l_ac].bgaa001
   LET g_pk_array[1].column = 'bgaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi010.state_change" >}
   
 
{</section>}
 
{<section id="abgi010.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="abgi010.other_function" readonly="Y" >}
# 檢查資資料在現金異動碼表編碼是否存在且有效
PRIVATE FUNCTION abgi010_bgaa009_chk(p_nmai001)
DEFINE p_nmai001     LIKE nmai_t.nmai001
    DEFINE l_nmaistus    LIKE nmai_t.nmaistus
    
    LET g_errno = ''
    SELECT nmaistus INTO l_nmaistus FROM nmai_t
     WHERE nmaient = g_enterprise
       AND nmai001 = p_nmai001
    CASE
       WHEN sqlca.sqlcode = 100   LET g_errno = 'abg-00001'
       WHEN l_nmaistus ='N'       LET g_errno = 'sub-01302'  #160318-00005#3 add
       #WHEN l_nmaistus ='N'       LET g_errno = 'abg-00002' #160318-00005#3 mark
     END CASE
END FUNCTION
# 檢查預算項目級別在預算項目資料檔中是否存在且有效
PRIVATE FUNCTION abgi010_bgaa008_chk(p_bgae007)
DEFINE p_bgae007   LIKE bgae_t.bgae006
DEFINE l_bgaestus  LIKE bgae_t.bgaestus 
    
    LET g_errno = ''  
    #161003-00014#3---s---
    LET l_bgaestus = NULL
    SELECT ooalstus INTO l_bgaestus
      FROM ooal_t
     WHERE ooalent = g_enterprise
       AND ooal001 = '11'    #預算
       AND ooal002 = p_bgae007
         
    #SELECT bgaestus INTO l_bgaestus FROM bgae_t
    # WHERE bgaeent = g_enterprise
    #   AND bgae006 = p_bgae007
    #161003-00014#3---e---    
    CASE
       WHEN sqlca.sqlcode = 100 LET g_errno = 'abg-00166' #161003-00014#3 add
      #WHEN sqlca.sqlcode = 100 LET g_errno = 'abg-00005'  #161003-00014#3 mark
      #WHEN l_bgaestus ='N'    LET g_errno = 'abg-00006' #160318-00005#3 mark
      WHEN l_bgaestus ='N'     LET g_errno = 'sub-01302'  #160318-00005#3 add
    END CASE
    
END FUNCTION
# 檢查幣別資料的存在及有效性
PRIVATE FUNCTION abgi010_bgaa003_chk(p_ooai001)
DEFINE l_ooai001     LIKE ooai_t.ooai001
   DEFINE l_ooaistus    like ooai_t.ooaistus
   DEFINE p_ooai001     LIKE ooai_t.ooai001
   LET g_errno = ''
   SELECT ooai001,ooaistus  INTO l_ooai001,l_ooaistus
     FROM ooai_t
    WHERE ooaient = g_enterprise
      AND ooai001 = p_ooai001
    CASE
       WHEN sqlca.sqlcode = 100   LET g_errno = 'aoo-00028'
       #WHEN l_ooaistus ='N'       LET g_errno = 'aoo-00011'#160318-00005#3 mark 
       WHEN l_ooaistus ='N'       LET g_errno = 'sub-01302' #160318-00005#3 add
     END CASE
END FUNCTION
# 檢查預算週期是否在預算週期檔中存在且有效
PRIVATE FUNCTION abgi010_bgaa002_chk(p_bgaa002)
DEFINE p_bgaa002   LIKE bgaa_t.bgaa002
   DEFINE l_bgac001   LIKE bgac_t.bgac001
   DEFINE l_bgacstus  LIKE bgac_t.bgacstus
   
   LET g_errno = ''
   SELECT bgac001,bgacstus INTO l_bgac001,l_bgacstus FROM bgac_t
    WHERE bgacent = g_enterprise
      AND bgac001 = p_bgaa002
   CASE
      WHEN SQLCA.SQLCODE = 100  LET g_errno = 'abg-00003'
      WHEN l_bgacstus = 'N'     LET g_errno = 'sub-01302'  #160318-00005#3 add
      #WHEN l_bgacstus = 'N'     LET g_errno = 'abg-00004' #160318-00005#3 mark
   END CASE
END FUNCTION
#预算组织资料检查
PRIVATE FUNCTION abgi010_bgaa010_chk(p_bgaa010)
   DEFINE p_bgaa010    LIKE bgaa_t.bgaa010
   DEFINE l_ooebstus   LIKE ooeb_t.ooebstus
   
   LET g_errno = ''
   IF NOT cl_null(g_bgaa_d[l_ac].bgaa011) THEN
      SELECT ooeb001 FROM ooeb_t
       WHERE ooebent = g_enterprise
         AND ooeb004 = '4'
         AND ooeb005 = g_bgaa_d[l_ac].bgaa011
         AND ooeb006 = p_bgaa010
         AND ooebstus = 'Y'
   ELSE
      SELECT ooeb001 FROM ooeb_t
       WHERE ooebent = g_enterprise
         AND ooeb006 = p_bgaa010
         AND ooebstus = 'Y'       
   END IF
     
   CASE
      WHEN SQLCA.SQLCODE = 100       LET g_errno = 'abg-00047'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 檢核是否存在參照表
# Memo...........: #150709-00008#2
# Usage..........: CALL abgi010_bgaa008_chk1(p_bgae007)
#                  RETURNING g_errno
# Date & Author..: 150713 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi010_bgaa008_chk1(p_bgae007)
DEFINE p_bgae007   LIKE bgae_t.bgae006
DEFINE l_glacstus  LIKE glac_t.glacstus
    
    LET g_errno = ''

    #albireo 160222-----s
#    SELECT glacstus INTO l_glacstus FROM glac_t
#     WHERE glacent = g_enterprise
#       AND glac001 = p_bgae007         
#       
    LET l_glacstus = NULL
    SELECT ooalstus INTO l_glacstus
      FROM ooal_t
     WHERE ooalent = g_enterprise
       AND ooal001 = '0'    #會科
       AND ooal002 = p_bgae007
    #albireo 160222-----e

    CASE
       WHEN sqlca.sqlcode = 100   LET g_errno = 'sub-01305'  #160318-00005#3 add
       #WHEN sqlca.sqlcode = 100   LET g_errno = 'agl-00010' #160318-00005#3 mark
       WHEN l_glacstus ='N'       LET g_errno = 'sub-01302'  #160318-00005#3 add
       #WHEN l_glacstus ='N'       LET g_errno = 'agl-00114' #160318-00005#3 mark
    END CASE
END FUNCTION

 
{</section>}
 
