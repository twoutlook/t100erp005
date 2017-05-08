#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi970.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-03-11 16:47:36), PR版次:0002(2015-03-17 14:52:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000093
#+ Filename...: azzi970
#+ Description: WEB版程式查看工具
#+ Creator....: 00845(2015-02-06 15:49:25)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi970.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_gzza_d        DYNAMIC ARRAY OF RECORD
         l_lineno      LIKE type_t.num5,
         l_code        STRING
                       END RECORD
DEFINE g_detail_idx    LIKE type_t.num5
DEFINE g_temp_idx      LIKE type_t.num5
DEFINE g_detail_cnt    LIKE type_t.num5
DEFINE g_wc2           STRING
DEFINE l_ac            LIKE type_t.num5
DEFINE g_cnt           LIKE type_t.num5
DEFINE g_sql           STRING
DEFINE g_error_show    LIKE type_t.num5
DEFINE g_forupd_sql    STRING
DEFINE gwin_curr       ui.Window                     #Current Window
DEFINE gfrm_curr       ui.Form                       #Current Form
DEFINE g_curr_diag     ui.Dialog                     #Current Dialog
#開窗畫面顯示欄位 type 宣告
 TYPE type_gr_qry RECORD
         check   LIKE type_t.chr1,
                 gzza001_1   LIKE gzza_t.gzza001, 
         gzzal003_2   LIKE gzzal_t.gzzal003, 
         gzza003_3   LIKE gzza_t.gzza003
       END RECORD
 
#@查詢資料的暫存器.
DEFINE gr_qry            DYNAMIC ARRAY OF type_gr_qry  
DEFINE gr_qry_sel        DYNAMIC ARRAY OF type_gr_qry  #多選時記錄已勾選的資料
 
DEFINE gi_multi_sel      LIKE type_t.num5   #是否需要複選資料(TRUE/FALSE)
DEFINE gi_need_cons      LIKE type_t.num5   #是否需要CONSTRUCT(TRUE/FALSE)
DEFINE gi_cons_where     STRING                #暫存CONSTRUCT區塊的WHERE條件
DEFINE gi_cons_where_old STRING                #暫存CONSTRUCT區塊的WHERE條件(舊的,用來比對條件是否改變)
 
DEFINE gs_default1       STRING 
DEFINE gs_default2       STRING 

DEFINE gi_page_count     LIKE type_t.num10  #每頁顯現資料筆數
DEFINE gs_pageswitch     STRING                #選擇的頁面
DEFINE gs_action         STRING
DEFINE gi_reconstruct    LIKE type_t.num5   #重新查詢
DEFINE g_pagestart       LIKE type_t.num5
DEFINE g_data_cnt        LIKE type_t.num5
DEFINE g_page_idx        LIKE type_t.num5   #目前所在頁數
DEFINE g_page_last       LIKE type_t.num5   #最後一頁
DEFINE g_sel_limit       LIKE type_t.num5   #選擇筆數的上限

DEFINE g_gzza001         LIKE gzza_t.gzza001
DEFINE g_gzza001_desc    LIKE gzzal_t.gzzal003

DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_gzwv_d      DYNAMIC ARRAY OF RECORD
  g_gzwv001   LIKE gzwv_t.gzwv001,
  g_gzwv003   LIKE gzwv_t.gzwv003,
  g_gzwv004   LIKE gzwv_t.gzwv004
       END RECORD
#DEFINE gwin_curr         ui.Window  
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzi970.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"

   LET g_forupd_sql = "SELECT gzza001 FROM gzza_t WHERE gzza001=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzi970_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi970 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzi970_init()
 
      #進入選單 Menu (='N')
      CALL azzi970_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzi970
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzi970.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzi970_init()
   #add-point:init段define

   #end add-point
   #add-point:init段define

   #end add-point



   LET g_error_show = 1

   #add-point:畫面資料初始化

   #end add-point

   CALL azzi970_default_search()

END FUNCTION

PRIVATE FUNCTION azzi970_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   DEFINE llst_items    om.NodeList
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE lnode_win,lnode_item,lnode_child,lnode_att    om.DomNode 
   #end add-point
   #add-point:ui_dialog段define

   #end add-point

   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent() #Current Window 
   LET gfrm_curr = gwin_curr.getForm()    #ui.Form Current Form 

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1

   #add-point:ui_dialog段before dialog
   LET lnode_win = ui.Interface.getRootNode() #user interface tree
   LET llst_items = lnode_win.selectByTagName("StyleList") 
   IF llst_items IS NOT NULL THEN 
      FOR li_cnt = 1 TO llst_items.getLength()
          LET lnode_item = llst_items.item(li_cnt)
          LET lnode_child = lnode_item.createChild("Style")
          CALL lnode_child.setAttribute("name", "Table.code")
          LET lnode_att = lnode_child.createChild("StyleAttribute")
          CALL lnode_att.setAttribute("name", "fontFamily")
          CALL lnode_att.setAttribute("value", "Courier New,明細體")
          EXIT FOR
      END FOR
   END IF
   #end add-point

   WHILE TRUE

      CALL azzi970_b_fill(g_wc2)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzza_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               #add-point:ui_dialog段before display

               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2

               #end add-point

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()
               CALL cl_user_overview_set_follow_pic()
         END DISPLAY

         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)

            #add-point:ui_dialog段before

            #end add-point
            NEXT FIELD CURRENT

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               #add-point:ON ACTION output

               #END add-point

            END IF

         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi970_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)
               CALL g_curr_diag.setCurrentRow("s_detail1",1)

            END IF

         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzza_d)
               LET g_export_id[1]   = "s_detail1"

               #add-point:ON ACTION exporttoexcel

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
            
         ON ACTION show_instruction 
            CALL azzi970_instruction_analytics(g_gzza_d[l_ac].l_code)
            IF g_gzwv_d.getLength() > 0 THEN 
               CALL azzi970_open_win_instruction()  
            END IF 
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前

         #end add-point
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION azzi970_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   DEFINE li_cnt LIKE type_t.num5
   DEFINE ls_path STRING 
   #add-point:query段define

   #end add-point
   #add-point:query段define

   #end add-point

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzza_d.clear()
   LET g_detail_cnt = 0
   LET g_qryparam.state = "c"

   #wc備份
   LET ls_wc = g_wc2

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc2 ON gzza001 FROM gzza001

         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzza001
            #add-point:ON ACTION controlp INFIELD gzza001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL azzi970_sub_open_win()
            DISPLAY g_qryparam.return1 TO gzza001  #顯示到畫面上
            LET g_gzza001 = g_qryparam.return1
            NEXT FIELD gzza001 
      END CONSTRUCT


      BEFORE DIALOG
         CALL cl_qbe_init()

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
      LET g_wc2 = ls_wc
      RETURN 
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
   
   #DISPLAY "g_wc2:",g_wc2
   IF g_wc2  = " 1=1" THEN
      LET g_gzza001 = "azzi900" 
      DISPLAY g_gzza001 TO gzza001
      LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("AZZ"),"4gl"),"azzi900.4gl")
      
   ELSE 
      #IF cl_null(g_qryparam.return1) AND cl_null(g_qryparam.return2) THEN 
      CALL azzi970_module_name(g_wc2) 
      #END IF  
      LET ls_path = os.Path.join(os.Path.join(FGL_GETENV(g_qryparam.return2),"4gl"),g_qryparam.return1 || ".4gl")
      LET g_gzza001 = g_qryparam.return1 
   END IF 
   

   CALL azzi970_b_fill(ls_path)
   #DISPLAY "g_detail_cnt:",g_detail_cnt

   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CLEAR FORM
      CALL g_gzza_d.clear()
      LET g_detail_cnt = 0
   END IF

   LET INT_FLAG = FALSE
   LET g_qryparam.return1 = ""
   LET g_qryparam.return2 = ""
   CALL azzi970_show()

