#該程式未解開Section, 採用最新樣板產出!
{<section id="azzq670.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-29 17:22:40), PR版次:0001(2016-12-30 15:26:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: azzq670
#+ Description: 異常管理查詢作業
#+ Creator....: 05423(2016-12-29 16:05:41)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="azzq670.global" >}
#應用 i05 樣板自動產生(Version:37)
#add-point:填寫註解說明
#160622-00009#2   2016/06/28  By zhujing   添加azzi310_01_get_record_number("aapr001",g_json)，获取总笔数
#150624-00008#53  2016/07/29  By zhujing   异常数、警告数都放入左边单身，左边单身上层目录编号、说明、目录编号这几个栏位拿掉
#160802-00026#1   2016/08/03  By zhujing   树状单身要改成跟aooi920一样的结构，另外括号里改成节点名称，oobk002_desc一栏改成节点说明
#150624-00008#102 2016/08/30  By zhujing   根据异常数、警告数显示颜色：异常数、警告数都是0显示黑色，异常数、警告数都<=10显示黄色，异常数或警告数任一个>10,显示红色
#161216-00018#1   2016/12/16  By zhujing   根据aooi922设定的权限显示对应资料，不是根节点的也需显示出来。
#end add-point
#add-point:填寫註解說明(客製用)

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
IMPORT FGL azz_azzi310        #160622-00009#2 add
IMPORT FGL azz_azzi310_01     #160622-00009#2 add
#end add-point
  
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_gzas_m RECORD
   gzas001 LIKE gzas_t.gzas001, 
   gzas002 LIKE gzas_t.gzas002
                                  END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#單身 type 宣告
PRIVATE TYPE type_g_gzas_d        RECORD
       l_exc_qty LIKE type_t.num20_6,
   l_war_qty LIKE type_t.num20_6
       END RECORD
       
   DEFINE l_id        LIKE type_t.num5
   DEFINE l_status    LIKE type_t.num5
   DEFINE l_value     STRING
   DEFINE arr_left    DYNAMIC ARRAY OF STRING
   DEFINE arr_right   DYNAMIC ARRAY OF STRING
   DEFINE l_dnd       ui.DragDrop
   DEFINE l_source    STRING
   DEFINE l_target    STRING
   DEFINE g_rec_b2    LIKE type_t.num10
   DEFINE g_gzas_d    DYNAMIC ARRAY OF type_g_gzas_d
#   DEFINE g_gzas_d    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
#            exc_qty   LIKE type_t.num20_6,
#            war_qty   LIKE type_t.num20_6            
#   END RECORD 
   DEFINE g_gzas2_d    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  #160622-00009#3 ADD
            exc_qty   LIKE type_t.num20_6,
            war_qty   LIKE type_t.num20_6,
            l_gzar003 LIKE gzar_t.gzar003,            
            l_gzar004 LIKE gzar_t.gzar004,            
            l_gzar005 LIKE gzar_t.gzar005            
   END RECORD 
   DEFINE  g_wc2      STRING 
   DEFINE g_tree_cnt  LIKE type_t.num5   
   DEFINE g_exc_sum       LIKE type_t.num10      #160622-00009#2  记录总异常数
   DEFINE g_war_sum       LIKE type_t.num10      #160622-00009#2  记录总警告数
   DEFINE g_field         STRING
   DEFINE ls_js      STRING
   DEFINE g_root_exc_sum   LIKE type_t.num10    #160802-00026#1 add 记录根节点异常数
   DEFINE g_root_war_sum   LIKE type_t.num10    #160802-00026#1 add 记录根节点警告数
#150624-00008#102 add-S
DEFINE g_browser_color DYNAMIC ARRAY OF RECORD
   b_show          STRING,   #外顯欄位
   b_pid           STRING,   #父節點id
   b_id            STRING,   #本身節點id
   b_exp           STRING,   #是否展開
   b_hasC          STRING,   #是否有子節點
   b_isExp         STRING,   #是否已展開
   b_expcode       STRING,   #展開值
   #tree自定義欄位  
   b_gzas001       STRING,
   b_gzas001_desc  STRING,
   b_gzas002       STRING,
   b_gzas002_desc  STRING,
   b_exc_qty_1     STRING,
   b_war_qty_1     STRING
END RECORD
#150624-00008#102 add-E
#end add-point
                                  
#模組變數(Module Variables)
DEFINE g_gzas_m          type_g_gzas_m
DEFINE g_gzas_m_t        type_g_gzas_m
DEFINE g_gzas_m_o        type_g_gzas_m
 
   DEFINE g_gzas001_t LIKE gzas_t.gzas001
DEFINE g_gzas002_t LIKE gzas_t.gzas002
 
 
#DEFINE g_gzas002_t        LIKE gzas_t.gzas002
#DEFINE g_gzas001_t        LIKE gzas_t.gzas001
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
          b_gzas001 LIKE gzas_t.gzas001,
   b_gzas001_desc LIKE type_t.chr80,
      b_gzas002 LIKE gzas_t.gzas002,
   b_gzas002_desc LIKE type_t.chr80,
   b_exc_qty_1 LIKE type_t.chr80,
   b_war_qty_1 LIKE type_t.chr80
                   END RECORD
 
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
       
#多table用變數
 
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_curr_diag           ui.Dialog                #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10         
DEFINE gwin_curr             ui.Window                #Current Window
DEFINE gfrm_curr             ui.Form                  #Current Form
DEFINE g_page_action         STRING                   #page action
DEFINE g_header_hidden       LIKE type_t.num5         #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5         #隱藏工作Panel
DEFINE g_browser_cnt         LIKE type_t.num10        #total count
DEFINE g_page                STRING                   #第幾頁
DEFINE g_current_row         LIKE type_t.num10        #Browser所在筆數
DEFINE g_current_sw          LIKE type_t.num10        #Browser所在筆數用開關
 
DEFINE g_searchcol           LIKE type_t.chr200
DEFINE g_searchstr           LIKE type_t.chr200
DEFINE g_searchtype          LIKE type_t.chr200
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_root_search         BOOLEAN
DEFINE g_first               LIKE type_t.num5  #標示是否要啟動s_browse重查
DEFINE g_aw                  STRING            #確定當下點擊的單身
DEFINE g_log1                STRING            #log用
DEFINE g_log2                STRING            #log用
DEFINE g_add_browse          STRING            #新增填充用WC
DEFINE g_add_idx             LIKE type_t.num5  #新增資料指標
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzq670.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gzas001,gzas002", 
                      " FROM gzas_t",
                      " WHERE gzasent= ? AND gzas001=? AND gzas002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq670_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzas001,t0.gzas002",
               " FROM gzas_t t0",
               
               " WHERE t0.gzasent = " ||g_enterprise|| " AND t0.gzas001 = ? AND t0.gzas002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzq670_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq670 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzq670_init()   
 
      #進入選單 Menu (="N")
      CALL azzq670_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE azzq670_tmp
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzq670
      
   END IF 
   
   CLOSE azzq670_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
    
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzq670.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzq670_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_add_idx = 1
   LET g_current_idx = 1
    
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('gzas004','222')  
   #end add-point
   
   CALL azzq670_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzq670.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzq670_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_time                DATETIME YEAR TO SECOND
   DEFINE l_ac1                 LIKE type_t.num10
   DEFINE l_i                   LIKE type_t.num10
   DEFINE l_ac2                 LIKE type_t.num10
   DEFINE l_n2                  LIKE type_t.num10
   DEFINE l_gzas001_t           LIKE gzas_t.gzas001
   DEFINE l_gzas002_t           LIKE gzas_t.gzas002
   DEFINE l_gzas002             LIKE gzas_t.gzas002
   DEFINE l_gzas002_2           LIKE gzas_t.gzas002
   DEFINE l_gzar001_t           LIKE gzar_t.gzar001
   DEFINE li_idx                LIKE type_t.num10
   DEFINE l_gzas003             LIKE gzas_t.gzas003
   DEFINE l_n                   LIKE type_t.num10
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL azzq670_tree_fill()
   #end add-point
   
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzas_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         LET g_first = 1
         CALL azzq670_init()
      END IF
 
      #當瀏覽頁簽被設定關閉時,使用MENU (開啟時使用DIALOG)
      IF g_worksheet_hidden = 1 THEN
 
         LET g_current_sw = FALSE
 
         #回歸舊筆數位置 (回到當時異動的筆數)
         LET g_current_idx = g_current_row
         LET g_current_sw = TRUE
         CALL cl_show_fld_cont() 
         CALL azzq670_fetch("")    #當每次點任一筆資料都會需要用到
 
         MENU
            #add-point:ui_dialog段其他頁簽的 display array(in menu) name="ui_dialog.more_displayarray_in_menu"
 
            #end add-point
            
            
            #ACTION表單列
            ON ACTION first
               LET g_current_idx = 1
               CALL azzq670_fetch("")
               LET g_current_row = g_current_idx
            
            ON ACTION next
               LET g_current_idx = g_current_idx + 1
               CALL azzq670_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION jump
               CALL azzq670_fetch("/")
               LET g_current_row = g_current_idx
 
            ON ACTION previous
               LET g_current_idx = g_current_idx - 1
               CALL azzq670_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION last 
               LET g_current_idx = g_browser_cnt
               CALL azzq670_fetch("") 
               LET g_current_row = g_current_idx
 
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
 
            ON ACTION close
               LET li_exit = TRUE
               EXIT MENU
 
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
         
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 1
               END IF
               EXIT MENU
         
            ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden
               END IF
 
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               
               #add-point:ON ACTION exporttoexcel name="menu2.exporttoexcel"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzq670_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzq670_delete(DIALOG)
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzq670_reproduce(DIALOG)
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION war_detail
            LET g_action_choice="war_detail"
            IF cl_auth_chk_act("war_detail") THEN
               
               #add-point:ON ACTION war_detail name="menu2.war_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exc_detail
            LET g_action_choice="exc_detail"
            IF cl_auth_chk_act("exc_detail") THEN
               
               #add-point:ON ACTION exc_detail name="menu2.exc_detail"
               
               #END add-point
               
            END IF
 
 
 
 
 
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzq670_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzq670_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzq670_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
 
         END MENU
 
      ELSE
         #第一次進入程式, 或啟動重新查詢
         IF g_first = 0 THEN 
            CALL azzq670_browser_fill(g_wc,g_searchtype)
            LET g_first = 1
         END IF
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
            INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol, 
                formonly.rdo_searchtype
               BEFORE INPUT
            END INPUT
            
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
 
               BEFORE DISPLAY
                  CALL DIALOG.setSelectionMode("s_browse",1) #設定為單選
 
               BEFORE ROW
                  #add-point:ui_dialog段before row1 name="ui_dialog.before_row1"
                  CALL DIALOG.setCellAttributes(g_browser_color)    #150624-00008#102 add
                  #end add-point
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_row > 1 AND g_current_sw = FALSE THEN
                     CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                     LET g_current_idx = g_current_row
                  END IF
                  #add-point:ui_dialog段before row2 name="ui_dialog.before_row2"
                  DISPLAY g_current_idx TO FORMONLY.idx
                  #end add-point
                  LET g_current_row = g_current_idx #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont() 
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
 
                  CALL azzq670_fetch("")  #當每次點任一筆資料都會需要用到
 
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL azzq670_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
 
               ON COLLAPSE (g_row_index)
                  #樹關閉
                  
               #add-point:ui_dialog段action name="ui_dialog.tree_action"
              
               #end add-point
 
            END DISPLAY
 
            #add-point:ui_dialog段其他頁簽的 display array name="ui_dialog.more_displayarray"
#            DISPLAY ARRAY g_gzas_d TO s_detail1.* ATTRIBUTE(COUNT=g_rec_b2)
#               BEFORE DISPLAY
#                  CALL DIALOG.setSelectionMode("s_detail1",1) #設定為單選
# 
#               BEFORE ROW
#                  #add-point:ui_dialog段before row1 name="ui_dialog.before_row1"
#
#                  #end add-point
#                  #回歸舊筆數位置 (回到當時異動的筆數)
#                  LET g_current_idx = DIALOG.getCurrentRow("s_detail1")
#                  IF g_current_row > 1 AND g_current_sw = FALSE THEN
#                     CALL DIALOG.setCurrentRow("s_detail1",g_current_row)
#                     LET g_current_idx = g_current_row
#                  END IF
#                  
#                  LET g_current_row = g_current_idx #目前指標
#                  LET g_current_sw = TRUE
#                  CALL cl_show_fld_cont() 
#                  CALL DIALOG.setCurrentRow("s_detail1",g_current_row)
##                  NEXT FIELD exc_qty
#                  
##               BEFORE FIELD exc_qty
#                  #执行报表
##                  LET g_field = DIALOG.getCurrentItem()     
##                  IF g_gzas_d[g_current_row].exc_qty>0 THEN
##                     IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar004) THEN
##                        INITIALIZE la_param.* TO NULL
##                        LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
##                        LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar004
##                       
##                        LET ls_js = util.JSON.stringify(la_param)
##                        CALL cl_cmdrun(ls_js)
##                     END IF
##                  END IF
###               BEFORE FIELD war_qty
##                  IF g_gzas_d[g_current_row].war_qty>0 THEN
##                     IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar005) THEN
##                        INITIALIZE la_param.* TO NULL
##                        LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
##                        LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar005
##                       
##                        LET ls_js = util.JSON.stringify(la_param)
##                        CALL cl_cmdrun(ls_js)
##                     END IF
##                  END IF
#               
#            END DISPLAY

            #点击画面上的按钮，来调用报表
            INPUT ARRAY g_gzas_d FROM s_detail1.*
               ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE,
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
               BEFORE INPUT
                  
               BEFORE ROW
                  LET l_ac = ARR_CURR()
                  LET g_current_row = l_ac
                  
               ON ACTION controlp INFIELD l_exc_qty
                  IF g_gzas_d[g_current_row].l_exc_qty>0 THEN
                     IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar004) THEN
                        INITIALIZE la_param.* TO NULL
                        LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
                        LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar004
                       
                        LET ls_js = util.JSON.stringify(la_param)
                        CALL cl_cmdrun(ls_js)
                     END IF
                  END IF
