#該程式未解開Section, 採用最新樣板產出!
{<section id="agli051.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-02-10 15:04:38), PR版次:0007(2016-10-21 20:43:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: agli051
#+ Description: 科目核算項依帳套設定默認值
#+ Creator....: 02599(2015-02-10 15:04:38)
#+ Modifier...: 02599 -SD/PR- 06821
 
{</section>}
 
{<section id="agli051.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#28   2016/03/28  By Jessy         修正azzi920重複定義之錯誤訊息
#160318-00025#7    2016/04/20  By 07675         將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160811-00039#7    2016/08/26  By 02599         查询及建立资料时（包括直接查询全部、开窗、输入值后的检核）及更改和删除，要考虑账套权限。
#160913-00017#3    2016/09/21  By 07900         AGL模组调整交易客商开窗
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
PRIVATE TYPE type_g_glas_d RECORD
       glasstus LIKE glas_t.glasstus, 
   glasld LIKE glas_t.glasld, 
   glasld_desc LIKE type_t.chr500, 
   glas001 LIKE glas_t.glas001, 
   glas001_desc LIKE type_t.chr500, 
   glas002 LIKE glas_t.glas002, 
   glas003 LIKE glas_t.glas003, 
   glas003_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_glas2_d RECORD
       glasld LIKE glas_t.glasld, 
   glasld_2_desc LIKE type_t.chr500, 
   glas001 LIKE glas_t.glas001, 
   glas002 LIKE glas_t.glas002, 
   glasownid LIKE glas_t.glasownid, 
   glasownid_desc LIKE type_t.chr500, 
   glasowndp LIKE glas_t.glasowndp, 
   glasowndp_desc LIKE type_t.chr500, 
   glascrtid LIKE glas_t.glascrtid, 
   glascrtid_desc LIKE type_t.chr500, 
   glascrtdp LIKE glas_t.glascrtdp, 
   glascrtdp_desc LIKE type_t.chr500, 
   glascrtdt DATETIME YEAR TO SECOND, 
   glasmodid LIKE glas_t.glasmodid, 
   glasmodid_desc LIKE type_t.chr500, 
   glasmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_glas_d          DYNAMIC ARRAY OF type_g_glas_d #單身變數
DEFINE g_glas_d_t        type_g_glas_d                  #單身備份
DEFINE g_glas_d_o        type_g_glas_d                  #單身備份
DEFINE g_glas_d_mask_o   DYNAMIC ARRAY OF type_g_glas_d #單身變數
DEFINE g_glas_d_mask_n   DYNAMIC ARRAY OF type_g_glas_d #單身變數
DEFINE g_glas2_d   DYNAMIC ARRAY OF type_g_glas2_d
DEFINE g_glas2_d_t type_g_glas2_d
DEFINE g_glas2_d_o type_g_glas2_d
DEFINE g_glas2_d_mask_o DYNAMIC ARRAY OF type_g_glas2_d
DEFINE g_glas2_d_mask_n DYNAMIC ARRAY OF type_g_glas2_d
 
      
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
 
{<section id="agli051.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT glasstus,glasld,glas001,glas002,glas003,glasld,glas001,glas002,glasownid, 
       glasowndp,glascrtid,glascrtdp,glascrtdt,glasmodid,glasmoddt FROM glas_t WHERE glasent=? AND glasld=?  
       AND glas001=? AND glas002=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli051_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agli051 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agli051_init()   
 
      #進入選單 Menu (="N")
      CALL agli051_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agli051
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agli051.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION agli051_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('glas002','9934') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('glas002','9934','4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,23,24')
   #end add-point
   
   CALL agli051_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="agli051.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION agli051_ui_dialog()
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
         CALL g_glas_d.clear()
         CALL g_glas2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL agli051_init()
      END IF
   
      CALL agli051_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glas_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_glas2_d[g_detail_idx].glasownid   #(ver:35)
               LET g_data_dept = g_glas2_d[g_detail_idx].glasowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL agli051_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_glas2_d TO s_detail2.*
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
   CALL agli051_set_pk_array()
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
            CALL agli051_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agli051_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL agli051_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agli051_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL agli051_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL agli051_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli051_insert()
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
               CALL agli051_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_glas_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_glas2_d)
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
            CALL agli051_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli051_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli051_set_pk_array()
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
 
{<section id="agli051.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli051_query()
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
   CALL g_glas_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON glasstus,glasld,glas001,glas001_desc,glas002,glas003,glas003_desc,glasownid, 
          glasowndp,glascrtid,glascrtdp,glascrtdt,glasmodid,glasmoddt 
 
         FROM s_detail1[1].glasstus,s_detail1[1].glasld,s_detail1[1].glas001,s_detail1[1].glas001_desc, 
             s_detail1[1].glas002,s_detail1[1].glas003,s_detail1[1].glas003_desc,s_detail2[1].glasownid, 
             s_detail2[1].glasowndp,s_detail2[1].glascrtid,s_detail2[1].glascrtdp,s_detail2[1].glascrtdt, 
             s_detail2[1].glasmodid,s_detail2[1].glasmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glascrtdt>>----
         AFTER FIELD glascrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glasmoddt>>----
         AFTER FIELD glasmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glascnfdt>>----
         
         #----<<glaspstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasstus
            #add-point:BEFORE FIELD glasstus name="query.b.page1.glasstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasstus
            
            #add-point:AFTER FIELD glasstus name="query.a.page1.glasstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glasstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasstus
            #add-point:ON ACTION controlp INFIELD glasstus name="query.c.page1.glasstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glasld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasld
            #add-point:ON ACTION controlp INFIELD glasld name="construct.c.page1.glasld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glasld  #顯示到畫面上
            NEXT FIELD glasld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasld
            #add-point:BEFORE FIELD glasld name="query.b.page1.glasld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasld
            
            #add-point:AFTER FIELD glasld name="query.a.page1.glasld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glas001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas001
            #add-point:ON ACTION controlp INFIELD glas001 name="construct.c.page1.glas001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glas001  #顯示到畫面上
            NEXT FIELD glas001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas001
            #add-point:BEFORE FIELD glas001 name="query.b.page1.glas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas001
            
            #add-point:AFTER FIELD glas001 name="query.a.page1.glas001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas001_desc
            #add-point:BEFORE FIELD glas001_desc name="query.b.page1.glas001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas001_desc
            
            #add-point:AFTER FIELD glas001_desc name="query.a.page1.glas001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glas001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas001_desc
            #add-point:ON ACTION controlp INFIELD glas001_desc name="query.c.page1.glas001_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas002
            #add-point:BEFORE FIELD glas002 name="query.b.page1.glas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas002
            
            #add-point:AFTER FIELD glas002 name="query.a.page1.glas002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas002
            #add-point:ON ACTION controlp INFIELD glas002 name="query.c.page1.glas002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas003
            #add-point:BEFORE FIELD glas003 name="query.b.page1.glas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas003
            
            #add-point:AFTER FIELD glas003 name="query.a.page1.glas003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas003
            #add-point:ON ACTION controlp INFIELD glas003 name="query.c.page1.glas003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas003_desc
            #add-point:BEFORE FIELD glas003_desc name="query.b.page1.glas003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas003_desc
            
            #add-point:AFTER FIELD glas003_desc name="query.a.page1.glas003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.glas003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas003_desc
            #add-point:ON ACTION controlp INFIELD glas003_desc name="query.c.page1.glas003_desc"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.glasownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasownid
            #add-point:ON ACTION controlp INFIELD glasownid name="construct.c.page2.glasownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glasownid  #顯示到畫面上
            NEXT FIELD glasownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasownid
            #add-point:BEFORE FIELD glasownid name="query.b.page2.glasownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasownid
            
            #add-point:AFTER FIELD glasownid name="query.a.page2.glasownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glasowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasowndp
            #add-point:ON ACTION controlp INFIELD glasowndp name="construct.c.page2.glasowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glasowndp  #顯示到畫面上
            NEXT FIELD glasowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasowndp
            #add-point:BEFORE FIELD glasowndp name="query.b.page2.glasowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasowndp
            
            #add-point:AFTER FIELD glasowndp name="query.a.page2.glasowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glascrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glascrtid
            #add-point:ON ACTION controlp INFIELD glascrtid name="construct.c.page2.glascrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glascrtid  #顯示到畫面上
            NEXT FIELD glascrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glascrtid
            #add-point:BEFORE FIELD glascrtid name="query.b.page2.glascrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glascrtid
            
            #add-point:AFTER FIELD glascrtid name="query.a.page2.glascrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glascrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glascrtdp
            #add-point:ON ACTION controlp INFIELD glascrtdp name="construct.c.page2.glascrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glascrtdp  #顯示到畫面上
            NEXT FIELD glascrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glascrtdp
            #add-point:BEFORE FIELD glascrtdp name="query.b.page2.glascrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glascrtdp
            
            #add-point:AFTER FIELD glascrtdp name="query.a.page2.glascrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glascrtdt
            #add-point:BEFORE FIELD glascrtdt name="query.b.page2.glascrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glasmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasmodid
            #add-point:ON ACTION controlp INFIELD glasmodid name="construct.c.page2.glasmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glasmodid  #顯示到畫面上
            NEXT FIELD glasmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasmodid
            #add-point:BEFORE FIELD glasmodid name="query.b.page2.glasmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasmodid
            
            #add-point:AFTER FIELD glasmodid name="query.a.page2.glasmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasmoddt
            #add-point:BEFORE FIELD glasmoddt name="query.b.page2.glasmoddt"
            
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
    
   CALL agli051_b_fill(g_wc2)
   LET g_data_owner = g_glas2_d[g_detail_idx].glasownid   #(ver:35)
   LET g_data_dept = g_glas2_d[g_detail_idx].glasowndp   #(ver:35)
 
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
 
{<section id="agli051.insert" >}
#+ 資料新增
PRIVATE FUNCTION agli051_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL agli051_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agli051.modify" >}
#+ 資料修改
PRIVATE FUNCTION agli051_modify()
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
   DEFINE  l_glaa004              LIKE glaa_t.glaa004
   DEFINE  l_success              LIKE type_t.num5
   DEFINE  l_glae009              LIKE glae_t.glae009
   DEFINE l_where                 LIKE type_t.chr100
   DEFINE  l_exeprog              LIKE type_t.chr80    #160321-00016#28 add
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
      INPUT ARRAY g_glas_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glas_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agli051_b_fill(g_wc2)
            LET g_detail_cnt = g_glas_d.getLength()
         
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
            DISPLAY g_glas_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_glas_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_glas_d[l_ac].glasld IS NOT NULL
               AND g_glas_d[l_ac].glas001 IS NOT NULL
               AND g_glas_d[l_ac].glas002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glas_d_t.* = g_glas_d[l_ac].*  #BACKUP
               LET g_glas_d_o.* = g_glas_d[l_ac].*  #BACKUP
               IF NOT agli051_lock_b("glas_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli051_bcl INTO g_glas_d[l_ac].glasstus,g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001, 
                      g_glas_d[l_ac].glas002,g_glas_d[l_ac].glas003,g_glas2_d[l_ac].glasld,g_glas2_d[l_ac].glas001, 
                      g_glas2_d[l_ac].glas002,g_glas2_d[l_ac].glasownid,g_glas2_d[l_ac].glasowndp,g_glas2_d[l_ac].glascrtid, 
                      g_glas2_d[l_ac].glascrtdp,g_glas2_d[l_ac].glascrtdt,g_glas2_d[l_ac].glasmodid, 
                      g_glas2_d[l_ac].glasmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glas_d_t.glasld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glas_d_mask_o[l_ac].* =  g_glas_d[l_ac].*
                  CALL agli051_glas_t_mask()
                  LET g_glas_d_mask_n[l_ac].* =  g_glas_d[l_ac].*
                  
                  CALL agli051_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL agli051_set_entry_b(l_cmd)
            CALL agli051_set_no_entry_b(l_cmd)
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
            INITIALIZE g_glas_d_t.* TO NULL
            INITIALIZE g_glas_d_o.* TO NULL
            INITIALIZE g_glas_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glas2_d[l_ac].glasownid = g_user
      LET g_glas2_d[l_ac].glasowndp = g_dept
      LET g_glas2_d[l_ac].glascrtid = g_user
      LET g_glas2_d[l_ac].glascrtdp = g_dept 
      LET g_glas2_d[l_ac].glascrtdt = cl_get_current()
      LET g_glas2_d[l_ac].glasmodid = g_user
      LET g_glas2_d[l_ac].glasmoddt = cl_get_current()
      LET g_glas_d[l_ac].glasstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_glas_d[l_ac].glasstus = "Y"
      LET g_glas_d[l_ac].glas002 = "5"
 
            #add-point:modify段before備份 name="input.body.before_bak"
 
            #end add-point
            LET g_glas_d_t.* = g_glas_d[l_ac].*     #新輸入資料
            LET g_glas_d_o.* = g_glas_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glas_d[li_reproduce_target].* = g_glas_d[li_reproduce].*
               LET g_glas2_d[li_reproduce_target].* = g_glas2_d[li_reproduce].*
 
               LET g_glas_d[g_glas_d.getLength()].glasld = NULL
               LET g_glas_d[g_glas_d.getLength()].glas001 = NULL
               LET g_glas_d[g_glas_d.getLength()].glas002 = NULL
 
            END IF
            
 
 
            CALL agli051_set_entry_b(l_cmd)
            CALL agli051_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM glas_t 
             WHERE glasent = g_enterprise AND glasld = g_glas_d[l_ac].glasld
                                       AND glas001 = g_glas_d[l_ac].glas001
                                       AND glas002 = g_glas_d[l_ac].glas002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glas_d[g_detail_idx].glasld
               LET gs_keys[2] = g_glas_d[g_detail_idx].glas001
               LET gs_keys[3] = g_glas_d[g_detail_idx].glas002
               CALL agli051_insert_b('glas_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_glas_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "glas_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agli051_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (glasld = '", g_glas_d[l_ac].glasld, "' "
                                  ," AND glas001 = '", g_glas_d[l_ac].glas001, "' "
                                  ," AND glas002 = '", g_glas_d[l_ac].glas002, "' "
 
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
               
               DELETE FROM glas_t
                WHERE glasent = g_enterprise AND 
                      glasld = g_glas_d_t.glasld
                      AND glas001 = g_glas_d_t.glas001
                      AND glas002 = g_glas_d_t.glas002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glas_t:",SQLERRMESSAGE 
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
                  CALL agli051_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_glas_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE agli051_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_glas_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glas_d_t.glasld
               LET gs_keys[2] = g_glas_d_t.glas001
               LET gs_keys[3] = g_glas_d_t.glas002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli051_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL agli051_delete_b('glas_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glas_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasstus
            #add-point:BEFORE FIELD glasstus name="input.b.page1.glasstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasstus
            
            #add-point:AFTER FIELD glasstus name="input.a.page1.glasstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glasstus
            #add-point:ON CHANGE glasstus name="input.g.page1.glasstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glasld
            
            #add-point:AFTER FIELD glasld name="input.a.page1.glasld"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_glas_d[g_detail_idx].glasld IS NOT NULL AND g_glas_d[g_detail_idx].glas001 IS NOT NULL AND g_glas_d[g_detail_idx].glas002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glas_d[g_detail_idx].glasld != g_glas_d_t.glasld OR g_glas_d[g_detail_idx].glas001 != g_glas_d_t.glas001 OR g_glas_d[g_detail_idx].glas002 != g_glas_d_t.glas002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glas_t WHERE "||"glasent = '" ||g_enterprise|| "' AND "||"glasld = '"||g_glas_d[g_detail_idx].glasld ||"' AND "|| "glas001 = '"||g_glas_d[g_detail_idx].glas001 ||"' AND "|| "glas002 = '"||g_glas_d[g_detail_idx].glas002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
#            IF cl_null(g_glas_d[l_ac].glasld) THEN #160811-00039#7 mark
            IF NOT cl_null(g_glas_d[l_ac].glasld) THEN #160811-00039#7 add
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glas_d[l_ac].glasld != g_glas_d_t.glasld OR cl_null(g_glas_d_t.glasld))) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_glas_d[l_ac].glasld
                  #160318-00025#7--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#7--add--end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_glaald") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_glas_d[l_ac].glasld = g_glas_d_t.glasld
                     NEXT FIELD CURRENT
                  END IF
                  #160811-00039#7--add--str--
                  IF NOT s_ld_chk_authorization(g_user,g_glas_d[l_ac].glasld) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00165'
                     LET g_errparam.extend = g_glas_d[l_ac].glasld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glas_d[l_ac].glasld = g_glas_d_t.glasld
                     NEXT FIELD CURRENT
                  END IF
                  #160811-00039#7--add--end
               END IF
            END IF 

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glas_d[l_ac].glasld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glas_d[l_ac].glasld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glas_d[l_ac].glasld_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glasld
            #add-point:BEFORE FIELD glasld name="input.b.page1.glasld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glasld
            #add-point:ON CHANGE glasld name="input.g.page1.glasld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas001
            
            #add-point:AFTER FIELD glas001 name="input.a.page1.glas001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_glas_d[g_detail_idx].glasld IS NOT NULL AND g_glas_d[g_detail_idx].glas001 IS NOT NULL AND g_glas_d[g_detail_idx].glas002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glas_d[g_detail_idx].glasld != g_glas_d_t.glasld OR g_glas_d[g_detail_idx].glas001 != g_glas_d_t.glas001 OR g_glas_d[g_detail_idx].glas002 != g_glas_d_t.glas002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glas_t WHERE "||"glasent = '" ||g_enterprise|| "' AND "||"glasld = '"||g_glas_d[g_detail_idx].glasld ||"' AND "|| "glas001 = '"||g_glas_d[g_detail_idx].glas001 ||"' AND "|| "glas002 = '"||g_glas_d[g_detail_idx].glas002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_glas_d[l_ac].glas001) THEN
            
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glas_d[l_ac].glasld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glas_d[l_ac].glas001
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glas_d[l_ac].glas001
                  LET g_qryparam.arg3 = g_glas_d[l_ac].glasld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_glas_d[l_ac].glas001 = g_qryparam.return1              
                  DISPLAY g_glas_d[l_ac].glas001 TO glas001                  
               END IF
               # 150916-00015#1 --end
            
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glas_d[l_ac].glas001 != g_glas_d_t.glas001 OR cl_null(g_glas_d_t.glas001))) THEN                   
                  CALL s_voucher_glaq002_chk(g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glas_d[l_ac].glas001
                     #160321-00016#28 --s add
                     LET g_errparam.replace[1] = 'agli030'
                     LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                     LET g_errparam.exeprog = 'agli030'
                     #160321-00016#28 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glas_d[l_ac].glas001 = g_glas_d_t.glas001
                     CALL s_desc_get_account_desc(g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001) RETURNING g_glas_d[l_ac].glas001_desc
                     DISPLAY BY NAME g_glas_d[l_ac].glas001_desc
                     NEXT FIELD glas001                  
                  END IF 
               END IF
            END IF
            CALL s_desc_get_account_desc(g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001) RETURNING g_glas_d[l_ac].glas001_desc
            DISPLAY BY NAME g_glas_d[l_ac].glas001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas001
            #add-point:BEFORE FIELD glas001 name="input.b.page1.glas001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glas001
            #add-point:ON CHANGE glas001 name="input.g.page1.glas001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas001_desc
            #add-point:BEFORE FIELD glas001_desc name="input.b.page1.glas001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas001_desc
            
            #add-point:AFTER FIELD glas001_desc name="input.a.page1.glas001_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glas001_desc
            #add-point:ON CHANGE glas001_desc name="input.g.page1.glas001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas002
            #add-point:BEFORE FIELD glas002 name="input.b.page1.glas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas002
            
            #add-point:AFTER FIELD glas002 name="input.a.page1.glas002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_glas_d[g_detail_idx].glasld IS NOT NULL AND g_glas_d[g_detail_idx].glas001 IS NOT NULL AND g_glas_d[g_detail_idx].glas002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glas_d[g_detail_idx].glasld != g_glas_d_t.glasld OR g_glas_d[g_detail_idx].glas001 != g_glas_d_t.glas001 OR g_glas_d[g_detail_idx].glas002 != g_glas_d_t.glas002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glas_t WHERE "||"glasent = '" ||g_enterprise|| "' AND "||"glasld = '"||g_glas_d[g_detail_idx].glasld ||"' AND "|| "glas001 = '"||g_glas_d[g_detail_idx].glas001 ||"' AND "|| "glas002 = '"||g_glas_d[g_detail_idx].glas002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glas002
            #add-point:ON CHANGE glas002 name="input.g.page1.glas002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas003
            
            #add-point:AFTER FIELD glas003 name="input.a.page1.glas003"
            IF NOT cl_null(g_glas_d[l_ac].glas003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glas_d[l_ac].glas003 != g_glas_d_t.glas003 OR cl_null(g_glas_d_t.glas003) OR g_glas_d[l_ac].glas002 != g_glas_d_t.glas002)) THEN 
                  CALL agli051_glas003_chk() RETURNING l_success
                  IF NOT cl_null(g_errno) THEN
                     IF NOT cl_null(g_errparam.exeprog) THEN LET l_exeprog = g_errparam.exeprog END IF  #160321-00016#28 add
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glas_d[l_ac].glas001
                     #160321-00016#28 --s add
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     
                     IF NOT cl_null(l_exeprog) THEN #s_voucher_free_account_chk
                        LET g_errparam.replace[1] = l_exeprog
                        LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                        LET g_errparam.exeprog = l_exeprog
                     END IF
                     #160321-00016#28 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glas_d[l_ac].glas003 = g_glas_d_t.glas003
                     CALL agli051_glas003_desc()
                     NEXT FIELD glas003               
                  END IF                 
               END IF
            END IF
            CALL agli051_glas003_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas003
            #add-point:BEFORE FIELD glas003 name="input.b.page1.glas003"
            CALL agli051_glas003_def() RETURNING l_glae009,l_where
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glas003
            #add-point:ON CHANGE glas003 name="input.g.page1.glas003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glas003_desc
            #add-point:BEFORE FIELD glas003_desc name="input.b.page1.glas003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glas003_desc
            
            #add-point:AFTER FIELD glas003_desc name="input.a.page1.glas003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glas003_desc
            #add-point:ON CHANGE glas003_desc name="input.g.page1.glas003_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glasstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasstus
            #add-point:ON ACTION controlp INFIELD glasstus name="input.c.page1.glasstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glasld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glasld
            #add-point:ON ACTION controlp INFIELD glasld name="input.c.page1.glasld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glas_d[l_ac].glasld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user #s
            LET g_qryparam.arg2 = g_dept #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glas_d[l_ac].glasld = g_qryparam.return1              

            DISPLAY g_glas_d[l_ac].glasld TO glasld              #

            NEXT FIELD glasld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glas001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas001
            #add-point:ON ACTION controlp INFIELD glas001 name="input.c.page1.glas001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glas_d[l_ac].glas001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_glas_d[l_ac].glasld
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()                                #呼叫開窗

            LET g_glas_d[l_ac].glas001 = g_qryparam.return1              

            DISPLAY g_glas_d[l_ac].glas001 TO glas001              #

            NEXT FIELD glas001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glas001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas001_desc
            #add-point:ON ACTION controlp INFIELD glas001_desc name="input.c.page1.glas001_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas002
            #add-point:ON ACTION controlp INFIELD glas002 name="input.c.page1.glas002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas003
            #add-point:ON ACTION controlp INFIELD glas003 name="input.c.page1.glas003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glas_d[l_ac].glas003             #給予default值
            CASE g_glas_d[l_ac].glas002
               WHEN '1' #營運據點
                  LET g_qryparam.where ="ooefstus='Y'"                  
                  CALL q_ooef001()
               WHEN '2' #部門
                  LET g_qryparam.arg1 = g_today
                  CALL q_ooeg001_4()
               WHEN '3' #利潤/成本中心
                  LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
                  LET g_qryparam.arg1 = g_today
                  CALL q_ooeg001_5() 
               WHEN '4' #區域
                  CALL q_oocq002_287()  
               WHEN '5' #交易客商
                  CALL q_pmaa001_25()      #160913-00017#3  add
                 #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
               WHEN '6' #帳款客戶
                  CALL q_pmaa001_25()      #160913-00017#3  add
                  #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
               WHEN '7' #客群
                  CALL q_oocq002_281() 
               WHEN '8' #產品類別
                  CALL q_rtax001() 
               WHEN '9' #經營方式
                  LET g_qryparam.arg1 = '6013'
                  CALL q_gzcb001()
               WHEN '10' #渠道
                  CALL q_oojd001_2()
               WHEN '11' #品牌
                  CALL q_oocq002_2002() 
               WHEN '12' #人員
                  CALL q_ooag001_8()
               WHEN '13' #專案
                  CALL q_pjba001()
               WHEN '14' #WBS
                  LET g_qryparam.where = "pjbb012='1' "
                  CALL q_pjbb002()
            END CASE
            #自由核算項
            IF g_glas_d[l_ac].glas002 = '15' OR g_glas_d[l_ac].glas002 = '16' OR g_glas_d[l_ac].glas002 = '17' OR
               g_glas_d[l_ac].glas002 = '18' OR g_glas_d[l_ac].glas002 = '19' OR g_glas_d[l_ac].glas002 = '20' OR
               g_glas_d[l_ac].glas002 = '21' OR g_glas_d[l_ac].glas002 = '22' OR g_glas_d[l_ac].glas002 = '23' OR
               g_glas_d[l_ac].glas002 = '24' THEN
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_glas_d[l_ac].glas003 
                  LET g_qryparam.default2 = ""
                  #給予arg
                  IF l_glae009 = 'q_glaf002' THEN    
                     LET g_qryparam.where = l_where
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_glas_d[l_ac].glas003 = g_qryparam.return1 
                  DISPLAY g_glas_d[l_ac].glas003 TO glas003              #
                  NEXT FIELD glas003
               END IF
            END IF
            LET g_glas_d[l_ac].glas003 = g_qryparam.return1 
            DISPLAY g_glas_d[l_ac].glas003 TO glas003              #
            NEXT FIELD glas003
            #END add-point
 
 
         #Ctrlp:input.c.page1.glas003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glas003_desc
            #add-point:ON ACTION controlp INFIELD glas003_desc name="input.c.page1.glas003_desc"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE agli051_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_glas_d[l_ac].* = g_glas_d_t.*
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
               LET g_errparam.extend = g_glas_d[l_ac].glasld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glas_d[l_ac].* = g_glas_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_glas2_d[l_ac].glasmodid = g_user 
LET g_glas2_d[l_ac].glasmoddt = cl_get_current()
LET g_glas2_d[l_ac].glasmodid_desc = cl_get_username(g_glas2_d[l_ac].glasmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL agli051_glas_t_mask_restore('restore_mask_o')
 
               UPDATE glas_t SET (glasstus,glasld,glas001,glas002,glas003,glasownid,glasowndp,glascrtid, 
                   glascrtdp,glascrtdt,glasmodid,glasmoddt) = (g_glas_d[l_ac].glasstus,g_glas_d[l_ac].glasld, 
                   g_glas_d[l_ac].glas001,g_glas_d[l_ac].glas002,g_glas_d[l_ac].glas003,g_glas2_d[l_ac].glasownid, 
                   g_glas2_d[l_ac].glasowndp,g_glas2_d[l_ac].glascrtid,g_glas2_d[l_ac].glascrtdp,g_glas2_d[l_ac].glascrtdt, 
                   g_glas2_d[l_ac].glasmodid,g_glas2_d[l_ac].glasmoddt)
                WHERE glasent = g_enterprise AND
                  glasld = g_glas_d_t.glasld #項次   
                  AND glas001 = g_glas_d_t.glas001  
                  AND glas002 = g_glas_d_t.glas002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glas_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glas_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glas_d[g_detail_idx].glasld
               LET gs_keys_bak[1] = g_glas_d_t.glasld
               LET gs_keys[2] = g_glas_d[g_detail_idx].glas001
               LET gs_keys_bak[2] = g_glas_d_t.glas001
               LET gs_keys[3] = g_glas_d[g_detail_idx].glas002
               LET gs_keys_bak[3] = g_glas_d_t.glas002
               CALL agli051_update_b('glas_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_glas_d_t)
                     LET g_log2 = util.JSON.stringify(g_glas_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agli051_glas_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL agli051_unlock_b("glas_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glas_d[l_ac].* = g_glas_d_t.*
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
               LET g_glas_d[li_reproduce_target].* = g_glas_d[li_reproduce].*
               LET g_glas2_d[li_reproduce_target].* = g_glas2_d[li_reproduce].*
 
               LET g_glas_d[li_reproduce_target].glasld = NULL
               LET g_glas_d[li_reproduce_target].glas001 = NULL
               LET g_glas_d[li_reproduce_target].glas002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glas_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glas_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_glas2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL agli051_b_fill(g_wc2)
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
               NEXT FIELD glasstus
            WHEN "s_detail2"
               NEXT FIELD glasld_2
 
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
      IF INT_FLAG OR cl_null(g_glas_d[g_detail_idx].glasld) THEN
         CALL g_glas_d.deleteElement(g_detail_idx)
         CALL g_glas2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_glas_d[g_detail_idx].* = g_glas_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE agli051_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="agli051.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agli051_delete()
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
   FOR li_idx = 1 TO g_glas_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT agli051_lock_b("glas_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("glas_t","glasownid") THEN
            LET g_data_owner = g_glas2_d[g_detail_idx].glasownid
            LET g_data_dept = g_glas2_d[g_detail_idx].glasowndp
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
   
   FOR li_idx = 1 TO g_glas_d.getLength()
      IF g_glas_d[li_idx].glasld IS NOT NULL
         AND g_glas_d[li_idx].glas001 IS NOT NULL
         AND g_glas_d[li_idx].glas002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         #160811-00039#7--add--str--
         IF NOT s_ld_chk_authorization(g_user,g_glas_d[li_idx].glasld) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00165'
            LET g_errparam.extend = g_glas_d[li_idx].glasld
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         #160811-00039#7--add--end
         #end add-point   
         
         DELETE FROM glas_t
          WHERE glasent = g_enterprise AND 
                glasld = g_glas_d[li_idx].glasld
                AND glas001 = g_glas_d[li_idx].glas001
                AND glas002 = g_glas_d[li_idx].glas002
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glas_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_glas_d_t.glasld
               LET gs_keys[2] = g_glas_d_t.glas001
               LET gs_keys[3] = g_glas_d_t.glas002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL agli051_delete_b('glas_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli051_set_pk_array()
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
   CALL agli051_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="agli051.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agli051_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ld_str   STRING   #160811-00039#7
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   #160811-00039#7--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glasld")
   LET p_wc2 = p_wc2," AND ",l_ld_str
   #160811-00039#7--add--end
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.glasstus,t0.glasld,t0.glas001,t0.glas002,t0.glas003,t0.glasld,t0.glas001, 
       t0.glas002,t0.glasownid,t0.glasowndp,t0.glascrtid,t0.glascrtdp,t0.glascrtdt,t0.glasmodid,t0.glasmoddt , 
       t1.glaal002 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM glas_t t0",
               "",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.glasld AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.glasownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.glasowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.glascrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.glascrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.glasmodid  ",
 
               " WHERE t0.glasent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("glas_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND glasowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("glas_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND glasownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("glas_t"),
                      " ORDER BY t0.glasld,t0.glas001,t0.glas002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glas_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE agli051_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR agli051_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glas_d.clear()
   CALL g_glas2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glas_d[l_ac].glasstus,g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001,g_glas_d[l_ac].glas002, 
       g_glas_d[l_ac].glas003,g_glas2_d[l_ac].glasld,g_glas2_d[l_ac].glas001,g_glas2_d[l_ac].glas002, 
       g_glas2_d[l_ac].glasownid,g_glas2_d[l_ac].glasowndp,g_glas2_d[l_ac].glascrtid,g_glas2_d[l_ac].glascrtdp, 
       g_glas2_d[l_ac].glascrtdt,g_glas2_d[l_ac].glasmodid,g_glas2_d[l_ac].glasmoddt,g_glas_d[l_ac].glasld_desc, 
       g_glas2_d[l_ac].glasownid_desc,g_glas2_d[l_ac].glasowndp_desc,g_glas2_d[l_ac].glascrtid_desc, 
       g_glas2_d[l_ac].glascrtdp_desc,g_glas2_d[l_ac].glasmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_desc_get_account_desc(g_glas_d[l_ac].glasld,g_glas_d[l_ac].glas001) RETURNING g_glas_d[l_ac].glas001_desc
      CALL agli051_glas003_desc()
      #end add-point
      
      CALL agli051_detail_show()      
 
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
   
 
   
   CALL g_glas_d.deleteElement(g_glas_d.getLength())   
   CALL g_glas2_d.deleteElement(g_glas2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_glas_d.getLength()
      LET g_glas2_d[l_ac].glasld = g_glas_d[l_ac].glasld 
      LET g_glas2_d[l_ac].glas001 = g_glas_d[l_ac].glas001 
      LET g_glas2_d[l_ac].glas002 = g_glas_d[l_ac].glas002 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_glas_d.getLength() THEN
      LET l_ac = g_glas_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glas_d.getLength()
      LET g_glas_d_mask_o[l_ac].* =  g_glas_d[l_ac].*
      CALL agli051_glas_t_mask()
      LET g_glas_d_mask_n[l_ac].* =  g_glas_d[l_ac].*
   END FOR
   
   LET g_glas2_d_mask_o.* =  g_glas2_d.*
   FOR l_ac = 1 TO g_glas2_d.getLength()
      LET g_glas2_d_mask_o[l_ac].* =  g_glas2_d[l_ac].*
      CALL agli051_glas_t_mask()
      LET g_glas2_d_mask_n[l_ac].* =  g_glas2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_glas_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE agli051_pb
   
END FUNCTION
 
{</section>}
 
{<section id="agli051.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION agli051_detail_show()
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
 
{<section id="agli051.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agli051_set_entry_b(p_cmd)                                                  
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
 
{<section id="agli051.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agli051_set_no_entry_b(p_cmd)                                               
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
 
{<section id="agli051.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agli051_default_search()
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
      LET ls_wc = ls_wc, " glasld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glas001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glas002 = '", g_argv[03], "' AND "
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
 
{<section id="agli051.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agli051_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "glas_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'glas_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM glas_t
          WHERE glasent = g_enterprise AND
            glasld = ps_keys_bak[1] AND glas001 = ps_keys_bak[2] AND glas002 = ps_keys_bak[3]
         
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
         CALL g_glas_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_glas2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli051.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agli051_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "glas_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO glas_t
                  (glasent,
                   glasld,glas001,glas002
                   ,glasstus,glas003,glasownid,glasowndp,glascrtid,glascrtdp,glascrtdt,glasmodid,glasmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_glas_d[l_ac].glasstus,g_glas_d[l_ac].glas003,g_glas2_d[l_ac].glasownid,g_glas2_d[l_ac].glasowndp, 
                       g_glas2_d[l_ac].glascrtid,g_glas2_d[l_ac].glascrtdp,g_glas2_d[l_ac].glascrtdt, 
                       g_glas2_d[l_ac].glasmodid,g_glas2_d[l_ac].glasmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glas_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="agli051.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agli051_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "glas_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "glas_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE glas_t 
         SET (glasld,glas001,glas002
              ,glasstus,glas003,glasownid,glasowndp,glascrtid,glascrtdp,glascrtdt,glasmodid,glasmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_glas_d[l_ac].glasstus,g_glas_d[l_ac].glas003,g_glas2_d[l_ac].glasownid,g_glas2_d[l_ac].glasowndp, 
                  g_glas2_d[l_ac].glascrtid,g_glas2_d[l_ac].glascrtdp,g_glas2_d[l_ac].glascrtdt,g_glas2_d[l_ac].glasmodid, 
                  g_glas2_d[l_ac].glasmoddt) 
         WHERE glasent = g_enterprise AND glasld = ps_keys_bak[1] AND glas001 = ps_keys_bak[2] AND glas002 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glas_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glas_t:",SQLERRMESSAGE 
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
 
{<section id="agli051.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agli051_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL agli051_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "glas_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agli051_bcl USING g_enterprise,
                                       g_glas_d[g_detail_idx].glasld,g_glas_d[g_detail_idx].glas001, 
                                           g_glas_d[g_detail_idx].glas002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agli051_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agli051.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agli051_unlock_b(ps_table)
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
      CLOSE agli051_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agli051.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION agli051_modify_detail_chk(ps_record)
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
         LET ls_return = "glasstus"
      WHEN "s_detail2"
         LET ls_return = "glasld_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="agli051.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION agli051_show_ownid_msg()
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
 
{<section id="agli051.mask_functions" >}
&include "erp/agl/agli051_mask.4gl"
 
{</section>}
 
{<section id="agli051.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agli051_set_pk_array()
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
   LET g_pk_array[1].values = g_glas_d[l_ac].glasld
   LET g_pk_array[1].column = 'glasld'
   LET g_pk_array[2].values = g_glas_d[l_ac].glas001
   LET g_pk_array[2].column = 'glas001'
   LET g_pk_array[3].values = g_glas_d[l_ac].glas002
   LET g_pk_array[3].column = 'glas002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli051.state_change" >}
   
 
{</section>}
 
{<section id="agli051.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="agli051.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取說明
# Memo...........:
# Usage..........: CALL agli051_glas003_desc()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/02/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli051_glas003_desc()
   DEFINE l_glad0171      LIKE glad_t.glad0171
   DEFINE l_glad0181      LIKE glad_t.glad0181
   DEFINE l_glad0191      LIKE glad_t.glad0191
   DEFINE l_glad0201      LIKE glad_t.glad0201
   DEFINE l_glad0211      LIKE glad_t.glad0211
   DEFINE l_glad0221      LIKE glad_t.glad0221
   DEFINE l_glad0231      LIKE glad_t.glad0231
   DEFINE l_glad0241      LIKE glad_t.glad0241
   DEFINE l_glad0251      LIKE glad_t.glad0251
   DEFINE l_glad0261      LIKE glad_t.glad0261
   
   IF l_ac<0 THEN
      RETURN
   END IF
   IF g_glas_d[l_ac].glas002 = '15' OR g_glas_d[l_ac].glas002 = '16' OR g_glas_d[l_ac].glas002 = '17' OR
      g_glas_d[l_ac].glas002 = '18' OR g_glas_d[l_ac].glas002 = '19' OR g_glas_d[l_ac].glas002 = '20' OR
      g_glas_d[l_ac].glas002 = '21' OR g_glas_d[l_ac].glas002 = '22' OR g_glas_d[l_ac].glas002 = '23' OR
      g_glas_d[l_ac].glas002 = '24' THEN
      SELECT glad0171,glad0181,glad0191,glad0201,glad0211,
             glad0221,glad0231,glad0241,glad0251,glad0261
        INTO l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,
             l_glad0221,l_glad0231,l_glad0241,l_glad0251,l_glad0261
        FROM glad_t
       WHERE gladent=g_enterprise AND gladld=g_glas_d[l_ac].glasld AND glad001=g_glas_d[l_ac].glas001
   END IF 
   #抓取說明
   CASE g_glas_d[l_ac].glas002
      WHEN '1' #營運據點
         CALL s_desc_get_department_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '2' #部門
         CALL s_desc_get_department_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '3' #成本/利潤中心
         CALL s_desc_get_department_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '4' #區域
         CALL s_desc_get_acc_desc('287',g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '5' #交易客商  
         CALL s_desc_get_trading_partner_abbr_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '6' #帳款客商  
         CALL s_desc_get_trading_partner_abbr_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '7' #客群
         CALL s_desc_get_acc_desc('281',g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '8' #產品類別        
         CALL s_desc_get_rtaxl003_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '9' #經營方式      
         CALL s_desc_gzcbl004_desc('6013',g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '10' #渠道
         CALL s_desc_get_oojdl003_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '11' #品牌
         CALL s_desc_get_acc_desc('2002',g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '12' #人員
         CALL s_desc_get_person_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '13' #專案
         CALL s_desc_get_project_desc(g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '14' #WBS
         CALL s_desc_get_wbs_desc('',g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '15' #自由核算項
         CALL s_voucher_free_account_desc(l_glad0171,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '16'
         CALL s_voucher_free_account_desc(l_glad0181,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '17'
         CALL s_voucher_free_account_desc(l_glad0191,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '18'
         CALL s_voucher_free_account_desc(l_glad0201,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '19'
         CALL s_voucher_free_account_desc(l_glad0211,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '20'
         CALL s_voucher_free_account_desc(l_glad0221,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '21'
         CALL s_voucher_free_account_desc(l_glad0231,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '22'
         CALL s_voucher_free_account_desc(l_glad0241,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '23'
         CALL s_voucher_free_account_desc(l_glad0251,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
      WHEN '24'
         CALL s_voucher_free_account_desc(l_glad0261,g_glas_d[l_ac].glas003) RETURNING g_glas_d[l_ac].glas003_desc
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 核算項值檢查
# Memo...........:
# Usage..........: CALL agli051_glas003_chk()
# Input parameter: 
# Return code....:
# Date & Author..: 2015/02/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli051_glas003_chk()
   DEFINE l_glad0171      LIKE glad_t.glad0171
   DEFINE l_glad0181      LIKE glad_t.glad0181
   DEFINE l_glad0191      LIKE glad_t.glad0191
   DEFINE l_glad0201      LIKE glad_t.glad0201
   DEFINE l_glad0211      LIKE glad_t.glad0211
   DEFINE l_glad0221      LIKE glad_t.glad0221
   DEFINE l_glad0231      LIKE glad_t.glad0231
   DEFINE l_glad0241      LIKE glad_t.glad0241
   DEFINE l_glad0251      LIKE glad_t.glad0251
   DEFINE l_glad0261      LIKE glad_t.glad0261
   DEFINE l_glad0172      LIKE glad_t.glad0172
   DEFINE l_glad0182      LIKE glad_t.glad0182
   DEFINE l_glad0192      LIKE glad_t.glad0192
   DEFINE l_glad0202      LIKE glad_t.glad0202
   DEFINE l_glad0212      LIKE glad_t.glad0212
   DEFINE l_glad0222      LIKE glad_t.glad0222
   DEFINE l_glad0232      LIKE glad_t.glad0232
   DEFINE l_glad0242      LIKE glad_t.glad0242
   DEFINE l_glad0252      LIKE glad_t.glad0252
   DEFINE l_glad0262      LIKE glad_t.glad0262
   DEFINE l_success       LIKE type_t.num5
   
   IF l_ac<0 THEN
      RETURN
   END IF
   LET l_success = TRUE
   LET g_errno = ''
   IF g_glas_d[l_ac].glas002 = '15' OR g_glas_d[l_ac].glas002 = '16' OR g_glas_d[l_ac].glas002 = '17' OR
      g_glas_d[l_ac].glas002 = '18' OR g_glas_d[l_ac].glas002 = '19' OR g_glas_d[l_ac].glas002 = '20' OR
      g_glas_d[l_ac].glas002 = '21' OR g_glas_d[l_ac].glas002 = '22' OR g_glas_d[l_ac].glas002 = '23' OR
      g_glas_d[l_ac].glas002 = '24' THEN
      SELECT glad0171,glad0172,glad0181,glad0182,glad0191,glad0192,glad0201,glad0202,glad0211,glad0212,
             glad0221,glad0222,glad0231,glad0232,glad0241,glad0242,glad0251,glad0252,glad0261,glad0262
        INTO l_glad0171,l_glad0172,l_glad0181,l_glad0182,l_glad0191,l_glad0192,l_glad0201,l_glad0202,l_glad0211,l_glad0212,
             l_glad0221,l_glad0222,l_glad0231,l_glad0232,l_glad0241,l_glad0242,l_glad0251,l_glad0252,l_glad0261,l_glad0262
        FROM glad_t
       WHERE gladent=g_enterprise AND gladld=g_glas_d[l_ac].glasld AND glad001=g_glas_d[l_ac].glas001
   END IF 
   
   LET g_errparam.exeprog = '' #160321-00016#28 add
   
   CASE g_glas_d[l_ac].glas002
     WHEN '1' #營運據點
        CALL s_voucher_glaq017_chk(g_glas_d[l_ac].glas003) 
     WHEN '2' #部門
        CALL s_department_chk(g_glas_d[l_ac].glas003,g_today) RETURNING l_success 
     WHEN '3' #成本/利潤中心
        CALL s_voucher_glaq019_chk(g_glas_d[l_ac].glas003,g_today)
     WHEN '4' #區域
        CALL s_azzi650_chk_exist('287',g_glas_d[l_ac].glas003) RETURNING l_success
     WHEN '5' #交易客商
        CALL s_voucher_glaq021_chk(g_glas_d[l_ac].glas003) 
     WHEN '6' #帳款客戶
        CALL s_voucher_glaq021_chk(g_glas_d[l_ac].glas003) 
     WHEN '7' #客群
        CALL s_azzi650_chk_exist('281',g_glas_d[l_ac].glas003) RETURNING l_success 
     WHEN '8' #產品類別
        CALL s_voucher_glaq024_chk(g_glas_d[l_ac].glas003)
     WHEN '9' #經營方式
        CALL s_voucher_glaq051_chk(g_glas_d[l_ac].glas003) 
     WHEN '10' #渠道
        CALL s_voucher_glaq052_chk(g_glas_d[l_ac].glas003)
     WHEN '11' #品牌
        CALL s_azzi650_chk_exist('2002',g_glas_d[l_ac].glas003) RETURNING l_success
     WHEN '12' #人員
        CALL s_employee_chk(g_glas_d[l_ac].glas003) RETURNING l_success
     WHEN '13' #專案
        CALL s_aap_project_chk(g_glas_d[l_ac].glas003) RETURNING l_success,g_errno
        IF NOT cl_null(g_errno) THEN LET g_errparam.exeprog = 'apjm200'  END IF   #160321-00016#28 add
     WHEN '14' #WBS
        #CALL s_voucher_glaq028_chk(g_glaq_m.glaq027,g_glas_d[l_ac].glas003)
     WHEN '15' #自由核算項
        CALL s_voucher_free_account_chk(l_glad0171,g_glas_d[l_ac].glas003,l_glad0172) RETURNING g_errno
     WHEN '16'
        CALL s_voucher_free_account_chk(l_glad0181,g_glas_d[l_ac].glas003,l_glad0182) RETURNING g_errno
     WHEN '17'
        CALL s_voucher_free_account_chk(l_glad0191,g_glas_d[l_ac].glas003,l_glad0192) RETURNING g_errno
     WHEN '18'
        CALL s_voucher_free_account_chk(l_glad0201,g_glas_d[l_ac].glas003,l_glad0202) RETURNING g_errno
     WHEN '19'
        CALL s_voucher_free_account_chk(l_glad0211,g_glas_d[l_ac].glas003,l_glad0212) RETURNING g_errno
     WHEN '20'
        CALL s_voucher_free_account_chk(l_glad0221,g_glas_d[l_ac].glas003,l_glad0222) RETURNING g_errno
     WHEN '21'
        CALL s_voucher_free_account_chk(l_glad0231,g_glas_d[l_ac].glas003,l_glad0232) RETURNING g_errno
     WHEN '22'
        CALL s_voucher_free_account_chk(l_glad0241,g_glas_d[l_ac].glas003,l_glad0242) RETURNING g_errno
     WHEN '23'
        CALL s_voucher_free_account_chk(l_glad0251,g_glas_d[l_ac].glas003,l_glad0252) RETURNING g_errno
     WHEN '24'
        CALL s_voucher_free_account_chk(l_glad0261,g_glas_d[l_ac].glas003,l_glad0262) RETURNING g_errno
   END CASE
   RETURN l_success
END FUNCTION

################################################################################
# Descriptions...: 當為自由核算項時開窗預設
# Memo...........:
# Usage..........: CALL agli051_glas003_def()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/02/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli051_glas003_def()
   DEFINE l_glad0171      LIKE glad_t.glad0171
   DEFINE l_glad0181      LIKE glad_t.glad0181
   DEFINE l_glad0191      LIKE glad_t.glad0191
   DEFINE l_glad0201      LIKE glad_t.glad0201
   DEFINE l_glad0211      LIKE glad_t.glad0211
   DEFINE l_glad0221      LIKE glad_t.glad0221
   DEFINE l_glad0231      LIKE glad_t.glad0231
   DEFINE l_glad0241      LIKE glad_t.glad0241
   DEFINE l_glad0251      LIKE glad_t.glad0251
   DEFINE l_glad0261      LIKE glad_t.glad0261
   DEFINE l_glae002       LIKE glae_t.glae002
   DEFINE l_glae009       LIKE glae_t.glae009
   DEFINE r_where         LIKE type_t.chr100
   
   LET l_glae002 = ''
   LET l_glae009 = ''
   LET r_where = " 1=1"
   IF g_glas_d[l_ac].glas002 = '15' OR g_glas_d[l_ac].glas002 = '16' OR g_glas_d[l_ac].glas002 = '17' OR
      g_glas_d[l_ac].glas002 = '18' OR g_glas_d[l_ac].glas002 = '19' OR g_glas_d[l_ac].glas002 = '20' OR
      g_glas_d[l_ac].glas002 = '21' OR g_glas_d[l_ac].glas002 = '22' OR g_glas_d[l_ac].glas002 = '23' OR
      g_glas_d[l_ac].glas002 = '24' THEN
      SELECT glad0171,glad0181,glad0191,glad0201,glad0211,
             glad0221,glad0231,glad0241,glad0251,glad0261
        INTO l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,
             l_glad0221,l_glad0231,l_glad0241,l_glad0251,l_glad0261
        FROM glad_t
       WHERE gladent=g_enterprise AND gladld=g_glas_d[l_ac].glasld AND glad001=g_glas_d[l_ac].glas001
      
      #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
      CASE
         WHEN '15' #自由核算項一
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0171
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0171
            END IF
            LET r_where = "glaf001 = '",l_glad0171,"'" #自由核算項類型            
         WHEN '16' #自由核算項二
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0181
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0181
            END IF 
            LET r_where = "glaf001 = '",l_glad0181,"'" #自由核算項類型 
         WHEN '17' #自由核算項三
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0191
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0191
            END IF 
            LET r_where = "glaf001 = '",l_glad0191,"'" #自由核算項類型 
         WHEN '18' #自由核算項四
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0201
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0201
            END IF 
            LET r_where = "glaf001 = '",l_glad0201,"'" #自由核算項類型 
         WHEN '19' #自由核算項五
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0211
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0211
            END IF 
            LET r_where = "glaf001 = '",l_glad0211,"'" #自由核算項類型 
         WHEN '20' #自由核算項六
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0221
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0221
            END IF 
            LET r_where = "glaf001 = '",l_glad0221,"'" #自由核算項類型 
         WHEN '21' #自由核算項七
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0231
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0231
            END IF 
            LET r_where = "glaf001 = '",l_glad0231,"'" #自由核算項類型             
         WHEN '22' #自由核算項八
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0241
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0241
            END IF 
            LET r_where = "glaf001 = '",l_glad0241,"'" #自由核算項類型 
         WHEN '23' #自由核算項九
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0251
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0251
            END IF 
            LET r_where = "glaf001 = '",l_glad0251,"'" #自由核算項類型 
         WHEN '26' #自由核算項十
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad0261
            IF l_glae002 = '1' THEN
               SELECT glae009 INTO l_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = l_glad0261
            END IF 
            LET r_where = "glaf001 = '",l_glad0261,"'" #自由核算項類型 
      END CASE 
      IF l_glae002 = '2' THEN
         LET l_glae009 = 'q_glaf002'
      END IF 
      
      IF l_glae002 = '3' THEN
         LET l_glae009 = ''
      END IF
   END IF
   RETURN l_glae009,r_where
END FUNCTION

 
{</section>}
 
