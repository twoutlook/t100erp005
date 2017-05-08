#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp442.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-03-10 16:02:24), PR版次:0003(2016-03-29 15:11:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000081
#+ Filename...: axrp442
#+ Description: 沖帳會計分錄批次還原作業
#+ Creator....: 02114(2014-03-10 00:00:00)
#+ Modifier...: 02114 -SD/PR- 07959
 
{</section>}
 
{<section id="axrp442.global" >}
#應用 i00 樣板自動產生(Version:7)
#add-point:填寫註解說明
#160318-00005#52 2016/03/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable)
{<Module define>}

#單頭 type 宣告
 TYPE type_g_xrda_m RECORD
       xrdald        LIKE xrda_t.xrdald,
       xrdald_desc   LIKE type_t.chr80,
       glaacomp      LIKE glaa_t.glaacomp,
       glaacomp_desc LIKE type_t.chr80
       END RECORD

#模組變數(Module Variables)
DEFINE g_xrda_m        type_g_xrda_m
DEFINE g_xrda_m_t      type_g_xrda_m                #備份舊值
   DEFINE g_xrdald_t LIKE xrda_t.xrdald
DEFINE g_xrdadocno_t LIKE xrda_t.xrdadocno


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
      b_xrda014   LIKE xrda_t.xrda014,
      b_xrdadocno LIKE xrda_t.xrdadocno,
      b_xrdadocdt LIKE xrda_t.xrdadocdt,
      b_xrda004   LIKE type_t.chr100,
      b_xrda005   LIKE type_t.chr100,
      b_xrdald    LIKE xrda_t.xrdald,
      b_xrda006   LIKE xrda_t.xrda006
         #,rank           LIKE type_t.num10
      END RECORD

#無單頭append欄位定義

DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING                        #組 sql 用
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
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

#快速搜尋用
DEFINE g_searchcol           STRING             #查詢欄位代碼
DEFINE g_searchstr           STRING             #查詢欄位字串
DEFINE g_order               STRING             #查詢排序模式

#Browser用
DEFINE g_current_idx         LIKE type_t.num5   #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num5   #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10  #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num5   #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num5   #Browser 總筆數(所有資料)
DEFINE g_tmp_page            LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_chk                 BOOLEAN
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_wc1          STRING 
DEFINE g_wc2          STRING
DEFINE g_wc3          STRING
DEFINE g_xrdald       LIKE xrda_t.xrdald
DEFINE g_glalld       LIKE glal_t.glalld
DEFINE g_glaa121      LIKE glaa_t.glaa121
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
{</section>}
 