#                  DISPLAY table1[arr_curr()].edit1
               ON ACTION controlp INFIELD l_war_qty
                  IF g_gzas_d[g_current_row].l_war_qty>0 THEN
                     IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar005) THEN
                        INITIALIZE la_param.* TO NULL
                        LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
                        LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar005
                       
                        LET ls_js = util.JSON.stringify(la_param)
                        CALL cl_cmdrun(ls_js)
                     END IF
                  END IF
#                  DISPLAY table1[arr_curr()].edit2
            END INPUT
            #end add-point
 
            BEFORE DIALOG
               #action default動作(判定是否要先執行特定動作)
               
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_current_sw = FALSE
 
               #add-point:ui_dialog,before dialog1 name="ui_dialog.b_dialog1"
               
               #end add-point
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               #add-point:ui_dialog,before dialog2 name="ui_dialog.b_dialog2"
              
               #end add-point
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont() 
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               CALL azzq670_fetch("")            #當每次點任一筆資料都會需要用到
               #add-point:ui_dialog,before dialog name="ui_dialog.b_dialog"
               CALL azzq670_tree_fill()
               #end add-point
 
            AFTER DIALOG 
               #add-point:ui_dialog,after dialog name="ui_dialog.a_dialog"
               
               #end add-point
 
 
            #一般搜尋
            ON ACTION searchdata
               LET g_searchstr = GET_FLDBUF(searchstr)
               LET g_searchcol = GET_FLDBUF(cbo_searchcol)
               #若無輸入關鍵字則查找出所有資料
               IF g_searchcol="0" AND NOT cl_null(g_searchstr) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "searchcol:" 
                  LET g_errparam.code = "std-00001" 
                  LET g_errparam.popup = FALSE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF 
               IF NOT cl_null(g_searchstr) THEN
                  LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
                  LET g_wc = g_wc.toLowerCase()
               ELSE
                  LET g_wc = " 1=1 "
               END IF
               LET g_first = 0 #啟動重查
               EXIT DIALOG
 
            #進階搜尋
            #ON ACTION advancesearch
 
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
            
            ON ACTION close
               LET li_exit = TRUE
               EXIT DIALOG
            
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/mainhidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT DIALOG
 
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 1
               END IF
               EXIT DIALOG
 
            ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden
               END IF
 
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzq670_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzq670_delete(DIALOG)
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzq670_reproduce(DIALOG)
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION war_detail
            LET g_action_choice="war_detail"
            IF cl_auth_chk_act("war_detail") THEN
               
               #add-point:ON ACTION war_detail name="menu.war_detail"
               #150624-00008#53 add-S
               LET l_ac = ARR_CURR()
               IF l_ac = 0 THEN
                  CONTINUE DIALOG
               END IF
               LET g_current_row = l_ac
               IF g_gzas_d[g_current_row].l_war_qty>0 THEN
                  IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar005) THEN
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
                     LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar005
                    
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exc_detail
            LET g_action_choice="exc_detail"
            IF cl_auth_chk_act("exc_detail") THEN
               
               #add-point:ON ACTION exc_detail name="menu.exc_detail"
               LET l_ac = ARR_CURR()
               IF l_ac = 0 THEN
                  CONTINUE DIALOG
               END IF
               LET g_current_row = l_ac
               IF g_gzas_d[g_current_row].l_exc_qty>0 THEN
                  IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar004) THEN
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
                     LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar004
                    
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  END IF
               END IF
               #150624-00008#53 add-E
               
               #END add-point
               
            END IF
 
 
 
 
 
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzq670_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzq670_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzq670_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            &include "main_menu_exit_dialog.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
   END WHILE
 
END FUNCTION 
 
{</section>}
 
{<section id="azzq670.browser_fill" >}
#+ 瀏覽頁簽where條件組成
PRIVATE FUNCTION azzq670_browser_fill(p_wc,p_type)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc       STRING 
   DEFINE p_type     LIKE type_t.chr10
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_cnt2     LIKE type_t.num10   
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_fill"
   CALL azzq670_tree_fill()
   RETURN
   #end add-point
 
   CALL g_browser.clear()
   CLEAR FORM
   LET l_cnt = 0
   LET l_cnt2 = 0
   
   DROP TABLE azzq670_tmp
   
   #Create temp table
   CREATE TEMP TABLE azzq670_tmp
   (
         gzas001 VARCHAR(500),
   gzas001_desc VARCHAR(500),
   gzas002 VARCHAR(500),
   gzas002_desc VARCHAR(500),
   exc_qty_1 VARCHAR(500),
   war_qty_1 VARCHAR(500),
      #僅含browser的欄位
      exp_code  VARCHAR(5)
   );
 
   #先確定搜尋範圍(若無條件搜尋則只找root出來)
   SELECT COUNT(1) INTO l_cnt FROM gzas_t WHERE gzasent = g_enterprise AND 1=1
   
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT COUNT(1)",
               " FROM gzas_t ",
               "  ",
               " WHERE gzasent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("gzas_t")
   #add-point:browser_fill段cnt wc name="browser_fill.cnt_wc"
   
   #end add-point
              
   PREPARE master_cnt FROM g_sql
   DECLARE master_cntcur CURSOR FOR master_cnt
   OPEN master_cntcur
   IF SQLCA.SQLCODE THEN   #(ver:36)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN master_cntcur:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   FETCH master_cntcur INTO l_cnt2
   LET g_root_search = FALSE
   
   IF l_cnt2 = 0 THEN
      #INITIALIZE g_errparam TO NULL 
      #LET g_errparam.extend = "" 
      #LET g_errparam.code = "-100" 
      #LET g_errparam.popup = TRUE 
      #CALL cl_err()
      RETURN
   END IF
   
   IF l_cnt = l_cnt2 THEN
      #未輸入條件時則只查找root節點
      LET p_wc = " gzas002 = gzas001 "
      LET g_root_search = TRUE
   END IF
 
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT gzas001,'',gzas002,'','','' ",
               " FROM gzas_t",
               "  ",
               " WHERE gzasent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("gzas_t")
   #add-point:browser_fill段sql wc name="browser_fill.sql_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzas_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_ext FROM g_sql
   DECLARE master_extcur CURSOR FOR master_ext
   
   #單筆update
   #LET g_sql = "SELECT '','','','','','','',gzas001,'',gzas002,'','','' ",
   #            " FROM gzas_t",
   #            "  ",
   #            " WHERE gzasent = " ||g_enterprise|| " AND ",
   #            " gzas001 = ?"
   #            ," gzas002 = ?"
 
                
   LET g_sql = " SELECT t0.gzas001,t0.gzas002,t1.gzasl004 ,t2.gzarl004 ",
               " FROM gzas_t t0",
               "  ",
                              " LEFT JOIN gzasl_t t1 ON t1.gzaslent="||g_enterprise||" AND t1.gzasl002=gzas001 AND t1.gzasl003='"||g_lang||"' ",
               " LEFT JOIN gzarl_t t2 ON t2.gzarlent="||g_enterprise||" AND t2.gzarl001=gzas002 AND t2.gzarl002='"||g_lang||"' ",
 
               " WHERE gzasent = " ||g_enterprise|| " AND ",
               " gzas001 = ?"
               ," AND gzas002 = ?"
 
 
               
   #add-point:browser_fill段sql wc name="browser_fill.refresh"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_refresh FROM g_sql
   DECLARE master_refreshcur CURSOR FOR master_refresh
 
   #搜尋建構樹所需的節點
   CASE p_type
      WHEN "1" #上推
         CALL azzq670_match_node(p_wc,p_type) 
      WHEN "2" #下展
         #CALL azzq670_find_speed_tbl(p_wc,p_type) 
         CALL azzq670_match_node(p_wc,p_type) 
      WHEN "3" #全部
         CALL azzq670_match_node(p_wc,p_type) 
   END CASE
 
   CALL azzq670_browser_create(p_type)
     
END FUNCTION
 
{</section>}
 
