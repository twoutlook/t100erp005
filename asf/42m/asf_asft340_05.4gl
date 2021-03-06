#該程式未解開Section, 採用最新樣板產出!
{<section id="asft340_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-08-03 17:08:55), PR版次:0007(2016-12-02 16:22:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: asft340_05
#+ Description: 工單完工入庫整批產生
#+ Creator....: 02097(2016-07-20 10:23:56)
#+ Modifier...: 02097 -SD/PR- 08171
 
{</section>}
 
{<section id="asft340_05.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161021-00009#1  2016/10/21 By 00768     可完工入库量计算(多产出主件)是增加产品特征的判断，可能一个工单中的多产出主件有相同料号，不同特征的情况
#161109-00085#34 2016/11/15 By lienjunqi 整批調整系統星號寫法
#161109-00085#63 2016/11/30 By 08171     整批調整系統星號寫法
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
PRIVATE TYPE type_g_sfeb_d RECORD
       sfebdocno LIKE sfeb_t.sfebdocno, 
   sfebseq LIKE sfeb_t.sfebseq, 
   sel LIKE type_t.chr500, 
   sfeb001 LIKE sfeb_t.sfeb001, 
   sfeb026 LIKE sfeb_t.sfeb026, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   sfeb003 LIKE sfeb_t.sfeb003, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb004_desc LIKE type_t.chr500, 
   sfeb004_desc_desc LIKE type_t.chr500, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb006 LIKE sfeb_t.sfeb006, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb017 LIKE sfeb_t.sfeb017, 
   sfeb018 LIKE sfeb_t.sfeb018, 
   sfeb019 LIKE sfeb_t.sfeb019, 
   sfeb020 LIKE sfeb_t.sfeb020, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   sfeb027 LIKE sfeb_t.sfeb027, 
   sfeb028 LIKE sfeb_t.sfeb028, 
   sfebsite LIKE sfeb_t.sfebsite, 
   l_sefb008_desc LIKE type_t.num26_10
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_slip        STRING
DEFINE g_sfebdocno      LIKE sfeb_t.sfebdocno
DEFINE g_sfea004        LIKE sfea_t.sfea004
DEFINE g_sfeb008_t      LIKE sfeb_t.sfeb008 
DEFINE g_flag           LIKE type_t.num5
#end add-point
 
#模組變數(Module Variables)
DEFINE g_sfeb_d          DYNAMIC ARRAY OF type_g_sfeb_d #單身變數
DEFINE g_sfeb_d_t        type_g_sfeb_d                  #單身備份
DEFINE g_sfeb_d_o        type_g_sfeb_d                  #單身備份
DEFINE g_sfeb_d_mask_o   DYNAMIC ARRAY OF type_g_sfeb_d #單身變數
DEFINE g_sfeb_d_mask_n   DYNAMIC ARRAY OF type_g_sfeb_d #單身變數
 
      
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
 
{<section id="asft340_05.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION asft340_05(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_sfebdocno,p_sfea004
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_sfebdocno      LIKE sfeb_t.sfebdocno
   DEFINE p_sfea004        LIKE sfea_t.sfea004
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_sfebdocno = p_sfebdocno
   LET g_sfea004   = p_sfea004
   CALL s_aooi210_get_check_sql(g_site,'',g_sfebdocno,'4','','sfaadocno') RETURNING g_sub_success,g_wc_slip
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT sfebdocno,sfebseq,sfeb001,sfeb026,sfeb002,sfeb003,sfeb004,sfeb005,sfeb008, 
       sfeb009,sfeb006,sfeb007,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb017,sfeb018, 
       sfeb019,sfeb020,sfeb021,sfeb022,sfeb027,sfeb028,sfebsite FROM sfeb_t WHERE sfebent=? AND sfebdocno=?  
       AND sfebseq=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   LET g_forupd_sql = "SELECT sfeadocno FROM sfea_t WHERE sfeaent=? AND sfeadocno=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asft340_05_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft340_05 WITH FORM cl_ap_formpath("asf","asft340_05")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL asft340_05_init()   
 
   #進入選單 Menu (="N")
   CALL asft340_05_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_asft340_05
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asft340_05.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asft340_05_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('sfeb003','4019')
   #end add-point
   
   CALL asft340_05_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asft340_05_ui_dialog()
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
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_j        LIKE type_t.num5
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
         CALL g_sfeb_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL asft340_05_init()
      END IF
   
      CALL asft340_05_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_sfeb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
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
   CALL asft340_05_set_pk_array()
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
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ins_sfeb
            LET g_action_choice="ins_sfeb"
            IF cl_auth_chk_act("ins_sfeb") THEN
               
               #add-point:ON ACTION ins_sfeb name="menu.ins_sfeb"
               CALL asft340_05_ins_sfeb() RETURNING g_sub_success
               IF g_sub_success THEN
                  LET g_action_choice="exit"
                  CANCEL DIALOG
               END IF             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL asft340_05_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asft340_05_modify()
            #add-point:ON ACTION modify name="menu.modify"
 
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL asft340_05_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL asft340_05_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
 
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION sel_all
            LET g_action_choice="sel_all"
            IF cl_auth_chk_act("sel_all") THEN
               
               #add-point:ON ACTION sel_all name="menu.sel_all"
               LET l_j = g_sfeb_d.getLength()
               IF l_j > 0 THEN      
                  FOR l_i = 1 TO l_j
                     LET g_sfeb_d[l_i].sel = 'Y' 
                  END FOR
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asft340_05_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unsel_all
            LET g_action_choice="unsel_all"
            IF cl_auth_chk_act("unsel_all") THEN
               
               #add-point:ON ACTION unsel_all name="menu.unsel_all"
               LET l_j = g_sfeb_d.getLength()
               IF l_j > 0 THEN      
                  FOR l_i = 1 TO l_j
                     LET g_sfeb_d[l_i].sel = 'N' 
                  END FOR
               END IF
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_sfeb_d)
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
            CALL asft340_05_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asft340_05_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asft340_05_set_pk_array()
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
 
{<section id="asft340_05.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asft340_05_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_sfac002     LIKE sfac_t.sfac002
   DEFINE l_where       STRING
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_sfeb_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON sfebdocno,sfebseq,sfeb001,sfeb026,sfeb003,sfeb004,sfeb005,sfeb006,sfeb007,sfeb010, 
          sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022, 
          sfeb027,sfeb028,sfebsite,l_sefb008_desc 
 
         FROM s_detail1[1].sfebdocno,s_detail1[1].sfebseq,s_detail1[1].sfeb001,s_detail1[1].sfeb026, 
             s_detail1[1].sfeb003,s_detail1[1].sfeb004,s_detail1[1].sfeb005,s_detail1[1].sfeb006,s_detail1[1].sfeb007, 
             s_detail1[1].sfeb010,s_detail1[1].sfeb011,s_detail1[1].sfeb012,s_detail1[1].sfeb013,s_detail1[1].sfeb014, 
             s_detail1[1].sfeb015,s_detail1[1].sfeb016,s_detail1[1].sfeb017,s_detail1[1].sfeb018,s_detail1[1].sfeb019, 
             s_detail1[1].sfeb020,s_detail1[1].sfeb021,s_detail1[1].sfeb022,s_detail1[1].sfeb027,s_detail1[1].sfeb028, 
             s_detail1[1].sfebsite,s_detail1[1].l_sefb008_desc 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebdocno
            #add-point:BEFORE FIELD sfebdocno name="query.b.page1.sfebdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebdocno
            
            #add-point:AFTER FIELD sfebdocno name="query.a.page1.sfebdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfebdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebdocno
            #add-point:ON ACTION controlp INFIELD sfebdocno name="query.c.page1.sfebdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebseq
            #add-point:BEFORE FIELD sfebseq name="query.b.page1.sfebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebseq
            
            #add-point:AFTER FIELD sfebseq name="query.a.page1.sfebseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebseq
            #add-point:ON ACTION controlp INFIELD sfebseq name="query.c.page1.sfebseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.sfeb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb001
            #add-point:ON ACTION controlp INFIELD sfeb001 name="construct.c.page1.sfeb001"
            #應用 a08 樣板自動產生(Version:3)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = 'F'            
            CALL s_aooi210_get_check_sql(g_site,'',g_sfebdocno,'4','','sfaadocno') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = l_where
               IF NOT cl_null(g_sfea004) THEN
                  LET g_qryparam.arg2 = g_sfea004
                  CALL q_sfaadocno_11()
               ELSE
                  CALL q_sfaadocno_10()                            #呼叫開窗
               END IF
               DISPLAY g_qryparam.return1 TO sfeb001   #顯示到畫面上
            END IF            
            NEXT FIELD sfeb001    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb001
            #add-point:BEFORE FIELD sfeb001 name="query.b.page1.sfeb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb001
            
            #add-point:AFTER FIELD sfeb001 name="query.a.page1.sfeb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb026
            #add-point:BEFORE FIELD sfeb026 name="query.b.page1.sfeb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb026
            
            #add-point:AFTER FIELD sfeb026 name="query.a.page1.sfeb026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb026
            #add-point:ON ACTION controlp INFIELD sfeb026 name="query.c.page1.sfeb026"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb026()
            DISPLAY g_qryparam.return1 TO sfeb026   #顯示到畫面上
            NEXT FIELD sfeb026   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb003
            #add-point:BEFORE FIELD sfeb003 name="query.b.page1.sfeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb003
            
            #add-point:AFTER FIELD sfeb003 name="query.a.page1.sfeb003"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb003
            #add-point:ON ACTION controlp INFIELD sfeb003 name="query.c.page1.sfeb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb004
            #add-point:BEFORE FIELD sfeb004 name="query.b.page1.sfeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb004
            
            #add-point:AFTER FIELD sfeb004 name="query.a.page1.sfeb004"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb004
            #add-point:ON ACTION controlp INFIELD sfeb004 name="query.c.page1.sfeb004"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb004()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb004   #顯示到畫面上
            NEXT FIELD sfeb004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb005
            #add-point:BEFORE FIELD sfeb005 name="query.b.page1.sfeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb005
            
            #add-point:AFTER FIELD sfeb005 name="query.a.page1.sfeb005"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb005
            #add-point:ON ACTION controlp INFIELD sfeb005 name="query.c.page1.sfeb005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb005()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb005   #顯示到畫面上
            NEXT FIELD sfeb005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb006
            #add-point:BEFORE FIELD sfeb006 name="query.b.page1.sfeb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb006
            
            #add-point:AFTER FIELD sfeb006 name="query.a.page1.sfeb006"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb006
            #add-point:ON ACTION controlp INFIELD sfeb006 name="query.c.page1.sfeb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb007
            #add-point:BEFORE FIELD sfeb007 name="query.b.page1.sfeb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb007
            
            #add-point:AFTER FIELD sfeb007 name="query.a.page1.sfeb007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb007
            #add-point:ON ACTION controlp INFIELD sfeb007 name="query.c.page1.sfeb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb010
            #add-point:BEFORE FIELD sfeb010 name="query.b.page1.sfeb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb010
            
            #add-point:AFTER FIELD sfeb010 name="query.a.page1.sfeb010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb010
            #add-point:ON ACTION controlp INFIELD sfeb010 name="query.c.page1.sfeb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb011
            #add-point:BEFORE FIELD sfeb011 name="query.b.page1.sfeb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb011
            
            #add-point:AFTER FIELD sfeb011 name="query.a.page1.sfeb011"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb011
            #add-point:ON ACTION controlp INFIELD sfeb011 name="query.c.page1.sfeb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb012
            #add-point:BEFORE FIELD sfeb012 name="query.b.page1.sfeb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb012
            
            #add-point:AFTER FIELD sfeb012 name="query.a.page1.sfeb012"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb012
            #add-point:ON ACTION controlp INFIELD sfeb012 name="query.c.page1.sfeb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb013
            #add-point:BEFORE FIELD sfeb013 name="query.b.page1.sfeb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb013
            
            #add-point:AFTER FIELD sfeb013 name="query.a.page1.sfeb013"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb013
            #add-point:ON ACTION controlp INFIELD sfeb013 name="query.c.page1.sfeb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb014
            #add-point:BEFORE FIELD sfeb014 name="query.b.page1.sfeb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb014
            
            #add-point:AFTER FIELD sfeb014 name="query.a.page1.sfeb014"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb014
            #add-point:ON ACTION controlp INFIELD sfeb014 name="query.c.page1.sfeb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb015
            #add-point:BEFORE FIELD sfeb015 name="query.b.page1.sfeb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb015
            
            #add-point:AFTER FIELD sfeb015 name="query.a.page1.sfeb015"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb015
            #add-point:ON ACTION controlp INFIELD sfeb015 name="query.c.page1.sfeb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb016
            #add-point:BEFORE FIELD sfeb016 name="query.b.page1.sfeb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb016
            
            #add-point:AFTER FIELD sfeb016 name="query.a.page1.sfeb016"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb016
            #add-point:ON ACTION controlp INFIELD sfeb016 name="query.c.page1.sfeb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb017
            #add-point:BEFORE FIELD sfeb017 name="query.b.page1.sfeb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb017
            
            #add-point:AFTER FIELD sfeb017 name="query.a.page1.sfeb017"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb017
            #add-point:ON ACTION controlp INFIELD sfeb017 name="query.c.page1.sfeb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb018
            #add-point:BEFORE FIELD sfeb018 name="query.b.page1.sfeb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb018
            
            #add-point:AFTER FIELD sfeb018 name="query.a.page1.sfeb018"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb018
            #add-point:ON ACTION controlp INFIELD sfeb018 name="query.c.page1.sfeb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb019
            #add-point:BEFORE FIELD sfeb019 name="query.b.page1.sfeb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb019
            
            #add-point:AFTER FIELD sfeb019 name="query.a.page1.sfeb019"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb019
            #add-point:ON ACTION controlp INFIELD sfeb019 name="query.c.page1.sfeb019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb020
            #add-point:BEFORE FIELD sfeb020 name="query.b.page1.sfeb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb020
            
            #add-point:AFTER FIELD sfeb020 name="query.a.page1.sfeb020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb020
            #add-point:ON ACTION controlp INFIELD sfeb020 name="query.c.page1.sfeb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb021
            #add-point:BEFORE FIELD sfeb021 name="query.b.page1.sfeb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb021
            
            #add-point:AFTER FIELD sfeb021 name="query.a.page1.sfeb021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb021
            #add-point:ON ACTION controlp INFIELD sfeb021 name="query.c.page1.sfeb021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb022
            #add-point:BEFORE FIELD sfeb022 name="query.b.page1.sfeb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb022
            
            #add-point:AFTER FIELD sfeb022 name="query.a.page1.sfeb022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb022
            #add-point:ON ACTION controlp INFIELD sfeb022 name="query.c.page1.sfeb022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb027
            #add-point:BEFORE FIELD sfeb027 name="query.b.page1.sfeb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb027
            
            #add-point:AFTER FIELD sfeb027 name="query.a.page1.sfeb027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb027
            #add-point:ON ACTION controlp INFIELD sfeb027 name="query.c.page1.sfeb027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb028
            #add-point:BEFORE FIELD sfeb028 name="query.b.page1.sfeb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb028
            
            #add-point:AFTER FIELD sfeb028 name="query.a.page1.sfeb028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfeb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb028
            #add-point:ON ACTION controlp INFIELD sfeb028 name="query.c.page1.sfeb028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebsite
            #add-point:BEFORE FIELD sfebsite name="query.b.page1.sfebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebsite
            
            #add-point:AFTER FIELD sfebsite name="query.a.page1.sfebsite"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.sfebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebsite
            #add-point:ON ACTION controlp INFIELD sfebsite name="query.c.page1.sfebsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sefb008_desc
            #add-point:BEFORE FIELD l_sefb008_desc name="query.b.page1.l_sefb008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sefb008_desc
            
            #add-point:AFTER FIELD l_sefb008_desc name="query.a.page1.l_sefb008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.l_sefb008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sefb008_desc
            #add-point:ON ACTION controlp INFIELD l_sefb008_desc name="query.c.page1.l_sefb008_desc"
            
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
    
   CALL asft340_05_b_fill(g_wc2)
 
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
 
{<section id="asft340_05.insert" >}
#+ 資料新增
PRIVATE FUNCTION asft340_05_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL asft340_05_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.modify" >}
#+ 資料修改
PRIVATE FUNCTION asft340_05_modify()
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
   DEFINE l_sfeadocno            LIKE sfea_t.sfeadocno
   DEFINE l_sfeadocdt            LIKE sfea_t.sfeadocdt
   DEFINE l_sfea002              LIKE sfea_t.sfea002
   DEFINE l_imaf071              LIKE imaf_t.imaf071
   DEFINE l_imaf081              LIKE imaf_t.imaf081
   DEFINE l_amount               LIKE sfeb_t.sfeb008
   DEFINE l_j                    LIKE type_t.num5
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
   LET g_flag = 1
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_sfeb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sfeb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asft340_05_b_fill(g_wc2)
            LET g_detail_cnt = g_sfeb_d.getLength()
         
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
            DISPLAY g_sfeb_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_sfeb_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_sfeb_d[l_ac].sfebdocno IS NOT NULL
               AND g_sfeb_d[l_ac].sfebseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sfeb_d_t.* = g_sfeb_d[l_ac].*  #BACKUP
               LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*  #BACKUP
               IF NOT asft340_05_lock_b("sfeb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asft340_05_bcl INTO g_sfeb_d[l_ac].sfebdocno,g_sfeb_d[l_ac].sfebseq,g_sfeb_d[l_ac].sfeb001, 
                      g_sfeb_d[l_ac].sfeb026,g_sfeb_d[l_ac].sfeb002,g_sfeb_d[l_ac].sfeb003,g_sfeb_d[l_ac].sfeb004, 
                      g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb008,g_sfeb_d[l_ac].sfeb009,g_sfeb_d[l_ac].sfeb006, 
                      g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011,g_sfeb_d[l_ac].sfeb012, 
                      g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_sfeb_d[l_ac].sfeb016, 
                      g_sfeb_d[l_ac].sfeb017,g_sfeb_d[l_ac].sfeb018,g_sfeb_d[l_ac].sfeb019,g_sfeb_d[l_ac].sfeb020, 
                      g_sfeb_d[l_ac].sfeb021,g_sfeb_d[l_ac].sfeb022,g_sfeb_d[l_ac].sfeb027,g_sfeb_d[l_ac].sfeb028, 
                      g_sfeb_d[l_ac].sfebsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sfeb_d_t.sfebdocno,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sfeb_d_mask_o[l_ac].* =  g_sfeb_d[l_ac].*
                  CALL asft340_05_sfeb_t_mask()
                  LET g_sfeb_d_mask_n[l_ac].* =  g_sfeb_d[l_ac].*
                  
                  CALL asft340_05_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asft340_05_set_entry_b(l_cmd)
            CALL asft340_05_set_no_entry_b(l_cmd)
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
            INITIALIZE g_sfeb_d_t.* TO NULL
            INITIALIZE g_sfeb_d_o.* TO NULL
            INITIALIZE g_sfeb_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身1)
                  LET g_sfeb_d[l_ac].sfeb008 = "0"
      LET g_sfeb_d[l_ac].sfeb009 = "0"
      LET g_sfeb_d[l_ac].sfeb011 = "0"
      LET g_sfeb_d[l_ac].sfeb012 = "0"
      LET g_sfeb_d[l_ac].sfeb027 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_sfeb_d_t.* = g_sfeb_d[l_ac].*     #新輸入資料
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sfeb_d[li_reproduce_target].* = g_sfeb_d[li_reproduce].*
 
               LET g_sfeb_d[g_sfeb_d.getLength()].sfebdocno = NULL
               LET g_sfeb_d[g_sfeb_d.getLength()].sfebseq = NULL
 
            END IF
            
 
            CALL asft340_05_set_entry_b(l_cmd)
            CALL asft340_05_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM sfeb_t 
             WHERE sfebent = g_enterprise AND sfebdocno = g_sfeb_d[l_ac].sfebdocno
                                       AND sfebseq = g_sfeb_d[l_ac].sfebseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfeb_d[g_detail_idx].sfebdocno
               LET gs_keys[2] = g_sfeb_d[g_detail_idx].sfebseq
               CALL asft340_05_insert_b('sfeb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_sfeb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asft340_05_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (sfebdocno = '", g_sfeb_d[l_ac].sfebdocno, "' "
                                  ," AND sfebseq = '", g_sfeb_d[l_ac].sfebseq, "' "
 
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
               
               DELETE FROM sfeb_t
                WHERE sfebent = g_enterprise AND 
                      sfebdocno = g_sfeb_d_t.sfebdocno
                      AND sfebseq = g_sfeb_d_t.sfebseq
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL asft340_05_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_sfeb_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE asft340_05_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_sfeb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfeb_d_t.sfebdocno
               LET gs_keys[2] = g_sfeb_d_t.sfebseq
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asft340_05_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL asft340_05_delete_b('sfeb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_sfeb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebdocno
            #add-point:BEFORE FIELD sfebdocno name="input.b.page1.sfebdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebdocno
            
            #add-point:AFTER FIELD sfebdocno name="input.a.page1.sfebdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_sfeb_d[g_detail_idx].sfebdocno IS NOT NULL AND g_sfeb_d[g_detail_idx].sfebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[g_detail_idx].sfebdocno != g_sfeb_d_t.sfebdocno OR g_sfeb_d[g_detail_idx].sfebseq != g_sfeb_d_t.sfebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM sfeb_t WHERE "||"sfebent = '" ||g_enterprise|| "' AND "||"sfebdocno = '"||g_sfeb_d[g_detail_idx].sfebdocno ||"' AND "|| "sfebseq = '"||g_sfeb_d[g_detail_idx].sfebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfebdocno
            #add-point:ON CHANGE sfebdocno name="input.g.page1.sfebdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebseq
            #add-point:BEFORE FIELD sfebseq name="input.b.page1.sfebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebseq
            
            #add-point:AFTER FIELD sfebseq name="input.a.page1.sfebseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_sfeb_d[g_detail_idx].sfebdocno IS NOT NULL AND g_sfeb_d[g_detail_idx].sfebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[g_detail_idx].sfebdocno != g_sfeb_d_t.sfebdocno OR g_sfeb_d[g_detail_idx].sfebseq != g_sfeb_d_t.sfebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM sfeb_t WHERE "||"sfebent = '" ||g_enterprise|| "' AND "||"sfebdocno = '"||g_sfeb_d[g_detail_idx].sfebdocno ||"' AND "|| "sfebseq = '"||g_sfeb_d[g_detail_idx].sfebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfebseq
            #add-point:ON CHANGE sfebseq name="input.g.page1.sfebseq"
            
            #END add-point 
 
 
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
            IF g_sfeb_d[g_detail_idx].sel = 'Y' AND (g_sfeb_d[g_detail_idx].sfeb008 = 0 OR cl_null(g_sfeb_d[g_detail_idx].sfeb008)) THEN
               LET g_sfeb_d[g_detail_idx].sel = 'N'
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code   = 'asf-00742'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb001
            #add-point:BEFORE FIELD sfeb001 name="input.b.page1.sfeb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb001
            
            #add-point:AFTER FIELD sfeb001 name="input.a.page1.sfeb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb001
            #add-point:ON CHANGE sfeb001 name="input.g.page1.sfeb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb026
            #add-point:BEFORE FIELD sfeb026 name="input.b.page1.sfeb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb026
            
            #add-point:AFTER FIELD sfeb026 name="input.a.page1.sfeb026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb026
            #add-point:ON CHANGE sfeb026 name="input.g.page1.sfeb026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb002
            #add-point:BEFORE FIELD sfeb002 name="input.b.page1.sfeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb002
            
            #add-point:AFTER FIELD sfeb002 name="input.a.page1.sfeb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb002
            #add-point:ON CHANGE sfeb002 name="input.g.page1.sfeb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb003
            #add-point:BEFORE FIELD sfeb003 name="input.b.page1.sfeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb003
            
            #add-point:AFTER FIELD sfeb003 name="input.a.page1.sfeb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb003
            #add-point:ON CHANGE sfeb003 name="input.g.page1.sfeb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb008
            #add-point:BEFORE FIELD sfeb008 name="input.b.page1.sfeb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb008
            
            #add-point:AFTER FIELD sfeb008 name="input.a.page1.sfeb008"
            IF g_sfeb_d[l_ac].sfeb008 < 0 THEN               
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code   = 'asf-00743'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD sfeb008
            END IF
            IF g_sfeb_d[l_ac].sfeb008 > 0 THEN
               IF g_sfeb_d[l_ac].sfeb008 > g_sfeb_d[l_ac].l_sefb008_desc THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'asf-00753'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_sfeb_d[l_ac].sfeb008 = g_sfeb_d[l_ac].l_sefb008_desc
                  NEXT FIELD sfeb008
               END IF
               #单位取位
               CALL s_aooi250_take_decimals(g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008)
                    RETURNING g_sub_success,g_sfeb_d[l_ac].sfeb008
                    
               SELECT sfeadocno,sfeadocdt,sfea002
                 INTO l_sfeadocno,l_sfeadocdt,l_sfea002
                 FROM sfea_t
                WHERE sfeaent = g_enterprise AND sfeadocno = g_sfebdocno
               CALL cl_err_collect_init() #汇总错误讯息初始化            
               CALL s_asft340_chk_sfeb008(l_sfeadocno,l_sfeadocdt,g_sfeb_d[l_ac].sfebseq,
                    g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,g_sfeb_d[l_ac].sfeb003,
                    g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,
                    g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008,g_sfeb_d_t.sfeb008)
                    RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL cl_err_collect_show()                                   
                  LET g_sfeb_d[l_ac].sfeb008 = g_sfeb_d_t.sfeb008
                  NEXT FIELD sfeb008
               END IF
               #为了要结束ERROR COLLECT的现象,重新呼叫一次
               CALL cl_err_collect_init() #汇总错误讯息初始化
               CALL cl_err_collect_show()
               #置sfeb011-参考数量
               CALL asft340_05_set_sfeb011()
              
               LET l_imaf071 = NULL
               LET l_imaf081 = NULL
               SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t WHERE imafent = g_enterprise
                 AND imafsite = g_site AND imaf001 = g_sfeb_d[l_ac].sfeb004
               IF l_imaf071 = '1' OR l_imaf081 = '1' THEN
                  IF NOT cl_null(g_sfebdocno) AND
                     NOT cl_null(g_sfeb_d[l_ac].sfebseq) AND
                     NOT cl_null(g_sfeb_d[l_ac].sfeb004) AND #料件
                     NOT cl_null(g_sfeb_d[l_ac].sfeb007) AND #单位
                     NOT cl_null(g_sfeb_d[l_ac].sfeb008) AND #数量
                     NOT cl_null(l_sfea002) THEN  #申请人
                     LET g_sub_success = ''
                     CALL s_lot_ins(g_site,g_sfebdocno,
                                    #目的單據項次                    目的單據項序(若單據沒有到項序層則此參數固定傳0)
                                    g_sfeb_d[l_ac].sfebseq,'1',
                                    #料件編號                        產品特徵
                                    g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,
                                    #交易單位                      交易數量                 
                                    g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008,
                                    '1',l_sfea002,'1',''
                                    ,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,  #151106-00018#4 add
                                    #指定庫位                指定儲位                指定批號
                                    g_sfeb_d[l_ac].sfeb016   #160316-00007#8-add
                                    #庫存管理特徵
                                    )
                          RETURNING g_sub_success,l_amount
                     IF g_sub_success THEN
                        IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
                           IF NOT asft340_05_ins_inao_2() THEN
                           END IF
                        END IF
                        IF g_sfeb_d[l_ac].sfeb008 <> l_amount THEN
                           IF cl_ask_confirm('ain-00249') THEN
                              CALL s_aooi250_convert_qty(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,
                                                         g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb008)                  
                                   RETURNING g_sub_success,g_sfeb_d[l_ac].sfeb011                              
                              LET g_sfeb_d[l_ac].sfeb008 = l_amount
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            #160805-00057 by whitney modify start
            IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
               LET g_sfeb_d[l_ac].sfeb009 = g_sfeb_d[l_ac].sfeb008
               LET g_sfeb_d[l_ac].sfeb027 = g_sfeb_d[l_ac].sfeb008
            ELSE
               LET g_sfeb_d[l_ac].sfeb009 = 0  
               LET g_sfeb_d[l_ac].sfeb027 = 0
            END IF
            #160805-00057 by whitney modify end

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb008
            #add-point:ON CHANGE sfeb008 name="input.g.page1.sfeb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb009
            #add-point:BEFORE FIELD sfeb009 name="input.b.page1.sfeb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb009
            
            #add-point:AFTER FIELD sfeb009 name="input.a.page1.sfeb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb009
            #add-point:ON CHANGE sfeb009 name="input.g.page1.sfeb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb006
            #add-point:BEFORE FIELD sfeb006 name="input.b.page1.sfeb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb006
            
            #add-point:AFTER FIELD sfeb006 name="input.a.page1.sfeb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb006
            #add-point:ON CHANGE sfeb006 name="input.g.page1.sfeb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb007
            #add-point:BEFORE FIELD sfeb007 name="input.b.page1.sfeb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb007
            
            #add-point:AFTER FIELD sfeb007 name="input.a.page1.sfeb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb007
            #add-point:ON CHANGE sfeb007 name="input.g.page1.sfeb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb010
            #add-point:BEFORE FIELD sfeb010 name="input.b.page1.sfeb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb010
            
            #add-point:AFTER FIELD sfeb010 name="input.a.page1.sfeb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb010
            #add-point:ON CHANGE sfeb010 name="input.g.page1.sfeb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb011
            #add-point:BEFORE FIELD sfeb011 name="input.b.page1.sfeb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb011
            
            #add-point:AFTER FIELD sfeb011 name="input.a.page1.sfeb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb011
            #add-point:ON CHANGE sfeb011 name="input.g.page1.sfeb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb012
            #add-point:BEFORE FIELD sfeb012 name="input.b.page1.sfeb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb012
            
            #add-point:AFTER FIELD sfeb012 name="input.a.page1.sfeb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb012
            #add-point:ON CHANGE sfeb012 name="input.g.page1.sfeb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb013
            #add-point:BEFORE FIELD sfeb013 name="input.b.page1.sfeb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb013
            
            #add-point:AFTER FIELD sfeb013 name="input.a.page1.sfeb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb013
            #add-point:ON CHANGE sfeb013 name="input.g.page1.sfeb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb014
            #add-point:BEFORE FIELD sfeb014 name="input.b.page1.sfeb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb014
            
            #add-point:AFTER FIELD sfeb014 name="input.a.page1.sfeb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb014
            #add-point:ON CHANGE sfeb014 name="input.g.page1.sfeb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb015
            #add-point:BEFORE FIELD sfeb015 name="input.b.page1.sfeb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb015
            
            #add-point:AFTER FIELD sfeb015 name="input.a.page1.sfeb015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb015
            #add-point:ON CHANGE sfeb015 name="input.g.page1.sfeb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb016
            #add-point:BEFORE FIELD sfeb016 name="input.b.page1.sfeb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb016
            
            #add-point:AFTER FIELD sfeb016 name="input.a.page1.sfeb016"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb016
            #add-point:ON CHANGE sfeb016 name="input.g.page1.sfeb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb017
            #add-point:BEFORE FIELD sfeb017 name="input.b.page1.sfeb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb017
            
            #add-point:AFTER FIELD sfeb017 name="input.a.page1.sfeb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb017
            #add-point:ON CHANGE sfeb017 name="input.g.page1.sfeb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb018
            #add-point:BEFORE FIELD sfeb018 name="input.b.page1.sfeb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb018
            
            #add-point:AFTER FIELD sfeb018 name="input.a.page1.sfeb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb018
            #add-point:ON CHANGE sfeb018 name="input.g.page1.sfeb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb019
            #add-point:BEFORE FIELD sfeb019 name="input.b.page1.sfeb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb019
            
            #add-point:AFTER FIELD sfeb019 name="input.a.page1.sfeb019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb019
            #add-point:ON CHANGE sfeb019 name="input.g.page1.sfeb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb020
            #add-point:BEFORE FIELD sfeb020 name="input.b.page1.sfeb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb020
            
            #add-point:AFTER FIELD sfeb020 name="input.a.page1.sfeb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb020
            #add-point:ON CHANGE sfeb020 name="input.g.page1.sfeb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb021
            #add-point:BEFORE FIELD sfeb021 name="input.b.page1.sfeb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb021
            
            #add-point:AFTER FIELD sfeb021 name="input.a.page1.sfeb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb021
            #add-point:ON CHANGE sfeb021 name="input.g.page1.sfeb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb022
            #add-point:BEFORE FIELD sfeb022 name="input.b.page1.sfeb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb022
            
            #add-point:AFTER FIELD sfeb022 name="input.a.page1.sfeb022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb022
            #add-point:ON CHANGE sfeb022 name="input.g.page1.sfeb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb027
            #add-point:BEFORE FIELD sfeb027 name="input.b.page1.sfeb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb027
            
            #add-point:AFTER FIELD sfeb027 name="input.a.page1.sfeb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb027
            #add-point:ON CHANGE sfeb027 name="input.g.page1.sfeb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb028
            #add-point:BEFORE FIELD sfeb028 name="input.b.page1.sfeb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb028
            
            #add-point:AFTER FIELD sfeb028 name="input.a.page1.sfeb028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb028
            #add-point:ON CHANGE sfeb028 name="input.g.page1.sfeb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebsite
            #add-point:BEFORE FIELD sfebsite name="input.b.page1.sfebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebsite
            
            #add-point:AFTER FIELD sfebsite name="input.a.page1.sfebsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfebsite
            #add-point:ON CHANGE sfebsite name="input.g.page1.sfebsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sefb008_desc
            #add-point:BEFORE FIELD l_sefb008_desc name="input.b.page1.l_sefb008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sefb008_desc
            
            #add-point:AFTER FIELD l_sefb008_desc name="input.a.page1.l_sefb008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sefb008_desc
            #add-point:ON CHANGE l_sefb008_desc name="input.g.page1.l_sefb008_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sfebdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebdocno
            #add-point:ON ACTION controlp INFIELD sfebdocno name="input.c.page1.sfebdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebseq
            #add-point:ON ACTION controlp INFIELD sfebseq name="input.c.page1.sfebseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb001
            #add-point:ON ACTION controlp INFIELD sfeb001 name="input.c.page1.sfeb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb026
            #add-point:ON ACTION controlp INFIELD sfeb026 name="input.c.page1.sfeb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb002
            #add-point:ON ACTION controlp INFIELD sfeb002 name="input.c.page1.sfeb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb003
            #add-point:ON ACTION controlp INFIELD sfeb003 name="input.c.page1.sfeb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb008
            #add-point:ON ACTION controlp INFIELD sfeb008 name="input.c.page1.sfeb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb009
            #add-point:ON ACTION controlp INFIELD sfeb009 name="input.c.page1.sfeb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb006
            #add-point:ON ACTION controlp INFIELD sfeb006 name="input.c.page1.sfeb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb007
            #add-point:ON ACTION controlp INFIELD sfeb007 name="input.c.page1.sfeb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb010
            #add-point:ON ACTION controlp INFIELD sfeb010 name="input.c.page1.sfeb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb011
            #add-point:ON ACTION controlp INFIELD sfeb011 name="input.c.page1.sfeb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb012
            #add-point:ON ACTION controlp INFIELD sfeb012 name="input.c.page1.sfeb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb013
            #add-point:ON ACTION controlp INFIELD sfeb013 name="input.c.page1.sfeb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb014
            #add-point:ON ACTION controlp INFIELD sfeb014 name="input.c.page1.sfeb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb015
            #add-point:ON ACTION controlp INFIELD sfeb015 name="input.c.page1.sfeb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb016
            #add-point:ON ACTION controlp INFIELD sfeb016 name="input.c.page1.sfeb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb017
            #add-point:ON ACTION controlp INFIELD sfeb017 name="input.c.page1.sfeb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb018
            #add-point:ON ACTION controlp INFIELD sfeb018 name="input.c.page1.sfeb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb019
            #add-point:ON ACTION controlp INFIELD sfeb019 name="input.c.page1.sfeb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb020
            #add-point:ON ACTION controlp INFIELD sfeb020 name="input.c.page1.sfeb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb021
            #add-point:ON ACTION controlp INFIELD sfeb021 name="input.c.page1.sfeb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb022
            #add-point:ON ACTION controlp INFIELD sfeb022 name="input.c.page1.sfeb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb027
            #add-point:ON ACTION controlp INFIELD sfeb027 name="input.c.page1.sfeb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb028
            #add-point:ON ACTION controlp INFIELD sfeb028 name="input.c.page1.sfeb028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebsite
            #add-point:ON ACTION controlp INFIELD sfebsite name="input.c.page1.sfebsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_sefb008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sefb008_desc
            #add-point:ON ACTION controlp INFIELD l_sefb008_desc name="input.c.page1.l_sefb008_desc"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE asft340_05_bcl
               LET INT_FLAG = 0
               LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*
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
               LET g_errparam.extend = g_sfeb_d[l_ac].sfebdocno 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
 
#               #end add-point
#               
#               #將遮罩欄位還原
#               CALL asft340_05_sfeb_t_mask_restore('restore_mask_o')
# 
#               UPDATE sfeb_t SET (sfebdocno,sfebseq,sfeb001,sfeb026,sfeb002,sfeb003,sfeb004,sfeb005, 
#                   sfeb008,sfeb009,sfeb006,sfeb007,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016, 
#                   sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022,sfeb027,sfeb028,sfebsite) = (g_sfeb_d[l_ac].sfebdocno, 
#                   g_sfeb_d[l_ac].sfebseq,g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,g_sfeb_d[l_ac].sfeb002, 
#                   g_sfeb_d[l_ac].sfeb003,g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb008, 
#                   g_sfeb_d[l_ac].sfeb009,g_sfeb_d[l_ac].sfeb006,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010, 
#                   g_sfeb_d[l_ac].sfeb011,g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014, 
#                   g_sfeb_d[l_ac].sfeb015,g_sfeb_d[l_ac].sfeb016,g_sfeb_d[l_ac].sfeb017,g_sfeb_d[l_ac].sfeb018, 
#                   g_sfeb_d[l_ac].sfeb019,g_sfeb_d[l_ac].sfeb020,g_sfeb_d[l_ac].sfeb021,g_sfeb_d[l_ac].sfeb022, 
#                   g_sfeb_d[l_ac].sfeb027,g_sfeb_d[l_ac].sfeb028,g_sfeb_d[l_ac].sfebsite)
#                WHERE sfebent = g_enterprise AND
#                  sfebdocno = g_sfeb_d_t.sfebdocno #項次   
#                  AND sfebseq = g_sfeb_d_t.sfebseq  
# 
#                  
#               #add-point:單身修改中 name="input.body.m_update"
               LET SQLCA.sqlerrd[3] = 1
               LET SQLCA.sqlcode = 0
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sfeb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfeb_d[g_detail_idx].sfebdocno
               LET gs_keys_bak[1] = g_sfeb_d_t.sfebdocno
               LET gs_keys[2] = g_sfeb_d[g_detail_idx].sfebseq
               LET gs_keys_bak[2] = g_sfeb_d_t.sfebseq
               CALL asft340_05_update_b('sfeb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_sfeb_d_t)
                     LET g_log2 = util.JSON.stringify(g_sfeb_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asft340_05_sfeb_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL asft340_05_unlock_b("sfeb_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*
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
               LET g_sfeb_d[li_reproduce_target].* = g_sfeb_d[li_reproduce].*
 
               LET g_sfeb_d[li_reproduce_target].sfebdocno = NULL
               LET g_sfeb_d[li_reproduce_target].sfebseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_sfeb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sfeb_d.getLength()+1
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
               NEXT FIELD sfebdocno
 
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
      IF INT_FLAG OR cl_null(g_sfeb_d[g_detail_idx].sfebdocno) THEN
         CALL g_sfeb_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_sfeb_d[g_detail_idx].* = g_sfeb_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   LET g_flag = 0
   #end add-point
 
   CLOSE asft340_05_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asft340_05_delete()
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
   FOR li_idx = 1 TO g_sfeb_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT asft340_05_lock_b("sfeb_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("sfeb_t","") THEN
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
   
   FOR li_idx = 1 TO g_sfeb_d.getLength()
      IF g_sfeb_d[li_idx].sfebdocno IS NOT NULL
         AND g_sfeb_d[li_idx].sfebseq IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM sfeb_t
          WHERE sfebent = g_enterprise AND 
                sfebdocno = g_sfeb_d[li_idx].sfebdocno
                AND sfebseq = g_sfeb_d[li_idx].sfebseq
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
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
               LET gs_keys[1] = g_sfeb_d_t.sfebdocno
               LET gs_keys[2] = g_sfeb_d_t.sfebseq
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL asft340_05_delete_b('sfeb_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asft340_05_set_pk_array()
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
   CALL asft340_05_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asft340_05_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #DEFINE l_sfaa           RECORD LIKE sfaa_t.*  #161109-00085#34
   DEFINE l_str            STRING
   DEFINE l_sfaa003        LIKE sfaa_t.sfaa003
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   IF g_flag THEN
      RETURN
   END IF
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.sfebdocno,t0.sfebseq,t0.sfeb001,t0.sfeb026,t0.sfeb002,t0.sfeb003, 
       t0.sfeb004,t0.sfeb005,t0.sfeb008,t0.sfeb009,t0.sfeb006,t0.sfeb007,t0.sfeb010,t0.sfeb011,t0.sfeb012, 
       t0.sfeb013,t0.sfeb014,t0.sfeb015,t0.sfeb016,t0.sfeb017,t0.sfeb018,t0.sfeb019,t0.sfeb020,t0.sfeb021, 
       t0.sfeb022,t0.sfeb027,t0.sfeb028,t0.sfebsite ,t1.imaal003 ,t2.imaal004 FROM sfeb_t t0",
               "",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.sfeb004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.sfeb004 AND t2.imaal002='"||g_dlang||"' ",
 
               " WHERE t0.sfebent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
   
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("sfeb_t"),
                      " ORDER BY t0.sfebdocno,t0.sfebseq"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   LET p_wc2 = cl_str_replace_multistr(p_wc2,'sfeb001','sfaadocno')
   LET p_wc2 = cl_str_replace_multistr(p_wc2,'sfeb004','sfac001')
   LET p_wc2 = cl_str_replace_multistr(p_wc2,'sfeb003','sfac002')
   LET p_wc2 = cl_str_replace_multistr(p_wc2,'sfeb005','sfac006')
   LET p_wc2 = cl_str_replace_multistr(p_wc2,'sfeb026','sfca001')

   IF NOT cl_null(g_sfea004) THEN
      #CALL q_sfaadocno_11()
      LET g_sql = " SELECT DISTINCT '','',sfaadocno,'','',sfac002, ",
                         " sfac001,sfac006,'','','',sfac004,'','','', ",
                         " '','','','','','','','','', ",
                         " '','','',sfaa003 ,t2.imaal003 ,t2.imaal004 ",
                  "   FROM sfqb_t,(SELECT sfaadocno,sfaa003,sfca001,sfac001,sfac002,sfac004,sfac006 ",
                            " FROM sfca_t,sfac_t,( SELECT DISTINCT sfaaent,sfaadocno,sfaa003  ",
                                                  " FROM sfaa_t ",
                                                "  WHERE sfaaent= ?  ",
                                                "    AND sfaasite = '",g_site,"' AND sfaastus = 'F' AND sfaa012 > (sfaa050 + sfaa051 + sfaa055 + sfaa056)",
                                                
                                              ")",
                             " WHERE sfaaent = sfcaent AND sfaadocno = sfcadocno ",
                               " AND sfaaent = sfacent AND sfaadocno = sfacdocno ",
                               " AND ",p_wc2,
                          ") t1",
                      " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=sfac001 AND t2.imaal002='"||g_dlang||"' ",
                     " WHERE sfaaent = sfqbent AND sfqb001 = sfaadocno AND sfqbdocno ='",g_sfea004,"'",
                     "  AND (sfaadocno,sfac001,sfac006) NOT IN (SELECT sfeb001,sfeb004,sfeb005 FROM sfeb_t WHERE sfebent = ",g_enterprise," AND sfebdocno ='",g_sfebdocno,"')"
   ELSE     
      #CALL q_sfaadocno_10()
      LET g_sql = " SELECT DISTINCT '','',sfaadocno,'','',sfac002, ",
                         " sfac001,sfac006,'','','',sfac004,'','','', ",
                         " '','','','','','','','','', ",
                         " '','','',sfaa003,imaal003,imaal004 ",
                  "  FROM (SELECT DISTINCT sfaadocno,sfac002,  sfac001,sfac006,sfac004,sfaa003 ,t2.imaal003 ,t2.imaal004 ",
                  "   FROM (SELECT sfaadocno,sfaa003,sfca001,sfac001,sfac002,sfac004,sfac006 ",
                            " FROM sfca_t,sfac_t,( SELECT DISTINCT sfaaent,sfaadocno,sfaa003  ",
                                                  " FROM sfaa_t ",
                                                "  WHERE sfaaent= ?  ",
                                                "    AND sfaasite = '",g_site,"' AND sfaastus = 'F' AND sfaa012 > (sfaa050 + sfaa051 + sfaa055 + sfaa056)",
                                                
                                              ")",
                             " WHERE sfaaent = sfcaent AND sfaadocno = sfcadocno ",
                               " AND sfaaent = sfacent AND sfaadocno = sfacdocno ",
                               " AND ",p_wc2,
                          ") t1",
                         " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=sfac001 AND t2.imaal002='"||g_dlang||"' " ,
                    ")" ,
                " WHERE (sfaadocno,sfac001,sfac006) NOT IN (SELECT sfeb001,sfeb004,sfeb005 FROM sfeb_t WHERE sfebent = ",g_enterprise," AND sfebdocno ='",g_sfebdocno,"')"
   END IF
   
   IF cl_null(g_wc_slip) THEN LET g_wc_slip = " 1=1" END IF
   LET g_sql = g_sql ," AND ",g_wc_slip  
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"sfeb_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asft340_05_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asft340_05_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_sfeb_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_sfeb_d[l_ac].sfebdocno,g_sfeb_d[l_ac].sfebseq,g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026, 
       g_sfeb_d[l_ac].sfeb002,g_sfeb_d[l_ac].sfeb003,g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb008, 
       g_sfeb_d[l_ac].sfeb009,g_sfeb_d[l_ac].sfeb006,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011, 
       g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_sfeb_d[l_ac].sfeb016, 
       g_sfeb_d[l_ac].sfeb017,g_sfeb_d[l_ac].sfeb018,g_sfeb_d[l_ac].sfeb019,g_sfeb_d[l_ac].sfeb020,g_sfeb_d[l_ac].sfeb021, 
       g_sfeb_d[l_ac].sfeb022,g_sfeb_d[l_ac].sfeb027,g_sfeb_d[l_ac].sfeb028,g_sfeb_d[l_ac].sfebsite, 
       g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #5.sfeb007 - 单位
      CALL asft340_05_set_sfeb007()      
      #13.sfeb026 - RUN CARD
      CALL asft340_05_set_sfeb026()    
      
      #14.sfeb008 - 申请数量
      CALL asft340_05_set_sfeb008()
      
      IF NOT g_sfeb_d[l_ac].sfeb008 > 0 THEN
         CONTINUE FOREACH
      END IF
      LET g_sfeb_d[l_ac].l_sefb008_desc = g_sfeb_d[l_ac].sfeb008 
      CALL asft340_05_sfeb001_reference()
      LET g_sfeb_d[l_ac].sel = 'Y'
      LET g_sfeb_d[l_ac].sfebdocno = g_sfebdocno
      LET g_sfeb_d[l_ac].sfebseq = 1

      LET g_sfeb_d[l_ac].sfebsite = g_site
      #160805-00057 by whitney modify start
      #LET g_sfeb_d[l_ac].sfeb009 = 0
      #LET g_sfeb_d[l_ac].sfeb027 = 0
      IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
         LET g_sfeb_d[l_ac].sfeb009 = g_sfeb_d[l_ac].sfeb008
         LET g_sfeb_d[l_ac].sfeb027 = g_sfeb_d[l_ac].sfeb008
      ELSE
         LET g_sfeb_d[l_ac].sfeb009 = 0  
         LET g_sfeb_d[l_ac].sfeb027 = 0
      END IF
      #160805-00057 by whitney modify end
      LET g_sfeb_d[l_ac].sfeb012 = 0
      #end add-point
      
      CALL asft340_05_detail_show()      
 
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
   
 
   
   CALL g_sfeb_d.deleteElement(g_sfeb_d.getLength())   
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_sfeb_d.getLength()
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_sfeb_d.getLength() THEN
      LET l_ac = g_sfeb_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_sfeb_d.getLength()
      LET g_sfeb_d_mask_o[l_ac].* =  g_sfeb_d[l_ac].*
      CALL asft340_05_sfeb_t_mask()
      LET g_sfeb_d_mask_n[l_ac].* =  g_sfeb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_sfeb_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE asft340_05_pb
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asft340_05_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
 
   #end add-point
   
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asft340_05_set_entry_b(p_cmd)                                                  
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
 
{<section id="asft340_05.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asft340_05_set_no_entry_b(p_cmd)                                               
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
 
{<section id="asft340_05.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asft340_05_default_search()
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
      LET ls_wc = ls_wc, " sfebdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " sfebseq = '", g_argv[02], "' AND "
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
   LET g_wc2 = " 1=2"
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asft340_05_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "sfeb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'sfeb_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM sfeb_t
          WHERE sfebent = g_enterprise AND
            sfebdocno = ps_keys_bak[1] AND sfebseq = ps_keys_bak[2]
         
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
         CALL g_sfeb_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asft340_05_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "sfeb_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO sfeb_t
                  (sfebent,
                   sfebdocno,sfebseq
                   ,sfeb001,sfeb026,sfeb002,sfeb003,sfeb004,sfeb005,sfeb008,sfeb009,sfeb006,sfeb007,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022,sfeb027,sfeb028,sfebsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,g_sfeb_d[l_ac].sfeb002,g_sfeb_d[l_ac].sfeb003, 
                       g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb008,g_sfeb_d[l_ac].sfeb009, 
                       g_sfeb_d[l_ac].sfeb006,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011, 
                       g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015, 
                       g_sfeb_d[l_ac].sfeb016,g_sfeb_d[l_ac].sfeb017,g_sfeb_d[l_ac].sfeb018,g_sfeb_d[l_ac].sfeb019, 
                       g_sfeb_d[l_ac].sfeb020,g_sfeb_d[l_ac].sfeb021,g_sfeb_d[l_ac].sfeb022,g_sfeb_d[l_ac].sfeb027, 
                       g_sfeb_d[l_ac].sfeb028,g_sfeb_d[l_ac].sfebsite)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asft340_05_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "sfeb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "sfeb_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE sfeb_t 
         SET (sfebdocno,sfebseq
              ,sfeb001,sfeb026,sfeb002,sfeb003,sfeb004,sfeb005,sfeb008,sfeb009,sfeb006,sfeb007,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb017,sfeb018,sfeb019,sfeb020,sfeb021,sfeb022,sfeb027,sfeb028,sfebsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,g_sfeb_d[l_ac].sfeb002,g_sfeb_d[l_ac].sfeb003, 
                  g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb008,g_sfeb_d[l_ac].sfeb009, 
                  g_sfeb_d[l_ac].sfeb006,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011, 
                  g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015, 
                  g_sfeb_d[l_ac].sfeb016,g_sfeb_d[l_ac].sfeb017,g_sfeb_d[l_ac].sfeb018,g_sfeb_d[l_ac].sfeb019, 
                  g_sfeb_d[l_ac].sfeb020,g_sfeb_d[l_ac].sfeb021,g_sfeb_d[l_ac].sfeb022,g_sfeb_d[l_ac].sfeb027, 
                  g_sfeb_d[l_ac].sfeb028,g_sfeb_d[l_ac].sfebsite) 
         WHERE sfebent = g_enterprise AND sfebdocno = ps_keys_bak[1] AND sfebseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfeb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
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
 
{<section id="asft340_05.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asft340_05_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   LET ls_group = "sfeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asft340_05_bcl USING g_enterprise,
                                       g_sfeb_d[g_detail_idx].sfebdocno

                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asft340_05_bcl:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
   RETURN TRUE
   #end add-point
   
   #先刷新資料
   #CALL asft340_05_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "sfeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asft340_05_bcl USING g_enterprise,
                                       g_sfeb_d[g_detail_idx].sfebdocno,g_sfeb_d[g_detail_idx].sfebseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asft340_05_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asft340_05_unlock_b(ps_table)
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
      CLOSE asft340_05_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION asft340_05_modify_detail_chk(ps_record)
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
         LET ls_return = "sfebdocno"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="asft340_05.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION asft340_05_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="asft340_05.mask_functions" >}
&include "erp/asf/asft340_05_mask.4gl"
 
{</section>}
 
{<section id="asft340_05.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asft340_05_set_pk_array()
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
   LET g_pk_array[1].values = g_sfeb_d[l_ac].sfebdocno
   LET g_pk_array[1].column = 'sfebdocno'
   LET g_pk_array[2].values = g_sfeb_d[l_ac].sfebseq
   LET g_pk_array[2].column = 'sfebseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asft340_05.state_change" >}
   
 
{</section>}
 
{<section id="asft340_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asft340_05.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 16/07/21 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_sfeb001_reference()
   #161109-00085#34-s
   #DEFINE l_sfaa           RECORD LIKE sfaa_t.*
   DEFINE l_sfaa RECORD  #工單單頭檔
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa059 LIKE sfaa_t.sfaa059  #預計入庫批號
   END RECORD
   #161109-00085#34-e
DEFINE l_str            STRING
 
   
   #161109-00085#34-s
   #SELECT * INTO l_sfaa.* FROM sfaa_t
   SELECT sfaa028,sfaa029,sfaa030,sfaa034,sfaa035,sfaa044,sfaa059
     INTO l_sfaa.sfaa028,l_sfaa.sfaa029,l_sfaa.sfaa030,l_sfaa.sfaa034,l_sfaa.sfaa035,
          l_sfaa.sfaa044,l_sfaa.sfaa059
     FROM sfaa_t
   #161109-00085#34-s
    WHERE sfaaent   = g_enterprise
      AND sfaasite  = g_site
      AND sfaadocno = g_sfeb_d[l_ac].sfeb001
   
   #1.sfeb002  -FQC否
   CALL asft340_05_set_sfeb002(l_sfaa.sfaa044,g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb003)
        RETURNING g_sfeb_d[l_ac].sfeb002 
        
   #7.sfeb010 - 参考单位
   CALL asft340_05_set_sfeb010(g_sfeb_d[l_ac].sfeb004)  
        RETURNING g_sfeb_d[l_ac].sfeb010
   
   #8.sfeb011 - 参考数量
   CALL asft340_05_set_sfeb011()
   
   #9.sfeb013/sfeb014/sfeb015 - 仓/批/批
   CALL s_asft340_set_warehouses(g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb004,l_sfaa.sfaa034,l_sfaa.sfaa035,l_sfaa.sfaa059)  
        RETURNING g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015

   #10.sfeb017 - 专案代号
   CALL asft340_05_set_sfeb017(l_sfaa.sfaa028)
   
   #11.sfeb018 - WBS
   CALL asft340_05_set_sfeb018(l_sfaa.sfaa029)   
   
   #12.sfeb018 - 活动代号
   CALL asft340_05_set_sfeb019(l_sfaa.sfaa030)   
   
   
   #置有效日期
   CALL asft340_05_set_sfeb021()  
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb002(p_sfaa044,p_sfeb001,p_sfeb003)
   DEFINE p_sfaa044     LIKE sfaa_t.sfaa044      #FQC否      
   DEFINE p_sfeb001     LIKE sfeb_t.sfeb001
   DEFINE p_sfeb003     LIKE sfeb_t.sfeb003        
   DEFINE r_sfeb002     LIKE sfeb_t.sfeb002                     
   DEFINE l_str         LIKE ooab_t.ooab002      #参数值                                  
   DEFINE l_doc_type    LIKE ooba_t.ooba002                                               
   DEFINE l_success     LIKE type_t.num5                                                  
   DEFINE l_ooef004     LIKE ooef_t.ooef004                                               
   DEFINE l_sfaasite    LIKE sfaa_t.sfaasite
   
   LET r_sfeb002 = 'N'                                                                
   SELECT sfaa044,sfaasite INTO p_sfaa044,l_sfaasite FROM sfaa_t                                           
    WHERE sfaaent   = g_enterprise                                                     
      AND sfaadocno = p_sfeb001                                           
   LET r_sfeb002 = p_sfaa044                                                 
                                                                                          
   #5.副产品/回收料                                                                       
   IF p_sfeb003 = '5' THEN                                                   
      #若参数 "副产品/回收料是否FQC" = 'N'时,sfeb002 = 'N';若参数值为'Y'时,取sfaa044      
      CALL s_aooi200_get_slip(p_sfeb001)                                     
           RETURNING l_success,l_doc_type                                                 
      SELECT ooef004 INTO l_ooef004 FROM ooef_t                                           
       WHERE ooefent = g_enterprise                                                       
         AND ooef001 = l_sfaasite                                              
      LET l_str = cl_get_doc_para(g_enterprise,l_sfaasite,l_doc_type,'D-MFG-0051') 
      IF l_str = 'N' THEN                                                                 
         LET r_sfeb002 = 'N'                                                 
      END IF                                                                              
   END IF  
   
   RETURN r_sfeb002    
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb003(p_cmd,p_sfaa003)
   DEFINE p_cmd         LIKE type_t.chr1
   DEFINE p_sfaa003     LIKE sfaa_t.sfaa003
   DEFINE l_cbo         ui.ComboBox
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_default     LIKE sfeb_t.sfeb003
   DEFINE r_valid       STRING               #160307-00009 by whitney modify chr10 -> STRING
   
   LET r_valid = '1、2、3、4、5'   #sfeb003的合理值范围  #160307-00009 by whitney add '、'
   LET l_default = '1'
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb001) THEN
      IF cl_null(p_sfaa003) THEN
         SELECT sfaa003 INTO p_sfaa003 FROM sfaa_t
          WHERE sfaaent   = g_enterprise
            AND sfaasite  = g_site
            AND sfaadocno = g_sfeb_d[l_ac].sfeb001   
      END IF
      CASE p_sfaa003 
           WHEN '1'   #一般工单
                #多产出主件个数
                SELECT COUNT(1) INTO l_cnt FROM sfac_t
                WHERE sfacent   = g_enterprise
                  AND sfacsite  = g_site
                  AND sfacdocno = g_sfeb_d[l_ac].sfeb001
                  AND sfac002   = '3'
                IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                IF l_cnt > 0 THEN                   
                   LET l_default = '3'  #多产出主件
                   LET r_valid = '3、5'  #160307-00009 by whitney add '、'
                ELSE
                   LET l_default = '1'  #一般 
                   LET r_valid = '1、2、5'  #160307-00009 by whitney add '、'               
                END IF         
           WHEN '3'   #拆件式工单
                LET l_default = '4'   #拆件式 
                LET r_valid = '4'
      END CASE
   END IF
   
   IF p_cmd = 'a' THEN
      LET g_sfeb_d[l_ac].sfeb003 = l_default
   END IF
   RETURN r_valid
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........
# Date & Author..:
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb004()
   DEFINE l_sfac002     LIKE sfac_t.sfac002
   DEFINE l_cnt         LIKE type_t.num5

   #sfeb003 = 3.多产出主件 4.拆件式 时,不可对sfeb004进行预设- BY SA
   IF g_sfeb_d[l_ac].sfeb003 MATCHES '[34]' THEN
      RETURN 
   END IF
   
   LET l_sfac002 = g_sfeb_d[l_ac].sfeb003
   #查看笔数
   SELECT COUNT(UNIQUE sfac001) INTO l_cnt
     FROM sfac_t
    WHERE sfacent = g_enterprise
      AND sfacsite = g_site
      AND sfacdocno = g_sfeb_d[l_ac].sfeb001
      AND sfac002 = l_sfac002
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt = 1 THEN
      #若仅有一笔时,需要做sfeb004的DEFAULT
      SELECT UNIQUE sfac001 INTO g_sfeb_d[l_ac].sfeb004
        FROM sfac_t
       WHERE sfacent   = g_enterprise
         AND sfacsite  = g_site
         AND sfacdocno = g_sfeb_d[l_ac].sfeb001
         AND sfac002   = l_sfac002        
   END IF  
   
   CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
        RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc
   DISPLAY BY NAME g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb005()
   DEFINE l_cnt         LIKE type_t.num5
   
   #sfeb003 = 4.拆件式 5.回收料/副产品时,不可对sfeb005进行预设
   IF g_sfeb_d[l_ac].sfeb003 MATCHES '[45]' THEN
      RETURN 
   END IF
   
   #查看特征值笔数
   SELECT COUNT(1) INTO l_cnt
     FROM sfac_t
    WHERE sfacent   = g_enterprise
      AND sfacsite  = g_site
      AND sfacdocno = g_sfeb_d[l_ac].sfeb001
      AND sfac001   = g_sfeb_d[l_ac].sfeb004
      AND sfac002   = g_sfeb_d[l_ac].sfeb003

   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt = 1 THEN
      #若仅有一笔时,需要做sfeb005的DEFAULT
      SELECT sfac006 INTO g_sfeb_d[l_ac].sfeb005
        FROM sfac_t
       WHERE sfacent   = g_enterprise
         AND sfacsite  = g_site
         AND sfacdocno = g_sfeb_d[l_ac].sfeb001
         AND sfac001   = g_sfeb_d[l_ac].sfeb004
         AND sfac002   = g_sfeb_d[l_ac].sfeb003     
      IF g_sfeb_d[l_ac].sfeb005 IS NULL THEN
         LET g_sfeb_d[l_ac].sfeb005 = ' '
      END IF
   ELSE
      LET g_sfeb_d[l_ac].sfeb005 = ' '
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb007()
   DEFINE l_sfac002         LIKE sfac_t.sfac002
   DEFINE l_sfac004         LIKE sfac_t.sfac004
           
   #拆件式的单位DEFAULT料件主档,其他类型要DEFAULT工单联产品档     
   IF g_sfeb_d[l_ac].sfeb003 = '4' THEN
      SELECT imae016 INTO l_sfac004 FROM imae_t
       WHERE imaeent  = g_enterprise
         AND imaesite = g_site
         AND imae001  = g_sfeb_d[l_ac].sfeb004
      LET g_sfeb_d[l_ac].sfeb007 = l_sfac004
   END IF

   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb008()
   DEFINE r_qty         LIKE sfeb_t.sfeb009
   DEFINE l_qty1        LIKE sfeb_t.sfeb009
   DEFINE l_qty2        LIKE sfeb_t.sfeb009 
   DEFINE l_sfac004     LIKE sfac_t.sfac004
   DEFINE l_rate        LIKE inaj_t.inaj014   #单位转换率
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sfeb008     LIKE sfeb_t.sfeb008   #单位取位过的数量
   DEFINE l_imaa005     LIKE imaa_t.imaa005   #是否有產品特徵的功能 #160322-00022#1-add
   DEFINE l_sfeadocdt   LIKE sfea_t.sfeadocdt
   
   LET g_sfeb_d[l_ac].sfeb008 = 0 
   IF g_sfeb_d[l_ac].sfeb003 NOT MATCHES '[123]' THEN
      RETURN 
   END IF
   SELECT sfeadocdt INTO l_sfeadocdt
     FROM sfea_t
    WHERE sfeaent = g_enterprise
      AND sfeadocno = g_sfebdocno
   IF cl_null(g_sfeb_d[l_ac].sfeb001) OR cl_null(g_sfeb_d[l_ac].sfeb026) OR 
      cl_null(g_sfeb_d[l_ac].sfeb004) OR cl_null(g_sfeb_d[l_ac].sfeb007) THEN
      RETURN
   ELSE
      #判斷料件是否存在產品特徵
      LET l_imaa005 = ''
      SELECT imaa005 INTO l_imaa005 FROM imaa_t 
       WHERE imaaent = g_enterprise AND imaa001 = g_sfeb_d[l_ac].sfeb004
      IF NOT cl_null(l_imaa005) THEN
         IF cl_null(g_sfeb_d[l_ac].sfeb005) THEN
            RETURN
         END IF
      END IF
   END IF
   #160322-00022#1-mod-(E)

   #l_qty1可入库的数量 BY 工单单位
   CASE g_sfeb_d[l_ac].sfeb003
        WHEN '1'  #一般
             CALL s_asft340_avariable_store_in_qty_1('1',g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,
                                                     g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,
                                                     g_sfeb_d[l_ac].sfeb007,l_sfeadocdt,0,0)
                  RETURNING l_qty1
        WHEN '2'  #联产品
             CALL s_asft340_avariable_store_in_qty_1('1',g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,
                                                     g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,
                                                     g_sfeb_d[l_ac].sfeb007,l_sfeadocdt,0,0)
                  RETURNING l_qty1    
        WHEN '3'  #多产出主件                  
             CALL s_asft340_avariable_store_in_qty_2('1',g_sfeb_d[l_ac].sfeb001,g_sfeb_d[l_ac].sfeb026,
                                                     g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,  #161021-00009#1 add g_sfeb_d[l_ac].sfeb005
                                                     g_sfeb_d[l_ac].sfeb007,l_sfeadocdt,0,0)             
                  RETURNING l_qty1                  
                  
   END CASE 
   
   IF cl_null(l_qty1) THEN LET l_qty1 = 0 END IF

   #l_qty2 可入为数量 BY入库单位
   #取生产单位
   SELECT sfac004 INTO l_sfac004 FROM sfac_t
    WHERE sfacent   = g_enterprise
      AND sfacdocno = g_sfeb_d[l_ac].sfeb001
      AND sfac001   = g_sfeb_d[l_ac].sfeb004
      AND sfac006   = g_sfeb_d[l_ac].sfeb005
   IF SQLCA.sqlcode THEN
      LET l_qty2 = l_qty1
   ELSE
      IF g_sfeb_d[l_ac].sfeb007 <> l_sfac004 THEN
         CALL s_aooi250_convert_qty1(g_sfeb_d[l_ac].sfeb004,l_sfac004,g_sfeb_d[l_ac].sfeb007,l_qty1)
              RETURNING l_success,l_qty2
         IF NOT l_success THEN
            LET l_qty2 = l_qty1
         END IF
      ELSE
         LET l_qty2 = l_qty1
      END IF   
   END IF
   
   #g_sfeb008_t为本笔在数据库中的数量
   IF cl_null(g_sfeb008_t) THEN LET g_sfeb008_t = 0 END IF
   
   LET g_sfeb_d[l_ac].sfeb008 = l_qty2 + g_sfeb008_t
    
   CALL s_aooi250_take_decimals(g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008)
        RETURNING l_success,l_sfeb008

   LET g_sfeb_d[l_ac].sfeb008 = l_sfeb008
   IF cl_null(g_sfeb_d[l_ac].sfeb008) THEN 
      LET g_sfeb_d[l_ac].sfeb008 = 0 
      RETURN
   END IF
   
   IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
      LET g_sfeb_d[l_ac].sfeb009 = g_sfeb_d[l_ac].sfeb008
      LET g_sfeb_d[l_ac].sfeb027 = g_sfeb_d[l_ac].sfeb008
   ELSE
      LET g_sfeb_d[l_ac].sfeb009 = 0  
      LET g_sfeb_d[l_ac].sfeb027 = 0
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb010(p_sfeb004)
   DEFINE p_sfeb004      LIKE sfeb_t.sfeb004
   DEFINE r_sfeb010      LIKE sfeb_t.sfeb010
   DEFINE l_imaf015      LIKE imaf_t.imaf015
  
   LET r_sfeb010 = NULL
   
   LET l_imaf015 = NULL
   SELECT imaf015 INTO l_imaf015 FROM imaf_t
    WHERE imafent  = g_enterprise
      AND imafsite = g_site
      AND imaf001  = p_sfeb004
   LET r_sfeb010 = l_imaf015
   
   RETURN r_sfeb010
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb011()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   
   #若没有参考单位时,参考数量DEFAULT NULL
   IF cl_null(g_sfeb_d[l_ac].sfeb010) THEN
      LET g_sfeb_d[l_ac].sfeb011 = NULL
      LET g_sfeb_d[l_ac].sfeb012 = NULL
      RETURN
   END IF
   
   IF cl_null(g_sfeb_d[l_ac].sfeb008) THEN
      RETURN
   END IF

   IF NOT cl_null(g_sfeb_d[l_ac].sfeb007) AND NOT cl_null(g_sfeb_d[l_ac].sfeb010) THEN
      CALL s_aooi250_convert_qty1(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb008)
           RETURNING l_success,g_sfeb_d[l_ac].sfeb011
      IF NOT l_success THEN
         LET g_sfeb_d[l_ac].sfeb011 = g_sfeb_d[l_ac].sfeb008
      END IF  
   ELSE
      LET g_sfeb_d[l_ac].sfeb011 = g_sfeb_d[l_ac].sfeb008
   END IF
   
   CALL s_aooi250_take_decimals(g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011)
        RETURNING l_success,g_sfeb_d[l_ac].sfeb011
   
   IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
      LET g_sfeb_d[l_ac].sfeb012 = g_sfeb_d[l_ac].sfeb011
   ELSE
      LET g_sfeb_d[l_ac].sfeb012 = 0  
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..:
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb017(p_sfaa028)
   DEFINE p_sfaa028      LIKE sfaa_t.sfaa028
   
   IF cl_null(p_sfaa028) THEN
      SELECT sfaa028 INTO p_sfaa028 FROM sfaa_t
       WHERE sfaaent = g_enterprise
         AND sfaadocno = g_sfeb_d[l_ac].sfeb001
   END IF

   LET g_sfeb_d[l_ac].sfeb017 = p_sfaa028
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb018(p_sfaa029)
DEFINE p_sfaa029     LIKE sfaa_t.sfaa029

   IF cl_null(p_sfaa029) THEN
      SELECT sfaa029 INTO p_sfaa029 FROM sfaa_t
       WHERE sfaaent = g_enterprise
         AND sfaadocno = g_sfeb_d[l_ac].sfeb001
   END IF

   LET g_sfeb_d[l_ac].sfeb018 = p_sfaa029
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb019(p_sfaa030)
   DEFINE p_sfaa030      LIKE sfaa_t.sfaa030
   
   IF cl_null(p_sfaa030) THEN
      SELECT sfaa030 INTO p_sfaa030 FROM sfaa_t
       WHERE sfaaent = g_enterprise
         AND sfaadocno = g_sfeb_d[l_ac].sfeb001
   END IF

   LET g_sfeb_d[l_ac].sfeb019 = p_sfaa030
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb026()
DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_sfcb001     LIKE sfcb_t.sfcb001
   
   LET g_sfeb_d[l_ac].sfeb026 = ''
   #查看特征值笔数
   SELECT COUNT(UNIQUE sfcb001) INTO l_cnt
     FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbdocno = g_sfeb_d[l_ac].sfeb001

   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt = 1 THEN
      #若仅有一笔时,需要做sfeb026的DEFAULT
      SELECT UNIQUE sfcb001 INTO g_sfeb_d[l_ac].sfeb026
        FROM sfcb_t
       WHERE sfcbent   = g_enterprise
         AND sfcbdocno = g_sfeb_d[l_ac].sfeb001      
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..:
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_set_sfeb021()
DEFINE l_sfeasite    LIKE sfea_t.sfeasite   
DEFINE l_sfeadocdt   LIKE sfea_t.sfeadocdt   

   SELECT sfeasite,sfeadocdt INTO l_sfeasite,l_sfeadocdt
     FROM sfea_t
    WHERE sfeaent = g_enterprise
      AND sfeadocno = g_sfebdocno
   CALL s_aini010_calculate_effdt(l_sfeasite,g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb015,l_sfeadocdt)
        RETURNING g_sfeb_d[l_ac].sfeb021
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_ins_inao_2()
DEFINE  l_sql       STRING
#161109-00085#34-s
#DEFINE  l_inao      RECORD LIKE inao_t.*
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企業編號
       inaosite LIKE inao_t.inaosite, #營運據點
       inaodocno LIKE inao_t.inaodocno, #單號
       inaoseq LIKE inao_t.inaoseq, #項次
       inaoseq1 LIKE inao_t.inaoseq1, #項序
       inaoseq2 LIKE inao_t.inaoseq2, #序號
       inao000 LIKE inao_t.inao000, #資料類型
       inao001 LIKE inao_t.inao001, #料件編號
       inao002 LIKE inao_t.inao002, #產品特徵
       inao003 LIKE inao_t.inao003, #庫存管理特徵
       inao004 LIKE inao_t.inao004, #包裝容器編號
       inao005 LIKE inao_t.inao005, #庫位
       inao006 LIKE inao_t.inao006, #儲位
       inao007 LIKE inao_t.inao007, #批號
       inao008 LIKE inao_t.inao008, #製造批號
       inao009 LIKE inao_t.inao009, #製造序號
       inao010 LIKE inao_t.inao010, #製造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #數量
       inao013 LIKE inao_t.inao013, #出入庫碼
       #161109-00085#63 --s add
       inaoud001 LIKE inao_t.inaoud001, #自定義欄位(文字)001
       inaoud002 LIKE inao_t.inaoud002, #自定義欄位(文字)002
       inaoud003 LIKE inao_t.inaoud003, #自定義欄位(文字)003
       inaoud004 LIKE inao_t.inaoud004, #自定義欄位(文字)004
       inaoud005 LIKE inao_t.inaoud005, #自定義欄位(文字)005
       inaoud006 LIKE inao_t.inaoud006, #自定義欄位(文字)006
       inaoud007 LIKE inao_t.inaoud007, #自定義欄位(文字)007
       inaoud008 LIKE inao_t.inaoud008, #自定義欄位(文字)008
       inaoud009 LIKE inao_t.inaoud009, #自定義欄位(文字)009
       inaoud010 LIKE inao_t.inaoud010, #自定義欄位(文字)010
       inaoud011 LIKE inao_t.inaoud011, #自定義欄位(數字)011
       inaoud012 LIKE inao_t.inaoud012, #自定義欄位(數字)012
       inaoud013 LIKE inao_t.inaoud013, #自定義欄位(數字)013
       inaoud014 LIKE inao_t.inaoud014, #自定義欄位(數字)014
       inaoud015 LIKE inao_t.inaoud015, #自定義欄位(數字)015
       inaoud016 LIKE inao_t.inaoud016, #自定義欄位(數字)016
       inaoud017 LIKE inao_t.inaoud017, #自定義欄位(數字)017
       inaoud018 LIKE inao_t.inaoud018, #自定義欄位(數字)018
       inaoud019 LIKE inao_t.inaoud019, #自定義欄位(數字)019
       inaoud020 LIKE inao_t.inaoud020, #自定義欄位(數字)020
       inaoud021 LIKE inao_t.inaoud021, #自定義欄位(日期時間)021
       inaoud022 LIKE inao_t.inaoud022, #自定義欄位(日期時間)022
       inaoud023 LIKE inao_t.inaoud023, #自定義欄位(日期時間)023
       inaoud024 LIKE inao_t.inaoud024, #自定義欄位(日期時間)024
       inaoud025 LIKE inao_t.inaoud025, #自定義欄位(日期時間)025
       inaoud026 LIKE inao_t.inaoud026, #自定義欄位(日期時間)026
       inaoud027 LIKE inao_t.inaoud027, #自定義欄位(日期時間)027
       inaoud028 LIKE inao_t.inaoud028, #自定義欄位(日期時間)028
       inaoud029 LIKE inao_t.inaoud029, #自定義欄位(日期時間)029
       inaoud030 LIKE inao_t.inaoud030, #自定義欄位(日期時間)030
       #161109-00085#63 --e add
       inao014 LIKE inao_t.inao014, #庫存單位
       inao020 LIKE inao_t.inao020, #檢驗合格量
       inao021 LIKE inao_t.inao021, #已入庫/出貨/簽收量
       inao022 LIKE inao_t.inao022, #已驗退/簽退量
       inao023 LIKE inao_t.inao023, #已倉退/銷退量
       inao024 LIKE inao_t.inao024, #已轉QC量
       inao025 LIKE inao_t.inao025  #已退品量
END RECORD
#161109-00085#34-e

DEFINE  r_success   LIKE type_t.num5

   #先刪除實際資料
   DELETE FROM inao_t
    WHERE inaodocno = g_sfebdocno
      AND inaosite = g_site
      AND inaoseq = g_sfeb_d[l_ac].sfebseq
      AND inaoent = g_enterprise  #160902-00048#4
      AND inao000 = '2'

   #161109-00085#34-s
   #LET l_sql = "SELECT * FROM inao_t ",
   #161109-00085#63 --s mark
   #LET l_sql = "SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003, ",
   #            "       inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013, ",
   #            "       inao014,inao020,inao021,inao022,inao023,inao024,inao025  ",
   #            "  FROM inao_t ",
   #161109-00085#63 --e mark
   #161109-00085#63 --s add
   LET l_sql = " SELECT inaoent,inaosite,inaodocno,inaoseq,inaoseq1, ",
               "        inaoseq2,inao000,inao001,inao002,inao003, ",
               "        inao004,inao005,inao006,inao007,inao008, ",
               "        inao009,inao010,inao011,inao012,inao013, ",
               "        inaoud001,inaoud002,inaoud003,inaoud004,inaoud005, ",
               "        inaoud006,inaoud007,inaoud008,inaoud009,inaoud010, ",
               "        inaoud011,inaoud012,inaoud013,inaoud014,inaoud015, ",
               "        inaoud016,inaoud017,inaoud018,inaoud019,inaoud020, ",
               "        inaoud021,inaoud022,inaoud023,inaoud024,inaoud025, ",
               "        inaoud026,inaoud027,inaoud028,inaoud029,inaoud030, ",
               "        inao014,inao020,inao021,inao022,inao023, ",
               "        inao024,inao025 ",
               "   FROM inao_t ",
   #161109-00085#63 --e add
   #161109-00085#34-e
               " WHERE inaodocno = '",g_sfebdocno,"'",
               "   AND inaoseq = ",g_sfeb_d[l_ac].sfebseq,
               "   AND inaoent = ",g_enterprise,  #160902-00048#4
               "   AND inao000 = '1' "

   PREPARE asft340_inao_pre FROM l_sql
   DECLARE asft340_inao_ins CURSOR FOR asft340_inao_pre

   LET r_success = TRUE
   
   #161109-00085#34-s
   #FOREACH asft340_inao_ins INTO l_inao.*
    FOREACH asft340_inao_ins 
   #161109-00085#63 --s mark
   #   INTO l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
   #        l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
   #        l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
   #        l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
   #        l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
   #        l_inao.inao024,l_inao.inao025
   #161109-00085#63 --e mark
   #161109-00085#63 --s add
       INTO l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
            l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
            l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
            l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
            l_inao.inaoud001,l_inao.inaoud002,l_inao.inaoud003,l_inao.inaoud004,l_inao.inaoud005,
            l_inao.inaoud006,l_inao.inaoud007,l_inao.inaoud008,l_inao.inaoud009,l_inao.inaoud010,
            l_inao.inaoud011,l_inao.inaoud012,l_inao.inaoud013,l_inao.inaoud014,l_inao.inaoud015,
            l_inao.inaoud016,l_inao.inaoud017,l_inao.inaoud018,l_inao.inaoud019,l_inao.inaoud020,
            l_inao.inaoud021,l_inao.inaoud022,l_inao.inaoud023,l_inao.inaoud024,l_inao.inaoud025,
            l_inao.inaoud026,l_inao.inaoud027,l_inao.inaoud028,l_inao.inaoud029,l_inao.inaoud030,
            l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
            l_inao.inao024,l_inao.inao025
   #161109-00085#63 --e add
   #161109-00085#34-e
      LET l_inao.inao000 = '2'
      LET l_inao.inaoseq1 = 1
      #161109-00085#34-s
      #INSERT INTO inao_t (inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,
      #                    inao004,inao005,inao006,inao007,inao008,inao009,inao010,inao011,inao012,inao013,
      #                    inao014,inao020,inao021,inao022,inao023,inao024,inao025)
      #            VALUES (l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
      #                    l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
      #                    l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
      #                    l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
      #                    l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
      #                    l_inao.inao024,l_inao.inao025)
      #161109-00085#34-e
      #161109-00085#63 --s add
      INSERT INTO inao_t (inaoent,inaosite,inaodocno,inaoseq,inaoseq1,
                          inaoseq2,inao000,inao001,inao002,inao003,
                          inao004,inao005,inao006,inao007,inao008,
                          inao009,inao010,inao011,inao012,inao013,
                          inaoud001,inaoud002,inaoud003,inaoud004,inaoud005,
                          inaoud006,inaoud007,inaoud008,inaoud009,inaoud010,
                          inaoud011,inaoud012,inaoud013,inaoud014,inaoud015,
                          inaoud016,inaoud017,inaoud018,inaoud019,inaoud020,
                          inaoud021,inaoud022,inaoud023,inaoud024,inaoud025,
                          inaoud026,inaoud027,inaoud028,inaoud029,inaoud030,
                          inao014,inao020,inao021,inao022,inao023,
                          inao024,inao025)
                  VALUES (l_inao.inaoent,l_inao.inaosite,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,
                          l_inao.inaoseq2,l_inao.inao000,l_inao.inao001,l_inao.inao002,l_inao.inao003,
                          l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
                          l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,
                          l_inao.inaoud001,l_inao.inaoud002,l_inao.inaoud003,l_inao.inaoud004,l_inao.inaoud005,
                          l_inao.inaoud006,l_inao.inaoud007,l_inao.inaoud008,l_inao.inaoud009,l_inao.inaoud010,
                          l_inao.inaoud011,l_inao.inaoud012,l_inao.inaoud013,l_inao.inaoud014,l_inao.inaoud015,
                          l_inao.inaoud016,l_inao.inaoud017,l_inao.inaoud018,l_inao.inaoud019,l_inao.inaoud020,
                          l_inao.inaoud021,l_inao.inaoud022,l_inao.inaoud023,l_inao.inaoud024,l_inao.inaoud025,
                          l_inao.inaoud026,l_inao.inaoud027,l_inao.inaoud028,l_inao.inaoud029,l_inao.inaoud030,
                          l_inao.inao014,l_inao.inao020,l_inao.inao021,l_inao.inao022,l_inao.inao023,
                          l_inao.inao024,l_inao.inao025)
      #161109-00085#63 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_05_ins_sfeb()
DEFINE l_i             LIKE type_t.num5
DEFINE l_j             LIKE type_t.num5
#161109-00085#34-s
#DEFINE l_sfec          RECORD LIKE sfec_t.*
DEFINE l_sfec RECORD  #完工入庫明細檔
       sfecent LIKE sfec_t.sfecent, #企業編號
       sfecsite LIKE sfec_t.sfecsite, #營運據點
       sfecdocno LIKE sfec_t.sfecdocno, #單號
       sfecseq LIKE sfec_t.sfecseq, #項次
       sfecseq1 LIKE sfec_t.sfecseq1, #項次1
       sfec001 LIKE sfec_t.sfec001, #工單單號
       sfec002 LIKE sfec_t.sfec002, #FQC單號
       sfec003 LIKE sfec_t.sfec003, #判定項次
       sfec004 LIKE sfec_t.sfec004, #入庫類型
       sfec005 LIKE sfec_t.sfec005, #料件編號
       sfec006 LIKE sfec_t.sfec006, #特徵
       sfec007 LIKE sfec_t.sfec007, #包裝容器
       sfec008 LIKE sfec_t.sfec008, #單位
       sfec009 LIKE sfec_t.sfec009, #數量
       sfec010 LIKE sfec_t.sfec010, #參考單位
       sfec011 LIKE sfec_t.sfec011, #參考數量
       sfec012 LIKE sfec_t.sfec012, #庫位
       sfec013 LIKE sfec_t.sfec013, #儲位
       sfec014 LIKE sfec_t.sfec014, #批號
       sfec015 LIKE sfec_t.sfec015, #庫存管理特徵
       sfec016 LIKE sfec_t.sfec016, #有效日期
       sfec017 LIKE sfec_t.sfec017, #庫存備註
       sfec018 LIKE sfec_t.sfec018, #生產料號
       sfec019 LIKE sfec_t.sfec019, #生產料號BOM特性
       sfec020 LIKE sfec_t.sfec020, #生產料號產品特徵
       sfec021 LIKE sfec_t.sfec021, #RUN CARD
       #161109-00085#63 --s add
       sfecud001 LIKE sfec_t.sfecud001, #自定義欄位(文字)001
       sfecud002 LIKE sfec_t.sfecud002, #自定義欄位(文字)002
       sfecud003 LIKE sfec_t.sfecud003, #自定義欄位(文字)003
       sfecud004 LIKE sfec_t.sfecud004, #自定義欄位(文字)004
       sfecud005 LIKE sfec_t.sfecud005, #自定義欄位(文字)005
       sfecud006 LIKE sfec_t.sfecud006, #自定義欄位(文字)006
       sfecud007 LIKE sfec_t.sfecud007, #自定義欄位(文字)007
       sfecud008 LIKE sfec_t.sfecud008, #自定義欄位(文字)008
       sfecud009 LIKE sfec_t.sfecud009, #自定義欄位(文字)009
       sfecud010 LIKE sfec_t.sfecud010, #自定義欄位(文字)010
       sfecud011 LIKE sfec_t.sfecud011, #自定義欄位(數字)011
       sfecud012 LIKE sfec_t.sfecud012, #自定義欄位(數字)012
       sfecud013 LIKE sfec_t.sfecud013, #自定義欄位(數字)013
       sfecud014 LIKE sfec_t.sfecud014, #自定義欄位(數字)014
       sfecud015 LIKE sfec_t.sfecud015, #自定義欄位(數字)015
       sfecud016 LIKE sfec_t.sfecud016, #自定義欄位(數字)016
       sfecud017 LIKE sfec_t.sfecud017, #自定義欄位(數字)017
       sfecud018 LIKE sfec_t.sfecud018, #自定義欄位(數字)018
       sfecud019 LIKE sfec_t.sfecud019, #自定義欄位(數字)019
       sfecud020 LIKE sfec_t.sfecud020, #自定義欄位(數字)020
       sfecud021 LIKE sfec_t.sfecud021, #自定義欄位(日期時間)021
       sfecud022 LIKE sfec_t.sfecud022, #自定義欄位(日期時間)022
       sfecud023 LIKE sfec_t.sfecud023, #自定義欄位(日期時間)023
       sfecud024 LIKE sfec_t.sfecud024, #自定義欄位(日期時間)024
       sfecud025 LIKE sfec_t.sfecud025, #自定義欄位(日期時間)025
       sfecud026 LIKE sfec_t.sfecud026, #自定義欄位(日期時間)026
       sfecud027 LIKE sfec_t.sfecud027, #自定義欄位(日期時間)027
       sfecud028 LIKE sfec_t.sfecud028, #自定義欄位(日期時間)028
       sfecud029 LIKE sfec_t.sfecud029, #自定義欄位(日期時間)029
       sfecud030 LIKE sfec_t.sfecud030, #自定義欄位(日期時間)030
       #161109-00085#63 --e add
       sfec022 LIKE sfec_t.sfec022, #專案編號
       sfec023 LIKE sfec_t.sfec023, #WBS
       sfec024 LIKE sfec_t.sfec024, #活動編號
       sfec028 LIKE sfec_t.sfec028  #製造日期
END RECORD
#161109-00085#34-e
 
   LET g_sub_success = FALSE
   LET l_j = g_sfeb_d.getLength()
   IF l_j = 0 THEN      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "agl-00066"
      LET g_errparam.extend = "inao_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN g_sub_success
   END IF
   
   IF s_transaction_chk("N",0) THEN
      CALL s_transaction_begin()
   END IF   
   
   FOR l_i = 1 TO l_j
      IF g_sfeb_d[l_i].sel = 'Y' AND g_sfeb_d[l_i].sfeb008 > 0 THEN
         SELECT MAX(sfebseq) + 1 INTO g_sfeb_d[l_i].sfebseq 
           FROM sfeb_t
          WHERE sfebent = g_enterprise
            AND sfebdocno = g_sfebdocno
         IF cl_null(g_sfeb_d[l_i].sfebseq) THEN
            LET g_sfeb_d[l_i].sfebseq = 1
         END IF
         INSERT INTO sfeb_t
               (sfebent,sfebsite,sfebdocno,sfebseq,
                sfeb001,sfeb002,sfeb003,sfeb004,sfeb005,
                sfeb006,sfeb007,sfeb008,sfeb009,sfeb010,
                sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,
                sfeb016,sfeb017,sfeb018,sfeb019,sfeb020,
                sfeb021,sfeb022,sfeb026,sfeb027,sfeb028) 
         VALUES(g_enterprise,g_sfeb_d[l_i].sfebsite,g_sfebdocno,g_sfeb_d[l_i].sfebseq,
                g_sfeb_d[l_i].sfeb001,g_sfeb_d[l_i].sfeb002,g_sfeb_d[l_i].sfeb003,g_sfeb_d[l_i].sfeb004,g_sfeb_d[l_i].sfeb005, 
                g_sfeb_d[l_i].sfeb006,g_sfeb_d[l_i].sfeb007,g_sfeb_d[l_i].sfeb008,g_sfeb_d[l_i].sfeb009,g_sfeb_d[l_i].sfeb010, 
                g_sfeb_d[l_i].sfeb011,g_sfeb_d[l_i].sfeb012,g_sfeb_d[l_i].sfeb013,g_sfeb_d[l_i].sfeb014,g_sfeb_d[l_i].sfeb015,
                g_sfeb_d[l_i].sfeb016,g_sfeb_d[l_i].sfeb017,g_sfeb_d[l_i].sfeb018,g_sfeb_d[l_i].sfeb019,g_sfeb_d[l_i].sfeb020,
                g_sfeb_d[l_i].sfeb021,g_sfeb_d[l_i].sfeb022,g_sfeb_d[l_i].sfeb026,g_sfeb_d[l_i].sfeb027,g_sfeb_d[l_i].sfeb028)
         IF SQLCA.sqlcode THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert sfeb'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN FALSE
         END IF
         LET l_sfec.sfecent   = g_enterprise                     #企業代碼
         LET l_sfec.sfecsite  = g_site                    #營運據點
         LET l_sfec.sfecdocno = g_sfebdocno               #單號
         LET l_sfec.sfecseq   = g_sfeb_d[l_i].sfebseq           #項次
         LET l_sfec.sfecseq1  = 1                                #項次1
         LET l_sfec.sfec001   = g_sfeb_d[l_i].sfeb001           #工單單號
         LET l_sfec.sfec002   = ''                               #FQC單號
         LET l_sfec.sfec003   = ''                               #判定項次
         LET l_sfec.sfec004   = g_sfeb_d[l_i].sfeb003           #入庫類型
         LET l_sfec.sfec005   = g_sfeb_d[l_i].sfeb004           #料件編號
         LET l_sfec.sfec006   = g_sfeb_d[l_i].sfeb005           #特徵
         LET l_sfec.sfec007   = g_sfeb_d[l_i].sfeb006           #包裝容器
         LET l_sfec.sfec008   = g_sfeb_d[l_i].sfeb007           #單位
         LET l_sfec.sfec009   = g_sfeb_d[l_i].sfeb008           #數量
         LET l_sfec.sfec010   = g_sfeb_d[l_i].sfeb010           #參考單位
         LET l_sfec.sfec011   = g_sfeb_d[l_i].sfeb011           #參考數量
         LET l_sfec.sfec012   = g_sfeb_d[l_i].sfeb013           #庫位
         LET l_sfec.sfec013   = g_sfeb_d[l_i].sfeb014           #儲位
         LET l_sfec.sfec014   = g_sfeb_d[l_i].sfeb015           #批號
         LET l_sfec.sfec015   = g_sfeb_d[l_i].sfeb016           #庫存管理特徵
         LET l_sfec.sfec028   = g_sfeb_d[l_i].sfeb028           #製造日期  #160512-00004#2-add
         LET l_sfec.sfec016   = g_sfeb_d[l_i].sfeb021           #有效日期
         LET l_sfec.sfec017   = g_sfeb_d[l_i].sfeb022           #庫存備註
         LET l_sfec.sfec021   = g_sfeb_d[l_i].sfeb026           #RUN CARD         
         LET l_sfec.sfec022   = g_sfeb_d[l_i].sfeb017           #專案編號
         LET l_sfec.sfec023   = g_sfeb_d[l_i].sfeb018           #WBS
         LET l_sfec.sfec024   = g_sfeb_d[l_i].sfeb019           #活動編號
         
         #161109-00085#34-s
         #INSERT INTO sfec_t VALUES l_sfec.*
         #161109-00085#63 --s mark
         #INSERT INTO sfec_t (sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,sfec001,sfec002,sfec003,sfec004,sfec005,
         #                    sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,
         #                    sfec016,sfec017,sfec018,sfec019,sfec020,sfec021,sfec022,sfec023,sfec024,sfec028)
         #VALUES (l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,
         #        l_sfec.sfec001,l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,
         #        l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,l_sfec.sfec009,l_sfec.sfec010,
         #        l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
         #        l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,
         #        l_sfec.sfec021,l_sfec.sfec022,l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
         #161109-00085#63 --e mark
         #161109-00085#34-e
         #161109-00085#63 --s add
         INSERT INTO sfec_t(sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,
                            sfec001,sfec002,sfec003,sfec004,sfec005,
                            sfec006,sfec007,sfec008,sfec009,sfec010,
                            sfec011,sfec012,sfec013,sfec014,sfec015,
                            sfec016,sfec017,sfec018,sfec019,sfec020,
                            sfec021,sfecud001,sfecud002,sfecud003,sfecud004,
                            sfecud005,sfecud006,sfecud007,sfecud008,sfecud009,
                            sfecud010,sfecud011,sfecud012,sfecud013,sfecud014,
                            sfecud015,sfecud016,sfecud017,sfecud018,sfecud019,
                            sfecud020,sfecud021,sfecud022,sfecud023,sfecud024,
                            sfecud025,sfecud026,sfecud027,sfecud028,sfecud029,
                            sfecud030,sfec022,sfec023,sfec024,sfec028)
         VALUES (l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,
                 l_sfec.sfec001,l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,
                 l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,l_sfec.sfec009,l_sfec.sfec010,
                 l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
                 l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,
                 l_sfec.sfec021,l_sfec.sfecud001,l_sfec.sfecud002,l_sfec.sfecud003,l_sfec.sfecud004,
                 l_sfec.sfecud005,l_sfec.sfecud006,l_sfec.sfecud007,l_sfec.sfecud008,l_sfec.sfecud009,
                 l_sfec.sfecud010,l_sfec.sfecud011,l_sfec.sfecud012,l_sfec.sfecud013,l_sfec.sfecud014,
                 l_sfec.sfecud015,l_sfec.sfecud016,l_sfec.sfecud017,l_sfec.sfecud018,l_sfec.sfecud019,
                 l_sfec.sfecud020,l_sfec.sfecud021,l_sfec.sfecud022,l_sfec.sfecud023,l_sfec.sfecud024,
                 l_sfec.sfecud025,l_sfec.sfecud026,l_sfec.sfecud027,l_sfec.sfecud028,l_sfec.sfecud029,
                 l_sfec.sfecud030,l_sfec.sfec022,l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
         #161109-00085#63 --e add
         IF SQLCA.sqlcode THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert sfec'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN FALSE
         END IF
      END IF
   END FOR
   CALL s_transaction_end('Y','0')
   LET g_sub_success = TRUE
   RETURN g_sub_success
   
END FUNCTION

 
{</section>}
 