END FUNCTION

PRIVATE FUNCTION azzi970_b_fill(p_wc2)
   #BODY FILL UP
   DEFINE p_wc2         STRING
   DEFINE ls_path       STRING
   DEFINE l_channel     base.Channel
   DEFINE ls_readline   STRING
   DEFINE li_cnt        LIKE type_t.num5
   
   CALL g_gzza_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1
   LET g_error_show = 0
   LET ls_path = p_wc2
   #DISPLAY "ls_path:",ls_path

   IF NOT os.Path.exists(ls_path) THEN 
      RETURN 
   END IF 

   #讀取檔案
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(ls_path,"r")

   WHILE TRUE
      IF l_channel.isEof() THEN
         EXIT WHILE
      END IF

      LET ls_readline = l_channel.readLine()
      LET g_gzza_d[l_ac].l_code = ls_readline
      LET g_gzza_d[l_ac].l_lineno = l_ac
      LET l_ac = l_ac + 1
   END WHILE

   CALL l_channel.close()

   IF g_cnt > g_gzza_d.getLength() THEN
      LET l_ac = g_gzza_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac

   LET g_detail_cnt = g_gzza_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt

END FUNCTION

PRIVATE FUNCTION azzi970_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING

   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzza001 = '", g_argv[01], "' AND "
   END IF

   #add-point:default_search段after sql

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

   #add-point:default_search段結束前

   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi970_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define

   #end add-point
   #add-point:modify_detail_chk段define

   #end add-point

   #add-point:modify_detail_chk段開始前

   #end add-point

   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1"
         LET ls_return = "gzza001"

      #add-point:modify_detail_chk段自訂page控制

      #end add-point
   END CASE

   #add-point:modify_detail_chk段結束前

   #end add-point

   RETURN ls_return

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi970_sub_open_win()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_open_win()
   DEFINE pi_multi_sel   LIKE type_t.num5
   DEFINE pi_need_cons   LIKE type_t.num5
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING
 
   #WHENEVER ERROR CALL cl_err_msg_log
 
   #畫面
   OPEN WINDOW w_azzi970_s01 WITH FORM cl_ap_formpath("azz","azzi970_s01")
      ATTRIBUTE(STYLE="openwin")
   #CALL cl_ui_locale("azzi970_s01")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_openwin.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
 
   IF g_qryparam.state = 'i' THEN
      LET gi_multi_sel = FALSE
   ELSE
      LET gi_multi_sel = TRUE
   END IF 
   LET gi_need_cons = g_qryparam.reqry
   LET gs_default1 = g_qryparam.default1 
   LET gs_default2 = g_qryparam.default2 

 
   CALL azzi970_sub_init()
   CALL azzi970_sub_sel()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF 
 
   CLOSE WINDOW w_azzi970_s01
 
END FUNCTION

################################################################################
# Descriptions...: 初始化
# Memo...........:
# Usage..........: CALL azzi970_sub_init()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_init()
   DEFINE l_qry_text LIKE dzcal_t.dzcal003
   DEFINE l_qry_id   LIKE dzca_t.dzca001
   DEFINE l_text     STRING
 
   IF NOT (gi_multi_sel) THEN
      CALL cl_set_comp_visible("check", FALSE)
      CALL cl_set_toolbaritem_visible("selectall, selectnone, selectpageall, selectpagenone", FALSE)
   END IF
 
#   IF (gi_multi_sel) THEN
#      #lib尚未修正
#      #CALL cl_set_comp_font_color("oea01", "red")
#   END IF
 
   LET INT_FLAG = FALSE         #避免被其他函式影響
   LET g_page_idx = 0
   LET g_page_last = 0
   LET g_sel_limit = azzi970_sub_get_sel_limit()     #選擇筆數的上限
   LET gi_page_count = azzi970_sub_get_page_count()  #每頁顯現資料筆數
   LET gi_cons_where = " 1=1"   #預設查詢全部資料
   LET gi_cons_where_old = NULL
   LET gi_reconstruct = FALSE
   INITIALIZE gs_pageswitch TO NULL
   INITIALIZE gs_action TO NULL
   INITIALIZE g_qryparam.return1 TO NULL  
   INITIALIZE g_qryparam.return2 TO NULL  

   CALL gr_qry.clear()
   CALL gr_qry_sel.clear()
 
END FUNCTION