{<section id="azzq670.match_node" >}
PRIVATE FUNCTION azzq670_match_node(p_wc,p_type)
   #add-point:match_node段define name="match_node.define_customerization"
   
   #end add-point
   DEFINE p_wc         LIKE type_t.chr200
   DEFINE p_type       LIKE type_t.chr10
   DEFINE ls_code      LIKE type_t.chr50
   DEFINE ls_code2     LIKE type_t.chr50
   DEFINE l_bstmp      RECORD    #body欄位
             gzas001 VARCHAR(500),
   gzas001_desc VARCHAR(500),
   gzas002 VARCHAR(500),
   gzas002_desc VARCHAR(500),
   exc_qty_1 VARCHAR(500),
   war_qty_1 VARCHAR(500)
          #僅含單身table的欄位
   END RECORD 
   DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位
             gzas001 VARCHAR(500),
   gzas001_desc VARCHAR(500),
   gzas002 VARCHAR(500),
   gzas002_desc VARCHAR(500),
   exc_qty_1 VARCHAR(500),
   war_qty_1 VARCHAR(500)
          #僅含單身table的欄位
   END RECORD
   DEFINE li_cnt       LIKE type_t.num10   #(ver:35) add
   #add-point:match_node段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="match_node.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="match_node.pre_function"
   
   #end add-point
   
   #先找出符合條件的節點並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code = "0" #展開值0則無法展開
      WHEN 2
         LET ls_code = "2"
      WHEN 3
         LET ls_code = "2"
   END CASE
   
   IF cl_null("gzas001") THEN
      LET ls_code = "0"
   END IF 
   
   CALL s_transaction_begin()
 
   LET g_sql = " INSERT INTO azzq670_tmp (gzas001,gzas001_desc,gzas002,gzas002_desc,exc_qty_1,war_qty_1, 
       exp_code) VALUES (?,?,?,?,?,?,?)"
   PREPARE master_tmp FROM g_sql
   
   IF g_root_search THEN
      #DECLARE master_tmp_cur CURSOR FOR master_tmp
      #OPEN master_tmp_cur
      FOREACH master_extcur INTO l_bstmp.*
         EXECUTE master_tmp USING l_bstmp.*,ls_code
         #PUT master_tmp_cur FROM l_bstmp.*,ls_code
      END FOREACH
      #FLUSH master_tmp_cur
      CALL s_transaction_end("Y","0")
      RETURN
   END IF
 
   #(ver:35) ---modify start---
   FOREACH master_extcur INTO l_bstmp.*
      #(ver:35) add gzas001
      IF azzq670_tmp_tbl_chk(l_bstmp.gzas002,l_bstmp.gzas001,ls_code   #(ver:35) add gzas001
                  ) THEN
         EXECUTE master_tmp USING l_bstmp.*,ls_code
      END IF
 
      LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
   END FOREACH
 
   #找出符合條件的節點的所有祖先並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code2 = "1"
      WHEN 2
         LET ls_code2 = "-1"
      WHEN 3
         LET ls_code2 = "1"
   END CASE
 
   WHILE TRUE
      IF l_child_list.getLength() <= 0 THEN
         EXIT WHILE
      END IF
 
      #若pid欄位存在才進行後續處理
      #擷取該節點的所有父節點
      IF cl_null(l_child_list[1].gzas002) THEN
         IF l_child_list.getLength() = 1 THEN
            EXIT WHILE
         ELSE
            CALL l_child_list.deleteElement(1)
            CONTINUE WHILE
         END IF
      END IF
 
      #確認是否有父節點
      LET g_sql = " SELECT COUNT(1) ",
                  " FROM gzas_t t0",
                  " WHERE gzasent = " ||g_enterprise|| " AND gzas002 = ? ",
                  cl_sql_add_filter("gzwe_t")
      PREPARE master_getparent_cnt FROM g_sql
      EXECUTE master_getparent_cnt USING l_child_list[1].gzas001 INTO li_cnt
      IF li_cnt <= 0 THEN
         CALL l_child_list.deleteElement(1)
         CONTINUE WHILE
      END IF
 
      #擷取該節點的父節點到temp table中
      LET g_sql = " SELECT gzas001,'',gzas002,'','','' ",
                  " FROM gzas_t t0",
                  " WHERE gzasent = " ||g_enterprise|| " AND gzas002 = ? ",
                  cl_sql_add_filter("gzas_t")
      PREPARE master_getparent_up FROM g_sql
      DECLARE master_getparent_up_cur CURSOR FOR master_getparent_up
      
   #  EXECUTE master_getparent_up USING l_child_list[1].gzas001
   #                                    INTO l_bstmp.*
      FOREACH master_getparent_up_cur USING l_child_list[1].gzas001
                                        INTO l_bstmp.*
 
         IF SQLCA.SQLCODE THEN
            FREE master_getparent_up
            EXIT WHILE
         END IF
         #FREE master_getparent_up
      
         #確定該節點是否存在於temp table中
         IF STATUS = 0 AND azzq670_tmp_tbl_chk(l_bstmp.gzas002,l_bstmp.gzas001,ls_code2
                     ) THEN
            EXECUTE master_tmp USING l_bstmp.*,ls_code2
 
            #若已找到root，表示已到根結點
            IF l_bstmp.gzas002 = l_bstmp.gzas001 THEN
               CALL l_child_list.deleteElement(1)
               CONTINUE WHILE
            END IF
 
            LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
         END IF
      END FOREACH
      CALL l_child_list.deleteElement(1)
   END WHILE
   #(ver:35) --- modify end ---
 
   CLOSE master_tmp
   
   CALL s_transaction_end("Y","0")
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.tmp_tbl_chk" >}
#+ TEMP TABLE CHK
#PRIVATE FUNCTION azzq670_tmp_tbl_chk(ps_id,pi_code)
PRIVATE FUNCTION azzq670_tmp_tbl_chk(ps_id,ps_pid,pi_code)   #(ver:35) modify
   #add-point:tmp_tbl_chk段define name="tmp_tbl_chk.define_customerization"
   
   #end add-point
   DEFINE ps_id       STRING
   DEFINE ps_pid      STRING   #(ver:35) add
   DEFINE pi_code     LIKE type_t.num10
   DEFINE ps_type     STRING
   DEFINE ls_id       LIKE type_t.chr500
   DEFINE ls_pid      LIKE type_t.chr500   #(ver:35) add
   DEFINE ls_search   LIKE type_t.chr500
   DEFINE ls_type     LIKE type_t.chr500
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_code     LIKE type_t.num10   
   #add-point:tmp_tbl_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="tmp_tbl_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="tmp_tbl_chk.pre_function"
   
   #end add-point
   
   LET ls_id = ps_id
   LET ls_pid = ps_pid   #(ver:35) add
  
   IF cl_null(ls_id) THEN
      RETURN TRUE
   END IF
   
   LET g_sql = " SELECT COUNT(1) FROM azzq670_tmp ", 
               " WHERE gzas002 = ? ",
                 " AND gzas001 = ? "   #(ver:35) add
 
   PREPARE azzq670_get_cnt FROM g_sql
   EXECUTE azzq670_get_cnt USING ls_id ,ls_pid   #(ver:35) add ls_pid
                                     INTO li_cnt
   FREE azzq670_get_cnt
 
   IF li_cnt = 0 OR SQLCA.SQLCODE THEN
      RETURN TRUE
   ELSE
      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM azzq670_tmp ",
                  " WHERE gzas002 = ? ",
                    " AND gzas001 = ? "   #(ver:35) add
 
      PREPARE azzq670_chk_exp FROM g_sql
      EXECUTE azzq670_chk_exp USING ls_id ,ls_pid   #(ver;35) add ls_pid
                                        INTO li_code
      FREE azzq670_chk_exp
      
      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE azzq670_tmp SET (exp_code) = ('",pi_code,"') ",
                     " WHERE gzas002 = ? ",
                       " AND gzas001 = ? "   #(ver:35) add
         PREPARE azzq670_upd_exp FROM g_sql
         EXECUTE azzq670_upd_exp USING ls_id ,ls_pid   #(ver:35) add ls_pid
         FREE azzq670_upd_exp
      END IF
      
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.browser_expand" >}
#+ Tree子節點展開
PRIVATE FUNCTION azzq670_browser_expand(p_id)
   #add-point:browser_expand段define name="browser_expand.define_customerization"
   
   #end add-point
   DEFINE p_id          LIKE type_t.num10
   DEFINE l_id          LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_keyvalue    LIKE type_t.chr50
   DEFINE l_typevalue   LIKE type_t.chr50
   DEFINE l_type        LIKE type_t.chr50
   DEFINE l_sql         STRING
   DEFINE ls_source     LIKE type_t.chr500
   DEFINE ls_exp_code   LIKE type_t.chr500
   DEFINE l_return      LIKE type_t.num5
   DEFINE ls_ent_wc     LIKE type_t.chr500
   #add-point:browser_expand段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_expand.pre_function"
   RETURN      #160802-00026#1 add
   #end add-point
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_return = FALSE
 
   LET l_keyvalue = g_browser[p_id].b_gzas002
   
   CASE g_browser[p_id].b_expcode
      WHEN -1
         CALL g_browser.deleteElement(p_id)
      WHEN 0
         RETURN
      WHEN 1
         LET ls_source = "azzq670_tmp"
         LET ls_exp_code = "exp_code"
      WHEN 2
         LET ls_source = "gzas_t"
         LET ls_exp_code = "'2'"
         LET ls_ent_wc = " gzasent = " ||g_enterprise|| " AND "
   END CASE
    
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','',",ls_exp_code,",gzas001,'',gzas002,'','','', 
       t1.gzasl004 ,t2.gzarl004 ",
               " FROM ",ls_source,
                              " LEFT JOIN gzasl_t t1 ON t1.gzaslent="||g_enterprise||" AND t1.gzasl002=gzas001 AND t1.gzasl003='"||g_lang||"' ",
               " LEFT JOIN gzarl_t t2 ON t2.gzarlent="||g_enterprise||" AND t2.gzarl001=gzas002 AND t2.gzarl002='"||g_lang||"' ",
 
               " WHERE ",ls_ent_wc,"gzas001 = '", l_keyvalue,
               "' AND gzas002 <> gzas001",
               " ORDER BY gzas002"
   
   #add-point:browser_expand段before_pre name="browser_expand.before_pre"
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','',",ls_exp_code,",gzas001,'',gzas002,'',gzas003, 
       gzas004,'','','','',t1.gzasl004 ,t2.gzarl004 ",   #160802-00026#1 mod
               " FROM ",ls_source,
                              " LEFT JOIN gzasl_t t1 ON t1.gzaslent='"||g_enterprise||"' AND t1.gzasl002=gzas001 AND t1.gzasl002='"||g_dlang||"' ",
#               " LEFT JOIN gzasl_t t2 ON t2.gzaslent='"||g_enterprise||"' AND t2.gzasl001=gzas002 AND t2.gzasl002='"||g_dlang||"' ",
               " LEFT JOIN gzarl_t t2 ON t2.gzarlent="||g_enterprise||" AND t2.gzarl001=gzas002 AND t2.gzarl002='"||g_lang||"' ",
               " WHERE ",ls_ent_wc,"gzas001 = '", l_keyvalue,
               "' AND gzas002 <> gzas001",
               " ORDER BY gzas001,gzas003"
   #end add-point
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand
  
   LET l_id = p_id + 1
   LET g_cnt = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_browser[l_id].*,g_browser[g_cnt].b_gzas001_desc,g_browser[g_cnt].b_gzas002_desc  
 
      #pid=父節點id
      LET g_browser[l_id].b_pid = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id = g_browser[p_id].b_id||"."||l_cnt
      #hasC=確認該節點是否有子孫
      CALL azzq670_desc_show(l_id)
      LET g_browser[l_id].b_hasC = azzq670_chk_hasC(l_id)
      LET l_id = l_id + 1
      LET g_cnt = l_id
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.browser_create" >}
PRIVATE FUNCTION azzq670_browser_create(p_type)
   #add-point:browser_create name="browser_create.define_customerization"
   
   #end add-point
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50
   #add-point:browser_create(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_create.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_create.pre_function"
   
   #end add-point
   
   #先找出所有的帳別資料
   
   LET l_ac = 1
      #確定root節點所在
      #此處為帳別部分(LV-1)
      
      #抓出LV2的所有資料
      #LET g_sql = " SELECT DISTINCT t0.gzas001,t0.gzas002,exp_code FROM azzq670_tmp a ",
      LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,gzas001,'',gzas002,'','','',t1.gzasl004 , 
          t2.gzarl004 FROM azzq670_tmp a ",
                                 " LEFT JOIN gzasl_t t1 ON t1.gzaslent="||g_enterprise||" AND t1.gzasl002=gzas001 AND t1.gzasl003='"||g_lang||"' ",
               " LEFT JOIN gzarl_t t2 ON t2.gzarlent="||g_enterprise||" AND t2.gzarl001=gzas002 AND t2.gzarl002='"||g_lang||"' ",
 
                  " WHERE ",
                  " (( SELECT COUNT(1) FROM azzq670_tmp b WHERE a.gzas001 = b.gzas002 ", 
                  ") = 0 OR ", 
                  " a.gzas002 = a.gzas001 )", 
                  " ORDER BY a.gzas002"
      #add-point:browser_create.before_pre name="browser_create.before_pre"
      LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,gzas001,'',gzas002,'',gzas003,gzas004, 
          '','','','',t1.gzasl004 ,t2.gzarl004 FROM azzq670_tmp a ",    #160802-00026#1 mod
                                 " LEFT JOIN gzasl_t t1 ON t1.gzaslent='"||g_enterprise||"' AND t1.gzasl002=gzas001 AND t1.gzasl002='"||g_dlang||"' ",
