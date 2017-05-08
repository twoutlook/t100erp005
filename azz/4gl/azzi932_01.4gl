#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi932_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-06-08 14:23:35), PR版次:0004(2016-07-29 16:07:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: azzi932_01
#+ Description: 問題管制表異動記錄
#+ Creator....: 01101(2014-12-08 14:05:16)
#+ Modifier...: 01101 -SD/PR- 08146
 
{</section>}
 
{<section id="azzi932_01.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: 01101(2014-11-19 17:36:24) 此程式欄位增減時,都要檢查 "#手動維護" 的部分
#+ Creator....: No.160726-00017#2 2016/07/29 By frank0521 共用函式改呼叫library
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
PRIVATE TYPE type_g_gzwo_d RECORD
       gzwostus LIKE gzwo_t.gzwostus, 
   gzwo001 LIKE gzwo_t.gzwo001, 
   gzwoseq LIKE gzwo_t.gzwoseq, 
   gzwo901 LIKE gzwo_t.gzwo901, 
   gzwo902 LIKE gzwo_t.gzwo902, 
   gzwo011 LIKE gzwo_t.gzwo011, 
   gzwo017 LIKE gzwo_t.gzwo017, 
   gzwo002 LIKE gzwo_t.gzwo002, 
   gzwo003 LIKE gzwo_t.gzwo003, 
   gzwo008 LIKE gzwo_t.gzwo008, 
   gzwo008_desc LIKE type_t.chr500, 
   gzwo010 LIKE gzwo_t.gzwo010, 
   gzwo004 LIKE gzwo_t.gzwo004, 
   gzwo012 LIKE gzwo_t.gzwo012, 
   gzwo027 LIKE gzwo_t.gzwo027, 
   gzwo005 LIKE gzwo_t.gzwo005, 
   gzwo005_desc LIKE type_t.chr500, 
   gzwo013 LIKE gzwo_t.gzwo013, 
   gzwo006 LIKE gzwo_t.gzwo006, 
   gzwo006_desc LIKE type_t.chr500, 
   gzwo015 LIKE gzwo_t.gzwo015, 
   gzwo007 LIKE gzwo_t.gzwo007, 
   gzwo018 LIKE gzwo_t.gzwo018, 
   gzwo007_desc LIKE type_t.chr500, 
   gzwo014 LIKE gzwo_t.gzwo014, 
   gzwo009 LIKE gzwo_t.gzwo009, 
   gzwo026 LIKE gzwo_t.gzwo026, 
   gzwo016 LIKE gzwo_t.gzwo016, 
   gzwo019 LIKE gzwo_t.gzwo019, 
   gzwo020 LIKE gzwo_t.gzwo020, 
   gzwo021 LIKE gzwo_t.gzwo021, 
   gzwo022 LIKE gzwo_t.gzwo022, 
   gzwo023 LIKE gzwo_t.gzwo023, 
   gzwo024 LIKE gzwo_t.gzwo024, 
   gzwo025 LIKE gzwo_t.gzwo025, 
   gzwoownid LIKE gzwo_t.gzwoownid, 
   gzwoownid_desc LIKE type_t.chr500, 
   gzwoowndp LIKE gzwo_t.gzwoowndp, 
   gzwoowndp_desc LIKE type_t.chr500, 
   gzwocrtid LIKE gzwo_t.gzwocrtid, 
   gzwocrtid_desc LIKE type_t.chr500, 
   gzwocrtdp LIKE gzwo_t.gzwocrtdp, 
   gzwocrtdp_desc LIKE type_t.chr500, 
   gzwocrtdt DATETIME YEAR TO SECOND, 
   gzwomodid LIKE gzwo_t.gzwomodid, 
   gzwomodid_desc LIKE type_t.chr500, 
   gzwomoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_gzwo_att RECORD   #列表顏色屬性   #手動維護
   gzwostus STRING,
   gzwo001 STRING,
   gzwoseq STRING,
   gzwo901 STRING,
   gzwo902 STRING,
   gzwo011 STRING,
   gzwo017 STRING,
   gzwo002 STRING,
   gzwo003 STRING,
   gzwo008 STRING,
   gzwo008_desc STRING,
   gzwo010 STRING,
   gzwo004 STRING,
   gzwo012 STRING,
   gzwo027 STRING,
   gzwo005 STRING,
   gzwo005_desc STRING,
   gzwo013 STRING,
   gzwo006 STRING,
   gzwo006_desc STRING,
   gzwo015 STRING,
   gzwo007 STRING,
   gzwo018 STRING,
   gzwo007_desc STRING,
   gzwo014 STRING,
   gzwo009 STRING,
   gzwo026 STRING,
   gzwo016 STRING,
   gzwo019 STRING,
   gzwo020 STRING,
   gzwo021 STRING,
   gzwo022 STRING,
   gzwo023 STRING,
   gzwo024 STRING,
   gzwo025 STRING,
   gzwoownid STRING,
   gzwoownid_desc STRING,
   gzwoowndp STRING,
   gzwoowndp_desc STRING,
   gzwocrtid STRING,
   gzwocrtid_desc STRING,
   gzwocrtdp STRING,
   gzwocrtdp_desc STRING,
   gzwocrtdt  STRING,
   gzwomodid  STRING,
   gzwomodid_desc  STRING,
   gzwomoddt  STRING
   END RECORD
DEFINE g_gzwo_att DYNAMIC ARRAY OF type_g_gzwo_att   #列表顏色屬性,異動的欄位要變色
DEFINE g_color_diff         STRING                   #顏色:表示此資料已異動
DEFINE g_syncway            STRING                   #與服務平台同步方式 alm,almhelp,eservice
#end add-point
 
#模組變數(Module Variables)
DEFINE g_gzwo_d          DYNAMIC ARRAY OF type_g_gzwo_d #單身變數
DEFINE g_gzwo_d_t        type_g_gzwo_d                  #單身備份
DEFINE g_gzwo_d_o        type_g_gzwo_d                  #單身備份
DEFINE g_gzwo_d_mask_o   DYNAMIC ARRAY OF type_g_gzwo_d #單身變數
DEFINE g_gzwo_d_mask_n   DYNAMIC ARRAY OF type_g_gzwo_d #單身變數
 
      
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
 
{<section id="azzi932_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION azzi932_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_argv01
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_argv01   LIKE gzwo_t.gzwo001
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_argv[01] = p_argv01
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT gzwostus,gzwo001,gzwoseq,gzwo901,gzwo902,gzwo011,gzwo017,gzwo002,gzwo003, 
       gzwo008,gzwo010,gzwo004,gzwo012,gzwo027,gzwo005,gzwo013,gzwo006,gzwo015,gzwo007,gzwo018,gzwo014, 
       gzwo009,gzwo026,gzwo016,gzwo019,gzwo020,gzwo021,gzwo022,gzwo023,gzwo024,gzwo025,gzwoownid,gzwoowndp, 
       gzwocrtid,gzwocrtdp,gzwocrtdt,gzwomodid,gzwomoddt FROM gzwo_t WHERE gzwo001=? AND gzwoseq=? FOR  
       UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi932_01_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi932_01 WITH FORM cl_ap_formpath("azz","azzi932_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL azzi932_01_init()   
 
   #進入選單 Menu (="N")
   CALL azzi932_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_azzi932_01
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi932_01.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzi932_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('gzwo901','176') 
   CALL cl_set_combo_scc('gzwo011','147') 
   CALL cl_set_combo_scc('gzwo002','140') 
   CALL cl_set_combo_scc('gzwo015','1') 
   CALL cl_set_combo_scc('gzwo014','153') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_module("gzwo003",1)            #模組
   CALL cl_set_combo_scc_part('gzwo015','1','0,2')  #聯絡對象類型
   LET g_color_diff = "#fbffd3 reverse"             #顏色:表示此資料已異動
      
   CALL cl_helps932_syncway() RETURNING g_syncway
   
   IF g_syncway != "alm" THEN
      CALL cl_set_combo_scc_part('gzwi014','153','1,2')   #SCC '153': 0.產中;1.MIS;2.鼎新
   END IF
   #end add-point
   
   CALL azzi932_01_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzi932_01_ui_dialog()
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
         CALL g_gzwo_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL azzi932_01_init()
      END IF
   
      CALL azzi932_01_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzwo_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               CALL DIALOG.setArrayAttributes("s_detail1", g_gzwo_att)   #列表顏色屬性,異動的欄位要變色
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
               LET g_data_owner = g_gzwo_d[g_detail_idx].gzwoownid   #(ver:35)
               LET g_data_dept = g_gzwo_d[g_detail_idx].gzwoowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL azzi932_01_set_pk_array()
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
            CALL DIALOG.setArrayAttributes("s_detail1", g_gzwo_att)   #列表顏色屬性,異動的欄位要變色
            #end add-point
            NEXT FIELD CURRENT
      
         
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
               CALL azzi932_01_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzwo_d)
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
            CALL azzi932_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi932_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi932_01_set_pk_array()
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
         LET INT_FLAG = FALSE   #還原值,避免影響主程式
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi932_01_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   CALL g_gzwo_att.clear()
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzwo_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON gzwostus,gzwo001,gzwoseq,gzwo901,gzwo011,gzwo017,gzwo002,gzwo003,gzwo008,gzwo010, 
          gzwo004,gzwo012,gzwo027,gzwo005,gzwo013,gzwo006,gzwo015,gzwo018,gzwo014,gzwo009,gzwo026,gzwo016, 
          gzwo019,gzwo020,gzwo021,gzwo022,gzwo023,gzwo024,gzwo025,gzwoownid,gzwoowndp,gzwocrtid,gzwocrtdp, 
          gzwocrtdt,gzwomodid,gzwomoddt 
 
         FROM s_detail1[1].gzwostus,s_detail1[1].gzwo001,s_detail1[1].gzwoseq,s_detail1[1].gzwo901,s_detail1[1].gzwo011, 
             s_detail1[1].gzwo017,s_detail1[1].gzwo002,s_detail1[1].gzwo003,s_detail1[1].gzwo008,s_detail1[1].gzwo010, 
             s_detail1[1].gzwo004,s_detail1[1].gzwo012,s_detail1[1].gzwo027,s_detail1[1].gzwo005,s_detail1[1].gzwo013, 
             s_detail1[1].gzwo006,s_detail1[1].gzwo015,s_detail1[1].gzwo018,s_detail1[1].gzwo014,s_detail1[1].gzwo009, 
             s_detail1[1].gzwo026,s_detail1[1].gzwo016,s_detail1[1].gzwo019,s_detail1[1].gzwo020,s_detail1[1].gzwo021, 
             s_detail1[1].gzwo022,s_detail1[1].gzwo023,s_detail1[1].gzwo024,s_detail1[1].gzwo025,s_detail1[1].gzwoownid, 
             s_detail1[1].gzwoowndp,s_detail1[1].gzwocrtid,s_detail1[1].gzwocrtdp,s_detail1[1].gzwocrtdt, 
             s_detail1[1].gzwomodid,s_detail1[1].gzwomoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzwocrtdt>>----
         AFTER FIELD gzwocrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzwomoddt>>----
         AFTER FIELD gzwomoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwocnfdt>>----
         
         #----<<gzwopstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwostus
            #add-point:BEFORE FIELD gzwostus name="query.b.page1.gzwostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwostus
            
            #add-point:AFTER FIELD gzwostus name="query.a.page1.gzwostus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwostus
            #add-point:ON ACTION controlp INFIELD gzwostus name="query.c.page1.gzwostus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo001
            #add-point:BEFORE FIELD gzwo001 name="query.b.page1.gzwo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo001
            
            #add-point:AFTER FIELD gzwo001 name="query.a.page1.gzwo001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo001
            #add-point:ON ACTION controlp INFIELD gzwo001 name="query.c.page1.gzwo001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwoseq
            #add-point:BEFORE FIELD gzwoseq name="query.b.page1.gzwoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwoseq
            
            #add-point:AFTER FIELD gzwoseq name="query.a.page1.gzwoseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwoseq
            #add-point:ON ACTION controlp INFIELD gzwoseq name="query.c.page1.gzwoseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo901
            #add-point:BEFORE FIELD gzwo901 name="query.b.page1.gzwo901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo901
            
            #add-point:AFTER FIELD gzwo901 name="query.a.page1.gzwo901"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo901
            #add-point:ON ACTION controlp INFIELD gzwo901 name="query.c.page1.gzwo901"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo011
            #add-point:BEFORE FIELD gzwo011 name="query.b.page1.gzwo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo011
            
            #add-point:AFTER FIELD gzwo011 name="query.a.page1.gzwo011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo011
            #add-point:ON ACTION controlp INFIELD gzwo011 name="query.c.page1.gzwo011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo017
            #add-point:BEFORE FIELD gzwo017 name="query.b.page1.gzwo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo017
            
            #add-point:AFTER FIELD gzwo017 name="query.a.page1.gzwo017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo017
            #add-point:ON ACTION controlp INFIELD gzwo017 name="query.c.page1.gzwo017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo002
            #add-point:BEFORE FIELD gzwo002 name="query.b.page1.gzwo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo002
            
            #add-point:AFTER FIELD gzwo002 name="query.a.page1.gzwo002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo002
            #add-point:ON ACTION controlp INFIELD gzwo002 name="query.c.page1.gzwo002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo003
            #add-point:BEFORE FIELD gzwo003 name="query.b.page1.gzwo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo003
            
            #add-point:AFTER FIELD gzwo003 name="query.a.page1.gzwo003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo003
            #add-point:ON ACTION controlp INFIELD gzwo003 name="query.c.page1.gzwo003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzwo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo008
            #add-point:ON ACTION controlp INFIELD gzwo008 name="construct.c.page1.gzwo008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwo008  #顯示到畫面上
            NEXT FIELD gzwo008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo008
            #add-point:BEFORE FIELD gzwo008 name="query.b.page1.gzwo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo008
            
            #add-point:AFTER FIELD gzwo008 name="query.a.page1.gzwo008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo010
            #add-point:BEFORE FIELD gzwo010 name="query.b.page1.gzwo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo010
            
            #add-point:AFTER FIELD gzwo010 name="query.a.page1.gzwo010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo010
            #add-point:ON ACTION controlp INFIELD gzwo010 name="query.c.page1.gzwo010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo004
            #add-point:BEFORE FIELD gzwo004 name="query.b.page1.gzwo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo004
            
            #add-point:AFTER FIELD gzwo004 name="query.a.page1.gzwo004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo004
            #add-point:ON ACTION controlp INFIELD gzwo004 name="query.c.page1.gzwo004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo012
            #add-point:BEFORE FIELD gzwo012 name="query.b.page1.gzwo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo012
            
            #add-point:AFTER FIELD gzwo012 name="query.a.page1.gzwo012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo012
            #add-point:ON ACTION controlp INFIELD gzwo012 name="query.c.page1.gzwo012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo027
            #add-point:BEFORE FIELD gzwo027 name="query.b.page1.gzwo027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo027
            
            #add-point:AFTER FIELD gzwo027 name="query.a.page1.gzwo027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo027
            #add-point:ON ACTION controlp INFIELD gzwo027 name="query.c.page1.gzwo027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzwo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo005
            #add-point:ON ACTION controlp INFIELD gzwo005 name="construct.c.page1.gzwo005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwo005  #顯示到畫面上
            NEXT FIELD gzwo005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo005
            #add-point:BEFORE FIELD gzwo005 name="query.b.page1.gzwo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo005
            
            #add-point:AFTER FIELD gzwo005 name="query.a.page1.gzwo005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo013
            #add-point:BEFORE FIELD gzwo013 name="query.b.page1.gzwo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo013
            
            #add-point:AFTER FIELD gzwo013 name="query.a.page1.gzwo013"
            #反映日期
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo013
            #add-point:ON ACTION controlp INFIELD gzwo013 name="query.c.page1.gzwo013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzwo006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo006
            #add-point:ON ACTION controlp INFIELD gzwo006 name="construct.c.page1.gzwo006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwo006  #顯示到畫面上
            NEXT FIELD gzwo006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo006
            #add-point:BEFORE FIELD gzwo006 name="query.b.page1.gzwo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo006
            
            #add-point:AFTER FIELD gzwo006 name="query.a.page1.gzwo006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo015
            #add-point:BEFORE FIELD gzwo015 name="query.b.page1.gzwo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo015
            
            #add-point:AFTER FIELD gzwo015 name="query.a.page1.gzwo015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo015
            #add-point:ON ACTION controlp INFIELD gzwo015 name="query.c.page1.gzwo015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo018
            #add-point:BEFORE FIELD gzwo018 name="query.b.page1.gzwo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo018
            
            #add-point:AFTER FIELD gzwo018 name="query.a.page1.gzwo018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo018
            #add-point:ON ACTION controlp INFIELD gzwo018 name="query.c.page1.gzwo018"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = DIALOG.getFieldBuffer("gzwo015")   #處理人員類型
            CALL q_oofa001_4()                       #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwo018    #顯示到畫面上
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo014
            #add-point:BEFORE FIELD gzwo014 name="query.b.page1.gzwo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo014
            
            #add-point:AFTER FIELD gzwo014 name="query.a.page1.gzwo014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo014
            #add-point:ON ACTION controlp INFIELD gzwo014 name="query.c.page1.gzwo014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo009
            #add-point:BEFORE FIELD gzwo009 name="query.b.page1.gzwo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo009
            
            #add-point:AFTER FIELD gzwo009 name="query.a.page1.gzwo009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo009
            #add-point:ON ACTION controlp INFIELD gzwo009 name="query.c.page1.gzwo009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo026
            #add-point:BEFORE FIELD gzwo026 name="query.b.page1.gzwo026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo026
            
            #add-point:AFTER FIELD gzwo026 name="query.a.page1.gzwo026"
            #最近同步時間
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo026
            #add-point:ON ACTION controlp INFIELD gzwo026 name="query.c.page1.gzwo026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo016
            #add-point:BEFORE FIELD gzwo016 name="query.b.page1.gzwo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo016
            
            #add-point:AFTER FIELD gzwo016 name="query.a.page1.gzwo016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo016
            #add-point:ON ACTION controlp INFIELD gzwo016 name="query.c.page1.gzwo016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo019
            #add-point:BEFORE FIELD gzwo019 name="query.b.page1.gzwo019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo019
            
            #add-point:AFTER FIELD gzwo019 name="query.a.page1.gzwo019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo019
            #add-point:ON ACTION controlp INFIELD gzwo019 name="query.c.page1.gzwo019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo020
            #add-point:BEFORE FIELD gzwo020 name="query.b.page1.gzwo020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo020
            
            #add-point:AFTER FIELD gzwo020 name="query.a.page1.gzwo020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo020
            #add-point:ON ACTION controlp INFIELD gzwo020 name="query.c.page1.gzwo020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo021
            #add-point:BEFORE FIELD gzwo021 name="query.b.page1.gzwo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo021
            
            #add-point:AFTER FIELD gzwo021 name="query.a.page1.gzwo021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo021
            #add-point:ON ACTION controlp INFIELD gzwo021 name="query.c.page1.gzwo021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo022
            #add-point:BEFORE FIELD gzwo022 name="query.b.page1.gzwo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo022
            
            #add-point:AFTER FIELD gzwo022 name="query.a.page1.gzwo022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo022
            #add-point:ON ACTION controlp INFIELD gzwo022 name="query.c.page1.gzwo022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo023
            #add-point:BEFORE FIELD gzwo023 name="query.b.page1.gzwo023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo023
            
            #add-point:AFTER FIELD gzwo023 name="query.a.page1.gzwo023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo023
            #add-point:ON ACTION controlp INFIELD gzwo023 name="query.c.page1.gzwo023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo024
            #add-point:BEFORE FIELD gzwo024 name="query.b.page1.gzwo024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo024
            
            #add-point:AFTER FIELD gzwo024 name="query.a.page1.gzwo024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo024
            #add-point:ON ACTION controlp INFIELD gzwo024 name="query.c.page1.gzwo024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo025
            #add-point:BEFORE FIELD gzwo025 name="query.b.page1.gzwo025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo025
            
            #add-point:AFTER FIELD gzwo025 name="query.a.page1.gzwo025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.gzwo025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo025
            #add-point:ON ACTION controlp INFIELD gzwo025 name="query.c.page1.gzwo025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzwoownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwoownid
            #add-point:ON ACTION controlp INFIELD gzwoownid name="construct.c.page1.gzwoownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwoownid  #顯示到畫面上
            NEXT FIELD gzwoownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwoownid
            #add-point:BEFORE FIELD gzwoownid name="query.b.page1.gzwoownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwoownid
            
            #add-point:AFTER FIELD gzwoownid name="query.a.page1.gzwoownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwoowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwoowndp
            #add-point:ON ACTION controlp INFIELD gzwoowndp name="construct.c.page1.gzwoowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwoowndp  #顯示到畫面上
            NEXT FIELD gzwoowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwoowndp
            #add-point:BEFORE FIELD gzwoowndp name="query.b.page1.gzwoowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwoowndp
            
            #add-point:AFTER FIELD gzwoowndp name="query.a.page1.gzwoowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwocrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwocrtid
            #add-point:ON ACTION controlp INFIELD gzwocrtid name="construct.c.page1.gzwocrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwocrtid  #顯示到畫面上
            NEXT FIELD gzwocrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwocrtid
            #add-point:BEFORE FIELD gzwocrtid name="query.b.page1.gzwocrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwocrtid
            
            #add-point:AFTER FIELD gzwocrtid name="query.a.page1.gzwocrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwocrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwocrtdp
            #add-point:ON ACTION controlp INFIELD gzwocrtdp name="construct.c.page1.gzwocrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwocrtdp  #顯示到畫面上
            NEXT FIELD gzwocrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwocrtdp
            #add-point:BEFORE FIELD gzwocrtdp name="query.b.page1.gzwocrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwocrtdp
            
            #add-point:AFTER FIELD gzwocrtdp name="query.a.page1.gzwocrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwocrtdt
            #add-point:BEFORE FIELD gzwocrtdt name="query.b.page1.gzwocrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzwomodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwomodid
            #add-point:ON ACTION controlp INFIELD gzwomodid name="construct.c.page1.gzwomodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwomodid  #顯示到畫面上
            NEXT FIELD gzwomodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwomodid
            #add-point:BEFORE FIELD gzwomodid name="query.b.page1.gzwomodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwomodid
            
            #add-point:AFTER FIELD gzwomodid name="query.a.page1.gzwomodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwomoddt
            #add-point:BEFORE FIELD gzwomoddt name="query.b.page1.gzwomoddt"
            
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
    
   CALL azzi932_01_b_fill(g_wc2)
   LET g_data_owner = g_gzwo_d[g_detail_idx].gzwoownid   #(ver:35)
   LET g_data_dept = g_gzwo_d[g_detail_idx].gzwoowndp   #(ver:35)
 
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
 
{<section id="azzi932_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi932_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL azzi932_01_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi932_01_modify()
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
      INPUT ARRAY g_gzwo_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzwo_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi932_01_b_fill(g_wc2)
            LET g_detail_cnt = g_gzwo_d.getLength()
         
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
            DISPLAY g_gzwo_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_gzwo_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_gzwo_d[l_ac].gzwo001 IS NOT NULL
               AND g_gzwo_d[l_ac].gzwoseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzwo_d_t.* = g_gzwo_d[l_ac].*  #BACKUP
               LET g_gzwo_d_o.* = g_gzwo_d[l_ac].*  #BACKUP
               IF NOT azzi932_01_lock_b("gzwo_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi932_01_bcl INTO g_gzwo_d[l_ac].gzwostus,g_gzwo_d[l_ac].gzwo001,g_gzwo_d[l_ac].gzwoseq, 
                      g_gzwo_d[l_ac].gzwo901,g_gzwo_d[l_ac].gzwo902,g_gzwo_d[l_ac].gzwo011,g_gzwo_d[l_ac].gzwo017, 
                      g_gzwo_d[l_ac].gzwo002,g_gzwo_d[l_ac].gzwo003,g_gzwo_d[l_ac].gzwo008,g_gzwo_d[l_ac].gzwo010, 
                      g_gzwo_d[l_ac].gzwo004,g_gzwo_d[l_ac].gzwo012,g_gzwo_d[l_ac].gzwo027,g_gzwo_d[l_ac].gzwo005, 
                      g_gzwo_d[l_ac].gzwo013,g_gzwo_d[l_ac].gzwo006,g_gzwo_d[l_ac].gzwo015,g_gzwo_d[l_ac].gzwo007, 
                      g_gzwo_d[l_ac].gzwo018,g_gzwo_d[l_ac].gzwo014,g_gzwo_d[l_ac].gzwo009,g_gzwo_d[l_ac].gzwo026, 
                      g_gzwo_d[l_ac].gzwo016,g_gzwo_d[l_ac].gzwo019,g_gzwo_d[l_ac].gzwo020,g_gzwo_d[l_ac].gzwo021, 
                      g_gzwo_d[l_ac].gzwo022,g_gzwo_d[l_ac].gzwo023,g_gzwo_d[l_ac].gzwo024,g_gzwo_d[l_ac].gzwo025, 
                      g_gzwo_d[l_ac].gzwoownid,g_gzwo_d[l_ac].gzwoowndp,g_gzwo_d[l_ac].gzwocrtid,g_gzwo_d[l_ac].gzwocrtdp, 
                      g_gzwo_d[l_ac].gzwocrtdt,g_gzwo_d[l_ac].gzwomodid,g_gzwo_d[l_ac].gzwomoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzwo_d_t.gzwo001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzwo_d_mask_o[l_ac].* =  g_gzwo_d[l_ac].*
                  CALL azzi932_01_gzwo_t_mask()
                  LET g_gzwo_d_mask_n[l_ac].* =  g_gzwo_d[l_ac].*
                  
                  CALL azzi932_01_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL azzi932_01_set_entry_b(l_cmd)
            CALL azzi932_01_set_no_entry_b(l_cmd)
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
            INITIALIZE g_gzwo_d_t.* TO NULL
            INITIALIZE g_gzwo_d_o.* TO NULL
            INITIALIZE g_gzwo_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzwo_d[l_ac].gzwoownid = g_user
      LET g_gzwo_d[l_ac].gzwoowndp = g_dept
      LET g_gzwo_d[l_ac].gzwocrtid = g_user
      LET g_gzwo_d[l_ac].gzwocrtdp = g_dept 
      LET g_gzwo_d[l_ac].gzwocrtdt = cl_get_current()
      LET g_gzwo_d[l_ac].gzwomodid = g_user
      LET g_gzwo_d[l_ac].gzwomoddt = cl_get_current()
      LET g_gzwo_d[l_ac].gzwostus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_gzwo_d[l_ac].gzwoseq = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_gzwo_d_t.* = g_gzwo_d[l_ac].*     #新輸入資料
            LET g_gzwo_d_o.* = g_gzwo_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzwo_d[li_reproduce_target].* = g_gzwo_d[li_reproduce].*
 
               LET g_gzwo_d[g_gzwo_d.getLength()].gzwo001 = NULL
               LET g_gzwo_d[g_gzwo_d.getLength()].gzwoseq = NULL
 
            END IF
            
 
            CALL azzi932_01_set_entry_b(l_cmd)
            CALL azzi932_01_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM gzwo_t 
             WHERE  gzwo001 = g_gzwo_d[l_ac].gzwo001
                                       AND gzwoseq = g_gzwo_d[l_ac].gzwoseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzwo_d[g_detail_idx].gzwo001
               LET gs_keys[2] = g_gzwo_d[g_detail_idx].gzwoseq
               CALL azzi932_01_insert_b('gzwo_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzwo_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzwo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi932_01_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (gzwo001 = '", g_gzwo_d[l_ac].gzwo001, "' "
                                  ," AND gzwoseq = '", g_gzwo_d[l_ac].gzwoseq, "' "
 
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
               
               DELETE FROM gzwo_t
                WHERE  
                      gzwo001 = g_gzwo_d_t.gzwo001
                      AND gzwoseq = g_gzwo_d_t.gzwoseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzwo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL azzi932_01_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_gzwo_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE azzi932_01_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_gzwo_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzwo_d_t.gzwo001
               LET gs_keys[2] = g_gzwo_d_t.gzwoseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi932_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL azzi932_01_delete_b('gzwo_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzwo_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwostus
            #add-point:BEFORE FIELD gzwostus name="input.b.page1.gzwostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwostus
            
            #add-point:AFTER FIELD gzwostus name="input.a.page1.gzwostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwostus
            #add-point:ON CHANGE gzwostus name="input.g.page1.gzwostus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo901
            #add-point:BEFORE FIELD gzwo901 name="input.b.page1.gzwo901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo901
            
            #add-point:AFTER FIELD gzwo901 name="input.a.page1.gzwo901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwo901
            #add-point:ON CHANGE gzwo901 name="input.g.page1.gzwo901"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwo027
            #add-point:BEFORE FIELD gzwo027 name="input.b.page1.gzwo027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwo027
            
            #add-point:AFTER FIELD gzwo027 name="input.a.page1.gzwo027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwo027
            #add-point:ON CHANGE gzwo027 name="input.g.page1.gzwo027"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzwostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwostus
            #add-point:ON ACTION controlp INFIELD gzwostus name="input.c.page1.gzwostus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzwo901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo901
            #add-point:ON ACTION controlp INFIELD gzwo901 name="input.c.page1.gzwo901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzwo027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwo027
            #add-point:ON ACTION controlp INFIELD gzwo027 name="input.c.page1.gzwo027"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE azzi932_01_bcl
               LET INT_FLAG = 0
               LET g_gzwo_d[l_ac].* = g_gzwo_d_t.*
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
               LET g_errparam.extend = g_gzwo_d[l_ac].gzwo001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzwo_d[l_ac].* = g_gzwo_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_gzwo_d[l_ac].gzwomodid = g_user 
LET g_gzwo_d[l_ac].gzwomoddt = cl_get_current()
LET g_gzwo_d[l_ac].gzwomodid_desc = cl_get_username(g_gzwo_d[l_ac].gzwomodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi932_01_gzwo_t_mask_restore('restore_mask_o')
 
               UPDATE gzwo_t SET (gzwostus,gzwo001,gzwoseq,gzwo901,gzwo902,gzwo011,gzwo017,gzwo002,gzwo003, 
                   gzwo008,gzwo010,gzwo004,gzwo012,gzwo027,gzwo005,gzwo013,gzwo006,gzwo015,gzwo007,gzwo018, 
                   gzwo014,gzwo009,gzwo026,gzwo016,gzwo019,gzwo020,gzwo021,gzwo022,gzwo023,gzwo024,gzwo025, 
                   gzwoownid,gzwoowndp,gzwocrtid,gzwocrtdp,gzwocrtdt,gzwomodid,gzwomoddt) = (g_gzwo_d[l_ac].gzwostus, 
                   g_gzwo_d[l_ac].gzwo001,g_gzwo_d[l_ac].gzwoseq,g_gzwo_d[l_ac].gzwo901,g_gzwo_d[l_ac].gzwo902, 
                   g_gzwo_d[l_ac].gzwo011,g_gzwo_d[l_ac].gzwo017,g_gzwo_d[l_ac].gzwo002,g_gzwo_d[l_ac].gzwo003, 
                   g_gzwo_d[l_ac].gzwo008,g_gzwo_d[l_ac].gzwo010,g_gzwo_d[l_ac].gzwo004,g_gzwo_d[l_ac].gzwo012, 
                   g_gzwo_d[l_ac].gzwo027,g_gzwo_d[l_ac].gzwo005,g_gzwo_d[l_ac].gzwo013,g_gzwo_d[l_ac].gzwo006, 
                   g_gzwo_d[l_ac].gzwo015,g_gzwo_d[l_ac].gzwo007,g_gzwo_d[l_ac].gzwo018,g_gzwo_d[l_ac].gzwo014, 
                   g_gzwo_d[l_ac].gzwo009,g_gzwo_d[l_ac].gzwo026,g_gzwo_d[l_ac].gzwo016,g_gzwo_d[l_ac].gzwo019, 
                   g_gzwo_d[l_ac].gzwo020,g_gzwo_d[l_ac].gzwo021,g_gzwo_d[l_ac].gzwo022,g_gzwo_d[l_ac].gzwo023, 
                   g_gzwo_d[l_ac].gzwo024,g_gzwo_d[l_ac].gzwo025,g_gzwo_d[l_ac].gzwoownid,g_gzwo_d[l_ac].gzwoowndp, 
                   g_gzwo_d[l_ac].gzwocrtid,g_gzwo_d[l_ac].gzwocrtdp,g_gzwo_d[l_ac].gzwocrtdt,g_gzwo_d[l_ac].gzwomodid, 
                   g_gzwo_d[l_ac].gzwomoddt)
                WHERE 
                  gzwo001 = g_gzwo_d_t.gzwo001 #項次   
                  AND gzwoseq = g_gzwo_d_t.gzwoseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzwo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzwo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzwo_d[g_detail_idx].gzwo001
               LET gs_keys_bak[1] = g_gzwo_d_t.gzwo001
               LET gs_keys[2] = g_gzwo_d[g_detail_idx].gzwoseq
               LET gs_keys_bak[2] = g_gzwo_d_t.gzwoseq
               CALL azzi932_01_update_b('gzwo_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_gzwo_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzwo_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi932_01_gzwo_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL azzi932_01_unlock_b("gzwo_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzwo_d[l_ac].* = g_gzwo_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
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
               LET g_gzwo_d[li_reproduce_target].* = g_gzwo_d[li_reproduce].*
 
               LET g_gzwo_d[li_reproduce_target].gzwo001 = NULL
               LET g_gzwo_d[li_reproduce_target].gzwoseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzwo_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzwo_d.getLength()+1
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
               NEXT FIELD gzwostus
 
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
      IF INT_FLAG OR cl_null(g_gzwo_d[g_detail_idx].gzwo001) THEN
         CALL g_gzwo_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_gzwo_d[g_detail_idx].* = g_gzwo_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE azzi932_01_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi932_01_delete()
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
   FOR li_idx = 1 TO g_gzwo_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT azzi932_01_lock_b("gzwo_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("gzwo_t","gzwoownid") THEN
            LET g_data_owner = g_gzwo_d[g_detail_idx].gzwoownid
            LET g_data_dept = g_gzwo_d[g_detail_idx].gzwoowndp
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
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
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_gzwo_d.getLength()
      IF g_gzwo_d[li_idx].gzwo001 IS NOT NULL
         AND g_gzwo_d[li_idx].gzwoseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM gzwo_t
          WHERE  
                gzwo001 = g_gzwo_d[li_idx].gzwo001
                AND gzwoseq = g_gzwo_d[li_idx].gzwoseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzwo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
            
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzwo_d_t.gzwo001
               LET gs_keys[2] = g_gzwo_d_t.gzwoseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL azzi932_01_delete_b('gzwo_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi932_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL azzi932_01_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi932_01_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.gzwostus,t0.gzwo001,t0.gzwoseq,t0.gzwo901,t0.gzwo902,t0.gzwo011, 
       t0.gzwo017,t0.gzwo002,t0.gzwo003,t0.gzwo008,t0.gzwo010,t0.gzwo004,t0.gzwo012,t0.gzwo027,t0.gzwo005, 
       t0.gzwo013,t0.gzwo006,t0.gzwo015,t0.gzwo007,t0.gzwo018,t0.gzwo014,t0.gzwo009,t0.gzwo026,t0.gzwo016, 
       t0.gzwo019,t0.gzwo020,t0.gzwo021,t0.gzwo022,t0.gzwo023,t0.gzwo024,t0.gzwo025,t0.gzwoownid,t0.gzwoowndp, 
       t0.gzwocrtid,t0.gzwocrtdp,t0.gzwocrtdt,t0.gzwomodid,t0.gzwomoddt ,t1.gzzal003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.oofa011 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 FROM gzwo_t t0",
               "",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzwo008 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.gzwo005  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.gzwo006 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t4 ON t4.oofaent="||g_enterprise||" AND t4.oofa001=t0.gzwo007  ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gzwoownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.gzwoowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.gzwocrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.gzwocrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.gzwomodid  ",
 
               " WHERE 1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("gzwo_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND gzwoowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("gzwo_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND gzwoownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("gzwo_t"),
                      " ORDER BY t0.gzwo001,t0.gzwoseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   CALL g_gzwo_att.clear()
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzwo_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzi932_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi932_01_pb
   
   OPEN b_fill_curs
 
   CALL g_gzwo_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_gzwo_d[l_ac].gzwostus,g_gzwo_d[l_ac].gzwo001,g_gzwo_d[l_ac].gzwoseq,g_gzwo_d[l_ac].gzwo901, 
       g_gzwo_d[l_ac].gzwo902,g_gzwo_d[l_ac].gzwo011,g_gzwo_d[l_ac].gzwo017,g_gzwo_d[l_ac].gzwo002,g_gzwo_d[l_ac].gzwo003, 
       g_gzwo_d[l_ac].gzwo008,g_gzwo_d[l_ac].gzwo010,g_gzwo_d[l_ac].gzwo004,g_gzwo_d[l_ac].gzwo012,g_gzwo_d[l_ac].gzwo027, 
       g_gzwo_d[l_ac].gzwo005,g_gzwo_d[l_ac].gzwo013,g_gzwo_d[l_ac].gzwo006,g_gzwo_d[l_ac].gzwo015,g_gzwo_d[l_ac].gzwo007, 
       g_gzwo_d[l_ac].gzwo018,g_gzwo_d[l_ac].gzwo014,g_gzwo_d[l_ac].gzwo009,g_gzwo_d[l_ac].gzwo026,g_gzwo_d[l_ac].gzwo016, 
       g_gzwo_d[l_ac].gzwo019,g_gzwo_d[l_ac].gzwo020,g_gzwo_d[l_ac].gzwo021,g_gzwo_d[l_ac].gzwo022,g_gzwo_d[l_ac].gzwo023, 
       g_gzwo_d[l_ac].gzwo024,g_gzwo_d[l_ac].gzwo025,g_gzwo_d[l_ac].gzwoownid,g_gzwo_d[l_ac].gzwoowndp, 
       g_gzwo_d[l_ac].gzwocrtid,g_gzwo_d[l_ac].gzwocrtdp,g_gzwo_d[l_ac].gzwocrtdt,g_gzwo_d[l_ac].gzwomodid, 
       g_gzwo_d[l_ac].gzwomoddt,g_gzwo_d[l_ac].gzwo008_desc,g_gzwo_d[l_ac].gzwo005_desc,g_gzwo_d[l_ac].gzwo006_desc, 
       g_gzwo_d[l_ac].gzwo007_desc,g_gzwo_d[l_ac].gzwoownid_desc,g_gzwo_d[l_ac].gzwoowndp_desc,g_gzwo_d[l_ac].gzwocrtid_desc, 
       g_gzwo_d[l_ac].gzwocrtdp_desc,g_gzwo_d[l_ac].gzwomodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL azzi932_01_att(l_ac,g_gzwo_d[l_ac].gzwo902)
      #end add-point
      
      CALL azzi932_01_detail_show()      
 
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
   
 
   
   CALL g_gzwo_d.deleteElement(g_gzwo_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_gzwo_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_gzwo_d.getLength() THEN
      LET l_ac = g_gzwo_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzwo_d.getLength()
      LET g_gzwo_d_mask_o[l_ac].* =  g_gzwo_d[l_ac].*
      CALL azzi932_01_gzwo_t_mask()
      LET g_gzwo_d_mask_n[l_ac].* =  g_gzwo_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_gzwo_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE azzi932_01_pb
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzi932_01_detail_show()
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
   
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi932_01_set_entry_b(p_cmd)                                                  
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
 
{<section id="azzi932_01.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi932_01_set_no_entry_b(p_cmd)                                               
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
 
{<section id="azzi932_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi932_01_default_search()
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
      LET ls_wc = ls_wc, " gzwo001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzwoseq = '", g_argv[02], "' AND "
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
 
{<section id="azzi932_01.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi932_01_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "gzwo_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'gzwo_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM gzwo_t
          WHERE 
            gzwo001 = ps_keys_bak[1] AND gzwoseq = ps_keys_bak[2]
         
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
         CALL g_gzwo_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi932_01_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "gzwo_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO gzwo_t
                  (
                   gzwo001,gzwoseq
                   ,gzwostus,gzwo901,gzwo902,gzwo011,gzwo017,gzwo002,gzwo003,gzwo008,gzwo010,gzwo004,gzwo012,gzwo027,gzwo005,gzwo013,gzwo006,gzwo015,gzwo007,gzwo018,gzwo014,gzwo009,gzwo026,gzwo016,gzwo019,gzwo020,gzwo021,gzwo022,gzwo023,gzwo024,gzwo025,gzwoownid,gzwoowndp,gzwocrtid,gzwocrtdp,gzwocrtdt,gzwomodid,gzwomoddt) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzwo_d[l_ac].gzwostus,g_gzwo_d[l_ac].gzwo901,g_gzwo_d[l_ac].gzwo902,g_gzwo_d[l_ac].gzwo011, 
                       g_gzwo_d[l_ac].gzwo017,g_gzwo_d[l_ac].gzwo002,g_gzwo_d[l_ac].gzwo003,g_gzwo_d[l_ac].gzwo008, 
                       g_gzwo_d[l_ac].gzwo010,g_gzwo_d[l_ac].gzwo004,g_gzwo_d[l_ac].gzwo012,g_gzwo_d[l_ac].gzwo027, 
                       g_gzwo_d[l_ac].gzwo005,g_gzwo_d[l_ac].gzwo013,g_gzwo_d[l_ac].gzwo006,g_gzwo_d[l_ac].gzwo015, 
                       g_gzwo_d[l_ac].gzwo007,g_gzwo_d[l_ac].gzwo018,g_gzwo_d[l_ac].gzwo014,g_gzwo_d[l_ac].gzwo009, 
                       g_gzwo_d[l_ac].gzwo026,g_gzwo_d[l_ac].gzwo016,g_gzwo_d[l_ac].gzwo019,g_gzwo_d[l_ac].gzwo020, 
                       g_gzwo_d[l_ac].gzwo021,g_gzwo_d[l_ac].gzwo022,g_gzwo_d[l_ac].gzwo023,g_gzwo_d[l_ac].gzwo024, 
                       g_gzwo_d[l_ac].gzwo025,g_gzwo_d[l_ac].gzwoownid,g_gzwo_d[l_ac].gzwoowndp,g_gzwo_d[l_ac].gzwocrtid, 
                       g_gzwo_d[l_ac].gzwocrtdp,g_gzwo_d[l_ac].gzwocrtdt,g_gzwo_d[l_ac].gzwomodid,g_gzwo_d[l_ac].gzwomoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzwo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi932_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "gzwo_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "gzwo_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE gzwo_t 
         SET (gzwo001,gzwoseq
              ,gzwostus,gzwo901,gzwo902,gzwo011,gzwo017,gzwo002,gzwo003,gzwo008,gzwo010,gzwo004,gzwo012,gzwo027,gzwo005,gzwo013,gzwo006,gzwo015,gzwo007,gzwo018,gzwo014,gzwo009,gzwo026,gzwo016,gzwo019,gzwo020,gzwo021,gzwo022,gzwo023,gzwo024,gzwo025,gzwoownid,gzwoowndp,gzwocrtid,gzwocrtdp,gzwocrtdt,gzwomodid,gzwomoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzwo_d[l_ac].gzwostus,g_gzwo_d[l_ac].gzwo901,g_gzwo_d[l_ac].gzwo902,g_gzwo_d[l_ac].gzwo011, 
                  g_gzwo_d[l_ac].gzwo017,g_gzwo_d[l_ac].gzwo002,g_gzwo_d[l_ac].gzwo003,g_gzwo_d[l_ac].gzwo008, 
                  g_gzwo_d[l_ac].gzwo010,g_gzwo_d[l_ac].gzwo004,g_gzwo_d[l_ac].gzwo012,g_gzwo_d[l_ac].gzwo027, 
                  g_gzwo_d[l_ac].gzwo005,g_gzwo_d[l_ac].gzwo013,g_gzwo_d[l_ac].gzwo006,g_gzwo_d[l_ac].gzwo015, 
                  g_gzwo_d[l_ac].gzwo007,g_gzwo_d[l_ac].gzwo018,g_gzwo_d[l_ac].gzwo014,g_gzwo_d[l_ac].gzwo009, 
                  g_gzwo_d[l_ac].gzwo026,g_gzwo_d[l_ac].gzwo016,g_gzwo_d[l_ac].gzwo019,g_gzwo_d[l_ac].gzwo020, 
                  g_gzwo_d[l_ac].gzwo021,g_gzwo_d[l_ac].gzwo022,g_gzwo_d[l_ac].gzwo023,g_gzwo_d[l_ac].gzwo024, 
                  g_gzwo_d[l_ac].gzwo025,g_gzwo_d[l_ac].gzwoownid,g_gzwo_d[l_ac].gzwoowndp,g_gzwo_d[l_ac].gzwocrtid, 
                  g_gzwo_d[l_ac].gzwocrtdp,g_gzwo_d[l_ac].gzwocrtdt,g_gzwo_d[l_ac].gzwomodid,g_gzwo_d[l_ac].gzwomoddt)  
 
         WHERE  gzwo001 = ps_keys_bak[1] AND gzwoseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzwo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzwo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi932_01_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL azzi932_01_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "gzwo_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi932_01_bcl USING 
                                       g_gzwo_d[g_detail_idx].gzwo001,g_gzwo_d[g_detail_idx].gzwoseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi932_01_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi932_01_unlock_b(ps_table)
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
      CLOSE azzi932_01_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION azzi932_01_modify_detail_chk(ps_record)
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
         LET ls_return = "gzwostus"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932_01.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION azzi932_01_show_ownid_msg()
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
 
{<section id="azzi932_01.mask_functions" >}
&include "erp/azz/azzi932_01_mask.4gl"
 
{</section>}
 
{<section id="azzi932_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi932_01_set_pk_array()
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
   LET g_pk_array[1].values = g_gzwo_d[l_ac].gzwo001
   LET g_pk_array[1].column = 'gzwo001'
   LET g_pk_array[2].values = g_gzwo_d[l_ac].gzwoseq
   LET g_pk_array[2].column = 'gzwoseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi932_01.state_change" >}
   
 
{</section>}
 
{<section id="azzi932_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi932_01.other_function" readonly="Y" >}

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
PUBLIC FUNCTION azzi932_01_att(p_idx,p_gzwo902)
   DEFINE p_idx       LIKE type_t.num5
   DEFINE p_gzwo902   LIKE gzwo_t.gzwo902
   DEFINE l_str       STRING
   DEFINE l_tok       base.StringTokenizer
   DEFINE l_tmp       STRING

   LET l_str = p_gzwo902
   LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
   WHILE l_tok.hasMoreTokens()	#依序取得子字串
      LET l_tmp = l_tok.nextToken()
      LET l_tmp = l_tmp.trim()
      
      CASE l_tmp
         WHEN "gzwistus"        LET g_gzwo_att[p_idx].gzwostus       = g_color_diff
         WHEN "gzwi001"         LET g_gzwo_att[p_idx].gzwo001        = g_color_diff
         WHEN "gzwiseq"         LET g_gzwo_att[p_idx].gzwoseq        = g_color_diff
         WHEN "gzwi901"         LET g_gzwo_att[p_idx].gzwo901        = g_color_diff
         WHEN "gzwi902"         LET g_gzwo_att[p_idx].gzwo902        = g_color_diff
         WHEN "gzwi011"         LET g_gzwo_att[p_idx].gzwo011        = g_color_diff
         WHEN "gzwi017"         LET g_gzwo_att[p_idx].gzwo017        = g_color_diff
         WHEN "gzwi002"         LET g_gzwo_att[p_idx].gzwo002        = g_color_diff
         WHEN "gzwi003"         LET g_gzwo_att[p_idx].gzwo003        = g_color_diff
         WHEN "gzwi008"         LET g_gzwo_att[p_idx].gzwo008        = g_color_diff
         WHEN "gzwi008_desc"    LET g_gzwo_att[p_idx].gzwo008_desc   = g_color_diff
         WHEN "gzwi010"         LET g_gzwo_att[p_idx].gzwo010        = g_color_diff
         WHEN "gzwi004"         LET g_gzwo_att[p_idx].gzwo004        = g_color_diff
         WHEN "gzwi012"         LET g_gzwo_att[p_idx].gzwo012        = g_color_diff
         WHEN "gzwi027"         LET g_gzwo_att[p_idx].gzwo027        = g_color_diff
         WHEN "gzwi005"         LET g_gzwo_att[p_idx].gzwo005        = g_color_diff
         WHEN "gzwi005_desc"    LET g_gzwo_att[p_idx].gzwo005_desc   = g_color_diff
         WHEN "gzwi013"         LET g_gzwo_att[p_idx].gzwo013        = g_color_diff
         WHEN "gzwi006"         LET g_gzwo_att[p_idx].gzwo006        = g_color_diff
         WHEN "gzwi006_desc"    LET g_gzwo_att[p_idx].gzwo006_desc   = g_color_diff
         WHEN "gzwi015"         LET g_gzwo_att[p_idx].gzwo015        = g_color_diff
         WHEN "gzwi007"         LET g_gzwo_att[p_idx].gzwo007        = g_color_diff
         WHEN "gzwi018"         LET g_gzwo_att[p_idx].gzwo018        = g_color_diff
         WHEN "gzwi007_desc"    LET g_gzwo_att[p_idx].gzwo007_desc   = g_color_diff
         WHEN "gzwi014"         LET g_gzwo_att[p_idx].gzwo014        = g_color_diff
         WHEN "gzwi009"         LET g_gzwo_att[p_idx].gzwo009        = g_color_diff
         WHEN "gzwi016"         LET g_gzwo_att[p_idx].gzwo016        = g_color_diff
         WHEN "gzwi019"         LET g_gzwo_att[p_idx].gzwo019        = g_color_diff
         WHEN "gzwi020"         LET g_gzwo_att[p_idx].gzwo020        = g_color_diff
         WHEN "gzwi021"         LET g_gzwo_att[p_idx].gzwo021        = g_color_diff
         WHEN "gzwi022"         LET g_gzwo_att[p_idx].gzwo022        = g_color_diff
         WHEN "gzwi023"         LET g_gzwo_att[p_idx].gzwo023        = g_color_diff
         WHEN "gzwi024"         LET g_gzwo_att[p_idx].gzwo024        = g_color_diff
         WHEN "gzwi025"         LET g_gzwo_att[p_idx].gzwo025        = g_color_diff
         WHEN "gzwi026"         LET g_gzwo_att[p_idx].gzwo026        = g_color_diff
         WHEN "gzwiownid"       LET g_gzwo_att[p_idx].gzwoownid      = g_color_diff
         WHEN "gzwiownid_desc"  LET g_gzwo_att[p_idx].gzwoownid_desc = g_color_diff
         WHEN "gzwiowndp"       LET g_gzwo_att[p_idx].gzwoowndp      = g_color_diff
         WHEN "gzwiowndp_desc"  LET g_gzwo_att[p_idx].gzwoowndp_desc = g_color_diff
         WHEN "gzwicrtid"       LET g_gzwo_att[p_idx].gzwocrtid      = g_color_diff
         WHEN "gzwicrtid_desc"  LET g_gzwo_att[p_idx].gzwocrtid_desc = g_color_diff
         WHEN "gzwicrtdp"       LET g_gzwo_att[p_idx].gzwocrtdp      = g_color_diff
         WHEN "gzwicrtdp_desc"  LET g_gzwo_att[p_idx].gzwocrtdp_desc = g_color_diff
         WHEN "gzwicrtdt"       LET g_gzwo_att[p_idx].gzwocrtdt      = g_color_diff
         WHEN "gzwimodid"       LET g_gzwo_att[p_idx].gzwomodid      = g_color_diff
         WHEN "gzwimodid_desc"  LET g_gzwo_att[p_idx].gzwomodid_desc = g_color_diff
         WHEN "gzwimoddt"       LET g_gzwo_att[p_idx].gzwomoddt      = g_color_diff
      END CASE
   END WHILE

END FUNCTION

 
{</section>}
 