################################################################################
# Descriptions...: 取得每頁顯現資料筆數
# Memo...........:
# Usage..........: CALL azzi970_sub_get_page_count()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_get_page_count()
   DEFINE l_sel_limit  LIKE type_t.num5
   DEFINE l_ooaa002    LIKE ooaa_t.ooaa002
   DEFINE l_default    LIKE type_t.num5
 
   LET l_default = 10 #設定預設值
 
   #取值優先權: ds.dzca_t>dsdemo.ooaa_t
   
   #從ds.dzca_t提取開窗每頁顯現資料筆數
   SELECT dzca004 INTO l_ooaa002 FROM dzca_t
    WHERE dzca001 = "azzi970_s01"
 
   IF l_ooaa002 <10 OR cl_null(l_ooaa002) THEN
      #提取開窗每頁顯現資料筆數
      LET l_ooaa002 = cl_get_para(g_enterprise,g_site,"E-SYS-0002")
      IF l_ooaa002 <10 OR cl_null(l_ooaa002) THEN
         LET l_sel_limit = l_default
      ELSE
         LET l_sel_limit = l_ooaa002
      END IF
 
   ELSE
      LET l_sel_limit = l_ooaa002
   END IF
 
   RETURN l_sel_limit
END FUNCTION

################################################################################
# Descriptions...: 取得選擇筆數的上限
# Memo...........:
# Usage..........: CALL azzi970_sub_get_sel_limit()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_get_sel_limit()
   DEFINE l_sel_limit  LIKE type_t.num5
   DEFINE l_ooaa002    LIKE ooaa_t.ooaa002
   DEFINE l_default    LIKE type_t.num5
 
   LET l_default = 200 #設定預設值
 
   #從資料庫提取開窗選擇筆數資料上限
   LET l_ooaa002 = cl_get_para(g_enterprise,g_site,"E-SYS-0003")
   IF l_ooaa002 <200 OR cl_null(l_ooaa002) THEN
      LET l_sel_limit = l_default
   ELSE
      LET l_sel_limit = l_ooaa002
   END IF
 
   RETURN l_sel_limit
END FUNCTION

################################################################################
# Descriptions...: 畫面顯現與資料的選擇.
# Memo...........:
# Usage..........: CALL azzi970_sub_sel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_sel()
    WHILE TRUE
      CALL azzi970_sub_prep_result_set()
 
      IF (gi_multi_sel) THEN
         CALL azzi970_sub_input_array()
      ELSE
         CALL azzi970_sub_display_array()
      END IF
 
      IF gs_action = "exit" THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 準備查詢畫面的資料集
# Memo...........:
# Usage..........: CALL azzi970_sub_prep_result_set()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_prep_result_set()
   CALL gr_qry.clear()
   CALL gr_qry_sel.clear()
 
   IF (gi_need_cons) OR (gi_reconstruct) THEN
 
      #避免使用預先查詢時,按重新整理的時候,進入CONSTRUCT段
      LET gi_need_cons = FALSE
 
      LET gi_reconstruct = FALSE
      LET gi_cons_where_old = NULL
      DISPLAY "" TO formonly.index
      CONSTRUCT gi_cons_where ON gzza001 #, gzzal003, gzza003 
         FROM s_qry[1].gzza001 #, s_qry[1].gzzal003, s_qry[1].gzza003 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         LET gi_cons_where = " 1=1"
      END IF
   END IF

   #INT_FLAG = 0
   #gs_pageswitch = (null)

   IF cl_null(gs_pageswitch) THEN
      LET gs_pageswitch = "first"
   END IF
   CALL azzi970_sub_pagedata_fill(gs_pageswitch)
   INITIALIZE gs_pageswitch TO NULL
END FUNCTION