#               " LEFT JOIN gzasl_t t2 ON t2.gzaslent='"||g_enterprise||"' AND t2.gzasl001=gzas002 AND t2.gzasl002='"||g_dlang||"' ",
               " LEFT JOIN gzarl_t t2 ON t2.gzarlent="||g_enterprise||" AND t2.gzarl001=gzas002 AND t2.gzarl002='"||g_lang||"' ",
                  " WHERE ",
                  " (( SELECT COUNT(1) FROM azzq670_tmp b WHERE a.gzas001 = b.gzas002 ", 
                  ") = 0 OR ", 
                  " a.gzas002 = a.gzas001 )", 
                  " ORDER BY a.gzas001,a.gzas003"
      #end add-point
 
      PREPARE master_getLV2 FROM g_sql
      DECLARE master_getLV2cur CURSOR FOR master_getLV2
      
      #以下為一般資料root(LV-2)
 
      LET g_cnt = l_ac
      FOREACH master_getLV2cur   #(ver:36) #(ver:37)
         INTO g_browser[g_cnt].*,g_browser[g_cnt].b_gzas001_desc,g_browser[g_cnt].b_gzas002_desc     
             #(ver:36)
         #(ver:36) ---add start---
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "Browser Create FOREACH ERROR"
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         #(ver:36) --- add end ---
 
         #去除多餘空白
         #LET g_browser[g_cnt].b_gzas002 = g_browser[g_cnt].b_gzas002 CLIPPED
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id  = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = FALSE
         #(ver:35) ---modify start---
         #LET g_browser[g_cnt].b_expcode = 2
         CASE g_browser[g_cnt].b_expcode
            WHEN 2
               LET g_browser[g_cnt].b_hasC = azzq670_chk_hasC(g_cnt)
            WHEN 1
               LET g_browser[g_cnt].b_hasC = azzq670_chk_hasC(g_cnt)
            WHEN 0
               LET g_browser[g_cnt].b_hasC = FALSE
            WHEN -1
               #向下查找到展開值不等於-1得節點(temp table中查找)
               LET g_cnt = azzq670_find_node(g_cnt)
         END CASE
         #(ver:35) --- modify end ---
         IF cl_null("gzas001") THEN
            LET g_browser[g_cnt].b_hasC = FALSE
         ELSE
            LET g_browser[g_cnt].b_hasC = TRUE
         END IF
 
         LET g_cnt = g_cnt + 1
      END FOREACH
      LET l_ac = g_browser.getLength()
 
   
   #組合描述欄位&刪除多於資料
   FOR l_ac = 1 TO g_browser.getLength()
      IF cl_null(g_browser[l_ac].b_gzas002) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL azzq670_desc_show(l_ac)
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
 
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
 
   FREE tree_expand
   FREE master_getLV2
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.desc_show" >}
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION azzq670_desc_show(pi_ac)
   #add-point:desc_show段define name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10   
   #add-point:desc_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   DEFINE l_desc  LIKE type_t.chr100   #160802-00026#1 add
   #end add-point
   
   #add-point:Function前置處理  name="desc_show.pre_function"
   
   #end add-point
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   
   
   #add-point:browser_create段desc處理 name="desc_show.show"
      LET g_browser[l_ac].b_show = 
           g_browser[l_ac].b_gzas001,
             '(',g_browser[l_ac].b_gzas002,')'
             
      #160802-00026#1 add-S
      IF azzq670_chkpoint_chk(g_browser[l_ac].b_gzas002) THEN
         SELECT gzarl003 INTO l_desc FROM gzarl_t
           WHERE gzarlent = g_enterprise
             AND gzarl001 = g_browser[l_ac].b_gzas002
             AND gzarl002 = g_lang
         
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_gzas002,'(',l_desc,')'
      ELSE
         SELECT gzasl004 INTO l_desc FROM gzasl_t
           WHERE gzaslent = g_enterprise
             AND gzasl002 = g_browser[l_ac].b_gzas002
             AND gzasl003 = g_lang
         LET g_browser[l_ac].b_gzas002_desc = l_desc
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_gzas002,'(',l_desc,')'
      END IF
      #160802-00026#1 add-E
      
      
