#該程式未解開Section, 採用最新樣板產出!
{<section id="axri011.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-08-15 11:10:48), PR版次:0016(2016-12-01 09:59:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000348
#+ Filename...: axri011
#+ Description: 應收帳款類別依帳套設定科目作業
#+ Creator....: 02295(2013-10-10 15:19:44)
#+ Modifier...: 01531 -SD/PR- 02481
 
{</section>}
 
{<section id="axri011.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151023-00016#1   2015/10/26  By 01727    錯誤訊息改為正規報錯
#150916-00015#1   2015/11/30  By taozf    当有账套时，科目检查改为检查是否存在于glad_t中
#151201-00002#57  2016/01/06  By 01727    天河程序回收產品,增加跨會計科目參照表複製的功能,新帳套不可使用的科目在複製時被清空
#160318-00005#50  2016/04/01  by pengxin  修正azzi920重复定义之错误讯息
#160811-00009#6   2016/08/19  By 01531    账务中心/法人/账套权限控管
#161018-00045#1   2016/10/26  By 07900    axri011，鼠标双击单身不能进入修改状态，建议跟aapi011一致
#161026-00012#1   2016/10/28  By 01727    axri011复制状态下,账套栏位开窗报错
#161028-00046#1   2016/11/04  By dorishsu 修正aapi011/axir011共用glab_t,二邊資料互相誤刪的問題
#161108-00019#2   2016/11/08  By 07900    g_browser_cnt 改为num10
#161118-00019#2   2016/11/22  By 07900    numt5 to num10(需人工调整部分)
#161128-00061#3   2016/12/01  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
{<Module define>}

#單頭 type 宣告
 type type_g_glab_m        RECORD
       glabld LIKE glab_t.glabld,
   glabld_desc LIKE type_t.chr80,
   glab001 LIKE glab_t.glab001,
   glab002 LIKE glab_t.glab002,
   glab002_desc LIKE type_t.chr80,
   glaacomp LIKE type_t.chr80,
   glaacomp_desc LIKE type_t.chr80,
   glaa014 LIKE type_t.chr80,
   glaa008 LIKE type_t.chr80,
   glaa004 LIKE glaa_t.glaa004,
   glaa004_desc LIKE type_t.chr80,
   glab010      LIKE glab_t.glab010
       END RECORD

#單身 type 宣告
 TYPE type_g_glab_d        RECORD
       glab003 LIKE glab_t.glab003,
   glab003_desc LIKE type_t.chr80,    
   glab005 LIKE glab_t.glab005,
   glab005_desc LIKE type_t.chr80,
   glab011 LIKE glab_t.glab011
       END RECORD

 TYPE type_g_glab2_d        RECORD
       glab003_2 LIKE glab_t.glab003,
   glab003_2_desc LIKE type_t.chr80,    
   glab005_2 LIKE glab_t.glab005,
   glab005_2_desc LIKE type_t.chr80,
   glab011_2 LIKE glab_t.glab011
       END RECORD

#無單頭append欄位定義
#無單身append欄位定義

#模組變數(Module Variables)
DEFINE g_glab_m          type_g_glab_m
DEFINE g_glab_m_t        type_g_glab_m

DEFINE g_glabld_t     LIKE glab_t.glabld
DEFINE g_glab001_t     LIKE glab_t.glab001

DEFINE g_glab002_t     LIKE glab_t.glab002



DEFINE g_glab_d          DYNAMIC ARRAY OF type_g_glab_d
DEFINE g_glab_d_t        type_g_glab_d

DEFINE g_glab2_d          DYNAMIC ARRAY OF type_g_glab2_d
DEFINE g_glab2_d_t        type_g_glab2_d

DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       b_statepic     LIKE type_t.chr50,
          b_glabld LIKE glab_t.glabld,
      b_glab001 LIKE glab_t.glab001,
      b_glab002 LIKE glab_t.glab002
       #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10              #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_rec_b2              LIKE type_t.num10              #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE l_ac                  LIKE type_t.num10              #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE l_ac2                 LIKE type_t.num10               #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10              #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數         #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數    #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數       #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161118-00019#2 mod  type_t.num5 -> type_t.num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數      #161108-00019#2 mod type_t.num5 -> type_t.num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_page_flag           STRING
DEFINE g_glab010_comm        LIKE type_t.chr500 #glab010說明
DEFINE g_aw                  STRING                        #確定當下點擊的單身
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="axri011.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT glabld,'',glab001,glab002,'','','','','' FROM glab_t WHERE glabent= ? AND glabld=? AND glab001='13' AND glab002=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE axri011_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axri011 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axri011_init()
 
      #進入選單 Menu (='N')
      CALL axri011_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_axri011
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axri011.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axri011_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point

   LET g_bfill = "Y"

      CALL cl_set_combo_scc('glab011','8315')
      CALL cl_set_combo_scc('glab011_2','8315')
   LET g_error_show = 1
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('glab003','8304')           {#ADP版次:1#}
   CALL cl_set_combo_scc('glab003_2','8304')
   CALL cl_getmsg("ais-00168",g_dlang) RETURNING g_glab010_comm
   CALL s_hint_show_set_comments('glab010',g_glab010_comm) 
   #end add-point

   CALL axri011_default_search()

END FUNCTION

PRIVATE FUNCTION axri011_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num10    #161108-00019#2 mod type_t.num5 -> type_t.num10

   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   LET g_page_flag = 'page1'
   CALL cl_set_act_visible("accept,cancel", FALSE)

   #該樣板不需此段落CALL gfrm_curr.setElementImage("logo","logo/applogo.png")
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("mainlayout",1)
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("worksheet",0)
   #該樣板不需此段落LET g_main_hidden = 1

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE TRUE

      CALL axri011_browser_fill("")

      #該樣板不需此段落CALL lib_cl_dlg.cl_dlg_before_display()
      #該樣板不需此段落CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_glabld = g_glabld_t
               AND g_browser[li_idx].b_glab001 = g_glab001_t

               AND g_browser[li_idx].b_glab002 = g_glab002_t


               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #該樣板不需此段落#左側瀏覽頁簽
         #該樣板不需此段落DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         #該樣板不需此段落
         #該樣板不需此段落   BEFORE ROW
         #該樣板不需此段落      #回歸舊筆數位置 (回到當時異動的筆數)
         #該樣板不需此段落      LET g_current_idx = DIALOG.getCurrentRow("s_browse")
         #該樣板不需此段落      IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
         #該樣板不需此段落         CALL DIALOG.setCurrentRow("s_browse",g_current_row)
         #該樣板不需此段落         LET g_current_idx = g_current_row
         #該樣板不需此段落      END IF
         #該樣板不需此段落      LET g_current_row = g_current_idx #目前指標
         #該樣板不需此段落      LET g_current_sw = TRUE
         #該樣板不需此段落
         #該樣板不需此段落      IF g_current_idx > g_browser.getLength() THEN
         #該樣板不需此段落         LET g_current_idx = g_browser.getLength()
         #該樣板不需此段落      END IF
         #該樣板不需此段落
         #該樣板不需此段落      CALL axri011_fetch('') # reload data
         #該樣板不需此段落      LET g_detail_idx = 1
         #該樣板不需此段落      CALL axri011_ui_detailshow() #Setting the current row
         #該樣板不需此段落
         #該樣板不需此段落END DISPLAY

         DISPLAY ARRAY g_glab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axri011_ui_detailshow()
               CALL s_hint_show_set_comments('glab010',g_glab010_comm)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               DISPLAY g_rec_b TO FORMONLY.cnt
               LET g_page_flag = 'page1'
               #控制stus哪個按鈕可以按





         END DISPLAY
         
         DISPLAY ARRAY g_glab2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page2

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axri011_ui_detailshow()
               CALL s_hint_show_set_comments('glab010',g_glab010_comm)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_rec_b2 TO FORMONLY.cnt
               LET g_page_flag = 'page2'
               #控制stus哪個按鈕可以按





         END DISPLAY         



         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point

         #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_qryplan
         #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_relateapps

         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            #該樣板不需此段落LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
            #該樣板不需此段落   CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE

            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF

            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1
            END IF

            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axri011_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axri011_ui_detailshow() #Setting the current row

            #若無資料則關閉相關功能
            IF g_browser_cnt = 0 THEN
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
            ELSE
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
            END IF

            #add-point:ui_dialog段before dialog2
            {<point name="ui_dialog.before_dialog2"/>}
            #end add-point

         #ACTION表單列
         #該樣板不需此段落ON ACTION filter
         #該樣板不需此段落   CALL axri011_filter()
         #該樣板不需此段落   EXIT DIALOG

         ON ACTION first
            CALL axri011_fetch('F')
            LET g_current_row = g_current_idx

         ON ACTION previous
            CALL axri011_fetch('P')
            LET g_current_row = g_current_idx

         ON ACTION jump
            CALL axri011_fetch('/')
            LET g_current_row = g_current_idx

         ON ACTION next
            CALL axri011_fetch('N')
            LET g_current_row = g_current_idx

         ON ACTION last
            CALL axri011_fetch('L')
            LET g_current_row = g_current_idx
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_glab_d)
                  LET g_export_id[1]   = "s_detail1"
                  
                  LET g_export_node[2] = base.typeInfo.create(g_glab2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel

                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         #該樣板不需此段落ON ACTION mainhidden       #主頁摺疊
         #該樣板不需此段落   IF g_main_hidden THEN
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",0)
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",1)
         #該樣板不需此段落      LET g_main_hidden = 0
         #該樣板不需此段落   ELSE
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",1)
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",0)
         #該樣板不需此段落      LET g_main_hidden = 1
         #該樣板不需此段落   END IF

         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
                CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF



         ON ACTION reproduce

            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axri011_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION delete

            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axri011_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF


         ON ACTION modify

            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL axri011_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF
         #161018-00045#1--add--s--
         ON ACTION modify_detail
         
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN             
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axri011_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"

               #END add-point
               EXIT DIALOG
            END IF
         #161018-00045#1--add--e--

         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axri011_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF


         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axri011_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
                EXIT DIALOG
            END IF


         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG

      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION axri011_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point

   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00005"
      LET g_errparam.extend = "searchcol"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF

   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1"
   END IF

   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY glabld,glab002"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF

   CALL axri011_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION axri011_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_ld_str          STRING #160811-00009#6
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point

   #add-point:browser_fill段動作開始前
   {<point name="browser_fill.before_browser_fill"/>}
   #end add-point

   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "glabld,glab002"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET l_wc  = g_wc.trim()
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF

   LET l_wc = l_wc," AND glab001 = '13'"
   
   #160811-00009#6---(S)---
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glabld")
   LET l_wc = l_wc," AND ",l_ld_str
   #160811-00009#6  ---(E)---      

   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE glabld ",
                      ", glab001 ",

                      ", glab002 ",


                      " FROM glab_t ",
                      " ",
                      " ",
                      " WHERE glabent = '" ||g_enterprise|| "' AND glab001 = '13'",
                      "   AND glab002 IN (SELECT oocq002 FROM oocq_t WHERE oocqent = '",g_enterprise,"'"," AND oocq001 = '3111' AND oocqstus = 'Y')",
                      "   AND ",l_wc, " AND ", l_wc2

   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE glabld ",
                      ", glab001 ",

                      ", glab002 ",


                      " FROM glab_t ",
                      " ",
                      " ",
                      " WHERE glabent = '" ||g_enterprise|| "' AND glab001 = '13'",
                      "   AND glab002 IN (SELECT oocq002 FROM oocq_t WHERE oocqent = '",g_enterprise,"'"," AND oocq001 = '3111' AND oocqstus = 'Y')",
                      "   AND ",l_wc CLIPPED

   END IF

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre

   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_error_show = 0

   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   #LET g_page_action = ps_page_action          # Keep Action
   IF ps_page_action = "first" OR
      ps_page_action = "prev"  OR
      ps_page_action = "next"  OR
      ps_page_action = "last"  THEN
      LET g_page_action = ps_page_action        #g_page_action 這個會影響 browser 下面四個button 的判斷
   END IF

   CASE ps_page_action
      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
             LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE

      OTHERWISE
         LET g_pagestart = 1

   END CASE

   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN

      #依照glabld,glab001,glab002 Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql  = "SELECT DISTINCT glabld,glab001,glab002 ",
                       " FROM glab_t ",
                       " ",
                       " WHERE glabent = '" ||g_enterprise|| "' AND glab001 = '13' AND ", g_wc," AND ",g_wc2

   ELSE
      #單身無輸入資料
      LET l_sub_sql  = "SELECT DISTINCT glabld,glab001,glab002 ",
                       " FROM glab_t ",
                       " WHERE glabent = '" ||g_enterprise|| "' AND glab001 = '13' AND ", g_wc

   END IF

   LET l_sql_rank = "SELECT glabld,glab001,glab002,DENSE_RANK() OVER(ORDER BY glabld ",g_order,") AS RANK ",
                    " FROM (",l_sub_sql,") "

   #定義翻頁CURSOR
   LET g_sql =  "  SELECT DISTINCT glabld,glab001,glab002 ",
                "     FROM glab_t ",
                "    WHERE glab001 = '13' AND glabent = '",g_enterprise,"'                                      ",
                "      AND glab002 IN (SELECT oocq002 FROM oocq_t WHERE oocqent = '",g_enterprise,"'"," AND oocq001 = '3111' AND oocqstus = 'Y')",
                "      AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glab_t")

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_glabld,g_browser[g_cnt].b_glab001,g_browser[g_cnt].b_glab002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF



      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
      #end add-point

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_glab_m.* TO NULL
      CALL g_glab_d.clear()

      CLEAR FORM
   END IF

   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0

   #該樣板不需此段落CALL axri011_fetch('')

   FREE browse_pre

END FUNCTION

PRIVATE FUNCTION axri011_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point

   LET g_glab_m.glabld = g_browser[g_current_idx].b_glabld
   LET g_glab_m.glab001 = g_browser[g_current_idx].b_glab001

   LET g_glab_m.glab002 = g_browser[g_current_idx].b_glab002


    SELECT UNIQUE glabld,glab001,glab002,glab010
 INTO g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab010
 FROM glab_t
 WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = g_glab_m.glab001 AND glab002 = g_glab_m.glab002
   CALL axri011_show()

END FUNCTION

PRIVATE FUNCTION axri011_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point

   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)

   END IF

   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_glabld = g_glab_m.glabld
         AND g_browser[l_i].b_glab001 = g_glab_m.glab001

         AND g_browser[l_i].b_glab002 = g_glab_m.glab002


         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR

   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF

   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示

END FUNCTION

PRIVATE FUNCTION axri011_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   DEFINE l_ld_str         STRING  #160811-00009#6 
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   #清除畫面上相關資料
   CLEAR FORM
   INITIALIZE g_glab_m.* TO NULL
   CALL g_glab_d.clear()

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""

   LET g_qryparam.state = 'c'

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT BY NAME g_wc ON glabld,glab001,glab002,glab010

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            CALL s_hint_show_set_comments('glab010',g_glab010_comm)
            #end add-point

        #---------------------------<  Master  >---------------------------
         #----<<glabld>>----
         #Ctrlp:construct.c.glabld
         ON ACTION controlp INFIELD glabld
            #add-point:ON ACTION controlp INFIELD glabld
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str #160811-00009#6
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa014 ='Y' OR glaa008 = 'Y') "  #160811-00009#6
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glabld  #顯示到畫面上

            NEXT FIELD glabld                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD glabld
            #add-point:BEFORE FIELD glabld
            {<point name="construct.b.glabld" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glabld

            #add-point:AFTER FIELD glabld
            {<point name="construct.a.glabld" />}
            #END add-point


         #----<<glab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001
            {<point name="construct.b.glab001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab001

            #add-point:AFTER FIELD glab001
            {<point name="construct.a.glab001" />}
            #END add-point


         #Ctrlp:construct.c.glab001
#         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001
            {<point name="construct.c.glab001" />}
            #END add-point

         #----<<glab002>>----
         #Ctrlp:construct.c.glab002
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glab002  #顯示到畫面上

            NEXT FIELD glab002                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab002

            #add-point:AFTER FIELD glab002
            
            #END add-point

      END CONSTRUCT

      #單身可以混搭多頁簽
      CONSTRUCT g_wc2 ON glab003,glab005,glab011

         FROM s_detail1[1].glab003,s_detail1[1].glab005,s_detail1[1].glab011


         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point

            #公用欄位開窗相關處理


            #---------------------<  Detail: page1  >---------------------
         #----<<glab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003
            {<point name="construct.b.page1.glab003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab003

            #add-point:AFTER FIELD glab003
            {<point name="construct.a.page1.glab003" />}
            #END add-point


         #Ctrlp:construct.c.page1.glab003
#         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003
            {<point name="construct.c.page1.glab003" />}
            #END add-point

         #----<<glab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005
            {<point name="construct.b.page1.glab005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab005

            #add-point:AFTER FIELD glab005
            {<point name="construct.a.page1.glab005" />}
            #END add-point


         #Ctrlp:construct.c.page1.glab005
#         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005
            {<point name="construct.c.page1.glab005" />}
            #END add-point

         #----<<glab011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011
            {<point name="construct.b.page1.glab011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab011

            #add-point:AFTER FIELD glab011
            {<point name="construct.a.page1.glab011" />}
            #END add-point


         #Ctrlp:construct.c.page1.glab011
#         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011
            {<point name="construct.c.page1.glab011" />}
            #END add-point




      END CONSTRUCT

      #add-point:cs段more_construct
      {<point name="cs.more_construct"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:ui_dialog段b_dialog
         CALL s_hint_show_set_comments('glab010',g_glab010_comm)
         #end add-point

      ON ACTION qbe_select     #條件查詢
         #CALL cl_qbe_list() RETURNING lc_qbe_sn
         #CALL cl_qbe_display_condition(lc_qbe_sn)

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

   #add-point:cs段after_construct
   CALL s_hint_show_set_comments('glab010',g_glab010_comm)
   #end add-point

   LET g_current_row = 1

   IF INT_FLAG THEN
      RETURN
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION axri011_filter()
#該樣板不需此段落   {<Local define>}
#該樣板不需此段落   {</Local define>}
#該樣板不需此段落   #add-point:filter段define
#該樣板不需此段落   {<point name="filter.define"/>}
#該樣板不需此段落   #end add-point

#該樣板不需此段落   LET INT_FLAG = 0

#該樣板不需此段落   LET g_qryparam.state = 'c'

#該樣板不需此段落   LET g_wc_filter_t = g_wc_filter
#該樣板不需此段落   LET g_wc_t = g_wc

#該樣板不需此段落   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

#該樣板不需此段落   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
#該樣板不需此段落   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

#該樣板不需此段落      #單頭
#該樣板不需此段落      CONSTRUCT g_wc_filter ON
#該樣板不需此段落                          FROM

#該樣板不需此段落         BEFORE CONSTRUCT
#該樣板不需此段落            CALL cl_qbe_init()
#該樣板不需此段落

#該樣板不需此段落      END CONSTRUCT

      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

#該樣板不需此段落      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
         #end add-point

#該樣板不需此段落      ON ACTION accept
#該樣板不需此段落         ACCEPT DIALOG

#該樣板不需此段落      ON ACTION cancel
#該樣板不需此段落         LET INT_FLAG = 1
#該樣板不需此段落         EXIT DIALOG

#該樣板不需此段落      #交談指令共用ACTION
#該樣板不需此段落      &include "common_action.4gl"
#該樣板不需此段落         CONTINUE DIALOG

#該樣板不需此段落   END DIALOG

#該樣板不需此段落   IF NOT INT_FLAG THEN
#該樣板不需此段落      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
#該樣板不需此段落      LET g_wc = g_wc , g_wc_filter
#該樣板不需此段落   ELSE
#該樣板不需此段落      LET g_wc_filter = g_wc_filter_t
#該樣板不需此段落      LET g_wc = g_wc_t
#該樣板不需此段落   END IF

END FUNCTION

PRIVATE FUNCTION axri011_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
#該樣板不需此段落   #add-point:filter段define
#該樣板不需此段落   {<point name="filter_parser.define"/>}
#該樣板不需此段落   #end add-point

#該樣板不需此段落   #一般條件解析
#該樣板不需此段落   LET ls_tmp = ps_field, "='"
#該樣板不需此段落   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
#該樣板不需此段落   IF li_tmp > 0 THEN
#該樣板不需此段落      LET li_tmp = ls_tmp.getLength() + li_tmp
#該樣板不需此段落      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
#該樣板不需此段落      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
#該樣板不需此段落   END IF

#該樣板不需此段落   #模糊條件解析
#該樣板不需此段落   LET ls_tmp = ps_field, " like '"
#該樣板不需此段落   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
#該樣板不需此段落   IF li_tmp > 0 THEN
#該樣板不需此段落      LET li_tmp = ls_tmp.getLength() + li_tmp
#該樣板不需此段落      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
#該樣板不需此段落      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
#該樣板不需此段落      LET ls_var = cl_replace_str(ls_var,'%','*')
#該樣板不需此段落   END IF

#該樣板不需此段落   RETURN ls_var

END FUNCTION

PRIVATE FUNCTION axri011_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   LET ls_wc = g_wc

   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()
   CALL g_glab_d.clear()

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL axri011_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axri011_browser_fill(g_wc)
      CALL axri011_fetch("")
      RETURN
   END IF

   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0

   LET g_error_show = 1
   CALL axri011_browser_fill("F")

   #備份搜尋條件
   LET ls_wc = g_wc

   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL axri011_browser_fill("F")
   END IF

   #第二層助記碼搜尋
   IF g_browser_cnt = 0 THEN



      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL axri011_browser_fill("F")
      END IF

   END IF

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLEAR FORM
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
   ELSE
      CALL axri011_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION axri011_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point

   #add-point:fetch段動作開始前
   {<point name="fetch.before_fetch"/>}
   #end add-point

   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt
      WHEN 'P'
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF
      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_set_act_visible("accept,cancel", TRUE)
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            CALL cl_set_act_visible("accept,cancel", FALSE)
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF

         END IF

         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE

   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   CALL axri011_browser_fill(p_flag)

   #該樣板不需此段落CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt

   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數

   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   LET g_glab_m.glabld = g_browser[g_current_idx].b_glabld
   LET g_glab_m.glab001 = g_browser[g_current_idx].b_glab001

   LET g_glab_m.glab002 = g_browser[g_current_idx].b_glab002



   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE glabld,glab001,glab002,glab010
 INTO g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab010
 FROM glab_t
 WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = g_glab_m.glab001 AND glab002 = g_glab_m.glab002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_glab_m.* TO NULL
      RETURN
   END IF

   #LET g_data_owner =
   #LET g_data_group =

   #重新顯示
   CALL axri011_show()

   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)

END FUNCTION

PRIVATE FUNCTION axri011_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point

   #清除相關資料
   CLEAR FORM
   CALL g_glab_d.clear()


   INITIALIZE g_glab_m.* LIKE glab_t.*             #DEFAULT 設定
   INITIALIZE g_glab_m_t.* LIKE glab_t.*
   LET g_glabld_t = NULL
   LET g_glab001_t = NULL

   LET g_glab002_t = NULL


   CALL s_transaction_begin()
   WHILE TRUE

      #單頭預設值
            LET g_glab_m.glaa014 = "N"
      LET g_glab_m.glaa008 = "N"


      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point

      CALL axri011_input("a")

      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_glab_m.* = g_glab_m_t.*
         CALL axri011_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      CALL g_glab_d.clear()


      LET g_rec_b = 0
      EXIT WHILE

   END WHILE

   LET g_state = "Y"

   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001

   LET g_glab002_t = g_glab_m.glab002



   LET g_wc = g_wc,
              " OR ( glabent = '" ||g_enterprise|| "' AND ",
              " glabld = '", g_glab_m.glabld CLIPPED, "' "
              ," AND glab001 = '", g_glab_m.glab001 CLIPPED, "' "

              ," AND glab002 = '", g_glab_m.glab002 CLIPPED, "' "


              , ") "

END FUNCTION

PRIVATE FUNCTION axri011_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point
   IF NOT s_ld_chk_authorization(g_user,g_glab_m.glabld) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glab_m.glabld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN              
   END IF 
   IF g_glab_m.glabld IS NULL
   OR g_glab_m.glab001 IS NULL

   OR g_glab_m.glab002 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE glabld,glab001,glab002,glab010
 INTO g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab010
 FROM glab_t
 WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = g_glab_m.glab001 AND glab002 = g_glab_m.glab002

   ERROR ""

   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001

   LET g_glab002_t = g_glab_m.glab002


   CALL s_transaction_begin()

   OPEN axri011_cl USING g_enterprise,g_glab_m.glabld
                                                       #,g_glab_m.glab001

                                                       ,g_glab_m.glab002


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axri011_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE axri011_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH axri011_cl INTO g_glab_m.glabld,g_glab_m.glabld_desc,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab002_desc,g_glab_m.glaacomp,g_glab_m.glaacomp_desc,g_glab_m.glaa014,g_glab_m.glaa008

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_glab_m.glabld
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE axri011_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL s_transaction_end('Y','0')

   CALL axri011_show()
   WHILE TRUE
      LET g_glabld_t = g_glab_m.glabld
      LET g_glab001_t = g_glab_m.glab001

      LET g_glab002_t = g_glab_m.glab002



      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point

      CALL axri011_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_glab_m.* = g_glab_m_t.*
         CALL axri011_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
      IF g_glab_m.glabld != g_glabld_t
      OR g_glab_m.glab001 != g_glab001_t

      OR g_glab_m.glab002 != g_glab002_t


      THEN
         CALL s_transaction_begin()

         #add-point:單頭(偽)修改前
         {<point name="modify.b_key_update" mark="Y"/>}
         #end add-point

         #更新單頭key值
         UPDATE glab_t SET glabld = g_glab_m.glabld
                                       , glab001 = g_glab_m.glab001

                                       , glab002 = g_glab_m.glab002


          WHERE glabent = g_enterprise AND glabld = g_glabld_t
            AND glab001 = g_glab001_t

            AND glab002 = g_glab002_t


         #add-point:單頭(偽)修改中
         {<point name="modify.m_key_update"/>}
         #end add-point
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "glab_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             CALL s_transaction_end('N','0')
             CONTINUE WHILE
         END IF

         #add-point:單頭(偽)修改後
         {<point name="modify.a_key_update"/>}
         #end add-point

      END IF

      EXIT WHILE

   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_glab_m.glabld,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE axri011_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_glab_m.glabld,'U')

   CALL axri011_b_fill("1=1")
   CALL axri011_b2_fill("1=1")
END FUNCTION

PRIVATE FUNCTION axri011_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num10               #未取消的ARRAY CNT  #161118-00019#2 mod  type_t.num5 -> type_t.num10
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num10               #161108-00019#2 mod type_t.num5 -> type_t.num10
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:input段define
   DEFINE l_glaastus       LIKE glaa_t.glaastus
   DEFINE l_oocqstus       LIKE oocq_t.oocqstus
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_glaa004        LIKE glaa_t.glaa004    #150916-00015#1 -add
   DEFINE l_ld_str         STRING  #160811-00009#6 
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   #add-point:input段define_sql
   {<point name="input.define_sql" mark="Y"/>}
   #end add-point
   LET g_forupd_sql = "SELECT glab003,glab005,'',glab011 FROM glab_t WHERE glabent=? AND glabld=? AND glab001='13' AND glab002=? AND glab003=? FOR UPDATE"
   #add-point:input段define_sql
   {<point name="input.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE axri011_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入
   CALL axri011_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL axri011_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   {<point name="input.after_set_no_entry"/>}
   #end add-point

   DISPLAY BY NAME g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glaacomp,g_glab_m.glaa014,g_glab_m.glaa008,g_glab_m.glab010

   #add-point:進入修改段前
   SELECT glaastus INTO l_glaastus FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glab_m.glabld
   IF l_glaastus <> 'Y' THEN INITIALIZE g_errparam TO NULL
#    LET g_errparam.code = 'agl-00051' #160318-00005#50  mark
    LET g_errparam.code = 'sub-01302'  #160318-00005#50  add
    LET g_errparam.extend = g_glab_m.glabld
    #160318-00005#50 --s add
    LET g_errparam.replace[1] = 'agli010'
    LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
    LET g_errparam.exeprog = 'agli010'
    #160318-00005#50 --e add
    LET g_errparam.popup = TRUE
    CALL cl_err()
 RETURN END IF

   SELECT oocqstus INTO l_oocqstus FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '3111' AND oocq002 = g_glab_m.glab002
   IF l_oocqstus <> 'Y' THEN INITIALIZE g_errparam TO NULL
#    LET g_errparam.code = 'apm-00182' #160318-00005#50  mark
    LET g_errparam.code = 'sub-01302'  #160318-00005#50  add
    LET g_errparam.extend = g_glab_m.glab002
    #160318-00005#50 --s add
    LET g_errparam.replace[1] = 'axri010'
    LET g_errparam.replace[2] = cl_get_progname('axri010',g_lang,"2")
    LET g_errparam.exeprog = 'axri010'
    #160318-00005#50 --e add
    LET g_errparam.popup = TRUE
    CALL cl_err()
 RETURN END IF
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glaacomp,g_glab_m.glaa014,g_glab_m.glaa008,g_glab_m.glab010
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂單頭ACTION


         BEFORE INPUT



         #---------------------------<  Master  >---------------------------
         #----<<glabld>>----
         #此段落由子樣板a02產生
         AFTER FIELD glabld
            CALL axri011_glabld_desc()
            CALL axri011_comp_desc(g_glab_m.glabld)
           #IF NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glabld) THEN
           #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_glab_m.glab002 != g_glab002_t  OR g_glab_m.glabld != g_glabld_t ))) THEN
           #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glab001 = '13' AND "|| "glab002 = '"||g_glab_m.glab002 ||"' AND "|| "glabld = '"||g_glab_m.glabld ||"'",'std-00004',0) THEN
           #         LET g_glab_m.glabld = g_glab_m_t.glabld
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF
           #
           #IF NOT cl_null(g_glab_m.glabld) THEN
           #   IF NOT ap_chk_isExist(g_glab_m.glabld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN
           #      LET g_glab_m.glabld = g_glab_m_t.glabld
           #      NEXT FIELD CURRENT
           #   END IF
           #   IF NOT ap_chk_isExist(g_glab_m.glabld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ?  AND glaastus = 'Y' ",'agl-00051',1) THEN
           #      LET g_glab_m.glabld = g_glab_m_t.glabld
           #      NEXT FIELD CURRENT
           #   END IF
           #   IF NOT ap_chk_isExist(g_glab_m.glabld,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ?  AND glaastus = 'Y' AND glaa014 ='Y' ",'axr-00071',1) THEN
           #      LET g_glab_m.glabld = g_glab_m_t.glabld
           #      NEXT FIELD CURRENT
           #   END IF               
           #END IF            
           #
           #
            IF NOT cl_null(g_glab_m.glabld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_glab_m.glabld != g_glab_m_t.glabld OR g_glab_m_t.glabld IS NULL )) THEN
                   #160811-00009#6 add s---
                   CALL axri011_glabld_chk()
                   IF NOT cl_null(g_errno) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_glab_m.glabld
 
                      CASE g_errno
                         WHEN 'sub-01302'
                            LET g_errparam.replace[1] = 'agli010'
                            LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                            LET g_errparam.exeprog = 'agli010'
                      END CASE
 
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                   
                      LET g_glab_m.glabld = ''
                      DISPLAY '' TO glabld_desc 
                      NEXT FIELD glabld
                   END IF    
                   #160811-00009#6 add e---                    
                   
                   CALL s_fin_account_center_with_ld_chk('',g_glab_m.glabld,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                   IF NOT l_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_glab_m.glabld =''
                      LET g_glab_m.glabld_desc = ''
                      DISPLAY BY NAME g_glab_m.glabld_desc
                      NEXT FIELD CURRENT
                   END IF
               END IF
            END IF
           #
            CALL axri011_glabld_desc()
            CALL axri011_comp_desc(g_glab_m.glabld)


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD glabld
            #add-point:BEFORE FIELD glabld
            CALL axri011_glabld_desc()
            CALL axri011_comp_desc(g_glab_m.glabld)
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE glabld
            #add-point:ON CHANGE glabld
            {<point name="input.g.glabld" />}
            #END add-point

         #----<<glab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001
            {<point name="input.b.glab001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab001

            #add-point:AFTER FIELD glab001
            #此段落由子樣板a05產生
    
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE glab001
            #add-point:ON CHANGE glab001
            {<point name="input.g.glab001" />}
            #END add-point

         #----<<glab002>>----
         #此段落由子樣板a02產生
         AFTER FIELD glab002

            #add-point:AFTER FIELD glab002
            #此段落由子樣板a05產生
            CALL axri011_glab002_desc()
            IF  NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glabld) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_glab_m.glab002 != g_glab002_t  OR g_glab_m.glabld != g_glabld_t ))) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glab001 = '13' AND "|| "glab002 = '"||g_glab_m.glab002 ||"' AND "|| "glabld = '"||g_glab_m.glabld ||"'",'std-00004',0) THEN
                     LET g_glab_m.glab002 = g_glab_m_t.glab002
                     DISPLAY '' TO glab002                        
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_glab_m.glab002) THEN 
#               IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' ",'apm-00181',1) THEN    #160318-00005#50  mark
               IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' ",'sub-01303','axri010') THEN    #160318-00005#50  add
                  LET g_glab_m.glab002 = g_glab_m_t.glab002                  
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' AND oocqstus = 'Y' ",'apm-00182',1) THEN  #160318-00005#50  mark
               IF NOT ap_chk_isExist(g_glab_m.glab002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' AND oocqstus = 'Y' ",'sub-01302','axri010') THEN   #160318-00005#50  add    
                  LET g_glab_m.glab002 = g_glab_m_t.glab002                
                  NEXT FIELD CURRENT
               END IF
            END IF               
            CALL axri011_glab002_desc()

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002
            CALL axri011_glab002_desc()
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE glab002
            #add-point:ON CHANGE glab002
            {<point name="input.g.glab002" />}
            #END add-point

         #----<<glaacomp>>----
         #此段落由子樣板a02產生
         AFTER FIELD glaacomp

         #此段落由子樣板a01產生
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp
            {<point name="input.b.glaacomp" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp
            {<point name="input.g.glaacomp" />}
            #END add-point

         #----<<glaa014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glaa014
            #add-point:BEFORE FIELD glaa014
            {<point name="input.b.glaa014" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glaa014

            #add-point:AFTER FIELD glaa014
            {<point name="input.a.glaa014" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE glaa014
            #add-point:ON CHANGE glaa014
            {<point name="input.g.glaa014" />}
            #END add-point

         #----<<glaa008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glaa008
            #add-point:BEFORE FIELD glaa008
            {<point name="input.b.glaa008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glaa008

            #add-point:AFTER FIELD glaa008
            {<point name="input.a.glaa008" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE glaa008
            #add-point:ON CHANGE glaa008
            {<point name="input.g.glaa008" />}
            #END add-point

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<glabld>>----
         #Ctrlp:input.c.glabld
         ON ACTION controlp INFIELD glabld
            #add-point:ON ACTION controlp INFIELD glabld
#此段落由子樣板a07產生
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str #160811-00009#6
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glabld             #給予default值
            #LET g_qryparam.where = " glaa014 ='Y' " #160811-00009#6
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa014 ='Y' OR glaa008 = 'Y')"  #160811-00009#6
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glab_m.glabld = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glab_m.glabld TO glabld              #顯示到畫面上

            NEXT FIELD glabld                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<glab001>>----
         #Ctrlp:input.c.glab001
#         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001
            {<point name="input.c.glab001" />}
            #END add-point

         #----<<glab002>>----
         #Ctrlp:input.c.glab002
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3111" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_glab_m.glab002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glab_m.glab002 TO glab002              #顯示到畫面上

            NEXT FIELD glab002                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<glaacomp>>----
         #Ctrlp:input.c.glaacomp
#         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp
            {<point name="input.c.glaacomp" />}
            #END add-point

         #----<<glaa014>>----
         #Ctrlp:input.c.glaa014
#         ON ACTION controlp INFIELD glaa014
            #add-point:ON ACTION controlp INFIELD glaa014
            {<point name="input.c.glaa014" />}
            #END add-point

         #----<<glaa008>>----
         #Ctrlp:input.c.glaa008
#         ON ACTION controlp INFIELD glaa008
            #add-point:ON ACTION controlp INFIELD glaa008
            {<point name="input.c.glaa008" />}
            #END add-point

         ON ACTION controlp INFIELD glab010
            #add-point:ON ACTION controlp INFIELD glab010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab_m.glab010  
            LET g_qryparam.where = "dzeb001 IN ('xrca_t')"            
            CALL q_dzeb002_10()          
            IF NOT cl_null(g_glab_m.glab010) AND NOT cl_null(g_qryparam.return1) THEN     
               CALL axri011_glab010_str(g_qryparam.return1)RETURNING g_qryparam.return1            
               LET g_glab_m.glab010 = g_glab_m.glab010,",@",g_qryparam.return1 
            ELSE          
               IF NOT cl_null(g_qryparam.return1)THEN            
                  LET g_glab_m.glab010 = "@",axri011_glab010_str(g_qryparam.return1)
               END IF
            END IF               
            DISPLAY BY NAME g_glab_m.glab010              
            NEXT FIELD glab010

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF

            #多語言處理


           #CALL cl_showmsg()   #151023-00016#1 Mark
            DISPLAY BY NAME g_glab_m.glabld
                            ,g_glab_m.glab001

                            ,g_glab_m.glab002



            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point

               UPDATE glab_t SET (glabld,glab001,glab002,glab010) = (g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab010)
                WHERE glabent = g_enterprise AND glabld = g_glabld_t
                  AND glab001 = g_glab001_t

                  AND glab002 = g_glab002_t


               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_glab_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               ELSE
                  #資料多語言用-增/改

                  LET g_glabld_t = g_glab_m.glabld
                  LET g_glab001_t = g_glab_m.glab001

                  LET g_glab002_t = g_glab_m.glab002


                  #add-point:單頭修改後
                  {<point name="input.head.a_update"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF


            ELSE
               #add-point:單頭新增
               {<point name="input.head.a_insert"/>}
               #end add-point
            END IF
           #controlp

           #若單身還沒有輸入資料, 強制切換至單身
           IF cl_null(g_glab_d[1].glab003) THEN
              NEXT FIELD glab003
           END IF

      END INPUT

      #Page1 預設值產生於此處
      INPUT ARRAY g_glab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂單身ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_glab_d.getLength()+1)
              LET g_insert = 'N'
           END IF
            CALL axri011_b_upd()
            CALL axri011_b_fill(g_wc2)
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_glab_m.glab001 = '13' 

         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()

            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axri011_cl USING g_enterprise,
                                               g_glab_m.glabld
                                               #,g_glab_m.glab001

                                               ,g_glab_m.glab002



               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axri011_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axri011_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF

            LET l_cmd = ''

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_glab_d[l_ac].glab003)

            THEN
               LET l_cmd='u'
               LET g_glab_d_t.* = g_glab_d[l_ac].*  #BACKUP
               CALL axri011_set_entry_b(l_cmd)
               CALL axri011_set_no_entry_b(l_cmd)
               OPEN axri011_bcl USING g_enterprise,g_glab_m.glabld,
                                                #g_glab_m.glab001,

                                                g_glab_m.glab002,


                                                g_glab_d_t.glab003

               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axri011_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH axri011_bcl INTO g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc,g_glab_d[l_ac].glab011
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_glab_d_t.glab003
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF

                  CALL axri011_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            CALL s_hint_show_set_comments('glab010',g_glab010_comm)
            #end add-point


         BEFORE INSERT

            INITIALIZE g_glab_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glab_d[l_ac].* TO NULL

            #公用欄位預設值


            #一般欄位預設值
                  LET g_glab_d[l_ac].glab011 = "1"




            LET g_glab_d_t.* = g_glab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axri011_set_entry_b(l_cmd)
            CALL axri011_set_no_entry_b(l_cmd)

            #add-point:modify段before insert
            LET g_glab_m.glab001 = '13'          {#ADP版次:1#}
            #end add-point

         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
               AND glab001 = g_glab_m.glab001

               AND glab002 = g_glab_m.glab002


               AND glab003 = g_glab_d[l_ac].glab003


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN

               CALL s_transaction_begin()

               #add-point:單身新增前
               {<point name="input.body.b_insert" mark="Y"/>}
               #end add-point

               INSERT INTO glab_t
                           (glabent,
                            glabld,glab001,glab002,glab010,
                            glab003
                            ,glab005,glab011)
                     VALUES(g_enterprise,
                            g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab010,
                            g_glab_d[l_ac].glab003
                            ,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011)
               #add-point:單身新增中
               {<point name="input.body.m_insert"/>}
               #end add-point
               LET p_cmd = 'u'
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_glab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF

            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改

               #add-point:input段-after_insert
               {<point name="input.body.a_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF

            #add-point:單身新增後
            {<point name="input.body.after_insert"/>}
            #end add-point

         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_glab_d_t.glab003)

               THEN

               #add-point:單身刪除前
               {<point name="input.body.b_delete"/>}
               #end add-point

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axri011_before_delete() THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               CLOSE axri011_bcl
               LET l_count = g_glab_d.getLength()
            END IF

            #add-point:單身刪除後
            {<point name="input.body.a_delete"/>}
            #end add-point

         AFTER DELETE
            #add-point:單身AFTER DELETE
            {<point name="input.body.after_delete"/>}
            #end add-point
            CALL axri011_delete_b(l_count)

         #---------------------<  Detail: page1  >---------------------
         #----<<glab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003
            {<point name="input.b.page1.glab003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab003

            #add-point:AFTER FIELD glab003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glab_m.glab001) AND NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glabld) AND NOT cl_null(g_glab_d[g_detail_idx].glab003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_glab_m.glab001 != g_glab001_t OR g_glab_m.glab002 != g_glab002_t OR g_glab_m.glabld != g_glabld_t OR g_glab_d[g_detail_idx].glab003 != g_glab_d_t.glab003))) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glab_m.glab001 ||"' AND "|| "glab001 = '"||g_glab_m.glab002 ||"' AND "|| "glab002 = '"||g_glab_m.glabld ||"' AND "|| "glab003 = '"||g_glab_d[g_detail_idx].glab003 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE glab003
            #add-point:ON CHANGE glab003
            {<point name="input.g.page1.glab003" />}
            #END add-point

         #----<<glab005>>----
         #此段落由子樣板a02產生
         AFTER FIELD glab005

            #add-point:AFTER FIELD glab005
            CALL axri011_glab005_desc()
            IF NOT cl_null(g_glab_d[l_ac].glab005) THEN
              
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab_d[l_ac].glab005,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_d[l_ac].glab005
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_d[l_ac].glab005
                  LET g_qryparam.arg3 = g_glab_m.glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_d[l_ac].glab005 = g_qryparam.return1                 
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_glab_m.glabld,g_glab_d[l_ac].glab005,'N') THEN
                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  NEXT FIELD  CURRENT
               END IF
               # 150916-00015#1 --end
               
               IF NOT ap_chk_isExist(g_glab_d[l_ac].glab005,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? ",'agl-00011',1) THEN
                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_glab_d[l_ac].glab005,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'agl-00012',1) THEN   ##160318-00005#50   mark
               IF NOT ap_chk_isExist(g_glab_d[l_ac].glab005,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'sub-01302','agli020') THEN     #160318-00005#50   add
                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_glab_d[l_ac].glab005,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? AND glacstus = 'Y' AND glac003 <> '1' ",'agl-00013',1) THEN
                  LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  NEXT FIELD CURRENT
               END IF               
            END IF            
            CALL axri011_glab005_desc()
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005
            CALL axri011_glab005_desc()            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE glab005
            #add-point:ON CHANGE glab005
            {<point name="input.g.page1.glab005" />}
            #END add-point

         #----<<glab011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011
            {<point name="input.b.page1.glab011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab011

            #add-point:AFTER FIELD glab011
            {<point name="input.a.page1.glab011" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE glab011
            #add-point:ON CHANGE glab011
            {<point name="input.g.page1.glab011" />}
            #END add-point


         #---------------------<  Detail: page1  >---------------------
         #----<<glab003>>----
         #Ctrlp:input.c.page1.glab003
#         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003
            {<point name="input.c.page1.glab003" />}
            #END add-point

         #----<<glab005>>----
         #Ctrlp:input.c.page1.glab005
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab_d[l_ac].glab005             #給予default值
            #給予arg
            
            LET g_qryparam.where = " glac003 <> '1' AND glac001 = '",g_glab_m.glaa004,"'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_glab_m.glabld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            CALL aglt310_04()                                #呼叫開窗
            LET g_glab_d[l_ac].glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_glab_d[l_ac].glab005 TO glab005              #顯示到畫面上
            CALL axri011_glab005_desc()
            NEXT FIELD glab005                          #返回原欄位
            #END add-point

         #----<<glab011>>----
         #Ctrlp:input.c.page1.glab011
#         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011
            {<point name="input.c.page1.glab011" />}
            #END add-point



         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_glab_d[l_ac].* = g_glab_d_t.*
               CLOSE axri011_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_glab_d[l_ac].glab003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_glab_d[l_ac].* = g_glab_d_t.*
            ELSE

               #add-point:單身修改前
               {<point name="input.body.b_update" mark="Y"/>}
               #end add-point

               UPDATE glab_t SET (glabld,glab001,glab002,glab003,glab005,glab011) = (g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011)
                WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
                 AND glab001 = g_glab_m.glab001

                 AND glab002 = g_glab_m.glab002


                 AND glab003 = g_glab_d_t.glab003 #項次

               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  LET g_glab_d[l_ac].* = g_glab_d_t.*
               ELSE
                  #資料多語言用-增/改

               END IF

               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
            END IF

         AFTER INPUT
            #add-point:input段after input
            {<point name="input.body.after_input"/>}
            #end add-point
      END INPUT

      #Page2 預設值產生於此處
      INPUT ARRAY g_glab2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂單身ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_glab2_d.getLength()+1)
              LET g_insert = 'N'
           END IF
            CALL axri011_b_upd()
            CALL axri011_b2_fill(g_wc2)
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac2)
            END IF
            LET g_glab_m.glab001 = '13'

         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac2 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
            CALL s_hint_show_set_comments('glab010',g_glab010_comm)

            CALL s_transaction_begin()

            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axri011_cl USING g_enterprise,
                                               g_glab_m.glabld
                                               #,g_glab_m.glab001

                                               ,g_glab_m.glab002



               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axri011_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axri011_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF

            LET l_cmd = ''

            IF g_rec_b2 >= l_ac2
               AND NOT cl_null(g_glab_d[l_ac].glab003)

            THEN
               LET l_cmd='u'
               LET g_glab2_d_t.* = g_glab2_d[l_ac2].*  #BACKUP
               CALL axri011_set_entry_b(l_cmd)
               CALL axri011_set_no_entry_b(l_cmd)
               OPEN axri011_bcl USING g_enterprise,g_glab_m.glabld,
                                                #g_glab_m.glab001,

                                                g_glab_m.glab002,


                                                g_glab2_d_t.glab003_2

               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axri011_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH axri011_bcl INTO g_glab2_d[l_ac2].glab003_2,g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc,g_glab2_d[l_ac2].glab011_2
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_glab_d_t.glab003
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF

                  CALL axri011_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         AFTER FIELD glab005_2
            CALL axri011_glab005_2_desc()
            IF NOT cl_null(g_glab2_d[l_ac2].glab005_2) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab2_d[l_ac2].glab005_2,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab2_d[l_ac2].glab005_2
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab2_d[l_ac2].glab005_2
                  LET g_qryparam.arg3 = g_glab_m.glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab2_d[l_ac2].glab005_2 = g_qryparam.return1                 
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_glab_m.glabld,g_glab2_d[l_ac].glab005_2,'N') THEN
                  LET g_glab2_d[l_ac2].glab005_2 = g_glab2_d_t.glab005_2
               END IF
               # 150916-00015#1 --end
               
               IF NOT ap_chk_isExist(g_glab2_d[l_ac2].glab005_2,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? ",'agl-00011',1) THEN
                  LET g_glab2_d[l_ac2].glab005_2 = g_glab2_d_t.glab005_2
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(g_glab2_d[l_ac2].glab005_2,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'agl-00012',1) THEN    #160318-00005#50  mark
               IF NOT ap_chk_isExist(g_glab2_d[l_ac2].glab005_2,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'sub-01302','agli020') THEN   #160318-00005#50  add
                  LET g_glab2_d[l_ac2].glab005_2 = g_glab2_d_t.glab005_2
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_glab2_d[l_ac2].glab005_2,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac001 = '"||g_glab_m.glaa004||"' AND glac002 = ? AND glacstus = 'Y' AND glac003 <>'1' ",'agl-00013',1) THEN
                  LET g_glab2_d[l_ac2].glab005_2 = g_glab2_d_t.glab005_2
                  NEXT FIELD CURRENT
               END IF               
            END IF            
            CALL axri011_glab005_2_desc()
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD glab005_2
            #add-point:BEFORE FIELD glab005
            CALL axri011_glab005_2_desc()            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE glab005
            #add-point:ON CHANGE glab005
            {<point name="input.g.page1.glab005" />}
            #END add-point

         #----<<glab011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011
            {<point name="input.b.page1.glab011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD glab011

            #add-point:AFTER FIELD glab011
            {<point name="input.a.page1.glab011" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE glab011
            #add-point:ON CHANGE glab011
            {<point name="input.g.page1.glab011" />}
            #END add-point

         #Ctrlp:input.c.page1.glab005
         ON ACTION controlp INFIELD glab005_2
            #add-point:ON ACTION controlp INFIELD glab005
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glab2_d[l_ac2].glab005_2             #給予default值
            #給予arg
            
            LET g_qryparam.where = " glac003 <> '1' AND glac001 = '",g_glab_m.glaa004,"'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_glab_m.glabld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            CALL aglt310_04()                                #呼叫開窗
            LET g_glab2_d[l_ac2].glab005_2 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_glab2_d[l_ac2].glab005_2 TO glab005              #顯示到畫面上
            CALL axri011_glab005_2_desc()
            NEXT FIELD glab005_2                          #返回原欄位
            #END add-point

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_glab2_d[l_ac2].* = g_glab2_d_t.*
               CLOSE axri011_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_glab2_d[l_ac2].glab003_2
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_glab2_d[l_ac2].* = g_glab2_d_t.*
            ELSE

               #add-point:單身修改前
               {<point name="input.body.b_update" mark="Y"/>}
               #end add-point

               UPDATE glab_t SET (glabld,glab001,glab002,glab003,glab005,glab011) = (g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002,g_glab2_d[l_ac2].glab003_2,g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab011_2)
                WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
                 AND glab001 = g_glab_m.glab001

                 AND glab002 = g_glab_m.glab002


                 AND glab003 = g_glab2_d_t.glab003_2 #項次

               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  LET g_glab2_d[l_ac2].* = g_glab2_d_t.*
               ELSE
                  #資料多語言用-增/改

               END IF

               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
            END IF

         AFTER INPUT

      END INPUT



      #add-point:input段more_input
      {<point name="input.more_inputarray"/>}
      #end add-point

      BEFORE DIALOG
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD glab002
         END IF
         CALL s_hint_show_set_comments('glab010',g_glab010_comm)
         #161018-00045#1--add--s--
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD glab005            
         END CASE
         #161018-00045#1--add--e--

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

END FUNCTION

PRIVATE FUNCTION axri011_show()
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point



   LET g_glab_m_t.* = g_glab_m.*      #保存單頭舊值

   DISPLAY BY NAME g_glab_m.glabld,g_glab_m.glabld_desc,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab002_desc,
                   g_glab_m.glaacomp,g_glab_m.glaacomp_desc,g_glab_m.glaa014,g_glab_m.glaa008,g_glab_m.glab010
   CALL axri011_b_fill(g_wc2)                 #單身
   CALL axri011_b2_fill("1=1")
   
   CALL axri011_ref_show()

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   IF g_page_flag = 'page1' THEN
      DISPLAY g_rec_b TO FORMONLY.cnt
   ELSE
      DISPLAY g_rec_b2 TO FORMONLY.cnt
   END IF
   #add-point:show段之後
   CALL s_hint_show_set_comments('glab010',g_glab010_comm)
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_ref_show()
   {<Local define>}
   DEFINE l_ac_t  LIKE type_t.num10   #l_ac暫存用
   DEFINE l_ac2_t LIKE type_t.num10
   {</Local define>}
   #add-point:ref_show段define
   {<point name="ref_show.define"/>}
   #end add-point

   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
            CALL axri011_glab002_desc()

            CALL axri011_glabld_desc()

            CALL axri011_comp_desc(g_glab_m.glabld)
          {#ADP版次:1#}
   #end add-point

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glab_d.getLength()
      #add-point:ref_show段d_reference
      CALL axri011_glab005_desc()
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glab_d[l_ac].glab003
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE  gzcbl001='8304' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glab_d[l_ac].glab003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glab_d[l_ac].glab003_desc             
      #end add-point
   END FOR

   LET l_ac = l_ac_t
   
   LET l_ac2_t = l_ac2
   FOR l_ac2 = 1 TO g_glab2_d.getLength()
      #add-point:ref_show段d_reference
      CALL axri011_glab005_2_desc()
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glab2_d[l_ac2].glab003_2
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE  gzcbl001='8304' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glab2_d[l_ac2].glab003_2_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_glab2_d[l_ac2].glab003_2_desc             
      #end add-point
   END FOR
   LET l_ac2 = l_ac2_t


END FUNCTION

PRIVATE FUNCTION axri011_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE glab_t.glabld
   DEFINE l_oldno     LIKE glab_t.glabld
   DEFINE l_newno02     LIKE glab_t.glab001
   DEFINE l_oldno02     LIKE glab_t.glab001

   DEFINE l_newno03     LIKE glab_t.glab002
   DEFINE l_oldno03     LIKE glab_t.glab002


   DEFINE l_master    RECORD LIKE glab_t.*
   DEFINE l_detail    RECORD LIKE glab_t.*
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_glaa004   LIKE glaa_t.glaa004
   DEFINE l_glaa004a  LIKE glaa_t.glaa004
   DEFINE l_ld_str    STRING #160811-00009#6 
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   IF g_glab_m.glabld IS NULL
      OR g_glab_m.glab001 IS NULL

      OR g_glab_m.glab002 IS NULL


      THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_glabld_t = g_glab_m.glabld
   LET g_glab001_t = g_glab_m.glab001

   LET g_glab002_t = g_glab_m.glab002
   LET l_glaa004a  = g_glab_m.glaa004
   CALL axri011_set_entry('a')
   CALL axri011_set_no_entry('a')

   CALL cl_set_head_visible("","YES")

      LET g_glab_m.glabld_desc = ''
   DISPLAY BY NAME g_glab_m.glabld_desc
   LET g_glab_m.glab002_desc = ''
   DISPLAY BY NAME g_glab_m.glab002_desc


   INPUT l_newno #FROM
         #,l_newno02

         ,l_newno03


    FROM glabld
        # ,glab001

         ,glab002


         ATTRIBUTE(FIELD ORDER FORM)

         BEFORE FIELD glabld
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_m.glabld_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_glab_m.glabld_desc         
            CALL axri011_comp_desc(l_newno) 
            
         AFTER FIELD glabld
           #151201-00002#57 Mark ---(S)---
           #IF NOT cl_null(l_newno) THEN
           #   SELECT glaa004
           #     INTO l_glaa004
           #     FROM glaa_t
           #    WHERE glaaent = g_enterprise
           #      AND glaald = l_newno
           #   IF l_glaa004 <> g_glab_m.glaa004 THEN 
           #      INITIALIZE g_errparam TO NULL
           #      LET g_errparam.code = 'anm-00030'
           #      LET g_errparam.extend = l_newno
           #      LET g_errparam.popup = TRUE
           #      CALL cl_err()
           #
           #      LET l_newno = l_oldno
           #      DISPLAY '' TO glaacomp
           #      DISPLAY '' TO glaa008
           #      DISPLAY '' TO glaa014
           #      DISPLAY '' TO glabld_desc
           #      DISPLAY '' TO glaacomp_desc
           #      DISPLAY '' TO glab004
           #      DISPLAY '' TO glaa004_desc                   
           #      NEXT FIELD CURRENT
           #   END IF
           #END IF  
           #151201-00002#57 Mark ---(E)---       
            #add-point:AFTER FIELD glabld
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_m.glabld_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_glab_m.glabld_desc
            CALL axri011_comp_desc(l_newno) 
            
            IF NOT cl_null(l_newno) AND NOT cl_null(l_newno03) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||l_newno||"' AND "|| "glab002 = '"||l_newno03||"' AND glab001 = '13'",'std-00004',0) THEN
                  LET l_newno = l_oldno
               #   DISPLAY '' TO glaacomp
               #   DISPLAY '' TO glaa008
               #   DISPLAY '' TO glaa014
               #   DISPLAY '' TO glabld_desc
               #   DISPLAY '' TO glaacomp_desc
               #   DISPLAY '' TO glab004
               #   DISPLAY '' TO glaa004_desc                   
                  NEXT FIELD CURRENT
               END IF
             END IF
            IF NOT cl_null(l_newno) THEN
               IF NOT ap_chk_isExist(l_newno,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN
                  LET l_newno = l_oldno
                #  DISPLAY '' TO glaacomp
                #  DISPLAY '' TO glaa008
                #  DISPLAY '' TO glaa014
                #  DISPLAY '' TO glabld_desc
                #  DISPLAY '' TO glaacomp_desc 
                #  DISPLAY '' TO glab004
                #  DISPLAY '' TO glaa004_desc                   
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(l_newno,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ?  AND glaastus = 'Y' ",'agl-00051',1) THEN   #160318-00005#50  mark
               IF NOT ap_chk_isExist(l_newno,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ?  AND glaastus = 'Y' ",'sub-01302','agli010') THEN     #160318-00005#50  add
                  LET l_newno = l_oldno
                #  DISPLAY '' TO glaacomp
                #  DISPLAY '' TO glaa008
                #  DISPLAY '' TO glaa014
                #  DISPLAY '' TO glabld_desc
                #  DISPLAY '' TO glaacomp_desc
                #  DISPLAY '' TO glab004
                #  DISPLAY '' TO glaa004_desc 
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(l_newno,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ?  AND glaastus = 'Y' AND glaa014 ='Y' ",'axr-00071',1) THEN
                  LET l_newno = l_oldno
                #  DISPLAY '' TO glaacomp
                #  DISPLAY '' TO glaa008
                #  DISPLAY '' TO glaa014
                #  DISPLAY '' TO glabld_desc
                #  DISPLAY '' TO glaacomp_desc
                #  DISPLAY '' TO glab004
                #  DISPLAY '' TO glaa004_desc 
                  NEXT FIELD CURRENT
               END IF              
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_newno
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_glab_m.glabld_desc = g_rtn_fields[1]
               DISPLAY BY NAME g_glab_m.glabld_desc              
               CALL axri011_comp_desc(l_newno)            
               
            END IF          {#ADP版次:1#}

         AFTER FIELD glab002
            #add-point:AFTER FIELD glab002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno03
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_m.glab002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glab_m.glab002_desc            
            IF NOT cl_null(l_newno03) AND NOT cl_null(l_newno) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glab001 = '13' AND "|| "glab002 = '"||l_newno03 ||"' AND "|| "glabld = '"||l_newno||"'",'std-00004',0) THEN
                  LET l_newno03 = l_oldno03
                  DISPLAY '' TO glab002
                  DISPLAY '' TO glab002_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF NOT cl_null(l_newno03) THEN 
#               IF NOT ap_chk_isExist(l_newno03,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' ",'apm-00181',1) THEN  #160318-00005#50 mark
               IF NOT ap_chk_isExist(l_newno03,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' ",'sub-01303','axri010') THEN   #160318-00005#50 add
                  LET l_newno03 = l_oldno03
                  DISPLAY '' TO glab002
                  DISPLAY '' TO glab002_desc                   
                  NEXT FIELD CURRENT
               END IF
#               IF NOT ap_chk_isExist(l_newno03,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' AND oocqstus = 'Y' ",'apm-00182',1) THEN   ##160318-00005#50 mark 
               IF NOT ap_chk_isExist(l_newno03,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3111' AND oocqstus = 'Y' ",'sub-01302','axri010') THEN    ##160318-00005#50 add
                  LET l_newno03 = l_oldno03
                  DISPLAY '' TO glab002     
                  DISPLAY '' TO glab002_desc                  
                  NEXT FIELD CURRENT
               END IF                
            END IF
            #END add-point



      #add-point:複製段落開窗/欄位控管/自定義action
          ON ACTION controlp INFIELD glabld
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str #160811-00009#6
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_newno             #給予default值
           #LET g_qryparam.where = " glaa014 ='Y' AND glaa004 ='",l_glaa004a,"'"   #151201-00002#57 Mark
            #LET g_qryparam.where = " glaa014 ='Y' " #160811-00009#6
            LET g_qryparam.where = l_ld_str CLIPPED,"AND (glaa014 ='Y' OR glaa008 = 'Y')"  #160811-00009#6 #151201-00002#57 Add  #161026-00012#1 Add AND
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                #呼叫開窗
            LET l_newno = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY l_newno TO glabld              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_m.glabld_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_glab_m.glabld_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_m.glabld_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_glab_m.glabld_desc              
            CALL axri011_comp_desc(l_newno)   
               
            NEXT FIELD glabld                          #返回原欄位

         ON ACTION controlp INFIELD glab002
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_newno03            #給予default值
            #給予arg
            LET g_qryparam.arg1 = "3111" 
            CALL q_oocq002()                                #呼叫開窗
            LET l_newno03 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY l_newno03 TO glab002              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno03
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_m.glab002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glab_m.glab002_desc              
            NEXT FIELD glab002                          #返回原欄位

      #end add-point

      BEFORE INPUT
         #add-point:複製段落Before input
         LET l_newno02 = '13'
         #end add-point

      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
         IF l_newno IS NULL
            OR l_newno02 IS NULL

            OR l_newno03 IS NULL


            THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00006"
         LET g_errparam.extend = "Reproduce"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         NEXT FIELD glab002
         END IF
         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM glab_t
          WHERE glabent = g_enterprise AND glabld = l_newno
            AND glab001 = l_newno02

            AND glab002 = l_newno03


         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00006"
         LET g_errparam.extend = "Reproduce"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            #NEXT FIELD glabld
         END IF

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT
   END INPUT

   IF INT_FLAG OR l_newno IS NULL THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

   LET g_sql = "SELECT * FROM glab_t WHERE glabent = '" ||g_enterprise|| "' AND ",
               " glabld = '",g_glab_m.glabld,"'"
              ," AND glab001 = '",g_glab_m.glab001,"'"

              ," AND glab002 = '",g_glab_m.glab002,"'"


   DECLARE axri011_reproduce CURSOR FROM g_sql

   FOREACH axri011_reproduce INTO l_detail.*

      LET l_detail.glabld = l_newno
      LET l_detail.glab001 = l_newno02

      LET l_detail.glab002 = l_newno03



      #公用欄位給予預設值


      #add-point:單身複製前

     #151201-00002#57 Add  ---(S)---
      SELECT glaa004 INTO l_glaa004  FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_newno

      SELECT glaa004 INTO l_glaa004a FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_glab_m.glabld

      LET l_cnt = 0
      SELECT COUNT(*) INTo l_cnt FROM glad_t WHERE gladent = g_enterprise
         AND gladld  = l_newno
         AND glad001 = l_detail.glab005
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN LET l_detail.glab005 = '' END IF

     #151201-00002#57 Add  ---(E)---

      #end add-point
      INSERT INTO glab_t VALUES (l_detail.*) #複製單身
      #add-point:單身複製中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後
      {<point name="reproduce.body.a_insert"/>}
      #end add-point
   END FOREACH

   CALL s_transaction_end('Y','0')
   ERROR 'ROW(',l_newno,') O.K'
   CLOSE axri011_reproduce

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " glabld = '", l_newno CLIPPED, "' "
              ," AND glab001 = '", l_newno02 CLIPPED, "' "

              ," AND glab002 = '", l_newno03 CLIPPED, "' "


              , ") "

   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point
   IF NOT s_ld_chk_authorization(g_user,g_glab_m.glabld) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glab_m.glabld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN              
   END IF 
   IF g_glab_m.glabld IS NULL
   OR g_glab_m.glab001 IS NULL

   OR g_glab_m.glab002 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE glabld,glab001,glab002
 INTO g_glab_m.glabld,g_glab_m.glab001,g_glab_m.glab002
 FROM glab_t
 WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = g_glab_m.glab001 AND glab002 = g_glab_m.glab002
   CALL s_transaction_begin()



   OPEN axri011_cl USING g_enterprise,g_glab_m.glabld
                                                       #,g_glab_m.glab001

                                                       ,g_glab_m.glab002


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axri011_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE axri011_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH axri011_cl INTO g_glab_m.glabld,g_glab_m.glabld_desc,g_glab_m.glab001,g_glab_m.glab002,g_glab_m.glab002_desc,g_glab_m.glaacomp,g_glab_m.glaacomp_desc,g_glab_m.glaa014,g_glab_m.glaa008

   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_glab_m.glabld
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL axri011_show()

   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "glabld"
      LET g_doc.value1 = g_glab_m.glabld
      CALL cl_doc_remove()

      #add-point:單身刪除前
      {<point name="delete.body.b_delete" mark="Y"/>}
      #end add-point

      DELETE FROM glab_t WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld
                                                               AND glab001 = g_glab_m.glab001
                                                               AND glab002 = g_glab_m.glab002
                                                               AND glab003 LIKE '8304%'   #161028-00046#1 add



      #add-point:單身刪除中
      {<point name="delete.body.m_delete"/>}
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "glab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF



      #add-point:單身刪除後
      {<point name="delete.body.a_delete"/>}
      #end add-point

      CLEAR FORM
      CALL g_glab_d.clear()


      CALL axri011_ui_browser_refresh()
      CALL axri011_ui_headershow()
      CALL axri011_ui_detailshow()

      IF g_browser_cnt > 0 THEN
         CALL axri011_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL axri011_browser_fill("F")
      END IF

   END IF

   CLOSE axri011_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_glab_m.glabld,'D')

END FUNCTION

PRIVATE FUNCTION axri011_b_fill(p_wc2)
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   #先清空單身變數內容
   CALL g_glab_d.clear()


   #add-point:b_fill段define

   #end add-point

   LET g_sql = "SELECT glab003,'',glab005,'',glab011 FROM glab_t WHERE glabent= ? AND glabld=? AND glab001='13' AND glab002=?"
   LET g_sql = g_sql," AND glab003 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8304' AND gzcb003 = '1') "  
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY glab_t.glabld,glab_t.glab001,glab_t.glab002,glab_t.glab003"

   PREPARE axri011_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR axri011_pb

   LET g_cnt = l_ac
   LET l_ac = 1

   OPEN b_fill_cs USING g_enterprise,g_glab_m.glabld
                                           # ,g_glab_m.glab001

                                            ,g_glab_m.glab002



   FOREACH b_fill_cs INTO g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab003_desc,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab005_desc,g_glab_d[l_ac].glab011


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      {<point name="b_fill.fill"/>}
      #end add-point

      #帶出公用欄位reference值






      #add-point:單身資料抓取
      {<point name="bfill.foreach"/>}
      #end add-point

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_glab_d.deleteElement(l_ac)


   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE axri011_pb

END FUNCTION

PRIVATE FUNCTION axri011_before_delete()
   #add-point:before_delete段define
   {<point name="before_delete.define"/>}
   #end add-point

   #add-point:單筆刪除前
   {<point name="delete.body.b_single_delete" mark="Y"/>}
   #end add-point

   DELETE FROM glab_t
    WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND
                              glab001 = g_glab_m.glab001 AND

                              glab002 = g_glab_m.glab002 AND


          glab003 = g_glab_d_t.glab003


   #add-point:單筆刪除中
   {<point name="delete.body.m_single_delete"/>}
   #end add-point

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF

   #add-point:單筆刪除後
   {<point name="delete.body.a_single_delete"/>}
   #end add-point

   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION axri011_delete_b(p_total)
   {<Local define>}
   DEFINE p_total LIKE type_t.num10    #161108-00019#2 mod type_t.num5 -> type_t.num10
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point



   IF p_total = g_glab_d.getLength() THEN
      CALL g_glab_d.deleteElement(l_ac)
   END IF

END FUNCTION

PRIVATE FUNCTION axri011_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glabld,glab001,glab002",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("glabld,glab001,glab002",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point

   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point

   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b段"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axri011_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point

   LET g_pagestart = 1

   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " glabld = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glab001 = ", g_argv[02], " AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glab002 = ", g_argv[03], " AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF

   #add-point:default_search段結束前

   #end add-point

END FUNCTION
#+ 單身資料的更新同步
PRIVATE FUNCTION axri011_b_upd()
#161128-00061#3-----modify--begin----------
#DEFINE l_glab    RECORD LIKE glab_t.*
DEFINE l_glab RECORD  #帳套應用會計科目設定檔
       glabent LIKE glab_t.glabent, #企業編號
       glabld LIKE glab_t.glabld, #帳套
       glab001 LIKE glab_t.glab001, #設定類型
       glab002 LIKE glab_t.glab002, #分類碼
       glab003 LIKE glab_t.glab003, #分類碼值
       glab004 LIKE glab_t.glab004, #科目參照表編號
       glab005 LIKE glab_t.glab005, #會計科目編號一
       glab006 LIKE glab_t.glab006, #會計科目編號二
       glab007 LIKE glab_t.glab007, #會計科目編號三
       glab008 LIKE glab_t.glab008, #會計科目編號四
       glab009 LIKE glab_t.glab009, #會計科目編號五
       glab010 LIKE glab_t.glab010, #其他設定值
       glab011 LIKE glab_t.glab011, #科目彙總方式
       glab012 LIKE glab_t.glab012, #会计科目编号六
       glab013 LIKE glab_t.glab013, #會計科目編號七
       glab014 LIKE glab_t.glab014, #代收銀據點
       glab015 LIKE glab_t.glab015, #據點帳套
       glab016 LIKE glab_t.glab016  #代收銀收款科目(流通)
       END RECORD

#161128-00061#3-----modify--end----------
DEFINE l_sql     STRING
DEFINE l_success LIKE type_t.chr1


   SELECT glaa004
     INTO l_glab.glab004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glab_m.glabld
      
   LET l_glab.glabent = g_enterprise
   LET l_glab.glabld  = g_glab_m.glabld
   LET l_glab.glab002 = g_glab_m.glab002
   LET l_glab.glab001 = '13'
   LET l_glab.glab005 = '' 
   LET l_glab.glab006 = ''
   LET l_glab.glab007 = ''
   LET l_glab.glab008 = ''
   LET l_glab.glab009 = ''
   LET l_glab.glab010 = g_glab_m.glab010
   LET l_glab.glab011 = '1'
   
   CALL s_transaction_begin()
   LET l_sql = " DELETE FROM glab_t WHERE glabent = '",g_enterprise,"'",
              "   AND glabld = '",g_glab_m.glabld,"' AND glab002 = '",g_glab_m.glab002,"' AND glab001 ='13' ",
              "   AND glab003 NOT IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 ='8304')" 
             ,"   AND glab003 LIKE '8304%' "   #161028-00046#1 add 
   PREPARE glab_del FROM l_sql
   EXECUTE glab_del
   
   LET l_success = 'Y'
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 ='8304' ",
               "   AND gzcb002 NOT IN (SELECT glab003 FROM glab_t WHERE glabent = '",g_enterprise,"'",
               "   AND glabld = '",g_glab_m.glabld,"' AND glab002 = '",g_glab_m.glab002,"' AND glab001 ='13')" 
   	PREPARE glab_ins_pre FROM l_sql
   	DECLARE glab_ins CURSOR FOR glab_ins_pre
   	FOREACH glab_ins INTO l_glab.glab003
   	
   	#161128-00061#3-----modify--begin----------
   	#INSERT INTO glab_t VALUES l_glab.*
   	INSERT INTO glab_t (glabent,glabld,glab001,glab002,glab003,glab004,glab005,glab006,glab007,
   	                    glab008,glab009,glab010,glab011,glab012,glab013,glab014,glab015,glab016) 
   	 VALUES (l_glab.glabent,l_glab.glabld,l_glab.glab001,l_glab.glab002,l_glab.glab003,l_glab.glab004,l_glab.glab005,l_glab.glab006,l_glab.glab007,
   	         l_glab.glab008,l_glab.glab009,l_glab.glab010,l_glab.glab011,l_glab.glab012,l_glab.glab013,l_glab.glab014,l_glab.glab015,l_glab.glab016)
   	#161128-00061#3-----modify--end----------
  	   IF SQLCA.SQLcode THEN
          LET l_success = 'N'
          EXIT FOREACH
       END IF     
   	END FOREACH
    IF l_success = 'N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "glab_t"
       LET g_errparam.popup = TRUE
       CALL cl_err()
  
       CALL s_transaction_end('N','0')                    
    ELSE
       CALL s_transaction_end('Y','0')
    END IF    
END FUNCTION
#+ 法人顯示
PRIVATE FUNCTION axri011_comp_desc(p_glabld)
DEFINE p_glabld  LIKE glab_t.glabld   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glabld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa008,glaa014,glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_glab_m.glaacomp = g_rtn_fields[1]
   LET g_glab_m.glaa008 = g_rtn_fields[2]
   LET g_glab_m.glaa014 = g_rtn_fields[3]
   LET g_glab_m.glaa004 = g_rtn_fields[4]
   DISPLAY BY NAME g_glab_m.glaacomp,g_glab_m.glaa008,g_glab_m.glaa014,g_glab_m.glaa004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glab_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab_m.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_glab_m.glaacomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glab_m.glaa004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='0' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab_m.glaa004_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_glab_m.glaa004_desc 

END FUNCTION
#+ 款別顯示
PRIVATE FUNCTION axri011_glabld_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glab_m.glabld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab_m.glabld_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_glab_m.glabld_desc
END FUNCTION
#+
PRIVATE FUNCTION axri011_glab002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glab_m.glab002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab_m.glab002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glab_m.glab002_desc
END FUNCTION
#+ 科目顯示
PRIVATE FUNCTION axri011_glab005_desc()
     
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glab_m.glaa004
   LET g_ref_fields[2] = g_glab_d[l_ac].glab005
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab_d[l_ac].glab005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glab_d[l_ac].glab005_desc     
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
PRIVATE FUNCTION axri011_glab005_2_desc()
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glab_m.glaa004
   LET g_ref_fields[2] = g_glab2_d[l_ac2].glab005_2
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab2_d[l_ac2].glab005_2_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glab2_d[l_ac2].glab005_2_desc 
END FUNCTION
################################################################################
# Descriptions...: 單身2填充
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
PRIVATE FUNCTION axri011_b2_fill(p_wc2)
   DEFINE p_wc2      STRING


   #先清空單身變數內容
   CALL g_glab2_d.clear()

   LET g_sql = "SELECT glab003,'',glab005,'',glab011 FROM glab_t WHERE glabent= ? AND glabld=? AND glab001='13' AND glab002=?"
   LET g_sql = g_sql," AND glab003 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8304' AND gzcb003 = '2') "  
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY glab_t.glabld,glab_t.glab001,glab_t.glab002,glab_t.glab003"

   PREPARE axri011_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR axri011_pb2

   LET g_cnt = l_ac2
   LET l_ac2 = 1

   OPEN b_fill_cs2 USING g_enterprise,g_glab_m.glabld
                                           # ,g_glab_m.glab001

                                            ,g_glab_m.glab002



   FOREACH b_fill_cs2 INTO g_glab2_d[l_ac2].glab003_2,g_glab2_d[l_ac2].glab003_2_desc,g_glab2_d[l_ac2].glab005_2,g_glab2_d[l_ac2].glab005_2_desc,g_glab2_d[l_ac2].glab011_2


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_glab2_d.deleteElement(l_ac2)


   LET g_rec_b2=l_ac2-1
   DISPLAY g_rec_b2 TO FORMONLY.cnt
   LET l_ac2 = g_cnt
   LET g_cnt = 0

   FREE axri011_pb2
END FUNCTION
################################################################################
# Descriptions...: 重組 apca010的字串
# Memo...........:
# Usage..........: CALL axri011_glab010_str(p_wc)
# Date & Author..: 2014/12/19 By zhangwei
# Modify.........:
################################################################################
PRIVATE FUNCTION axri011_glab010_str(p_wc)
   DEFINE tok            base.stringtokenizer
   DEFINE p_wc           STRING

   WHENEVER ERROR CONTINUE
   LET p_wc = cl_replace_str(p_wc,"|",",@")
   RETURN p_wc

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axri011_glabld_chk()
# Date & Author..: 2016/08/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axri011_glabld_chk()
   DEFINE l_glaastus  LIKE glaa_t.glaastus
   DEFINE l_glaa008   LIKE glaa_t.glaa008  
   DEFINE l_glaa014   LIKE glaa_t.glaa014 
   
   LET g_errno = ''
   SELECT glaastus,glaa008,glaa014 INTO l_glaastus,l_glaa008,l_glaa014 FROM glaa_t 
    WHERE glaaent = g_enterprise
      AND glaald = g_glab_m.glabld
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'      
      #WHEN l_glaa014 = 'N'       LET g_errno = 'axr-00071'  #160811-00009#6 
      WHEN l_glaa014 = 'N' AND l_glaa008 = 'N'  LET g_errno = 'axr-00021'   #160811-00009#6       
   END CASE
END FUNCTION

#end add-point
 
{</section>}
 
