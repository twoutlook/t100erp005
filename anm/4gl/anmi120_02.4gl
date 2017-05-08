#該程式未解開Section, 採用最新樣板產出!
{<section id="anmi120_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-03-15 15:25:52), PR版次:0005(2016-11-29 14:35:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: anmi120_02
#+ Description: 部門設限
#+ Creator....: 02599(2016-03-15 10:26:13)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="anmi120_02.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#47 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160905-00007#7  2016/09/05 By 01727   调整系统中无ENT的SQL条件增加ent
#160326-00001#18 2016/09/28 By 02114   人员与部门的权限里面可以录入ALL，即表示不管控帐户权限，
#                                      anmi120的子作业和取权限SUB加判断，只要出现这个ALL,权限全部放开
#161128-00061#1  2016/11/29 by 02481  标准程式定义采用宣告模式,弃用.*写法

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
PRIVATE TYPE type_g_nmlm_d RECORD
       nmlm001 LIKE nmlm_t.nmlm001, 
   nmas003 LIKE type_t.chr500, 
   nmas003_desc LIKE type_t.chr500, 
   nmlm002 LIKE nmlm_t.nmlm002, 
   nmlm002_desc LIKE type_t.chr500, 
   nmlmcomp LIKE nmlm_t.nmlmcomp, 
   nmlmsite LIKE nmlm_t.nmlmsite, 
   nmlmownid LIKE nmlm_t.nmlmownid, 
   nmlmownid_desc LIKE type_t.chr500, 
   nmlmowndp LIKE nmlm_t.nmlmowndp, 
   nmlmowndp_desc LIKE type_t.chr500, 
   nmlmcrtid LIKE nmlm_t.nmlmcrtid, 
   nmlmcrtid_desc LIKE type_t.chr500, 
   nmlmcrtdp LIKE nmlm_t.nmlmcrtdp, 
   nmlmcrtdp_desc LIKE type_t.chr500, 
   nmlmcrtdt DATETIME YEAR TO SECOND, 
   nmlmmodid LIKE nmlm_t.nmlmmodid, 
   nmlmmodid_desc LIKE type_t.chr500, 
   nmlmmoddt DATETIME YEAR TO SECOND, 
   nmlmstus LIKE nmlm_t.nmlmstus
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_nmas002         LIKE nmas_t.nmas002
DEFINE g_nmaa002         LIKE nmaa_t.nmaa002
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmlm_d          DYNAMIC ARRAY OF type_g_nmlm_d #單身變數
DEFINE g_nmlm_d_t        type_g_nmlm_d                  #單身備份
DEFINE g_nmlm_d_o        type_g_nmlm_d                  #單身備份
DEFINE g_nmlm_d_mask_o   DYNAMIC ARRAY OF type_g_nmlm_d #單身變數
DEFINE g_nmlm_d_mask_n   DYNAMIC ARRAY OF type_g_nmlm_d #單身變數
 
      
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
 
{<section id="anmi120_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION anmi120_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_nmas002,p_nmaa002
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_nmas002             LIKE nmas_t.nmas002
   DEFINE p_nmaa002             LIKE nmaa_t.nmaa002
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_nmas002 = p_nmas002
   LET g_nmaa002 = p_nmaa002
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmlm001,nmlm002,nmlmcomp,nmlmsite,nmlmownid,nmlmowndp,nmlmcrtid,nmlmcrtdp, 
       nmlmcrtdt,nmlmmodid,nmlmmoddt,nmlmstus FROM nmlm_t WHERE nmlment=? AND nmlm001=? AND nmlm002=?  
       FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmi120_02_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmi120_02 WITH FORM cl_ap_formpath("anm","anmi120_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL anmi120_02_init()   
 
   #進入選單 Menu (="N")
   CALL anmi120_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_anmi120_02
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi120_02.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmi120_02_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #若交易账户编号没有部门资料，询问是否自动产生
   CALL anmi120_02_ins_nmlm()
   #end add-point
   
   CALL anmi120_02_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmi120_02_ui_dialog()
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
         CALL g_nmlm_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL anmi120_02_init()
      END IF
   
      CALL anmi120_02_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmlm_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_nmlm_d[g_detail_idx].nmlmownid   #(ver:35)
               LET g_data_dept = g_nmlm_d[g_detail_idx].nmlmowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL anmi120_02_set_pk_array()
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
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL anmi120_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmi120_02_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL anmi120_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmi120_02_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL anmi120_02_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL anmi120_02_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmi120_02_insert()
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
               CALL anmi120_02_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmlm_d)
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
            CALL anmi120_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmi120_02_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmi120_02_set_pk_array()
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
 
{<section id="anmi120_02.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmi120_02_query()
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
   CALL g_nmlm_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON nmlm001,nmas003,nmlm002,nmlmcomp,nmlmsite,nmlmownid,nmlmowndp,nmlmcrtid,nmlmcrtdp, 
          nmlmcrtdt,nmlmmodid,nmlmmoddt,nmlmstus 
 
         FROM s_detail1[1].nmlm001,s_detail1[1].nmas003,s_detail1[1].nmlm002,s_detail1[1].nmlmcomp,s_detail1[1].nmlmsite, 
             s_detail1[1].nmlmownid,s_detail1[1].nmlmowndp,s_detail1[1].nmlmcrtid,s_detail1[1].nmlmcrtdp, 
             s_detail1[1].nmlmcrtdt,s_detail1[1].nmlmmodid,s_detail1[1].nmlmmoddt,s_detail1[1].nmlmstus  
 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmlmcrtdt>>----
         AFTER FIELD nmlmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmlmmoddt>>----
         AFTER FIELD nmlmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmlmcnfdt>>----
         
         #----<<nmlmpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlm001
            #add-point:BEFORE FIELD nmlm001 name="query.b.page1.nmlm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlm001
            
            #add-point:AFTER FIELD nmlm001 name="query.a.page1.nmlm001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmlm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlm001
            #add-point:ON ACTION controlp INFIELD nmlm001 name="query.c.page1.nmlm001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmas003
            #add-point:ON ACTION controlp INFIELD nmas003 name="construct.c.page1.nmas003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmas003  #顯示到畫面上
            NEXT FIELD nmas003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmas003
            #add-point:BEFORE FIELD nmas003 name="query.b.page1.nmas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmas003
            
            #add-point:AFTER FIELD nmas003 name="query.a.page1.nmas003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmlm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlm002
            #add-point:ON ACTION controlp INFIELD nmlm002 name="construct.c.page1.nmlm002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmlm002  #顯示到畫面上
            NEXT FIELD nmlm002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlm002
            #add-point:BEFORE FIELD nmlm002 name="query.b.page1.nmlm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlm002
            
            #add-point:AFTER FIELD nmlm002 name="query.a.page1.nmlm002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmcomp
            #add-point:BEFORE FIELD nmlmcomp name="query.b.page1.nmlmcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmcomp
            
            #add-point:AFTER FIELD nmlmcomp name="query.a.page1.nmlmcomp"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmlmcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmcomp
            #add-point:ON ACTION controlp INFIELD nmlmcomp name="query.c.page1.nmlmcomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmsite
            #add-point:BEFORE FIELD nmlmsite name="query.b.page1.nmlmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmsite
            
            #add-point:AFTER FIELD nmlmsite name="query.a.page1.nmlmsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmlmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmsite
            #add-point:ON ACTION controlp INFIELD nmlmsite name="query.c.page1.nmlmsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmlmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmownid
            #add-point:ON ACTION controlp INFIELD nmlmownid name="construct.c.page1.nmlmownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmlmownid  #顯示到畫面上
            NEXT FIELD nmlmownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmownid
            #add-point:BEFORE FIELD nmlmownid name="query.b.page1.nmlmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmownid
            
            #add-point:AFTER FIELD nmlmownid name="query.a.page1.nmlmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmlmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmowndp
            #add-point:ON ACTION controlp INFIELD nmlmowndp name="construct.c.page1.nmlmowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmlmowndp  #顯示到畫面上
            NEXT FIELD nmlmowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmowndp
            #add-point:BEFORE FIELD nmlmowndp name="query.b.page1.nmlmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmowndp
            
            #add-point:AFTER FIELD nmlmowndp name="query.a.page1.nmlmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmlmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmcrtid
            #add-point:ON ACTION controlp INFIELD nmlmcrtid name="construct.c.page1.nmlmcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmlmcrtid  #顯示到畫面上
            NEXT FIELD nmlmcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmcrtid
            #add-point:BEFORE FIELD nmlmcrtid name="query.b.page1.nmlmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmcrtid
            
            #add-point:AFTER FIELD nmlmcrtid name="query.a.page1.nmlmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmlmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmcrtdp
            #add-point:ON ACTION controlp INFIELD nmlmcrtdp name="construct.c.page1.nmlmcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmlmcrtdp  #顯示到畫面上
            NEXT FIELD nmlmcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmcrtdp
            #add-point:BEFORE FIELD nmlmcrtdp name="query.b.page1.nmlmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmcrtdp
            
            #add-point:AFTER FIELD nmlmcrtdp name="query.a.page1.nmlmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmcrtdt
            #add-point:BEFORE FIELD nmlmcrtdt name="query.b.page1.nmlmcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmlmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmmodid
            #add-point:ON ACTION controlp INFIELD nmlmmodid name="construct.c.page1.nmlmmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmlmmodid  #顯示到畫面上
            NEXT FIELD nmlmmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmmodid
            #add-point:BEFORE FIELD nmlmmodid name="query.b.page1.nmlmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmmodid
            
            #add-point:AFTER FIELD nmlmmodid name="query.a.page1.nmlmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmmoddt
            #add-point:BEFORE FIELD nmlmmoddt name="query.b.page1.nmlmmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmstus
            #add-point:BEFORE FIELD nmlmstus name="query.b.page1.nmlmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmstus
            
            #add-point:AFTER FIELD nmlmstus name="query.a.page1.nmlmstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.nmlmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmstus
            #add-point:ON ACTION controlp INFIELD nmlmstus name="query.c.page1.nmlmstus"
            
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
    
   CALL anmi120_02_b_fill(g_wc2)
   LET g_data_owner = g_nmlm_d[g_detail_idx].nmlmownid   #(ver:35)
   LET g_data_dept = g_nmlm_d[g_detail_idx].nmlmowndp   #(ver:35)
 
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
 
{<section id="anmi120_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmi120_02_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL anmi120_02_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmi120_02_modify()
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
   DEFINE  l_success              LIKE type_t.num5
   DEFINE  l_ld                   LIKE glaa_t.glaald
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
      INPUT ARRAY g_nmlm_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmlm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmi120_02_b_fill(g_wc2)
            LET g_detail_cnt = g_nmlm_d.getLength()
         
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
            DISPLAY g_nmlm_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_nmlm_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_nmlm_d[l_ac].nmlm001 IS NOT NULL
               AND g_nmlm_d[l_ac].nmlm002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmlm_d_t.* = g_nmlm_d[l_ac].*  #BACKUP
               LET g_nmlm_d_o.* = g_nmlm_d[l_ac].*  #BACKUP
               IF NOT anmi120_02_lock_b("nmlm_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmi120_02_bcl INTO g_nmlm_d[l_ac].nmlm001,g_nmlm_d[l_ac].nmlm002,g_nmlm_d[l_ac].nmlmcomp, 
                      g_nmlm_d[l_ac].nmlmsite,g_nmlm_d[l_ac].nmlmownid,g_nmlm_d[l_ac].nmlmowndp,g_nmlm_d[l_ac].nmlmcrtid, 
                      g_nmlm_d[l_ac].nmlmcrtdp,g_nmlm_d[l_ac].nmlmcrtdt,g_nmlm_d[l_ac].nmlmmodid,g_nmlm_d[l_ac].nmlmmoddt, 
                      g_nmlm_d[l_ac].nmlmstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmlm_d_t.nmlm001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmlm_d_mask_o[l_ac].* =  g_nmlm_d[l_ac].*
                  CALL anmi120_02_nmlm_t_mask()
                  LET g_nmlm_d_mask_n[l_ac].* =  g_nmlm_d[l_ac].*
                  
                  CALL anmi120_02_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL anmi120_02_set_entry_b(l_cmd)
            CALL anmi120_02_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'u' THEN
               CALL anmi120_02_nmlm001_ref() RETURNING g_nmlm_d[l_ac].nmas003,g_nmlm_d[l_ac].nmas003_desc
               CALL s_desc_get_department_desc(g_nmlm_d[l_ac].nmlm002) RETURNING g_nmlm_d[l_ac].nmlm002_desc
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
            INITIALIZE g_nmlm_d_t.* TO NULL
            INITIALIZE g_nmlm_d_o.* TO NULL
            INITIALIZE g_nmlm_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmlm_d[l_ac].nmlmownid = g_user
      LET g_nmlm_d[l_ac].nmlmowndp = g_dept
      LET g_nmlm_d[l_ac].nmlmcrtid = g_user
      LET g_nmlm_d[l_ac].nmlmcrtdp = g_dept 
      LET g_nmlm_d[l_ac].nmlmcrtdt = cl_get_current()
      LET g_nmlm_d[l_ac].nmlmmodid = g_user
      LET g_nmlm_d[l_ac].nmlmmoddt = cl_get_current()
      LET g_nmlm_d[l_ac].nmlmstus = ''
 
 
 
            #自定義預設值(單身1)
                  LET g_nmlm_d[l_ac].nmlmstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_nmlm_d[l_ac].nmlm001 = g_nmas002
            CALL anmi120_02_nmlm001_ref() RETURNING g_nmlm_d[l_ac].nmas003,g_nmlm_d[l_ac].nmas003_desc
            LET g_nmlm_d[l_ac].nmlmsite = g_nmaa002
            CALL s_fin_orga_get_comp_ld(g_nmlm_d[l_ac].nmlmsite) 
             RETURNING l_success,g_errno,g_nmlm_d[l_ac].nmlmcomp,l_ld
            #end add-point
            LET g_nmlm_d_t.* = g_nmlm_d[l_ac].*     #新輸入資料
            LET g_nmlm_d_o.* = g_nmlm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmlm_d[li_reproduce_target].* = g_nmlm_d[li_reproduce].*
 
               LET g_nmlm_d[g_nmlm_d.getLength()].nmlm001 = NULL
               LET g_nmlm_d[g_nmlm_d.getLength()].nmlm002 = NULL
 
            END IF
            
 
            CALL anmi120_02_set_entry_b(l_cmd)
            CALL anmi120_02_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM nmlm_t 
             WHERE nmlment = g_enterprise AND nmlm001 = g_nmlm_d[l_ac].nmlm001
                                       AND nmlm002 = g_nmlm_d[l_ac].nmlm002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmlm_d[g_detail_idx].nmlm001
               LET gs_keys[2] = g_nmlm_d[g_detail_idx].nmlm002
               CALL anmi120_02_insert_b('nmlm_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmlm_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmlm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmi120_02_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL s_transaction_end('Y','0')
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (nmlm001 = '", g_nmlm_d[l_ac].nmlm001, "' "
                                  ," AND nmlm002 = '", g_nmlm_d[l_ac].nmlm002, "' "
 
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
               
               DELETE FROM nmlm_t
                WHERE nmlment = g_enterprise AND 
                      nmlm001 = g_nmlm_d_t.nmlm001
                      AND nmlm002 = g_nmlm_d_t.nmlm002
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmlm_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL anmi120_02_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_nmlm_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE anmi120_02_bcl
               #add-point:單身關閉bcl name="input.body.close"
               CALL s_transaction_end('Y','0')
               #end add-point
               LET l_count = g_nmlm_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmlm_d_t.nmlm001
               LET gs_keys[2] = g_nmlm_d_t.nmlm002
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmi120_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL anmi120_02_delete_b('nmlm_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmlm_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlm001
            #add-point:BEFORE FIELD nmlm001 name="input.b.page1.nmlm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlm001
            
            #add-point:AFTER FIELD nmlm001 name="input.a.page1.nmlm001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_nmlm_d[g_detail_idx].nmlm001 IS NOT NULL AND g_nmlm_d[g_detail_idx].nmlm002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmlm_d[g_detail_idx].nmlm001 != g_nmlm_d_t.nmlm001 OR g_nmlm_d[g_detail_idx].nmlm002 != g_nmlm_d_t.nmlm002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmlm_t WHERE "||"nmlment = '" ||g_enterprise|| "' AND "||"nmlm001 = '"||g_nmlm_d[g_detail_idx].nmlm001 ||"' AND "|| "nmlm002 = '"||g_nmlm_d[g_detail_idx].nmlm002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmlm001
            #add-point:ON CHANGE nmlm001 name="input.g.page1.nmlm001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmas003
            
            #add-point:AFTER FIELD nmas003 name="input.a.page1.nmas003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmlm_d[l_ac].nmas003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmlm_d[l_ac].nmas003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmlm_d[l_ac].nmas003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmas003
            #add-point:BEFORE FIELD nmas003 name="input.b.page1.nmas003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmas003
            #add-point:ON CHANGE nmas003 name="input.g.page1.nmas003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlm002
            
            #add-point:AFTER FIELD nmlm002 name="input.a.page1.nmlm002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_nmlm_d[g_detail_idx].nmlm001 IS NOT NULL AND g_nmlm_d[g_detail_idx].nmlm002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmlm_d[g_detail_idx].nmlm001 != g_nmlm_d_t.nmlm001 OR g_nmlm_d[g_detail_idx].nmlm002 != g_nmlm_d_t.nmlm002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmlm_t WHERE "||"nmlment = '" ||g_enterprise|| "' AND "||"nmlm001 = '"||g_nmlm_d[g_detail_idx].nmlm001 ||"' AND "|| "nmlm002 = '"||g_nmlm_d[g_detail_idx].nmlm002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            IF NOT cl_null(g_nmlm_d[l_ac].nmlm002) AND g_nmlm_d[l_ac].nmlm002 <> 'ALL' THEN   #160326-00001#18 add AND g_nmll_d[l_ac].nmll002 <> 'ALL' lujh 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmlm_d[l_ac].nmlm002
               LET g_chkparam.arg2 = g_today
               #160318-00025#47  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#47  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmlm_d[l_ac].nmlm002=g_nmlm_d_t.nmlm002
                  CALL s_desc_get_department_desc(g_nmlm_d[l_ac].nmlm002) RETURNING g_nmlm_d[l_ac].nmlm002_desc
                  DISPLAY BY NAME g_nmlm_d[l_ac].nmlm002_desc
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmlm_d[l_ac].nmlm002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? ","") RETURNING g_rtn_fields
            LET g_nmlm_d[l_ac].nmlm002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmlm_d[l_ac].nmlm002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlm002
            #add-point:BEFORE FIELD nmlm002 name="input.b.page1.nmlm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmlm002
            #add-point:ON CHANGE nmlm002 name="input.g.page1.nmlm002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmcomp
            #add-point:BEFORE FIELD nmlmcomp name="input.b.page1.nmlmcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmcomp
            
            #add-point:AFTER FIELD nmlmcomp name="input.a.page1.nmlmcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmlmcomp
            #add-point:ON CHANGE nmlmcomp name="input.g.page1.nmlmcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmsite
            #add-point:BEFORE FIELD nmlmsite name="input.b.page1.nmlmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmsite
            
            #add-point:AFTER FIELD nmlmsite name="input.a.page1.nmlmsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmlmsite
            #add-point:ON CHANGE nmlmsite name="input.g.page1.nmlmsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmlmstus
            #add-point:BEFORE FIELD nmlmstus name="input.b.page1.nmlmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmlmstus
            
            #add-point:AFTER FIELD nmlmstus name="input.a.page1.nmlmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmlmstus
            #add-point:ON CHANGE nmlmstus name="input.g.page1.nmlmstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmlm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlm001
            #add-point:ON ACTION controlp INFIELD nmlm001 name="input.c.page1.nmlm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmas003
            #add-point:ON ACTION controlp INFIELD nmas003 name="input.c.page1.nmas003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmlm_d[l_ac].nmas003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_nmlm_d[l_ac].nmas003 = g_qryparam.return1              

            DISPLAY g_nmlm_d[l_ac].nmas003 TO nmas003              #

            NEXT FIELD nmas003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.nmlm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlm002
            #add-point:ON ACTION controlp INFIELD nmlm002 name="input.c.page1.nmlm002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmlm_d[l_ac].nmlm002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooeg001_9()                                #呼叫開窗
 
            LET g_nmlm_d[l_ac].nmlm002 = g_qryparam.return1              

            DISPLAY g_nmlm_d[l_ac].nmlm002 TO nmlm002              #
            CALL s_desc_get_department_desc(g_nmlm_d[l_ac].nmlm002) RETURNING g_nmlm_d[l_ac].nmlm002_desc
            DISPLAY BY NAME g_nmlm_d[l_ac].nmlm002_desc
            NEXT FIELD nmlm002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.nmlmcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmcomp
            #add-point:ON ACTION controlp INFIELD nmlmcomp name="input.c.page1.nmlmcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmlmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmsite
            #add-point:ON ACTION controlp INFIELD nmlmsite name="input.c.page1.nmlmsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmlmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmlmstus
            #add-point:ON ACTION controlp INFIELD nmlmstus name="input.c.page1.nmlmstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE anmi120_02_bcl
               LET INT_FLAG = 0
               LET g_nmlm_d[l_ac].* = g_nmlm_d_t.*
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
               LET g_errparam.extend = g_nmlm_d[l_ac].nmlm001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmlm_d[l_ac].* = g_nmlm_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_nmlm_d[l_ac].nmlmmodid = g_user 
LET g_nmlm_d[l_ac].nmlmmoddt = cl_get_current()
LET g_nmlm_d[l_ac].nmlmmodid_desc = cl_get_username(g_nmlm_d[l_ac].nmlmmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmi120_02_nmlm_t_mask_restore('restore_mask_o')
 
               UPDATE nmlm_t SET (nmlm001,nmlm002,nmlmcomp,nmlmsite,nmlmownid,nmlmowndp,nmlmcrtid,nmlmcrtdp, 
                   nmlmcrtdt,nmlmmodid,nmlmmoddt,nmlmstus) = (g_nmlm_d[l_ac].nmlm001,g_nmlm_d[l_ac].nmlm002, 
                   g_nmlm_d[l_ac].nmlmcomp,g_nmlm_d[l_ac].nmlmsite,g_nmlm_d[l_ac].nmlmownid,g_nmlm_d[l_ac].nmlmowndp, 
                   g_nmlm_d[l_ac].nmlmcrtid,g_nmlm_d[l_ac].nmlmcrtdp,g_nmlm_d[l_ac].nmlmcrtdt,g_nmlm_d[l_ac].nmlmmodid, 
                   g_nmlm_d[l_ac].nmlmmoddt,g_nmlm_d[l_ac].nmlmstus)
                WHERE nmlment = g_enterprise AND
                  nmlm001 = g_nmlm_d_t.nmlm001 #項次   
                  AND nmlm002 = g_nmlm_d_t.nmlm002  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmlm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmlm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmlm_d[g_detail_idx].nmlm001
               LET gs_keys_bak[1] = g_nmlm_d_t.nmlm001
               LET gs_keys[2] = g_nmlm_d[g_detail_idx].nmlm002
               LET gs_keys_bak[2] = g_nmlm_d_t.nmlm002
               CALL anmi120_02_update_b('nmlm_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_nmlm_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmlm_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmi120_02_nmlm_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL s_transaction_end('Y','0')
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL anmi120_02_unlock_b("nmlm_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmlm_d[l_ac].* = g_nmlm_d_t.*
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
               LET g_nmlm_d[li_reproduce_target].* = g_nmlm_d[li_reproduce].*
 
               LET g_nmlm_d[li_reproduce_target].nmlm001 = NULL
               LET g_nmlm_d[li_reproduce_target].nmlm002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmlm_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmlm_d.getLength()+1
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
               NEXT FIELD nmlm001
 
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
      IF INT_FLAG OR cl_null(g_nmlm_d[g_detail_idx].nmlm001) THEN
         CALL g_nmlm_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_nmlm_d[g_detail_idx].* = g_nmlm_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE anmi120_02_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmi120_02_delete()
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
   FOR li_idx = 1 TO g_nmlm_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT anmi120_02_lock_b("nmlm_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("nmlm_t","nmlmownid") THEN
            LET g_data_owner = g_nmlm_d[g_detail_idx].nmlmownid
            LET g_data_dept = g_nmlm_d[g_detail_idx].nmlmowndp
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
   
   FOR li_idx = 1 TO g_nmlm_d.getLength()
      IF g_nmlm_d[li_idx].nmlm001 IS NOT NULL
         AND g_nmlm_d[li_idx].nmlm002 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM nmlm_t
          WHERE nmlment = g_enterprise AND 
                nmlm001 = g_nmlm_d[li_idx].nmlm001
                AND nmlm002 = g_nmlm_d[li_idx].nmlm002
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmlm_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_nmlm_d_t.nmlm001
               LET gs_keys[2] = g_nmlm_d_t.nmlm002
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL anmi120_02_delete_b('nmlm_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmi120_02_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   CALL s_transaction_end('Y','0')
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL anmi120_02_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmi120_02_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.nmlm001,t0.nmlm002,t0.nmlmcomp,t0.nmlmsite,t0.nmlmownid,t0.nmlmowndp, 
       t0.nmlmcrtid,t0.nmlmcrtdp,t0.nmlmcrtdt,t0.nmlmmodid,t0.nmlmmoddt,t0.nmlmstus ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 FROM nmlm_t t0",
               "",
                              " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmlm002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.nmlmownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.nmlmowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.nmlmcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.nmlmcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmlmmodid  ",
 
               " WHERE t0.nmlment= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("nmlm_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND nmlmowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("nmlm_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND nmlmownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = g_sql CLIPPED," AND nmlm001 = '",g_nmas002,"'"
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("nmlm_t"),
                      " ORDER BY t0.nmlm001,t0.nmlm002"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmlm_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmi120_02_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmi120_02_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmlm_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_nmlm_d[l_ac].nmlm001,g_nmlm_d[l_ac].nmlm002,g_nmlm_d[l_ac].nmlmcomp,g_nmlm_d[l_ac].nmlmsite, 
       g_nmlm_d[l_ac].nmlmownid,g_nmlm_d[l_ac].nmlmowndp,g_nmlm_d[l_ac].nmlmcrtid,g_nmlm_d[l_ac].nmlmcrtdp, 
       g_nmlm_d[l_ac].nmlmcrtdt,g_nmlm_d[l_ac].nmlmmodid,g_nmlm_d[l_ac].nmlmmoddt,g_nmlm_d[l_ac].nmlmstus, 
       g_nmlm_d[l_ac].nmlm002_desc,g_nmlm_d[l_ac].nmlmownid_desc,g_nmlm_d[l_ac].nmlmowndp_desc,g_nmlm_d[l_ac].nmlmcrtid_desc, 
       g_nmlm_d[l_ac].nmlmcrtdp_desc,g_nmlm_d[l_ac].nmlmmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL anmi120_02_nmlm001_ref() RETURNING g_nmlm_d[l_ac].nmas003,g_nmlm_d[l_ac].nmas003_desc
      #end add-point
      
      CALL anmi120_02_detail_show()      
 
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
   
 
   
   CALL g_nmlm_d.deleteElement(g_nmlm_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_nmlm_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_nmlm_d.getLength() THEN
      LET l_ac = g_nmlm_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmlm_d.getLength()
      LET g_nmlm_d_mask_o[l_ac].* =  g_nmlm_d[l_ac].*
      CALL anmi120_02_nmlm_t_mask()
      LET g_nmlm_d_mask_n[l_ac].* =  g_nmlm_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_nmlm_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE anmi120_02_pb
   
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmi120_02_detail_show()
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
 
{<section id="anmi120_02.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmi120_02_set_entry_b(p_cmd)                                                  
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
 
{<section id="anmi120_02.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmi120_02_set_no_entry_b(p_cmd)                                               
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
 
{<section id="anmi120_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmi120_02_default_search()
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
      LET ls_wc = ls_wc, " nmlm001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmlm002 = '", g_argv[02], "' AND "
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
 
{<section id="anmi120_02.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmi120_02_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "nmlm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'nmlm_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM nmlm_t
          WHERE nmlment = g_enterprise AND
            nmlm001 = ps_keys_bak[1] AND nmlm002 = ps_keys_bak[2]
         
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
         CALL g_nmlm_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmi120_02_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "nmlm_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO nmlm_t
                  (nmlment,
                   nmlm001,nmlm002
                   ,nmlmcomp,nmlmsite,nmlmownid,nmlmowndp,nmlmcrtid,nmlmcrtdp,nmlmcrtdt,nmlmmodid,nmlmmoddt,nmlmstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_nmlm_d[l_ac].nmlmcomp,g_nmlm_d[l_ac].nmlmsite,g_nmlm_d[l_ac].nmlmownid,g_nmlm_d[l_ac].nmlmowndp, 
                       g_nmlm_d[l_ac].nmlmcrtid,g_nmlm_d[l_ac].nmlmcrtdp,g_nmlm_d[l_ac].nmlmcrtdt,g_nmlm_d[l_ac].nmlmmodid, 
                       g_nmlm_d[l_ac].nmlmmoddt,g_nmlm_d[l_ac].nmlmstus)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmlm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmi120_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "nmlm_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "nmlm_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE nmlm_t 
         SET (nmlm001,nmlm002
              ,nmlmcomp,nmlmsite,nmlmownid,nmlmowndp,nmlmcrtid,nmlmcrtdp,nmlmcrtdt,nmlmmodid,nmlmmoddt,nmlmstus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_nmlm_d[l_ac].nmlmcomp,g_nmlm_d[l_ac].nmlmsite,g_nmlm_d[l_ac].nmlmownid,g_nmlm_d[l_ac].nmlmowndp, 
                  g_nmlm_d[l_ac].nmlmcrtid,g_nmlm_d[l_ac].nmlmcrtdp,g_nmlm_d[l_ac].nmlmcrtdt,g_nmlm_d[l_ac].nmlmmodid, 
                  g_nmlm_d[l_ac].nmlmmoddt,g_nmlm_d[l_ac].nmlmstus) 
         WHERE nmlment = g_enterprise AND nmlm001 = ps_keys_bak[1] AND nmlm002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmlm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmlm_t:",SQLERRMESSAGE 
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
 
{<section id="anmi120_02.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmi120_02_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL anmi120_02_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "nmlm_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmi120_02_bcl USING g_enterprise,
                                       g_nmlm_d[g_detail_idx].nmlm001,g_nmlm_d[g_detail_idx].nmlm002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmi120_02_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmi120_02_unlock_b(ps_table)
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
      CLOSE anmi120_02_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION anmi120_02_modify_detail_chk(ps_record)
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
         LET ls_return = "nmlm001"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="anmi120_02.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION anmi120_02_show_ownid_msg()
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
 
{<section id="anmi120_02.mask_functions" >}
&include "erp/anm/anmi120_02_mask.4gl"
 
{</section>}
 
{<section id="anmi120_02.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmi120_02_set_pk_array()
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
   LET g_pk_array[1].values = g_nmlm_d[l_ac].nmlm001
   LET g_pk_array[1].column = 'nmlm001'
   LET g_pk_array[2].values = g_nmlm_d[l_ac].nmlm002
   LET g_pk_array[2].column = 'nmlm002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi120_02.state_change" >}
   
 
{</section>}
 
{<section id="anmi120_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmi120_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 交易帳戶欄位帶值
# Memo...........:
# Usage..........: CALL anmi120_02_nmlm001_ref()
#                  RETURNING r_nmas003,nmas003_desc
# Date & Author..: 2016/03/15 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION anmi120_02_nmlm001_ref()
   DEFINE r_nmas003         LIKE nmas_t.nmas003
   DEFINE r_nmas003_desc    LIKE ooail_t.ooail003

   SELECT nmas003 INTO r_nmas003 FROM nmas_t
    WHERE nmasent = g_enterprise AND nmas002 = g_nmlm_d[l_ac].nmlm001
   
   SELECT ooail003 INTO r_nmas003_desc FROM ooail_t
    WHERE ooailent = g_enterprise AND ooail001 = r_nmas003
      AND ooail002 = g_dlang
   
   RETURN r_nmas003,r_nmas003_desc
END FUNCTION

################################################################################
# Descriptions...: 交易帳戶未設定部門，提示是否將賬戶其他部門插入該筆交易賬戶
# Memo...........:
# Usage..........: CALL anmi120_02_ins_nmlm()
# Date & Author..: 2016/03/15 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION anmi120_02_ins_nmlm()
   DEFINE l_sql          STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   #161128-00061#1----modify------begin-----------
   #DEFINE l_nmlm         RECORD LIKE nmlm_t.*
   DEFINE l_nmlm RECORD  #銀行帳戶部門設限檔
       nmlment LIKE nmlm_t.nmlment, #企業編號
       nmlmownid LIKE nmlm_t.nmlmownid, #資料所有者
       nmlmowndp LIKE nmlm_t.nmlmowndp, #資料所屬部門
       nmlmcrtid LIKE nmlm_t.nmlmcrtid, #資料建立者
       nmlmcrtdp LIKE nmlm_t.nmlmcrtdp, #資料建立部門
       nmlmcrtdt LIKE nmlm_t.nmlmcrtdt, #資料創建日
       nmlmmodid LIKE nmlm_t.nmlmmodid, #資料修改者
       nmlmmoddt LIKE nmlm_t.nmlmmoddt, #最近修改日
       nmlmstus LIKE nmlm_t.nmlmstus, #狀態碼
       nmlmcomp LIKE nmlm_t.nmlmcomp, #法人
       nmlmsite LIKE nmlm_t.nmlmsite, #營運據點
       nmlm001 LIKE nmlm_t.nmlm001, #交易帳戶編號
       nmlm002 LIKE nmlm_t.nmlm002  #部門編號
       END RECORD

   #161128-00061#1----modify------end-----------
   DEFINE l_ld           LIKE glaa_t.glaald
   DEFINE l_nmas001      LIKE nmas_t.nmas001
   DEFINE l_flag         LIKE type_t.chr1

   #账户编码下的所有交易账户编号有设置权限，弹出提示框，询问是否自动新增
   #银行账户
   SELECT UNIQUE nmas001 INTO l_nmas001 FROM nmas_t
    WHERE nmasent = g_enterprise AND nmas002 = g_nmas002
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM nmlm_t
    WHERE nmlment = g_enterprise 
      AND nmlm001 IN(SELECT UNIQUE nmas002 FROM nmas_t WHERE nmasent = g_enterprise AND nmas001 = l_nmas001)
   IF l_n = 0 THEN 
      RETURN
   END IF
   
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM nmlm_t
    WHERE nmlment = g_enterprise AND nmlm001 = g_nmas002
    
   IF l_n = 0 THEN
      IF NOT cl_ask_confirm('anm-00573') THEN
         RETURN
      END IF
   ELSE
      RETURN
   END IF
    
   LET l_sql = " SELECT UNIQUE nmlm002 FROM nmlm_t,nmas_t ",
               "  WHERE nmlment = nmasent AND nmlm001 = nmas002 ",
               "    AND nmlment = ",g_enterprise," AND nmas001 = '",l_nmas001,"'"
   PREPARE nmlm002_ins_prep FROM l_sql
   DECLARE nmlm002_ins_curs CURSOR FOR nmlm002_ins_prep
   
   LET l_flag = 'N'    #记录是否有资料插入nmlm_t
   LET l_nmlm.nmlment = g_enterprise
   LET l_nmlm.nmlm001 = g_nmas002
   LET l_nmlm.nmlmsite = g_nmaa002
   #公用欄位新增給值
   LET l_nmlm.nmlmownid = g_user
   LET l_nmlm.nmlmowndp = g_dept
   LET l_nmlm.nmlmcrtid = g_user
   LET l_nmlm.nmlmcrtdp = g_dept
   LET l_nmlm.nmlmcrtdt = cl_get_current()
   LET l_nmlm.nmlmstus = 'Y'
   
   CALL s_fin_orga_get_comp_ld(l_nmlm.nmlmsite) 
    RETURNING l_success,g_errno,l_nmlm.nmlmcomp,l_ld
   
   LET l_success = TRUE
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   FOREACH nmlm002_ins_curs INTO l_nmlm.nmlm002
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH nmlm002_ins_curs:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_flag = 'Y'
      INSERT INTO nmlm_t(nmlment,nmlmsite,nmlmcomp,nmlm001,nmlm002,nmlmstus,
                         nmlmownid,nmlmowndp,nmlmcrtid,nmlmcrtdp,nmlmcrtdt) 
                  VALUES(l_nmlm.nmlment,l_nmlm.nmlmsite,l_nmlm.nmlmcomp,l_nmlm.nmlm001,l_nmlm.nmlm002,l_nmlm.nmlmstus,
                         l_nmlm.nmlmownid,l_nmlm.nmlmowndp,l_nmlm.nmlmcrtid,l_nmlm.nmlmcrtdp,l_nmlm.nmlmcrtdt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "ins nmlm_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
   END FOREACH
   
   IF l_flag = 'N' THEN  #没有插入资料
      LET l_success = FALSE
   END IF
   
   IF l_success = TRUE THEN
      CALL s_transaction_end('Y','1')
   ELSE
      CALL s_transaction_end('N','1')
   END IF
   CALL cl_err_collect_show()
               
END FUNCTION

 
{</section>}
 