#      IF g_browser[l_ac].b_gzas004 = '1'  THEN      
#         SELECT gzar003,gzar004,gzar005 INTO g_browser[l_ac].b_gzar003,g_browser[l_ac].b_gzar004,g_browser[l_ac].b_gzar005 FROM gzar_t
#          WHERE gzarent = g_enterprise
#            AND gzar001 = g_browser[l_ac].b_gzas002 
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_browser[l_ac].b_gzar003
#         CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
#         LET g_browser[l_ac].b_gzar003_desc = '', g_rtn_fields[1] , ''
#         DISPLAY BY NAME g_browser[l_ac].b_gzar003_desc
#      ELSE
#         LET g_browser[l_ac].b_gzar003 = ''
#         LET g_browser[l_ac].b_gzar003_desc = ''
#         LET g_browser[l_ac].b_gzar004 = ''
#         LET g_browser[l_ac].b_gzar005 = ''
#      END IF
   #end add-point
 
   LET l_ac = li_tmp
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.find_node" >}
#+ 尋找符合條件的節點
PRIVATE FUNCTION azzq670_find_node(pi_ac)
   #add-point:find_node段define name="find_node.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   DEFINE ls_pid  STRING
   #add-point:find_node段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="find_node.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="find_node.pre_function"
   LET ls_pid = g_browser[pi_ac].b_pid
   
   LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,gzas001,'',gzas002,'',gzas003,gzas004, 
       '','','' ",
               " FROM azzq670_tmp ",
               " WHERE gzas001 = ? AND gzas001 <> gzas002",
               " ORDER BY gzas001,gzas003"
   PREPARE master_getNode2 FROM g_sql
   DECLARE master_getNodecur2 CURSOR FOR master_getNode2
   
   LET li_idx = pi_ac
   WHILE li_idx <= g_browser.getLength()
      IF g_browser[li_idx].b_expcode = -1 THEN
         OPEN master_getNodecur2 USING g_browser[li_idx].b_gzas002
         FOREACH master_getNodecur2 INTO g_browser[g_browser.getLength()+1].*
            CALL azzq670_desc_show(g_browser.getLength())
            LET g_browser[g_browser.getLength()].b_pid = ls_pid
            LET g_browser[g_browser.getLength()].b_id = g_browser.getLength()
            LET g_browser[g_browser.getLength()].b_hasC = azzq670_chk_hasC(g_browser.getLength())
         END FOREACH
         CALL g_browser.deleteElement(li_idx)
         CALL g_browser.deleteElement(g_browser.getLength())
      ELSE
         LET li_idx = li_idx + 1
      END IF
   
   END WHILE
   
   FREE master_getNode2
   
   RETURN g_browser.getLength()
   #end add-point
   
   LET ls_pid = g_browser[pi_ac].b_pid
   
   LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,gzas001,'',gzas002,'','','' ",
               " FROM azzq670_tmp ",
               " WHERE gzas001 = ? AND gzas001 <> gzas002",
               " ORDER BY gzas002"
   PREPARE master_getNode FROM g_sql
   DECLARE master_getNodecur CURSOR FOR master_getNode
   
   LET li_idx = pi_ac
   WHILE li_idx <= g_browser.getLength()
      IF g_browser[li_idx].b_expcode = -1 THEN
      #  OPEN master_getNodecur USING g_browser[li_idx].b_gzas002   #(ver:36)
         FOREACH master_getNodecur USING g_browser[li_idx].b_gzas002 INTO g_browser[g_browser.getLength()+1].*  
               #(ver:36)
 
            #(ver:36) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH ",SQLERRMESSAGE
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               RETURN
            END IF
            #(ver:36) --- end ---
            CALL azzq670_desc_show(g_browser.getLength())
            LET g_browser[g_browser.getLength()].b_pid = ls_pid
            LET g_browser[g_browser.getLength()].b_id = g_browser.getLength()
            LET g_browser[g_browser.getLength()].b_hasC = azzq670_chk_hasC(g_browser.getLength())
         END FOREACH
         CALL g_browser.deleteElement(li_idx)
         CALL g_browser.deleteElement(g_browser.getLength())
      ELSE
         LET li_idx = li_idx + 1
      END IF
   
   END WHILE
   
   FREE master_getNode
   
   RETURN g_browser.getLength()
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.chk_hasC" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzq670_chk_hasC(pi_id)
   #add-point:chk_hasC段define name="chk_hasC.define_customerization"
   
   #end add-point
   DEFINE pi_id    LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:chk_hasC段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_hasC.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="chk_hasC.pre_function"
   
   #end add-point
   
   LET g_sql = "SELECT COUNT(gzas001) FROM azzq670_tmp ",
               " WHERE ",
                "gzas001 = ? AND ",
                "exp_code <> '-1' AND gzas002 <> gzas001 "
 
   PREPARE azzq670_temp_chk FROM g_sql
 
   LET g_sql = "SELECT COUNT(1) FROM gzas_t ",
               " WHERE gzasent = " ||g_enterprise|| " AND ", 
               "gzas002 <> gzas001 AND ",
               "gzas001 = ? ",
               cl_sql_add_filter("gzas_t")
   
   PREPARE azzq670_master_chk FROM g_sql
   
   CASE g_browser[pi_id].b_expcode 
      WHEN -1
         RETURN FALSE
      WHEN 0
         RETURN FALSE
      WHEN 1
         EXECUTE azzq670_temp_chk 
           USING g_browser[pi_id].b_gzas002
            INTO li_cnt
         FREE azzq670_temp_chk
      WHEN 2 
         EXECUTE azzq670_master_chk 
           USING g_browser[pi_id].b_gzas002
            INTO li_cnt
         FREE azzq670_master_chk
   END CASE
    
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzq670_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_wc       STRING
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面
   CLEAR FORM
   INITIALIZE g_gzas_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_qryparam.state = "c"
    
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT BY NAME g_wc ON gzas001,gzas002 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
            
         
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzas001
            #add-point:BEFORE FIELD gzas001 name="construct.b.gzas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzas001
            
            #add-point:AFTER FIELD gzas001 name="construct.a.gzas001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzas001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzas001
            #add-point:ON ACTION controlp INFIELD gzas001 name="construct.c.gzas001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzas001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzas001  #顯示到畫面上
            NEXT FIELD gzas001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzas002
            #add-point:BEFORE FIELD gzas002 name="construct.b.gzas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzas002
            
            #add-point:AFTER FIELD gzas002 name="construct.a.gzas002"
   
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzas002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzas002
            #add-point:ON ACTION controlp INFIELD gzas002 name="construct.c.gzas002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzas001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzas002  #顯示到畫面上
            NEXT FIELD gzas002                     #返回原欄位
    
            #END add-point
 
 
 
       
      END CONSTRUCT
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT g_wc2 ON gzar001,gzar003
           FROM s_detail1[1].gzar001,s_detail1[1].gzar003

         BEFORE CONSTRUCT 
            INITIALIZE g_wc2 TO NULL
            
         ON ACTION controlp INFIELD gzar001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzar001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzar001  #顯示到畫面上
            NEXT FIELD gzar001                     #返回原欄位
            
         ON ACTION controlp INFIELD gzar003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzar003  #顯示到畫面上
            NEXT FIELD gzar003                     #返回原欄位            
            
      END CONSTRUCT
      
      #end add-point
         
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段before dialog name="cs.before_dialog"
         
         #end add-point
      
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
      
      ON ACTION qbe_save       #條件儲存
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG
 
   END DIALOG
 
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzq670_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.before_query"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
 
   #CLEAR FORM
   #CALL g_browser.clear()
 
   DISPLAY " " TO FORMONLY.h_count
 
   CALL azzq670_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      #add-point:query段取消 name="query.cancel"
      CALL azzq670_gzar_b_fill()      
      #end add-point
      #CALL azzq670_browser_fill(g_wc,g_searchtype)
      CALL azzq670_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_browser_cnt = 0
      LET g_current_idx = 1
      CALL g_browser.clear()
      LET g_first = 0  #設定重新查詢資料後顯示
   END IF
 
   LET g_searchtype = "3"
   LET g_searchcol = "0"
   CALL azzq670_browser_fill(g_wc,g_searchtype)
   
   IF g_browser_cnt > 0 THEN
      CALL azzq670_fetch("")
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #第一層模糊搜尋
   #IF g_browser_cnt = 0 THEN
   #   LET g_wc = cl_wc_parser(g_wc)
   #   CALL azzq670_browser_fill(g_wc,g_searchtype)
   #END IF
   
   #第二層速記碼搜尋
   #IF g_browser_cnt = 0 THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "" 
   #   LET g_errparam.code = "-100" 
   #   LET g_errparam.popup = TRUE 
   #   CALL cl_err()
   #END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzq670_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.befroe_fetch"
   
   #end add-point 
 
 
   #瀏覽頁筆數顯示
   LET li_idx = 1
   FOR li_idx = 1 TO g_browser_root.getLength()
      IF g_browser_root[li_idx] > g_current_idx THEN
       EXIT FOR
      END IF
   END FOR
   LET li_idx = g_current_idx - li_idx + 1
   #DISPLAY li_idx TO FORMONLY.h_index   #當下筆數
 
   IF p_flag = "/" THEN
      IF (NOT g_no_ask) THEN      
         CALL cl_getmsg("fetch",g_lang) RETURNING ls_msg
         LET INT_FLAG = 0
 
         PROMPT ls_msg CLIPPED,": " FOR g_jump
            #交談指令共用ACTION
            &include "common_action.4gl" 
         END PROMPT
 
         IF INT_FLAG THEN
            LET INT_FLAG = 0
         ELSE
            IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
               LET g_current_idx = g_jump
            END IF
            LET g_no_ask = FALSE  
         END IF           
      END IF
   END IF    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   LET g_gzas_m.gzas002 = g_browser[g_current_idx].b_gzas002
   LET g_gzas_m.gzas001 = g_browser[g_current_idx].b_gzas001
    
   #add-point:fetch段refresh前 name="fetch.before_refresh"
   
   #end add-point
    
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzq670_master_referesh USING g_gzas_m.gzas001,g_gzas_m.gzas002 INTO g_gzas_m.gzas001,g_gzas_m.gzas002  
 
   
   IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "gzas_t:",SQLERRMESSAGE 
       LET g_errparam.code = SQLCA.SQLCODE 
       LET g_errparam.popup = TRUE 
       CALL cl_err()
       INITIALIZE g_gzas_m.* TO NULL
       RETURN
   END IF
   
   #若無資料則關閉相關功能
   IF g_browser.getLength() = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
   #add-point:fetch段after_fetch name="fetch.after_fetch"
   
   #end add-point
 
   
   
   #保存單頭舊值
   LET g_gzas_m_t.* = g_gzas_m.*
   LET g_gzas_m_o.* = g_gzas_m.*
   
   #重新顯示
   CALL azzq670_show()
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
   
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzq670_insert(l_dialog)
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point
   DEFINE l_dialog   ui.DIALOG
   DEFINE li_addpos  LIKE type_t.num10 #新增節點時產出的畫面實際位置
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   LET g_gzas001_t = g_gzas_m.gzas001
   LET g_gzas002_t = g_gzas_m.gzas002
 
   LET g_gzas002_t = g_gzas_m.gzas002
 
   #清畫面欄位內容
   CLEAR g_gzas_m.*
 
 
   #add-point:單頭預設值 name="insert.before_insert"
   
   #end add-point 
 
   INITIALIZE g_gzas_m.* LIKE gzas_t.*
   DISPLAY BY NAME g_gzas_m.gzas001,g_gzas_m.gzas002
   CALL s_transaction_begin()
 
   #其他table資料備份(確定是否更改用)
   
 
   WHILE TRUE
      #給予pid,type預設值
      LET g_gzas_m.gzas001 = g_gzas002_t
      
      
      CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
  
      
      
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
#      LET g_gzas_m.gzas005 = 'N' 
#      LET g_gzas_m.gzas004 = '0'
      #end add-point 
 
      CALL azzq670_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzas_m.* = g_gzas_m_t.*
         CALL azzq670_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         EXIT WHILE
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_gzas_m.gzas001 = g_gzas_m.gzas002 THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_gzas001 = g_gzas_m.gzas001
            LET g_browser[li_addpos].b_gzas002 = g_gzas_m.gzas002
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL azzq670_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_gzas002 = g_gzas_m.gzas001 THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_gzas001 = g_gzas_m.gzas001
                     LET g_browser[li_addpos].b_gzas002 = g_gzas_m.gzas002
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_gzas001
                                                     ,g_browser[li_addpos].b_gzas002
 
                                                INTO g_browser[g_cnt].b_gzas001,g_browser[g_cnt].b_gzas002, 
                                                    g_browser[g_cnt].b_gzas001_desc,g_browser[g_cnt].b_gzas002_desc 
 
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL azzq670_desc_show(li_addpos)
                     #打開父節點
                     LET g_browser[li_idx].b_hasC = TRUE
                     LET g_browser[li_idx].b_exp = TRUE
                     LET g_current_idx = li_addpos
                     EXIT FOR
                  END IF
               END FOR
            END IF
            LET g_cnt = li_cnt
         END IF
      END IF
      
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzq670_master_referesh USING g_gzas_m.gzas001,g_gzas_m.gzas002 INTO g_gzas_m.gzas001,g_gzas_m.gzas002 
 
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzas_m.gzas001,g_gzas_m.gzas002
   
   #功能已完成,通報訊息中心
   CALL azzq670_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzq670_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_gzas_m.gzas001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
   
   EXECUTE azzq670_master_referesh USING g_gzas_m.gzas001,g_gzas_m.gzas002 INTO g_gzas_m.gzas001,g_gzas_m.gzas002 
 
 
   #檢查是否允許此動作
   IF NOT azzq670_action_chk() THEN
      RETURN
   END IF
  
   LET g_gzas001_t = g_gzas_m.gzas001
   LET g_gzas002_t = g_gzas_m.gzas002
 
   
   CALL s_transaction_begin()
   
   OPEN azzq670_cl USING g_enterprise,g_gzas_m.gzas001,g_gzas_m.gzas002
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE azzq670_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzq670_cl:" 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzq670_cl INTO g_gzas_m.gzas001,g_gzas_m.gzas002
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.SQLCODE THEN
      CLOSE azzq670_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzas_m.gzas002,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #其他table資料備份(確定是否更改用)
   
 
   CALL azzq670_show()
   WHILE TRUE
      LET g_gzas_m.gzas001 = g_gzas001_t
      LET g_gzas_m.gzas002 = g_gzas002_t
 
      
      #寫入修改者/修改日期資訊
      
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL azzq670_input("u")     #欄位更改
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzas_m.* = g_gzas_m_t.*
         CALL azzq670_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
 
      
      EXIT WHILE
  
   END WHILE
 
   CLOSE azzq670_cl
   CALL s_transaction_end("Y","0")
 
   #功能已完成,通報訊息中心
   CALL azzq670_msgcentre_notify('modify')
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.check" >}
#+ 避免資料錯誤
PRIVATE FUNCTION azzq670_check(ps_id,ps_pid)
   #add-point:check段define name="check.define_customerization"
   
   #end add-point
   DEFINE ps_id       STRING
   DEFINE ps_pid      STRING
   DEFINE ps_type     STRING
   DEFINE ls_pid      LIKE type_t.chr100
   DEFINE ls_id       LIKE type_t.chr100
   DEFINE ls_type     LIKE type_t.chr100
   DEFINE ls_return   LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   #add-point:check段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="check.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="check.pre_function"
   
   #end add-point
   
   #從該節點往上檢查, 若出現ID重複的狀況代表會導致無限迴圈
   LET ls_sql = " SELECT gzas002,gzas001 FROM ",
                " (SELECT gzas002,gzas001 FROM gzas_t WHERE gzasent = " ||g_enterprise|| " AND gzas002<>gzas001)", 
 
                " WHERE gzas002 = '",ps_id,"' OR gzas001 = '",ps_id,"'",
                " START WITH gzas002='",ps_pid,"'",
                " CONNECT BY PRIOR gzas001=gzas002 "
 
   PREPARE check_cnt FROM ls_sql
   DECLARE check_cntcur CURSOR FOR check_cnt
   OPEN check_cntcur
   IF SQLCA.SQLCODE THEN   #(ver:36)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN check_cntcur:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
 
   FETCH check_cntcur INTO li_cnt
 
   IF li_cnt > 0 THEN
      LET ls_return = TRUE
   ELSE
      LET ls_return = FALSE
   END IF
   
   RETURN ls_return 
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzq670_reproduce(l_dialog)
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_dialog      ui.DIALOG
   DEFINE li_addpos     LIKE type_t.num10
   DEFINE l_newno           LIKE gzas_t.gzas001 
   DEFINE l_oldno           LIKE gzas_t.gzas001 
   DEFINE l_newno02     LIKE gzas_t.gzas002 
   DEFINE l_oldno02     LIKE gzas_t.gzas002 
 
   DEFINE l_master          RECORD LIKE gzas_t.*
   DEFINE l_cnt             LIKE type_t.num10  
   DEFINE li_idx            LIKE type_t.num10  
   DEFINE li_cnt            LIKE type_t.num10  
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.before_reproduce"
   
   #end add-point
 
   #檢查PK欄位是否均有值,若全部為NULL時退出
   IF g_gzas_m.gzas001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   EXECUTE azzq670_master_referesh USING g_gzas_m.gzas001,g_gzas_m.gzas002 INTO g_gzas_m.gzas001,g_gzas_m.gzas002 
 
 
   #檢查如果有子節點(hasC=1)則顯示錯誤訊息後退出
 
   ERROR ""
 
   CALL cl_set_head_visible("","YES")
 
   
 
   LET g_gzas_m.gzas001 = ""
   LET g_gzas_m.gzas002 = ""
 
   
   
   CALL s_transaction_begin()
   
   #其他table資料備份(確定是否更改用)
   
 
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #直接呼叫輸入
   CALL azzq670_input("r")
 
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
 
   IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzas_m.* = g_gzas_m_t.*
         CALL azzq670_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_gzas_m.gzas001 = g_gzas_m.gzas002 THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_gzas001 = g_gzas_m.gzas001
            LET g_browser[li_addpos].b_gzas002 = g_gzas_m.gzas002
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL azzq670_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_gzas002 = g_gzas_m.gzas001 THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_gzas001 = g_gzas_m.gzas001
                     LET g_browser[li_addpos].b_gzas002 = g_gzas_m.gzas002
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_gzas001
                                                     ,g_browser[li_addpos].b_gzas002
 
                                                INTO g_browser[g_cnt].b_gzas001,g_browser[g_cnt].b_gzas002, 
                                                    g_browser[g_cnt].b_gzas001_desc,g_browser[g_cnt].b_gzas002_desc 
 
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL azzq670_desc_show(li_addpos)
                     #打開父節點
                     LET g_browser[li_idx].b_hasC = TRUE
                     LET g_browser[li_idx].b_exp = TRUE
                     LET g_current_idx = li_addpos
                     EXIT FOR
                  END IF
               END FOR
            END IF
            LET g_cnt = li_cnt 
         END IF
      END IF
 
   #功能已完成,通報訊息中心
   CALL azzq670_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzq670_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_cmd_t         LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzas_m.gzas001,g_gzas_m.gzas002
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r' 
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF  
   
   CALL cl_set_head_visible("","YES")
 
   LET l_insert = FALSE
   LET g_action_choice = ""
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL azzq670_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzq670_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_gzas_m.gzas001,g_gzas_m.gzas002
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_gzas_m.gzas001,g_gzas_m.gzas002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            #add-point:input段define name="input.action"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzas001
            #add-point:BEFORE FIELD gzas001 name="input.b.gzas001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzas001
            
            #add-point:AFTER FIELD gzas001 name="input.a.gzas001"

            IF g_gzas_m.gzas001 <> g_gzas_m.gzas002 THEN 
               IF NOT ap_chk_isexist(g_gzas_m.gzas001,"SELECT COUNT(*) FROM gzas_t WHERE gzas002 = ? ",'std-00021',1)  THEN
                  NEXT FIELD gzas001
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzas001
            #add-point:ON CHANGE gzas001 name="input.g.gzas001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzas002
            #add-point:BEFORE FIELD gzas002 name="input.b.gzas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzas002
            
            #add-point:AFTER FIELD gzas002 name="input.a.gzas002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_gzas_m.gzas001) AND NOT cl_null(g_gzas_m.gzas002) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzas_m.gzas001 != g_gzas001_t  OR g_gzas_m.gzas002 != g_gzas002_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzas_t WHERE "||"gzasent = " ||g_enterprise|| " AND "||"gzas001 = '"||g_gzas_m.gzas001 ||"' AND "|| "gzas002 = '"||g_gzas_m.gzas002 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzas002
            #add-point:ON CHANGE gzas002 name="input.g.gzas002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzas001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzas001
            #add-point:ON ACTION controlp INFIELD gzas001 name="input.c.gzas001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_gzas_m.gzas001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_gzas001()                                #呼叫開窗
 
            LET g_gzas_m.gzas001 = g_qryparam.return1              

            DISPLAY g_gzas_m.gzas001 TO gzas001              #

            NEXT FIELD gzas001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gzas002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzas002
            #add-point:ON ACTION controlp INFIELD gzas002 name="input.c.gzas002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_gzas_m.gzas002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_gzar001()                                #呼叫開窗
 
            LET g_gzas_m.gzas002 = g_qryparam.return1              

            DISPLAY g_gzas_m.gzas002 TO gzas002              #

            NEXT FIELD gzas002     
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #避免資料錯誤的檢查
            IF azzq670_check(g_gzas_m.gzas002,g_gzas_m.gzas001
               ) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code = "std-00020" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
 
            #CALL cl_err_collect_show()   #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gzas_m.gzas002
 
            #實體新增/修改/複製段落的處理
            CASE
               WHEN p_cmd = "a" OR p_cmd = "r"
                  LET l_count = 1
 
                  SELECT COUNT(1) INTO l_count FROM gzas_t
                   WHERE gzasent = g_enterprise AND gzas001 = g_gzas_m.gzas001
                     AND gzas002 = g_gzas_m.gzas002
 
                         #
                  IF l_count = 0 THEN
                     #add-point:單頭新增前 name="input.head.b_insert"
                     
                     #end add-point
 
                     INSERT INTO gzas_t (gzasent,gzas001,gzas002)
                     VALUES (g_enterprise,g_gzas_m.gzas001,g_gzas_m.gzas002) 
 
                     #add-point:單頭新增中 name="input.head.m_insert"
                     CALL azzq670_gzar_b_fill()
                     #end add-point
 
                     IF SQLCA.SQLCODE THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "g_gzas_m:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                  
                     #提速檔資料建置
                     IF g_gzas_m.gzas002 <> g_gzas_m.gzas001 THEN
                        #CALL n_gzass_generate_child(g_gzas_m.gzas002,g_gzas_m.gzas001)
                     END IF
                     
                     #add-point:單頭新增後 name="input.head.a_insert"
                     
                     #end add-point
                     
                     #資料多語言用-增/改
                     
                     CALL s_transaction_end("Y","0")
                  ELSE
                     CALL s_transaction_end("N","0")
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend =  g_gzas_m.gzas002 
                     LET g_errparam.code =  "std-00006" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  END IF 
 
               #修改段落
               WHEN p_cmd = "u"  
                  #add-point:單頭修改前 name="input.head.b_update"
                  
                  #end add-point
                  UPDATE gzas_t SET (gzas001,gzas002) = (g_gzas_m.gzas001,g_gzas_m.gzas002)
                   WHERE gzasent = g_enterprise AND gzas001 = g_gzas001_t #
                     AND gzas002 = g_gzas002_t
 
                  #add-point:單頭修改中 name="input.head.m_update"
                  
                  #end add-point
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        CALL s_transaction_end('N','0')
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "gzas_t" 
                        LET g_errparam.code = "std-00009" 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        
                     WHEN SQLCA.SQLCODE #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "gzas_t:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL s_transaction_end('N','0')
                        CALL cl_err()
                        
                     OTHERWISE
                        #add-point:單頭修改後 name="input.head.a_update"
                        CALL azzq670_gzar_b_fill()
                        #end add-point
    
                        #資料多語言用-增/改
                        
                        LET g_log1 = util.JSON.stringify(g_gzas_m_t)
                        LET g_log2 = util.JSON.stringify(g_gzas_m)
                        IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL s_transaction_end('Y','0')
                        END IF
                  END CASE
 
               OTHERWISE 
            END CASE
 
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      #150624-00008#53 add-S
      INPUT ARRAY g_browser FROM s_browse.*
         ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
           INSERT ROW = FALSE,
           DELETE ROW = FALSE,
           APPEND ROW = FALSE)
           
         BEFORE INPUT
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_current_row = l_ac
            
         ON ACTION controlp INFIELD b_exc_qty_1
            IF g_browser[g_current_row].b_exc_qty_1>0 THEN
               IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar004) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
                  LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar004
                 
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
            END IF