################################################################################
# Descriptions...: 描採用INPUT ARRAY的方式來顯現查詢過後的資料.
# Memo...........:
# Usage..........: CALL azzi970_sub_input_array()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_input_array()
   DEFINE li_ac     LIKE type_t.num5
   DEFINE ldig_curr ui.Dialog
   DEFINE l_msg     STRING           
   DEFINE l_chk     LIKE type_t.num5 
 
   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###
 
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT ARRAY gr_qry FROM s_qry.*
         ATTRIBUTES(COUNT=g_data_cnt, 
                    APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE) 
         
         BEFORE INPUT
            CALL azzi970_sub_set_pagebutton(ldig_curr) 
            
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_qry") 
            
         ON CHANGE check   #改變勾選狀態
            CALL azzi970_sub_qry_check("", gr_qry[li_ac].check, li_ac, li_ac)
      END INPUT
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
 
      ON ACTION accept
         CALL azzi970_sub_get_multiret()
         LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION cancel
         LET g_qryparam.return1 = NULL
         
         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION pg_first
         CALL azzi970_sub_pagedata_fill("first")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_prev
         CALL azzi970_sub_pagedata_fill("prev")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_next
         CALL azzi970_sub_pagedata_fill("next")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_last
         CALL azzi970_sub_pagedata_fill("last")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      #重新整理
      ON ACTION refresh
         CALL azzi970_sub_pagedata_fill("first")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         EXIT DIALOG
         
      #重新查詢
      ON ACTION reconstruct
         LET gi_reconstruct = TRUE
         CALL gr_qry.clear()
         CALL gr_qry_sel.clear()
         CALL azzi970_sub_data_count("0")    #總筆數
         EXIT DIALOG
         
      #全部選取
      ON ACTION selectall
         # 連未選擇的頁面都必須選擇
         CALL azzi970_sub_qry_check("selectall", "Y", 1, gr_qry.getLength()) 
         
      #全部取消選取
      ON ACTION selectnone
         CALL azzi970_sub_qry_check("selectnone", "N", 1, gr_qry.getLength()) 
         
      #此頁全選
      ON ACTION selectpageall
         CALL azzi970_sub_qry_check("selectpageall", "Y", 1, gr_qry.getLength()) 
         
      #此頁取消選取
      ON ACTION selectpagenone
         CALL azzi970_sub_qry_check("selectpagenone", "N", 1, gr_qry.getLength()) 
         
      ON ACTION exporttoexcel
         MESSAGE ""
 
      #開窗程式串查沒有設定
 
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 採用DISPLAY ARRAY的方式來顯現查詢過後的資料.
# Memo...........:
# Usage..........: CALL azzi970_sub_display_array()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_display_array()
    DEFINE li_ac       LIKE type_t.num5
   DEFINE ldig_curr   ui.Dialog
   DEFINE l_msg       STRING           
   DEFINE l_chk       LIKE type_t.num5 
 
   #動態設定comboBox項目
   ### 此開窗無comboBox的欄位 ###
   
   DIALOG ATTRIBUTES(UNBUFFERED)
      DISPLAY ARRAY gr_qry TO s_qry.*
         ATTRIBUTES(COUNT=g_data_cnt)
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_qry")
      END DISPLAY
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
         CALL azzi970_sub_set_pagebutton(ldig_curr)
 
      ON ACTION accept
         IF li_ac > 0 THEN
            LET g_qryparam.return1 = gr_qry[li_ac].gzza001_1 
            LET g_qryparam.return2 = gr_qry[li_ac].gzza003_3 
          
         ELSE
            LET g_qryparam.return1 = gs_default1 
            LET g_qryparam.return2 = gs_default2 

         END IF
         LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION CANCEL
            LET g_qryparam.return1 = gs_default1 
            LET g_qryparam.return2 = gs_default2 

 
         LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
      ON ACTION pg_first
         CALL azzi970_sub_pagedata_fill("first")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_prev
         CALL azzi970_sub_pagedata_fill("prev")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_next
         CALL azzi970_sub_pagedata_fill("next")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION pg_last
         CALL azzi970_sub_pagedata_fill("last")
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         NEXT FIELD CURRENT
         
      ON ACTION refresh       #重新整理
         CALL azzi970_sub_pagedata_fill("first") 
         CALL azzi970_sub_set_pagebutton(ldig_curr)
         EXIT DIALOG
         
      ON ACTION reconstruct   #重新查詢 
         LET gi_reconstruct = TRUE
         CALL gr_qry.clear()
         CALL azzi970_sub_data_count("0")    #總筆數
         EXIT DIALOG
         
      ON ACTION exporttoexcel
         MESSAGE ""
 
      #開窗程式串查沒有設定
 
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 準備查詢畫面的資料集.
# Memo...........:
# Usage..........: CALL azzi970_sub_pagedata_fill(ps_page_action)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_pagedata_fill(ps_page_action)
   DEFINE ps_page_action STRING
   DEFINE ls_sql         STRING
   DEFINE ls_where       STRING
   DEFINE ls_where2      STRING
   DEFINE li_i           LIKE type_t.num10
   DEFINE li_j           LIKE type_t.num10
   DEFINE l_datarange    STRING   #第m-n筆
   DEFINE l_str          STRING   #字串
   DEFINE l_str1         STRING
   DEFINE l_str2         STRING
 
   CASE ps_page_action
      WHEN "first"
         LET g_page_idx = 1
      WHEN "prev"
         LET g_page_idx = g_page_idx - 1
      WHEN "next"
         LET g_page_idx = g_page_idx + 1
      WHEN "last"
         LET g_page_idx = g_page_last
   END CASE
 
   IF g_page_idx > 0 THEN
      LET g_pagestart = (g_page_idx - 1) * gi_page_count + 1
   END IF
 
   CALL azzi970_sub_sqlwhere() RETURNING ls_where,ls_where2
   #全部選取 
   LET ls_sql =" SELECT 'N', gzza001, gzzal003, gzza003, RANK ",
               "   FROM (SELECT gzza001, gzzal003,gzza003,RANK() OVER(ORDER BY gzza001, gzzal003, gzza003) AS RANK ",
               "          FROM (SELECT DISTINCT 'Y', gzza001 gzza001, gzzal003, gzza003 ",
               "                 FROM gzza_t ",
               "                  LEFT OUTER JOIN gzzal_t ",
               "                   ON gzza001 = gzzal001 ",
               "                    AND gzzal002 = '",g_dlang,"'",
               "                   WHERE gzzastus = 'Y' ",
               "                     AND ", ls_where CLIPPED,  
               "                 UNION ",
               "                 SELECT DISTINCT 'Y', gzde001 gzza001, gzdel003, gzde002 ",
               "                  FROM gzde_t ",
               "                   LEFT OUTER JOIN gzdel_t ",
               "                    ON gzde001 = gzdel001 ",
               "                     AND gzdel002 = '",g_dlang,"'" ,
               "                   WHERE gzdestus = 'Y' ",
               "                     AND ", ls_where2 CLIPPED,
               "                 ) Tbl1",
               "        ORDER BY Tbl1.gzza001) " 

-------------------------------------------------------------------------------------------------
   DECLARE lcurs_qry_all CURSOR FROM ls_sql

   #此頁
   #@如果不需要複選資料,則不要設定check的預設值(將'N'刪除)
-----------------------------------------------------------------------------------------------------
    LET ls_sql =" SELECT 'N', gzza001, gzzal003, gzza003, RANK ",
               "   FROM (SELECT gzza001, gzzal003,gzza003,RANK() OVER(ORDER BY gzza001, gzzal003, gzza003) AS RANK ",
               "          FROM (SELECT DISTINCT 'Y', gzza001 gzza001, gzzal003, gzza003 ",
               "                 FROM gzza_t ",
               "                  LEFT OUTER JOIN gzzal_t ",
               "                   ON gzza001 = gzzal001 ",
               "                    AND gzzal002 = '",g_dlang,"'",
               "                   WHERE gzzastus = 'Y' ",
               "                     AND ", ls_where CLIPPED,  
               "                 UNION ",
               "                 SELECT DISTINCT 'Y', gzde001 gzza001, gzdel003, gzde002 ",
               "                  FROM gzde_t ",
               "                   LEFT OUTER JOIN gzdel_t ",
               "                    ON gzde001 = gzdel001 ",
               "                     AND gzdel002 = '",g_dlang,"'" ,
               "                   WHERE gzdestus = 'Y' ",
               "                     AND ", ls_where2 CLIPPED,
               "                 ) Tbl1",
               "        ORDER BY Tbl1.gzza001) " ,
               "    WHERE RANK >= ", g_pagestart," AND RANK < ", g_pagestart + gi_page_count 
 
   DECLARE lcurs_qry CURSOR FROM ls_sql

   CALL gr_qry.clear()
 
   LET li_i = 1
   FOREACH lcurs_qry INTO gr_qry[li_i].*
      LET l_str1 = gr_qry[li_i].gzza001_1, gr_qry[li_i].gzzal003_2, gr_qry[li_i].gzza003_3
      FOR li_j = 1 TO gr_qry_sel.getLength()
         LET l_str2 = gr_qry_sel[li_j].gzza001_1, gr_qry_sel[li_j].gzzal003_2, gr_qry_sel[li_j].gzza003_3
         IF l_str1 = l_str2 THEN
            LET gr_qry[li_i].check = gr_qry_sel[li_j].check
         END IF
      END FOR
      LET li_i = li_i + 1
   END FOREACH
   CALL gr_qry.deleteElement(li_i)
 
   IF gi_cons_where <> gi_cons_where_old OR cl_null(gi_cons_where) OR cl_null(gi_cons_where_old) THEN   #查詢條件改變
      LET gi_cons_where_old = gi_cons_where
      #CALL azzi970_sub_data_count("db")  #查詢資料的總筆數,給下一段計算第m-n筆
   END IF
 
   CALL azzi970_sub_data_count("db") #查詢資料的總筆數,給下一段計算第m-n筆
 
   #第m-n筆
   IF g_page_idx > 0 THEN
      LET li_i = g_data_cnt MOD gi_page_count
      #現在在最後一頁，而且不是滿頁的狀況
      IF g_page_idx = g_page_last AND li_i > 0 THEN
         LET l_str = g_pagestart - 1 + li_i
      ELSE
         LET l_str = g_pagestart - 1 + gi_page_count
      END IF
      LET l_datarange = g_pagestart
      LET l_datarange = l_datarange CLIPPED, " - ", l_str
   ELSE
      LET l_datarange = ""
   END IF
   DISPLAY l_datarange TO formonly.index
 