{<section id="axrp442.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   
   #end add-point    
   #add-point:main段define(客製用)
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化
   
   #end add-point
 
   #add-point:SQL_define
   LET g_forupd_sql = "SELECT xrdald,'',xrdacomp,xrdadocno,xrdadocdt,xrda004,xrda014 FROM xrda_t WHERE xrdaent= ? AND xrdadocno=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE axrp442_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp442 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrp442_init()
 
      #進入選單 Menu (='N')
      CALL axrp442_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_axrp442
   END IF
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axrp442.other_function" readonly="Y" >}
#add-point:自定義元件(Function)

PRIVATE FUNCTION axrp442_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point
   DEFINE l_success     LIKE type_t.num5

   LET g_main_hidden = 0


   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   #add-point:畫面資料初始化
   {<point name="init.init" />}
   #end add-point
   
   #获取预设主帐别
   CALL s_ld_bookno()  RETURNING l_success,g_glalld
   IF l_success = FALSE THEN
      RETURN 
   END IF 

   #CALL axrp442_default_search()

END FUNCTION

PRIVATE FUNCTION axrp442_ui_dialog()
   {<Local define>}
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE l_flag   LIKE type_t.num5

   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1


   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE li_exit = FALSE
      
      IF NOT cl_null(g_argv[1])      AND NOT cl_null(g_argv[02]) 
         AND NOT cl_null(g_argv[03]) AND NOT cl_null(g_argv[04]) 
         AND NOT cl_null(g_argv[05]) AND NOT cl_null(g_argv[06]) 
         AND NOT cl_null(g_argv[07]) AND NOT cl_null(g_argv[08])
         THEN 
         CALL axrp442_default_search()
      ELSE
         CALL axrp442_construct()
      END IF
      IF INT_FLAG THEN
         LET INT_FLAG = 0      
         EXIT WHILE
      END IF
 
      CALL axrp442_browser_fill(g_wc,"")

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)

            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_idx = 0 THEN
                  LET g_current_idx = 1
               END IF
               LET g_current_row = g_current_idx  #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont()

               #當每次點任一筆資料都會需要用到
               #CALL axrp442_fetch("")

            ON EXPAND (g_row_index)
               #樹展開
               #CALL axrp442_browser_expand(g_row_index)
               #LET g_browser[g_row_index].b_isExp = 1

            ON COLLAPSE (g_row_index)
               #樹關閉

         END DISPLAY


         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point

         BEFORE DIALOG

            IF cl_null(g_argv[1]) THEN 
               DISPLAY g_xrda_m.xrdald  TO xrdald
               CALL axrp442_xrdald_desc(g_xrda_m.xrdald)
            END IF

         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
            {<point name="ui_dialog.after_dialog"/>}
            #end add-point
         
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION close
            LET li_exit = TRUE
            EXIT DIALOG


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

         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段
            CALL axrp442_construct()
            CLEAR FORM
            INITIALIZE g_xrda_m.* TO NULL
            LET g_xrda_m.xrdald = g_glalld
            CALL axrp442_xrdald_desc(g_xrda_m.xrdald)
            #end add-point

      ON ACTION reduction

         LET g_action_choice="reduction"
         IF cl_auth_chk_act("reduction") THEN
            LET g_success = 'Y'
            CALL axrp442_p() 
            IF g_success = 'N' THEN
               CALL s_transaction_end('N','0')
               #CALL cl_err_showmsg() 
               CALL cl_err_collect_show()     
               CALL cl_ask_end2(2) RETURNING l_flag
            ELSE
               CALL s_transaction_end('Y','0')
               #CALL cl_err_showmsg() 
               CALL cl_err_collect_show()     
               CALL cl_ask_end2(1) RETURNING l_flag
            END IF
           
            IF l_flag THEN
               LET g_argv[1]  = ''
               LET g_argv[02] = ''
               LET g_argv[03] = ''
               LET g_argv[04] = ''
               LET g_argv[05] = ''
               LET g_argv[05] = ''
               LET g_argv[07] = ''
               LET g_argv[08] = ''
               CONTINUE WHILE 
            ELSE   
               CLOSE WINDOW w_axrp442
               EXIT WHILE 
            END IF
         END IF

      ON ACTION link  
          IF NOT cl_null(g_browser[g_current_idx].b_xrda014) AND cl_null(g_browser[g_current_idx].b_xrdadocno) THEN 
             CALL cl_cmdrun("aglt310  '"||g_browser[g_current_idx].b_xrda014||"'")
          END IF          
          
          IF NOT cl_null(g_browser[g_current_idx].b_xrdadocno) THEN 
             CALL cl_cmdrun("axrt400 '"||g_xrda_m.xrdald||"' '"||g_browser[g_current_idx].b_xrdadocno||"'")
          END IF
          
      ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL axrp442_construct()
            END IF
          


         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"

      END DIALOG

   END WHILE

END FUNCTION

