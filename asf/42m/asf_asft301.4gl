#該程式未解開Section, 採用最新樣板產出!
{<section id="asft301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2016-08-16 10:45:07), PR版次:0019(2017-01-25 11:33:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000303
#+ Filename...: asft301
#+ Description: 工單製程維護作業
#+ Creator....: 01258(2014-02-24 15:01:49)
#+ Modifier...: 01534 -SD/PR- 05384
 
{</section>}
 
{<section id="asft301.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160113-00001#1   2016/01/14  By Sarah      在原有兩個作業中插入一個新的作業時，下站作業與作業序的更新會有錯
#160318-00025#3   2016/04/11  By 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160730-00001#1   2016/08/03  By shiun      進度頁籤增加顯示作業編號、作業名稱、作業序、工作站、工作站名稱
#160727-00025#3   2016/08/16  By lixh       增加"製程追蹤"按鈕
#161108-00013#1   2016/11/08  By 07024      與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161109-00085#28  2016/11/11  By lienjunqi  整批調整系統星號寫法
#161108-00023#2   2016/11/14  By Whitney    調整作業及作業序後更新對應上下站
#160824-00007#215 2016/11/29  By sakura     新舊值備份處理
#161214-00062#1   2016/12/15  By Sarah      browser_fill()增加呼叫權限過濾器lib
#161109-00085#67  2016/12/19  By 08171      整批調整系統星號寫法
#161231-00002#1   2016/12/31  By Whitney    修正asft301_upd_sfcb009()的星號調整的部分
#170104-00066#2   2017/01/06  By Rainy      筆數相關變數由num5放大至num10
#161109-00045#1   2017/01/24  By shiun      當工單製程未勾選時，不能新增或刪除單身
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_sfca_m        RECORD
       sfcadocno LIKE sfca_t.sfcadocno,
   sfca002 LIKE sfca_t.sfca002,
   sfaa010 LIKE sfaa_t.sfaa010,
   sfaa011 LIKE sfaa_t.sfaa011,
   sfaa017 LIKE sfaa_t.sfaa017,
   sfaa017_desc LIKE type_t.chr80,
   oobal004 LIKE type_t.chr80,
   sfaa010_desc LIKE type_t.chr80,
   sfaa019 LIKE sfaa_t.sfaa019,
   sfaastus LIKE sfaa_t.sfaastus,
   sfca001 LIKE sfca_t.sfca001,
   sfca005 LIKE sfca_t.sfca005,
   sfaa010_desc1 LIKE type_t.chr80,
   sfaa020 LIKE sfaa_t.sfaa020,
   sfaa003 LIKE sfaa_t.sfaa003,
   sfca003 LIKE sfca_t.sfca003,
   sfaa013 LIKE sfaa_t.sfaa013,
   sfaa005 LIKE sfaa_t.sfaa005,
   sfaa016 LIKE sfaa_t.sfaa016,
   sfaa016_desc LIKE type_t.chr80,
   sfca004 LIKE sfca_t.sfca004,
   sfaa006 LIKE sfaa_t.sfaa006,
   sfaa007 LIKE sfaa_t.sfaa007,
   sfaa008 LIKE sfaa_t.sfaa008,
   sfaa063 LIKE sfaa_t.sfaa063,
   sfcasite LIKE sfca_t.sfcasite,
   sfaa009 LIKE sfaa_t.sfaa009,
   sfaa009_desc LIKE type_t.chr80
       END RECORD

#單身 type 宣告
 TYPE type_g_sfcb_d        RECORD
       sfcb002 LIKE sfcb_t.sfcb002,
   sfcb003 LIKE sfcb_t.sfcb003,
   sfcb003_desc LIKE type_t.chr500,
   sfcb004 LIKE sfcb_t.sfcb004,
   sfcb005 LIKE sfcb_t.sfcb005,
   sfcb006 LIKE sfcb_t.sfcb006,
   sfcb007 LIKE sfcb_t.sfcb007,
   sfcb007_desc LIKE type_t.chr500,
   sfcb008 LIKE sfcb_t.sfcb008,
   sfcb009 LIKE sfcb_t.sfcb009,
   sfcb009_desc LIKE type_t.chr500,
   sfcb010 LIKE sfcb_t.sfcb010,
   sfcb011 LIKE sfcb_t.sfcb011,
   sfcb011_desc LIKE type_t.chr500,
   sfcb023 LIKE sfcb_t.sfcb023,
   sfcb024 LIKE sfcb_t.sfcb024,
   sfcb025 LIKE sfcb_t.sfcb025,
   sfcb026 LIKE sfcb_t.sfcb026,
   sfcb044 LIKE sfcb_t.sfcb044,
   sfcb045 LIKE sfcb_t.sfcb045,
   sfcb012 LIKE sfcb_t.sfcb012,
   sfcb013 LIKE sfcb_t.sfcb013,
   sfcb013_desc LIKE type_t.chr500,
   sfcb014 LIKE sfcb_t.sfcb014,
   sfcb015 LIKE sfcb_t.sfcb015,
   sfcb016 LIKE sfcb_t.sfcb016,
   sfcb017 LIKE sfcb_t.sfcb017,
   sfcb018 LIKE sfcb_t.sfcb018,
   sfcb019 LIKE sfcb_t.sfcb019,
   sfcb052 LIKE sfcb_t.sfcb052,
   sfcb052_desc LIKE type_t.chr80,
   sfcb053 LIKE sfcb_t.sfcb053,
   sfcb054 LIKE sfcb_t.sfcb054,
   sfcb020 LIKE sfcb_t.sfcb020,
   sfcb020_desc LIKE type_t.chr80,
   sfcb021 LIKE sfcb_t.sfcb021,
   sfcb022 LIKE sfcb_t.sfcb022,
   sfcb055 LIKE sfcb_t.sfcb055,
   ooff013 LIKE ooff_t.ooff013
       END RECORD
 TYPE type_g_sfcb2_d RECORD
       sfcb002 LIKE sfcb_t.sfcb002,
   #add--160730-00001#1 By shiun--(S)
   sfcb003 LIKE sfcb_t.sfcb003,
   sfcb003_desc LIKE type_t.chr500,
   sfcb004 LIKE sfcb_t.sfcb004,
   sfcb011 LIKE sfcb_t.sfcb011,
   sfcb011_desc LIKE type_t.chr500,
   #add--160730-00001#1 By shiun--(E)
   sfcb027 LIKE sfcb_t.sfcb027,
   sfcb050 LIKE sfcb_t.sfcb050,
   sfcb028 LIKE sfcb_t.sfcb028,
   sfcb029 LIKE sfcb_t.sfcb029,
   sfcb030 LIKE sfcb_t.sfcb030,
   sfcb031 LIKE sfcb_t.sfcb031,
   sfcb032 LIKE sfcb_t.sfcb032,
   sfcb033 LIKE sfcb_t.sfcb033,
   sfcb034 LIKE sfcb_t.sfcb034,
   sfcb035 LIKE sfcb_t.sfcb035,
   sfcb036 LIKE sfcb_t.sfcb036,
   sfcb037 LIKE sfcb_t.sfcb037,
   sfcb038 LIKE sfcb_t.sfcb038,
   sfcb039 LIKE sfcb_t.sfcb039,
   sfcb040 LIKE sfcb_t.sfcb040,
   sfcb041 LIKE sfcb_t.sfcb041,
   sfcb042 LIKE sfcb_t.sfcb042,
   sfcb043 LIKE sfcb_t.sfcb043,
   sfcb046 LIKE sfcb_t.sfcb046,
   sfcb047 LIKE sfcb_t.sfcb047,
   sfcb048 LIKE sfcb_t.sfcb048,
   sfcb049 LIKE sfcb_t.sfcb049,
   sfcb051 LIKE sfcb_t.sfcb051
       END RECORD



#模組變數(Module Variables)
DEFINE g_sfca_m          type_g_sfca_m
DEFINE g_sfca_m_t        type_g_sfca_m

   DEFINE g_sfcadocno_t LIKE sfca_t.sfcadocno
DEFINE g_sfca001_t LIKE sfca_t.sfca001


DEFINE g_sfcb_d          DYNAMIC ARRAY OF type_g_sfcb_d
DEFINE g_sfcb_d_t        type_g_sfcb_d
DEFINE g_sfcb_d_o        type_g_sfcb_d   #160824-00007#215 by sakura add
DEFINE g_sfcb2_d   DYNAMIC ARRAY OF type_g_sfcb2_d
DEFINE g_sfcb2_d_t type_g_sfcb2_d



DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
    #     b_statepic     LIKE type_t.chr50,
            b_sfcadocno LIKE sfca_t.sfcadocno,
      b_sfca001 LIKE sfca_t.sfca001
         #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_browser_f  RECORD    #資料瀏覽之欄位
     #    b_statepic     LIKE type_t.chr50,
            b_sfcadocno LIKE sfca_t.sfcadocno,
      b_sfca001 LIKE sfca_t.sfca001
         #,rank           LIKE type_t.num10
      END RECORD

#無單頭append欄位定義
DEFINE g_detail_multi_table_t    RECORD
      ooff001 LIKE ooff_t.ooff001,
      ooff002 LIKE ooff_t.ooff002,
      ooff003 LIKE ooff_t.ooff003,
      ooff004 LIKE ooff_t.ooff004,
      ooff005 LIKE ooff_t.ooff005,
      ooff006 LIKE ooff_t.ooff006,
      ooff007 LIKE ooff_t.ooff007,
      ooff008 LIKE ooff_t.ooff008,
      ooff009 LIKE ooff_t.ooff009,
      ooff010 LIKE ooff_t.ooff010,
      ooff011 LIKE ooff_t.ooff011,
      ooff012 LIKE ooff_t.ooff012,
      ooff013 LIKE ooff_t.ooff013
      END RECORD

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING


DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
#161108-00013#1-s-mod 把筆數num5變num10
#DEFINE g_rec_b               LIKE type_t.num5
#DEFINE l_ac                  LIKE type_t.num5
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
#
#DEFINE g_pagestart           LIKE type_t.num5
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_state               STRING
#DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數  
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
#DEFINE g_searchcol           STRING                        #查詢欄位代碼
#DEFINE g_searchstr           STRING                        #查詢欄位字串
#DEFINE g_order               STRING                        #查詢排序欄位
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
#DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
#DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數  
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
#161108-00013#1-e-mod

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #

DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身

{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_sfcasite_t          LIKE sfca_t.sfcasite
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="asft301.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT sfcadocno,sfca002,'','','','','','','','',sfca001,sfca005,'','','',sfca003,'','','','',sfca004,'','','',sfcasite,'','' FROM sfca_t",
                      " WHERE sfcaent=? AND sfcasite='",g_site,"' AND sfcadocno=? AND sfca001=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE asft301_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asft301 WITH FORM cl_ap_formpath("asf",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL asft301_init()
 
      #進入選單 Menu (='N')
      CALL asft301_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_asft301
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="asft301.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION asft301_init()
   #add-point:init段define

   #end add-point

   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   CALL cl_set_combo_scc_part('sfaastus','13','C,D,E,F,M,N,R,W,X,Y')
   CALL cl_set_combo_scc('sfaa003','4007')
   CALL cl_set_combo_scc('sfaa005','4009')
   CALL cl_set_combo_scc('sfca005','4054')
   CALL cl_set_combo_scc('sfcb005','1202')

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   #add-point:畫面資料初始化
   #{<point name="init.init"/>}
   #end add-point

   CALL asft301_default_search()

END FUNCTION

PRIVATE FUNCTION asft301_ui_dialog()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   DEFINE l_sfoa900  LIKE sfoa_t.sfoa900
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING   
   #end add-point

   CALL cl_set_act_visible("accept,cancel", FALSE)


   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   
   #end add-point

   WHILE TRUE
      IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2])THEN
         LET g_sfca_m.sfcadocno = g_argv[1]
         LET g_sfca_m.sfca001 = g_argv[2]
         SELECT sfca002,sfca003,sfca004,sfca005,sfcasite INTO g_sfca_m.sfca002,g_sfca_m.sfca003,g_sfca_m.sfca004,g_sfca_m.sfca005,g_sfca_m.sfcasite FROM sfca_t 
          WHERE sfcaent=g_enterprise AND sfcadocno=g_sfca_m.sfcadocno AND sfca001=g_sfca_m.sfca001
         CALL asft301_show()
      ELSE
         CALL asft301_browser_fill("")
      END IF 
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         DISPLAY ARRAY g_sfcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               CALL asft301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

               #add-point:page1, before row動作
               {<point name="ui_dialog.page1.before_row"/>}
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL asft301_idx_chk()
               #add-point:page1自定義行為
               {<point name="ui_dialog.page1.before_display"/>}
               #end add-point

            #自訂ACTION(detail_show,page_1)


            #add-point:page1自定義行為
            {<point name="ui_dialog.page1.action"/>}
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_sfcb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL asft301_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

               #add-point:page2, before row動作
               {<point name="ui_dialog.body2.before_row"/>}
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
			   LET g_current_page = 2
               CALL asft301_idx_chk()
               #add-point:page2自定義行為
               {<point name="ui_dialog.body2.before_display"/>}
               #end add-point

            #自訂ACTION(detail_show,page_2)


            #add-point:page2自定義行為
            {<point name="ui_dialog.body2.action"/>}
            #end add-point

         END DISPLAY



         #add-point:ui_dialog段自定義display array
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point


         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE

            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF

            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL asft301_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asft301_ui_detailshow() #Setting the current row

            #筆數顯示
            LET g_current_page = 1
            CALL asft301_idx_chk()

            #160727-00025#3-s
            #1.工單類型為5模具工單時，才顯示
            #2.在工單已確認或已發出後才可使用   
            IF g_sfca_m.sfaa003 = '5' AND (g_sfca_m.sfaastus = 'Y' OR g_sfca_m.sfaastus = 'F') THEN
               CALL cl_set_act_visible("add_process", TRUE)
            ELSE
               CALL cl_set_act_visible("add_process", FALSE)   
            END IF
            #160727-00025#3-e
            
            #add-point:ui_dialog段before_dialog2
            {<point name="ui_dialog.before_dialog2"/>}
            #end add-point

            #NEXT FIELD sfcb002

#        ON ACTION statechange
#           CALL asft301_statechange()
#           LET g_action_choice = "statechange"
#           EXIT DIALOG

         #此段落由子樣板a32產生
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status
            {<point name="menu.bpm_status" />}
            #END add-point

#160727-00025#3-s
         ON ACTION add_process
            LET g_action_choice="add_process"
            IF cl_auth_chk_act("add_process") THEN
               CALL asft301_ins_sfoa() RETURNING l_sfoa900
               
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft801'
               LET la_param.param[1] = g_sfca_m.sfcadocno
               LET la_param.param[2] = g_sfca_m.sfca001
               LET la_param.param[3] = l_sfoa900
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)               
            END IF         
#160727-00025#3-e


         #ACTION表單列

         ON ACTION first
            CALL asft301_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft301_idx_chk()

         ON ACTION previous
            CALL asft301_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft301_idx_chk()

         ON ACTION jump
            CALL asft301_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft301_idx_chk()

         ON ACTION next
            CALL asft301_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft301_idx_chk()

         ON ACTION last
            CALL asft301_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft301_idx_chk()

         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
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

      #   ON ACTION delete
      #
      #      LET g_action_choice="delete"
      #      IF cl_auth_chk_act("delete") THEN 
      #      #   CALL asft301_delete()
      #         #add-point:ON ACTION delete
	  #
      #         #END add-point
      #      END IF
      #
      #
      #   ON ACTION insert
      #
      #      LET g_action_choice="insert"
      #      IF cl_auth_chk_act("insert") THEN 
      #         CALL asft301_insert()
      #         #add-point:ON ACTION insert
	  #
      #         #END add-point
      #         EXIT DIALOG
      #      END IF

         ON ACTION modify
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL asft301_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
               EXIT DIALOG
            END IF


         ON ACTION modify_detail
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               CALL asft301_modify()
               #add-point:ON ACTION modify_detail
               {<point name="menu.modify_detail" />}
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

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_browser)
               LET g_export_id[1]   = "s_browse"
               LET g_export_node[2] = base.typeInfo.create(g_sfcb_d)
               LET g_export_id[2]   = "s_detail1"
               LET g_export_node[3] = base.typeInfo.create(g_sfcb2_d)
               LET g_export_id[3]   = "s_detail2"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asft301_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
            
         ON ACTION gen_sfcc
            LET g_action_choice="gen_sfcc"
            IF cl_auth_chk_act("gen_sfcc") THEN
               IF l_ac > 0 THEN
                  CALL asft301_01(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'N')
               END IF
            END IF
            
         ON ACTION gen_checkin
            LET g_action_choice="gen_checkin"
            IF cl_auth_chk_act("gen_checkin") THEN
               IF l_ac > 0 THEN
                  CALL asft301_02(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'1','N')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00139'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
         
         ON ACTION gen_checkout
            LET g_action_choice="gen_checkout"
            IF cl_auth_chk_act("gen_checkout") THEN
               IF l_ac > 0 THEN
                  CALL asft301_02(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'2','N')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00139'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            

     #   ON ACTION reproduce
     #
     #      LET g_action_choice="reproduce"
     #      IF cl_auth_chk_act("reproduce") THEN 
     #         CALL asft301_reproduce()
     #         #add-point:ON ACTION reproduce
	 #
     #         #END add-point
     #         EXIT DIALOG
     #      END IF

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

PRIVATE FUNCTION asft301_browser_search(p_type)
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
      LET g_wc = " 1=1 "
   END IF

   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY sfcadocno"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF

   CALL asft301_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION asft301_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_sfca_m.* TO NULL
   CALL g_sfcb_d.clear()
   CALL g_sfcb2_d.clear()


   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "sfcadocno"
                        ,",sfca001"


   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET g_wc = g_wc," AND sfcasite='",g_site,"'"

   LET l_wc  = g_wc.trim()
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF

   #add-point:browser_fill,foreach前
   {<point name="browser_fill.before_foreach"/>}
   #end add-point

   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE sfcadocno ",
                                    ",sfca001 ",


                        " FROM sfca_t ",
                              " ",
                              " LEFT JOIN sfcb_t ON sfcbent = sfcaent AND sfcadocno = sfcbdocno AND sfca001 = sfcb001 ",
                              " ,sfaa_t ",
                       " WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno AND sfcaent = '" ||g_enterprise|| "' AND sfcbent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
                       , cl_sql_add_filter("sfca_t")   #161214-00062#1 add
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE sfcadocno ",
                                    ",sfca001 ",


                        " FROM sfca_t,sfaa_t ",
                              " ",
                              " ",
                        "WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno AND sfcaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
                        , cl_sql_add_filter("sfca_t")   #161214-00062#1 add
   END IF

   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"

   #add-point:browser_fill,count前
   {<point name="browser_fill.before_count"/>}
   #end add-point

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre

   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   #LET g_page_action = ps_page_action          # Keep Action

   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF

   CASE ps_page_action
      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - 1
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + 1
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 1) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - 1
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 1) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - 1
         END WHILE

      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF

   END CASE

   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      #依照sfcadocno,sfca001 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT sfcadocno,sfca001,DENSE_RANK() OVER(ORDER BY sfcadocno,sfca001 ",g_order,") AS RANK ",
                        " FROM sfca_t ",
                              " ",
                              " LEFT JOIN sfcb_t ON sfcbent = sfcaent AND sfcadocno = sfcbdocno AND sfca001 = sfcb001 ",
                              " ,sfaa_t ",
                       " WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno AND sfcaent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
                       , cl_sql_add_filter("sfca_t")   #161214-00062#1 add
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT sfcadocno,sfca001,DENSE_RANK() OVER(ORDER BY sfcadocno,sfca001 ",g_order,") AS RANK ",
                       " FROM sfca_t,sfaa_t ",
                            "  ",
                            "  ",
                       " WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno AND sfcaent = '" ||g_enterprise|| "' AND ", g_wc
                       , cl_sql_add_filter("sfca_t")   #161214-00062#1 add
   END IF

   #定義翻頁CURSOR
   LET g_sql= "SELECT sfcadocno,sfca001 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order

   #add-point:browser_fill,before_prepare
   {<point name="browser_fill.before_prepare"/>}
   #end add-point

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   #add-point:browser_fill,open
   {<point name="browser_fill.open"/>}
   #end add-point

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_sfcadocno,g_browser[g_cnt].b_sfca001

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

            #此段落由子樣板a24產生
#      CASE g_browser[g_cnt].b_statepic
#         WHEN "C"
#            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
#         WHEN "D"
#            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
#
#         WHEN "E"
#            LET g_browser[g_cnt].b_statepic = "stus/16/closed_irregular.png"
#
#         WHEN "F"
#            LET g_browser[g_cnt].b_statepic = "stus/16/released.png"
#
#         WHEN "M"
#            LET g_browser[g_cnt].b_statepic = "stus/16/costing_closed.png"
#
#         WHEN "N"
#            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
#
#         WHEN "R"
#            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
#
#         WHEN "W"
#            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
#
#         WHEN "X"
#            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
#
#         WHEN "Y"
#            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
#
#
#		
#      END CASE


      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()

   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0

   FREE browse_pre

   #add-point:browser_fill段結束前
   {<point name="browser_fill.after"/>}
   #end add-point

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

END FUNCTION

PRIVATE FUNCTION asft301_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point

   LET g_sfca_m.sfcadocno = g_browser[g_current_idx].b_sfcadocno
   LET g_sfca_m.sfca001 = g_browser[g_current_idx].b_sfca001


    SELECT UNIQUE sfcadocno,sfca002,sfca001,sfca005,sfca003,sfca004,sfcasite
 INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfca003,g_sfca_m.sfca004,
     g_sfca_m.sfcasite
 FROM sfca_t
 WHERE sfcaent = g_enterprise AND sfcadocno = g_sfca_m.sfcadocno AND sfca001 = g_sfca_m.sfca001
   CALL asft301_show()

END FUNCTION

PRIVATE FUNCTION asft301_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point

   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)


   END IF

   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_sfcadocno = g_sfca_m.sfcadocno
         AND g_browser[l_i].b_sfca001 = g_sfca_m.sfca001


         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR

   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF

   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示

END FUNCTION

PRIVATE FUNCTION asft301_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_sfca_m.* TO NULL
   CALL g_sfcb_d.clear()
   CALL g_sfcb2_d.clear()



   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL

   INITIALIZE g_wc2_table1 TO NULL


   LET g_qryparam.state = 'c'

   #add-point:cs段開始前
   {<point name="cs.before_construct"/>}
   #end add-point

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT BY NAME g_wc ON sfcadocno,sfca002,sfca001,sfca005,sfaa003,sfaa016,sfaa010,sfaa011,sfca003,sfaa013,sfca004,sfaa017,sfaa019,sfaa020,sfaa005,sfaa006,sfaa007,sfaa008,sfaa063,sfaa009,sfaastus

         BEFORE CONSTRUCT