END FUNCTION

################################################################################
# Descriptions...: 查詢資料的總筆數
# Memo...........:
# Usage..........: CALL azzi970_sub_data_count(p_data_cnt)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_data_count(p_data_cnt)
   DEFINE p_data_cnt  STRING     #總筆數計算方式 "db":資料庫中的資料/非"db"則以此值為總筆數
   DEFINE ls_sql      STRING
   DEFINE ls_where    STRING
   DEFINE ls_where2   STRING 
   DEFINE ls_sql_1    STRING
 
   IF p_data_cnt = "db" THEN
      CALL azzi970_sub_sqlwhere() RETURNING ls_where,ls_where2
      LET ls_sql = " SELECT COUNT(1) FROM (", "SELECT DISTINCT 'Y', gzza001, gzzal003, gzza003 ",
                   "  FROM gzza_t LEFT OUTER JOIN gzzal_t ON gzza001 = gzzal001 AND gzzal002 = '",g_dlang,"'", 
                   "    WHERE  gzzastus = 'Y'  AND ", ls_where CLIPPED ,
                   " UNION ",
                   " SELECT DISTINCT 'Y', gzde001, gzdel003, gzde002 ",
                   " FROM gzde_t LEFT OUTER JOIN gzdel_t ON gzde001 = gzdel001 AND gzdel002 = '",g_dlang,"'", 
                   "  WHERE gzdestus = 'Y' AND ", ls_where2 CLIPPED ,")"
  
      #DISPLAY "[sql for ls_sql] = ",ls_sql
      #DISPLAY "[sql for azzi970_sub] = ",ls_sql_1
      
      #DISPLAY "########################################################################"
      #DISPLAY "[sql for azzi970_sub] = ",ls_sql_1
      #DISPLAY "########################################################################"
      #CALL azzi970_sub_sql_verify(ls_sql_1)
      PREPARE qry_count FROM ls_sql
      EXECUTE qry_count INTO g_data_cnt
   ELSE
      LET g_data_cnt = p_data_cnt
   END IF
 
   IF g_data_cnt > 0 THEN
      IF g_data_cnt MOD gi_page_count = 0 THEN
         LET g_page_last = g_data_cnt / gi_page_count   #總筆數 / 每頁顯現資料筆數
      ELSE
         LET g_page_last = g_data_cnt / gi_page_count + 1
      END IF
   ELSE
      LET g_page_last = 0
   END IF
 
   DISPLAY g_data_cnt TO formonly.count    #顯示總筆數
END FUNCTION

################################################################################
# Descriptions...: 進行SQL驗證
# Memo...........:
# Usage..........: CALL azzi970_sub_sql_verify(p_sql)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_sql_verify(p_sql)
   DEFINE p_sql      STRING
   DEFINE l_sql      STRING
   DEFINE l_sql_msg  STRING
   
   TRY
      LET l_sql = "SELECT COUNT(1) FROM (",p_sql,")"
       
      #實際進行驗證
      EXECUTE IMMEDIATE l_sql
 
      MESSAGE 'Verify OK!' 
   CATCH
      DISPLAY ":SQLCA.SQLCODE=",SQLCA.SQLCODE,SQLERRMESSAGE
      LET l_sql_msg = ":SQLCA.SQLCODE=",SQLCA.SQLCODE,ASCII 10," \ sql = ",l_sql,ASCII 10," \ SQLERRMESSAGE=",SQLERRMESSAGE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = l_sql_msg 
      LET g_errparam.code   =  "adz-00024" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END TRY 
END FUNCTION

################################################################################
# Descriptions...: 組SQL的where條件
# Memo...........:
# Usage..........: CALL azzi970_sub_sqlwhere()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_sqlwhere()
   DEFINE ls_where2  STRING
   DEFINE ls_where   STRING

   IF gi_cons_where = " 1=1" THEN 
      LET ls_where = gi_cons_where
      LET ls_where2 = gi_cons_where
   ELSE 
      CALL azzi970_change_sql_where(gi_cons_where) RETURNING ls_where,ls_where2
   END IF 

   #LET ls_where = gi_cons_where CLIPPED   #gi_cons_where 螢幕抓取的where 條件
 
   #在input段開窗的時候自動加入<inwc></inwc>之間的where條件 cch_20130605
   IF  g_qryparam.state = "i" THEN
      LET ls_where = ls_where," ",""
   END IF
   
   #entprise - Start -
    
   #entprise -  End  -
   IF NOT cl_null(g_qryparam.where) THEN
      LET ls_where = ls_where, " AND ", g_qryparam.where CLIPPED   # g_qryparam.where查詢資料的條件
   END IF
   RETURN ls_where,ls_where2
   #RETURN ls_where
END FUNCTION

