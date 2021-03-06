#該程式未解開Section, 採用最新樣板產出!
{<section id="arti040.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-03-27 16:26:21), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: arti040
#+ Description: 備用品牌資料維護作業
#+ Creator....: 02159(2015-03-26 09:17:37)
#+ Modifier...: 02159 -SD/PR- 00000
 
{</section>}
 
{<section id="arti040.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
# Modify......: NO.160318-00025#33   2016/04/13   By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
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
PRIVATE TYPE type_g_rtdl_d RECORD
       rtdlstus LIKE rtdl_t.rtdlstus, 
   rtdl001 LIKE rtdl_t.rtdl001, 
   rtdll003 LIKE rtdll_t.rtdll003, 
   rtdll004 LIKE rtdll_t.rtdll004, 
   rtdl021 LIKE rtdl_t.rtdl021, 
   rtdl002 LIKE rtdl_t.rtdl002, 
   rtdl002_desc LIKE type_t.chr500, 
   rtdl003 LIKE rtdl_t.rtdl003, 
   rtdl003_desc LIKE type_t.chr500, 
   rtdl004 LIKE rtdl_t.rtdl004, 
   rtdl004_desc LIKE type_t.chr500, 
   rtdl005 LIKE rtdl_t.rtdl005, 
   rtdl005_desc LIKE type_t.chr500, 
   rtdl006 LIKE rtdl_t.rtdl006, 
   rtdl006_desc LIKE type_t.chr500, 
   rtdl007 LIKE rtdl_t.rtdl007, 
   rtdl007_desc LIKE type_t.chr500, 
   rtdl008 LIKE rtdl_t.rtdl008, 
   rtdl008_desc LIKE type_t.chr500, 
   rtdl009 LIKE rtdl_t.rtdl009, 
   rtdl009_desc LIKE type_t.chr500, 
   rtdl010 LIKE rtdl_t.rtdl010, 
   rtdl011 LIKE rtdl_t.rtdl011, 
   rtdl012 LIKE rtdl_t.rtdl012, 
   rtdl013 LIKE rtdl_t.rtdl013, 
   rtdl014 LIKE rtdl_t.rtdl014, 
   rtdl014_desc LIKE type_t.chr500, 
   rtdl015 LIKE rtdl_t.rtdl015, 
   rtdl016 LIKE rtdl_t.rtdl016, 
   rtdl017 LIKE rtdl_t.rtdl017, 
   rtdl017_desc LIKE type_t.chr500, 
   rtdl018 LIKE rtdl_t.rtdl018, 
   rtdl018_desc LIKE type_t.chr500, 
   rtdl019 LIKE rtdl_t.rtdl019, 
   rtdl019_desc LIKE type_t.chr500, 
   rtdl020 LIKE rtdl_t.rtdl020, 
   rtdl025 LIKE rtdl_t.rtdl025, 
   rtdl026 LIKE rtdl_t.rtdl026, 
   rtdl027 LIKE rtdl_t.rtdl027, 
   rtdl028 LIKE rtdl_t.rtdl028, 
   rtdl022 LIKE rtdl_t.rtdl022, 
   rtdl023 LIKE rtdl_t.rtdl023, 
   rtdl023_desc LIKE type_t.chr500, 
   rtdl024 LIKE rtdl_t.rtdl024, 
   rtdl024_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_rtdl2_d RECORD
       rtdl001 LIKE rtdl_t.rtdl001, 
   rtdlownid LIKE rtdl_t.rtdlownid, 
   rtdlownid_desc LIKE type_t.chr500, 
   rtdlowndp LIKE rtdl_t.rtdlowndp, 
   rtdlowndp_desc LIKE type_t.chr500, 
   rtdlcrtid LIKE rtdl_t.rtdlcrtid, 
   rtdlcrtid_desc LIKE type_t.chr500, 
   rtdlcrtdp LIKE rtdl_t.rtdlcrtdp, 
   rtdlcrtdp_desc LIKE type_t.chr500, 
   rtdlcrtdt DATETIME YEAR TO SECOND, 
   rtdlmodid LIKE rtdl_t.rtdlmodid, 
   rtdlmodid_desc LIKE type_t.chr500, 
   rtdlmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      rtdll001 LIKE rtdll_t.rtdll001,
      rtdll002 LIKE rtdll_t.rtdll002,
      rtdll003 LIKE rtdll_t.rtdll003,
      rtdll004 LIKE rtdll_t.rtdll004
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rtdl003_acc      LIKE type_t.chr10 #品牌屬性
DEFINE g_rtdl004_acc      LIKE type_t.chr10 #品牌價位
DEFINE g_rtdl005_acc      LIKE type_t.chr10 #經營能力
DEFINE g_rtdl006_acc      LIKE type_t.chr10 #品牌集團
DEFINE g_rtdl007_acc      LIKE type_t.chr10 #經營能力
DEFINE g_rtdl008_acc      LIKE type_t.chr10 #品牌集團
DEFINE g_rtdl009_acc      LIKE type_t.chr10 #品牌性質
DEFINE g_rtdl010_acc      LIKE type_t.chr10 #品牌風格
DEFINE g_rtdl011_acc      LIKE type_t.chr10 #品牌檔次
DEFINE g_oocq001_acc      LIKE type_t.chr10 #商品-品牌
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtdl_d          DYNAMIC ARRAY OF type_g_rtdl_d #單身變數
DEFINE g_rtdl_d_t        type_g_rtdl_d                  #單身備份
DEFINE g_rtdl_d_o        type_g_rtdl_d                  #單身備份
DEFINE g_rtdl_d_mask_o   DYNAMIC ARRAY OF type_g_rtdl_d #單身變數
DEFINE g_rtdl_d_mask_n   DYNAMIC ARRAY OF type_g_rtdl_d #單身變數
DEFINE g_rtdl2_d   DYNAMIC ARRAY OF type_g_rtdl2_d
DEFINE g_rtdl2_d_t type_g_rtdl2_d
DEFINE g_rtdl2_d_o type_g_rtdl2_d
DEFINE g_rtdl2_d_mask_o DYNAMIC ARRAY OF type_g_rtdl2_d
DEFINE g_rtdl2_d_mask_n DYNAMIC ARRAY OF type_g_rtdl2_d
 
      
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
 
{<section id="arti040.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
    CALL s_aooi390_cre_tmp_table() RETURNING l_success #add--2015/12/10 By dengdd
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtdlstus,rtdl001,rtdl021,rtdl002,rtdl003,rtdl004,rtdl005,rtdl006,rtdl007, 
       rtdl008,rtdl009,rtdl010,rtdl011,rtdl012,rtdl013,rtdl014,rtdl015,rtdl016,rtdl017,rtdl018,rtdl019, 
       rtdl020,rtdl025,rtdl026,rtdl027,rtdl028,rtdl022,rtdl023,rtdl024,rtdl001,rtdlownid,rtdlowndp,rtdlcrtid, 
       rtdlcrtdp,rtdlcrtdt,rtdlmodid,rtdlmoddt FROM rtdl_t WHERE rtdlent=? AND rtdl001=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE arti040_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_arti040 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL arti040_init()   
 
      #進入選單 Menu (="N")
      CALL arti040_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_arti040
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/12/10 By dengdd
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="arti040.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION arti040_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
 
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
      CALL cl_set_combo_scc('rtdl020','6771') 
 
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1 #校驗皆要彈出視窗
   #ACC代碼
   LET g_rtdl003_acc = '2119' #品牌屬性
   LET g_rtdl004_acc = '2120' #品牌價位
   LET g_rtdl005_acc = '2121' #經營能力
   LET g_rtdl006_acc = '2122' #品牌集團
   LET g_rtdl007_acc = '2123' #品牌性質
   LET g_rtdl008_acc = '2124' #品牌風格
   LET g_rtdl009_acc = '2125' #品牌檔次
   LET g_oocq001_acc = '2002' #商品-品牌
   #end add-point
   
   CALL arti040_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="arti040.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION arti040_ui_dialog()
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
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_colname_1            STRING
   DEFINE l_comment_1            STRING   
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
         CALL g_rtdl_d.clear()
         CALL g_rtdl2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL arti040_init()
      END IF
   
      CALL arti040_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtdl_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_rtdl2_d[g_detail_idx].rtdlownid   #(ver:35)
               LET g_data_dept = g_rtdl2_d[g_detail_idx].rtdlowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL arti040_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_oocq
            LET g_action_choice="update_oocq"
            IF cl_auth_chk_act("update_oocq") THEN
               
               #add-point:ON ACTION update_oocq name="menu.detail_show.page1.update_oocq"
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               CALL s_azzi902_get_gzzd("arti040","lbl_rtdl001") RETURNING l_colname_1, l_comment_1
               LET g_coll_title[1] = l_colname_1 #品牌編號
               
               IF g_detail_idx >= 1 AND NOT cl_null(g_detail_idx) THEN
                  #詢問是否將備用品牌的資料拋轉至正式品牌資料檔
                  IF cl_ask_confirm('art-00510') THEN
                     #判斷選取的筆數
                     FOR li_idx = 1 TO g_rtdl_d.getLength()
                         IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                            IF g_rtdl_d[li_idx].rtdl021 = 'N' AND g_rtdl_d[li_idx].rtdlstus = 'Y' THEN
                               CALL arti040_upd_oocq(li_idx) RETURNING l_success
                            ELSE
                               INITIALIZE g_errparam TO NULL
                               LET g_errparam.code = 'art-00512'
                               LET g_errparam.extend = ""
                               LET g_errparam.popup = TRUE
                               LET g_errparam.coll_vals[1] = g_rtdl_d[li_idx].rtdl001
                               CALL cl_err()                               
                            END IF
                         END IF
                     END FOR
                     IF NOT l_success THEN
                        CALL cl_err_collect_show()
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL arti040_b_fill(g_wc2)
                        CALL cl_err_collect_show()
                        CALL s_transaction_end('Y','0')
                     END IF                     
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
         END DISPLAY
      
         DISPLAY ARRAY g_rtdl2_d TO s_detail2.*
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
   CALL arti040_set_pk_array()
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
            CALL arti040_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti040_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL arti040_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti040_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL arti040_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL arti040_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL arti040_insert()
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
               CALL arti040_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_rtdl_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtdl2_d)
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
            CALL arti040_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL arti040_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL arti040_set_pk_array()
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
 
{<section id="arti040.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION arti040_query()
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
   CALL g_rtdl_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON rtdlstus,rtdl001,rtdll003,rtdll004,rtdl021,rtdl002,rtdl003,rtdl004,rtdl005, 
          rtdl006,rtdl007,rtdl008,rtdl009,rtdl010,rtdl011,rtdl012,rtdl013,rtdl014,rtdl015,rtdl016,rtdl017, 
          rtdl018,rtdl019,rtdl020,rtdl025,rtdl026,rtdl027,rtdl028,rtdl022,rtdl023,rtdl024,rtdlownid, 
          rtdlowndp,rtdlcrtid,rtdlcrtdp,rtdlcrtdt,rtdlmodid,rtdlmoddt 
 
         FROM s_detail1[1].rtdlstus,s_detail1[1].rtdl001,s_detail1[1].rtdll003,s_detail1[1].rtdll004, 
             s_detail1[1].rtdl021,s_detail1[1].rtdl002,s_detail1[1].rtdl003,s_detail1[1].rtdl004,s_detail1[1].rtdl005, 
             s_detail1[1].rtdl006,s_detail1[1].rtdl007,s_detail1[1].rtdl008,s_detail1[1].rtdl009,s_detail1[1].rtdl010, 
             s_detail1[1].rtdl011,s_detail1[1].rtdl012,s_detail1[1].rtdl013,s_detail1[1].rtdl014,s_detail1[1].rtdl015, 
             s_detail1[1].rtdl016,s_detail1[1].rtdl017,s_detail1[1].rtdl018,s_detail1[1].rtdl019,s_detail1[1].rtdl020, 
             s_detail1[1].rtdl025,s_detail1[1].rtdl026,s_detail1[1].rtdl027,s_detail1[1].rtdl028,s_detail1[1].rtdl022, 
             s_detail1[1].rtdl023,s_detail1[1].rtdl024,s_detail2[1].rtdlownid,s_detail2[1].rtdlowndp, 
             s_detail2[1].rtdlcrtid,s_detail2[1].rtdlcrtdp,s_detail2[1].rtdlcrtdt,s_detail2[1].rtdlmodid, 
             s_detail2[1].rtdlmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdlcrtdt>>----
         AFTER FIELD rtdlcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdlmoddt>>----
         AFTER FIELD rtdlmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdlcnfdt>>----
         
         #----<<rtdlpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlstus
            #add-point:BEFORE FIELD rtdlstus name="query.b.page1.rtdlstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlstus
            
            #add-point:AFTER FIELD rtdlstus name="query.a.page1.rtdlstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdlstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlstus
            #add-point:ON ACTION controlp INFIELD rtdlstus name="query.c.page1.rtdlstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl001
            #add-point:ON ACTION controlp INFIELD rtdl001 name="construct.c.page1.rtdl001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtdl001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl001  #顯示到畫面上
            NEXT FIELD rtdl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl001
            #add-point:BEFORE FIELD rtdl001 name="query.b.page1.rtdl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl001
            
            #add-point:AFTER FIELD rtdl001 name="query.a.page1.rtdl001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdll003
            #add-point:BEFORE FIELD rtdll003 name="query.b.page1.rtdll003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdll003
            
            #add-point:AFTER FIELD rtdll003 name="query.a.page1.rtdll003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdll003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdll003
            #add-point:ON ACTION controlp INFIELD rtdll003 name="query.c.page1.rtdll003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdll004
            #add-point:BEFORE FIELD rtdll004 name="query.b.page1.rtdll004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdll004
            
            #add-point:AFTER FIELD rtdll004 name="query.a.page1.rtdll004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdll004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdll004
            #add-point:ON ACTION controlp INFIELD rtdll004 name="query.c.page1.rtdll004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl021
            #add-point:BEFORE FIELD rtdl021 name="query.b.page1.rtdl021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl021
            
            #add-point:AFTER FIELD rtdl021 name="query.a.page1.rtdl021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl021
            #add-point:ON ACTION controlp INFIELD rtdl021 name="query.c.page1.rtdl021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl002
            #add-point:ON ACTION controlp INFIELD rtdl002 name="construct.c.page1.rtdl002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl002  #顯示到畫面上
            NEXT FIELD rtdl002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl002
            #add-point:BEFORE FIELD rtdl002 name="query.b.page1.rtdl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl002
            
            #add-point:AFTER FIELD rtdl002 name="query.a.page1.rtdl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl003
            #add-point:ON ACTION controlp INFIELD rtdl003 name="construct.c.page1.rtdl003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl003_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl003  #顯示到畫面上
            NEXT FIELD rtdl003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl003
            #add-point:BEFORE FIELD rtdl003 name="query.b.page1.rtdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl003
            
            #add-point:AFTER FIELD rtdl003 name="query.a.page1.rtdl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl004
            #add-point:ON ACTION controlp INFIELD rtdl004 name="construct.c.page1.rtdl004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl004_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl004  #顯示到畫面上
            NEXT FIELD rtdl004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl004
            #add-point:BEFORE FIELD rtdl004 name="query.b.page1.rtdl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl004
            
            #add-point:AFTER FIELD rtdl004 name="query.a.page1.rtdl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl005
            #add-point:ON ACTION controlp INFIELD rtdl005 name="construct.c.page1.rtdl005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl005_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl005  #顯示到畫面上
            NEXT FIELD rtdl005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl005
            #add-point:BEFORE FIELD rtdl005 name="query.b.page1.rtdl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl005
            
            #add-point:AFTER FIELD rtdl005 name="query.a.page1.rtdl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl006
            #add-point:ON ACTION controlp INFIELD rtdl006 name="construct.c.page1.rtdl006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl006_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl006  #顯示到畫面上
            NEXT FIELD rtdl006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl006
            #add-point:BEFORE FIELD rtdl006 name="query.b.page1.rtdl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl006
            
            #add-point:AFTER FIELD rtdl006 name="query.a.page1.rtdl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl007
            #add-point:ON ACTION controlp INFIELD rtdl007 name="construct.c.page1.rtdl007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl007_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl007  #顯示到畫面上
            NEXT FIELD rtdl007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl007
            #add-point:BEFORE FIELD rtdl007 name="query.b.page1.rtdl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl007
            
            #add-point:AFTER FIELD rtdl007 name="query.a.page1.rtdl007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl008
            #add-point:ON ACTION controlp INFIELD rtdl008 name="construct.c.page1.rtdl008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl008_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl008  #顯示到畫面上
            NEXT FIELD rtdl008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl008
            #add-point:BEFORE FIELD rtdl008 name="query.b.page1.rtdl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl008
            
            #add-point:AFTER FIELD rtdl008 name="query.a.page1.rtdl008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl009
            #add-point:ON ACTION controlp INFIELD rtdl009 name="construct.c.page1.rtdl009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl009_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl009  #顯示到畫面上
            NEXT FIELD rtdl009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl009
            #add-point:BEFORE FIELD rtdl009 name="query.b.page1.rtdl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl009
            
            #add-point:AFTER FIELD rtdl009 name="query.a.page1.rtdl009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl010
            #add-point:BEFORE FIELD rtdl010 name="query.b.page1.rtdl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl010
            
            #add-point:AFTER FIELD rtdl010 name="query.a.page1.rtdl010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl010
            #add-point:ON ACTION controlp INFIELD rtdl010 name="query.c.page1.rtdl010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl011
            #add-point:BEFORE FIELD rtdl011 name="query.b.page1.rtdl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl011
            
            #add-point:AFTER FIELD rtdl011 name="query.a.page1.rtdl011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl011
            #add-point:ON ACTION controlp INFIELD rtdl011 name="query.c.page1.rtdl011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl012
            #add-point:BEFORE FIELD rtdl012 name="query.b.page1.rtdl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl012
            
            #add-point:AFTER FIELD rtdl012 name="query.a.page1.rtdl012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl012
            #add-point:ON ACTION controlp INFIELD rtdl012 name="query.c.page1.rtdl012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl013
            #add-point:BEFORE FIELD rtdl013 name="query.b.page1.rtdl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl013
            
            #add-point:AFTER FIELD rtdl013 name="query.a.page1.rtdl013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl013
            #add-point:ON ACTION controlp INFIELD rtdl013 name="query.c.page1.rtdl013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl014
            #add-point:ON ACTION controlp INFIELD rtdl014 name="construct.c.page1.rtdl014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl014  #顯示到畫面上
            NEXT FIELD rtdl014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl014
            #add-point:BEFORE FIELD rtdl014 name="query.b.page1.rtdl014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl014
            
            #add-point:AFTER FIELD rtdl014 name="query.a.page1.rtdl014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl015
            #add-point:BEFORE FIELD rtdl015 name="query.b.page1.rtdl015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl015
            
            #add-point:AFTER FIELD rtdl015 name="query.a.page1.rtdl015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl015
            #add-point:ON ACTION controlp INFIELD rtdl015 name="query.c.page1.rtdl015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl016
            #add-point:BEFORE FIELD rtdl016 name="query.b.page1.rtdl016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl016
            
            #add-point:AFTER FIELD rtdl016 name="query.a.page1.rtdl016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl016
            #add-point:ON ACTION controlp INFIELD rtdl016 name="query.c.page1.rtdl016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdl017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl017
            #add-point:ON ACTION controlp INFIELD rtdl017 name="construct.c.page1.rtdl017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl017  #顯示到畫面上
            NEXT FIELD rtdl017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl017
            #add-point:BEFORE FIELD rtdl017 name="query.b.page1.rtdl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl017
            
            #add-point:AFTER FIELD rtdl017 name="query.a.page1.rtdl017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl018
            #add-point:ON ACTION controlp INFIELD rtdl018 name="construct.c.page1.rtdl018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtdl_d[l_ac].rtdl016
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl018  #顯示到畫面上
            NEXT FIELD rtdl018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl018
            #add-point:BEFORE FIELD rtdl018 name="query.b.page1.rtdl018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl018
            
            #add-point:AFTER FIELD rtdl018 name="query.a.page1.rtdl018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl019
            #add-point:ON ACTION controlp INFIELD rtdl019 name="construct.c.page1.rtdl019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl019  #顯示到畫面上
            NEXT FIELD rtdl019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl019
            #add-point:BEFORE FIELD rtdl019 name="query.b.page1.rtdl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl019
            
            #add-point:AFTER FIELD rtdl019 name="query.a.page1.rtdl019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl020
            #add-point:BEFORE FIELD rtdl020 name="query.b.page1.rtdl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl020
            
            #add-point:AFTER FIELD rtdl020 name="query.a.page1.rtdl020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl020
            #add-point:ON ACTION controlp INFIELD rtdl020 name="query.c.page1.rtdl020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl025
            #add-point:BEFORE FIELD rtdl025 name="query.b.page1.rtdl025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl025
            
            #add-point:AFTER FIELD rtdl025 name="query.a.page1.rtdl025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl025
            #add-point:ON ACTION controlp INFIELD rtdl025 name="query.c.page1.rtdl025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl026
            #add-point:BEFORE FIELD rtdl026 name="query.b.page1.rtdl026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl026
            
            #add-point:AFTER FIELD rtdl026 name="query.a.page1.rtdl026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl026
            #add-point:ON ACTION controlp INFIELD rtdl026 name="query.c.page1.rtdl026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl027
            #add-point:BEFORE FIELD rtdl027 name="query.b.page1.rtdl027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl027
            
            #add-point:AFTER FIELD rtdl027 name="query.a.page1.rtdl027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl027
            #add-point:ON ACTION controlp INFIELD rtdl027 name="query.c.page1.rtdl027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl028
            #add-point:BEFORE FIELD rtdl028 name="query.b.page1.rtdl028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl028
            
            #add-point:AFTER FIELD rtdl028 name="query.a.page1.rtdl028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl028
            #add-point:ON ACTION controlp INFIELD rtdl028 name="query.c.page1.rtdl028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl022
            #add-point:BEFORE FIELD rtdl022 name="query.b.page1.rtdl022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl022
            
            #add-point:AFTER FIELD rtdl022 name="query.a.page1.rtdl022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.rtdl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl022
            #add-point:ON ACTION controlp INFIELD rtdl022 name="query.c.page1.rtdl022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtdl023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl023
            #add-point:ON ACTION controlp INFIELD rtdl023 name="construct.c.page1.rtdl023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl023  #顯示到畫面上
            NEXT FIELD rtdl023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl023
            #add-point:BEFORE FIELD rtdl023 name="query.b.page1.rtdl023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl023
            
            #add-point:AFTER FIELD rtdl023 name="query.a.page1.rtdl023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtdl024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl024
            #add-point:ON ACTION controlp INFIELD rtdl024 name="construct.c.page1.rtdl024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdl024  #顯示到畫面上
            NEXT FIELD rtdl024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl024
            #add-point:BEFORE FIELD rtdl024 name="query.b.page1.rtdl024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl024
            
            #add-point:AFTER FIELD rtdl024 name="query.a.page1.rtdl024"
            
            #END add-point
            
 
 
  
         
                  #Ctrlp:construct.c.page2.rtdlownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlownid
            #add-point:ON ACTION controlp INFIELD rtdlownid name="construct.c.page2.rtdlownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdlownid  #顯示到畫面上
            NEXT FIELD rtdlownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlownid
            #add-point:BEFORE FIELD rtdlownid name="query.b.page2.rtdlownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlownid
            
            #add-point:AFTER FIELD rtdlownid name="query.a.page2.rtdlownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdlowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlowndp
            #add-point:ON ACTION controlp INFIELD rtdlowndp name="construct.c.page2.rtdlowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdlowndp  #顯示到畫面上
            NEXT FIELD rtdlowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlowndp
            #add-point:BEFORE FIELD rtdlowndp name="query.b.page2.rtdlowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlowndp
            
            #add-point:AFTER FIELD rtdlowndp name="query.a.page2.rtdlowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdlcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlcrtid
            #add-point:ON ACTION controlp INFIELD rtdlcrtid name="construct.c.page2.rtdlcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdlcrtid  #顯示到畫面上
            NEXT FIELD rtdlcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlcrtid
            #add-point:BEFORE FIELD rtdlcrtid name="query.b.page2.rtdlcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlcrtid
            
            #add-point:AFTER FIELD rtdlcrtid name="query.a.page2.rtdlcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtdlcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlcrtdp
            #add-point:ON ACTION controlp INFIELD rtdlcrtdp name="construct.c.page2.rtdlcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdlcrtdp  #顯示到畫面上
            NEXT FIELD rtdlcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlcrtdp
            #add-point:BEFORE FIELD rtdlcrtdp name="query.b.page2.rtdlcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlcrtdp
            
            #add-point:AFTER FIELD rtdlcrtdp name="query.a.page2.rtdlcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlcrtdt
            #add-point:BEFORE FIELD rtdlcrtdt name="query.b.page2.rtdlcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtdlmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlmodid
            #add-point:ON ACTION controlp INFIELD rtdlmodid name="construct.c.page2.rtdlmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtdlmodid  #顯示到畫面上
            NEXT FIELD rtdlmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlmodid
            #add-point:BEFORE FIELD rtdlmodid name="query.b.page2.rtdlmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlmodid
            
            #add-point:AFTER FIELD rtdlmodid name="query.a.page2.rtdlmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlmoddt
            #add-point:BEFORE FIELD rtdlmoddt name="query.b.page2.rtdlmoddt"
            
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
    
   CALL arti040_b_fill(g_wc2)
   LET g_data_owner = g_rtdl2_d[g_detail_idx].rtdlownid   #(ver:35)
   LET g_data_dept = g_rtdl2_d[g_detail_idx].rtdlowndp   #(ver:35)
 
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
 
{<section id="arti040.insert" >}
#+ 資料新增
PRIVATE FUNCTION arti040_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL arti040_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti040.modify" >}
#+ 資料修改
PRIVATE FUNCTION arti040_modify()
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
   DEFINE l_set_curr              LIKE type_t.num5
   #add--2015/12/10 By dengdd--(S)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_n1                  LIKE type_t.num5
   #add--2015/12/10 By dengdd--(E)
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
      INPUT ARRAY g_rtdl_d FROM s_detail1.*
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
               IF NOT cl_null(g_rtdl_d[l_ac].rtdl001)  THEN
                  CALL n_rtdll(g_rtdl_d[l_ac].rtdl001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtdl_d[l_ac].rtdl001
                  CALL ap_ref_array2(g_ref_fields," SELECT rtdll003,rtdll004 FROM rtdll_t WHERE rtdllent = '"||g_enterprise||"' AND rtdll001 = ? AND rtdll002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
                  LET g_rtdl_d[l_ac].rtdll003 = g_rtn_fields[1] 
                  LET g_rtdl_d[l_ac].rtdll004 = g_rtn_fields[2] 
                  DISPLAY g_rtdl_d[l_ac].rtdll003,g_rtdl_d[l_ac].rtdll004 TO rtdll003,rtdll004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdl_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL arti040_b_fill(g_wc2)
            LET g_detail_cnt = g_rtdl_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            CALL arti040_chk_rtdl021(l_ac_t) RETURNING l_set_curr
            LET l_ac = l_set_curr
            LET g_detail_idx = l_ac
            CALL fgl_set_arr_curr(l_ac)
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_rtdl_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtdl_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtdl_d[l_ac].rtdl001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtdl_d_t.* = g_rtdl_d[l_ac].*  #BACKUP
               LET g_rtdl_d_o.* = g_rtdl_d[l_ac].*  #BACKUP
               IF NOT arti040_lock_b("rtdl_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH arti040_bcl INTO g_rtdl_d[l_ac].rtdlstus,g_rtdl_d[l_ac].rtdl001,g_rtdl_d[l_ac].rtdl021, 
                      g_rtdl_d[l_ac].rtdl002,g_rtdl_d[l_ac].rtdl003,g_rtdl_d[l_ac].rtdl004,g_rtdl_d[l_ac].rtdl005, 
                      g_rtdl_d[l_ac].rtdl006,g_rtdl_d[l_ac].rtdl007,g_rtdl_d[l_ac].rtdl008,g_rtdl_d[l_ac].rtdl009, 
                      g_rtdl_d[l_ac].rtdl010,g_rtdl_d[l_ac].rtdl011,g_rtdl_d[l_ac].rtdl012,g_rtdl_d[l_ac].rtdl013, 
                      g_rtdl_d[l_ac].rtdl014,g_rtdl_d[l_ac].rtdl015,g_rtdl_d[l_ac].rtdl016,g_rtdl_d[l_ac].rtdl017, 
                      g_rtdl_d[l_ac].rtdl018,g_rtdl_d[l_ac].rtdl019,g_rtdl_d[l_ac].rtdl020,g_rtdl_d[l_ac].rtdl025, 
                      g_rtdl_d[l_ac].rtdl026,g_rtdl_d[l_ac].rtdl027,g_rtdl_d[l_ac].rtdl028,g_rtdl_d[l_ac].rtdl022, 
                      g_rtdl_d[l_ac].rtdl023,g_rtdl_d[l_ac].rtdl024,g_rtdl2_d[l_ac].rtdl001,g_rtdl2_d[l_ac].rtdlownid, 
                      g_rtdl2_d[l_ac].rtdlowndp,g_rtdl2_d[l_ac].rtdlcrtid,g_rtdl2_d[l_ac].rtdlcrtdp, 
                      g_rtdl2_d[l_ac].rtdlcrtdt,g_rtdl2_d[l_ac].rtdlmodid,g_rtdl2_d[l_ac].rtdlmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtdl_d_t.rtdl001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtdl_d_mask_o[l_ac].* =  g_rtdl_d[l_ac].*
                  CALL arti040_rtdl_t_mask()
                  LET g_rtdl_d_mask_n[l_ac].* =  g_rtdl_d[l_ac].*
                  
                  CALL arti040_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL arti040_set_entry_b(l_cmd)
            CALL arti040_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.rtdll001 = g_rtdl_d[l_ac].rtdl001
LET g_detail_multi_table_t.rtdll002 = g_dlang
LET g_detail_multi_table_t.rtdll003 = g_rtdl_d[l_ac].rtdll003
LET g_detail_multi_table_t.rtdll004 = g_rtdl_d[l_ac].rtdll004
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rtdllent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rtdll001'
            LET l_var_keys[02] = g_rtdl_d[l_ac].rtdl001
            LET l_field_keys[03] = 'rtdll002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rtdll_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtdl_d_t.* TO NULL
            INITIALIZE g_rtdl_d_o.* TO NULL
            INITIALIZE g_rtdl_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtdl2_d[l_ac].rtdlownid = g_user
      LET g_rtdl2_d[l_ac].rtdlowndp = g_dept
      LET g_rtdl2_d[l_ac].rtdlcrtid = g_user
      LET g_rtdl2_d[l_ac].rtdlcrtdp = g_dept 
      LET g_rtdl2_d[l_ac].rtdlcrtdt = cl_get_current()
      LET g_rtdl2_d[l_ac].rtdlmodid = g_user
      LET g_rtdl2_d[l_ac].rtdlmoddt = cl_get_current()
      LET g_rtdl_d[l_ac].rtdlstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_rtdl_d[l_ac].rtdlstus = "Y"
      LET g_rtdl_d[l_ac].rtdl021 = "N"
      LET g_rtdl_d[l_ac].rtdl010 = "N"
      LET g_rtdl_d[l_ac].rtdl015 = "N"
      LET g_rtdl_d[l_ac].rtdl020 = "2"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            #開發日期
            LET g_rtdl_d[l_ac].rtdl016 = g_today
            
            #開發人員
            LET g_rtdl_d[l_ac].rtdl017 = g_user
            CALL s_desc_get_person_desc(g_rtdl_d[l_ac].rtdl017) RETURNING g_rtdl_d[l_ac].rtdl017_desc

            #開發部門
            LET g_rtdl_d[l_ac].rtdl018 = g_dept
            CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl018) RETURNING g_rtdl_d[l_ac].rtdl018_desc
            
			   #開發組織
            LET g_rtdl_d[l_ac].rtdl019 = g_site
            CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl019) RETURNING g_rtdl_d[l_ac].rtdl019_desc
            
            #end add-point
            LET g_rtdl_d_t.* = g_rtdl_d[l_ac].*     #新輸入資料
            LET g_rtdl_d_o.* = g_rtdl_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtdl_d[li_reproduce_target].* = g_rtdl_d[li_reproduce].*
               LET g_rtdl2_d[li_reproduce_target].* = g_rtdl2_d[li_reproduce].*
 
               LET g_rtdl_d[g_rtdl_d.getLength()].rtdl001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.rtdll001 = g_rtdl_d[l_ac].rtdl001
LET g_detail_multi_table_t.rtdll002 = g_dlang
LET g_detail_multi_table_t.rtdll003 = g_rtdl_d[l_ac].rtdll003
LET g_detail_multi_table_t.rtdll004 = g_rtdl_d[l_ac].rtdll004
 
 
            CALL arti040_set_entry_b(l_cmd)
            CALL arti040_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            #add by dengdd 151210(S)
            IF l_cmd = 'a' THEN
               SELECT COUNT(*) INTO l_n1
                 FROM oofg_t
                WHERE oofgent = g_enterprise
                  AND oofg002 = '32'
                  AND oofgstus = 'Y'
               IF l_n1 > 0 THEN
                  CALL s_aooi390_gen('32') RETURNING l_success,g_rtdl_d[l_ac].rtdl001,l_oofg_return
                  DISPLAY BY NAME g_rtdl_d[l_ac].rtdl001
               END IF
            END IF
            #add by dengdd 151210(E)
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
            SELECT COUNT(1) INTO l_count FROM rtdl_t 
             WHERE rtdlent = g_enterprise AND rtdl001 = g_rtdl_d[l_ac].rtdl001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               #add--2015/12/10 By dengdd--(S)
               CALL s_aooi390_get_auto_no('32',g_rtdl_d[l_ac].rtdl001) RETURNING l_success,g_rtdl_d[l_ac].rtdl001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF   
               DISPLAY BY NAME g_rtdl_d[l_ac].rtdl001             
               CALL s_aooi390_oofi_upd('32',g_rtdl_d[l_ac].rtdl001) RETURNING l_success
               #add--2015/12/10 By dengdd--(E)
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdl_d[g_detail_idx].rtdl001
               CALL arti040_insert_b('rtdl_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtdl_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rtdl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL arti040_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtdl_d[l_ac].rtdl001 = g_detail_multi_table_t.rtdll001 AND
         g_rtdl_d[l_ac].rtdll003 = g_detail_multi_table_t.rtdll003 AND
         g_rtdl_d[l_ac].rtdll004 = g_detail_multi_table_t.rtdll004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtdllent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtdl_d[l_ac].rtdl001
            LET l_field_keys[02] = 'rtdll001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdll001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtdll002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdll002
            LET l_vars[01] = g_rtdl_d[l_ac].rtdll003
            LET l_fields[01] = 'rtdll003'
            LET l_vars[02] = g_rtdl_d[l_ac].rtdll004
            LET l_fields[02] = 'rtdll004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdll_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (rtdl001 = '", g_rtdl_d[l_ac].rtdl001, "' "
 
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
               
               DELETE FROM rtdl_t
                WHERE rtdlent = g_enterprise AND 
                      rtdl001 = g_rtdl_d_t.rtdl001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtdl_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtdllent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtdll001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdll001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtdll_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL arti040_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_rtdl_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE arti040_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_rtdl_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdl_d_t.rtdl001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti040_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL arti040_delete_b('rtdl_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_rtdl_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdlstus
            #add-point:BEFORE FIELD rtdlstus name="input.b.page1.rtdlstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdlstus
            
            #add-point:AFTER FIELD rtdlstus name="input.a.page1.rtdlstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdlstus
            #add-point:ON CHANGE rtdlstus name="input.g.page1.rtdlstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl001
            #add-point:BEFORE FIELD rtdl001 name="input.b.page1.rtdl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl001
            
            #add-point:AFTER FIELD rtdl001 name="input.a.page1.rtdl001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            #IF  g_rtdl_d[g_detail_idx].rtdl001 IS NOT NULL THEN 
            #   IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdl_d[g_detail_idx].rtdl001 != g_rtdl_d_t.rtdl001)) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdl_t WHERE "||"rtdlent = '" ||g_enterprise|| "' AND "||"rtdl001 = '"||g_rtdl_d[g_detail_idx].rtdl001 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl001) THEN 
               IF g_rtdl_d[l_ac].rtdl001 != g_rtdl_d_o.rtdl001 OR cl_null(g_rtdl_d_o.rtdl001) THEN                                            
                  IF NOT arti040_rtdl001_chk() THEN
                     LET g_rtdl_d[l_ac].rtdl001 = g_rtdl_d_o.rtdl001
                     NEXT FIELD rtdl001                   
                  END IF               
               END IF
               #add--2015/12/10 By dengdd--(S)
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdl_d[l_ac].rtdl001 != g_rtdl_d_o.rtdl001 )) THEN
                  IF NOT s_aooi390_chk('32',g_rtdl_d[l_ac].rtdl001) THEN
                     LET g_rtdl_d[l_ac].rtdl001 = g_rtdl_d_o.rtdl001
                     DISPLAY BY NAME g_rtdl_d[l_ac].rtdl001
                     NEXT FIELD CURRENT
                  END IF   
               END IF
               #add--2015/12/10 By dengdd--(E)
            END IF 
            LET g_rtdl_d_o.rtdl001 = g_rtdl_d[l_ac].rtdl001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl001
            #add-point:ON CHANGE rtdl001 name="input.g.page1.rtdl001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdll003
            #add-point:BEFORE FIELD rtdll003 name="input.b.page1.rtdll003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdll003
            
            #add-point:AFTER FIELD rtdll003 name="input.a.page1.rtdll003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdll003
            #add-point:ON CHANGE rtdll003 name="input.g.page1.rtdll003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdll004
            #add-point:BEFORE FIELD rtdll004 name="input.b.page1.rtdll004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdll004
            
            #add-point:AFTER FIELD rtdll004 name="input.a.page1.rtdll004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdll004
            #add-point:ON CHANGE rtdll004 name="input.g.page1.rtdll004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl021
            #add-point:BEFORE FIELD rtdl021 name="input.b.page1.rtdl021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl021
            
            #add-point:AFTER FIELD rtdl021 name="input.a.page1.rtdl021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl021
            #add-point:ON CHANGE rtdl021 name="input.g.page1.rtdl021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl002
            
            #add-point:AFTER FIELD rtdl002 name="input.a.page1.rtdl002"
            LET g_rtdl_d[l_ac].rtdl002_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl002) THEN
　　　　　　　　IF g_rtdl_d[l_ac].rtdl002 != g_rtdl_d_o.rtdl002 OR cl_null(g_rtdl_d_o.rtdl002) THEN　            
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtdl_d[l_ac].rtdl002
                   IF NOT cl_chk_exist("v_rtax001_1") THEN
                     LET g_rtdl_d[l_ac].rtdl002 = g_rtdl_d_o.rtdl002
                     CALL s_desc_get_rtaxl003_desc(g_rtdl_d[l_ac].rtdl002) 
                          RETURNING g_rtdl_d[l_ac].rtdl002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtdl_d_o.rtdl002 = g_rtdl_d[l_ac].rtdl002          
            CALL s_desc_get_rtaxl003_desc(g_rtdl_d[l_ac].rtdl002) 
                 RETURNING g_rtdl_d[l_ac].rtdl002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl002
            #add-point:BEFORE FIELD rtdl002 name="input.b.page1.rtdl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl002
            #add-point:ON CHANGE rtdl002 name="input.g.page1.rtdl002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl003
            
            #add-point:AFTER FIELD rtdl003 name="input.a.page1.rtdl003"
            LET g_rtdl_d[l_ac].rtdl003_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl003) THEN
               IF g_rtdl_d[l_ac].rtdl003 != g_rtdl_d_o.rtdl003 OR cl_null(g_rtdl_d_o.rtdl003) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl003_acc,g_rtdl_d[l_ac].rtdl003) THEN
                     LET g_rtdl_d[l_ac].rtdl003 = g_rtdl_d_o.rtdl003
                     CALL s_desc_get_acc_desc(g_rtdl003_acc,g_rtdl_d[l_ac].rtdl003)
                        RETURNING g_rtdl_d[l_ac].rtdl003_desc
                     NEXT FIELD rtdl003
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl003 = g_rtdl_d[l_ac].rtdl003
               CALL s_desc_get_acc_desc(g_rtdl003_acc,g_rtdl_d[l_ac].rtdl003)
                  RETURNING g_rtdl_d[l_ac].rtdl003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl003
            #add-point:BEFORE FIELD rtdl003 name="input.b.page1.rtdl003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl003
            #add-point:ON CHANGE rtdl003 name="input.g.page1.rtdl003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl004
            
            #add-point:AFTER FIELD rtdl004 name="input.a.page1.rtdl004"
            LET g_rtdl_d[l_ac].rtdl004_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl004) THEN
               IF g_rtdl_d[l_ac].rtdl004 != g_rtdl_d_o.rtdl004 OR cl_null(g_rtdl_d_o.rtdl004) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl004_acc,g_rtdl_d[l_ac].rtdl004) THEN
                     LET g_rtdl_d[l_ac].rtdl004 = g_rtdl_d_o.rtdl004
                     CALL s_desc_get_acc_desc(g_rtdl004_acc,g_rtdl_d[l_ac].rtdl004)
                        RETURNING g_rtdl_d[l_ac].rtdl004_desc
                     NEXT FIELD rtdl004
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl004 = g_rtdl_d[l_ac].rtdl004
            CALL s_desc_get_acc_desc(g_rtdl004_acc,g_rtdl_d[l_ac].rtdl004)
                 RETURNING g_rtdl_d[l_ac].rtdl004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl004
            #add-point:BEFORE FIELD rtdl004 name="input.b.page1.rtdl004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl004
            #add-point:ON CHANGE rtdl004 name="input.g.page1.rtdl004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl005
            
            #add-point:AFTER FIELD rtdl005 name="input.a.page1.rtdl005"
            LET g_rtdl_d[l_ac].rtdl005_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl005) THEN
               IF g_rtdl_d[l_ac].rtdl005 != g_rtdl_d_o.rtdl005 OR cl_null(g_rtdl_d_o.rtdl005) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl005_acc,g_rtdl_d[l_ac].rtdl005) THEN
                     LET g_rtdl_d[l_ac].rtdl005 = g_rtdl_d_o.rtdl005
                     CALL s_desc_get_acc_desc(g_rtdl005_acc,g_rtdl_d[l_ac].rtdl005)
                        RETURNING g_rtdl_d[l_ac].rtdl005_desc
                     NEXT FIELD rtdl005
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl005 = g_rtdl_d[l_ac].rtdl005
            CALL s_desc_get_acc_desc(g_rtdl005_acc,g_rtdl_d[l_ac].rtdl005)
                 RETURNING g_rtdl_d[l_ac].rtdl005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl005
            #add-point:BEFORE FIELD rtdl005 name="input.b.page1.rtdl005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl005
            #add-point:ON CHANGE rtdl005 name="input.g.page1.rtdl005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl006
            
            #add-point:AFTER FIELD rtdl006 name="input.a.page1.rtdl006"
            LET g_rtdl_d[l_ac].rtdl006_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl006) THEN
               IF g_rtdl_d[l_ac].rtdl006 != g_rtdl_d_o.rtdl006 OR cl_null(g_rtdl_d_o.rtdl006) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl006_acc,g_rtdl_d[l_ac].rtdl006) THEN
                     LET g_rtdl_d[l_ac].rtdl006 = g_rtdl_d_o.rtdl006
                     CALL s_desc_get_acc_desc(g_rtdl006_acc,g_rtdl_d[l_ac].rtdl006)
                        RETURNING g_rtdl_d[l_ac].rtdl006_desc
                     NEXT FIELD rtdl006
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl006 = g_rtdl_d[l_ac].rtdl006
               CALL s_desc_get_acc_desc(g_rtdl006_acc,g_rtdl_d[l_ac].rtdl006)
                  RETURNING g_rtdl_d[l_ac].rtdl006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl006
            #add-point:BEFORE FIELD rtdl006 name="input.b.page1.rtdl006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl006
            #add-point:ON CHANGE rtdl006 name="input.g.page1.rtdl006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl007
            
            #add-point:AFTER FIELD rtdl007 name="input.a.page1.rtdl007"
            LET g_rtdl_d[l_ac].rtdl007_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl007) THEN
               IF g_rtdl_d[l_ac].rtdl007 != g_rtdl_d_o.rtdl007 OR cl_null(g_rtdl_d_o.rtdl007) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl007_acc,g_rtdl_d[l_ac].rtdl007) THEN
                     LET g_rtdl_d[l_ac].rtdl007 = g_rtdl_d_o.rtdl007
                     CALL s_desc_get_acc_desc(g_rtdl007_acc,g_rtdl_d[l_ac].rtdl007)
                        RETURNING g_rtdl_d[l_ac].rtdl007_desc
                     NEXT FIELD rtdl007
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl007 = g_rtdl_d[l_ac].rtdl007
            CALL s_desc_get_acc_desc(g_rtdl007_acc,g_rtdl_d[l_ac].rtdl007)
                 RETURNING g_rtdl_d[l_ac].rtdl007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl007
            #add-point:BEFORE FIELD rtdl007 name="input.b.page1.rtdl007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl007
            #add-point:ON CHANGE rtdl007 name="input.g.page1.rtdl007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl008
            
            #add-point:AFTER FIELD rtdl008 name="input.a.page1.rtdl008"
            LET g_rtdl_d[l_ac].rtdl008_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl008) THEN
               IF g_rtdl_d[l_ac].rtdl008 != g_rtdl_d_o.rtdl008 OR cl_null(g_rtdl_d_o.rtdl008) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl008_acc,g_rtdl_d[l_ac].rtdl008) THEN
                     LET g_rtdl_d[l_ac].rtdl008 = g_rtdl_d_o.rtdl008
                     CALL s_desc_get_acc_desc(g_rtdl008_acc,g_rtdl_d[l_ac].rtdl008)
                        RETURNING g_rtdl_d[l_ac].rtdl008_desc
                     NEXT FIELD rtdl008
                  END IF
               END IF
			    END IF
			    LET g_rtdl_d_o.rtdl008 = g_rtdl_d[l_ac].rtdl008
             CALL s_desc_get_acc_desc(g_rtdl008_acc,g_rtdl_d[l_ac].rtdl008)
                  RETURNING g_rtdl_d[l_ac].rtdl008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl008
            #add-point:BEFORE FIELD rtdl008 name="input.b.page1.rtdl008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl008
            #add-point:ON CHANGE rtdl008 name="input.g.page1.rtdl008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl009
            
            #add-point:AFTER FIELD rtdl009 name="input.a.page1.rtdl009"
            LET g_rtdl_d[l_ac].rtdl009_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl009) THEN
               IF g_rtdl_d[l_ac].rtdl009 != g_rtdl_d_o.rtdl009 OR cl_null(g_rtdl_d_o.rtdl009) THEN
                  IF NOT s_azzi650_chk_exist(g_rtdl009_acc,g_rtdl_d[l_ac].rtdl009) THEN
                     LET g_rtdl_d[l_ac].rtdl009 = g_rtdl_d_o.rtdl009
                     CALL s_desc_get_acc_desc(g_rtdl009_acc,g_rtdl_d[l_ac].rtdl009)
                        RETURNING g_rtdl_d[l_ac].rtdl009_desc
                     NEXT FIELD rtdl009
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl009 = g_rtdl_d[l_ac].rtdl009
            CALL s_desc_get_acc_desc(g_rtdl009_acc,g_rtdl_d[l_ac].rtdl009)
                 RETURNING g_rtdl_d[l_ac].rtdl009_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl009
            #add-point:BEFORE FIELD rtdl009 name="input.b.page1.rtdl009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl009
            #add-point:ON CHANGE rtdl009 name="input.g.page1.rtdl009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl010
            #add-point:BEFORE FIELD rtdl010 name="input.b.page1.rtdl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl010
            
            #add-point:AFTER FIELD rtdl010 name="input.a.page1.rtdl010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl010
            #add-point:ON CHANGE rtdl010 name="input.g.page1.rtdl010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl011
            #add-point:BEFORE FIELD rtdl011 name="input.b.page1.rtdl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl011
            
            #add-point:AFTER FIELD rtdl011 name="input.a.page1.rtdl011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl011
            #add-point:ON CHANGE rtdl011 name="input.g.page1.rtdl011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtdl_d[l_ac].rtdl012,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD rtdl012
            END IF 
 
 
 
            #add-point:AFTER FIELD rtdl012 name="input.a.page1.rtdl012"
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl012
            #add-point:BEFORE FIELD rtdl012 name="input.b.page1.rtdl012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl012
            #add-point:ON CHANGE rtdl012 name="input.g.page1.rtdl012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl013
            #add-point:BEFORE FIELD rtdl013 name="input.b.page1.rtdl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl013
            
            #add-point:AFTER FIELD rtdl013 name="input.a.page1.rtdl013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl013
            #add-point:ON CHANGE rtdl013 name="input.g.page1.rtdl013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl014
            
            #add-point:AFTER FIELD rtdl014 name="input.a.page1.rtdl014"
            LET g_rtdl_d[l_ac].rtdl014_desc = ' '
            IF NOT cl_null(g_rtdl_d[l_ac].rtdl014) THEN
               IF g_rtdl_d[l_ac].rtdl014 != g_rtdl_d_o.rtdl014 OR cl_null(g_rtdl_d_o.rtdl014) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtdl_d[l_ac].rtdl014			   
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_rtdl_d[l_ac].rtdl014 = g_rtdl_d_o.rtdl014
                     CALL s_desc_get_trading_partner_abbr_desc(g_rtdl_d[l_ac].rtdl014) 
					           RETURNING g_rtdl_d[l_ac].rtdl014_desc
                     NEXT FIELD rtdl014
                  END IF
               END IF
			   END IF
			   LET g_rtdl_d_o.rtdl014 = g_rtdl_d[l_ac].rtdl014
            CALL s_desc_get_trading_partner_abbr_desc(g_rtdl_d[l_ac].rtdl014) 
                 RETURNING g_rtdl_d[l_ac].rtdl014_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl014
            #add-point:BEFORE FIELD rtdl014 name="input.b.page1.rtdl014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl014
            #add-point:ON CHANGE rtdl014 name="input.g.page1.rtdl014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl015
            #add-point:BEFORE FIELD rtdl015 name="input.b.page1.rtdl015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl015
            
            #add-point:AFTER FIELD rtdl015 name="input.a.page1.rtdl015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl015
            #add-point:ON CHANGE rtdl015 name="input.g.page1.rtdl015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl016
            #add-point:BEFORE FIELD rtdl016 name="input.b.page1.rtdl016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl016
            
            #add-point:AFTER FIELD rtdl016 name="input.a.page1.rtdl016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl016
            #add-point:ON CHANGE rtdl016 name="input.g.page1.rtdl016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl017
            
            #add-point:AFTER FIELD rtdl017 name="input.a.page1.rtdl017"
            LET g_rtdl_d[l_ac].rtdl017_desc = ' '
			   IF NOT cl_null(g_rtdl_d[l_ac].rtdl017) THEN 
               IF g_rtdl_d[l_ac].rtdl017 != g_rtdl_d_o.rtdl017 OR cl_null(g_rtdl_d_o.rtdl017) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtdl_d[l_ac].rtdl017
                  #160318-00025#33   2016/04/13   By 07959  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#33   2016/04/13   By 07959  add(E)
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_rtdl_d[l_ac].rtdl017 = g_rtdl_d_o.rtdl017
                     CALL s_desc_get_person_desc(g_rtdl_d[l_ac].rtdl017) 
                          RETURNING g_rtdl_d[l_ac].rtdl017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtdl_d_o.rtdl017 = g_rtdl_d[l_ac].rtdl017			
            CALL s_desc_get_person_desc(g_rtdl_d[l_ac].rtdl017) 
                 RETURNING g_rtdl_d[l_ac].rtdl017_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl017
            #add-point:BEFORE FIELD rtdl017 name="input.b.page1.rtdl017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl017
            #add-point:ON CHANGE rtdl017 name="input.g.page1.rtdl017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl018
            
            #add-point:AFTER FIELD rtdl018 name="input.a.page1.rtdl018"
            LET g_rtdl_d[l_ac].rtdl018_desc = ' '
			   IF NOT cl_null(g_rtdl_d[l_ac].rtdl018) THEN 
               IF g_rtdl_d[l_ac].rtdl018 != g_rtdl_d_o.rtdl018 OR cl_null(g_rtdl_d_o.rtdl018) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtdl_d[l_ac].rtdl018
				      LET g_chkparam.arg2 = g_rtdl_d[l_ac].rtdl016
				      #160318-00025#33   2016/04/13   By 07959  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#33   2016/04/13   By 07959  add(E)
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_rtdl_d[l_ac].rtdl018 = g_rtdl_d_o.rtdl018
                     CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl018) RETURNING g_rtdl_d[l_ac].rtdl018_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtdl_d_o.rtdl018 = g_rtdl_d[l_ac].rtdl018			
            CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl018) 
			        RETURNING g_rtdl_d[l_ac].rtdl018_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl018
            #add-point:BEFORE FIELD rtdl018 name="input.b.page1.rtdl018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl018
            #add-point:ON CHANGE rtdl018 name="input.g.page1.rtdl018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl019
            
            #add-point:AFTER FIELD rtdl019 name="input.a.page1.rtdl019"
            LET g_rtdl_d[l_ac].rtdl019_desc = ' '
			    IF NOT cl_null(g_rtdl_d[l_ac].rtdl019) THEN 
                IF g_rtdl_d[l_ac].rtdl019 != g_rtdl_d_o.rtdl019 OR cl_null(g_rtdl_d_o.rtdl019) THEN
                   INITIALIZE g_chkparam.* TO NULL
                   LET g_chkparam.arg1 = g_rtdl_d[l_ac].rtdl019
                   #160318-00025#33   2016/04/13   By 07959  add(S)
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                   #160318-00025#33   2016/04/13   By 07959  add(E)
                   IF NOT cl_chk_exist("v_ooef001") THEN
                      LET g_rtdl_d[l_ac].rtdl019 = g_rtdl_d_o.rtdl019
                      CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl019)
                           RETURNING g_rtdl_d[l_ac].rtdl019_desc
                      NEXT FIELD CURRENT
                   END IF
                END IF
            END IF
            LET g_rtdl_d_o.rtdl019 = g_rtdl_d[l_ac].rtdl019			
            CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl019)
                 RETURNING g_rtdl_d[l_ac].rtdl019_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl019
            #add-point:BEFORE FIELD rtdl019 name="input.b.page1.rtdl019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl019
            #add-point:ON CHANGE rtdl019 name="input.g.page1.rtdl019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl020
            #add-point:BEFORE FIELD rtdl020 name="input.b.page1.rtdl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl020
            
            #add-point:AFTER FIELD rtdl020 name="input.a.page1.rtdl020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl020
            #add-point:ON CHANGE rtdl020 name="input.g.page1.rtdl020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl025
            #add-point:BEFORE FIELD rtdl025 name="input.b.page1.rtdl025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl025
            
            #add-point:AFTER FIELD rtdl025 name="input.a.page1.rtdl025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl025
            #add-point:ON CHANGE rtdl025 name="input.g.page1.rtdl025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl026
            #add-point:BEFORE FIELD rtdl026 name="input.b.page1.rtdl026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl026
            
            #add-point:AFTER FIELD rtdl026 name="input.a.page1.rtdl026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl026
            #add-point:ON CHANGE rtdl026 name="input.g.page1.rtdl026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl027
            #add-point:BEFORE FIELD rtdl027 name="input.b.page1.rtdl027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl027
            
            #add-point:AFTER FIELD rtdl027 name="input.a.page1.rtdl027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl027
            #add-point:ON CHANGE rtdl027 name="input.g.page1.rtdl027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl028
            #add-point:BEFORE FIELD rtdl028 name="input.b.page1.rtdl028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl028
            
            #add-point:AFTER FIELD rtdl028 name="input.a.page1.rtdl028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl028
            #add-point:ON CHANGE rtdl028 name="input.g.page1.rtdl028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl022
            #add-point:BEFORE FIELD rtdl022 name="input.b.page1.rtdl022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl022
            
            #add-point:AFTER FIELD rtdl022 name="input.a.page1.rtdl022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl022
            #add-point:ON CHANGE rtdl022 name="input.g.page1.rtdl022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl023
            
            #add-point:AFTER FIELD rtdl023 name="input.a.page1.rtdl023"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl023
            #add-point:BEFORE FIELD rtdl023 name="input.b.page1.rtdl023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl023
            #add-point:ON CHANGE rtdl023 name="input.g.page1.rtdl023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtdl024
            
            #add-point:AFTER FIELD rtdl024 name="input.a.page1.rtdl024"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtdl024
            #add-point:BEFORE FIELD rtdl024 name="input.b.page1.rtdl024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtdl024
            #add-point:ON CHANGE rtdl024 name="input.g.page1.rtdl024"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtdlstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdlstus
            #add-point:ON ACTION controlp INFIELD rtdlstus name="input.c.page1.rtdlstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl001
            #add-point:ON ACTION controlp INFIELD rtdl001 name="input.c.page1.rtdl001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdll003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdll003
            #add-point:ON ACTION controlp INFIELD rtdll003 name="input.c.page1.rtdll003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdll004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdll004
            #add-point:ON ACTION controlp INFIELD rtdll004 name="input.c.page1.rtdll004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl021
            #add-point:ON ACTION controlp INFIELD rtdl021 name="input.c.page1.rtdl021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl002
            #add-point:ON ACTION controlp INFIELD rtdl002 name="input.c.page1.rtdl002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl002             #給予default值
            CALL q_rtax001()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl002 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl002 TO rtdl002              #
            CALL s_desc_get_rtaxl003_desc( g_rtdl_d[l_ac].rtdl002) 
                 RETURNING  g_rtdl_d[l_ac].rtdl002_desc
            NEXT FIELD rtdl002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl003
            #add-point:ON ACTION controlp INFIELD rtdl003 name="input.c.page1.rtdl003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl003             #給予default值
            LET g_qryparam.arg1 = g_rtdl003_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl003 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl003 TO rtdl003
            CALL s_desc_get_acc_desc(g_rtdl003_acc,g_rtdl_d[l_ac].rtdl003) 
              RETURNING g_rtdl_d[l_ac].rtdl003_desc
            NEXT FIELD rtdl003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl004
            #add-point:ON ACTION controlp INFIELD rtdl004 name="input.c.page1.rtdl004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl004             #給予default值
            LET g_qryparam.arg1 = g_rtdl004_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl004 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl004 TO rtdl004
            CALL s_desc_get_acc_desc(g_rtdl004_acc,g_rtdl_d[l_ac].rtdl004) 
              RETURNING g_rtdl_d[l_ac].rtdl004_desc
            NEXT FIELD rtdl004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl005
            #add-point:ON ACTION controlp INFIELD rtdl005 name="input.c.page1.rtdl005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl005             #給予default值
            LET g_qryparam.arg1 = g_rtdl005_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl005 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl005 TO rtdl005
            CALL s_desc_get_acc_desc(g_rtdl005_acc,g_rtdl_d[l_ac].rtdl005) 
              RETURNING g_rtdl_d[l_ac].rtdl005_desc            
            NEXT FIELD rtdl005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl006
            #add-point:ON ACTION controlp INFIELD rtdl006 name="input.c.page1.rtdl006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl006             #給予default值
            LET g_qryparam.arg1 = g_rtdl006_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl006 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl006 TO rtdl006
            CALL s_desc_get_acc_desc(g_rtdl006_acc,g_rtdl_d[l_ac].rtdl006) 
              RETURNING g_rtdl_d[l_ac].rtdl006_desc            
            NEXT FIELD rtdl006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl007
            #add-point:ON ACTION controlp INFIELD rtdl007 name="input.c.page1.rtdl007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl007             #給予default值
            LET g_qryparam.arg1 = g_rtdl007_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl007 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl007 TO rtdl007
            CALL s_desc_get_acc_desc(g_rtdl007_acc,g_rtdl_d[l_ac].rtdl007) 
              RETURNING g_rtdl_d[l_ac].rtdl007_desc            
            NEXT FIELD rtdl007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl008
            #add-point:ON ACTION controlp INFIELD rtdl008 name="input.c.page1.rtdl008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl008             #給予default值
            LET g_qryparam.arg1 = g_rtdl008_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl008 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl008 TO rtdl008
            CALL s_desc_get_acc_desc(g_rtdl008_acc,g_rtdl_d[l_ac].rtdl008) 
              RETURNING g_rtdl_d[l_ac].rtdl008_desc            
            NEXT FIELD rtdl008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl009
            #add-point:ON ACTION controlp INFIELD rtdl009 name="input.c.page1.rtdl009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl009             #給予default值
            LET g_qryparam.arg1 = g_rtdl009_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl009 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl009 TO rtdl009
            CALL s_desc_get_acc_desc(g_rtdl009_acc,g_rtdl_d[l_ac].rtdl009) 
              RETURNING g_rtdl_d[l_ac].rtdl009_desc            
            NEXT FIELD rtdl009                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl010
            #add-point:ON ACTION controlp INFIELD rtdl010 name="input.c.page1.rtdl010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl011
            #add-point:ON ACTION controlp INFIELD rtdl011 name="input.c.page1.rtdl011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl012
            #add-point:ON ACTION controlp INFIELD rtdl012 name="input.c.page1.rtdl012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl013
            #add-point:ON ACTION controlp INFIELD rtdl013 name="input.c.page1.rtdl013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl014
            #add-point:ON ACTION controlp INFIELD rtdl014 name="input.c.page1.rtdl014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl014             #給予default值
            CALL q_pmaa001_3()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl014 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl014 TO rtdl014
            CALL s_desc_get_trading_partner_abbr_desc(g_rtdl_d[l_ac].rtdl014) 
                 RETURNING g_rtdl_d[l_ac].rtdl014_desc
            NEXT FIELD rtdl014                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl015
            #add-point:ON ACTION controlp INFIELD rtdl015 name="input.c.page1.rtdl015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl016
            #add-point:ON ACTION controlp INFIELD rtdl016 name="input.c.page1.rtdl016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl017
            #add-point:ON ACTION controlp INFIELD rtdl017 name="input.c.page1.rtdl017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl017             #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl017 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl017 TO rtdl017
            CALL s_desc_get_person_desc(g_rtdl_d[l_ac].rtdl017) 
                 RETURNING g_rtdl_d[l_ac].rtdl017_desc            
            NEXT FIELD rtdl017                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl018
            #add-point:ON ACTION controlp INFIELD rtdl018 name="input.c.page1.rtdl018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl018             #給予default值
            LET g_qryparam.arg1 = g_rtdl_d[l_ac].rtdl016
            CALL q_ooeg001_4()                                #呼叫開窗
            LET g_rtdl_d[l_ac].rtdl018 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl018 TO rtdl018
            CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl018) 
                 RETURNING g_rtdl_d[l_ac].rtdl018_desc
            NEXT FIELD rtdl018                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl019
            #add-point:ON ACTION controlp INFIELD rtdl019 name="input.c.page1.rtdl019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtdl_d[l_ac].rtdl019             #給予default值
             CALL q_ooef001()
            LET g_rtdl_d[l_ac].rtdl019 = g_qryparam.return1              
            DISPLAY g_rtdl_d[l_ac].rtdl019 TO rtdl019 
            CALL s_desc_get_department_desc(g_rtdl_d[l_ac].rtdl019) 
                 RETURNING g_rtdl_d[l_ac].rtdl019_desc
            NEXT FIELD rtdl019                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl020
            #add-point:ON ACTION controlp INFIELD rtdl020 name="input.c.page1.rtdl020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl025
            #add-point:ON ACTION controlp INFIELD rtdl025 name="input.c.page1.rtdl025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl026
            #add-point:ON ACTION controlp INFIELD rtdl026 name="input.c.page1.rtdl026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl027
            #add-point:ON ACTION controlp INFIELD rtdl027 name="input.c.page1.rtdl027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl028
            #add-point:ON ACTION controlp INFIELD rtdl028 name="input.c.page1.rtdl028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl022
            #add-point:ON ACTION controlp INFIELD rtdl022 name="input.c.page1.rtdl022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl023
            #add-point:ON ACTION controlp INFIELD rtdl023 name="input.c.page1.rtdl023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtdl024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtdl024
            #add-point:ON ACTION controlp INFIELD rtdl024 name="input.c.page1.rtdl024"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE arti040_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_rtdl_d[l_ac].* = g_rtdl_d_t.*
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
               LET g_errparam.extend = g_rtdl_d[l_ac].rtdl001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtdl_d[l_ac].* = g_rtdl_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_rtdl2_d[l_ac].rtdlmodid = g_user 