PRIVATE FUNCTION axrp442_browser_fill(ps_wc,ps_page_action)
   {<Local define>}
   DEFINE ps_wc              STRING
   DEFINE ps_page_action     STRING
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num5
   DEFINE li_idx2            LIKE type_t.num5
   DEFINE li_lv              LIKE type_t.num10
   DEFINE pi_id              LIKE type_t.num10
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004 
   DEFINE l_xrda004_desc     LIKE type_t.chr100 
   DEFINE l_xrda005_desc     LIKE type_t.chr100 
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point


   CALL g_browser.clear()

   LET li_idx = 1
   LET g_browser[li_idx].b_pid     = 0
   LET g_browser[li_idx].b_id      = 0, ".", 1 USING "<<<"
   LET g_browser[li_idx].b_exp     = TRUE
   LET g_browser[li_idx].b_expcode = 1
   LET g_browser[li_idx].b_hasC    = TRUE
   #LET g_browser[li_idx].b_show    = ''
   CALL axrp442_desc_show(1)
   LET li_idx = li_idx + 1

   LET ls_sql = " SELECT UNIQUE xrda014 ",
                " FROM xrda_t,glap_t ",
                " WHERE xrdaent = '" ||g_enterprise|| "' AND ", g_wc,
                "   AND xrda014 IS NOT NULL",
                "   AND glapdocno = xrda014",
                "   AND xrdald = '",g_xrda_m.xrdald,"'",
                " ORDER BY xrda014"

   PREPARE browse_pre FROM ls_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   FOREACH browse_cur INTO g_browser[li_idx].b_xrda014

      LET g_browser[li_idx].b_pid     = g_browser[1].b_id
      LET g_browser[li_idx].b_id      = g_browser[1].b_id, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = TRUE
      LET g_browser[li_idx].b_isExp   = TRUE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_xrda014
      CALL axrp442_desc_show(li_idx)
      LET li_idx = li_idx + 1

      
      LET ls_sql = " SELECT UNIQUE xrda014,xrdadocno,xrdadocdt,xrda004,xrda005,xrdald,xrda006 ",
                   "   FROM xrda_t ",
                   #"  WHERE xrdaent = '" ||g_enterprise|| "' AND ", g_wc,
                   "  WHERE xrdaent = '" ||g_enterprise|| "' ", 
                   "    AND xrda014 = ? ",
                   "  ORDER BY xrda014"
   
      #LET li_lv = g_browser[pi_id].b_expcode
      LET li_lv = g_browser[li_idx].b_expcode
   
      PREPARE leaf_pre FROM ls_sql
      DECLARE leaf_cur CURSOR FOR leaf_pre
      OPEN leaf_cur USING g_browser[li_idx-1].b_xrda014
      
      LET li_idx2 = li_idx
      CALL g_browser.insertElement(g_cnt)
      FOREACH leaf_cur INTO g_browser[li_idx2].b_xrda014,g_browser[li_idx2].b_xrdadocno,g_browser[li_idx2].b_xrdadocdt,
                            g_browser[li_idx2].b_xrda004,g_browser[li_idx2].b_xrda005,g_browser[li_idx2].b_xrdald,
                            g_browser[li_idx2].b_xrda006
   
         LET g_browser[li_idx2].b_pid     = g_browser[li_idx-1].b_id
         LET g_browser[li_idx2].b_id      = g_browser[li_idx-1].b_id , ".", li_idx2 USING "<<<"
         LET g_browser[li_idx2].b_exp     = TRUE
         LET g_browser[li_idx2].b_expcode = 2
         LET g_browser[li_idx2].b_hasC    = FALSE
         LET g_browser[li_idx2].b_show = g_browser[li_idx2].b_xrdadocno
         CALL axrp442_desc_show(li_idx2)
         
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_browser[li_idx2].b_xrda004
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET l_xrda004_desc = '', g_rtn_fields[1] , ''
         LET g_browser[li_idx2].b_xrda004 = g_browser[li_idx2].b_xrda004,' ',l_xrda004_desc
         
         SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_browser[li_idx2].b_xrda005
   
         INITIALIZE g_ref_fields TO NULL 
         IF g_browser[li_idx2].b_xrda006 IS NOT NULL AND l_pmaa004 = '2'THEN 
            LET g_ref_fields[1] = g_browser[li_idx2].b_xrda006
            CALL ap_ref_array2(g_ref_fields,"SELECT pmak003 FROM pmak_t WHERE pmakent='"||g_enterprise||"' AND pmak001=? ","") RETURNING g_rtn_fields   
         ELSE
            LET g_ref_fields[1] = g_browser[li_idx2].b_xrda005
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         END IF
         LET l_xrda005_desc = '', g_rtn_fields[1] , ''
         
         LET g_browser[li_idx2].b_xrda005 = g_browser[li_idx2].b_xrda005,' ',l_xrda005_desc
         

         
         
         LET li_idx2 = li_idx2 + 1
         CALL g_browser.insertElement(li_idx2)
         
         IF li_idx2 > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
   
#      CALL g_browser.deleteElement(li_idx2)
      
      LET li_idx = g_browser.getLength()

      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH
   LET g_error_show = 0

   CALL g_browser.deleteElement(g_browser.getLength())

   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數

   #CALL axrp442_fetch("")

   FREE browse_pre

END FUNCTION