################################################################################
# Descriptions...: 設定上下頁按鈕狀態
# Memo...........:
# Usage..........: CALL azzi970_sub_set_pagebutton(pdig_curr)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_set_pagebutton(pdig_curr)
   DEFINE pdig_curr ui.Dialog
 
   CALL pdig_curr.setActionActive("pg_first", 0)
   CALL pdig_curr.setActionActive("pg_prev", 0)
   CALL pdig_curr.setActionActive("pg_next", 0)
   CALL pdig_curr.setActionActive("pg_last", 0)
 
   IF g_page_idx > 1 THEN
      CALL pdig_curr.setActionActive("pg_first", 1)
      CALL pdig_curr.setActionActive("pg_prev", 1)
   END IF
 
   IF g_page_idx < g_page_last THEN
      CALL pdig_curr.setActionActive("pg_next", 1)
      CALL pdig_curr.setActionActive("pg_last", 1)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 組合多選資料
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
PRIVATE FUNCTION azzi970_sub_get_multiret()
   DEFINE li_i   LIKE type_t.num10
 
   IF g_qryparam.state = "c" THEN
      LET g_qryparam.return1 = ""
      FOR li_i = 1 TO gr_qry_sel.getLength()
         IF gr_qry_sel[li_i].check = "Y" THEN
            #@因為複選資料(display array)只能回傳一個欄位的組合字串.這裡不處理多欄位的回傳,以序號最小的回傳欄位為回傳值
            IF cl_null(g_qryparam.return1) THEN
               LET g_qryparam.return1 = gr_qry_sel[li_i].gzza001_1 

            ELSE
               LET g_qryparam.return1 = g_qryparam.return1 , "|", gr_qry_sel[li_i].gzza001_1 
 
            END IF
         END IF
      END FOR
   END IF
 
   IF g_qryparam.state = "m" THEN
      CALL g_qryparam.str_array.clear()
 
      FOR li_i = 1 TO gr_qry_sel.getLength()
         #DISPLAY "gr_qry_sel[",li_i,"] = ",gr_qry_sel[li_i].*
         
         LET g_qryparam.str_array[li_i] = gr_qry_sel[li_i].gzza001_1,'|', 
gr_qry_sel[li_i].gzzal003_2
         #DISPLAY "g_qryparam.str_array[",li_i,"] = ",g_qryparam.str_array[li_i]
      END FOR
   END IF
END FUNCTION

################################################################################
# Descriptions...: 記錄已勾選的資料
# Memo...........:
# Usage..........: CALL azzi970_sub_qry_check(p_mode, p_check, p_start, p_end)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_qry_check(p_mode,p_check,p_start,p_end)
   DEFINE p_mode   STRING                 #選取方式
   DEFINE p_check  LIKE type_t.chr1    #選取狀態 Y/N
   DEFINE p_start  LIKE type_t.num10   #此頁選取範圍第一筆
   DEFINE p_end    LIKE type_t.num10   #此頁選取範圍最後一筆
   DEFINE li_i     LIKE type_t.num10
   DEFINE li_j     LIKE type_t.num10
   DEFINE l_check  LIKE type_t.chr1
   DEFINE l_str1   STRING
   DEFINE l_str2   STRING
 
   CASE
      #全部選取
      WHEN p_mode = "selectall"
         IF g_data_cnt > g_sel_limit THEN   #選取資料筆數超出系統容許上限
            #qry-005:選取資料筆數超出系統容許上限%1
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = g_sel_limit
            LET g_errparam.code   =  "9035" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         ELSE
            FOR li_i = p_start TO p_end
               LET gr_qry[li_i].check = "Y"
            END FOR
 
            CALL gr_qry_sel.clear()
            LET li_i = 1
            FOREACH lcurs_qry_all INTO gr_qry_sel[li_i].*
               LET li_i = li_i + 1
            END FOREACH
            CALL gr_qry_sel.deleteElement(li_i)
         END IF
 
      #全部取消選取
      WHEN p_mode = "selectnone"
         CALL gr_qry_sel.clear()
         FOR li_i = p_start TO p_end
            LET gr_qry[li_i].check = "N"
         END FOR
 
      #改變單筆資料的選取狀態/此頁全選/此頁取消選取
      WHEN p_end > 0 AND (cl_null(p_mode) OR p_mode = "selectpageall" OR p_mode = "selectpagenone")
         FOR li_i = p_start TO p_end
            #將所有欄位值串在一起,以利做開窗record唯一值判斷
            #要和已被選取的陣列(gr_qry_sel)做唯一值判斷比較
            LET l_str1 = gr_qry[li_i].gzza001_1, gr_qry[li_i].gzzal003_2, gr_qry[li_i].gzza003_3
 
            IF p_check = "Y" THEN
               IF gr_qry_sel.getLength() >= g_sel_limit THEN   #選取資料筆數超出系統容許上限
                  LET gr_qry[li_i].check = "N"
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_sel_limit
                  LET g_errparam.code   =  "9035" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT FOR
               ELSE
                  LET l_check = "Y"
                  LET gr_qry[li_i].check = "Y"             #此頁全選時,用程式批次改變值
                  FOR li_j = 1 TO gr_qry_sel.getLength()   #勾選清單中有此筆資料
                     LET l_str2 = gr_qry_sel[li_j].gzza001_1, gr_qry_sel[li_j].gzzal003_2, gr_qry_sel[li_j].gzza003_3
                     IF l_str1 = l_str2 THEN
                        LET l_check = ""
                        EXIT FOR
                     END IF
                  END FOR
                  IF l_check = "Y" THEN  #加入勾選清單
                     LET li_j = gr_qry_sel.getLength() + 1
                     LET gr_qry_sel[li_j].* = gr_qry[li_i].*
                  END IF
               END IF
            ELSE
               LET gr_qry[li_i].check = "N"             #此頁取消選取時,用程式批次改變值
               FOR li_j = 1 TO gr_qry_sel.getLength()   #刪除勾選清單中的此筆資料
                  LET l_str2 = gr_qry_sel[li_j].gzza001_1, gr_qry_sel[li_j].gzzal003_2, gr_qry_sel[li_j].gzza003_3
                  IF l_str1 = l_str2 THEN
                      CALL gr_qry_sel.deleteElement(li_j)
                     EXIT FOR
                  END IF
               END FOR
            END IF
         END FOR
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 設定comboBox
# Memo...........:
# Usage..........: CALL azzi970_sub_setting_comboBox(p_col_str) 
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_setting_comboBox(p_col_str)
   DEFINE p_col_str           STRING 
   DEFINE l_i                 LIKE type_t.num5 
   DEFINE l_dzep011           LIKE dzep_t.dzep010  #系統分類碼
   DEFINE l_dzeb001           LIKE dzeb_t.dzeb001  #表格代號
   DEFINE l_gzcc003           LIKE gzcc_t.gzcc003  #系統分類碼
   DEFINE l_gzcc004_str       STRING               #系統分類值的字串 
   DEFINE l_token             base.StringTokenizer 
   DEFINE l_token_str         LIKE dzeb_t.dzeb002 
   DEFINE l_str               STRING 
   DEFINE l_parameter1        STRING 
   DEFINE l_parameter2        STRING 
   DEFINE l_parameter3        STRING 
   DEFINE l_col_id            LIKE dzeb_t.dzeb002
          
   #優先處理 token
   LET l_token = base.StringTokenizer.create(p_col_str,"|")
 
   WHILE l_token.hasMoreTokens()
 
      LET l_token_str =l_token.nextToken()
      LET l_str = l_token_str
      LET l_str = l_str.subString(1,l_str.getIndexOf("_",1)-1)
      LET l_col_id = l_str.trim()
 
      #找出欄位的所屬表格代號
      SELECT dzeb001 INTO l_dzeb001 FROM dzeb_t WHERE dzeb002 = l_col_id
      
      IF l_col_id MATCHES "*stus" THEN
         #找出該表格的狀態碼欄位和系統分類碼
         SELECT DISTINCT gzcc003 INTO l_gzcc003 FROM gzcc_t WHERE gzcc001 = l_dzeb001
         #組合出表格有效的系統分類值的字串
         LET l_gzcc004_str = azzi970_sub_setting_system_type_value_for_table(l_dzeb001)
 
         LET l_parameter1 = "formonly.",l_token_str
         LET l_parameter2 = l_gzcc003
         LET l_parameter3 = l_gzcc004_str
 
         #組合 動態設定有選擇SCC資料的ComboBox選項 的程式碼,列出部分的系統分類值
         CALL cl_set_combo_scc_part(l_parameter1,l_parameter2,l_parameter3)
      ELSE
         #找出該欄位的系統分類碼
         SELECT dzep011 INTO l_dzep011 FROM dzep_t WHERE dzep002 = l_col_id
 
         LET l_parameter1 = "formonly.",l_token_str
         LET l_parameter2 = l_dzep011
         
         #組合 動態設定有選擇SCC資料的ComboBox選項 的程式碼,列出全部的系統分類值
         CALL cl_set_combo_scc(l_parameter1,l_parameter2)
      END IF
 
   END WHILE
    