#            DISPLAY table1[arr_curr()].edit1
         ON ACTION controlp INFIELD b_war_qty_1
            IF g_browser[g_current_row].b_war_qty_1>0 THEN
               IF NOT cl_null(g_gzas2_d[g_current_row].l_gzar003) AND NOT cl_null(g_gzas2_d[g_current_row].l_gzar005) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = g_gzas2_d[g_current_row].l_gzar003 
                  LET la_param.param[1] = g_gzas2_d[g_current_row].l_gzar005
                 
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
            END IF
#            DISPLAY table1[arr_curr()].edit2
      END INPUT
      #150624-00008#53 add-E
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:before dialog name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
        
      #在dialog button (放棄)
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close       
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
           
   END DIALOG
   
   #add-point:input段after input  name="input.after_input"
   
   #end add-point
    
END FUNCTION
 
{</section>}
 
{<section id="azzq670.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzq670_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
       
   
   #帶出公用欄位reference值
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzq670_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:reference段之後 name="show.head.reference"

#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_gzas_m.gzas002
#   CALL ap_ref_array2(g_ref_fields," SELECT gzasl003 FROM gzasl_t WHERE gzaslent = '"||g_enterprise||"' AND gzasl001 = ? AND gzasl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
#   LET g_gzas_m.gzasl003 = g_rtn_fields[1] 
#   DISPLAY g_gzas_m.gzasl003 TO gzasl003
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzas_m.gzas001,g_gzas_m.gzas002
 
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()   
 
   #add-point:show段之後 name="show.after"
   CALL azzq670_gzar_b_fill() 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzq670_delete(l_dialog)
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_dialog        ui.DIALOG
   DEFINE li_status       LIKE type_t.num5  #SQL實體資料刪除狀態
   DEFINE li_cnt          LIKE type_t.num10 #查看本階是否有兄弟資料
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_gzas_m.gzas001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:delete段before_delete name="delete.before_delete"
   
   #end add-point
 
   EXECUTE azzq670_master_referesh USING g_gzas_m.gzas001,g_gzas_m.gzas002 INTO g_gzas_m.gzas001,g_gzas_m.gzas002 
 
    
   #檢查是否允許此動作
   IF NOT azzq670_action_chk() THEN
      RETURN
   END IF
    
   CALL azzq670_show()
   
   #Transaction開始
   CALL s_transaction_begin()
   
   
 
   OPEN azzq670_cl USING g_enterprise,g_gzas_m.gzas001,g_gzas_m.gzas002
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE azzq670_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzq670_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzq670_cl INTO g_gzas_m.gzas001,g_gzas_m.gzas002
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzas_m.gzas002,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   #add-point:delete段before_delete name="delete.before_delete_ask"
   
   #end add-point
 
   #(ver:35) ---modify start---
   #(ver:35) 為避免刪除全部子節點可能會對其他節點造成影響，現改為只刪除當下節點
   #先判斷是否有子節點(hasC) 詢問是否砍除全部
#  IF g_browser[g_current_idx].b_hasC THEN
#     IF cl_ask_delete_all_node() THEN
#        LET li_status = azzq670_sql_delete(TRUE)
#     ELSE
#        LET li_status = FALSE
#     END IF
#  ELSE
      #如果沒有子節點,詢問是否刪除本筆資料
      IF cl_ask_delete() THEN
         LET li_status = azzq670_sql_delete(FALSE)
      ELSE
         LET li_status = FALSE
      END IF
#  END IF
   #(ver:35) --- modify end ---
 
   #檢查實體砍除是否發生意外中止
   IF NOT li_status THEN
      CALL s_transaction_end("N","0")
      CLOSE azzq670_cl
      RETURN
   END IF
 
   #刪除節點與資料內容
   CALL l_dialog.deleteNode("s_browse",g_current_idx)  #deleteNode會順便幫忙做deleteElement
 
   #確認這一階還有沒有兄弟 (有:不異動上階屬性/否:上階hasC及exp設定成0)
   #SELECT COUNT(1) INTO li_cnt
   #  FROM gzas_t
   # WHERE gzas001 = g_gzas_m.gzas001
   #IF g_current_idx > 1 THEN
   #   IF li_cnt = 0  THEN
   #      LET g_browser[g_current_idx - 1].b_hasC = 0
   #      LET g_browser[g_current_idx - 1].b_exp = 0
   #   END IF
   #END IF
 
   #add-point:單頭刪除後 name="delete.head.a_delete"
   
   #end add-point
   
   IF g_current_idx > 1 THEN
      LET g_current_idx = g_current_idx - 1
   END IF
   
   IF g_browser.getLength() > 0 THEN
      CALL azzq670_fetch("")
   END IF
 
   LET g_log1 = util.JSON.stringify(g_gzas_m)   #(ver:36)
   IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:36)
      CLOSE azzq670_cl
      CALL s_transaction_end('N','0')
   ELSE
      CLOSE azzq670_cl
      CALL s_transaction_end('Y','0')
   END IF
 
   #功能已完成,通報訊息中心
   CALL azzq670_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzq670.sql_delete" >}
#+ 實體刪除FUNCTION 
PRIVATE FUNCTION azzq670_sql_delete(li_node)
   #add-point:sql_delete段define name="sql_delet.define_customerization"
   
   #end add-point
   DEFINE li_node         LIKE type_t.num5  #TRUE:砍除Node Tree/FALSE:砍除Single Node
   DEFINE li_return       LIKE type_t.num5
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE ls_sql          STRING
   DEFINE li_cnt          LIKE type_t.num10   #(ver:35) add
   #add-point:sql_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sql_delet.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="sql_delet.pre_function"
   
   #end add-point
   
   LET li_return = TRUE
 
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzq670_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
   #add-point:單頭刪除前 name="delete.head.b_delete"
   
   #end add-point
   
   IF li_node = TRUE THEN
      #砍除該節點以下所有節點
      LET ls_sql = " SELECT gzas002,gzas001 FROM ",
                   " (SELECT gzas002,gzas001 FROM gzas_t WHERE gzasent = " ||g_enterprise|| " AND gzas002<>gzas001)", 
 
                   " START WITH gzas001='",g_gzas_m.gzas001,"'",
                   " CONNECT BY PRIOR gzas002 = gzas001"
 
   ELSE 
   
   END IF
 
   #刪除當下節點
   DELETE FROM gzas_t
    WHERE gzasent = g_enterprise AND gzas001 = g_gzas_m.gzas001
      AND gzas002 = g_gzas_m.gzas002
 
 
   #add-point:單頭刪除中 name="delete.head.m_delete"
   
   #end add-point
 
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzas_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
   END IF
 
   #(ver:35) ---modify start---
   # 若此節點還有存在在其他節點下，則多語言資料不可刪除
   LET li_cnt = 0
   LET ls_sql = " SELECT COUNT(1) FROM gzas_t",
                 " WHERE gzasent = " ||g_enterprise|| " AND gzas002 = '",g_gzas_m.gzas002,"'"
 
   PREPARE master_chk_node_exist FROM ls_sql
   EXECUTE master_chk_node_exist INTO li_cnt
   IF li_cnt <= 0 THEN
      
   END IF
   #(ver:35) --- modify end ---
 
   RETURN li_return
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzq670_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1 
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzas001,gzas002",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
 
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry('gzasl003',TRUE)
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzq670_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzas001,gzas002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.default_search" >}
#+ 外部參數預設搜尋
PRIVATE FUNCTION azzq670_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF g_searchtype = 0 OR cl_null(g_searchtype) THEN
      LET g_searchtype = 3
   END IF 
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzas001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzas002 = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #CALL azzq670_browser_fill(g_wc,g_searchtype)
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq670.state_change" >}
   
 
{</section>}
 
