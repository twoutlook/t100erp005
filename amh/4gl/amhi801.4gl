#該程式未解開Section, 採用最新樣板產出!
{<section id="amhi801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-09-02 17:42:55), PR版次:0006(2016-11-08 16:34:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: amhi801
#+ Description: 圖紙設定作業
#+ Creator....: 02749(2016-05-07 09:17:36)
#+ Modifier...: 08742 -SD/PR- 02749
 
{</section>}
 
{<section id="amhi801.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160713-00018#1  2016/07/14  by 06814       補上營運組織檢核
#160831-00049#1  2016/09/01  by 08742       整单操作加两个按钮，图纸编辑，图纸浏览，打开个字对应的网页
#161006-00008#2  2016/10/17  by 06814       加上aooi500控卡邏輯
#161108-00027#1  2016/11/08  By lori        調整g_browser_cnt長度變數定義為num10
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
PRIVATE TYPE type_g_mhbj_d RECORD
       mhbjsite LIKE mhbj_t.mhbjsite, 
   mhbjsite_desc LIKE type_t.chr500, 
   mhbj001 LIKE mhbj_t.mhbj001, 
   mhbj001_desc LIKE type_t.chr500, 
   mhbj002 LIKE mhbj_t.mhbj002, 
   mhbj002_desc LIKE type_t.chr500, 
   mhbj003 LIKE mhbj_t.mhbj003, 
   mhbj005 LIKE mhbj_t.mhbj005, 
   mhbjl007 LIKE mhbjl_t.mhbjl007, 
   mhbj006 LIKE mhbj_t.mhbj006, 
   mhbj007 LIKE mhbj_t.mhbj007, 
   mhbjstus LIKE mhbj_t.mhbjstus, 
   mhbjunit LIKE mhbj_t.mhbjunit
       END RECORD
PRIVATE TYPE type_g_mhbj2_d RECORD
       mhbjsite LIKE mhbj_t.mhbjsite, 
   mhbj003 LIKE mhbj_t.mhbj003, 
   mhbj005 LIKE mhbj_t.mhbj005, 
   mhbjownid LIKE mhbj_t.mhbjownid, 
   mhbjownid_desc LIKE type_t.chr500, 
   mhbjowndp LIKE mhbj_t.mhbjowndp, 
   mhbjowndp_desc LIKE type_t.chr500, 
   mhbjcrtid LIKE mhbj_t.mhbjcrtid, 
   mhbjcrtid_desc LIKE type_t.chr500, 
   mhbjcrtdp LIKE mhbj_t.mhbjcrtdp, 
   mhbjcrtdp_desc LIKE type_t.chr500, 
   mhbjcrtdt DATETIME YEAR TO SECOND, 
   mhbjmodid LIKE mhbj_t.mhbjmodid, 
   mhbjmodid_desc LIKE type_t.chr500, 
   mhbjmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      mhbjlsite LIKE mhbjl_t.mhbjlsite,
      mhbjl003 LIKE mhbjl_t.mhbjl003,
      mhbjl005 LIKE mhbjl_t.mhbjl005,
      mhbjl006 LIKE mhbjl_t.mhbjl006,
      mhbjl007 LIKE mhbjl_t.mhbjl007
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tree    DYNAMIC ARRAY OF RECORD      #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
       b_ooed001       LIKE ooed_t.ooed001,
       b_ooed002       LIKE ooed_t.ooed002,
       b_ooed003       LIKE ooed_t.ooed003,
       b_ooed004       LIKE ooed_t.ooed004,
       b_ooed005       LIKE ooed_t.ooed005
                   END RECORD
                   
DEFINE g_root_search   BOOLEAN 
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
#DEFINE g_browser_cnt   LIKE type_t.num5            #total count   #161108-00027#1 161108 by lori mark
DEFINE g_browser_cnt   LIKE type_t.num10           #total count    #161108-00027#1 161108 by lori add
DEFINE g_first         LIKE type_t.chr1            #紀錄是否是程式剛開始進入狀態
DEFINE g_current_idx   LIKE type_t.num10           #Browser所在筆數
DEFINE g_current_row   LIKE type_t.num5    
DEFINE g_set_detail    LIKE type_t.num5            #Tree節點有時                
DEFINE g_ooed004       LIKE ooed_t.ooed004         #紀錄Tree點選的組織
#end add-point
 
#模組變數(Module Variables)
DEFINE g_mhbj_d          DYNAMIC ARRAY OF type_g_mhbj_d #單身變數
DEFINE g_mhbj_d_t        type_g_mhbj_d                  #單身備份
DEFINE g_mhbj_d_o        type_g_mhbj_d                  #單身備份
DEFINE g_mhbj_d_mask_o   DYNAMIC ARRAY OF type_g_mhbj_d #單身變數
DEFINE g_mhbj_d_mask_n   DYNAMIC ARRAY OF type_g_mhbj_d #單身變數
DEFINE g_mhbj2_d   DYNAMIC ARRAY OF type_g_mhbj2_d
DEFINE g_mhbj2_d_t type_g_mhbj2_d
DEFINE g_mhbj2_d_o type_g_mhbj2_d
DEFINE g_mhbj2_d_mask_o DYNAMIC ARRAY OF type_g_mhbj2_d
DEFINE g_mhbj2_d_mask_n DYNAMIC ARRAY OF type_g_mhbj2_d
 
      
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
 
{<section id="amhi801.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#2 20161017 add by beckxie
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
   LET g_forupd_sql = "SELECT mhbjsite,mhbj001,mhbj002,mhbj003,mhbj005,mhbj006,mhbj007,mhbjstus,mhbjunit, 
       mhbjsite,mhbj003,mhbj005,mhbjownid,mhbjowndp,mhbjcrtid,mhbjcrtdp,mhbjcrtdt,mhbjmodid,mhbjmoddt  
       FROM mhbj_t WHERE mhbjent=? AND mhbjsite=? AND mhbj003=? AND mhbj005=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amhi801_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amhi801 WITH FORM cl_ap_formpath("amh",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amhi801_init()   
 
      #進入選單 Menu (="N")
      CALL amhi801_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL amhi801_drop_tmp()  #刪tmp table
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amhi801
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#2 20161017 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amhi801.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION amhi801_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#2 20161017 add by beckxie
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   CALL amhi801_create_tmp()   #建tmp table
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#2 20161017 add by beckxie
   #end add-point
   
   CALL amhi801_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="amhi801.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION amhi801_ui_dialog()
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
   DEFINE l_url                   STRING
   DEFINE l_mhbj003               LIKE mhbj_t.mhbj003   
   DEFINE l_cnt                   LIKE type_t.num10 
   DEFINE l_ent                   STRING
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL amhi801_browser_fill(g_wc2)
   LET g_first = 1
   LET g_set_detail = 0
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_mhbj_d.clear()
         CALL g_mhbj2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL amhi801_init()
      END IF
   
      CALL amhi801_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mhbj_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_mhbj2_d[g_detail_idx].mhbjownid   #(ver:35)
               LET g_data_dept = g_mhbj2_d[g_detail_idx].mhbjowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL amhi801_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_mhbj2_d TO s_detail2.*
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
   CALL amhi801_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #Tree
         DISPLAY ARRAY g_tree TO s_tree.*
            BEFORE DISPLAY
               CALL DIALOG.setSelectionMode("s_tree",1) #設定為單選
 
            BEFORE ROW
               LET g_current_idx = DIALOG.getCurrentRow("s_tree")
               LET g_current_row = g_current_idx
               LET g_ooed004 = g_tree[g_current_row].b_ooed004
               IF cl_null(g_ooed004) THEN
                  LET g_ooed004 = g_tree[g_current_row].b_ooed002
               END IF               
               DISPLAY "g_ooed004:",g_ooed004
               LET g_set_detail = 0
               CALL amhi801_b_fill(g_wc2)
               
            #   #回歸舊筆數位置 (回到當時異動的筆數)
            #   LET g_current_idx = DIALOG.getCurrentRow("s_tree")
            #   IF g_current_row > 0 THEN
            #      IF g_current_row <> g_current_idx THEN
            #         LET g_current_row = g_current_idx #目前指標
            #         CALL DIALOG.setCurrentRow("s_tree",g_current_row)
            #       END IF
            #
            #      IF NOT cl_null(g_tree[g_current_row].b_ooed002) THEN
            #         LET g_set_detail = NULL
            #         FOR l_i = 1 TO g_ooed_d.getLength()
            #            IF g_dbac_d[l_i].b_ooed002 = g_tree[g_current_row].b_ooed002 THEN
            #              LET g_set_detail = l_i
            #              CALL DIALOG.setCurrentRow("s_detail1",g_set_detail)
            #              EXIT FOR
            #            END IF
            #         END FOR
            #      END IF
            #   ELSE
            #      LET g_current_row = g_detail_idx
            #   END IF
            #
            #   CALL cl_show_fld_cont() 
               
            ON EXPAND (g_current_row)
               #樹展開
               CALL amhi801_node_open(g_tree[g_current_row].b_ooed004)
            ON COLLAPSE (g_current_row)
               #樹關閉
               CALL amhi801_node_close(g_tree[g_current_row].b_ooed004)
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
            
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL amhi801_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amhi801_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL amhi801_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amhi801_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL amhi801_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL amhi801_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION draw_browse
            LET g_action_choice="draw_browse"
            IF cl_auth_chk_act("draw_browse") THEN
               
               #add-point:ON ACTION draw_browse name="menu.draw_browse"
               #160831-00049#1 -S
               LET l_cnt = g_mhbj_d.getLength()
               IF l_cnt > 0 THEN 
                  IF l_ac = 0 THEN
                     LET l_ac = 1 
                  END IF   
                  LET l_mhbj003 = g_mhbj_d[l_ac].mhbj003  
                  LET l_ent = g_enterprise
                  LET l_url = FGL_GETENV("FGLASIP"),"/components/MallShow/app/index.html#/olview" 
                  LET l_url = l_url ,"?ent=",l_ent,"&mapid=", l_mhbj003
                  CALL ui.Interface.frontCall("standard", "launchurl", [l_url], []) 
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00626'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  CONTINUE DIALOG
               END IF                    
               #160831-00049#1 -E
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amhi801_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION draw_editor
            LET g_action_choice="draw_editor"
            IF cl_auth_chk_act("draw_editor") THEN
               
               #add-point:ON ACTION draw_editor name="menu.draw_editor"
               #160831-00049#1 -S
               LET l_cnt = g_mhbj_d.getLength()
               IF l_cnt > 0 THEN 
                  IF l_ac = 0 THEN
                     LET l_ac = 1 
                  END IF   
                  LET l_mhbj003 = g_mhbj_d[l_ac].mhbj003  
                  LET l_ent = g_enterprise
                  LET l_url = FGL_GETENV("FGLASIP"),"/components/MallShow/app/index.html#/oldraw" 
                  LET l_url = l_url , "?ent=",l_ent,"&mapid=", l_mhbj003
                  CALL ui.Interface.frontCall("standard", "launchurl", [l_url], []) 
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00626'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  CONTINUE DIALOG
               END IF                     
               #160831-00049#1 -E
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
               CALL amhi801_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_mhbj_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_mhbj2_d)
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
            CALL amhi801_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amhi801_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amhi801_set_pk_array()
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
 
{<section id="amhi801.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION amhi801_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   LET g_set_detail = 1
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_mhbj_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON mhbjsite,mhbj001,mhbj002,mhbj003,mhbj005,mhbjl007,mhbj006,mhbj007,mhbjstus, 
          mhbjunit,mhbjownid,mhbjowndp,mhbjcrtid,mhbjcrtdp,mhbjcrtdt,mhbjmodid,mhbjmoddt 
 
         FROM s_detail1[1].mhbjsite,s_detail1[1].mhbj001,s_detail1[1].mhbj002,s_detail1[1].mhbj003,s_detail1[1].mhbj005, 
             s_detail1[1].mhbjl007,s_detail1[1].mhbj006,s_detail1[1].mhbj007,s_detail1[1].mhbjstus,s_detail1[1].mhbjunit, 
             s_detail2[1].mhbjownid,s_detail2[1].mhbjowndp,s_detail2[1].mhbjcrtid,s_detail2[1].mhbjcrtdp, 
             s_detail2[1].mhbjcrtdt,s_detail2[1].mhbjmodid,s_detail2[1].mhbjmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mhbjcrtdt>>----
         AFTER FIELD mhbjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mhbjmoddt>>----
         AFTER FIELD mhbjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mhbjcnfdt>>----
         
         #----<<mhbjpstdt>>----
 
 
 
      
                  #Ctrlp:construct.c.page1.mhbjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjsite
            #add-point:ON ACTION controlp INFIELD mhbjsite name="construct.c.page1.mhbjsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbjsite',g_site,'c')   #161006-00008#2 20161017 add by beckxie
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbjsite  #顯示到畫面上
            NEXT FIELD mhbjsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjsite
            #add-point:BEFORE FIELD mhbjsite name="query.b.page1.mhbjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjsite
            
            #add-point:AFTER FIELD mhbjsite name="query.a.page1.mhbjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj001
            #add-point:ON ACTION controlp INFIELD mhbj001 name="construct.c.page1.mhbj001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbj001  #顯示到畫面上
            NEXT FIELD mhbj001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj001
            #add-point:BEFORE FIELD mhbj001 name="query.b.page1.mhbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj001
            
            #add-point:AFTER FIELD mhbj001 name="query.a.page1.mhbj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj002
            #add-point:ON ACTION controlp INFIELD mhbj002 name="construct.c.page1.mhbj002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbj002  #顯示到畫面上
            NEXT FIELD mhbj002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj002
            #add-point:BEFORE FIELD mhbj002 name="query.b.page1.mhbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj002
            
            #add-point:AFTER FIELD mhbj002 name="query.a.page1.mhbj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mhbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj003
            #add-point:ON ACTION controlp INFIELD mhbj003 name="construct.c.page1.mhbj003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbj003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbj003  #顯示到畫面上
            NEXT FIELD mhbj003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj003
            #add-point:BEFORE FIELD mhbj003 name="query.b.page1.mhbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj003
            
            #add-point:AFTER FIELD mhbj003 name="query.a.page1.mhbj003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj005
            #add-point:BEFORE FIELD mhbj005 name="query.b.page1.mhbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj005
            
            #add-point:AFTER FIELD mhbj005 name="query.a.page1.mhbj005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj005
            #add-point:ON ACTION controlp INFIELD mhbj005 name="query.c.page1.mhbj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjl007
            #add-point:BEFORE FIELD mhbjl007 name="query.b.page1.mhbjl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjl007
            
            #add-point:AFTER FIELD mhbjl007 name="query.a.page1.mhbjl007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhbjl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjl007
            #add-point:ON ACTION controlp INFIELD mhbjl007 name="query.c.page1.mhbjl007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj006
            #add-point:BEFORE FIELD mhbj006 name="query.b.page1.mhbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj006
            
            #add-point:AFTER FIELD mhbj006 name="query.a.page1.mhbj006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj006
            #add-point:ON ACTION controlp INFIELD mhbj006 name="query.c.page1.mhbj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj007
            #add-point:BEFORE FIELD mhbj007 name="query.b.page1.mhbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj007
            
            #add-point:AFTER FIELD mhbj007 name="query.a.page1.mhbj007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj007
            #add-point:ON ACTION controlp INFIELD mhbj007 name="query.c.page1.mhbj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjstus
            #add-point:BEFORE FIELD mhbjstus name="query.b.page1.mhbjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjstus
            
            #add-point:AFTER FIELD mhbjstus name="query.a.page1.mhbjstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhbjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjstus
            #add-point:ON ACTION controlp INFIELD mhbjstus name="query.c.page1.mhbjstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjunit
            #add-point:BEFORE FIELD mhbjunit name="query.b.page1.mhbjunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjunit
            
            #add-point:AFTER FIELD mhbjunit name="query.a.page1.mhbjunit"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.mhbjunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjunit
            #add-point:ON ACTION controlp INFIELD mhbjunit name="query.c.page1.mhbjunit"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.mhbjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjownid
            #add-point:ON ACTION controlp INFIELD mhbjownid name="construct.c.page2.mhbjownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbjownid  #顯示到畫面上
            NEXT FIELD mhbjownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjownid
            #add-point:BEFORE FIELD mhbjownid name="query.b.page2.mhbjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjownid
            
            #add-point:AFTER FIELD mhbjownid name="query.a.page2.mhbjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhbjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjowndp
            #add-point:ON ACTION controlp INFIELD mhbjowndp name="construct.c.page2.mhbjowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbjowndp  #顯示到畫面上
            NEXT FIELD mhbjowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjowndp
            #add-point:BEFORE FIELD mhbjowndp name="query.b.page2.mhbjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjowndp
            
            #add-point:AFTER FIELD mhbjowndp name="query.a.page2.mhbjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhbjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjcrtid
            #add-point:ON ACTION controlp INFIELD mhbjcrtid name="construct.c.page2.mhbjcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbjcrtid  #顯示到畫面上
            NEXT FIELD mhbjcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjcrtid
            #add-point:BEFORE FIELD mhbjcrtid name="query.b.page2.mhbjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjcrtid
            
            #add-point:AFTER FIELD mhbjcrtid name="query.a.page2.mhbjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mhbjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjcrtdp
            #add-point:ON ACTION controlp INFIELD mhbjcrtdp name="construct.c.page2.mhbjcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbjcrtdp  #顯示到畫面上
            NEXT FIELD mhbjcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjcrtdp
            #add-point:BEFORE FIELD mhbjcrtdp name="query.b.page2.mhbjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjcrtdp
            
            #add-point:AFTER FIELD mhbjcrtdp name="query.a.page2.mhbjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjcrtdt
            #add-point:BEFORE FIELD mhbjcrtdt name="query.b.page2.mhbjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mhbjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjmodid
            #add-point:ON ACTION controlp INFIELD mhbjmodid name="construct.c.page2.mhbjmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhbjmodid  #顯示到畫面上
            NEXT FIELD mhbjmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjmodid
            #add-point:BEFORE FIELD mhbjmodid name="query.b.page2.mhbjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjmodid
            
            #add-point:AFTER FIELD mhbjmodid name="query.a.page2.mhbjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjmoddt
            #add-point:BEFORE FIELD mhbjmoddt name="query.b.page2.mhbjmoddt"
            
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
    
   CALL amhi801_b_fill(g_wc2)
   LET g_data_owner = g_mhbj2_d[g_detail_idx].mhbjownid   #(ver:35)
   LET g_data_dept = g_mhbj2_d[g_detail_idx].mhbjowndp   #(ver:35)
 
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
 
{<section id="amhi801.insert" >}
#+ 資料新增
PRIVATE FUNCTION amhi801_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   LET g_set_detail = 0
   #end add-point
   
   LET g_insert = 'Y'
   CALL amhi801_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amhi801.modify" >}
#+ 資料修改
PRIVATE FUNCTION amhi801_modify()
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
   DEFINE l_success               LIKE type_t.num5
   DEFINE l_mhbj005               LIKE mhbj_t.mhbj005
   DEFINE l_errno                 LIKE type_t.chr10   #161006-00008#2 20161017 add by beckxie
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
      INPUT ARRAY g_mhbj_d FROM s_detail1.*
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
               IF NOT cl_null(g_mhbj_d[l_ac].mhbj003)  THEN
                  CALL n_mhbjl(g_mhbj_d[l_ac].mhbjsite,g_mhbj_d[l_ac].mhbj003,g_mhbj_d[l_ac].mhbj005)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mhbj_d[l_ac].mhbjsite
                  LET g_ref_fields[2] = g_mhbj_d[l_ac].mhbj003
                  LET g_ref_fields[3] = g_mhbj_d[l_ac].mhbj005
                  CALL ap_ref_array2(g_ref_fields," SELECT mhbjl007,mhbjl008 FROM mhbjl_t WHERE mhbjlent = '"
                      ||g_enterprise||"' AND mhbjlsite = ? AND mhbjl003 = ? AND mhbjl005 = ? AND mhbjl006 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mhbj_d[l_ac].mhbjl007 = g_rtn_fields[1]
                  #LET g_rtel_d[l_ac].rtell003 = g_rtn_fields[2]
                  #LET g_rtel_d[l_ac].rtell004 = g_rtn_fields[3]
               
                  DISPLAY BY NAME g_mhbj_d[l_ac].mhbjl007
                  #DISPLAY BY NAME g_rtel_d[l_ac].rtell003
                  #DISPLAY BY NAME g_rtel_d[l_ac].rtell004                  
               END IF 
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mhbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amhi801_b_fill(g_wc2)
            LET g_detail_cnt = g_mhbj_d.getLength()
         
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
            DISPLAY g_mhbj_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_mhbj_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_mhbj_d[l_ac].mhbjsite IS NOT NULL
               AND g_mhbj_d[l_ac].mhbj003 IS NOT NULL
               AND g_mhbj_d[l_ac].mhbj005 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mhbj_d_t.* = g_mhbj_d[l_ac].*  #BACKUP
               LET g_mhbj_d_o.* = g_mhbj_d[l_ac].*  #BACKUP
               IF NOT amhi801_lock_b("mhbj_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amhi801_bcl INTO g_mhbj_d[l_ac].mhbjsite,g_mhbj_d[l_ac].mhbj001,g_mhbj_d[l_ac].mhbj002, 
                      g_mhbj_d[l_ac].mhbj003,g_mhbj_d[l_ac].mhbj005,g_mhbj_d[l_ac].mhbj006,g_mhbj_d[l_ac].mhbj007, 
                      g_mhbj_d[l_ac].mhbjstus,g_mhbj_d[l_ac].mhbjunit,g_mhbj2_d[l_ac].mhbjsite,g_mhbj2_d[l_ac].mhbj003, 
                      g_mhbj2_d[l_ac].mhbj005,g_mhbj2_d[l_ac].mhbjownid,g_mhbj2_d[l_ac].mhbjowndp,g_mhbj2_d[l_ac].mhbjcrtid, 
                      g_mhbj2_d[l_ac].mhbjcrtdp,g_mhbj2_d[l_ac].mhbjcrtdt,g_mhbj2_d[l_ac].mhbjmodid, 
                      g_mhbj2_d[l_ac].mhbjmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mhbj_d_t.mhbjsite,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mhbj_d_mask_o[l_ac].* =  g_mhbj_d[l_ac].*
                  CALL amhi801_mhbj_t_mask()
                  LET g_mhbj_d_mask_n[l_ac].* =  g_mhbj_d[l_ac].*
                  
                  CALL amhi801_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL amhi801_set_entry_b(l_cmd)
            CALL amhi801_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.mhbjlsite = g_mhbj_d[l_ac].mhbjsite
LET g_detail_multi_table_t.mhbjl003 = g_mhbj_d[l_ac].mhbj003
LET g_detail_multi_table_t.mhbjl005 = g_mhbj_d[l_ac].mhbj005
LET g_detail_multi_table_t.mhbjl006 = g_dlang
LET g_detail_multi_table_t.mhbjl007 = g_mhbj_d[l_ac].mhbjl007
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'mhbjlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'mhbjlsite'
            LET l_var_keys[02] = g_mhbj_d[l_ac].mhbjsite
            LET l_field_keys[03] = 'mhbjl003'
            LET l_var_keys[03] = g_mhbj_d[l_ac].mhbj003
            LET l_field_keys[04] = 'mhbjl005'
            LET l_var_keys[04] = g_mhbj_d[l_ac].mhbj005
            LET l_field_keys[05] = 'mhbjl006'
            LET l_var_keys[05] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'mhbjl_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mhbj_d_t.* TO NULL
            INITIALIZE g_mhbj_d_o.* TO NULL
            INITIALIZE g_mhbj_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mhbj2_d[l_ac].mhbjownid = g_user
      LET g_mhbj2_d[l_ac].mhbjowndp = g_dept
      LET g_mhbj2_d[l_ac].mhbjcrtid = g_user
      LET g_mhbj2_d[l_ac].mhbjcrtdp = g_dept 
      LET g_mhbj2_d[l_ac].mhbjcrtdt = cl_get_current()
      LET g_mhbj2_d[l_ac].mhbjmodid = g_user
      LET g_mhbj2_d[l_ac].mhbjmoddt = cl_get_current()
      LET g_mhbj_d[l_ac].mhbjstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_mhbj_d[l_ac].mhbjstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            #營運組織預設左邊點選的組織
            IF NOT cl_null(g_ooed004) THEN
               LET g_mhbj_d[l_ac].mhbjsite = g_ooed004
               CALL s_desc_get_department_desc(g_mhbj_d[l_ac].mhbjsite) RETURNING g_mhbj_d[l_ac].mhbjsite_desc
               DISPLAY BY NAME g_mhbj_d[l_ac].mhbjsite_desc                
            END IF
            
            
            #生效日期預設當天
            LET g_mhbj_d[l_ac].mhbj006 = g_today
            
            #圖紙版本加1
            #CALL amhi801_mhbj005()
            #end add-point
            LET g_mhbj_d_t.* = g_mhbj_d[l_ac].*     #新輸入資料
            LET g_mhbj_d_o.* = g_mhbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mhbj_d[li_reproduce_target].* = g_mhbj_d[li_reproduce].*
               LET g_mhbj2_d[li_reproduce_target].* = g_mhbj2_d[li_reproduce].*
 
               LET g_mhbj_d[g_mhbj_d.getLength()].mhbjsite = NULL
               LET g_mhbj_d[g_mhbj_d.getLength()].mhbj003 = NULL
               LET g_mhbj_d[g_mhbj_d.getLength()].mhbj005 = NULL
 
            END IF
            
LET g_detail_multi_table_t.mhbjlsite = g_mhbj_d[l_ac].mhbjsite
LET g_detail_multi_table_t.mhbjl003 = g_mhbj_d[l_ac].mhbj003
LET g_detail_multi_table_t.mhbjl005 = g_mhbj_d[l_ac].mhbj005
LET g_detail_multi_table_t.mhbjl006 = g_dlang
LET g_detail_multi_table_t.mhbjl007 = g_mhbj_d[l_ac].mhbjl007
 
 
            CALL amhi801_set_entry_b(l_cmd)
            CALL amhi801_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM mhbj_t 
             WHERE mhbjent = g_enterprise AND mhbjsite = g_mhbj_d[l_ac].mhbjsite
                                       AND mhbj003 = g_mhbj_d[l_ac].mhbj003
                                       AND mhbj005 = g_mhbj_d[l_ac].mhbj005
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbj_d[g_detail_idx].mhbjsite
               LET gs_keys[2] = g_mhbj_d[g_detail_idx].mhbj003
               LET gs_keys[3] = g_mhbj_d[g_detail_idx].mhbj005
               CALL amhi801_insert_b('mhbj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mhbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mhbj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amhi801_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhbj_d[l_ac].mhbjsite = g_detail_multi_table_t.mhbjlsite AND
         g_mhbj_d[l_ac].mhbj003 = g_detail_multi_table_t.mhbjl003 AND
         g_mhbj_d[l_ac].mhbj005 = g_detail_multi_table_t.mhbjl005 AND
         g_mhbj_d[l_ac].mhbjl007 = g_detail_multi_table_t.mhbjl007 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbjlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhbj_d[l_ac].mhbjsite
            LET l_field_keys[02] = 'mhbjlsite'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbjlsite
            LET l_var_keys[03] = g_mhbj_d[l_ac].mhbj003
            LET l_field_keys[03] = 'mhbjl003'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbjl003
            LET l_var_keys[04] = g_mhbj_d[l_ac].mhbj005
            LET l_field_keys[04] = 'mhbjl005'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbjl005
            LET l_var_keys[05] = g_dlang
            LET l_field_keys[05] = 'mhbjl006'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhbjl006
            LET l_vars[01] = g_mhbj_d[l_ac].mhbjl007
            LET l_fields[01] = 'mhbjl007'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbjl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (mhbjsite = '", g_mhbj_d[l_ac].mhbjsite, "' "
                                  ," AND mhbj003 = '", g_mhbj_d[l_ac].mhbj003, "' "
                                  ," AND mhbj005 = '", g_mhbj_d[l_ac].mhbj005, "' "
 
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
               
               DELETE FROM mhbj_t
                WHERE mhbjent = g_enterprise AND 
                      mhbjsite = g_mhbj_d_t.mhbjsite
                      AND mhbj003 = g_mhbj_d_t.mhbj003
                      AND mhbj005 = g_mhbj_d_t.mhbj005
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mhbj_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhbjlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhbjlsite'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbjlsite
                  LET l_field_keys[03] = 'mhbjl003'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbjl003
                  LET l_field_keys[04] = 'mhbjl005'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbjl005
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbjl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL amhi801_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_mhbj_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE amhi801_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_mhbj_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbj_d_t.mhbjsite
               LET gs_keys[2] = g_mhbj_d_t.mhbj003
               LET gs_keys[3] = g_mhbj_d_t.mhbj005
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amhi801_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL amhi801_delete_b('mhbj_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_mhbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjsite
            
            #add-point:AFTER FIELD mhbjsite name="input.a.page1.mhbjsite"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mhbj_d[g_detail_idx].mhbjsite IS NOT NULL AND g_mhbj_d[g_detail_idx].mhbj003 IS NOT NULL AND g_mhbj_d[g_detail_idx].mhbj005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhbj_d[g_detail_idx].mhbjsite != g_mhbj_d_t.mhbjsite OR g_mhbj_d[g_detail_idx].mhbj003 != g_mhbj_d_t.mhbj003 OR g_mhbj_d[g_detail_idx].mhbj005 != g_mhbj_d_t.mhbj005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbj_t WHERE "||"mhbjent = '" ||g_enterprise|| "' AND "||"mhbjsite = '"||g_mhbj_d[g_detail_idx].mhbjsite ||"' AND "|| "mhbj003 = '"||g_mhbj_d[g_detail_idx].mhbj003 ||"' AND "|| "mhbj005 = '"||g_mhbj_d[g_detail_idx].mhbj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #160713-00018#1 20160714 add by beckxie---S
            LET g_mhbj_d[l_ac].mhbjsite_desc = ''
            IF NOT cl_null(g_mhbj_d[l_ac].mhbjsite) THEN
               IF g_mhbj_d[l_ac].mhbjsite != g_mhbj_d_o.mhbjsite OR cl_null(g_mhbj_d_o.mhbjsite) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbj_d[l_ac].mhbjsite
                  IF NOT cl_chk_exist("v_ooef001_11") THEN
                     LET g_mhbj_d[l_ac].mhbjsite = g_mhbj_d_o.mhbjsite
                     CALL amhi801_mhbjsite_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00008#2 20161017 add by beckxie---S
                  CALL s_aooi500_chk(g_prog,'mhbjsite',g_mhbj_d[l_ac].mhbjsite,g_mhbj_d[l_ac].mhbjsite)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_mhbj_d[l_ac].mhbjsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mhbj_d[l_ac].mhbjsite = g_mhbj_d_o.mhbjsite
                     CALL amhi801_mhbjsite_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #161006-00008#2 20161017 add by beckxie---E
               END IF
            END IF
            
            LET g_mhbj_d_o.mhbjsite = g_mhbj_d[l_ac].mhbjsite
            CALL amhi801_mhbjsite_ref()
            #160713-00018#1 20160714 add by beckxie---E
            
            #CALL amhi801_mhbj005()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjsite
            #add-point:BEFORE FIELD mhbjsite name="input.b.page1.mhbjsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbjsite
            #add-point:ON CHANGE mhbjsite name="input.g.page1.mhbjsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj001
            
            #add-point:AFTER FIELD mhbj001 name="input.a.page1.mhbj001"
            LET g_mhbj_d[l_ac].mhbj001_desc = ' '
            DISPLAY BY NAME g_mhbj_d[l_ac].mhbj001_desc
            IF NOT cl_null(g_mhbj_d[l_ac].mhbj001) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mhbj_d[l_ac].mhbj001 != g_mhbj_d_t.mhbj001 OR g_mhbj_d_t.mhbj001 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbj_d[l_ac].mhbj001
                  LET g_chkparam.arg2 = g_mhbj_d[l_ac].mhbjsite
                  IF NOT cl_chk_exist("v_mhaa001") THEN
                     LET g_mhbj_d[l_ac].mhbj001 = g_mhbj_d_t.mhbj001
                     CALL amhi801_mhbj001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amhi801_mhbj001_ref()   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj001
            #add-point:BEFORE FIELD mhbj001 name="input.b.page1.mhbj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbj001
            #add-point:ON CHANGE mhbj001 name="input.g.page1.mhbj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj002
            
            #add-point:AFTER FIELD mhbj002 name="input.a.page1.mhbj002"
            LET g_mhbj_d[l_ac].mhbj002_desc = ' '
            DISPLAY BY NAME g_mhbj_d[l_ac].mhbj002_desc
            IF NOT cl_null(g_mhbj_d[l_ac].mhbj001) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mhbj_d[l_ac].mhbj002 != g_mhbj_d_t.mhbj002 OR g_mhbj_d_t.mhbj002 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mhbj_d[l_ac].mhbj002
                  LET g_chkparam.arg2 = g_mhbj_d[l_ac].mhbj001
                  IF NOT cl_chk_exist("v_mhab002") THEN
                     LET g_mhbj_d[l_ac].mhbj002 = g_mhbj_d_t.mhbj002
                     CALL amhi801_mhbj002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amhi801_mhbj002_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj002
            #add-point:BEFORE FIELD mhbj002 name="input.b.page1.mhbj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbj002
            #add-point:ON CHANGE mhbj002 name="input.g.page1.mhbj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj003
            #add-point:BEFORE FIELD mhbj003 name="input.b.page1.mhbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj003
            
            #add-point:AFTER FIELD mhbj003 name="input.a.page1.mhbj003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mhbj_d[g_detail_idx].mhbjsite IS NOT NULL AND g_mhbj_d[g_detail_idx].mhbj003 IS NOT NULL AND g_mhbj_d[g_detail_idx].mhbj005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhbj_d[g_detail_idx].mhbjsite != g_mhbj_d_t.mhbjsite OR g_mhbj_d[g_detail_idx].mhbj003 != g_mhbj_d_t.mhbj003 OR g_mhbj_d[g_detail_idx].mhbj005 != g_mhbj_d_t.mhbj005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbj_t WHERE "||"mhbjent = '" ||g_enterprise|| "' AND "||"mhbjsite = '"||g_mhbj_d[g_detail_idx].mhbjsite ||"' AND "|| "mhbj003 = '"||g_mhbj_d[g_detail_idx].mhbj003 ||"' AND "|| "mhbj005 = '"||g_mhbj_d[g_detail_idx].mhbj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #取得版本資訊
            CALL amhi801_mhbj005()


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbj003
            #add-point:ON CHANGE mhbj003 name="input.g.page1.mhbj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj005
            #add-point:BEFORE FIELD mhbj005 name="input.b.page1.mhbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj005
            
            #add-point:AFTER FIELD mhbj005 name="input.a.page1.mhbj005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mhbj_d[g_detail_idx].mhbjsite IS NOT NULL AND g_mhbj_d[g_detail_idx].mhbj003 IS NOT NULL AND g_mhbj_d[g_detail_idx].mhbj005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mhbj_d[g_detail_idx].mhbjsite != g_mhbj_d_t.mhbjsite OR g_mhbj_d[g_detail_idx].mhbj003 != g_mhbj_d_t.mhbj003 OR g_mhbj_d[g_detail_idx].mhbj005 != g_mhbj_d_t.mhbj005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mhbj_t WHERE "||"mhbjent = '" ||g_enterprise|| "' AND "||"mhbjsite = '"||g_mhbj_d[g_detail_idx].mhbjsite ||"' AND "|| "mhbj003 = '"||g_mhbj_d[g_detail_idx].mhbj003 ||"' AND "|| "mhbj005 = '"||g_mhbj_d[g_detail_idx].mhbj005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbj005
            #add-point:ON CHANGE mhbj005 name="input.g.page1.mhbj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjl007
            #add-point:BEFORE FIELD mhbjl007 name="input.b.page1.mhbjl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjl007
            
            #add-point:AFTER FIELD mhbjl007 name="input.a.page1.mhbjl007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbjl007
            #add-point:ON CHANGE mhbjl007 name="input.g.page1.mhbjl007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj006
            #add-point:BEFORE FIELD mhbj006 name="input.b.page1.mhbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj006
            
            #add-point:AFTER FIELD mhbj006 name="input.a.page1.mhbj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbj006
            #add-point:ON CHANGE mhbj006 name="input.g.page1.mhbj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbj007
            #add-point:BEFORE FIELD mhbj007 name="input.b.page1.mhbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbj007
            
            #add-point:AFTER FIELD mhbj007 name="input.a.page1.mhbj007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbj007
            #add-point:ON CHANGE mhbj007 name="input.g.page1.mhbj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjstus
            #add-point:BEFORE FIELD mhbjstus name="input.b.page1.mhbjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjstus
            
            #add-point:AFTER FIELD mhbjstus name="input.a.page1.mhbjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbjstus
            #add-point:ON CHANGE mhbjstus name="input.g.page1.mhbjstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhbjunit
            #add-point:BEFORE FIELD mhbjunit name="input.b.page1.mhbjunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhbjunit
            
            #add-point:AFTER FIELD mhbjunit name="input.a.page1.mhbjunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mhbjunit
            #add-point:ON CHANGE mhbjunit name="input.g.page1.mhbjunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mhbjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjsite
            #add-point:ON ACTION controlp INFIELD mhbjsite name="input.c.page1.mhbjsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbj_d[l_ac].mhbjsite             #給予default值
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mhbjsite',g_site,'i')   #161006-00008#2 20161017 add by beckxie
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_24()                                #呼叫開窗
 
            LET g_mhbj_d[l_ac].mhbjsite = g_qryparam.return1              

            DISPLAY g_mhbj_d[l_ac].mhbjsite TO mhbjsite              #

            NEXT FIELD mhbjsite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj001
            #add-point:ON ACTION controlp INFIELD mhbj001 name="input.c.page1.mhbj001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbj_d[l_ac].mhbj001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

         
            CALL q_mhaa001()                                #呼叫開窗
 
            LET g_mhbj_d[l_ac].mhbj001 = g_qryparam.return1              

            DISPLAY g_mhbj_d[l_ac].mhbj001 TO mhbj001              #

            NEXT FIELD mhbj001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj002
            #add-point:ON ACTION controlp INFIELD mhbj002 name="input.c.page1.mhbj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mhbj_d[l_ac].mhbj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_mhab002()                                #呼叫開窗
 
            LET g_mhbj_d[l_ac].mhbj002 = g_qryparam.return1              

            DISPLAY g_mhbj_d[l_ac].mhbj002 TO mhbj002              #

            NEXT FIELD mhbj002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj003
            #add-point:ON ACTION controlp INFIELD mhbj003 name="input.c.page1.mhbj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj005
            #add-point:ON ACTION controlp INFIELD mhbj005 name="input.c.page1.mhbj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbjl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjl007
            #add-point:ON ACTION controlp INFIELD mhbjl007 name="input.c.page1.mhbjl007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj006
            #add-point:ON ACTION controlp INFIELD mhbj006 name="input.c.page1.mhbj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbj007
            #add-point:ON ACTION controlp INFIELD mhbj007 name="input.c.page1.mhbj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjstus
            #add-point:ON ACTION controlp INFIELD mhbjstus name="input.c.page1.mhbjstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mhbjunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhbjunit
            #add-point:ON ACTION controlp INFIELD mhbjunit name="input.c.page1.mhbjunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE amhi801_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_mhbj_d[l_ac].* = g_mhbj_d_t.*
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
               LET g_errparam.extend = g_mhbj_d[l_ac].mhbjsite 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mhbj_d[l_ac].* = g_mhbj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_mhbj2_d[l_ac].mhbjmodid = g_user 
LET g_mhbj2_d[l_ac].mhbjmoddt = cl_get_current()
LET g_mhbj2_d[l_ac].mhbjmodid_desc = cl_get_username(g_mhbj2_d[l_ac].mhbjmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL amhi801_mhbj_t_mask_restore('restore_mask_o')
 
               UPDATE mhbj_t SET (mhbjsite,mhbj001,mhbj002,mhbj003,mhbj005,mhbj006,mhbj007,mhbjstus, 
                   mhbjunit,mhbjownid,mhbjowndp,mhbjcrtid,mhbjcrtdp,mhbjcrtdt,mhbjmodid,mhbjmoddt) = (g_mhbj_d[l_ac].mhbjsite, 
                   g_mhbj_d[l_ac].mhbj001,g_mhbj_d[l_ac].mhbj002,g_mhbj_d[l_ac].mhbj003,g_mhbj_d[l_ac].mhbj005, 
                   g_mhbj_d[l_ac].mhbj006,g_mhbj_d[l_ac].mhbj007,g_mhbj_d[l_ac].mhbjstus,g_mhbj_d[l_ac].mhbjunit, 
                   g_mhbj2_d[l_ac].mhbjownid,g_mhbj2_d[l_ac].mhbjowndp,g_mhbj2_d[l_ac].mhbjcrtid,g_mhbj2_d[l_ac].mhbjcrtdp, 
                   g_mhbj2_d[l_ac].mhbjcrtdt,g_mhbj2_d[l_ac].mhbjmodid,g_mhbj2_d[l_ac].mhbjmoddt)
                WHERE mhbjent = g_enterprise AND
                  mhbjsite = g_mhbj_d_t.mhbjsite #項次   
                  AND mhbj003 = g_mhbj_d_t.mhbj003  
                  AND mhbj005 = g_mhbj_d_t.mhbj005  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mhbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbj_d[g_detail_idx].mhbjsite
               LET gs_keys_bak[1] = g_mhbj_d_t.mhbjsite
               LET gs_keys[2] = g_mhbj_d[g_detail_idx].mhbj003
               LET gs_keys_bak[2] = g_mhbj_d_t.mhbj003
               LET gs_keys[3] = g_mhbj_d[g_detail_idx].mhbj005
               LET gs_keys_bak[3] = g_mhbj_d_t.mhbj005
               CALL amhi801_update_b('mhbj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_mhbj_d[l_ac].mhbjsite = g_detail_multi_table_t.mhbjlsite AND
         g_mhbj_d[l_ac].mhbj003 = g_detail_multi_table_t.mhbjl003 AND
         g_mhbj_d[l_ac].mhbj005 = g_detail_multi_table_t.mhbjl005 AND
         g_mhbj_d[l_ac].mhbjl007 = g_detail_multi_table_t.mhbjl007 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mhbjlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mhbj_d[l_ac].mhbjsite
            LET l_field_keys[02] = 'mhbjlsite'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbjlsite
            LET l_var_keys[03] = g_mhbj_d[l_ac].mhbj003
            LET l_field_keys[03] = 'mhbjl003'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbjl003
            LET l_var_keys[04] = g_mhbj_d[l_ac].mhbj005
            LET l_field_keys[04] = 'mhbjl005'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbjl005
            LET l_var_keys[05] = g_dlang
            LET l_field_keys[05] = 'mhbjl006'
            LET l_var_keys_bak[05] = g_detail_multi_table_t.mhbjl006
            LET l_vars[01] = g_mhbj_d[l_ac].mhbjl007
            LET l_fields[01] = 'mhbjl007'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mhbjl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_mhbj_d_t)
                     LET g_log2 = util.JSON.stringify(g_mhbj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amhi801_mhbj_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL amhi801_unlock_b("mhbj_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mhbj_d[l_ac].* = g_mhbj_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            CALL cl_multitable_unlock()
             #add-point:單身after row name="input.body.a_row"
            #檢查是否有上一版本
            CALL amhi801_mhbj003_chk() RETURNING l_success,l_mhbj005
            #如有上版本 更新上一版本的失效日
            IF l_success THEN
               IF NOT amhi801_mhbj007_upd(l_mhbj005) THEN
                  RETURN
               END IF 
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
               LET g_mhbj_d[li_reproduce_target].* = g_mhbj_d[li_reproduce].*
               LET g_mhbj2_d[li_reproduce_target].* = g_mhbj2_d[li_reproduce].*
 
               LET g_mhbj_d[li_reproduce_target].mhbjsite = NULL
               LET g_mhbj_d[li_reproduce_target].mhbj003 = NULL
               LET g_mhbj_d[li_reproduce_target].mhbj005 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mhbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mhbj_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_mhbj2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL amhi801_b_fill(g_wc2)
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
               NEXT FIELD mhbjsite
            WHEN "s_detail2"
               NEXT FIELD mhbjsite_2
 
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
      IF INT_FLAG OR cl_null(g_mhbj_d[g_detail_idx].mhbjsite) THEN
         CALL g_mhbj_d.deleteElement(g_detail_idx)
         CALL g_mhbj2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_mhbj_d[g_detail_idx].* = g_mhbj_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE amhi801_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="amhi801.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amhi801_delete()
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
   FOR li_idx = 1 TO g_mhbj_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT amhi801_lock_b("mhbj_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("mhbj_t","mhbjownid") THEN
            LET g_data_owner = g_mhbj2_d[g_detail_idx].mhbjownid
            LET g_data_dept = g_mhbj2_d[g_detail_idx].mhbjowndp
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
   
   FOR li_idx = 1 TO g_mhbj_d.getLength()
      IF g_mhbj_d[li_idx].mhbjsite IS NOT NULL
         AND g_mhbj_d[li_idx].mhbj003 IS NOT NULL
         AND g_mhbj_d[li_idx].mhbj005 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM mhbj_t
          WHERE mhbjent = g_enterprise AND 
                mhbjsite = g_mhbj_d[li_idx].mhbjsite
                AND mhbj003 = g_mhbj_d[li_idx].mhbj003
                AND mhbj005 = g_mhbj_d[li_idx].mhbj005
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.mhbjlsite = g_mhbj_d[l_ac].mhbjsite
LET g_detail_multi_table_t.mhbjl003 = g_mhbj_d[l_ac].mhbj003
LET g_detail_multi_table_t.mhbjl005 = g_mhbj_d[l_ac].mhbj005
LET g_detail_multi_table_t.mhbjl006 = g_dlang
LET g_detail_multi_table_t.mhbjl007 = g_mhbj_d[l_ac].mhbjl007
 
 
            
LET g_detail_multi_table_t.mhbjlsite = g_mhbj_d[l_ac].mhbjsite
LET g_detail_multi_table_t.mhbjl003 = g_mhbj_d[l_ac].mhbj003
LET g_detail_multi_table_t.mhbjl005 = g_mhbj_d[l_ac].mhbj005
LET g_detail_multi_table_t.mhbjl006 = g_dlang
LET g_detail_multi_table_t.mhbjl007 = g_mhbj_d[l_ac].mhbjl007
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhbjlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhbjlsite'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbjlsite
                  LET l_field_keys[03] = 'mhbjl003'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbjl003
                  LET l_field_keys[04] = 'mhbjl005'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbjl005
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbjl_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'mhbjlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'mhbjlsite'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.mhbjlsite
                  LET l_field_keys[03] = 'mhbjl003'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.mhbjl003
                  LET l_field_keys[04] = 'mhbjl005'
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.mhbjl005
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mhbjl_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mhbj_d_t.mhbjsite
               LET gs_keys[2] = g_mhbj_d_t.mhbj003
               LET gs_keys[3] = g_mhbj_d_t.mhbj005
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL amhi801_delete_b('mhbj_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amhi801_set_pk_array()
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
   CALL amhi801_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="amhi801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amhi801_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where  STRING   #161006-00008#2 20161017 add by beckxie
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   #161006-00008#2 20161017 add by beckxie---S
   LET l_where = s_aooi500_sql_where(g_prog,'mhbjsite')
   LET p_wc2 = p_wc2 CLIPPED," AND ",l_where
   #161006-00008#2 20161017 add by beckxie---E
   
   IF g_set_detail = 0 THEN
      LET p_wc2 = p_wc2, " AND mhbjsite = '",g_ooed004,"'"
   END IF
   LET g_set_detail = 1
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.mhbjsite,t0.mhbj001,t0.mhbj002,t0.mhbj003,t0.mhbj005,t0.mhbj006, 
       t0.mhbj007,t0.mhbjstus,t0.mhbjunit,t0.mhbjsite,t0.mhbj003,t0.mhbj005,t0.mhbjownid,t0.mhbjowndp, 
       t0.mhbjcrtid,t0.mhbjcrtdp,t0.mhbjcrtdt,t0.mhbjmodid,t0.mhbjmoddt ,t1.ooefl003 ,t2.mhaal003 ,t3.mhabl004 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 FROM mhbj_t t0",
               " LEFT JOIN mhbjl_t ON mhbjlent = "||g_enterprise||" AND mhbjsite = mhbjlsite AND mhbj003 = mhbjl003 AND mhbj005 = mhbjl005 AND mhbjl006 = '",g_dlang,"'",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mhbjsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhaal_t t2 ON t2.mhaalent="||g_enterprise||" AND t2.mhaal001=t0.mhbj001 AND t2.mhaal002='"||g_dlang||"' ",
               " LEFT JOIN mhabl_t t3 ON t3.mhablent="||g_enterprise||" AND t3.mhabl001=t0.mhbj001 AND t3.mhabl002=t0.mhbj002 AND t3.mhabl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mhbjownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mhbjowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mhbjcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mhbjcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mhbjmodid  ",
 
               " WHERE t0.mhbjent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("mhbj_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND mhbjowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("mhbj_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND mhbjownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("mhbj_t"),
                      " ORDER BY t0.mhbjsite,t0.mhbj003,t0.mhbj005"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"mhbj_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE amhi801_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR amhi801_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mhbj_d.clear()
   CALL g_mhbj2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_mhbj_d[l_ac].mhbjsite,g_mhbj_d[l_ac].mhbj001,g_mhbj_d[l_ac].mhbj002,g_mhbj_d[l_ac].mhbj003, 
       g_mhbj_d[l_ac].mhbj005,g_mhbj_d[l_ac].mhbj006,g_mhbj_d[l_ac].mhbj007,g_mhbj_d[l_ac].mhbjstus, 
       g_mhbj_d[l_ac].mhbjunit,g_mhbj2_d[l_ac].mhbjsite,g_mhbj2_d[l_ac].mhbj003,g_mhbj2_d[l_ac].mhbj005, 
       g_mhbj2_d[l_ac].mhbjownid,g_mhbj2_d[l_ac].mhbjowndp,g_mhbj2_d[l_ac].mhbjcrtid,g_mhbj2_d[l_ac].mhbjcrtdp, 
       g_mhbj2_d[l_ac].mhbjcrtdt,g_mhbj2_d[l_ac].mhbjmodid,g_mhbj2_d[l_ac].mhbjmoddt,g_mhbj_d[l_ac].mhbjsite_desc, 
       g_mhbj_d[l_ac].mhbj001_desc,g_mhbj_d[l_ac].mhbj002_desc,g_mhbj2_d[l_ac].mhbjownid_desc,g_mhbj2_d[l_ac].mhbjowndp_desc, 
       g_mhbj2_d[l_ac].mhbjcrtid_desc,g_mhbj2_d[l_ac].mhbjcrtdp_desc,g_mhbj2_d[l_ac].mhbjmodid_desc
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
      
      CALL amhi801_detail_show()      
 
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
   
 
   
   CALL g_mhbj_d.deleteElement(g_mhbj_d.getLength())   
   CALL g_mhbj2_d.deleteElement(g_mhbj2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_mhbj_d.getLength()
      LET g_mhbj2_d[l_ac].mhbjsite = g_mhbj_d[l_ac].mhbjsite 
      LET g_mhbj2_d[l_ac].mhbj003 = g_mhbj_d[l_ac].mhbj003 
      LET g_mhbj2_d[l_ac].mhbj005 = g_mhbj_d[l_ac].mhbj005 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_mhbj_d.getLength() THEN
      LET l_ac = g_mhbj_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_mhbj_d.getLength()
      LET g_mhbj_d_mask_o[l_ac].* =  g_mhbj_d[l_ac].*
      CALL amhi801_mhbj_t_mask()
      LET g_mhbj_d_mask_n[l_ac].* =  g_mhbj_d[l_ac].*
   END FOR
   
   LET g_mhbj2_d_mask_o.* =  g_mhbj2_d.*
   FOR l_ac = 1 TO g_mhbj2_d.getLength()
      LET g_mhbj2_d_mask_o[l_ac].* =  g_mhbj2_d[l_ac].*
      CALL amhi801_mhbj_t_mask()
      LET g_mhbj2_d_mask_n[l_ac].* =  g_mhbj2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_mhbj_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE amhi801_pb
   
END FUNCTION
 
{</section>}
 
{<section id="amhi801.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION amhi801_detail_show()
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
   LET g_ref_fields[1] = g_mhbj_d[l_ac].mhbjsite
   LET g_ref_fields[2] = g_mhbj_d[l_ac].mhbj003
   LET g_ref_fields[3] = g_mhbj_d[l_ac].mhbj005
   CALL ap_ref_array2(g_ref_fields," SELECT mhbjl007 FROM mhbjl_t WHERE mhbjlent = '"||g_enterprise||"' AND mhbjlsite = ? AND mhbjl003 = ? AND mhbjl005 = ? AND mhbjl006 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mhbj_d[l_ac].mhbjl007 = g_rtn_fields[1] 
   DISPLAY BY NAME g_mhbj_d[l_ac].mhbjl007
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amhi801.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amhi801_set_entry_b(p_cmd)                                                  
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
 
{<section id="amhi801.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amhi801_set_no_entry_b(p_cmd)                                               
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
 
{<section id="amhi801.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amhi801_default_search()
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
      LET ls_wc = ls_wc, " mhbjsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " mhbj003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " mhbj005 = '", g_argv[03], "' AND "
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
 
{<section id="amhi801.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amhi801_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "mhbj_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'mhbj_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM mhbj_t
          WHERE mhbjent = g_enterprise AND
            mhbjsite = ps_keys_bak[1] AND mhbj003 = ps_keys_bak[2] AND mhbj005 = ps_keys_bak[3]
         
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
         CALL g_mhbj_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_mhbj2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="amhi801.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amhi801_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "mhbj_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO mhbj_t
                  (mhbjent,
                   mhbjsite,mhbj003,mhbj005
                   ,mhbj001,mhbj002,mhbj006,mhbj007,mhbjstus,mhbjunit,mhbjownid,mhbjowndp,mhbjcrtid,mhbjcrtdp,mhbjcrtdt,mhbjmodid,mhbjmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mhbj_d[l_ac].mhbj001,g_mhbj_d[l_ac].mhbj002,g_mhbj_d[l_ac].mhbj006,g_mhbj_d[l_ac].mhbj007, 
                       g_mhbj_d[l_ac].mhbjstus,g_mhbj_d[l_ac].mhbjunit,g_mhbj2_d[l_ac].mhbjownid,g_mhbj2_d[l_ac].mhbjowndp, 
                       g_mhbj2_d[l_ac].mhbjcrtid,g_mhbj2_d[l_ac].mhbjcrtdp,g_mhbj2_d[l_ac].mhbjcrtdt, 
                       g_mhbj2_d[l_ac].mhbjmodid,g_mhbj2_d[l_ac].mhbjmoddt)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mhbj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="amhi801.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amhi801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "mhbj_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "mhbj_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE mhbj_t 
         SET (mhbjsite,mhbj003,mhbj005
              ,mhbj001,mhbj002,mhbj006,mhbj007,mhbjstus,mhbjunit,mhbjownid,mhbjowndp,mhbjcrtid,mhbjcrtdp,mhbjcrtdt,mhbjmodid,mhbjmoddt) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mhbj_d[l_ac].mhbj001,g_mhbj_d[l_ac].mhbj002,g_mhbj_d[l_ac].mhbj006,g_mhbj_d[l_ac].mhbj007, 
                  g_mhbj_d[l_ac].mhbjstus,g_mhbj_d[l_ac].mhbjunit,g_mhbj2_d[l_ac].mhbjownid,g_mhbj2_d[l_ac].mhbjowndp, 
                  g_mhbj2_d[l_ac].mhbjcrtid,g_mhbj2_d[l_ac].mhbjcrtdp,g_mhbj2_d[l_ac].mhbjcrtdt,g_mhbj2_d[l_ac].mhbjmodid, 
                  g_mhbj2_d[l_ac].mhbjmoddt) 
         WHERE mhbjent = g_enterprise AND mhbjsite = ps_keys_bak[1] AND mhbj003 = ps_keys_bak[2] AND mhbj005 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mhbj_t:",SQLERRMESSAGE 
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
 
{<section id="amhi801.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amhi801_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL amhi801_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "mhbj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amhi801_bcl USING g_enterprise,
                                       g_mhbj_d[g_detail_idx].mhbjsite,g_mhbj_d[g_detail_idx].mhbj003, 
                                           g_mhbj_d[g_detail_idx].mhbj005
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amhi801_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amhi801.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amhi801_unlock_b(ps_table)
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
      CLOSE amhi801_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amhi801.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION amhi801_modify_detail_chk(ps_record)
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
         LET ls_return = "mhbjsite"
      WHEN "s_detail2"
         LET ls_return = "mhbjsite_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="amhi801.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION amhi801_show_ownid_msg()
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
 
{<section id="amhi801.mask_functions" >}
&include "erp/amh/amhi801_mask.4gl"
 
{</section>}
 
{<section id="amhi801.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amhi801_set_pk_array()
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
   LET g_pk_array[1].values = g_mhbj_d[l_ac].mhbjsite
   LET g_pk_array[1].column = 'mhbjsite'
   LET g_pk_array[2].values = g_mhbj_d[l_ac].mhbj003
   LET g_pk_array[2].column = 'mhbj003'
   LET g_pk_array[3].values = g_mhbj_d[l_ac].mhbj005
   LET g_pk_array[3].column = 'mhbj005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amhi801.state_change" >}
   
 
{</section>}
 
{<section id="amhi801.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="amhi801.other_function" readonly="Y" >}

################################################################################
# Descriptions...: Tree:瀏覽頁籤設定
# Memo...........:
# Usage..........: CALL amhi801_browser_fill(p_wc)
# Input parameter: p_wc      查詢條件   
# Return code....: 
# Date & Author..: 2016-05-10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_browser_fill(p_wc)
DEFINE p_wc       STRING
DEFINE l_idx      LIKE type_t.num10
DEFINE l_n        LIKE type_t.num5
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE l_sql      STRING
DEFINE l_n2       LIKE type_t.num5

   CALL g_tree.clear()
   LET g_cnt = 1
   LET l_n = 1
   #第一層的資料
   LET l_sql = " SELECT UNIQUE ooed002,ooed003 FROM ooed_t ",
               "  WHERE ooedent = '",g_enterprise,"'",
               "    AND ooed001 = '1' ",
               "    AND ooed006 <= '",g_today,"' ",
               "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ",
               "  ORDER BY ooed002 "
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   LET l_sql = " SELECT UNIQUE ooed004,ooed003 FROM ooed_t ",
               "  WHERE ooedent = '",g_enterprise,"'",
               "    AND ooed001 = '1' ",
               "    AND ooed006 <= '",g_today,"' ",
               "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ",
               "    AND ooed002 = ? ",
               "    AND ooed003 = ? ",
               "    AND ooed002 = ooed005 ",
               "    AND ooed004 <> ooed005 ",
               "  ORDER BY ooed004 "
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1

   INITIALIZE g_browser_root TO NULL
   #初始化l_idx
   LET l_idx = 1
   FOREACH master_typecur_0 INTO g_tree[l_idx].b_ooed002,g_tree[l_idx].b_ooed003
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_idx
      #此處(LV-1)
      LET g_tree[l_idx].b_ooed002 = g_tree[l_idx].b_ooed002
      LET g_tree[l_idx].b_pid = '0' CLIPPED
      LET g_tree[l_idx].b_id = l_idx USING "<<<"
      LET g_tree[l_idx].b_exp = TRUE
      LET g_tree[l_idx].b_hasC = TRUE
      LET g_tree[l_idx].b_isExp = TRUE
      #第一層節點編號
      LET l_pid = g_tree[l_idx].b_id CLIPPED
      LET l_idx = l_idx + 1
      LET g_cnt = l_idx
      FOREACH master_typecur_1 USING g_tree[l_idx-1].b_ooed002,g_tree[l_idx-1].b_ooed003 INTO g_tree[g_cnt].b_ooed004,g_tree[g_cnt].b_ooed003
         LET g_tree[g_cnt].b_ooed002 = g_tree[l_idx-1].b_ooed002
         LET g_tree[g_cnt].b_ooed004 = g_tree[g_cnt].b_ooed004
         LET g_tree[g_cnt].b_ooed005 = g_tree[l_idx-1].b_ooed004
         LET g_tree[g_cnt].b_pid = l_pid
         LET g_tree[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
         LET g_tree[g_cnt].b_exp = TRUE
         LET g_tree[g_cnt].b_hasC = amhi801_chk_hasC(g_cnt)
         IF g_tree[g_cnt].b_hasC = 1 THEN
            CALL amhi801_browser_expand(g_cnt,p_wc)
            LET g_cnt = g_tree.getLength()
         END IF
         LET g_cnt = g_cnt +1
      END FOREACH
      LET l_idx = g_tree.getLength()
   END FOREACH
   LET l_idx = l_idx - 1
   CALL g_tree.deleteElement(l_idx+1)
   FOR l_idx = 1 TO g_tree.getLength()
       CALL amhi801_desc_show(l_idx)
   END FOR

   LET g_browser_cnt = g_tree.getLength() - g_browser_root.getLength()

   FREE master_type_0
   FREE master_type_1
   
   FOR l_n2 = 1 TO g_tree.getLength()
       IF g_tree[l_n2].b_isExp is null THEN
         CALL amhi801_browser_expand(l_n2,p_wc)
      END IF
   END FOR   
   
   
   
   
   
   
   
   
   #DEFINE p_wc       STRING 
   #DEFINE l_idx      LIKE type_t.num10
   #DEFINE l_idx2     LIKE type_t.num10
   #DEFINE l_idx3     LIKE type_t.num10
   #DEFINE l_sql      STRING
   #DEFINE l_expanded LIKE type_t.chr1
   #
   #CALL g_tree.clear()
   #CLEAR FORM
   #
   #LET l_sql = " SELECT UNIQUE ooed002 FROM ooed_t ",
   #            "  WHERE ooedent = ",g_enterprise,
   #            "    AND ooed001 = '1' ",
   #            "    AND ooed006 <= '",g_today,"' ",
   #            "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ",
   #            "  ORDER BY ooed002 "
   #PREPARE tree_pre FROM l_sql
   #DECLARE tree_cur CURSOR FOR tree_pre
   #
   #LET l_sql = " SELECT expanded FROM amhi801_ooed_t WHERE ooed002 = ? "   
   #PREPARE tree_stus FROM l_sql  
   #
   #LET l_idx = 1 
   #FOREACH tree_cur INTO g_tree[l_idx].b_ooed002
   #   LET g_tree[l_idx].b_pid     = 0
   #   LET g_tree[l_idx].b_id      = 0, ".", l_idx USING "<<<"
   #   LET g_tree[l_idx].b_exp     = FALSE
   #   LET g_tree[l_idx].b_expcode = 1
   #   LET g_tree[l_idx].b_hasC    = FALSE
   #   LET g_tree[l_idx].b_show    = g_tree[l_idx].b_ooed002
   #   LET g_tree[l_idx].b_isexp   = FALSE
   #   
   #   CALL amhi801_desc_show(l_idx)
   #   
   #   LET l_idx = l_idx + 1
   #   
   #   IF l_idx > g_max_rec AND g_error_show = 1 THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code =  9035
   #      LET g_errparam.extend =  ''
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      EXIT FOREACH
   #   END IF   
   #END FOREACH
   #CALL g_tree.deleteElement(g_tree.getLength()) 
   #
   #LET g_error_show = 0     
   #LET g_browser_cnt = g_tree.getLength()      #總筆數, 有瀏覽頁籤才需要DISPLAY
   #
   #FREE tree_pre
   #
   #FOR l_idx2 = 1 TO g_tree.getLength()
   #   IF g_tree[l_idx2].b_isExp = FALSE THEN
   #       CALL amhi801_browser_expand(l_idx2,p_wc)
   #       LET g_tree[l_idx2].b_isExp = TRUE        
   #   END IF
   #END FOR
   #
   #FOR l_idx3 = 1 TO g_tree.getLength()
   #   #抓取記錄在temp table裡的展開否的值
   #   LET l_expanded = ''
   #   EXECUTE tree_stus USING g_tree[l_idx3].b_ooed002 INTO l_expanded
   #   IF cl_null(l_expanded) THEN
   #      LET l_expanded = '1'
   #   END IF
   #   LET g_tree[l_idx3].b_exp = l_expanded
   #   #程式一執行就讓樹是全部展開的狀態
   #   IF g_first = 0 THEN
   #      LET g_tree[l_idx3].b_exp = '2'          #是否展開 1展開 2不展開
   #      LET g_tree[l_idx3].b_isExp = 1
   #      INSERT INTO amhi801_ooed_t(ooed002,expanded)
   #      VALUES(g_tree[l_idx3].b_ooed002,g_tree[l_idx3].b_exp)             
   #   END IF  
   #END FOR
END FUNCTION

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL amhi801_create_tmp()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/05/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_create_tmp()
   WHENEVER ERROR CONTINUE
   
   CALL amhi801_drop_tmp()
   
   #建立組織暫存檔
   CREATE TEMP TABLE amhi801_ooed_t(
      ooed002   LIKE ooed_t.ooed002,
      expanded  LIKE type_t.chr1)  
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL amhi801_drop_tmp()
# Date & Author..: 2016/05/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_drop_tmp()
   WHENEVER ERROR CONTINUE   

   DROP TABLE amhi801_ooed_t
END FUNCTION

################################################################################
# Descriptions...: Tree:子節點展開
# Memo...........:
# Usage..........: CALL amhi801_browser_expand(p_id,p_wc)
# Input parameter: p_id 
#                  p_wc  
# Return code....: 
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_browser_expand(p_id,p_wc)
DEFINE p_id          LIKE type_t.num10
DEFINE p_wc          STRING
DEFINE l_id          LIKE type_t.num10
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_keyvalue    LIKE type_t.chr50
DEFINE l_typevalue   LIKE type_t.chr50
DEFINE l_type        LIKE type_t.chr50
DEFINE l_sql         LIKE type_t.chr500
DEFINE ls_source     LIKE type_t.chr500
DEFINE ls_exp_code   LIKE type_t.chr500
DEFINE l_return      LIKE type_t.num5

   #若已經展開
   IF g_tree[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET g_tree[p_id].b_isExp = 1 
   LET l_return = FALSE
 
   LET l_keyvalue = g_tree[p_id].b_ooed004
   
         
   LET l_sql = "SELECT UNIQUE ooed004,ooed003 ",
               "  FROM ooed_t ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed005 = '",l_keyvalue,"' ",
               "   AND ooed004 <> ooed005",
               "   AND ooed001 = '1'", 
               "   AND ooed006 <= '",g_today,"' ",
               "   AND ooed002 = '",g_tree[p_id].b_ooed002,"' ",
               "   AND ooed003 = '",g_tree[p_id].b_ooed003,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ",
               " ORDER BY ooed004"
   
   PREPARE tree_expand1 FROM l_sql
   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1
  
   LET l_id = p_id + 1
   CALL g_tree.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur1 INTO g_tree[l_id].b_ooed004,g_tree[l_id].b_ooed003
      IF cl_null(g_tree[l_id].b_ooed004) THEN
         EXIT FOREACH
      END IF
      #pid=父節點id
      LET g_tree[l_id].b_pid  = g_tree[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_tree[l_id].b_id  = g_tree[p_id].b_id||"."||l_cnt
      LET g_tree[l_id].b_exp = TRUE
      LET g_tree[l_id].b_ooed005 = g_tree[p_id].b_ooed004
      LET g_tree[l_id].b_ooed002 = g_tree[p_id].b_ooed002
      #hasC=確認該節點是否有子孫
      CALL amhi801_desc_show(l_id)
      LET g_tree[l_id].b_hasC = amhi801_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_tree.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   LET l_cnt = l_cnt -1
   #刪除空資料
   CALL g_tree.deleteElement(l_id)   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   #DEFINE p_id     LIKE type_t.num10
   #DEFINE p_wc     STRING
   #DEFINE l_lv     LIKE type_t.num10
   #DEFINE l_idx    LIKE type_t.num10
   #DEFINE l_sql    STRING
   #
   #LET l_lv = g_tree[p_id].b_expcode
   #LET g_tree[p_id].b_isExp = TRUE
   #
   #LET l_sql = " SELECT UNIQUE ooed004,ooefl003 FROM ooed_t,ooefl_t ",
   #            "  WHERE ooedent = ooeflent ",
   #            "    AND ooedent = ",g_enterprise," AND (",p_wc,") ",
   #            "    AND ooed004 = ooefl001 ",
   #            "    AND ooed005 = '",g_tree[p_id].b_ooed002,"' ",
   #            "  ORDER BY ooed004 "
   #PREPARE expand_pre FROM l_sql
   #DECLARE expand_cur CURSOR FOR expand_pre
   #
   #LET l_idx = p_id + 1
   #CALL g_tree.insertElement(l_idx)
   #FOREACH expand_cur INTO g_tree[l_idx].b_ooed002,g_tree[l_idx].b_ooefl003
   #   LET g_tree[l_idx].b_pid     = g_tree[p_id].b_id 
   #   LET g_tree[l_idx].b_id      = g_tree[p_id].b_id , ".", l_idx USING "<<<"
   #   LET g_tree[l_idx].b_exp     = FALSE
   #   LET g_tree[l_idx].b_expcode = l_lv + 1
   #   #LET g_tree[l_idx].b_hasC    = FALSE  
   #   LET g_tree[l_idx].b_show    = g_tree[l_idx].b_ooefl003
   #   CALL amhi801_desc_show(l_idx)
   #   LET g_tree[l_idx].b_hasC = amhi801_chk_hasC(l_idx)
   #   IF g_tree[l_idx].b_hasC = 1 THEN
   #      CALL amhi801_browser_expand(l_idx,p_wc)
   #      LET g_cnt = g_tree.getLength()
   #   END IF
   #   LET l_idx = l_idx + 1
   #   CALL g_tree.insertElement(l_idx)      
   #END FOREACH  
   #
   #CALL g_tree.deleteElement(l_idx)   
   #LET g_browser_cnt = g_tree.getLength() 
END FUNCTION

################################################################################
# Descriptions...: Tree:節點說明
# Memo...........:
# Usage..........: CALL amhi801_desc_show(pi_ac)
# Input parameter: pi_ac
# Return code....: 
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_desc_show(pi_ac)
DEFINE pi_ac          LIKE type_t.num5
DEFINE li_tmp         LIKE type_t.num5
DEFINE l_ooed004_desc LIKE type_t.chr80 
DEFINE ls_msg         STRING

   LET li_tmp = l_ac
   LET l_ac = pi_ac
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   
   IF cl_null(g_tree[l_ac].b_ooed004) AND cl_null(g_tree[l_ac].b_ooed005) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[l_ac].b_ooed002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET l_ooed004_desc = g_rtn_fields[1]
      LET ls_msg = cl_getmsg("aoo-00232",g_lang)
      LET g_tree[l_ac].b_show = g_tree[l_ac].b_ooed002,' (',l_ooed004_desc,')','(',ls_msg,g_tree[l_ac].b_ooed003,')'
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[l_ac].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET l_ooed004_desc = g_rtn_fields[1]
      LET g_tree[l_ac].b_show = g_tree[l_ac].b_ooed004,' (',l_ooed004_desc,')'
   END IF   
   
   
   
   
   #DEFINE pi_ac   LIKE type_t.num5
   #DEFINE lc_show     LIKE type_t.chr100
   ##DEFINE l_dbacl004  LIKE dbacl_t.dbacl004
   ##DEFINE l_dbacl005  LIKE dbacl_t.dbacl005
   #
   ##IF cl_null(g_tree[pi_ac].b_ooefl003) THEN 
   #   LET lc_show =  amhi801_ooed002_ref(g_tree[pi_ac].b_ooed002)
   #   #LET g_tree[pi_ac].b_show = lc_show,'(', g_tree[pi_ac].b_ooed002,')'     
   #   LET g_tree[pi_ac].b_show = g_tree[pi_ac].b_ooed002,lc_show
   ##ELSE
   ##   CALL adbi252_dbac001_ref(g_tree[pi_ac].b_dbac001) RETURNING lc_show,l_dbacl004,l_dbacl005 
   ##   LET g_tree[pi_ac].b_show = lc_show,'(', g_tree[pi_ac].b_dbac001,')'   
   ##END IF 
END FUNCTION

################################################################################
# Descriptions...: 營運組織說明
# Memo...........:
# Usage..........: CALL amhi801_ooed002_ref(p_ooed002)
#                  RETURNING r_ooed002_desc
# Input parameter: p_ooed002      營運組織
# Return code....: r_ooed002_desc 營運組織說明
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_ooed002_ref(p_ooed002)
   DEFINE p_ooed002      LIKE ooed_t.ooed002
   DEFINE r_ooed002_desc LIKE ooefl_t.ooefl003
   
   LET r_ooed002_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooed002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooed002_desc = '', g_rtn_fields[1] , ''
   
   IF cl_null(r_ooed002_desc) THEN
      LET r_ooed002_desc = ' '
   END IF
   
   RETURN r_ooed002_desc
END FUNCTION

################################################################################
# Descriptions...: Tree:節點狀態更新為展開
# Memo...........:
# Usage..........: CALL amhi801_node_open(p_ooed002)
# Input parameter: p_ooed002
# Return code....: 
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_node_open(p_ooed002)
   DEFINE p_ooed002   LIKE ooed_t.ooed002
   
   LET g_tree[g_current_row].b_isExp = 1
   
   UPDATE amhi801_ooed_t SET expanded = '1'
    WHERE ooed002 = p_ooed002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF   
END FUNCTION

################################################################################
# Descriptions...: Tree:節點狀態更新為展開
# Memo...........:
# Usage..........: CALL amhi801_node_close(p_ooed002)
# Input parameter: p_ooed002
# Return code....: 
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_node_close(p_ooed002)
   DEFINE p_ooed002   LIKE ooed_t.ooed002
   
   LET g_tree[g_current_row].b_isExp = 0
   
   UPDATE amhi801_ooed_t SET expanded = '0'
    WHERE ooed002 = p_ooed002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
END FUNCTION

################################################################################
# Descriptions...: 檢查是否有下節點
# Memo...........:
# Usage..........: CALL amhi801_chk_hasC(pi_id)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_chk_hasC(pi_id)
DEFINE pi_id    INTEGER
DEFINE li_cnt   INTEGER


   LET g_sql = "SELECT COUNT(*) FROM ooed_t ",
               " WHERE ooedent = '" ||g_enterprise|| "'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed001 = '1' ",
               "   AND ooed006 <= '",g_today,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ", 
               "   AND ooed005 = ? ",
               "   AND ooed002 = ? ",
               "   AND ooed003 = ? "
   PREPARE amhi801_master_chk1 FROM g_sql 
   EXECUTE amhi801_master_chk1 USING g_tree[pi_id].b_ooed004,g_tree[pi_id].b_ooed002,g_tree[pi_id].b_ooed003 INTO li_cnt
   FREE amhi801_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 樓層說明
# Memo...........:
# Usage..........: CALL amhi801_mhbj002_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_mhbj002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbj_d[l_ac].mhbj001
   LET g_ref_fields[2] = g_mhbj_d[l_ac].mhbj002
   CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbj_d[l_ac].mhbj002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbj_d[l_ac].mhbj002_desc
END FUNCTION

################################################################################
# Descriptions...: 樓棟說明
# Memo...........:
# Usage..........: CALL amhi801_mhbj001_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-05-11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_mhbj001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbj_d[l_ac].mhbj001
   CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbj_d[l_ac].mhbj001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbj_d[l_ac].mhbj001_desc
END FUNCTION

################################################################################
# Descriptions...: 圖型版本加1
# Memo...........:
# Usage..........: CALL amhi801_mhbj005()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-05-12 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_mhbj005()
   SELECT MAX(mhbj005)+1 INTO g_mhbj_d[l_ac].mhbj005
     FROM mhbj_t
    WHERE mhbjent = g_enterprise
      AND mhbjsite = g_mhbj_d[l_ac].mhbjsite
      AND mhbj003  = g_mhbj_d[l_ac].mhbj003
   IF cl_null(g_mhbj_d[l_ac].mhbj005) OR g_mhbj_d[l_ac].mhbj005 = 0 THEN
      LET g_mhbj_d[l_ac].mhbj005 = 1
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查圖型編號的版本是否有上一筆
# Memo...........:
# Usage..........: CALL amhi801_mhbj003_chk()
#                  RETURNING r_success,r_mhbj005
# Input parameter: 
# Return code....: r_success        TRUE/FALSE
#                : r_mhbj005        上一版本
# Date & Author..: 2016-05-12 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_mhbj003_chk()
DEFINE l_mhbj005        LIKE mhbj_t.mhbj005
DEFINE l_mhbj005_old    LIKE mhbj_t.mhbj005
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   LET l_mhbj005_old = 1

   IF g_mhbj_d[l_ac].mhbj005 <> 1 THEN
      SELECT mhbj005 - 1 INTO l_mhbj005_old
        FROM mhbj_t
       WHERE mhbjent = g_enterprise
         AND mhbjsite= g_mhbj_d[l_ac].mhbjsite
         AND mhbj003 = g_mhbj_d[l_ac].mhbj003
         AND mhbj005 = g_mhbj_d[l_ac].mhbj005         
   ELSE
      LET r_success = FALSE
   END IF
   
   RETURN r_success,l_mhbj005_old
END FUNCTION

################################################################################
# Descriptions...: 更新上一版本的失效日期
# Memo...........:
# Usage..........: CALL amhi801_mhbj007_upd(p_mhbj005)
#                  RETURNING r_success
# Input parameter: p_mhbj005     版本
# Return code....: r_success     TRUE/FALSE 
# Date & Author..: 2016-05-12 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION amhi801_mhbj007_upd(p_mhbj005)
DEFINE p_mhbj005        LIKE mhbj_t.mhbj005
DEFINE l_yesterday      DATE
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT mhbj006 - 1 INTO l_yesterday
     FROM mhbj_t
    WHERE mhbjent = g_enterprise
      AND mhbjsite= g_mhbj_d[l_ac].mhbjsite
      AND mhbj003 = g_mhbj_d[l_ac].mhbj003
      AND mhbj005 = g_mhbj_d[l_ac].mhbj005
      
   UPDATE mhbj_t SET mhbj007 = l_yesterday
    WHERE mhbjent = g_enterprise
      AND mhbjsite= g_mhbj_d[l_ac].mhbjsite
      AND mhbj003 = g_mhbj_d[l_ac].mhbj003
      AND mhbj005 = p_mhbj005
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "更新上一版本的失效日失敗！"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   
   CALL amhi801_b_fill(g_wc2)
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION amhi801_mhbjsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mhbj_d[l_ac].mhbjsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mhbj_d[l_ac].mhbjsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mhbj_d[l_ac].mhbjsite_desc
END FUNCTION

 
{</section>}
 