END FUNCTION

################################################################################
# Descriptions...: 組合出表格有效的系統分類值的字串
# Memo...........:
# Usage..........: CALL azzi970_sub_setting_system_type_value_for_table(p_table)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_sub_setting_system_type_value_for_table(p_table)
   DEFINE p_table     LIKE  gzcc_t.gzcc001
   DEFINE l_gzcc_d    DYNAMIC ARRAY OF  RECORD
            gzcc004     LIKE dzeb_t.dzeb001
                      END  RECORD
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE r_str       STRING
 
   LET ls_sql = "SELECT gzcc004 FROM gzcc_t ",
                 "WHERE gzcc001='",p_table,"' AND gzccstus='Y' ",
                 "ORDER BY gzcc006 "
   LET r_str = ""
 
   PREPARE gzcc_prep FROM ls_sql
   DECLARE gzcc_curs CURSOR FOR gzcc_prep
   LET l_cnt = 1
   FOREACH gzcc_curs INTO l_gzcc_d[l_cnt].gzcc004
      LET r_str = r_str,l_gzcc_d[l_cnt].gzcc004,","
      LET l_cnt = l_cnt + 1
   END FOREACH
 
   CALL l_gzcc_d.deleteElement(l_cnt)
 
   #去掉最後面的逗號
   LET r_str = r_str.subString(1,r_str.getLength()-1)
   
   RETURN r_str
END FUNCTION

################################################################################
# Descriptions...: 取得模組及程式名稱
# Memo...........:
# Usage..........: CALL azzi970_module_name(ps_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_module_name(ps_wc)
   DEFINE ps_wc       STRING 
   DEFINE li_index    LIKE type_t.num5
   DEFINE li_index2   LIKE type_t.num5
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzza003  LIKE gzza_t.gzza003
   
   CALL azzi970_get_index(ps_wc)RETURNING li_index,li_index2
   IF li_index > 0 THEN 
      LET lc_gzza001 = ps_wc.subString(li_index+2,li_index2-1)
      
      SELECT COUNT(*) INTO li_cnt FROM gzza_t 
       WHERE gzza001 = lc_gzza001  
      IF li_cnt = 0 THEN 
         SELECT gzde002 INTO lc_gzza003 FROM gzde_t 
          WHERE gzde001 = lc_gzza001 
      ELSE
         SELECT gzza003 INTO lc_gzza003 FROM  gzza_t 
          WHERE gzza001 = lc_gzza001      
      END IF  
   END IF 
   LET g_qryparam.return2 = lc_gzza003 
   LET g_qryparam.return1 = lc_gzza001

END FUNCTION

################################################################################
# Descriptions...: 轉換 sql where
# Memo...........:
# Usage..........: CALL azzi970_change_sql_where(ps_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_change_sql_where(ps_wc)
   DEFINE ps_wc       STRING 
   DEFINE li_index    LIKE type_t.num5
   DEFINE li_index2   LIKE type_t.num5
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzza003  LIKE gzza_t.gzza003
   DEFINE ls_where    STRING 
   DEFINE ls_where2   STRING  
   #gi_cons_where:gzza001 like 'azzi%'
   #gi_cons_where:gzza001='azzi900'

   CALL azzi970_get_index(ps_wc)RETURNING li_index,li_index2

   IF li_index > 0 THEN 
      LET lc_gzza001 = ps_wc.subString(li_index+2,li_index2-1) 
      LET ls_where = ps_wc
      LET ls_where2 = " gzde001=","'",lc_gzza001,"'" 
   ELSE
      IF ps_wc.getIndexOf("like",1) THEN 
         LET li_index = ps_wc.getIndexOf("like",1)
         LET ls_where = ps_wc
         LET ls_where2 = "gzde001 ",ps_wc.subString(li_index,ps_wc.getLength()) 
      ELSE 
         LET ls_where = ps_wc
         LET ls_where2 = ps_wc
      END IF  
   END IF

   RETURN ls_where,ls_where2
