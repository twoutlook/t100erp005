#該程式未解開Section, 採用最新樣板產出!
{<section id="axmi171.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-03-14 10:52:54), PR版次:0009(2017-01-06 17:04:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000175
#+ Filename...: axmi171
#+ Description: 集團預測銷售組織設定作業
#+ Creator....: 02295(2014-03-05 14:35:46)
#+ Modifier...: 02295 -SD/PR- 00700
 
{</section>}
 
{<section id="axmi171.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#47 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161108-00013#1  2016/11/08 By 07024   與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161214-00032#2 2016/12/15  by 07900   石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#170104-00066#3  2017/01/06 By Rainy     筆數相關變數由num5放大至num10
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
 TYPE type_g_xmij_m RECORD
       xmij001 LIKE xmij_t.xmij001,
   xmij001_desc LIKE type_t.chr80,
   xmij002 LIKE xmij_t.xmij002,
   xmij003 LIKE xmij_t.xmij003,
   xmij004 LIKE xmij_t.xmij004,
   xmij005 LIKE xmij_t.xmij005,
   xmij006 LIKE xmij_t.xmij006,
   xmij007 LIKE xmij_t.xmij007,
   xmij008 LIKE xmij_t.xmij008,
   xmij009 LIKE xmij_t.xmij009,
   xmij010 LIKE xmij_t.xmij010,
   xmij011 LIKE xmij_t.xmij011,
   xmijstus LIKE xmij_t.xmijstus,
   xmijownid LIKE xmij_t.xmijownid,
   xmijownid_desc LIKE type_t.chr80,
   xmijowndp LIKE xmij_t.xmijowndp,
   xmijowndp_desc LIKE type_t.chr80,
   xmijcrtid LIKE xmij_t.xmijcrtid,
   xmijcrtid_desc LIKE type_t.chr80,
   xmijcrtdp LIKE xmij_t.xmijcrtdp,
   xmijcrtdp_desc LIKE type_t.chr80,
   xmijcrtdt DATETIME YEAR TO SECOND,
   xmijmodid LIKE xmij_t.xmijmodid,
   xmijmodid_desc LIKE type_t.chr80,
   xmijmoddt DATETIME YEAR TO SECOND
       END RECORD

#模組變數(Module Variables)
DEFINE g_xmij_m        type_g_xmij_m
DEFINE g_xmij_m_t      type_g_xmij_m                #備份舊值
DEFINE g_xmij001_t LIKE xmij_t.xmij001

DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位
                #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5,
       #tree自定義欄位
       b_ooed001       LIKE ooed_t.ooed001,
       b_ooed002       LIKE ooed_t.ooed002,
       b_ooed003       LIKE ooed_t.ooed003,
       b_ooed004       LIKE ooed_t.ooed004,
       b_ooed005       LIKE ooed_t.ooed005,
       b_xmij002       LIKE xmij_t.xmij002,
       b_xmij003       LIKE xmij_t.xmij003
      END RECORD

#無單頭append欄位定義
DEFINE g_browser2    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位
       b_xmij001       LIKE xmij_t.xmij001
      END RECORD
      
      
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING                        #組 sql 用
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗
#161108-00013#1-s-mod
#DEFINE g_rec_b               LIKE type_t.num5              #單身筆數
#DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_ch                  base.Channel                  #外串程式用
#DEFINE g_state               STRING
#DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#DEFINE g_error_show          LIKE type_t.num5
#DEFINE g_aw                  STRING             #確定當下點擊的單身
#
##快速搜尋用
#DEFINE g_searchcol           STRING             #查詢欄位代碼
#DEFINE g_searchstr           STRING             #查詢欄位字串
#DEFINE g_order               STRING             #查詢排序模式
#
##Browser用
#DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
#DEFINE g_current_row         LIKE type_t.num5   #Browser 所在筆數(暫存用)
#DEFINE g_current_cnt         LIKE type_t.num5  #Browser 總筆數(當下page)
#DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)
#DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數(所有資料)  
#DEFINE g_tmp_page            LIKE type_t.num5
#DEFINE g_row_index           LIKE type_t.num5
#DEFINE g_chk                 BOOLEAN
#DEFINE g_browser_root        DYNAMIC ARRAY OF INTEGER
#DEFINE g_current_idx2        LIKE type_t.num5  
#DEFINE g_row_index2          LIKE type_t.num5
#DEFINE g_current_row2        LIKE type_t.num5
#DEFINE g_browser_cnt2        LIKE type_t.num5  
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_aw                  STRING             #確定當下點擊的單身

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num10   #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10   #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10   #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10   #Browser 總筆數(所有資料)  
DEFINE g_tmp_page            LIKE type_t.num10
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_chk                 BOOLEAN
DEFINE g_browser_root        DYNAMIC ARRAY OF INTEGER
DEFINE g_current_idx2        LIKE type_t.num10  
DEFINE g_row_index2          LIKE type_t.num10
DEFINE g_current_row2        LIKE type_t.num10
DEFINE g_browser_cnt2        LIKE type_t.num10 
#161108-00013#1-e-mod
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="axmi171.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT xmij001,'',xmij002,xmij003,xmij004,xmij005,xmij006,xmij007,xmij008,",
                      "       xmij009,xmij010,xmij011 ",
                      "  FROM xmij_t WHERE xmijent = ? AND xmij001=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE axmi171_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmi171 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmi171_init()
 
      #進入選單 Menu (='N')
      CALL axmi171_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_axmi171
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axmi171.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axmi171_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point

   LET g_main_hidden = 0
      CALL cl_set_combo_scc_part('xmijstus','17','N,Y')


   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #add-point:畫面資料初始化
   {<point name="init.init" />}
   #end add-point

   CALL axmi171_default_search()

END FUNCTION

PRIVATE FUNCTION axmi171_browser_fill()
DEFINE l_n        LIKE type_t.num5
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE l_sql      STRING
DEFINE l_n2       LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   CALL g_browser.clear()
   LET g_cnt = 1
   LET l_n = 1
   #第一層的資料
   LET l_sql = " SELECT UNIQUE ooed002,ooed003,xmij002,xmij003 FROM ooed_t ",
               "  LEFT OUTER JOIN xmij_t ON ooedent = xmijent AND ooed002 = xmij001 ",
               "  WHERE ooedent = '",g_enterprise,"'",
               "    AND ooed001 = '2' ",     #mod xianghui 7->2
               "    AND ooed006 <= '",g_today,"' ",
               "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' )  ",
               "  ORDER BY ooed002 "
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   LET l_sql = " SELECT UNIQUE ooed004,ooed003,xmij002,xmij003 FROM ooed_t ",
               "  LEFT OUTER JOIN xmij_t ON ooedent = xmijent AND ooed004 = xmij001 ",
               "  WHERE ooedent = '",g_enterprise,"'",
               "    AND ooed001 = '2' ",    #mod xianghui 7->2
               "    AND ooed006 <= '",g_today,"' ",
               "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' )  ",
               "    AND ooed002 = ? ",
               "    AND ooed003 = ? ",
               "    AND ooed002 = ooed005 ",
               "    AND ooed004 <> ooed005 ",
               "  ORDER BY ooed004 "
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1

   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1
   FOREACH master_typecur_0 INTO g_browser[l_ac].b_ooed002,g_browser[l_ac].b_ooed003,g_browser[l_ac].b_xmij002,g_browser[l_ac].b_xmij003
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_ooed002 = g_browser[l_ac].b_ooed002
      LET g_browser[l_ac].b_ooed004 = g_browser[l_ac].b_ooed002
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      LET g_browser[l_ac].b_isExp = TRUE
      #第一層節點編號
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET l_ac = l_ac + 1
      LET g_cnt = l_ac
      FOREACH master_typecur_1 USING g_browser[l_ac-1].b_ooed002,g_browser[l_ac-1].b_ooed003 INTO g_browser[g_cnt].b_ooed004,g_browser[g_cnt].b_ooed003,g_browser[g_cnt].b_xmij002,g_browser[g_cnt].b_xmij003
         LET g_browser[g_cnt].b_ooed002 = g_browser[l_ac-1].b_ooed002
         LET g_browser[g_cnt].b_ooed004 = g_browser[g_cnt].b_ooed004
         LET g_browser[g_cnt].b_ooed005 = g_browser[l_ac-1].b_ooed004
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = TRUE
         LET g_browser[g_cnt].b_hasC = axmi171_chk_hasC(g_cnt)
         IF g_browser[g_cnt].b_hasC = 1 THEN
            CALL axmi171_browser_expand(g_cnt)
            LET g_cnt = g_browser.getLength()
         END IF
         LET g_cnt = g_cnt +1
      END FOREACH
      LET l_ac = g_browser.getLength()
   END FOREACH
   LET l_ac = l_ac - 1
   CALL g_browser.deleteElement(l_ac+1)
   FOR l_ac = 1 TO g_browser.getLength()
       CALL axmi171_desc_show(l_ac)
   END FOR

   LET g_browser_cnt2 = g_browser.getLength() - g_browser_root.getLength()

   FREE master_type_0
   FREE master_type_1
   
   FOR l_n2 = 1 TO g_browser.getLength()
       IF g_browser[l_n2].b_isExp is null THEN
         CALL axmi171_browser_expand(l_n2)
      END IF
   END FOR
END FUNCTION

PRIVATE FUNCTION axmi171_ui_dialog()
   {<Local define>}
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10   #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_current_idx2 = 1

   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL axmi171_insert()
            #add-point:ON ACTION insert
            {<point name="menu.default.insert" />}
            #END add-point
         END IF

      #add-point:action default自訂
      {<point name="ui_dialog.action_default"/>}
      #end add-point
      OTHERWISE

   END CASE



   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE li_exit = FALSE

      CALL axmi171_browser_fill()
      CALL axmi171_browser2_fill(g_wc,"")
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_ooed004 = g_xmij001_t
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      IF g_main_hidden = 2 THEN
         MENU
            BEFORE MENU

               CALL cl_navigator_setting(g_current_idx, g_current_cnt)

               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF

               #當每次點任一筆資料都會需要用到
               IF g_browser_cnt > 0 THEN
                  CALL axmi171_fetch("")
               END IF

            ON ACTION statechange
               CALL axmi171_statechange()
               LET g_action_choice="statechange"

            ON ACTION first
               CALL axmi171_fetch("F")
               LET g_current_row = g_current_idx

            ON ACTION next
               CALL axmi171_fetch("N")
               LET g_current_row = g_current_idx

            ON ACTION jump
               CALL axmi171_fetch("/")
               LET g_current_row = g_current_idx

            ON ACTION previous
               CALL axmi171_fetch("P")
               LET g_current_row = g_current_idx

            ON ACTION last
               CALL axmi171_fetch("L")
               #CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               #CALL fgl_set_arr_curr(g_current_idx)
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

            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            ON ACTION controls
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet_detail",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet_detail",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden
               END IF



         ON ACTION delete

            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmi171_delete()
               #add-point:ON ACTION delete
               {<point name="menu2.delete" />}
               #END add-point
            END IF


         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi171_insert()
               #add-point:ON ACTION insert
               {<point name="menu2.insert" />}
               #END add-point
               EXIT MENU
            END IF


         ON ACTION modify

            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL axmi171_modify()
               #add-point:ON ACTION modify
               {<point name="menu2.modify" />}
               #END add-point
               EXIT MENU
            END IF


         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu2.output" />}
               #END add-point
               EXIT MENU
            END IF


         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmi171_query()
               #add-point:ON ACTION query
               {<point name="menu2.query" />}
               #END add-point
            END IF


         ON ACTION reproduce

            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmi171_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu2.reproduce" />}
               #END add-point
               EXIT MENU
            END IF




            ON ACTION related_document
               CALL cl_doc()

            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"

         END MENU

      ELSE

         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

            INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
               BEFORE INPUT

            END INPUT

            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx2 = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx2 = 0 THEN
                     LET g_current_idx2 = 1
                  END IF
                  LET g_current_row2 = g_current_idx2  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()

                  #當每次點任一筆資料都會需要用到
                  CALL axmi171_fetch("")

               ON EXPAND (g_row_index2)
                  #樹展開
                  CALL axmi171_browser_expand(g_row_index2)
                  LET g_browser[g_row_index2].b_isExp = 1

               ON COLLAPSE (g_row_index2)
                  #樹關閉

            END DISPLAY


            #add-point:ui_dialog段define
            {<point name="ui_dialog.more_displayarray"/>}
            #end add-point

            BEFORE DIALOG
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #LET g_page = "first"
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF

               #當每次點任一筆資料都會需要用到
               IF g_browser_cnt > 0 THEN
                  CALL axmi171_fetch("")
               END IF

            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               {<point name="ui_dialog.after_dialog"/>}
               #end add-point

            ON ACTION statechange
               CALL axmi171_statechange()
               LET g_action_choice="statechange"
               EXIT DIALOG


            ON ACTION first
               CALL axmi171_fetch("F")
               LET g_current_row = g_current_idx

            ON ACTION next
               CALL axmi171_fetch("N")
               LET g_current_row = g_current_idx

            ON ACTION jump
               CALL axmi171_fetch("/")
               LET g_current_row = g_current_idx

            ON ACTION previous
               CALL axmi171_fetch("P")
               LET g_current_row = g_current_idx

            ON ACTION last
               CALL axmi171_fetch("L")
               #CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               #CALL fgl_set_arr_curr(g_current_idx)
               LET g_current_row = g_current_idx

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

            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 1
               END IF

            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            ON ACTION controls
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet_detail",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet_detail",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden
               END IF

            #快速搜尋
            ON ACTION searchdata
               LET g_current_idx = 1
               LET g_searchstr = GET_FLDBUF(searchstr)
               CALL axmi171_browser_search()
               EXIT DIALOG



         ON ACTION delete

            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmi171_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF


         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi171_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
               EXIT DIALOG
            END IF


         ON ACTION modify

            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL axmi171_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
               EXIT DIALOG
            END IF


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
               CALL axmi171_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF


         ON ACTION reproduce

            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmi171_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
               EXIT DIALOG
            END IF




            ON ACTION related_document
               CALL cl_doc()

            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"

         END DIALOG

      END IF

   END WHILE

END FUNCTION

PRIVATE FUNCTION axmi171_browser_expand(pi_id)
DEFINE pi_id          LIKE type_t.num10
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
   IF g_browser[pi_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET g_browser[pi_id].b_isExp = 1 
   LET l_return = FALSE
 
   LET l_keyvalue = g_browser[pi_id].b_ooed004
   
         
   LET l_sql = "SELECT UNIQUE ooed004,ooed003,xmij002,xmij003 ",
               "  FROM ooed_t ",
               "  LEFT OUTER JOIN xmij_t ON ooedent = xmijent AND ooed004 = xmij001 ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed005 = '",l_keyvalue,"' ",
               "   AND ooed004 <> ooed005",
               "   AND ooed001 = '2'", #mod xianghui 7->2
               "   AND ooed006 <= '",g_today,"' ",
               "   AND ooed002 = '",g_browser[pi_id].b_ooed002,"' ",
               "   AND ooed003 = '",g_browser[pi_id].b_ooed003,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ",
               " ORDER BY ooed004"
   
   PREPARE tree_expand1 FROM l_sql
   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1
  
   LET l_id = pi_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur1 INTO g_browser[l_id].b_ooed004,g_browser[l_id].b_ooed003,g_browser[l_id].b_xmij002,g_browser[l_id].b_xmij003
      IF cl_null(g_browser[l_id].b_ooed004) THEN
         EXIT FOREACH
      END IF
      #pid=父節點id
      LET g_browser[l_id].b_pid  = g_browser[pi_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id  = g_browser[pi_id].b_id||"."||l_cnt
      LET g_browser[l_id].b_exp = TRUE
      LET g_browser[l_id].b_ooed005 = g_browser[pi_id].b_ooed004
      LET g_browser[l_id].b_ooed002 = g_browser[pi_id].b_ooed002
      #hasC=確認該節點是否有子孫
      CALL axmi171_desc_show(l_id)
      LET g_browser[l_id].b_hasC = axmi171_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   LET l_cnt = l_cnt -1
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
END FUNCTION

PRIVATE FUNCTION axmi171_desc_show(pi_ac)
DEFINE pi_ac          LIKE type_t.num10  #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE li_tmp         LIKE type_t.num10  #170104-00066#3 num5->num10  17/01/06 mod by rainy 
DEFINE l_ooed004_desc LIKE type_t.chr80 
DEFINE ls_msg         STRING

   LET li_tmp = l_ac
   LET l_ac = pi_ac
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   
   IF cl_null(g_browser[l_ac].b_ooed004) AND cl_null(g_browser[l_ac].b_ooed005) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET l_ooed004_desc = g_rtn_fields[1]
      LET ls_msg = cl_getmsg("aoo-00232",g_lang)
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed002,' (',l_ooed004_desc,')','(',ls_msg,g_browser[l_ac].b_ooed003,')'
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET l_ooed004_desc = g_rtn_fields[1]
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed004,' (',l_ooed004_desc,')'
   END IF
   
END FUNCTION

PRIVATE FUNCTION axmi171_browser_search()
   {<Local define>}
   DEFINE ls_wc       STRING   #若有輸入g_searchstr時用來代換g_wc的暫存變數
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #END add-point

   IF NOT cl_null(g_searchstr) THEN
      LET ls_wc = " lower(", g_searchcol, ") LIKE '", g_searchstr, "%'"
      LET ls_wc = ls_wc.toLowerCase()
   ELSE
      LET ls_wc = " 1=1 "
   END IF

   LET g_wc = ls_wc

END FUNCTION

PRIVATE FUNCTION axmi171_construct()
   {<Local define>}
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   #CLEAR FORM
   INITIALIZE g_xmij_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1

   LET g_qryparam.state = "c"

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON xmij001,xmij002,xmij003,xmij004,xmij005,xmij006,xmij007,xmij008,
          xmij009,xmij010,xmij011,xmijstus,xmijownid,xmijowndp,xmijcrtid,xmijcrtdp,xmijcrtdt,xmijmodid,
          xmijmoddt

         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.before_construct"/>}
            #end add-point

         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<xmijownid>>----
         #ON ACTION controlp INFIELD xmijownid
         #   CALL q_common('xmij_t','xmijownid',TRUE,FALSE,g_xmij_m.xmijownid) RETURNING ls_return
         #   DISPLAY ls_return TO xmijownid
         #   NEXT FIELD xmijownid
         #
         ##----<<xmijowndp>>----
         #ON ACTION controlp INFIELD xmijowndp
         #   CALL q_common('xmij_t','xmijowndp',TRUE,FALSE,g_xmij_m.xmijowndp) RETURNING ls_return
         #   DISPLAY ls_return TO xmijowndp
         #   NEXT FIELD xmijowndp
         #
         ##----<<xmijcrtid>>----
         #ON ACTION controlp INFIELD xmijcrtid
         #   CALL q_common('xmij_t','xmijcrtid',TRUE,FALSE,g_xmij_m.xmijcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO xmijcrtid
         #   NEXT FIELD xmijcrtid
         #
         ##----<<xmijcrtdp>>----
         #ON ACTION controlp INFIELD xmijcrtdp
         #   CALL q_common('xmij_t','xmijcrtdp',TRUE,FALSE,g_xmij_m.xmijcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO xmijcrtdp
         #   NEXT FIELD xmijcrtdp
         #
         ##----<<xmijmodid>>----
         #ON ACTION controlp INFIELD xmijmodid
         #   CALL q_common('xmij_t','xmijmodid',TRUE,FALSE,g_xmij_m.xmijmodid) RETURNING ls_return
         #   DISPLAY ls_return TO xmijmodid
         #   NEXT FIELD xmijmodid
         #
         ##----<<xmijcnfid>>----
         ##ON ACTION controlp INFIELD xmijcnfid
         ##   CALL q_common('xmij_t','xmijcnfid',TRUE,FALSE,g_xmij_m.xmijcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO xmijcnfid
         ##   NEXT FIELD xmijcnfid
         #
         ##----<<xmijpstid>>----
         ##ON ACTION controlp INFIELD xmijpstid
         ##   CALL q_common('xmij_t','xmijpstid',TRUE,FALSE,g_xmij_m.xmijpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO xmijpstid
         ##   NEXT FIELD xmijpstid

         ##----<<xmijcrtdt>>----
         AFTER FIELD xmijcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<xmijmoddt>>----
         AFTER FIELD xmijmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<xmijcnfdt>>----
         #AFTER FIELD xmijcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<xmijpstdt>>----
         #AFTER FIELD xmijpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)



         #一般欄位
         #---------------------------<  Master  >---------------------------
         #----<<xmij001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij001
            #add-point:BEFORE FIELD xmij001
            {<point name="construct.b.xmij001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij001

            #add-point:AFTER FIELD xmij001
            {<point name="construct.a.xmij001" />}
            #END add-point


         #Ctrlp:construct.c.xmij001
         ON ACTION controlp INFIELD xmij001
            #add-point:ON ACTION controlp INFIELD xmij001
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '7'
            CALL q_ooef001_41()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmij001             #將開窗取得的值回傳到變數
            NEXT FIELD xmij001                          #返回原欄位            
            #END add-point

         #----<<xmij002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij002
            #add-point:BEFORE FIELD xmij002
            {<point name="construct.b.xmij002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij002

            #add-point:AFTER FIELD xmij002
            {<point name="construct.a.xmij002" />}
            #END add-point


         #Ctrlp:construct.c.xmij002
#         ON ACTION controlp INFIELD xmij002
            #add-point:ON ACTION controlp INFIELD xmij002
            {<point name="construct.c.xmij002" />}
            #END add-point

         #----<<xmij003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij003
            #add-point:BEFORE FIELD xmij003
            {<point name="construct.b.xmij003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij003

            #add-point:AFTER FIELD xmij003
            {<point name="construct.a.xmij003" />}
            #END add-point


         #Ctrlp:construct.c.xmij003
#         ON ACTION controlp INFIELD xmij003
            #add-point:ON ACTION controlp INFIELD xmij003
            {<point name="construct.c.xmij003" />}
            #END add-point

         #----<<xmij004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij004
            #add-point:BEFORE FIELD xmij004
            {<point name="construct.b.xmij004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij004

            #add-point:AFTER FIELD xmij004
            {<point name="construct.a.xmij004" />}
            #END add-point


         #Ctrlp:construct.c.xmij004
#         ON ACTION controlp INFIELD xmij004
            #add-point:ON ACTION controlp INFIELD xmij004
            {<point name="construct.c.xmij004" />}
            #END add-point

         #----<<xmij005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij005
            #add-point:BEFORE FIELD xmij005
            {<point name="construct.b.xmij005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij005

            #add-point:AFTER FIELD xmij005
            {<point name="construct.a.xmij005" />}
            #END add-point


         #Ctrlp:construct.c.xmij005
#         ON ACTION controlp INFIELD xmij005
            #add-point:ON ACTION controlp INFIELD xmij005
            {<point name="construct.c.xmij005" />}
            #END add-point

         #----<<xmij006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij006
            #add-point:BEFORE FIELD xmij006
            {<point name="construct.b.xmij006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij006

            #add-point:AFTER FIELD xmij006
            {<point name="construct.a.xmij006" />}
            #END add-point


         #Ctrlp:construct.c.xmij006
#         ON ACTION controlp INFIELD xmij006
            #add-point:ON ACTION controlp INFIELD xmij006
            {<point name="construct.c.xmij006" />}
            #END add-point

         #----<<xmij007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij007
            #add-point:BEFORE FIELD xmij007
            {<point name="construct.b.xmij007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij007

            #add-point:AFTER FIELD xmij007
            {<point name="construct.a.xmij007" />}
            #END add-point


         #Ctrlp:construct.c.xmij007
#         ON ACTION controlp INFIELD xmij007
            #add-point:ON ACTION controlp INFIELD xmij007
            {<point name="construct.c.xmij007" />}
            #END add-point

         #----<<xmij008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij008
            #add-point:BEFORE FIELD xmij008
            {<point name="construct.b.xmij008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij008

            #add-point:AFTER FIELD xmij008
            {<point name="construct.a.xmij008" />}
            #END add-point


         #Ctrlp:construct.c.xmij008
#         ON ACTION controlp INFIELD xmij008
            #add-point:ON ACTION controlp INFIELD xmij008
            {<point name="construct.c.xmij008" />}
            #END add-point

         #----<<xmij009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij009
            #add-point:BEFORE FIELD xmij009
            {<point name="construct.b.xmij009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij009

            #add-point:AFTER FIELD xmij009
            {<point name="construct.a.xmij009" />}
            #END add-point


         #Ctrlp:construct.c.xmij009
#         ON ACTION controlp INFIELD xmij009
            #add-point:ON ACTION controlp INFIELD xmij009
            {<point name="construct.c.xmij009" />}
            #END add-point

         #----<<xmij010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij010
            #add-point:BEFORE FIELD xmij010
            {<point name="construct.b.xmij010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij010

            #add-point:AFTER FIELD xmij010
            {<point name="construct.a.xmij010" />}
            #END add-point


         #Ctrlp:construct.c.xmij010
#         ON ACTION controlp INFIELD xmij010
            #add-point:ON ACTION controlp INFIELD xmij010
            {<point name="construct.c.xmij010" />}
            #END add-point

         #----<<xmij011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij011
            #add-point:BEFORE FIELD xmij011
            {<point name="construct.b.xmij011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij011

            #add-point:AFTER FIELD xmij011
            {<point name="construct.a.xmij011" />}
            #END add-point


         #Ctrlp:construct.c.xmij011
#         ON ACTION controlp INFIELD xmij011
            #add-point:ON ACTION controlp INFIELD xmij011
            {<point name="construct.c.xmij011" />}
            #END add-point

         #----<<xmijstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmijstus
            #add-point:BEFORE FIELD xmijstus
            {<point name="construct.b.xmijstus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijstus

            #add-point:AFTER FIELD xmijstus
            {<point name="construct.a.xmijstus" />}
            #END add-point


         #Ctrlp:construct.c.xmijstus
#         ON ACTION controlp INFIELD xmijstus
            #add-point:ON ACTION controlp INFIELD xmijstus
            {<point name="construct.c.xmijstus" />}
            #END add-point

         #----<<xmijownid>>----
         #Ctrlp:construct.c.xmijownid
         ON ACTION controlp INFIELD xmijownid
            #add-point:ON ACTION controlp INFIELD xmijownid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmijownid  #顯示到畫面上

            NEXT FIELD xmijownid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD xmijownid
            #add-point:BEFORE FIELD xmijownid
            {<point name="construct.b.xmijownid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijownid

            #add-point:AFTER FIELD xmijownid
            {<point name="construct.a.xmijownid" />}
            #END add-point


         #----<<xmijowndp>>----
         #Ctrlp:construct.c.xmijowndp
         ON ACTION controlp INFIELD xmijowndp
            #add-point:ON ACTION controlp INFIELD xmijowndp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmijowndp  #顯示到畫面上

            NEXT FIELD xmijowndp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD xmijowndp
            #add-point:BEFORE FIELD xmijowndp
            {<point name="construct.b.xmijowndp" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijowndp

            #add-point:AFTER FIELD xmijowndp
            {<point name="construct.a.xmijowndp" />}
            #END add-point


         #----<<xmijcrtid>>----
         #Ctrlp:construct.c.xmijcrtid
         ON ACTION controlp INFIELD xmijcrtid
            #add-point:ON ACTION controlp INFIELD xmijcrtid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmijcrtid  #顯示到畫面上

            NEXT FIELD xmijcrtid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD xmijcrtid
            #add-point:BEFORE FIELD xmijcrtid
            {<point name="construct.b.xmijcrtid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijcrtid

            #add-point:AFTER FIELD xmijcrtid
            {<point name="construct.a.xmijcrtid" />}
            #END add-point


         #----<<xmijcrtdp>>----
         #Ctrlp:construct.c.xmijcrtdp
         ON ACTION controlp INFIELD xmijcrtdp
            #add-point:ON ACTION controlp INFIELD xmijcrtdp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmijcrtdp  #顯示到畫面上

            NEXT FIELD xmijcrtdp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD xmijcrtdp
            #add-point:BEFORE FIELD xmijcrtdp
            {<point name="construct.b.xmijcrtdp" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijcrtdp

            #add-point:AFTER FIELD xmijcrtdp
            {<point name="construct.a.xmijcrtdp" />}
            #END add-point


         #----<<xmijcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmijcrtdt
            #add-point:BEFORE FIELD xmijcrtdt
            {<point name="construct.b.xmijcrtdt" />}
            #END add-point

         #----<<xmijmodid>>----
         #Ctrlp:construct.c.xmijmodid
         ON ACTION controlp INFIELD xmijmodid
            #add-point:ON ACTION controlp INFIELD xmijmodid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmijmodid  #顯示到畫面上

            NEXT FIELD xmijmodid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD xmijmodid
            #add-point:BEFORE FIELD xmijmodid
            {<point name="construct.b.xmijmodid" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijmodid

            #add-point:AFTER FIELD xmijmodid
            {<point name="construct.a.xmijmodid" />}
            #END add-point


         #----<<xmijmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmijmoddt
            #add-point:BEFORE FIELD xmijmoddt
            {<point name="construct.b.xmijmoddt" />}
            #END add-point



      END CONSTRUCT

      #add-point:cs段more_construct
      {<point name="cs.more_construct"/>}
      #end add-point

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:cs段after_construct
   {<point name="cs.after_construct"/>}
   #end add-point

   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")

END FUNCTION

PRIVATE FUNCTION axmi171_filter()
      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
         #end add-point






END FUNCTION

PRIVATE FUNCTION axmi171_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}




END FUNCTION

PRIVATE FUNCTION axmi171_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   LET INT_FLAG = 0
   LET ls_wc = g_wc

   #切換畫面

   CALL g_browser2.clear()

   IF g_worksheet_hidden THEN  #browser panel 單身折疊
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      CALL gfrm_curr.setElementHidden("worksheet_detail",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF

   INITIALIZE g_xmij_m.* TO NULL
   ERROR ""

   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL axmi171_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axmi171_browser_fill()
      CALL axmi171_browser2_fill(g_wc,"F")
      #CALL axmi171_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF

   LET g_error_show = 1
   CALL axmi171_browser2_fill(g_wc,"F")   # 移到第一頁

   #備份搜尋條件
   LET ls_wc = g_wc

   #第一層模糊搜尋
   IF g_browser.getLength() = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL axmi171_browser2_fill(g_wc,"F")
   END IF

   #第二層助記碼搜尋
   IF g_browser.getLength() = 0 THEN
      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL axmi171_browser2_fill(g_wc,"F")
      END IF

   END IF

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL axmi171_fetch("F")
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION axmi171_fetch(p_fl)
   {<Local define>}
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}

   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point

   CASE p_fl
      WHEN "F" LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF
      WHEN "L"
         LET g_current_idx = g_header_cnt
      WHEN "/"
         IF (NOT g_no_ask) THEN
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE
   END CASE

   LET g_browser_cnt = g_browser2.getLength()
   LET g_browser_cnt2 = g_browser.getLength()

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   #DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt2 TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   CALL ui.Interface.refresh()

   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數

   IF g_browser[g_current_idx2].b_expcode <> "2" THEN
      INITIALIZE g_xmij_m.* TO NULL
      DISPLAY BY NAME g_xmij_m.*
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      RETURN
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF


   IF g_current_idx > g_browser2.getLength() THEN
      LET g_current_idx = g_browser2.getLength()
   END IF

   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx2)

   CALL cl_navigator_setting(g_browser_idx, g_current_cnt)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

#   LET g_xmij_m.xmijsite = g_browser[g_current_idx].b_xmijsite
#   LET g_xmij_m.xmij001 = g_browser[g_current_idx].b_xmij001
   IF cl_null(p_fl) THEN 
      LET g_xmij_m.xmij001 = g_browser[g_current_idx2].b_ooed004
   ELSE
      LET g_xmij_m.xmij001 = g_browser2[g_current_idx].b_xmij001
   END IF

   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE xmij001,xmij002,xmij003,xmij004,xmij005,xmij006,xmij007,xmij008,xmij009,xmij010,
        xmij011,xmijstus,xmijownid,xmijowndp,xmijcrtid,xmijcrtdp,xmijcrtdt,xmijmodid,xmijmoddt
 INTO g_xmij_m.xmij001,g_xmij_m.xmij002,g_xmij_m.xmij003,g_xmij_m.xmij004,g_xmij_m.xmij005,
     g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,g_xmij_m.xmij010,g_xmij_m.xmij011,
     g_xmij_m.xmijstus,g_xmij_m.xmijownid,g_xmij_m.xmijowndp,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtdp,g_xmij_m.xmijcrtdt,
     g_xmij_m.xmijmodid,g_xmij_m.xmijmoddt
 FROM xmij_t
 WHERE xmijent = g_enterprise AND xmij001 = g_xmij_m.xmij001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmij_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      INITIALIZE g_xmij_m.* TO NULL
      DISPLAY BY NAME g_xmij_m.*
      RETURN
   END IF

   #add-point:fetch段action控制
   CALL cl_set_act_visible("delete",TRUE)
   IF g_xmij_m.xmijstus = 'N' THEN 
      CALL cl_set_act_visible("delete",FALSE)
   END IF
   #end add-point



   #重新顯示
   CALL axmi171_show()

END FUNCTION

PRIVATE FUNCTION axmi171_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point

   #CLEAR FORM                    #清畫面欄位內容

   INITIALIZE g_xmij_m.* LIKE xmij_t.*             #DEFAULT 設定
   LET g_xmij001_t = NULL



   CALL s_transaction_begin()

   WHILE TRUE

      #公用欄位給值
      #此段落由子樣板a14產生
      LET g_xmij_m.xmijownid = g_user
      LET g_xmij_m.xmijowndp = g_dept
      LET g_xmij_m.xmijcrtid = g_user
      LET g_xmij_m.xmijcrtdp = g_dept
      LET g_xmij_m.xmijcrtdt = cl_get_current()
      LET g_xmij_m.xmijmodid = ""
      LET g_xmij_m.xmijmoddt = ""
      LET g_xmij_m.xmijstus = "Y"
      LET g_xmij_m.xmij002 = "N"
      LET g_xmij_m.xmij003 = "N"
      LET g_xmij_m.xmij004 = "N"
      LET g_xmij_m.xmij005 = "N"
      LET g_xmij_m.xmij006 = "N"
      LET g_xmij_m.xmij007 = "N"
      LET g_xmij_m.xmij008 = "N"
      LET g_xmij_m.xmij009 = "N"
      LET g_xmij_m.xmij010 = "N"
      LET g_xmij_m.xmij011 = "N"

      #append欄位給值
      LET g_xmij_m_t.* = g_xmij_m.*

      #一般欄位給值


      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point

      CALL axmi171_input("a")

      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xmij_m.* = g_xmij_m_t.*
         CALL axmi171_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      LET g_rec_b = 0
      EXIT WHILE
   END WHILE

   LET g_xmij001_t = g_xmij_m.xmij001



   LET g_state = "Y"




END FUNCTION

PRIVATE FUNCTION axmi171_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   IF g_xmij_m.xmij001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE xmij001,xmij002,xmij003,xmij004,xmij005,xmij006,xmij007,xmij008,xmij009,xmij010,
        xmij011,xmijstus,xmijownid,xmijowndp,xmijcrtid,xmijcrtdp,xmijcrtdt,xmijmodid,xmijmoddt
 INTO g_xmij_m.xmij001,g_xmij_m.xmij002,g_xmij_m.xmij003,g_xmij_m.xmij004,g_xmij_m.xmij005,
     g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,g_xmij_m.xmij010,g_xmij_m.xmij011,
     g_xmij_m.xmijstus,g_xmij_m.xmijownid,g_xmij_m.xmijowndp,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtdp,g_xmij_m.xmijcrtdt,
     g_xmij_m.xmijmodid,g_xmij_m.xmijmoddt
 FROM xmij_t
 WHERE xmijent = g_enterprise AND xmij001 = g_xmij_m.xmij001

   ERROR ""

   LET g_xmij001_t = g_xmij_m.xmij001



   CALL s_transaction_begin()

   OPEN axmi171_cl USING g_enterprise,g_xmij_m.xmij001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axmi171_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE axmi171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH axmi171_cl INTO g_xmij_m.xmij001,g_xmij_m.xmij001_desc,g_xmij_m.xmij002,g_xmij_m.xmij003,
       g_xmij_m.xmij004,g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,
       g_xmij_m.xmij010,g_xmij_m.xmij011,g_xmij_m.xmijstus,g_xmij_m.xmijownid,g_xmij_m.xmijownid_desc,
       g_xmij_m.xmijowndp,g_xmij_m.xmijowndp_desc,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtid_desc,g_xmij_m.xmijcrtdp,
       g_xmij_m.xmijcrtdp_desc,g_xmij_m.xmijcrtdt,g_xmij_m.xmijmodid,g_xmij_m.xmijmodid_desc,g_xmij_m.xmijmoddt


   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmij_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE axmi171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF



   CALL axmi171_show()

   WHILE TRUE
      LET g_xmij_m.xmij001 = g_xmij001_t



      #寫入修改者/修改日期資訊
      LET g_xmij_m.xmijmodid = g_user
LET g_xmij_m.xmijmoddt = cl_get_current()


      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point

      CALL axmi171_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xmij_m.* = g_xmij_m_t.*
         CALL axmi171_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      EXIT WHILE

   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_xmij_m.xmij001,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE axmi171_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_xmij_m.xmij001,"U")

   LET g_worksheet_hidden = 0

END FUNCTION

PRIVATE FUNCTION axmi171_input(p_cmd)
   {<Local define>}
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10        #未取消的ARRAY CNT    #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10       #170104-00066#3 num5->num10  17/01/06 mod by rainy 
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point

   #切換畫面
   CALL gfrm_curr.setElementHidden("mainlayout",0)
   CALL gfrm_curr.setElementImage("mainhidden","small/arr-u.png")
   LET g_main_hidden = 1

   CALL cl_set_head_visible("","YES")

   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   #控制key欄位可否輸入
   CALL axmi171_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL axmi171_set_no_entry(p_cmd)
   #add-point:資料輸入前
   LET g_errshow = 1
   #end add-point

   DISPLAY BY NAME g_xmij_m.xmij001,g_xmij_m.xmij002,g_xmij_m.xmij003,g_xmij_m.xmij004,
       g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,g_xmij_m.xmij010,
       g_xmij_m.xmij011,g_xmij_m.xmijstus

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_xmij_m.xmij001,g_xmij_m.xmij002,g_xmij_m.xmij003,g_xmij_m.xmij004,
          g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,g_xmij_m.xmij010,
          g_xmij_m.xmij011,g_xmij_m.xmijstus
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)

            #add-point:input開始前
            {<point name="input.before.input"/>}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<xmij001>>----
         #此段落由子樣板a02產生
         AFTER FIELD xmij001

            #add-point:AFTER FIELD xmij001
            CALL axmi171_xmij001_desc()
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xmij_m.xmij001) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmij_m.xmij001 != g_xmij001_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmij_t WHERE "||"xmijent = '" ||g_enterprise|| "' AND "|| "xmij001 = '"||g_xmij_m.xmij001 ||"'",'std-00004',0) THEN
                     LET g_xmij_m.xmij001 = g_xmij_m_t.xmij001
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_xmij_m.xmij001) THEN 
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xmij_m.xmij001
                  LET g_chkparam.arg2 = '7'
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001_38") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xmij_m.xmij001 = g_xmij_m_t.xmij001
                     NEXT FIELD CURRENT
                  END IF
               END IF                         
            END IF



          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD xmij001
            #add-point:BEFORE FIELD xmij001
            CALL axmi171_xmij001_desc()
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE xmij001
            #add-point:ON CHANGE xmij001
            {<point name="input.g.xmij001" />}
            #END add-point

         #----<<xmij002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij002
            #add-point:BEFORE FIELD xmij002
            {<point name="input.b.xmij002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij002

            #add-point:AFTER FIELD xmij002
            {<point name="input.a.xmij002" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij002
            #add-point:ON CHANGE xmij002
            IF g_xmij_m.xmij002 = 'Y' THEN 
               LET g_xmij_m.xmij003 = 'N'
               LET g_xmij_m.xmij004 = 'N'
               LET g_xmij_m.xmij005 = 'N'
               LET g_xmij_m.xmij006 = 'N'
               LET g_xmij_m.xmij007 = 'N'
               LET g_xmij_m.xmij008 = 'N'
               LET g_xmij_m.xmij009 = 'N'
               LET g_xmij_m.xmij010 = 'N'
               LET g_xmij_m.xmij011 = 'N'
            END IF
            CALL axmi171_set_entry(p_cmd)
            CALL axmi171_set_no_entry(p_cmd)
            #END add-point

         #----<<xmij003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij003
            #add-point:BEFORE FIELD xmij003
            {<point name="input.b.xmij003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij003

            #add-point:AFTER FIELD xmij003
            {<point name="input.a.xmij003" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij003
            #add-point:ON CHANGE xmij003
            IF g_xmij_m.xmij003 = 'Y' THEN 
               LET g_xmij_m.xmij002 = 'N'
               LET g_xmij_m.xmij005 = 'Y'
            ELSE
               LET g_xmij_m.xmij004 = 'N'
               LET g_xmij_m.xmij005 = 'N'
               LET g_xmij_m.xmij006 = 'N'
               LET g_xmij_m.xmij007 = 'N'
               LET g_xmij_m.xmij008 = 'N'
               LET g_xmij_m.xmij009 = 'N'
               LET g_xmij_m.xmij010 = 'N'
               LET g_xmij_m.xmij011 = 'N'            
            END IF
            CALL axmi171_set_entry(p_cmd)
            CALL axmi171_set_no_entry(p_cmd)
            
            #END add-point

         #----<<xmij004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij004
            #add-point:BEFORE FIELD xmij004
            {<point name="input.b.xmij004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij004

            #add-point:AFTER FIELD xmij004
            {<point name="input.a.xmij004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij004
            #add-point:ON CHANGE xmij004
            {<point name="input.g.xmij004" />}
            #END add-point

         #----<<xmij005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij005
            #add-point:BEFORE FIELD xmij005
            {<point name="input.b.xmij005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij005

            #add-point:AFTER FIELD xmij005
            {<point name="input.a.xmij005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij005
            #add-point:ON CHANGE xmij005
            {<point name="input.g.xmij005" />}
            #END add-point

         #----<<xmij006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij006
            #add-point:BEFORE FIELD xmij006
            {<point name="input.b.xmij006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij006

            #add-point:AFTER FIELD xmij006
            {<point name="input.a.xmij006" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij006
            #add-point:ON CHANGE xmij006
            {<point name="input.g.xmij006" />}
            #END add-point

         #----<<xmij007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij007
            #add-point:BEFORE FIELD xmij007
            {<point name="input.b.xmij007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij007

            #add-point:AFTER FIELD xmij007
            {<point name="input.a.xmij007" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij007
            #add-point:ON CHANGE xmij007
            {<point name="input.g.xmij007" />}
            #END add-point

         #----<<xmij008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij008
            #add-point:BEFORE FIELD xmij008
            {<point name="input.b.xmij008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij008

            #add-point:AFTER FIELD xmij008
            {<point name="input.a.xmij008" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij008
            #add-point:ON CHANGE xmij008
            {<point name="input.g.xmij008" />}
            #END add-point

         #----<<xmij009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij009
            #add-point:BEFORE FIELD xmij009
            {<point name="input.b.xmij009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij009

            #add-point:AFTER FIELD xmij009
            {<point name="input.a.xmij009" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij009
            #add-point:ON CHANGE xmij009
            {<point name="input.g.xmij009" />}
            #END add-point

         #----<<xmij010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij010
            #add-point:BEFORE FIELD xmij010
            {<point name="input.b.xmij010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij010

            #add-point:AFTER FIELD xmij010
            {<point name="input.a.xmij010" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij010
            #add-point:ON CHANGE xmij010
            {<point name="input.g.xmij010" />}
            #END add-point

         #----<<xmij011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmij011
            #add-point:BEFORE FIELD xmij011
            {<point name="input.b.xmij011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmij011

            #add-point:AFTER FIELD xmij011
            {<point name="input.a.xmij011" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmij011
            #add-point:ON CHANGE xmij011
            {<point name="input.g.xmij011" />}
            #END add-point

         #----<<xmijstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xmijstus
            #add-point:BEFORE FIELD xmijstus
            {<point name="input.b.xmijstus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD xmijstus

            #add-point:AFTER FIELD xmijstus
            {<point name="input.a.xmijstus" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE xmijstus
            #add-point:ON CHANGE xmijstus
            {<point name="input.g.xmijstus" />}
            #END add-point

         #----<<xmijownid>>----
         #----<<xmijowndp>>----
         #----<<xmijcrtid>>----
         #----<<xmijcrtdp>>----
         #----<<xmijcrtdt>>----
         #----<<xmijmodid>>----
         #----<<xmijmoddt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<xmij001>>----
         #Ctrlp:input.c.xmij001
         ON ACTION controlp INFIELD xmij001
            #add-point:ON ACTION controlp INFIELD xmij001
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.default1 = g_xmij_m.xmij001
            LET g_qryparam.arg1 = '7'
            CALL q_ooef001_41()            #呼叫開窗
            LET g_xmij_m.xmij001 = g_qryparam.return1
            DISPLAY g_xmij_m.xmij001 TO xmij001             #將開窗取得的值回傳到變數
            NEXT FIELD xmij001                          #返回原欄位  
            #END add-point

         #----<<xmij002>>----
         #Ctrlp:input.c.xmij002
#         ON ACTION controlp INFIELD xmij002
            #add-point:ON ACTION controlp INFIELD xmij002
            {<point name="input.c.xmij002" />}
            #END add-point

         #----<<xmij003>>----
         #Ctrlp:input.c.xmij003
#         ON ACTION controlp INFIELD xmij003
            #add-point:ON ACTION controlp INFIELD xmij003
            {<point name="input.c.xmij003" />}
            #END add-point

         #----<<xmij004>>----
         #Ctrlp:input.c.xmij004
#         ON ACTION controlp INFIELD xmij004
            #add-point:ON ACTION controlp INFIELD xmij004
            {<point name="input.c.xmij004" />}
            #END add-point

         #----<<xmij005>>----
         #Ctrlp:input.c.xmij005
#         ON ACTION controlp INFIELD xmij005
            #add-point:ON ACTION controlp INFIELD xmij005
            {<point name="input.c.xmij005" />}
            #END add-point

         #----<<xmij006>>----
         #Ctrlp:input.c.xmij006
#         ON ACTION controlp INFIELD xmij006
            #add-point:ON ACTION controlp INFIELD xmij006
            {<point name="input.c.xmij006" />}
            #END add-point

         #----<<xmij007>>----
         #Ctrlp:input.c.xmij007
#         ON ACTION controlp INFIELD xmij007
            #add-point:ON ACTION controlp INFIELD xmij007
            {<point name="input.c.xmij007" />}
            #END add-point

         #----<<xmij008>>----
         #Ctrlp:input.c.xmij008
#         ON ACTION controlp INFIELD xmij008
            #add-point:ON ACTION controlp INFIELD xmij008
            {<point name="input.c.xmij008" />}
            #END add-point

         #----<<xmij009>>----
         #Ctrlp:input.c.xmij009
#         ON ACTION controlp INFIELD xmij009
            #add-point:ON ACTION controlp INFIELD xmij009
            {<point name="input.c.xmij009" />}
            #END add-point

         #----<<xmij010>>----
         #Ctrlp:input.c.xmij010
#         ON ACTION controlp INFIELD xmij010
            #add-point:ON ACTION controlp INFIELD xmij010
            {<point name="input.c.xmij010" />}
            #END add-point

         #----<<xmij011>>----
         #Ctrlp:input.c.xmij011
#         ON ACTION controlp INFIELD xmij011
            #add-point:ON ACTION controlp INFIELD xmij011
            {<point name="input.c.xmij011" />}
            #END add-point

         #----<<xmijstus>>----
         #Ctrlp:input.c.xmijstus
#         ON ACTION controlp INFIELD xmijstus
            #add-point:ON ACTION controlp INFIELD xmijstus
            {<point name="input.c.xmijstus" />}
            #END add-point

         #----<<xmijownid>>----
         #----<<xmijowndp>>----
         #----<<xmijcrtid>>----
         #----<<xmijcrtdp>>----
         #----<<xmijcrtdt>>----
         #----<<xmijmodid>>----
         #----<<xmijmoddt>>----
 #欄位開窗

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()   #錯誤訊息統整顯示

            IF p_cmd <> "u" THEN
               LET l_count = 1

               SELECT COUNT(*) INTO l_count FROM xmij_t
                WHERE xmijent = g_enterprise 
                  AND xmij001 = g_xmij_m.xmij001


               IF l_count = 0 THEN

                  #add-point:單頭新增前
                  {<point name="input.head.b_insert" mark="Y"/>}
                  #end add-point

                  INSERT INTO xmij_t (xmijent,xmij001,xmij002,xmij003,xmij004,xmij005,xmij006,
                      xmij007,xmij008,xmij009,xmij010,xmij011,xmijstus,xmijownid,xmijowndp,xmijcrtid,
                      xmijcrtdp,xmijcrtdt,xmijmodid,xmijmoddt)
                  VALUES (g_enterprise,g_xmij_m.xmij001,g_xmij_m.xmij002,g_xmij_m.xmij003,
                      g_xmij_m.xmij004,g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,
                      g_xmij_m.xmij009,g_xmij_m.xmij010,g_xmij_m.xmij011,g_xmij_m.xmijstus,g_xmij_m.xmijownid,
                      g_xmij_m.xmijowndp,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtdp,g_xmij_m.xmijcrtdt,g_xmij_m.xmijmodid,
                      g_xmij_m.xmijmoddt)

                  #add-point:單頭新增中
                  {<point name="input.head.m_insert"/>}
                  #end add-point

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmij_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF



                  #資料多語言用-增/改


                  #add-point:單頭新增後
                  {<point name="input.head.a_insert"/>}
                  #end add-point

                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_xmij_m.xmij001"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF
            ELSE
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
               UPDATE xmij_t SET (xmij001,xmij002,xmij003,xmij004,xmij005,xmij006,xmij007,xmij008,
                   xmij009,xmij010,xmij011,xmijstus,xmijownid,xmijowndp,xmijcrtid,xmijcrtdp,xmijcrtdt,
                   xmijmodid,xmijmoddt) = (g_xmij_m.xmij001,g_xmij_m.xmij002,g_xmij_m.xmij003,
                   g_xmij_m.xmij004,g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,
                   g_xmij_m.xmij009,g_xmij_m.xmij010,g_xmij_m.xmij011,g_xmij_m.xmijstus,g_xmij_m.xmijownid,
                   g_xmij_m.xmijowndp,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtdp,g_xmij_m.xmijcrtdt,g_xmij_m.xmijmodid,
                   g_xmij_m.xmijmoddt)
                WHERE xmijent = g_enterprise 
                  AND xmij001 = g_xmij001_t


               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xmij_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmij_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE

                     #資料多語言用-增/改

                     #add-point:單頭修改後
                     {<point name="input.head.a_update"/>}
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE
            END IF
           #controlp
      END INPUT

      #add-point:input段more input
      {<point name="input.more_input"/>}
      #end add-point

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)

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
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:input段after input
   {<point name="input.after_input"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE xmij_t.xmij001
   DEFINE l_oldno     LIKE xmij_t.xmij001


   DEFINE l_master    RECORD LIKE xmij_t.*
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}

   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面

   IF g_xmij_m.xmij001 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_xmij001_t = g_xmij_m.xmij001

   LET g_xmij_m.xmij001 = ""



   CALL axmi171_set_entry("a")
   CALL axmi171_set_no_entry("a")

   #公用欄位給予預設值
   #此段落由子樣板a14產生
      LET g_xmij_m.xmijownid = g_user
      LET g_xmij_m.xmijowndp = g_dept
      LET g_xmij_m.xmijcrtid = g_user
      LET g_xmij_m.xmijcrtdp = g_dept
      LET g_xmij_m.xmijcrtdt = cl_get_current()
      LET g_xmij_m.xmijmodid = ""
      LET g_xmij_m.xmijmoddt = ""
      LET g_xmij_m.xmijstus = "Y"



   #add-point:複製輸入前
   {<point name="reproduce.head.b_input"/>}
   #end add-point

   CALL axmi171_input("r")

      LET g_xmij_m.xmij001_desc = ''
   DISPLAY BY NAME g_xmij_m.xmij001_desc


   IF INT_FLAG  THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

   #add-point:單頭複製前
   {<point name="reproduce.head.b_insert" mark="Y"/>}
   #end add-point

   #add-point:單頭複製中
   {<point name="reproduce.head.m_insert"/>}
   #end add-point

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmij_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #add-point:單頭複製後
   {<point name="reproduce.head.a_insert"/>}
   #end add-point

   CALL s_transaction_end('Y','0')


   LET g_xmij001_t = g_xmij_m.xmij001



   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_show()
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point



   LET g_xmij_m_t.* = g_xmij_m.*      #保存單頭舊值

   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_xmij_m.xmijownid_desc = cl_get_username(g_xmij_m.xmijownid)
      #LET g_xmij_m.xmijowndp_desc = cl_get_deptname(g_xmij_m.xmijowndp)
      #LET g_xmij_m.xmijcrtid_desc = cl_get_username(g_xmij_m.xmijcrtid)
      #LET g_xmij_m.xmijcrtdp_desc = cl_get_deptname(g_xmij_m.xmijcrtdp)
      #LET g_xmij_m.xmijmodid_desc = cl_get_username(g_xmij_m.xmijmodid)
      ##LET g_xmij_m.xmijcnfid_desc = cl_get_deptname(g_xmij_m.xmijcnfid)
      ##LET g_xmij_m.xmijpstid_desc = cl_get_deptname(g_xmij_m.xmijpstid)




   #讀入ref值(單頭)
   #add-point:show段reference

            CALL axmi171_xmij001_desc()

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmij_m.xmijownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xmij_m.xmijownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmij_m.xmijownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmij_m.xmijowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmij_m.xmijowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmij_m.xmijowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmij_m.xmijcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xmij_m.xmijcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmij_m.xmijcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmij_m.xmijcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmij_m.xmijcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmij_m.xmijcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmij_m.xmijmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xmij_m.xmijmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmij_m.xmijmodid_desc
          {#ADP版次:1#}
   #end add-point

   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmij_m.xmij001,g_xmij_m.xmij001_desc,g_xmij_m.xmij002,g_xmij_m.xmij003,
       g_xmij_m.xmij004,g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,
       g_xmij_m.xmij010,g_xmij_m.xmij011,g_xmij_m.xmijstus,g_xmij_m.xmijownid,g_xmij_m.xmijownid_desc,
       g_xmij_m.xmijowndp,g_xmij_m.xmijowndp_desc,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtid_desc,g_xmij_m.xmijcrtdp,
       g_xmij_m.xmijcrtdp_desc,g_xmij_m.xmijcrtdt,g_xmij_m.xmijmodid,g_xmij_m.xmijmodid_desc,g_xmij_m.xmijmoddt


   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_xmij_m.xmijstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")



      END CASE



   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_delete()
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

   IF g_xmij_m.xmij001 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   CALL axmi171_show()

   CALL s_transaction_begin()

   LET g_xmij001_t = g_xmij_m.xmij001





   OPEN axmi171_cl USING g_enterprise,g_xmij_m.xmij001


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axmi171_cl:"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE axmi171_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   FETCH axmi171_cl INTO g_xmij_m.xmij001,g_xmij_m.xmij001_desc,g_xmij_m.xmij002,g_xmij_m.xmij003,
       g_xmij_m.xmij004,g_xmij_m.xmij005,g_xmij_m.xmij006,g_xmij_m.xmij007,g_xmij_m.xmij008,g_xmij_m.xmij009,
       g_xmij_m.xmij010,g_xmij_m.xmij011,g_xmij_m.xmijstus,g_xmij_m.xmijownid,g_xmij_m.xmijownid_desc,
       g_xmij_m.xmijowndp,g_xmij_m.xmijowndp_desc,g_xmij_m.xmijcrtid,g_xmij_m.xmijcrtid_desc,g_xmij_m.xmijcrtdp,
       g_xmij_m.xmijcrtdp_desc,g_xmij_m.xmijcrtdt,g_xmij_m.xmijmodid,g_xmij_m.xmijmodid_desc,g_xmij_m.xmijmoddt

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_xmij_m.xmij001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   IF cl_ask_delete() THEN
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "xmij001"
      LET g_doc.value1 = g_xmij_m.xmij001
      CALL cl_doc_remove()

      #add-point:單頭刪除前
      {<point name="delete.head.b_delete" mark="Y"/>}
      #end add-point

      DELETE FROM xmij_t
       WHERE xmijent = g_enterprise 
         AND xmij001 = g_xmij_m.xmij001



      #add-point:單頭刪除中
      {<point name="delete.head.m_delete"/>}
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "xmij_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF



      #add-point:單頭刪除後
      {<point name="delete.head.a_delete"/>}
      #end add-point



      CLEAR FORM
      CALL axmi171_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL axmi171_browser2_fill(g_wc,"P")
         #CALL axmi171_fetch("P")
      ELSE
         CALL axmi171_browser2_fill('1=1','')
      END IF
      CALL axmi171_browser_fill()
   END IF

   CLOSE axmi171_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_xmij_m.xmij001,"D")

END FUNCTION


PRIVATE FUNCTION axmi171_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}

   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_ooed004 = g_xmij_m.xmij001 THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR

   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF

END FUNCTION

PRIVATE FUNCTION axmi171_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("xmij001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("xmij004,xmij006,xmij007,xmij008,xmij009,xmij010,xmij011",TRUE)
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("xmij001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   IF g_xmij_m.xmij003 = 'N' THEN 
      CALL cl_set_comp_entry("xmij004,xmij006,xmij007,xmij008,xmij009,xmij010,xmij011",FALSE)
   END IF
   CALL cl_set_comp_entry("xmij005",FALSE)
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_default_search()
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
      LET ls_wc = ls_wc, " xmij001 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
   {<point name="statechange.define"/>}
   #end add-point

   #add-point:statechange段開始前
   {<point name="statechange.before"/>}
   #end add-point

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_xmij_m.xmij001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_xmij_m.xmijstus
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"



         END CASE

      #add-point:menu前
      {<point name="statechange.before_menu"/>}
      #end add-point

      ON ACTION inactive
         LET lc_state = "N"
         #add-point:action控制
         {<point name="statechange.inactive"/>}
         #end add-point
         EXIT MENU
      ON ACTION active
         LET lc_state = "Y"
         #add-point:action控制
         {<point name="statechange.active"/>}
         #end add-point
         EXIT MENU





      #add-point:stus控制
      {<point name="statechange.more_control"/>}
      #end add-point

   END MENU

   IF (lc_state <> "N"
      AND lc_state <> "Y"


      ) OR
      cl_null(lc_state) THEN
      RETURN
   END IF

   #add-point:stus修改前
   {<point name="statechange.b_update"/>}
   #end add-point

   UPDATE xmij_t SET xmijstus = lc_state
    WHERE xmijent = g_enterprise 
      AND xmij001 = g_xmij_m.xmij001


   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")



      END CASE
      LET g_xmij_m.xmijstus = lc_state
      DISPLAY BY NAME g_xmij_m.xmijstus
   END IF

   #add-point:stus修改後
   {<point name="statechange.a_update"/>}
   #end add-point

   #add-point:statechange段結束前
   {<point name="statechange.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axmi171_browser2_fill(p_wc,ps_page_action)
   {<Local define>}
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   {</Local define>}
   #add-point:browser_fill段define

   #end add-point
   
   CLEAR FORM
   INITIALIZE g_xmij_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser2.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "xmij001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
 
   LET g_sql = " SELECT COUNT(*) FROM xmij_t ",
               " WHERE xmijent = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED,cl_sql_add_filter("xmij_t")  #161214-00032#2 add ,cl_sql_add_filter("xmij_t") 
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
   LET g_error_show = 0
   
   #DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   LET g_wc = p_wc
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
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
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-998'
            LET g_errparam.extend = g_jump
            LET g_errparam.popup = FALSE
            CALL cl_err()

         END IF
         
      OTHERWISE
         
   END CASE
   
   LET l_sql_rank = "SELECT xmij001,'',RANK() OVER(ORDER BY xmij001 ",
 
                    g_order,
                    ") AS RANK ",
                    " FROM xmij_t ",
                    "  ",
                    "  ",
                    " WHERE xmijent = '" ||g_enterprise|| "' AND ", g_wc CLIPPED,cl_sql_add_filter("xmij_t")  #161214-00032#2 add ,cl_sql_add_filter("xmij_t") 				
					
   #定義翻頁CURSOR
   LET g_sql= " SELECT xmij001 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) , 
              "  ORDER BY ",l_searchcol," ",g_order
 
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser2.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser2[g_cnt].b_xmij001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser2.deleteElement(g_cnt)
   LET g_header_cnt = g_browser2.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_rec_b
   LET g_cnt = 0
   
   CALL axmi171_fetch("") 
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION

PRIVATE FUNCTION axmi171_chk_hasC(pi_id)
DEFINE pi_id    INTEGER
DEFINE li_cnt   INTEGER


   LET g_sql = "SELECT COUNT(*) FROM ooed_t ",
               " WHERE ooedent = '" ||g_enterprise|| "'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed001 = '2' ",   #mod xianghui 4->2
               "   AND ooed006 <= '",g_today,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"' ) ", 
               "   AND ooed005 = ? ",
               "   AND ooed002 = ? ",
               "   AND ooed003 = ? "
   PREPARE axmi171_master_chk1 FROM g_sql 
   EXECUTE axmi171_master_chk1 USING g_browser[pi_id].b_ooed004,g_browser[pi_id].b_ooed002,g_browser[pi_id].b_ooed003 INTO li_cnt
   FREE axmi171_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

PRIVATE FUNCTION axmi171_xmij001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmij_m.xmij001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmij_m.xmij001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmij_m.xmij001_desc
END FUNCTION

#end add-point
 
{</section>}
 