LET g_rtdl2_d[l_ac].rtdlmoddt = cl_get_current()
LET g_rtdl2_d[l_ac].rtdlmodid_desc = cl_get_username(g_rtdl2_d[l_ac].rtdlmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL arti040_rtdl_t_mask_restore('restore_mask_o')
 
               UPDATE rtdl_t SET (rtdlstus,rtdl001,rtdl021,rtdl002,rtdl003,rtdl004,rtdl005,rtdl006,rtdl007, 
                   rtdl008,rtdl009,rtdl010,rtdl011,rtdl012,rtdl013,rtdl014,rtdl015,rtdl016,rtdl017,rtdl018, 
                   rtdl019,rtdl020,rtdl025,rtdl026,rtdl027,rtdl028,rtdl022,rtdl023,rtdl024,rtdlownid, 
                   rtdlowndp,rtdlcrtid,rtdlcrtdp,rtdlcrtdt,rtdlmodid,rtdlmoddt) = (g_rtdl_d[l_ac].rtdlstus, 
                   g_rtdl_d[l_ac].rtdl001,g_rtdl_d[l_ac].rtdl021,g_rtdl_d[l_ac].rtdl002,g_rtdl_d[l_ac].rtdl003, 
                   g_rtdl_d[l_ac].rtdl004,g_rtdl_d[l_ac].rtdl005,g_rtdl_d[l_ac].rtdl006,g_rtdl_d[l_ac].rtdl007, 
                   g_rtdl_d[l_ac].rtdl008,g_rtdl_d[l_ac].rtdl009,g_rtdl_d[l_ac].rtdl010,g_rtdl_d[l_ac].rtdl011, 
                   g_rtdl_d[l_ac].rtdl012,g_rtdl_d[l_ac].rtdl013,g_rtdl_d[l_ac].rtdl014,g_rtdl_d[l_ac].rtdl015, 
                   g_rtdl_d[l_ac].rtdl016,g_rtdl_d[l_ac].rtdl017,g_rtdl_d[l_ac].rtdl018,g_rtdl_d[l_ac].rtdl019, 
                   g_rtdl_d[l_ac].rtdl020,g_rtdl_d[l_ac].rtdl025,g_rtdl_d[l_ac].rtdl026,g_rtdl_d[l_ac].rtdl027, 
                   g_rtdl_d[l_ac].rtdl028,g_rtdl_d[l_ac].rtdl022,g_rtdl_d[l_ac].rtdl023,g_rtdl_d[l_ac].rtdl024, 
                   g_rtdl2_d[l_ac].rtdlownid,g_rtdl2_d[l_ac].rtdlowndp,g_rtdl2_d[l_ac].rtdlcrtid,g_rtdl2_d[l_ac].rtdlcrtdp, 
                   g_rtdl2_d[l_ac].rtdlcrtdt,g_rtdl2_d[l_ac].rtdlmodid,g_rtdl2_d[l_ac].rtdlmoddt)
                WHERE rtdlent = g_enterprise AND
                  rtdl001 = g_rtdl_d_t.rtdl001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtdl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdl_d[g_detail_idx].rtdl001
               LET gs_keys_bak[1] = g_rtdl_d_t.rtdl001
               CALL arti040_update_b('rtdl_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtdl_d[l_ac].rtdl001 = g_detail_multi_table_t.rtdll001 AND
         g_rtdl_d[l_ac].rtdll003 = g_detail_multi_table_t.rtdll003 AND
         g_rtdl_d[l_ac].rtdll004 = g_detail_multi_table_t.rtdll004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtdllent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtdl_d[l_ac].rtdl001
            LET l_field_keys[02] = 'rtdll001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdll001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtdll002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtdll002
            LET l_vars[01] = g_rtdl_d[l_ac].rtdll003
            LET l_fields[01] = 'rtdll003'
            LET l_vars[02] = g_rtdl_d[l_ac].rtdll004
            LET l_fields[02] = 'rtdll004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtdll_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_rtdl_d_t)
                     LET g_log2 = util.JSON.stringify(g_rtdl_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL arti040_rtdl_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL arti040_unlock_b("rtdl_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtdl_d[l_ac].* = g_rtdl_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            CALL cl_multitable_unlock()
             #add-point:單身after row name="input.body.a_row"
             LET l_ac_t = l_ac
             IF l_ac > g_detail_cnt THEN
                CALL g_rtdl_d.deleteElement(l_ac)
             END IF
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
               LET g_rtdl_d[li_reproduce_target].* = g_rtdl_d[li_reproduce].*
               LET g_rtdl2_d[li_reproduce_target].* = g_rtdl2_d[li_reproduce].*
 
               LET g_rtdl_d[li_reproduce_target].rtdl001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtdl_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtdl_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_rtdl2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL arti040_b_fill(g_wc2)
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
               NEXT FIELD rtdlstus
            WHEN "s_detail2"
               NEXT FIELD rtdl001_2
 
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
      IF INT_FLAG OR cl_null(g_rtdl_d[g_detail_idx].rtdl001) THEN
         CALL g_rtdl_d.deleteElement(g_detail_idx)
         CALL g_rtdl2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_rtdl_d[g_detail_idx].* = g_rtdl_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE arti040_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="arti040.delete" >}
#+ 資料刪除
PRIVATE FUNCTION arti040_delete()
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
   IF g_rtdl_d[g_detail_idx].rtdl021 = 'Y' THEN
      RETURN
   END IF
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_rtdl_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT arti040_lock_b("rtdl_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("rtdl_t","rtdlownid") THEN
            LET g_data_owner = g_rtdl2_d[g_detail_idx].rtdlownid
            LET g_data_dept = g_rtdl2_d[g_detail_idx].rtdlowndp
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
   
   FOR li_idx = 1 TO g_rtdl_d.getLength()
      IF g_rtdl_d[li_idx].rtdl001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM rtdl_t
          WHERE rtdlent = g_enterprise AND 
                rtdl001 = g_rtdl_d[li_idx].rtdl001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.rtdll001 = g_rtdl_d[l_ac].rtdl001
LET g_detail_multi_table_t.rtdll002 = g_dlang
LET g_detail_multi_table_t.rtdll003 = g_rtdl_d[l_ac].rtdll003
LET g_detail_multi_table_t.rtdll004 = g_rtdl_d[l_ac].rtdll004
 
 
            
LET g_detail_multi_table_t.rtdll001 = g_rtdl_d[l_ac].rtdl001
LET g_detail_multi_table_t.rtdll002 = g_dlang
LET g_detail_multi_table_t.rtdll003 = g_rtdl_d[l_ac].rtdll003
LET g_detail_multi_table_t.rtdll004 = g_rtdl_d[l_ac].rtdll004
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtdllent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtdll001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdll001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtdll_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtdllent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtdll001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtdll001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtdll_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtdl_d_t.rtdl001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL arti040_delete_b('rtdl_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL arti040_set_pk_array()
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
   CALL arti040_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="arti040.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION arti040_b_fill(p_wc2)              #BODY FILL UP
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
 
   LET g_sql = "SELECT  DISTINCT t0.rtdlstus,t0.rtdl001,t0.rtdl021,t0.rtdl002,t0.rtdl003,t0.rtdl004, 
       t0.rtdl005,t0.rtdl006,t0.rtdl007,t0.rtdl008,t0.rtdl009,t0.rtdl010,t0.rtdl011,t0.rtdl012,t0.rtdl013, 
       t0.rtdl014,t0.rtdl015,t0.rtdl016,t0.rtdl017,t0.rtdl018,t0.rtdl019,t0.rtdl020,t0.rtdl025,t0.rtdl026, 
       t0.rtdl027,t0.rtdl028,t0.rtdl022,t0.rtdl023,t0.rtdl024,t0.rtdl001,t0.rtdlownid,t0.rtdlowndp,t0.rtdlcrtid, 
       t0.rtdlcrtdp,t0.rtdlcrtdt,t0.rtdlmodid,t0.rtdlmoddt ,t1.rtaxl003 ,t2.oocql004 ,t3.oocql004 ,t4.oocql004 , 
       t5.oocql004 ,t6.oocql004 ,t7.oocql004 ,t8.oocql004 ,t9.pmaal004 ,t10.ooag011 ,t11.ooefl003 ,t12.ooefl003 , 
       t13.ooag011 ,t14.ooefl003 ,t15.ooag011 ,t16.ooefl003 ,t17.ooag011 ,t18.ooefl003 ,t19.ooag011 FROM rtdl_t t0", 
 
               " LEFT JOIN rtdll_t ON rtdllent = "||g_enterprise||" AND rtdl001 = rtdll001 AND rtdll002 = '",g_dlang,"'",
                              " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.rtdl002 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2119' AND t2.oocql002=t0.rtdl003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2120' AND t3.oocql002=t0.rtdl004 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2121' AND t4.oocql002=t0.rtdl005 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2122' AND t5.oocql002=t0.rtdl005 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2123' AND t6.oocql002=t0.rtdl005 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2124' AND t7.oocql002=t0.rtdl005 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2125' AND t8.oocql002=t0.rtdl005 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t9 ON t9.pmaalent="||g_enterprise||" AND t9.pmaal001=t0.rtdl014 AND t9.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtdl017  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.rtdl018 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.rtdl019 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.rtdl023  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.rtdl024 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.rtdlownid  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.rtdlowndp AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.rtdlcrtid  ",
               " LEFT JOIN ooefl_t t18 ON t18.ooeflent="||g_enterprise||" AND t18.ooefl001=t0.rtdlcrtdp AND t18.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.rtdlmodid  ",
 
               " WHERE t0.rtdlent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("rtdl_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND rtdlowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("rtdl_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND rtdlownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   LET g_sql = "SELECT  UNIQUE t0.rtdlstus,t0.rtdl001,t0.rtdl021,t0.rtdl002,t0.rtdl003,t0.rtdl004,t0.rtdl005,", 
               "               t0.rtdl006,t0.rtdl007,t0.rtdl008,t0.rtdl009,t0.rtdl010,t0.rtdl011,t0.rtdl012,t0.rtdl013,t0.rtdl014, ",
               "               t0.rtdl015,t0.rtdl016,t0.rtdl017,t0.rtdl018,t0.rtdl019,t0.rtdl020,t0.rtdl025,t0.rtdl026,t0.rtdl027, ",
               "               t0.rtdl028,t0.rtdl022,t0.rtdl023,t0.rtdl024,t0.rtdl001,t0.rtdlownid,t0.rtdlowndp,t0.rtdlcrtid, ",
               "               t0.rtdlcrtdp,t0.rtdlcrtdt,t0.rtdlmodid,t0.rtdlmoddt ,t1.rtaxl003 ,t2.oocql004 ,t3.oocql004 ,t4.oocql004 , ",
               "               t5.oocql004 ,t6.oocql004 ,t7.oocql004 ,t8.oocql004 ,t9.pmaal004 ,t10.ooag011 ,t11.ooefl003 ,t12.ooefl003 , ",
               "               t13.ooag011 ,t14.ooefl003 ,t15.ooag011 ,t16.ooefl003 ,t17.ooag011 ,t18.ooefl003 ,t19.ooag011 ",
               " FROM rtdl_t t0 ", 
               " LEFT JOIN rtdll_t ON rtdllent = "||g_enterprise||" AND rtdl001 = rtdll001 AND rtdll002 = '",g_dlang,"'",
               " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.rtdl002 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2119' AND t2.oocql002=t0.rtdl003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2120' AND t3.oocql002=t0.rtdl004 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2121' AND t4.oocql002=t0.rtdl005 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2122' AND t5.oocql002=t0.rtdl006 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2123' AND t6.oocql002=t0.rtdl007 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2124' AND t7.oocql002=t0.rtdl008 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2125' AND t8.oocql002=t0.rtdl009 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t9 ON t9.pmaalent="||g_enterprise||" AND t9.pmaal001=t0.rtdl014 AND t9.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtdl017  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.rtdl018 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.rtdl019 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.rtdl023  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.rtdl024 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.rtdlownid  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.rtdlowndp AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.rtdlcrtid  ",
               " LEFT JOIN ooefl_t t18 ON t18.ooeflent="||g_enterprise||" AND t18.ooefl001=t0.rtdlcrtdp AND t18.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.rtdlmodid  ",
 
               " WHERE t0.rtdlent= ?  AND  1=1 AND (", p_wc2, ") "    
   LET g_sql = g_sql ," AND rtdl020 = '2'"
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("rtdl_t"),
                      " ORDER BY t0.rtdl001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtdl_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE arti040_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR arti040_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtdl_d.clear()
   CALL g_rtdl2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_rtdl_d[l_ac].rtdlstus,g_rtdl_d[l_ac].rtdl001,g_rtdl_d[l_ac].rtdl021,g_rtdl_d[l_ac].rtdl002, 
       g_rtdl_d[l_ac].rtdl003,g_rtdl_d[l_ac].rtdl004,g_rtdl_d[l_ac].rtdl005,g_rtdl_d[l_ac].rtdl006,g_rtdl_d[l_ac].rtdl007, 
       g_rtdl_d[l_ac].rtdl008,g_rtdl_d[l_ac].rtdl009,g_rtdl_d[l_ac].rtdl010,g_rtdl_d[l_ac].rtdl011,g_rtdl_d[l_ac].rtdl012, 
       g_rtdl_d[l_ac].rtdl013,g_rtdl_d[l_ac].rtdl014,g_rtdl_d[l_ac].rtdl015,g_rtdl_d[l_ac].rtdl016,g_rtdl_d[l_ac].rtdl017, 
       g_rtdl_d[l_ac].rtdl018,g_rtdl_d[l_ac].rtdl019,g_rtdl_d[l_ac].rtdl020,g_rtdl_d[l_ac].rtdl025,g_rtdl_d[l_ac].rtdl026, 
       g_rtdl_d[l_ac].rtdl027,g_rtdl_d[l_ac].rtdl028,g_rtdl_d[l_ac].rtdl022,g_rtdl_d[l_ac].rtdl023,g_rtdl_d[l_ac].rtdl024, 
       g_rtdl2_d[l_ac].rtdl001,g_rtdl2_d[l_ac].rtdlownid,g_rtdl2_d[l_ac].rtdlowndp,g_rtdl2_d[l_ac].rtdlcrtid, 
       g_rtdl2_d[l_ac].rtdlcrtdp,g_rtdl2_d[l_ac].rtdlcrtdt,g_rtdl2_d[l_ac].rtdlmodid,g_rtdl2_d[l_ac].rtdlmoddt, 
       g_rtdl_d[l_ac].rtdl002_desc,g_rtdl_d[l_ac].rtdl003_desc,g_rtdl_d[l_ac].rtdl004_desc,g_rtdl_d[l_ac].rtdl005_desc, 
       g_rtdl_d[l_ac].rtdl006_desc,g_rtdl_d[l_ac].rtdl007_desc,g_rtdl_d[l_ac].rtdl008_desc,g_rtdl_d[l_ac].rtdl009_desc, 
       g_rtdl_d[l_ac].rtdl014_desc,g_rtdl_d[l_ac].rtdl017_desc,g_rtdl_d[l_ac].rtdl018_desc,g_rtdl_d[l_ac].rtdl019_desc, 
       g_rtdl_d[l_ac].rtdl023_desc,g_rtdl_d[l_ac].rtdl024_desc,g_rtdl2_d[l_ac].rtdlownid_desc,g_rtdl2_d[l_ac].rtdlowndp_desc, 
       g_rtdl2_d[l_ac].rtdlcrtid_desc,g_rtdl2_d[l_ac].rtdlcrtdp_desc,g_rtdl2_d[l_ac].rtdlmodid_desc
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
      
      CALL arti040_detail_show()      
 
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
   
 
   
   CALL g_rtdl_d.deleteElement(g_rtdl_d.getLength())   
   CALL g_rtdl2_d.deleteElement(g_rtdl2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_rtdl_d.getLength()
      LET g_rtdl2_d[l_ac].rtdl001 = g_rtdl_d[l_ac].rtdl001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_rtdl_d.getLength() THEN
      LET l_ac = g_rtdl_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtdl_d.getLength()
      LET g_rtdl_d_mask_o[l_ac].* =  g_rtdl_d[l_ac].*
      CALL arti040_rtdl_t_mask()
      LET g_rtdl_d_mask_n[l_ac].* =  g_rtdl_d[l_ac].*
   END FOR
   
   LET g_rtdl2_d_mask_o.* =  g_rtdl2_d.*
   FOR l_ac = 1 TO g_rtdl2_d.getLength()
      LET g_rtdl2_d_mask_o[l_ac].* =  g_rtdl2_d[l_ac].*
      CALL arti040_rtdl_t_mask()
      LET g_rtdl2_d_mask_n[l_ac].* =  g_rtdl2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_rtdl_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE arti040_pb
   
END FUNCTION
 
{</section>}
 
{<section id="arti040.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION arti040_detail_show()
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
   LET g_ref_fields[1] = g_rtdl_d[l_ac].rtdl001
   CALL ap_ref_array2(g_ref_fields," SELECT rtdll003,rtdll004 FROM rtdll_t WHERE rtdllent = '"||g_enterprise||"' AND rtdll001 = ? AND rtdll002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_rtdl_d[l_ac].rtdll003 = g_rtn_fields[1] 
   LET g_rtdl_d[l_ac].rtdll004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_rtdl_d[l_ac].rtdll003,g_rtdl_d[l_ac].rtdll004
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="arti040.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION arti040_set_entry_b(p_cmd)                                                  
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
 
{<section id="arti040.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION arti040_set_no_entry_b(p_cmd)                                               
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
 
{<section id="arti040.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION arti040_default_search()
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
      LET ls_wc = ls_wc, " rtdl001 = '", g_argv[01], "' AND "
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
 
{<section id="arti040.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION arti040_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "rtdl_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtdl_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM rtdl_t
          WHERE rtdlent = g_enterprise AND
            rtdl001 = ps_keys_bak[1]
         
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
         CALL g_rtdl_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_rtdl2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti040.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION arti040_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "rtdl_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO rtdl_t
                  (rtdlent,
                   rtdl001
                   ,rtdlstus,rtdl021,rtdl002,rtdl003,rtdl004,rtdl005,rtdl006,rtdl007,rtdl008,rtdl009,rtdl010,rtdl011,rtdl012,rtdl013,rtdl014,rtdl015,rtdl016,rtdl017,rtdl018,rtdl019,rtdl020,rtdl025,rtdl026,rtdl027,rtdl028,rtdl022,rtdl023,rtdl024,rtdlownid,rtdlowndp,rtdlcrtid,rtdlcrtdp,rtdlcrtdt,rtdlmodid,rtdlmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_rtdl_d[l_ac].rtdlstus,g_rtdl_d[l_ac].rtdl021,g_rtdl_d[l_ac].rtdl002,g_rtdl_d[l_ac].rtdl003, 
                       g_rtdl_d[l_ac].rtdl004,g_rtdl_d[l_ac].rtdl005,g_rtdl_d[l_ac].rtdl006,g_rtdl_d[l_ac].rtdl007, 
                       g_rtdl_d[l_ac].rtdl008,g_rtdl_d[l_ac].rtdl009,g_rtdl_d[l_ac].rtdl010,g_rtdl_d[l_ac].rtdl011, 
                       g_rtdl_d[l_ac].rtdl012,g_rtdl_d[l_ac].rtdl013,g_rtdl_d[l_ac].rtdl014,g_rtdl_d[l_ac].rtdl015, 
                       g_rtdl_d[l_ac].rtdl016,g_rtdl_d[l_ac].rtdl017,g_rtdl_d[l_ac].rtdl018,g_rtdl_d[l_ac].rtdl019, 
                       g_rtdl_d[l_ac].rtdl020,g_rtdl_d[l_ac].rtdl025,g_rtdl_d[l_ac].rtdl026,g_rtdl_d[l_ac].rtdl027, 
                       g_rtdl_d[l_ac].rtdl028,g_rtdl_d[l_ac].rtdl022,g_rtdl_d[l_ac].rtdl023,g_rtdl_d[l_ac].rtdl024, 
                       g_rtdl2_d[l_ac].rtdlownid,g_rtdl2_d[l_ac].rtdlowndp,g_rtdl2_d[l_ac].rtdlcrtid, 
                       g_rtdl2_d[l_ac].rtdlcrtdp,g_rtdl2_d[l_ac].rtdlcrtdt,g_rtdl2_d[l_ac].rtdlmodid, 
                       g_rtdl2_d[l_ac].rtdlmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtdl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="arti040.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION arti040_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "rtdl_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtdl_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE rtdl_t 
         SET (rtdl001
              ,rtdlstus,rtdl021,rtdl002,rtdl003,rtdl004,rtdl005,rtdl006,rtdl007,rtdl008,rtdl009,rtdl010,rtdl011,rtdl012,rtdl013,rtdl014,rtdl015,rtdl016,rtdl017,rtdl018,rtdl019,rtdl020,rtdl025,rtdl026,rtdl027,rtdl028,rtdl022,rtdl023,rtdl024,rtdlownid,rtdlowndp,rtdlcrtid,rtdlcrtdp,rtdlcrtdt,rtdlmodid,rtdlmoddt) 
              = 
             (ps_keys[1]
              ,g_rtdl_d[l_ac].rtdlstus,g_rtdl_d[l_ac].rtdl021,g_rtdl_d[l_ac].rtdl002,g_rtdl_d[l_ac].rtdl003, 
                  g_rtdl_d[l_ac].rtdl004,g_rtdl_d[l_ac].rtdl005,g_rtdl_d[l_ac].rtdl006,g_rtdl_d[l_ac].rtdl007, 
                  g_rtdl_d[l_ac].rtdl008,g_rtdl_d[l_ac].rtdl009,g_rtdl_d[l_ac].rtdl010,g_rtdl_d[l_ac].rtdl011, 
                  g_rtdl_d[l_ac].rtdl012,g_rtdl_d[l_ac].rtdl013,g_rtdl_d[l_ac].rtdl014,g_rtdl_d[l_ac].rtdl015, 
                  g_rtdl_d[l_ac].rtdl016,g_rtdl_d[l_ac].rtdl017,g_rtdl_d[l_ac].rtdl018,g_rtdl_d[l_ac].rtdl019, 
                  g_rtdl_d[l_ac].rtdl020,g_rtdl_d[l_ac].rtdl025,g_rtdl_d[l_ac].rtdl026,g_rtdl_d[l_ac].rtdl027, 
                  g_rtdl_d[l_ac].rtdl028,g_rtdl_d[l_ac].rtdl022,g_rtdl_d[l_ac].rtdl023,g_rtdl_d[l_ac].rtdl024, 
                  g_rtdl2_d[l_ac].rtdlownid,g_rtdl2_d[l_ac].rtdlowndp,g_rtdl2_d[l_ac].rtdlcrtid,g_rtdl2_d[l_ac].rtdlcrtdp, 
                  g_rtdl2_d[l_ac].rtdlcrtdt,g_rtdl2_d[l_ac].rtdlmodid,g_rtdl2_d[l_ac].rtdlmoddt) 
         WHERE rtdlent = g_enterprise AND rtdl001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtdl_t:",SQLERRMESSAGE 
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
 
{<section id="arti040.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION arti040_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL arti040_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "rtdl_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN arti040_bcl USING g_enterprise,
                                       g_rtdl_d[g_detail_idx].rtdl001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "arti040_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="arti040.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION arti040_unlock_b(ps_table)
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
      CLOSE arti040_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="arti040.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION arti040_modify_detail_chk(ps_record)
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
         LET ls_return = "rtdlstus"
      WHEN "s_detail2"
         LET ls_return = "rtdl001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="arti040.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION arti040_show_ownid_msg()
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
 
{<section id="arti040.mask_functions" >}
&include "erp/art/arti040_mask.4gl"
 
{</section>}
 
{<section id="arti040.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION arti040_set_pk_array()
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
   LET g_pk_array[1].values = g_rtdl_d[l_ac].rtdl001
   LET g_pk_array[1].column = 'rtdl001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="arti040.state_change" >}
   
 
{</section>}
 
{<section id="arti040.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="arti040.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查輸入值不可以跟"自營品牌"、"百貨正式品牌"和"百貨備用品牌"的資料重複。
# Memo...........:
# Usage..........: CALL arti040_rtdl001_chk()
#                  RETURNING  r_success
# Input parameter: 無
# Return code....: r_success TRUE(FALSE)
# Date & Author..: 2015/03/25 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION arti040_rtdl001_chk()
DEFINE l_oocq022      LIKE  oocq_t.oocq022
DEFINE l_rtdl001      LIKE  rtdl_t.rtdl001
DEFINE r_success      LIKE type_t.num5
  
  
   LET r_success = TRUE
   LET l_oocq022 = ''
   SELECT oocq022 INTO l_oocq022
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = g_oocq001_acc
      AND oocq002 = g_rtdl_d[l_ac].rtdl001
      
   #自營品牌重複
   IF l_oocq022 = 1 THEN  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00507'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE      
      RETURN r_success
   END IF
   
   #百貨正式品牌重複
   IF l_oocq022 = 2 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00509'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_rtdl001 = ''
   SELECT rtdl001 INTO l_rtdl001 FROM rtdl_t
    WHERE rtdlent  = g_enterprise
      AND rtdl001 = g_rtdl_d[l_ac].rtdl001
   
   #百貨備用品牌重複   
   IF NOT cl_null(l_rtdl001) THEN  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00508'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF   
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: (1)將備用品牌的資料拋轉至正式品牌資料檔(oocq_t)
#                  (2)更新備用品牌的 rtdl021,rtdl022,rtdl023,rtdl024 的資料
# Memo...........:
# Usage..........: CALL arti040_upd_oocq(p_li_idx)
#                  RETURNING  r_success
# Input parameter: 
# Return code....: r_success   TRUE(FALSE)
# Date & Author..: 2015/03/25 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION arti040_upd_oocq(p_li_idx)
DEFINE p_li_idx  LIKE type_t.num10
DEFINE l_li_idx  LIKE type_t.num10
DEFINE r_success LIKE type_t.num5
DEFINE l_sql     STRING

      LET l_li_idx = p_li_idx
      LET r_success = TRUE
      #ins oocq_t,商品-品牌(應用碼2002)
      INSERT INTO oocq_t(oocqent,oocq001,oocqstus,
                         oocq002,oocq004,oocq005,
      				       oocq006,oocq007,oocq008,
      				       oocq009,oocq010,oocq011,
      				       oocq012,oocq013,oocq014,
      				       oocq015,oocq016,oocq017,
      				       oocq018,oocq019,oocq020,
      				       oocq021,oocq022,
      				       oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,
                         oocqcrtdt,oocqmodid,oocqmoddt)
      		   VALUES(g_enterprise,g_oocq001_acc,'Y',
      		          g_rtdl_d[l_li_idx].rtdl001,g_rtdl_d[l_li_idx].rtdl002,g_rtdl_d[l_li_idx].rtdl003,
      		          g_rtdl_d[l_li_idx].rtdl004,g_rtdl_d[l_li_idx].rtdl005,g_rtdl_d[l_li_idx].rtdl006,
      				    g_rtdl_d[l_li_idx].rtdl007,g_rtdl_d[l_li_idx].rtdl008,g_rtdl_d[l_li_idx].rtdl009,
      				    g_rtdl_d[l_li_idx].rtdl010,g_rtdl_d[l_li_idx].rtdl011,g_rtdl_d[l_li_idx].rtdl012,
      				    g_rtdl_d[l_li_idx].rtdl013,g_rtdl_d[l_li_idx].rtdl014,g_rtdl_d[l_li_idx].rtdl015,
      				    g_rtdl_d[l_li_idx].rtdl016,g_rtdl_d[l_li_idx].rtdl017,g_rtdl_d[l_li_idx].rtdl018,
      				    g_rtdl_d[l_li_idx].rtdl019,g_rtdl_d[l_li_idx].rtdl020,
      				    g_user,g_dept,g_user,g_dept,
      				    g_today,g_user,g_today)
      				    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins oocq_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
	  
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #ins oocql_t多語言檔
      LET l_sql = " INSERT INTO oocql_t( ",
                  "  oocqlent,oocql001,oocql002,oocql003,oocql004,oocql005) ",
                  " SELECT rtdllent,",g_oocq001_acc,",rtdll001,rtdll002,rtdll003,rtdll004",
                  "   FROM rtdll_t ",
                  "  WHERE rtdllent = ? AND rtdll001 = ? "
      
      PREPARE ins_oocq_pre FROM l_sql
      EXECUTE ins_oocq_pre USING g_enterprise,g_rtdl_d[l_li_idx].rtdl001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Ins oocq_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      
      #update轉正式品牌='Y'
      UPDATE rtdl_t
         SET rtdl021 = 'Y',        #轉正式品牌
             rtdl022 = g_today,    #轉正式品牌日期
             rtdl023 = g_user,     #轉正式品牌人員
             rtdl024 = g_dept      #轉正式品牌部門
       WHERE rtdlent = g_enterprise
         AND rtdl001 = g_rtdl_d[l_li_idx].rtdl001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd rtdl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00511'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = g_rtdl_d[l_li_idx].rtdl001
      CALL cl_err()
      
      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查目前點選到資料為未拋轉正式品牌資料列
# Memo...........: 如選到轉正式品牌=Y時,則往下(上)找到是轉正式品牌=N的資料列
# Usage..........: CALL arti040_chk_rtdl021(p_ac_t)
#                  RETURNING r_set_curr
# Input parameter: p_ac_t         原本資料指標位置
# Return code....: r_set_curr     新的資料指標位置
# Date & Author..: 2015/03/26 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION arti040_chk_rtdl021(p_ac_t)
   DEFINE p_ac_t          LIKE type_t.num5
   DEFINE l_ac_t          LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_rtdl001       LIKE rtdl_t.rtdl001
   DEFINE r_set_curr      LIKE type_t.num5   

   LET r_set_curr = l_ac
   IF r_set_curr = 0 THEN
     LET r_set_curr = 1
   END IF

   LET l_ac_t = p_ac_t
   IF l_ac_t = 0 THEN
    LET l_ac_t = 1
   END IF
   IF l_ac_t = 0 OR r_set_curr > p_ac_t THEN
      LET l_flag = 'D'
   ELSE
      LET l_flag = 'U'
   END IF

   LET l_rtdl001 = ' '

   IF l_flag = 'D' THEN
      FOR l_i = r_set_curr TO g_rtdl_d.getLength()
         IF g_rtdl_d[l_i].rtdl021 = 'Y' THEN
            IF l_i = r_set_curr THEN
               LET l_rtdl001 = g_rtdl_d[l_i].rtdl001
            END IF         
            CONTINUE FOR
         END IF

         LET r_set_curr = l_i
         EXIT FOR
      END FOR
      LET r_set_curr = l_i
   ELSE
      FOR l_i = r_set_curr TO 1 STEP -1
         IF g_rtdl_d[l_i].rtdl021 = 'Y' THEN
            IF l_i = r_set_curr THEN
               LET l_rtdl001 = g_rtdl_d[l_i].rtdl001
            END IF         
            CONTINUE FOR
         END IF

         LET r_set_curr = l_i
         EXIT FOR
      END FOR
      IF l_i = 0 THEN
         LET r_set_curr = g_rtdl_d.getLength() + 1
      END IF
   END IF
   
   IF NOT cl_null(l_rtdl001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00513'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      LET g_errparam.replace[1] = l_rtdl001
      CALL cl_err()   
   END IF   

   RETURN r_set_curr
END FUNCTION

 
{</section>}
 