END FUNCTION

################################################################################
# Descriptions...: 取 "=" 的 index  ex:gzza001='azzi900' 
# Memo...........:
# Usage..........: CALL azzi970_get_index(ps_wc)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_get_index(ps_wc)
   DEFINE ps_wc       STRING 
   DEFINE li_index    LIKE type_t.num5
   DEFINE li_index2   LIKE type_t.num5
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzza003  LIKE gzza_t.gzza003

   LET li_index = ps_wc.getIndexOf("=",1)
   IF li_index > 0 THEN 
      LET li_index2 = ps_wc.getIndexOf("'",li_index+2)
      
   END IF
   
   RETURN li_index,li_index2
END FUNCTION

################################################################################
# Descriptions...: 畫面顯示
# Memo...........:
# Usage..........: CALL azzi970_show()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_show()
   IF NOT cl_null(g_gzza001) THEN
                  
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_gzza001
      CALL ap_ref_array2(g_ref_fields," SELECT gzzal003,gzzal004 FROM gzzal_t WHERE gzzal001 = ? AND gzzal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_gzza001_desc = g_rtn_fields[1]
      IF cl_null(g_gzza001_desc) THEN 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_gzza001
         CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_gzza001_desc = g_rtn_fields[1]
      END IF  
      DISPLAY g_gzza001_desc TO gzza001_desc
  END IF
END FUNCTION

################################################################################
# Descriptions...: 解析程式碼
# Memo...........:
# Usage..........: CALL azzi970_instruction_analytics(ps_code)
#                  RETURNING 回传参数
# Input parameter: ps_code 程式碼 STRING
# Return code....: 
# Date & Author..: 2015/03/16 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_instruction_analytics(ps_code)
   DEFINE ps_code    STRING 
   DEFINE l_token    base.StringTokenizer
   DEFINE lch_pipe   base.Channel
   DEFINE lc_token   LIKE gzwv_t.gzwv001   
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE li_cnt2    LIKE type_t.num5

   
   
   LET lch_pipe = base.Channel.create()
   LET l_token = base.StringTokenizer.create(ps_code," ")
   LET li_cnt2 = 1
   CALL g_gzwv_d.clear()
   WHILE l_token.hasMoreTokens()
      LET lc_token = l_token.nextToken()
      SELECT COUNT(*) INTO li_cnt FROM gzwv_t
       WHERE gzwv001 = lc_token AND gzwv002 = g_dlang
      IF li_cnt > 0 THEN 
         #SELECT gzwv004 INTO lc_gzwv004 FROM gzwv_t
         # WHERE gzwv001 = lc_token AND gzwv002 = g_dlang
         #  CALL cl_ask_confirm3('',lc_gzwv004)
         FOR li_cnt =  1 TO g_gzwv_d.getLength()
             IF lc_token = g_gzwv_d[li_cnt].g_gzwv001 THEN 
                CONTINUE WHILE 
             END IF 
         END FOR 
         LET g_gzwv_d[g_gzwv_d.getLength()+1].g_gzwv001 = lc_token
         SELECT gzwv003,gzwv004 INTO g_gzwv_d[g_gzwv_d.getLength()].g_gzwv003,g_gzwv_d[g_gzwv_d.getLength()].g_gzwv004
          FROM gzwv_t
           WHERE gzwv001 = lc_token AND gzwv002 = g_dlang
      END IF  
   END WHILE 
   CALL lch_pipe.close() 
END FUNCTION

################################################################################
# Descriptions...: 開窗顯示
# Memo...........:
# Usage..........: CALL azzi970_open_win_instruction()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2015/03/17 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi970_open_win_instruction()
   DEFINE lwin_curr   ui.Window
   DEFINE lfrm_curr   ui.Form
   DEFINE ls_path     STRING
   DEFINE li_ac       LIKE type_t.num5
   DEFINE ldig_curr   ui.Dialog
   DEFINE l_msg       STRING           
   DEFINE l_chk       LIKE type_t.num5 
   DEFINE lc_gzwv001  LIKE gzwv_t.gzwv001

  #畫面
   OPEN WINDOW w_azzi970_s02 WITH FORM cl_ap_formpath("azz","azzi970_s02")
      ATTRIBUTE(STYLE="openwin")
   #CALL cl_ui_locale("azzi970_s01")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_openwin.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)

      
   DIALOG ATTRIBUTES(UNBUFFERED)

      DISPLAY ARRAY g_gzwv_d TO s_detail2.*
         ATTRIBUTES(COUNT=g_data_cnt)
         BEFORE ROW
            LET li_ac = DIALOG.getCurrentRow("s_detail2")
            DISPLAY li_ac TO FORMONLY.idx 
            DISPLAY g_gzwv_d.getLength() TO FORMONLY.cnt
      END DISPLAY
 
      BEFORE DIALOG
         LET ldig_curr = ui.Dialog.getCurrent()
         #CALL azzi970_sub_set_pagebutton(ldig_curr)

 
      ON ACTION accept
         #IF li_ac > 0 THEN
         #   LET lc_gzwv001 = g_gzwv_d[li_ac].g_gzwv001 
            #LET g_qryparam.return1 = g_instruct_d[li_ac].g_id 
            #LET g_qryparam.return2 = g_instruct_d[li_ac].gzza003_3 
         #ELSE
         #   LET g_qryparam.return1 = gs_default1 
         #   LET g_qryparam.return2 = gs_default2 

         #END IF
         #LET gs_action = "exit"
         EXIT DIALOG
         
      ON ACTION CANCEL
         #LET g_qryparam.return1 = gs_default1 
         #LET g_qryparam.return2 = gs_default2 
         LET lc_gzwv001 = ""
         #LET gs_action = "exit"
         LET INT_FLAG = TRUE
         EXIT DIALOG
         
   END DIALOG
   CLOSE WINDOW w_azzi970_s02

END FUNCTION

#end add-point
 
{</section>}
 
