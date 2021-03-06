#該程式未解開Section, 採用最新樣板產出!
{<section id="adbi253.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-01-22 15:45:09), PR版次:0008(2016-11-08 16:15:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000216
#+ Filename...: adbi253
#+ Description: 站點基本資料維護作業
#+ Creator....: 02749(2014-04-29 09:25:59)
#+ Modifier...: 06137 -SD/PR- 02749
 
{</section>}
 
{<section id="adbi253.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161108-00027#1   2016/11/08  By lori        調整g_browser_cnt長度變數定義為num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
#嵌入--
IMPORT FGL aoo_aooi350_01
IMPORT FGL aoo_aooi350_02
#嵌入--
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"
#嵌入--
GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35001      STRING             #聯絡地址QBE條件
   DEFINE g_wc2_i35002      STRING             #通訊方式QBE條件
   DEFINE g_d_idx_i35001    LIKE type_t.num5   #聯絡地址所在筆數
   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #聯絡地址總筆數
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #通訊方式所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #通訊方式總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
END GLOBALS
#嵌入--
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_dbad_d RECORD
       dbadstus LIKE dbad_t.dbadstus, 
   dbad001 LIKE dbad_t.dbad001, 
   dbadl003 LIKE type_t.chr500, 
   dbadl004 LIKE type_t.chr500, 
   dbadl005 LIKE type_t.chr500, 
   dbad002 LIKE dbad_t.dbad002, 
   dbad002_desc LIKE type_t.chr500, 
   l_dbac002 LIKE type_t.chr500, 
   l_dbac002_desc LIKE type_t.chr500, 
   dbad003 LIKE dbad_t.dbad003
       END RECORD
PRIVATE TYPE type_g_dbad2_d RECORD
       dbad001 LIKE dbad_t.dbad001, 
   dbadownid LIKE dbad_t.dbadownid, 
   dbadownid_desc LIKE type_t.chr500, 
   dbadowndp LIKE dbad_t.dbadowndp, 
   dbadowndp_desc LIKE type_t.chr500, 
   dbadcrtid LIKE dbad_t.dbadcrtid, 
   dbadcrtid_desc LIKE type_t.chr500, 
   dbadcrtdp LIKE dbad_t.dbadcrtdp, 
   dbadcrtdp_desc LIKE type_t.chr500, 
   dbadcrtdt DATETIME YEAR TO SECOND, 
   dbadmodid LIKE dbad_t.dbadmodid, 
   dbadmodid_desc LIKE type_t.chr500, 
   dbadmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      dbadl001 LIKE dbadl_t.dbadl001,
      dbadl002 LIKE dbadl_t.dbadl002,
      dbadl003 LIKE dbadl_t.dbadl003,
      dbadl004 LIKE dbadl_t.dbadl004,
      dbadl005 LIKE dbadl_t.dbadl005
      END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#Tree:變數---
DEFINE g_tree    DYNAMIC ARRAY OF RECORD      #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
       b_dbac002       LIKE dbac_t.dbac002,
       b_dbad002       LIKE dbad_t.dbad002,
       b_dbad001       LIKE dbad_t.dbad001       
                   END RECORD
DEFINE g_root_search   BOOLEAN 
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
#DEFINE g_browser_cnt   LIKE type_t.num5            #total count   #total count   #161108-00027#1 161108 by lori mark
DEFINE g_browser_cnt   LIKE type_t.num10           #total count    #161108-00027#1 161108 by lori add
DEFINE g_first         LIKE type_t.chr1            #紀錄是否是程式剛開始進入狀態
DEFINE g_current_idx   LIKE type_t.num10           #Browser所在筆數
DEFINE g_current_row   LIKE type_t.num5    
DEFINE g_cursor    RECORD
          sel_sql         STRING,
          from_sql        STRING,
          where_sql       STRING,
          order_sql       STRING
                   END RECORD
DEFINE g_set_detail       LIKE type_t.num5  #Tree節點有站點編號時,將右側資訊的指標指向該站點                   
#Tree:變數---
#ken---add---s 需求單號：150107-00009 項次：4
GLOBALS
 TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus,
   oofb001 LIKE oofb_t.oofb001,
   oofb019 LIKE oofb_t.oofb019,
   oofb011 LIKE oofb_t.oofb011,
   oofb008 LIKE oofb_t.oofb008,
   oofb009 LIKE oofb_t.oofb009,
   oofb009_desc LIKE type_t.chr500,
   oofb010 LIKE oofb_t.oofb010,
   oofb012 LIKE oofb_t.oofb012,
   oofb012_desc LIKE type_t.chr500,
   oofb013 LIKE oofb_t.oofb013,
   oofb014 LIKE oofb_t.oofb014,
   oofb014_desc LIKE type_t.chr500,
   oofb015 LIKE oofb_t.oofb015,
   oofb015_desc LIKE type_t.chr500,
   oofb016 LIKE oofb_t.oofb016,
   oofb016_desc LIKE type_t.chr500,
   oofb017 LIKE oofb_t.oofb017,
   oofb022 LIKE oofb_t.oofb022,
   oofb022_desc LIKE type_t.chr500,
   oofb020 LIKE oofb_t.oofb020,
   oofb021 LIKE oofb_t.oofb021,
   oofb018 LIKE oofb_t.oofb018
       END RECORD
DEFINE g_pmba_d          DYNAMIC ARRAY OF type_g_oofb_d

 TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus,
   oofc001 LIKE oofc_t.oofc001,
   oofc008 LIKE oofc_t.oofc008,
   oofc009 LIKE oofc_t.oofc009,
   oofc009_desc LIKE type_t.chr500,
   oofc012 LIKE oofc_t.oofc012,
   oofc010 LIKE oofc_t.oofc010,
   oofc014 LIKE oofc_t.oofc014,
   oofc011 LIKE oofc_t.oofc011,
   oofc015 LIKE oofc_t.oofc015,
   oofc013 LIKE oofc_t.oofc013
       END RECORD
DEFINE g_pmba2_d          DYNAMIC ARRAY OF type_g_oofc_d
END GLOBALS
#ken---add---e
#end add-point
 
#模組變數(Module Variables)
DEFINE g_dbad_d          DYNAMIC ARRAY OF type_g_dbad_d #單身變數
DEFINE g_dbad_d_t        type_g_dbad_d                  #單身備份
DEFINE g_dbad_d_o        type_g_dbad_d                  #單身備份
DEFINE g_dbad_d_mask_o   DYNAMIC ARRAY OF type_g_dbad_d #單身變數
DEFINE g_dbad_d_mask_n   DYNAMIC ARRAY OF type_g_dbad_d #單身變數
DEFINE g_dbad2_d   DYNAMIC ARRAY OF type_g_dbad2_d
DEFINE g_dbad2_d_t type_g_dbad2_d
DEFINE g_dbad2_d_o type_g_dbad2_d
DEFINE g_dbad2_d_mask_o DYNAMIC ARRAY OF type_g_dbad2_d
DEFINE g_dbad2_d_mask_n DYNAMIC ARRAY OF type_g_dbad2_d
 
      
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
 
{<section id="adbi253.main" >}
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
 
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT dbadstus,dbad001,dbad002,dbad003,dbad001,dbadownid,dbadowndp,dbadcrtid, 
       dbadcrtdp,dbadcrtdt,dbadmodid,dbadmoddt FROM dbad_t WHERE dbadent=? AND dbad001=? FOR UPDATE" 
 
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbi253_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi253 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi253_init()   
 
      #進入選單 Menu (="N")
      CALL adbi253_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi253
      
   END IF 
   
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbi253.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adbi253_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = '1'
   #嵌入---
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_01"), "grid_aooi3501", "Table", "s_detail1_aooi350_01")
   CALL cl_set_combo_scc('oofb008','9')   #地址類型
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi350_02"), "grid_aooi3502", "Table", "s_detail1_aooi350_02")
   CALL cl_set_combo_scc('oofc008','6')   #通訊類型 
   #嵌入---   
   #Tree---
   DROP TABLE adbi253_status
   CREATE TEMP TABLE adbi253_status(
      pid        VARCHAR(100),
      expanded   VARCHAR(1))
   LET g_first = 0
   #Tree--- 

   CALL cl_set_act_visible_toolbaritem('reproduce',FALSE)
   #end add-point
   
   CALL adbi253_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi253.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adbi253_ui_dialog()
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
   DEFINE l_i       LIKE type_t.num5   #Tree
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #Tree---
   CALL adbi253_browser_fill(g_wc2)
   LET g_first = 1
   #Tree---
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_dbad_d.clear()
         CALL g_dbad2_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL adbi253_init()
      END IF
   
      CALL adbi253_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dbad_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
               LET g_data_owner = g_dbad2_d[g_detail_idx].dbadownid   #(ver:35)
               LET g_data_dept = g_dbad2_d[g_detail_idx].dbadowndp  #(ver:35)
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL adbi253_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               #嵌入---
               IF l_ac > 0 THEN
                  INITIALIZE g_pmaa027_d TO NULL
                  CALL aooi350_01_clear_detail()
                  CALL aooi350_02_clear_detail()   
                  IF NOT cl_null(g_dbad_d[l_ac].dbad003) THEN
                     LET g_pmaa027_d = g_dbad_d[l_ac].dbad003
                     CALL aooi350_01_b_fill(g_pmaa027_d)
                     CALL aooi350_02_b_fill(g_pmaa027_d)
                  END IF
               END IF
               #嵌入---
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_dbad2_d TO s_detail2.*
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
   CALL adbi253_set_pk_array()
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
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_tree")
               IF g_current_row > 0 THEN
                  IF g_current_row <> g_current_idx THEN
                     LET g_current_row = g_current_idx #目前指標
                     CALL DIALOG.setCurrentRow("s_tree",g_current_row)
                   END IF

                  IF NOT cl_null(g_tree[g_current_row].b_dbad001) THEN
                     LET g_set_detail = NULL
                     FOR l_i = 1 TO g_dbad_d.getLength()
                        IF g_dbad_d[l_i].dbad001 = g_tree[g_current_row].b_dbad001 THEN
                          LET g_set_detail = l_i
                          CALL DIALOG.setCurrentRow("s_detail1",g_set_detail)
                          EXIT FOR
                        END IF
                     END FOR
                  END IF
               ELSE
                  LET g_current_row = g_detail_idx
               END IF

               CALL cl_show_fld_cont()        
 
            ON EXPAND (g_current_row)
               #樹展開
               CALL adbi253_node_open(g_tree[g_current_row].b_pid)
            ON COLLAPSE (g_current_row)
               #樹關閉
               CALL adbi253_node_close(g_tree[g_current_row].b_pid)
         END DISPLAY
         
         #嵌入--
         SUBDIALOG aoo_aooi350_01.aooi350_01_display
         SUBDIALOG aoo_aooi350_02.aooi350_02_display
         #嵌入--
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
            NEXT FIELD dbadstus
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL adbi253_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi253_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL adbi253_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi253_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL adbi253_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL adbi253_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbi253_insert()
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
               CALL adbi253_query()
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
               LET g_export_node[1] = base.typeInfo.create(g_dbad_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_dbad2_d)
               LET g_export_id[2]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               #ken---add---s 需求單號：150107-00009 項次：4
               LET g_export_node[3] = base.typeInfo.create(g_pmba_d)
               LET g_export_id[3]   = "s_detail1_aooi350_01"
               LET g_export_node[4] = base.typeInfo.create(g_pmba2_d)
               LET g_export_id[4]   = "s_detail1_aooi350_02"
               #ken---add---e
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
            CALL adbi253_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbi253_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbi253_set_pk_array()
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
 
{<section id="adbi253.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi253_query()
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
   CALL g_dbad_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON dbadstus,dbad001,dbadl003,dbadl004,dbadl005,dbad002,dbad003,dbadownid,dbadowndp, 
          dbadcrtid,dbadcrtdp,dbadcrtdt,dbadmodid,dbadmoddt 
 
         FROM s_detail1[1].dbadstus,s_detail1[1].dbad001,s_detail1[1].dbadl003,s_detail1[1].dbadl004, 
             s_detail1[1].dbadl005,s_detail1[1].dbad002,s_detail1[1].dbad003,s_detail2[1].dbadownid, 
             s_detail2[1].dbadowndp,s_detail2[1].dbadcrtid,s_detail2[1].dbadcrtdp,s_detail2[1].dbadcrtdt, 
             s_detail2[1].dbadmodid,s_detail2[1].dbadmoddt 
      
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbadcrtdt>>----
         AFTER FIELD dbadcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbadmoddt>>----
         AFTER FIELD dbadmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbadcnfdt>>----
         
         #----<<dbadpstdt>>----
 
 
 
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadstus
            #add-point:BEFORE FIELD dbadstus name="query.b.page1.dbadstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadstus
            
            #add-point:AFTER FIELD dbadstus name="query.a.page1.dbadstus"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbadstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadstus
            #add-point:ON ACTION controlp INFIELD dbadstus name="query.c.page1.dbadstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbad001
            #add-point:ON ACTION controlp INFIELD dbad001 name="construct.c.page1.dbad001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbad001  #顯示到畫面上
            NEXT FIELD dbad001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbad001
            #add-point:BEFORE FIELD dbad001 name="query.b.page1.dbad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbad001
            
            #add-point:AFTER FIELD dbad001 name="query.a.page1.dbad001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadl003
            #add-point:BEFORE FIELD dbadl003 name="query.b.page1.dbadl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadl003
            
            #add-point:AFTER FIELD dbadl003 name="query.a.page1.dbadl003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbadl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadl003
            #add-point:ON ACTION controlp INFIELD dbadl003 name="query.c.page1.dbadl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadl004
            #add-point:BEFORE FIELD dbadl004 name="query.b.page1.dbadl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadl004
            
            #add-point:AFTER FIELD dbadl004 name="query.a.page1.dbadl004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbadl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadl004
            #add-point:ON ACTION controlp INFIELD dbadl004 name="query.c.page1.dbadl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadl005
            #add-point:BEFORE FIELD dbadl005 name="query.b.page1.dbadl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadl005
            
            #add-point:AFTER FIELD dbadl005 name="query.a.page1.dbadl005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbadl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadl005
            #add-point:ON ACTION controlp INFIELD dbadl005 name="query.c.page1.dbadl005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbad002
            #add-point:ON ACTION controlp INFIELD dbad002 name="construct.c.page1.dbad002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbad002  #顯示到畫面上
            NEXT FIELD dbad002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbad002
            #add-point:BEFORE FIELD dbad002 name="query.b.page1.dbad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbad002
            
            #add-point:AFTER FIELD dbad002 name="query.a.page1.dbad002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbad003
            #add-point:BEFORE FIELD dbad003 name="query.b.page1.dbad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbad003
            
            #add-point:AFTER FIELD dbad003 name="query.a.page1.dbad003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.dbad003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbad003
            #add-point:ON ACTION controlp INFIELD dbad003 name="query.c.page1.dbad003"
            
            #END add-point
 
 
  
         
                  #Ctrlp:construct.c.page2.dbadownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadownid
            #add-point:ON ACTION controlp INFIELD dbadownid name="construct.c.page2.dbadownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbadownid  #顯示到畫面上
            NEXT FIELD dbadownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadownid
            #add-point:BEFORE FIELD dbadownid name="query.b.page2.dbadownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadownid
            
            #add-point:AFTER FIELD dbadownid name="query.a.page2.dbadownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbadowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadowndp
            #add-point:ON ACTION controlp INFIELD dbadowndp name="construct.c.page2.dbadowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbadowndp  #顯示到畫面上
            NEXT FIELD dbadowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadowndp
            #add-point:BEFORE FIELD dbadowndp name="query.b.page2.dbadowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadowndp
            
            #add-point:AFTER FIELD dbadowndp name="query.a.page2.dbadowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbadcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadcrtid
            #add-point:ON ACTION controlp INFIELD dbadcrtid name="construct.c.page2.dbadcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbadcrtid  #顯示到畫面上
            NEXT FIELD dbadcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadcrtid
            #add-point:BEFORE FIELD dbadcrtid name="query.b.page2.dbadcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadcrtid
            
            #add-point:AFTER FIELD dbadcrtid name="query.a.page2.dbadcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbadcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadcrtdp
            #add-point:ON ACTION controlp INFIELD dbadcrtdp name="construct.c.page2.dbadcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbadcrtdp  #顯示到畫面上
            NEXT FIELD dbadcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadcrtdp
            #add-point:BEFORE FIELD dbadcrtdp name="query.b.page2.dbadcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadcrtdp
            
            #add-point:AFTER FIELD dbadcrtdp name="query.a.page2.dbadcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadcrtdt
            #add-point:BEFORE FIELD dbadcrtdt name="query.b.page2.dbadcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbadmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadmodid
            #add-point:ON ACTION controlp INFIELD dbadmodid name="construct.c.page2.dbadmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbadmodid  #顯示到畫面上
            NEXT FIELD dbadmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadmodid
            #add-point:BEFORE FIELD dbadmodid name="query.b.page2.dbadmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadmodid
            
            #add-point:AFTER FIELD dbadmodid name="query.a.page2.dbadmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadmoddt
            #add-point:BEFORE FIELD dbadmoddt name="query.b.page2.dbadmoddt"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      #嵌入--
      SUBDIALOG aoo_aooi350_01.aooi350_01_construct
      SUBDIALOG aoo_aooi350_02.aooi350_02_construct
      #嵌入--
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
   #嵌入--
   IF g_wc2_i35001 <> " 1=1" THEN
      IF cl_null(g_wc2) THEN
         LET g_wc2 = g_wc2_i35001
      ELSE
         LET g_wc2 = g_wc2 ," AND ", g_wc2_i35001
      END IF
   END IF

   IF g_wc2_i35002 <> " 1=1" THEN
      IF cl_null(g_wc2) THEN
         LET g_wc2 = g_wc2_i35002
      ELSE
         LET g_wc2 = g_wc2 ," AND ", g_wc2_i35002
      END IF
   END IF
   #嵌入--
   
   #Tree--
   IF NOT INT_FLAG THEN
      CALL adbi253_browser_fill(g_wc2)
   END IF   
   #Tree--
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
    
   CALL adbi253_b_fill(g_wc2)
   LET g_data_owner = g_dbad2_d[g_detail_idx].dbadownid   #(ver:35)
   LET g_data_dept = g_dbad2_d[g_detail_idx].dbadowndp   #(ver:35)
 
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
 
{<section id="adbi253.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbi253_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL adbi253_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi253.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbi253_modify()
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
   #嵌入--
   DEFINE  l_success              LIKE type_t.num5
   DEFINE  l_wc                   STRING
   DEFINE  l_oofb001              LIKE oofb_t.oofb001
   DEFINE  l_flag                 LIKE type_t.chr1    #判斷是否有經過insert的指令
   DEFINE  l_ooef006              LIKE ooef_t.ooef006   
   #嵌入--
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
   #嵌入--
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #嵌入--
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbad_d FROM s_detail1.*
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
            IF NOT cl_null(g_dbad_d[g_detail_idx].dbad001)  THEN
               CALL n_dbadl(g_dbad_d[g_detail_idx].dbad001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_dbad_d[g_detail_idx].dbad001
               CALL ap_ref_array2(g_ref_fields," SELECT dbadl003,dbadl004,dbadl005 FROM dbadl_t WHERE dbadlent = '"
                   ||g_enterprise||"' AND dbadl001 = ? AND dbadl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_dbad_d[g_detail_idx].dbadl003 = g_rtn_fields[1]
               LET g_dbad_d[g_detail_idx].dbadl004 = g_rtn_fields[2]
               LET g_dbad_d[g_detail_idx].dbadl005 = g_rtn_fields[3]
               DISPLAY BY NAME g_dbad_d[g_detail_idx].dbadl003,g_dbad_d[g_detail_idx].dbadl004,g_dbad_d[g_detail_idx].dbadl005
            END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbad_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbi253_b_fill(g_wc2)
            LET g_detail_cnt = g_dbad_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            #Tree:節點有站點資料時,直接維護該筆資料,所以將指標指向該站點---
            IF g_set_detail > 0 AND g_detail_idx <> g_set_detail  THEN
               CALL DIALOG.setCurrentRow("s_detail1",g_set_detail)
            END IF
            #Tree---
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_dbad_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_dbad_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_dbad_d[l_ac].dbad001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbad_d_t.* = g_dbad_d[l_ac].*  #BACKUP
               LET g_dbad_d_o.* = g_dbad_d[l_ac].*  #BACKUP
               IF NOT adbi253_lock_b("dbad_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi253_bcl INTO g_dbad_d[l_ac].dbadstus,g_dbad_d[l_ac].dbad001,g_dbad_d[l_ac].dbad002, 
                      g_dbad_d[l_ac].dbad003,g_dbad2_d[l_ac].dbad001,g_dbad2_d[l_ac].dbadownid,g_dbad2_d[l_ac].dbadowndp, 
                      g_dbad2_d[l_ac].dbadcrtid,g_dbad2_d[l_ac].dbadcrtdp,g_dbad2_d[l_ac].dbadcrtdt, 
                      g_dbad2_d[l_ac].dbadmodid,g_dbad2_d[l_ac].dbadmoddt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbad_d_t.dbad001,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbad_d_mask_o[l_ac].* =  g_dbad_d[l_ac].*
                  CALL adbi253_dbad_t_mask()
                  LET g_dbad_d_mask_n[l_ac].* =  g_dbad_d[l_ac].*
                  
                  CALL adbi253_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL adbi253_set_entry_b(l_cmd)
            CALL adbi253_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            #嵌入--
            IF l_cmd = 'u' THEN
               IF NOT cl_null(g_dbad_d[l_ac].dbad003) THEN
                  LET g_pmaa027_d = g_dbad_d[l_ac].dbad003
                  CALL aooi350_01_b_fill(g_pmaa027_d)
                  CALL aooi350_02_b_fill(g_pmaa027_d)
               END IF
            END IF
            #嵌入--
            
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.dbadl001 = g_dbad_d[l_ac].dbad001
LET g_detail_multi_table_t.dbadl002 = g_dlang
LET g_detail_multi_table_t.dbadl003 = g_dbad_d[l_ac].dbadl003
LET g_detail_multi_table_t.dbadl004 = g_dbad_d[l_ac].dbadl004
LET g_detail_multi_table_t.dbadl005 = g_dbad_d[l_ac].dbadl005
 
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'dbadlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'dbadl001'
            LET l_var_keys[02] = g_dbad_d[l_ac].dbad001
            LET l_field_keys[03] = 'dbadl002'
            LET l_var_keys[03] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'dbadl_t') THEN
               RETURN 
            END IF 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbad_d_t.* TO NULL
            INITIALIZE g_dbad_d_o.* TO NULL
            INITIALIZE g_dbad_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbad2_d[l_ac].dbadownid = g_user
      LET g_dbad2_d[l_ac].dbadowndp = g_dept
      LET g_dbad2_d[l_ac].dbadcrtid = g_user
      LET g_dbad2_d[l_ac].dbadcrtdp = g_dept 
      LET g_dbad2_d[l_ac].dbadcrtdt = cl_get_current()
      LET g_dbad2_d[l_ac].dbadmodid = g_user
      LET g_dbad2_d[l_ac].dbadmoddt = cl_get_current()
      LET g_dbad_d[l_ac].dbadstus = ''
 
 
 
            #自定義預設值(單身2)
                  LET g_dbad_d[l_ac].dbadstus = "Y"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_dbad_d_t.* = g_dbad_d[l_ac].*     #新輸入資料
            LET g_dbad_d_o.* = g_dbad_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbad_d[li_reproduce_target].* = g_dbad_d[li_reproduce].*
               LET g_dbad2_d[li_reproduce_target].* = g_dbad2_d[li_reproduce].*
 
               LET g_dbad_d[g_dbad_d.getLength()].dbad001 = NULL
 
            END IF
            
LET g_detail_multi_table_t.dbadl001 = g_dbad_d[l_ac].dbad001
LET g_detail_multi_table_t.dbadl002 = g_dlang
LET g_detail_multi_table_t.dbadl003 = g_dbad_d[l_ac].dbadl003
LET g_detail_multi_table_t.dbadl004 = g_dbad_d[l_ac].dbadl004
LET g_detail_multi_table_t.dbadl005 = g_dbad_d[l_ac].dbadl005
 
 
            CALL adbi253_set_entry_b(l_cmd)
            CALL adbi253_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            #Tree:預設值--
            IF g_current_row > 0 THEN
               IF NOT cl_null(g_tree[g_current_row].b_dbad002 ) THEN
                  LET g_dbad_d[l_ac].dbad002 = g_tree[g_current_row].b_dbad002             
                  LET g_dbad_d[l_ac].l_dbac002 = adbi253_get_dbac_info(g_tree[g_current_row].b_dbad002)
               ELSE
                  LET g_dbad_d[l_ac].l_dbac002 = g_tree[g_current_row].b_dbac002
               END IF
                         
               LET g_dbad_d[l_ac].dbad002_desc = adbi253_dbad002_ref(g_dbad_d[l_ac].dbad002)
               LET g_dbad_d[l_ac].l_dbac002_desc = adbi253_dbac002_ref(g_dbad_d[l_ac].l_dbac002)
            END IF   
            LET g_dbad_d_t.* = g_dbad_d[l_ac].*
            #Tree---  
            #嵌入--
            INITIALIZE g_pmaa027_d TO NULL
            CALL aooi350_01_clear_detail()
            CALL aooi350_02_clear_detail()
            LET l_flag = 'N'            
            #嵌入--
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
            SELECT COUNT(1) INTO l_count FROM dbad_t 
             WHERE dbadent = g_enterprise AND dbad001 = g_dbad_d[l_ac].dbad001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               #嵌入---
               IF NOT cl_null(g_dbad_d[l_ac].dbad001) THEN
                  LET l_success = ''
                  CALL s_aooi350_ins_oofa('12',g_dbad_d[l_ac].dbad001,'') RETURNING l_success,g_dbad_d[l_ac].dbad003
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     CONTINUE DIALOG
                  END IF
               END IF
               #嵌入---
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbad_d[g_detail_idx].dbad001
               CALL adbi253_insert_b('dbad_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_dbad_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "dbad_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbi253_b_fill(g_wc2)
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbad_d[l_ac].dbad001 = g_detail_multi_table_t.dbadl001 AND
         g_dbad_d[l_ac].dbadl003 = g_detail_multi_table_t.dbadl003 AND
         g_dbad_d[l_ac].dbadl004 = g_detail_multi_table_t.dbadl004 AND
         g_dbad_d[l_ac].dbadl005 = g_detail_multi_table_t.dbadl005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbad_d[l_ac].dbad001
            LET l_field_keys[02] = 'dbadl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbadl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbadl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbadl002
            LET l_vars[01] = g_dbad_d[l_ac].dbadl003
            LET l_fields[01] = 'dbadl003'
            LET l_vars[02] = g_dbad_d[l_ac].dbadl004
            LET l_fields[02] = 'dbadl004'
            LET l_vars[03] = g_dbad_d[l_ac].dbadl005
            LET l_fields[03] = 'dbadl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbadl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
               #嵌入
               LET g_pmaa027_d = g_dbad_d[l_ac].dbad003
               LET l_flag = 'Y'
               #Tree:重整
               CALL adbi253_browser_fill(g_wc2)
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (dbad001 = '", g_dbad_d[l_ac].dbad001, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               IF NOT adbi253_delete_invalid_chk(g_dbad_d_t.dbad001) THEN
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
               
               DELETE FROM dbad_t
                WHERE dbadent = g_enterprise AND 
                      dbad001 = g_dbad_d_t.dbad001
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbad_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbadl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbadl_t')
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  #Tree:重整
                  CALL adbi253_browser_fill(g_wc2)
                  #嵌入--
                  IF NOT cl_null(g_dbad_d_t.dbad003) THEN		
                     IF NOT s_aooi350_del(g_dbad_d_t.dbad003) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "oofa_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        CANCEL DELETE
                     END IF                  
                  END IF
                  #嵌入--
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL adbi253_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_dbad_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF 
               CLOSE adbi253_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_dbad_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbad_d_t.dbad001
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi253_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL adbi253_delete_b('dbad_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_dbad_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadstus
            #add-point:BEFORE FIELD dbadstus name="input.b.page1.dbadstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadstus
            
            #add-point:AFTER FIELD dbadstus name="input.a.page1.dbadstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbadstus
            #add-point:ON CHANGE dbadstus name="input.g.page1.dbadstus"
            IF g_dbad_d[l_ac].dbadstus = 'N' THEN
               IF NOT adbi253_delete_invalid_chk(g_dbad_d[l_ac].dbad001) THEN  
                  LET g_dbad_d[l_ac].dbadstus = g_dbad_d_t.dbadstus
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbad001
            #add-point:BEFORE FIELD dbad001 name="input.b.page1.dbad001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbad001
            
            #add-point:AFTER FIELD dbad001 name="input.a.page1.dbad001"
            #此段落由子樣板a05產生
            IF  g_dbad_d[g_detail_idx].dbad001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbad_d[g_detail_idx].dbad001 != g_dbad_d_t.dbad001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbad_t WHERE "||"dbadent = '" ||g_enterprise|| "' AND "||"dbad001 = '"||g_dbad_d[g_detail_idx].dbad001 ||"'",'std-00004',0) THEN 
                     LET g_dbad_d[l_ac].dbad001 = g_dbad_d_t.dbad001
                     NEXT FIELD CURRENT
                  ELSE
                     IF g_dbad_d[l_ac].dbad001 != g_dbad_d_t.dbad001 THEN
                        IF NOT adbi253_delete_invalid_chk(g_dbad_d_t.dbad001) THEN
                           NEXT FIELD CURRENT
                        END IF                     
                     END IF
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbad001
            #add-point:ON CHANGE dbad001 name="input.g.page1.dbad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadl003
            #add-point:BEFORE FIELD dbadl003 name="input.b.page1.dbadl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadl003
            
            #add-point:AFTER FIELD dbadl003 name="input.a.page1.dbadl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbadl003
            #add-point:ON CHANGE dbadl003 name="input.g.page1.dbadl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadl004
            #add-point:BEFORE FIELD dbadl004 name="input.b.page1.dbadl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadl004
            
            #add-point:AFTER FIELD dbadl004 name="input.a.page1.dbadl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbadl004
            #add-point:ON CHANGE dbadl004 name="input.g.page1.dbadl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbadl005
            #add-point:BEFORE FIELD dbadl005 name="input.b.page1.dbadl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbadl005
            
            #add-point:AFTER FIELD dbadl005 name="input.a.page1.dbadl005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbadl005
            #add-point:ON CHANGE dbadl005 name="input.g.page1.dbadl005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbad002
            
            #add-point:AFTER FIELD dbad002 name="input.a.page1.dbad002"
            IF NOT cl_null(g_dbad_d[l_ac].dbad002) 
               AND l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbad_d[l_ac].dbad002 != g_dbad_d_t.dbad002)) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_dbad_d[l_ac].dbad002
               IF cl_chk_exist("v_dbac001") THEN
                  LET g_dbad_d[l_ac].l_dbac002 = adbi253_get_dbac_info(g_dbad_d[l_ac].dbad002)
               ELSE
                  LET g_dbad_d[l_ac].dbad002 = g_dbad_d_t.dbad002
                  LET g_dbad_d[l_ac].l_dbac002 = g_dbad_d_t.l_dbac002
                  LET g_dbad_d[l_ac].dbad002_desc = adbi253_dbad002_ref(g_dbad_d[l_ac].dbad002)
                  LET g_dbad_d[l_ac].l_dbac002_desc = adbi253_dbac002_ref(g_dbad_d[l_ac].l_dbac002)
                  NEXT FIELD CURRENT
               END IF
            END IF            
            
            LET g_dbad_d[l_ac].dbad002_desc = adbi253_dbad002_ref(g_dbad_d[l_ac].dbad002)
            LET g_dbad_d[l_ac].l_dbac002_desc = adbi253_dbac002_ref(g_dbad_d[l_ac].l_dbac002)
            DISPLAY BY NAME g_dbad_d[l_ac].dbad002_desc,g_dbad_d[l_ac].l_dbac002_desc              
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbad002
            #add-point:BEFORE FIELD dbad002 name="input.b.page1.dbad002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbad002
            #add-point:ON CHANGE dbad002 name="input.g.page1.dbad002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbad003
            #add-point:BEFORE FIELD dbad003 name="input.b.page1.dbad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbad003
            
            #add-point:AFTER FIELD dbad003 name="input.a.page1.dbad003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbad003
            #add-point:ON CHANGE dbad003 name="input.g.page1.dbad003"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbadstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadstus
            #add-point:ON ACTION controlp INFIELD dbadstus name="input.c.page1.dbadstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbad001
            #add-point:ON ACTION controlp INFIELD dbad001 name="input.c.page1.dbad001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbadl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadl003
            #add-point:ON ACTION controlp INFIELD dbadl003 name="input.c.page1.dbadl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbadl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadl004
            #add-point:ON ACTION controlp INFIELD dbadl004 name="input.c.page1.dbadl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbadl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbadl005
            #add-point:ON ACTION controlp INFIELD dbadl005 name="input.c.page1.dbadl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbad002
            #add-point:ON ACTION controlp INFIELD dbad002 name="input.c.page1.dbad002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbad_d[l_ac].dbad002             #給予default值
            LET g_qryparam.default2 = "" #g_dbad_d[l_ac].dbabl003 #說明(簡稱)
            LET g_qryparam.default3 = "" #g_dbad_d[l_ac].dbac001 #片區編號
            LET g_qryparam.default4 = "" #g_dbad_d[l_ac].dbac002 #預設路線編號
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_dbac001_1()                                #呼叫開窗

            LET g_dbad_d[l_ac].dbad002 = g_qryparam.return1              
            LET g_dbad_d[l_ac].l_dbac002 = g_qryparam.return2 
            
            DISPLAY g_dbad_d[l_ac].dbad002 TO dbad002
            DISPLAY g_dbad_d[l_ac].l_dbac002 TO l_dbac002 #預設路線編號
            
            LET g_dbad_d[l_ac].dbad002_desc = adbi253_dbad002_ref(g_dbad_d[l_ac].dbad002)
            LET g_dbad_d[l_ac].l_dbac002_desc = adbi253_dbac002_ref(g_dbad_d[l_ac].l_dbac002)
            DISPLAY BY NAME g_dbad_d[l_ac].dbad002_desc,g_dbad_d[l_ac].l_dbac002_desc 
            
            NEXT FIELD dbad002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dbad003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbad003
            #add-point:ON ACTION controlp INFIELD dbad003 name="input.c.page1.dbad003"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE adbi253_bcl
               CALL s_transaction_end('N','0')
               LET INT_FLAG = 0
               LET g_dbad_d[l_ac].* = g_dbad_d_t.*
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
               LET g_errparam.extend = g_dbad_d[l_ac].dbad001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_dbad_d[l_ac].* = g_dbad_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               LET g_dbad2_d[l_ac].dbadmodid = g_user 
LET g_dbad2_d[l_ac].dbadmoddt = cl_get_current()
LET g_dbad2_d[l_ac].dbadmodid_desc = cl_get_username(g_dbad2_d[l_ac].dbadmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               #嵌入---
               IF NOT cl_null(g_dbad_d[l_ac].dbad001) AND cl_null(g_dbad_d[l_ac].dbad003) THEN
                  LET l_success = ''
                  CALL s_aooi350_ins_oofa('12',g_dbad_d[l_ac].dbad001,'') RETURNING l_success,g_dbad_d[l_ac].dbad003
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oofa_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     CONTINUE DIALOG
                  END IF
               END IF
               #嵌入---
               #end add-point
               
               #將遮罩欄位還原
               CALL adbi253_dbad_t_mask_restore('restore_mask_o')
 
               UPDATE dbad_t SET (dbadstus,dbad001,dbad002,dbad003,dbadownid,dbadowndp,dbadcrtid,dbadcrtdp, 
                   dbadcrtdt,dbadmodid,dbadmoddt) = (g_dbad_d[l_ac].dbadstus,g_dbad_d[l_ac].dbad001, 
                   g_dbad_d[l_ac].dbad002,g_dbad_d[l_ac].dbad003,g_dbad2_d[l_ac].dbadownid,g_dbad2_d[l_ac].dbadowndp, 
                   g_dbad2_d[l_ac].dbadcrtid,g_dbad2_d[l_ac].dbadcrtdp,g_dbad2_d[l_ac].dbadcrtdt,g_dbad2_d[l_ac].dbadmodid, 
                   g_dbad2_d[l_ac].dbadmoddt)
                WHERE dbadent = g_enterprise AND
                  dbad001 = g_dbad_d_t.dbad001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbad_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbad_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbad_d[g_detail_idx].dbad001
               LET gs_keys_bak[1] = g_dbad_d_t.dbad001
               CALL adbi253_update_b('dbad_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_dbad_d[l_ac].dbad001 = g_detail_multi_table_t.dbadl001 AND
         g_dbad_d[l_ac].dbadl003 = g_detail_multi_table_t.dbadl003 AND
         g_dbad_d[l_ac].dbadl004 = g_detail_multi_table_t.dbadl004 AND
         g_dbad_d[l_ac].dbadl005 = g_detail_multi_table_t.dbadl005 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'dbadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_dbad_d[l_ac].dbad001
            LET l_field_keys[02] = 'dbadl001'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.dbadl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'dbadl002'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.dbadl002
            LET l_vars[01] = g_dbad_d[l_ac].dbadl003
            LET l_fields[01] = 'dbadl003'
            LET l_vars[02] = g_dbad_d[l_ac].dbadl004
            LET l_fields[02] = 'dbadl004'
            LET l_vars[03] = g_dbad_d[l_ac].dbadl005
            LET l_fields[03] = 'dbadl005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'dbadl_t')
         END IF 
 
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_dbad_d_t)
                     LET g_log2 = util.JSON.stringify(g_dbad_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL adbi253_dbad_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               #Tree:重整
               CALL adbi253_browser_fill(g_wc2)
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL adbi253_unlock_b("dbad_t")
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbad_d[l_ac].* = g_dbad_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #其他table進行unlock
            CALL cl_multitable_unlock()
             #add-point:單身after row name="input.body.a_row"
            #Tree:清除指定指標--
            IF g_detail_idx = g_set_detail THEN
               LET g_set_detail = NULL
            END IF            
            #Tree--
            #嵌入--
            IF l_cmd = 'a' AND l_ac > 0 AND l_flag = 'Y' THEN
               IF NOT cl_null(g_dbad_d[l_ac].dbad003) THEN
                  LET g_pmaa027_d = g_dbad_d[l_ac].dbad003
                  CALL aooi350_01_b_fill(g_pmaa027_d)
                  CALL aooi350_02_b_fill(g_pmaa027_d)
                  NEXT FIELD oofbstus
               END IF               
            END IF
            #嵌入--
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            IF INT_FLAG THEN
               LET INT_FLAG = 0
            ELSE
               IF cl_null(g_dbad_d[l_ac].dbad001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adb-00021'
                  LET g_errparam.extend = g_dbad_d[l_ac].dbad001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL g_dbad_d.deleteElement(l_ac)
                  NEXT FIELD dbadstus
               END IF
            END IF            
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_dbad_d[li_reproduce_target].* = g_dbad_d[li_reproduce].*
               LET g_dbad2_d[li_reproduce_target].* = g_dbad2_d[li_reproduce].*
 
               LET g_dbad_d[li_reproduce_target].dbad001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbad_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbad_d.getLength()+1
            END IF
            
      END INPUT
      
 
      
      DISPLAY ARRAY g_dbad2_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_detail_cnt)  
      
         BEFORE DISPLAY 
            CALL adbi253_b_fill(g_wc2)
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
      #Tree
      DISPLAY ARRAY g_tree TO s_tree.*
         BEFORE DISPLAY
            CALL DIALOG.setSelectionMode("s_tree",1) #設定為單選
 
         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_tree")
            LET g_current_row = g_current_idx #目前指標
            CALL cl_show_fld_cont() 
            CALL DIALOG.setCurrentRow("s_tree",g_current_row)    
            NEXT FIELD dbadstus
 
         ON EXPAND (g_current_row)
            #樹展開
            CALL adbi253_node_open(g_tree[g_current_row].b_pid)
         ON COLLAPSE (g_current_row)
            #樹關閉
            CALL adbi253_node_close(g_tree[g_current_row].b_pid)
      END DISPLAY
      
      #嵌入--
      SUBDIALOG aoo_aooi350_01.aooi350_01_input
      SUBDIALOG aoo_aooi350_02.aooi350_02_input
      #嵌入--
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
         #Tree
         CALL DIALOG.setCurrentRow("s_tree",g_current_idx)
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD dbadstus
            WHEN "s_detail2"
               NEXT FIELD dbad001_2
 
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
      IF INT_FLAG OR cl_null(g_dbad_d[g_detail_idx].dbad001) THEN
         CALL g_dbad_d.deleteElement(g_detail_idx)
         CALL g_dbad2_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_dbad_d[g_detail_idx].* = g_dbad_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   #end add-point
 
   CLOSE adbi253_bcl
   CALL s_transaction_end('Y','0')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi253.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi253_delete()
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
   FOR li_idx = 1 TO g_dbad_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT adbi253_lock_b("dbad_t") THEN
            #已被他人鎖定
            CALL s_transaction_end('N','0')
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("dbad_t","dbadownid") THEN
            LET g_data_owner = g_dbad2_d[g_detail_idx].dbadownid
            LET g_data_dept = g_dbad2_d[g_detail_idx].dbadowndp
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
   CALL cl_err_collect_init()
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_dbad_d.getLength()
      IF g_dbad_d[li_idx].dbad001 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         IF NOT adbi253_delete_invalid_chk(g_dbad_d[li_idx].dbad001) THEN
            CONTINUE FOR
         END IF
         #end add-point   
         
         DELETE FROM dbad_t
          WHERE dbadent = g_enterprise AND 
                dbad001 = g_dbad_d[li_idx].dbad001
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbad_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
LET g_detail_multi_table_t.dbadl001 = g_dbad_d[l_ac].dbad001
LET g_detail_multi_table_t.dbadl002 = g_dlang
LET g_detail_multi_table_t.dbadl003 = g_dbad_d[l_ac].dbadl003
LET g_detail_multi_table_t.dbadl004 = g_dbad_d[l_ac].dbadl004
LET g_detail_multi_table_t.dbadl005 = g_dbad_d[l_ac].dbadl005
 
 
            
LET g_detail_multi_table_t.dbadl001 = g_dbad_d[l_ac].dbad001
LET g_detail_multi_table_t.dbadl002 = g_dlang
LET g_detail_multi_table_t.dbadl003 = g_dbad_d[l_ac].dbadl003
LET g_detail_multi_table_t.dbadl004 = g_dbad_d[l_ac].dbadl004
LET g_detail_multi_table_t.dbadl005 = g_dbad_d[l_ac].dbadl005
 
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbadl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbadl_t')
 
 
            
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'dbadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'dbadl001'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.dbadl001
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'dbadl_t')
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbad_d_t.dbad001
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL adbi253_delete_b('dbad_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            #Tree:重整
            CALL adbi253_browser_fill(g_wc2)
            #嵌入--
            IF NOT cl_null(g_dbad_d[g_detail_idx].dbad003) THEN
               IF NOT s_aooi350_del(g_dbad_d[g_detail_idx].dbad003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofa_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  CALL s_transaction_end('N','0')
               END IF                  
            END IF
            #嵌入--            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi253_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   CALL s_transaction_end('Y','0')
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   CALL cl_err_collect_show()
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL adbi253_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="adbi253.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi253_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag          LIKE type_t.chr1   #嵌入
   DEFINE l_dbac002       LIKE dbac_t.dbac002
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.dbadstus,t0.dbad001,t0.dbad002,t0.dbad003,t0.dbad001,t0.dbadownid, 
       t0.dbadowndp,t0.dbadcrtid,t0.dbadcrtdp,t0.dbadcrtdt,t0.dbadmodid,t0.dbadmoddt ,t1.dbacl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 FROM dbad_t t0",
               " LEFT JOIN dbadl_t ON dbadlent = "||g_enterprise||" AND dbad001 = dbadl001 AND dbadl002 = '",g_dlang,"'",
                              " LEFT JOIN dbacl_t t1 ON t1.dbaclent="||g_enterprise||" AND t1.dbacl001=t0.dbad002 AND t1.dbacl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.dbadownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.dbadowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.dbadcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.dbadcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.dbadmodid  ",
 
               " WHERE t0.dbadent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
      #應用 a68 樣板自動產生(Version:1)
   #若是修改，須視權限加上條件
   IF g_action_choice = "modify" OR g_action_choice = "modify_detail" THEN
      LET ls_owndept_list = NULL
      LET ls_ownuser_list = NULL
 
      #若有設定部門權限
      CALL cl_get_owndept_list("dbad_t","modify") RETURNING ls_owndept_list
      IF NOT cl_null(ls_owndept_list) THEN
         LET g_sql = g_sql, " AND dbadowndp IN (",ls_owndept_list,")"
      END IF
 
      #若有設定個人權限
      CALL cl_get_ownuser_list("dbad_t","modify") RETURNING ls_ownuser_list
      IF NOT cl_null(ls_ownuser_list) THEN
         LET g_sql = g_sql," AND dbadownid IN (",ls_ownuser_list,")"
      END IF
   END IF
 
 
 
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("dbad_t"),
                      " ORDER BY t0.dbad001"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE t0.dbadstus,t0.dbad001,t0.dbad002,t0.dbad003,t0.dbad001, ",
               "               t0.dbadownid,t0.dbadowndp,t0.dbadcrtid,t0.dbadcrtdp,t0.dbadcrtdt, ",
               "               t0.dbadmodid,t0.dbadmoddt ,t1.dbacl003 ,t3.ooag011,t4.ooefl003, ", 
               "               t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ",
               "  FROM dbad_t t0 ",
               "       LEFT JOIN dbadl_t ON dbadlent = '"||g_enterprise||"' AND dbad001 = dbadl001 AND dbadl002 = '",g_lang,"'",
               "       LEFT JOIN dbacl_t t1 ON t1.dbaclent='"||g_enterprise||"' AND t1.dbacl001=t0.dbad002 AND t1.dbacl002='"||g_dlang||"' ",
               "       LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.dbadownid  ",
               "       LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.dbadowndp AND t4.ooefl002='"||g_dlang||"' ",
               "       LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.dbadcrtid  ",
               "       LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.dbadcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               "       LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.dbadmodid  ", 
               "       LEFT JOIN oofb_t t6 ON t6.oofbent = t0.dbadent AND t6.oofb002 = t0.dbad003 ",  #嵌入
               "       LEFT JOIN oofc_t t7 ON t7.oofcent = t0.dbadent AND t7.oofc002 = t0.dbad003 ",  #嵌入               
               " WHERE t0.dbadent= ?  AND  1=1 AND ", p_wc2 
    
   LET g_sql = g_sql, cl_sql_add_filter("dbad_t"),
                      " ORDER BY t0.dbad001"   
                      
   #嵌入:調整SQL  
   INITIALIZE g_pmaa027_d TO NULL
   CALL aooi350_01_clear_detail()
   CALL aooi350_02_clear_detail()   
   LET l_flag = 'N'   
   #嵌入---                   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbad_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adbi253_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbi253_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dbad_d.clear()
   CALL g_dbad2_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_dbad_d[l_ac].dbadstus,g_dbad_d[l_ac].dbad001,g_dbad_d[l_ac].dbad002,g_dbad_d[l_ac].dbad003, 
       g_dbad2_d[l_ac].dbad001,g_dbad2_d[l_ac].dbadownid,g_dbad2_d[l_ac].dbadowndp,g_dbad2_d[l_ac].dbadcrtid, 
       g_dbad2_d[l_ac].dbadcrtdp,g_dbad2_d[l_ac].dbadcrtdt,g_dbad2_d[l_ac].dbadmodid,g_dbad2_d[l_ac].dbadmoddt, 
       g_dbad_d[l_ac].dbad002_desc,g_dbad2_d[l_ac].dbadownid_desc,g_dbad2_d[l_ac].dbadowndp_desc,g_dbad2_d[l_ac].dbadcrtid_desc, 
       g_dbad2_d[l_ac].dbadcrtdp_desc,g_dbad2_d[l_ac].dbadmodid_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET l_flag = 'Y'   #嵌入
      LET l_dbac002 = NULL
      
      SELECT dbac002 INTO l_dbac002
        FROM dbac_t
       WHERE dbacent = g_enterprise AND dbac001 = g_dbad_d[l_ac].dbad002

      DISPLAY l_dbac002 TO  g_dbad_d[l_ac].l_dbac002
      #end add-point
      
      CALL adbi253_detail_show()      
 
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
   
 
   
   CALL g_dbad_d.deleteElement(g_dbad_d.getLength())   
   CALL g_dbad2_d.deleteElement(g_dbad2_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_dbad_d.getLength()
      LET g_dbad2_d[l_ac].dbad001 = g_dbad_d[l_ac].dbad001 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_dbad_d.getLength() THEN
      LET l_ac = g_dbad_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbad_d.getLength()
      LET g_dbad_d_mask_o[l_ac].* =  g_dbad_d[l_ac].*
      CALL adbi253_dbad_t_mask()
      LET g_dbad_d_mask_n[l_ac].* =  g_dbad_d[l_ac].*
   END FOR
   
   LET g_dbad2_d_mask_o.* =  g_dbad2_d.*
   FOR l_ac = 1 TO g_dbad2_d.getLength()
      LET g_dbad2_d_mask_o[l_ac].* =  g_dbad2_d[l_ac].*
      CALL adbi253_dbad_t_mask()
      LET g_dbad2_d_mask_n[l_ac].* =  g_dbad2_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #嵌入--   
   IF l_flag = 'Y' THEN
      IF g_cnt > 0 THEN
         IF NOT cl_null(g_dbad_d[g_cnt].dbad003) THEN
            LET g_pmaa027_d = g_dbad_d[g_cnt].dbad003
            CALL aooi350_01_b_fill(g_pmaa027_d)
            CALL aooi350_02_b_fill(g_pmaa027_d)
         END IF
      ELSE
         IF NOT cl_null(g_dbad_d[1].dbad003) THEN
            LET g_pmaa027_d = g_dbad_d[1].dbad003
            CALL aooi350_01_b_fill(g_pmaa027_d)
            CALL aooi350_02_b_fill(g_pmaa027_d)
         END IF 
      END IF
   END IF   
   #嵌入--
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_dbad_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE adbi253_pb
   
END FUNCTION
 
{</section>}
 
{<section id="adbi253.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbi253_detail_show()
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

   CALL adbi253_dbad001_ref(g_dbad_d[l_ac].dbad001) RETURNING g_dbad_d[l_ac].dbadl003,g_dbad_d[l_ac].dbadl004,g_dbad_d[l_ac].dbadl005
   DISPLAY BY NAME g_dbad_d[l_ac].dbadl003,g_dbad_d[l_ac].dbadl004,g_dbad_d[l_ac].dbadl005
   
   LET g_dbad_d[l_ac].dbad002_desc = adbi253_dbad002_ref(g_dbad_d[l_ac].dbad002)
   DISPLAY BY NAME g_dbad_d[l_ac].dbad002_desc
   
   LET g_dbad_d[l_ac].l_dbac002 = adbi253_get_dbac_info(g_dbad_d[l_ac].dbad002)
   LET g_dbad_d[l_ac].l_dbac002_desc = adbi253_dbac002_ref(g_dbad_d[l_ac].l_dbac002)
   DISPLAY BY NAME g_dbad_d[l_ac].l_dbac002,g_dbad_d[l_ac].l_dbac002_desc   
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"

   LET g_dbad2_d[l_ac].dbadownid_desc = adbi253_user_ref(g_dbad2_d[l_ac].dbadownid)
   DISPLAY BY NAME g_dbad2_d[l_ac].dbadownid_desc

   LET g_dbad2_d[l_ac].dbadowndp_desc = adbi253_org_ref(g_dbad2_d[l_ac].dbadowndp)
   DISPLAY BY NAME g_dbad2_d[l_ac].dbadowndp_desc

   LET g_dbad2_d[l_ac].dbadcrtid_desc = adbi253_user_ref(g_dbad2_d[l_ac].dbadcrtid)
   DISPLAY BY NAME g_dbad2_d[l_ac].dbadcrtid_desc

   LET g_dbad2_d[l_ac].dbadcrtdp_desc = adbi253_org_ref(g_dbad2_d[l_ac].dbadcrtdp)
   DISPLAY BY NAME g_dbad2_d[l_ac].dbadcrtdp_desc

   LET g_dbad2_d[l_ac].dbadmodid_desc = adbi253_user_ref(g_dbad2_d[l_ac].dbadmodid)
   DISPLAY BY NAME g_dbad2_d[l_ac].dbadmodid_desc

   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbi253.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi253_set_entry_b(p_cmd)                                                  
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
 
{<section id="adbi253.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi253_set_no_entry_b(p_cmd)                                               
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
 
{<section id="adbi253.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi253_default_search()
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
      LET ls_wc = ls_wc, " dbad001 = '", g_argv[01], "' AND "
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
 
{<section id="adbi253.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi253_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "dbad_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'dbad_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM dbad_t
          WHERE dbadent = g_enterprise AND
            dbad001 = ps_keys_bak[1]
         
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
         CALL g_dbad_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_dbad2_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      #Tree:重整
      CALL adbi253_browser_fill(g_wc2)
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi253.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi253_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "dbad_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO dbad_t
                  (dbadent,
                   dbad001
                   ,dbadstus,dbad002,dbad003,dbadownid,dbadowndp,dbadcrtid,dbadcrtdp,dbadcrtdt,dbadmodid,dbadmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1]
                   ,g_dbad_d[l_ac].dbadstus,g_dbad_d[l_ac].dbad002,g_dbad_d[l_ac].dbad003,g_dbad2_d[l_ac].dbadownid, 
                       g_dbad2_d[l_ac].dbadowndp,g_dbad2_d[l_ac].dbadcrtid,g_dbad2_d[l_ac].dbadcrtdp, 
                       g_dbad2_d[l_ac].dbadcrtdt,g_dbad2_d[l_ac].dbadmodid,g_dbad2_d[l_ac].dbadmoddt) 
 
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi253.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi253_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "dbad_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dbad_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE dbad_t 
         SET (dbad001
              ,dbadstus,dbad002,dbad003,dbadownid,dbadowndp,dbadcrtid,dbadcrtdp,dbadcrtdt,dbadmodid,dbadmoddt) 
              = 
             (ps_keys[1]
              ,g_dbad_d[l_ac].dbadstus,g_dbad_d[l_ac].dbad002,g_dbad_d[l_ac].dbad003,g_dbad2_d[l_ac].dbadownid, 
                  g_dbad2_d[l_ac].dbadowndp,g_dbad2_d[l_ac].dbadcrtid,g_dbad2_d[l_ac].dbadcrtdp,g_dbad2_d[l_ac].dbadcrtdt, 
                  g_dbad2_d[l_ac].dbadmodid,g_dbad2_d[l_ac].dbadmoddt) 
         WHERE dbadent = g_enterprise AND dbad001 = ps_keys_bak[1]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbad_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbad_t:",SQLERRMESSAGE 
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
 
{<section id="adbi253.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi253_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL adbi253_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "dbad_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adbi253_bcl USING g_enterprise,
                                       g_dbad_d[g_detail_idx].dbad001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbi253_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi253.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi253_unlock_b(ps_table)
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
      CLOSE adbi253_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbi253.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION adbi253_modify_detail_chk(ps_record)
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
         LET ls_return = "dbadstus"
      WHEN "s_detail2"
         LET ls_return = "dbad001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adbi253.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION adbi253_show_ownid_msg()
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
 
{<section id="adbi253.mask_functions" >}
&include "erp/adb/adbi253_mask.4gl"
 
{</section>}
 
{<section id="adbi253.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbi253_set_pk_array()
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
   LET g_pk_array[1].values = g_dbad_d[l_ac].dbad001
   LET g_pk_array[1].column = 'dbad001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbi253.state_change" >}
   
 
{</section>}
 
{<section id="adbi253.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adbi253.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 人員名稱
# Memo...........:
# Usage..........: CALL adbi253_user_ref(p_user_id)
#                  RETURNING r_user_desc
# Input parameter: p_user_id      人員編號
# Return code....: r_user_desc    人員名稱
# Date & Author..: 2014/04/25 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_user_ref(p_user_id)
   DEFINE p_user_id   LIKE dbad_t.dbadownid
   DEFINE r_user_desc LIKE oofa_t.oofa011 
   
   LET r_user_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_user_id
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET r_user_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_user_desc
END FUNCTION

################################################################################
# Descriptions...: 組織说明
# Memo...........:
# Usage..........: CALL adbi253_org_ref(p_org_id)
#                  RETURNING r_org_desc
# Input parameter: p_org_id       組織編號
# Return code....: r_org_desc     組織說明
# Date & Author..: 2014/04/25 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_org_ref(p_org_id)
   DEFINE p_org_id   LIKE dbac_t.dbacowndp
   DEFINE r_org_desc LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_org_id
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_org_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_org_desc
END FUNCTION

################################################################################
# Descriptions...: 站點说明
# Memo...........:
# Usage..........: CALL adbi253_dbad001_ref(p_dbad001)
#                  RETURNING r_dbadl003,r_dbadl004,r_dbadl005
# Input parameter: p_dbad001   站點編號
# Return code....: r_dbadl003  站點簡稱
#                  r_dbadl004  站點說明
#                  r_dbadl005  助記碼
# Date & Author..: 2014/04/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_dbad001_ref(p_dbad001)
   DEFINE p_dbad001    LIKE dbad_t.dbad001
   DEFINE r_dbadl003   LIKE dbadl_t.dbadl003
   DEFINE r_dbadl004   LIKE dbadl_t.dbadl004
   DEFINE r_dbadl005   LIKE dbadl_t.dbadl005
   
   LET r_dbadl003 = NULL
   LET r_dbadl004 = NULL
   LET r_dbadl005 = NULL
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = p_dbad001
   CALL ap_ref_array2(g_ref_fields," SELECT dbadl003,dbadl004,dbadl005 FROM dbadl_t WHERE dbadlent = '"||g_enterprise||"' AND dbadl001 = ? AND dbadl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET r_dbadl003 = g_rtn_fields[1] 
   LET r_dbadl004 = g_rtn_fields[2] 
   LET r_dbadl005 = g_rtn_fields[3] 
   
   RETURN r_dbadl003,r_dbadl004,r_dbadl005   
END FUNCTION

################################################################################
# Descriptions...: 片區说明
# Memo...........:
# Usage..........: CALL adbi253_dbad002_ref(p_dbad002)
#                  RETURNING r_dbad002_desc
# Input parameter: p_dbad002        片區編號
# Return code....: r_dbad002_desc   片區說明
# Date & Author..: 2014/04/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_dbad002_ref(p_dbad002)
   DEFINE p_dbad002        LIKE dbad_t.dbad002
   DEFINE r_dbad002_desc   LIKE dbacl_t.dbacl003
   
   LET r_dbad002_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_dbad002   
   CALL ap_ref_array2(g_ref_fields,"SELECT dbacl003 FROM dbacl_t WHERE dbaclent='"||g_enterprise||"' AND dbacl001=? AND dbacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_dbad002_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_dbad002_desc
END FUNCTION

################################################################################
# Descriptions...: 路線說明
# Memo...........:
# Usage..........: CALL adbi253_dbac002_ref(p_dbac002)
#                  RETURNING r_dbac002_desc
# Input parameter: p_dbac002      路線編號
# Return code....: r_dbac002_desc 路線說明
# Date & Author..: 2014/04/25 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_dbac002_ref(p_dbac002)
   DEFINE p_dbac002      LIKE dbac_t.dbac002
   DEFINE r_dbac002_desc LIKE dbabl_t.dbabl003
   
   LET r_dbac002_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_dbac002
   CALL ap_ref_array2(g_ref_fields,"SELECT dbabl003 FROM dbabl_t WHERE dbablent='"||g_enterprise||"' AND dbabl001=? AND dbabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_dbac002_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_dbac002_desc
END FUNCTION

################################################################################
# Descriptions...: 取片區的預設路線
# Memo...........:
# Usage..........: CALL adbi253_get_dbac_info(p_dbad002)
#                  RETURNING r_dbac002
# Input parameter: p_dbad002   片區編號
# Return code....: r_dbac002   預設路線編號
# Date & Author..: 2014/04/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_get_dbac_info(p_dbad002)
   DEFINE p_dbad002   LIKE dbad_t.dbad002
   DEFINE r_dbac002   LIKE dbac_t.dbac002
   
   LET r_dbac002 = NULL
   
   SELECT dbac002 INTO r_dbac002
     FROM dbac_t
    WHERE dbacent = g_enterprise AND dbac001 = p_dbad002
    
   RETURN r_dbac002
END FUNCTION

################################################################################
# Descriptions...: Tree:根節點-路線
# Memo...........:
# Usage..........: CALL adbi253_browser_fill(p_wc)
# Input parameter: p_wc      查詢條件   
# Return code....: 
# Date & Author..: 2014/04/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_browser_fill(p_wc)
   DEFINE p_wc       STRING 
   DEFINE l_idx      LIKE type_t.num10
   DEFINE l_idx2     LIKE type_t.num10
   DEFINE l_idx3     LIKE type_t.num10
   DEFINE l_idx4     LIKE type_t.num10
   DEFINE l_sql      STRING
   DEFINE l_expanded LIKE type_t.chr1
   
   CALL g_tree.clear()
   CLEAR FORM
   INITIALIZE g_cursor.* TO NULL
   LET l_idx3 = 0

   LET g_cursor.sel_sql = " SELECT UNIQUE "
   LET g_cursor.from_sql = " FROM dbac_t LEFT JOIN dbad_t ON dbacent = dbadent AND dbac001 = dbad002 "   
   LET g_cursor.where_sql = " WHERE dbacent = ",g_enterprise," AND (",p_wc,") ",
                            "   AND (dbacstus = 'Y' ",
                            "        AND EXISTS (SELECT 1 FROM dbab_t WHERE dbacent = dbabent AND dbac002 = dbab001 AND dbabstus = 'Y'))"
   LET g_cursor.order_sql = " ORDER BY dbac002 "


   LET l_sql = g_cursor.sel_sql," dbac002 ",
               g_cursor.from_sql, g_cursor.where_sql, g_cursor.order_sql
   PREPARE tree_pre FROM l_sql
   DECLARE tree_cur CURSOR FOR tree_pre
   
   LET l_sql = " SELECT expanded FROM adbi253_status WHERE dbac002 = ? "   
   PREPARE tree_stus FROM l_sql   
   
   LET l_idx = 1 
   FOREACH tree_cur INTO g_tree[l_idx].b_dbac002
      LET g_tree[l_idx].b_pid     = 0
      LET g_tree[l_idx].b_id      = 0, ".", l_idx USING "<<<"
      LET g_tree[l_idx].b_exp     = FALSE
      LET g_tree[l_idx].b_expcode = 1
      LET g_tree[l_idx].b_hasC    = TRUE
      LET g_tree[l_idx].b_show    = g_tree[l_idx].b_dbac002
      LET g_tree[l_idx].b_isexp   = FALSE
      
      CALL adbi253_desc_show(l_idx)
      
      LET l_idx = l_idx + 1
      
      IF l_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF   
   END FOREACH
   CALL g_tree.deleteElement(g_tree.getLength()) 
   
   LET g_error_show = 0     
   LET g_browser_cnt = g_tree.getLength()      #總筆數, 有瀏覽頁籤才需要DISPLAY

   FREE tree_pre
   
   FOR l_idx2 = 1 TO g_tree.getLength()
      IF g_tree[l_idx2].b_expcode = '1' THEN
          CALL adbi253_browser_expand(l_idx2,p_wc)
          LET g_tree[l_idx2].b_isExp = TRUE        
      END IF
   END FOR

   FOR l_idx2 = 1 TO g_tree.getLength()
      IF g_tree[l_idx2].b_expcode = '2' THEN
          LET l_idx3 = l_idx3 + 1
          CALL adbi253_browser_expand2(l_idx2,l_idx3,p_wc)
          LET g_tree[l_idx2].b_isExp = TRUE        
      END IF
   END FOR

   FOR l_idx4 = 1 TO g_tree.getLength()
      #抓取記錄在temp table裡的展開否的值
      LET l_expanded = ''
      EXECUTE tree_stus USING g_tree[l_idx4].b_pid INTO l_expanded
      IF cl_null(l_expanded) THEN
         LET l_expanded = '1'
      END IF
      LET g_tree[l_idx4].b_exp = l_expanded
      #程式一執行就讓樹是全部展開的狀態
      IF g_first = 0 THEN
         LET g_tree[l_idx4].b_exp = '1'          #是否展開 1展開 2不展開
         LET g_tree[l_idx4].b_isExp = 1
         INSERT INTO adbi253_status(pid,expanded)
         VALUES(g_tree[l_idx4].b_pid,g_tree[l_idx4].b_exp)             
      END IF 
   END FOR
END FUNCTION

################################################################################
# Descriptions...: Tree:子節點展開-片區
# Memo...........:
# Usage..........: CALL adbi253_browser_expand(p_id,p_wc)
# Input parameter: p_id 
#                  p_wc  
# Return code....: 
# Date & Author..: 2014/04/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_browser_expand(p_id,p_wc)
   DEFINE p_id     LIKE type_t.num10
   DEFINE p_wc     STRING
   DEFINE l_lv     LIKE type_t.num10
   DEFINE l_idx    LIKE type_t.num10
   DEFINE l_idx2   LIKE type_t.num10
   DEFINE l_sql    STRING

   LET l_lv = g_tree[p_id].b_expcode
   LET g_tree[p_id].b_isExp = TRUE
               
   LET g_cursor.order_sql = " ORDER BY dbac001 "
   LET l_sql = g_cursor.sel_sql," dbac001 ",
               g_cursor.from_sql, g_cursor.where_sql, 
               "    AND dbac002 = '",g_tree[p_id].b_dbac002,"' ",
               g_cursor.order_sql 
   PREPARE expand_pre FROM l_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET l_idx = p_id + 1
   CALL g_tree.insertElement(l_idx)
   FOREACH expand_cur INTO g_tree[l_idx].b_dbad002
      LET g_tree[l_idx].b_pid     = g_tree[p_id].b_id 
      LET g_tree[l_idx].b_id      = g_tree[p_id].b_id , ".", l_idx USING "<<<"
      LET g_tree[l_idx].b_exp     = FALSE
      LET g_tree[l_idx].b_expcode = l_lv + 1
      LET g_tree[l_idx].b_hasC    = FALSE  
      LET g_tree[l_idx].b_show    = g_tree[l_idx].b_dbad002
      CALL adbi253_desc_show(l_idx) 
      LET l_idx = l_idx + 1
      CALL g_tree.insertElement(l_idx)           
   END FOREACH  
   
   CALL g_tree.deleteElement(l_idx)   
   LET g_browser_cnt = g_tree.getLength()    
   
END FUNCTION

################################################################################
# Descriptions...: Tree:子節點展開-站點
# Memo...........:
# Usage..........: CALL adbi253_browser_expand2(p_pid,p_id,p_wc)
# Input parameter: p_pid
#                  p_id 
#                  p_wc  
# Return code....: 
# Date & Author..: 2014/04/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_browser_expand2(p_pid,p_id,p_wc)
   DEFINE p_pid    LIKE type_t.num10
   DEFINE p_id     LIKE type_t.num10
   DEFINE p_wc     STRING
   DEFINE l_lv     LIKE type_t.num10
   DEFINE l_idx    LIKE type_t.num10
   DEFINE l_idx2   LIKE type_t.num10
   DEFINE l_sql    STRING

   LET l_lv = g_tree[p_pid].b_expcode
   LET g_tree[p_pid].b_isExp = TRUE
           
   LET g_cursor.order_sql = " ORDER BY dbad001 "
   LET l_sql = g_cursor.sel_sql," dbad002,dbad001 ",
               g_cursor.from_sql, g_cursor.where_sql, 
               "    AND dbad002 = '",g_tree[p_pid].b_dbad002,"' ",
               g_cursor.order_sql 
   PREPARE expand_pre1 FROM l_sql
   DECLARE expand_cur1 CURSOR FOR expand_pre1
   
   LET l_idx = p_pid + 1
   LET l_idx2 = p_id
   CALL g_tree.insertElement(l_idx)
   FOREACH expand_cur1 INTO g_tree[l_idx].b_dbad002,g_tree[l_idx].b_dbad001
      LET g_tree[l_idx].b_pid     = g_tree[p_pid].b_id 
      LET g_tree[l_idx].b_id      = g_tree[p_pid].b_id , ".", l_idx2 USING "<<<"
      LET g_tree[l_idx].b_exp     = FALSE
      LET g_tree[l_idx].b_expcode = l_lv + 1
      LET g_tree[l_idx].b_hasC    = FALSE  
      LET g_tree[l_idx].b_show    = g_tree[l_idx].b_dbad001
      CALL adbi253_desc_show(l_idx)
      LET l_idx = l_idx + 1
      LET l_idx2 = l_idx2 + 1
      CALL g_tree.insertElement(l_idx)      
   END FOREACH  
   
   CALL g_tree.deleteElement(l_idx)   
   LET g_browser_cnt = g_tree.getLength() 
END FUNCTION

################################################################################
# Descriptions...: Tree:節點說明
# Memo...........:
# Usage..........: CALL adbi253_desc_show(pi_ac)
# Input parameter: pi_ac
# Return code....: 
# Date & Author..: 2014/04/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_desc_show(pi_ac)
   DEFINE pi_ac   LIKE type_t.num5
   DEFINE lc_show     LIKE type_t.chr100
   DEFINE l_dbadl004  LIKE dbadl_t.dbadl004
   DEFINE l_dbadl005  LIKE dbadl_t.dbadl005
   
   IF cl_null(g_tree[pi_ac].b_dbad001) THEN 
      IF cl_null(g_tree[pi_ac].b_dbad002) THEN     
         LET lc_show =  adbi253_dbac002_ref(g_tree[pi_ac].b_dbac002)
         LET g_tree[pi_ac].b_show = lc_show,'(', g_tree[pi_ac].b_dbac002,')'  
      ELSE 
         LET lc_show =  adbi253_dbad002_ref(g_tree[pi_ac].b_dbad002)
         LET g_tree[pi_ac].b_show = lc_show,'(', g_tree[pi_ac].b_dbad002,')'  
      END IF       
   ELSE
      CALL adbi253_dbad001_ref(g_tree[pi_ac].b_dbad001) RETURNING lc_show,l_dbadl004,l_dbadl005 
      LET g_tree[pi_ac].b_show = lc_show,'(', g_tree[pi_ac].b_dbad001,')'    
   END IF      
END FUNCTION

################################################################################
# Descriptions...: Tree:節點狀態更新為展開
# Memo...........:
# Usage..........: CALL adbi253_node_open(p_pid)
# Input parameter: p_pid
# Return code....: 
# Date & Author..: 2014/04/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_node_open(p_pid)
   DEFINE p_pid   LIKE type_t.chr100
   
   LET g_tree[g_current_row].b_isExp = 1
   
   UPDATE adbi253_status SET expanded = '1'
    WHERE pid = p_pid
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
# Usage..........: CALL adbi253_node_close(p_pid)
# Input parameter: p_pid
# Return code....: 
# Date & Author..: 2014/04/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_node_close(p_pid)
   DEFINE p_pid   LIKE type_t.chr100
   
   LET g_tree[g_current_row].b_isExp = 0
   
   UPDATE adbi253_status SET expanded = '0'
    WHERE pid = p_pid
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
END FUNCTION

################################################################################
# Descriptions...: 刪除或失效前檢核是否可處理
# Memo...........:
# Usage..........: CALL adbi253_delete_invalid_chk(p_dbad001)
#                  RETURNING r_success
# Input parameter: p_dbad001   站點編號
# Return code....: r_success 
# Date & Author..: 2014/09/03 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi253_delete_invalid_chk(p_dbad001)
   DEFINE p_dbad001   LIKE dbad_t.dbad001
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   #檢查有無存在於路線順序檔
   SELECT COUNT(*) INTO l_cnt
     FROM dbaf_t 
    WHERE dbafent = g_enterprise
      AND dbaf003 = p_dbad001
      AND dbafstus = 'Y'      
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = p_dbad001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = p_dbad001
       LET g_errparam.code   = 'adb-00311'
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
       
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
