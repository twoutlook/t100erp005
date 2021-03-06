#該程式未解開Section, 採用最新樣板產出!
{<section id="amhi206.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-05-12 11:47:44), PR版次:0010(2016-11-24 15:08:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: amhi206
#+ Description: 場地基本資料維護作業
#+ Creator....: 06254(2015-11-16 13:41:58)
#+ Modifier...: 06814 -SD/PR- 02159
 
{</section>}
 
{<section id="amhi206.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161006-00008#2  2016/10/19 By 06814     修正aooi500相關邏輯
#161104-00002#2  2016/11/08 By sakura    變數定義與INSERT不用*
#161123-00042#2  2016/11/24 by sakura    星號寫法，補上自定義欄位
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
PRIVATE TYPE type_g_mhaa_d RECORD
       sel LIKE type_t.chr1, 
   mhaasite LIKE type_t.chr10, 
   mhaasite_desc LIKE type_t.chr500, 
   mhaaunit LIKE type_t.chr10, 
   mhaaunit_desc LIKE type_t.chr500, 
   mhaa001 LIKE type_t.chr10, 
   mhaal003 LIKE type_t.chr500, 
   mhaa005 LIKE type_t.num20_6, 
   mhaa006 LIKE type_t.num20_6, 
   mhaa002 LIKE type_t.num20_6, 
   mhaa003 LIKE type_t.num20_6, 
   mhaa004 LIKE type_t.num20_6, 
   mhab001 LIKE type_t.chr10, 
   mhab002 LIKE type_t.chr10, 
   mhabl004 LIKE type_t.chr500, 
   mhab006 LIKE type_t.num20_6, 
   mhab007 LIKE type_t.num20_6, 
   mhab008 LIKE type_t.num20_6, 
   mhab009 LIKE type_t.num20_6, 
   mhab003 LIKE type_t.num20_6, 
   mhab004 LIKE type_t.num20_6, 
   mhab005 LIKE type_t.num20_6, 
   mhac001 LIKE type_t.chr10, 
   mhac002 LIKE type_t.chr10, 
   mhac003 LIKE type_t.chr10, 
   mhacl005 LIKE type_t.chr500, 
   mhac004 LIKE type_t.num20_6, 
   mhac005 LIKE type_t.num20_6, 
   mhac006 LIKE type_t.num20_6, 
   mhad001 LIKE type_t.chr10, 
   mhad002 LIKE type_t.chr10, 
   mhad003 LIKE type_t.chr10, 
   mhad004 LIKE type_t.chr20, 
   mhadl006 LIKE type_t.chr500, 
   mhad010 LIKE type_t.chr10, 
   mhad010_desc LIKE type_t.chr500, 
   mhad005 LIKE type_t.num20_6, 
   mhad006 LIKE type_t.num20_6, 
   mhad007 LIKE type_t.num20_6, 
   mhad008 LIKE type_t.chr10, 
   mhadstus LIKE type_t.chr10
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      mhaal001 LIKE mhaal_t.mhaal001,
      mhaal002 LIKE mhaal_t.mhaal002,
      mhaal003 LIKE mhaal_t.mhaal003,
      mhabl001 LIKE mhabl_t.mhabl001,
      mhabl002 LIKE mhabl_t.mhabl002,
      mhabl003 LIKE mhabl_t.mhabl003,
      mhabl004 LIKE mhabl_t.mhabl004,
      mhacl001 LIKE mhacl_t.mhacl001,
      mhacl002 LIKE mhacl_t.mhacl002,
      mhacl003 LIKE mhacl_t.mhacl003,
      mhacl004 LIKE mhacl_t.mhacl004,
      mhacl005 LIKE mhacl_t.mhacl005,
      mhadl001 LIKE mhadl_t.mhadl001,
      mhadl002 LIKE mhadl_t.mhadl002,
      mhadl003 LIKE mhadl_t.mhadl003,
      mhadl004 LIKE mhadl_t.mhadl004,
      mhadl005 LIKE mhadl_t.mhadl005,
      mhadl006 LIKE mhadl_t.mhadl006
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_mhaa001         LIKE type_t.num5
DEFINE g_mhab002         LIKE type_t.num5
DEFINE g_mhac003         LIKE type_t.num5
DEFINE g_mhad004         LIKE type_t.num5
DEFINE g_cnt1            LIKE type_t.num5
DEFINE l_var_keys             DYNAMIC ARRAY OF STRING
DEFINE l_field_keys           DYNAMIC ARRAY OF STRING
DEFINE l_vars                 DYNAMIC ARRAY OF STRING
DEFINE l_fields               DYNAMIC ARRAY OF STRING
DEFINE l_var_keys_bak         DYNAMIC ARRAY OF STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_mhaa_d          DYNAMIC ARRAY OF type_g_mhaa_d #單身變數
DEFINE g_mhaa_d_t        type_g_mhaa_d                  #單身備份
DEFINE g_mhaa_d_o        type_g_mhaa_d                  #單身備份
DEFINE g_mhaa_d_mask_o   DYNAMIC ARRAY OF type_g_mhaa_d #單身變數
DEFINE g_mhaa_d_mask_n   DYNAMIC ARRAY OF type_g_mhaa_d #單身變數
 
      
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
 
{<section id="amhi206.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#2 20161019 add by beckxie
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amh","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mhaasite,mhaaunit,mhaa001,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004 FROM  
       mhaa_t WHERE mhaaent=? AND mhaasite=? AND mhaa001=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   LET g_forupd_sql = "SELECT mhadsite,'','','','','','','','','','', ",
                      "       '','','','','','','','','','',  ",
                      "       '','','','','','','',  ",
                      #"       mhad001,mhad002,mhad003,mhad004,'',mhad005,mhad006,mhad007,mhad008,mhadstus  ",        #160506-00009#28 20160512 mark by beckxie
                      "       mhad001,mhad002,mhad003,mhad004,'',mhad010,mhad005,mhad006,mhad007,mhad008,mhadstus  ", #160506-00009#28 20160512 add by beckxie
                      "  FROM mhad_t  ",
                      " WHERE mhadent=? AND mhadsite=? AND mhad001=? AND mhad002 = ? AND mhad003 =? AND mhad004 = ? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amhi206_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amhi206 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amhi206_init()   
 
      #進入選單 Menu (="N")
      CALL amhi206_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amhi206
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#2 20161019 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amhi206.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION amhi206_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#2 20161019 add by beckxie
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
 
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #160421-00013#3 160428 by sakura add(S)
   CALL s_asti800_set_comp_format("mhaa005",g_site,'2')
   CALL s_asti800_set_comp_format("mhaa006",g_site,'2')
   CALL s_asti800_set_comp_format("mhab006",g_site,'2')
   CALL s_asti800_set_comp_format("mhab007",g_site,'2')
   CALL s_asti800_set_comp_format("mhad005",g_site,'2')
   CALL s_asti800_set_comp_format("mhad006",g_site,'2')
   CALL s_asti800_set_comp_format("mhad007",g_site,'2')
   #160421-00013#3 160428 by sakura add(E)   
   CALL cl_set_comp_visible('mhaa002,mhaa003,mhaa004',FALSE)
   CALL cl_set_comp_visible('mhab003,mhab004,mhab005',FALSE)
   CALL cl_set_comp_visible('mhac004,mhac005,mhac006',FALSE)
   CALL cl_set_combo_scc('mhad008','6020') 
   CALL cl_set_act_visible("delete",FALSE)
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#2 20161019 add by beckxie
   #end add-point
   
   CALL amhi206_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="amhi206.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION amhi206_ui_dialog()
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
   DEFINE l_success   LIKE type_t.num5        #add by dengdd 15/11/11
   DEFINE l_time      DATETIME YEAR TO SECOND #add by dengdd 15/11/11
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
         CALL g_mhaa_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL amhi206_init()
      END IF
   
      CALL amhi206_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mhaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL amhi206_set_pk_array()
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
            CALL amhi206_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amhi206_modify()
            #add-point:ON ACTION modify name="menu.modify"
               CALL amhi206_modify_1()
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL amhi206_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amhi206_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL amhi206_modify_1()
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL amhi206_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amhi206_delete()
            #add-point:ON ACTION delete name="menu.delete"
               CALL amhi206_delete_mhad()
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amhi206_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL amhi206_modify_1()
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
               CALL amhi206_query()
               #add-point:ON ACTION query name="menu.query"
               CALL amhi206_query2()
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               LET l_time = cl_get_current()
               LET g_time = cl_replace_str(l_time,'-','')
               LET g_time = cl_replace_str(g_time,' ','')
               LET g_time = cl_replace_str(g_time,':','')
               
               LET g_etlparam[1].para_id = "g_docno"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_time
               #add by dengdd 151111(S)
               
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)

               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               
               CALL amhi206_check() RETURNING l_success
               IF l_success THEN                        
                  IF NOT amhi206_ins() THEN 
                     LET g_errparam.code = 'adz-00218'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     LET g_errparam.code = 'amh-00619'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_cnt1
                     CALL cl_err()
                  END IF
              
                  CALL amhi206_b_fill2("1=1")    
               END IF
            
            #写入水电费资料档完成，删除暂存表资料
            DELETE FROM mhaw_t WHERE mhawent = g_enterprise
                                 AND mhawsite= g_site
              
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "del_mhaw" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CONTINUE DIALOG
            END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pinvalid
            LET g_action_choice="pinvalid"
            IF cl_auth_chk_act("pinvalid") THEN
               
               #add-point:ON ACTION pinvalid name="menu.pinvalid"
               CALL amhi206_pinvalid()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pvalid
            LET g_action_choice="pvalid"
            IF cl_auth_chk_act("pvalid") THEN
               
               #add-point:ON ACTION pvalid name="menu.pvalid"
               CALL amhi206_pvalid()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN
               
               #add-point:ON ACTION excel_example name="menu.excel_example"
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_mhaa_d)
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
            CALL amhi206_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amhi206_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amhi206_set_pk_array()
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
 
{<section id="amhi206.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION amhi206_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   RETURN
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_mhaa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sel,mhaasite,mhaaunit,mhaa001,mhaal003,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004, 
          mhab001,mhab002,mhabl004,mhab006,mhab007,mhab008,mhab009,mhab003,mhab004,mhab005,mhac001,mhac002, 
          mhac003,mhacl005,mhac004,mhac005,mhac006,mhad001,mhad002,mhad003,mhad004,mhadl006,mhad010, 
          mhad005,mhad006,mhad007,mhad008,mhadstus 
 
         FROM s_detail1[1].sel,s_detail1[1].mhaasite,s_detail1[1].mhaaunit,s_detail1[1].mhaa001,s_detail1[1].mhaal003, 
             s_detail1[1].mhaa005,s_detail1[1].mhaa006,s_detail1[1].mhaa002,s_detail1[1].mhaa003,s_detail1[1].mhaa004, 
             s_detail1[1].mhab001,s_detail1[1].mhab002,s_detail1[1].mhabl004,s_detail1[1].mhab006,s_detail1[1].mhab007, 
             s_detail1[1].mhab008,s_detail1[1].mhab009,s_detail1[1].mhab003,s_detail1[1].mhab004,s_detail1[1].mhab005, 
             s_detail1[1].mhac001,s_detail1[1].mhac002,s_detail1[1].mhac003,s_detail1[1].mhacl005,s_detail1[1].mhac004, 
             s_detail1[1].mhac005,s_detail1[1].mhac006,s_detail1[1].mhad001,s_detail1[1].mhad002,s_detail1[1].mhad003, 
             s_detail1[1].mhad004,s_detail1[1].mhadl006,s_detail1[1].mhad010,s_detail1[1].mhad005,s_detail1[1].mhad006, 
             s_detail1[1].mhad007,s_detail1[1].mhad008,s_detail1[1].mhadstus 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="query.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="query.a.page1.sel"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="query.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaasite
            #add-point:ON ACTION controlp INFIELD mhaasite name="construct.c.page1.mhaasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaasite  #顯示到畫面上
            NEXT FIELD mhaasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaasite
            #add-point:BEFORE FIELD mhaasite name="query.b.page1.mhaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaasite
            
            #add-point:AFTER FIELD mhaasite name="query.a.page1.mhaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhaaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaaunit
            #add-point:ON ACTION controlp INFIELD mhaaunit name="construct.c.page1.mhaaunit"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaaunit  #顯示到畫面上
            NEXT FIELD mhaaunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaaunit
            #add-point:BEFORE FIELD mhaaunit name="query.b.page1.mhaaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaaunit
            
            #add-point:AFTER FIELD mhaaunit name="query.a.page1.mhaaunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa001
            #add-point:ON ACTION controlp INFIELD mhaa001 name="construct.c.page1.mhaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaa001  #顯示到畫面上
            NEXT FIELD mhaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa001
            #add-point:BEFORE FIELD mhaa001 name="query.b.page1.mhaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa001
            
            #add-point:AFTER FIELD mhaa001 name="query.a.page1.mhaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaal003
            #add-point:BEFORE FIELD mhaal003 name="query.b.page1.mhaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaal003
            
            #add-point:AFTER FIELD mhaal003 name="query.a.page1.mhaal003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaal003
            #add-point:ON ACTION controlp INFIELD mhaal003 name="query.c.page1.mhaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa005
            #add-point:BEFORE FIELD mhaa005 name="query.b.page1.mhaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa005
            
            #add-point:AFTER FIELD mhaa005 name="query.a.page1.mhaa005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa005
            #add-point:ON ACTION controlp INFIELD mhaa005 name="query.c.page1.mhaa005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa006
            #add-point:BEFORE FIELD mhaa006 name="query.b.page1.mhaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa006
            
            #add-point:AFTER FIELD mhaa006 name="query.a.page1.mhaa006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa006
            #add-point:ON ACTION controlp INFIELD mhaa006 name="query.c.page1.mhaa006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa002
            #add-point:BEFORE FIELD mhaa002 name="query.b.page1.mhaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa002
            
            #add-point:AFTER FIELD mhaa002 name="query.a.page1.mhaa002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa002
            #add-point:ON ACTION controlp INFIELD mhaa002 name="query.c.page1.mhaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa003
            #add-point:BEFORE FIELD mhaa003 name="query.b.page1.mhaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa003
            
            #add-point:AFTER FIELD mhaa003 name="query.a.page1.mhaa003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa003
            #add-point:ON ACTION controlp INFIELD mhaa003 name="query.c.page1.mhaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa004
            #add-point:BEFORE FIELD mhaa004 name="query.b.page1.mhaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa004
            
            #add-point:AFTER FIELD mhaa004 name="query.a.page1.mhaa004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa004
            #add-point:ON ACTION controlp INFIELD mhaa004 name="query.c.page1.mhaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab001
            #add-point:ON ACTION controlp INFIELD mhab001 name="construct.c.page1.mhab001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhab001  #顯示到畫面上
            NEXT FIELD mhab001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab001
            #add-point:BEFORE FIELD mhab001 name="query.b.page1.mhab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab001
            
            #add-point:AFTER FIELD mhab001 name="query.a.page1.mhab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab002
            #add-point:ON ACTION controlp INFIELD mhab002 name="construct.c.page1.mhab002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhab002  #顯示到畫面上
            NEXT FIELD mhab002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab002
            #add-point:BEFORE FIELD mhab002 name="query.b.page1.mhab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab002
            
            #add-point:AFTER FIELD mhab002 name="query.a.page1.mhab002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhabl004
            #add-point:BEFORE FIELD mhabl004 name="query.b.page1.mhabl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhabl004
            
            #add-point:AFTER FIELD mhabl004 name="query.a.page1.mhabl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhabl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhabl004
            #add-point:ON ACTION controlp INFIELD mhabl004 name="query.c.page1.mhabl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab006
            #add-point:BEFORE FIELD mhab006 name="query.b.page1.mhab006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab006
            
            #add-point:AFTER FIELD mhab006 name="query.a.page1.mhab006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab006
            #add-point:ON ACTION controlp INFIELD mhab006 name="query.c.page1.mhab006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab007
            #add-point:BEFORE FIELD mhab007 name="query.b.page1.mhab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab007
            
            #add-point:AFTER FIELD mhab007 name="query.a.page1.mhab007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab007
            #add-point:ON ACTION controlp INFIELD mhab007 name="query.c.page1.mhab007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab008
            #add-point:BEFORE FIELD mhab008 name="query.b.page1.mhab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab008
            
            #add-point:AFTER FIELD mhab008 name="query.a.page1.mhab008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab008
            #add-point:ON ACTION controlp INFIELD mhab008 name="query.c.page1.mhab008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab009
            #add-point:BEFORE FIELD mhab009 name="query.b.page1.mhab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab009
            
            #add-point:AFTER FIELD mhab009 name="query.a.page1.mhab009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab009
            #add-point:ON ACTION controlp INFIELD mhab009 name="query.c.page1.mhab009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab003
            #add-point:BEFORE FIELD mhab003 name="query.b.page1.mhab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab003
            
            #add-point:AFTER FIELD mhab003 name="query.a.page1.mhab003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab003
            #add-point:ON ACTION controlp INFIELD mhab003 name="query.c.page1.mhab003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab004
            #add-point:BEFORE FIELD mhab004 name="query.b.page1.mhab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab004
            
            #add-point:AFTER FIELD mhab004 name="query.a.page1.mhab004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab004
            #add-point:ON ACTION controlp INFIELD mhab004 name="query.c.page1.mhab004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab005
            #add-point:BEFORE FIELD mhab005 name="query.b.page1.mhab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab005
            
            #add-point:AFTER FIELD mhab005 name="query.a.page1.mhab005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab005
            #add-point:ON ACTION controlp INFIELD mhab005 name="query.c.page1.mhab005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac001
            #add-point:ON ACTION controlp INFIELD mhac001 name="construct.c.page1.mhac001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhac001  #顯示到畫面上
            NEXT FIELD mhac001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac001
            #add-point:BEFORE FIELD mhac001 name="query.b.page1.mhac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac001
            
            #add-point:AFTER FIELD mhac001 name="query.a.page1.mhac001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac002
            #add-point:ON ACTION controlp INFIELD mhac002 name="construct.c.page1.mhac002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhac002  #顯示到畫面上
            NEXT FIELD mhac002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac002
            #add-point:BEFORE FIELD mhac002 name="query.b.page1.mhac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac002
            
            #add-point:AFTER FIELD mhac002 name="query.a.page1.mhac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac003
            #add-point:ON ACTION controlp INFIELD mhac003 name="construct.c.page1.mhac003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhac003  #顯示到畫面上
            NEXT FIELD mhac003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac003
            #add-point:BEFORE FIELD mhac003 name="query.b.page1.mhac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac003
            
            #add-point:AFTER FIELD mhac003 name="query.a.page1.mhac003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhacl005
            #add-point:BEFORE FIELD mhacl005 name="query.b.page1.mhacl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhacl005
            
            #add-point:AFTER FIELD mhacl005 name="query.a.page1.mhacl005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhacl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhacl005
            #add-point:ON ACTION controlp INFIELD mhacl005 name="query.c.page1.mhacl005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac004
            #add-point:BEFORE FIELD mhac004 name="query.b.page1.mhac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac004
            
            #add-point:AFTER FIELD mhac004 name="query.a.page1.mhac004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac004
            #add-point:ON ACTION controlp INFIELD mhac004 name="query.c.page1.mhac004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac005
            #add-point:BEFORE FIELD mhac005 name="query.b.page1.mhac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac005
            
            #add-point:AFTER FIELD mhac005 name="query.a.page1.mhac005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac005
            #add-point:ON ACTION controlp INFIELD mhac005 name="query.c.page1.mhac005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac006
            #add-point:BEFORE FIELD mhac006 name="query.b.page1.mhac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac006
            
            #add-point:AFTER FIELD mhac006 name="query.a.page1.mhac006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac006
            #add-point:ON ACTION controlp INFIELD mhac006 name="query.c.page1.mhac006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad001
            #add-point:ON ACTION controlp INFIELD mhad001 name="construct.c.page1.mhad001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad001  #顯示到畫面上
            NEXT FIELD mhad001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad001
            #add-point:BEFORE FIELD mhad001 name="query.b.page1.mhad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad001
            
            #add-point:AFTER FIELD mhad001 name="query.a.page1.mhad001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad002
            #add-point:ON ACTION controlp INFIELD mhad002 name="construct.c.page1.mhad002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad002  #顯示到畫面上
            NEXT FIELD mhad002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad002
            #add-point:BEFORE FIELD mhad002 name="query.b.page1.mhad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad002
            
            #add-point:AFTER FIELD mhad002 name="query.a.page1.mhad002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad003
            #add-point:ON ACTION controlp INFIELD mhad003 name="construct.c.page1.mhad003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad003  #顯示到畫面上
            NEXT FIELD mhad003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad003
            #add-point:BEFORE FIELD mhad003 name="query.b.page1.mhad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad003
            
            #add-point:AFTER FIELD mhad003 name="query.a.page1.mhad003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhad004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad004
            #add-point:ON ACTION controlp INFIELD mhad004 name="construct.c.page1.mhad004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad004  #顯示到畫面上
            NEXT FIELD mhad004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad004
            #add-point:BEFORE FIELD mhad004 name="query.b.page1.mhad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad004
            
            #add-point:AFTER FIELD mhad004 name="query.a.page1.mhad004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhadl006
            #add-point:BEFORE FIELD mhadl006 name="query.b.page1.mhadl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhadl006
            
            #add-point:AFTER FIELD mhadl006 name="query.a.page1.mhadl006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhadl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhadl006
            #add-point:ON ACTION controlp INFIELD mhadl006 name="query.c.page1.mhadl006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mhad010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad010
            #add-point:ON ACTION controlp INFIELD mhad010 name="construct.c.page1.mhad010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2145'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad010  #顯示到畫面上
            NEXT FIELD mhad010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad010
            #add-point:BEFORE FIELD mhad010 name="query.b.page1.mhad010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad010
            
            #add-point:AFTER FIELD mhad010 name="query.a.page1.mhad010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad005
            #add-point:BEFORE FIELD mhad005 name="query.b.page1.mhad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad005
            
            #add-point:AFTER FIELD mhad005 name="query.a.page1.mhad005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad005
            #add-point:ON ACTION controlp INFIELD mhad005 name="query.c.page1.mhad005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad006
            #add-point:BEFORE FIELD mhad006 name="query.b.page1.mhad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad006
            
            #add-point:AFTER FIELD mhad006 name="query.a.page1.mhad006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhad006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad006
            #add-point:ON ACTION controlp INFIELD mhad006 name="query.c.page1.mhad006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad007
            #add-point:BEFORE FIELD mhad007 name="query.b.page1.mhad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad007
            
            #add-point:AFTER FIELD mhad007 name="query.a.page1.mhad007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad007
            #add-point:ON ACTION controlp INFIELD mhad007 name="query.c.page1.mhad007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad008
            #add-point:BEFORE FIELD mhad008 name="query.b.page1.mhad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad008
            
            #add-point:AFTER FIELD mhad008 name="query.a.page1.mhad008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhad008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad008
            #add-point:ON ACTION controlp INFIELD mhad008 name="query.c.page1.mhad008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhadstus
            #add-point:BEFORE FIELD mhadstus name="query.b.page1.mhadstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhadstus
            
            #add-point:AFTER FIELD mhadstus name="query.a.page1.mhadstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhadstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhadstus
            #add-point:ON ACTION controlp INFIELD mhadstus name="query.c.page1.mhadstus"
            
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
    
   CALL amhi206_b_fill(g_wc2)
 
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
 
{<section id="amhi206.insert" >}
#+ 資料新增
PRIVATE FUNCTION amhi206_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL amhi206_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amhi206.modify" >}
#+ 資料修改
PRIVATE FUNCTION amhi206_modify()
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
   RETURN
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
      INPUT ARRAY g_mhaa_d FROM s_detail1.*
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
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amhi206_b_fill(g_wc2)
            LET g_detail_cnt = g_mhaa_d.getLength()
         
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
            DISPLAY g_mhaa_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mhaa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mhaa_d[l_ac].mhaasite IS NOT NULL
               AND g_mhaa_d[l_ac].mhaa001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhaa_d_t.* = g_mhaa_d[l_ac].*  #BACKUP
               LET g_mhaa_d_o.* = g_mhaa_d[l_ac].*  #BACKUP
               IF NOT amhi206_lock_b("mhaa_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amhi206_bcl INTO g_mhaa_d[l_ac].mhaasite,g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaa001, 
                      g_mhaa_d[l_ac].mhaa005,g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaa002,g_mhaa_d[l_ac].mhaa003, 
                      g_mhaa_d[l_ac].mhaa004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhaa_d_t.mhaasite,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhaa_d_mask_o[l_ac].* =  g_mhaa_d[l_ac].*
                  CALL amhi206_mhaa_t_mask()
                  LET g_mhaa_d_mask_n[l_ac].* =  g_mhaa_d[l_ac].*
                  
                  CALL amhi206_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL amhi206_set_entry_b(l_cmd)
            CALL amhi206_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.mhadl001 = g_mhaa_d[l_ac].mhad001
LET g_detail_multi_table_t.mhadl002 = g_mhaa_d[l_ac].mhad002
LET g_detail_multi_table_t.mhadl003 = g_mhaa_d[l_ac].mhad003
LET g_detail_multi_table_t.mhadl004 = g_mhaa_d[l_ac].mhad004
LET g_detail_multi_table_t.mhadl005 = g_dlang
LET g_detail_multi_table_t.mhadl006 = g_mhaa_d[l_ac].mhadl006
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'mhadlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhadl001'
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhad001
            LET l_field_keys[03] = 'mhadl002'
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhad002
            LET l_field_keys[04] = 'mhadl003'
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhad003
            LET l_field_keys[05] = 'mhadl004'
            LET l_var_keys[05] = g_mhaa_d[l_ac].mhad004
            LET l_field_keys[06] = 'mhadl005'
            LET l_var_keys[06] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhadl_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mhaa_d_t.* TO NULL
            INITIALIZE g_mhaa_d_o.* TO NULL
            INITIALIZE g_mhaa_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_mhaa_d[l_ac].sel = "N"
      LET g_mhaa_d[l_ac].mhaa005 = "0"
      LET g_mhaa_d[l_ac].mhaa006 = "0"
      LET g_mhaa_d[l_ac].mhaa002 = "0"
      LET g_mhaa_d[l_ac].mhaa003 = "0"
      LET g_mhaa_d[l_ac].mhaa004 = "0"
      LET g_mhaa_d[l_ac].mhab006 = "0"
      LET g_mhaa_d[l_ac].mhab007 = "0"
      LET g_mhaa_d[l_ac].mhab003 = "0"
      LET g_mhaa_d[l_ac].mhab004 = "0"
      LET g_mhaa_d[l_ac].mhab005 = "0"
      LET g_mhaa_d[l_ac].mhac004 = "0"
      LET g_mhaa_d[l_ac].mhac005 = "0"
      LET g_mhaa_d[l_ac].mhac006 = "0"
      LET g_mhaa_d[l_ac].mhad005 = "0"
      LET g_mhaa_d[l_ac].mhad006 = "0"
      LET g_mhaa_d[l_ac].mhad007 = "0"
      LET g_mhaa_d[l_ac].mhadstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_mhaa_d_t.* = g_mhaa_d[l_ac].*     #新輸入資料
            LET g_mhaa_d_o.* = g_mhaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhaa_d[li_reproduce_target].* = g_mhaa_d[li_reproduce].*
 
               LET g_mhaa_d[g_mhaa_d.getLength()].mhaasite = NULL
               LET g_mhaa_d[g_mhaa_d.getLength()].mhaa001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.mhadl001 = g_mhaa_d[l_ac].mhad001
LET g_detail_multi_table_t.mhadl002 = g_mhaa_d[l_ac].mhad002
LET g_detail_multi_table_t.mhadl003 = g_mhaa_d[l_ac].mhad003
LET g_detail_multi_table_t.mhadl004 = g_mhaa_d[l_ac].mhad004
LET g_detail_multi_table_t.mhadl005 = g_dlang
LET g_detail_multi_table_t.mhadl006 = g_mhaa_d[l_ac].mhadl006
 
            CALL amhi206_set_entry_b(l_cmd)
            CALL amhi206_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM mhaa_t 
             WHERE mhaaent = g_enterprise AND mhaasite = g_mhaa_d[l_ac].mhaasite
                                       AND mhaa001 = g_mhaa_d[l_ac].mhaa001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhaa_d[g_detail_idx].mhaasite
               LET gs_keys[2] = g_mhaa_d[g_detail_idx].mhaa001
               CALL amhi206_insert_b('mhaa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
#               CALL amhi206_insert_mhaa()
#               CALL amhi206_insert_mhab()
#               CALL amhi206_insert_mhac()
#               CALL amhi206_insert_mhad()
               #end add-point
            ELSE    
               INITIALIZE g_mhaa_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mhaa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amhi206_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhaa001 = g_detail_multi_table_t.mhaal001 AND
         g_mhaa_d[l_ac].mhaal003 = g_detail_multi_table_t.mhaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhaa001
            LET l_field_keys[02] = 'mhaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mhaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhaal002
            LET l_vars[01] = g_mhaa_d[l_ac].mhaal003
            LET l_fields[01] = 'mhaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhaal_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhab001 = g_detail_multi_table_t.mhabl001 AND
         g_mhaa_d[l_ac].mhab002 = g_detail_multi_table_t.mhabl002 AND
         g_mhaa_d[l_ac].mhabl004 = g_detail_multi_table_t.mhabl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhablent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhab001
            LET l_field_keys[02] = 'mhabl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhabl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhab002
            LET l_field_keys[03] = 'mhabl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhabl002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhabl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhabl003
            LET l_vars[01] = g_mhaa_d[l_ac].mhabl004
            LET l_fields[01] = 'mhabl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhabl_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhac001 = g_detail_multi_table_t.mhacl001 AND
         g_mhaa_d[l_ac].mhac002 = g_detail_multi_table_t.mhacl002 AND
         g_mhaa_d[l_ac].mhac003 = g_detail_multi_table_t.mhacl003 AND
         g_mhaa_d[l_ac].mhacl005 = g_detail_multi_table_t.mhacl005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhac001
            LET l_field_keys[02] = 'mhacl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhacl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhac002
            LET l_field_keys[03] = 'mhacl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhacl002
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhac003
            LET l_field_keys[04] = 'mhacl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhacl003
            LET l_var_keys[05] = g_dlang
            LET l_field_keys[05] = 'mhacl004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhacl004
            LET l_vars[01] = g_mhaa_d[l_ac].mhacl005
            LET l_fields[01] = 'mhacl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhacl_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhad001 = g_detail_multi_table_t.mhadl001 AND
         g_mhaa_d[l_ac].mhad002 = g_detail_multi_table_t.mhadl002 AND
         g_mhaa_d[l_ac].mhad003 = g_detail_multi_table_t.mhadl003 AND
         g_mhaa_d[l_ac].mhad004 = g_detail_multi_table_t.mhadl004 AND
         g_mhaa_d[l_ac].mhadl006 = g_detail_multi_table_t.mhadl006 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhad001
            LET l_field_keys[02] = 'mhadl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhad002
            LET l_field_keys[03] = 'mhadl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhad003
            LET l_field_keys[04] = 'mhadl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
            LET l_var_keys[05] = g_mhaa_d[l_ac].mhad004
            LET l_field_keys[05] = 'mhadl004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'mhadl005'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.mhadl005
            LET l_vars[01] = g_mhaa_d[l_ac].mhadl006
            LET l_fields[01] = 'mhadl006'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhadl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (mhaasite = '", g_mhaa_d[l_ac].mhaasite, "' "
                                  ," AND mhaa001 = '", g_mhaa_d[l_ac].mhaa001, "' "
 
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
               
               DELETE FROM mhaa_t
                WHERE mhaaent = g_enterprise AND 
                      mhaasite = g_mhaa_d_t.mhaasite
                      AND mhaa001 = g_mhaa_d_t.mhaa001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mhaa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
                  LET l_field_keys[03] = 'mhadl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
                  LET l_field_keys[04] = 'mhadl003'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
                  LET l_field_keys[05] = 'mhadl004'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhadl_t')
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL amhi206_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_mhaa_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE amhi206_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_mhaa_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhaa_d_t.mhaasite
               LET gs_keys[2] = g_mhaa_d_t.mhaa001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amhi206_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL amhi206_delete_b('mhaa_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mhaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaasite
            
            #add-point:AFTER FIELD mhaasite name="input.a.page1.mhaasite"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhaa001 != g_mhaa_d_t.mhaa001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhaa_t WHERE "||"mhaaent = '" ||g_enterprise|| "' AND "||"mhaasite = '"||g_mhaa_d[g_detail_idx].mhaasite ||"' AND "|| "mhaa001 = '"||g_mhaa_d[g_detail_idx].mhaa001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_mhaa_d[l_ac].mhaasite) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhaasite
#               LET g_chkparam.arg2 = '參數2'
#               LET g_chkparam.arg3 = 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooed004") THEN
#                  #檢查成功時後續處理
#                  
#               ELSE
#                  #檢查失敗時後續處理
#                  
#                  NEXT FIELD CURRENT
#               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhaa_d[l_ac].mhaasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhaa_d[l_ac].mhaasite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaasite
            #add-point:BEFORE FIELD mhaasite name="input.b.page1.mhaasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaasite
            #add-point:ON CHANGE mhaasite name="input.g.page1.mhaasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaaunit
            
            #add-point:AFTER FIELD mhaaunit name="input.a.page1.mhaaunit"
            IF NOT cl_null(g_mhaa_d[l_ac].mhaaunit) THEN 
#               #應用 a17 樣板自動產生(Version:2)
#               #欄位存在檢查
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhaaunit
#               LET g_chkparam.arg2 = '參數2'
#               LET g_chkparam.arg3 = 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooed004") THEN
#                  #檢查成功時後續處理
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaaunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mhaa_d[l_ac].mhaaunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mhaa_d[l_ac].mhaaunit_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaaunit
            #add-point:BEFORE FIELD mhaaunit name="input.b.page1.mhaaunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaaunit
            #add-point:ON CHANGE mhaaunit name="input.g.page1.mhaaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa001
            #add-point:BEFORE FIELD mhaa001 name="input.b.page1.mhaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa001
            
            #add-point:AFTER FIELD mhaa001 name="input.a.page1.mhaa001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhaa001 != g_mhaa_d_t.mhaa001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhaa_t WHERE "||"mhaaent = '" ||g_enterprise|| "' AND "||"mhaasite = '"||g_mhaa_d[g_detail_idx].mhaasite ||"' AND "|| "mhaa001 = '"||g_mhaa_d[g_detail_idx].mhaa001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaa001
            #add-point:ON CHANGE mhaa001 name="input.g.page1.mhaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaal003
            #add-point:BEFORE FIELD mhaal003 name="input.b.page1.mhaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaal003
            
            #add-point:AFTER FIELD mhaal003 name="input.a.page1.mhaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaal003
            #add-point:ON CHANGE mhaal003 name="input.g.page1.mhaal003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhaa005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhaa005
            END IF 
 
 
 
            #add-point:AFTER FIELD mhaa005 name="input.a.page1.mhaa005"
            IF NOT cl_null(g_mhaa_d[l_ac].mhaa005) THEN 
               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa005
            #add-point:BEFORE FIELD mhaa005 name="input.b.page1.mhaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaa005
            #add-point:ON CHANGE mhaa005 name="input.g.page1.mhaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhaa006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhaa006
            END IF 
 
 
 
            #add-point:AFTER FIELD mhaa006 name="input.a.page1.mhaa006"
            IF NOT cl_null(g_mhaa_d[l_ac].mhaa006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa006
            #add-point:BEFORE FIELD mhaa006 name="input.b.page1.mhaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaa006
            #add-point:ON CHANGE mhaa006 name="input.g.page1.mhaa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa002
            #add-point:BEFORE FIELD mhaa002 name="input.b.page1.mhaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa002
            
            #add-point:AFTER FIELD mhaa002 name="input.a.page1.mhaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaa002
            #add-point:ON CHANGE mhaa002 name="input.g.page1.mhaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa003
            #add-point:BEFORE FIELD mhaa003 name="input.b.page1.mhaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa003
            
            #add-point:AFTER FIELD mhaa003 name="input.a.page1.mhaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaa003
            #add-point:ON CHANGE mhaa003 name="input.g.page1.mhaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhaa004
            #add-point:BEFORE FIELD mhaa004 name="input.b.page1.mhaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhaa004
            
            #add-point:AFTER FIELD mhaa004 name="input.a.page1.mhaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhaa004
            #add-point:ON CHANGE mhaa004 name="input.g.page1.mhaa004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab001
            
            #add-point:AFTER FIELD mhab001 name="input.a.page1.mhab001"
            IF NOT cl_null(g_mhaa_d[l_ac].mhab001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhab001
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab001
            #add-point:BEFORE FIELD mhab001 name="input.b.page1.mhab001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab001
            #add-point:ON CHANGE mhab001 name="input.g.page1.mhab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab002
            #add-point:BEFORE FIELD mhab002 name="input.b.page1.mhab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab002
            
            #add-point:AFTER FIELD mhab002 name="input.a.page1.mhab002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab002
            #add-point:ON CHANGE mhab002 name="input.g.page1.mhab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhabl004
            #add-point:BEFORE FIELD mhabl004 name="input.b.page1.mhabl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhabl004
            
            #add-point:AFTER FIELD mhabl004 name="input.a.page1.mhabl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhabl004
            #add-point:ON CHANGE mhabl004 name="input.g.page1.mhabl004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab006
            END IF 
 
 
 
            #add-point:AFTER FIELD mhab006 name="input.a.page1.mhab006"
            IF NOT cl_null(g_mhaa_d[l_ac].mhab006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab006
            #add-point:BEFORE FIELD mhab006 name="input.b.page1.mhab006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab006
            #add-point:ON CHANGE mhab006 name="input.g.page1.mhab006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab007
            END IF 
 
 
 
            #add-point:AFTER FIELD mhab007 name="input.a.page1.mhab007"
            IF NOT cl_null(g_mhaa_d[l_ac].mhab007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab007
            #add-point:BEFORE FIELD mhab007 name="input.b.page1.mhab007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab007
            #add-point:ON CHANGE mhab007 name="input.g.page1.mhab007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab008
            END IF 
 
 
 
            #add-point:AFTER FIELD mhab008 name="input.a.page1.mhab008"
            IF NOT cl_null(g_mhaa_d[l_ac].mhab008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab008
            #add-point:BEFORE FIELD mhab008 name="input.b.page1.mhab008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab008
            #add-point:ON CHANGE mhab008 name="input.g.page1.mhab008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab009
            END IF 
 
 
 
            #add-point:AFTER FIELD mhab009 name="input.a.page1.mhab009"
            IF NOT cl_null(g_mhaa_d[l_ac].mhab009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab009
            #add-point:BEFORE FIELD mhab009 name="input.b.page1.mhab009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab009
            #add-point:ON CHANGE mhab009 name="input.g.page1.mhab009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab003
            #add-point:BEFORE FIELD mhab003 name="input.b.page1.mhab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab003
            
            #add-point:AFTER FIELD mhab003 name="input.a.page1.mhab003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab003
            #add-point:ON CHANGE mhab003 name="input.g.page1.mhab003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab004
            #add-point:BEFORE FIELD mhab004 name="input.b.page1.mhab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab004
            
            #add-point:AFTER FIELD mhab004 name="input.a.page1.mhab004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab004
            #add-point:ON CHANGE mhab004 name="input.g.page1.mhab004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhab005
            #add-point:BEFORE FIELD mhab005 name="input.b.page1.mhab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhab005
            
            #add-point:AFTER FIELD mhab005 name="input.a.page1.mhab005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhab005
            #add-point:ON CHANGE mhab005 name="input.g.page1.mhab005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac001
            
            #add-point:AFTER FIELD mhac001 name="input.a.page1.mhac001"
            IF NOT cl_null(g_mhaa_d[l_ac].mhac001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhac001
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac001
            #add-point:BEFORE FIELD mhac001 name="input.b.page1.mhac001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhac001
            #add-point:ON CHANGE mhac001 name="input.g.page1.mhac001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac002
            
            #add-point:AFTER FIELD mhac002 name="input.a.page1.mhac002"
            IF NOT cl_null(g_mhaa_d[l_ac].mhac002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhac002
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhab002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac002
            #add-point:BEFORE FIELD mhac002 name="input.b.page1.mhac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhac002
            #add-point:ON CHANGE mhac002 name="input.g.page1.mhac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac003
            #add-point:BEFORE FIELD mhac003 name="input.b.page1.mhac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac003
            
            #add-point:AFTER FIELD mhac003 name="input.a.page1.mhac003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhac003
            #add-point:ON CHANGE mhac003 name="input.g.page1.mhac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhacl005
            #add-point:BEFORE FIELD mhacl005 name="input.b.page1.mhacl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhacl005
            
            #add-point:AFTER FIELD mhacl005 name="input.a.page1.mhacl005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhacl005
            #add-point:ON CHANGE mhacl005 name="input.g.page1.mhacl005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhac004,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhac004
            END IF 
 
 
 
            #add-point:AFTER FIELD mhac004 name="input.a.page1.mhac004"
            IF NOT cl_null(g_mhaa_d[l_ac].mhac004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac004
            #add-point:BEFORE FIELD mhac004 name="input.b.page1.mhac004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhac004
            #add-point:ON CHANGE mhac004 name="input.g.page1.mhac004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhac005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhac005
            END IF 
 
 
 
            #add-point:AFTER FIELD mhac005 name="input.a.page1.mhac005"
            IF NOT cl_null(g_mhaa_d[l_ac].mhac005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac005
            #add-point:BEFORE FIELD mhac005 name="input.b.page1.mhac005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhac005
            #add-point:ON CHANGE mhac005 name="input.g.page1.mhac005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhac006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhac006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhac006
            END IF 
 
 
 
            #add-point:AFTER FIELD mhac006 name="input.a.page1.mhac006"
            IF NOT cl_null(g_mhaa_d[l_ac].mhac006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhac006
            #add-point:BEFORE FIELD mhac006 name="input.b.page1.mhac006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhac006
            #add-point:ON CHANGE mhac006 name="input.g.page1.mhac006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad001
            
            #add-point:AFTER FIELD mhad001 name="input.a.page1.mhad001"
            IF NOT cl_null(g_mhaa_d[l_ac].mhad001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhad001
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad001
            #add-point:BEFORE FIELD mhad001 name="input.b.page1.mhad001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad001
            #add-point:ON CHANGE mhad001 name="input.g.page1.mhad001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad002
            
            #add-point:AFTER FIELD mhad002 name="input.a.page1.mhad002"
            IF NOT cl_null(g_mhaa_d[l_ac].mhad002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhad002
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhab002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad002
            #add-point:BEFORE FIELD mhad002 name="input.b.page1.mhad002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad002
            #add-point:ON CHANGE mhad002 name="input.g.page1.mhad002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad003
            #add-point:BEFORE FIELD mhad003 name="input.b.page1.mhad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad003
            
            #add-point:AFTER FIELD mhad003 name="input.a.page1.mhad003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad003
            #add-point:ON CHANGE mhad003 name="input.g.page1.mhad003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad004
            #add-point:BEFORE FIELD mhad004 name="input.b.page1.mhad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad004
            
            #add-point:AFTER FIELD mhad004 name="input.a.page1.mhad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad004
            #add-point:ON CHANGE mhad004 name="input.g.page1.mhad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhadl006
            #add-point:BEFORE FIELD mhadl006 name="input.b.page1.mhadl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhadl006
            
            #add-point:AFTER FIELD mhadl006 name="input.a.page1.mhadl006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhadl006
            #add-point:ON CHANGE mhadl006 name="input.g.page1.mhadl006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad010
            
            #add-point:AFTER FIELD mhad010 name="input.a.page1.mhad010"
            IF NOT cl_null(g_mhaa_d[l_ac].mhad010) THEN 
               IF g_mhaa_d[l_ac].mhad010 != g_mhaa_d_o.mhad010 OR g_mhaa_d_o.mhad010 IS NULL  THEN
                  #應用 a17 樣板自動產生(Version:3)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  IF NOT s_azzi650_chk_exist('2145',g_mhaa_d[l_ac].mhad010) THEN
                     LET g_mhaa_d_o.mhad010 = g_mhaa_d[l_ac].mhad010
                     CALL s_desc_get_acc_desc('2145',g_mhaa_d[l_ac].mhad010)  RETURNING g_mhaa_d[l_ac].mhad010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            CALL s_desc_get_acc_desc('2145',g_mhaa_d[l_ac].mhad010)  RETURNING g_mhaa_d[l_ac].mhad010_desc
            DISPLAY BY NAME g_mhaa_d[l_ac].mhad010_desc
            LET g_mhaa_d_o.mhad010 = g_mhaa_d[l_ac].mhad010
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad010
            #add-point:BEFORE FIELD mhad010 name="input.b.page1.mhad010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad010
            #add-point:ON CHANGE mhad010 name="input.g.page1.mhad010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad005
            #add-point:BEFORE FIELD mhad005 name="input.b.page1.mhad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad005
            
            #add-point:AFTER FIELD mhad005 name="input.a.page1.mhad005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad005
            #add-point:ON CHANGE mhad005 name="input.g.page1.mhad005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhad006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhad006
            END IF 
 
 
 
            #add-point:AFTER FIELD mhad006 name="input.a.page1.mhad006"
            IF NOT cl_null(g_mhaa_d[l_ac].mhad006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad006
            #add-point:BEFORE FIELD mhad006 name="input.b.page1.mhad006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad006
            #add-point:ON CHANGE mhad006 name="input.g.page1.mhad006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhad007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhad007
            END IF 
 
 
 
            #add-point:AFTER FIELD mhad007 name="input.a.page1.mhad007"
            IF NOT cl_null(g_mhaa_d[l_ac].mhad007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad007
            #add-point:BEFORE FIELD mhad007 name="input.b.page1.mhad007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad007
            #add-point:ON CHANGE mhad007 name="input.g.page1.mhad007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhad008
            #add-point:BEFORE FIELD mhad008 name="input.b.page1.mhad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad008
            
            #add-point:AFTER FIELD mhad008 name="input.a.page1.mhad008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhad008
            #add-point:ON CHANGE mhad008 name="input.g.page1.mhad008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhadstus
            #add-point:BEFORE FIELD mhadstus name="input.b.page1.mhadstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhadstus
            
            #add-point:AFTER FIELD mhadstus name="input.a.page1.mhadstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhadstus
            #add-point:ON CHANGE mhadstus name="input.g.page1.mhadstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaasite
            #add-point:ON ACTION controlp INFIELD mhaasite name="input.c.page1.mhaasite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhaasite             #給予default值
            LET g_qryparam.default2 = "" #g_mhaa_d[l_ac].ooed004 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_ooed004()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhaasite = g_qryparam.return1              
            #LET g_mhaa_d[l_ac].ooed004 = g_qryparam.return2 
            DISPLAY g_mhaa_d[l_ac].mhaasite TO mhaasite              #
            #DISPLAY g_mhaa_d[l_ac].ooed004 TO ooed004 #組織編號
            NEXT FIELD mhaasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaaunit
            #add-point:ON ACTION controlp INFIELD mhaaunit name="input.c.page1.mhaaunit"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhaaunit             #給予default值
            LET g_qryparam.default2 = "" #g_mhaa_d[l_ac].ooed004 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_ooed004()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhaaunit = g_qryparam.return1              
            #LET g_mhaa_d[l_ac].ooed004 = g_qryparam.return2 
            DISPLAY g_mhaa_d[l_ac].mhaaunit TO mhaaunit              #
            #DISPLAY g_mhaa_d[l_ac].ooed004 TO ooed004 #組織編號
            NEXT FIELD mhaaunit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa001
            #add-point:ON ACTION controlp INFIELD mhaa001 name="input.c.page1.mhaa001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhaa001             #給予default值
            LET g_qryparam.where = "mhaasite ='",g_mhaa_d[l_ac].mhaasite,"' "
            #給予arg
            CALL q_mhaa001()                                #呼叫開窗
            LET g_mhaa_d[l_ac].mhaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_mhaa_d[l_ac].mhaa001 TO mhaa001              #顯示到畫面上
            NEXT FIELD mhaa001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaal003
            #add-point:ON ACTION controlp INFIELD mhaal003 name="input.c.page1.mhaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa005
            #add-point:ON ACTION controlp INFIELD mhaa005 name="input.c.page1.mhaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa006
            #add-point:ON ACTION controlp INFIELD mhaa006 name="input.c.page1.mhaa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa002
            #add-point:ON ACTION controlp INFIELD mhaa002 name="input.c.page1.mhaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa003
            #add-point:ON ACTION controlp INFIELD mhaa003 name="input.c.page1.mhaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhaa004
            #add-point:ON ACTION controlp INFIELD mhaa004 name="input.c.page1.mhaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab001
            #add-point:ON ACTION controlp INFIELD mhab001 name="input.c.page1.mhab001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhab001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhab001 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhab001 TO mhab001              #

            NEXT FIELD mhab001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab002
            #add-point:ON ACTION controlp INFIELD mhab002 name="input.c.page1.mhab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhabl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhabl004
            #add-point:ON ACTION controlp INFIELD mhabl004 name="input.c.page1.mhabl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab006
            #add-point:ON ACTION controlp INFIELD mhab006 name="input.c.page1.mhab006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab007
            #add-point:ON ACTION controlp INFIELD mhab007 name="input.c.page1.mhab007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab008
            #add-point:ON ACTION controlp INFIELD mhab008 name="input.c.page1.mhab008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab009
            #add-point:ON ACTION controlp INFIELD mhab009 name="input.c.page1.mhab009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab003
            #add-point:ON ACTION controlp INFIELD mhab003 name="input.c.page1.mhab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab004
            #add-point:ON ACTION controlp INFIELD mhab004 name="input.c.page1.mhab004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhab005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhab005
            #add-point:ON ACTION controlp INFIELD mhab005 name="input.c.page1.mhab005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac001
            #add-point:ON ACTION controlp INFIELD mhac001 name="input.c.page1.mhac001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhac001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhac001 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhac001 TO mhac001              #

            NEXT FIELD mhac001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac002
            #add-point:ON ACTION controlp INFIELD mhac002 name="input.c.page1.mhac002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhac002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhab002()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhac002 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhac002 TO mhac002              #

            NEXT FIELD mhac002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac003
            #add-point:ON ACTION controlp INFIELD mhac003 name="input.c.page1.mhac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhacl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhacl005
            #add-point:ON ACTION controlp INFIELD mhacl005 name="input.c.page1.mhacl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac004
            #add-point:ON ACTION controlp INFIELD mhac004 name="input.c.page1.mhac004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac005
            #add-point:ON ACTION controlp INFIELD mhac005 name="input.c.page1.mhac005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhac006
            #add-point:ON ACTION controlp INFIELD mhac006 name="input.c.page1.mhac006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad001
            #add-point:ON ACTION controlp INFIELD mhad001 name="input.c.page1.mhad001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhad001 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhad001 TO mhad001              #

            NEXT FIELD mhad001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad002
            #add-point:ON ACTION controlp INFIELD mhad002 name="input.c.page1.mhad002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhab002()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhad002 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhad002 TO mhad002              #

            NEXT FIELD mhad002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad003
            #add-point:ON ACTION controlp INFIELD mhad003 name="input.c.page1.mhad003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhac003()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhad003 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhad003 TO mhad003              #

            NEXT FIELD mhad003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad004
            #add-point:ON ACTION controlp INFIELD mhad004 name="input.c.page1.mhad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhadl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhadl006
            #add-point:ON ACTION controlp INFIELD mhadl006 name="input.c.page1.mhadl006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad010
            #add-point:ON ACTION controlp INFIELD mhad010 name="input.c.page1.mhad010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad010             #給予default值
            LET g_qryparam.default2 = "" #g_mhaa_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '2145' #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhaa_d[l_ac].mhad010 = g_qryparam.return1              
            #LET g_mhaa_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mhaa_d[l_ac].mhad010 TO mhad010              #
            #DISPLAY g_mhaa_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mhad010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad005
            #add-point:ON ACTION controlp INFIELD mhad005 name="input.c.page1.mhad005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad006
            #add-point:ON ACTION controlp INFIELD mhad006 name="input.c.page1.mhad006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad007
            #add-point:ON ACTION controlp INFIELD mhad007 name="input.c.page1.mhad007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhad008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad008
            #add-point:ON ACTION controlp INFIELD mhad008 name="input.c.page1.mhad008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhadstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhadstus
            #add-point:ON ACTION controlp INFIELD mhadstus name="input.c.page1.mhadstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE amhi206_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_mhaa_d[l_ac].* = g_mhaa_d_t.*
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
               LET g_errparam.extend = g_mhaa_d[l_ac].mhaasite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mhaa_d[l_ac].* = g_mhaa_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL amhi206_mhaa_t_mask_restore('restore_mask_o')
 
               UPDATE mhaa_t SET (mhaasite,mhaaunit,mhaa001,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004) = (g_mhaa_d[l_ac].mhaasite, 
                   g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaa001,g_mhaa_d[l_ac].mhaa005,g_mhaa_d[l_ac].mhaa006, 
                   g_mhaa_d[l_ac].mhaa002,g_mhaa_d[l_ac].mhaa003,g_mhaa_d[l_ac].mhaa004)
                WHERE mhaaent = g_enterprise AND
                  mhaasite = g_mhaa_d_t.mhaasite #項次   
                  AND mhaa001 = g_mhaa_d_t.mhaa001  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhaa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhaa_d[g_detail_idx].mhaasite
               LET gs_keys_bak[1] = g_mhaa_d_t.mhaasite
               LET gs_keys[2] = g_mhaa_d[g_detail_idx].mhaa001
               LET gs_keys_bak[2] = g_mhaa_d_t.mhaa001
               CALL amhi206_update_b('mhaa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhaa001 = g_detail_multi_table_t.mhaal001 AND
         g_mhaa_d[l_ac].mhaal003 = g_detail_multi_table_t.mhaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhaa001
            LET l_field_keys[02] = 'mhaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mhaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhaal002
            LET l_vars[01] = g_mhaa_d[l_ac].mhaal003
            LET l_fields[01] = 'mhaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhaal_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhab001 = g_detail_multi_table_t.mhabl001 AND
         g_mhaa_d[l_ac].mhab002 = g_detail_multi_table_t.mhabl002 AND
         g_mhaa_d[l_ac].mhabl004 = g_detail_multi_table_t.mhabl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhablent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhab001
            LET l_field_keys[02] = 'mhabl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhabl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhab002
            LET l_field_keys[03] = 'mhabl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhabl002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhabl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhabl003
            LET l_vars[01] = g_mhaa_d[l_ac].mhabl004
            LET l_fields[01] = 'mhabl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhabl_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhac001 = g_detail_multi_table_t.mhacl001 AND
         g_mhaa_d[l_ac].mhac002 = g_detail_multi_table_t.mhacl002 AND
         g_mhaa_d[l_ac].mhac003 = g_detail_multi_table_t.mhacl003 AND
         g_mhaa_d[l_ac].mhacl005 = g_detail_multi_table_t.mhacl005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhac001
            LET l_field_keys[02] = 'mhacl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhacl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhac002
            LET l_field_keys[03] = 'mhacl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhacl002
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhac003
            LET l_field_keys[04] = 'mhacl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhacl003
            LET l_var_keys[05] = g_dlang
            LET l_field_keys[05] = 'mhacl004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhacl004
            LET l_vars[01] = g_mhaa_d[l_ac].mhacl005
            LET l_fields[01] = 'mhacl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhacl_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhad001 = g_detail_multi_table_t.mhadl001 AND
         g_mhaa_d[l_ac].mhad002 = g_detail_multi_table_t.mhadl002 AND
         g_mhaa_d[l_ac].mhad003 = g_detail_multi_table_t.mhadl003 AND
         g_mhaa_d[l_ac].mhad004 = g_detail_multi_table_t.mhadl004 AND
         g_mhaa_d[l_ac].mhadl006 = g_detail_multi_table_t.mhadl006 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhad001
            LET l_field_keys[02] = 'mhadl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhad002
            LET l_field_keys[03] = 'mhadl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhad003
            LET l_field_keys[04] = 'mhadl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
            LET l_var_keys[05] = g_mhaa_d[l_ac].mhad004
            LET l_field_keys[05] = 'mhadl004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'mhadl005'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.mhadl005
            LET l_vars[01] = g_mhaa_d[l_ac].mhadl006
            LET l_fields[01] = 'mhadl006'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhadl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_mhaa_d_t)
                     LET g_log2 = util.JSON.stringify(g_mhaa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amhi206_mhaa_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL amhi206_unlock_b("mhaa_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mhaa_d[l_ac].* = g_mhaa_d_t.*
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
               LET g_mhaa_d[li_reproduce_target].* = g_mhaa_d[li_reproduce].*
 
               LET g_mhaa_d[li_reproduce_target].mhaasite = NULL
               LET g_mhaa_d[li_reproduce_target].mhaa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhaa_d.getLength()+1
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
               NEXT FIELD sel
 
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
      IF INT_FLAG OR cl_null(g_mhaa_d[g_detail_idx].mhaasite) THEN
         CALL g_mhaa_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_mhaa_d[g_detail_idx].* = g_mhaa_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE amhi206_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="amhi206.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amhi206_delete()
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
   RETURN
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_mhaa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT amhi206_lock_b("mhaa_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("mhaa_t","") THEN
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
   
   FOR li_idx = 1 TO g_mhaa_d.getLength()
      IF g_mhaa_d[li_idx].mhaasite IS NOT NULL
         AND g_mhaa_d[li_idx].mhaa001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM mhaa_t
          WHERE mhaaent = g_enterprise AND 
                mhaasite = g_mhaa_d[li_idx].mhaasite
                AND mhaa001 = g_mhaa_d[li_idx].mhaa001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhaa_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.mhadl001 = g_mhaa_d[l_ac].mhad001
LET g_detail_multi_table_t.mhadl002 = g_mhaa_d[l_ac].mhad002
LET g_detail_multi_table_t.mhadl003 = g_mhaa_d[l_ac].mhad003
LET g_detail_multi_table_t.mhadl004 = g_mhaa_d[l_ac].mhad004
LET g_detail_multi_table_t.mhadl005 = g_dlang
LET g_detail_multi_table_t.mhadl006 = g_mhaa_d[l_ac].mhadl006
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
                  LET l_field_keys[03] = 'mhadl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
                  LET l_field_keys[04] = 'mhadl003'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
                  LET l_field_keys[05] = 'mhadl004'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhadl_t')
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhaa_d_t.mhaasite
               LET gs_keys[2] = g_mhaa_d_t.mhaa001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL amhi206_delete_b('mhaa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amhi206_set_pk_array()
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
   CALL amhi206_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="amhi206.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amhi206_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   #CALL amhi206_b_fill2(p_wc2)
   RETURN
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.mhaasite,t0.mhaaunit,t0.mhaa001,t0.mhaa005,t0.mhaa006,t0.mhaa002, 
       t0.mhaa003,t0.mhaa004 ,t1.ooefl003 ,t2.ooefl003 FROM mhaa_t t0",
               " LEFT JOIN mhaal_t ON mhaalent = "||g_enterprise||" AND mhaa001 = mhaal001 AND mhaal002 = '",g_dlang,"' LEFT JOIN mhabl_t ON mhablent = "||g_enterprise||" AND mhab001 = mhabl001 AND mhab002 = mhabl002 AND mhabl003 = '",g_dlang,"' LEFT JOIN mhacl_t ON mhaclent = "||g_enterprise||" AND mhac001 = mhacl001 AND mhac002 = mhacl002 AND mhac003 = mhacl003 AND mhacl004 = '",g_dlang,"' LEFT JOIN mhadl_t ON mhadlent = "||g_enterprise||" AND mhad001 = mhadl001 AND mhad002 = mhadl002 AND mhad003 = mhadl003 AND mhad004 = mhadl004 AND mhadl005 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mhaaunit AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.mhaaent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = "SELECT  UNIQUE t0.mhaasite,t1.ooefl003,t0.mhaaunit,t2.ooefl003,t0.mhaa001,t0.mhaa005, t0.mhaa006, ",
               "               t0.mhaa002, t0.mhaa003, t0.mhaa004, t3.mhab001, t3.mhab002,t4.mhabl004,t3.mhab006, ",
               "               t3.mhab007, t3.mhab008, t3.mhab009, t3.mhab003, t3.mhab004,t3.mhab005, t5.mhac001, ",
               "               t5.mhac002, t5.mhac003, t6.mhacl005,t5.mhac004, t5.mhac005,t5.mhac006, t7.mhad001, ",
               #"               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad005,t7.mhad006, t7.mhad007, ",#160506-00009#28 20160512 add by beckxie---S
               "               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad010,t7.mhad005,t7.mhad006, t7.mhad007, ",#160506-00009#28 20160512 add by beckxie---S
               "               t7.mhad008 ",
               "  FROM mhaa_t t0",
               "               LEFT JOIN mhaal_t ON mhaalent = '"||g_enterprise||"' AND mhaa001 = mhaal001 AND mhaal002 = '"||g_dlang||"' ",
               "               LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhaasite AND t1.ooefl002='"||g_dlang||"' ",
               "               LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.mhaaunit AND t2.ooefl002='"||g_dlang||"' ",
               "     ,mhab_t  t3 ",
               "               LEFT JOIN mhabl_t t4 ON t4.mhablent = '"||g_enterprise||"' AND t4.mhabl001 = t3.mhab001 AND t4.mhabl002 = t3.mhab002 AND t4.mhabl003 ='"||g_dlang||"' ",
               "     ,mhac_t  t5 ",
               "               LEFT JOIN mhacl_t t6 ON t6.mhaclent = '"||g_enterprise||"' AND t6.mhacl001 = t5.mhac001 AND t6.mhacl002 = t5.mhac002 AND t6.mhacl003 = t5.mhac003 AND t6.mhacl004= '"||g_dlang||"' ",
               "     ,mhad_t  t7 ",
               "               LEFT JOIN mhadl_t t8 ON t8.mhadlent = '"||g_enterprise||"' AND t8.mhadl001 = t7.mhad001 AND t8.mhadl002 = t7.mhad002 AND t8.mhadl003 = t7.mhad003 AND t8.mhadl004= t7.mhad004 AND t8.mhadl005='"||g_dlang||"' ",
               " WHERE t0.mhaaent =t3.mhabent ",
               "   AND t0.mhaaent =t5.mhacent ",
               "   AND t0.mhaaent =t7.mhadent ",
               "   AND t0.mhaasite = t3.mhabsite ",
               "   AND t0.mhaasite = t5.mhacsite ",
               "   AND t0.mhaasite = t7.mhadsite ",
               "   AND t0.mhaa001  = t3.mhab001 ",
               "   AND t0.mhaa001  = t5.mhac001 ",
               "   AND t0.mhaa001  = t7.mhad001 ",
               "   AND t3.mhab002  = t5.mhac002 ",
               "   AND t3.mhab002  = t7.mhad002 ",
               "   AND t5.mhac003  = t7.mhad003 ",
               "   AND t0.mhaaent= ?  AND  1=1 AND (", p_wc2, ") " 
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("mhaa_t"),
                      " ORDER BY t0.mhaasite,t0.mhaa001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhaa_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE amhi206_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR amhi206_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mhaa_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mhaa_d[l_ac].mhaasite,g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaa001,g_mhaa_d[l_ac].mhaa005, 
       g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaa002,g_mhaa_d[l_ac].mhaa003,g_mhaa_d[l_ac].mhaa004,g_mhaa_d[l_ac].mhaasite_desc, 
       g_mhaa_d[l_ac].mhaaunit_desc
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
      
      CALL amhi206_detail_show()      
 
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
   
 
   
   CALL g_mhaa_d.deleteElement(g_mhaa_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_mhaa_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_mhaa_d.getLength() THEN
      LET l_ac = g_mhaa_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhaa_d.getLength()
      LET g_mhaa_d_mask_o[l_ac].* =  g_mhaa_d[l_ac].*
      CALL amhi206_mhaa_t_mask()
      LET g_mhaa_d_mask_n[l_ac].* =  g_mhaa_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_mhaa_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE amhi206_pb
   
END FUNCTION
 
{</section>}
 
{<section id="amhi206.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION amhi206_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"

#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaa001
#   CALL ap_ref_array2(g_ref_fields," SELECT mhaal003 FROM mhaa_t WHERE mhaaent = '"||g_enterprise||"' AND mhaal001 = ? AND mhaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_mhaa_d[l_ac].mhaal003 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhaa_d[l_ac].mhaal003
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = .mhab001
#   LET g_ref_fields[2] = g_mhaa_d[l_ac].mhab002
#   CALL ap_ref_array2(g_ref_fields," SELECT mhabl004 FROM mhabl_t WHERE mhablent = '"||g_enterprise||"' AND mhabl001 = ? AND mhabl002 = ? AND mhabl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_mhaa_d[l_ac].mhabl004 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhaa_d[l_ac].mhabl004
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = .mhac001
#   LET g_ref_fields[2] = .mhac002
#   LET g_ref_fields[3] = g_mhaa_d[l_ac].mhac003
#   CALL ap_ref_array2(g_ref_fields," SELECT mhacl005 FROM mhacl_t WHERE mhaclent = '"||g_enterprise||"' AND mhacl001 = ? AND mhacl002 = ? AND mhacl003 = ? AND mhacl004 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_mhaa_d[l_ac].mhacl005 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhaa_d[l_ac].mhacl005
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = .mhad001
#   LET g_ref_fields[2] = .mhad002
#   LET g_ref_fields[3] = .mhad003
#   LET g_ref_fields[4] = g_mhaa_d[l_ac].mhad004
#   CALL ap_ref_array2(g_ref_fields," SELECT mhadl006 FROM mhadl_t WHERE mhadlent = '"||g_enterprise||"' AND mhadl001 = ? AND mhad002 = ? AND mhad003 = ? AND mhad004 = ? AND mhadl005 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_mhaa_d[l_ac].mhadl006 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_mhaa_d[l_ac].mhadl006
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amhi206.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amhi206_set_entry_b(p_cmd)                                                  
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
 
{<section id="amhi206.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amhi206_set_no_entry_b(p_cmd)                                               
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
 
{<section id="amhi206.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amhi206_default_search()
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
      LET ls_wc = ls_wc, " mhaasite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mhaa001 = '", g_argv[02], "' AND "
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
 
{<section id="amhi206.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amhi206_delete_b(ps_table,ps_keys_bak,ps_page)
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
   RETURN
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "mhaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'mhaa_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM mhaa_t
          WHERE mhaaent = g_enterprise AND
            mhaasite = ps_keys_bak[1] AND mhaa001 = ps_keys_bak[2]
         
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
         CALL g_mhaa_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="amhi206.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amhi206_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   RETURN 
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "mhaa_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO mhaa_t
                  (mhaaent,
                   mhaasite,mhaa001
                   ,mhaaunit,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaa005,g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaa002, 
                       g_mhaa_d[l_ac].mhaa003,g_mhaa_d[l_ac].mhaa004)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhaa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="amhi206.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amhi206_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "mhaa_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mhaa_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE mhaa_t 
         SET (mhaasite,mhaa001
              ,mhaaunit,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaa005,g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaa002, 
                  g_mhaa_d[l_ac].mhaa003,g_mhaa_d[l_ac].mhaa004) 
         WHERE mhaaent = g_enterprise AND mhaasite = ps_keys_bak[1] AND mhaa001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhaa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhaa_t:",SQLERRMESSAGE 
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
 
{<section id="amhi206.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amhi206_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   
   #end add-point
   
   #先刷新資料
   #CALL amhi206_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mhaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amhi206_bcl USING g_enterprise,
                                       g_mhaa_d[g_detail_idx].mhaasite,g_mhaa_d[g_detail_idx].mhaa001 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amhi206_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amhi206.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amhi206_unlock_b(ps_table)
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
      CLOSE amhi206_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amhi206.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION amhi206_modify_detail_chk(ps_record)
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
         LET ls_return = "sel"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="amhi206.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION amhi206_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="amhi206.mask_functions" >}
&include "erp/amh/amhi206_mask.4gl"
 
{</section>}
 
{<section id="amhi206.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amhi206_set_pk_array()
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
   LET g_pk_array[1].values = g_mhaa_d[l_ac].mhaasite
   LET g_pk_array[1].column = 'mhaasite'
   LET g_pk_array[2].values = g_mhaa_d[l_ac].mhaa001
   LET g_pk_array[2].column = 'mhaa001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amhi206.state_change" >}
   
 
{</section>}
 
{<section id="amhi206.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="amhi206.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/11/16 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi206_modify_1()
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
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE  l_success              LIKE type_t.num5
   DEFINE  l_errno                LIKE type_t.chr10   #161006-00008#2 20161019 add by beckxie
   #end add-point 
   
   #add-point:Function前置處理 
   
   #end add-point
   
   LET g_action_choice = ""
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前
   LET g_mhaa001=FALSE
   LET g_mhab002=FALSE
   LET g_mhac003=FALSE
   LET g_mhad004=FALSE
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前

   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_mhaa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:3)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF NOT cl_null(g_mhaa_d[l_ac].mhaa001)  THEN
                  CALL n_mhaal(g_mhaa_d[l_ac].mhaa001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaa001

                  CALL ap_ref_array2(g_ref_fields," SELECT mhaal003,mhaal004 FROM mhaal_t WHERE mhaalent = '"
                      ||g_enterprise||"' AND mhaal001 = ?  AND mhaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhaa_d[l_ac].mhaal003 = g_rtn_fields[1]

                  DISPLAY BY NAME g_mhaa_d[l_ac].mhaal003
               END IF
               
               IF NOT cl_null(g_mhaa_d[l_ac].mhab002)  THEN
                  CALL n_mhaal(g_mhaa_d[l_ac].mhab002)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaa001
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhab002

                  CALL ap_ref_array2(g_ref_fields," SELECT mhabl004,mhabl005 FROM mhabl_t WHERE mhablent = '"
                      ||g_enterprise||"' AND mhabl001 = ?  AND mhabl002 = ? AND mhabl003 ='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhaa_d[l_ac].mhabl004 = g_rtn_fields[1]

                  DISPLAY BY NAME g_mhaa_d[l_ac].mhabl004
               END IF
               
               IF NOT cl_null(g_mhaa_d[l_ac].mhac003)  THEN
                  CALL n_mhaal(g_mhaa_d[l_ac].mhac003)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaa001
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhab002
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhac003

                  CALL ap_ref_array2(g_ref_fields," SELECT mhacl005,mhacl006 FROM mhacl_t WHERE mhaclent = '"
                      ||g_enterprise||"' AND mhacl001 = ?  AND mhacl002 = ? AND mhacl003 = ? AND mhacl004 ='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhaa_d[l_ac].mhacl005 = g_rtn_fields[1]

                  DISPLAY BY NAME g_mhaa_d[l_ac].mhacl005
               END IF
               
               IF NOT cl_null(g_mhaa_d[l_ac].mhad004)  THEN
                  CALL n_mhaal(g_mhaa_d[l_ac].mhad004)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaa001
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhab002
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhac003
                  LET g_ref_fields[1] = g_mhaa_d[l_ac].mhad004

                  CALL ap_ref_array2(g_ref_fields," SELECT mhadl006,mhadl007 FROM mhadl_t WHERE mhadlent = '"
                      ||g_enterprise||"' AND mhadl001 = ?  AND mhadl002 = ? AND mhadl003 = ? AND mhadl004 = ? AND mhadl005 ='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhaa_d[l_ac].mhadl006 = g_rtn_fields[1]

                  DISPLAY BY NAME g_mhaa_d[l_ac].mhadl006
               END IF
               #END add-point
            END IF
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amhi206_b_fill2(g_wc2)
            LET g_detail_cnt = g_mhaa_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_mhaa_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mhaa_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mhaa_d[l_ac].mhaasite IS NOT NULL
               AND g_mhaa_d[l_ac].mhaa001 IS NOT NULL
               AND g_mhaa_d[l_ac].mhab002 IS NOT NULL
               AND g_mhaa_d[l_ac].mhac003 IS NOT NULL
               AND g_mhaa_d[l_ac].mhad004 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_mhaa_d_t.* = g_mhaa_d[l_ac].*  #BACKUP
               LET g_mhaa_d_o.* = g_mhaa_d[l_ac].*  #BACKUP
#               CALL cl_set_comp_entry('mhaa001,mhab002,mhac003,mhad004',FALSE)
               IF NOT amhi206_lock("mhaa_t") THEN                                                          
                  LET l_lock_sw='Y'                 
               ELSE
                  FETCH amhi206_bcl INTO g_mhaa_d[l_ac].mhaasite,     g_mhaa_d[l_ac].mhaasite_desc,g_mhaa_d[l_ac].mhaaunit,
                                         g_mhaa_d[l_ac].mhaaunit_desc,g_mhaa_d[l_ac].mhaa001,      g_mhaa_d[l_ac].mhaal003, g_mhaa_d[l_ac].mhaa005,      
                                         g_mhaa_d[l_ac].mhaa006,      g_mhaa_d[l_ac].mhaa002,      g_mhaa_d[l_ac].mhaa003,
                                         g_mhaa_d[l_ac].mhaa004,      g_mhaa_d[l_ac].mhab001,      g_mhaa_d[l_ac].mhab002,
                                         g_mhaa_d[l_ac].mhabl004,     g_mhaa_d[l_ac].mhab006,      g_mhaa_d[l_ac].mhab007,
                                         g_mhaa_d[l_ac].mhab008,      g_mhaa_d[l_ac].mhab009,      g_mhaa_d[l_ac].mhab003,
                                         g_mhaa_d[l_ac].mhab004,      g_mhaa_d[l_ac].mhab005,      g_mhaa_d[l_ac].mhac001,
                                         g_mhaa_d[l_ac].mhac002,      g_mhaa_d[l_ac].mhac003,      g_mhaa_d[l_ac].mhacl005,
                                         g_mhaa_d[l_ac].mhac004,      g_mhaa_d[l_ac].mhac005,      g_mhaa_d[l_ac].mhac006,
                                         g_mhaa_d[l_ac].mhad001,      g_mhaa_d[l_ac].mhad002,      g_mhaa_d[l_ac].mhad003,
                                         #g_mhaa_d[l_ac].mhad004,      g_mhaa_d[l_ac].mhadl006,     g_mhaa_d[l_ac].mhad005,   #160506-00009#28 20160512 mark by beckxie
                                         g_mhaa_d[l_ac].mhad004,      g_mhaa_d[l_ac].mhadl006,     g_mhaa_d[l_ac].mhad010,g_mhaa_d[l_ac].mhad005,   #160506-00009#28 20160512 add by beckxie
                                         g_mhaa_d[l_ac].mhad006,      g_mhaa_d[l_ac].mhad007,      g_mhaa_d[l_ac].mhad008,
                                         g_mhaa_d[l_ac].mhadstus
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhaa_d_t.mhaasite 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  SELECT mhaaunit,mhaa001,mhaa002,mhaa003,mhaa004,mhaa005,mhaa006
                    INTO g_mhaa_d[l_ac].mhaaunit,
                         g_mhaa_d[l_ac].mhaa001,      g_mhaa_d[l_ac].mhaa002,      
                         g_mhaa_d[l_ac].mhaa003,      g_mhaa_d[l_ac].mhaa004,      
                         g_mhaa_d[l_ac].mhaa005,      g_mhaa_d[l_ac].mhaa006
                    FROM mhaa_t
                   WHERE mhaaent=g_enterprise
                     AND mhaasite=g_mhaa_d[l_ac].mhaasite
                     AND mhaa001=g_mhaa_d[l_ac].mhad001
                     
                 SELECT mhab001,mhab002,mhab003,mhab004,mhab005,mhab006,mhab007,mhab008,mhab009
                   INTO g_mhaa_d[l_ac].mhab001,      g_mhaa_d[l_ac].mhab002,
                        g_mhaa_d[l_ac].mhab003,      g_mhaa_d[l_ac].mhab004,
                        g_mhaa_d[l_ac].mhab005,      g_mhaa_d[l_ac].mhab006,      
                        g_mhaa_d[l_ac].mhab007,      g_mhaa_d[l_ac].mhab008,     g_mhaa_d[l_ac].mhab009
                   FROM mhab_t
                  WHERE mhabent=g_enterprise
                    AND mhabsite=g_mhaa_d[l_ac].mhaasite
                    AND mhab001=g_mhaa_d[l_ac].mhad001
                    AND mhab002=g_mhaa_d[l_ac].mhad002
                    
                    
                 SELECT mhac001,mhac002,mhac003,mhac004,mhac005,mhac006
                   INTO g_mhaa_d[l_ac].mhac001,   g_mhaa_d[l_ac].mhac002,    g_mhaa_d[l_ac].mhac003,     
                        g_mhaa_d[l_ac].mhac004,   g_mhaa_d[l_ac].mhac005,    g_mhaa_d[l_ac].mhac006
                   FROM mhac_t
                  WHERE mhacent=g_enterprise
                    AND mhacsite=g_mhaa_d[l_ac].mhaasite
                    AND mhac001=g_mhaa_d[l_ac].mhad001
                    AND mhac002=g_mhaa_d[l_ac].mhad002
                    AND mhac003=g_mhaa_d[l_ac].mhad003
                  
                  SELECT ooefl003 INTO g_mhaa_d[l_ac].mhaasite_desc FROM ooefl_t
                   WHERE ooeflent=g_enterprise AND ooefl001= g_mhaa_d[l_ac].mhaasite AND ooefl002=g_dlang
                 
                  SELECT ooefl003 INTO g_mhaa_d[l_ac].mhaaunit_desc FROM ooefl_t
                   WHERE ooeflent=g_enterprise AND ooefl001= g_mhaa_d[l_ac].mhaaunit AND ooefl002=g_dlang
                  
                  SELECT mhaal003 INTO g_mhaa_d[l_ac].mhaal003 FROM mhaal_t 
                   WHERE mhaalent=g_enterprise AND mhaal001=g_mhaa_d[l_ac].mhaa001 AND mhaal002=g_dlang
                   
                  SELECT mhabl004 INTO g_mhaa_d[l_ac].mhabl004 FROM mhabl_t 
                   WHERE mhablent=g_enterprise AND mhabl001=g_mhaa_d[l_ac].mhab001 AND mhabl002=g_mhaa_d[l_ac].mhab002 AND mhabl003=g_dlang
                   
                  SELECT mhacl005 INTO g_mhaa_d[l_ac].mhacl005 FROM mhacl_t
                   WHERE mhaclent=g_enterprise AND mhacl001=g_mhaa_d[l_ac].mhac001 AND mhacl002=g_mhaa_d[l_ac].mhac002
                     AND mhacl003=g_mhaa_d[l_ac].mhac003 AND mhacl004=g_dlang
                     
                 SELECT mhadl006 INTO g_mhaa_d[l_ac].mhadl006 FROM mhadl_t
                  WHERE mhadlent=g_enterprise AND mhadl001=g_mhaa_d[l_ac].mhad001 AND mhadl002=g_mhaa_d[l_ac].mhad002
                    AND mhadl003=g_mhaa_d[l_ac].mhad003 AND mhadl004=g_mhaa_d[l_ac].mhad004 AND mhadl005=g_dlang
                  
                       DISPLAY BY NAME  g_mhaa_d[l_ac].mhaasite,     g_mhaa_d[l_ac].mhaasite_desc,g_mhaa_d[l_ac].mhaaunit,
                                         g_mhaa_d[l_ac].mhaaunit_desc,g_mhaa_d[l_ac].mhaa001,      g_mhaa_d[l_ac].mhaal003, g_mhaa_d[l_ac].mhaa005,      
                                         g_mhaa_d[l_ac].mhaa006,      g_mhaa_d[l_ac].mhaa002,      g_mhaa_d[l_ac].mhaa003,
                                         g_mhaa_d[l_ac].mhaa004,      g_mhaa_d[l_ac].mhab001,      g_mhaa_d[l_ac].mhab002,
                                         g_mhaa_d[l_ac].mhabl004,     g_mhaa_d[l_ac].mhab006,      g_mhaa_d[l_ac].mhab007,
                                         g_mhaa_d[l_ac].mhab008,      g_mhaa_d[l_ac].mhab009,      g_mhaa_d[l_ac].mhab003,
                                         g_mhaa_d[l_ac].mhab004,      g_mhaa_d[l_ac].mhab005,      g_mhaa_d[l_ac].mhac001,
                                         g_mhaa_d[l_ac].mhac002,      g_mhaa_d[l_ac].mhac003,      g_mhaa_d[l_ac].mhacl005,
                                         g_mhaa_d[l_ac].mhac004,      g_mhaa_d[l_ac].mhac005,      g_mhaa_d[l_ac].mhac006,
                                         g_mhaa_d[l_ac].mhad001,      g_mhaa_d[l_ac].mhad002,      g_mhaa_d[l_ac].mhad003,
                                         #g_mhaa_d[l_ac].mhad004,      g_mhaa_d[l_ac].mhadl006,     g_mhaa_d[l_ac].mhad005,   #160506-00009#28 20160512 mark by beckxie
                                         g_mhaa_d[l_ac].mhad004,      g_mhaa_d[l_ac].mhadl006,     g_mhaa_d[l_ac].mhad010,g_mhaa_d[l_ac].mhad005,   #160506-00009#28 20160512 mark by beckxie
                                         g_mhaa_d[l_ac].mhad006,      g_mhaa_d[l_ac].mhad007,      g_mhaa_d[l_ac].mhad008 
                  #遮罩相關處理
                  LET g_mhaa_d_mask_o[l_ac].* =  g_mhaa_d[l_ac].*
                  CALL amhi206_mhaa_t_mask()
                  LET g_mhaa_d_mask_n[l_ac].* =  g_mhaa_d[l_ac].*
                  
                  CALL amhi206_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            LET g_detail_multi_table_t.mhaal001= g_mhaa_d[l_ac].mhaa001
            LET g_detail_multi_table_t.mhaal002= g_dlang
            LET g_detail_multi_table_t.mhaal003= g_mhaa_d[l_ac].mhaal003
            
            LET g_detail_multi_table_t.mhabl001= g_mhaa_d[l_ac].mhab001 
            LET g_detail_multi_table_t.mhabl002= g_mhaa_d[l_ac].mhab002 
            LET g_detail_multi_table_t.mhabl003= g_dlang 
            LET g_detail_multi_table_t.mhabl004= g_mhaa_d[l_ac].mhabl004 
            
            LET g_detail_multi_table_t.mhacl001= g_mhaa_d[l_ac].mhac001 
            LET g_detail_multi_table_t.mhacl002= g_mhaa_d[l_ac].mhac002 
            LET g_detail_multi_table_t.mhacl003= g_mhaa_d[l_ac].mhac003 
            LET g_detail_multi_table_t.mhacl004= g_dlang 
            LET g_detail_multi_table_t.mhacl005= g_mhaa_d[l_ac].mhacl005 
            
            LET g_detail_multi_table_t.mhadl001 = g_mhaa_d[l_ac].mhad001
            LET g_detail_multi_table_t.mhadl002 = g_mhaa_d[l_ac].mhad002
            LET g_detail_multi_table_t.mhadl003 = g_mhaa_d[l_ac].mhad003
            LET g_detail_multi_table_t.mhadl004 = g_mhaa_d[l_ac].mhad004
            LET g_detail_multi_table_t.mhadl005 = g_dlang
            LET g_detail_multi_table_t.mhadl006 = g_mhaa_d[l_ac].mhadl006
 
            #其他table進行lock
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            
            LET l_field_keys[01] = 'mhaalent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhaal001'
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhaa001
            LET l_field_keys[03] = 'mhaal002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhaal_t') THEN
               RETURN 
            END IF 
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL
            LET l_field_keys[01] = 'mhablent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhabl001'
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhab001
            LET l_field_keys[03] = 'mhabl002'
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhab002
            LET l_field_keys[04] = 'mhabl003'
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhab003
            LET l_field_keys[05] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhabl_t') THEN
               RETURN 
            END IF 
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL
            LET l_field_keys[01] = 'mhaclent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhacl001'
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhac001
            LET l_field_keys[03] = 'mhacl002'
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhac002
            LET l_field_keys[04] = 'mhacl003'
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhac003
            LET l_field_keys[05] = 'mhacl004'
            LET l_var_keys[05] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhacl_t') THEN
               RETURN 
            END IF 
            
            LET l_field_keys[01] = 'mhadlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhadl001'
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhad001
            LET l_field_keys[03] = 'mhadl002'
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhad002
            LET l_field_keys[04] = 'mhadl003'
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhad003
            LET l_field_keys[05] = 'mhadl004'
            LET l_var_keys[05] = g_mhaa_d[l_ac].mhad004
            LET l_field_keys[06] = 'mhadl005'
            LET l_var_keys[06] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhadl_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mhaa_d_t.* TO NULL
            INITIALIZE g_mhaa_d_o.* TO NULL
            INITIALIZE g_mhaa_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
            
            #161006-00008#2 20161019 add by beckxie---S
            CALL s_aooi500_default(g_prog,'mhaasite',g_mhaa_d[l_ac].mhaasite)
               RETURNING l_insert,g_mhaa_d[l_ac].mhaasite
            IF l_insert = FALSE THEN
               RETURN
            END IF
            CALL amhi206_mhaasite_ref()
            CALL s_aooi500_default(g_prog,'mhaaunit',g_mhaa_d[l_ac].mhaaunit)
               RETURNING l_insert,g_mhaa_d[l_ac].mhaaunit
            IF l_insert = FALSE THEN
               RETURN
            END IF
            CALL amhi206_mhaaunit_ref()
            #161006-00008#2 20161019 add by beckxie---E
            LET g_mhaa_d[l_ac].mhaa005 = "0"
            LET g_mhaa_d[l_ac].mhaa006 = "0"
            LET g_mhaa_d[l_ac].mhaa002 = "0"
            LET g_mhaa_d[l_ac].mhaa003 = "0"
            LET g_mhaa_d[l_ac].mhaa004 = "0"
            LET g_mhaa_d[l_ac].mhab006 = "0"
            LET g_mhaa_d[l_ac].mhab007 = "0"
            LET g_mhaa_d[l_ac].mhab003 = "0"
            LET g_mhaa_d[l_ac].mhab004 = "0"
            LET g_mhaa_d[l_ac].mhab005 = "0"
            LET g_mhaa_d[l_ac].mhac004 = "0"
            LET g_mhaa_d[l_ac].mhac005 = "0"
            LET g_mhaa_d[l_ac].mhac006 = "0"
            LET g_mhaa_d[l_ac].mhad005 = "0"
            LET g_mhaa_d[l_ac].mhad006 = "0"
            LET g_mhaa_d[l_ac].mhad007 = "0"
            LET g_mhaa_d[l_ac].mhad008 = "0"
            LET g_mhaa_d[l_ac].mhadstus= "Y"
            LET g_mhaa_d[l_ac].sel = "N"
            #add-point:modify段before備份
            
            #end add-point
            LET g_mhaa_d_t.* = g_mhaa_d[l_ac].*     #新輸入資料
            LET g_mhaa_d_o.* = g_mhaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amhi206_set_entry_b("a")
            CALL amhi206_set_no_entry_b("a")
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhaa_d[li_reproduce_target].* = g_mhaa_d[li_reproduce].*
 
               LET g_mhaa_d[g_mhaa_d.getLength()].mhaasite = NULL
               LET g_mhaa_d[g_mhaa_d.getLength()].mhaa001 = NULL
 
            END IF
            
            LET g_detail_multi_table_t.mhaal001= g_mhaa_d[l_ac].mhaa001
            LET g_detail_multi_table_t.mhaal002= g_dlang
            LET g_detail_multi_table_t.mhaal003= g_mhaa_d[l_ac].mhaal003
            
            LET g_detail_multi_table_t.mhabl001= g_mhaa_d[l_ac].mhab001 
            LET g_detail_multi_table_t.mhabl002= g_mhaa_d[l_ac].mhab002 
            LET g_detail_multi_table_t.mhabl003= g_dlang 
            LET g_detail_multi_table_t.mhabl004= g_mhaa_d[l_ac].mhabl004 
            
            LET g_detail_multi_table_t.mhacl001= g_mhaa_d[l_ac].mhac001 
            LET g_detail_multi_table_t.mhacl002= g_mhaa_d[l_ac].mhac002 
            LET g_detail_multi_table_t.mhacl003= g_mhaa_d[l_ac].mhac003 
            LET g_detail_multi_table_t.mhacl004= g_dlang 
            LET g_detail_multi_table_t.mhacl005= g_mhaa_d[l_ac].mhacl005
            
            LET g_detail_multi_table_t.mhadl001 = g_mhaa_d[l_ac].mhad001
            LET g_detail_multi_table_t.mhadl002 = g_mhaa_d[l_ac].mhad002
            LET g_detail_multi_table_t.mhadl003 = g_mhaa_d[l_ac].mhad003
            LET g_detail_multi_table_t.mhadl004 = g_mhaa_d[l_ac].mhad004
            LET g_detail_multi_table_t.mhadl005 = g_dlang
            LET g_detail_multi_table_t.mhadl006 = g_mhaa_d[l_ac].mhadl006
 
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
            SELECT COUNT(1) INTO l_count FROM mhad_t 
             WHERE mhadent = g_enterprise AND mhadsite = g_mhaa_d[l_ac].mhaasite
                                          AND mhad001 = g_mhaa_d[l_ac].mhad001
                                          AND mhad001 = g_mhaa_d[l_ac].mhad002
                                          AND mhad002 = g_mhaa_d[l_ac].mhad003
                                          AND mhad004 = g_mhaa_d[l_ac].mhad004 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
#               INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_mhaa_d[g_detail_idx].mhaasite
#               LET gs_keys[2] = g_mhaa_d[g_detail_idx].mhaa001
#               CALL amhi206_insert_b('mhaa_t',gs_keys,"'1'")

               CALL amhi206_insert_mhaa()
               CALL amhi206_insert_mhab()
               CALL amhi206_insert_mhac()
               CALL amhi206_insert_mhad()            
               #add-point:單身新增後
               
               #end add-point
           ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_mhaa_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
           END IF
 
           IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhaa_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
           ELSE
               #先刷新資料
               #CALL amhi206_b_fill(g_wc2)
               #資料多語言用-增/改
               INITIALIZE l_var_keys TO NULL 
               INITIALIZE l_field_keys TO NULL 
               INITIALIZE l_vars TO NULL 
               INITIALIZE l_fields TO NULL 
               INITIALIZE l_var_keys_bak TO NULL 
               IF g_mhaa_d[l_ac].mhaa001 = g_detail_multi_table_t.mhaal001 AND
                  g_mhaa_d[l_ac].mhaal003 = g_detail_multi_table_t.mhaal003 THEN
               ELSE 
                  LET l_var_keys[01] = g_enterprise
                  LET l_field_keys[01] = 'mhaalent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_var_keys[02] = g_mhaa_d[l_ac].mhaa001
                  LET l_field_keys[02] = 'mhaal001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhaal001
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'mhaal002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhaal002
                  LET l_vars[01] = g_mhaa_d[l_ac].mhaal003
                  LET l_fields[01] = 'mhaal003'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhaal_t')
              END IF 
              INITIALIZE l_var_keys TO NULL 
              INITIALIZE l_field_keys TO NULL 
              INITIALIZE l_vars TO NULL 
              INITIALIZE l_fields TO NULL 
              INITIALIZE l_var_keys_bak TO NULL 
              IF g_mhaa_d[l_ac].mhab001 = g_detail_multi_table_t.mhabl001 AND
                 g_mhaa_d[l_ac].mhab002 = g_detail_multi_table_t.mhabl002 AND
                 g_mhaa_d[l_ac].mhabl004 = g_detail_multi_table_t.mhabl004 THEN
              ELSE 
                 LET l_var_keys[01] = g_enterprise
                 LET l_field_keys[01] = 'mhablent'
                 LET l_var_keys_bak[01] = g_enterprise
                 LET l_var_keys[02] = g_mhaa_d[l_ac].mhab001
                 LET l_field_keys[02] = 'mhabl001'
                 LET l_var_keys_bak[02] = g_detail_multi_table_t.mhabl001
                 LET l_var_keys[03] = g_mhaa_d[l_ac].mhab002
                 LET l_field_keys[03] = 'mhabl002'
                 LET l_var_keys_bak[03] = g_detail_multi_table_t.mhabl002
                 LET l_var_keys[04] = g_dlang
                 LET l_field_keys[04] = 'mhabl003'
                 LET l_var_keys_bak[04] = g_detail_multi_table_t.mhabl003
                 LET l_vars[01] = g_mhaa_d[l_ac].mhabl004
                 LET l_fields[01] = 'mhabl004'
                 CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhabl_t')
              END IF 
              INITIALIZE l_var_keys TO NULL 
              INITIALIZE l_field_keys TO NULL 
              INITIALIZE l_vars TO NULL 
              INITIALIZE l_fields TO NULL 
              INITIALIZE l_var_keys_bak TO NULL 
              IF g_mhaa_d[l_ac].mhac001 = g_detail_multi_table_t.mhacl001 AND
                 g_mhaa_d[l_ac].mhac002 = g_detail_multi_table_t.mhacl002 AND
                 g_mhaa_d[l_ac].mhac003 = g_detail_multi_table_t.mhacl003 AND
                 g_mhaa_d[l_ac].mhacl005 = g_detail_multi_table_t.mhacl005 THEN
              ELSE 
                LET l_var_keys[01] = g_enterprise
                LET l_field_keys[01] = 'mhaclent'
                LET l_var_keys_bak[01] = g_enterprise
                LET l_var_keys[02] = g_mhaa_d[l_ac].mhac001
                LET l_field_keys[02] = 'mhacl001'
                LET l_var_keys_bak[02] = g_detail_multi_table_t.mhacl001
                LET l_var_keys[03] = g_mhaa_d[l_ac].mhac002
                LET l_field_keys[03] = 'mhacl002'
                LET l_var_keys_bak[03] = g_detail_multi_table_t.mhacl002
                LET l_var_keys[04] = g_mhaa_d[l_ac].mhac003
                LET l_field_keys[04] = 'mhacl003'
                LET l_var_keys_bak[04] = g_detail_multi_table_t.mhacl003
                LET l_var_keys[05] = g_dlang
                LET l_field_keys[05] = 'mhacl004'
                LET l_var_keys_bak[05] = g_detail_multi_table_t.mhacl004
                LET l_vars[01] = g_mhaa_d[l_ac].mhacl005
                LET l_fields[01] = 'mhacl005'
                CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhacl_t')
              END IF 
              INITIALIZE l_var_keys TO NULL 
              INITIALIZE l_field_keys TO NULL 
              INITIALIZE l_vars TO NULL 
              INITIALIZE l_fields TO NULL 
              INITIALIZE l_var_keys_bak TO NULL 
              IF g_mhaa_d[l_ac].mhad001 = g_detail_multi_table_t.mhadl001 AND
                 g_mhaa_d[l_ac].mhad002 = g_detail_multi_table_t.mhadl002 AND
                 g_mhaa_d[l_ac].mhad003 = g_detail_multi_table_t.mhadl003 AND
                 g_mhaa_d[l_ac].mhad004 = g_detail_multi_table_t.mhadl004 AND
                 g_mhaa_d[l_ac].mhadl006 = g_detail_multi_table_t.mhadl006 THEN
              ELSE 
                 LET l_var_keys[01] = g_enterprise
                 LET l_field_keys[01] = 'mhadlent'
                 LET l_var_keys_bak[01] = g_enterprise
                 LET l_var_keys[02] = g_mhaa_d[l_ac].mhad001
                 LET l_field_keys[02] = 'mhadl001'
                 LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
                 LET l_var_keys[03] = g_mhaa_d[l_ac].mhad002
                 LET l_field_keys[03] = 'mhadl002'
                 LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
                 LET l_var_keys[04] = g_mhaa_d[l_ac].mhad003
                 LET l_field_keys[04] = 'mhadl003'
                 LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
                 LET l_var_keys[05] = g_mhaa_d[l_ac].mhad004
                 LET l_field_keys[05] = 'mhadl004'
                 LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
                 LET l_var_keys[06] = g_dlang
                 LET l_field_keys[06] = 'mhadl005'
                 LET l_var_keys_bak[06] = g_detail_multi_table_t.mhadl005
                 LET l_vars[01] = g_mhaa_d[l_ac].mhadl006
                 LET l_fields[01] = 'mhadl006'
                 CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhadl_t')
              END IF 
 
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (mhaasite = '", g_mhaa_d[l_ac].mhaasite, "' "
                                  ," AND mhaa001 = '", g_mhaa_d[l_ac].mhaa001, "' "
 
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
               
#               DELETE FROM mhaa_t
#                WHERE mhaaent = g_enterprise AND 
#                      mhaasite = g_mhaa_d_t.mhaasite
#                      AND mhaa001 = g_mhaa_d_t.mhaa001
 
                      
               #add-point:單身刪除中
               DELETE FROM mhad_t
                WHERE mhadent=g_enterprise
                  AND mhadsite=g_mhaa_d_t.mhaasite
                  AND mhad001=g_mhaa_d_t.mhad001
                  AND mhad002=g_mhaa_d_t.mhad002
                  AND mhad003=g_mhaa_d_t.mhad003
                  AND mhad004=g_mhaa_d_t.mhad004
               #end add-point  
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "del mhad_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
                  LET l_field_keys[03] = 'mhadl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
                  LET l_field_keys[04] = 'mhadl003'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
                  LET l_field_keys[05] = 'mhadl004'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhadl_t')
 
                  #add-point:單身刪除後

                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL amhi206_set_pk_array()
                  IF NOT cl_log_modified_record('','') THEN 
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE amhi206_bcl
               #add-point:單身關閉bcl

               #end add-point
               LET l_count = g_mhaa_d.getLength()
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhaa_d_t.mhaasite
               LET gs_keys[2] = g_mhaa_d_t.mhaa001
 
               #應用 a47 樣板自動產生(Version:2)
               #刪除相關文件
               CALL amhi206_set_pk_array()
               #add-point:相關文件刪除前

               #end add-point   
               CALL cl_doc_remove()  
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2
               
               #end add-point
  #             CALL amhi206_delete_mhad()
            END IF
            #如果是最後一筆
            IF l_ac = (g_mhaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3

            #end add-point
 
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaasite
            
            #add-point:AFTER FIELD mhaasite
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhaa001 != g_mhaa_d_t.mhaa001)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhaa_t WHERE "||"mhaaent = '" ||g_enterprise|| "' AND "||"mhaasite = '"||g_mhaa_d[g_detail_idx].mhaasite ||"' AND "|| "mhaa001 = '"||g_mhaa_d[g_detail_idx].mhaa001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
             

            IF NOT cl_null(g_mhaa_d[l_ac].mhaasite) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhaasite
#               LET g_chkparam.arg2 = '參數2'
#               LET g_chkparam.arg3 = 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooed004") THEN
#                  #檢查成功時後續處理
#                  
#               ELSE
#                  #檢查失敗時後續處理
#                  
#                  NEXT FIELD CURRENT
#               END IF
                #161006-00008#2 20161019 add by beckxie---S
                CALL s_aooi500_chk(g_prog,'mhaasite',g_mhaa_d[l_ac].mhaasite,g_site) RETURNING l_success,l_errno
                IF NOT l_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = l_errno
                   LET g_errparam.extend = g_mhaa_d[l_ac].mhaasite
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()                        
                   LET g_mhaa_d[l_ac].mhaasite = g_mhaa_d_t.mhaasite
                   CALL amhi206_mhaasite_ref()
                   NEXT FIELD CURRENT
                END IF                     
                #161006-00008#2 20161019 add by beckxie---E
            END IF 
            #161006-00008#2 20161019 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaasite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mhaa_d[l_ac].mhaasite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mhaa_d[l_ac].mhaasite_desc
            #161006-00008#2 20161019 mark by beckxie---E
            CALL amhi206_mhaasite_ref()   #161006-00008#2 20161019 add by beckxie
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaasite
            #add-point:BEFORE FIELD mhaasite

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaasite
            #add-point:ON CHANGE mhaasite

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaaunit
            
            #add-point:AFTER FIELD mhaaunit
            IF NOT cl_null(g_mhaa_d[l_ac].mhaaunit) THEN 
#               #應用 a17 樣板自動產生(Version:2)
#               #欄位存在檢查
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhaaunit
#               LET g_chkparam.arg2 = '參數2'
#               LET g_chkparam.arg3 = 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooed004") THEN
#                  #檢查成功時後續處理
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
                #161006-00008#2 20161019 add by beckxie---S
                CALL s_aooi500_chk(g_prog,'mhaaunit',g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaasite) RETURNING l_success,l_errno
                IF NOT l_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = l_errno
                   LET g_errparam.extend = g_mhaa_d[l_ac].mhaaunit
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()                        
                   LET g_mhaa_d[l_ac].mhaaunit = g_mhaa_d_t.mhaaunit
                   CALL amhi206_mhaaunit_ref()
                   NEXT FIELD CURRENT
                END IF                     
                #161006-00008#2 20161019 add by beckxie---E

            END IF 
            #161006-00008#2 20161019 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaaunit
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mhaa_d[l_ac].mhaaunit_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mhaa_d[l_ac].mhaaunit_desc
            #161006-00008#2 20161019 mark by beckxie---E
            CALL amhi206_mhaaunit_ref()   #161006-00008#2 20161019 add by beckxie

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaaunit
            #add-point:BEFORE FIELD mhaaunit

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaaunit
            #add-point:ON CHANGE mhaaunit

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa001
            #add-point:BEFORE FIELD mhaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa001
            
            #add-point:AFTER FIELD mhaa001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhaa001 != g_mhaa_d_t.mhaa001)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhaa_t WHERE "||"mhaaent = '" ||g_enterprise|| "' AND "||"mhaasite = '"||g_mhaa_d[g_detail_idx].mhaasite ||"' AND "|| "mhaa001 = '"||g_mhaa_d[g_detail_idx].mhaa001 ||"'",'std-00004',0) THEN 
                   SELECT COUNT(*) INTO l_cnt FROM mhaa_t WHERE mhaaent=g_enterprise
                      AND  mhaasite=g_mhaa_d[l_ac].mhaasite
                      AND  mhaa001=g_mhaa_d[l_ac].mhaa001
                      
                   IF l_cnt>0 THEN                      
#                     LET g_mhaa001=TRUE
                     CALL cl_set_comp_entry('mhaa005,mhaa006,mhaa002,mhaa003,mhaa004',FALSE)
                     SELECT mhaa002,mhaa003,mhaa004,mhaa005,mhaa006,mhaal003
                       INTO g_mhaa_d[l_ac].mhaa002,g_mhaa_d[l_ac].mhaa003,g_mhaa_d[l_ac].mhaa004,
                            g_mhaa_d[l_ac].mhaa005,g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaal003
                       FROM mhaa_t,mhaal_t
                      WHERE mhaaent=mhaalent
                        AND mhaa001=mhaal001
                        AND mhaaent=g_enterprise
                        AND mhaasite=g_mhaa_d[l_ac].mhaasite
                        AND mhaa001=g_mhaa_d[l_ac].mhaa001
                     
                     DISPLAY BY NAME g_mhaa_d[l_ac].mhaa002,g_mhaa_d[l_ac].mhaa003,
                                     g_mhaa_d[l_ac].mhaa004,g_mhaa_d[l_ac].mhaa005,
                                     g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaal003
                  ELSE
                    LET g_mhaa_d[l_ac].mhab001=g_mhaa_d[l_ac].mhaa001
                    LET g_mhaa_d[l_ac].mhac001=g_mhaa_d[l_ac].mhaa001
                    LET g_mhaa_d[l_ac].mhad001=g_mhaa_d[l_ac].mhaa001    
                 END IF
                 LET g_mhaa_d[l_ac].mhab001=g_mhaa_d[l_ac].mhaa001
                 LET g_mhaa_d[l_ac].mhac001=g_mhaa_d[l_ac].mhaa001
                 LET g_mhaa_d[l_ac].mhad001=g_mhaa_d[l_ac].mhaa001 
                  
               END IF
            END IF  
            
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaa001
            #add-point:ON CHANGE mhaa001

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaal003
            #add-point:BEFORE FIELD mhaal003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaal003
            
            #add-point:AFTER FIELD mhaal003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaal003
            #add-point:ON CHANGE mhaal003

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa005
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhaa005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhaa005
            END IF 


           #add-point:AFTER FIELD mhaa005
            IF NOT cl_null(g_mhaa_d[l_ac].mhaa005) THEN 
               
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa005
            #add-point:BEFORE FIELD mhaa005

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaa005
            #add-point:ON CHANGE mhaa005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa006
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhaa006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhaa006
            END IF 
 
 
            #add-point:AFTER FIELD mhaa006
            IF NOT cl_null(g_mhaa_d[l_ac].mhaa006) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa006
            #add-point:BEFORE FIELD mhaa006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaa006
            #add-point:ON CHANGE mhaa006

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa002
            #add-point:BEFORE FIELD mhaa002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa002
            
            #add-point:AFTER FIELD mhaa002

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaa002
            #add-point:ON CHANGE mhaa002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa003
            #add-point:BEFORE FIELD mhaa003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa003
            
            #add-point:AFTER FIELD mhaa003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaa003
            #add-point:ON CHANGE mhaa003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa004
            #add-point:BEFORE FIELD mhaa004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa004
            
            #add-point:AFTER FIELD mhaa004

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhaa004
            #add-point:ON CHANGE mhaa004

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab001
            
            #add-point:AFTER FIELD mhab001
            IF NOT cl_null(g_mhaa_d[l_ac].mhab001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhab001
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab001
            #add-point:BEFORE FIELD mhab001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab001
            #add-point:ON CHANGE mhab001

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab002
            #add-point:BEFORE FIELD mhab002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab002
            
            #add-point:AFTER FIELD mhab002
            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhab002 != g_mhaa_d_t.mhab002)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhab_t WHERE "||"mhabent = '" ||g_enterprise|| 
#                                                                      "' AND "||"mhab001 = '"||g_mhaa_d[g_detail_idx].mhab001 ||
#                                                                      "' AND "||"mhab002 = '"||g_mhaa_d[g_detail_idx].mhab002 || "'",'std-00004',0) THEN 
                  SELECT COUNT(*) INTO l_cnt FROM mhab_t
                  WHERE mhabent=g_enterprise AND mhabsite=g_mhaa_d[l_ac].mhaasite
                    AND mhab001=g_mhaa_d[l_ac].mhab001 AND mhab002=g_mhaa_d[l_ac].mhab002
                     
                  IF l_cnt > 0 THEN
  #                   LET g_mhab002=TRUE
                     SELECT mhab003,mhab004,mhab005,mhab006,mhab007,mhab008,mhab009,mhabl004
                       INTO g_mhaa_d[l_ac].mhab003,g_mhaa_d[l_ac].mhab004,g_mhaa_d[l_ac].mhab005,
                            g_mhaa_d[l_ac].mhab006,g_mhaa_d[l_ac].mhab007,g_mhaa_d[l_ac].mhab008,
                            g_mhaa_d[l_ac].mhab009,g_mhaa_d[l_ac].mhabl004
                       FROM mhab_t,mhabl_t
                      WHERE mhabent=mhablent
                        AND mhab001=mhabl001
                        AND mhab002=mhabl002
                        AND mhab003=g_dlang
                        AND mhabent=g_enterprise
                        AND mhabsite=g_mhaa_d[l_ac].mhaasite
                        AND mhab001=g_mhaa_d[l_ac].mhab001
                        AND mhab002=g_mhaa_d[l_ac].mhab002
                     
                     DISPLAY BY NAME g_mhaa_d[l_ac].mhab003,g_mhaa_d[l_ac].mhab004,g_mhaa_d[l_ac].mhab005,
                                     g_mhaa_d[l_ac].mhab006,g_mhaa_d[l_ac].mhab007,g_mhaa_d[l_ac].mhab008,
                                     g_mhaa_d[l_ac].mhab009
                 ELSE
                     LET g_mhaa_d[l_ac].mhac002=g_mhaa_d[l_ac].mhab002
                     LET g_mhaa_d[l_ac].mhad002=g_mhaa_d[l_ac].mhab002
                 END IF
                 LET g_mhaa_d[l_ac].mhac002=g_mhaa_d[l_ac].mhab002
                 LET g_mhaa_d[l_ac].mhad002=g_mhaa_d[l_ac].mhab002
               END IF
            END IF
            
           
           
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab002
            #add-point:ON CHANGE mhab002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhabl004
            #add-point:BEFORE FIELD mhabl004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhabl004
            
            #add-point:AFTER FIELD mhabl004

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhabl004
            #add-point:ON CHANGE mhabl004

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab006
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內 
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab006
            END IF
 
            #add-point:AFTER FIELD mhab006
            IF NOT cl_null(g_mhaa_d[l_ac].mhab006) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab006
            #add-point:BEFORE FIELD mhab006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab006
            #add-point:ON CHANGE mhab006

            #END add-point 
       
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab007
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab007
            END IF 
 
 
            #add-point:AFTER FIELD mhab007
            IF NOT cl_null(g_mhaa_d[l_ac].mhab007) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab007
            #add-point:BEFORE FIELD mhab007

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab007
            #add-point:ON CHANGE mhab007

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab008
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab008
            END IF 
 
 
            #add-point:AFTER FIELD mhab008
            IF NOT cl_null(g_mhaa_d[l_ac].mhab008) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab008
            #add-point:BEFORE FIELD mhab008

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab008
            #add-point:ON CHANGE mhab008

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab009
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhab009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhab009
            END IF 
 
 
            #add-point:AFTER FIELD mhab009
            IF NOT cl_null(g_mhaa_d[l_ac].mhab009) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab009
            #add-point:BEFORE FIELD mhab009

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab009
            #add-point:ON CHANGE mhab009

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab003
            #add-point:BEFORE FIELD mhab003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab003
            
            #add-point:AFTER FIELD mhab003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab003
            #add-point:ON CHANGE mhab003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab004
            #add-point:BEFORE FIELD mhab004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab004
            
            #add-point:AFTER FIELD mhab004

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab004
            #add-point:ON CHANGE mhab004

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab005
            #add-point:BEFORE FIELD mhab005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab005
            
            #add-point:AFTER FIELD mhab005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhab005
            #add-point:ON CHANGE mhab005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac001
            
            #add-point:AFTER FIELD mhac001
            IF NOT cl_null(g_mhaa_d[l_ac].mhac001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhac001
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac001
            #add-point:BEFORE FIELD mhac001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhac001
            #add-point:ON CHANGE mhac001

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac002
            
            #add-point:AFTER FIELD mhac002
            IF NOT cl_null(g_mhaa_d[l_ac].mhac002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhac002
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhab002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac002
            #add-point:BEFORE FIELD mhac002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhac002
            #add-point:ON CHANGE mhac002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac003
            #add-point:BEFORE FIELD mhac003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac003
            
            #add-point:AFTER FIELD mhac003
            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhac003 != g_mhaa_d_t.mhac003)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhac_t WHERE "||"mhacent = '" ||g_enterprise|| 
#                                                                      "' AND "||"mhac001 = '"||g_mhaa_d[g_detail_idx].mhac001 ||
#                                                                      "' AND "||"mhac002 = '"||g_mhaa_d[g_detail_idx].mhac002 ||
#                                                                      "' AND "||"mhac003 = '"||g_mhaa_d[g_detail_idx].mhac003 ||"'",'std-00004',0) THEN  
                 SELECT count(*) INTO l_cnt FROM mhac_t
                   WHERE mhacent=g_enterprise AND mhacsite=g_mhaa_d[l_ac].mhaasite
                     AND mhac001=g_mhaa_d[l_ac].mhac001
                     AND mhac002=g_mhaa_d[l_ac].mhac002
                     AND mhac003=g_mhaa_d[l_ac].mhac003
                 IF l_cnt > 0 THEN
 #                    LET g_mhac003=TRUE
                     SELECT mhac004.mhac005,mhac006,mhacl005
                       INTO g_mhaa_d[l_ac].mhac004,g_mhaa_d[l_ac].mhac005,g_mhaa_d[l_ac].mhac006,
                            g_mhaa_d[l_ac].mhacl005
                       FROM mhac_t,mhacl_t
                      WHERE mhacent=mhaclent
                        AND mhac001=mhacl001
                        AND mhac002=mhacl002
                        AND mhac003=mhacl003
                        AND mhacl004=g_dlang
                        AND mhacent=g_enterprise
                        AND mhacsite=g_mhaa_d[l_ac].mhaasite
                        AND mhac001=g_mhaa_d[l_ac].mhac001
                        AND mhac002=g_mhaa_d[l_ac].mhac002
                        AND mhac003=g_mhaa_d[l_ac].mhac003
                     
                     DISPLAY BY NAME g_mhaa_d[l_ac].mhac004,g_mhaa_d[l_ac].mhac005,g_mhaa_d[l_ac].mhac006,
                                     g_mhaa_d[l_ac].mhacl005
                      
                 ELSE
                     LET g_mhaa_d[l_ac].mhad003=g_mhaa_d[l_ac].mhac003
                 END IF
                 LET g_mhaa_d[l_ac].mhad003=g_mhaa_d[l_ac].mhac003
              END IF
            END IF
            
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhac003
            #add-point:ON CHANGE mhac003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhacl005
            #add-point:BEFORE FIELD mhacl005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhacl005
            
            #add-point:AFTER FIELD mhacl005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhacl005
            #add-point:ON CHANGE mhacl005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac004
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhac004,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhac004
            END IF 
 
 
            #add-point:AFTER FIELD mhac004
            IF NOT cl_null(g_mhaa_d[l_ac].mhac004) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac004
            #add-point:BEFORE FIELD mhac004

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhac004
            #add-point:ON CHANGE mhac004

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac005
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhac005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhac005
            END IF 
 
 
            #add-point:AFTER FIELD mhac005
            IF NOT cl_null(g_mhaa_d[l_ac].mhac005) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac005
            #add-point:BEFORE FIELD mhac005

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhac005
            #add-point:ON CHANGE mhac005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac006
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhac006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhac006
            END IF 
 
 
            #add-point:AFTER FIELD mhac006
            IF NOT cl_null(g_mhaa_d[l_ac].mhac006) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac006
            #add-point:BEFORE FIELD mhac006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhac006
            #add-point:ON CHANGE mhac006

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad001
            
            #add-point:AFTER FIELD mhad001
            IF NOT cl_null(g_mhaa_d[l_ac].mhad001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhad001
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad001
            #add-point:BEFORE FIELD mhad001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad001
            #add-point:ON CHANGE mhad001

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad002
            
            #add-point:AFTER FIELD mhad002
            IF NOT cl_null(g_mhaa_d[l_ac].mhad002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mhaa_d[l_ac].mhad002
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhab002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad002
            #add-point:BEFORE FIELD mhad002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad002
            #add-point:ON CHANGE mhad002

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad003
            #add-point:BEFORE FIELD mhad003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad003
            
            #add-point:AFTER FIELD mhad003

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad003
            #add-point:ON CHANGE mhad003

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad004
            #add-point:BEFORE FIELD mhad004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad004
            
            #add-point:AFTER FIELD mhad004
            IF  g_mhaa_d[g_detail_idx].mhaasite IS NOT NULL AND g_mhaa_d[g_detail_idx].mhaa001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhaa_d[g_detail_idx].mhaasite != g_mhaa_d_t.mhaasite OR g_mhaa_d[g_detail_idx].mhad004 != g_mhaa_d_t.mhad004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhad_t WHERE "||"mhadent = '" ||g_enterprise|| 
                                                                      "' AND "||"mhadsite = '"||g_mhaa_d[g_detail_idx].mhaasite ||
                                                                      "' AND "||"mhad001 = '"||g_mhaa_d[g_detail_idx].mhad001 ||
                                                                      "' AND "||"mhad002 = '"||g_mhaa_d[g_detail_idx].mhad002 ||
                                                                      "' AND "||"mhad003 = '"||g_mhaa_d[g_detail_idx].mhad003 ||
                                                                      "' AND "||"mhad004 = '"||g_mhaa_d[g_detail_idx].mhad004 ||"'",'std-00004',0) THEN                      
                     LET g_mhaa_d[l_ac].mhad004 = g_mhaa_d_t.mhad004
                     NEXT FIELD CURRENT                   
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad004
            #add-point:ON CHANGE mhad004

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhadl006
            #add-point:BEFORE FIELD mhadl006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhadl006
            
            #add-point:AFTER FIELD mhadl006

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhadl006
            #add-point:ON CHANGE mhadl006

            #END add-point 
         #160506-00009#28 20160512 add by beckxie---S   
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhad010
            
            #add-point:AFTER FIELD mhad010 name="input.a.page1.mhad010"
            IF NOT cl_null(g_mhaa_d[l_ac].mhad010) THEN 
               IF g_mhaa_d[l_ac].mhad010 != g_mhaa_d_o.mhad010 OR g_mhaa_d_o.mhad010 IS NULL  THEN
                  #應用 a17 樣板自動產生(Version:3)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  IF NOT s_azzi650_chk_exist('2145',g_mhaa_d[l_ac].mhad010) THEN
                     LET g_mhaa_d[l_ac].mhad010 = g_mhaa_d_o.mhad010
                     CALL s_desc_get_acc_desc('2145',g_mhaa_d[l_ac].mhad010)  RETURNING g_mhaa_d[l_ac].mhad010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            CALL s_desc_get_acc_desc('2145',g_mhaa_d[l_ac].mhad010)  RETURNING g_mhaa_d[l_ac].mhad010_desc
            DISPLAY BY NAME g_mhaa_d[l_ac].mhad010_desc
            LET g_mhaa_d_o.mhad010 = g_mhaa_d[l_ac].mhad010
            
            #END add-point
         #160506-00009#28 20160512 add by beckxie---E
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad005
            #add-point:BEFORE FIELD mhad005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad005
            
            #add-point:AFTER FIELD mhad005

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad005
            #add-point:ON CHANGE mhad005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad006
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhad006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhad006
            END IF 
 
 
            #add-point:AFTER FIELD mhad006
            IF NOT cl_null(g_mhaa_d[l_ac].mhad006) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_mhaa_d[l_ac].mhad006 != g_mhaa_d_t.mhad006 OR g_mhaa_d_t.mhad006 IS null)) THEN 
                  CALL amhi206_count_mhad005()
 #                 CALL amhi206_chk_mhad006() RETURNING l_success
#                  IF l_success=false THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mhaa_d[l_ac].mhad006
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_mhaa_d[l_ac].mhad006=g_mhaa_d_t.mhad006
#                     CALL amhi206_count_mhad005()
#                     NEXT FIELD mhad006
#                  END IF
              END IF
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad006
            #add-point:BEFORE FIELD mhad006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad006
            #add-point:ON CHANGE mhad006

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad007
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mhaa_d[l_ac].mhad007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mhad007
            END IF 
 
 
            #add-point:AFTER FIELD mhad007
            IF NOT cl_null(g_mhaa_d[l_ac].mhad007) THEN 
              
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_mhaa_d[l_ac].mhad007 != g_mhaa_d_t.mhad007 OR g_mhaa_d_t.mhad007 IS null)) THEN 
                  CALL amhi206_count_mhad007()
      #            CALL amhi204_chk_mhad006() RETURNING l_success
#                  IF l_success=false THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mhaa_d[l_ac].mhad007
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     let g_mhaa_d[l_ac].mhad007=g_mhaa_d_t.mhad007
#                     CALL amhi206_count_mhad007()
#                     NEXT FIELD mhad007
#                  END IF
               END IF
            
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad007
            #add-point:BEFORE FIELD mhad007

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad007
            #add-point:ON CHANGE mhad007

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad008
            #add-point:BEFORE FIELD mhad008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad008
            
            #add-point:AFTER FIELD mhad008

            #END add-point
          
        AFTER FIELD sel
             LET g_mhaa_d[g_detail_idx].sel=GET_FLDBUF(sel)        
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE mhad008
            #add-point:ON CHANGE mhad008

            #END add-point 
 
 
                  #Ctrlp:input.c.page1.mhaasite
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaasite
            #add-point:ON ACTION controlp INFIELD mhaasite
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhaasite             #給予default值
            LET g_qryparam.default2 = "" #g_mhaa_d[l_ac].ooed004 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhaasite',g_site,'i') #161006-00008#2 20161019 add by beckxie
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhaasite = g_qryparam.return1              
            #LET g_mhaa_d[l_ac].ooed004 = g_qryparam.return2 
            DISPLAY g_mhaa_d[l_ac].mhaasite TO mhaasite              #
            #DISPLAY g_mhaa_d[l_ac].ooed004 TO ooed004 #組織編號
            NEXT FIELD mhaasite                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhaaunit
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaaunit
            #add-point:ON ACTION controlp INFIELD mhaaunit
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhaaunit             #給予default值
            LET g_qryparam.default2 = "" #g_mhaa_d[l_ac].ooed004 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhaaunit',g_site,'i') #161006-00008#2 20161019 add by beckxie
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhaaunit = g_qryparam.return1              
            #LET g_mhaa_d[l_ac].ooed004 = g_qryparam.return2 
            DISPLAY g_mhaa_d[l_ac].mhaaunit TO mhaaunit              #
            #DISPLAY g_mhaa_d[l_ac].ooed004 TO ooed004 #組織編號
            NEXT FIELD mhaaunit                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa001
            #add-point:ON ACTION controlp INFIELD mhaa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhaa001             #給予default值
            LET g_qryparam.where = "mhaasite ='",g_mhaa_d[l_ac].mhaasite,"' "
            #給予arg
            CALL q_mhaa001()                                #呼叫開窗
            LET g_mhaa_d[l_ac].mhaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_mhaa_d[l_ac].mhaa001 TO mhaa001              #顯示到畫面上
            NEXT FIELD mhaa001                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page1.mhaal003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaal003
            #add-point:ON ACTION controlp INFIELD mhaal003

            #END add-point
 
         #Ctrlp:input.c.page1.mhaa005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa005
            #add-point:ON ACTION controlp INFIELD mhaa005

            #END add-point
 
         #Ctrlp:input.c.page1.mhaa006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa006
            #add-point:ON ACTION controlp INFIELD mhaa006

            #END add-point
 
         #Ctrlp:input.c.page1.mhaa002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa002
            #add-point:ON ACTION controlp INFIELD mhaa002

            #END add-point
 
         #Ctrlp:input.c.page1.mhaa003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa003
            #add-point:ON ACTION controlp INFIELD mhaa003

            #END add-point
 
         #Ctrlp:input.c.page1.mhaa004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa004
            #add-point:ON ACTION controlp INFIELD mhaa004

            #END add-point
 
         #Ctrlp:input.c.page1.mhab001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab001
            #add-point:ON ACTION controlp INFIELD mhab001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhab001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhab001 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhab001 TO mhab001              #

            NEXT FIELD mhab001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhab002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab002
            #add-point:ON ACTION controlp INFIELD mhab002
            INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where =" mhab001 = '",g_mhaa_d[l_ac].mhaa001
            CALL q_mhab002()                           #呼叫開窗
            LET g_mhaa_d[l_ac].mhab002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_mhaa_d[l_ac].mhab002 TO mhab002              #顯示到畫面上
 #           DISPLAY g_qryparam.return1 TO mhab002  #顯示到畫面上

            NEXT FIELD mhab002                     #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page1.mhabl004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhabl004
            #add-point:ON ACTION controlp INFIELD mhabl004

            #END add-point
 
         #Ctrlp:input.c.page1.mhab006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab006
            #add-point:ON ACTION controlp INFIELD mhab006

            #END add-point
 
         #Ctrlp:input.c.page1.mhab007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab007
            #add-point:ON ACTION controlp INFIELD mhab007

            #END add-point
 
         #Ctrlp:input.c.page1.mhab008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab008
            #add-point:ON ACTION controlp INFIELD mhab008

            #END add-point
 
         #Ctrlp:input.c.page1.mhab009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab009
            #add-point:ON ACTION controlp INFIELD mhab009

            #END add-point
 
         #Ctrlp:input.c.page1.mhab003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab003
            #add-point:ON ACTION controlp INFIELD mhab003

            #END add-point
 
         #Ctrlp:input.c.page1.mhab004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab004
            #add-point:ON ACTION controlp INFIELD mhab004

            #END add-point
 
         #Ctrlp:input.c.page1.mhab005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab005
            #add-point:ON ACTION controlp INFIELD mhab005

            #END add-point
 
         #Ctrlp:input.c.page1.mhac001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac001
            #add-point:ON ACTION controlp INFIELD mhac001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhac001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhac001 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhac001 TO mhac001              #

            NEXT FIELD mhac001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhac002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac002
            #add-point:ON ACTION controlp INFIELD mhac002
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhac002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhab002()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhac002 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhac002 TO mhac002              #

            NEXT FIELD mhac002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhac003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac003
            #add-point:ON ACTION controlp INFIELD mhac003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160711-00033#1 Add By ken 160713
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.WHERE=" mhac001='",g_mhaa_d[l_ac].mhaa001,"' AND mhac002 ='",g_mhaa_d[l_ac].mhab002,"'"
            CALL q_mhac003()                           #呼叫開窗
            LET g_mhaa_d[l_ac].mhac003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_mhaa_d[l_ac].mhac003 TO mhac003              #顯示到畫面上
 #           DISPLAY g_qryparam.return1 TO mhac003  #顯示到畫面上

            NEXT FIELD mhac003                     #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page1.mhacl005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhacl005
            #add-point:ON ACTION controlp INFIELD mhacl005

            #END add-point
 
         #Ctrlp:input.c.page1.mhac004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac004
            #add-point:ON ACTION controlp INFIELD mhac004

            #END add-point
 
         #Ctrlp:input.c.page1.mhac005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac005
            #add-point:ON ACTION controlp INFIELD mhac005

            #END add-point
 
         #Ctrlp:input.c.page1.mhac006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac006
            #add-point:ON ACTION controlp INFIELD mhac006

            #END add-point
 
         #Ctrlp:input.c.page1.mhad001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad001
            #add-point:ON ACTION controlp INFIELD mhad001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhaa001()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhad001 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhad001 TO mhad001              #

            NEXT FIELD mhad001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhad002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad002
            #add-point:ON ACTION controlp INFIELD mhad002
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhab002()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhad002 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhad002 TO mhad002              #

            NEXT FIELD mhad002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhad003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad003
            #add-point:ON ACTION controlp INFIELD mhad003
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhac003()                                #呼叫開窗

            LET g_mhaa_d[l_ac].mhad003 = g_qryparam.return1              

            DISPLAY g_mhaa_d[l_ac].mhad003 TO mhad003              #

            NEXT FIELD mhad003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.mhad004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad004
            #add-point:ON ACTION controlp INFIELD mhad004
            INITIALIZE g_qryparam.* TO NULL
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.WHERE = " mhad001='",g_mhaa_d[l_ac].mhaa001,"' AND mhad002 = '",g_mhaa_d[l_ac].mhab002,"' AND mhad003 ='",g_mhaa_d[l_ac].mhac003,"'"
            CALL q_mhad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad004  #顯示到畫面上

            NEXT FIELD mhad004                     #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page1.mhadl006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhadl006
            #add-point:ON ACTION controlp INFIELD mhadl006

            #END add-point
            
         #160506-00009#28 20160512 add by beckxie---S   
         #Ctrlp:input.c.page1.mhad010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad010
            #add-point:ON ACTION controlp INFIELD mhad010 name="input.c.page1.mhad010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhaa_d[l_ac].mhad010             #給予default值
            LET g_qryparam.default2 = "" #g_mhaa_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '2145' #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_mhaa_d[l_ac].mhad010 = g_qryparam.return1              
            #LET g_mhaa_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_mhaa_d[l_ac].mhad010 TO mhad010              #
            CALL s_desc_get_acc_desc('2145',g_mhaa_d[l_ac].mhad010)  RETURNING g_mhaa_d[l_ac].mhad010_desc
            #DISPLAY BY NAME g_mhaa_d[l_ac].mhad010_desc
            #DISPLAY g_mhaa_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mhad010                          #返回原欄位

            #END add-point
         #160506-00009#28 20160512 add by beckxie---E
         
         
         #Ctrlp:input.c.page1.mhad005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad005
            #add-point:ON ACTION controlp INFIELD mhad005

            #END add-point
 
         #Ctrlp:input.c.page1.mhad006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad006
            #add-point:ON ACTION controlp INFIELD mhad006

            #END add-point
 
         #Ctrlp:input.c.page1.mhad007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad007
            #add-point:ON ACTION controlp INFIELD mhad007

            #END add-point
 
         #Ctrlp:input.c.page1.mhad008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad008
            #add-point:ON ACTION controlp INFIELD mhad008

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_mhaa_d[l_ac].* = g_mhaa_d_t.*
               CLOSE amhi206_bcl
               #add-point:單身取消時

               #end add-point
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mhaa_d[l_ac].mhaasite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mhaa_d[l_ac].* = g_mhaa_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前
               
               #end add-point
               
               #將遮罩欄位還原
               CALL amhi206_mhaa_t_mask_restore('restore_mask_o')
               
               
               #楼栋
               UPDATE mhaa_t SET mhaasite=g_mhaa_d[l_ac].mhaasite,
                       mhaaunit=g_mhaa_d[l_ac].mhaaunit,
                       mhaa001=g_mhaa_d[l_ac].mhaa001,
                       mhaa002=g_mhaa_d[l_ac].mhaa002,
                       mhaa003=g_mhaa_d[l_ac].mhaa003,
                       mhaa004=g_mhaa_d[l_ac].mhaa004,
                       mhaa005=g_mhaa_d[l_ac].mhaa005,
                       mhaa006=g_mhaa_d[l_ac].mhaa006
                 WHERE mhaaent=g_enterprise
                   AND mhaa001=g_mhaa_d_t.mhaa001 
               IF g_mhaa_d[l_ac].mhaa001 != g_mhaa_d_t.mhaa001 THEN
                  UPDATE mhab_t SET mhab001=g_mhaa_d[l_ac].mhaa001
                   WHERE mhabent=g_enterprise
                     AND mhabsite=g_mhaa_d_t.mhaasite
                     AND mhab001=g_mhaa_d_t.mhaa001
                     
                 UPDATE mhac_t SET mhac001=g_mhaa_d[l_ac].mhaa001
                  WHERE mhacent=g_enterprise
                    AND mhacsite=g_mhaa_d_t.mhaasite
                    AND mhac001=g_mhaa_d_t.mhaa001
                    
                 UPDATE mhad_t SET mhad001=g_mhaa_d[l_ac].mhaa001
                  WHERE mhadent=g_enterprise
                    AND mhadsite=g_mhaa_d_t.mhaasite
                    AND mhad001=g_mhaa_d_t.mhaa001
               END IF
               
               #楼层
               UPDATE mhab_t SET mhabsite=g_mhaa_d[l_ac].mhaasite,
                       mhabunit=g_mhaa_d[l_ac].mhaaunit,
                       mhab002=g_mhaa_d[l_ac].mhab002,
                       mhab003=g_mhaa_d[l_ac].mhab003,
                       mhab004=g_mhaa_d[l_ac].mhab004,
                       mhab005=g_mhaa_d[l_ac].mhab005,
                       mhab006=g_mhaa_d[l_ac].mhab006,
                       mhab007=g_mhaa_d[l_ac].mhab007,
                       mhab008=g_mhaa_d[l_ac].mhab008,
                       mhab009=g_mhaa_d[l_ac].mhab009
                 WHERE mhabent=g_enterprise
                   AND mhabsite=g_mhaa_d_t.mhaasite
                   AND mhab001=g_mhaa_d[l_ac].mhab001
                   AND mhab002=g_mhaa_d_t.mhab002
                   
               IF g_mhaa_d[l_ac].mhab002 != g_mhaa_d_t.mhab002 THEN
                  UPDATE mhac_t SET mhac002=g_mhaa_d[l_ac].mhab002
                   WHERE mhacent=g_enterprise
                     AND mhacsite=g_mhaa_d_t.mhaasite
                     AND mhac001=g_mhaa_d[l_ac].mhaa001
                     AND mhac002=g_mhaa_d_t.mhab002
                     
                  UPDATE mhad_t SET mhad002=g_mhaa_d[l_ac].mhab002
                   WHERE mhadent=g_enterprise
                     AND mhadsite=g_mhaa_d_t.mhaasite
                     AND mhad001=g_mhaa_d[l_ac].mhaa001
                     AND mhad002=g_mhaa_d_t.mhab002
               END IF
               
               #区域
               UPDATE mhac_t SET mhacsite=g_mhaa_d[l_ac].mhaasite,
                       mhacunit=g_mhaa_d[l_ac].mhaaunit,
                       mhac003=g_mhaa_d[l_ac].mhac003,
                       mhac004=g_mhaa_d[l_ac].mhac004,
                       mhac005=g_mhaa_d[l_ac].mhac005,
                       mhac006=g_mhaa_d[l_ac].mhac006
                 WHERE mhacent=g_enterprise
                   AND mhacsite=g_mhaa_d_t.mhaasite
                   AND mhac001=g_mhaa_d[l_ac].mhaa001
                   AND mhac002=g_mhaa_d[l_ac].mhab002
                   AND mhac003=g_mhaa_d_t.mhac003 
               
               IF g_mhaa_d[l_ac].mhac003 != g_mhaa_d_t.mhac003 THEN 
                  UPDATE mhad_t SET mhad003=g_mhaa_d[l_ac].mhac003
                   WHERE mhadent=g_enterprise
                     AND mhadsite=g_mhaa_d_t.mhaasite
                     AND mhad001=g_mhaa_d[l_ac].mhaa001
                     AND mhad002=g_mhaa_d[l_ac].mhab002
                     AND mhad003=g_mhaa_d_t.mhac003
                 
                                  
               END IF
               
               #场地
               UPDATE mhad_t SET mhadsite=g_mhaa_d[l_ac].mhaasite,
                       mhadunit=g_mhaa_d[l_ac].mhaaunit,
                       mhad004=g_mhaa_d[l_ac].mhad004,
                       mhad005=g_mhaa_d[l_ac].mhad005,
                       mhad006=g_mhaa_d[l_ac].mhad006,
                       mhad007=g_mhaa_d[l_ac].mhad007,
                       mhad008=g_mhaa_d[l_ac].mhad008,
                       mhad010=g_mhaa_d[l_ac].mhad010,   #160506-00009#28 20160512 add by beckxie
                       mhadstus=g_mhaa_d[l_ac].mhadstus
                 WHERE mhadent=g_enterprise
                   AND mhadsite=g_mhaa_d_t.mhaasite
                   AND mhad001=g_mhaa_d[l_ac].mhad001
                   AND mhad002=g_mhaa_d[l_ac].mhad002
                   AND mhad003=g_mhaa_d[l_ac].mhad003
                   AND mhad004=g_mhaa_d_t.mhad004               
               #add-point:單身修改中
                
#               CALL amhi206_insert_mhaa()
#               CALL amhi206_insert_mhab()
#               CALL amhi206_insert_mhac()
#               CALL amhi206_insert_mhad()
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhaa_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                    WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhaa_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhaa_d[g_detail_idx].mhaasite
               LET gs_keys_bak[1] = g_mhaa_d_t.mhaasite
               LET gs_keys[2] = g_mhaa_d[g_detail_idx].mhaa001
               LET gs_keys_bak[2] = g_mhaa_d_t.mhaa001
               CALL amhi206_update_b('mhaa_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhaa001 = g_detail_multi_table_t.mhaal001 AND
         g_mhaa_d[l_ac].mhaal003 = g_detail_multi_table_t.mhaal003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhaa001
            LET l_field_keys[02] = 'mhaal001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mhaal002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhaal002
            LET l_vars[01] = g_mhaa_d[l_ac].mhaal003
            LET l_fields[01] = 'mhaal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhaal_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhab001 = g_detail_multi_table_t.mhabl001 AND
         g_mhaa_d[l_ac].mhab002 = g_detail_multi_table_t.mhabl002 AND
         g_mhaa_d[l_ac].mhabl004 = g_detail_multi_table_t.mhabl004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhablent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhab001
            LET l_field_keys[02] = 'mhabl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhabl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhab002
            LET l_field_keys[03] = 'mhabl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhabl002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhabl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhabl003
            LET l_vars[01] = g_mhaa_d[l_ac].mhabl004
            LET l_fields[01] = 'mhabl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhabl_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhac001 = g_detail_multi_table_t.mhacl001 AND
         g_mhaa_d[l_ac].mhac002 = g_detail_multi_table_t.mhacl002 AND
         g_mhaa_d[l_ac].mhac003 = g_detail_multi_table_t.mhacl003 AND
         g_mhaa_d[l_ac].mhacl005 = g_detail_multi_table_t.mhacl005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaclent'
            LET l_var_keys_bak[01] = g_enterprise
            #LET l_var_keys[02] = g_mhaa_d[l_ac].mhac001    #160711-00033#1 Mark By ken 160713
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhab001     #160711-00033#1 Add By ken 160713  
            LET l_field_keys[02] = 'mhacl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhacl001
            #LET l_var_keys[03] = g_mhaa_d[l_ac].mhac002     #160711-00033#1 Mark By ken 160713
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhab002      #160711-00033#1 Add By ken 160713
            LET l_field_keys[03] = 'mhacl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhacl002
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhac003
            LET l_field_keys[04] = 'mhacl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhacl003
            LET l_var_keys[05] = g_dlang
            LET l_field_keys[05] = 'mhacl004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhacl004
            LET l_vars[01] = g_mhaa_d[l_ac].mhacl005
            LET l_fields[01] = 'mhacl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhacl_t')
         END IF 
          INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhaa_d[l_ac].mhad001 = g_detail_multi_table_t.mhadl001 AND
         g_mhaa_d[l_ac].mhad002 = g_detail_multi_table_t.mhadl002 AND
         g_mhaa_d[l_ac].mhad003 = g_detail_multi_table_t.mhadl003 AND
         g_mhaa_d[l_ac].mhad004 = g_detail_multi_table_t.mhadl004 AND
         g_mhaa_d[l_ac].mhadl006 = g_detail_multi_table_t.mhadl006 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhaa_d[l_ac].mhad001
            LET l_field_keys[02] = 'mhadl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
            LET l_var_keys[03] = g_mhaa_d[l_ac].mhad002
            LET l_field_keys[03] = 'mhadl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
            LET l_var_keys[04] = g_mhaa_d[l_ac].mhad003
            LET l_field_keys[04] = 'mhadl003'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
            LET l_var_keys[05] = g_mhaa_d[l_ac].mhad004
            LET l_field_keys[05] = 'mhadl004'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
            LET l_var_keys[06] = g_dlang
            LET l_field_keys[06] = 'mhadl005'
            LET l_var_keys_bak[06] = g_detail_multi_table_t.mhadl005
            LET l_vars[01] = g_mhaa_d[l_ac].mhadl006
            LET l_fields[01] = 'mhadl006'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhadl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_mhaa_d_t)
                     LET g_log2 = util.JSON.stringify(g_mhaa_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amhi206_mhaa_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後
            #   CALL amhi206_b_fill2(" 1=1")
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL amhi206_unlock_b("mhaa_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            CALL cl_multitable_unlock()
             #add-point:單身after row
             
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mhaa_d[li_reproduce_target].* = g_mhaa_d[li_reproduce].*
 
               LET g_mhaa_d[li_reproduce_target].mhaasite = NULL
               LET g_mhaa_d[li_reproduce_target].mhaa001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhaa_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
 
      
      #add-point:before_more_input

      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog

         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD mhaasite
 
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
      IF INT_FLAG OR cl_null(g_mhaa_d[g_detail_idx].mhaasite) THEN
         CALL g_mhaa_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_mhaa_d[g_detail_idx].* = g_mhaa_d_t.*
   END IF
   
   #add-point:modify段修改後
 #  CALL amhi206_b_fill2(" 1=1")
   #end add-point
 
   CLOSE amhi206_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION

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
PRIVATE FUNCTION amhi206_b_fill2(p_wc2)
DEFINE p_wc2    STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE l_where     STRING   #161006-00008#2 20161019 add by beckxie
   #end add-point
   
   #add-point:Function前置處理 
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前
   #161006-00008#2 20161019 add by beckxie---S
   LET l_where = s_aooi500_sql_where(g_prog,'mhaasite')
   LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   #161006-00008#2 20161019 add by beckxie---E
   #end add-point
 
   LET g_sql = "SELECT  UNIQUE t0.mhaasite,t0.mhaaunit,t0.mhaa001,t0.mhaa005,t0.mhaa006,t0.mhaa002,t0.mhaa003, 
       t0.mhaa004 ,t1.ooefl003 ,t2.ooefl003 FROM mhaa_t t0",
               " LEFT JOIN mhaal_t ON mhaalent = '"||g_enterprise||"' AND mhaa001 = mhaal001 AND mhaal002 = '",g_dlang,"' LEFT JOIN mhabl_t ON mhablent = '"||g_enterprise||"' AND mhab001 = mhabl001 AND mhab002 = mhabl002 AND mhabl003 = '",g_dlang,"' LEFT JOIN mhacl_t ON mhaclent = '"||g_enterprise||"' AND mhac001 = mhacl001 AND mhac002 = mhacl002 AND mhac003 = mhacl003 AND mhacl004 = '",g_dlang,"' LEFT JOIN mhadl_t ON mhadlent = '"||g_enterprise||"' AND mhad001 = mhadl001 AND mhad002 = mhadl002 AND mhad003 = mhadl003 AND mhad004 = mhadl004 AND mhadl005 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.mhaaunit AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.mhaaent= ?  AND  1=1 AND (", p_wc2, ") " 
   #add-point:b_fill段sql wc
   #160705-00028#1 20160706 mark by beckxie---S
   #LET g_sql = "SELECT  UNIQUE t0.mhaasite,t1.ooefl003,t0.mhaaunit,t2.ooefl003,t0.mhaa001, mhaal003,  t0.mhaa005, t0.mhaa006, ",
   #            "               t0.mhaa002, t0.mhaa003, t0.mhaa004, t3.mhab001, t3.mhab002,t4.mhabl004,t3.mhab006, ",
   #            "               t3.mhab007, t3.mhab008, t3.mhab009, t3.mhab003, t3.mhab004,t3.mhab005, t5.mhac001, ",
   #            "               t5.mhac002, t5.mhac003, t6.mhacl005,t5.mhac004, t5.mhac005,t5.mhac006, t7.mhad001, ",
   #            #"               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad005,t7.mhad006, t7.mhad007, ",              #160506-00009#28 20160512 mark by beckxie
   #            "               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad010,t9.oocql004,t7.mhad005,t7.mhad006, t7.mhad007, ",    #160506-00009#28 20160512 add by beckxie
   #            "               t7.mhad008, t7.mhadstus                                ",
   #            "  FROM mhaa_t t0",
   #            "               LEFT JOIN mhaal_t ON mhaalent = '"||g_enterprise||"' AND mhaa001 = mhaal001 AND mhaal002 = '"||g_dlang||"' ",
   #            "               LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhaasite AND t1.ooefl002='"||g_dlang||"' ",
   #            "               LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.mhaaunit AND t2.ooefl002='"||g_dlang||"' ",
   #            "     ,mhab_t  t3 ",
   #            "               LEFT JOIN mhabl_t t4 ON t4.mhablent = '"||g_enterprise||"' AND t4.mhabl001 = t3.mhab001 AND t4.mhabl002 = t3.mhab002 AND t4.mhabl003 ='"||g_dlang||"' ",
   #            "     ,mhac_t  t5 ",
   #            "               LEFT JOIN mhacl_t t6 ON t6.mhaclent = '"||g_enterprise||"' AND t6.mhacl001 = t5.mhac001 AND t6.mhacl002 = t5.mhac002 AND t6.mhacl003 = t5.mhac003 AND t6.mhacl004= '"||g_dlang||"' ",
   #            "     ,mhad_t  t7 ",
   #            "               LEFT JOIN mhadl_t t8 ON t8.mhadlent = '"||g_enterprise||"' AND t8.mhadl001 = t7.mhad001 AND t8.mhadl002 = t7.mhad002 AND t8.mhadl003 = t7.mhad003 AND t8.mhadl004= t7.mhad004 AND t8.mhadl005='"||g_dlang||"' ",
   #            #160506-00009#28 20160512 add by beckxie---S
   #            "               LEFT JOIN oocql_t t9 ON t9.oocqlent = '"||g_enterprise||"' AND t9.oocql001 = '2145' AND t9.oocql002 = t7.mhad010 AND t9.oocql003='"||g_dlang||"' ",
   #            #160506-00009#28 20160512 add by beckxie---E
   #            " WHERE t0.mhaaent =t3.mhabent ",
   #            "   AND t0.mhaaent =t5.mhacent ",
   #            "   AND t0.mhaaent =t7.mhadent ",
   #            "   AND t0.mhaasite = t3.mhabsite ",
   #            "   AND t0.mhaasite = t5.mhacsite ",
   #            "   AND t0.mhaasite = t7.mhadsite ",
   #            "   AND t0.mhaa001  = t3.mhab001 ",
   #            "   AND t0.mhaa001  = t5.mhac001 ",
   #            "   AND t0.mhaa001  = t7.mhad001 ",
   #            "   AND t3.mhab002  = t5.mhac002 ",
   #            "   AND t3.mhab002  = t7.mhad002 ",
   #            "   AND t5.mhac003  = t7.mhad003 ",
   #            "   AND t0.mhaaent= ?  AND t0.mhaasite= ? AND  1=1 AND (", p_wc2, ") " 
   #160705-00028#1 20160706 mark by beckxie---E
   #160705-00028#1 20160706  add by beckxie---S
   LET g_sql = "SELECT  UNIQUE t0.mhaasite,t1.ooefl003,t0.mhaaunit,t2.ooefl003,t0.mhaa001, mhaal003,  t0.mhaa005, t0.mhaa006, ",
               "               t0.mhaa002, t0.mhaa003, t0.mhaa004, t3.mhab001, t3.mhab002,t4.mhabl004,t3.mhab006, ",
               "               t3.mhab007, t3.mhab008, t3.mhab009, t3.mhab003, t3.mhab004,t3.mhab005, t5.mhac001, ",
               "               t5.mhac002, t5.mhac003, t6.mhacl005,t5.mhac004, t5.mhac005,t5.mhac006, t7.mhad001, ",
               #"               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad005,t7.mhad006, t7.mhad007, ",              #160506-00009#28 20160512 mark by beckxie
               "               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad010,t9.oocql004,t7.mhad005,t7.mhad006, t7.mhad007, ",    #160506-00009#28 20160512 add by beckxie
               "               t7.mhad008, t7.mhadstus                                ",
               "  FROM mhaa_t t0",
               "               LEFT JOIN mhaal_t ON mhaalent = '"||g_enterprise||"' AND mhaa001 = mhaal001 AND mhaal002 = '"||g_dlang||"' ",
               "               LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhaasite AND t1.ooefl002='"||g_dlang||"' ",
               "               LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.mhaaunit AND t2.ooefl002='"||g_dlang||"' ",
               "     ,mhab_t  t3 ",
               "               LEFT JOIN mhabl_t t4 ON t4.mhablent = '"||g_enterprise||"' AND t4.mhabl001 = t3.mhab001 AND t4.mhabl002 = t3.mhab002 AND t4.mhabl003 ='"||g_dlang||"' ",
               "     ,mhac_t  t5 ",
               "               LEFT JOIN mhacl_t t6 ON t6.mhaclent = '"||g_enterprise||"' AND t6.mhacl001 = t5.mhac001 AND t6.mhacl002 = t5.mhac002 AND t6.mhacl003 = t5.mhac003 AND t6.mhacl004= '"||g_dlang||"' ",
               "     ,mhad_t  t7 ",
               "               LEFT JOIN mhadl_t t8 ON t8.mhadlent = '"||g_enterprise||"' AND t8.mhadl001 = t7.mhad001 AND t8.mhadl002 = t7.mhad002 AND t8.mhadl003 = t7.mhad003 AND t8.mhadl004= t7.mhad004 AND t8.mhadl005='"||g_dlang||"' ",
               #160506-00009#28 20160512 add by beckxie---S
               "               LEFT JOIN oocql_t t9 ON t9.oocqlent = '"||g_enterprise||"' AND t9.oocql001 = '2145' AND t9.oocql002 = t7.mhad010 AND t9.oocql003='"||g_dlang||"' ",
               #160506-00009#28 20160512 add by beckxie---E
               " WHERE t0.mhaaent =t3.mhabent ",
               "   AND t0.mhaaent =t5.mhacent ",
               "   AND t0.mhaaent =t7.mhadent ",
               "   AND t0.mhaasite = t3.mhabsite ",
               "   AND t0.mhaasite = t5.mhacsite ",
               "   AND t0.mhaasite = t7.mhadsite ",
               "   AND t0.mhaa001  = t3.mhab001 ",
               "   AND t0.mhaa001  = t5.mhac001 ",
               "   AND t0.mhaa001  = t7.mhad001 ",
               "   AND t3.mhab002  = t5.mhac002 ",
               "   AND t3.mhab002  = t7.mhad002 ",
               "   AND t5.mhac003  = t7.mhad003 ",
               "   AND t0.mhaaent= ?  AND t0.mhaasite= ? AND  1=1 AND (", p_wc2, ") " ,
               " UNION ",
               "SELECT  UNIQUE t0.mhaasite,t1.ooefl003,t0.mhaaunit,t2.ooefl003,t0.mhaa001, mhaal003,  t0.mhaa005, t0.mhaa006, ",
               "               t0.mhaa002, t0.mhaa003, t0.mhaa004, t3.mhab001, t3.mhab002,t4.mhabl004,t3.mhab006, ",
               "               t3.mhab007, t3.mhab008, t3.mhab009, t3.mhab003, t3.mhab004,t3.mhab005, t3.mhab001, ",
               "               t3.mhab002, ' ', '',0, 0,0, t7.mhad001, ",
               #"               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad005,t7.mhad006, t7.mhad007, ",              #160506-00009#28 20160512 mark by beckxie
               "               t7.mhad002, t7.mhad003, t7.mhad004, t8.mhadl006,t7.mhad010,t9.oocql004,t7.mhad005,t7.mhad006, t7.mhad007, ",    #160506-00009#28 20160512 add by beckxie
               "               t7.mhad008, t7.mhadstus                                ",
               "  FROM mhaa_t t0",
               "               LEFT JOIN mhaal_t ON mhaalent = '"||g_enterprise||"' AND mhaa001 = mhaal001 AND mhaal002 = '"||g_dlang||"' ",
               "               LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.mhaasite AND t1.ooefl002='"||g_dlang||"' ",
               "               LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.mhaaunit AND t2.ooefl002='"||g_dlang||"' ",
               "     ,mhab_t  t3 ",
               "               LEFT JOIN mhabl_t t4 ON t4.mhablent = '"||g_enterprise||"' AND t4.mhabl001 = t3.mhab001 AND t4.mhabl002 = t3.mhab002 AND t4.mhabl003 ='"||g_dlang||"' ",
               "     ,mhad_t  t7 ",
               "               LEFT JOIN mhadl_t t8 ON t8.mhadlent = '"||g_enterprise||"' AND t8.mhadl001 = t7.mhad001 AND t8.mhadl002 = t7.mhad002 AND t8.mhadl003 = t7.mhad003 AND t8.mhadl004= t7.mhad004 AND t8.mhadl005='"||g_dlang||"' ",
               #160506-00009#28 20160512 add by beckxie---S
               "               LEFT JOIN oocql_t t9 ON t9.oocqlent = '"||g_enterprise||"' AND t9.oocql001 = '2145' AND t9.oocql002 = t7.mhad010 AND t9.oocql003='"||g_dlang||"' ",
               #160506-00009#28 20160512 add by beckxie---E
               " WHERE t0.mhaaent =t3.mhabent ",
               "   AND t0.mhaaent =t7.mhadent ",
               "   AND t0.mhaasite = t3.mhabsite ",
               "   AND t0.mhaasite = t7.mhadsite ",
               "   AND t0.mhaa001  = t3.mhab001 ",
               "   AND t0.mhaa001  = t7.mhad001 ",
               "   AND t7.mhad002 = t3.mhab002 ",   #160707-00021#1 20160707 add by beckxie
               "   AND t7.mhad003 = ' ' ",
               "   AND t0.mhaaent= ?  AND t0.mhaasite= ? AND  1=1 AND (", p_wc2, ") " 
   #160705-00028#1 20160706  add by beckxie---E
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("mhaa_t"),
                      " ORDER BY mhaasite,mhaa001"
   
   #add-point:b_fill段sql之後

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhaa_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE amhi206_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR amhi206_pb1
   
   #160705-00028#1 20160706 modify by beckxie---S
   #OPEN b_fill_curs1 USING g_enterprise,g_site   
   OPEN b_fill_curs1 USING g_enterprise,g_site,g_enterprise,g_site
   #160705-00028#1 20160706 modify by beckxie---E
   
   CALL g_mhaa_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_mhaa_d[l_ac].mhaasite,     g_mhaa_d[l_ac].mhaasite_desc,g_mhaa_d[l_ac].mhaaunit,
                            g_mhaa_d[l_ac].mhaaunit_desc,g_mhaa_d[l_ac].mhaa001,      g_mhaa_d[l_ac].mhaal003, g_mhaa_d[l_ac].mhaa005,      
                            g_mhaa_d[l_ac].mhaa006,      g_mhaa_d[l_ac].mhaa002,      g_mhaa_d[l_ac].mhaa003,
                            g_mhaa_d[l_ac].mhaa004,      g_mhaa_d[l_ac].mhab001,      g_mhaa_d[l_ac].mhab002,
                            g_mhaa_d[l_ac].mhabl004,     g_mhaa_d[l_ac].mhab006,      g_mhaa_d[l_ac].mhab007,
                            g_mhaa_d[l_ac].mhab008,      g_mhaa_d[l_ac].mhab009,      g_mhaa_d[l_ac].mhab003,
                            g_mhaa_d[l_ac].mhab004,      g_mhaa_d[l_ac].mhab005,      g_mhaa_d[l_ac].mhac001,
                            g_mhaa_d[l_ac].mhac002,      g_mhaa_d[l_ac].mhac003,      g_mhaa_d[l_ac].mhacl005,
                            g_mhaa_d[l_ac].mhac004,      g_mhaa_d[l_ac].mhac005,      g_mhaa_d[l_ac].mhac006,
                            g_mhaa_d[l_ac].mhad001,      g_mhaa_d[l_ac].mhad002,      g_mhaa_d[l_ac].mhad003,
                            #g_mhaa_d[l_ac].mhad004,      g_mhaa_d[l_ac].mhadl006,     g_mhaa_d[l_ac].mhad005,  #160506-00009#28 20160512 mark by beckxie
                            g_mhaa_d[l_ac].mhad004,      g_mhaa_d[l_ac].mhadl006,     g_mhaa_d[l_ac].mhad010,   #160506-00009#28 20160512 add by beckxie
                            g_mhaa_d[l_ac].mhad010_desc ,g_mhaa_d[l_ac].mhad005,                                #160506-00009#28 20160512 add by beckxie
                            g_mhaa_d[l_ac].mhad006,      g_mhaa_d[l_ac].mhad007,      g_mhaa_d[l_ac].mhad008,
                            g_mhaa_d[l_ac].mhadstus
                            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充
#      IF cl_null(g_mhaa_d[g_detail_idx].sel) OR g_mhaa_d[g_detail_idx].sel='N' THEN
#         LET g_mhaa_d[l_ac].sel='N'
#      ELSE 
#        LET g_mhaa_d[l_ac].sel= g_mhaa_d[g_detail_idx].sel
#      END IF
      LET g_mhaa_d[l_ac].sel='N'
      #end add-point
      
      CALL amhi206_detail_show()      
 
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
   
 
   
   CALL g_mhaa_d.deleteElement(g_mhaa_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_mhaa_d.getLength()
 
      #add-point:b_fill段key值相關欄位

      #end add-point
   END FOR
   
   IF g_cnt > g_mhaa_d.getLength() THEN
      LET l_ac = g_mhaa_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhaa_d.getLength()
      LET g_mhaa_d_mask_o[l_ac].* =  g_mhaa_d[l_ac].*
      CALL amhi206_mhaa_t_mask()
      LET g_mhaa_d_mask_n[l_ac].* =  g_mhaa_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_mhaa_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE amhi206_pb
END FUNCTION

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
PRIVATE FUNCTION amhi206_query2()
DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   #add-point:Function前置處理 

   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_mhaa_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      CONSTRUCT g_wc2 ON mhaasite,mhaaunit,mhaa001,mhaal003,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004, 
          mhab001,mhab002,mhabl004,mhab006,mhab007,mhab008,mhab009,mhab003,mhab004,mhab005,mhac001,mhac002, 
          #mhac003,mhacl005,mhac004,mhac005,mhac006,mhad001,mhad002,mhad003,mhad004,mhadl006,mhad005,   #160506-00009#28 20160512 mark by beckxie
          mhac003,mhacl005,mhac004,mhac005,mhac006,mhad001,mhad002,mhad003,mhad004,mhadl006,mhad010,mhad005, #160506-00009#28 20160512 add by beckxie
          mhad006,mhad007,mhad008,mhadstus 
 
         FROM s_detail1[1].mhaasite,s_detail1[1].mhaaunit,s_detail1[1].mhaa001,s_detail1[1].mhaal003, 
             s_detail1[1].mhaa005,s_detail1[1].mhaa006,s_detail1[1].mhaa002,s_detail1[1].mhaa003,s_detail1[1].mhaa004, 
             s_detail1[1].mhab001,s_detail1[1].mhab002,s_detail1[1].mhabl004,s_detail1[1].mhab006,s_detail1[1].mhab007, 
             s_detail1[1].mhab008,s_detail1[1].mhab009,s_detail1[1].mhab003,s_detail1[1].mhab004,s_detail1[1].mhab005, 
             s_detail1[1].mhac001,s_detail1[1].mhac002,s_detail1[1].mhac003,s_detail1[1].mhacl005,s_detail1[1].mhac004, 
             s_detail1[1].mhac005,s_detail1[1].mhac006,s_detail1[1].mhad001,s_detail1[1].mhad002,s_detail1[1].mhad003, 
             #s_detail1[1].mhad004,s_detail1[1].mhadl006,s_detail1[1].mhad005,s_detail1[1].mhad006,s_detail1[1].mhad007, #160506-00009#28 20160512 mark by beckxie
             s_detail1[1].mhad004,s_detail1[1].mhadl006,s_detail1[1].mhad010,s_detail1[1].mhad005,s_detail1[1].mhad006,s_detail1[1].mhad007, #160506-00009#28 20160512 add by beckxie
             s_detail1[1].mhad008,s_detail1[1].mhadstus 
      
         
      
                  #Ctrlp:construct.c.page1.mhaasite
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaasite
            #add-point:ON ACTION controlp INFIELD mhaasite
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhaasite',g_site,'c') #161006-00008#2 20161019 add by beckxie
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaasite  #顯示到畫面上
            NEXT FIELD mhaasite                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaasite
            #add-point:BEFORE FIELD mhaasite

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaasite
            
            #add-point:AFTER FIELD mhaasite

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhaaunit
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaaunit
            #add-point:ON ACTION controlp INFIELD mhaaunit
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhaaunit',g_site,'c') #161006-00008#2 20161019 add by beckxie
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaaunit  #顯示到畫面上
            NEXT FIELD mhaaunit                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaaunit
            #add-point:BEFORE FIELD mhaaunit

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaaunit
            
            #add-point:AFTER FIELD mhaaunit

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa001
            #add-point:ON ACTION controlp INFIELD mhaa001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhaa001  #顯示到畫面上
            NEXT FIELD mhaa001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa001
            #add-point:BEFORE FIELD mhaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa001
            
            #add-point:AFTER FIELD mhaa001

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaal003
            #add-point:BEFORE FIELD mhaal003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaal003
            
            #add-point:AFTER FIELD mhaal003

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhaal003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaal003
            #add-point:ON ACTION controlp INFIELD mhaal003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa005
            #add-point:BEFORE FIELD mhaa005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa005
            
            #add-point:AFTER FIELD mhaa005

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhaa005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa005
            #add-point:ON ACTION controlp INFIELD mhaa005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa006
            #add-point:BEFORE FIELD mhaa006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa006
            
            #add-point:AFTER FIELD mhaa006

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhaa006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa006
            #add-point:ON ACTION controlp INFIELD mhaa006

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa002
            #add-point:BEFORE FIELD mhaa002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa002
            
            #add-point:AFTER FIELD mhaa002

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhaa002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa002
            #add-point:ON ACTION controlp INFIELD mhaa002

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa003
            #add-point:BEFORE FIELD mhaa003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa003
            
            #add-point:AFTER FIELD mhaa003

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhaa003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa003
            #add-point:ON ACTION controlp INFIELD mhaa003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhaa004
            #add-point:BEFORE FIELD mhaa004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhaa004
            
            #add-point:AFTER FIELD mhaa004

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhaa004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhaa004
            #add-point:ON ACTION controlp INFIELD mhaa004

            #END add-point
 
         #Ctrlp:construct.c.page1.mhab001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab001
            #add-point:ON ACTION controlp INFIELD mhab001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhab001  #顯示到畫面上
            NEXT FIELD mhab001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab001
            #add-point:BEFORE FIELD mhab001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab001
            
            #add-point:AFTER FIELD mhab001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhab002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab002
            #add-point:ON ACTION controlp INFIELD mhab002
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhab002  #顯示到畫面上
            NEXT FIELD mhab002                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab002
            #add-point:BEFORE FIELD mhab002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab002
            
            #add-point:AFTER FIELD mhab002

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhabl004
            #add-point:BEFORE FIELD mhabl004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhabl004
            
            #add-point:AFTER FIELD mhabl004

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhabl004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhabl004
            #add-point:ON ACTION controlp INFIELD mhabl004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab006
            #add-point:BEFORE FIELD mhab006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab006
            
            #add-point:AFTER FIELD mhab006

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab006
            #add-point:ON ACTION controlp INFIELD mhab006

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab007
            #add-point:BEFORE FIELD mhab007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab007
            
            #add-point:AFTER FIELD mhab007

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab007
            #add-point:ON ACTION controlp INFIELD mhab007

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab008
            #add-point:BEFORE FIELD mhab008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab008
            
            #add-point:AFTER FIELD mhab008

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab008
            #add-point:ON ACTION controlp INFIELD mhab008

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab009
            #add-point:BEFORE FIELD mhab009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab009
            
            #add-point:AFTER FIELD mhab009

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab009
            #add-point:ON ACTION controlp INFIELD mhab009

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab003
            #add-point:BEFORE FIELD mhab003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab003
            
            #add-point:AFTER FIELD mhab003

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab003
            #add-point:ON ACTION controlp INFIELD mhab003

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab004
            #add-point:BEFORE FIELD mhab004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab004
            
            #add-point:AFTER FIELD mhab004

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab004
            #add-point:ON ACTION controlp INFIELD mhab004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhab005
            #add-point:BEFORE FIELD mhab005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhab005
            
            #add-point:AFTER FIELD mhab005

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhab005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhab005
            #add-point:ON ACTION controlp INFIELD mhab005

            #END add-point
 
         #Ctrlp:construct.c.page1.mhac001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac001
            #add-point:ON ACTION controlp INFIELD mhac001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhac001  #顯示到畫面上
            NEXT FIELD mhac001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac001
            #add-point:BEFORE FIELD mhac001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac001
            
            #add-point:AFTER FIELD mhac001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhac002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac002
            #add-point:ON ACTION controlp INFIELD mhac002
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhac002  #顯示到畫面上
            NEXT FIELD mhac002                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac002
            #add-point:BEFORE FIELD mhac002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac002
            
            #add-point:AFTER FIELD mhac002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhac003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac003
            #add-point:ON ACTION controlp INFIELD mhac003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhac003  #顯示到畫面上
            NEXT FIELD mhac003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac003
            #add-point:BEFORE FIELD mhac003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac003
            
            #add-point:AFTER FIELD mhac003

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhacl005
            #add-point:BEFORE FIELD mhacl005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhacl005
            
            #add-point:AFTER FIELD mhacl005

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhacl005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhacl005
            #add-point:ON ACTION controlp INFIELD mhacl005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac004
            #add-point:BEFORE FIELD mhac004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac004
            
            #add-point:AFTER FIELD mhac004

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhac004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac004
            #add-point:ON ACTION controlp INFIELD mhac004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac005
            #add-point:BEFORE FIELD mhac005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac005
            
            #add-point:AFTER FIELD mhac005

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhac005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac005
            #add-point:ON ACTION controlp INFIELD mhac005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhac006
            #add-point:BEFORE FIELD mhac006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhac006
            
            #add-point:AFTER FIELD mhac006

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhac006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhac006
            #add-point:ON ACTION controlp INFIELD mhac006

            #END add-point
 
         #Ctrlp:construct.c.page1.mhad001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad001
            #add-point:ON ACTION controlp INFIELD mhad001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad001  #顯示到畫面上
            NEXT FIELD mhad001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad001
            #add-point:BEFORE FIELD mhad001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad001
            
            #add-point:AFTER FIELD mhad001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhad002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad002
            #add-point:ON ACTION controlp INFIELD mhad002
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad002  #顯示到畫面上
            NEXT FIELD mhad002                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad002
            #add-point:BEFORE FIELD mhad002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad002
            
            #add-point:AFTER FIELD mhad002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhad003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad003
            #add-point:ON ACTION controlp INFIELD mhad003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad003  #顯示到畫面上
            NEXT FIELD mhad003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad003
            #add-point:BEFORE FIELD mhad003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad003
            
            #add-point:AFTER FIELD mhad003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mhad004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad004
            #add-point:ON ACTION controlp INFIELD mhad004
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad004  #顯示到畫面上
            NEXT FIELD mhad004                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad004
            #add-point:BEFORE FIELD mhad004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad004
            
            #add-point:AFTER FIELD mhad004

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhadl006
            #add-point:BEFORE FIELD mhadl006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhadl006
            
            #add-point:AFTER FIELD mhadl006
        
            #END add-point
            
 
         #Ctrlp:query.c.page1.mhadl006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhadl006
            #add-point:ON ACTION controlp INFIELD mhadl006

            #END add-point
         #160506-00009#28 20160512 add by beckxie---S
         #Ctrlp:construct.c.page1.mhad010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhad010
            #add-point:ON ACTION controlp INFIELD mhad010 name="construct.c.page1.mhad010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2145'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhad010  #顯示到畫面上
            NEXT FIELD mhad010                     #返回原欄位
            #END add-point
         #160506-00009#28 20160512 add by beckxie---E   
         
         
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad005
            #add-point:BEFORE FIELD mhad005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad005
            
            #add-point:AFTER FIELD mhad005

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhad005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad005
            #add-point:ON ACTION controlp INFIELD mhad005

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad006
            #add-point:BEFORE FIELD mhad006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad006
            
            #add-point:AFTER FIELD mhad006

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhad006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad006
            #add-point:ON ACTION controlp INFIELD mhad006

            #END add-point
            
         
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad007
            #add-point:BEFORE FIELD mhad007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad007
            
            #add-point:AFTER FIELD mhad007

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhad007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad007
            #add-point:ON ACTION controlp INFIELD mhad007

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mhad008
            #add-point:BEFORE FIELD mhad008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mhad008
            
            #add-point:AFTER FIELD mhad008

            #END add-point
            
 
         #Ctrlp:query.c.page1.mhad008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mhad008
            #add-point:ON ACTION controlp INFIELD mhad008

            #END add-point
 
  
         
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct

      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog

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
 
   #add-point:query段after_construct

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
    
   CALL amhi206_b_fill2(g_wc2)
   
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION

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
PRIVATE FUNCTION amhi206_chk_mhad006()
DEFINE l_mhad005   LIKE mhad_t.mhad005
 DEFINE l_mhad006   LIKE mhad_t.mhad006
 DEFINE l_mhad007   LIKE mhad_t.mhad007
 DEFINE l_success   LIKE type_t.num5
 DEFINE l_mhab007   LIKE mhab_t.mhab007
 DEFINE l_mhab006   LIKE mhab_t.mhab006
 DEFINE l_mhaa005   LIKE mhaa_t.mhaa005
 DEFINE l_mhaa006   LIKE mhaa_t.mhaa006
   
   LET l_mhad005=0
   LET l_mhad006=0
   LET l_mhad007=0
   LET l_mhab006=0
   LET l_mhab007=0
   LET l_mhaa005 = 0
   LET l_mhaa006 = 0
   LET l_success = TRUE
   LET g_errno = NULL
         
   LET l_mhad005=0
   LET l_mhad006=0
   LET l_mhad007=0
   IF NOT cl_null(g_mhaa_d[l_ac].mhad002) THEN
         SELECT SUM(mhad005),sum(mhad006),sum(mhad007) 
           INTO l_mhad005,l_mhad006,l_mhad007
           FROM mhad_t
          WHERE mhad001 = g_mhaa_d[l_ac].mhad001 
            AND mhad002 = g_mhaa_d[l_ac].mhad002
#            AND mhad003 = g_mhaa_d[l_ac].mhad003
            AND mhadent = g_enterprise
            AND mhadstus='Y'
      IF cl_null(l_mhad005) THEN
         LET l_mhad005=0
      END IF
      IF cl_null(l_mhad006) THEN
         LET l_mhad006=0
      END IF
      IF cl_null(l_mhad007) THEN
         LET l_mhad007=0
      END IF
      LET l_mhad005=l_mhad005+g_mhaa_d[l_ac].mhad005
      LET l_mhad006=l_mhad006+g_mhaa_d[l_ac].mhad006
      LET l_mhad007=l_mhad007+g_mhaa_d[l_ac].mhad007  
      
      SELECT mhab006,mhab007 INTO l_mhab006,l_mhab007 
        FROM mhab_t
       WHERE mhab001 = g_mhaa_d[l_ac].mhab001 
         AND mhab002 = g_mhaa_d[l_ac].mhab002
         AND mhabent = g_enterprise 
         
      IF NOT cl_null(l_mhab006) THEN
        
         IF l_mhab006 < l_mhad005 THEN
            LET g_errno="amh-00009"
            LET l_success = FALSE
            RETURN l_success
         END IF
      END IF
      IF NOT cl_null(l_mhab007) THEN      
         IF l_mhab007 < l_mhad006 THEN
            LET g_errno="amh-00010"
            LET l_success = FALSE
            RETURN l_success
         END IF  
      END IF    
   END IF
#   LET l_mhad005=0
#   LET l_mhad006=0
#   LET l_mhad007=0
#   IF NOT cl_null(g_mhad_m.mhad001) THEN
#      IF NOT cl_null(g_mhad_d_t.mhad004) THEN
#         SELECT SUM(mhad005),sum(mhad006),sum(mhad007) INTO l_mhad005,l_mhad006,l_mhad007
#           FROM mhad_t
#          WHERE mhad001 = g_mhad_m.mhad001 AND mhad004<> g_mhad_d_t.mhad004
#            AND mhadent = g_enterprise AND mhadstus='Y'  
#      ELSE 
#         SELECT SUM(mhad005),sum(mhad006),sum(mhad007) INTO l_mhad005,l_mhad006,l_mhad007
#           FROM mhad_t
#          WHERE mhad001 = g_mhad_m.mhad001
#            AND mhadent = g_enterprise and mhadstus='Y'
#      END IF 
#      IF cl_null(l_mhad005) THEN
#         LET l_mhad005=0
#      END IF  
#      IF cl_null(l_mhad006) THEN
#         LET l_mhad006=0
#      END IF
#      IF cl_null(l_mhad007) THEN
#         LET l_mhad007=0
#      END IF      
#      LET l_mhad005=l_mhad005+g_mhad_d[l_ac].mhad005
#      LET l_mhad006=l_mhad006+g_mhad_d[l_ac].mhad006
#      LET l_mhad007=l_mhad007+g_mhad_d[l_ac].mhad007
#      
#      SELECT mhaa005,mhaa006 INTO l_mhaa005,l_mhaa006 FROM mhaa_t
#       WHERE mhaa001 =  g_mhad_m.mhad001
#         AND mhaaent = g_enterprise
#      IF NOT cl_null(l_mhaa005) THEN         
#         IF l_mhaa005 < l_mhad005 THEN
#            LET g_errno="amh-00011"
#            LET l_success = FALSE
#            RETURN l_success
#         END IF
#      END IF
#      IF NOT cl_null(l_mhaa006) THEN      
#         IF l_mhaa006 < l_mhad006 THEN
#            LET g_errno="amh-00012"
#            LET l_success = FALSE
#            RETURN l_success
#         END IF 
#      END IF         
#   END IF
   RETURN l_success
END FUNCTION

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
PRIVATE FUNCTION amhi206_count_mhad005()
DEFINE  l_mhab008  LIKE mhab_t.mhab008
DEFINE  l_mhab009  LIKE mhab_t.mhab009
   
   SELECT mhab008,mhab009 
     INTO l_mhab008,l_mhab009 FROM mhab_t
    WHERE mhabent= g_enterprise 
      AND mhab001 = g_mhaa_d[l_ac].mhad001
      AND mhab002 = g_mhaa_d[l_ac].mhad002
      
   IF cl_null(l_mhab008) THEN
      LET l_mhab008 = 0
   END IF 
   IF cl_null(l_mhab009) THEN
      LET l_mhab009 = 0
   END IF 
   LET g_mhaa_d[l_ac].mhad005 = g_mhaa_d[l_ac].mhad006*(1+l_mhab008/100)
   LET g_mhaa_d[l_ac].mhad007 = g_mhaa_d[l_ac].mhad006*l_mhab009
   
   DISPLAY  g_mhaa_d[l_ac].mhad005 TO s_detail1[l_ac].mhad005
   DISPLAY  g_mhaa_d[l_ac].mhad006 TO s_detail1[l_ac].mhad006
   
END FUNCTION

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
PRIVATE FUNCTION amhi206_count_mhad007()
DEFINE  l_mhab008  LIKE mhab_t.mhab008
DEFINE  l_mhab009  LIKE mhab_t.mhab009
   
   SELECT mhab008,mhab009 
     INTO l_mhab008,l_mhab009 FROM mhab_t
    WHERE mhabent= g_enterprise 
      AND mhab001 = g_mhaa_d[l_ac].mhad001
      AND mhab002 = g_mhaa_d[l_ac].mhad002
      
   IF cl_null(l_mhab008) THEN
      LET l_mhab008 = 0
   END IF 
   IF cl_null(l_mhab009) THEN
      LET l_mhab009 = 0
   END IF
   LET g_mhaa_d[l_ac].mhad006 = g_mhaa_d[l_ac].mhad007/l_mhab009   
   LET g_mhaa_d[l_ac].mhad005 = g_mhaa_d[l_ac].mhad006*(1+l_mhab008/100)
   
   DISPLAY  g_mhaa_d[l_ac].mhad005 TO s_detail1[l_ac].mhad005
   DISPLAY  g_mhaa_d[l_ac].mhad006 TO s_detail1[l_ac].mhad006
END FUNCTION

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
PRIVATE FUNCTION amhi206_insert_mhaa()
DEFINE l_cnt   LIKE type_t.num5 


 SELECT COUNT(*) INTO l_cnt FROM mhaa_t WHERE mhaaent=g_enterprise
     AND  mhaasite=g_mhaa_d[l_ac].mhaasite
     AND  mhaa001=g_mhaa_d[l_ac].mhaa001 
     
  IF l_cnt > 0THEN
     UPDATE mhaa_t SET mhaasite=g_mhaa_d[l_ac].mhaasite,
                       mhaaunit=g_mhaa_d[l_ac].mhaaunit,
                       mhaa002=g_mhaa_d[l_ac].mhaa002,
                       mhaa003=g_mhaa_d[l_ac].mhaa003,
                       mhaa004=g_mhaa_d[l_ac].mhaa004,
                       mhaa005=g_mhaa_d[l_ac].mhaa005,
                       mhaa006=g_mhaa_d[l_ac].mhaa006
                 WHERE mhaaent=g_enterprise
                   AND mhaa001=g_mhaa_d[l_ac].mhaa001
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd mhaa_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
  ELSE
      INSERT INTO mhaa_t
                  (mhaaent,
                   mhaasite,mhaa001
                   ,mhaaunit,mhaa005,mhaa006,mhaa002,mhaa003,mhaa004,mhaastus) 
            VALUES(g_enterprise,g_mhaa_d[l_ac].mhaasite,g_mhaa_d[l_ac].mhaa001,
                                g_mhaa_d[l_ac].mhaaunit,g_mhaa_d[l_ac].mhaa005,
                                g_mhaa_d[l_ac].mhaa006,g_mhaa_d[l_ac].mhaa002, 
                                g_mhaa_d[l_ac].mhaa003,g_mhaa_d[l_ac].mhaa004,'Y')    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins mhaa_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
END FUNCTION

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
PRIVATE FUNCTION amhi206_insert_mhab()
DEFINE l_cnt  LIKE type_t.num5 

  SELECT COUNT(*) INTO l_cnt FROM mhab_t WHERE mhabent=g_enterprise
     AND  mhabsite=g_mhaa_d[l_ac].mhaasite
     AND  mhab001=g_mhaa_d[l_ac].mhab001
     AND  mhab002=g_mhaa_d[l_ac].mhab002     
  
  IF l_cnt > 0 THEN
     UPDATE mhab_t SET mhabsite=g_mhaa_d[l_ac].mhaasite,
                       mhabunit=g_mhaa_d[l_ac].mhaaunit,
                       mhab003=g_mhaa_d[l_ac].mhab003,
                       mhab004=g_mhaa_d[l_ac].mhab004,
                       mhab005=g_mhaa_d[l_ac].mhab005,
                       mhab006=g_mhaa_d[l_ac].mhab006,
                       mhab007=g_mhaa_d[l_ac].mhab007,
                       mhab008=g_mhaa_d[l_ac].mhab008,
                       mhab009=g_mhaa_d[l_ac].mhab009
                 WHERE mhabent=g_enterprise
                   AND mhab001=g_mhaa_d[l_ac].mhab001
                   AND mhab002=g_mhaa_d[l_ac].mhab002
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd mhab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
  ELSE
      INSERT INTO mhab_t
                  (mhabent,mhabsite,mhabunit,mhab001,mhab002,mhab003,mhab004,mhab005,
                   mhab006,mhab007,mhab008,mhab009,mhabstus) 
            VALUES(g_enterprise,g_mhaa_d[l_ac].mhaasite,g_mhaa_d[l_ac].mhaaunit,
                                g_mhaa_d[l_ac].mhab001,g_mhaa_d[l_ac].mhab002,
                                g_mhaa_d[l_ac].mhab003,g_mhaa_d[l_ac].mhab004, 
                                g_mhaa_d[l_ac].mhab005,g_mhaa_d[l_ac].mhab006,
                                g_mhaa_d[l_ac].mhab007,g_mhaa_d[l_ac].mhab008,
                                g_mhaa_d[l_ac].mhab009,'Y')    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins mhab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
END FUNCTION

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
PRIVATE FUNCTION amhi206_insert_mhac()
DEFINE l_cnt   LIKE type_t.num5

  SELECT COUNT(*) INTO l_cnt FROM mhac_t WHERE mhacent=g_enterprise
     AND  mhacsite=g_mhaa_d[l_ac].mhaasite
     AND  mhac001=g_mhaa_d[l_ac].mhac001
     AND  mhac002=g_mhaa_d[l_ac].mhac002
     AND  mhac003=g_mhaa_d[l_ac].mhac003
  
  IF l_cnt > 0 THEN
     UPDATE mhac_t SET mhacsite=g_mhaa_d[l_ac].mhaasite,
                       mhacunit=g_mhaa_d[l_ac].mhaaunit,
                       mhac004=g_mhaa_d[l_ac].mhac004,
                       mhac005=g_mhaa_d[l_ac].mhac005,
                       mhac006=g_mhaa_d[l_ac].mhac006
                 WHERE mhacent=g_enterprise
                   AND mhac001=g_mhaa_d[l_ac].mhac001
                   AND mhac002=g_mhaa_d[l_ac].mhac002
                   AND mhac003=g_mhaa_d[l_ac].mhac003
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd mhac_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
  ELSE
      INSERT INTO mhac_t
                  (mhacent,mhacsite,mhacunit,mhac001,mhac002,mhac003,mhac004,mhac005,
                   mhac006,mhacstus) 
            VALUES(g_enterprise,g_mhaa_d[l_ac].mhaasite,g_mhaa_d[l_ac].mhaaunit,
                                g_mhaa_d[l_ac].mhac001,g_mhaa_d[l_ac].mhac002,
                                g_mhaa_d[l_ac].mhac003,g_mhaa_d[l_ac].mhac004, 
                                g_mhaa_d[l_ac].mhac005,g_mhaa_d[l_ac].mhac006,'Y')    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins mhac_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
END FUNCTION

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
PRIVATE FUNCTION amhi206_insert_mhad()
DEFINE l_cnt   LIKE type_t.num5

  SELECT COUNT(*) INTO l_cnt FROM mhad_t WHERE mhadent=g_enterprise
     AND  mhadsite=g_mhaa_d[l_ac].mhaasite
     AND  mhad001=g_mhaa_d[l_ac].mhad001
     AND  mhad002=g_mhaa_d[l_ac].mhad002
     AND  mhad003=g_mhaa_d[l_ac].mhad003
     AND  mhad004=g_mhaa_d[l_ac].mhad004
  
  IF l_cnt > 0 THEN
     UPDATE mhad_t SET mhadsite=g_mhaa_d[l_ac].mhaasite,
                       mhadunit=g_mhaa_d[l_ac].mhaaunit,
                       mhad004=g_mhaa_d[l_ac].mhad004,
                       mhad005=g_mhaa_d[l_ac].mhad005,
                       mhad006=g_mhaa_d[l_ac].mhad006,
                       mhad007=g_mhaa_d[l_ac].mhad007,
                       mhad008=g_mhaa_d[l_ac].mhad008,
                       mhadstus=g_mhaa_d[l_ac].mhadstus
                 WHERE mhadent=g_enterprise
                   AND mhad001=g_mhaa_d[l_ac].mhad001
                   AND mhad002=g_mhaa_d[l_ac].mhad002
                   AND mhad003=g_mhaa_d[l_ac].mhad003
                   AND mhad004=g_mhaa_d_t.mhad004
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "upd mhad_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
  ELSE
      INSERT INTO mhad_t
                  (mhadent,mhadsite,mhadunit,mhad001,mhad002,mhad003,mhad004,mhad005,
                   #mhad006,mhad007,mhad008,mhadstus)        #160506-00009#28 20160512 mark by beckxie
                   mhad006,mhad007,mhad008,mhad010,mhadstus) #160506-00009#28 20160512 add by beckxie
            VALUES(g_enterprise,g_mhaa_d[l_ac].mhaasite,g_mhaa_d[l_ac].mhaaunit,
                                g_mhaa_d[l_ac].mhad001,g_mhaa_d[l_ac].mhad002,
                                g_mhaa_d[l_ac].mhad003,g_mhaa_d[l_ac].mhad004, 
                                g_mhaa_d[l_ac].mhad005,g_mhaa_d[l_ac].mhad006,
                                #g_mhaa_d[l_ac].mhad007,g_mhaa_d[l_ac].mhad008,g_mhaa_d[l_ac].mhadstus)   #160506-00009#28 20160512 mark by beckxie
                                #160506-00009#28 20160512 add by beckxie---S
                                g_mhaa_d[l_ac].mhad007,g_mhaa_d[l_ac].mhad008,g_mhaa_d[l_ac].mhad010,g_mhaa_d[l_ac].mhadstus)   
                                #160506-00009#28 20160512 add by beckxie---E
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins mhad_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
END FUNCTION

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
PRIVATE FUNCTION amhi206_delete_mhad()
DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   #add-point:Function前置處理 
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   IF cl_null(g_mhaa_d[1].mhaasite) THEN
      CALL g_mhaa_d.clear()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_mhaa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT amhi206_lock("mhaa_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
   END FOR
   
   #add-point:單身刪除詢問前

   #end add-point  
   
   #詢問是否確定刪除所選資料
   
   
   IF NOT cl_ask_del_detail() THEN
      CALL amhi206_unlock_b("mhad_t")
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_mhaa_d.getLength()
      IF g_mhaa_d[li_idx].mhaasite IS NOT NULL
         AND g_mhaa_d[li_idx].mhaa001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前

         #end add-point   
         
         DELETE FROM mhad_t
          WHERE mhadent = g_enterprise 
            AND mhadsite = g_mhaa_d[li_idx].mhaasite
            AND mhad001 = g_mhaa_d[li_idx].mhad001
            AND mhad002 = g_mhaa_d[li_idx].mhad002
            AND mhad003 = g_mhaa_d[li_idx].mhad003
            AND mhad004 = g_mhaa_d[li_idx].mhad004
 
         #add-point:單身刪除中

         #end add-point  
                
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "delete mhad_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            LET g_detail_multi_table_t.mhadl001 = g_mhaa_d[l_ac].mhad001
            LET g_detail_multi_table_t.mhadl002 = g_mhaa_d[l_ac].mhad002
            LET g_detail_multi_table_t.mhadl003 = g_mhaa_d[l_ac].mhad003
            LET g_detail_multi_table_t.mhadl004 = g_mhaa_d[l_ac].mhad004
            LET g_detail_multi_table_t.mhadl005 = g_dlang
            LET g_detail_multi_table_t.mhadl006 = g_mhaa_d[l_ac].mhadl006
 
 
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhadl001
                  LET l_field_keys[03] = 'mhadl002'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhadl002
                  LET l_field_keys[04] = 'mhadl003'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhadl003
                  LET l_field_keys[05] = 'mhadl004'
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.mhadl004
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhadl_t')
 
 
            #add-point:單身同步刪除前(同層table)

            #end add-point
#               LET g_detail_idx = li_idx
#                           
#                           
#               INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_mhaa_d_t.mhaasite
#               LET gs_keys[2] = g_mhaa_d_t.mhaa001
# 
#            #add-point:單身同步刪除中(同層table)
#
#            #end add-point
#            CALL amhi206_delete_b('mhaa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table)

            #end add-point
         END IF 
      END IF 
    
   END FOR
   
   CALL amhi206_unlock_b("mhad_t")
   CALL s_transaction_end('Y','0')
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後

   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL amhi206_b_fill2(g_wc2)
END FUNCTION

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
PRIVATE FUNCTION amhi206_lock(ps_table)
 DEFINE ps_table STRING
 DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point   
   
   #add-point:Function前置處理 
   
   
   #end add-point
   
   #先刷新資料
   #CALL amhi206_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mhaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amhi206_bcl USING g_enterprise,g_mhaa_d[g_detail_idx].mhaasite,
                             g_mhaa_d[g_detail_idx].mhad001,g_mhaa_d[g_detail_idx].mhad002,
                             g_mhaa_d[g_detail_idx].mhad003,g_mhaa_d[g_detail_idx].mhad004 

                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amhi206_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 场地批量失效
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
PRIVATE FUNCTION amhi206_pinvalid()
DEFINE li_idx   LIKE type_t.num5
DEFINE l_cnt    LIKE type_t.num5
DEFINE l_success LIKE type_t.num5
       
       
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success=TRUE
   
   FOR li_idx=1 TO g_mhaa_d.getlength()
       IF g_mhaa_d[li_idx].sel = "Y" THEN
           LET l_cnt = l_cnt + 1
           IF g_mhaa_d[li_idx].mhadstus='Y' THEN
              UPDATE mhad_t SET mhadstus='N' WHERE mhadent=g_enterprise
                                               AND mhadsite=g_mhaa_d[li_idx].mhaasite
                                               AND mhad001=g_mhaa_d[li_idx].mhad001
                                               AND mhad002=g_mhaa_d[li_idx].mhab002
                                               AND mhad003=g_mhaa_d[li_idx].mhad003
                                               AND mhad004=g_mhaa_d[li_idx].mhad004
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = STATUS
                  LET g_errparam.extend = g_mhaa_d[li_idx].mhad004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET l_success = FALSE 
               END IF
           ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00624'
               LET g_errparam.extend = g_mhaa_d[li_idx].mhad004
               LET g_errparam.popup = TRUE
               CALL cl_err()  
               LET l_success = FALSE   
           END IF               
       END IF
   END FOR
   
   IF l_cnt = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'adb-00078'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end("N","0")
       RETURN
   END IF  
    
   IF l_success THEN
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end("Y","0")
   ELSE
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end("N","0")
   END IF
   
   CALL amhi206_b_fill2("1=1")

END FUNCTION

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
PRIVATE FUNCTION amhi206_pvalid()
DEFINE li_idx   LIKE type_t.num5
DEFINE l_cnt    LIKE type_t.num5
DEFINE l_success LIKE type_t.num5
       
       
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success=TRUE
   
   FOR li_idx=1 TO g_mhaa_d.getlength()
       IF g_mhaa_d[li_idx].sel = "Y" THEN
           LET l_cnt = l_cnt + 1
           IF g_mhaa_d[li_idx].mhadstus='N' THEN
              UPDATE mhad_t SET mhadstus='Y' WHERE mhadent=g_enterprise
                                               AND mhadsite=g_mhaa_d[li_idx].mhaasite
                                               AND mhad001=g_mhaa_d[li_idx].mhad001
                                               AND mhad002=g_mhaa_d[li_idx].mhab002
                                               AND mhad003=g_mhaa_d[li_idx].mhad003
                                               AND mhad004=g_mhaa_d[li_idx].mhad004
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = STATUS
                  LET g_errparam.extend = g_mhaa_d[li_idx].mhad004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET l_success = FALSE 
               END IF
           ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amh-00623'
               LET g_errparam.extend = g_mhaa_d[li_idx].mhad004
               LET g_errparam.popup = TRUE
               CALL cl_err()  
               LET l_success = FALSE   
           END IF               
       END IF
   END FOR
   
   IF l_cnt = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'adb-00078'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end("N","0")
       RETURN
   END IF  
    
   IF l_success THEN
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end("Y","0")
   ELSE
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end("N","0")
   END IF
   
   CALL amhi206_b_fill2("1=1")
   
END FUNCTION

################################################################################
# Descriptions...: excel导入检查
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
PRIVATE FUNCTION amhi206_check()
#DEFINE l_mhaw      RECORD LIKE mhaw_t.*   #161104-00002#2 by sakura mark
#161104-00002#2 by sakura add(S)
DEFINE l_mhaw RECORD  #場地資料匯入臨時檔
       mhawent LIKE mhaw_t.mhawent, #企業編號
       mhawsite LIKE mhaw_t.mhawsite, #營運據點
       mhawunit LIKE mhaw_t.mhawunit, #應用組織
       mhaw001 LIKE mhaw_t.mhaw001, #樓棟編號
       mhaw002 LIKE mhaw_t.mhaw002, #樓棟名稱
       mhaw003 LIKE mhaw_t.mhaw003, #樓棟圖紙建築面積
       mhaw004 LIKE mhaw_t.mhaw004, #樓棟圖紙測量面積
       mhaw005 LIKE mhaw_t.mhaw005, #樓層編號
       mhaw006 LIKE mhaw_t.mhaw006, #樓層名稱
       mhaw007 LIKE mhaw_t.mhaw007, #樓層圖紙建築面積
       mhaw008 LIKE mhaw_t.mhaw008, #樓層圖紙測量面積
       mhaw009 LIKE mhaw_t.mhaw009, #建築公攤率
       mhaw010 LIKE mhaw_t.mhaw010, #公攤系數
       mhaw011 LIKE mhaw_t.mhaw011, #區域編號
       mhaw012 LIKE mhaw_t.mhaw012, #區域名稱
       mhaw013 LIKE mhaw_t.mhaw013, #場地編號
       mhaw014 LIKE mhaw_t.mhaw014, #場地名稱
       mhaw015 LIKE mhaw_t.mhaw015, #建築面積
       mhaw016 LIKE mhaw_t.mhaw016, #測量面積
       mhaw017 LIKE mhaw_t.mhaw017, #經營面積
       mhaw018 LIKE mhaw_t.mhaw018, #場地使用狀態
       mhaw019 LIKE mhaw_t.mhaw019  #有效否
END RECORD
#161104-00002#2 by sakura add(E)
DEFINE l_cnt       LIKE type_t.num10
DEFINE r_success   LIKE type_t.num5  
DEFINE l_sql       STRING

   LET r_success = TRUE
   CALL cl_err_collect_init()   
   INITIALIZE l_mhaw.* TO NULL
   #LET l_sql = " SELECT * FROM mhaw_t ",   #161104-00002#2 by sakura mark
   #161104-00002#2 by sakura add(S)
   LET l_sql = " SELECT mhawent,mhawsite,mhawunit,mhaw001,mhaw002,mhaw003, ",
               "        mhaw004,mhaw005 ,mhaw006 ,mhaw007,mhaw008,mhaw009, ",
               "        mhaw010,mhaw011 ,mhaw012 ,mhaw013,mhaw014,mhaw015, ",
               "        mhaw016,mhaw017,mhaw018,mhaw019 ",
               "FROM mhaw_t ",    
   #161104-00002#2 by sakura add(E)
               "  WHERE mhawent = ",g_enterprise,
               "    AND mhawsite = '",g_site,"'"
   PREPARE sel_mhaw_chk FROM l_sql
   DECLARE sel_mhaw_chk_cs CURSOR FOR sel_mhaw_chk
   
   #FOREACH sel_mhaw_chk_cs INTO l_mhaw.*   #161104-00002#2 by sakura mark
   #161104-00002#2 by sakura add(S)
   FOREACH sel_mhaw_chk_cs INTO l_mhaw.mhawent,l_mhaw.mhawsite,l_mhaw.mhawunit,l_mhaw.mhaw001,l_mhaw.mhaw002,l_mhaw.mhaw003,
                                l_mhaw.mhaw004,l_mhaw.mhaw005 ,l_mhaw.mhaw006 ,l_mhaw.mhaw007,l_mhaw.mhaw008,l_mhaw.mhaw009,
                                l_mhaw.mhaw010,l_mhaw.mhaw011 ,l_mhaw.mhaw012 ,l_mhaw.mhaw013,l_mhaw.mhaw014,l_mhaw.mhaw015,
                                l_mhaw.mhaw016,l_mhaw.mhaw017 ,l_mhaw.mhaw018 ,l_mhaw.mhaw019
   #161104-00002#2 by sakura add(E)
      IF l_mhaw.mhawsite IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00451'
         LET g_errparam.extend = l_mhaw.mhawsite
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
      END IF
      
      #楼栋编号不可为null
      IF l_mhaw.mhaw001 IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00451'
         LET g_errparam.extend = l_mhaw.mhaw001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
      END IF
      #楼层编号不可为null
      IF l_mhaw.mhaw005 IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00451'
         LET g_errparam.extend = l_mhaw.mhaw005
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
      END IF
      #区域编号不可为空
      IF l_mhaw.mhaw011 IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00451'
         LET g_errparam.extend = l_mhaw.mhaw011
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
      END IF
      #场地编号不可为空
      IF l_mhaw.mhaw013 IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00451'
         LET g_errparam.extend = l_mhaw.mhaw013
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
      END IF
      
      #场地不可重复
      SELECT COUNT(*) INTO l_cnt
        FROM mhad_t
       WHERE mhadent=g_enterprise
         AND mhadsite=g_site
         AND mhad001=l_mhaw.mhaw001
         AND mhad002=l_mhaw.mhaw005
         AND mhad003=l_mhaw.mhaw011
         AND mhad004=l_mhaw.mhaw013
      
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00394'
         LET g_errparam.extend = l_mhaw.mhaw013
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
      END IF
   END FOREACH
   
   CALL cl_err_collect_show()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: EXCEL导入
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
PRIVATE FUNCTION amhi206_ins()
DEFINE l_sql       STRING
#161104-00002#2 by sakura mark(S)
#DEFINE l_mhaw      RECORD LIKE mhaw_t.* 
#DEFINE l_mhaa      RECORD LIKE mhaa_t.*
#DEFINE l_mhab      RECORD LIKE mhab_t.*
#DEFINE l_mhac      RECORD LIKE mhac_t.*
#DEFINE l_mhad      RECORD LIKE mhad_t.*
#161104-00002#2 by sakura mark(E)
#161104-00002#2 by sakura add(S)
DEFINE l_mhaw RECORD  #場地資料匯入臨時檔
       mhawent LIKE mhaw_t.mhawent, #企業編號
       mhawsite LIKE mhaw_t.mhawsite, #營運據點
       mhawunit LIKE mhaw_t.mhawunit, #應用組織
       mhaw001 LIKE mhaw_t.mhaw001, #樓棟編號
       mhaw002 LIKE mhaw_t.mhaw002, #樓棟名稱
       mhaw003 LIKE mhaw_t.mhaw003, #樓棟圖紙建築面積
       mhaw004 LIKE mhaw_t.mhaw004, #樓棟圖紙測量面積
       mhaw005 LIKE mhaw_t.mhaw005, #樓層編號
       mhaw006 LIKE mhaw_t.mhaw006, #樓層名稱
       mhaw007 LIKE mhaw_t.mhaw007, #樓層圖紙建築面積
       mhaw008 LIKE mhaw_t.mhaw008, #樓層圖紙測量面積
       mhaw009 LIKE mhaw_t.mhaw009, #建築公攤率
       mhaw010 LIKE mhaw_t.mhaw010, #公攤系數
       mhaw011 LIKE mhaw_t.mhaw011, #區域編號
       mhaw012 LIKE mhaw_t.mhaw012, #區域名稱
       mhaw013 LIKE mhaw_t.mhaw013, #場地編號
       mhaw014 LIKE mhaw_t.mhaw014, #場地名稱
       mhaw015 LIKE mhaw_t.mhaw015, #建築面積
       mhaw016 LIKE mhaw_t.mhaw016, #測量面積
       mhaw017 LIKE mhaw_t.mhaw017, #經營面積
       mhaw018 LIKE mhaw_t.mhaw018, #場地使用狀態
       mhaw019 LIKE mhaw_t.mhaw019  #有效否
END RECORD
DEFINE l_mhaa RECORD  #樓棟基本資料檔
       mhaaent LIKE mhaa_t.mhaaent, #企業編號
       mhaasite LIKE mhaa_t.mhaasite, #營運據點
       mhaaunit LIKE mhaa_t.mhaaunit, #應用組織
       mhaa001 LIKE mhaa_t.mhaa001, #樓棟編號
       mhaa002 LIKE mhaa_t.mhaa002, #建築面積
       mhaa003 LIKE mhaa_t.mhaa003, #測量面積
       mhaa004 LIKE mhaa_t.mhaa004, #經營面積
       mhaa005 LIKE mhaa_t.mhaa005, #圖紙建築面積
       mhaa006 LIKE mhaa_t.mhaa006, #圖紙測量面積
       mhaaownid LIKE mhaa_t.mhaaownid, #資料所有者
       mhaaowndp LIKE mhaa_t.mhaaowndp, #資料所屬部門
       mhaacrtid LIKE mhaa_t.mhaacrtid, #資料建立者
       mhaacrtdp LIKE mhaa_t.mhaacrtdp, #資料建立部門
       mhaacrtdt LIKE mhaa_t.mhaacrtdt, #資料創建日
       mhaamodid LIKE mhaa_t.mhaamodid, #資料修改者
       mhaamoddt LIKE mhaa_t.mhaamoddt, #最近修改日
       mhaastus LIKE mhaa_t.mhaastus,  #狀態碼
       #161123-00042#2 by sakura add(S)
       mhaaud001 LIKE mhaa_t.mhaaud001, #自定義欄位(文字)001
       mhaaud002 LIKE mhaa_t.mhaaud002, #自定義欄位(文字)002
       mhaaud003 LIKE mhaa_t.mhaaud003, #自定義欄位(文字)003
       mhaaud004 LIKE mhaa_t.mhaaud004, #自定義欄位(文字)004
       mhaaud005 LIKE mhaa_t.mhaaud005, #自定義欄位(文字)005
       mhaaud006 LIKE mhaa_t.mhaaud006, #自定義欄位(文字)006
       mhaaud007 LIKE mhaa_t.mhaaud007, #自定義欄位(文字)007
       mhaaud008 LIKE mhaa_t.mhaaud008, #自定義欄位(文字)008
       mhaaud009 LIKE mhaa_t.mhaaud009, #自定義欄位(文字)009
       mhaaud010 LIKE mhaa_t.mhaaud010, #自定義欄位(文字)010
       mhaaud011 LIKE mhaa_t.mhaaud011, #自定義欄位(數字)011
       mhaaud012 LIKE mhaa_t.mhaaud012, #自定義欄位(數字)012
       mhaaud013 LIKE mhaa_t.mhaaud013, #自定義欄位(數字)013
       mhaaud014 LIKE mhaa_t.mhaaud014, #自定義欄位(數字)014
       mhaaud015 LIKE mhaa_t.mhaaud015, #自定義欄位(數字)015
       mhaaud016 LIKE mhaa_t.mhaaud016, #自定義欄位(數字)016
       mhaaud017 LIKE mhaa_t.mhaaud017, #自定義欄位(數字)017
       mhaaud018 LIKE mhaa_t.mhaaud018, #自定義欄位(數字)018
       mhaaud019 LIKE mhaa_t.mhaaud019, #自定義欄位(數字)019
       mhaaud020 LIKE mhaa_t.mhaaud020, #自定義欄位(數字)020
       mhaaud021 LIKE mhaa_t.mhaaud021, #自定義欄位(日期時間)021
       mhaaud022 LIKE mhaa_t.mhaaud022, #自定義欄位(日期時間)022
       mhaaud023 LIKE mhaa_t.mhaaud023, #自定義欄位(日期時間)023
       mhaaud024 LIKE mhaa_t.mhaaud024, #自定義欄位(日期時間)024
       mhaaud025 LIKE mhaa_t.mhaaud025, #自定義欄位(日期時間)025
       mhaaud026 LIKE mhaa_t.mhaaud026, #自定義欄位(日期時間)026
       mhaaud027 LIKE mhaa_t.mhaaud027, #自定義欄位(日期時間)027
       mhaaud028 LIKE mhaa_t.mhaaud028, #自定義欄位(日期時間)028
       mhaaud029 LIKE mhaa_t.mhaaud029, #自定義欄位(日期時間)029
       mhaaud030 LIKE mhaa_t.mhaaud030  #自定義欄位(日期時間)030
       #161123-00042#2 by sakura add(E)       
END RECORD
DEFINE l_mhab RECORD  #樓層基本資料檔
       mhabent LIKE mhab_t.mhabent, #企業編號
       mhabsite LIKE mhab_t.mhabsite, #營運據點
       mhabunit LIKE mhab_t.mhabunit, #應用組織
       mhab001 LIKE mhab_t.mhab001, #樓棟編號
       mhab002 LIKE mhab_t.mhab002, #樓層編號
       mhab003 LIKE mhab_t.mhab003, #建築面積
       mhab004 LIKE mhab_t.mhab004, #測量面積
       mhab005 LIKE mhab_t.mhab005, #經營面積
       mhab006 LIKE mhab_t.mhab006, #圖紙建築面積
       mhab007 LIKE mhab_t.mhab007, #圖紙測量面積
       mhab008 LIKE mhab_t.mhab008, #建築公攤率
       mhab009 LIKE mhab_t.mhab009, #公攤系數
       mhabownid LIKE mhab_t.mhabownid, #資料所有者
       mhabowndp LIKE mhab_t.mhabowndp, #資料所屬部門
       mhabcrtid LIKE mhab_t.mhabcrtid, #資料建立者
       mhabcrtdp LIKE mhab_t.mhabcrtdp, #資料建立部門
       mhabcrtdt LIKE mhab_t.mhabcrtdt, #資料創建日
       mhabmodid LIKE mhab_t.mhabmodid, #資料修改者
       mhabmoddt LIKE mhab_t.mhabmoddt, #最近修改日
       mhabstus LIKE mhab_t.mhabstus, #狀態碼
       #161123-00042#2 by sakura add(S)
       mhabud001 LIKE mhab_t.mhabud001, #自定義欄位(文字)001
       mhabud002 LIKE mhab_t.mhabud002, #自定義欄位(文字)002
       mhabud003 LIKE mhab_t.mhabud003, #自定義欄位(文字)003
       mhabud004 LIKE mhab_t.mhabud004, #自定義欄位(文字)004
       mhabud005 LIKE mhab_t.mhabud005, #自定義欄位(文字)005
       mhabud006 LIKE mhab_t.mhabud006, #自定義欄位(文字)006
       mhabud007 LIKE mhab_t.mhabud007, #自定義欄位(文字)007
       mhabud008 LIKE mhab_t.mhabud008, #自定義欄位(文字)008
       mhabud009 LIKE mhab_t.mhabud009, #自定義欄位(文字)009
       mhabud010 LIKE mhab_t.mhabud010, #自定義欄位(文字)010
       mhabud011 LIKE mhab_t.mhabud011, #自定義欄位(數字)011
       mhabud012 LIKE mhab_t.mhabud012, #自定義欄位(數字)012
       mhabud013 LIKE mhab_t.mhabud013, #自定義欄位(數字)013
       mhabud014 LIKE mhab_t.mhabud014, #自定義欄位(數字)014
       mhabud015 LIKE mhab_t.mhabud015, #自定義欄位(數字)015
       mhabud016 LIKE mhab_t.mhabud016, #自定義欄位(數字)016
       mhabud017 LIKE mhab_t.mhabud017, #自定義欄位(數字)017
       mhabud018 LIKE mhab_t.mhabud018, #自定義欄位(數字)018
       mhabud019 LIKE mhab_t.mhabud019, #自定義欄位(數字)019
       mhabud020 LIKE mhab_t.mhabud020, #自定義欄位(數字)020
       mhabud021 LIKE mhab_t.mhabud021, #自定義欄位(日期時間)021
       mhabud022 LIKE mhab_t.mhabud022, #自定義欄位(日期時間)022
       mhabud023 LIKE mhab_t.mhabud023, #自定義欄位(日期時間)023
       mhabud024 LIKE mhab_t.mhabud024, #自定義欄位(日期時間)024
       mhabud025 LIKE mhab_t.mhabud025, #自定義欄位(日期時間)025
       mhabud026 LIKE mhab_t.mhabud026, #自定義欄位(日期時間)026
       mhabud027 LIKE mhab_t.mhabud027, #自定義欄位(日期時間)027
       mhabud028 LIKE mhab_t.mhabud028, #自定義欄位(日期時間)028
       mhabud029 LIKE mhab_t.mhabud029, #自定義欄位(日期時間)029
       mhabud030 LIKE mhab_t.mhabud030  #自定義欄位(日期時間)030
       #161123-00042#2 by sakura add(E)       
END RECORD
DEFINE l_mhac RECORD  #區域基本資料檔
       mhacent LIKE mhac_t.mhacent, #企業編號
       mhacsite LIKE mhac_t.mhacsite, #營運據點
       mhacunit LIKE mhac_t.mhacunit, #應用組織
       mhac001 LIKE mhac_t.mhac001, #樓棟編號
       mhac002 LIKE mhac_t.mhac002, #樓層編號
       mhac003 LIKE mhac_t.mhac003, #區域編號
       mhac004 LIKE mhac_t.mhac004, #建築面積
       mhac005 LIKE mhac_t.mhac005, #測量面積
       mhac006 LIKE mhac_t.mhac006, #經營面積
       mhacstus LIKE mhac_t.mhacstus, #狀態碼
       mhacownid LIKE mhac_t.mhacownid, #資料所有者
       mhacowndp LIKE mhac_t.mhacowndp, #資料所屬部門
       mhaccrtid LIKE mhac_t.mhaccrtid, #資料建立者
       mhaccrtdp LIKE mhac_t.mhaccrtdp, #資料建立部門
       mhaccrtdt LIKE mhac_t.mhaccrtdt, #資料創建日
       mhacmodid LIKE mhac_t.mhacmodid, #資料修改者
       mhacmoddt LIKE mhac_t.mhacmoddt, #最近修改日
       #161123-00042#2 by sakura add(S)
       mhacud001 LIKE mhac_t.mhacud001, #自定義欄位(文字)001
       mhacud002 LIKE mhac_t.mhacud002, #自定義欄位(文字)002
       mhacud003 LIKE mhac_t.mhacud003, #自定義欄位(文字)003
       mhacud004 LIKE mhac_t.mhacud004, #自定義欄位(文字)004
       mhacud005 LIKE mhac_t.mhacud005, #自定義欄位(文字)005
       mhacud006 LIKE mhac_t.mhacud006, #自定義欄位(文字)006
       mhacud007 LIKE mhac_t.mhacud007, #自定義欄位(文字)007
       mhacud008 LIKE mhac_t.mhacud008, #自定義欄位(文字)008
       mhacud009 LIKE mhac_t.mhacud009, #自定義欄位(文字)009
       mhacud010 LIKE mhac_t.mhacud010, #自定義欄位(文字)010
       mhacud011 LIKE mhac_t.mhacud011, #自定義欄位(數字)011
       mhacud012 LIKE mhac_t.mhacud012, #自定義欄位(數字)012
       mhacud013 LIKE mhac_t.mhacud013, #自定義欄位(數字)013
       mhacud014 LIKE mhac_t.mhacud014, #自定義欄位(數字)014
       mhacud015 LIKE mhac_t.mhacud015, #自定義欄位(數字)015
       mhacud016 LIKE mhac_t.mhacud016, #自定義欄位(數字)016
       mhacud017 LIKE mhac_t.mhacud017, #自定義欄位(數字)017
       mhacud018 LIKE mhac_t.mhacud018, #自定義欄位(數字)018
       mhacud019 LIKE mhac_t.mhacud019, #自定義欄位(數字)019
       mhacud020 LIKE mhac_t.mhacud020, #自定義欄位(數字)020
       mhacud021 LIKE mhac_t.mhacud021, #自定義欄位(日期時間)021
       mhacud022 LIKE mhac_t.mhacud022, #自定義欄位(日期時間)022
       mhacud023 LIKE mhac_t.mhacud023, #自定義欄位(日期時間)023
       mhacud024 LIKE mhac_t.mhacud024, #自定義欄位(日期時間)024
       mhacud025 LIKE mhac_t.mhacud025, #自定義欄位(日期時間)025
       mhacud026 LIKE mhac_t.mhacud026, #自定義欄位(日期時間)026
       mhacud027 LIKE mhac_t.mhacud027, #自定義欄位(日期時間)027
       mhacud028 LIKE mhac_t.mhacud028, #自定義欄位(日期時間)028
       mhacud029 LIKE mhac_t.mhacud029, #自定義欄位(日期時間)029
       mhacud030 LIKE mhac_t.mhacud030  #自定義欄位(日期時間)030
       #161123-00042#2 by sakura add(E)       
END RECORD
DEFINE l_mhad RECORD  #場地基本資料檔
       mhadent LIKE mhad_t.mhadent, #企業編號
       mhadsite LIKE mhad_t.mhadsite, #營運據點
       mhadunit LIKE mhad_t.mhadunit, #應用組織
       mhad001 LIKE mhad_t.mhad001, #樓棟編號
       mhad002 LIKE mhad_t.mhad002, #樓層編號
       mhad003 LIKE mhad_t.mhad003, #區域編號
       mhad004 LIKE mhad_t.mhad004, #場地編號
       mhad005 LIKE mhad_t.mhad005, #建築面積
       mhad006 LIKE mhad_t.mhad006, #測量面積
       mhad007 LIKE mhad_t.mhad007, #經營面積
       mhad008 LIKE mhad_t.mhad008, #場地使用狀態
       mhadstus LIKE mhad_t.mhadstus, #狀態碼
       mhadownid LIKE mhad_t.mhadownid, #資料所有者
       mhadowndp LIKE mhad_t.mhadowndp, #資料所屬部門
       mhadcrtid LIKE mhad_t.mhadcrtid, #資料建立者
       mhadcrtdp LIKE mhad_t.mhadcrtdp, #資料建立部門
       mhadcrtdt LIKE mhad_t.mhadcrtdt, #資料創建日
       mhadmodid LIKE mhad_t.mhadmodid, #資料修改者
       mhadmoddt LIKE mhad_t.mhadmoddt, #最近修改日
       #161123-00042#2 by sakura add(S)
       mhadud001 LIKE mhad_t.mhadud001, #自定義欄位(文字)001
       mhadud002 LIKE mhad_t.mhadud002, #自定義欄位(文字)002
       mhadud003 LIKE mhad_t.mhadud003, #自定義欄位(文字)003
       mhadud004 LIKE mhad_t.mhadud004, #自定義欄位(文字)004
       mhadud005 LIKE mhad_t.mhadud005, #自定義欄位(文字)005
       mhadud006 LIKE mhad_t.mhadud006, #自定義欄位(文字)006
       mhadud007 LIKE mhad_t.mhadud007, #自定義欄位(文字)007
       mhadud008 LIKE mhad_t.mhadud008, #自定義欄位(文字)008
       mhadud009 LIKE mhad_t.mhadud009, #自定義欄位(文字)009
       mhadud010 LIKE mhad_t.mhadud010, #自定義欄位(文字)010
       mhadud011 LIKE mhad_t.mhadud011, #自定義欄位(數字)011
       mhadud012 LIKE mhad_t.mhadud012, #自定義欄位(數字)012
       mhadud013 LIKE mhad_t.mhadud013, #自定義欄位(數字)013
       mhadud014 LIKE mhad_t.mhadud014, #自定義欄位(數字)014
       mhadud015 LIKE mhad_t.mhadud015, #自定義欄位(數字)015
       mhadud016 LIKE mhad_t.mhadud016, #自定義欄位(數字)016
       mhadud017 LIKE mhad_t.mhadud017, #自定義欄位(數字)017
       mhadud018 LIKE mhad_t.mhadud018, #自定義欄位(數字)018
       mhadud019 LIKE mhad_t.mhadud019, #自定義欄位(數字)019
       mhadud020 LIKE mhad_t.mhadud020, #自定義欄位(數字)020
       mhadud021 LIKE mhad_t.mhadud021, #自定義欄位(日期時間)021
       mhadud022 LIKE mhad_t.mhadud022, #自定義欄位(日期時間)022
       mhadud023 LIKE mhad_t.mhadud023, #自定義欄位(日期時間)023
       mhadud024 LIKE mhad_t.mhadud024, #自定義欄位(日期時間)024
       mhadud025 LIKE mhad_t.mhadud025, #自定義欄位(日期時間)025
       mhadud026 LIKE mhad_t.mhadud026, #自定義欄位(日期時間)026
       mhadud027 LIKE mhad_t.mhadud027, #自定義欄位(日期時間)027
       mhadud028 LIKE mhad_t.mhadud028, #自定義欄位(日期時間)028
       mhadud029 LIKE mhad_t.mhadud029, #自定義欄位(日期時間)029
       mhadud030 LIKE mhad_t.mhadud030, #自定義欄位(日期時間)030      
       #161123-00042#2 by sakura add(E)
       mhad009 LIKE mhad_t.mhad009, #版本
       mhad010 LIKE mhad_t.mhad010  #場地等級        
END RECORD
#161104-00002#2 by sakura add(E)
DEFINE l_success   LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5


   WHENEVER ERROR CONTINUE
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET g_cnt1 = 0
   INITIALIZE l_mhaw.* TO NULL
   
   #LET l_sql="SELECT * ",
   #161104-00002#2 by sakura add(S)
   LET l_sql = " SELECT mhawent,mhawsite,mhawunit,mhaw001,mhaw002,mhaw003, ",
               "        mhaw004,mhaw005 ,mhaw006 ,mhaw007,mhaw008,mhaw009, ",
               "        mhaw010,mhaw011 ,mhaw012 ,mhaw013,mhaw014,mhaw015, ",
               "        mhaw016,mhaw017,mhaw018,mhaw019 ",   
   #161104-00002#2 by sakura add(E)   
               " FROM mhaw_t WHERE mhawent =",g_enterprise," AND mhawsite='",g_site,"'"
   PREPARE sel_mhaw FROM l_sql
   DECLARE sel_mhaw_cs CURSOR FOR sel_mhaw
   
   #FOREACH sel_mhaw_cs INTO l_mhaw.*   #161104-00002#2 by sakura mark
   #161104-00002#2 by sakura add(S)
   FOREACH sel_mhaw_cs INTO l_mhaw.mhawent,l_mhaw.mhawsite,l_mhaw.mhawunit,l_mhaw.mhaw001,l_mhaw.mhaw002,l_mhaw.mhaw003,
                            l_mhaw.mhaw004,l_mhaw.mhaw005 ,l_mhaw.mhaw006 ,l_mhaw.mhaw007,l_mhaw.mhaw008,l_mhaw.mhaw009,
                            l_mhaw.mhaw010,l_mhaw.mhaw011 ,l_mhaw.mhaw012 ,l_mhaw.mhaw013,l_mhaw.mhaw014,l_mhaw.mhaw015,
                            l_mhaw.mhaw016,l_mhaw.mhaw017 ,l_mhaw.mhaw018 ,l_mhaw.mhaw019
   #161104-00002#2 by sakura add(E)   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         LET g_cnt1=g_cnt1+1
         INITIALIZE l_mhaa.* TO NULL
         INITIALIZE l_mhab.* TO NULL
         INITIALIZE l_mhac.* TO NULL
         INITIALIZE l_mhad.* TO NULL
         
         #楼栋资料
         LET l_cnt = NULL
         SELECT COUNT(*) INTO l_cnt FROM mhaa_t 
          WHERE mhaaent=g_enterprise AND mhaasite=g_site AND mhaa001=l_mhaw.mhaw001
         IF l_cnt = 0 THEN
            LET l_mhaa.mhaaent  = g_enterprise
            LET l_mhaa.mhaasite = l_mhaw.mhawsite
            LET l_mhaa.mhaaunit = l_mhaw.mhawunit
            LET l_mhaa.mhaa001  = l_mhaw.mhaw001  #楼栋编号
            LET l_mhaa.mhaa005  = l_mhaw.mhaw003  #图纸建筑面积
            LET l_mhaa.mhaa006  = l_mhaw.mhaw004  #图纸测量面积
            LET l_mhaa.mhaastus = 'Y'
            LET l_mhaa.mhaaownid = g_user
            LET l_mhaa.mhaaowndp = g_dept
            LET l_mhaa.mhaacrtid = g_user
            LET l_mhaa.mhaacrtdp = g_dept
            LET l_mhaa.mhaacrtdt = cl_get_current() 
            
            INSERT INTO mhaa_t (mhaaent,mhaasite,mhaaunit,mhaa001,mhaa005,
                                mhaa006,mhaastus,mhaaownid,mhaaowndp,mhaacrtid,
                                mhaacrtdp,mhaacrtdt)
                         VALUES(l_mhaa.mhaaent,l_mhaa.mhaasite,l_mhaa.mhaaunit,
                                l_mhaa.mhaa001,l_mhaa.mhaa005,l_mhaa.mhaa006,l_mhaa.mhaastus,
                                l_mhaa.mhaaownid,l_mhaa.mhaaowndp,l_mhaa.mhaacrtid,
                                l_mhaa.mhaacrtdp,l_mhaa.mhaacrtdt)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhaa_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            INITIALIZE l_vars TO NULL 
            INITIALIZE l_fields TO NULL 
            INITIALIZE l_var_keys_bak TO NULL 
            
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = l_mhaa.mhaa001
            LET l_field_keys[02] = 'mhaal001'
            LET l_var_keys_bak[02] = l_mhaa.mhaa001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mhaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = l_mhaw.mhaw002
            LET l_fields[01] = 'mhaal003'
            LET l_vars[02] = ''
            LET l_fields[02] = 'mhaal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhaal_t')
          
            
         END IF
         
         #楼层资料
         LET l_cnt=NULL
         SELECT COUNT(*) INTO l_cnt FROM mhab_t
          WHERE mhabent=g_enterprise 
            AND mhab001=l_mhaw.mhaw001 AND mhab002=l_mhaw.mhaw005
         
         IF l_cnt = 0 THEN
            LET l_mhab.mhabent=g_enterprise
            LET l_mhab.mhabsite=l_mhaw.mhawsite
            LET l_mhab.mhabunit=l_mhaw.mhawunit
            LET l_mhab.mhab001 =l_mhaw.mhaw001
            LET l_mhab.mhab002 =l_mhaw.mhaw005
            LET l_mhab.mhab006 =l_mhaw.mhaw007
            LET l_mhab.mhab007 =l_mhaw.mhaw008
            LET l_mhab.mhab008 =l_mhaw.mhaw009
            LET l_mhab.mhab009 =l_mhaw.mhaw010
            LET l_mhab.mhabstus='Y'
            LET l_mhab.mhabownid = g_user
            LET l_mhab.mhabowndp = g_dept
            LET l_mhab.mhabcrtid = g_user
            LET l_mhab.mhabcrtdp = g_dept
            LET l_mhab.mhabcrtdt = cl_get_current()
            
            INSERT INTO mhab_t (mhabent,mhabsite,mhabunit,mhab001,mhab002,
                                mhab006,mhab007,mhab008,mhab009,mhabstus,
                                mhabownid,mhabowndp,mhabcrtid,mhabcrtdp,
                                mhabcrtdt)
                         VALUES(l_mhab.mhabent,l_mhab.mhabsite,l_mhab.mhabunit,l_mhab.mhab001,l_mhab.mhab002,
                                l_mhab.mhab006,l_mhab.mhab007,l_mhab.mhab008,l_mhab.mhab009,l_mhab.mhabstus,
                                l_mhab.mhabownid,l_mhab.mhabowndp,l_mhab.mhabcrtid,l_mhab.mhabcrtdp,l_mhab.mhabcrtdt)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhaa_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            INITIALIZE l_vars TO NULL 
            INITIALIZE l_fields TO NULL 
            INITIALIZE l_var_keys_bak TO NULL
            
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhablent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = l_mhab.mhab001
            LET l_field_keys[02] = 'mhabl001'
            LET l_var_keys_bak[02] = l_mhab.mhab001
            LET l_var_keys[03] = l_mhab.mhab002
            LET l_field_keys[03] = 'mhabl002'
            LET l_var_keys_bak[03] = l_mhab.mhab001
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'mhabl003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = l_mhaw.mhaw006
            LET l_fields[01] = 'mhabl004'
            LET l_vars[02] = ''
            LET l_fields[02] = 'mhabl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhabl_t')            
            
         
         END IF
         
         #区域资料
         LET l_cnt = NULL
         SELECT COUNT(*) INTO l_cnt FROM mhac_t 
          WHERE mhacent=g_enterprise AND mhac001=l_mhaw.mhaw001 
            AND mhac002 = l_mhaw.mhaw005 AND mhac003=l_mhaw.mhaw011
         IF l_cnt = 0 THEN
            LET l_mhac.mhacent=g_enterprise
            LET l_mhac.mhacsite=l_mhaw.mhawsite
            LET l_mhac.mhacunit=l_mhaw.mhawunit
            LET l_mhac.mhac001 =l_mhaw.mhaw001
            LET l_mhac.mhac002 =l_mhaw.mhaw005
            LET l_mhac.mhac003 =l_mhaw.mhaw011
            LET l_mhac.mhacstus='Y'
            LET l_mhac.mhacownid=g_user
            LET l_mhac.mhacowndp=g_dept
            LET l_mhac.mhaccrtid=g_user
            LET l_mhac.mhaccrtdp=g_dept
            LET l_mhac.mhaccrtdt=cl_get_current()
            
            INSERT INTO mhac_t (mhacent,mhacsite,mhacunit,mhac001,mhac002,mhac003,
                                mhacstus,mhacownid,mhacowndp,mhaccrtid,mhaccrtdp,
                                mhaccrtdt)
                         VALUES(l_mhac.mhacent,l_mhac.mhacsite,l_mhac.mhacunit,l_mhac.mhac001,
                                l_mhac.mhac002,l_mhac.mhac003,l_mhac.mhacstus,l_mhac.mhacownid,
                                l_mhac.mhacowndp,l_mhac.mhaccrtid,l_mhac.mhaccrtdp,l_mhac.mhaccrtdt)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhaa_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
            END IF
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            INITIALIZE l_vars TO NULL 
            INITIALIZE l_fields TO NULL 
            INITIALIZE l_var_keys_bak TO NULL
            
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhaclent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = l_mhac.mhac001
            LET l_field_keys[02] = 'mhacl001'
            LET l_var_keys_bak[02] = l_mhac.mhac001
            LET l_var_keys[03] = l_mhac.mhac002
            LET l_field_keys[03] = 'mhacl002'
            LET l_var_keys_bak[03] = l_mhac.mhac002
            LET l_var_keys[04] = l_mhac.mhac003
            LET l_field_keys[04] = 'mhacl003'
            LET l_var_keys_bak[04] = l_mhac.mhac003
            LET l_var_keys[05] = g_dlang
            LET l_field_keys[05] = 'mhacl004'
            LET l_var_keys_bak[05] = g_dlang
            LET l_vars[01] = l_mhaw.mhaw012
            LET l_fields[01] = 'mhacl005'
            LET l_vars[02] = ''
            LET l_fields[02] = 'mhacl006'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhacl_t')
         END IF
         
         #场地资料
         LET l_cnt = NULL 
         SELECT COUNT(*) INTO l_cnt FROM mhad_t 
          WHERE mhadent=g_enterprise AND mhad001=l_mhaw.mhaw001 
            AND mhad002=l_mhaw.mhaw005 AND mhad003=l_mhaw.mhaw011
            AND mhad004=l_mhaw.mhaw013
         IF l_cnt = 0 THEN
             LET l_mhad.mhadent=g_enterprise
             LET l_mhad.mhadsite=l_mhaw.mhawsite
             LET l_mhad.mhadunit=l_mhaw.mhawunit
             LET l_mhad.mhad001=l_mhaw.mhaw001
             LET l_mhad.mhad002=l_mhaw.mhaw005
             LET l_mhad.mhad003=l_mhaw.mhaw011
             LET l_mhad.mhad004=l_mhaw.mhaw013
             LET l_mhad.mhad005=l_mhaw.mhaw015 #建筑面积
             LET l_mhad.mhad006=l_mhaw.mhaw016 #测量面积
             LET l_mhad.mhad007=l_mhaw.mhaw017 #经营面积
             LET l_mhad.mhad008=l_mhaw.mhaw018 #场地使用状态
             LET l_mhad.mhadstus=l_mhaw.mhaw019 #有效否
             LET l_mhad.mhadownid=g_user
             LET l_mhad.mhadowndp=g_dept
             LET l_mhad.mhadcrtid=g_user
             LET l_mhad.mhadcrtdp=g_dept
             LET l_mhad.mhadcrtdt=cl_get_current()
             
             INSERT INTO mhad_t (mhadent,mhadsite,mhadunit,mhad001,mhad002,mhad003,
                                 mhad004,mhad005,mhad006,mhad007,mhad008,mhadstus,
                                 mhadownid,mhadowndp,mhadcrtid,mhadcrtdp,mhadcrtdt)
                          VALUES (l_mhad.mhadent,l_mhad.mhadsite,l_mhad.mhadunit,l_mhad.mhad001,
                                  l_mhad.mhad002,l_mhad.mhad003,l_mhad.mhad004,l_mhad.mhad005,
                                  l_mhad.mhad006,l_mhad.mhad007,l_mhad.mhad008,l_mhad.mhadstus,
                                  l_mhad.mhadownid,l_mhad.mhadowndp,l_mhad.mhadcrtid,l_mhad.mhadcrtdp,
                                  l_mhad.mhadcrtdt)
             IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mhad_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET l_success = FALSE
             END IF
             INITIALIZE l_var_keys TO NULL 
             INITIALIZE l_field_keys TO NULL 
             INITIALIZE l_vars TO NULL 
             INITIALIZE l_fields TO NULL 
             INITIALIZE l_var_keys_bak TO NULL 
             LET l_var_keys[01] = g_enterprise
             LET l_field_keys[01] = 'mhadlent'
             LET l_var_keys_bak[01] = g_enterprise
             LET l_var_keys[02] = l_mhad.mhad001
             LET l_field_keys[02] = 'mhadl001'
             LET l_var_keys_bak[02] = l_mhad.mhad001
             LET l_var_keys[03] = l_mhad.mhad002
             LET l_field_keys[03] = 'mhadl002'
             LET l_var_keys_bak[03] = l_mhad.mhad002
             LET l_var_keys[04] = l_mhad.mhad003
             LET l_field_keys[04] = 'mhadl003'
             LET l_var_keys_bak[04] = l_mhad.mhad003
             LET l_var_keys[05] = l_mhad.mhad004
             LET l_field_keys[05] = 'mhadl004'
             LET l_var_keys_bak[05] = l_mhad.mhad004
             LET l_var_keys[06] = g_dlang
             LET l_field_keys[06] = 'mhadl005'
             LET l_var_keys_bak[06] = g_dlang
             LET l_vars[01] = l_mhaw.mhaw014
             LET l_fields[01] = 'mhadl006'
             LET l_vars[02] = ''
             LET l_fields[02] = 'mhadl007'
             CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhadl_t')
         END IF
         
   END FOREACH
   
   IF l_success THEN 
      CALL cl_err_collect_show()
      CALL s_transaction_end('Y','0')
      RETURN TRUE
   ELSE
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
END FUNCTION

PRIVATE FUNCTION amhi206_mhaasite_ref()
   #161006-00008#2 20161019 add by beckxie---S
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhaa_d[l_ac].mhaasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhaa_d[l_ac].mhaasite_desc
   #161006-00008#2 20161019 add by beckxie---E
END FUNCTION

PRIVATE FUNCTION amhi206_mhaaunit_ref()
   #161006-00008#2 20161019 add by beckxie---S
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhaa_d[l_ac].mhaaunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhaa_d[l_ac].mhaaunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhaa_d[l_ac].mhaaunit_desc
   #161006-00008#2 20161019 add by beckxie---E
END FUNCTION

 
{</section>}
 