{<section id="azzq670.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzq670_set_pk_array()
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
   LET g_pk_array[1].values = g_gzas_m.gzas001
   LET g_pk_array[1].column = 'gzas001'
   LET g_pk_array[2].values = g_gzas_m.gzas002
   LET g_pk_array[2].column = 'gzas002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzq670.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzq670_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL azzq670_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzas_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzq670.action_chk" >}
PRIVATE FUNCTION azzq670_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzq670.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 说明
# Memo...........:
# Usage..........: CALL azzq670_gzas001_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_gzas001_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_gzas_m.gzas001
#   CALL ap_ref_array2(g_ref_fields,"SELECT gzasl003 FROM gzasl_t WHERE gzaslent='"||g_enterprise||"' AND gzasl001=? AND gzasl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_gzas_m.gzas001_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_gzas_m.gzas001_desc
END FUNCTION

################################################################################
# Descriptions...: 说明
# Memo...........:
# Usage..........: CALL azzq670_gzas001_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_gzas001_chk()
DEFINE  l_cnt      LIKE type_t.num5
DEFINE  r_success  LIKE type_t.num5
      
   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(gzas002) INTO l_cnt FROM gzas_t
    WHERE gzasent = g_enterprise
      AND gzas002 = g_gzas_m.gzas001
      
  IF g_gzas_m.gzas001 = g_gzas_m.gzas002 THEN
     RETURN TRUE
  END IF  
  IF cl_null(l_cnt) THEN
     LET l_cnt = 0
  END IF
  
  IF l_cnt < 1 THEN
     LET r_success = FALSE
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'aoo-00673'
     LET g_errparam.extend = g_gzas_m.gzas001
     LET g_errparam.popup = TRUE
     CALL cl_err()     
  END IF
  
  RETURN r_success
  
END FUNCTION

################################################################################
# Descriptions...: 说明
# Memo...........:
# Usage..........: CALL azzq670_gzas002_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_gzas002_chk()
DEFINE  l_cnt      LIKE type_t.num5
DEFINE  r_success  LIKE type_t.num5
      
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(gzas002) INTO l_cnt FROM gzas_t
    WHERE gzasent = g_enterprise
      AND gzas002 = g_gzas_m.gzas002
      AND gzas004 = '0'    #检核点可以一对多
      
  IF cl_null(l_cnt) THEN
     LET l_cnt = 0
  END IF
  
  IF l_cnt > 0 THEN
     LET r_success = FALSE
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'aoo-00674'
     LET g_errparam.extend = g_gzas_m.gzas002
     LET g_errparam.popup = TRUE
     CALL cl_err()     
  END IF
  
  RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 显示检核点
# Memo...........:
# Usage..........: CALL azzq670_gzar_b_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_gzar_b_fill()
DEFINE   l_sql     STRING

  
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
PRIVATE FUNCTION azzq670_gzas002_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_gzas_m.gzas002
#   CALL ap_ref_array2(g_ref_fields,"SELECT gzasl003 FROM gzasl_t WHERE gzaslent='"||g_enterprise||"' AND gzasl001=? AND gzasl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_gzas_m.gzasl003 = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_gzas_m.gzasl003
END FUNCTION

################################################################################
# Descriptions...: 删除子节点
# Memo...........:
# Usage..........: CALL azzq670_del_child(p_gzas001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_del_child(p_gzas001)
DEFINE  p_gzas001     LIKE gzas_t.gzas001
DEFINE  r_success     LIKE type_t.num5
DEFINE  l_i           LIKE type_t.num5
DEFINE  l_n           LIKE type_t.num5
DEFINE  l_sql         STRING
DEFINE  l_arr     DYNAMIC ARRAY OF RECORD
                  gzas002  LIKE gzas_t.gzas002
                 END RECORD

   LET r_success = TRUE   
   LET l_n = 1
   
   LET l_sql = " SELECT gzas002 FROM gzas_t ",
               "  WHERE gzasent = ",g_enterprise,
               "    AND gzas001 = '",p_gzas001,"'"

   PREPARE azzq670_del_gzas_pre FROM l_sql
   DECLARE azzq670_del_gzas_cs CURSOR FOR azzq670_del_gzas_pre
   
   FOREACH azzq670_del_gzas_cs INTO l_arr[l_n].gzas002
   
      DELETE FROM gzas_t WHERE gzasent = g_enterprise
                           AND gzas001 = p_gzas001
                           AND gzas002 = l_arr[l_n].gzas002

      IF SQLCA.SQLcode  THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzas_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_n = l_n + 1 
      
   END FOREACH

   CALL l_arr.deleteElement(l_arr.getLength())
   
   FOR l_i = 1 TO l_arr.getLength()
   
     IF NOT azzq670_del_child(l_arr[l_i].gzas002) THEN
        LET r_success = FALSE
        RETURN r_success
     END IF
     
   END FOR
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 遍历树
# Memo...........:
# Usage..........: CALL azzq670_tree_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_tree_fill()
DEFINE   l_sql       STRING
DEFINE   l_gzas001   LIKE gzas_t.gzas001
DEFINE   l_gzas002   LIKE gzas_t.gzas002     #161216-00018#1 add
#DEFINE  l_cnt LIKE type_t.chr10
DEFINE  l_cnt LIKE type_t.num5
DEFINE l_level  LIKE type_t.num5
DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
DEFINE l_tree_cnt_t  LIKE type_t.num10 #160802-00026#1 add                    
  
   LET l_sql = " SELECT DISTINCT gzas001,gzas002 FROM gzas_t ",      #若不是根节点，也需抓出显示
               "  WHERE gzasent = ",g_enterprise,
               "    AND (gzas002 IN (SELECT gzat002 FROM gzat_t WHERE gzatent = ",g_enterprise,
               "     AND gzat001 IN (SELECT gzxb003 FROM gzxb_t WHERE gzxbent = ",g_enterprise," AND gzxb001 = '",g_user,"' AND gzxb002 = '1')",
               "               UNION SELECT gzau002 FROM gzau_t WHERE gzauent = ",g_enterprise," AND gzau001 = '",g_user,"' )",
               "         AND gzas001 = gzas002)",     #根节点的情况，满足存在于权限内的资料。
               "     OR (gzas002 IN (SELECT gzat002 FROM gzat_t WHERE gzatent = ",g_enterprise, 
               "               AND gzat001 IN (SELECT gzxb003 FROM gzxb_t WHERE gzxbent = ",g_enterprise," AND gzxb001 = '",g_user,"' AND gzxb002 = '1')",
               "               UNION SELECT gzau002 FROM gzau_t WHERE gzauent = ",g_enterprise," AND gzau001 = '",g_user,"' )",
               "     AND gzas001 NOT IN (SELECT gzat002 FROM gzat_t WHERE gzatent = ",g_enterprise,      #剔除掉在权限内的根节点(包含关系)
               "               AND gzat001 IN (SELECT gzxb003 FROM gzxb_t WHERE gzxbent = ",g_enterprise," AND gzxb001 = '",g_user,"' AND gzxb002 = '1')",
               "               UNION SELECT gzau002 FROM gzau_t WHERE gzauent = ",g_enterprise," AND gzau001 = '",g_user,"' ) ",
               "         AND gzas001 <> gzas002)",    #不是根节点的情况，排除掉包含在已有的根节点中的资料。
               " ORDER BY gzas001 " #160802-00026#1 add
   #161216-00018#1 mod-E
   
   PREPARE azzq670_del_gzas_pre2 FROM l_sql
   DECLARE azzq670_del_gzas_cs2 CURSOR FOR azzq670_del_gzas_pre2
   CALL g_browser.clear()
   CLEAR FORM   
   LET g_tree_cnt = 1
   LET l_cnt = 0
   LET l_level = 0
   FOREACH azzq670_del_gzas_cs2 INTO l_gzas001,l_gzas002
      #160802-00026#1 add-S
      LET g_browser[g_tree_cnt].b_pid = NULL
      LET g_browser[g_tree_cnt].b_id = '.'||l_cnt+1
      LET g_browser[g_tree_cnt].b_exp = TRUE
      LET g_browser[g_tree_cnt].b_hasC = TRUE
      LET g_browser[g_tree_cnt].b_isExp = TRUE
      LET g_browser[g_tree_cnt].b_expcode = 2
      LET g_browser[g_tree_cnt].b_gzas001 = l_gzas001
      #161216-00018#1 mod-S
#      LET g_browser[g_tree_cnt].b_gzas002 = l_gzas001
      LET g_browser[g_tree_cnt].b_gzas002 = l_gzas002
      #161216-00018#1 mod-E
      CALL azzq670_desc_show(g_tree_cnt)
#      DISPLAY g_tree_cnt,':',g_browser[g_tree_cnt].*
      LET g_root_exc_sum = 0
      LET g_root_war_sum = 0
      LET l_tree_cnt_t = g_tree_cnt
      #161216-00018#1 mod-S
#      CALL azzq670_tree_fill2(0,l_gzas001,g_browser[g_tree_cnt].b_id ) 
      CALL azzq670_tree_fill2(0,l_gzas002,g_browser[g_tree_cnt].b_id ) 
      #161216-00018#1 mod-E
      LET g_browser[l_tree_cnt_t].b_exc_qty_1 = g_root_exc_sum
      LET g_browser[l_tree_cnt_t].b_war_qty_1 = g_root_war_sum
      #160802-00026#1 add-E
      CALL azzq670_detail_color_fill(g_root_exc_sum,g_root_war_sum,l_tree_cnt_t)    #150624-00008#102 add
#      CALL azzq670_tree_fill2(0,l_gzas001,l_cnt)
      LET g_tree_cnt = g_tree_cnt+1     #161216-00018#1 add
      LET l_cnt = l_cnt + 1
   END FOREACH
      #150624-00008#53 add-E
   DISPLAY ARRAY g_browser TO s_browse.* #ATTRIBUTE(COUNT=g_rec_b)
    
      BEFORE DISPLAY 
         EXIT DISPLAY
         
   END DISPLAY         
   
END FUNCTION

################################################################################
# Descriptions...: 逐个遍历树
# Memo...........:
# Usage..........: CALL azzq670_tree_fill2(p_gzas001,p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_tree_fill2(p_level,p_gzas001,p_pid)
DEFINE  p_gzas001     LIKE gzas_t.gzas001
DEFINE  p_ac          LIKE type_t.num5 
DEFINE  r_success     LIKE type_t.num5
DEFINE  l_i           LIKE type_t.num5
DEFINE  l_n           LIKE type_t.num5
DEFINE  l_sql         STRING
DEFINE  l_arr     DYNAMIC ARRAY OF RECORD
                          gzas002  LIKE gzas_t.gzas002
                  END RECORD
DEFINE l_pid    LIKE type_t.chr50
DEFINE p_level  LIKE type_t.num5
DEFINE p_pid    LIKE type_t.chr50
DEFINE l_cnt    LIKE type_t.num5
DEFINE sr    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #150624-00008#53 mod-S
#       #tree自定義欄位
#          b_gzas001 LIKE gzas_t.gzas001,
#   b_gzas001_desc LIKE type_t.chr80,
#      b_gzas002 LIKE gzas_t.gzas002,
#   b_gzas002_desc LIKE type_t.chr80
   #tree自定義欄位
          b_gzas001 LIKE gzas_t.gzas001,
   b_gzas001_desc LIKE type_t.chr80,
      b_gzas002 LIKE gzas_t.gzas002,
   b_gzas002_desc LIKE type_t.chr80,
   b_exc_qty_1 LIKE type_t.chr80,
   b_war_qty_1 LIKE type_t.chr80
       #150624-00008#53 mod-E
                   END RECORD
#160622-00009#2 add-S
DEFINE l_gzar003     LIKE gzar_t.gzar003
DEFINE l_gzar004     LIKE gzar_t.gzar004
DEFINE l_gzar005     LIKE gzar_t.gzar005
DEFINE l_exc         LIKE type_t.num10    #异常数
DEFINE l_war         LIKE type_t.num10    #警告数
DEFINE l_tree_cnt    LIKE type_t.num10
#160622-00009#2 add-E
   
   #150624-00008#53 mod-S
   LET l_sql = " SELECT DISTINCT '','','','TRUE','','','2',gzas001,'',gzas002,'','','',t1.gzasl004 ,t2.gzarl004 ", #160802-00026#1 mod
   #150624-00008#53 mod-E
               "   FROM gzas_t ",
               "   LEFT JOIN gzasl_t t1 ON t1.gzaslent='"||g_enterprise||"' AND t1.gzasl002=gzas001 AND t1.gzasl002='"||g_dlang||"' ",
#               "   LEFT JOIN gzasl_t t2 ON t2.gzaslent='"||g_enterprise||"' AND t2.gzasl001=gzas002 AND t2.gzasl002='"||g_dlang||"' ",
               " LEFT JOIN gzarl_t t2 ON t2.gzarlent='"||g_enterprise||"' AND t2.gzarl001=gzas002 AND t2.gzarl002='"||g_dlang||"' ",
               "  WHERE gzasent = ",g_enterprise,
               "    AND gzas001 = '", p_gzas001,"'",
               "    AND gzas002 <> gzas001",
               "  ORDER BY gzas001,gzas002"                   

   PREPARE azzq670_sel_gzas_pre FROM l_sql
   DECLARE azzq670_sel_gzas_cs CURSOR FOR azzq670_sel_gzas_pre
   LET l_cnt = 1
   FOREACH azzq670_sel_gzas_cs INTO sr[l_cnt].*,sr[l_cnt].b_gzas001_desc,sr[l_cnt].b_gzas002_desc 
      IF SQLCA.SQLcode  THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH gzas_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF     
          
      #上层节点给当前父节点
      LET sr[l_cnt].b_pid  = p_pid
        #id=本身節點id(採流水號遞增)
      LET sr[l_cnt].b_id   = p_pid||"."||l_cnt
      LET sr[l_cnt].b_exp = FALSE
      LET sr[l_cnt].b_expcode = 2 
       
      LET sr[l_cnt].b_hasC = azzq670_exp_chk(sr[l_cnt].b_gzas002)
      
      LET l_cnt = l_cnt + 1
   END FOREACH
   LET g_tree_cnt = g_browser.getLength()+1  #160622-00009#2 add
   LET g_exc_sum = 0                         #160622-00009#2 add
   LET g_war_sum = 0                         #160622-00009#2 add
         
   LET p_level = p_level + 1
    FOR l_i = 1 TO l_cnt - 1
         LET g_browser[g_tree_cnt].* = sr[l_i].*
         CALL azzq670_desc_show(g_tree_cnt)
         #160622-00009#2 add-S
         IF azzq670_chkpoint_chk(sr[l_i].b_gzas002) THEN
            #获取来源报表、异常条件、警告条件
            LET l_gzar003 = NULL
            LET l_gzar004 = NULL
            LET l_gzar005 = NULL
            LET l_exc = 0
            LET l_war = 0
            SELECT gzar003,gzar004,gzar005 INTO l_gzar003,l_gzar004,l_gzar005
              FROM gzar_t
             WHERE gzar001 = sr[l_i].b_gzas002
               AND gzarent = g_enterprise
            IF NOT cl_null(l_gzar003) AND NOT cl_null(l_gzar004) THEN
               #异常数获取
               LET l_exc = azzi310_01_get_record_number(l_gzar003,l_gzar004)
               IF cl_null(l_exc) THEN
                  LET l_exc = 0
               END IF
               LET g_gzas_d[g_tree_cnt].l_exc_qty = l_exc
               LET g_gzas2_d[g_tree_cnt].exc_qty = g_gzas_d[g_tree_cnt].l_exc_qty
               LET g_gzas2_d[g_tree_cnt].l_gzar003 = l_gzar003
               LET g_gzas2_d[g_tree_cnt].l_gzar004 = l_gzar004
               #150624-00008#53 add-S
               LET g_browser[g_tree_cnt].b_exc_qty_1 = l_exc
               #150624-00008#53 add-E
               LET g_exc_sum = g_exc_sum + l_exc
            END IF
            IF NOT cl_null(l_gzar003) AND NOT cl_null(l_gzar005) THEN
            #警告数获取
               LET l_war = azzi310_01_get_record_number(l_gzar003,l_gzar005)
               IF cl_null(l_war) THEN
                  LET l_war = 0
               END IF
               LET g_gzas_d[g_tree_cnt].l_war_qty = l_war
               LET g_war_sum = g_war_sum + l_war
               LET g_gzas2_d[g_tree_cnt].war_qty = g_gzas_d[g_tree_cnt].l_war_qty
               LET g_gzas2_d[g_tree_cnt].l_gzar003 = l_gzar003
               LET g_gzas2_d[g_tree_cnt].l_gzar005 = l_gzar005
               #150624-00008#53 add-S
               LET g_browser[g_tree_cnt].b_war_qty_1 = l_war
               #150624-00008#53 add-E
            END IF
         ELSE 
            LET g_gzas_d[g_tree_cnt].l_exc_qty = 0
            LET g_gzas_d[g_tree_cnt].l_war_qty = 0
            #150624-00008#53 add-S
            LET g_browser[g_tree_cnt].b_exc_qty_1 = 0
            LET g_browser[g_tree_cnt].b_war_qty_1 = 0
            #150624-00008#53 add-E
         END IF
         #161216-00018#1 add-S
         IF cl_null(g_browser[g_tree_cnt].b_exc_qty_1) THEN
            LET g_browser[g_tree_cnt].b_exc_qty_1 = 0
         END IF
         IF cl_null(g_browser[g_tree_cnt].b_war_qty_1) THEN
            LET g_browser[g_tree_cnt].b_war_qty_1 = 0
         END IF
         IF cl_null(g_gzas_d[g_tree_cnt].l_exc_qty) THEN
            LET g_gzas_d[g_tree_cnt].l_exc_qty = 0
         END IF
         IF cl_null(g_gzas_d[g_tree_cnt].l_war_qty) THEN
            LET g_gzas_d[g_tree_cnt].l_war_qty = 0
         END IF
         LET g_root_exc_sum = g_root_exc_sum + g_browser[g_tree_cnt].b_exc_qty_1
         LET g_root_war_sum = g_root_war_sum + g_browser[g_tree_cnt].b_war_qty_1
         #161216-00018#1 add-E
         #160622-00009#2 add-E
         CALL azzq670_detail_color_fill(g_browser[g_tree_cnt].b_exc_qty_1,g_browser[g_tree_cnt].b_war_qty_1,g_tree_cnt)   #150624-00008#102 add
         IF azzq670_exp_chk(sr[l_i].b_gzas002) THEN
            LET g_browser[g_tree_cnt].b_isExp = NULL
            LET g_browser[g_tree_cnt].b_exp = TRUE
            LET l_tree_cnt = g_tree_cnt                  #160622-00009#2 add
            LET g_tree_cnt = g_tree_cnt + 1  
            CALL azzq670_tree_fill2(p_level,sr[l_i].b_gzas002,sr[l_i].b_id)
            LET g_gzas_d[l_tree_cnt].l_exc_qty = g_exc_sum #160622-00009#2 add
            LET g_gzas_d[l_tree_cnt].l_war_qty = g_war_sum #160622-00009#2 add
            #150624-00008#53 add-S
            LET g_browser[l_tree_cnt].b_exc_qty_1 = g_exc_sum
            LET g_browser[l_tree_cnt].b_war_qty_1 = g_war_sum
#            LET g_browser[g_tree_cnt].* = sr[l_i].*
            #150624-00008#53 add-E
            CALL azzq670_detail_color_fill(g_exc_sum,g_war_sum,l_tree_cnt)    #150624-00008#102 add
            #161216-00018#1 marked-S
            #160802-00026#1 add-S
#            LET g_root_exc_sum = g_root_exc_sum + g_exc_sum
#            LET g_root_war_sum = g_root_war_sum + g_war_sum
            #160802-00026#1 add-E
            #161216-00018#1 marked-E
         END IF
#         DISPLAY g_tree_cnt,':',g_browser[g_tree_cnt].*
         LET g_tree_cnt = g_tree_cnt + 1
     END FOR
    LET g_tree_cnt = g_browser.getLength()
    DISPLAY g_tree_cnt TO FORMONLY.b_count

   
END FUNCTION

PRIVATE FUNCTION azzq670_exp_chk(p_gzas002)
DEFINE p_gzas002 LIKE gzas_t.gzas002
DEFINE l_n  LIKE type_t.num5
   IF cl_null(p_gzas002) THEN
      RETURN FALSE
   END IF
   LET g_sql = "SELECT COUNT(*) FROM gzas_t ",
               " WHERE gzasent = '" ||g_enterprise|| "'",
               "   AND gzas001 <> gzas002 ",
               "   AND gzas001 = ? "
   LET l_n = 0
   PREPARE  azzq670_master_chk2 FROM g_sql
   EXECUTE  azzq670_master_chk2 USING p_gzas002 INTO l_n
   FREE  azzq670_master_chk2
   IF l_n > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 检核是否为检核点
# Memo...........:
# Usage..........: CALL azzq670_chkpoint_chk(p_gzas002)
#                  RETURNING r_success
# Date & Author..: 2016-6-28 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq670_chkpoint_chk(p_gzas002)
DEFINE p_gzas002  LIKE gzas_t.gzas002
DEFINE r_success  LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_gzas002) THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM gzas_t
       WHERE gzas002 = p_gzas002
         AND gzasent = g_enterprise
         AND gzas004 = '1'
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 单身颜色充填
# Memo...........: 根据异常数、警告数显示颜色：
#                  异常数、警告数都是0显示黑色，
#                  异常数、警告数都<=10显示黄色，
#                  异常数或警告数任一个>10,显示红色
# Memo...........: #150624-00008#102
################################################################################
PRIVATE FUNCTION azzq670_detail_color_fill(p_exc,p_war,p_ac)
DEFINE p_exc      LIKE type_t.num10
DEFINE p_war      LIKE type_t.num10
DEFINE p_ac       LIKE type_t.num10
DEFINE l_color    STRING

   IF cl_null(p_exc) THEN
      LET p_exc = 0
   END IF
   IF cl_null(p_war) THEN
      LET p_war = 0
   END IF
   IF p_exc = 0 AND p_war = 0 THEN
      LET l_color = 'black'
   ELSE
      IF p_exc <= 10 AND p_war <=10 THEN
         LET l_color = 'yellow'
      ELSE
         LET l_color = 'red'
      END IF
   END IF
   LET g_browser_color[p_ac].b_show = l_color
   LET g_browser_color[p_ac].b_pid = l_color           
   LET g_browser_color[p_ac].b_id = l_color
   LET g_browser_color[p_ac].b_exp = l_color
   LET g_browser_color[p_ac].b_hasC = l_color
   LET g_browser_color[p_ac].b_isExp = l_color
   LET g_browser_color[p_ac].b_expcode = l_color
   LET g_browser_color[p_ac].b_gzas001 = l_color
   LET g_browser_color[p_ac].b_gzas001_desc = l_color
   LET g_browser_color[p_ac].b_gzas002 = l_color
   LET g_browser_color[p_ac].b_gzas002_desc = l_color
   LET g_browser_color[p_ac].b_exc_qty_1 = l_color
   LET g_browser_color[p_ac].b_war_qty_1 = l_color
END FUNCTION

 
{</section>}
 