PRIVATE FUNCTION axrp442_browser_expand(pi_id)
   {<Local define>}
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_type_list     STRING
   DEFINE ls_sql           STRING
   {</Local define>}
   #add-point:browser_expand段define
   {<point name="browser_expand.define"/>}
   #end add-point

   #已經展開過
   IF g_browser[pi_id].b_isExp = TRUE THEN
      RETURN
   END IF

   #leaf展開
   IF g_browser[pi_id].b_expcode = (2-1) THEN
      #CALL axrp442_browser_expand_leaf(pi_id)
      RETURN
   END IF

   LET li_lv = g_browser[pi_id].b_expcode
   LET g_browser[pi_id].b_isExp = TRUE

   CASE li_lv
      WHEN 1
         LET ls_wc = " AND xrda014 = '",g_browser[pi_id].b_xrda014,"' "
         LET ls_type_list = "xrda014"
                            #,","

      WHEN 2
         LET ls_wc = " AND xrda014 = '", g_browser[pi_id].b_xrda014, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
         LET ls_type_list = "xrda014"
                            #,","
                            #,","

      WHEN 3
         LET ls_wc = " AND xrda014 = '", g_browser[pi_id].b_xrda014, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
         LET ls_type_list = "xrda014"
                            #,","
                            #,","
                            #,","

      WHEN 4
         LET ls_wc = " AND xrda014 = '", g_browser[pi_id].b_xrda014, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
         LET ls_type_list = "xrda014"
                            #,","
                            #,","
                            #,","
                            #,","

      WHEN 5
         LET ls_wc = " AND xrda014 = '", g_browser[pi_id].b_xrda014, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
                     #," AND  = '", g_browser[pi_id].b_, "'"
         LET ls_type_list = "xrda014"
                            #,","
                            #,","
                            #,","
                            #,","
                            #,","
   END CASE

   LET ls_sql = " SELECT UNIQUE   ", ls_type_list,
                " FROM xrda_t ",
                "  ",
                "  ",
                " WHERE xrdaent = '" ||g_enterprise|| "' AND ", g_wc, ls_wc

   LET li_lv = g_browser[pi_id].b_expcode

   #add-point:browser_expand段before prepare
   {<point name="browser_expand.before_prepare"/>}
   #end add-point

   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre

   LET li_idx = pi_id + 1
   CALL g_browser.insertElement(li_idx)
   FOREACH expand_cur INTO g_browser[li_idx].b_xrda014
      LET g_browser[li_idx].b_pid     = g_browser[pi_id].b_id
      LET g_browser[li_idx].b_id      = g_browser[pi_id].b_id , ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = li_lv + 1
      LET g_browser[li_idx].b_hasC    = TRUE
      CASE li_lv
         WHEN 1
            #LET g_browser[li_idx].b_show = g_browser[li_idx].b_
         WHEN 2
            #LET g_browser[li_idx].b_show = g_browser[li_idx].b_
         WHEN 3
            #LET g_browser[li_idx].b_show = g_browser[li_idx].b_
         WHEN 4
            #LET g_browser[li_idx].b_show = g_browser[li_idx].b_
         WHEN 5
            #LET g_browser[li_idx].b_show = g_browser[li_idx].b_
      END CASE
      CALL axrp442_desc_show(li_idx)
      LET li_idx = li_idx + 1
      CALL g_browser.insertElement(li_idx)
   END FOREACH

   CALL g_browser.deleteElement(li_idx)

   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數

END FUNCTION

PRIVATE FUNCTION axrp442_desc_show(pi_ac)
   {<Local define>}
   DEFINE pi_ac   LIKE type_t.num5
   DEFINE li_tmp  LIKE type_t.num5
   {</Local define>}
   #add-point:desc_show段define
   {<point name="desc_show.define"/>}
   #end add-point

   LET li_tmp = g_cnt
   LET g_cnt = pi_ac

   #add-point:desc_show段desc處理
   IF g_cnt = 1 THEN 
      LET g_browser[g_cnt].b_show = cl_getmsg('axr-00075',g_lang)
   END IF 
   
   
   #end add-point
   LET g_cnt = li_tmp

END FUNCTION

