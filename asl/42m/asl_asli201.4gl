#該程式未解開Section, 採用最新樣板產出!
{<section id="asli201.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-09-29 11:44:43), PR版次:0003(2016-10-02 14:41:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000020
#+ Filename...: asli201
#+ Description: 訂貨會訂貨明細調整
#+ Creator....: 03247(2016-08-14 10:06:28)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="asli201.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160922-00032#3  2016/9/26   By   06137    1.对象类型写入xmjd003的值改为1.内部组织，2.客户；2.对象编号根据对象类型开窗的时候，之前门店和客户的开窗要调换；
#160930-00014#1  2016/10/02  By   06137    整单操作的原稿转入画面，对象编号开窗应过滤掉已经'无效'的资料	
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
PRIVATE TYPE type_g_xmjd_d RECORD
       sel LIKE type_t.chr500, 
   xmjd001 LIKE xmjd_t.xmjd001, 
   xmjd002 LIKE xmjd_t.xmjd002, 
   xmjd003 LIKE xmjd_t.xmjd003, 
   xmjd004 LIKE xmjd_t.xmjd004, 
   xmjd005 LIKE xmjd_t.xmjd005, 
   xmjd006 LIKE xmjd_t.xmjd006, 
   xmjd007 LIKE xmjd_t.xmjd007, 
   xmjd008 LIKE xmjd_t.xmjd008, 
   xmjd008_desc LIKE type_t.chr500, 
   xmjd020 LIKE xmjd_t.xmjd020, 
   xmjd021 LIKE xmjd_t.xmjd021, 
   xmjd022 LIKE xmjd_t.xmjd022, 
   xmjd023 LIKE xmjd_t.xmjd023, 
   xmjd024 LIKE xmjd_t.xmjd024, 
   xmjd025 LIKE xmjd_t.xmjd025, 
   xmjd026 LIKE xmjd_t.xmjd026, 
   xmjd027 LIKE xmjd_t.xmjd027, 
   xmjd028 LIKE xmjd_t.xmjd028, 
   xmjd029 LIKE xmjd_t.xmjd029, 
   xmjd030 LIKE xmjd_t.xmjd030, 
   xmjd031 LIKE xmjd_t.xmjd031, 
   xmjd009 LIKE xmjd_t.xmjd009, 
   xmjd010 LIKE xmjd_t.xmjd010, 
   xmjd011 LIKE xmjd_t.xmjd011, 
   xmjd012 LIKE xmjd_t.xmjd012, 
   xmjd013 LIKE xmjd_t.xmjd013, 
   xmjd014 LIKE xmjd_t.xmjd014, 
   xmjd015 LIKE xmjd_t.xmjd015, 
   xmjd016 LIKE xmjd_t.xmjd016, 
   xmjd017 LIKE xmjd_t.xmjd017, 
   xmjdsite LIKE xmjd_t.xmjdsite, 
   xmjdstus LIKE xmjd_t.xmjdstus
       END RECORD
PRIVATE TYPE type_g_xmjd2_d RECORD
       xmjd001 LIKE xmjd_t.xmjd001, 
   xmjd002 LIKE xmjd_t.xmjd002, 
   xmjd003 LIKE xmjd_t.xmjd003, 
   xmjd004 LIKE xmjd_t.xmjd004, 
   xmjd008 LIKE xmjd_t.xmjd008, 
   xmjd010 LIKE xmjd_t.xmjd010, 
   xmjd012 LIKE xmjd_t.xmjd012, 
   xmjdownid LIKE xmjd_t.xmjdownid, 
   xmjdownid_desc LIKE type_t.chr500, 
   xmjdowndp LIKE xmjd_t.xmjdowndp, 
   xmjdowndp_desc LIKE type_t.chr500, 
   xmjdcrtid LIKE xmjd_t.xmjdcrtid, 
   xmjdcrtid_desc LIKE type_t.chr500, 
   xmjdcrtdp LIKE xmjd_t.xmjdcrtdp, 
   xmjdcrtdp_desc LIKE type_t.chr500, 
   xmjdcrtdt DATETIME YEAR TO SECOND, 
   xmjdmodid LIKE xmjd_t.xmjdmodid, 
   xmjdmodid_desc LIKE type_t.chr500, 
   xmjdmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE lwin_curr         ui.Window
DEFINE l_curr_diag       ui.Dialog                     #Current Dialog
DEFINE lfrm_curr         ui.Form
DEFINE ls_path           STRING
DEFINE g_detail_idx2     LIKE type_t.num10
DEFINE l_ac2             LIKE type_t.num10
DEFINE g_detail_tmp      LIKE type_t.num10
DEFINE g_xmjd_d2         DYNAMIC ARRAY OF RECORD
       b_xmjd001           LIKE xmjd_t.xmjd001,
       b_xmjd002           LIKE xmjd_t.xmjd002,
       b_xmjd003           LIKE xmjd_t.xmjd003,
       b_xmjd004           LIKE xmjd_t.xmjd004,
       b_xmjd005           LIKE xmjd_t.xmjd005,
       b_xmjd006           LIKE xmjd_t.xmjd006,
       b_xmjd007           LIKE xmjd_t.xmjd007,
       b_xmjd008           LIKE xmjd_t.xmjd008,
       b_xmjd008_desc      LIKE imaal_t.imaal003,
       b_xmjd020           LIKE xmjd_t.xmjd020,
       b_xmjd021           LIKE xmjd_t.xmjd021,
       b_xmjd022           LIKE xmjd_t.xmjd022,
       b_xmjd023           LIKE xmjd_t.xmjd023,
       b_xmjd024           LIKE xmjd_t.xmjd024,
       b_xmjd025           LIKE xmjd_t.xmjd025,
       b_xmjd026           LIKE xmjd_t.xmjd026,
       b_xmjd027           LIKE xmjd_t.xmjd027,
       b_xmjd028           LIKE xmjd_t.xmjd028,
       b_xmjd029           LIKE xmjd_t.xmjd029,
       b_xmjd030           LIKE xmjd_t.xmjd030,
       b_xmjd031           LIKE xmjd_t.xmjd031,
       b_xmjd009           LIKE xmjd_t.xmjd009,
       b_xmjd010           LIKE xmjd_t.xmjd010,
       b_xmjd011           LIKE xmjd_t.xmjd011,
       b_xmjd012           LIKE xmjd_t.xmjd012,
       b_xmjd013           LIKE xmjd_t.xmjd013,
       b_xmjd014           LIKE xmjd_t.xmjd014,
       b_xmjd015           LIKE xmjd_t.xmjd015,
       b_xmjd016           LIKE xmjd_t.xmjd016
       END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmjd_d          DYNAMIC ARRAY OF type_g_xmjd_d #單身變數
DEFINE g_xmjd_d_t        type_g_xmjd_d                  #單身備份
DEFINE g_xmjd_d_o        type_g_xmjd_d                  #單身備份
DEFINE g_xmjd_d_mask_o   DYNAMIC ARRAY OF type_g_xmjd_d #單身變數
DEFINE g_xmjd_d_mask_n   DYNAMIC ARRAY OF type_g_xmjd_d #單身變數
DEFINE g_xmjd2_d   DYNAMIC ARRAY OF type_g_xmjd2_d
DEFINE g_xmjd2_d_t type_g_xmjd2_d
DEFINE g_xmjd2_d_o type_g_xmjd2_d
DEFINE g_xmjd2_d_mask_o DYNAMIC ARRAY OF type_g_xmjd2_d
DEFINE g_xmjd2_d_mask_n DYNAMIC ARRAY OF type_g_xmjd2_d
 
      
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
 
{<section id="asli201.main" >}
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
   CALL cl_ap_init("asl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xmjd001,xmjd002,xmjd003,xmjd004,xmjd005,xmjd006,xmjd007,xmjd008,xmjd020, 
       xmjd021,xmjd022,xmjd023,xmjd024,xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,xmjd030,xmjd031,xmjd009, 
       xmjd010,xmjd011,xmjd012,xmjd013,xmjd014,xmjd015,xmjd016,xmjd017,xmjdsite,xmjdstus,xmjd001,xmjd002, 
       xmjd003,xmjd004,xmjd008,xmjd010,xmjd012,xmjdownid,xmjdowndp,xmjdcrtid,xmjdcrtdp,xmjdcrtdt,xmjdmodid, 
       xmjdmoddt FROM xmjd_t WHERE xmjdent=? AND xmjd001=? AND xmjd002=? AND xmjd003=? AND xmjd004=?  
       AND xmjd008=? AND xmjd010=? AND xmjd012=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asli201_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asli201 WITH FORM cl_ap_formpath("asl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asli201_init()   
 
      #進入選單 Menu (="N")
      CALL asli201_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asli201
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asli201.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asli201_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('xmjd002','6940') 
   CALL cl_set_combo_scc('xmjd003','6960') 
   CALL cl_set_combo_scc('xmjd017','6961') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
#   LET lwin_curr = ui.Window.getCurrent()
#   LET lfrm_curr = lwin_curr.getForm()
#   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
#   LET ls_path = os.Path.join(ls_path,"toolbar_p.4tb")
#   CALL lfrm_curr.loadToolBar(ls_path)
   CALL cl_set_combo_scc_part('xmjd002','6940','1,2')
   CALL cl_set_combo_scc_part('xmjd003','6960','1,2') 
   #end add-point
   
   CALL asli201_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asli201.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asli201_ui_dialog()
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
   DEFINE l_i                   LIKE type_t.num10
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
         CALL g_xmjd_d.clear()
         CALL g_xmjd2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL asli201_init()
      END IF
   
      CALL asli201_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xmjd_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_xmjd2_d[g_detail_idx].xmjdownid   #(ver:35)
               LET g_data_dept = g_xmjd2_d[g_detail_idx].xmjdowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL asli201_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_xmjd2_d TO s_detail2.*
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
   CALL asli201_set_pk_array()
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
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_upd
            LET g_action_choice="batch_upd"
            IF cl_auth_chk_act("batch_upd") THEN
               
               #add-point:ON ACTION batch_upd name="menu.batch_upd"
               CALL asli201_batch_process('upd')
               CALL asli201_b_fill(g_wc2)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL asli201_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asli201_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL asli201_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asli201_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION seleall
            LET g_action_choice="seleall"
            IF cl_auth_chk_act("seleall") THEN
               
               #add-point:ON ACTION seleall name="menu.seleall"
               FOR li_idx = 1 TO g_xmjd_d.getLength()
                  LET g_xmjd_d[li_idx].sel = 'Y'
               END FOR
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION selenone
            LET g_action_choice="selenone"
            IF cl_auth_chk_act("selenone") THEN
               
               #add-point:ON ACTION selenone name="menu.selenone"
               FOR li_idx = 1 TO g_xmjd_d.getLength()
                  LET g_xmjd_d[li_idx].sel = 'N'
               END FOR
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION selnone
            LET g_action_choice="selnone"
            IF cl_auth_chk_act("selnone") THEN
               
               #add-point:ON ACTION selnone name="menu.selnone"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unsele
            LET g_action_choice="unsele"
            IF cl_auth_chk_act("unsele") THEN
               
               #add-point:ON ACTION unsele name="menu.unsele"
               FOR li_idx = 1 TO g_xmjd_d.getLength()
                  #已選擇的資料
                  IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
                     LET g_xmjd_d[li_idx].sel = 'N'
                  END IF
               END FOR
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL asli201_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asli201_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asli201_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_unconf
            LET g_action_choice="batch_unconf"
            IF cl_auth_chk_act("batch_unconf") THEN
               
               #add-point:ON ACTION batch_unconf name="menu.batch_unconf"
               IF NOT cl_ask_confirm('asl-00011') THEN
                  CONTINUE DIALOG
               END IF
               LET g_detail_tmp = g_detail_idx
               CALL s_transaction_begin()
               FOR l_i = 1 TO g_xmjd_d.getLength()
                  IF g_xmjd_d[l_i].sel = 'Y' AND g_xmjd_d[l_i].xmjd017 = '2' THEN
                     LET g_detail_idx = l_i
                     #確定是否有被鎖定
                     IF NOT asli201_lock_b("xmjd_t") THEN
                        #已被他人鎖定
                        CALL s_transaction_end('N','0')
                        EXIT FOR
                     END IF
                     
                     UPDATE xmjd_t SET xmjd017 = '1'
                      WHERE xmjdent = g_enterprise
                        AND xmjd001 = g_xmjd_d[l_i].xmjd001
                        AND xmjd002 = g_xmjd_d[l_i].xmjd002
                        AND xmjd003 = g_xmjd_d[l_i].xmjd003
                        AND xmjd004 = g_xmjd_d[l_i].xmjd004
                        AND xmjd008 = g_xmjd_d[l_i].xmjd008
                        AND xmjd010 = g_xmjd_d[l_i].xmjd010
                        AND xmjd012 = g_xmjd_d[l_i].xmjd012
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "upd xmjd017" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        EXIT FOR
                     END IF
                  END IF
               END FOR
               CALL s_transaction_end('Y','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "sub-00033"
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_detail_idx = g_detail_tmp
               CALL asli201_b_fill(g_wc2)
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
         ON ACTION selall
            LET g_action_choice="selall"
            IF cl_auth_chk_act("selall") THEN
               
               #add-point:ON ACTION selall name="menu.selall"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION data_ins
            LET g_action_choice="data_ins"
            IF cl_auth_chk_act("data_ins") THEN
               
               #add-point:ON ACTION data_ins name="menu.data_ins"
               CALL asli201_data_ins()
               CALL asli201_b_fill(g_wc2)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asli201_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_conf
            LET g_action_choice="batch_conf"
            IF cl_auth_chk_act("batch_conf") THEN
               
               #add-point:ON ACTION batch_conf name="menu.batch_conf"
               IF NOT cl_ask_confirm('asl-00011') THEN
                  CONTINUE DIALOG
               END IF
               LET g_detail_tmp = g_detail_idx
               CALL s_transaction_begin()
               FOR l_i = 1 TO g_xmjd_d.getLength()
                  IF g_xmjd_d[l_i].sel = 'Y' AND g_xmjd_d[l_i].xmjd017 = '1' THEN
                     LET g_detail_idx = l_i
                     #確定是否有被鎖定
                     IF NOT asli201_lock_b("xmjd_t") THEN
                        #已被他人鎖定
                        CALL s_transaction_end('N','0')
                        EXIT FOR
                     END IF
                     
                     UPDATE xmjd_t SET xmjd017 = '2'
                      WHERE xmjdent = g_enterprise
                        AND xmjd001 = g_xmjd_d[l_i].xmjd001
                        AND xmjd002 = g_xmjd_d[l_i].xmjd002
                        AND xmjd003 = g_xmjd_d[l_i].xmjd003
                        AND xmjd004 = g_xmjd_d[l_i].xmjd004
                        AND xmjd008 = g_xmjd_d[l_i].xmjd008
                        AND xmjd010 = g_xmjd_d[l_i].xmjd010
                        AND xmjd012 = g_xmjd_d[l_i].xmjd012
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "upd xmjd017" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        EXIT FOR
                     END IF
                  END IF
               END FOR
               CALL s_transaction_end('Y','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "sub-00033"
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_detail_idx = g_detail_tmp
               CALL asli201_b_fill(g_wc2)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_order
            LET g_action_choice="batch_order"
            IF cl_auth_chk_act("batch_order") THEN
               
               #add-point:ON ACTION batch_order name="menu.batch_order"
               CALL asli201_batch_process('ins')
               CALL asli201_b_fill(g_wc2)
#            END IF
#            
#         #勾選所選資料
#         ON ACTION sel
#         
#         #選擇全部
#         ON ACTION selall
#         
#         #取消所選資料
#         ON ACTION unsel
#         
#         #取消全部
#         ON ACTION selnone
#            
#            IF 1=1 THEN
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION sele
            LET g_action_choice="sele"
            IF cl_auth_chk_act("sele") THEN
               
               #add-point:ON ACTION sele name="menu.sele"
               FOR li_idx = 1 TO g_xmjd_d.getLength()
                  #已選擇的資料
                  IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
                     LET g_xmjd_d[li_idx].sel = 'Y'
                  END IF
               END FOR
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unsel
            LET g_action_choice="unsel"
            IF cl_auth_chk_act("unsel") THEN
               
               #add-point:ON ACTION unsel name="menu.unsel"
               
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xmjd_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xmjd2_d)
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
            CALL asli201_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asli201_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asli201_set_pk_array()
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
 
{<section id="asli201.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asli201_query()
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
   CALL g_xmjd_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sel,xmjd001,xmjd002,xmjd003,xmjd004,xmjd005,xmjd006,xmjd007,xmjd008,xmjd020, 
          xmjd021,xmjd022,xmjd023,xmjd024,xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,xmjd030,xmjd031,xmjd009, 
          xmjd010,xmjd011,xmjd012,xmjd013,xmjd014,xmjd015,xmjd016,xmjd017,xmjdsite,xmjdstus,xmjdownid, 
          xmjdowndp,xmjdcrtid,xmjdcrtdp,xmjdcrtdt,xmjdmodid,xmjdmoddt 
 
         FROM s_detail1[1].sel,s_detail1[1].xmjd001,s_detail1[1].xmjd002,s_detail1[1].xmjd003,s_detail1[1].xmjd004, 
             s_detail1[1].xmjd005,s_detail1[1].xmjd006,s_detail1[1].xmjd007,s_detail1[1].xmjd008,s_detail1[1].xmjd020, 
             s_detail1[1].xmjd021,s_detail1[1].xmjd022,s_detail1[1].xmjd023,s_detail1[1].xmjd024,s_detail1[1].xmjd025, 
             s_detail1[1].xmjd026,s_detail1[1].xmjd027,s_detail1[1].xmjd028,s_detail1[1].xmjd029,s_detail1[1].xmjd030, 
             s_detail1[1].xmjd031,s_detail1[1].xmjd009,s_detail1[1].xmjd010,s_detail1[1].xmjd011,s_detail1[1].xmjd012, 
             s_detail1[1].xmjd013,s_detail1[1].xmjd014,s_detail1[1].xmjd015,s_detail1[1].xmjd016,s_detail1[1].xmjd017, 
             s_detail1[1].xmjdsite,s_detail1[1].xmjdstus,s_detail2[1].xmjdownid,s_detail2[1].xmjdowndp, 
             s_detail2[1].xmjdcrtid,s_detail2[1].xmjdcrtdp,s_detail2[1].xmjdcrtdt,s_detail2[1].xmjdmodid, 
             s_detail2[1].xmjdmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmjdcrtdt>>----
         AFTER FIELD xmjdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmjdmoddt>>----
         AFTER FIELD xmjdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmjdcnfdt>>----
         
         #----<<xmjdpstdt>>----
 
 
 
      
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd001
            #add-point:BEFORE FIELD xmjd001 name="query.b.page1.xmjd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd001
            
            #add-point:AFTER FIELD xmjd001 name="query.a.page1.xmjd001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd001
            #add-point:ON ACTION controlp INFIELD xmjd001 name="query.c.page1.xmjd001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd002
            #add-point:BEFORE FIELD xmjd002 name="query.b.page1.xmjd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd002
            
            #add-point:AFTER FIELD xmjd002 name="query.a.page1.xmjd002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd002
            #add-point:ON ACTION controlp INFIELD xmjd002 name="query.c.page1.xmjd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd003
            #add-point:BEFORE FIELD xmjd003 name="query.b.page1.xmjd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd003
            
            #add-point:AFTER FIELD xmjd003 name="query.a.page1.xmjd003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd003
            #add-point:ON ACTION controlp INFIELD xmjd003 name="query.c.page1.xmjd003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmjd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd004
            #add-point:ON ACTION controlp INFIELD xmjd004 name="construct.c.page1.xmjd004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmjd004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd004  #顯示到畫面上
            NEXT FIELD xmjd004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd004
            #add-point:BEFORE FIELD xmjd004 name="query.b.page1.xmjd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd004
            
            #add-point:AFTER FIELD xmjd004 name="query.a.page1.xmjd004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd005
            #add-point:BEFORE FIELD xmjd005 name="query.b.page1.xmjd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd005
            
            #add-point:AFTER FIELD xmjd005 name="query.a.page1.xmjd005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd005
            #add-point:ON ACTION controlp INFIELD xmjd005 name="query.c.page1.xmjd005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmjd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd006
            #add-point:ON ACTION controlp INFIELD xmjd006 name="construct.c.page1.xmjd006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmjd006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd006  #顯示到畫面上
            NEXT FIELD xmjd006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd006
            #add-point:BEFORE FIELD xmjd006 name="query.b.page1.xmjd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd006
            
            #add-point:AFTER FIELD xmjd006 name="query.a.page1.xmjd006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd007
            #add-point:BEFORE FIELD xmjd007 name="query.b.page1.xmjd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd007
            
            #add-point:AFTER FIELD xmjd007 name="query.a.page1.xmjd007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd007
            #add-point:ON ACTION controlp INFIELD xmjd007 name="query.c.page1.xmjd007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmjd008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd008
            #add-point:ON ACTION controlp INFIELD xmjd008 name="construct.c.page1.xmjd008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd008  #顯示到畫面上
            NEXT FIELD xmjd008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd008
            #add-point:BEFORE FIELD xmjd008 name="query.b.page1.xmjd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd008
            
            #add-point:AFTER FIELD xmjd008 name="query.a.page1.xmjd008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd020
            #add-point:BEFORE FIELD xmjd020 name="query.b.page1.xmjd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd020
            
            #add-point:AFTER FIELD xmjd020 name="query.a.page1.xmjd020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd020
            #add-point:ON ACTION controlp INFIELD xmjd020 name="query.c.page1.xmjd020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd021
            #add-point:BEFORE FIELD xmjd021 name="query.b.page1.xmjd021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd021
            
            #add-point:AFTER FIELD xmjd021 name="query.a.page1.xmjd021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd021
            #add-point:ON ACTION controlp INFIELD xmjd021 name="query.c.page1.xmjd021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd022
            #add-point:BEFORE FIELD xmjd022 name="query.b.page1.xmjd022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd022
            
            #add-point:AFTER FIELD xmjd022 name="query.a.page1.xmjd022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd022
            #add-point:ON ACTION controlp INFIELD xmjd022 name="query.c.page1.xmjd022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd023
            #add-point:BEFORE FIELD xmjd023 name="query.b.page1.xmjd023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd023
            
            #add-point:AFTER FIELD xmjd023 name="query.a.page1.xmjd023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd023
            #add-point:ON ACTION controlp INFIELD xmjd023 name="query.c.page1.xmjd023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd024
            #add-point:BEFORE FIELD xmjd024 name="query.b.page1.xmjd024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd024
            
            #add-point:AFTER FIELD xmjd024 name="query.a.page1.xmjd024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd024
            #add-point:ON ACTION controlp INFIELD xmjd024 name="query.c.page1.xmjd024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd025
            #add-point:BEFORE FIELD xmjd025 name="query.b.page1.xmjd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd025
            
            #add-point:AFTER FIELD xmjd025 name="query.a.page1.xmjd025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd025
            #add-point:ON ACTION controlp INFIELD xmjd025 name="query.c.page1.xmjd025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd026
            #add-point:BEFORE FIELD xmjd026 name="query.b.page1.xmjd026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd026
            
            #add-point:AFTER FIELD xmjd026 name="query.a.page1.xmjd026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd026
            #add-point:ON ACTION controlp INFIELD xmjd026 name="query.c.page1.xmjd026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd027
            #add-point:BEFORE FIELD xmjd027 name="query.b.page1.xmjd027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd027
            
            #add-point:AFTER FIELD xmjd027 name="query.a.page1.xmjd027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd027
            #add-point:ON ACTION controlp INFIELD xmjd027 name="query.c.page1.xmjd027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd028
            #add-point:BEFORE FIELD xmjd028 name="query.b.page1.xmjd028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd028
            
            #add-point:AFTER FIELD xmjd028 name="query.a.page1.xmjd028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd028
            #add-point:ON ACTION controlp INFIELD xmjd028 name="query.c.page1.xmjd028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd029
            #add-point:BEFORE FIELD xmjd029 name="query.b.page1.xmjd029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd029
            
            #add-point:AFTER FIELD xmjd029 name="query.a.page1.xmjd029"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd029
            #add-point:ON ACTION controlp INFIELD xmjd029 name="query.c.page1.xmjd029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd030
            #add-point:BEFORE FIELD xmjd030 name="query.b.page1.xmjd030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd030
            
            #add-point:AFTER FIELD xmjd030 name="query.a.page1.xmjd030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd030
            #add-point:ON ACTION controlp INFIELD xmjd030 name="query.c.page1.xmjd030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd031
            #add-point:BEFORE FIELD xmjd031 name="query.b.page1.xmjd031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd031
            
            #add-point:AFTER FIELD xmjd031 name="query.a.page1.xmjd031"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd031
            #add-point:ON ACTION controlp INFIELD xmjd031 name="query.c.page1.xmjd031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd009
            #add-point:BEFORE FIELD xmjd009 name="query.b.page1.xmjd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd009
            
            #add-point:AFTER FIELD xmjd009 name="query.a.page1.xmjd009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd009
            #add-point:ON ACTION controlp INFIELD xmjd009 name="query.c.page1.xmjd009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmjd010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd010
            #add-point:ON ACTION controlp INFIELD xmjd010 name="construct.c.page1.xmjd010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd010  #顯示到畫面上
            NEXT FIELD xmjd010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd010
            #add-point:BEFORE FIELD xmjd010 name="query.b.page1.xmjd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd010
            
            #add-point:AFTER FIELD xmjd010 name="query.a.page1.xmjd010"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd011
            #add-point:BEFORE FIELD xmjd011 name="query.b.page1.xmjd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd011
            
            #add-point:AFTER FIELD xmjd011 name="query.a.page1.xmjd011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd011
            #add-point:ON ACTION controlp INFIELD xmjd011 name="query.c.page1.xmjd011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmjd012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd012
            #add-point:ON ACTION controlp INFIELD xmjd012 name="construct.c.page1.xmjd012"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd012  #顯示到畫面上
            NEXT FIELD xmjd012                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd012
            #add-point:BEFORE FIELD xmjd012 name="query.b.page1.xmjd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd012
            
            #add-point:AFTER FIELD xmjd012 name="query.a.page1.xmjd012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd013
            #add-point:BEFORE FIELD xmjd013 name="query.b.page1.xmjd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd013
            
            #add-point:AFTER FIELD xmjd013 name="query.a.page1.xmjd013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd013
            #add-point:ON ACTION controlp INFIELD xmjd013 name="query.c.page1.xmjd013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd014
            #add-point:BEFORE FIELD xmjd014 name="query.b.page1.xmjd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd014
            
            #add-point:AFTER FIELD xmjd014 name="query.a.page1.xmjd014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd014
            #add-point:ON ACTION controlp INFIELD xmjd014 name="query.c.page1.xmjd014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd015
            #add-point:BEFORE FIELD xmjd015 name="query.b.page1.xmjd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd015
            
            #add-point:AFTER FIELD xmjd015 name="query.a.page1.xmjd015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd015
            #add-point:ON ACTION controlp INFIELD xmjd015 name="query.c.page1.xmjd015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd016
            #add-point:BEFORE FIELD xmjd016 name="query.b.page1.xmjd016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd016
            
            #add-point:AFTER FIELD xmjd016 name="query.a.page1.xmjd016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd016
            #add-point:ON ACTION controlp INFIELD xmjd016 name="query.c.page1.xmjd016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd017
            #add-point:BEFORE FIELD xmjd017 name="query.b.page1.xmjd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd017
            
            #add-point:AFTER FIELD xmjd017 name="query.a.page1.xmjd017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjd017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd017
            #add-point:ON ACTION controlp INFIELD xmjd017 name="query.c.page1.xmjd017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdsite
            #add-point:BEFORE FIELD xmjdsite name="query.b.page1.xmjdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdsite
            
            #add-point:AFTER FIELD xmjdsite name="query.a.page1.xmjdsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdsite
            #add-point:ON ACTION controlp INFIELD xmjdsite name="query.c.page1.xmjdsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdstus
            #add-point:BEFORE FIELD xmjdstus name="query.b.page1.xmjdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdstus
            
            #add-point:AFTER FIELD xmjdstus name="query.a.page1.xmjdstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xmjdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdstus
            #add-point:ON ACTION controlp INFIELD xmjdstus name="query.c.page1.xmjdstus"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.xmjdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdownid
            #add-point:ON ACTION controlp INFIELD xmjdownid name="construct.c.page2.xmjdownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjdownid  #顯示到畫面上
            NEXT FIELD xmjdownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdownid
            #add-point:BEFORE FIELD xmjdownid name="query.b.page2.xmjdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdownid
            
            #add-point:AFTER FIELD xmjdownid name="query.a.page2.xmjdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmjdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdowndp
            #add-point:ON ACTION controlp INFIELD xmjdowndp name="construct.c.page2.xmjdowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjdowndp  #顯示到畫面上
            NEXT FIELD xmjdowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdowndp
            #add-point:BEFORE FIELD xmjdowndp name="query.b.page2.xmjdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdowndp
            
            #add-point:AFTER FIELD xmjdowndp name="query.a.page2.xmjdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmjdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdcrtid
            #add-point:ON ACTION controlp INFIELD xmjdcrtid name="construct.c.page2.xmjdcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjdcrtid  #顯示到畫面上
            NEXT FIELD xmjdcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdcrtid
            #add-point:BEFORE FIELD xmjdcrtid name="query.b.page2.xmjdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdcrtid
            
            #add-point:AFTER FIELD xmjdcrtid name="query.a.page2.xmjdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmjdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdcrtdp
            #add-point:ON ACTION controlp INFIELD xmjdcrtdp name="construct.c.page2.xmjdcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjdcrtdp  #顯示到畫面上
            NEXT FIELD xmjdcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdcrtdp
            #add-point:BEFORE FIELD xmjdcrtdp name="query.b.page2.xmjdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdcrtdp
            
            #add-point:AFTER FIELD xmjdcrtdp name="query.a.page2.xmjdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdcrtdt
            #add-point:BEFORE FIELD xmjdcrtdt name="query.b.page2.xmjdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmjdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdmodid
            #add-point:ON ACTION controlp INFIELD xmjdmodid name="construct.c.page2.xmjdmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjdmodid  #顯示到畫面上
            NEXT FIELD xmjdmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdmodid
            #add-point:BEFORE FIELD xmjdmodid name="query.b.page2.xmjdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdmodid
            
            #add-point:AFTER FIELD xmjdmodid name="query.a.page2.xmjdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdmoddt
            #add-point:BEFORE FIELD xmjdmoddt name="query.b.page2.xmjdmoddt"
            
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
    
   CALL asli201_b_fill(g_wc2)
   LET g_data_owner = g_xmjd2_d[g_detail_idx].xmjdownid   #(ver:35)
   LET g_data_dept = g_xmjd2_d[g_detail_idx].xmjdowndp   #(ver:35)
 
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
 
{<section id="asli201.insert" >}
#+ 資料新增
PRIVATE FUNCTION asli201_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL asli201_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asli201.modify" >}
#+ 資料修改
PRIVATE FUNCTION asli201_modify()
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
      INPUT ARRAY g_xmjd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmjd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asli201_b_fill(g_wc2)
            LET g_detail_cnt = g_xmjd_d.getLength()
         
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
            DISPLAY g_xmjd_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_xmjd_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xmjd_d[l_ac].xmjd001 IS NOT NULL
               AND g_xmjd_d[l_ac].xmjd002 IS NOT NULL
               AND g_xmjd_d[l_ac].xmjd003 IS NOT NULL
               AND g_xmjd_d[l_ac].xmjd004 IS NOT NULL
               AND g_xmjd_d[l_ac].xmjd008 IS NOT NULL
               AND g_xmjd_d[l_ac].xmjd010 IS NOT NULL
               AND g_xmjd_d[l_ac].xmjd012 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmjd_d_t.* = g_xmjd_d[l_ac].*  #BACKUP
               LET g_xmjd_d_o.* = g_xmjd_d[l_ac].*  #BACKUP
               IF NOT asli201_lock_b("xmjd_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asli201_bcl INTO g_xmjd_d[l_ac].xmjd001,g_xmjd_d[l_ac].xmjd002,g_xmjd_d[l_ac].xmjd003, 
                      g_xmjd_d[l_ac].xmjd004,g_xmjd_d[l_ac].xmjd005,g_xmjd_d[l_ac].xmjd006,g_xmjd_d[l_ac].xmjd007, 
                      g_xmjd_d[l_ac].xmjd008,g_xmjd_d[l_ac].xmjd020,g_xmjd_d[l_ac].xmjd021,g_xmjd_d[l_ac].xmjd022, 
                      g_xmjd_d[l_ac].xmjd023,g_xmjd_d[l_ac].xmjd024,g_xmjd_d[l_ac].xmjd025,g_xmjd_d[l_ac].xmjd026, 
                      g_xmjd_d[l_ac].xmjd027,g_xmjd_d[l_ac].xmjd028,g_xmjd_d[l_ac].xmjd029,g_xmjd_d[l_ac].xmjd030, 
                      g_xmjd_d[l_ac].xmjd031,g_xmjd_d[l_ac].xmjd009,g_xmjd_d[l_ac].xmjd010,g_xmjd_d[l_ac].xmjd011, 
                      g_xmjd_d[l_ac].xmjd012,g_xmjd_d[l_ac].xmjd013,g_xmjd_d[l_ac].xmjd014,g_xmjd_d[l_ac].xmjd015, 
                      g_xmjd_d[l_ac].xmjd016,g_xmjd_d[l_ac].xmjd017,g_xmjd_d[l_ac].xmjdsite,g_xmjd_d[l_ac].xmjdstus, 
                      g_xmjd2_d[l_ac].xmjd001,g_xmjd2_d[l_ac].xmjd002,g_xmjd2_d[l_ac].xmjd003,g_xmjd2_d[l_ac].xmjd004, 
                      g_xmjd2_d[l_ac].xmjd008,g_xmjd2_d[l_ac].xmjd010,g_xmjd2_d[l_ac].xmjd012,g_xmjd2_d[l_ac].xmjdownid, 
                      g_xmjd2_d[l_ac].xmjdowndp,g_xmjd2_d[l_ac].xmjdcrtid,g_xmjd2_d[l_ac].xmjdcrtdp, 
                      g_xmjd2_d[l_ac].xmjdcrtdt,g_xmjd2_d[l_ac].xmjdmodid,g_xmjd2_d[l_ac].xmjdmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmjd_d_t.xmjd001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmjd_d_mask_o[l_ac].* =  g_xmjd_d[l_ac].*
                  CALL asli201_xmjd_t_mask()
                  LET g_xmjd_d_mask_n[l_ac].* =  g_xmjd_d[l_ac].*
                  
                  CALL asli201_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asli201_set_entry_b(l_cmd)
            CALL asli201_set_no_entry_b(l_cmd)
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
            INITIALIZE g_xmjd_d_t.* TO NULL
            INITIALIZE g_xmjd_d_o.* TO NULL
            INITIALIZE g_xmjd_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmjd2_d[l_ac].xmjdownid = g_user
      LET g_xmjd2_d[l_ac].xmjdowndp = g_dept
      LET g_xmjd2_d[l_ac].xmjdcrtid = g_user
      LET g_xmjd2_d[l_ac].xmjdcrtdp = g_dept 
      LET g_xmjd2_d[l_ac].xmjdcrtdt = cl_get_current()
      LET g_xmjd2_d[l_ac].xmjdmodid = g_user
      LET g_xmjd2_d[l_ac].xmjdmoddt = cl_get_current()
      LET g_xmjd_d[l_ac].xmjdstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_xmjd_d[l_ac].xmjd001 = "0"
      LET g_xmjd_d[l_ac].xmjd009 = "0"
      LET g_xmjd_d[l_ac].xmjd014 = "0"
      LET g_xmjd_d[l_ac].xmjd015 = "0"
      LET g_xmjd_d[l_ac].xmjd016 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            LET g_xmjd_d[l_ac].sel = "N"
            LET g_xmjd_d[l_ac].xmjd001 = YEAR(g_today)
            LET g_xmjd_d[l_ac].xmjd002 = "1"
            #LET g_xmjd_d[l_ac].xmjd003 = "1"   #160922-00032#3 Mark By Ken 160929
            LET g_xmjd_d[l_ac].xmjd003 = "2"    #160922-00032#3 Add By Ken 160929 
            LET g_xmjd_d[l_ac].xmjd006 = ""
            LET g_xmjd_d[l_ac].xmjd007 = ""
            LET g_xmjd_d[l_ac].xmjd017 = "1"
            LET g_xmjd_d[l_ac].xmjdstus = 'Y'
            LET g_xmjd_d[l_ac].xmjdsite = g_site
            #end add-point
            LET g_xmjd_d_t.* = g_xmjd_d[l_ac].*     #新輸入資料
            LET g_xmjd_d_o.* = g_xmjd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmjd_d[li_reproduce_target].* = g_xmjd_d[li_reproduce].*
               LET g_xmjd2_d[li_reproduce_target].* = g_xmjd2_d[li_reproduce].*
 
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd001 = NULL
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd002 = NULL
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd003 = NULL
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd004 = NULL
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd008 = NULL
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd010 = NULL
               LET g_xmjd_d[g_xmjd_d.getLength()].xmjd012 = NULL
 
            END IF
            
 
 
            CALL asli201_set_entry_b(l_cmd)
            CALL asli201_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM xmjd_t 
             WHERE xmjdent = g_enterprise AND xmjd001 = g_xmjd_d[l_ac].xmjd001
                                       AND xmjd002 = g_xmjd_d[l_ac].xmjd002
                                       AND xmjd003 = g_xmjd_d[l_ac].xmjd003
                                       AND xmjd004 = g_xmjd_d[l_ac].xmjd004
                                       AND xmjd008 = g_xmjd_d[l_ac].xmjd008
                                       AND xmjd010 = g_xmjd_d[l_ac].xmjd010
                                       AND xmjd012 = g_xmjd_d[l_ac].xmjd012
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmjd_d[g_detail_idx].xmjd001
               LET gs_keys[2] = g_xmjd_d[g_detail_idx].xmjd002
               LET gs_keys[3] = g_xmjd_d[g_detail_idx].xmjd003
               LET gs_keys[4] = g_xmjd_d[g_detail_idx].xmjd004
               LET gs_keys[5] = g_xmjd_d[g_detail_idx].xmjd008
               LET gs_keys[6] = g_xmjd_d[g_detail_idx].xmjd010
               LET gs_keys[7] = g_xmjd_d[g_detail_idx].xmjd012
               CALL asli201_insert_b('xmjd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmjd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmjd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asli201_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (xmjd001 = '", g_xmjd_d[l_ac].xmjd001, "' "
                                  ," AND xmjd002 = '", g_xmjd_d[l_ac].xmjd002, "' "
                                  ," AND xmjd003 = '", g_xmjd_d[l_ac].xmjd003, "' "
                                  ," AND xmjd004 = '", g_xmjd_d[l_ac].xmjd004, "' "
                                  ," AND xmjd008 = '", g_xmjd_d[l_ac].xmjd008, "' "
                                  ," AND xmjd010 = '", g_xmjd_d[l_ac].xmjd010, "' "
                                  ," AND xmjd012 = '", g_xmjd_d[l_ac].xmjd012, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               IF NOT cl_null(g_xmjd_d_t.xmjd007) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "asl-00010"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
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
               
               DELETE FROM xmjd_t
                WHERE xmjdent = g_enterprise AND 
                      xmjd001 = g_xmjd_d_t.xmjd001
                      AND xmjd002 = g_xmjd_d_t.xmjd002
                      AND xmjd003 = g_xmjd_d_t.xmjd003
                      AND xmjd004 = g_xmjd_d_t.xmjd004
                      AND xmjd008 = g_xmjd_d_t.xmjd008
                      AND xmjd010 = g_xmjd_d_t.xmjd010
                      AND xmjd012 = g_xmjd_d_t.xmjd012
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmjd_t:",SQLERRMESSAGE 
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
                  CALL asli201_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xmjd_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE asli201_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_xmjd_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmjd_d_t.xmjd001
               LET gs_keys[2] = g_xmjd_d_t.xmjd002
               LET gs_keys[3] = g_xmjd_d_t.xmjd003
               LET gs_keys[4] = g_xmjd_d_t.xmjd004
               LET gs_keys[5] = g_xmjd_d_t.xmjd008
               LET gs_keys[6] = g_xmjd_d_t.xmjd010
               LET gs_keys[7] = g_xmjd_d_t.xmjd012
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asli201_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asli201_delete_b('xmjd_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xmjd_d.getLength() + 1) THEN
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd001
            #add-point:BEFORE FIELD xmjd001 name="input.b.page1.xmjd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd001
            
            #add-point:AFTER FIELD xmjd001 name="input.a.page1.xmjd001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmjd_d[l_ac].xmjd001) AND g_xmjd_d[l_ac].xmjd001 <> g_xmjd_d_o.xmjd001 THEN
               LET g_xmjd_d[l_ac].xmjd008 = ''
            END IF
            
            LET g_xmjd_d_o.xmjd001 = g_xmjd_d[l_ac].xmjd001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd001
            #add-point:ON CHANGE xmjd001 name="input.g.page1.xmjd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd002
            #add-point:BEFORE FIELD xmjd002 name="input.b.page1.xmjd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd002
            
            #add-point:AFTER FIELD xmjd002 name="input.a.page1.xmjd002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmjd_d[l_ac].xmjd002) AND g_xmjd_d[l_ac].xmjd002 <> g_xmjd_d_o.xmjd002 THEN
               LET g_xmjd_d[l_ac].xmjd008 = ''
            END IF
            
            LET g_xmjd_d_o.xmjd002 = g_xmjd_d[l_ac].xmjd002
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd002
            #add-point:ON CHANGE xmjd002 name="input.g.page1.xmjd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd003
            #add-point:BEFORE FIELD xmjd003 name="input.b.page1.xmjd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd003
            
            #add-point:AFTER FIELD xmjd003 name="input.a.page1.xmjd003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd003
            #add-point:ON CHANGE xmjd003 name="input.g.page1.xmjd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd004
            #add-point:BEFORE FIELD xmjd004 name="input.b.page1.xmjd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd004
            
            #add-point:AFTER FIELD xmjd004 name="input.a.page1.xmjd004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmjd_d[l_ac].xmjd004) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmjd_d[l_ac].xmjd004

               #呼叫檢查存在並帶值的library
               IF g_xmjd_d[l_ac].xmjd003 = '2' THEN     #160922-00032#3 Modify By Ken 160929  1 原是客戶，改成2是客戶
                  IF cl_chk_exist("v_pmaa001_7") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xmjd_d[l_ac].xmjd004 = g_xmjd_d_t.xmjd004
                     DISPLAY BY NAME g_xmjd_d[l_ac].xmjd004
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF cl_chk_exist("v_ooef001_35") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xmjd_d[l_ac].xmjd004 = g_xmjd_d_t.xmjd004
                     DISPLAY BY NAME g_xmjd_d[l_ac].xmjd004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF g_xmjd_d[l_ac].xmjd003 = '2' THEN     #160922-00032#3 Modify By Ken 160929  1 原是客戶，改成2是客戶
               SELECT pmaal004 INTO g_xmjd_d[l_ac].xmjd005 FROM pmaal_t 
                WHERE pmaalent = g_enterprise
                  AND pmaal001 = g_xmjd_d[l_ac].xmjd004
                  AND pmaal002 = g_dlang
            ELSE
               SELECT ooefl003 INTO g_xmjd_d[l_ac].xmjd005 FROM ooefl_t 
                WHERE ooeflent = g_enterprise
                  AND ooefl001 = g_xmjd_d[l_ac].xmjd004
                  AND ooefl002 = g_dlang
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd004
            #add-point:ON CHANGE xmjd004 name="input.g.page1.xmjd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd005
            #add-point:BEFORE FIELD xmjd005 name="input.b.page1.xmjd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd005
            
            #add-point:AFTER FIELD xmjd005 name="input.a.page1.xmjd005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd005
            #add-point:ON CHANGE xmjd005 name="input.g.page1.xmjd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd006
            #add-point:BEFORE FIELD xmjd006 name="input.b.page1.xmjd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd006
            
            #add-point:AFTER FIELD xmjd006 name="input.a.page1.xmjd006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd006
            #add-point:ON CHANGE xmjd006 name="input.g.page1.xmjd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd007
            #add-point:BEFORE FIELD xmjd007 name="input.b.page1.xmjd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd007
            
            #add-point:AFTER FIELD xmjd007 name="input.a.page1.xmjd007"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd007
            #add-point:ON CHANGE xmjd007 name="input.g.page1.xmjd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd008
            
            #add-point:AFTER FIELD xmjd008 name="input.a.page1.xmjd008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmjd_d[l_ac].xmjd008) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmjd_d[l_ac].xmjd008

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               
               ELSE
                  #檢查失敗時後續處理
                  LET g_xmjd_d[l_ac].xmjd008 = g_xmjd_d_t.xmjd008
                  DISPLAY BY NAME g_xmjd_d[l_ac].xmjd008
                  NEXT FIELD CURRENT
               END IF
               
               #判断是否属于当前年度和订货季
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_xmjd_d[l_ac].xmjd008
                  AND imaa154 = g_xmjd_d[l_ac].xmjd001
                  AND imaa155 = g_xmjd_d[l_ac].xmjd002
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "asl-00013"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_xmjd_d[l_ac].xmjd008 = g_xmjd_d_t.xmjd008
                  DISPLAY BY NAME g_xmjd_d[l_ac].xmjd008
                  NEXT FIELD xmjd008
               END IF
               
               #料號帶值
               CALL asli201_xmjd008_ref()
            END IF

            SELECT imaal003 INTO g_xmjd_d[l_ac].xmjd008_desc
              FROM imaal_t
             WHERE imaalent = g_enterprise
               AND imaal001 = g_xmjd_d[l_ac].xmjd008
               AND imaal002 = g_dlang       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd008
            #add-point:BEFORE FIELD xmjd008 name="input.b.page1.xmjd008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd008
            #add-point:ON CHANGE xmjd008 name="input.g.page1.xmjd008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd020
            #add-point:BEFORE FIELD xmjd020 name="input.b.page1.xmjd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd020
            
            #add-point:AFTER FIELD xmjd020 name="input.a.page1.xmjd020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd020
            #add-point:ON CHANGE xmjd020 name="input.g.page1.xmjd020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd021
            #add-point:BEFORE FIELD xmjd021 name="input.b.page1.xmjd021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd021
            
            #add-point:AFTER FIELD xmjd021 name="input.a.page1.xmjd021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd021
            #add-point:ON CHANGE xmjd021 name="input.g.page1.xmjd021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd022
            #add-point:BEFORE FIELD xmjd022 name="input.b.page1.xmjd022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd022
            
            #add-point:AFTER FIELD xmjd022 name="input.a.page1.xmjd022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd022
            #add-point:ON CHANGE xmjd022 name="input.g.page1.xmjd022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd023
            #add-point:BEFORE FIELD xmjd023 name="input.b.page1.xmjd023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd023
            
            #add-point:AFTER FIELD xmjd023 name="input.a.page1.xmjd023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd023
            #add-point:ON CHANGE xmjd023 name="input.g.page1.xmjd023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd024
            #add-point:BEFORE FIELD xmjd024 name="input.b.page1.xmjd024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd024
            
            #add-point:AFTER FIELD xmjd024 name="input.a.page1.xmjd024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd024
            #add-point:ON CHANGE xmjd024 name="input.g.page1.xmjd024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd025
            #add-point:BEFORE FIELD xmjd025 name="input.b.page1.xmjd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd025
            
            #add-point:AFTER FIELD xmjd025 name="input.a.page1.xmjd025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd025
            #add-point:ON CHANGE xmjd025 name="input.g.page1.xmjd025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd026
            #add-point:BEFORE FIELD xmjd026 name="input.b.page1.xmjd026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd026
            
            #add-point:AFTER FIELD xmjd026 name="input.a.page1.xmjd026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd026
            #add-point:ON CHANGE xmjd026 name="input.g.page1.xmjd026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd027
            #add-point:BEFORE FIELD xmjd027 name="input.b.page1.xmjd027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd027
            
            #add-point:AFTER FIELD xmjd027 name="input.a.page1.xmjd027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd027
            #add-point:ON CHANGE xmjd027 name="input.g.page1.xmjd027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd028
            #add-point:BEFORE FIELD xmjd028 name="input.b.page1.xmjd028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd028
            
            #add-point:AFTER FIELD xmjd028 name="input.a.page1.xmjd028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd028
            #add-point:ON CHANGE xmjd028 name="input.g.page1.xmjd028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd029
            #add-point:BEFORE FIELD xmjd029 name="input.b.page1.xmjd029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd029
            
            #add-point:AFTER FIELD xmjd029 name="input.a.page1.xmjd029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd029
            #add-point:ON CHANGE xmjd029 name="input.g.page1.xmjd029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd030
            #add-point:BEFORE FIELD xmjd030 name="input.b.page1.xmjd030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd030
            
            #add-point:AFTER FIELD xmjd030 name="input.a.page1.xmjd030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd030
            #add-point:ON CHANGE xmjd030 name="input.g.page1.xmjd030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd031
            #add-point:BEFORE FIELD xmjd031 name="input.b.page1.xmjd031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd031
            
            #add-point:AFTER FIELD xmjd031 name="input.a.page1.xmjd031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd031
            #add-point:ON CHANGE xmjd031 name="input.g.page1.xmjd031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd009
            #add-point:BEFORE FIELD xmjd009 name="input.b.page1.xmjd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd009
            
            #add-point:AFTER FIELD xmjd009 name="input.a.page1.xmjd009"
            IF NOT cl_null(g_xmjd_d[l_ac].xmjd009) AND NOT cl_null(g_xmjd_d[l_ac].xmjd015) THEN
               LET g_xmjd_d[l_ac].xmjd016 = g_xmjd_d[l_ac].xmjd015*g_xmjd_d[l_ac].xmjd009
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd009
            #add-point:ON CHANGE xmjd009 name="input.g.page1.xmjd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd010
            #add-point:BEFORE FIELD xmjd010 name="input.b.page1.xmjd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd010
            
            #add-point:AFTER FIELD xmjd010 name="input.a.page1.xmjd010"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmjd_d[l_ac].xmjd010) THEN
               IF NOT s_azzi650_chk_exist('2148',g_xmjd_d[l_ac].xmjd010) THEN
                  LET g_xmjd_d[l_ac].xmjd010 = g_xmjd_d_t.xmjd010
                  CALL s_desc_get_acc_desc('2148',g_xmjd_d[l_ac].xmjd010)
                     RETURNING g_xmjd_d[l_ac].xmjd011
                  NEXT FIELD xmjd010
               END IF
            END IF
            
            CALL s_desc_get_acc_desc('2148',g_xmjd_d[l_ac].xmjd010)
               RETURNING g_xmjd_d[l_ac].xmjd011
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd010
            #add-point:ON CHANGE xmjd010 name="input.g.page1.xmjd010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd011
            #add-point:BEFORE FIELD xmjd011 name="input.b.page1.xmjd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd011
            
            #add-point:AFTER FIELD xmjd011 name="input.a.page1.xmjd011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd011
            #add-point:ON CHANGE xmjd011 name="input.g.page1.xmjd011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd012
            #add-point:BEFORE FIELD xmjd012 name="input.b.page1.xmjd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd012
            
            #add-point:AFTER FIELD xmjd012 name="input.a.page1.xmjd012"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xmjd_d[g_detail_idx].xmjd001 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd002 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd003 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd004 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd006 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd007 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd008 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd010 IS NOT NULL AND g_xmjd_d[g_detail_idx].xmjd012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmjd_d[g_detail_idx].xmjd001 != g_xmjd_d_t.xmjd001 OR g_xmjd_d[g_detail_idx].xmjd002 != g_xmjd_d_t.xmjd002 OR g_xmjd_d[g_detail_idx].xmjd003 != g_xmjd_d_t.xmjd003 OR g_xmjd_d[g_detail_idx].xmjd004 != g_xmjd_d_t.xmjd004 OR g_xmjd_d[g_detail_idx].xmjd006 != g_xmjd_d_t.xmjd006 OR g_xmjd_d[g_detail_idx].xmjd007 != g_xmjd_d_t.xmjd007 OR g_xmjd_d[g_detail_idx].xmjd008 != g_xmjd_d_t.xmjd008 OR g_xmjd_d[g_detail_idx].xmjd010 != g_xmjd_d_t.xmjd010 OR g_xmjd_d[g_detail_idx].xmjd012 != g_xmjd_d_t.xmjd012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmjd_t WHERE "||"xmjdent = '" ||g_enterprise|| "' AND "||"xmjd001 = '"||g_xmjd_d[g_detail_idx].xmjd001 ||"' AND "|| "xmjd002 = '"||g_xmjd_d[g_detail_idx].xmjd002 ||"' AND "|| "xmjd003 = '"||g_xmjd_d[g_detail_idx].xmjd003 ||"' AND "|| "xmjd004 = '"||g_xmjd_d[g_detail_idx].xmjd004 ||"' AND "|| "xmjd006 = '"||g_xmjd_d[g_detail_idx].xmjd006 ||"' AND "|| "xmjd007 = '"||g_xmjd_d[g_detail_idx].xmjd007 ||"' AND "|| "xmjd008 = '"||g_xmjd_d[g_detail_idx].xmjd008 ||"' AND "|| "xmjd010 = '"||g_xmjd_d[g_detail_idx].xmjd010 ||"' AND "|| "xmjd012 = '"||g_xmjd_d[g_detail_idx].xmjd012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmjd_d[l_ac].xmjd012) THEN
               IF NOT s_azzi650_chk_exist('2149',g_xmjd_d[l_ac].xmjd012) THEN
                  LET g_xmjd_d[l_ac].xmjd012 = g_xmjd_d_t.xmjd012
                  CALL s_desc_get_acc_desc('2149',g_xmjd_d[l_ac].xmjd012)
                     RETURNING g_xmjd_d[l_ac].xmjd013
                  NEXT FIELD xmjd012
               END IF
            END IF
            
            CALL s_desc_get_acc_desc('2149',g_xmjd_d[l_ac].xmjd012)
               RETURNING g_xmjd_d[l_ac].xmjd013

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd012
            #add-point:ON CHANGE xmjd012 name="input.g.page1.xmjd012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd013
            #add-point:BEFORE FIELD xmjd013 name="input.b.page1.xmjd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd013
            
            #add-point:AFTER FIELD xmjd013 name="input.a.page1.xmjd013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd013
            #add-point:ON CHANGE xmjd013 name="input.g.page1.xmjd013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd014
            #add-point:BEFORE FIELD xmjd014 name="input.b.page1.xmjd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd014
            
            #add-point:AFTER FIELD xmjd014 name="input.a.page1.xmjd014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd014
            #add-point:ON CHANGE xmjd014 name="input.g.page1.xmjd014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd015
            #add-point:BEFORE FIELD xmjd015 name="input.b.page1.xmjd015"
            IF g_xmjd_d[l_ac].xmjd017 <> '1' THEN
               NEXT FIELD xmjd016
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd015
            
            #add-point:AFTER FIELD xmjd015 name="input.a.page1.xmjd015"
            IF NOT cl_null(g_xmjd_d[l_ac].xmjd009) AND NOT cl_null(g_xmjd_d[l_ac].xmjd015) THEN
               LET g_xmjd_d[l_ac].xmjd016 = g_xmjd_d[l_ac].xmjd015*g_xmjd_d[l_ac].xmjd009
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd015
            #add-point:ON CHANGE xmjd015 name="input.g.page1.xmjd015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd016
            #add-point:BEFORE FIELD xmjd016 name="input.b.page1.xmjd016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd016
            
            #add-point:AFTER FIELD xmjd016 name="input.a.page1.xmjd016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd016
            #add-point:ON CHANGE xmjd016 name="input.g.page1.xmjd016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjd017
            #add-point:BEFORE FIELD xmjd017 name="input.b.page1.xmjd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjd017
            
            #add-point:AFTER FIELD xmjd017 name="input.a.page1.xmjd017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjd017
            #add-point:ON CHANGE xmjd017 name="input.g.page1.xmjd017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdsite
            #add-point:BEFORE FIELD xmjdsite name="input.b.page1.xmjdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdsite
            
            #add-point:AFTER FIELD xmjdsite name="input.a.page1.xmjdsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjdsite
            #add-point:ON CHANGE xmjdsite name="input.g.page1.xmjdsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmjdstus
            #add-point:BEFORE FIELD xmjdstus name="input.b.page1.xmjdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmjdstus
            
            #add-point:AFTER FIELD xmjdstus name="input.a.page1.xmjdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmjdstus
            #add-point:ON CHANGE xmjdstus name="input.g.page1.xmjdstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd001
            #add-point:ON ACTION controlp INFIELD xmjd001 name="input.c.page1.xmjd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd002
            #add-point:ON ACTION controlp INFIELD xmjd002 name="input.c.page1.xmjd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd003
            #add-point:ON ACTION controlp INFIELD xmjd003 name="input.c.page1.xmjd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd004
            #add-point:ON ACTION controlp INFIELD xmjd004 name="input.c.page1.xmjd004"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmjd_d[l_ac].xmjd004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            IF g_xmjd_d[l_ac].xmjd003 = '1' THEN
               #CALL q_pmaa001_13()                               #呼叫開窗     #160922-00032#3 Mark By Ken 160929
               CALL q_ooef001_34()                                             #160922-00032#3 Add By Ken 160929
            END IF
            IF g_xmjd_d[l_ac].xmjd003 = '2' THEN
               #CALL q_ooef001_34()                               #呼叫開窗     #160922-00032#3 Mark By Ken 160929
               CALL q_pmaa001_13()                                             #160922-00032#3 Add By Ken 160929
            END IF

            LET g_xmjd_d[l_ac].xmjd004 = g_qryparam.return1
            LET g_xmjd_d[l_ac].xmjd005 = g_qryparam.return2

            DISPLAY g_xmjd_d[l_ac].xmjd004 TO xmjd004              #
            DISPLAY g_xmjd_d[l_ac].xmjd005 TO xmjd005

            NEXT FIELD xmjd004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd005
            #add-point:ON ACTION controlp INFIELD xmjd005 name="input.c.page1.xmjd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd006
            #add-point:ON ACTION controlp INFIELD xmjd006 name="input.c.page1.xmjd006"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmjd_d[l_ac].xmjd006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xmjd006()                                #呼叫開窗

            LET g_xmjd_d[l_ac].xmjd006 = g_qryparam.return1

            DISPLAY g_xmjd_d[l_ac].xmjd006 TO xmjd006              #

            NEXT FIELD xmjd006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd007
            #add-point:ON ACTION controlp INFIELD xmjd007 name="input.c.page1.xmjd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd008
            #add-point:ON ACTION controlp INFIELD xmjd008 name="input.c.page1.xmjd008"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmjd_d[l_ac].xmjd008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " imaa154 = ",g_xmjd_d[l_ac].xmjd001," AND imaa155 = '",g_xmjd_d[l_ac].xmjd002,"' "

            CALL q_imaa001_4()                                #呼叫開窗

            LET g_xmjd_d[l_ac].xmjd008 = g_qryparam.return1
            LET g_xmjd_d[l_ac].xmjd008_desc = g_qryparam.return2

            DISPLAY g_xmjd_d[l_ac].xmjd008 TO xmjd008              #
            DISPLAY g_xmjd_d[l_ac].xmjd008_desc TO xmjd008_desc

            NEXT FIELD xmjd008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd020
            #add-point:ON ACTION controlp INFIELD xmjd020 name="input.c.page1.xmjd020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd021
            #add-point:ON ACTION controlp INFIELD xmjd021 name="input.c.page1.xmjd021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd022
            #add-point:ON ACTION controlp INFIELD xmjd022 name="input.c.page1.xmjd022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd023
            #add-point:ON ACTION controlp INFIELD xmjd023 name="input.c.page1.xmjd023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd024
            #add-point:ON ACTION controlp INFIELD xmjd024 name="input.c.page1.xmjd024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd025
            #add-point:ON ACTION controlp INFIELD xmjd025 name="input.c.page1.xmjd025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd026
            #add-point:ON ACTION controlp INFIELD xmjd026 name="input.c.page1.xmjd026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd027
            #add-point:ON ACTION controlp INFIELD xmjd027 name="input.c.page1.xmjd027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd028
            #add-point:ON ACTION controlp INFIELD xmjd028 name="input.c.page1.xmjd028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd029
            #add-point:ON ACTION controlp INFIELD xmjd029 name="input.c.page1.xmjd029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd030
            #add-point:ON ACTION controlp INFIELD xmjd030 name="input.c.page1.xmjd030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd031
            #add-point:ON ACTION controlp INFIELD xmjd031 name="input.c.page1.xmjd031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd009
            #add-point:ON ACTION controlp INFIELD xmjd009 name="input.c.page1.xmjd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd010
            #add-point:ON ACTION controlp INFIELD xmjd010 name="input.c.page1.xmjd010"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmjd_d[l_ac].xmjd010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2148" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_xmjd_d[l_ac].xmjd010 = g_qryparam.return1
            LET g_xmjd_d[l_ac].xmjd011 = g_qryparam.return2

            DISPLAY g_xmjd_d[l_ac].xmjd010 TO xmjd010              #
            DISPLAY g_xmjd_d[l_ac].xmjd011 TO xmjd011 

            NEXT FIELD xmjd010                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd011
            #add-point:ON ACTION controlp INFIELD xmjd011 name="input.c.page1.xmjd011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd012
            #add-point:ON ACTION controlp INFIELD xmjd012 name="input.c.page1.xmjd012"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmjd_d[l_ac].xmjd012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2149" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_xmjd_d[l_ac].xmjd012 = g_qryparam.return1
            LET g_xmjd_d[l_ac].xmjd013 = g_qryparam.return2

            DISPLAY g_xmjd_d[l_ac].xmjd012 TO xmjd012              #
            DISPLAY g_xmjd_d[l_ac].xmjd013 TO xmjd013

            NEXT FIELD xmjd012                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd013
            #add-point:ON ACTION controlp INFIELD xmjd013 name="input.c.page1.xmjd013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd014
            #add-point:ON ACTION controlp INFIELD xmjd014 name="input.c.page1.xmjd014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd015
            #add-point:ON ACTION controlp INFIELD xmjd015 name="input.c.page1.xmjd015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd016
            #add-point:ON ACTION controlp INFIELD xmjd016 name="input.c.page1.xmjd016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjd017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjd017
            #add-point:ON ACTION controlp INFIELD xmjd017 name="input.c.page1.xmjd017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdsite
            #add-point:ON ACTION controlp INFIELD xmjdsite name="input.c.page1.xmjdsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmjdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmjdstus
            #add-point:ON ACTION controlp INFIELD xmjdstus name="input.c.page1.xmjdstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE asli201_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_xmjd_d[l_ac].* = g_xmjd_d_t.*
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
               LET g_errparam.extend = g_xmjd_d[l_ac].xmjd001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmjd_d[l_ac].* = g_xmjd_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_xmjd2_d[l_ac].xmjdmodid = g_user 
LET g_xmjd2_d[l_ac].xmjdmoddt = cl_get_current()
LET g_xmjd2_d[l_ac].xmjdmodid_desc = cl_get_username(g_xmjd2_d[l_ac].xmjdmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL asli201_xmjd_t_mask_restore('restore_mask_o')
 
               UPDATE xmjd_t SET (xmjd001,xmjd002,xmjd003,xmjd004,xmjd005,xmjd006,xmjd007,xmjd008,xmjd020, 
                   xmjd021,xmjd022,xmjd023,xmjd024,xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,xmjd030,xmjd031, 
                   xmjd009,xmjd010,xmjd011,xmjd012,xmjd013,xmjd014,xmjd015,xmjd016,xmjd017,xmjdsite, 
                   xmjdstus,xmjdownid,xmjdowndp,xmjdcrtid,xmjdcrtdp,xmjdcrtdt,xmjdmodid,xmjdmoddt) = (g_xmjd_d[l_ac].xmjd001, 
                   g_xmjd_d[l_ac].xmjd002,g_xmjd_d[l_ac].xmjd003,g_xmjd_d[l_ac].xmjd004,g_xmjd_d[l_ac].xmjd005, 
                   g_xmjd_d[l_ac].xmjd006,g_xmjd_d[l_ac].xmjd007,g_xmjd_d[l_ac].xmjd008,g_xmjd_d[l_ac].xmjd020, 
                   g_xmjd_d[l_ac].xmjd021,g_xmjd_d[l_ac].xmjd022,g_xmjd_d[l_ac].xmjd023,g_xmjd_d[l_ac].xmjd024, 
                   g_xmjd_d[l_ac].xmjd025,g_xmjd_d[l_ac].xmjd026,g_xmjd_d[l_ac].xmjd027,g_xmjd_d[l_ac].xmjd028, 
                   g_xmjd_d[l_ac].xmjd029,g_xmjd_d[l_ac].xmjd030,g_xmjd_d[l_ac].xmjd031,g_xmjd_d[l_ac].xmjd009, 
                   g_xmjd_d[l_ac].xmjd010,g_xmjd_d[l_ac].xmjd011,g_xmjd_d[l_ac].xmjd012,g_xmjd_d[l_ac].xmjd013, 
                   g_xmjd_d[l_ac].xmjd014,g_xmjd_d[l_ac].xmjd015,g_xmjd_d[l_ac].xmjd016,g_xmjd_d[l_ac].xmjd017, 
                   g_xmjd_d[l_ac].xmjdsite,g_xmjd_d[l_ac].xmjdstus,g_xmjd2_d[l_ac].xmjdownid,g_xmjd2_d[l_ac].xmjdowndp, 
                   g_xmjd2_d[l_ac].xmjdcrtid,g_xmjd2_d[l_ac].xmjdcrtdp,g_xmjd2_d[l_ac].xmjdcrtdt,g_xmjd2_d[l_ac].xmjdmodid, 
                   g_xmjd2_d[l_ac].xmjdmoddt)
                WHERE xmjdent = g_enterprise AND
                  xmjd001 = g_xmjd_d_t.xmjd001 #項次   
                  AND xmjd002 = g_xmjd_d_t.xmjd002  
                  AND xmjd003 = g_xmjd_d_t.xmjd003  
                  AND xmjd004 = g_xmjd_d_t.xmjd004  
                  AND xmjd008 = g_xmjd_d_t.xmjd008  
                  AND xmjd010 = g_xmjd_d_t.xmjd010  
                  AND xmjd012 = g_xmjd_d_t.xmjd012  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmjd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmjd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmjd_d[g_detail_idx].xmjd001
               LET gs_keys_bak[1] = g_xmjd_d_t.xmjd001
               LET gs_keys[2] = g_xmjd_d[g_detail_idx].xmjd002
               LET gs_keys_bak[2] = g_xmjd_d_t.xmjd002
               LET gs_keys[3] = g_xmjd_d[g_detail_idx].xmjd003
               LET gs_keys_bak[3] = g_xmjd_d_t.xmjd003
               LET gs_keys[4] = g_xmjd_d[g_detail_idx].xmjd004
               LET gs_keys_bak[4] = g_xmjd_d_t.xmjd004
               LET gs_keys[5] = g_xmjd_d[g_detail_idx].xmjd008
               LET gs_keys_bak[5] = g_xmjd_d_t.xmjd008
               LET gs_keys[6] = g_xmjd_d[g_detail_idx].xmjd010
               LET gs_keys_bak[6] = g_xmjd_d_t.xmjd010
               LET gs_keys[7] = g_xmjd_d[g_detail_idx].xmjd012
               LET gs_keys_bak[7] = g_xmjd_d_t.xmjd012
               CALL asli201_update_b('xmjd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xmjd_d_t)
                     LET g_log2 = util.JSON.stringify(g_xmjd_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asli201_xmjd_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asli201_unlock_b("xmjd_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmjd_d[l_ac].* = g_xmjd_d_t.*
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
               LET g_xmjd_d[li_reproduce_target].* = g_xmjd_d[li_reproduce].*
               LET g_xmjd2_d[li_reproduce_target].* = g_xmjd2_d[li_reproduce].*
 
               LET g_xmjd_d[li_reproduce_target].xmjd001 = NULL
               LET g_xmjd_d[li_reproduce_target].xmjd002 = NULL
               LET g_xmjd_d[li_reproduce_target].xmjd003 = NULL
               LET g_xmjd_d[li_reproduce_target].xmjd004 = NULL
               LET g_xmjd_d[li_reproduce_target].xmjd008 = NULL
               LET g_xmjd_d[li_reproduce_target].xmjd010 = NULL
               LET g_xmjd_d[li_reproduce_target].xmjd012 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmjd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmjd_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_xmjd2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL asli201_b_fill(g_wc2)
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
               NEXT FIELD sel
            WHEN "s_detail2"
               NEXT FIELD xmjd001_2
 
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
      IF INT_FLAG OR cl_null(g_xmjd_d[g_detail_idx].xmjd001) THEN
         CALL g_xmjd_d.deleteElement(g_detail_idx)
         CALL g_xmjd2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_xmjd_d[g_detail_idx].* = g_xmjd_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE asli201_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="asli201.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asli201_delete()
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
   FOR li_idx = 1 TO g_xmjd_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT asli201_lock_b("xmjd_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("xmjd_t","xmjdownid") THEN
            LET g_data_owner = g_xmjd2_d[g_detail_idx].xmjdownid
            LET g_data_dept = g_xmjd2_d[g_detail_idx].xmjdowndp
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
   
   FOR li_idx = 1 TO g_xmjd_d.getLength()
      IF g_xmjd_d[li_idx].xmjd001 IS NOT NULL
         AND g_xmjd_d[li_idx].xmjd002 IS NOT NULL
         AND g_xmjd_d[li_idx].xmjd003 IS NOT NULL
         AND g_xmjd_d[li_idx].xmjd004 IS NOT NULL
         AND g_xmjd_d[li_idx].xmjd008 IS NOT NULL
         AND g_xmjd_d[li_idx].xmjd010 IS NOT NULL
         AND g_xmjd_d[li_idx].xmjd012 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         #状态不为1.未审核的资料和由原稿转入的资料不能删除
         IF g_xmjd_d[li_idx].xmjd017 <> '1' OR (NOT cl_null(g_xmjd_d[li_idx].xmjd007)) THEN
            CONTINUE FOR
         END IF
         #end add-point   
         
         DELETE FROM xmjd_t
          WHERE xmjdent = g_enterprise AND 
                xmjd001 = g_xmjd_d[li_idx].xmjd001
                AND xmjd002 = g_xmjd_d[li_idx].xmjd002
                AND xmjd003 = g_xmjd_d[li_idx].xmjd003
                AND xmjd004 = g_xmjd_d[li_idx].xmjd004
                AND xmjd008 = g_xmjd_d[li_idx].xmjd008
                AND xmjd010 = g_xmjd_d[li_idx].xmjd010
                AND xmjd012 = g_xmjd_d[li_idx].xmjd012
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmjd_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_xmjd_d_t.xmjd001
               LET gs_keys[2] = g_xmjd_d_t.xmjd002
               LET gs_keys[3] = g_xmjd_d_t.xmjd003
               LET gs_keys[4] = g_xmjd_d_t.xmjd004
               LET gs_keys[5] = g_xmjd_d_t.xmjd008
               LET gs_keys[6] = g_xmjd_d_t.xmjd010
               LET gs_keys[7] = g_xmjd_d_t.xmjd012
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL asli201_delete_b('xmjd_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asli201_set_pk_array()
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
   CALL asli201_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="asli201.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asli201_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.xmjd001,t0.xmjd002,t0.xmjd003,t0.xmjd004,t0.xmjd005,t0.xmjd006,t0.xmjd007, 
       t0.xmjd008,t0.xmjd020,t0.xmjd021,t0.xmjd022,t0.xmjd023,t0.xmjd024,t0.xmjd025,t0.xmjd026,t0.xmjd027, 
       t0.xmjd028,t0.xmjd029,t0.xmjd030,t0.xmjd031,t0.xmjd009,t0.xmjd010,t0.xmjd011,t0.xmjd012,t0.xmjd013, 
       t0.xmjd014,t0.xmjd015,t0.xmjd016,t0.xmjd017,t0.xmjdsite,t0.xmjdstus,t0.xmjd001,t0.xmjd002,t0.xmjd003, 
       t0.xmjd004,t0.xmjd008,t0.xmjd010,t0.xmjd012,t0.xmjdownid,t0.xmjdowndp,t0.xmjdcrtid,t0.xmjdcrtdp, 
       t0.xmjdcrtdt,t0.xmjdmodid,t0.xmjdmoddt ,t1.imaal003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 FROM xmjd_t t0",
               "",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.xmjd008 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.xmjdownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.xmjdowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.xmjdcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.xmjdcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xmjdmodid  ",
 
               " WHERE t0.xmjdent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("xmjd_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND xmjdowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("xmjd_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND xmjdownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("xmjd_t"),
                      " ORDER BY t0.xmjd001,t0.xmjd002,t0.xmjd003,t0.xmjd004,t0.xmjd008,t0.xmjd010,t0.xmjd012"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmjd_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asli201_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asli201_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xmjd_d.clear()
   CALL g_xmjd2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_xmjd_d[l_ac].xmjd001,g_xmjd_d[l_ac].xmjd002,g_xmjd_d[l_ac].xmjd003,g_xmjd_d[l_ac].xmjd004, 
       g_xmjd_d[l_ac].xmjd005,g_xmjd_d[l_ac].xmjd006,g_xmjd_d[l_ac].xmjd007,g_xmjd_d[l_ac].xmjd008,g_xmjd_d[l_ac].xmjd020, 
       g_xmjd_d[l_ac].xmjd021,g_xmjd_d[l_ac].xmjd022,g_xmjd_d[l_ac].xmjd023,g_xmjd_d[l_ac].xmjd024,g_xmjd_d[l_ac].xmjd025, 
       g_xmjd_d[l_ac].xmjd026,g_xmjd_d[l_ac].xmjd027,g_xmjd_d[l_ac].xmjd028,g_xmjd_d[l_ac].xmjd029,g_xmjd_d[l_ac].xmjd030, 
       g_xmjd_d[l_ac].xmjd031,g_xmjd_d[l_ac].xmjd009,g_xmjd_d[l_ac].xmjd010,g_xmjd_d[l_ac].xmjd011,g_xmjd_d[l_ac].xmjd012, 
       g_xmjd_d[l_ac].xmjd013,g_xmjd_d[l_ac].xmjd014,g_xmjd_d[l_ac].xmjd015,g_xmjd_d[l_ac].xmjd016,g_xmjd_d[l_ac].xmjd017, 
       g_xmjd_d[l_ac].xmjdsite,g_xmjd_d[l_ac].xmjdstus,g_xmjd2_d[l_ac].xmjd001,g_xmjd2_d[l_ac].xmjd002, 
       g_xmjd2_d[l_ac].xmjd003,g_xmjd2_d[l_ac].xmjd004,g_xmjd2_d[l_ac].xmjd008,g_xmjd2_d[l_ac].xmjd010, 
       g_xmjd2_d[l_ac].xmjd012,g_xmjd2_d[l_ac].xmjdownid,g_xmjd2_d[l_ac].xmjdowndp,g_xmjd2_d[l_ac].xmjdcrtid, 
       g_xmjd2_d[l_ac].xmjdcrtdp,g_xmjd2_d[l_ac].xmjdcrtdt,g_xmjd2_d[l_ac].xmjdmodid,g_xmjd2_d[l_ac].xmjdmoddt, 
       g_xmjd_d[l_ac].xmjd008_desc,g_xmjd2_d[l_ac].xmjdownid_desc,g_xmjd2_d[l_ac].xmjdowndp_desc,g_xmjd2_d[l_ac].xmjdcrtid_desc, 
       g_xmjd2_d[l_ac].xmjdcrtdp_desc,g_xmjd2_d[l_ac].xmjdmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_xmjd_d[l_ac].sel = 'N'
      #end add-point
      
      CALL asli201_detail_show()      
 
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
   
 
   
   CALL g_xmjd_d.deleteElement(g_xmjd_d.getLength())   
   CALL g_xmjd2_d.deleteElement(g_xmjd2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_xmjd_d.getLength()
      LET g_xmjd2_d[l_ac].xmjd001 = g_xmjd_d[l_ac].xmjd001 
      LET g_xmjd2_d[l_ac].xmjd002 = g_xmjd_d[l_ac].xmjd002 
      LET g_xmjd2_d[l_ac].xmjd003 = g_xmjd_d[l_ac].xmjd003 
      LET g_xmjd2_d[l_ac].xmjd004 = g_xmjd_d[l_ac].xmjd004 
      LET g_xmjd2_d[l_ac].xmjd008 = g_xmjd_d[l_ac].xmjd008 
      LET g_xmjd2_d[l_ac].xmjd010 = g_xmjd_d[l_ac].xmjd010 
      LET g_xmjd2_d[l_ac].xmjd012 = g_xmjd_d[l_ac].xmjd012 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_xmjd_d.getLength() THEN
      LET l_ac = g_xmjd_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmjd_d.getLength()
      LET g_xmjd_d_mask_o[l_ac].* =  g_xmjd_d[l_ac].*
      CALL asli201_xmjd_t_mask()
      LET g_xmjd_d_mask_n[l_ac].* =  g_xmjd_d[l_ac].*
   END FOR
   
   LET g_xmjd2_d_mask_o.* =  g_xmjd2_d.*
   FOR l_ac = 1 TO g_xmjd2_d.getLength()
      LET g_xmjd2_d_mask_o[l_ac].* =  g_xmjd2_d[l_ac].*
      CALL asli201_xmjd_t_mask()
      LET g_xmjd2_d_mask_n[l_ac].* =  g_xmjd2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_xmjd_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE asli201_pb
   
END FUNCTION
 
{</section>}
 
{<section id="asli201.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asli201_detail_show()
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
 
{<section id="asli201.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asli201_set_entry_b(p_cmd)                                                  
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
   CALL cl_set_comp_entry("xmjd001,xmjd002,xmjd003,xmjd004,xmjd008,xmjd010,xmjd012",TRUE)
   CALL cl_set_comp_entry("xmjd029",TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="asli201.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asli201_set_no_entry_b(p_cmd)                                               
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
      IF (NOT cl_null(g_xmjd_d[l_ac].xmjd007)) OR (g_xmjd_d[l_ac].xmjd017 <> '1') THEN
         CALL cl_set_comp_entry("xmjd001,xmjd002,xmjd003,xmjd004,xmjd008,xmjd010,xmjd012",FALSE)
         CALL cl_set_comp_entry("xmjd029",FALSE)
      END IF
      #end add-point 
   END IF
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
   
   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="asli201.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asli201_default_search()
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
      LET ls_wc = ls_wc, " xmjd001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmjd002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xmjd003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xmjd004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xmjd008 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xmjd010 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xmjd012 = '", g_argv[07], "' AND "
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
 
{<section id="asli201.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asli201_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "xmjd_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'xmjd_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM xmjd_t
          WHERE xmjdent = g_enterprise AND
            xmjd001 = ps_keys_bak[1] AND xmjd002 = ps_keys_bak[2] AND xmjd003 = ps_keys_bak[3] AND xmjd004 = ps_keys_bak[4] AND xmjd008 = ps_keys_bak[5] AND xmjd010 = ps_keys_bak[6] AND xmjd012 = ps_keys_bak[7]
         
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
         CALL g_xmjd_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xmjd2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asli201.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asli201_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "xmjd_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO xmjd_t
                  (xmjdent,
                   xmjd001,xmjd002,xmjd003,xmjd004,xmjd008,xmjd010,xmjd012
                   ,xmjd005,xmjd006,xmjd007,xmjd020,xmjd021,xmjd022,xmjd023,xmjd024,xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,xmjd030,xmjd031,xmjd009,xmjd011,xmjd013,xmjd014,xmjd015,xmjd016,xmjd017,xmjdsite,xmjdstus,xmjdownid,xmjdowndp,xmjdcrtid,xmjdcrtdp,xmjdcrtdt,xmjdmodid,xmjdmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7]
                   ,g_xmjd_d[l_ac].xmjd005,g_xmjd_d[l_ac].xmjd006,g_xmjd_d[l_ac].xmjd007,g_xmjd_d[l_ac].xmjd020, 
                       g_xmjd_d[l_ac].xmjd021,g_xmjd_d[l_ac].xmjd022,g_xmjd_d[l_ac].xmjd023,g_xmjd_d[l_ac].xmjd024, 
                       g_xmjd_d[l_ac].xmjd025,g_xmjd_d[l_ac].xmjd026,g_xmjd_d[l_ac].xmjd027,g_xmjd_d[l_ac].xmjd028, 
                       g_xmjd_d[l_ac].xmjd029,g_xmjd_d[l_ac].xmjd030,g_xmjd_d[l_ac].xmjd031,g_xmjd_d[l_ac].xmjd009, 
                       g_xmjd_d[l_ac].xmjd011,g_xmjd_d[l_ac].xmjd013,g_xmjd_d[l_ac].xmjd014,g_xmjd_d[l_ac].xmjd015, 
                       g_xmjd_d[l_ac].xmjd016,g_xmjd_d[l_ac].xmjd017,g_xmjd_d[l_ac].xmjdsite,g_xmjd_d[l_ac].xmjdstus, 
                       g_xmjd2_d[l_ac].xmjdownid,g_xmjd2_d[l_ac].xmjdowndp,g_xmjd2_d[l_ac].xmjdcrtid, 
                       g_xmjd2_d[l_ac].xmjdcrtdp,g_xmjd2_d[l_ac].xmjdcrtdt,g_xmjd2_d[l_ac].xmjdmodid, 
                       g_xmjd2_d[l_ac].xmjdmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmjd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asli201.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asli201_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "xmjd_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "xmjd_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE xmjd_t 
         SET (xmjd001,xmjd002,xmjd003,xmjd004,xmjd008,xmjd010,xmjd012
              ,xmjd005,xmjd006,xmjd007,xmjd020,xmjd021,xmjd022,xmjd023,xmjd024,xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,xmjd030,xmjd031,xmjd009,xmjd011,xmjd013,xmjd014,xmjd015,xmjd016,xmjd017,xmjdsite,xmjdstus,xmjdownid,xmjdowndp,xmjdcrtid,xmjdcrtdp,xmjdcrtdt,xmjdmodid,xmjdmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7]
              ,g_xmjd_d[l_ac].xmjd005,g_xmjd_d[l_ac].xmjd006,g_xmjd_d[l_ac].xmjd007,g_xmjd_d[l_ac].xmjd020, 
                  g_xmjd_d[l_ac].xmjd021,g_xmjd_d[l_ac].xmjd022,g_xmjd_d[l_ac].xmjd023,g_xmjd_d[l_ac].xmjd024, 
                  g_xmjd_d[l_ac].xmjd025,g_xmjd_d[l_ac].xmjd026,g_xmjd_d[l_ac].xmjd027,g_xmjd_d[l_ac].xmjd028, 
                  g_xmjd_d[l_ac].xmjd029,g_xmjd_d[l_ac].xmjd030,g_xmjd_d[l_ac].xmjd031,g_xmjd_d[l_ac].xmjd009, 
                  g_xmjd_d[l_ac].xmjd011,g_xmjd_d[l_ac].xmjd013,g_xmjd_d[l_ac].xmjd014,g_xmjd_d[l_ac].xmjd015, 
                  g_xmjd_d[l_ac].xmjd016,g_xmjd_d[l_ac].xmjd017,g_xmjd_d[l_ac].xmjdsite,g_xmjd_d[l_ac].xmjdstus, 
                  g_xmjd2_d[l_ac].xmjdownid,g_xmjd2_d[l_ac].xmjdowndp,g_xmjd2_d[l_ac].xmjdcrtid,g_xmjd2_d[l_ac].xmjdcrtdp, 
                  g_xmjd2_d[l_ac].xmjdcrtdt,g_xmjd2_d[l_ac].xmjdmodid,g_xmjd2_d[l_ac].xmjdmoddt) 
         WHERE xmjdent = g_enterprise AND xmjd001 = ps_keys_bak[1] AND xmjd002 = ps_keys_bak[2] AND xmjd003 = ps_keys_bak[3] AND xmjd004 = ps_keys_bak[4] AND xmjd008 = ps_keys_bak[5] AND xmjd010 = ps_keys_bak[6] AND xmjd012 = ps_keys_bak[7]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmjd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmjd_t:",SQLERRMESSAGE 
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
 
{<section id="asli201.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asli201_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL asli201_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "xmjd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asli201_bcl USING g_enterprise,
                                       g_xmjd_d[g_detail_idx].xmjd001,g_xmjd_d[g_detail_idx].xmjd002, 
                                           g_xmjd_d[g_detail_idx].xmjd003,g_xmjd_d[g_detail_idx].xmjd004, 
                                           g_xmjd_d[g_detail_idx].xmjd008,g_xmjd_d[g_detail_idx].xmjd010, 
                                           g_xmjd_d[g_detail_idx].xmjd012
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asli201_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asli201.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asli201_unlock_b(ps_table)
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
      CLOSE asli201_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asli201.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION asli201_modify_detail_chk(ps_record)
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
      WHEN "s_detail2"
         LET ls_return = "xmjd001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="asli201.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION asli201_show_ownid_msg()
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
 
{<section id="asli201.mask_functions" >}
&include "erp/asl/asli201_mask.4gl"
 
{</section>}
 
{<section id="asli201.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asli201_set_pk_array()
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
   LET g_pk_array[1].values = g_xmjd_d[l_ac].xmjd001
   LET g_pk_array[1].column = 'xmjd001'
   LET g_pk_array[2].values = g_xmjd_d[l_ac].xmjd002
   LET g_pk_array[2].column = 'xmjd002'
   LET g_pk_array[3].values = g_xmjd_d[l_ac].xmjd003
   LET g_pk_array[3].column = 'xmjd003'
   LET g_pk_array[4].values = g_xmjd_d[l_ac].xmjd004
   LET g_pk_array[4].column = 'xmjd004'
   LET g_pk_array[5].values = g_xmjd_d[l_ac].xmjd008
   LET g_pk_array[5].column = 'xmjd008'
   LET g_pk_array[6].values = g_xmjd_d[l_ac].xmjd010
   LET g_pk_array[6].column = 'xmjd010'
   LET g_pk_array[7].values = g_xmjd_d[l_ac].xmjd012
   LET g_pk_array[7].column = 'xmjd012'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asli201.state_change" >}
   
 
{</section>}
 
{<section id="asli201.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="asli201.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 原稿轉入邏輯
# Memo...........:
# Usage..........: CALL asli201_data_ins()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_data_ins()
DEFINE l_optype        LIKE type_t.chr1
DEFINE l_xmjd001_1     LIKE xmjd_t.xmjd001
DEFINE l_xmjd002_1     LIKE xmjd_t.xmjd002
DEFINE l_xmjd003_1     LIKE xmjd_t.xmjd003
DEFINE l_wc            STRING
DEFINE l_sql           STRING
DEFINE l_time          DATETIME YEAR TO SECOND
DEFINE l_xmjd006       LIKE xmjd_t.xmjd006
DEFINE l_xmjd007       LIKE xmjd_t.xmjd007
DEFINE l_xmjd008       LIKE xmjd_t.xmjd008
DEFINE l_xmjd010       LIKE xmjd_t.xmjd010
DEFINE l_xmjd012       LIKE xmjd_t.xmjd012


   #畫面開啟 (identifier)
   OPEN WINDOW w_asli201_s01 WITH FORM cl_ap_formpath("asl","asli201_s01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   CALL cl_set_combo_scc('optype','6963') 
   CALL cl_set_combo_scc_part('xmjd002_1','6940','1,2') 
   CALL cl_set_combo_scc('xmjd003_1','6960') 
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT l_optype,l_xmjd001_1,l_xmjd002_1,l_xmjd003_1 FROM optype,xmjd001_1,xmjd002_1,xmjd003_1
         
         BEFORE INPUT
            
         AFTER FIELD xmjd003_1
            IF l_xmjd003_1 = '0' THEN
               CALL cl_set_comp_entry("xmjd004_1",FALSE)
               DISPLAY '' TO xmjd004_1
               LET l_wc = " 1=1"
            ELSE
               CALL cl_set_comp_entry("xmjd004_1",TRUE)
            END IF
            
      END INPUT
      
      CONSTRUCT l_wc ON xmjd004_1 FROM xmjd004_1
      
         BEFORE CONSTRUCT
            IF l_xmjd003_1 = '0' THEN
               NEXT FIELD xmjd003_1
            END IF
         
         ON ACTION controlp INFIELD xmjd004_1
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF l_xmjd003_1 = '1' THEN
               #CALL q_pmaa001_13()                          #呼叫開窗  #160922-00032#3 Mark By Ken 160929
               LET g_qryparam.where = " ooefstus != 'N' "    #160922-00032#3 Add By Ken 160929
               CALL q_ooef001_34()                           #呼叫開窗   #160922-00032#3 Add By Ken 160929
            END IF
            IF l_xmjd003_1 = '2' THEN
               #CALL q_ooef001_34()                          #呼叫開窗  #160922-00032#3 Mark By Ken 160929
               LET g_qryparam.where = " pmaastus = 'Y' "     #160922-00032#3 Add By Ken 160929
               CALL q_pmaa001_13()                           #呼叫開窗   #160922-00032#3 Add By Ken 160929
            END IF
            DISPLAY g_qryparam.return1 TO xmjd004_1  #顯示到畫面上
            NEXT FIELD xmjd004_1                     #返回原欄位
            
         
      END CONSTRUCT
   
      BEFORE DIALOG
         LET l_optype = '1'
         LET l_xmjd002_1 = '1'
         #LET l_xmjd003_1 = '1'   #160922-00032#3 Mark By Ken 160929
         LET l_xmjd003_1 = '2'    #160922-00032#3 Add By Ken 160929
         IF cl_null(l_wc) THEN
            LET l_wc = " 1=1"
         END IF
      
      ON ACTION accept
         CALL asli201_data_ins_tmp('a')
         CALL s_transaction_begin()
         IF l_optype = '1' THEN
            #抓取原稿資料
            LET l_wc = cl_replace_str(l_wc,'xmjd004_1','xmjc004')
            LET l_sql = " INSERT INTO asli201_xmjc_tmp ",
                        " SELECT * FROM xmjc_t WHERE xmjcent = ",g_enterprise," ",
                        "    AND xmjc001 = ",l_xmjd001_1," ",
                        "    AND xmjc002 = '",l_xmjd002_1,"' ",
                        #"    AND xmjc003 = '",l_xmjd003_1,"' ",
                        "    AND ",l_wc,
                        "    AND xmjc016 = '0' "
            IF l_xmjd003_1 <> '0' THEN
               LET l_sql = l_sql," AND xmjc003 = '",l_xmjd003_1,"' "
            END IF
            PREPARE ins_xmjc_tmp FROM l_sql
            EXECUTE ins_xmjc_tmp
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins xmjc_tmp" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL asli201_data_ins_tmp('d')
               EXIT DIALOG
            END IF
            #寫入當前表
            LET l_time = cl_get_current()
            LET l_sql = " MERGE INTO xmjd_t ",
                        " USING (SELECT xmjcent, xmjcsite, xmjc001, xmjc002, xmjc003, xmjc004, xmjc005, xmjc006, xmjc007, ",
                        "               xmjc008, xmjc009, xmjc010, xmjc011, xmjc012, xmjc013, xmjc014, xmjc015, xmjc016, ",
                        "               xmjc017, xmjc018, xmjc019, xmjc020, xmjc021, xmjc022, xmjc023, xmjc024, xmjc025, ",
                        "               xmjc026, xmjc027, xmjc028, xmjc029, xmjc030 ",
                        "          FROM asli201_xmjc_tmp) ",
                        "    ON (xmjdent=xmjcent AND xmjd001=xmjc001 AND xmjd002=xmjc002 AND xmjd003=xmjc003 AND ",
                        "        xmjd004=xmjc004 AND xmjd008=xmjc008 AND xmjd010=xmjc010 AND xmjd012=xmjc012 AND ",
                        "        xmjd017='1') ",
                        "  WHEN NOT MATCHED THEN ",
                        " INSERT (xmjdent, xmjdsite, xmjd001, xmjd002, xmjd003, xmjd004, xmjd005, xmjd006, xmjd007, ",
                        "         xmjd008, xmjd009, xmjd010, xmjd011, xmjd012, xmjd013, xmjd014, xmjd015, xmjd016, xmjd017, ",
                        "         xmjd018, xmjd019, xmjd020, xmjd021, xmjd022, xmjd023, xmjd024, xmjd025, xmjd026, xmjd027, ",
                        "         xmjd028, xmjd029, xmjd030, xmjd031, xmjdstus, ",
                        "         xmjdownid, xmjdowndp, xmjdcrtid, xmjdcrtdp, xmjdcrtdt) ",
                        " VALUES (xmjcent, xmjcsite, xmjc001, xmjc002, xmjc003, xmjc004, xmjc005, xmjc006, xmjc007, ",
                        "         xmjc008, xmjc009, xmjc010, xmjc011, xmjc012, xmjc013, xmjc014, xmjc014, xmjc015, '1', ",
                        "         xmjc017, xmjc018, xmjc019, xmjc020, xmjc021, xmjc022, xmjc023, xmjc024, xmjc025, xmjc026, ",
                        "         xmjc027, xmjc028, xmjc029, xmjc030, 'Y', ",
                        "         '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',to_date('",l_time,"','YYYY-MM-DD hh24:mi:ss')) ",   
                        "  WHEN MATCHED THEN ",
                        " UPDATE SET xmjdsite = xmjcsite,xmjd005 = xmjc005,xmjd006 = xmjc006,xmjd007 = xmjc007,xmjd009 = xmjc009, ",
                        "            xmjd011 = xmjc011,xmjd013 = xmjc013,xmjd014 = xmjc014,xmjd015 = xmjc014,xmjd016 = xmjc016, ",
                        "            xmjd018 = xmjc017,xmjd019 = xmjc018,xmjd020 = xmjc019,xmjd021 = xmjc020,xmjd022 = xmjc021, ",
                        "            xmjd023 = xmjc022,xmjd024 = xmjc023,xmjd025 = xmjc024,xmjd026 = xmjc025,xmjd027 = xmjc026, ",
                        "            xmjd028 = xmjc027,xmjd029 = xmjc028,xmjd030 = xmjc029,xmjd031 = xmjc030 "
            PREPARE ins_xmjd_pre FROM l_sql
            EXECUTE ins_xmjd_pre
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "merge xmjd" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL asli201_data_ins_tmp('d')
               EXIT DIALOG
            END IF        
            #回写原稿状态
            LET l_sql = " UPDATE xmjc_t t1 SET t1.xmjc016 = '1' ",
                        "  WHERE EXISTS (SELECT 1 FROM asli201_xmjc_tmp t2 WHERE t2.xmjcent=t1.xmjcent ",
                        "                   AND t2.xmjc001=t1.xmjc001 AND t2.xmjc002=t1.xmjc002 ",
                        "                   AND t2.xmjc003=t1.xmjc003 AND t2.xmjc004=t1.xmjc004 ",
                        "                   AND t2.xmjc008=t1.xmjc008 AND t2.xmjc010=t1.xmjc010 ",
                        "                   AND t2.xmjc012=t1.xmjc012) " 
            PREPARE upd_xmjc_pre FROM l_sql
            EXECUTE upd_xmjc_pre     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xmjc" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL asli201_data_ins_tmp('d')
               EXIT DIALOG
            END IF            
         END IF
         #取消转入
         IF l_optype = '2' THEN
            #抓取当前表資料
            LET l_wc = cl_replace_str(l_wc,'xmjd004_1','xmjd004')
            LET l_sql = " INSERT INTO asli201_xmjd_tmp ",
                        " SELECT * FROM xmjd_t WHERE xmjdent = ",g_enterprise," ",
                        "    AND xmjd001 = ",l_xmjd001_1," ",
                        "    AND xmjd002 = '",l_xmjd002_1,"' ",
                        #"    AND xmjd003 = '",l_xmjd003_1,"' ",
                        "    AND xmjd007 IS NOT NULL ",
                        "    AND ",l_wc
            IF l_xmjd003_1 <> '0' THEN
               LET l_sql = l_sql," AND xmjd003 = '",l_xmjd003_1,"' "
            END IF
            PREPARE ins_xmjd_tmp FROM l_sql
            EXECUTE ins_xmjd_tmp
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins xmjd_tmp" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL asli201_data_ins_tmp('d')
               EXIT DIALOG
            END IF
            #回写原稿状态
            LET l_sql = " UPDATE xmjc_t t1 SET t1.xmjc016 = '0' ",
                        "  WHERE EXISTS (SELECT 1 FROM asli201_xmjd_tmp t2 WHERE t2.xmjdent=t1.xmjcent ",
                        "                   AND t2.xmjd001=t1.xmjc001 AND t2.xmjd002=t1.xmjc002 ",
                        "                   AND t2.xmjd003=t1.xmjc003 AND t2.xmjd004=t1.xmjc004 ",
                        "                   AND t2.xmjd008=t1.xmjc008 AND t2.xmjd010=t1.xmjc010 ",
                        "                   AND t2.xmjd012=t1.xmjc012 AND t2.xmjd017 = '1') " 
            PREPARE upd_xmjc_pre2 FROM l_sql
            EXECUTE upd_xmjc_pre2     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xmjc" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL asli201_data_ins_tmp('d')
               EXIT DIALOG
            END IF
            #删除当前表资料
            LET l_sql = " DELETE FROM xmjd_t t1 ",
                        "  WHERE EXISTS (SELECT 1 FROM asli201_xmjd_tmp t2 WHERE t2.xmjdent=t1.xmjdent ",
                        "                   AND t2.xmjd001=t1.xmjd001 AND t2.xmjd002=t1.xmjd002 ",
                        "                   AND t2.xmjd003=t1.xmjd003 AND t2.xmjd004=t1.xmjd004 ",
                        "                   AND t2.xmjd008=t1.xmjd008 AND t2.xmjd010=t1.xmjd010 ",
                        "                   AND t2.xmjd012=t1.xmjd012 AND t2.xmjd017 = '1') " 
            PREPARE del_xmjd_pre FROM l_sql
            EXECUTE del_xmjd_pre
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "del xmjd" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL asli201_data_ins_tmp('d')
               EXIT DIALOG
            END IF
            #汇总状态不为未审核无法取消转入的资料
            CALL cl_err_collect_init()
            LET l_sql = " SELECT xmjd006,xmjd007,xmjd008,xmjd010,xmjd012 FROM asli201_xmjd_tmp ",
                        "  WHERE xmjd017 <> '1' "
            PREPARE sel_xmjd_tmp FROM l_sql
            DECLARE xmjd_tmp_cs  CURSOR FOR sel_xmjd_tmp
            FOREACH xmjd_tmp_cs  INTO l_xmjd006,l_xmjd007,l_xmjd008,l_xmjd010,l_xmjd012
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'asl-00008'
               LET g_errparam.replace[1] = l_xmjd007
               LET g_errparam.replace[2] = l_xmjd008
               LET g_errparam.replace[3] = l_xmjd010
               LET g_errparam.replace[4] = l_xmjd012
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               LET l_xmjd006 = ''
               LET l_xmjd007 = ''
               LET l_xmjd008 = ''
               LET l_xmjd010 = ''
               LET l_xmjd012 = ''
               CONTINUE FOREACH
            END FOREACH
            CALL cl_err_collect_show()
         END IF
         
         CALL s_transaction_end('Y','0')
         CALL asli201_data_ins_tmp('d')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "sub-00033"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         ACCEPT DIALOG
         
      ON ACTION CANCEL
      
         EXIT DIALOG
      
      ON ACTION close
      
         EXIT DIALOG
       
      ON ACTION exit
      
         EXIT DIALOG
      
      
   END DIALOG
   
   #畫面關閉
   CLOSE WINDOW w_asli201_s01
      
END FUNCTION

################################################################################
# Descriptions...: 資料轉入临时表处理
# Memo...........:
# Usage..........: CALL asli201_data_ins_tmp(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_data_ins_tmp(p_type)
DEFINE p_type        LIKE type_t.chr1

   CASE p_type
      WHEN 'a'
         DROP TABLE asli201_xmjc_tmp
         SELECT * FROM xmjc_t WHERE 1=0 INTO TEMP asli201_xmjc_tmp
         
         DROP TABLE asli201_xmjd_tmp
         SELECT * FROM xmjd_t WHERE 1=0 INTO TEMP asli201_xmjd_tmp
         
      WHEN 'i'
         DROP TABLE asli201_pmaa_tmp 
         CREATE TEMP TABLE asli201_pmaa_tmp(
            pmaa001      VARCHAR(10),
            pmaal004     VARCHAR(80));
         DROP TABLE asli201_ooef_tmp 
         CREATE TEMP TABLE asli201_ooef_tmp(
            ooef001      VARCHAR(10),
            ooefl003     VARCHAR(500));
         DROP TABLE asli201_imaa_tmp 
         CREATE TEMP TABLE asli201_imaa_tmp(
            imaa001      VARCHAR(40),
            imaa157      DECIMAL(20,6),
            imaa126      VARCHAR(40),
            imaa127      VARCHAR(40),
            imaa134      VARCHAR(40),
            imaa133      VARCHAR(40),
            imaa158      VARCHAR(40),
            imaa156      VARCHAR(40),
            imaa132      VARCHAR(40),
            rtax001      VARCHAR(40),
            imaa009      VARCHAR(40),
            imaa131      VARCHAR(40),
            imaa130      VARCHAR(40));
         
      WHEN 'd'
         DROP TABLE asli201_xmjc_tmp
         DROP TABLE asli201_xmjd_tmp
         DROP TABLE asli201_pmaa_tmp
         DROP TABLE asli201_ooef_tmp 
         DROP TABLE asli201_imaa_tmp
         
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 整批调整
# Memo...........:
# Usage..........: CALL asli201_batch_process(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_batch_process(p_type)
DEFINE p_type           LIKE type_t.chr5
DEFINE l_optype_2       LIKE type_t.chr1
DEFINE l_xmjd001_2      LIKE xmjd_t.xmjd001
DEFINE l_xmjd002_2      LIKE xmjd_t.xmjd002
DEFINE l_xmjd003_2      LIKE xmjd_t.xmjd003
DEFINE l_amount         LIKE type_t.num10
DEFINE l_xmjd004_str    STRING
DEFINE l_xmjd008_str    STRING
DEFINE l_xmjd010_str    STRING
DEFINE l_xmjd012_str    STRING
DEFINE l_xmjd004_table  STRING
DEFINE l_pmaa_str       STRING
DEFINE l_pmaa_table     STRING
DEFINE l_ooef_str       STRING
DEFINE l_ooef_table     STRING
DEFINE l_i              LIKE type_t.num10
DEFINE l_sql            STRING
DEFINE l_time           DATETIME YEAR TO SECOND

   #畫面開啟 (identifier)
   OPEN WINDOW w_asli201_s02 WITH FORM cl_ap_formpath("asl","asli201_s02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   IF p_type = 'ins' THEN
      CALL lwin_curr.setText(cl_getmsg('asl-00012',g_dlang))
   END IF
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_p.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   CALL cl_set_combo_scc('optype_2','6962') 
   CALL cl_set_combo_scc_part('xmjd002_2','6940','1,2') 
   CALL cl_set_combo_scc_part('xmjd003_2','6960','1,2') 
   CALL cl_set_combo_scc('b_xmjd002','6940') 
   CALL cl_set_combo_scc('b_xmjd003','6960') 
   CALL asli201_batch_visible(p_type)
   CALL asli201_batch_no_visible(p_type)
   
   CALL asli201_data_ins_tmp('a')
   IF p_type = 'upd' THEN
      #抓取主画面勾选的资料显示
      DELETE FROM asli201_xmjd_tmp
      FOR l_i = 1 TO g_xmjd_d.getLength()
         IF g_xmjd_d[l_i].sel = 'Y' AND g_xmjd_d[l_i].xmjd017 = '1' THEN
            INSERT INTO asli201_xmjd_tmp (xmjdent,xmjd001,xmjd002,xmjd003,xmjd004,
                                          xmjd005,xmjd006,xmjd007,xmjd008,xmjd009,
                                          xmjd010,xmjd011,xmjd012,xmjd013,xmjd014,
                                          xmjd015,xmjd016,xmjd017,xmjdsite,xmjdstus,
                                          xmjd020,xmjd021,xmjd022,xmjd023,xmjd024,
                                          xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,
                                          xmjd030,xmjd031)
            VALUES (g_enterprise,g_xmjd_d[l_i].xmjd001,g_xmjd_d[l_i].xmjd002,g_xmjd_d[l_i].xmjd003,g_xmjd_d[l_i].xmjd004,
                    g_xmjd_d[l_i].xmjd005,g_xmjd_d[l_i].xmjd006,g_xmjd_d[l_i].xmjd007,g_xmjd_d[l_i].xmjd008,g_xmjd_d[l_i].xmjd009,
                    g_xmjd_d[l_i].xmjd010,g_xmjd_d[l_i].xmjd011,g_xmjd_d[l_i].xmjd012,g_xmjd_d[l_i].xmjd013,g_xmjd_d[l_i].xmjd014,
                    g_xmjd_d[l_i].xmjd015,g_xmjd_d[l_i].xmjd016,g_xmjd_d[l_i].xmjd017,g_xmjd_d[l_i].xmjdsite,g_xmjd_d[l_i].xmjdstus,
                    g_xmjd_d[l_i].xmjd020,g_xmjd_d[l_i].xmjd021,g_xmjd_d[l_i].xmjd022,g_xmjd_d[l_i].xmjd023,g_xmjd_d[l_i].xmjd024,
                    g_xmjd_d[l_i].xmjd025,g_xmjd_d[l_i].xmjd026,g_xmjd_d[l_i].xmjd027,g_xmjd_d[l_i].xmjd028,g_xmjd_d[l_i].xmjd029,
                    g_xmjd_d[l_i].xmjd030,g_xmjd_d[l_i].xmjd031)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins xmjd_tmp" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL asli201_data_ins_tmp('d')
               RETURN
            END IF
         END IF
      END FOR
   END IF
   CALL asli201_tmp_fill()
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT l_optype_2,l_xmjd001_2,l_xmjd002_2,l_xmjd003_2 FROM optype_2,xmjd001_2,xmjd002_2,xmjd003_2
         
         BEFORE INPUT
            IF p_type = 'upd' THEN
               LET l_optype_2 = '1'
            ELSE
               LET l_optype_2 = '5'
               LET l_xmjd002_2 = '1'
               #LET l_xmjd003_2 = '1'   #160922-00032#3 Mark By Ken 160929
               LET l_xmjd003_2 = '2'    #160922-00032#3 Add By Ken 160929
            END IF
            
         AFTER FIELD optype_2
            IF l_optype_2 = '4' THEN
               LET l_amount = 0
               DISPLAY l_amount TO amount
            END IF
         
      END INPUT
      
      CONSTRUCT l_xmjd004_str ON xmjd004_2 FROM xmjd004_2
         
         ON ACTION controlp INFIELD xmjd004_2
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF l_xmjd003_2 = '1' THEN
               #CALL q_pmaa001_13()                           #呼叫開窗   #160922-00032#3 Mark By Ken 160929
               LET g_qryparam.where = " ooefstus != 'N' "    #160930-00014#1 Add By Ken 161002
               CALL q_ooef001_34()                           #呼叫開窗    #160922-00032#3 Add By Ken 160929
            END IF
            IF l_xmjd003_2 = '2' THEN
               #CALL q_ooef001_34()                           #呼叫開窗   #160922-00032#3 Mark By Ken 160929
               LET g_qryparam.where = " pmaastus = 'Y' "     #160930-00014#1 Add By Ken 161002
               CALL q_pmaa001_13()                           #呼叫開窗    #160922-00032#3 Add By Ken 160929  
            END IF
            DISPLAY g_qryparam.return1 TO xmjd004_2  #顯示到畫面上
            NEXT FIELD xmjd004_2                     #返回原欄位
         
      END CONSTRUCT
      
      CONSTRUCT l_xmjd008_str ON xmjd008_2 FROM xmjd008_2
         
         ON ACTION controlp INFIELD xmjd008_2
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imaa154 = ",l_xmjd001_2," AND imaa155 = '",l_xmjd002_2,"' "
            CALL q_imaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd008_2  #顯示到畫面上
            NEXT FIELD xmjd008_2                     #返回原欄位
         
      END CONSTRUCT
      
      CONSTRUCT l_xmjd010_str ON xmjd010_2 FROM xmjd010_2
         
         ON ACTION controlp INFIELD xmjd010_2
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2148'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd010_2  #顯示到畫面上
            NEXT FIELD xmjd010_2                     #返回原欄位
         
      END CONSTRUCT
      
      CONSTRUCT l_xmjd012_str ON xmjd012_2 FROM xmjd012_2
         
         ON ACTION controlp INFIELD xmjd012_2
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2149'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmjd012_2  #顯示到畫面上
            NEXT FIELD xmjd012_2                     #返回原欄位
         
      END CONSTRUCT
      
      INPUT l_amount FROM amount
         
         AFTER FIELD amount
            IF l_amount < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00041'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD amount
            END IF
         
      END INPUT
      
      DISPLAY ARRAY g_xmjd_d2 TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt) #page1

         BEFORE ROW
            #顯示單身筆數
            LET g_detail_idx2 = l_curr_diag.getCurrentRow("s_detail1")
            IF g_detail_idx2 > g_xmjd_d2.getLength() THEN
               LET g_detail_idx2 = g_xmjd_d2.getLength()
            END IF
            IF g_detail_idx2 = 0 AND g_xmjd_d2.getLength() <> 0 THEN
               LET g_detail_idx2 = 1
            END IF
            DISPLAY g_detail_idx2 TO FORMONLY.idx
            DISPLAY g_xmjd_d2.getLength() TO FORMONLY.cnt
#            #確定當下選擇的筆數
#            LET l_ac = DIALOG.getCurrentRow("s_detail1")
#            LET g_detail_idx = l_ac
#            LET g_detail_idx_list[1] = l_ac
#            CALL g_idx_group.addAttribute("'1',",l_ac)
   
         BEFORE DISPLAY
#            #如果一直都在單身1則控制筆數位置
#            IF g_loc = 'm' THEN
#               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
#            END IF
#            LET g_loc = 'm'
#            LET l_ac = DIALOG.getCurrentRow("s_detail1")
#            LET g_current_page = 1
#            #顯示單身筆數
#            CALL aprt111_idx_chk()

         END DISPLAY
         
      BEFORE DIALOG
         IF cl_null(l_xmjd004_str) THEN
            LET l_xmjd004_str = " 1=1"
         END IF
         IF cl_null(l_xmjd008_str) THEN
            LET l_xmjd008_str = " 1=1"
         END IF
         IF cl_null(l_xmjd010_str) THEN
            LET l_xmjd010_str = " 1=1"
         END IF
         IF cl_null(l_xmjd012_str) THEN
            LET l_xmjd012_str = " 1=1"
         END IF
         LET l_curr_diag = ui.DIALOG.getCurrent()
      
      ON ACTION accept
         IF cl_null(l_amount) THEN
            NEXT FIELD amount
         END IF
         LET l_time = cl_get_current()
         CASE l_optype_2
            WHEN '1' 
               LET l_sql = " UPDATE asli201_xmjd_tmp SET xmjd015=xmjd015+",l_amount,",xmjd016=xmjd016+(xmjd009*",l_amount,") "
            WHEN '2'                                             
               LET l_sql = " UPDATE asli201_xmjd_tmp SET xmjd015=xmjd015-",l_amount,",xmjd016=xmjd016-(xmjd009*",l_amount,") "
            WHEN '3'                                             
               LET l_sql = " UPDATE asli201_xmjd_tmp SET xmjd015=",l_amount,",xmjd016=(xmjd009*",l_amount,") "
            WHEN '4'         
               LET l_amount = 0
               DISPLAY l_amount TO amount         
               LET l_sql = " UPDATE asli201_xmjd_tmp SET xmjd015=0,xmjd016=0 "
            WHEN '5'
               #新增资料
               CALL asli201_data_ins_tmp('i')
#               #IF l_xmjd003_2 = '1' THEN
               LET l_pmaa_str = cl_replace_str(l_xmjd004_str,'xmjd004_2','pmaa001')
#               LET l_pmaa_table = "(SELECT pmaa001,pmaal004 FROM pmaa_t LEFT JOIN pmaal_t ON pmaalent=pmaaent ",
#                                  "    AND pmaal001=pmaa001 AND pmaal002='",g_dlang,"' ",
#                                  "    AND pmaastus = 'Y' ",
#                                  "    AND pmaaent=",g_enterprise," AND ",l_pmaa_str,") "
#               #END IF
#               #IF l_xmjd003_2 = '2' THEN
               LET l_ooef_str = cl_replace_str(l_xmjd004_str,'xmjd004_2','ooef001')
#               LET l_ooef_table = "(SELECT ooef001,ooefl003 FROM ooef_t LEFT JOIN ooefl_t ON ooeflent=ooefent ",
#                                  "    AND ooefl001=ooef001 AND ooefl002='",g_dlang,"' ",
#                                  "    AND ooefstus = 'Y' ",
#                                  "    AND ooefent=",g_enterprise," AND ",l_ooef_str,") "
#               #END IF
               LET l_xmjd008_str = cl_replace_str(l_xmjd008_str,'xmjd008_2','imaa001')
               LET l_xmjd010_str = cl_replace_str(l_xmjd010_str,'xmjd010_2','oocq002')
               LET l_xmjd012_str = cl_replace_str(l_xmjd012_str,'xmjd012_2','oocq002')
               LET l_sql = " INSERT INTO asli201_pmaa_tmp (pmaa001,pmaal004) ",
                           " SELECT pmaa001,pmaal004 FROM pmaa_t LEFT JOIN pmaal_t ON pmaalent=pmaaent ",
                           "    AND pmaal001=pmaa001 AND pmaal002='",g_dlang,"' ",
                           "  WHERE pmaastus = 'Y' ",
                           "    AND pmaaent=",g_enterprise," AND ",l_pmaa_str
               PREPARE ins_pmaa_tmp FROM l_sql
               EXECUTE ins_pmaa_tmp
               LET l_sql = " INSERT INTO asli201_ooef_tmp (ooef001,ooefl003) ",
                           " SELECT ooef001,ooefl003 FROM ooef_t LEFT JOIN ooefl_t ON ooeflent=ooefent ",
                           "    AND ooefl001=ooef001 AND ooefl002='",g_dlang,"' ",
                           "  WHERE ooefstus = 'Y' ",
                           "    AND ooefent=",g_enterprise," AND ",l_ooef_str
               PREPARE ins_ooef_tmp FROM l_sql
               EXECUTE ins_ooef_tmp
               LET l_sql = " INSERT INTO asli201_imaa_tmp (imaa001,imaa157,imaa126,imaa127,imaa134,imaa133, ",
                           "                               imaa158,imaa156,imaa132,rtax001,imaa009, ",
                           "                               imaa131,imaa130) ",
                           " SELECT imaa001,imaa157,t1.oocql004,t2.oocql004,t3.oocql004,t4.oocql004, ",
                           "        to_char(imaa158,'YYYY-MM-DD'),gzcbl004,t5.oocql004,t6.rtaxl003,t7.rtaxl003, ",
                           "        t8.oocql004,imaa130 ",
                           "   FROM imaa_t LEFT JOIN oocql_t t1 ON t1.oocqlent=imaaent AND t1.oocql001='2002' AND t1.oocql002=imaa126 AND t1.oocql003='",g_dlang,"' ",
                           "               LEFT JOIN oocql_t t2 ON t2.oocqlent=imaaent AND t2.oocql001='2003' AND t2.oocql002=imaa127 AND t2.oocql003='",g_dlang,"' ",
                           "               LEFT JOIN oocql_t t3 ON t3.oocqlent=imaaent AND t3.oocql001='2008' AND t3.oocql002=imaa134 AND t3.oocql003='",g_dlang,"' ",
                           "               LEFT JOIN oocql_t t4 ON t4.oocqlent=imaaent AND t4.oocql001='2007' AND t4.oocql002=imaa133 AND t4.oocql003='",g_dlang,"' ",
                           "               LEFT JOIN gzcbl_t ON gzcbl001='6941' AND gzcbl002=imaa156 AND gzcbl003='",g_dlang,"' ",
                           "               LEFT JOIN oocql_t t5 ON t5.oocqlent=imaaent AND t5.oocql001='2006' AND t5.oocql002=imaa132 AND t5.oocql003='",g_dlang,"' ",
                           "               LEFT JOIN rtaxl_t t7 ON t7.rtaxlent=imaaent AND t7.rtaxl001=imaa009 AND t7.rtaxl002='",g_dlang,"' ",
                           "               LEFT JOIN oocql_t t8 ON t8.oocqlent=imaaent AND t8.oocql001='2001' AND t8.oocql002=imaa131 AND t8.oocql003='",g_dlang,"', ",
                           "        rtax_t LEFT JOIN rtaxl_t t6 ON t6.rtaxlent=rtaxent AND t6.rtaxl001=rtax006 AND t6.rtaxl002='",g_dlang,"' ",
                           "   WHERE imaaent=",g_enterprise," ",
                           "    AND imaaent = rtaxent AND imaa009 = rtax001 ",
                           "    AND imaa154 = ",l_xmjd001_2," AND imaa155 = '",l_xmjd002_2,"' ",
                           "    AND imaastus = 'Y' AND ",l_xmjd008_str
               PREPARE ins_imaa_tmp FROM l_sql
               EXECUTE ins_imaa_tmp
               
               DELETE FROM asli201_xmjd_tmp
               LET l_sql = " INSERT INTO asli201_xmjd_tmp (xmjdent, xmjdsite, xmjd001, xmjd002, xmjd003, xmjd004, ",
                           "                               xmjd005, xmjd006, xmjd007, xmjd008, xmjd009, xmjd010, ",
                           "                               xmjd011, xmjd012, xmjd013, xmjd014, xmjd015, xmjd016, ",
                           "                               xmjd018, xmjd019, xmjd020, xmjd021, xmjd022, xmjd023, ",
                           "                               xmjd024, xmjd025, xmjd026, xmjd027, xmjd028, xmjd029, ",
                           "                               xmjd030, xmjd031, xmjd017, xmjdstus, xmjdownid, xmjdowndp, ",
                           "                               xmjdcrtid, xmjdcrtdp, xmjdcrtdt) ",
                           " SELECT DISTINCT ",g_enterprise,",'",g_site,"',",l_xmjd001_2,",'",l_xmjd002_2,"','",l_xmjd003_2,"', ",
                           "        (CASE '",l_xmjd003_2,"' WHEN '1' THEN pmaa001 WHEN '2' THEN ooef001 END), ",
                           "        (CASE '",l_xmjd003_2,"' WHEN '1' THEN pmaal004 WHEN '2' THEN ooefl003 END), ",
                           "        '','',imaa001,imaa157,t1.oocq002,t1.oocql004,t2.oocq002,t2.oocql004, ",
                           "        '',",l_amount,",imaa157*",l_amount,", ",
                           "        '','',imaa126,imaa127,imaa134,imaa133,imaa158,imaa156, ",
                           "        imaa132,rtax001,imaa009,'',imaa131,imaa130, ",
                           "        '1','Y','",g_user,"','",g_dept,"', ",
                           "        '",g_user,"','",g_dept,"',to_date('",l_time,"','YYYY-MM-DD hh24:mi:ss') ",
                           "   FROM asli201_imaa_tmp LEFT JOIN asli201_pmaa_tmp ON 1=1 ",
                           "                         LEFT JOIN asli201_ooef_tmp ON 1=1, ",
                           "        (SELECT oocq002,oocql004 FROM oocq_t LEFT JOIN oocql_t ON oocqlent=oocqent AND oocql001='2148' ",
                           "            AND oocql002=oocq002 AND oocqstus = 'Y' AND oocql003='",g_dlang,"' ",
                           "          WHERE oocqent=",g_enterprise," AND oocq001='2148' AND ",l_xmjd010_str,") t1, ",
                           "        (SELECT oocq002,oocql004 FROM oocq_t LEFT JOIN oocql_t ON oocqlent=oocqent AND oocql001='2149' ",
                           "            AND oocql002=oocq002 AND oocqstus = 'Y' AND oocql003='",g_dlang,"' ",
                           "          WHERE oocqent=",g_enterprise," AND oocq001='2149' AND ",l_xmjd012_str,") t2 ",                           
                           "  WHERE 1=1 "
         END CASE
         PREPARE upd_xmjd_tmp FROM l_sql
         EXECUTE upd_xmjd_tmp
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "merge xmjd_tmp" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT DIALOG
         END IF
         IF SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = '-100'
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CONTINUE DIALOG
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "sub-00033"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         CALL asli201_tmp_fill()
#         CALL s_transaction_end('Y','0')
#         CALL asli201_data_ins_tmp('d')

      ON ACTION batch_execute
         IF l_optype_2 = '4' THEN
            LET l_amount = 0
            DISPLAY l_amount TO amount
         END IF
         LET l_time = cl_get_current()
         IF NOT cl_ask_confirm('asl-00011') THEN
            CONTINUE DIALOG
         END IF
         CALL s_transaction_begin()
         #更新主画面
         LET l_sql = " MERGE INTO xmjd_t t1 ",
                     " USING (SELECT t2.xmjdent, t2.xmjdsite, t2.xmjd001, t2.xmjd002, t2.xmjd003, t2.xmjd004, ",
                     "               t2.xmjd005, t2.xmjd006, t2.xmjd007, t2.xmjd008, t2.xmjd009, t2.xmjd010, ",
                     "               t2.xmjd011, t2.xmjd012, t2.xmjd013, t2.xmjd014, t2.xmjd015, t2.xmjd016, ",
                     "               t2.xmjd018, t2.xmjd019, t2.xmjd020, t2.xmjd021, t2.xmjd022, t2.xmjd023, ",
                     "               t2.xmjd024, t2.xmjd025, t2.xmjd026, t2.xmjd027, t2.xmjd028, t2.xmjd029, ",
                     "               t2.xmjd030, t2.xmjd031, t2.xmjd017, t2.xmjdstus, ",
                     "               t2.xmjdownid, t2.xmjdowndp, t2.xmjdcrtid, ",
                     "               t2.xmjdcrtdp, t2.xmjdcrtdt ",
                     "          FROM asli201_xmjd_tmp t2) t2 ",
                     "    ON (t1.xmjdent=t2.xmjdent AND t1.xmjd001=t2.xmjd001 AND t1.xmjd002=t2.xmjd002 AND t1.xmjd003=t2.xmjd003 AND ",
                     "        t1.xmjd004=t2.xmjd004 AND t1.xmjd008=t2.xmjd008 AND t1.xmjd010=t2.xmjd010 AND t1.xmjd012=t2.xmjd012) ",
                     "  WHEN NOT MATCHED THEN ",
                     " INSERT (t1.xmjdent, t1.xmjdsite, t1.xmjd001, t1.xmjd002, t1.xmjd003, t1.xmjd004, t1.xmjd005, t1.xmjd006, t1.xmjd007, ",
                     "         t1.xmjd008, t1.xmjd009, t1.xmjd010, t1.xmjd011, t1.xmjd012, t1.xmjd013, t1.xmjd014, t1.xmjd015, t1.xmjd016, t1.xmjd017, ",
                     "         t1.xmjd018, t1.xmjd019, t1.xmjd020, t1.xmjd021, t1.xmjd022, t1.xmjd023, t1.xmjd024, t1.xmjd025, t1.xmjd026, t1.xmjd027, ",
                     "         t1.xmjd028, t1.xmjd029, t1.xmjd030, t1.xmjd031, t1.xmjdstus, ",
                     "         t1.xmjdownid, t1.xmjdowndp, t1.xmjdcrtid, t1.xmjdcrtdp, t1.xmjdcrtdt) ",
                     " VALUES (t2.xmjdent, t2.xmjdsite, t2.xmjd001, t2.xmjd002, t2.xmjd003, t2.xmjd004, t2.xmjd005, t2.xmjd006, t2.xmjd007, ",
                     "         t2.xmjd008, t2.xmjd009, t2.xmjd010, t2.xmjd011, t2.xmjd012, t2.xmjd013, t2.xmjd014, t2.xmjd015, t2.xmjd016, '1', ",
                     "         t2.xmjd018, t2.xmjd019, t2.xmjd020, t2.xmjd021, t2.xmjd022, t2.xmjd023, t2.xmjd024, t2.xmjd025, t2.xmjd026, t2.xmjd027, ",
                     "         t2.xmjd028, t2.xmjd029, t2.xmjd030, t2.xmjd031, 'Y', ",
                     "         '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',to_date('",l_time,"','YYYY-MM-DD hh24:mi:ss')) ",   
                     "  WHEN MATCHED THEN ",
                     " UPDATE SET t1.xmjd015 = t2.xmjd015,t1.xmjd016 = t2.xmjd016 "
         PREPARE upd_xmjd_pre FROM l_sql
         EXECUTE upd_xmjd_pre
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "merge xmjd" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            EXIT DIALOG
         END IF
         
         #删除调整量为0且订单号为空的记录
         LET l_sql = " DELETE FROM xmjd_t t1 WHERE t1.xmjdent = ",g_enterprise," ",
                     "    AND EXISTS (SELECT 1 FROM asli201_xmjd_tmp t2 ",
                     "                 WHERE t2.xmjdent=t1.xmjdent AND t2.xmjd001=t1.xmjd001 ",
                     "                   AND t2.xmjd002=t1.xmjd002 AND t2.xmjd003=t1.xmjd003 ",
                     "                   AND t2.xmjd004=t1.xmjd004 AND t2.xmjd008=t1.xmjd008 ",
                     "                   AND t2.xmjd010=t1.xmjd010 AND t2.xmjd012=t1.xmjd012 ",
                     "                   AND t2.xmjd007 IS NULL AND t2.xmjd015=0) "
         PREPARE del_xmjd_pre2 FROM l_sql
         EXECUTE del_xmjd_pre2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "del xmjd" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            EXIT DIALOG
         END IF
         CALL s_transaction_end('Y','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "sub-00033"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         ACCEPT DIALOG
      
      ON ACTION CANCEL
      
         EXIT DIALOG
         
      ON ACTION close
      
         EXIT DIALOG
       
      ON ACTION exit
      
         EXIT DIALOG
      
      
   END DIALOG
      
   CALL asli201_data_ins_tmp('d')
   #畫面關閉
   CLOSE WINDOW w_asli201_s02
   
END FUNCTION

################################################################################
# Descriptions...: 临时表资料显示
# Memo...........:
# Usage..........: CALL asli201_tmp_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_tmp_fill()
DEFINE l_sql        STRING

   CALL g_xmjd_d2.clear()
   
   LET l_sql = " SELECT xmjd001,xmjd002,xmjd003,xmjd004,xmjd005,xmjd006,xmjd007, ",
               "        xmjd008,imaal003,xmjd020,xmjd021,xmjd022,xmjd023,xmjd024, ",
               "        xmjd025,xmjd026,xmjd027,xmjd028,xmjd029,xmjd030,xmjd031, ",
               "        xmjd009,xmjd010,xmjd011,xmjd012,xmjd013,xmjd014,xmjd015,xmjd016 ",
               "   FROM asli201_xmjd_tmp ",
               "   LEFT JOIN imaal_t ON imaalent=xmjdent AND imaal001=xmjd008 AND imaal002='",g_dlang,"' ",
               "  WHERE xmjdent = ",g_enterprise," "
   PREPARE sel_xmjd_pre FROM l_sql
   DECLARE sel_xmjd_cs  CURSOR FOR sel_xmjd_pre
   LET l_ac2 = 1
   FOREACH sel_xmjd_cs  INTO g_xmjd_d2[l_ac2].b_xmjd001,g_xmjd_d2[l_ac2].b_xmjd002,g_xmjd_d2[l_ac2].b_xmjd003,g_xmjd_d2[l_ac2].b_xmjd004,
                             g_xmjd_d2[l_ac2].b_xmjd005,g_xmjd_d2[l_ac2].b_xmjd006,g_xmjd_d2[l_ac2].b_xmjd007,g_xmjd_d2[l_ac2].b_xmjd008,
                             g_xmjd_d2[l_ac2].b_xmjd008_desc,g_xmjd_d2[l_ac2].b_xmjd020,g_xmjd_d2[l_ac2].b_xmjd021,g_xmjd_d2[l_ac2].b_xmjd022,
                             g_xmjd_d2[l_ac2].b_xmjd023,g_xmjd_d2[l_ac2].b_xmjd024,g_xmjd_d2[l_ac2].b_xmjd025,g_xmjd_d2[l_ac2].b_xmjd026,
                             g_xmjd_d2[l_ac2].b_xmjd027,g_xmjd_d2[l_ac2].b_xmjd028,g_xmjd_d2[l_ac2].b_xmjd029,g_xmjd_d2[l_ac2].b_xmjd030,
                             g_xmjd_d2[l_ac2].b_xmjd031,g_xmjd_d2[l_ac2].b_xmjd009,g_xmjd_d2[l_ac2].b_xmjd010,g_xmjd_d2[l_ac2].b_xmjd011,
                             g_xmjd_d2[l_ac2].b_xmjd012,g_xmjd_d2[l_ac2].b_xmjd013,g_xmjd_d2[l_ac2].b_xmjd014,g_xmjd_d2[l_ac2].b_xmjd015,
                             g_xmjd_d2[l_ac2].b_xmjd016
                             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF                          
                
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF 

      LET l_ac2 = l_ac2 + 1
   END FOREACH
   
   CALL g_xmjd_d2.deleteElement(g_xmjd_d2.getLength())
   
   IF g_detail_idx2 > g_xmjd_d2.getLength() THEN
      LET g_detail_idx2 = g_xmjd_d2.getLength()
   END IF
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   DISPLAY g_xmjd_d2.getLength() TO FORMONLY.cnt
   
END FUNCTION

################################################################################
# Descriptions...: 整批处理栏位显示/隐藏
# Memo...........:
# Usage..........: CALL asli201_batch_visible(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_batch_visible(p_type)
DEFINE p_type        LIKE type_t.chr5

   CALL cl_set_comp_visible("xmjd001_2,xmjd002_2,xmjd003_2,xmjd004_2,xmjd008_2,xmjd010_2,xmjd012_2",TRUE)   
   CALL cl_set_comp_visible("b_xmjd006,b_xmjd007,b_xmjd014",TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 整批处理栏位隐藏
# Memo...........:
# Usage..........: CALL asli201_batch_no_visible(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_batch_no_visible(p_type)
DEFINE p_type        LIKE type_t.chr5

   
   IF p_type = "ins" THEN
      CALL cl_set_comp_visible("b_xmjd006,b_xmjd007,b_xmjd014",FALSE)
      CALL cl_set_combo_scc_part('optype_2','6962','5') 
   END IF
   
   IF p_type = "upd" THEN
      CALL cl_set_comp_visible("xmjd001_2,xmjd002_2,xmjd003_2,xmjd004_2,xmjd008_2,xmjd010_2,xmjd012_2",FALSE)
      CALL cl_set_combo_scc_part('optype_2','6962','1,2,3,4') 
   END IF
   
   CALL cl_set_comp_visible("b_xmjd006",FALSE)
   
END FUNCTION

################################################################################
# Descriptions...: 料号带值
# Memo...........:
# Usage..........: CALL asli201_xmjd008_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asli201_xmjd008_ref()
DEFINE l_sql        STRING
   
   LET l_sql = " SELECT imaa157,t1.oocql004,t2.oocql004,t3.oocql004,t4.oocql004, ",
               "        to_char(imaa158,'YYYY-MM-DD'),gzcbl004,t5.oocql004,t6.rtaxl003,t7.rtaxl003, ",
               "        t8.oocql004,imaa130 ",
               "   FROM imaa_t LEFT JOIN oocql_t t1 ON t1.oocqlent=imaaent AND t1.oocql001='2002' AND t1.oocql002=imaa126 AND t1.oocql003='",g_dlang,"' ",
               "               LEFT JOIN oocql_t t2 ON t2.oocqlent=imaaent AND t2.oocql001='2003' AND t2.oocql002=imaa127 AND t2.oocql003='",g_dlang,"' ",
               "               LEFT JOIN oocql_t t3 ON t3.oocqlent=imaaent AND t3.oocql001='2008' AND t3.oocql002=imaa134 AND t3.oocql003='",g_dlang,"' ",
               "               LEFT JOIN oocql_t t4 ON t4.oocqlent=imaaent AND t4.oocql001='2007' AND t4.oocql002=imaa133 AND t4.oocql003='",g_dlang,"' ",
               "               LEFT JOIN gzcbl_t ON gzcbl001='6941' AND gzcbl002=imaa156 AND gzcbl003='",g_dlang,"' ",
               "               LEFT JOIN oocql_t t5 ON t5.oocqlent=imaaent AND t5.oocql001='2006' AND t5.oocql002=imaa132 AND t5.oocql003='",g_dlang,"' ",
               "               LEFT JOIN rtaxl_t t7 ON t7.rtaxlent=imaaent AND t7.rtaxl001=imaa009 AND t7.rtaxl002='",g_dlang,"' ",
               "               LEFT JOIN oocql_t t8 ON t8.oocqlent=imaaent AND t8.oocql001='2001' AND t8.oocql002=imaa131 AND t8.oocql003='",g_dlang,"', ",
               "        rtax_t LEFT JOIN rtaxl_t t6 ON t6.rtaxlent=rtaxent AND t6.rtaxl001=rtax006 AND t6.rtaxl002='",g_dlang,"' ",
               "  WHERE imaaent=",g_enterprise," ",
               "    AND imaaent = rtaxent AND imaa009 = rtax001 ",
               "    AND imaa001 = '",g_xmjd_d[l_ac].xmjd008,"' "
   PREPARE sel_imaa_pre FROM l_sql
   EXECUTE sel_imaa_pre INTO g_xmjd_d[l_ac].xmjd009,g_xmjd_d[l_ac].xmjd020,g_xmjd_d[l_ac].xmjd021,g_xmjd_d[l_ac].xmjd022,
                             g_xmjd_d[l_ac].xmjd023,g_xmjd_d[l_ac].xmjd024,g_xmjd_d[l_ac].xmjd025,g_xmjd_d[l_ac].xmjd026,
                             g_xmjd_d[l_ac].xmjd027,g_xmjd_d[l_ac].xmjd028,g_xmjd_d[l_ac].xmjd030,g_xmjd_d[l_ac].xmjd031
   

END FUNCTION

 
{</section>}
 