#saki            CALL cl_qbe_init()
            #add-point:cs段before_construct
            {<point name="cs.head.before_construct"/>}
            #end add-point

         #公用欄位開窗相關處理


         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         #----<<sfcadocno>>----
         #Ctrlp:construct.c.sfcadocno
         ON ACTION controlp INFIELD sfcadocno
            #add-point:ON ACTION controlp INFIELD sfcadocno
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcadocno  #顯示到畫面上

            NEXT FIELD sfcadocno                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcadocno
            #add-point:BEFORE FIELD sfcadocno
            {<point name="construct.b.sfcadocno" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcadocno

            #add-point:AFTER FIELD sfcadocno
            {<point name="construct.a.sfcadocno" />}
            #END add-point


         #----<<sfca002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfca002
            #add-point:BEFORE FIELD sfca002
            {<point name="construct.b.sfca002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfca002

            #add-point:AFTER FIELD sfca002
            {<point name="construct.a.sfca002" />}
            #END add-point


         #Ctrlp:construct.c.sfca002
#         ON ACTION controlp INFIELD sfca002
            #add-point:ON ACTION controlp INFIELD sfca002
            {<point name="construct.c.sfca002" />}
            #END add-point

         #----<<sfca001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfca001
            #add-point:BEFORE FIELD sfca001
            {<point name="construct.b.sfca001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfca001

            #add-point:AFTER FIELD sfca001
            {<point name="construct.a.sfca001" />}
            #END add-point


         #Ctrlp:construct.c.sfca001
#         ON ACTION controlp INFIELD sfca001
            #add-point:ON ACTION controlp INFIELD sfca001
            {<point name="construct.c.sfca001" />}
            #END add-point

         #----<<sfca005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfca005
            #add-point:BEFORE FIELD sfca005
            {<point name="construct.b.sfca005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfca005

            #add-point:AFTER FIELD sfca005
            {<point name="construct.a.sfca005" />}
            #END add-point


         #Ctrlp:construct.c.sfca005
#         ON ACTION controlp INFIELD sfca005
            #add-point:ON ACTION controlp INFIELD sfca005
            {<point name="construct.c.sfca005" />}
            #END add-point

         #----<<sfca003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfca003
            #add-point:BEFORE FIELD sfca003
            {<point name="construct.b.sfca003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfca003

            #add-point:AFTER FIELD sfca003
            {<point name="construct.a.sfca003" />}
            #END add-point


         #Ctrlp:construct.c.sfca003
#         ON ACTION controlp INFIELD sfca003
            #add-point:ON ACTION controlp INFIELD sfca003
            {<point name="construct.c.sfca003" />}
            #END add-point

         #----<<sfca004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfca004
            #add-point:BEFORE FIELD sfca004
            {<point name="construct.b.sfca004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfca004

            #add-point:AFTER FIELD sfca004
            {<point name="construct.a.sfca004" />}
            #END add-point


         #Ctrlp:construct.c.sfca004
#         ON ACTION controlp INFIELD sfca004
            #add-point:ON ACTION controlp INFIELD sfca004
            {<point name="construct.c.sfca004" />}
            #END add-point

          ON ACTION controlp INFIELD sfaa016
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ecba002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa016  #顯示到畫面上
            NEXT FIELD sfaa016                     #返回原欄位

         ON ACTION controlp INFIELD sfaa010
            #add-point:ON ACTION controlp INFIELD sfaa010
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上

            NEXT FIELD sfaa010                     #返回原欄位
            
         ON ACTION controlp INFIELD sfaa013
            #add-point:ON ACTION controlp INFIELD sfaa013
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa013  #顯示到畫面上

            NEXT FIELD sfaa013                     #返回原欄位
            
         ON ACTION controlp INFIELD sfaa017
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa017  #顯示到畫面上
            NEXT FIELD sfaa017                     #返回原欄位

         ON ACTION controlp INFIELD sfaa006
            #add-point:ON ACTION controlp INFIELD sfaa005
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " sfaasite = '",g_site,"'"
            CALL q_sfaa006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa006      #顯示到畫面上
            DISPLAY g_qryparam.return2 TO sfaa007      #顯示到畫面上
            DISPLAY g_qryparam.return3 TO sfaa008      #顯示到畫面上
            DISPLAY g_qryparam.return4 TO sfaa063      #顯示到畫面上
            NEXT FIELD sfaa006                         #返回原欄位
            
         ON ACTION controlp INFIELD sfaa007
            #add-point:ON ACTION controlp INFIELD sfaa005
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " sfaasite = '",g_site,"'"
            CALL q_sfaa006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa006      #顯示到畫面上
            DISPLAY g_qryparam.return2 TO sfaa007      #顯示到畫面上
            DISPLAY g_qryparam.return3 TO sfaa008      #顯示到畫面上
            DISPLAY g_qryparam.return4 TO sfaa063      #顯示到畫面上
            NEXT FIELD sfaa007                        #返回原欄位
            
         ON ACTION controlp INFIELD sfaa008
            #add-point:ON ACTION controlp INFIELD sfaa005
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " sfaasite = '",g_site,"'"
            CALL q_sfaa006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa006      #顯示到畫面上
            DISPLAY g_qryparam.return2 TO sfaa007      #顯示到畫面上
            DISPLAY g_qryparam.return3 TO sfaa008      #顯示到畫面上
            DISPLAY g_qryparam.return4 TO sfaa063      #顯示到畫面上
            NEXT FIELD sfaa008                         #返回原欄位
            
         ON ACTION controlp INFIELD sfaa063
            #add-point:ON ACTION controlp INFIELD sfaa005
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " sfaasite = '",g_site,"'"
            CALL q_sfaa006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa006      #顯示到畫面上
            DISPLAY g_qryparam.return2 TO sfaa007      #顯示到畫面上
            DISPLAY g_qryparam.return3 TO sfaa008      #顯示到畫面上
            DISPLAY g_qryparam.return4 TO sfaa063      #顯示到畫面上
            NEXT FIELD sfaa063                         #返回原欄位
            
         ON ACTION controlp INFIELD sfaa009
            #add-point:ON ACTION controlp INFIELD sfaa009
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa009  #顯示到畫面上
            NEXT FIELD sfaa009                     #返回原欄位

      END CONSTRUCT

      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON sfcb002,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,sfcb008,sfcb009,sfcb010,
          sfcb011,sfcb023,sfcb024,sfcb025,sfcb026,sfcb044,sfcb045,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,
          sfcb017,sfcb018,sfcb019,sfcb052,sfcb053,sfcb054,sfcb020,sfcb021,sfcb022,sfcb055,sfcb027,sfcb050,
          sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,
          sfcb040,sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051
           FROM s_detail1[1].sfcb002,s_detail1[1].sfcb003,s_detail1[1].sfcb004,s_detail1[1].sfcb005,
               s_detail1[1].sfcb006,s_detail1[1].sfcb007,s_detail1[1].sfcb008,s_detail1[1].sfcb009,s_detail1[1].sfcb010,
               s_detail1[1].sfcb011,s_detail1[1].sfcb023,s_detail1[1].sfcb024,s_detail1[1].sfcb025,s_detail1[1].sfcb026,
               s_detail1[1].sfcb044,s_detail1[1].sfcb045,s_detail1[1].sfcb012,s_detail1[1].sfcb013,s_detail1[1].sfcb014,
               s_detail1[1].sfcb015,s_detail1[1].sfcb016,s_detail1[1].sfcb017,s_detail1[1].sfcb018,s_detail1[1].sfcb019,
               s_detail1[1].sfcb052,s_detail1[1].sfcb053,s_detail1[1].sfcb054,s_detail1[1].sfcb020,s_detail1[1].sfcb021,
               s_detail1[1].sfcb022,s_detail1[1].sfcb055,s_detail2[1].sfcb027,s_detail2[1].sfcb050,s_detail2[1].sfcb028,
               s_detail2[1].sfcb029,s_detail2[1].sfcb030,s_detail2[1].sfcb031,s_detail2[1].sfcb032,s_detail2[1].sfcb033,
               s_detail2[1].sfcb034,s_detail2[1].sfcb035,s_detail2[1].sfcb036,s_detail2[1].sfcb037,s_detail2[1].sfcb038,
               s_detail2[1].sfcb039,s_detail2[1].sfcb040,s_detail2[1].sfcb041,s_detail2[1].sfcb042,s_detail2[1].sfcb043,
               s_detail2[1].sfcb046,s_detail2[1].sfcb047,s_detail2[1].sfcb048,s_detail2[1].sfcb049,s_detail2[1].sfcb051


         BEFORE CONSTRUCT
#saki            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<sfcb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb002
            #add-point:BEFORE FIELD sfcb002
            {<point name="construct.b.page1.sfcb002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb002

            #add-point:AFTER FIELD sfcb002
            {<point name="construct.a.page1.sfcb002" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb002
#         ON ACTION controlp INFIELD sfcb002
            #add-point:ON ACTION controlp INFIELD sfcb002
            {<point name="construct.c.page1.sfcb002" />}
            #END add-point

         #----<<sfcb003>>----
         #Ctrlp:construct.c.page1.sfcb003
         ON ACTION controlp INFIELD sfcb003
            #add-point:ON ACTION controlp INFIELD sfcb003
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcb003  #顯示到畫面上

            NEXT FIELD sfcb003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcb003
            #add-point:BEFORE FIELD sfcb003
            {<point name="construct.b.page1.sfcb003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb003

            #add-point:AFTER FIELD sfcb003
            {<point name="construct.a.page1.sfcb003" />}
            #END add-point


         #----<<sfcb004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb004
            #add-point:BEFORE FIELD sfcb004
            {<point name="construct.b.page1.sfcb004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb004

            #add-point:AFTER FIELD sfcb004
            {<point name="construct.a.page1.sfcb004" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb004
#         ON ACTION controlp INFIELD sfcb004
            #add-point:ON ACTION controlp INFIELD sfcb004
            {<point name="construct.c.page1.sfcb004" />}
            #END add-point

         #----<<sfcb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb005
            #add-point:BEFORE FIELD sfcb005
            {<point name="construct.b.page1.sfcb005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb005

            #add-point:AFTER FIELD sfcb005
            {<point name="construct.a.page1.sfcb005" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb005
#         ON ACTION controlp INFIELD sfcb005
            #add-point:ON ACTION controlp INFIELD sfcb005
            {<point name="construct.c.page1.sfcb005" />}
            #END add-point

         #----<<sfcb006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb006
            #add-point:BEFORE FIELD sfcb006
            {<point name="construct.b.page1.sfcb006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb006

            #add-point:AFTER FIELD sfcb006
            {<point name="construct.a.page1.sfcb006" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb006
#         ON ACTION controlp INFIELD sfcb006
            #add-point:ON ACTION controlp INFIELD sfcb006
            {<point name="construct.c.page1.sfcb006" />}
            #END add-point

         #----<<sfcb007>>----
         #Ctrlp:construct.c.page1.sfcb007
         ON ACTION controlp INFIELD sfcb007
            #add-point:ON ACTION controlp INFIELD sfcb007
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcb007  #顯示到畫面上

            NEXT FIELD sfcb007                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcb007
            #add-point:BEFORE FIELD sfcb007
            {<point name="construct.b.page1.sfcb007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb007

            #add-point:AFTER FIELD sfcb007
            {<point name="construct.a.page1.sfcb007" />}
            #END add-point


         #----<<sfcb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb008
            #add-point:BEFORE FIELD sfcb008
            {<point name="construct.b.page1.sfcb008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb008

            #add-point:AFTER FIELD sfcb008
            {<point name="construct.a.page1.sfcb008" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb008
#         ON ACTION controlp INFIELD sfcb008
            #add-point:ON ACTION controlp INFIELD sfcb008
            {<point name="construct.c.page1.sfcb008" />}
            #END add-point

         #----<<sfcb009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb009
            #add-point:BEFORE FIELD sfcb009
            {<point name="construct.b.page1.sfcb009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb009

            #add-point:AFTER FIELD sfcb009
            {<point name="construct.a.page1.sfcb009" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb009
#         ON ACTION controlp INFIELD sfcb009
            #add-point:ON ACTION controlp INFIELD sfcb009
            {<point name="construct.c.page1.sfcb009" />}
            #END add-point

         #----<<sfcb010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb010
            #add-point:BEFORE FIELD sfcb010
            {<point name="construct.b.page1.sfcb010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb010

            #add-point:AFTER FIELD sfcb010
            {<point name="construct.a.page1.sfcb010" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb010
#         ON ACTION controlp INFIELD sfcb010
            #add-point:ON ACTION controlp INFIELD sfcb010
            {<point name="construct.c.page1.sfcb010" />}
            #END add-point

         #----<<sfcb011>>----
         #Ctrlp:construct.c.page1.sfcb011
         ON ACTION controlp INFIELD sfcb011
            #add-point:ON ACTION controlp INFIELD sfcb011
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ecaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcb011  #顯示到畫面上

            NEXT FIELD sfcb011                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcb011
            #add-point:BEFORE FIELD sfcb011
            {<point name="construct.b.page1.sfcb011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb011

            #add-point:AFTER FIELD sfcb011
            {<point name="construct.a.page1.sfcb011" />}
            #END add-point


         #----<<sfcb023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb023
            #add-point:BEFORE FIELD sfcb023
            {<point name="construct.b.page1.sfcb023" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb023

            #add-point:AFTER FIELD sfcb023
            {<point name="construct.a.page1.sfcb023" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb023
#         ON ACTION controlp INFIELD sfcb023
            #add-point:ON ACTION controlp INFIELD sfcb023
            {<point name="construct.c.page1.sfcb023" />}
            #END add-point

         #----<<sfcb024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb024
            #add-point:BEFORE FIELD sfcb024
            {<point name="construct.b.page1.sfcb024" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb024

            #add-point:AFTER FIELD sfcb024
            {<point name="construct.a.page1.sfcb024" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb024
#         ON ACTION controlp INFIELD sfcb024
            #add-point:ON ACTION controlp INFIELD sfcb024
            {<point name="construct.c.page1.sfcb024" />}
            #END add-point

         #----<<sfcb025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb025
            #add-point:BEFORE FIELD sfcb025
            {<point name="construct.b.page1.sfcb025" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb025

            #add-point:AFTER FIELD sfcb025
            {<point name="construct.a.page1.sfcb025" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb025
#         ON ACTION controlp INFIELD sfcb025
            #add-point:ON ACTION controlp INFIELD sfcb025
            {<point name="construct.c.page1.sfcb025" />}
            #END add-point

         #----<<sfcb026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb026
            #add-point:BEFORE FIELD sfcb026
            {<point name="construct.b.page1.sfcb026" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb026

            #add-point:AFTER FIELD sfcb026
            {<point name="construct.a.page1.sfcb026" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb026
#         ON ACTION controlp INFIELD sfcb026
            #add-point:ON ACTION controlp INFIELD sfcb026
            {<point name="construct.c.page1.sfcb026" />}
            #END add-point

         #----<<sfcb044>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb044
            #add-point:BEFORE FIELD sfcb044
            {<point name="construct.b.page1.sfcb044" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb044

            #add-point:AFTER FIELD sfcb044
            {<point name="construct.a.page1.sfcb044" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb044
#         ON ACTION controlp INFIELD sfcb044
            #add-point:ON ACTION controlp INFIELD sfcb044
            {<point name="construct.c.page1.sfcb044" />}
            #END add-point

         #----<<sfcb045>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb045
            #add-point:BEFORE FIELD sfcb045
            {<point name="construct.b.page1.sfcb045" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb045

            #add-point:AFTER FIELD sfcb045
            {<point name="construct.a.page1.sfcb045" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb045
#         ON ACTION controlp INFIELD sfcb045
            #add-point:ON ACTION controlp INFIELD sfcb045
            {<point name="construct.c.page1.sfcb045" />}
            #END add-point

         #----<<sfcb012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb012
            #add-point:BEFORE FIELD sfcb012
            {<point name="construct.b.page1.sfcb012" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb012

            #add-point:AFTER FIELD sfcb012
            {<point name="construct.a.page1.sfcb012" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb012
#         ON ACTION controlp INFIELD sfcb012
            #add-point:ON ACTION controlp INFIELD sfcb012
            {<point name="construct.c.page1.sfcb012" />}
            #END add-point

         #----<<sfcb013>>----
         #Ctrlp:construct.c.page1.sfcb013
         ON ACTION controlp INFIELD sfcb013
            #add-point:ON ACTION controlp INFIELD sfcb013
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcb013  #顯示到畫面上

            NEXT FIELD sfcb013                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcb013
            #add-point:BEFORE FIELD sfcb013
            {<point name="construct.b.page1.sfcb013" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb013

            #add-point:AFTER FIELD sfcb013
            {<point name="construct.a.page1.sfcb013" />}
            #END add-point


         #----<<sfcb014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb014
            #add-point:BEFORE FIELD sfcb014
            {<point name="construct.b.page1.sfcb014" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb014

            #add-point:AFTER FIELD sfcb014
            {<point name="construct.a.page1.sfcb014" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb014
#         ON ACTION controlp INFIELD sfcb014
            #add-point:ON ACTION controlp INFIELD sfcb014
            {<point name="construct.c.page1.sfcb014" />}
            #END add-point

         #----<<sfcb015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb015
            #add-point:BEFORE FIELD sfcb015
            {<point name="construct.b.page1.sfcb015" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb015

            #add-point:AFTER FIELD sfcb015
            {<point name="construct.a.page1.sfcb015" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb015
#         ON ACTION controlp INFIELD sfcb015
            #add-point:ON ACTION controlp INFIELD sfcb015
            {<point name="construct.c.page1.sfcb015" />}
            #END add-point

         #----<<sfcb016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb016
            #add-point:BEFORE FIELD sfcb016
            {<point name="construct.b.page1.sfcb016" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb016

            #add-point:AFTER FIELD sfcb016
            {<point name="construct.a.page1.sfcb016" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb016
#         ON ACTION controlp INFIELD sfcb016
            #add-point:ON ACTION controlp INFIELD sfcb016
            {<point name="construct.c.page1.sfcb016" />}
            #END add-point

         #----<<sfcb017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb017
            #add-point:BEFORE FIELD sfcb017
            {<point name="construct.b.page1.sfcb017" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb017

            #add-point:AFTER FIELD sfcb017
            {<point name="construct.a.page1.sfcb017" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb017
#         ON ACTION controlp INFIELD sfcb017
            #add-point:ON ACTION controlp INFIELD sfcb017
            {<point name="construct.c.page1.sfcb017" />}
            #END add-point

         #----<<sfcb018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb018
            #add-point:BEFORE FIELD sfcb018
            {<point name="construct.b.page1.sfcb018" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb018

            #add-point:AFTER FIELD sfcb018
            {<point name="construct.a.page1.sfcb018" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb018
#         ON ACTION controlp INFIELD sfcb018
            #add-point:ON ACTION controlp INFIELD sfcb018
            {<point name="construct.c.page1.sfcb018" />}
            #END add-point

         #----<<sfcb019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb019
            #add-point:BEFORE FIELD sfcb019
            {<point name="construct.b.page1.sfcb019" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb019

            #add-point:AFTER FIELD sfcb019
            {<point name="construct.a.page1.sfcb019" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb019
#         ON ACTION controlp INFIELD sfcb019
            #add-point:ON ACTION controlp INFIELD sfcb019
            {<point name="construct.c.page1.sfcb019" />}
            #END add-point

         #----<<sfcb052>>----
         #Ctrlp:construct.c.page1.sfcb052
         ON ACTION controlp INFIELD sfcb052
            #add-point:ON ACTION controlp INFIELD sfcb052
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcb052  #顯示到畫面上

            NEXT FIELD sfcb052                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcb052
            #add-point:BEFORE FIELD sfcb052
            {<point name="construct.b.page1.sfcb052" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb052

            #add-point:AFTER FIELD sfcb052
            {<point name="construct.a.page1.sfcb052" />}
            #END add-point


         #----<<sfcb053>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb053
            #add-point:BEFORE FIELD sfcb053
            {<point name="construct.b.page1.sfcb053" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb053

            #add-point:AFTER FIELD sfcb053
            {<point name="construct.a.page1.sfcb053" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb053
#         ON ACTION controlp INFIELD sfcb053
            #add-point:ON ACTION controlp INFIELD sfcb053
            {<point name="construct.c.page1.sfcb053" />}
            #END add-point

         #----<<sfcb054>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb054
            #add-point:BEFORE FIELD sfcb054
            {<point name="construct.b.page1.sfcb054" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb054

            #add-point:AFTER FIELD sfcb054
            {<point name="construct.a.page1.sfcb054" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb054
#         ON ACTION controlp INFIELD sfcb054
            #add-point:ON ACTION controlp INFIELD sfcb054
            {<point name="construct.c.page1.sfcb054" />}
            #END add-point

         #----<<sfcb020>>----
         #Ctrlp:construct.c.page1.sfcb020
         ON ACTION controlp INFIELD sfcb020
            #add-point:ON ACTION controlp INFIELD sfcb020
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfcb020  #顯示到畫面上

            NEXT FIELD sfcb020                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD sfcb020
            #add-point:BEFORE FIELD sfcb020
            {<point name="construct.b.page1.sfcb020" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb020

            #add-point:AFTER FIELD sfcb020
            {<point name="construct.a.page1.sfcb020" />}
            #END add-point


         #----<<sfcb021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb021
            #add-point:BEFORE FIELD sfcb021
            {<point name="construct.b.page1.sfcb021" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb021

            #add-point:AFTER FIELD sfcb021
            {<point name="construct.a.page1.sfcb021" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb021
#         ON ACTION controlp INFIELD sfcb021
            #add-point:ON ACTION controlp INFIELD sfcb021
            {<point name="construct.c.page1.sfcb021" />}
            #END add-point

         #----<<sfcb022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb022
            #add-point:BEFORE FIELD sfcb022
            {<point name="construct.b.page1.sfcb022" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb022

            #add-point:AFTER FIELD sfcb022
            {<point name="construct.a.page1.sfcb022" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb022
#         ON ACTION controlp INFIELD sfcb022
            #add-point:ON ACTION controlp INFIELD sfcb022
            {<point name="construct.c.page1.sfcb022" />}
            #END add-point

         #----<<sfcb055>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb055
            #add-point:BEFORE FIELD sfcb055
            {<point name="construct.b.page1.sfcb055" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb055

            #add-point:AFTER FIELD sfcb055
            {<point name="construct.a.page1.sfcb055" />}
            #END add-point


         #Ctrlp:construct.c.page1.sfcb055
#         ON ACTION controlp INFIELD sfcb055
            #add-point:ON ACTION controlp INFIELD sfcb055
            {<point name="construct.c.page1.sfcb055" />}
            #END add-point

#---------------------<  Detail: page2  >---------------------
         #----<<sfcb027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb027
            #add-point:BEFORE FIELD sfcb027
            {<point name="construct.b.page2.sfcb027" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb027

            #add-point:AFTER FIELD sfcb027
            {<point name="construct.a.page2.sfcb027" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb027
#         ON ACTION controlp INFIELD sfcb027
            #add-point:ON ACTION controlp INFIELD sfcb027
            {<point name="construct.c.page2.sfcb027" />}
            #END add-point

         #----<<sfcb050>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb050
            #add-point:BEFORE FIELD sfcb050
            {<point name="construct.b.page2.sfcb050" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb050

            #add-point:AFTER FIELD sfcb050
            {<point name="construct.a.page2.sfcb050" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb050
#         ON ACTION controlp INFIELD sfcb050
            #add-point:ON ACTION controlp INFIELD sfcb050
            {<point name="construct.c.page2.sfcb050" />}
            #END add-point

         #----<<sfcb028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb028
            #add-point:BEFORE FIELD sfcb028
            {<point name="construct.b.page2.sfcb028" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb028

            #add-point:AFTER FIELD sfcb028
            {<point name="construct.a.page2.sfcb028" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb028
#         ON ACTION controlp INFIELD sfcb028
            #add-point:ON ACTION controlp INFIELD sfcb028
            {<point name="construct.c.page2.sfcb028" />}
            #END add-point

         #----<<sfcb029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb029
            #add-point:BEFORE FIELD sfcb029
            {<point name="construct.b.page2.sfcb029" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb029

            #add-point:AFTER FIELD sfcb029
            {<point name="construct.a.page2.sfcb029" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb029
#         ON ACTION controlp INFIELD sfcb029
            #add-point:ON ACTION controlp INFIELD sfcb029
            {<point name="construct.c.page2.sfcb029" />}
            #END add-point

         #----<<sfcb030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb030
            #add-point:BEFORE FIELD sfcb030
            {<point name="construct.b.page2.sfcb030" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb030

            #add-point:AFTER FIELD sfcb030
            {<point name="construct.a.page2.sfcb030" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb030
#         ON ACTION controlp INFIELD sfcb030
            #add-point:ON ACTION controlp INFIELD sfcb030
            {<point name="construct.c.page2.sfcb030" />}
            #END add-point

         #----<<sfcb031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb031
            #add-point:BEFORE FIELD sfcb031
            {<point name="construct.b.page2.sfcb031" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb031

            #add-point:AFTER FIELD sfcb031
            {<point name="construct.a.page2.sfcb031" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb031
#         ON ACTION controlp INFIELD sfcb031
            #add-point:ON ACTION controlp INFIELD sfcb031
            {<point name="construct.c.page2.sfcb031" />}
            #END add-point

         #----<<sfcb032>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb032
            #add-point:BEFORE FIELD sfcb032
            {<point name="construct.b.page2.sfcb032" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb032

            #add-point:AFTER FIELD sfcb032
            {<point name="construct.a.page2.sfcb032" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb032
#         ON ACTION controlp INFIELD sfcb032
            #add-point:ON ACTION controlp INFIELD sfcb032
            {<point name="construct.c.page2.sfcb032" />}
            #END add-point

         #----<<sfcb033>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb033
            #add-point:BEFORE FIELD sfcb033
            {<point name="construct.b.page2.sfcb033" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb033

            #add-point:AFTER FIELD sfcb033
            {<point name="construct.a.page2.sfcb033" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb033
#         ON ACTION controlp INFIELD sfcb033
            #add-point:ON ACTION controlp INFIELD sfcb033
            {<point name="construct.c.page2.sfcb033" />}
            #END add-point

         #----<<sfcb034>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb034
            #add-point:BEFORE FIELD sfcb034
            {<point name="construct.b.page2.sfcb034" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb034

            #add-point:AFTER FIELD sfcb034
            {<point name="construct.a.page2.sfcb034" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb034
#         ON ACTION controlp INFIELD sfcb034
            #add-point:ON ACTION controlp INFIELD sfcb034
            {<point name="construct.c.page2.sfcb034" />}
            #END add-point

         #----<<sfcb035>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb035
            #add-point:BEFORE FIELD sfcb035
            {<point name="construct.b.page2.sfcb035" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb035

            #add-point:AFTER FIELD sfcb035
            {<point name="construct.a.page2.sfcb035" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb035
#         ON ACTION controlp INFIELD sfcb035
            #add-point:ON ACTION controlp INFIELD sfcb035
            {<point name="construct.c.page2.sfcb035" />}
            #END add-point

         #----<<sfcb036>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb036
            #add-point:BEFORE FIELD sfcb036
            {<point name="construct.b.page2.sfcb036" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb036

            #add-point:AFTER FIELD sfcb036
            {<point name="construct.a.page2.sfcb036" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb036
#         ON ACTION controlp INFIELD sfcb036
            #add-point:ON ACTION controlp INFIELD sfcb036
            {<point name="construct.c.page2.sfcb036" />}
            #END add-point

         #----<<sfcb037>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb037
            #add-point:BEFORE FIELD sfcb037
            {<point name="construct.b.page2.sfcb037" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb037

            #add-point:AFTER FIELD sfcb037
            {<point name="construct.a.page2.sfcb037" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb037
#         ON ACTION controlp INFIELD sfcb037
            #add-point:ON ACTION controlp INFIELD sfcb037
            {<point name="construct.c.page2.sfcb037" />}
            #END add-point

         #----<<sfcb038>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb038
            #add-point:BEFORE FIELD sfcb038
            {<point name="construct.b.page2.sfcb038" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb038

            #add-point:AFTER FIELD sfcb038
            {<point name="construct.a.page2.sfcb038" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb038
#         ON ACTION controlp INFIELD sfcb038
            #add-point:ON ACTION controlp INFIELD sfcb038
            {<point name="construct.c.page2.sfcb038" />}
            #END add-point

         #----<<sfcb039>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb039
            #add-point:BEFORE FIELD sfcb039
            {<point name="construct.b.page2.sfcb039" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb039

            #add-point:AFTER FIELD sfcb039
            {<point name="construct.a.page2.sfcb039" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb039
#         ON ACTION controlp INFIELD sfcb039
            #add-point:ON ACTION controlp INFIELD sfcb039
            {<point name="construct.c.page2.sfcb039" />}
            #END add-point

         #----<<sfcb040>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb040
            #add-point:BEFORE FIELD sfcb040
            {<point name="construct.b.page2.sfcb040" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb040

            #add-point:AFTER FIELD sfcb040
            {<point name="construct.a.page2.sfcb040" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb040
#         ON ACTION controlp INFIELD sfcb040
            #add-point:ON ACTION controlp INFIELD sfcb040
            {<point name="construct.c.page2.sfcb040" />}
            #END add-point

         #----<<sfcb041>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb041
            #add-point:BEFORE FIELD sfcb041
            {<point name="construct.b.page2.sfcb041" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb041

            #add-point:AFTER FIELD sfcb041
            {<point name="construct.a.page2.sfcb041" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb041
#         ON ACTION controlp INFIELD sfcb041
            #add-point:ON ACTION controlp INFIELD sfcb041
            {<point name="construct.c.page2.sfcb041" />}
            #END add-point

         #----<<sfcb042>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb042
            #add-point:BEFORE FIELD sfcb042
            {<point name="construct.b.page2.sfcb042" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb042

            #add-point:AFTER FIELD sfcb042
            {<point name="construct.a.page2.sfcb042" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb042
#         ON ACTION controlp INFIELD sfcb042
            #add-point:ON ACTION controlp INFIELD sfcb042
            {<point name="construct.c.page2.sfcb042" />}
            #END add-point

         #----<<sfcb043>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb043
            #add-point:BEFORE FIELD sfcb043
            {<point name="construct.b.page2.sfcb043" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb043

            #add-point:AFTER FIELD sfcb043
            {<point name="construct.a.page2.sfcb043" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb043
#         ON ACTION controlp INFIELD sfcb043
            #add-point:ON ACTION controlp INFIELD sfcb043
            {<point name="construct.c.page2.sfcb043" />}
            #END add-point

         #----<<sfcb046>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb046
            #add-point:BEFORE FIELD sfcb046
            {<point name="construct.b.page2.sfcb046" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb046

            #add-point:AFTER FIELD sfcb046
            {<point name="construct.a.page2.sfcb046" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb046
#         ON ACTION controlp INFIELD sfcb046
            #add-point:ON ACTION controlp INFIELD sfcb046
            {<point name="construct.c.page2.sfcb046" />}
            #END add-point

         #----<<sfcb047>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb047
            #add-point:BEFORE FIELD sfcb047
            {<point name="construct.b.page2.sfcb047" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb047

            #add-point:AFTER FIELD sfcb047
            {<point name="construct.a.page2.sfcb047" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb047
#         ON ACTION controlp INFIELD sfcb047
            #add-point:ON ACTION controlp INFIELD sfcb047
            {<point name="construct.c.page2.sfcb047" />}
            #END add-point

         #----<<sfcb048>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb048
            #add-point:BEFORE FIELD sfcb048
            {<point name="construct.b.page2.sfcb048" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb048

            #add-point:AFTER FIELD sfcb048
            {<point name="construct.a.page2.sfcb048" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb048
#         ON ACTION controlp INFIELD sfcb048
            #add-point:ON ACTION controlp INFIELD sfcb048
            {<point name="construct.c.page2.sfcb048" />}
            #END add-point

         #----<<sfcb049>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb049
            #add-point:BEFORE FIELD sfcb049
            {<point name="construct.b.page2.sfcb049" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb049

            #add-point:AFTER FIELD sfcb049
            {<point name="construct.a.page2.sfcb049" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb049
#         ON ACTION controlp INFIELD sfcb049
            #add-point:ON ACTION controlp INFIELD sfcb049
            {<point name="construct.c.page2.sfcb049" />}
            #END add-point

         #----<<sfcb051>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb051
            #add-point:BEFORE FIELD sfcb051
            {<point name="construct.b.page2.sfcb051" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD sfcb051

            #add-point:AFTER FIELD sfcb051
            {<point name="construct.a.page2.sfcb051" />}
            #END add-point


         #Ctrlp:construct.c.page2.sfcb051
#         ON ACTION controlp INFIELD sfcb051
            #add-point:ON ACTION controlp INFIELD sfcb051
            {<point name="construct.c.page2.sfcb051" />}
            #END add-point



      END CONSTRUCT





      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      {<point name="cs.add_cs"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:cs段b_dialog
         {<point name="cs.b_dialog"/>}
         #end add-point

      ON ACTION qbe_select     #條件查詢
#saki         CALL cl_qbe_list() RETURNING lc_qbe_sn
#saki         CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION qbe_save       #條件儲存
#saki         CALL cl_qbe_save()

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #組合g_wc2
   LET g_wc2 = g_wc2_table1




   #add-point:cs段結束前
   {<point name="cs.after_construct"/>}
   #end add-point

   IF INT_FLAG THEN
      RETURN
   END IF

END FUNCTION

PRIVATE FUNCTION asft301_filter()










      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point

         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
         #end add-point







END FUNCTION

PRIVATE FUNCTION asft301_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}




END FUNCTION

PRIVATE FUNCTION asft301_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   #切換畫面

   LET ls_wc = g_wc

   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()
   CALL g_sfcb_d.clear()
   CALL g_sfcb2_d.clear()



   #add-point:query段other
   {<point name="query.other"/>}
   #end add-point

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL asft301_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL asft301_browser_fill("")
      CALL asft301_fetch("")
      RETURN
   END IF

   #搜尋後資料初始化
   LET g_detail_cnt = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
   LET g_wc_filter = ""
   CALL FGL_SET_ARR_CURR(1)
   LET g_error_show = 1
   CALL asft301_browser_fill("F")

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL asft301_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION asft301_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point

   IF g_browser_cnt = 0 THEN
      RETURN
   END IF

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

            PROMPT ls_msg CLIPPED,':' FOR g_jump
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

   CALL asft301_browser_fill(p_flag)


   LET g_detail_cnt = g_header_cnt

   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF

   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數

   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   LET g_sfca_m.sfcadocno = g_browser[g_current_idx].b_sfcadocno
   LET g_sfca_m.sfca001 = g_browser[g_current_idx].b_sfca001



   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE sfcadocno,sfca002,sfca001,sfca005,sfca003,sfca004,sfcasite
 INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfca003,g_sfca_m.sfca004,
     g_sfca_m.sfcasite
 FROM sfca_t
 WHERE sfcaent = g_enterprise AND sfcadocno = g_sfca_m.sfcadocno AND sfca001 = g_sfca_m.sfca001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sfca_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_sfca_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   {<point name="fetch.action_control"/>}
   
   #end add-point



   #add-point:fetch結束前
   {<point name="fetch.after" />}
   #end add-point

   #LET g_data_owner =
   #LET g_data_group =

   #重新顯示
   CALL asft301_show()
   
   CALL cl_set_act_visible("gen_checkin,gen_checkout",FALSE)
   IF NOT cl_null(g_sfca_m.sfaa016) AND NOT cl_null(g_sfca_m.sfaa010) THEN
      CALL cl_set_act_visible("gen_checkin,gen_checkout", TRUE) 
   END IF

END FUNCTION

PRIVATE FUNCTION asft301_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   IF g_sfca_m.sfcadocno IS NULL
   OR g_sfca_m.sfca001 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF   

    SELECT UNIQUE sfcadocno,sfca002,sfca001,sfca005,sfca003,sfca004,sfcasite
 INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfca003,g_sfca_m.sfca004,
     g_sfca_m.sfcasite
 FROM sfca_t
 WHERE sfcaent = g_enterprise AND sfcadocno = g_sfca_m.sfcadocno AND sfca001 = g_sfca_m.sfca001

   ERROR ""

   LET g_sfcadocno_t = g_sfca_m.sfcadocno
   LET g_sfca001_t = g_sfca_m.sfca001


   CALL s_transaction_begin()

   OPEN asft301_cl USING g_enterprise,g_sfca_m.sfcadocno,g_sfca_m.sfca001


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN asft301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH asft301_cl INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfaa010,g_sfca_m.sfaa011,g_sfca_m.sfaa017,
       g_sfca_m.sfaa017_desc,g_sfca_m.oobal004,g_sfca_m.sfaa010_desc,g_sfca_m.sfaa019,g_sfca_m.sfaastus,
       g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfaa010_desc1,g_sfca_m.sfaa020,g_sfca_m.sfaa003,g_sfca_m.sfca003,
       g_sfca_m.sfaa013,g_sfca_m.sfaa005,g_sfca_m.sfaa016,g_sfca_m.sfaa016_desc,g_sfca_m.sfca004,g_sfca_m.sfaa006,
       g_sfca_m.sfaa007,g_sfca_m.sfaa008,g_sfca_m.sfcasite,g_sfca_m.sfaa009,g_sfca_m.sfaa009_desc

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfca_m.sfcadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF



   CALL asft301_show()
   WHILE TRUE
      LET g_sfcadocno_t = g_sfca_m.sfcadocno
      LET g_sfca001_t = g_sfca_m.sfca001



      #寫入修改者/修改日期資訊(單頭)


      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point

      CALL asft301_input("u")     #欄位更改

      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_sfca_m.* = g_sfca_m_t.*
         CALL asft301_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
      IF g_sfca_m.sfcadocno != g_sfcadocno_t
      OR g_sfca_m.sfca001 != g_sfca001_t


      THEN
         CALL s_transaction_begin()

         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update" mark="Y"/>}
         #end add-point

         #更新單身key值
         UPDATE sfcb_t SET sfcbdocno = g_sfca_m.sfcadocno
                                      ,sfcb001 = g_sfca_m.sfca001


          WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfcadocno_t
            AND sfcb001 = g_sfca001_t



         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "sfcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update"/>}
         #end add-point





         #UPDATE 多語言table key值




         CALL s_transaction_end('Y','0')
      END IF

      EXIT WHILE
   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_sfca_m.sfcadocno,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE asft301_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_sfca_m.sfcadocno,'U')

END FUNCTION

PRIVATE FUNCTION asft301_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10   #170104-00066#2 num5->num10  17/01/06 mod by rainy
   #161109-00085#28-s
   #DEFINE l_sfaa    RECORD LIKE sfaa_t.*
   DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       #161109-00085#67 --s add
       sfaaud001 LIKE sfaa_t.sfaaud001, #自定義欄位(文字)001
       sfaaud002 LIKE sfaa_t.sfaaud002, #自定義欄位(文字)002
       sfaaud003 LIKE sfaa_t.sfaaud003, #自定義欄位(文字)003
       sfaaud004 LIKE sfaa_t.sfaaud004, #自定義欄位(文字)004
       sfaaud005 LIKE sfaa_t.sfaaud005, #自定義欄位(文字)005
       sfaaud006 LIKE sfaa_t.sfaaud006, #自定義欄位(文字)006
       sfaaud007 LIKE sfaa_t.sfaaud007, #自定義欄位(文字)007
       sfaaud008 LIKE sfaa_t.sfaaud008, #自定義欄位(文字)008
       sfaaud009 LIKE sfaa_t.sfaaud009, #自定義欄位(文字)009
       sfaaud010 LIKE sfaa_t.sfaaud010, #自定義欄位(文字)010
       sfaaud011 LIKE sfaa_t.sfaaud011, #自定義欄位(數字)011
       sfaaud012 LIKE sfaa_t.sfaaud012, #自定義欄位(數字)012
       sfaaud013 LIKE sfaa_t.sfaaud013, #自定義欄位(數字)013
       sfaaud014 LIKE sfaa_t.sfaaud014, #自定義欄位(數字)014
       sfaaud015 LIKE sfaa_t.sfaaud015, #自定義欄位(數字)015
       sfaaud016 LIKE sfaa_t.sfaaud016, #自定義欄位(數字)016
       sfaaud017 LIKE sfaa_t.sfaaud017, #自定義欄位(數字)017
       sfaaud018 LIKE sfaa_t.sfaaud018, #自定義欄位(數字)018
       sfaaud019 LIKE sfaa_t.sfaaud019, #自定義欄位(數字)019
       sfaaud020 LIKE sfaa_t.sfaaud020, #自定義欄位(數字)020
       sfaaud021 LIKE sfaa_t.sfaaud021, #自定義欄位(日期時間)021
       sfaaud022 LIKE sfaa_t.sfaaud022, #自定義欄位(日期時間)022
       sfaaud023 LIKE sfaa_t.sfaaud023, #自定義欄位(日期時間)023
       sfaaud024 LIKE sfaa_t.sfaaud024, #自定義欄位(日期時間)024
       sfaaud025 LIKE sfaa_t.sfaaud025, #自定義欄位(日期時間)025
       sfaaud026 LIKE sfaa_t.sfaaud026, #自定義欄位(日期時間)026
       sfaaud027 LIKE sfaa_t.sfaaud027, #自定義欄位(日期時間)027
       sfaaud028 LIKE sfaa_t.sfaaud028, #自定義欄位(日期時間)028
       sfaaud029 LIKE sfaa_t.sfaaud029, #自定義欄位(日期時間)029
       sfaaud030 LIKE sfaa_t.sfaaud030, #自定義欄位(日期時間)030
       #161109-00085#67 --e add
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
   END RECORD
   #161109-00085#28-e
   
   DEFINE l_success   LIKE type_t.num5                 
   DEFINE l_slip      STRING
   {</Local define>}
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point

   SELECT * INTO l_sfaa.* FROM sfaa_t WHERE sfaaent=g_enterprise AND sfaasite=g_site AND sfaadocno=g_sfca_m.sfcadocno
   LET g_sfca_m.sfaa003 = l_sfaa.sfaa003
   DISPLAY g_sfca_m.sfaa003 TO sfaa003
   LET g_sfca_m.sfaa005 = l_sfaa.sfaa005
   LET g_sfca_m.sfaa006 = l_sfaa.sfaa006
   LET g_sfca_m.sfaa007 = l_sfaa.sfaa007
   LET g_sfca_m.sfaa008 = l_sfaa.sfaa008
   LET g_sfca_m.sfaa063 = l_sfaa.sfaa063
   LET g_sfca_m.sfaa009 = l_sfaa.sfaa009
   LET g_sfca_m.sfaa010 = l_sfaa.sfaa010
   LET g_sfca_m.sfaa011 = l_sfaa.sfaa011
   LET g_sfca_m.sfaa013 = l_sfaa.sfaa013
   LET g_sfca_m.sfaa016 = l_sfaa.sfaa016
   LET g_sfca_m.sfaa017 = l_sfaa.sfaa017
   LET g_sfca_m.sfaa019 = l_sfaa.sfaa019
   LET g_sfca_m.sfaa020 = l_sfaa.sfaa020
   LET g_sfca_m.sfaastus = l_sfaa.sfaastus
   #160727-00025#3-s
   #1.工單類型為5模具工單時，才顯示
   #2.在工單已確認或已發出後才可使用   
   IF g_sfca_m.sfaa003 = '5' AND (g_sfca_m.sfaastus = 'Y' OR g_sfca_m.sfaastus = 'F') THEN
      CALL cl_set_act_visible("add_process", TRUE)
   ELSE
      CALL cl_set_act_visible("add_process", FALSE)   
   END IF
   #160727-00025#3-e
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfca_m.sfaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfca_m.sfaa010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfca_m.sfaa010_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_sfca_m.sfaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_sfca_m.sfaa010_desc1 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_sfca_m.sfaa010_desc1
            
   IF NOT cl_null(g_sfca_m.sfaa009) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfca_m.sfaa009
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfca_m.sfaa009_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_sfca_m.sfaa009_desc
   END IF

   IF NOT cl_null(g_sfca_m.sfaa010) AND NOT cl_null(g_sfca_m.sfaa016) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfca_m.sfaa010
      LET g_ref_fields[2] = g_sfca_m.sfaa016
      CALL ap_ref_array2(g_ref_fields,"SELECT ecba003 FROM ecba_t WHERE ecbaent='"||g_enterprise||"' AND ecba001=? AND ecba002=? ","") RETURNING g_rtn_fields
      LET g_sfca_m.sfaa016_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_sfca_m.sfaa016_desc
   END IF
   
   IF l_sfaa.sfaa057 = '2' THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_sfca_m.sfaa017
      CALL cl_ref_val("v_pmaal004")
      LET g_sfca_m.sfaa017_desc = g_chkparam.return1
      DISPLAY BY NAME g_sfca_m.sfaa017_desc
   ELSE
      CALL s_desc_get_department_desc(g_sfca_m.sfaa017) RETURNING g_sfca_m.sfaa017_desc
      DISPLAY BY NAME g_sfca_m.sfaa017_desc
   END IF
   
   CALL s_aooi200_get_slip(g_sfca_m.sfcadocno) RETURNING l_success,l_slip
   CALL s_aooi200_get_slip_desc(l_slip)
     RETURNING g_sfca_m.oobal004
   DISPLAY BY NAME g_sfca_m.oobal004
   
   LET g_sfca_m_t.* = g_sfca_m.*      #保存單頭舊值

   IF g_bfill = "Y" THEN
      CALL asft301_b_fill() #單身填充
      CALL asft301_b_fill2('0') #單身填充
   END IF

   #帶出公用欄位reference值


   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:show段reference
   {<point name="show.head.reference"/>}
   #end add-point

   #將資料輸出到畫面上
   DISPLAY BY NAME g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfaa010,g_sfca_m.sfaa011,g_sfca_m.sfaa017,
       g_sfca_m.sfaa017_desc,g_sfca_m.oobal004,g_sfca_m.sfaa010_desc,g_sfca_m.sfaa019,g_sfca_m.sfaastus,
       g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfaa010_desc1,g_sfca_m.sfaa020,g_sfca_m.sfaa003,g_sfca_m.sfca003,
       g_sfca_m.sfaa013,g_sfca_m.sfaa005,g_sfca_m.sfaa016,g_sfca_m.sfaa016_desc,g_sfca_m.sfca004,g_sfca_m.sfaa006,
       g_sfca_m.sfaa007,g_sfca_m.sfaa008,g_sfca_m.sfcasite,g_sfca_m.sfaa009,g_sfca_m.sfaa009_desc

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_sfca_m.sfaastus
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")

         WHEN "E"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed_irregular.png")

         WHEN "F"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")

         WHEN "M"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/costing_closed.png")

         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")

         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")

         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")

         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")


		
      END CASE



   #讀入ref值(單身)
   FOR l_ac = 1 TO g_sfcb_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb009_desc

            CALL asft301_sfcb011_ref(g_sfcb_d[l_ac].sfcb011) RETURNING g_sfcb_d[l_ac].sfcb011_desc  #160811-00008 by whitney modify

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb013_desc
            
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb002) THEN
               CALL s_aooi360_sel('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,'','','','','','','4') RETURNING l_success,g_sfcb_d[l_ac].ooff013
            END IF
         {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_sfcb2_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
      {<point name="show.body2.reference"/>}
      #end add-point
   END FOR





   #add-point:show段other
   {<point name="show.other"/>}
   #end add-point

   LET l_ac = l_ac_t

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   CALL asft301_detail_show()

   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_detail_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10    #170104-00066#2 num5->num10  17/01/06 mod by rainy
   {</Local define>}
   #add-point:detail_show段define
   {<point name="detail_show.define"/>}
   #end add-point

   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #end add-point

   LET l_ac_t = l_ac

   LET l_ac = l_ac_t

   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE sfca_t.sfcadocno
   DEFINE l_oldno     LIKE sfca_t.sfcadocno
   DEFINE l_newno02     LIKE sfca_t.sfca001
   DEFINE l_oldno02     LIKE sfca_t.sfca001
   DEFINE l_master    RECORD LIKE sfca_t.*
   DEFINE l_detail    RECORD LIKE sfcb_t.*
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   #切換畫面

   IF g_sfca_m.sfcadocno IS NULL
   OR g_sfca_m.sfca001 IS NULL


   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_sfcadocno_t = g_sfca_m.sfcadocno
   LET g_sfca001_t = g_sfca_m.sfca001



   LET g_sfca_m.sfcadocno = ""
   LET g_sfca_m.sfca001 = ""



   CALL asft301_set_entry('a')
   CALL asft301_set_no_entry('a')

   CALL cl_set_head_visible("","YES")

   #公用欄位給予預設值


   #add-point:複製輸入前
   {<point name="reproduce.head.b_input"/>}
   #end add-point

   CALL asft301_input("r")



   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " sfcadocno = '", g_sfca_m.sfcadocno CLIPPED, "' "
              ," AND sfca001 = '", g_sfca_m.sfca001 CLIPPED, "' "


              , ") "

   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE sfcb_t.*
   {</Local define>}
   #add-point:delete段define
   {<point name="detail_reproduce.define"/>}
   #end add-point

   CALL s_transaction_begin()

   LET ld_date = cl_get_current()

   DROP TABLE asft301_detail

   #add-point:單身複製前1
   {<point name="detail_reproduce.body.table1.b_insert" mark="Y"/>}
   #end add-point

   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE asft301_detail AS ",
                "SELECT * FROM sfcb_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO asft301_detail SELECT * FROM sfcb_t
                                         WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfcadocno_t
                                         AND sfcb001 = g_sfca001_t



   #將key修正為調整後
   UPDATE asft301_detail
      #更新key欄位
      SET sfcbdocno = g_sfca_m.sfcadocno
          , sfcb001 = g_sfca_m.sfca001


      #更新共用欄位



   #將資料塞回原table
   INSERT INTO sfcb_t SELECT * FROM asft301_detail

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #add-point:單身複製中1
   {<point name="detail_reproduce.body.table1.m_insert"/>}
   #end add-point

   #刪除TEMP TABLE
   DROP TABLE asft301_detail

   #add-point:單身複製後1
   {<point name="detail_reproduce.body.table1.a_insert"/>}
   #end add-point





   #多語言複製段落
      #此段落由子樣板a38產生
   DROP TABLE asft301_detail_lang

   #add-point:單身複製前1
   {<point name="detail_reproduce.body.lang0.b_insert" mark="Y"/>}
   #end add-point

   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE asft301_detail_lang AS ",
                "SELECT * FROM ooff_t "
   PREPARE repro_ooff_t FROM ls_sql
   EXECUTE repro_ooff_t
   FREE repro_ooff_t

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO asft301_detail_lang SELECT * FROM ooff_t
                                             WHERE ooffent = g_enterprise AND ooff001 = g_sfcadocno_t
                                             AND ooff002 = g_sfca001_t


   #將key修正為調整後
   UPDATE asft301_detail_lang
      #更新key欄位
      SET ooff001 = g_sfca_m.sfcadocno
          , ooff002 = g_sfca_m.sfca001


   #將資料塞回原table
   INSERT INTO ooff_t SELECT * FROM asft301_detail_lang

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #add-point:單身複製中1
   {<point name="detail_reproduce.lang0.table1.m_insert"/>}
   #end add-point

   #刪除TEMP TABLE
   DROP TABLE asft301_detail_lang

   #add-point:單身複製後1
   {<point name="detail_reproduce.lang0.table1.a_insert"/>}
   #end add-point



   CALL s_transaction_end('Y','0')

   #已新增完, 調整資料內容(修改時使用)
   LET g_sfcadocno_t = g_sfca_m.sfcadocno
   LET g_sfca001_t = g_sfca_m.sfca001



   DROP TABLE asft301_detail

END FUNCTION

PRIVATE FUNCTION asft301_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   DEFINE l_success  LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   CALL g_sfcb_d.clear()    #g_sfcb_d 單頭及單身
   CALL g_sfcb2_d.clear()



   #add-point:b_fill段sql_before
   {<point name="b_fill.sql_before"/>}
   #end add-point

   #判斷是否填充
   IF asft301_fill_chk(1) THEN

      LET g_sql = "SELECT  UNIQUE sfcb002,sfcb003,'',sfcb004,sfcb005,sfcb006,sfcb007,'',sfcb008,sfcb009,",
          "'',sfcb010,sfcb011,'',sfcb023,sfcb024,sfcb025,sfcb026,sfcb044,sfcb045,sfcb012,sfcb013,'',sfcb014,",
          "sfcb015,sfcb016,sfcb017,sfcb018,sfcb019,sfcb052,'',sfcb053,sfcb054,sfcb020,'',sfcb021,sfcb022,sfcb055,",
          "'',sfcb002,",
          #add--160730-00001#1 By shiun--(S)
          "sfcb003,'',sfcb004,sfcb011,'',",
          #add--160730-00001#1 By shiun--(E)
          "sfcb027,sfcb050,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,",
          "sfcb037,sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051 FROM sfcb_t",

                  " INNER JOIN sfca_t ON sfcaent = sfcbent AND sfcadocno = sfcbdocno AND sfca001 = sfcb001 ",
                  " WHERE sfcbent=? AND sfcbdocno=? AND sfcb001=? AND sfcbsite='",g_site,"'"
      #add-point:b_fill段sql_before
      {<point name="b_fill.body.fill_sql"/>}
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF

      #子單身的WC


      LET g_sql = g_sql, " ORDER BY sfcb_t.sfcb002"

      #add-point:單身填充控制
      {<point name="b_fill.sql"/>}
      #end add-point

      PREPARE asft301_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR asft301_pb

      LET g_cnt = l_ac
      LET l_ac = 1

      OPEN b_fill_cs USING g_enterprise,g_sfca_m.sfcadocno
                                               ,g_sfca_m.sfca001



      FOREACH b_fill_cs INTO g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb003_desc,
          g_sfcb_d[l_ac].sfcb004,g_sfcb_d[l_ac].sfcb005,g_sfcb_d[l_ac].sfcb006,g_sfcb_d[l_ac].sfcb007,
          g_sfcb_d[l_ac].sfcb007_desc,g_sfcb_d[l_ac].sfcb008,g_sfcb_d[l_ac].sfcb009,g_sfcb_d[l_ac].sfcb009_desc,
          g_sfcb_d[l_ac].sfcb010,g_sfcb_d[l_ac].sfcb011,g_sfcb_d[l_ac].sfcb011_desc,g_sfcb_d[l_ac].sfcb023,
          g_sfcb_d[l_ac].sfcb024,g_sfcb_d[l_ac].sfcb025,g_sfcb_d[l_ac].sfcb026,g_sfcb_d[l_ac].sfcb044,
          g_sfcb_d[l_ac].sfcb045,g_sfcb_d[l_ac].sfcb012,g_sfcb_d[l_ac].sfcb013,g_sfcb_d[l_ac].sfcb013_desc,
          g_sfcb_d[l_ac].sfcb014,g_sfcb_d[l_ac].sfcb015,g_sfcb_d[l_ac].sfcb016,g_sfcb_d[l_ac].sfcb017,
          g_sfcb_d[l_ac].sfcb018,g_sfcb_d[l_ac].sfcb019,g_sfcb_d[l_ac].sfcb052,g_sfcb_d[l_ac].sfcb052_desc,g_sfcb_d[l_ac].sfcb053,
          g_sfcb_d[l_ac].sfcb054,g_sfcb_d[l_ac].sfcb020,g_sfcb_d[l_ac].sfcb020_desc,g_sfcb_d[l_ac].sfcb021,g_sfcb_d[l_ac].sfcb022,
          g_sfcb_d[l_ac].sfcb055,g_sfcb_d[l_ac].ooff013,g_sfcb2_d[l_ac].sfcb002,
          #add--160730-00001#1 By shiun--(S)
          g_sfcb2_d[l_ac].sfcb003,g_sfcb2_d[l_ac].sfcb003_desc,g_sfcb2_d[l_ac].sfcb004,
          g_sfcb2_d[l_ac].sfcb011,g_sfcb2_d[l_ac].sfcb011_desc,
          #add--160730-00001#1 By shiun--(E)
          g_sfcb2_d[l_ac].sfcb027,
          g_sfcb2_d[l_ac].sfcb050,g_sfcb2_d[l_ac].sfcb028,g_sfcb2_d[l_ac].sfcb029,g_sfcb2_d[l_ac].sfcb030,
          g_sfcb2_d[l_ac].sfcb031,g_sfcb2_d[l_ac].sfcb032,g_sfcb2_d[l_ac].sfcb033,g_sfcb2_d[l_ac].sfcb034,
          g_sfcb2_d[l_ac].sfcb035,g_sfcb2_d[l_ac].sfcb036,g_sfcb2_d[l_ac].sfcb037,g_sfcb2_d[l_ac].sfcb038,
          g_sfcb2_d[l_ac].sfcb039,g_sfcb2_d[l_ac].sfcb040,g_sfcb2_d[l_ac].sfcb041,g_sfcb2_d[l_ac].sfcb042,
          g_sfcb2_d[l_ac].sfcb043,g_sfcb2_d[l_ac].sfcb046,g_sfcb2_d[l_ac].sfcb047,g_sfcb2_d[l_ac].sfcb048,
          g_sfcb2_d[l_ac].sfcb049,g_sfcb2_d[l_ac].sfcb051
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
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb009_desc

            CALL asft301_sfcb011_ref(g_sfcb_d[l_ac].sfcb011) RETURNING g_sfcb_d[l_ac].sfcb011_desc  #160811-00008 by whitney modify

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb013_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb052
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb052_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb052_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb020
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb020_desc
            
            #add--160730-00001#1 By shiun--(S)
            LET g_ref_fields[1] = g_sfcb2_d[l_ac].sfcb003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb2_d[l_ac].sfcb003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb2_d[l_ac].sfcb003_desc
            
            CALL asft301_sfcb011_ref(g_sfcb2_d[l_ac].sfcb011) RETURNING g_sfcb2_d[l_ac].sfcb011_desc  #160811-00008 by whitney modify
            #add--160730-00001#1 By shiun--(E)

            IF NOT cl_null(g_sfcb_d[l_ac].sfcb002) THEN
               CALL s_aooi360_sel('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,'','','','','','','4') RETURNING l_success,g_sfcb_d[l_ac].ooff013
            END IF          {#ADP版次:1#}
         #end add-point

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

      END FOREACH
      LET g_error_show = 0

   END IF



   #add-point:browser_fill段其他table處理
   {<point name="browser_fill.other_fill"/>}
   #end add-point

   CALL g_sfcb_d.deleteElement(g_sfcb_d.getLength())
   CALL g_sfcb2_d.deleteElement(g_sfcb2_d.getLength())




   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE asft301_pb


END FUNCTION

PRIVATE FUNCTION asft301_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete" mark="Y"/>}
      #end add-point
      DELETE FROM sfcb_t
       WHERE sfcbent = g_enterprise AND
         sfcbdocno = ps_keys_bak[1] AND sfcb001 = ps_keys_bak[2] AND sfcb002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete"/>}
      #end add-point
   END IF





   #add-point:delete_b段other
   {<point name="delete_b.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      {<point name="insert_b.before_insert" mark="Y"/>}
      #end add-point
      INSERT INTO sfcb_t
                  (sfcbent,
                   sfcbdocno,sfcb001,
                   sfcb002,sfcbsite
                   ,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,sfcb008,sfcb009,sfcb010,sfcb011,sfcb023,sfcb024,sfcb025,sfcb026,sfcb044,sfcb045,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,sfcb018,sfcb019,sfcb052,sfcb053,sfcb054,sfcb020,sfcb021,sfcb022,sfcb055,sfcb027,sfcb050,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],g_site
                   ,g_sfcb_d[g_detail_idx].sfcb003,g_sfcb_d[g_detail_idx].sfcb004,g_sfcb_d[g_detail_idx].sfcb005,
                       g_sfcb_d[g_detail_idx].sfcb006,g_sfcb_d[g_detail_idx].sfcb007,g_sfcb_d[g_detail_idx].sfcb008,
                       g_sfcb_d[g_detail_idx].sfcb009,g_sfcb_d[g_detail_idx].sfcb010,g_sfcb_d[g_detail_idx].sfcb011,
                       g_sfcb_d[g_detail_idx].sfcb023,g_sfcb_d[g_detail_idx].sfcb024,g_sfcb_d[g_detail_idx].sfcb025,
                       g_sfcb_d[g_detail_idx].sfcb026,g_sfcb_d[g_detail_idx].sfcb044,g_sfcb_d[g_detail_idx].sfcb045,
                       g_sfcb_d[g_detail_idx].sfcb012,g_sfcb_d[g_detail_idx].sfcb013,g_sfcb_d[g_detail_idx].sfcb014,
                       g_sfcb_d[g_detail_idx].sfcb015,g_sfcb_d[g_detail_idx].sfcb016,g_sfcb_d[g_detail_idx].sfcb017,
                       g_sfcb_d[g_detail_idx].sfcb018,g_sfcb_d[g_detail_idx].sfcb019,g_sfcb_d[g_detail_idx].sfcb052,
                       g_sfcb_d[g_detail_idx].sfcb053,g_sfcb_d[g_detail_idx].sfcb054,g_sfcb_d[g_detail_idx].sfcb020,
                       g_sfcb_d[g_detail_idx].sfcb021,g_sfcb_d[g_detail_idx].sfcb022,g_sfcb_d[g_detail_idx].sfcb055,
                       g_sfcb2_d[g_detail_idx].sfcb027,g_sfcb2_d[g_detail_idx].sfcb050,g_sfcb2_d[g_detail_idx].sfcb028,
                       g_sfcb2_d[g_detail_idx].sfcb029,g_sfcb2_d[g_detail_idx].sfcb030,g_sfcb2_d[g_detail_idx].sfcb031,
                       g_sfcb2_d[g_detail_idx].sfcb032,g_sfcb2_d[g_detail_idx].sfcb033,g_sfcb2_d[g_detail_idx].sfcb034,
                       g_sfcb2_d[g_detail_idx].sfcb035,g_sfcb2_d[g_detail_idx].sfcb036,g_sfcb2_d[g_detail_idx].sfcb037,
                       g_sfcb2_d[g_detail_idx].sfcb038,g_sfcb2_d[g_detail_idx].sfcb039,g_sfcb2_d[g_detail_idx].sfcb040,
                       g_sfcb2_d[g_detail_idx].sfcb041,g_sfcb2_d[g_detail_idx].sfcb042,g_sfcb2_d[g_detail_idx].sfcb043,
                       g_sfcb2_d[g_detail_idx].sfcb046,g_sfcb2_d[g_detail_idx].sfcb047,g_sfcb2_d[g_detail_idx].sfcb048,
                       g_sfcb2_d[g_detail_idx].sfcb049,g_sfcb2_d[g_detail_idx].sfcb051)
      #add-point:insert_b段資料新增中
      {<point name="insert_b.m_insert"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "sfcb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      {<point name="insert_b.after_insert"/>}
      #end add-point
   END IF





   #add-point:insert_b段other
   {<point name="insert_b.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
   #end add-point

   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR

   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF

   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sfcb_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.before_update" mark="Y"/>}
      #end add-point
      UPDATE sfcb_t
         SET (sfcbdocno,sfcb001,
              sfcb002
              ,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,sfcb008,sfcb009,sfcb010,sfcb011,sfcb023,sfcb024,sfcb025,sfcb026,sfcb044,sfcb045,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,sfcb018,sfcb019,sfcb052,sfcb053,sfcb054,sfcb020,sfcb021,sfcb022,sfcb055,sfcb027,sfcb050,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_sfcb_d[g_detail_idx].sfcb003,g_sfcb_d[g_detail_idx].sfcb004,g_sfcb_d[g_detail_idx].sfcb005,
                  g_sfcb_d[g_detail_idx].sfcb006,g_sfcb_d[g_detail_idx].sfcb007,g_sfcb_d[g_detail_idx].sfcb008,
                  g_sfcb_d[g_detail_idx].sfcb009,g_sfcb_d[g_detail_idx].sfcb010,g_sfcb_d[g_detail_idx].sfcb011,
                  g_sfcb_d[g_detail_idx].sfcb023,g_sfcb_d[g_detail_idx].sfcb024,g_sfcb_d[g_detail_idx].sfcb025,
                  g_sfcb_d[g_detail_idx].sfcb026,g_sfcb_d[g_detail_idx].sfcb044,g_sfcb_d[g_detail_idx].sfcb045,
                  g_sfcb_d[g_detail_idx].sfcb012,g_sfcb_d[g_detail_idx].sfcb013,g_sfcb_d[g_detail_idx].sfcb014,
                  g_sfcb_d[g_detail_idx].sfcb015,g_sfcb_d[g_detail_idx].sfcb016,g_sfcb_d[g_detail_idx].sfcb017,
                  g_sfcb_d[g_detail_idx].sfcb018,g_sfcb_d[g_detail_idx].sfcb019,g_sfcb_d[g_detail_idx].sfcb052,
                  g_sfcb_d[g_detail_idx].sfcb053,g_sfcb_d[g_detail_idx].sfcb054,g_sfcb_d[g_detail_idx].sfcb020,
                  g_sfcb_d[g_detail_idx].sfcb021,g_sfcb_d[g_detail_idx].sfcb022,g_sfcb_d[g_detail_idx].sfcb055,
                  g_sfcb2_d[g_detail_idx].sfcb027,g_sfcb2_d[g_detail_idx].sfcb050,g_sfcb2_d[g_detail_idx].sfcb028,
                  g_sfcb2_d[g_detail_idx].sfcb029,g_sfcb2_d[g_detail_idx].sfcb030,g_sfcb2_d[g_detail_idx].sfcb031,
                  g_sfcb2_d[g_detail_idx].sfcb032,g_sfcb2_d[g_detail_idx].sfcb033,g_sfcb2_d[g_detail_idx].sfcb034,
                  g_sfcb2_d[g_detail_idx].sfcb035,g_sfcb2_d[g_detail_idx].sfcb036,g_sfcb2_d[g_detail_idx].sfcb037,
                  g_sfcb2_d[g_detail_idx].sfcb038,g_sfcb2_d[g_detail_idx].sfcb039,g_sfcb2_d[g_detail_idx].sfcb040,
                  g_sfcb2_d[g_detail_idx].sfcb041,g_sfcb2_d[g_detail_idx].sfcb042,g_sfcb2_d[g_detail_idx].sfcb043,
                  g_sfcb2_d[g_detail_idx].sfcb046,g_sfcb2_d[g_detail_idx].sfcb047,g_sfcb2_d[g_detail_idx].sfcb048,
                  g_sfcb2_d[g_detail_idx].sfcb049,g_sfcb2_d[g_detail_idx].sfcb051)
         WHERE sfcbent = g_enterprise AND sfcbdocno = ps_keys_bak[1] AND sfcb001 = ps_keys_bak[2] AND sfcb002 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "sfcb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "sfcb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.after_update"/>}
      #end add-point
   END IF







   #add-point:update_b段other
   {<point name="update_b.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("sfcadocno,sfca001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("sfcadocno,sfca001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point
   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   CALL cl_set_comp_entry("sfcb006,sfcb008",TRUE)

   #end add-poin
END FUNCTION

PRIVATE FUNCTION asft301_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   DEFINE l_n     LIKE type_t.num5
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point
   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b"/>}
   IF g_sfcb_d[l_ac].sfcb005 = '1' THEN
      LET g_sfcb_d[l_ac].sfcb006=''
      CALL cl_set_comp_entry("sfcb006",FALSE)
   END IF
   IF g_sfcb_d[l_ac].sfcb007 = 'INIT' OR g_sfcb_d[l_ac].sfcb007 = 'MULT' THEN
      LET g_sfcb_d[l_ac].sfcb008= 0
      CALL cl_set_comp_entry("sfcb008",FALSE)
   END IF
   
   SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
      AND sfcb001=g_sfca_m.sfca001 AND sfcb006=g_sfcb_d[l_ac].sfcb007
   IF l_n > 0 THEN
      LET g_sfcb_d[l_ac].sfcb008 = 0
      CALL cl_set_comp_entry("sfcb008",FALSE)
   END IF
   
   #end add-point
END FUNCTION

PRIVATE FUNCTION asft301_default_search()
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
      LET ls_wc = ls_wc, " sfcadocno = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " sfca001 = '", g_argv[02], "' AND "
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

PRIVATE FUNCTION asft301_statechange()
#   {<Local define>}
#   DEFINE lc_state LIKE type_t.chr5
#   {</Local define>}
#   #add-point:statechange段define
#   {<point name="statechange.define"/>}
#   #end add-point
#
#   #add-point:statechange段開始前
#   {<point name="statechange.before"/>}
#   #end add-point
#
#   ERROR ""     #清空畫面右下側ERROR區塊
#
#   IF g_sfca_m.sfcadocno IS NULL
#      #key2
#      OR g_sfca_m.sfca001 IS NULL
#
#   THEN
#      CALL cl_err("","std-00003",0)
#      RETURN
#   END IF
#
#   MENU "" ATTRIBUTES (STYLE="popup")
#      BEFORE MENU
#         CASE g_sfca_m.sfaastus
#            WHEN "C"
#               HIDE OPTION "closed"
#            WHEN "D"
#               HIDE OPTION "withdraw"
#
#            WHEN "E"
#               HIDE OPTION "closed_irregular"
#
#            WHEN "F"
#               HIDE OPTION "released"
#
#            WHEN "M"
#               HIDE OPTION "costing_closed"
#
#            WHEN "N"
#               HIDE OPTION "open"
#
#            WHEN "R"
#               HIDE OPTION "rejection"
#
#            WHEN "W"
#               HIDE OPTION "signing"
#
#            WHEN "X"
#               HIDE OPTION "invalid"
#
#            WHEN "Y"
#               HIDE OPTION "confirmed"
#
#
#			
#         END CASE
#
#      #add-point:menu前
#      {<point name="statechange.before_menu"/>}
#      #end add-point
#	
#      ON ACTION closed
#         LET lc_state = "C"
#         #add-point:action控制
#         {<point name="statechange.closed"/>}
#         #end add-point
#         EXIT MENU
#      #ON ACTION withdraw
#      #   LET lc_state = "D"
#      #   #add-point:action控制
#      #   {<point name="statechange.withdraw"/>}
#      #   #end add-point
#      #   EXIT MENU
#
#      ON ACTION closed_irregular
#         LET lc_state = "E"
#         #add-point:action控制
#         {<point name="statechange.closed_irregular"/>}
#         #end add-point
#         EXIT MENU
#
#      ON ACTION released
#         LET lc_state = "F"
#         #add-point:action控制
#         {<point name="statechange.released"/>}
#         #end add-point
#         EXIT MENU
#
#      ON ACTION costing_closed
#         LET lc_state = "M"
#         #add-point:action控制
#         {<point name="statechange.costing_closed"/>}
#         #end add-point
#         EXIT MENU
#
#      ON ACTION open
#         LET lc_state = "N"
#         #add-point:action控制
#         {<point name="statechange.open"/>}
#         #end add-point
#         EXIT MENU
#
#      ON ACTION rejection
#         LET lc_state = "R"
#         #add-point:action控制
#         {<point name="statechange.rejection"/>}
#         #end add-point
#         EXIT MENU
#
#      #ON ACTION signing
#      #   LET lc_state = "W"
#      #   #add-point:action控制
#      #   {<point name="statechange.signing"/>}
#      #   #end add-point
#      #   EXIT MENU
#
#      ON ACTION invalid
#         LET lc_state = "X"
#         #add-point:action控制
#         {<point name="statechange.invalid"/>}
#         #end add-point
#         EXIT MENU
#
#      ON ACTION confirmed
#         LET lc_state = "Y"
#         #add-point:action控制
#         {<point name="statechange.confirmed"/>}
#         #end add-point
#         EXIT MENU
#
#
#	
#	  #此段落由子樣板a36產生
#      #提交
#      ON ACTION signing
#         IF cl_auth_chk_act("signing") THEN
#            CALL asft301_send()
#         END IF
#         LET lc_state = 'W'
#         EXIT MENU
#
#      #抽單
#      ON ACTION withdraw
#         IF cl_auth_chk_act("withdraw") THEN
#            CALL asft301_draw_out()
#         END IF
#         LET lc_state = 'D'
#         EXIT MENU
#
#
#	
#      #add-point:stus控制
#      {<point name="statechange.more_control"/>}
#      #end add-point
#	
#   END MENU
#
#   IF (lc_state <> "C"
#      AND lc_state <> "D"
#
#      AND lc_state <> "E"
#
#      AND lc_state <> "F"
#
#      AND lc_state <> "M"
#
#      AND lc_state <> "N"
#
#      AND lc_state <> "R"
#
#      AND lc_state <> "W"
#
#      AND lc_state <> "X"
#
#      AND lc_state <> "Y"
#
#
#      ) OR
#      cl_null(lc_state) THEN
#      RETURN
#   END IF
#
#   #add-point:stus修改前
#   {<point name="statechange.b_update"/>}
#   #end add-point
#
#   UPDATE sfca_t SET sfcastus = lc_state
#    WHERE sfcaent = g_enterprise AND sfcadocno = g_sfca_m.sfcadocno
#      #key2
#      AND sfca001 = g_sfca_m.sfca001
#
#
#   IF SQLCA.sqlcode THEN
#      CALL cl_err("",SQLCA.sqlcode,0)
#   ELSE
#      CASE lc_state
#         WHEN "C"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
#         WHEN "D"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
#
#         WHEN "E"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed_irregular.png")
#
#         WHEN "F"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/released.png")
#
#         WHEN "M"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/costing_closed.png")
#
#         WHEN "N"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
#
#         WHEN "R"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
#
#         WHEN "W"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
#
#         WHEN "X"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
#
#         WHEN "Y"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
#
#
#		
#      END CASE
#      LET g_sfca_m.sfcastus = lc_state
#      DISPLAY BY NAME g_sfca_m.sfcastus
#   END IF
#
#   #add-point:stus修改後
#   {<point name="statechange.a_update"/>}
#   #end add-point
#
#   #add-point:statechange段結束前
#   {<point name="statechange.after"/>}
#   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_idx_chk()
   #add-point:idx_chk段define
   {<point name="idx_chk.define"/>}
   #end add-point

   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_sfcb_d.getLength() THEN
         LET g_detail_idx = g_sfcb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfcb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sfcb_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_sfcb2_d.getLength() THEN
         LET g_detail_idx = g_sfcb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfcb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sfcb2_d.getLength() TO FORMONLY.cnt
   END IF



   #add-point:idx_chk段other
   {<point name="idx_chk.other"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft301_b_fill2(pi_idx)
   {<Local define>}
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy
   DEFINE ls_chk          LIKE type_t.chr1
   {</Local define>}
   #add-point:b_fill2段define
   {<point name="b_fill2.define"/>}
   #end add-point

   LET li_ac = l_ac



   #add-point:單身填充後
   {<point name="b_fill2.after_fill" />}
   #end add-point

   LET l_ac = li_ac

   CALL asft301_detail_show()

END FUNCTION

PRIVATE FUNCTION asft301_fill_chk(ps_idx)
   {<Local define>}
   DEFINE ps_idx        LIKE type_t.chr10
   {</Local define>}
   #add-point:fill_chk段define
   {<point name="fill_chk.define"/>}
   #end add-point

   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段define
      {<point name="fill_chk.other_chk"/>}
      #end add-point
      RETURN TRUE
   END IF

   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   #根據wc判定是否需要填充


   RETURN FALSE

END FUNCTION

PRIVATE FUNCTION asft301_modify_detail_chk(ps_record)
   {<Local define>}
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   {</Local define>}
   #add-point:modify_detail_chk段define
   {<point name="modify_detail_chk.define"/>}
   #end add-point

   #add-point:modify_detail_chk段開始前
   {<point name="modify_detail_chk.before"/>}
   #end add-point

   CASE ps_record
      WHEN "s_detail1"
         LET ls_return = "sfcb002"
      WHEN "s_detail2"
         LET ls_return = "sfcb002_2"


      #add-point:modify_detail_chk段自訂page控制
      {<point name="modify_detail_chk.page_control"/>}
      #end add-point
   END CASE

   #add-point:modify_detail_chk段結束前
   {<point name="modify_detail_chk.after"/>}
   #end add-point

   RETURN ls_return

END FUNCTION

PRIVATE FUNCTION asft301_send()
   #add-point:send段define
   {<point name="send.define"/>}
   #end add-point

   IF g_sfca_m.sfcadocno IS NULL
   OR g_sfca_m.sfca001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   #重新取得與顯示完整單據資料(最新單據資料)
    SELECT UNIQUE sfcadocno,sfca002,sfca001,sfca005,sfca003,sfca004,sfcasite
 INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfca003,g_sfca_m.sfca004,
     g_sfca_m.sfcasite
 FROM sfca_t
 WHERE sfcaent = g_enterprise AND sfcadocno = g_sfca_m.sfcadocno AND sfca001 = g_sfca_m.sfca001

   ERROR ""

   CALL s_transaction_begin()

   OPEN asft301_cl USING g_enterprise,g_sfca_m.sfcadocno
                                                       ,g_sfca_m.sfca001

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN asft301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改的資料
   FETCH asft301_cl INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfaa010,g_sfca_m.sfaa011,g_sfca_m.sfaa017,
       g_sfca_m.sfaa017_desc,g_sfca_m.oobal004,g_sfca_m.sfaa010_desc,g_sfca_m.sfaa019,g_sfca_m.sfaastus,
       g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfaa010_desc1,g_sfca_m.sfaa020,g_sfca_m.sfaa003,g_sfca_m.sfca003,
       g_sfca_m.sfaa013,g_sfca_m.sfaa005,g_sfca_m.sfaa016,g_sfca_m.sfaa016_desc,g_sfca_m.sfca004,g_sfca_m.sfaa006,
       g_sfca_m.sfaa007,g_sfca_m.sfaa008,g_sfca_m.sfcasite,g_sfca_m.sfaa009,g_sfca_m.sfaa009_desc

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfca_m.sfcadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"


   CALL asft301_show()

   #add-point: 提交前的ADP
   {<point name="send.before_send" />}
   #end add-point

   #公用變數初始化
   CALL cl_bpm_data_init()

   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data()
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_sfca_m))

   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_sfcb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_sfcb2_d))


   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功

   #開單失敗
   IF NOT cl_bpm_cli() THEN
      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #add-point: 提交後的ADP
   {<point name="send.after_send" />}
   #end add-point

   #完成狀態更新
   CLOSE asft301_cl
   CALL s_transaction_end('Y','0')

   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL asft301_ui_browser_refresh()

   #重新指定此筆單據資料狀態圖片=>送簽中
  # LET g_browser[g_current_row].b_statepic = "stus/16/signing.png"

   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asft301_ui_headershow()
   CALL asft301_ui_detailshow()

END FUNCTION

PRIVATE FUNCTION asft301_draw_out()
   #add-point:draw段define
   {<point name="draw.define"/>}
   #end add-point

   #檢查資料是否存在
   IF g_sfca_m.sfcadocno IS NULL
   OR g_sfca_m.sfca001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   #LOCK主檔資料
   CALL s_transaction_begin()

   #進行BPM抽單功能
   OPEN asft301_cl USING g_enterprise,g_sfca_m.sfcadocno
                                                       ,g_sfca_m.sfca001

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN asft301_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改的資料
   FETCH asft301_cl INTO g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfaa010,g_sfca_m.sfaa011,g_sfca_m.sfaa017,
       g_sfca_m.sfaa017_desc,g_sfca_m.oobal004,g_sfca_m.sfaa010_desc,g_sfca_m.sfaa019,g_sfca_m.sfaastus,
       g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfaa010_desc1,g_sfca_m.sfaa020,g_sfca_m.sfaa003,g_sfca_m.sfca003,
       g_sfca_m.sfaa013,g_sfca_m.sfaa005,g_sfca_m.sfaa016,g_sfca_m.sfaa016_desc,g_sfca_m.sfca004,g_sfca_m.sfaa006,
       g_sfca_m.sfaa007,g_sfca_m.sfaa008,g_sfca_m.sfcasite,g_sfca_m.sfaa009,g_sfca_m.sfaa009_desc

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_sfca_m.sfcadocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN
      CLOSE asft301_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #完成狀態更新
   CLOSE asft301_cl
   CALL s_transaction_end('Y','0')

   #重新指定此筆單據資料狀態圖片=>抽單
 #  LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"

   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asft301_ui_headershow()
   CALL asft301_ui_detailshow()

END FUNCTION
#+ 資料新增
PRIVATE FUNCTION asft301_insert()
   #add-point:insert段define

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_sfcb_d.clear()   
   CALL g_sfcb2_d.clear()  
 
 
 
   INITIALIZE g_sfca_m.* LIKE sfca_t.*             #DEFAULT 設定
   
   LET g_sfcadocno_t = NULL
   LET g_sfca001_t = NULL
 
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_sfca_m.sfca005 = "1"
 
  
      #add-point:單頭預設值

      #end add-point 
     
      CALL asft301_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_sfca_m.* = g_sfca_m_t.*
         CALL asft301_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_sfcb_d.clear()
      CALL g_sfcb2_d.clear()
 
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_sfcadocno_t = g_sfca_m.sfcadocno
   LET g_sfca001_t = g_sfca_m.sfca001
 
 
   
   LET g_wc = g_wc,  
              " OR ( sfcaent = '" ||g_enterprise|| "' AND",
              " sfcadocno = '", g_sfca_m.sfcadocno CLIPPED, "' "
              ," AND sfca001 = '", g_sfca_m.sfca001 CLIPPED, "' "
 
 
              , ") "
   
   CLOSE asft301_cl
END FUNCTION
#资料输入
PRIVATE FUNCTION asft301_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10                #未取消的ARRAY CNT  #170104-00066#2 num5->num10  17/01/06 mod by rainy
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   DEFINE  l_sys                 LIKE type_t.num5 
   DEFINE  l_sql                 STRING
   DEFINE  l_j                   LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_sfaa016             LIKE sfaa_t.sfaa016   #161109-00045#1
   DEFINE  l_sfaa061             LIKE sfaa_t.sfaa061   #161109-00045#1
   {</Local define>}
   #add-point:input段define

   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = "SELECT sfcb002,sfcb003,'',sfcb004,sfcb005,sfcb006,sfcb007,'',sfcb008,sfcb009,", 
       "'',sfcb010,sfcb011,sfcb023,sfcb024,sfcb025,sfcb026,sfcb044,sfcb045,sfcb012,sfcb013,'',sfcb014,", 
       "sfcb015,sfcb016,sfcb017,sfcb018,sfcb019,sfcb052,sfcb053,sfcb054,sfcb020,sfcb021,sfcb022,sfcb055,", 
       #mod--160730-00001#1 By shiun--(S)
#       "'',sfcb027,sfcb050,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,", 
       "'','','','','',sfcb027,sfcb050,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,", 
       #mod--160730-00001#1 By shiun--(E)
       "sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051",  
       " FROM sfcb_t WHERE sfcbent=? AND sfcbdocno=? AND sfcb001=? AND sfcb002=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE asft301_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql

   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asft301_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL asft301_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_sfca_m.sfcadocno,g_sfca_m.sfca002,g_sfca_m.sfca001,g_sfca_m.sfca005,g_sfca_m.sfca003, 
       g_sfca_m.sfca004,g_sfca_m.sfcasite
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   IF g_sfca_m.sfaastus != 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00035'
      LET g_errparam.extend = g_sfca_m.sfcadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   CALL s_aooi200_get_slip(g_sfca_m.sfcadocno) RETURNING l_success,l_ooba002
   IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0023') = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00333'
      LET g_errparam.extend = g_sfca_m.sfcadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   #161109-00045#1-s-add
   SELECT sfaa016,sfaa061 INTO l_sfaa016,l_sfaa061
     FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno = g_sfca_m.sfcadocno
   
   IF cl_null(l_sfaa061) OR l_sfaa061 = 'N' OR (l_sfaa061 = 'Y' AND cl_null(l_sfaa016)) THEN
      LET l_allow_insert = FALSE
      LET l_allow_delete = FALSE
   END IF
   #161109-00045#1-e-add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      #Page1 預設值產生於此處
      INPUT ARRAY g_sfcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sfcb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asft301_b_fill()
            LET g_rec_b = g_sfcb_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN asft301_cl USING g_enterprise,g_sfca_m.sfcadocno
                                                                ,g_sfca_m.sfca001
 
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN asft301_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE asft301_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_sfcb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_sfcb_d[l_ac].sfcb002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sfcb_d_t.* = g_sfcb_d[l_ac].*  #BACKUP
               LET g_sfcb_d_o.* = g_sfcb_d[l_ac].*  #BACKUP   #160824-00007#215 by sakura add
               CALL asft301_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL asft301_set_no_entry_b(l_cmd)
               IF NOT asft301_lock_b("sfcb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asft301_bcl INTO g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb003_desc, 
                      g_sfcb_d[l_ac].sfcb004,g_sfcb_d[l_ac].sfcb005,g_sfcb_d[l_ac].sfcb006,g_sfcb_d[l_ac].sfcb007, 
                      g_sfcb_d[l_ac].sfcb007_desc,g_sfcb_d[l_ac].sfcb008,g_sfcb_d[l_ac].sfcb009,g_sfcb_d[l_ac].sfcb009_desc, 
                      g_sfcb_d[l_ac].sfcb010,g_sfcb_d[l_ac].sfcb011,g_sfcb_d[l_ac].sfcb023,g_sfcb_d[l_ac].sfcb024, 
                      g_sfcb_d[l_ac].sfcb025,g_sfcb_d[l_ac].sfcb026,g_sfcb_d[l_ac].sfcb044,g_sfcb_d[l_ac].sfcb045, 
                      g_sfcb_d[l_ac].sfcb012,g_sfcb_d[l_ac].sfcb013,g_sfcb_d[l_ac].sfcb013_desc,g_sfcb_d[l_ac].sfcb014, 
                      g_sfcb_d[l_ac].sfcb015,g_sfcb_d[l_ac].sfcb016,g_sfcb_d[l_ac].sfcb017,g_sfcb_d[l_ac].sfcb018, 
                      g_sfcb_d[l_ac].sfcb019,g_sfcb_d[l_ac].sfcb052,g_sfcb_d[l_ac].sfcb053,g_sfcb_d[l_ac].sfcb054, 
                      g_sfcb_d[l_ac].sfcb020,g_sfcb_d[l_ac].sfcb021,g_sfcb_d[l_ac].sfcb022,g_sfcb_d[l_ac].sfcb055, 
                      g_sfcb2_d[l_ac].sfcb002,
                      #add--160730-00001#1 By shiun--(S)
                      g_sfcb2_d[l_ac].sfcb003,g_sfcb2_d[l_ac].sfcb003_desc,g_sfcb2_d[l_ac].sfcb004,g_sfcb2_d[l_ac].sfcb011,                      
                      #add--160730-00001#1 By shiun--(E)
                      g_sfcb2_d[l_ac].sfcb027,g_sfcb2_d[l_ac].sfcb050,g_sfcb2_d[l_ac].sfcb028, 
                      g_sfcb2_d[l_ac].sfcb029,g_sfcb2_d[l_ac].sfcb030,g_sfcb2_d[l_ac].sfcb031,g_sfcb2_d[l_ac].sfcb032, 
                      g_sfcb2_d[l_ac].sfcb033,g_sfcb2_d[l_ac].sfcb034,g_sfcb2_d[l_ac].sfcb035,g_sfcb2_d[l_ac].sfcb036, 
                      g_sfcb2_d[l_ac].sfcb037,g_sfcb2_d[l_ac].sfcb038,g_sfcb2_d[l_ac].sfcb039,g_sfcb2_d[l_ac].sfcb040, 
                      g_sfcb2_d[l_ac].sfcb041,g_sfcb2_d[l_ac].sfcb042,g_sfcb2_d[l_ac].sfcb043,g_sfcb2_d[l_ac].sfcb046, 
                      g_sfcb2_d[l_ac].sfcb047,g_sfcb2_d[l_ac].sfcb048,g_sfcb2_d[l_ac].sfcb049,g_sfcb2_d[l_ac].sfcb051
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_sfcb_d_t.sfcb002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL asft301_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
               NEXT FIELD sfcb002
            END IF
            #add-point:modify段before row
          
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_sfcb_d[l_ac].* TO NULL 
                  LET g_sfcb_d[l_ac].sfcb005 = "1"
      LET g_sfcb_d[l_ac].sfcb023 = "0"
      LET g_sfcb_d[l_ac].sfcb024 = "0"
      LET g_sfcb_d[l_ac].sfcb025 = "0"
      LET g_sfcb_d[l_ac].sfcb026 = "0"
      LET g_sfcb_d[l_ac].sfcb012 = "N"
      LET g_sfcb_d[l_ac].sfcb014 = "N"
      LET g_sfcb_d[l_ac].sfcb015 = "N"
      LET g_sfcb_d[l_ac].sfcb016 = "Y"
      LET g_sfcb_d[l_ac].sfcb017 = "N"
      LET g_sfcb_d[l_ac].sfcb018 = "N"
      LET g_sfcb_d[l_ac].sfcb019 = "N"
      LET g_sfcb_d[l_ac].sfcb053 = "1"
      LET g_sfcb_d[l_ac].sfcb054 = "1"
      LET g_sfcb_d[l_ac].sfcb021 = "1"
      LET g_sfcb_d[l_ac].sfcb022 = "1"
      LET g_sfcb_d[l_ac].sfcb055 = "N"
      LET g_sfcb_d[l_ac].sfcb045 = g_sfca_m.sfaa020
      LET g_sfcb_d[l_ac].sfcb020 = g_sfca_m.sfaa013
      LET g_sfcb_d[l_ac].sfcb052 = g_sfca_m.sfaa013
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb052
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfcb_d[l_ac].sfcb052_desc = '', g_rtn_fields[1] , ''
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb020
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfcb_d[l_ac].sfcb020_desc = '', g_rtn_fields[1] , ''
      
      LET g_sfcb2_d[l_ac].sfcb028 = "0"
      LET g_sfcb2_d[l_ac].sfcb029 = "0"
      LET g_sfcb2_d[l_ac].sfcb030 = "0"
      LET g_sfcb2_d[l_ac].sfcb031 = "0"
      LET g_sfcb2_d[l_ac].sfcb032 = "0"
      LET g_sfcb2_d[l_ac].sfcb033 = "0"
      LET g_sfcb2_d[l_ac].sfcb034 = "0"
      LET g_sfcb2_d[l_ac].sfcb035 = "0"
      LET g_sfcb2_d[l_ac].sfcb036 = "0"
      LET g_sfcb2_d[l_ac].sfcb037 = "0"
      LET g_sfcb2_d[l_ac].sfcb038 = "0"
      LET g_sfcb2_d[l_ac].sfcb039 = "0"
      LET g_sfcb2_d[l_ac].sfcb040 = "0"
      LET g_sfcb2_d[l_ac].sfcb041 = "0"
      LET g_sfcb2_d[l_ac].sfcb042 = "0"
      LET g_sfcb2_d[l_ac].sfcb043 = "0"
      LET g_sfcb2_d[l_ac].sfcb046 = "0"
      LET g_sfcb2_d[l_ac].sfcb047 = "0"
      LET g_sfcb2_d[l_ac].sfcb048 = "0"
      LET g_sfcb2_d[l_ac].sfcb049 = "0"
      LET g_sfcb2_d[l_ac].sfcb051 = "0"
      LET g_sfcb2_d[l_ac].sfcb027 = g_sfca_m.sfca003 * g_sfcb_d[l_ac].sfcb021 / g_sfcb_d[l_ac].sfcb022 
      LET g_sfcb2_d[l_ac].sfcb050 = 0
      

            LET g_sfcb_d_t.* = g_sfcb_d[l_ac].*     #新輸入資料
            LET g_sfcb_d_o.* = g_sfcb_d[l_ac].*     #新輸入資料   #160824-00007#215 by sakura add
            CALL cl_show_fld_cont()
            CALL asft301_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL asft301_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sfcb_d[li_reproduce_target].* = g_sfcb_d[li_reproduce].*
               LET g_sfcb2_d[li_reproduce_target].* = g_sfcb2_d[li_reproduce].*
 
               LET g_sfcb_d[li_reproduce_target].sfcb002 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert

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
               
            #add-point:單身新增
            #所属同一个替代群组的本站作业，有其中一站5个步骤(move in,check in,报工站,check out,move out)有勾选的话，另外的站，必须至少也勾选一个
            IF g_sfcb_d[l_ac].sfcb005 = '2' AND NOT cl_null(g_sfcb_d[l_ac].sfcb006) THEN
               IF g_sfcb_d[l_ac].sfcb014 = 'N' AND g_sfcb_d[l_ac].sfcb015 = 'N' AND g_sfcb_d[l_ac].sfcb016 = 'N' AND g_sfcb_d[l_ac].sfcb018 = 'N' AND g_sfcb_d[l_ac].sfcb019 = 'N' THEN
                  SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                     AND sfcb001 = g_sfca_m.sfca001 AND sfcb005 = '2' AND sfcb006 = g_sfcb_d[l_ac].sfcb006 
                     AND sfcb014 ='Y' AND sfcb015 = 'Y' AND sfcb016 = 'Y' AND sfcb018 = 'Y' AND sfcb019 = 'Y'
                     AND sfcb002 != g_sfcb_d[l_ac].sfcb002
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD sfcb014
                  END IF
               END IF
               IF g_sfcb_d[l_ac].sfcb014 = 'Y' AND g_sfcb_d[l_ac].sfcb015 = 'Y' AND g_sfcb_d[l_ac].sfcb016 = 'Y' AND g_sfcb_d[l_ac].sfcb018 = 'Y' AND g_sfcb_d[l_ac].sfcb019 = 'Y' THEN
                  SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                     AND sfcb001 = g_sfca_m.sfca001 AND sfcb005 = '2' AND sfcb006 = g_sfcb_d[l_ac].sfcb006 
                     AND sfcb014 ='N' AND sfcb015 = 'N' AND sfcb016 = 'N' AND sfcb018 = 'N' AND sfcb019 = 'N'
                     AND sfcb002 != g_sfcb_d[l_ac].sfcb002
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD sfcb014
                  END IF
               END IF
            END IF
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM sfcb_t 
             WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno
               AND sfcb001 = g_sfca_m.sfca001
 
 
               AND sfcb002 = g_sfcb_d[l_ac].sfcb002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfca_m.sfcadocno
               LET gs_keys[2] = g_sfca_m.sfca001
               LET gs_keys[3] = g_sfcb_d[g_detail_idx].sfcb002
               CALL asft301_insert_b('sfcb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               IF g_sfcb_d[l_ac].sfcb055 = 'Y' THEN
                  UPDATE sfcb_t SET sfcb055 = 'N' WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                     AND sfcb001 = g_sfca_m.sfca001 AND sfcb002 != g_sfcb_d[l_ac].sfcb002
               END IF
               
               #新增制程上站作业资料
               IF g_sfcb_d[l_ac].sfcb007 <> 'MULT' THEN
                  DELETE FROM sfcc_t
                   WHERE sfccent = g_enterprise AND sfccsite = g_site AND sfccdocno=g_sfca_m.sfcadocno
                     AND sfcc001 = g_sfca_m.sfca001 AND sfcc002 = g_sfcb_d[l_ac].sfcb002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "del_sfcc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
                  INSERT INTO sfcc_t(sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004)                
                     VALUES(g_enterprise,g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins_sfcc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
               END IF 
               
               IF NOT cl_null(g_sfcb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,' ',' ',' ',' ',' ',' ','4',g_sfcb_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF
               
               #update 下站作业+制程序
               IF NOT asft301_upd_sfcb009() THEN
                  CALL s_transaction_end('N','0')
               END IF     

               #Check in/Check out项目资料
               IF NOT cl_null(g_sfca_m.sfaa016) AND NOT cl_null(g_sfca_m.sfaa010) THEN
                  LET l_sql = "INSERT INTO sfcd_t(sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,sfcd008,sfcd009) ",
                              " SELECT ecbfent,ecbfsite,'",g_sfca_m.sfcadocno,"',",g_sfca_m.sfca001,",ecbf003,ecbf005,ecbf006,ecbf007,ecbf008,ecbf009,ecbf010,ecbf004 FROM ecbf_t",
                              "  WHERE ecbfent='",g_enterprise,"' AND ecbfsite='",g_site,"' AND ecbf001='",g_sfca_m.sfaa010,"' AND ecbf002='",g_sfca_m.sfaa016,"' AND ecbf003=",g_sfcb_d[l_ac].sfcb002
                  PREPARE asft301_ins_sfcd_pre FROM l_sql
                  EXECUTE asft301_ins_sfcd_pre 
               END IF
                                    
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_sfcb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               CALL asft301_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_sfcb_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_sfcb_d.deleteElement(l_ac)
               NEXT FIELD sfcb002
            END IF
         
            IF g_sfcb_d[l_ac].sfcb002 IS NOT NULL
 
               THEN 
               
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
               
               #add-point:單身刪除前
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               #end add-point 
               
               DELETE FROM sfcb_t
                WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno AND
                                          sfcb001 = g_sfca_m.sfca001 AND
 
 
                      sfcb002 = g_sfcb_d_t.sfcb002
 
                  
               #add-point:單身刪除中
               
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  DELETE FROM sfcc_t
                   WHERE sfccent = g_enterprise AND sfccdocno = g_sfca_m.sfcadocno
                     AND sfcc001 = g_sfca_m.sfca001 AND sfcc002 = g_sfcb_d_t.sfcb002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "sfcc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
                  DELETE FROM sfcd_t
                   WHERE sfcdent = g_enterprise AND sfcddocno = g_sfca_m.sfcadocno
                     AND sfcd001 = g_sfca_m.sfca001 AND sfcd002 = g_sfcb_d_t.sfcb002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "sfcd_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
                  
                  CALL s_aooi360_del('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  #更新下站作业+作业序
                  IF NOT asft301_upd_sfcb009() THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE asft301_bcl
               LET l_count = g_sfcb_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfca_m.sfcadocno
               LET gs_keys[2] = g_sfca_m.sfca001
               LET gs_keys[3] = g_sfcb_d[g_detail_idx].sfcb002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2

            #end add-point
                           CALL asft301_delete_b('sfcb_t',gs_keys,"'1'")
                           CALL asft301_b_fill()
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sfcb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb002
            #add-point:BEFORE FIELD sfcb002
            IF cl_null(g_sfcb_d[l_ac].sfcb002) THEN 
               SELECT MAX(sfcb002) INTO g_sfcb_d[l_ac].sfcb002 FROM sfcb_t
                WHERE sfcbent = g_enterprise
                  AND sfcbsite = g_site
                  AND sfcbdocno = g_sfca_m.sfcadocno
                  AND sfcb001 = g_sfca_m.sfca001
               CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
               IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF    
               IF cl_null(g_sfcb_d[l_ac].sfcb002) THEN 
                  LET g_sfcb_d[l_ac].sfcb002 = l_sys 
                  LET g_sfcb_d[l_ac].sfcb007 = 'INIT'
                  LET g_sfcb_d[l_ac].sfcb008 = '0'                  
               ELSE
                  SELECT sfcb003,sfcb004 INTO g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008 FROM sfcb_t
                   WHERE sfcbent = g_enterprise
                     AND sfcbsite = g_site
                     AND sfcbdocno = g_sfca_m.sfcadocno
                     AND sfcb001 = g_sfca_m.sfca001 
                     AND sfcb002 = g_sfcb_d[l_ac].sfcb002  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = '221'
                  LET g_chkparam.arg2 = g_sfcb_d[l_ac].sfcb007
                  CALL cl_ref_val("v_oocql002")
                  LET g_sfcb_d[l_ac].sfcb007_desc = g_chkparam.return1
                  DISPLAY BY NAME g_sfcb_d[l_ac].sfcb007_desc                     
                  LET g_sfcb_d[l_ac].sfcb002 = g_sfcb_d[l_ac].sfcb002+l_sys
                  LET g_sfcb2_d[l_ac].sfcb002 = g_sfcb_d[l_ac].sfcb002
               END IF
               CALL asft301_def_sfcb044(g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008)                
             END IF 
             
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb002
            
            #add-point:AFTER FIELD sfcb002
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb002,"0","0","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb002 = g_sfcb_d_t.sfcb002
               NEXT FIELD sfcb002
            END IF

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_sfca_m.sfcadocno) AND NOT cl_null(g_sfca_m.sfca001) AND NOT cl_null(g_sfcb_d[l_ac].sfcb002) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfca_m.sfcadocno != g_sfcadocno_t OR g_sfca_m.sfca001 != g_sfca001_t OR g_sfcb_d[l_ac].sfcb002 != g_sfcb_d_t.sfcb002)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM sfcb_t WHERE "||"sfcbent = '" ||g_enterprise|| "' AND sfcbsite = '" ||g_site|| "' AND "||"sfcbdocno = '"||g_sfca_m.sfcadocno ||"' AND "|| "sfcb001 = '"||g_sfca_m.sfca001 ||"' AND "|| "sfcb002 = '"||g_sfcb_d[l_ac].sfcb002 ||"'",'std-00004',0) THEN
                     LET g_sfcb_d[l_ac].sfcb002 = g_sfcb_d_t.sfcb002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_sfcb2_d[l_ac].sfcb002 = g_sfcb_d[l_ac].sfcb002
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb002
            #add-point:ON CHANGE sfcb002

            #END add-point
 
         #----<<sfcb003>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb003
            
            #add-point:AFTER FIELD sfcb003
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb003) THEN
              #IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfcb_d[l_ac].sfcb003 <> g_sfcb_d_t.sfcb003) THEN   #160824-00007#215 by sakura mark
               IF g_sfcb_d[l_ac].sfcb003 <> g_sfcb_d_o.sfcb003 OR cl_null(g_sfcb_d_o.sfcb003) THEN      #160824-00007#215 by sakura add
                  IF NOT s_azzi650_chk_exist('221',g_sfcb_d[l_ac].sfcb003) THEN
                    #LET g_sfcb_d[l_ac].sfcb003 = g_sfcb_d_t.sfcb003   #160824-00007#215 by sakura mark
                     LET g_sfcb_d[l_ac].sfcb003 = g_sfcb_d_o.sfcb003   #160824-00007#215 by sakura add
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = '221'
                     LET g_chkparam.arg2 = g_sfcb_d[l_ac].sfcb003
                     CALL cl_ref_val("v_oocql002")
                     LET g_sfcb_d[l_ac].sfcb003_desc = g_chkparam.return1
                     #add--2016/08/03 By shiun--(S)
                     LET g_sfcb2_d[l_ac].sfcb003 = g_sfcb_d[l_ac].sfcb003
                     LET g_sfcb2_d[l_ac].sfcb003_desc = g_sfcb_d[l_ac].sfcb003_desc
                     DISPLAY BY NAME g_sfcb2_d[l_ac].sfcb003,g_sfcb2_d[l_ac].sfcb003_desc
                     #add--2016/08/03 By shiun--(E)
                     DISPLAY BY NAME g_sfcb_d[l_ac].sfcb003_desc                     
                     NEXT FIELD sfcb003
                  END IF
                  CALL asft301_def_sfcb004(g_sfcb_d[l_ac].sfcb003)
                  IF NOT asft301_sfcb003(g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004) THEN
                     NEXT FIELD sfcb003
                  END IF
               END IF
               
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '221'
               LET g_chkparam.arg2 = g_sfcb_d[l_ac].sfcb003
               CALL cl_ref_val("v_oocql002")
               LET g_sfcb_d[l_ac].sfcb003_desc = g_chkparam.return1
               DISPLAY BY NAME g_sfcb_d[l_ac].sfcb003_desc
            END IF
            LET g_sfcb_d_o.* = g_sfcb_d[l_ac].*   #160824-00007#215 by sakura add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb003
            #add-point:BEFORE FIELD sfcb003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb003
            #add-point:ON CHANGE sfcb003

            #END add-point
 
         #----<<sfcb004>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb004
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb004,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD sfcb004
            END IF
           
 
            #add-point:AFTER FIELD sfcb004
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb004) THEN
               IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfcb_d[l_ac].sfcb004 <> g_sfcb_d_t.sfcb004) THEN
                  IF NOT asft301_sfcb003(g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004) THEN
                     NEXT FIELD sfcb003
                  END IF
               END IF
            END IF
            #add--2016/08/03 By shiun--(S)
            LET g_sfcb2_d[l_ac].sfcb004 = g_sfcb_d[l_ac].sfcb004
            #add--2016/08/03 By shiun--(E)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb004
            #add-point:BEFORE FIELD sfcb004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb004
            #add-point:ON CHANGE sfcb004

            #END add-point
 
         #----<<sfcb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb005
            #add-point:BEFORE FIELD sfcb005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb005
            
            #add-point:AFTER FIELD sfcb005
            CALL asft301_set_entry_b(p_cmd)
            CALL asft301_set_no_entry_b(p_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb005
            #add-point:ON CHANGE sfcb005

            #END add-point
 
         #----<<sfcb006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb006
            #add-point:BEFORE FIELD sfcb006
            CALL asft301_set_entry_b(p_cmd)
            CALL asft301_set_no_entry_b(p_cmd)
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb006
            
            #add-point:AFTER FIELD sfcb006
            IF g_sfcb_d[l_ac].sfcb005 = '2' OR g_sfcb_d[l_ac].sfcb005 = '3' THEN
               IF cl_null(g_sfcb_d[l_ac].sfcb006) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00130'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD sfcb006
               END IF
            END IF 
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb006
            #add-point:ON CHANGE sfcb006

            #END add-point
 
         #----<<sfcb007>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb007
            
            #add-point:AFTER FIELD sfcb007
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb007) THEN
              #IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfcb_d[l_ac].sfcb007<>　g_sfcb_d_t.sfcb007) THEN   #160824-00007#215 by sakura mark
               IF g_sfcb_d[l_ac].sfcb007 != g_sfcb_d_o.sfcb007 OR cl_null(g_sfcb_d_o.sfcb007) THEN      #160824-00007#215 by sakura add
                  IF NOT asft301_sfcb007() THEN
                     LET g_sfcb_d[l_ac].sfcb007 = g_sfcb_d_o.sfcb007   #160824-00007#215 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL asft301_def_sfcb044(g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008)
               END IF
               IF g_sfcb_d[l_ac].sfcb007 = 'MULT' THEN
                  SELECT COUNT(1) INTO l_n FROM sfcc_t
                   WHERE sfccent=g_enterprise AND sfccsite=g_site AND sfccdocno=g_sfca_m.sfcadocno
                     AND sfcc001=g_sfca_m.sfca001 AND sfcc002=g_sfcb_d[l_ac].sfcb002
                  IF l_n <= 1 THEN
                     CALL asft301_01(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'Y')
                     SELECT COUNT(1) INTO l_n FROM sfcc_t WHERE sfccent=g_enterprise AND sfccsite=g_site AND sfccdocno=g_sfca_m.sfcadocno
                        AND sfcc001=g_sfca_m.sfca001 AND sfcc002=g_sfcb_d[l_ac].sfcb002
                     IF l_n = 0 THEN
                        LET g_sfcb_d[l_ac].sfcb007 = ''
                        LET g_sfcb_d[l_ac].sfcb008 = ''
                     END IF
                     IF l_n = 1 THEN
                        SELECT sfcc003,sfcc004 INTO g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008 FROM sfcc_t WHERE sfccent=g_enterprise AND sfccsite=g_site AND sfccdocno=g_sfca_m.sfcadocno
                           AND sfcc001=g_sfca_m.sfca001 AND sfcc002=g_sfcb_d[l_ac].sfcb002
                     END IF 
                     IF l_n > 1 THEN
                        LET g_sfcb_d[l_ac].sfcb007 = 'MULT'
                        LET g_sfcb_d[l_ac].sfcb008 = 0
                     END IF
                  END IF
               END IF
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '221'
               LET g_chkparam.arg2 = g_sfcb_d[l_ac].sfcb007
               CALL cl_ref_val("v_oocql002")
               LET g_sfcb_d[l_ac].sfcb007_desc = g_chkparam.return1
               DISPLAY BY NAME g_sfcb_d[l_ac].sfcb007_desc
            END IF
            LET g_sfcb_d_o.* = g_sfcb_d[l_ac].*   #160824-00007#215 by sakura add  
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb007
            #add-point:BEFORE FIELD sfcb007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb007
            #add-point:ON CHANGE sfcb007

            #END add-point
 
         #----<<sfcb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb008
            #add-point:BEFORE FIELD sfcb008
            CALL asft301_set_entry_b(p_cmd)
            CALL asft301_set_no_entry_b(p_cmd)
            IF cl_null(g_sfcb_d[l_ac].sfcb007) THEN
               NEXT FIELD sfcb007
            END IF 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb008
            
            #add-point:AFTER FIELD sfcb008
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb008) THEN
               #IF l_cmd = 'a' OR  (l_cmd = 'u' AND g_sfcb_d[l_ac].sfcb008 <> g_sfcb_d_t.sfcb008) THEN   #160824-00007#215 by sakura mark
               IF g_sfcb_d[l_ac].sfcb008 <> g_sfcb_d_o.sfcb008 OR cl_null(g_sfcb_d_o.sfcb008) THEN       #160824-00007#215 by sakura add
                  IF NOT asft301_sfcb007() THEN
                     LET g_sfcb_d[l_ac].sfcb008 = g_sfcb_d_o.sfcb008   #160824-00007#215 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL asft301_def_sfcb044(g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008)
               END IF
            END IF
            LET g_sfcb_d_o.* = g_sfcb_d[l_ac].*    #160824-00007#215 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb008
            #add-point:ON CHANGE sfcb008

            #END add-point
 
         #----<<sfcb009>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb009
            
            #add-point:AFTER FIELD sfcb009

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb009
            #add-point:BEFORE FIELD sfcb009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb009
            #add-point:ON CHANGE sfcb009

            #END add-point
 
         #----<<sfcb010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb010
            #add-point:BEFORE FIELD sfcb010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb010
            
            #add-point:AFTER FIELD sfcb010

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb010
            #add-point:ON CHANGE sfcb010

            #END add-point
 
         #----<<sfcb011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb011
            #add-point:BEFORE FIELD sfcb011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb011
            
            #add-point:AFTER FIELD sfcb011
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb011) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfcb_d[l_ac].sfcb011
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ecaa001_1") THEN
                  LET g_sfcb_d[l_ac].sfcb011 = g_sfcb_d_t.sfcb011
                  CALL asft301_sfcb011_ref(g_sfcb_d[l_ac].sfcb011) RETURNING g_sfcb_d[l_ac].sfcb011_desc  #160811-00008 by whitney modify
                  #add--2016/08/03 By shiun--(S)
                  LET g_sfcb2_d[l_ac].sfcb011 = g_sfcb_d[l_ac].sfcb011
                  LET g_sfcb2_d[l_ac].sfcb011_desc = g_sfcb_d[l_ac].sfcb011_desc
                  #add--2016/08/03 By shiun--(E)
                  NEXT FIELD sfcb011
               END IF
               CALL asft301_sfcb011_ref(g_sfcb_d[l_ac].sfcb011) RETURNING g_sfcb_d[l_ac].sfcb011_desc  #160811-00008 by whitney modify
           END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb011
            #add-point:ON CHANGE sfcb011

            #END add-point
 
         #----<<sfcb023>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb023
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb023,"0.000","1","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb023 = g_sfcb_d_t.sfcb023
               NEXT FIELD sfcb023
            END IF
 
 
            #add-point:AFTER FIELD sfcb023

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb023
            #add-point:BEFORE FIELD sfcb023

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb023
            #add-point:ON CHANGE sfcb023

            #END add-point
 
         #----<<sfcb024>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb024
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb024,"0.000","1","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb024 = g_sfcb_d_t.sfcb024
               NEXT FIELD sfcb024
            END IF
 
 
            #add-point:AFTER FIELD sfcb024

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb024
            #add-point:BEFORE FIELD sfcb024

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb024
            #add-point:ON CHANGE sfcb024

            #END add-point
 
         #----<<sfcb025>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb025
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb025,"0.000","1","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb025 = g_sfcb_d_t.sfcb025
               NEXT FIELD sfcb025
            END IF
 
 
            #add-point:AFTER FIELD sfcb025

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb025
            #add-point:BEFORE FIELD sfcb025

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb025
            #add-point:ON CHANGE sfcb025

            #END add-point
 
         #----<<sfcb026>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb026
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb026,"0.000","1","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb026 = g_sfcb_d_t.sfcb026
               NEXT FIELD sfcb026
            END IF
 
 
            #add-point:AFTER FIELD sfcb026

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb026
            #add-point:BEFORE FIELD sfcb026

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb026
            #add-point:ON CHANGE sfcb026

            #END add-point
 
         #----<<sfcb044>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb044
            #add-point:BEFORE FIELD sfcb044

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb044
            
            #add-point:AFTER FIELD sfcb044
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb044) AND NOT cl_null(g_sfcb_d[l_ac].sfcb045) THEN 
               IF g_sfcb_d[l_ac].sfcb044 > g_sfcb_d[l_ac].sfcb045 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00058'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfcb_d[l_ac].sfcb044 = g_sfcb_d_t.sfcb044
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb044
            #add-point:ON CHANGE sfcb044

            #END add-point
 
         #----<<sfcb045>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb045
            #add-point:BEFORE FIELD sfcb045

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb045
            
            #add-point:AFTER FIELD sfcb045
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb044) AND NOT cl_null(g_sfcb_d[l_ac].sfcb045) THEN 
               IF g_sfcb_d[l_ac].sfcb044 > g_sfcb_d[l_ac].sfcb045 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00058'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfcb_d[l_ac].sfcb045 = g_sfcb_d_t.sfcb045
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb045
            #add-point:ON CHANGE sfcb045

            #END add-point
 
         #----<<sfcb012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb012
            #add-point:BEFORE FIELD sfcb012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb012
            
            #add-point:AFTER FIELD sfcb012
            CALL cl_set_comp_entry('sfcb013',TRUE)
            IF g_sfcb_d[l_ac].sfcb012 = 'N' THEN
               CALL cl_set_comp_entry('sfcb013',FALSE)
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb012
            #add-point:ON CHANGE sfcb012

            #END add-point
 
         #----<<sfcb013>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb013
            
            #add-point:AFTER FIELD sfcb013
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb013) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfcb_d[l_ac].sfcb013
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_sfcb_d[l_ac].sfcb013 = g_sfcb_d_t.sfcb013
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb013
                  CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_sfcb_d[l_ac].sfcb013_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_sfcb_d[l_ac].sfcb013_desc
                  NEXT FIELD sfcb013
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb013
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_sfcb_d[l_ac].sfcb013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_sfcb_d[l_ac].sfcb013_desc          
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb013
            #add-point:BEFORE FIELD sfcb013
            CALL cl_set_comp_entry('sfcb013',TRUE)
            IF g_sfcb_d[l_ac].sfcb012 = 'N' THEN
               CALL cl_set_comp_entry('sfcb013',FALSE)
            END IF
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb013
            #add-point:ON CHANGE sfcb013

            #END add-point
 
         #----<<sfcb014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb014
            #add-point:BEFORE FIELD sfcb014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb014
            
            #add-point:AFTER FIELD sfcb014

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb014
            #add-point:ON CHANGE sfcb014

            #END add-point
 
         #----<<sfcb015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb015
            #add-point:BEFORE FIELD sfcb015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb015
            
            #add-point:AFTER FIELD sfcb015

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb015
            #add-point:ON CHANGE sfcb015

            #END add-point
 
         #----<<sfcb016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb016
            #add-point:BEFORE FIELD sfcb016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb016
            
            #add-point:AFTER FIELD sfcb016

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb016
            #add-point:ON CHANGE sfcb016

            #END add-point
 
         #----<<sfcb017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb017
            #add-point:BEFORE FIELD sfcb017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb017
            
            #add-point:AFTER FIELD sfcb017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb017
            #add-point:ON CHANGE sfcb017

            #END add-point
 
         #----<<sfcb018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb018
            #add-point:BEFORE FIELD sfcb018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb018
            
            #add-point:AFTER FIELD sfcb018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb018
            #add-point:ON CHANGE sfcb018

            #END add-point
 
         #----<<sfcb019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb019
            #add-point:BEFORE FIELD sfcb019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb019
            
            #add-point:AFTER FIELD sfcb019

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb019
            #add-point:ON CHANGE sfcb019

            #END add-point
 
         #----<<sfcb052>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb052
            #add-point:BEFORE FIELD sfcb052

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb052
            
            #add-point:AFTER FIELD sfcb052
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb052) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL             
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfcb_d[l_ac].sfcb052 
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_sfcb_d[l_ac].sfcb052 = g_sfcb_d_t.sfcb052
                  NEXT FIELD sfcb052
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb052
               CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_sfcb_d[l_ac].sfcb052_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_sfcb_d[l_ac].sfcb052_desc
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb052
            #add-point:ON CHANGE sfcb052

            #END add-point
 
         #----<<sfcb053>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb053
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb053,"0.000","0","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb053 = g_sfcb_d_t.sfcb053
               NEXT FIELD sfcb053
            END IF
 
 
            #add-point:AFTER FIELD sfcb053

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb053
            #add-point:BEFORE FIELD sfcb053

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb053
            #add-point:ON CHANGE sfcb053

            #END add-point
 
         #----<<sfcb054>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb054
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb054,"0.000","0","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb054 = g_sfcb_d_t.sfcb054
               NEXT FIELD sfcb054
            END IF
 
 
            #add-point:AFTER FIELD sfcb054

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb054
            #add-point:BEFORE FIELD sfcb054

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb054
            #add-point:ON CHANGE sfcb054

            #END add-point
 
         #----<<sfcb020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb020
            #add-point:BEFORE FIELD sfcb020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb020
            
            #add-point:AFTER FIELD sfcb020
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb020) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL             
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sfcb_d[l_ac].sfcb020 
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_sfcb_d[l_ac].sfcb020 = g_sfcb_d_t.sfcb020
                  NEXT FIELD sfcb020
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb020
               CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_sfcb_d[l_ac].sfcb020_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_sfcb_d[l_ac].sfcb020_desc
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb020
            #add-point:ON CHANGE sfcb020

            #END add-point
 
         #----<<sfcb021>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb021
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb021,"0.000","0","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb021 = g_sfcb_d_t.sfcb021
               NEXT FIELD sfcb021
            END IF
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb021) AND NOT cl_null(g_sfcb_d[l_ac].sfcb022)  THEN
               LET g_sfcb2_d[l_ac].sfcb027 = g_sfca_m.sfca003 * g_sfcb_d[l_ac].sfcb021 / g_sfcb_d[l_ac].sfcb022 
            END IF
 
 
            #add-point:AFTER FIELD sfcb021

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb021
            #add-point:BEFORE FIELD sfcb021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb021
            #add-point:ON CHANGE sfcb021

            #END add-point
 
         #----<<sfcb022>>----
         #此段落由子樣板a02產生
         AFTER FIELD sfcb022
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfcb_d[l_ac].sfcb022,"0.000","0","","","azz-00079",1) THEN
               LET g_sfcb_d[l_ac].sfcb022 = g_sfcb_d_t.sfcb022
               NEXT FIELD sfcb022
            END IF
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb021) AND NOT cl_null(g_sfcb_d[l_ac].sfcb022)  THEN
               LET g_sfcb2_d[l_ac].sfcb027 = g_sfca_m.sfca003 * g_sfcb_d[l_ac].sfcb021 / g_sfcb_d[l_ac].sfcb022 
            END IF
 
 
            #add-point:AFTER FIELD sfcb022

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb022
            #add-point:BEFORE FIELD sfcb022

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb022
            #add-point:ON CHANGE sfcb022

            #END add-point
 
         #----<<sfcb055>>----
         #此段落由子樣板a01產生
         BEFORE FIELD sfcb055
            #add-point:BEFORE FIELD sfcb055

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfcb055
            
            #add-point:AFTER FIELD sfcb055

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfcb055
            #add-point:ON CHANGE sfcb055
            IF g_sfcb_d[l_ac].sfcb055 = 'Y' THEN
               SELECT count(1) INTO l_n FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno 
                  AND sfcb001=g_sfca_m.sfca001 AND sfcb055='Y'
               IF l_n > 0 THEN
                  IF NOT cl_ask_confirm('asf-00134') THEN
                     LET g_sfcb_d[l_ac].sfcb055 = 'N'
                  ELSE
                     FOR l_j = 1 TO g_rec_b
                        IF g_sfcb_d[l_j].sfcb055 = 'Y' THEN
                           LET g_sfcb_d[l_j].sfcb055 = 'N'
                           DISPLAY BY NAME g_sfcb_d[l_j].sfcb055
                           EXIT FOR
                        END IF
                     END FOR
                  END IF
               END IF
            END IF
                  
               
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<sfcb002>>----
         #Ctrlp:input.c.page1.sfcb002
         ON ACTION controlp INFIELD sfcb002
            #add-point:ON ACTION controlp INFIELD sfcb002

            #END add-point
 
         #----<<sfcb003>>----
         #Ctrlp:input.c.page1.sfcb003
         ON ACTION controlp INFIELD sfcb003
            #add-point:ON ACTION controlp INFIELD sfcb003
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfcb_d[l_ac].sfcb003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_sfcb_d[l_ac].sfcb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sfcb_d[l_ac].sfcb003 TO sfcb003              #顯示到畫面上
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = '221'
            LET g_chkparam.arg2 = g_sfcb_d[l_ac].sfcb003
            CALL cl_ref_val("v_oocql002")
            LET g_sfcb_d[l_ac].sfcb003_desc = g_chkparam.return1
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb003_desc
            NEXT FIELD sfcb003 
            #END add-point
 
         #----<<sfcb004>>----
         #Ctrlp:input.c.page1.sfcb004
         ON ACTION controlp INFIELD sfcb004
            #add-point:ON ACTION controlp INFIELD sfcb004

            #END add-point
 
         #----<<sfcb005>>----
         #Ctrlp:input.c.page1.sfcb005
         ON ACTION controlp INFIELD sfcb005
            #add-point:ON ACTION controlp INFIELD sfcb005

            #END add-point
 
         #----<<sfcb006>>----
         #Ctrlp:input.c.page1.sfcb006
         ON ACTION controlp INFIELD sfcb006
            #add-point:ON ACTION controlp INFIELD sfcb006

            #END add-point
 
         #----<<sfcb007>>----
         #Ctrlp:input.c.page1.sfcb007
         ON ACTION controlp INFIELD sfcb007
            #add-point:ON ACTION controlp INFIELD sfcb007
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfcb_d[l_ac].sfcb007             #給予default值

            #給予arg
            LET g_qryparam.arg1=g_site
            LET g_qryparam.arg2=g_sfca_m.sfcadocno
            LET g_qryparam.arg3=g_sfca_m.sfca001
            CALL q_sfcb003()                                #呼叫開窗
            LET g_sfcb_d[l_ac].sfcb007  = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_sfcb_d[l_ac].sfcb008  = g_qryparam.return2
            DISPLAY g_sfcb_d[l_ac].sfcb007  TO sfcb007              #顯示到畫面上
            DISPLAY g_sfcb_d[l_ac].sfcb008  TO sfcb008  
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = '221'
            LET g_chkparam.arg2 = g_sfcb_d[l_ac].sfcb007
            CALL cl_ref_val("v_oocql002")
            LET g_sfcb_d[l_ac].sfcb007_desc = g_chkparam.return1
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb007_desc
            LET g_qryparam.where = ""
            NEXT FIELD sfcb007                         #返回原欄位
            #END add-point
 
         #----<<sfcb008>>----
         #Ctrlp:input.c.page1.sfcb008
         ON ACTION controlp INFIELD sfcb008
            #add-point:ON ACTION controlp INFIELD sfcb008

            #END add-point
 
         #----<<sfcb009>>----
         #Ctrlp:input.c.page1.sfcb009
         ON ACTION controlp INFIELD sfcb009
            #add-point:ON ACTION controlp INFIELD sfcb009

            #END add-point
 
         #----<<sfcb010>>----
         #Ctrlp:input.c.page1.sfcb010
         ON ACTION controlp INFIELD sfcb010
            #add-point:ON ACTION controlp INFIELD sfcb010

            #END add-point
 
         #----<<sfcb011>>----
         #Ctrlp:input.c.page1.sfcb011
         ON ACTION controlp INFIELD sfcb011
            #add-point:ON ACTION controlp INFIELD sfcb011
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfcb_d[l_ac].sfcb011             #給予default值

            #給予arg

            CALL q_ecaa001_1()                                #呼叫開窗

            LET g_sfcb_d[l_ac].sfcb011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sfcb_d[l_ac].sfcb011 TO sfcb011             #顯示到畫面上
            CALL asft301_sfcb011_ref(g_sfcb_d[l_ac].sfcb011) RETURNING g_sfcb_d[l_ac].sfcb011_desc  #160811-00008 by whitney modify
            NEXT FIELD sfcb011                         #返回原欄位
            #END add-point
 
         #----<<sfcb023>>----
         #Ctrlp:input.c.page1.sfcb023
         ON ACTION controlp INFIELD sfcb023
            #add-point:ON ACTION controlp INFIELD sfcb023
            
            #END add-point
 
         #----<<sfcb024>>----
         #Ctrlp:input.c.page1.sfcb024
         ON ACTION controlp INFIELD sfcb024
            #add-point:ON ACTION controlp INFIELD sfcb024
            
            #END add-point
 
         #----<<sfcb025>>----
         #Ctrlp:input.c.page1.sfcb025
         ON ACTION controlp INFIELD sfcb025
            #add-point:ON ACTION controlp INFIELD sfcb025
            
            #END add-point
 
         #----<<sfcb026>>----
         #Ctrlp:input.c.page1.sfcb026
         ON ACTION controlp INFIELD sfcb026
            #add-point:ON ACTION controlp INFIELD sfcb026
            
            #END add-point
 
         #----<<sfcb044>>----
         #Ctrlp:input.c.page1.sfcb044
         ON ACTION controlp INFIELD sfcb044
            #add-point:ON ACTION controlp INFIELD sfcb044

            #END add-point
 
         #----<<sfcb045>>----
         #Ctrlp:input.c.page1.sfcb045
         ON ACTION controlp INFIELD sfcb045
            #add-point:ON ACTION controlp INFIELD sfcb045

            #END add-point
 
         #----<<sfcb012>>----
         #Ctrlp:input.c.page1.sfcb012
         ON ACTION controlp INFIELD sfcb012
            #add-point:ON ACTION controlp INFIELD sfcb012

            #END add-point
 
         #----<<sfcb013>>----
         #Ctrlp:input.c.page1.sfcb013
         ON ACTION controlp INFIELD sfcb013
            #add-point:ON ACTION controlp INFIELD sfcb013
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfcb_d[l_ac].sfcb013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = " ('1','3')" #交易對象類型

            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_sfcb_d[l_ac].sfcb013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sfcb_d[l_ac].sfcb013 TO sfcb013             #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfcb_d[l_ac].sfcb013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfcb_d[l_ac].sfcb013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfcb_d[l_ac].sfcb013_desc
            NEXT FIELD sfcb013                          #返回原欄位
            #END add-point
 
         #----<<sfcb014>>----
         #Ctrlp:input.c.page1.sfcb014
         ON ACTION controlp INFIELD sfcb014
            #add-point:ON ACTION controlp INFIELD sfcb014

            #END add-point
 
         #----<<sfcb015>>----
         #Ctrlp:input.c.page1.sfcb015
         ON ACTION controlp INFIELD sfcb015
            #add-point:ON ACTION controlp INFIELD sfcb015

            #END add-point
 
         #----<<sfcb016>>----
         #Ctrlp:input.c.page1.sfcb016
         ON ACTION controlp INFIELD sfcb016
            #add-point:ON ACTION controlp INFIELD sfcb016

            #END add-point
 
         #----<<sfcb017>>----
         #Ctrlp:input.c.page1.sfcb017
         ON ACTION controlp INFIELD sfcb017
            #add-point:ON ACTION controlp INFIELD sfcb017

            #END add-point
 
         #----<<sfcb018>>----
         #Ctrlp:input.c.page1.sfcb018
         ON ACTION controlp INFIELD sfcb018
            #add-point:ON ACTION controlp INFIELD sfcb018

            #END add-point
 
         #----<<sfcb019>>----
         #Ctrlp:input.c.page1.sfcb019
         ON ACTION controlp INFIELD sfcb019
            #add-point:ON ACTION controlp INFIELD sfcb019

            #END add-point
 
         #----<<sfcb052>>----
         #Ctrlp:input.c.page1.sfcb052
         ON ACTION controlp INFIELD sfcb052
            #add-point:ON ACTION controlp INFIELD sfcb052
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfcb_d[l_ac].sfcb052            #給予default值
            #給予arg
            CALL q_ooca001()                                #呼叫開窗
            LET g_sfcb_d[l_ac].sfcb052 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_sfcb_d[l_ac].sfcb052 TO sfcb052             #顯示到畫面上
            NEXT FIELD sfcb052                          #返回原欄位
            #END add-point
 
         #----<<sfcb053>>----
         #Ctrlp:input.c.page1.sfcb053
         ON ACTION controlp INFIELD sfcb053
            #add-point:ON ACTION controlp INFIELD sfcb053

            #END add-point
 
         #----<<sfcb054>>----
         #Ctrlp:input.c.page1.sfcb054
         ON ACTION controlp INFIELD sfcb054
            #add-point:ON ACTION controlp INFIELD sfcb054

            #END add-point
 
         #----<<sfcb020>>----
         #Ctrlp:input.c.page1.sfcb020
         ON ACTION controlp INFIELD sfcb020
            #add-point:ON ACTION controlp INFIELD sfcb020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfcb_d[l_ac].sfcb020            #給予default值
            #給予arg
            CALL q_ooca001()                                #呼叫開窗
            LET g_sfcb_d[l_ac].sfcb020 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_sfcb_d[l_ac].sfcb020 TO sfcb020            #顯示到畫面上
            NEXT FIELD sfcb020                        #返回原欄位
            #END add-point
 
         #----<<sfcb021>>----
         #Ctrlp:input.c.page1.sfcb021
         ON ACTION controlp INFIELD sfcb021
            #add-point:ON ACTION controlp INFIELD sfcb021

            #END add-point
 
         #----<<sfcb022>>----
         #Ctrlp:input.c.page1.sfcb022
         ON ACTION controlp INFIELD sfcb022
            #add-point:ON ACTION controlp INFIELD sfcb022

            #END add-point
 
         #----<<sfcb055>>----
         #Ctrlp:input.c.page1.sfcb055
         ON ACTION controlp INFIELD sfcb055
            #add-point:ON ACTION controlp INFIELD sfcb055

            #END add-point
         ON ACTION controlp INFIELD ooff013
            IF NOT cl_null(g_sfcb_d[l_ac].sfcb002) THEN
               CALL aooi360_02('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,'','','','','','','4')
               CALL s_aooi360_sel('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,'','','','','','','4') RETURNING l_success,g_sfcb_d[l_ac].ooff013
            END IF
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_sfcb_d[l_ac].* = g_sfcb_d_t.*
               CLOSE asft301_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_sfcb_d[l_ac].sfcb002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_sfcb_d[l_ac].* = g_sfcb_d_t.*
            ELSE
            
               #add-point:單身修改前
               #所属同一个替代群组的本站作业，有其中一站5个步骤(move in,check in,报工站,check out,move out)有勾选的话，另外的站，必须至少也勾选一个
               IF g_sfcb_d[l_ac].sfcb005 = '2' AND NOT cl_null(g_sfcb_d[l_ac].sfcb006) THEN
                  IF g_sfcb_d[l_ac].sfcb014 = 'N' AND g_sfcb_d[l_ac].sfcb015 = 'N' AND g_sfcb_d[l_ac].sfcb016 = 'N' AND g_sfcb_d[l_ac].sfcb018 = 'N' AND g_sfcb_d[l_ac].sfcb019 = 'N' THEN
                     SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                        AND sfcb001 = g_sfca_m.sfca001 AND sfcb005 = '2' AND sfcb006 = g_sfcb_d[l_ac].sfcb006 
                        AND sfcb014 ='Y' AND sfcb015 = 'Y' AND sfcb016 = 'Y' AND sfcb018 = 'Y' AND sfcb019 = 'Y'
                        AND sfcb002 != g_sfcb_d[l_ac].sfcb002
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                        NEXT FIELD sfcb014
                     END IF
                  END IF
                  IF g_sfcb_d[l_ac].sfcb014 = 'Y' AND g_sfcb_d[l_ac].sfcb015 = 'Y' AND g_sfcb_d[l_ac].sfcb016 = 'Y' AND g_sfcb_d[l_ac].sfcb018 = 'Y' AND g_sfcb_d[l_ac].sfcb019 = 'Y' THEN
                     SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                        AND sfcb001 = g_sfca_m.sfca001 AND sfcb005 = '2' AND sfcb006 = g_sfcb_d[l_ac].sfcb006 
                        AND sfcb014 ='N' AND sfcb015 = 'N' AND sfcb016 = 'N' AND sfcb018 = 'N' AND sfcb019 = 'N'
                        AND sfcb002 != g_sfcb_d[l_ac].sfcb002
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                        NEXT FIELD sfcb014
                     END IF
                  END IF
               END IF
               
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE sfcb_t SET (sfcbdocno,sfcb001,sfcb002,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007, 
                   sfcb008,sfcb009,sfcb010,sfcb011,sfcb023,sfcb024,sfcb025,sfcb026,sfcb044,sfcb045,sfcb012, 
                   sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,sfcb018,sfcb019,sfcb052,sfcb053,sfcb054,sfcb020, 
                   sfcb021,sfcb022,sfcb055,sfcb027,sfcb050,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033, 
                   sfcb034,sfcb035,sfcb036,sfcb037,sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb046, 
                   sfcb047,sfcb048,sfcb049,sfcb051,sfcbsite) = (g_sfca_m.sfcadocno,g_sfca_m.sfca001, 
                   g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,g_sfcb_d[l_ac].sfcb005, 
                   g_sfcb_d[l_ac].sfcb006,g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008,g_sfcb_d[l_ac].sfcb009, 
                   g_sfcb_d[l_ac].sfcb010,g_sfcb_d[l_ac].sfcb011,g_sfcb_d[l_ac].sfcb023,g_sfcb_d[l_ac].sfcb024, 
                   g_sfcb_d[l_ac].sfcb025,g_sfcb_d[l_ac].sfcb026,g_sfcb_d[l_ac].sfcb044,g_sfcb_d[l_ac].sfcb045, 
                   g_sfcb_d[l_ac].sfcb012,g_sfcb_d[l_ac].sfcb013,g_sfcb_d[l_ac].sfcb014,g_sfcb_d[l_ac].sfcb015, 
                   g_sfcb_d[l_ac].sfcb016,g_sfcb_d[l_ac].sfcb017,g_sfcb_d[l_ac].sfcb018,g_sfcb_d[l_ac].sfcb019, 
                   g_sfcb_d[l_ac].sfcb052,g_sfcb_d[l_ac].sfcb053,g_sfcb_d[l_ac].sfcb054,g_sfcb_d[l_ac].sfcb020, 
                   g_sfcb_d[l_ac].sfcb021,g_sfcb_d[l_ac].sfcb022,g_sfcb_d[l_ac].sfcb055,g_sfcb2_d[l_ac].sfcb027, 
                   g_sfcb2_d[l_ac].sfcb050,g_sfcb2_d[l_ac].sfcb028,g_sfcb2_d[l_ac].sfcb029,g_sfcb2_d[l_ac].sfcb030, 
                   g_sfcb2_d[l_ac].sfcb031,g_sfcb2_d[l_ac].sfcb032,g_sfcb2_d[l_ac].sfcb033,g_sfcb2_d[l_ac].sfcb034, 
                   g_sfcb2_d[l_ac].sfcb035,g_sfcb2_d[l_ac].sfcb036,g_sfcb2_d[l_ac].sfcb037,g_sfcb2_d[l_ac].sfcb038, 
                   g_sfcb2_d[l_ac].sfcb039,g_sfcb2_d[l_ac].sfcb040,g_sfcb2_d[l_ac].sfcb041,g_sfcb2_d[l_ac].sfcb042, 
                   g_sfcb2_d[l_ac].sfcb043,g_sfcb2_d[l_ac].sfcb046,g_sfcb2_d[l_ac].sfcb047,g_sfcb2_d[l_ac].sfcb048, 
                   g_sfcb2_d[l_ac].sfcb049,g_sfcb2_d[l_ac].sfcb051,g_site)
                WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                  AND sfcb001 = g_sfca_m.sfca001 
 
 
                  AND sfcb002 = g_sfcb_d_t.sfcb002 #項次   
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "sfcb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_sfcb_d[l_ac].* = g_sfcb_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                     LET g_sfcb_d[l_ac].* = g_sfcb_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfca_m.sfcadocno
               LET gs_keys_bak[1] = g_sfcadocno_t
               LET gs_keys[2] = g_sfca_m.sfca001
               LET gs_keys_bak[2] = g_sfca001_t
               LET gs_keys[3] = g_sfcb_d[g_detail_idx].sfcb002
               LET gs_keys_bak[3] = g_sfcb_d_t.sfcb002
               CALL asft301_update_b('sfcb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               
               #161108-00023#2-s
               IF g_sfcb_d[l_ac].sfcb003 <> g_sfcb_d_t.sfcb003 OR
                  g_sfcb_d[l_ac].sfcb004 <> g_sfcb_d_t.sfcb004 THEN
                  UPDATE sfcb_t
                     SET sfcb007 = g_sfcb_d[l_ac].sfcb003,
                         sfcb008 = g_sfcb_d[l_ac].sfcb004
                   WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno AND sfcb001 = g_sfca_m.sfca001
                     AND sfcb007 = g_sfcb_d_t.sfcb003 AND sfcb008 = g_sfcb_d_t.sfcb004
                  UPDATE sfcb_t
                     SET sfcb009 = g_sfcb_d[l_ac].sfcb003,
                         sfcb010 = g_sfcb_d[l_ac].sfcb004
                   WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno AND sfcb001 = g_sfca_m.sfca001
                     AND sfcb009 = g_sfcb_d_t.sfcb003 AND sfcb010 = g_sfcb_d_t.sfcb004
                  UPDATE sfcc_t
                     SET sfcc003 = g_sfcb_d[l_ac].sfcb003,
                         sfcc004 = g_sfcb_d[l_ac].sfcb004
                   WHERE sfccent = g_enterprise AND sfccdocno = g_sfca_m.sfcadocno AND sfcc001 = g_sfca_m.sfca001
                     AND sfcc003 = g_sfcb_d_t.sfcb003 AND sfcc004 = g_sfcb_d_t.sfcb004
               END IF
               #161108-00023#2-e
               
               IF g_sfcb_d[l_ac].sfcb055 = 'Y' THEN
                  UPDATE sfcb_t SET sfcb055 = 'N' WHERE sfcbent = g_enterprise AND sfcbdocno = g_sfca_m.sfcadocno 
                     AND sfcb001 = g_sfca_m.sfca001 AND sfcb002 != g_sfcb_d[l_ac].sfcb002
               END IF
               
               IF g_sfcb_d[l_ac].sfcb007 <> 'MULT' AND (g_sfcb_d[l_ac].sfcb007!=g_sfcb_d_t.sfcb007 OR g_sfcb_d[l_ac].sfcb008!=g_sfcb_d_t.sfcb008) THEN
                  DELETE FROM sfcc_t WHERE sfccent = g_enterprise AND sfccsite = g_site AND sfccdocno=g_sfca_m.sfcadocno
                     AND sfcc001 = g_sfca_m.sfca001 AND sfcc002 = g_sfcb_d[l_ac].sfcb002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "del_sfcc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF   
                  INSERT INTO sfcc_t(sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004)
                     VALUES(g_enterprise,g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins_sfcc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
               END IF 
               
               IF NOT cl_null(g_sfcb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,' ',' ',' ',' ',' ',' ','4',g_sfcb_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF
               #update 下站作业+制程序
               IF NOT asft301_upd_sfcb009() THEN
                  CALL s_transaction_end('N','0')
               END IF 
               CALL asft301_b_fill()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

                         
            #end add-point
            CALL asft301_unlock_b("sfcb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
            
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_sfcb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_sfcb_d.getLength()+1
         
         ON ACTION gen_sfcc
            IF l_ac > 0 THEN
               CALL asft301_01(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'Y')
               SELECT COUNT(1) INTO l_n FROM sfcc_t WHERE sfccent=g_enterprise AND sfccsite=g_site AND sfccdocno=g_sfca_m.sfcadocno
                  AND sfcc001=g_sfca_m.sfca001 AND sfcc002=g_sfcb_d[l_ac].sfcb002
               IF l_n = 0 THEN
                  LET g_sfcb_d[l_ac].sfcb007 = ''
                  LET g_sfcb_d[l_ac].sfcb008 = ''
               END IF
               IF l_n = 1 THEN
                  SELECT sfcc003,sfcc004 INTO g_sfcb_d[l_ac].sfcb007,g_sfcb_d[l_ac].sfcb008 FROM sfcc_t WHERE sfccent=g_enterprise AND sfccsite=g_site AND sfccdocno=g_sfca_m.sfcadocno
                     AND sfcc001=g_sfca_m.sfca001 AND sfcc002=g_sfcb_d[l_ac].sfcb002
               END IF 
               IF l_n > 1 THEN
                  LET g_sfcb_d[l_ac].sfcb007 = 'MULT'
                  LET g_sfcb_d[l_ac].sfcb008 = 0
               END IF
               UPDATE sfcb_t SET sfcb007=g_sfcb_d[l_ac].sfcb007,sfcb008=g_sfcb_d[l_ac].sfcb008
                WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
                  AND sfcb001=g_sfca_m.sfca001 AND sfcb002=g_sfcb_d[l_ac].sfcb002
             # CALL asft301_b_fill()
            END IF
         
         ON ACTION gen_checkin
            IF l_ac > 0  THEN
               CALL asft301_02(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'1','Y')
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00139'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
         ON ACTION gen_checkout
            IF l_ac > 0 THEN
               CALL asft301_02(g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[l_ac].sfcb002,g_sfcb_d[l_ac].sfcb003,g_sfcb_d[l_ac].sfcb004,'2','Y')
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00139'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      #add-point:自定義input

      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         CALL cl_set_act_visible("gen_checkin,gen_checkout",FALSE) 
         IF NOT cl_null(g_sfca_m.sfaa016) AND NOT cl_null(g_sfca_m.sfaa010) THEN
            CALL cl_set_act_visible("gen_checkin,gen_checkout", TRUE)
         END IF 
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD sfcadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sfcb002
               WHEN "s_detail2"
                  NEXT FIELD sfcb002
            END CASE
         END IF
    
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
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
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

   #end add-point    
END FUNCTION

PRIVATE FUNCTION asft301_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point

   #先刷新資料
   #CALL asft301_b_fill()

   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "sfcb_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN asft301_bcl USING g_enterprise,g_sfca_m.sfcadocno,g_sfca_m.sfca001,g_sfcb_d[g_detail_idx].sfcb002


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "asft301_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF

   END IF





   #add-point:lock_b段other
   {<point name="lock_b.other"/>}
   #end add-point

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION asft301_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point

   LET ls_group = "'1','2',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asft301_bcl
   END IF





   #add-point:unlock_b段other
   {<point name="unlock_b.other"/>}
   #end add-point

END FUNCTION
#检查作业+制程序不可重复
PRIVATE FUNCTION asft301_sfcb003(p_sfcb003,p_sfcb004)
DEFINE p_sfcb003         LIKE sfcb_t.sfcb003
DEFINE p_sfcb004         LIKE sfcb_t.sfcb004
DEFINE l_n               LIKE type_t.num5

   IF cl_null(p_sfcb003) OR cl_null(p_sfcb004) THEN
      RETURN TRUE
   END IF 
   SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
      AND sfcb001=g_sfca_m.sfca001 AND sfcb003=p_sfcb003 AND sfcb004=p_sfcb004
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00129'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#预设制程序
PRIVATE FUNCTION asft301_def_sfcb004(p_sfcb003)
DEFINE p_sfcb003         LIKE sfcb_t.sfcb003
DEFINE l_sfcb004         LIKE type_t.num5

   IF cl_null(p_sfcb003) THEN
      RETURN
   END IF
   SELECT MAX(sfcb004) INTO l_sfcb004 FROM sfcb_t
    WHERE sfcbent = g_enterprise
      AND sfcbsite = g_site
      AND sfcbdocno = g_sfca_m.sfcadocno
      AND sfcb001 = g_sfca_m.sfca001
      AND sfcb003 = p_sfcb003
   LET l_sfcb004 = l_sfcb004 + 1
   LET g_sfcb_d[l_ac].sfcb004 = l_sfcb004
   IF cl_null(g_sfcb_d[l_ac].sfcb004) THEN
      LET g_sfcb_d[l_ac].sfcb004 = 1
   END IF
   DISPLAY BY NAME g_sfcb_d[l_ac].sfcb004
END FUNCTION
#上站作业+制程序 检查
PRIVATE FUNCTION asft301_sfcb007()
DEFINE l_n       LIKE type_t.num5
DEFINE l_sql     STRING
   CALL cl_set_comp_entry("sfcb008",TRUE)
   IF cl_null(g_sfcb_d[l_ac].sfcb007) THEN
      RETURN FALSE
   END IF
   IF g_sfcb_d[l_ac].sfcb007 = 'INIT' OR g_sfcb_d[l_ac].sfcb007 = 'MULT' THEN
      LET g_sfcb_d[l_ac].sfcb008 = 0
      CALL cl_set_comp_entry("sfcb008",FALSE)
      RETURN TRUE
   END IF 
   SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
      AND sfcb001=g_sfca_m.sfca001 AND sfcb006=g_sfcb_d[l_ac].sfcb007
   IF l_n > 0 THEN
      LET g_sfcb_d[l_ac].sfcb008 = 0
      CALL cl_set_comp_entry("sfcb008",FALSE)
      RETURN TRUE
   END IF
   #上站作业非“INIT”，“MULT","群组”，若作业序为0，则清空作业序
   IF g_sfcb_d[l_ac].sfcb008 = '0' THEN
      CALL cl_set_comp_entry("sfcb008",TRUE)
      LET g_sfcb_d[l_ac].sfcb008 = ''
   END IF 
   
   LET l_sql ="SELECT COUNT(1) FROM sfcb_t WHERE sfcbent='",g_enterprise,"' AND sfcbsite='",g_site,"' AND sfcbdocno='",g_sfca_m.sfcadocno,"'",
              "   AND sfcb001='",g_sfca_m.sfca001,"' AND sfcb003='",g_sfcb_d[l_ac].sfcb007,"'"
   IF NOT cl_null(g_sfcb_d[l_ac].sfcb008) THEN
      LET l_sql=l_sql," AND sfcb004='",g_sfcb_d[l_ac].sfcb008,"'"
   END IF
   PREPARE asft301_sfcb007_pre FROM l_sql
   EXECUTE asft301_sfcb007_pre INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00132'
      LET g_errparam.extend = g_sfcb_d[l_ac].sfcb007
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      IF NOT cl_null(g_sfcb_d[l_ac].sfcb003) AND NOT cl_null(g_sfcb_d[l_ac].sfcb004) AND NOT cl_null(g_sfcb_d[l_ac].sfcb008) THEN
         IF g_sfcb_d[l_ac].sfcb003 = g_sfcb_d[l_ac].sfcb007 AND g_sfcb_d[l_ac].sfcb004 = g_sfcb_d[l_ac].sfcb008 THEN
            INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00132'
      LET g_errparam.extend = g_sfcb_d[l_ac].sfcb007
      LET g_errparam.popup = TRUE
      CALL cl_err()

            RETURN FALSE        
         END IF
      END IF
      RETURN TRUE
   END IF
              
END FUNCTION
#预设预计开工日
PRIVATE FUNCTION asft301_def_sfcb044(p_sfcb007,p_sfcb008)
DEFINE p_sfcb007         LIKE sfcb_t.sfcb007
DEFINE p_sfcb008         LIKE sfcb_t.sfcb008
DEFINE l_n               LIKE type_t.num5

   IF cl_null(p_sfcb007) THEN
      RETURN
   END IF
   
   IF p_sfcb007 = 'INIT' THEN
      LET g_sfcb_d[l_ac].sfcb044 = g_sfca_m.sfaa019
   END IF
   
   IF p_sfcb007 = 'MULT' THEN      
      SELECT MAX(sfcb045) INTO g_sfcb_d[l_ac].sfcb044 FROM sfcb_t,sfcc_t WHERE sfcbent=sfccent AND sfcbsite=sfccsite AND sfcbdocno=sfccdocno
         AND sfcb001=sfcc001 AND sfcb002=sfcc002 AND sfcb003=sfcc003 AND sfcb004=sfcc004
         AND sfccent=g_enterprise AND sfccsite=g_site AND sfccdocno=g_sfca_m.sfcadocno
         AND sfcc001=g_sfca_m.sfca001 AND sfcc002=g_sfcb_d[l_ac].sfcb002
   END IF
   
   #群组
   SELECT COUNT(1) INTO l_n FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
      AND sfcb001=g_sfca_m.sfca001 AND sfcb006=g_sfcb_d[l_ac].sfcb007
   IF l_n > 0 THEN
      SELECT MAX(sfcb045) INTO g_sfcb_d[l_ac].sfcb044 FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site
         AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 AND sfcb006=g_sfcb_d[l_ac].sfcb007
   ELSE
      SELECT sfcb045 INTO g_sfcb_d[l_ac].sfcb044 FROM sfcb_t WHERE sfcbent=g_enterprise AND sfcbsite=g_site
         AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
         AND sfcb003=g_sfcb_d[l_ac].sfcb007 AND sfcb004=g_sfcb_d[l_ac].sfcb008
   END IF
   
END FUNCTION
#回写下站作业+制程序
PRIVATE FUNCTION asft301_upd_sfcb009()
DEFINE l_sql          STRING
#161109-00085#28-s
#DEFINE l_sfcc         RECORD LIKE sfcc_t.*
DEFINE l_sfcc RECORD  #工單製程上站作業資料
       sfccent LIKE sfcc_t.sfccent, #企業編號
       sfccsite LIKE sfcc_t.sfccsite, #營運據點
       sfccdocno LIKE sfcc_t.sfccdocno, #單號
       sfcc001 LIKE sfcc_t.sfcc001, #RUN CARD
       sfcc002 LIKE sfcc_t.sfcc002, #項次
       sfcc003 LIKE sfcc_t.sfcc003, #上站作業
       #sfcc004 LIKE sfcc_t.sfcc004  #上站作業序 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfcc004 LIKE sfcc_t.sfcc004, #上站作業序
       sfccud001 LIKE sfcc_t.sfccud001, #自定義欄位(文字)001
       sfccud002 LIKE sfcc_t.sfccud002, #自定義欄位(文字)002
       sfccud003 LIKE sfcc_t.sfccud003, #自定義欄位(文字)003
       sfccud004 LIKE sfcc_t.sfccud004, #自定義欄位(文字)004
       sfccud005 LIKE sfcc_t.sfccud005, #自定義欄位(文字)005
       sfccud006 LIKE sfcc_t.sfccud006, #自定義欄位(文字)006
       sfccud007 LIKE sfcc_t.sfccud007, #自定義欄位(文字)007
       sfccud008 LIKE sfcc_t.sfccud008, #自定義欄位(文字)008
       sfccud009 LIKE sfcc_t.sfccud009, #自定義欄位(文字)009
       sfccud010 LIKE sfcc_t.sfccud010, #自定義欄位(文字)010
       sfccud011 LIKE sfcc_t.sfccud011, #自定義欄位(數字)011
       sfccud012 LIKE sfcc_t.sfccud012, #自定義欄位(數字)012
       sfccud013 LIKE sfcc_t.sfccud013, #自定義欄位(數字)013
       sfccud014 LIKE sfcc_t.sfccud014, #自定義欄位(數字)014
       sfccud015 LIKE sfcc_t.sfccud015, #自定義欄位(數字)015
       sfccud016 LIKE sfcc_t.sfccud016, #自定義欄位(數字)016
       sfccud017 LIKE sfcc_t.sfccud017, #自定義欄位(數字)017
       sfccud018 LIKE sfcc_t.sfccud018, #自定義欄位(數字)018
       sfccud019 LIKE sfcc_t.sfccud019, #自定義欄位(數字)019
       sfccud020 LIKE sfcc_t.sfccud020, #自定義欄位(數字)020
       sfccud021 LIKE sfcc_t.sfccud021, #自定義欄位(日期時間)021
       sfccud022 LIKE sfcc_t.sfccud022, #自定義欄位(日期時間)022
       sfccud023 LIKE sfcc_t.sfccud023, #自定義欄位(日期時間)023
       sfccud024 LIKE sfcc_t.sfccud024, #自定義欄位(日期時間)024
       sfccud025 LIKE sfcc_t.sfccud025, #自定義欄位(日期時間)025
       sfccud026 LIKE sfcc_t.sfccud026, #自定義欄位(日期時間)026
       sfccud027 LIKE sfcc_t.sfccud027, #自定義欄位(日期時間)027
       sfccud028 LIKE sfcc_t.sfccud028, #自定義欄位(日期時間)028
       sfccud029 LIKE sfcc_t.sfccud029, #自定義欄位(日期時間)029
       sfccud030 LIKE sfcc_t.sfccud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e

DEFINE l_n            LIKE type_t.num5
DEFINE l_n1           LIKE type_t.num5
DEFINE l_n2           LIKE type_t.num5
DEFINE l_n3           LIKE type_t.num5
DEFINE l_n4           LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
#161109-00085#28-s
#DEFINE l_sfcb    RECORD LIKE sfcb_t.*
DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       #sfcb055 LIKE sfcb_t.sfcb055  #回收站 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfcb055 LIKE sfcb_t.sfcb055, #回收站
       sfcbud001 LIKE sfcb_t.sfcbud001, #自定義欄位(文字)001
       sfcbud002 LIKE sfcb_t.sfcbud002, #自定義欄位(文字)002
       sfcbud003 LIKE sfcb_t.sfcbud003, #自定義欄位(文字)003
       sfcbud004 LIKE sfcb_t.sfcbud004, #自定義欄位(文字)004
       sfcbud005 LIKE sfcb_t.sfcbud005, #自定義欄位(文字)005
       sfcbud006 LIKE sfcb_t.sfcbud006, #自定義欄位(文字)006
       sfcbud007 LIKE sfcb_t.sfcbud007, #自定義欄位(文字)007
       sfcbud008 LIKE sfcb_t.sfcbud008, #自定義欄位(文字)008
       sfcbud009 LIKE sfcb_t.sfcbud009, #自定義欄位(文字)009
       sfcbud010 LIKE sfcb_t.sfcbud010, #自定義欄位(文字)010
       sfcbud011 LIKE sfcb_t.sfcbud011, #自定義欄位(數字)011
       sfcbud012 LIKE sfcb_t.sfcbud012, #自定義欄位(數字)012
       sfcbud013 LIKE sfcb_t.sfcbud013, #自定義欄位(數字)013
       sfcbud014 LIKE sfcb_t.sfcbud014, #自定義欄位(數字)014
       sfcbud015 LIKE sfcb_t.sfcbud015, #自定義欄位(數字)015
       sfcbud016 LIKE sfcb_t.sfcbud016, #自定義欄位(數字)016
       sfcbud017 LIKE sfcb_t.sfcbud017, #自定義欄位(數字)017
       sfcbud018 LIKE sfcb_t.sfcbud018, #自定義欄位(數字)018
       sfcbud019 LIKE sfcb_t.sfcbud019, #自定義欄位(數字)019
       sfcbud020 LIKE sfcb_t.sfcbud020, #自定義欄位(數字)020
       sfcbud021 LIKE sfcb_t.sfcbud021, #自定義欄位(日期時間)021
       sfcbud022 LIKE sfcb_t.sfcbud022, #自定義欄位(日期時間)022
       sfcbud023 LIKE sfcb_t.sfcbud023, #自定義欄位(日期時間)023
       sfcbud024 LIKE sfcb_t.sfcbud024, #自定義欄位(日期時間)024
       sfcbud025 LIKE sfcb_t.sfcbud025, #自定義欄位(日期時間)025
       sfcbud026 LIKE sfcb_t.sfcbud026, #自定義欄位(日期時間)026
       sfcbud027 LIKE sfcb_t.sfcbud027, #自定義欄位(日期時間)027
       sfcbud028 LIKE sfcb_t.sfcbud028, #自定義欄位(日期時間)028
       sfcbud029 LIKE sfcb_t.sfcbud029, #自定義欄位(日期時間)029
       sfcbud030 LIKE sfcb_t.sfcbud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e

DEFINE l_n0           LIKE type_t.num5
DEFINE l_sfcb009      LIKE sfcb_t.sfcb009
DEFINE l_sfcb010      LIKE sfcb_t.sfcb010
   
   LET r_success = FALSE
   LET l_n = 0 
   #161109-00085#28-s
   #LET l_sql = "SELECT * FROM sfcb_t",
   #161109-00085#67 --s mark
   #LET l_sql = " SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,sfcb003,sfcb004,sfcb005,sfcb006,sfcb007, ",
   #            "       sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,sfcb017, ",
   #            "       sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,sfcb023,sfcb024,sfcb025,sfcb026,sfcb027, ",
   #            "       sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037, ",
   #            "       sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb044,sfcb045,sfcb046,sfcb047, ",
   #            "       sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,sfcb053,sfcb054,sfcb055 ",
   #161109-00085#67 --e mark
   #161109-00085#67 --s add
   LET l_sql = "SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002, ",
               "       sfcb003,sfcb004,sfcb005,sfcb006,sfcb007, ",
               "       sfcb008,sfcb009,sfcb010,sfcb011,sfcb012, ",
               "       sfcb013,sfcb014,sfcb015,sfcb016,sfcb017, ",
               "       sfcb018,sfcb019,sfcb020,sfcb021,sfcb022, ",
               "       sfcb023,sfcb024,sfcb025,sfcb026,sfcb027, ",
               "       sfcb028,sfcb029,sfcb030,sfcb031,sfcb032, ",
               "       sfcb033,sfcb034,sfcb035,sfcb036,sfcb037, ",
               "       sfcb038,sfcb039,sfcb040,sfcb041,sfcb042, ",
               "       sfcb043,sfcb044,sfcb045,sfcb046,sfcb047, ",
               "       sfcb048,sfcb049,sfcb050,sfcb051,sfcb052, ",
               "       sfcb053,sfcb054,sfcb055,sfcbud001,sfcbud002, ",
               "       sfcbud003,sfcbud004,sfcbud005,sfcbud006,sfcbud007, ",
               "       sfcbud008,sfcbud009,sfcbud010,sfcbud011,sfcbud012, ",
               "       sfcbud013,sfcbud014,sfcbud015,sfcbud016,sfcbud017, ",
               "       sfcbud018,sfcbud019,sfcbud020,sfcbud021,sfcbud022, ",
               "       sfcbud023,sfcbud024,sfcbud025,sfcbud026,sfcbud027, ",
               "       sfcbud028,sfcbud029,sfcbud030 ",
   #161109-00085#67 --e add
               "  FROM sfcb_t ",
               " WHERE sfcbent=",g_enterprise," AND sfcbsite='",g_site,"'",
               "   AND sfcbdocno='",g_sfca_m.sfcadocno,"' AND sfcb001='",g_sfca_m.sfca001,"'"
   PREPARE asft301_upd_sfcb009_pre0 FROM l_sql
   DECLARE asft301_upd_sfcb009_cs0 CURSOR FOR asft301_upd_sfcb009_pre0
   #FOREACH asft301_upd_sfcb009_cs0 INTO l_sfcb.*
   FOREACH asft301_upd_sfcb009_cs0 
      #161109-00085#67 --s mark
      #INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
      #     l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
      #     l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
      #     l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
      #     l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
      #     l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
      #     l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
      #     l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
      #     l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
      #     l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
      #     l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
      #     l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
      #161109-00085#67 --e mark
      #161109-00085#67 --s add
      INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
           l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
           l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
           l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
           l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
           l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
           l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
           l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
           l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
           l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
           l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
           l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055,l_sfcb.sfcbud001,l_sfcb.sfcbud002,
           l_sfcb.sfcbud003,l_sfcb.sfcbud004,l_sfcb.sfcbud005,l_sfcb.sfcbud006,l_sfcb.sfcbud007,
           l_sfcb.sfcbud008,l_sfcb.sfcbud009,l_sfcb.sfcbud010,l_sfcb.sfcbud011,l_sfcb.sfcbud012,
           l_sfcb.sfcbud013,l_sfcb.sfcbud014,l_sfcb.sfcbud015,l_sfcb.sfcbud016,l_sfcb.sfcbud017,
           l_sfcb.sfcbud018,l_sfcb.sfcbud019,l_sfcb.sfcbud020,l_sfcb.sfcbud021,l_sfcb.sfcbud022,
           l_sfcb.sfcbud023,l_sfcb.sfcbud024,l_sfcb.sfcbud025,l_sfcb.sfcbud026,l_sfcb.sfcbud027,
           l_sfcb.sfcbud028,l_sfcb.sfcbud029,l_sfcb.sfcbud030
      #161109-00085#67 --e add
   #161109-00085#28-e   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #当前作业、作业序，不存在其他站的 上站作业 中，
      #当前群組 也不存在其他站的 上站作业 中，
      #则更新本站对应下站为END,0
      SELECT COUNT(1) INTO l_n4 FROM sfcc_t 
       WHERE sfccent = g_enterprise AND sfccsite = g_site
         AND sfccdocno = g_sfca_m.sfcadocno AND sfcc001 = g_sfca_m.sfca001
         AND sfcc003 = l_sfcb.sfcb003 AND sfcc004 = l_sfcb.sfcb004
      IF NOT cl_null(l_sfcb.sfcb006) AND l_n4 = 0 THEN 
         SELECT COUNT(1) INTO l_n4 FROM sfcc_t 
          WHERE sfccent = g_enterprise AND sfccsite = g_site
            AND sfccdocno = g_sfca_m.sfcadocno AND sfcc001 = g_sfca_m.sfca001
            AND sfcc003 = l_sfcb.sfcb006 AND sfcc004 = 0
      END IF
      IF l_n4 = 0 THEN
         #161231-00002#1
         UPDATE sfcb_t SET sfcb009 = 'END',sfcb010 = 0
         #WHERE sfcbent = g_enterprise AND sfobsite = g_site  #161231-00002#1 mark
          WHERE sfcbent = g_enterprise AND sfcbsite = g_site  #161231-00002#1 add
            AND sfcbdocno = g_sfca_m.sfcadocno AND sfcb001 = g_sfca_m.sfca001
            AND sfcb002 = l_sfcb.sfcb002
      END IF
      #161109-00085#28-s
      #LET l_sql = "SELECT * FROM sfcc_t",
      #LET l_sql = "SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004 FROM sfcc_t", #161109-00085#67 mark
      #161109-00085#67 --s add
      LET l_sql = "SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002, ",
                  "       sfcc003,sfcc004,sfccud001,sfccud002,sfccud003, ",
                  "       sfccud004,sfccud005,sfccud006,sfccud007,sfccud008, ",
                  "       sfccud009,sfccud010,sfccud011,sfccud012,sfccud013, ",
                  "       sfccud014,sfccud015,sfccud016,sfccud017,sfccud018, ",
                  "       sfccud019,sfccud020,sfccud021,sfccud022,sfccud023, ",
                  "       sfccud024,sfccud025,sfccud026,sfccud027,sfccud028, ",
                  "       sfccud029,sfccud030 ",
      #161109-00085#67 --e add
      #161109-00085#28-e
                  "  FROM sfcc_t ",  #161231-00002#1 add
                  " WHERE sfccent='",g_enterprise,"' AND sfccsite='",g_site,"'",
                  "   AND sfccdocno='",g_sfca_m.sfcadocno,"' AND sfcc001='",g_sfca_m.sfca001,"'",                  
                  "   AND sfcc002=",l_sfcb.sfcb002                  
      PREPARE asft301_upd_sfcb009_pre FROM l_sql
      DECLARE asft301_upd_sfcb009_cs CURSOR FOR asft301_upd_sfcb009_pre
      #161109-00085#28-s   
      #FOREACH asft301_upd_sfcb009_cs INTO l_sfcc.*
      FOREACH asft301_upd_sfcb009_cs 
      #161109-00085#67 --s add
      #   INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
      #        l_sfcc.sfcc003,l_sfcc.sfcc004
      #161109-00085#67 --e add
      #161109-00085#67 --s add
          INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
               l_sfcc.sfcc003,l_sfcc.sfcc004,l_sfcc.sfccud001,l_sfcc.sfccud002,l_sfcc.sfccud003,
               l_sfcc.sfccud004,l_sfcc.sfccud005,l_sfcc.sfccud006,l_sfcc.sfccud007,l_sfcc.sfccud008,
               l_sfcc.sfccud009,l_sfcc.sfccud010,l_sfcc.sfccud011,l_sfcc.sfccud012,l_sfcc.sfccud013,
               l_sfcc.sfccud014,l_sfcc.sfccud015,l_sfcc.sfccud016,l_sfcc.sfccud017,l_sfcc.sfccud018,
               l_sfcc.sfccud019,l_sfcc.sfccud020,l_sfcc.sfccud021,l_sfcc.sfccud022,l_sfcc.sfccud023,
               l_sfcc.sfccud024,l_sfcc.sfccud025,l_sfcc.sfccud026,l_sfcc.sfccud027,l_sfcc.sfccud028,
               l_sfcc.sfccud029,l_sfcc.sfccud030
      #161109-00085#67 --e add
      #161109-00085#28-e 
         #計算一下抓到的上站作業+作業序  是其他幾筆資料的 上站作業+作業序
         SELECT COUNT(1) INTO l_n FROM sfcc_t
          WHERE sfccent=g_enterprise AND sfccsite=g_site
            AND sfccdocno=g_sfca_m.sfcadocno AND sfcc001=g_sfca_m.sfca001 
            AND sfcc003=l_sfcc.sfcc003 AND sfcc004=l_sfcc.sfcc004
        #IF l_n = 1 THEN  #160113-00001#1 mark
        #160113-00001#1 mod str
         CASE
            WHEN l_n = 1  #抓到一筆作業+作業序的上站資料
        #160113-00001#1 mod end
            IF NOT cl_null(l_sfcb.sfcb006) THEN   #有維護群組
               #更新上站作業+上站作業序且無維護群組或群組不一樣的資料
               #對應下站程序+下站制程序為本資料的群組+本站 
               UPDATE sfcb_t SET sfcb009=l_sfcb.sfcb006,sfcb010=0
                WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                  AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
                  AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
                  AND (sfcb006 IS NULL OR sfcb006!=l_sfcb.sfcb006)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "sfcb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN r_success
               END IF
               #更新上站作業+上站制程序且有維護群組(相同群組)的資料
               #對應下站程序+下站制程序為本資料的本站程序+本站制程序
               UPDATE sfcb_t SET sfcb009=l_sfcb.sfcb003,sfcb010=l_sfcb.sfcb004
                WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                  AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
                  AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
                  AND sfcb006=l_sfcb.sfcb006
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "sfcb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN r_success
               END IF
            ELSE    #無維護群組
               #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
               UPDATE sfcb_t SET sfcb009=l_sfcb.sfcb003,sfcb010=l_sfcb.sfcb004
                WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                  AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
                  AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "sfcb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  RETURN r_success
               END IF
            END IF
        #160113-00001#1 add str
           WHEN l_n > 1  #抓到多筆作業+作業序的上站資料
              IF NOT cl_null(l_sfcb.sfcb006) THEN
                 UPDATE sfcb_t SET sfcb009=l_sfcb.sfcb006,sfcb010=0
                  WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                    AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
                    AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
              ELSE
                 UPDATE sfcb_t SET sfcb009='MULT',sfcb010=0
                  WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                    AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
                    AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
              END IF
           WHEN l_n = 0  #都不是別人的上站
              UPDATE sfcb_t SET sfcb009 = 'END',sfcb010 = 0
               WHERE sfcbent = g_enterprise AND sfcbsite = g_site
                 AND sfcbdocno = g_sfca_m.sfcadocno AND sfcb001 = g_sfca_m.sfca001
                 AND sfcb002 = l_sfcb.sfcb002
         END CASE
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE sfcb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
        #160113-00001#1 add end         
        #160113-00001#1 mark str
        #ELSE
        #   SELECT COUNT(DISTINCT sfcc003) INTO l_n2 FROM sfcc_t
        #    WHERE sfccent=g_enterprise AND sfccsite=g_site
        #      AND sfccdocno=g_sfca_m.sfcadocno AND sfcc001=g_sfca_m.sfca001 
        #      AND sfcc003=l_sfcc.sfcc003 AND sfcc004=l_sfcc.sfcc004
        #   SELECT COUNT(DISTINCT sfcc004) INTO l_n3 FROM sfcc_t
        #    WHERE sfccent=g_enterprise AND sfccsite=g_site
        #      AND sfccdocno=g_sfca_m.sfcadocno AND sfcc001=g_sfca_m.sfca001 
        #      AND sfcc003=l_sfcc.sfcc003 AND sfcc004=l_sfcc.sfcc004
        #   IF l_n2 = 1 AND l_n3 = 1 THEN         
        #      UPDATE sfcb_t SET sfcb009='MULT',sfcb010=0
        #       WHERE sfcbent=g_enterprise AND sfcbsite=g_site
        #         AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
        #         AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
        #   ELSE
        #      UPDATE sfcb_t SET sfcb009=l_sfcb.sfcb006,sfcb010=0
        #       WHERE sfcbent=g_enterprise AND sfcbsite=g_site
        #         AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
        #         AND sfcb003=l_sfcc.sfcc003 AND sfcb004=l_sfcc.sfcc004
        #   END IF
        #   IF SQLCA.sqlcode THEN
        #      INITIALIZE g_errparam TO NULL
        #      LET g_errparam.code = SQLCA.sqlcode
        #      LET g_errparam.extend = "sfcb_t"
        #      LET g_errparam.popup = TRUE
        #      CALL cl_err()
        #      RETURN r_success
        #   END IF
        #END IF
        #160113-00001#1 mark end
            
         SELECT COUNT(1) INTO l_n1 FROM sfcb_t
          WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
            AND sfcb001=g_sfca_m.sfca001 AND sfcb006=l_sfcc.sfcc003
            AND (sfcb003 NOT IN (SELECT sfcb007 FROM sfcb_t
                                  WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                                    AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
                                    AND sfcb006=l_sfcc.sfcc003) OR
                 sfcb004 NOT IN (SELECT sfcb008 FROM sfcb_t
                                  WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                                    AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
                                    AND sfcb006=l_sfcc.sfcc003))
         IF l_n1 > 0 THEN
            UPDATE sfcb_t SET sfcb009=l_sfcb.sfcb003,sfcb010=l_sfcb.sfcb004
             WHERE sfcbent=g_enterprise AND sfcbsite=g_site AND sfcbdocno=g_sfca_m.sfcadocno
               AND sfcb001=g_sfca_m.sfca001 AND sfcb006=l_sfcc.sfcc003
               AND (sfcb003 NOT IN (SELECT sfcb007 FROM sfcb_t
                                     WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                                       AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
                                       AND sfcb006=l_sfcc.sfcc003) OR
                    sfcb004 NOT IN (SELECT sfcb008 FROM sfcb_t 
                                     WHERE sfcbent=g_enterprise AND sfcbsite=g_site
                                       AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
                                       AND sfcb006=l_sfcc.sfcc003))
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfcb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()          
               RETURN r_success
            END IF
         END IF
      END FOREACH
      
     #160113-00001#1 mark str
      ##若当站对应下站不存在或者为空，则更新下站作业+下站作业序END+0
      #SELECT sfcb009,sfcb010 INTO l_sfcb009,l_sfcb010 FROM sfcb_t
      # WHERE sfcbent=g_enterprise AND sfcbsite=g_site
      #   AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001
      #   AND sfcb002=l_sfcb.sfcb002
      #IF NOT cl_null(l_sfcb009) AND NOT cl_null(l_sfcb010) THEN
      #   SELECT COUNT(1) INTO l_n0 FROM sfcc_t
      #    WHERE sfccent=g_enterprise AND sfccsite=g_site
      #      AND sfccdocno=g_sfca_m.sfcadocno AND sfcc001=g_sfca_m.sfca001 
      #      AND sfcc003=l_sfcb009 AND sfcc004=l_sfcb010
      #   IF l_n0 = 0 THEN
      #      IF l_sfcb.sfcb009 = 'MULT' THEN
      #         SELECT COUNT(1) INTO l_n0 FROM sfcc_t
      #          WHERE sfccent=g_enterprise AND sfccsite=g_site
      #            AND sfccdocno=g_sfca_m.sfcadocno AND sfcc001=g_sfca_m.sfca001 
      #            AND sfcc003=l_sfcb.sfcb003 AND sfcc004=l_sfcb.sfcb004
      #      ELSE
      #         #群组
      #         SELECT COUNT(1) INTO l_n0 FROM sfcb_t
      #          WHERE sfcbent=g_enterprise AND sfcbsite=g_site
      #            AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
      #            AND sfcb007=l_sfcb.sfcb003 AND sfcb008=l_sfcb.sfcb004 AND sfcb006=l_sfcb009
      #         IF l_n0 = 0 THEN
      #            SELECT COUNT(1) INTO l_n0 FROM sfcb_t
      #             WHERE sfcbent=g_enterprise AND sfcbsite=g_site
      #               AND sfcbdocno=g_sfca_m.sfcadocno AND sfcb001=g_sfca_m.sfca001 
      #               AND sfcb003=l_sfcb009 AND sfcb004=l_sfcb010 AND sfcb007=l_sfcb.sfcb006
      #         END IF
      #      END IF
      #   END IF
      #END IF
      #IF cl_null(l_sfcb009) OR l_n0 = 0 THEN           
      #   UPDATE sfcb_t SET sfcb009 = 'END',sfcb010 = 0
      #    WHERE sfcbent = g_enterprise
      #      AND sfcbsite = g_site
      #      AND sfcbdocno = g_sfca_m.sfcadocno
      #      AND sfcb001 = g_sfca_m.sfca001
      #      AND sfcb002 = l_sfcb.sfcb002
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "UPDATE sfcb_t"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      RETURN r_success
      #   END IF
      #END IF
     #160113-00001#1 mark str
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 工作站名稱
# Memo...........:
# Usage..........: CALL asft301_sfcb011_ref(p_ecaa001)
#                  RETURNING r_ecaa002
# Input parameter: 
# Return code....: 
# Date & Author..: 160811-00008 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_sfcb011_ref(p_ecaa001)
DEFINE p_ecaa001    LIKE ecaa_t.ecaa001
DEFINE r_ecaa002    LIKE ecaa_t.ecaa002

   LET r_ecaa002 = ''
   SELECT ecaa002 INTO r_ecaa002
     FROM ecaa_t
    WHERE ecaaent = g_enterprise
      AND ecaasite = g_site
      AND ecaa001 = p_ecaa001

   RETURN r_ecaa002
END FUNCTION

################################################################################
# Descriptions...: 新增变更单
# Memo...........:
# Usage..........: CALL asft301_ins_sfoa()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_ins_sfoa()
DEFINE  l_cnt       LIKE type_t.num5
DEFINE  l_sfoa900   LIKE sfoa_t.sfoa900
DEFINE  r_success   LIKE type_t.num5

   LET l_cnt = 0
   LET l_sfoa900 = ''
   SELECT COUNT(1) INTO l_cnt FROM sfoa_t
    WHERE sfoaent = g_enterprise
      AND sfoadocno = g_sfca_m.sfcadocno
      AND sfoa001 = g_sfca_m.sfca001
      AND sfoastus = 'N'
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
   IF l_cnt > 0 THEN      
      SELECT sfoa900 INTO l_sfoa900 FROM sfoa_t
       WHERE sfoaent = g_enterprise
         AND sfoadocno = g_sfca_m.sfcadocno
         AND sfoa001 = g_sfca_m.sfca001
         AND sfoastus = 'N'    
               
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00759'
      LET g_errparam.extend = g_sfca_m.sfcadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      RETURN l_sfoa900  
   ELSE
   #產生新的變更單
      CALL s_transaction_begin()    
      #变更单单头资料，sfoa_t
      CALL asft301_gen_sfoa() RETURNING r_success,l_sfoa900

      IF r_success THEN
      #变更单制程资料
         IF NOT asft301_gen_sfob(l_sfoa900) THEN
            CALL s_transaction_end('N','0')
            RETURN ''
         ELSE
            CALL s_transaction_end('Y','0')         
         END IF  
      ELSE
         CALL s_transaction_end('N','0')      
      END IF
      
      RETURN l_sfoa900
   END IF
   RETURN l_sfoa900
END FUNCTION

################################################################################
# Descriptions...: 產生變更資料
# Memo...........:
# Usage..........: CALL asft301_gen_sfoa()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_gen_sfoa()
DEFINE r_success              LIKE type_t.num5
#161109-00085#28-s
#DEFINE l_sfca    RECORD LIKE sfca_t.*
DEFINE l_sfca RECORD  #工單製程單頭檔
       sfcaent LIKE sfca_t.sfcaent, #企業編號
       sfcasite LIKE sfca_t.sfcasite, #營運據點
       sfcadocno LIKE sfca_t.sfcadocno, #單號
       sfca001 LIKE sfca_t.sfca001, #RUN CARD編號
       sfca002 LIKE sfca_t.sfca002, #變更版本
       sfca003 LIKE sfca_t.sfca003, #生產數量
       sfca004 LIKE sfca_t.sfca004, #完工數量
       #sfca005 LIKE sfca_t.sfca005  #RUN CARD類型 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfca005 LIKE sfca_t.sfca005, #RUN CARD類型
       sfcaud001 LIKE sfca_t.sfcaud001, #自定義欄位(文字)001
       sfcaud002 LIKE sfca_t.sfcaud002, #自定義欄位(文字)002
       sfcaud003 LIKE sfca_t.sfcaud003, #自定義欄位(文字)003
       sfcaud004 LIKE sfca_t.sfcaud004, #自定義欄位(文字)004
       sfcaud005 LIKE sfca_t.sfcaud005, #自定義欄位(文字)005
       sfcaud006 LIKE sfca_t.sfcaud006, #自定義欄位(文字)006
       sfcaud007 LIKE sfca_t.sfcaud007, #自定義欄位(文字)007
       sfcaud008 LIKE sfca_t.sfcaud008, #自定義欄位(文字)008
       sfcaud009 LIKE sfca_t.sfcaud009, #自定義欄位(文字)009
       sfcaud010 LIKE sfca_t.sfcaud010, #自定義欄位(文字)010
       sfcaud011 LIKE sfca_t.sfcaud011, #自定義欄位(數字)011
       sfcaud012 LIKE sfca_t.sfcaud012, #自定義欄位(數字)012
       sfcaud013 LIKE sfca_t.sfcaud013, #自定義欄位(數字)013
       sfcaud014 LIKE sfca_t.sfcaud014, #自定義欄位(數字)014
       sfcaud015 LIKE sfca_t.sfcaud015, #自定義欄位(數字)015
       sfcaud016 LIKE sfca_t.sfcaud016, #自定義欄位(數字)016
       sfcaud017 LIKE sfca_t.sfcaud017, #自定義欄位(數字)017
       sfcaud018 LIKE sfca_t.sfcaud018, #自定義欄位(數字)018
       sfcaud019 LIKE sfca_t.sfcaud019, #自定義欄位(數字)019
       sfcaud020 LIKE sfca_t.sfcaud020, #自定義欄位(數字)020
       sfcaud021 LIKE sfca_t.sfcaud021, #自定義欄位(日期時間)021
       sfcaud022 LIKE sfca_t.sfcaud022, #自定義欄位(日期時間)022
       sfcaud023 LIKE sfca_t.sfcaud023, #自定義欄位(日期時間)023
       sfcaud024 LIKE sfca_t.sfcaud024, #自定義欄位(日期時間)024
       sfcaud025 LIKE sfca_t.sfcaud025, #自定義欄位(日期時間)025
       sfcaud026 LIKE sfca_t.sfcaud026, #自定義欄位(日期時間)026
       sfcaud027 LIKE sfca_t.sfcaud027, #自定義欄位(日期時間)027
       sfcaud028 LIKE sfca_t.sfcaud028, #自定義欄位(日期時間)028
       sfcaud029 LIKE sfca_t.sfcaud029, #自定義欄位(日期時間)029
       sfcaud030 LIKE sfca_t.sfcaud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
#161109-00085#28-s
#DEFINE l_sfoa                 RECORD LIKE sfoa_t.*
DEFINE l_sfoa RECORD  #工單製程變更單頭檔
       sfoaent LIKE sfoa_t.sfoaent, #企業編號
       sfoasite LIKE sfoa_t.sfoasite, #營運據點
       sfoadocno LIKE sfoa_t.sfoadocno, #工單單號
       sfoa001 LIKE sfoa_t.sfoa001, #RUN CARD編號
       sfoa002 LIKE sfoa_t.sfoa002, #變更版本
       sfoa003 LIKE sfoa_t.sfoa003, #生產數量
       sfoa004 LIKE sfoa_t.sfoa004, #完工數量
       sfoa900 LIKE sfoa_t.sfoa900, #變更序
       sfoa901 LIKE sfoa_t.sfoa901, #變更類型
       sfoa902 LIKE sfoa_t.sfoa902, #變更日期
       sfoa905 LIKE sfoa_t.sfoa905, #變更理由
       sfoa906 LIKE sfoa_t.sfoa906, #變更備註
       sfoaownid LIKE sfoa_t.sfoaownid, #資料所有者
       sfoaowndp LIKE sfoa_t.sfoaowndp, #資料所屬部門
       sfoacrtid LIKE sfoa_t.sfoacrtid, #資料建立者
       sfoacrtdp LIKE sfoa_t.sfoacrtdp, #資料建立部門
       sfoacrtdt LIKE sfoa_t.sfoacrtdt, #資料創建日
       sfoamodid LIKE sfoa_t.sfoamodid, #資料修改者
       sfoamoddt LIKE sfoa_t.sfoamoddt, #最近修改日
       sfoacnfid LIKE sfoa_t.sfoacnfid, #資料確認者
       sfoacnfdt LIKE sfoa_t.sfoacnfdt, #資料確認日
       sfoapstid LIKE sfoa_t.sfoapstid, #資料過帳者
       sfoapstdt LIKE sfoa_t.sfoapstdt, #資料過帳日
       sfoastus LIKE sfoa_t.sfoastus, #狀態碼
       #sfoa005 LIKE sfoa_t.sfoa005  #RUN CARD類型 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfoa005 LIKE sfoa_t.sfoa005, #RUN CARD類型
       sfoaud001 LIKE sfoa_t.sfoaud001, #自定義欄位(文字)001
       sfoaud002 LIKE sfoa_t.sfoaud002, #自定義欄位(文字)002
       sfoaud003 LIKE sfoa_t.sfoaud003, #自定義欄位(文字)003
       sfoaud004 LIKE sfoa_t.sfoaud004, #自定義欄位(文字)004
       sfoaud005 LIKE sfoa_t.sfoaud005, #自定義欄位(文字)005
       sfoaud006 LIKE sfoa_t.sfoaud006, #自定義欄位(文字)006
       sfoaud007 LIKE sfoa_t.sfoaud007, #自定義欄位(文字)007
       sfoaud008 LIKE sfoa_t.sfoaud008, #自定義欄位(文字)008
       sfoaud009 LIKE sfoa_t.sfoaud009, #自定義欄位(文字)009
       sfoaud010 LIKE sfoa_t.sfoaud010, #自定義欄位(文字)010
       sfoaud011 LIKE sfoa_t.sfoaud011, #自定義欄位(數字)011
       sfoaud012 LIKE sfoa_t.sfoaud012, #自定義欄位(數字)012
       sfoaud013 LIKE sfoa_t.sfoaud013, #自定義欄位(數字)013
       sfoaud014 LIKE sfoa_t.sfoaud014, #自定義欄位(數字)014
       sfoaud015 LIKE sfoa_t.sfoaud015, #自定義欄位(數字)015
       sfoaud016 LIKE sfoa_t.sfoaud016, #自定義欄位(數字)016
       sfoaud017 LIKE sfoa_t.sfoaud017, #自定義欄位(數字)017
       sfoaud018 LIKE sfoa_t.sfoaud018, #自定義欄位(數字)018
       sfoaud019 LIKE sfoa_t.sfoaud019, #自定義欄位(數字)019
       sfoaud020 LIKE sfoa_t.sfoaud020, #自定義欄位(數字)020
       sfoaud021 LIKE sfoa_t.sfoaud021, #自定義欄位(日期時間)021
       sfoaud022 LIKE sfoa_t.sfoaud022, #自定義欄位(日期時間)022
       sfoaud023 LIKE sfoa_t.sfoaud023, #自定義欄位(日期時間)023
       sfoaud024 LIKE sfoa_t.sfoaud024, #自定義欄位(日期時間)024
       sfoaud025 LIKE sfoa_t.sfoaud025, #自定義欄位(日期時間)025
       sfoaud026 LIKE sfoa_t.sfoaud026, #自定義欄位(日期時間)026
       sfoaud027 LIKE sfoa_t.sfoaud027, #自定義欄位(日期時間)027
       sfoaud028 LIKE sfoa_t.sfoaud028, #自定義欄位(日期時間)028
       sfoaud029 LIKE sfoa_t.sfoaud029, #自定義欄位(日期時間)029
       sfoaud030 LIKE sfoa_t.sfoaud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
DEFINE l_sfoacrtdt            DATETIME YEAR TO SECOND  #资料建立日期

   LET r_success = FALSE
   #161109-00085#28-s
   #SELECT * INTO l_sfca.* FROM sfca_t
   #161109-00085#67 --s mark
   #  SELECT sfcaent,sfcasite,sfcadocno,sfca001,sfca002,sfca003,sfca004,sfca005
   #    INTO l_sfca.sfcaent,l_sfca.sfcasite,l_sfca.sfcadocno,l_sfca.sfca001,l_sfca.sfca002,
   #         l_sfca.sfca003,l_sfca.sfca004,l_sfca.sfca005
   #161109-00085#67 --e mark
   #161109-00085#67 --s add
     SELECT sfcaent,sfcasite,sfcadocno,sfca001,sfca002,
            sfca003,sfca004,sfca005,sfcaud001,sfcaud002,
            sfcaud003,sfcaud004,sfcaud005,sfcaud006,sfcaud007,
            sfcaud008,sfcaud009,sfcaud010,sfcaud011,sfcaud012,
            sfcaud013,sfcaud014,sfcaud015,sfcaud016,sfcaud017,
            sfcaud018,sfcaud019,sfcaud020,sfcaud021,sfcaud022,
            sfcaud023,sfcaud024,sfcaud025,sfcaud026,sfcaud027,
            sfcaud028,sfcaud029,sfcaud030
       INTO l_sfca.sfcaent,l_sfca.sfcasite,l_sfca.sfcadocno,l_sfca.sfca001,l_sfca.sfca002,
            l_sfca.sfca003,l_sfca.sfca004,l_sfca.sfca005,l_sfca.sfcaud001,l_sfca.sfcaud002,
            l_sfca.sfcaud003,l_sfca.sfcaud004,l_sfca.sfcaud005,l_sfca.sfcaud006,l_sfca.sfcaud007,
            l_sfca.sfcaud008,l_sfca.sfcaud009,l_sfca.sfcaud010,l_sfca.sfcaud011,l_sfca.sfcaud012,
            l_sfca.sfcaud013,l_sfca.sfcaud014,l_sfca.sfcaud015,l_sfca.sfcaud016,l_sfca.sfcaud017,
            l_sfca.sfcaud018,l_sfca.sfcaud019,l_sfca.sfcaud020,l_sfca.sfcaud021,l_sfca.sfcaud022,
            l_sfca.sfcaud023,l_sfca.sfcaud024,l_sfca.sfcaud025,l_sfca.sfcaud026,l_sfca.sfcaud027,
            l_sfca.sfcaud028,l_sfca.sfcaud029,l_sfca.sfcaud030
   #161109-00085#67 --e add
       FROM sfca_t
   #161109-00085#28-e   
    WHERE sfcaent = g_enterprise
      AND sfcadocno = g_sfca_m.sfcadocno
      AND sfca001 = g_sfca_m.sfca001
   
   LET l_sfoa.sfoaent = g_enterprise
   LET l_sfoa.sfoasite = g_site
   LET l_sfoa.sfoadocno = l_sfca.sfcadocno
   LET l_sfoa.sfoa001 = l_sfca.sfca001
   LET l_sfoa.sfoa002 = l_sfca.sfca002 + 1  #變更版本=[T:工單製程單頭檔].[C:變更版本]加1  #160222-00017#1 mod
   LET l_sfoa.sfoa003 = l_sfca.sfca003
   LET l_sfoa.sfoa004 = l_sfca.sfca004
   LET l_sfoa.sfoa005 = l_sfca.sfca005
   SELECT MAX(sfoa900)+1 INTO l_sfoa.sfoa900 FROM sfoa_t
    WHERE sfoaent = g_enterprise
      AND sfoadocno = l_sfoa.sfoadocno
      AND sfoa001 = l_sfoa.sfoa001
   IF cl_null(l_sfoa.sfoa900) THEN LET l_sfoa.sfoa900 = 1 END IF     
   LET l_sfoa.sfoa901 = 'N'
   LET l_sfoa.sfoa902 = cl_get_current()
   LET l_sfoa.sfoaownid =  g_user
   LET l_sfoa.sfoaowndp =  g_dept
   LET l_sfoa.sfoacrtid =  g_user
   LET l_sfoa.sfoacrtdp =  g_dept 
   LET l_sfoa.sfoacrtdt =  ""
   LET l_sfoa.sfoamodid =  ""
   LET l_sfoa.sfoamoddt =  ""
   LET l_sfoa.sfoacnfid =  ""
   LET l_sfoa.sfoacnfdt =  ""
   LET l_sfoa.sfoapstid =  ""
   LET l_sfoa.sfoapstdt =  ""
   LET l_sfoa.sfoastus  =  "N"
   #161109-00085#28-s
   #INSERT INTO sfoa_t VALUES l_sfoa.*
   #161109-00085#67 --s mark
   #INSERT INTO sfoa_t(sfoaent,sfoasite,sfoadocno,sfoa001,sfoa002,sfoa003,sfoa004,sfoa900,sfoa901,sfoa902,
   #                   sfoa905,sfoa906,sfoaownid,sfoaowndp,sfoacrtid,sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,
   #                   sfoacnfdt,sfoapstid,sfoapstdt,sfoastus,sfoa005) 
   #VALUES (l_sfoa.sfoaent,l_sfoa.sfoasite,l_sfoa.sfoadocno,l_sfoa.sfoa001,l_sfoa.sfoa002,
   #        l_sfoa.sfoa003,l_sfoa.sfoa004,l_sfoa.sfoa900,l_sfoa.sfoa901,l_sfoa.sfoa902,
   #        l_sfoa.sfoa905,l_sfoa.sfoa906,l_sfoa.sfoaownid,l_sfoa.sfoaowndp,l_sfoa.sfoacrtid,
   #        l_sfoa.sfoacrtdp,l_sfoa.sfoacrtdt,l_sfoa.sfoamodid,l_sfoa.sfoamoddt,l_sfoa.sfoacnfid,
   #        l_sfoa.sfoacnfdt,l_sfoa.sfoapstid,l_sfoa.sfoapstdt,l_sfoa.sfoastus,l_sfoa.sfoa005)
   #161109-00085#67 --e mark
   #161109-00085#28-e
   #161109-00085#67 --s add
   INSERT INTO sfoa_t(sfoaent,sfoasite,sfoadocno,sfoa001,sfoa002,
                      sfoa003,sfoa004,sfoa900,sfoa901,sfoa902,
                      sfoa905,sfoa906,sfoaownid,sfoaowndp,sfoacrtid,
                      sfoacrtdp,sfoacrtdt,sfoamodid,sfoamoddt,sfoacnfid,
                      sfoacnfdt,sfoapstid,sfoapstdt,sfoastus,sfoa005,
                      sfoaud001,sfoaud002,sfoaud003,sfoaud004,sfoaud005,
                      sfoaud006,sfoaud007,sfoaud008,sfoaud009,sfoaud010,
                      sfoaud011,sfoaud012,sfoaud013,sfoaud014,sfoaud015,
                      sfoaud016,sfoaud017,sfoaud018,sfoaud019,sfoaud020,
                      sfoaud021,sfoaud022,sfoaud023,sfoaud024,sfoaud025,
                      sfoaud026,sfoaud027,sfoaud028,sfoaud029,sfoaud030)
              VALUES (l_sfoa.sfoaent,l_sfoa.sfoasite,l_sfoa.sfoadocno,l_sfoa.sfoa001,l_sfoa.sfoa002,
                      l_sfoa.sfoa003,l_sfoa.sfoa004,l_sfoa.sfoa900,l_sfoa.sfoa901,l_sfoa.sfoa902,
                      l_sfoa.sfoa905,l_sfoa.sfoa906,l_sfoa.sfoaownid,l_sfoa.sfoaowndp,l_sfoa.sfoacrtid,
                      l_sfoa.sfoacrtdp,l_sfoa.sfoacrtdt,l_sfoa.sfoamodid,l_sfoa.sfoamoddt,l_sfoa.sfoacnfid,
                      l_sfoa.sfoacnfdt,l_sfoa.sfoapstid,l_sfoa.sfoapstdt,l_sfoa.sfoastus,l_sfoa.sfoa005,
                      l_sfoa.sfoaud001,l_sfoa.sfoaud002,l_sfoa.sfoaud003,l_sfoa.sfoaud004,l_sfoa.sfoaud005,
                      l_sfoa.sfoaud006,l_sfoa.sfoaud007,l_sfoa.sfoaud008,l_sfoa.sfoaud009,l_sfoa.sfoaud010,
                      l_sfoa.sfoaud011,l_sfoa.sfoaud012,l_sfoa.sfoaud013,l_sfoa.sfoaud014,l_sfoa.sfoaud015,
                      l_sfoa.sfoaud016,l_sfoa.sfoaud017,l_sfoa.sfoaud018,l_sfoa.sfoaud019,l_sfoa.sfoaud020,
                      l_sfoa.sfoaud021,l_sfoa.sfoaud022,l_sfoa.sfoaud023,l_sfoa.sfoaud024,l_sfoa.sfoaud025,
                      l_sfoa.sfoaud026,l_sfoa.sfoaud027,l_sfoa.sfoaud028,l_sfoa.sfoaud029,l_sfoa.sfoaud030)
   #161109-00085#67 --e add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT sfoa_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success,l_sfoa.sfoa900
   END IF
   LET l_sfoacrtdt =  cl_get_current()
   UPDATE sfoa_t SET sfoacrtdt = l_sfoacrtdt 
    WHERE sfoaent = g_enterprise AND sfoasite = g_site
      AND sfoadocno = l_sfoa.sfoadocno AND sfoa001 = l_sfoa.sfoa001
      AND sfoa900 = l_sfoa.sfoa900
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE sfoa_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success,l_sfoa.sfoa900
   END IF
   LET r_success = TRUE
   RETURN r_success,l_sfoa.sfoa900
END FUNCTION

################################################################################
# Descriptions...: #产生单身制程资料
# Memo...........:
# Usage..........: CALL asft301_gen_sfob(p_sfoa900)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_gen_sfob(p_sfoa900)
DEFINE p_sfoa900              LIKE sfoa_t.sfoa900
DEFINE r_success              LIKE type_t.num5
#161109-00085#28-s
#DEFINE l_sfcb    RECORD LIKE sfcb_t.*
DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       #sfcb055 LIKE sfcb_t.sfcb055  #回收站 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfcb055 LIKE sfcb_t.sfcb055, #回收站
       sfcbud001 LIKE sfcb_t.sfcbud001, #自定義欄位(文字)001
       sfcbud002 LIKE sfcb_t.sfcbud002, #自定義欄位(文字)002
       sfcbud003 LIKE sfcb_t.sfcbud003, #自定義欄位(文字)003
       sfcbud004 LIKE sfcb_t.sfcbud004, #自定義欄位(文字)004
       sfcbud005 LIKE sfcb_t.sfcbud005, #自定義欄位(文字)005
       sfcbud006 LIKE sfcb_t.sfcbud006, #自定義欄位(文字)006
       sfcbud007 LIKE sfcb_t.sfcbud007, #自定義欄位(文字)007
       sfcbud008 LIKE sfcb_t.sfcbud008, #自定義欄位(文字)008
       sfcbud009 LIKE sfcb_t.sfcbud009, #自定義欄位(文字)009
       sfcbud010 LIKE sfcb_t.sfcbud010, #自定義欄位(文字)010
       sfcbud011 LIKE sfcb_t.sfcbud011, #自定義欄位(數字)011
       sfcbud012 LIKE sfcb_t.sfcbud012, #自定義欄位(數字)012
       sfcbud013 LIKE sfcb_t.sfcbud013, #自定義欄位(數字)013
       sfcbud014 LIKE sfcb_t.sfcbud014, #自定義欄位(數字)014
       sfcbud015 LIKE sfcb_t.sfcbud015, #自定義欄位(數字)015
       sfcbud016 LIKE sfcb_t.sfcbud016, #自定義欄位(數字)016
       sfcbud017 LIKE sfcb_t.sfcbud017, #自定義欄位(數字)017
       sfcbud018 LIKE sfcb_t.sfcbud018, #自定義欄位(數字)018
       sfcbud019 LIKE sfcb_t.sfcbud019, #自定義欄位(數字)019
       sfcbud020 LIKE sfcb_t.sfcbud020, #自定義欄位(數字)020
       sfcbud021 LIKE sfcb_t.sfcbud021, #自定義欄位(日期時間)021
       sfcbud022 LIKE sfcb_t.sfcbud022, #自定義欄位(日期時間)022
       sfcbud023 LIKE sfcb_t.sfcbud023, #自定義欄位(日期時間)023
       sfcbud024 LIKE sfcb_t.sfcbud024, #自定義欄位(日期時間)024
       sfcbud025 LIKE sfcb_t.sfcbud025, #自定義欄位(日期時間)025
       sfcbud026 LIKE sfcb_t.sfcbud026, #自定義欄位(日期時間)026
       sfcbud027 LIKE sfcb_t.sfcbud027, #自定義欄位(日期時間)027
       sfcbud028 LIKE sfcb_t.sfcbud028, #自定義欄位(日期時間)028
       sfcbud029 LIKE sfcb_t.sfcbud029, #自定義欄位(日期時間)029
       sfcbud030 LIKE sfcb_t.sfcbud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
#161109-00085#28-s
#DEFINE l_sfob                 RECORD LIKE sfob_t.*
DEFINE l_sfob RECORD  #工單製程變更單身檔
       sfobent LIKE sfob_t.sfobent, #企業編號
       sfobsite LIKE sfob_t.sfobsite, #營運據點
       sfobdocno LIKE sfob_t.sfobdocno, #工單單號
       sfob001 LIKE sfob_t.sfob001, #RUN CARD
       sfob002 LIKE sfob_t.sfob002, #項次
       sfob003 LIKE sfob_t.sfob003, #本站作業
       sfob004 LIKE sfob_t.sfob004, #製程式
       sfob005 LIKE sfob_t.sfob005, #群組性質
       sfob006 LIKE sfob_t.sfob006, #群組
       sfob007 LIKE sfob_t.sfob007, #上站作業
       sfob008 LIKE sfob_t.sfob008, #上站製程式
       sfob009 LIKE sfob_t.sfob009, #下站作業
       sfob010 LIKE sfob_t.sfob010, #下站製程式
       sfob011 LIKE sfob_t.sfob011, #工作站
       sfob012 LIKE sfob_t.sfob012, #允許委外
       sfob013 LIKE sfob_t.sfob013, #主要加工廠
       sfob014 LIKE sfob_t.sfob014, #Move in
       sfob015 LIKE sfob_t.sfob015, #Check in
       sfob016 LIKE sfob_t.sfob016, #報工站
       sfob017 LIKE sfob_t.sfob017, #PQC
       sfob018 LIKE sfob_t.sfob018, #Check out
       sfob019 LIKE sfob_t.sfob019, #Move out
       sfob020 LIKE sfob_t.sfob020, #轉出單位
       sfob021 LIKE sfob_t.sfob021, #轉出單位轉換率分子
       sfob022 LIKE sfob_t.sfob022, #轉出單位轉換率分母
       sfob023 LIKE sfob_t.sfob023, #固定工時
       sfob024 LIKE sfob_t.sfob024, #標準工時
       sfob025 LIKE sfob_t.sfob025, #固定機時
       sfob026 LIKE sfob_t.sfob026, #標準機時
       sfob027 LIKE sfob_t.sfob027, #標準產出量
       sfob028 LIKE sfob_t.sfob028, #良品轉入
       sfob029 LIKE sfob_t.sfob029, #重工轉入
       sfob030 LIKE sfob_t.sfob030, #工單轉入
       sfob031 LIKE sfob_t.sfob031, #分割轉入
       sfob032 LIKE sfob_t.sfob032, #合併轉入
       sfob033 LIKE sfob_t.sfob033, #良品轉出
       sfob034 LIKE sfob_t.sfob034, #重工轉出
       sfob035 LIKE sfob_t.sfob035, #工單轉出
       sfob036 LIKE sfob_t.sfob036, #當站報廢
       sfob037 LIKE sfob_t.sfob037, #當站下線
       sfob038 LIKE sfob_t.sfob038, #分割轉出
       sfob039 LIKE sfob_t.sfob039, #合併轉出
       sfob040 LIKE sfob_t.sfob040, #Bonus
       sfob041 LIKE sfob_t.sfob041, #委外加工數
       sfob042 LIKE sfob_t.sfob042, #委外完工數
       sfob043 LIKE sfob_t.sfob043, #盤點數
       sfob044 LIKE sfob_t.sfob044, #預計開工日
       sfob045 LIKE sfob_t.sfob045, #預計完工日
       sfob046 LIKE sfob_t.sfob046, #待Move in數
       sfob047 LIKE sfob_t.sfob047, #待Check in數
       sfob048 LIKE sfob_t.sfob048, #待Check out數
       sfob049 LIKE sfob_t.sfob049, #待Move out數
       sfob050 LIKE sfob_t.sfob050, #在製數
       sfob051 LIKE sfob_t.sfob051, #待PQC數
       sfob052 LIKE sfob_t.sfob052, #轉入單位
       sfob053 LIKE sfob_t.sfob053, #轉入單位轉換率分子
       sfob054 LIKE sfob_t.sfob054, #轉入單位轉換率分母
       sfob900 LIKE sfob_t.sfob900, #變更序
       sfob901 LIKE sfob_t.sfob901, #變更類型
       sfob902 LIKE sfob_t.sfob902, #變更日期
       sfob905 LIKE sfob_t.sfob905, #變更理由
       sfob906 LIKE sfob_t.sfob906, #變更備註
       #sfob055 LIKE sfob_t.sfob055  #回收站 #161109-00085#67 mark
       #161109-00085#67 --s add   
       sfob055 LIKE sfob_t.sfob055, #回收站
       sfobud001 LIKE sfob_t.sfobud001, #自定義欄位(文字)001
       sfobud002 LIKE sfob_t.sfobud002, #自定義欄位(文字)002
       sfobud003 LIKE sfob_t.sfobud003, #自定義欄位(文字)003
       sfobud004 LIKE sfob_t.sfobud004, #自定義欄位(文字)004
       sfobud005 LIKE sfob_t.sfobud005, #自定義欄位(文字)005
       sfobud006 LIKE sfob_t.sfobud006, #自定義欄位(文字)006
       sfobud007 LIKE sfob_t.sfobud007, #自定義欄位(文字)007
       sfobud008 LIKE sfob_t.sfobud008, #自定義欄位(文字)008
       sfobud009 LIKE sfob_t.sfobud009, #自定義欄位(文字)009
       sfobud010 LIKE sfob_t.sfobud010, #自定義欄位(文字)010
       sfobud011 LIKE sfob_t.sfobud011, #自定義欄位(數字)011
       sfobud012 LIKE sfob_t.sfobud012, #自定義欄位(數字)012
       sfobud013 LIKE sfob_t.sfobud013, #自定義欄位(數字)013
       sfobud014 LIKE sfob_t.sfobud014, #自定義欄位(數字)014
       sfobud015 LIKE sfob_t.sfobud015, #自定義欄位(數字)015
       sfobud016 LIKE sfob_t.sfobud016, #自定義欄位(數字)016
       sfobud017 LIKE sfob_t.sfobud017, #自定義欄位(數字)017
       sfobud018 LIKE sfob_t.sfobud018, #自定義欄位(數字)018
       sfobud019 LIKE sfob_t.sfobud019, #自定義欄位(數字)019
       sfobud020 LIKE sfob_t.sfobud020, #自定義欄位(數字)020
       sfobud021 LIKE sfob_t.sfobud021, #自定義欄位(日期時間)021
       sfobud022 LIKE sfob_t.sfobud022, #自定義欄位(日期時間)022
       sfobud023 LIKE sfob_t.sfobud023, #自定義欄位(日期時間)023
       sfobud024 LIKE sfob_t.sfobud024, #自定義欄位(日期時間)024
       sfobud025 LIKE sfob_t.sfobud025, #自定義欄位(日期時間)025
       sfobud026 LIKE sfob_t.sfobud026, #自定義欄位(日期時間)026
       sfobud027 LIKE sfob_t.sfobud027, #自定義欄位(日期時間)027
       sfobud028 LIKE sfob_t.sfobud028, #自定義欄位(日期時間)028
       sfobud029 LIKE sfob_t.sfobud029, #自定義欄位(日期時間)029
       sfobud030 LIKE sfob_t.sfobud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
               END RECORD
#161109-00085#28-e
   LET r_success = FALSE
   DECLARE asft301_gen_sfob CURSOR FOR
       #161109-00085#28-s
       #SELECT * FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbsite = g_site
       #161109-00085#67 --s mark
       #SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,sfcb003,sfcb004,sfcb005,sfcb006,
       #       sfcb007,sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,sfcb013,sfcb014,sfcb015,sfcb016,
       #       sfcb017,sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,sfcb023,sfcb024,sfcb025,sfcb026,
       #       sfcb027,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,
       #       sfcb037,sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,sfcb043,sfcb044,sfcb045,sfcb046,
       #       sfcb047,sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,sfcb053,sfcb054,sfcb055
       #161109-00085#67 --e mark
       #161109-00085#67 --s add
       SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
              sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
              sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
              sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
              sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
              sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
              sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
              sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
              sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
              sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
              sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
              sfcb053,sfcb054,sfcb055,sfcbud001,sfcbud002,
              sfcbud003,sfcbud004,sfcbud005,sfcbud006,sfcbud007,
              sfcbud008,sfcbud009,sfcbud010,sfcbud011,sfcbud012,
              sfcbud013,sfcbud014,sfcbud015,sfcbud016,sfcbud017,
              sfcbud018,sfcbud019,sfcbud020,sfcbud021,sfcbud022,
              sfcbud023,sfcbud024,sfcbud025,sfcbud026,sfcbud027,
              sfcbud028,sfcbud029,sfcbud030
       #161109-00085#67 --e add
         FROM sfcb_t
        WHERE sfcbent = g_enterprise AND sfcbsite = g_site
          AND sfcbdocno = g_sfca_m.sfcadocno AND sfcb001 = g_sfca_m.sfca001
   #FOREACH asft301_gen_sfob INTO l_sfcb.*
   FOREACH asft301_gen_sfob 
   #161109-00085#67 --s mark
   #   INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
   #        l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
   #        l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
   #        l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
   #        l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
   #        l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
   #        l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
   #        l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
   #        l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
   #        l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
   #        l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
   #        l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
   #161109-00085#67 --e amrk
   #161109-00085#67 --s add
       INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
            l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
            l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
            l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
            l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
            l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
            l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
            l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
            l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
            l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
            l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
            l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055,l_sfcb.sfcbud001,l_sfcb.sfcbud002,
            l_sfcb.sfcbud003,l_sfcb.sfcbud004,l_sfcb.sfcbud005,l_sfcb.sfcbud006,l_sfcb.sfcbud007,
            l_sfcb.sfcbud008,l_sfcb.sfcbud009,l_sfcb.sfcbud010,l_sfcb.sfcbud011,l_sfcb.sfcbud012,
            l_sfcb.sfcbud013,l_sfcb.sfcbud014,l_sfcb.sfcbud015,l_sfcb.sfcbud016,l_sfcb.sfcbud017,
            l_sfcb.sfcbud018,l_sfcb.sfcbud019,l_sfcb.sfcbud020,l_sfcb.sfcbud021,l_sfcb.sfcbud022,
            l_sfcb.sfcbud023,l_sfcb.sfcbud024,l_sfcb.sfcbud025,l_sfcb.sfcbud026,l_sfcb.sfcbud027,
            l_sfcb.sfcbud028,l_sfcb.sfcbud029,l_sfcb.sfcbud030
   #161109-00085#67 --e add
   #161109-00085#28-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfob.sfobent = g_enterprise 
      LET l_sfob.sfobsite = g_site
      LET l_sfob.sfobdocno = l_sfcb.sfcbdocno
      LET l_sfob.sfob001 = l_sfcb.sfcb001
      LET l_sfob.sfob002 = l_sfcb.sfcb002
      LET l_sfob.sfob003 = l_sfcb.sfcb003
      LET l_sfob.sfob004 = l_sfcb.sfcb004
      LET l_sfob.sfob005 = l_sfcb.sfcb005
      LET l_sfob.sfob006 = l_sfcb.sfcb006
      LET l_sfob.sfob007 = l_sfcb.sfcb007
      LET l_sfob.sfob008 = l_sfcb.sfcb008
      LET l_sfob.sfob009 = l_sfcb.sfcb009
      LET l_sfob.sfob010 = l_sfcb.sfcb010
      LET l_sfob.sfob011 = l_sfcb.sfcb011
      LET l_sfob.sfob012 = l_sfcb.sfcb012
      LET l_sfob.sfob013 = l_sfcb.sfcb013
      LET l_sfob.sfob014 = l_sfcb.sfcb014
      LET l_sfob.sfob015 = l_sfcb.sfcb015
      LET l_sfob.sfob016 = l_sfcb.sfcb016
      LET l_sfob.sfob017 = l_sfcb.sfcb017
      LET l_sfob.sfob018 = l_sfcb.sfcb018
      LET l_sfob.sfob019 = l_sfcb.sfcb019
      LET l_sfob.sfob020 = l_sfcb.sfcb020
      LET l_sfob.sfob021 = l_sfcb.sfcb021
      LET l_sfob.sfob022 = l_sfcb.sfcb022
      LET l_sfob.sfob023 = l_sfcb.sfcb023
      LET l_sfob.sfob024 = l_sfcb.sfcb024
      LET l_sfob.sfob025 = l_sfcb.sfcb025
      LET l_sfob.sfob026 = l_sfcb.sfcb026
      LET l_sfob.sfob027 = l_sfcb.sfcb027
      LET l_sfob.sfob028 = l_sfcb.sfcb028
      LET l_sfob.sfob029 = l_sfcb.sfcb029
      LET l_sfob.sfob030 = l_sfcb.sfcb030
      LET l_sfob.sfob031 = l_sfcb.sfcb031
      LET l_sfob.sfob032 = l_sfcb.sfcb032
      LET l_sfob.sfob033 = l_sfcb.sfcb033
      LET l_sfob.sfob034 = l_sfcb.sfcb034
      LET l_sfob.sfob035 = l_sfcb.sfcb035
      LET l_sfob.sfob036 = l_sfcb.sfcb036
      LET l_sfob.sfob037 = l_sfcb.sfcb037
      LET l_sfob.sfob038 = l_sfcb.sfcb038
      LET l_sfob.sfob039 = l_sfcb.sfcb039
      LET l_sfob.sfob040 = l_sfcb.sfcb040
      LET l_sfob.sfob041 = l_sfcb.sfcb041
      LET l_sfob.sfob042 = l_sfcb.sfcb042
      LET l_sfob.sfob043 = l_sfcb.sfcb043
      LET l_sfob.sfob044 = l_sfcb.sfcb044
      LET l_sfob.sfob045 = l_sfcb.sfcb045
      LET l_sfob.sfob046 = l_sfcb.sfcb046
      LET l_sfob.sfob047 = l_sfcb.sfcb047
      LET l_sfob.sfob048 = l_sfcb.sfcb048
      LET l_sfob.sfob049 = l_sfcb.sfcb049
      LET l_sfob.sfob050 = l_sfcb.sfcb050
      LET l_sfob.sfob051 = l_sfcb.sfcb051
      LET l_sfob.sfob052 = l_sfcb.sfcb052
      LET l_sfob.sfob053 = l_sfcb.sfcb053
      LET l_sfob.sfob054 = l_sfcb.sfcb054
      LET l_sfob.sfob055 = l_sfcb.sfcb055     
      LET l_sfob.sfob900 = p_sfoa900
      LET l_sfob.sfob901 = '1'
      
      #161109-00085#28-s
      #INSERT INTO sfob_t VALUES l_sfob.*
      #161109-00085#67 --s mark
      #INSERT INTO sfob_t(sfobent,sfobsite,sfobdocno,sfob001,sfob002,sfob003,sfob004,sfob005,sfob006,sfob007,
      #                   sfob008,sfob009,sfob010,sfob011,sfob012,sfob013,sfob014,sfob015,sfob016,sfob017,
      #                   sfob018,sfob019,sfob020,sfob021,sfob022,sfob023,sfob024,sfob025,sfob026,sfob027,
      #                   sfob028,sfob029,sfob030,sfob031,sfob032,sfob033,sfob034,sfob035,sfob036,sfob037,
      #                   sfob038,sfob039,sfob040,sfob041,sfob042,sfob043,sfob044,sfob045,sfob046,sfob047,
      #                   sfob048,sfob049,sfob050,sfob051,sfob052,sfob053,sfob054,sfob900,sfob901,sfob902,
      #                   sfob905,sfob906,sfob055) 
      #VALUES (l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
      #        l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
      #        l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
      #        l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
      #        l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
      #        l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
      #        l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
      #        l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
      #        l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
      #        l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
      #        l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
      #        l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
      #        l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055)
      #161109-00085#67 --e mark
      #161109-00085#67 --s add
      INSERT INTO sfob_t(sfobent,sfobsite,sfobdocno,sfob001,sfob002,
                         sfob003,sfob004,sfob005,sfob006,sfob007,
                         sfob008,sfob009,sfob010,sfob011,sfob012,
                         sfob013,sfob014,sfob015,sfob016,sfob017,
                         sfob018,sfob019,sfob020,sfob021,sfob022,
                         sfob023,sfob024,sfob025,sfob026,sfob027,
                         sfob028,sfob029,sfob030,sfob031,sfob032,
                         sfob033,sfob034,sfob035,sfob036,sfob037,
                         sfob038,sfob039,sfob040,sfob041,sfob042,
                         sfob043,sfob044,sfob045,sfob046,sfob047,
                         sfob048,sfob049,sfob050,sfob051,sfob052,
                         sfob053,sfob054,sfob900,sfob901,sfob902,
                         sfob905,sfob906,sfob055,sfobud001,sfobud002,
                         sfobud003,sfobud004,sfobud005,sfobud006,sfobud007,
                         sfobud008,sfobud009,sfobud010,sfobud011,sfobud012,
                         sfobud013,sfobud014,sfobud015,sfobud016,sfobud017,
                         sfobud018,sfobud019,sfobud020,sfobud021,sfobud022,
                         sfobud023,sfobud024,sfobud025,sfobud026,sfobud027,
                         sfobud028,sfobud029,sfobud030)
                 VALUES (l_sfob.sfobent,l_sfob.sfobsite,l_sfob.sfobdocno,l_sfob.sfob001,l_sfob.sfob002,
                         l_sfob.sfob003,l_sfob.sfob004,l_sfob.sfob005,l_sfob.sfob006,l_sfob.sfob007,
                         l_sfob.sfob008,l_sfob.sfob009,l_sfob.sfob010,l_sfob.sfob011,l_sfob.sfob012,
                         l_sfob.sfob013,l_sfob.sfob014,l_sfob.sfob015,l_sfob.sfob016,l_sfob.sfob017,
                         l_sfob.sfob018,l_sfob.sfob019,l_sfob.sfob020,l_sfob.sfob021,l_sfob.sfob022,
                         l_sfob.sfob023,l_sfob.sfob024,l_sfob.sfob025,l_sfob.sfob026,l_sfob.sfob027,
                         l_sfob.sfob028,l_sfob.sfob029,l_sfob.sfob030,l_sfob.sfob031,l_sfob.sfob032,
                         l_sfob.sfob033,l_sfob.sfob034,l_sfob.sfob035,l_sfob.sfob036,l_sfob.sfob037,
                         l_sfob.sfob038,l_sfob.sfob039,l_sfob.sfob040,l_sfob.sfob041,l_sfob.sfob042,
                         l_sfob.sfob043,l_sfob.sfob044,l_sfob.sfob045,l_sfob.sfob046,l_sfob.sfob047,
                         l_sfob.sfob048,l_sfob.sfob049,l_sfob.sfob050,l_sfob.sfob051,l_sfob.sfob052,
                         l_sfob.sfob053,l_sfob.sfob054,l_sfob.sfob900,l_sfob.sfob901,l_sfob.sfob902,
                         l_sfob.sfob905,l_sfob.sfob906,l_sfob.sfob055,l_sfob.sfobud001,l_sfob.sfobud002,
                         l_sfob.sfobud003,l_sfob.sfobud004,l_sfob.sfobud005,l_sfob.sfobud006,l_sfob.sfobud007,
                         l_sfob.sfobud008,l_sfob.sfobud009,l_sfob.sfobud010,l_sfob.sfobud011,l_sfob.sfobud012,
                         l_sfob.sfobud013,l_sfob.sfobud014,l_sfob.sfobud015,l_sfob.sfobud016,l_sfob.sfobud017,
                         l_sfob.sfobud018,l_sfob.sfobud019,l_sfob.sfobud020,l_sfob.sfobud021,l_sfob.sfobud022,
                         l_sfob.sfobud023,l_sfob.sfobud024,l_sfob.sfobud025,l_sfob.sfobud026,l_sfob.sfobud027,
                         l_sfob.sfobud028,l_sfob.sfobud029,l_sfob.sfobud030)
      #161109-00085#67 --e add
      #161109-00085#28-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT sfob_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      
      #变更单多上站资料
      IF NOT asft301_gen_sfoc(l_sfcb.sfcb002,p_sfoa900) THEN
         RETURN r_success
      END IF
      
      #变更单check in/out资料
      IF NOT asft301_gen_sfod(l_sfcb.sfcb002,p_sfoa900) THEN
         RETURN r_success
      END IF
      INITIALIZE l_sfcb.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: #产生单身制程资料
# Memo...........:
# Usage..........: CALL asft301_gen_sfoc(p_sfoc002,p_sfoa900)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_gen_sfoc(p_sfoc002,p_sfoa900)
DEFINE  p_sfoc002    LIKE sfoc_t.sfoc002
DEFINE  p_sfoa900    LIKE sfoa_t.sfoa900
DEFINE  r_success    LIKE type_t.num5
#161109-00085#28-s
#DEFINE l_sfcc         RECORD LIKE sfcc_t.*
DEFINE l_sfcc RECORD  #工單製程上站作業資料
       sfccent LIKE sfcc_t.sfccent, #企業編號
       sfccsite LIKE sfcc_t.sfccsite, #營運據點
       sfccdocno LIKE sfcc_t.sfccdocno, #單號
       sfcc001 LIKE sfcc_t.sfcc001, #RUN CARD
       sfcc002 LIKE sfcc_t.sfcc002, #項次
       sfcc003 LIKE sfcc_t.sfcc003, #上站作業
       #sfcc004 LIKE sfcc_t.sfcc004  #上站作業序 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfcc004 LIKE sfcc_t.sfcc004, #上站作業序
       sfccud001 LIKE sfcc_t.sfccud001, #自定義欄位(文字)001
       sfccud002 LIKE sfcc_t.sfccud002, #自定義欄位(文字)002
       sfccud003 LIKE sfcc_t.sfccud003, #自定義欄位(文字)003
       sfccud004 LIKE sfcc_t.sfccud004, #自定義欄位(文字)004
       sfccud005 LIKE sfcc_t.sfccud005, #自定義欄位(文字)005
       sfccud006 LIKE sfcc_t.sfccud006, #自定義欄位(文字)006
       sfccud007 LIKE sfcc_t.sfccud007, #自定義欄位(文字)007
       sfccud008 LIKE sfcc_t.sfccud008, #自定義欄位(文字)008
       sfccud009 LIKE sfcc_t.sfccud009, #自定義欄位(文字)009
       sfccud010 LIKE sfcc_t.sfccud010, #自定義欄位(文字)010
       sfccud011 LIKE sfcc_t.sfccud011, #自定義欄位(數字)011
       sfccud012 LIKE sfcc_t.sfccud012, #自定義欄位(數字)012
       sfccud013 LIKE sfcc_t.sfccud013, #自定義欄位(數字)013
       sfccud014 LIKE sfcc_t.sfccud014, #自定義欄位(數字)014
       sfccud015 LIKE sfcc_t.sfccud015, #自定義欄位(數字)015
       sfccud016 LIKE sfcc_t.sfccud016, #自定義欄位(數字)016
       sfccud017 LIKE sfcc_t.sfccud017, #自定義欄位(數字)017
       sfccud018 LIKE sfcc_t.sfccud018, #自定義欄位(數字)018
       sfccud019 LIKE sfcc_t.sfccud019, #自定義欄位(數字)019
       sfccud020 LIKE sfcc_t.sfccud020, #自定義欄位(數字)020
       sfccud021 LIKE sfcc_t.sfccud021, #自定義欄位(日期時間)021
       sfccud022 LIKE sfcc_t.sfccud022, #自定義欄位(日期時間)022
       sfccud023 LIKE sfcc_t.sfccud023, #自定義欄位(日期時間)023
       sfccud024 LIKE sfcc_t.sfccud024, #自定義欄位(日期時間)024
       sfccud025 LIKE sfcc_t.sfccud025, #自定義欄位(日期時間)025
       sfccud026 LIKE sfcc_t.sfccud026, #自定義欄位(日期時間)026
       sfccud027 LIKE sfcc_t.sfccud027, #自定義欄位(日期時間)027
       sfccud028 LIKE sfcc_t.sfccud028, #自定義欄位(日期時間)028
       sfccud029 LIKE sfcc_t.sfccud029, #自定義欄位(日期時間)029
       sfccud030 LIKE sfcc_t.sfccud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
#161109-00085#28-s
#DEFINE  l_sfoc       RECORD LIKE sfoc_t.*
DEFINE l_sfoc RECORD  #工單製程變更上站作業資料
       sfocent LIKE sfoc_t.sfocent, #企業編號
       sfocsite LIKE sfoc_t.sfocsite, #營運據點
       sfocdocno LIKE sfoc_t.sfocdocno, #工單單號
       sfoc001 LIKE sfoc_t.sfoc001, #RUN CARD
       sfoc002 LIKE sfoc_t.sfoc002, #項次
       sfoc003 LIKE sfoc_t.sfoc003, #上站作業
       sfoc004 LIKE sfoc_t.sfoc004, #上站製程式
       sfoc900 LIKE sfoc_t.sfoc900, #變更序
       sfoc901 LIKE sfoc_t.sfoc901, #變更類型
       sfoc902 LIKE sfoc_t.sfoc902, #變更日期
       sfoc905 LIKE sfoc_t.sfoc905, #變更理由
       sfoc906 LIKE sfoc_t.sfoc906, #變更備註
       #sfocseq LIKE sfoc_t.sfocseq  #項序 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfocseq LIKE sfoc_t.sfocseq, #項序
       sfocud001 LIKE sfoc_t.sfocud001, #自定義欄位(文字)001
       sfocud002 LIKE sfoc_t.sfocud002, #自定義欄位(文字)002
       sfocud003 LIKE sfoc_t.sfocud003, #自定義欄位(文字)003
       sfocud004 LIKE sfoc_t.sfocud004, #自定義欄位(文字)004
       sfocud005 LIKE sfoc_t.sfocud005, #自定義欄位(文字)005
       sfocud006 LIKE sfoc_t.sfocud006, #自定義欄位(文字)006
       sfocud007 LIKE sfoc_t.sfocud007, #自定義欄位(文字)007
       sfocud008 LIKE sfoc_t.sfocud008, #自定義欄位(文字)008
       sfocud009 LIKE sfoc_t.sfocud009, #自定義欄位(文字)009
       sfocud010 LIKE sfoc_t.sfocud010, #自定義欄位(文字)010
       sfocud011 LIKE sfoc_t.sfocud011, #自定義欄位(數字)011
       sfocud012 LIKE sfoc_t.sfocud012, #自定義欄位(數字)012
       sfocud013 LIKE sfoc_t.sfocud013, #自定義欄位(數字)013
       sfocud014 LIKE sfoc_t.sfocud014, #自定義欄位(數字)014
       sfocud015 LIKE sfoc_t.sfocud015, #自定義欄位(數字)015
       sfocud016 LIKE sfoc_t.sfocud016, #自定義欄位(數字)016
       sfocud017 LIKE sfoc_t.sfocud017, #自定義欄位(數字)017
       sfocud018 LIKE sfoc_t.sfocud018, #自定義欄位(數字)018
       sfocud019 LIKE sfoc_t.sfocud019, #自定義欄位(數字)019
       sfocud020 LIKE sfoc_t.sfocud020, #自定義欄位(數字)020
       sfocud021 LIKE sfoc_t.sfocud021, #自定義欄位(日期時間)021
       sfocud022 LIKE sfoc_t.sfocud022, #自定義欄位(日期時間)022
       sfocud023 LIKE sfoc_t.sfocud023, #自定義欄位(日期時間)023
       sfocud024 LIKE sfoc_t.sfocud024, #自定義欄位(日期時間)024
       sfocud025 LIKE sfoc_t.sfocud025, #自定義欄位(日期時間)025
       sfocud026 LIKE sfoc_t.sfocud026, #自定義欄位(日期時間)026
       sfocud027 LIKE sfoc_t.sfocud027, #自定義欄位(日期時間)027
       sfocud028 LIKE sfoc_t.sfocud028, #自定義欄位(日期時間)028
       sfocud029 LIKE sfoc_t.sfocud029, #自定義欄位(日期時間)029
       sfocud030 LIKE sfoc_t.sfocud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
DEFINE  l_i          LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy

   LET r_success = FALSE
   DECLARE asft801_gen_sfcc CURSOR FOR
    #161109-00085#28-s
    #SELECT * FROM sfcc_t WHERE sfccent = g_enterprise AND sfccsite = g_site
    #SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004 #161109-00085#67 mark
    #161109-00085#67 --s add
    SELECT sfccent,sfccsite,sfccdocno,sfcc001,sfcc002,
           sfcc003,sfcc004,sfccud001,sfccud002,sfccud003,
           sfccud004,sfccud005,sfccud006,sfccud007,sfccud008,
           sfccud009,sfccud010,sfccud011,sfccud012,sfccud013,
           sfccud014,sfccud015,sfccud016,sfccud017,sfccud018,
           sfccud019,sfccud020,sfccud021,sfccud022,sfccud023,
           sfccud024,sfccud025,sfccud026,sfccud027,sfccud028,
           sfccud029,sfccud030
    #161109-00085#67 --e add
      FROM sfcc_t 
     WHERE sfccent = g_enterprise AND sfccsite = g_site
       AND sfccdocno = g_sfca_m.sfcadocno AND sfcc001 = g_sfca_m.sfca001
       AND sfcc002 = p_sfoc002 
       ORDER BY sfcc003,sfcc004
   LET l_i = 1
   #FOREACH asft801_gen_sfcc INTO l_sfcc.*
   FOREACH asft801_gen_sfcc 
   #161109-00085#67 --s mark
   #   INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
   #        l_sfcc.sfcc003,l_sfcc.sfcc004
   #161109-00085#67 --e mark
   #161109-00085#67 --s add
      INTO l_sfcc.sfccent,l_sfcc.sfccsite,l_sfcc.sfccdocno,l_sfcc.sfcc001,l_sfcc.sfcc002,
           l_sfcc.sfcc003,l_sfcc.sfcc004,l_sfcc.sfccud001,l_sfcc.sfccud002,l_sfcc.sfccud003,
           l_sfcc.sfccud004,l_sfcc.sfccud005,l_sfcc.sfccud006,l_sfcc.sfccud007,l_sfcc.sfccud008,
           l_sfcc.sfccud009,l_sfcc.sfccud010,l_sfcc.sfccud011,l_sfcc.sfccud012,l_sfcc.sfccud013,
           l_sfcc.sfccud014,l_sfcc.sfccud015,l_sfcc.sfccud016,l_sfcc.sfccud017,l_sfcc.sfccud018,
           l_sfcc.sfccud019,l_sfcc.sfccud020,l_sfcc.sfccud021,l_sfcc.sfccud022,l_sfcc.sfccud023,
           l_sfcc.sfccud024,l_sfcc.sfccud025,l_sfcc.sfccud026,l_sfcc.sfccud027,l_sfcc.sfccud028,
           l_sfcc.sfccud029,l_sfcc.sfccud030
   #161109-00085#67 --e add
   #161109-00085#28-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfoc.sfocent = g_enterprise 
      LET l_sfoc.sfocsite = g_site
      LET l_sfoc.sfocdocno = l_sfcc.sfccdocno
      LET l_sfoc.sfoc001 = l_sfcc.sfcc001
      LET l_sfoc.sfoc002 = l_sfcc.sfcc002
      LET l_sfoc.sfoc003 = l_sfcc.sfcc003
      LET l_sfoc.sfoc004 = l_sfcc.sfcc004
      LET l_sfoc.sfoc900 = p_sfoa900
      LET l_sfoc.sfoc901 = '1'
      LET l_sfoc.sfocseq = l_i
      #161109-00085#28-s
      #INSERT INTO sfoc_t VALUES l_sfoc.*
      #161109-00085#67 --s mark
      #INSERT INTO sfoc_t(sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,sfoc905,sfoc906,sfocseq) 
      #VALUES (l_sfoc.sfocent,l_sfoc.sfocsite,l_sfoc.sfocdocno,l_sfoc.sfoc001,l_sfoc.sfoc002,
      #        l_sfoc.sfoc003,l_sfoc.sfoc004,l_sfoc.sfoc900,l_sfoc.sfoc901,l_sfoc.sfoc902,
      #        l_sfoc.sfoc905,l_sfoc.sfoc906,l_sfoc.sfocseq)
      #161109-00085#67 --e mark
      #161109-00085#28-e
      #161109-00085#67 --s add
      INSERT INTO sfoc_t (sfocent,sfocsite,sfocdocno,sfoc001,sfoc002,
                          sfoc003,sfoc004,sfoc900,sfoc901,sfoc902,
                          sfoc905,sfoc906,sfocseq,sfocud001,sfocud002,
                          sfocud003,sfocud004,sfocud005,sfocud006,sfocud007,
                          sfocud008,sfocud009,sfocud010,sfocud011,sfocud012,
                          sfocud013,sfocud014,sfocud015,sfocud016,sfocud017,
                          sfocud018,sfocud019,sfocud020,sfocud021,sfocud022,
                          sfocud023,sfocud024,sfocud025,sfocud026,sfocud027,
                          sfocud028,sfocud029,sfocud030)
                  VALUES (l_sfoc.sfocent,l_sfoc.sfocsite,l_sfoc.sfocdocno,l_sfoc.sfoc001,l_sfoc.sfoc002,
                          l_sfoc.sfoc003,l_sfoc.sfoc004,l_sfoc.sfoc900,l_sfoc.sfoc901,l_sfoc.sfoc902,
                          l_sfoc.sfoc905,l_sfoc.sfoc906,l_sfoc.sfocseq,l_sfoc.sfocud001,l_sfoc.sfocud002,
                          l_sfoc.sfocud003,l_sfoc.sfocud004,l_sfoc.sfocud005,l_sfoc.sfocud006,l_sfoc.sfocud007,
                          l_sfoc.sfocud008,l_sfoc.sfocud009,l_sfoc.sfocud010,l_sfoc.sfocud011,l_sfoc.sfocud012,
                          l_sfoc.sfocud013,l_sfoc.sfocud014,l_sfoc.sfocud015,l_sfoc.sfocud016,l_sfoc.sfocud017,
                          l_sfoc.sfocud018,l_sfoc.sfocud019,l_sfoc.sfocud020,l_sfoc.sfocud021,l_sfoc.sfocud022,
                          l_sfoc.sfocud023,l_sfoc.sfocud024,l_sfoc.sfocud025,l_sfoc.sfocud026,l_sfoc.sfocud027,
                          l_sfoc.sfocud028,l_sfoc.sfocud029,l_sfoc.sfocud030)
      #161109-00085#67 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT sfoc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_sfcc.* TO NULL   #清空数组
      LET l_i = l_i + 1
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: #产生制程check in/out资料
# Memo...........:
# Usage..........: CALL asft301_gen_sfod(p_sfod002,p_sfoa900)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asft301_gen_sfod(p_sfod002,p_sfoa900)
DEFINE p_sfod002              LIKE sfod_t.sfod002
DEFINE p_sfoa900              LIKE sfoa_t.sfoa900
DEFINE r_success              LIKE type_t.num5
#161109-00085#28-s
#DEFINE l_sfcd                 RECORD LIKE sfcd_t.*
DEFINE l_sfcd RECORD  #工單製程check in/out專案資料
       sfcdent LIKE sfcd_t.sfcdent, #企業編號
       sfcdsite LIKE sfcd_t.sfcdsite, #營運據點
       sfcddocno LIKE sfcd_t.sfcddocno, #單號
       sfcd001 LIKE sfcd_t.sfcd001, #RUN CARD
       sfcd002 LIKE sfcd_t.sfcd002, #項次
       sfcd003 LIKE sfcd_t.sfcd003, #專案
       sfcd004 LIKE sfcd_t.sfcd004, #型態
       sfcd005 LIKE sfcd_t.sfcd005, #下限
       sfcd006 LIKE sfcd_t.sfcd006, #上限
       sfcd007 LIKE sfcd_t.sfcd007, #預設值
       sfcd008 LIKE sfcd_t.sfcd008, #必要
       #sfcd009 LIKE sfcd_t.sfcd009  #check in/check out #161109-00085#67 mark
       #161109-00085#67 --s add
       sfcd009 LIKE sfcd_t.sfcd009, #check in/check out
       sfcdud001 LIKE sfcd_t.sfcdud001, #自定義欄位(文字)001
       sfcdud002 LIKE sfcd_t.sfcdud002, #自定義欄位(文字)002
       sfcdud003 LIKE sfcd_t.sfcdud003, #自定義欄位(文字)003
       sfcdud004 LIKE sfcd_t.sfcdud004, #自定義欄位(文字)004
       sfcdud005 LIKE sfcd_t.sfcdud005, #自定義欄位(文字)005
       sfcdud006 LIKE sfcd_t.sfcdud006, #自定義欄位(文字)006
       sfcdud007 LIKE sfcd_t.sfcdud007, #自定義欄位(文字)007
       sfcdud008 LIKE sfcd_t.sfcdud008, #自定義欄位(文字)008
       sfcdud009 LIKE sfcd_t.sfcdud009, #自定義欄位(文字)009
       sfcdud010 LIKE sfcd_t.sfcdud010, #自定義欄位(文字)010
       sfcdud011 LIKE sfcd_t.sfcdud011, #自定義欄位(數字)011
       sfcdud012 LIKE sfcd_t.sfcdud012, #自定義欄位(數字)012
       sfcdud013 LIKE sfcd_t.sfcdud013, #自定義欄位(數字)013
       sfcdud014 LIKE sfcd_t.sfcdud014, #自定義欄位(數字)014
       sfcdud015 LIKE sfcd_t.sfcdud015, #自定義欄位(數字)015
       sfcdud016 LIKE sfcd_t.sfcdud016, #自定義欄位(數字)016
       sfcdud017 LIKE sfcd_t.sfcdud017, #自定義欄位(數字)017
       sfcdud018 LIKE sfcd_t.sfcdud018, #自定義欄位(數字)018
       sfcdud019 LIKE sfcd_t.sfcdud019, #自定義欄位(數字)019
       sfcdud020 LIKE sfcd_t.sfcdud020, #自定義欄位(數字)020
       sfcdud021 LIKE sfcd_t.sfcdud021, #自定義欄位(日期時間)021
       sfcdud022 LIKE sfcd_t.sfcdud022, #自定義欄位(日期時間)022
       sfcdud023 LIKE sfcd_t.sfcdud023, #自定義欄位(日期時間)023
       sfcdud024 LIKE sfcd_t.sfcdud024, #自定義欄位(日期時間)024
       sfcdud025 LIKE sfcd_t.sfcdud025, #自定義欄位(日期時間)025
       sfcdud026 LIKE sfcd_t.sfcdud026, #自定義欄位(日期時間)026
       sfcdud027 LIKE sfcd_t.sfcdud027, #自定義欄位(日期時間)027
       sfcdud028 LIKE sfcd_t.sfcdud028, #自定義欄位(日期時間)028
       sfcdud029 LIKE sfcd_t.sfcdud029, #自定義欄位(日期時間)029
       sfcdud030 LIKE sfcd_t.sfcdud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
#161109-00085#28-s
#DEFINE l_sfod                 RECORD LIKE sfod_t.*
DEFINE l_sfod RECORD  #工單製程變更check in/out項目資料
       sfodent LIKE sfod_t.sfodent, #企業編號
       sfodsite LIKE sfod_t.sfodsite, #營運據點
       sfoddocno LIKE sfod_t.sfoddocno, #工單單號
       sfod001 LIKE sfod_t.sfod001, #RUN CARD
       sfod002 LIKE sfod_t.sfod002, #項次
       sfod003 LIKE sfod_t.sfod003, #專案
       sfod004 LIKE sfod_t.sfod004, #型態
       sfod005 LIKE sfod_t.sfod005, #下限
       sfod006 LIKE sfod_t.sfod006, #上限
       sfod007 LIKE sfod_t.sfod007, #預設值
       sfod008 LIKE sfod_t.sfod008, #必要
       sfod900 LIKE sfod_t.sfod900, #變更序
       sfod901 LIKE sfod_t.sfod901, #變更類型
       sfod902 LIKE sfod_t.sfod902, #變更時間
       sfod905 LIKE sfod_t.sfod905, #變更理由
       sfod906 LIKE sfod_t.sfod906, #變更備註
       sfod009 LIKE sfod_t.sfod009, #Check in/out
       #sfodseq LIKE sfod_t.sfodseq  #項序 #161109-00085#67 mark
       #161109-00085#67 --s add
       sfodseq LIKE sfod_t.sfodseq, #項序
       sfodud001 LIKE sfod_t.sfodud001, #自定義欄位(文字)001
       sfodud002 LIKE sfod_t.sfodud002, #自定義欄位(文字)002
       sfodud003 LIKE sfod_t.sfodud003, #自定義欄位(文字)003
       sfodud004 LIKE sfod_t.sfodud004, #自定義欄位(文字)004
       sfodud005 LIKE sfod_t.sfodud005, #自定義欄位(文字)005
       sfodud006 LIKE sfod_t.sfodud006, #自定義欄位(文字)006
       sfodud007 LIKE sfod_t.sfodud007, #自定義欄位(文字)007
       sfodud008 LIKE sfod_t.sfodud008, #自定義欄位(文字)008
       sfodud009 LIKE sfod_t.sfodud009, #自定義欄位(文字)009
       sfodud010 LIKE sfod_t.sfodud010, #自定義欄位(文字)010
       sfodud011 LIKE sfod_t.sfodud011, #自定義欄位(數字)011
       sfodud012 LIKE sfod_t.sfodud012, #自定義欄位(數字)012
       sfodud013 LIKE sfod_t.sfodud013, #自定義欄位(數字)013
       sfodud014 LIKE sfod_t.sfodud014, #自定義欄位(數字)014
       sfodud015 LIKE sfod_t.sfodud015, #自定義欄位(數字)015
       sfodud016 LIKE sfod_t.sfodud016, #自定義欄位(數字)016
       sfodud017 LIKE sfod_t.sfodud017, #自定義欄位(數字)017
       sfodud018 LIKE sfod_t.sfodud018, #自定義欄位(數字)018
       sfodud019 LIKE sfod_t.sfodud019, #自定義欄位(數字)019
       sfodud020 LIKE sfod_t.sfodud020, #自定義欄位(數字)020
       sfodud021 LIKE sfod_t.sfodud021, #自定義欄位(日期時間)021
       sfodud022 LIKE sfod_t.sfodud022, #自定義欄位(日期時間)022
       sfodud023 LIKE sfod_t.sfodud023, #自定義欄位(日期時間)023
       sfodud024 LIKE sfod_t.sfodud024, #自定義欄位(日期時間)024
       sfodud025 LIKE sfod_t.sfodud025, #自定義欄位(日期時間)025
       sfodud026 LIKE sfod_t.sfodud026, #自定義欄位(日期時間)026
       sfodud027 LIKE sfod_t.sfodud027, #自定義欄位(日期時間)027
       sfodud028 LIKE sfod_t.sfodud028, #自定義欄位(日期時間)028
       sfodud029 LIKE sfod_t.sfodud029, #自定義欄位(日期時間)029
       sfodud030 LIKE sfod_t.sfodud030  #自定義欄位(日期時間)030
       #161109-00085#67 --e add
END RECORD
#161109-00085#28-e
DEFINE l_i                    LIKE type_t.num5

   LET r_success = FALSE
   DECLARE asft801_gen_sfod CURSOR FOR
   #161109-00085#28-s
   #SELECT * FROM sfcd_t WHERE sfcdent = g_enterprise AND sfcdsite = g_site
   #SELECT sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,sfcd008,sfcd009 #161109-00085#67 mark
   #161109-00085#67 --s add
   SELECT sfcdent,sfcdsite,sfcddocno,sfcd001,sfcd002,
          sfcd003,sfcd004,sfcd005,sfcd006,sfcd007,
          sfcd008,sfcd009,sfcdud001,sfcdud002,sfcdud003,
          sfcdud004,sfcdud005,sfcdud006,sfcdud007,sfcdud008,
          sfcdud009,sfcdud010,sfcdud011,sfcdud012,sfcdud013,
          sfcdud014,sfcdud015,sfcdud016,sfcdud017,sfcdud018,
          sfcdud019,sfcdud020,sfcdud021,sfcdud022,sfcdud023,
          sfcdud024,sfcdud025,sfcdud026,sfcdud027,sfcdud028,
          sfcdud029,sfcdud030
   #161109-00085#67 --e add
     FROM sfcd_t
    WHERE sfcdent = g_enterprise AND sfcdsite = g_site       
      AND sfcddocno = g_sfca_m.sfcadocno AND sfcd001 = g_sfca_m.sfca001
      AND sfcd002 = p_sfod002
    ORDER BY sfcd003,sfcd004
   LET l_i = -1
   #FOREACH asft801_gen_sfod INTO l_sfcd.*
   FOREACH asft801_gen_sfod 
   #161109-00085#67 --s mark
   #   INTO l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
   #        l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
   #        l_sfcd.sfcd008,l_sfcd.sfcd009
   #161109-00085#67 --e mark
   #161109-00085#67 --s add
     INTO l_sfcd.sfcdent,l_sfcd.sfcdsite,l_sfcd.sfcddocno,l_sfcd.sfcd001,l_sfcd.sfcd002,
          l_sfcd.sfcd003,l_sfcd.sfcd004,l_sfcd.sfcd005,l_sfcd.sfcd006,l_sfcd.sfcd007,
          l_sfcd.sfcd008,l_sfcd.sfcd009,l_sfcd.sfcdud001,l_sfcd.sfcdud002,l_sfcd.sfcdud003,
          l_sfcd.sfcdud004,l_sfcd.sfcdud005,l_sfcd.sfcdud006,l_sfcd.sfcdud007,l_sfcd.sfcdud008,
          l_sfcd.sfcdud009,l_sfcd.sfcdud010,l_sfcd.sfcdud011,l_sfcd.sfcdud012,l_sfcd.sfcdud013,
          l_sfcd.sfcdud014,l_sfcd.sfcdud015,l_sfcd.sfcdud016,l_sfcd.sfcdud017,l_sfcd.sfcdud018,
          l_sfcd.sfcdud019,l_sfcd.sfcdud020,l_sfcd.sfcdud021,l_sfcd.sfcdud022,l_sfcd.sfcdud023,
          l_sfcd.sfcdud024,l_sfcd.sfcdud025,l_sfcd.sfcdud026,l_sfcd.sfcdud027,l_sfcd.sfcdud028,
          l_sfcd.sfcdud029,l_sfcd.sfcdud030
   #161109-00085#67 --e add
   #161109-00085#28-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_sfod.sfodent = g_enterprise 
      LET l_sfod.sfodsite = g_site
      LET l_sfod.sfoddocno = l_sfcd.sfcddocno
      LET l_sfod.sfod001 = l_sfcd.sfcd001
      LET l_sfod.sfod002 = l_sfcd.sfcd002
      LET l_sfod.sfod003 = l_sfcd.sfcd003
      LET l_sfod.sfod004 = l_sfcd.sfcd004
      LET l_sfod.sfod005 = l_sfcd.sfcd005
      LET l_sfod.sfod006 = l_sfcd.sfcd006
      LET l_sfod.sfod007 = l_sfcd.sfcd007
      LET l_sfod.sfod008 = l_sfcd.sfcd008
      LET l_sfod.sfod009 = l_sfcd.sfcd009
      LET l_sfod.sfod900 = p_sfoa900
      LET l_sfod.sfod901 = '1'
      LET l_sfod.sfodseq = l_i
      
      #161109-00085#28-s
      #INSERT INTO sfod_t VALUES l_sfod.*
      #161109-00085#67 --s mark
      #INSERT INTO sfod_t(sfodent,sfodsite,sfoddocno,sfod001,sfod002,sfod003,sfod004,sfod005,sfod006,sfod007,
      #                   sfod008,sfod900,sfod901,sfod902,sfod905,sfod906,sfod009,sfodseq) 
      #VALUES (l_sfod.sfodent,l_sfod.sfodsite,l_sfod.sfoddocno,l_sfod.sfod001,l_sfod.sfod002,
      #        l_sfod.sfod003,l_sfod.sfod004,l_sfod.sfod005,l_sfod.sfod006,l_sfod.sfod007,
      #        l_sfod.sfod008,l_sfod.sfod900,l_sfod.sfod901,l_sfod.sfod902,l_sfod.sfod905,
      #        l_sfod.sfod906,l_sfod.sfod009,l_sfod.sfodseq)
      #161109-00085#67 --e mark
      #161109-00085#28-e
      #161109-00085#67 --s add
      INSERT INTO sfod_t(sfodent,sfodsite,sfoddocno,sfod001,sfod002,
                         sfod003,sfod004,sfod005,sfod006,sfod007,
                         sfod008,sfod900,sfod901,sfod902,sfod905,
                         sfod906,sfod009,sfodseq,sfodud001,sfodud002,
                         sfodud003,sfodud004,sfodud005,sfodud006,sfodud007,
                         sfodud008,sfodud009,sfodud010,sfodud011,sfodud012,
                         sfodud013,sfodud014,sfodud015,sfodud016,sfodud017,
                         sfodud018,sfodud019,sfodud020,sfodud021,sfodud022,
                         sfodud023,sfodud024,sfodud025,sfodud026,sfodud027,
                         sfodud028,sfodud029,sfodud030)
                 VALUES (l_sfod.sfodent,l_sfod.sfodsite,l_sfod.sfoddocno,l_sfod.sfod001,l_sfod.sfod002,
                         l_sfod.sfod003,l_sfod.sfod004,l_sfod.sfod005,l_sfod.sfod006,l_sfod.sfod007,
                         l_sfod.sfod008,l_sfod.sfod900,l_sfod.sfod901,l_sfod.sfod902,l_sfod.sfod905,
                         l_sfod.sfod906,l_sfod.sfod009,l_sfod.sfodseq,l_sfod.sfodud001,l_sfod.sfodud002,
                         l_sfod.sfodud003,l_sfod.sfodud004,l_sfod.sfodud005,l_sfod.sfodud006,l_sfod.sfodud007,
                         l_sfod.sfodud008,l_sfod.sfodud009,l_sfod.sfodud010,l_sfod.sfodud011,l_sfod.sfodud012,
                         l_sfod.sfodud013,l_sfod.sfodud014,l_sfod.sfodud015,l_sfod.sfodud016,l_sfod.sfodud017,
                         l_sfod.sfodud018,l_sfod.sfodud019,l_sfod.sfodud020,l_sfod.sfodud021,l_sfod.sfodud022,
                         l_sfod.sfodud023,l_sfod.sfodud024,l_sfod.sfodud025,l_sfod.sfodud026,l_sfod.sfodud027,
                         l_sfod.sfodud028,l_sfod.sfodud029,l_sfod.sfodud030)
      #161109-00085#67 --e add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT sfod_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_sfcd.* TO NULL   #清空数组
      LET l_i = l_i - 1
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