PRIVATE FUNCTION axrp442_construct()
   {<Local define>}
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   CLEAR FORM
   INITIALIZE g_xrda_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1

   LET g_qryparam.state = "c"

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_xrda_m.xrdald    
         BEFORE INPUT
            LET g_xrda_m.xrdald = g_glalld
        
         BEFORE FIELD xrdald
            CALL axrp442_xrdald_desc(g_xrda_m.xrdald)
         
         AFTER FIELD xrdald
            CALL axrp442_xrdald_desc(g_xrda_m.xrdald)
            IF NOT cl_null(g_xrda_m.xrdald) THEN 
               IF NOT ap_chk_isExist(g_xrda_m.xrdald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? ",'agl-00016',1) THEN 
                  LET g_xrda_m.xrdald = ''
                  NEXT FIELD CURRENT
               END IF 
#               IF NOT ap_chk_isExist(g_xrda_m.xrdald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'agl-00051',1) THEN  #160318-00005#52  mark
               IF NOT ap_chk_isExist(g_xrda_m.xrdald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND glaastus = 'Y' ",'sub-01302','agli010') THEN  #160318-00005#52  add
                  LET g_xrda_m.xrdald = ''
                  NEXT FIELD CURRENT
               END IF 
               IF NOT ap_chk_isExist(g_xrda_m.xrdald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = ? AND (glaa014 = 'Y' OR glaa008 = 'Y') AND glaastus = 'Y' ",'axr-00021',1) THEN 
                  LET g_xrda_m.xrdald = ''
                  NEXT FIELD CURRENT
               END IF 
               IF NOT s_ld_chk_authorization(g_user,g_xrda_m.xrdald) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_xrda_m.xrdald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrda_m.xrdald = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_xrdald = g_xrda_m.xrdald
            
         ON ACTION controlp INFIELD xrdald
          INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrda_m.xrdald      #給予default值
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL  q_authorised_ld()                                  #呼叫開窗
            LET g_xrda_m.xrdald = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_xrda_m.xrdald TO xrdald              #顯示到畫面上
            CALL axrp442_xrdald_desc(g_xrda_m.xrdald)
            NEXT FIELD xrdald                              #返回原欄位  
            
         AFTER INPUT

      END INPUT  
       
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON xrdasite,xrda003,xrdadocno,xrdadocdt,xrda004,xrda014,glapcrtid

         BEFORE CONSTRUCT
            #CALL cl_qbe_init()
           
         #----<<xrdasite>>----           
         ON ACTION controlp INFIELD xrdasite
	       INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	       LET g_qryparam.reqry = FALSE
            CALL q_xrah002_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrdasite  #顯示到畫面上  
            NEXT FIELD xrdasite                     #返回原欄位  
        
        #----<<xrda003>>----
        ON ACTION controlp INFIELD xrda003
	       INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	       LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrda003  #顯示到畫面上  
            NEXT FIELD xrda003                     #返回原欄位 

         #----<<xrdadocno>>----
         ON ACTION controlp INFIELD xrdadocno
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrdald = '",g_xrda_m.xrdald,"'",
                                   "   AND xrdastus = 'Y'",
                                   "   AND xrda014 IS NOT NULL"
            CALL q_xrdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrdadocno  #顯示到畫面上

            NEXT FIELD xrdadocno                     #返回原欄位
            
         ON ACTION controlp INFIELD xrda004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 = '2' OR pmaa002 = '3'"
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrda004  #顯示到畫面上

            NEXT FIELD xrda004                     #返回原欄位 


         ON ACTION controlp INFIELD xrda014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrdald = '",g_xrda_m.xrdald,"'"
            CALL q_xrda014()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrda014  #顯示到畫面上

            NEXT FIELD xrda014                     #返回原欄位 

         #----<<glapcrtid>>----
         ON ACTION controlp INFIELD glapcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapcrtid  #顯示到畫面上

            NEXT FIELD glapcrtid                     #返回原欄位

      END CONSTRUCT
       

  
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

   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("", "")
   #LET g_wc = g_wc1," AND ",g_wc2," AND ",g_wc3

END FUNCTION

PRIVATE FUNCTION axrp442_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("xrdald,xrdadocno",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axrp442_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd LIKE type_t.chr1
   {</Local define>}

   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("xrdald,xrdadocno",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION axrp442_default_search()
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
      LET ls_wc = ls_wc, " xrdald = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xrdasite = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xrda003 = '", g_argv[03], "' AND "
   END IF

   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xrdadocno = '", g_argv[04], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xrdadocdt = '", g_argv[05], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xrda004 = '", g_argv[06], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xrda014 = '", g_argv[07], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " glapcrtid = '", g_argv[08], "' AND "
   END IF
   
   LET g_xrda_m.xrdald = g_argv[1]
   
   DISPLAY g_argv[1]  TO xrdald
   CALL axrp442_xrdald_desc(g_argv[1])
   DISPLAY g_argv[02] TO xrdasite
   DISPLAY g_argv[03] TO xrda003
   DISPLAY g_argv[04] TO xrdadocno
   DISPLAY g_argv[05] TO xrdadocdt
   DISPLAY g_argv[06] TO xrda004
   DISPLAY g_argv[07] TO xrda014
   DISPLAY g_argv[08] TO glapcrtid

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
# 帳別帶值
PRIVATE FUNCTION axrp442_xrdald_desc(p_xrdald)
   DEFINE p_xrdald         LIKE xrda_t.xrdald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xrdald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrda_m.xrdald_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xrda_m.xrdald_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xrdald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa121 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_xrda_m.glaacomp = g_rtn_fields[1]
   LET g_glaa121 = g_rtn_fields[2]
   DISPLAY BY NAME g_xrda_m.glaacomp

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrda_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrda_m.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xrda_m.glaacomp_desc
   
   
END FUNCTION
# 批處理邏輯
PRIVATE FUNCTION axrp442_p()
   DEFINE l_xrda014          LIKE xrda_t.xrda014
   DEFINE l_xrdadocno        LIKE xrda_t.xrdadocno
   DEFINE l_glapstus         LIKE glap_t.glapstus
   DEFINE l_glapdocdt        LIKE glap_t.glapdocdt
   DEFINE l_wc               STRING
   DEFINE l_success          LIKE type_t.num5
   
   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   
   LET g_sql = " SELECT UNIQUE xrda014,xrdadocno ",
                "  FROM xrda_t,glap_t ",
                " WHERE xrdaent = '",g_enterprise,"' AND ", g_wc,
                "   AND xrda014 IS NOT NULL",
                "   AND glapdocno = xrda014 ",
                "   AND xrdald = '",g_xrda_m.xrdald,"'",
                " ORDER BY xrda014"
   PREPARE axrp442_pre FROM g_sql
   DECLARE axrp442_cur CURSOR FOR axrp442_pre
   
   FOREACH axrp442_cur INTO l_xrda014,l_xrdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      SELECT glapstus,glapdocdt INTO l_glapstus,l_glapdocdt
        FROM glap_t
       WHERE glapent = g_enterprise
         AND glapld = g_xrda_m.xrdald
         AND glapdocno = l_xrda014
         
      IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN 
         #CALL cl_errmsg(l_xrdadocno,l_xrda014,'','axr-00076',1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_xrdadocno,l_xrda014
         LET g_errparam.code   = 'axr-00076'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N' 
      END IF 
      
      DELETE FROM glap_t 
       WHERE glapent = g_enterprise
         AND glapld = g_xrda_m.xrdald
         AND glapdocno = l_xrda014 
         
      
      IF SQLCA.SQLCODE THEN
         #CALL cl_errmsg('DELETE glap_t',l_xrda014,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'DELETE glap_t',l_xrda014
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      
      #IF NOT s_aooi200_del_docno(l_xrda014,l_glapdocdt) THEN
      #   CALL s_transaction_end('N','0')
      #   LET g_success = 'N' 
      #   EXIT FOREACH
      #END IF
      
      DELETE FROM glaq_t 
       WHERE glaqent = g_enterprise
         AND glaqld = g_xrda_m.xrdald
         AND glaqdocno = l_xrda014 
      
      IF SQLCA.SQLCODE THEN
         #CALL cl_errmsg('DELETE glaq_t',l_xrda014,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'DELETE glaq_t',l_xrda014
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      
      IF g_glaa121 = 'Y' THEN 
         LET l_wc = "glgadocno = '",l_xrdadocno,"'"
         CALL s_pre_voucher_upd('AR','R20',g_xrda_m.xrdald,'','','',l_wc) RETURNING l_success
         
         IF l_success = FALSE THEN 
            LET g_success = 'N'
         END IF
      END IF
      
      UPDATE xrda_t SET xrda014 = NULL
       WHERE xrdaent = g_enterprise
         AND xrdald = g_xrda_m.xrdald
         AND xrda014 = l_xrda014 
         
      IF SQLCA.SQLCODE THEN
         #CALL cl_errmsg('update xrda_t',l_xrdadocno,'',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'update xrda_t',l_xrdadocno
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      END IF
      
   END FOREACH 
   
END FUNCTION

#end add-point
 
{</section>}
 
