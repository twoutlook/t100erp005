#+ Version..: T6-ERP-1.00.00 Build-000013
#+ 
#+ Filename...: adzi230
#+ Buildtype..: 
#+ Memo.......: SQL語句範例維護作業
# Modify.........: 2014/04/15 by madey mark掉相關文件cl_del_doc
#                  2014/08/27 by madey mark cl_showmsg
#                  2014/11/18 by madey mark CONNECT 
#                  2015/04/02 by Hiko:調整畫面
#                  2015/04/23 by Hiko:dzej003回歸到dzejl004

IMPORT JAVA java.lang.String 

IMPORT os

SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 

#單頭 type 宣告
PRIVATE TYPE type_g_dzej_m RECORD
   dzej001 LIKE dzej_t.dzej001, 
   dzej002 LIKE dzej_t.dzej002, 
   dzej003 LIKE dzejl_t.dzejl004, 
   dzej004 LIKE dzej_t.dzej004 
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_dzej_m      type_g_dzej_m
DEFINE g_dzej_m_t    type_g_dzej_m             #備份舊值
DEFINE g_dzej001_t   LIKE dzej_t.dzej001       #Key值備份#key2
DEFINE g_dzej002_t   LIKE dzej_t.dzej002       #Key值備份#key3
#DEFINE g_dzej003_t   LIKE dzej_t.dzej003       #Key值備份
DEFINE g_browser     DYNAMIC ARRAY OF RECORD   #資料瀏覽之欄位  
       b_dzej001     LIKE dzej_t.dzej001,
       b_dzej002     LIKE dzej_t.dzej002,
       b_dzej003     LIKE dzejl_t.dzejl004  
      END RECORD 
          
#無單頭append欄位定義
 
DEFINE g_wc                  STRING             #儲存 user 的查詢條件  
DEFINE g_sql                 STRING             #組 sql 用 
DEFINE g_forupd_sql          STRING             #SELECT ... FOR UPDATE  SQL    
DEFINE g_before_input_done   LIKE type_t.num5   #判斷是否已執行BeforeInput指令 
DEFINE g_cnt                 LIKE type_t.num10   
DEFINE g_jump                LIKE type_t.num10  #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5   #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num5   #單身筆數                         
DEFINE l_ac                  LIKE type_t.num5   #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog          #Current Dialog     
DEFINE gwin_curr             ui.Window          #Current Window
DEFINE gfrm_curr             ui.Form            #Current Form
DEFINE g_pagestart           LIKE type_t.num5   #page起始筆數
DEFINE g_page_action         STRING             #page action
DEFINE g_header_hidden       LIKE type_t.num5   #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5   #隱藏工作Panel
DEFINE g_page                STRING             #第幾頁
DEFINE g_current_sw          BOOLEAN            #Browser所在筆數用開關
DEFINE g_ch                  base.Channel       #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列

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
DEFINE g_prog_id             LIKE type_t.chr18
DEFINE g_dzej001             LIKE dzej_t.dzej001
DEFINE g_dzejl001             LIKE dzejl_t.dzejl001

 
#+ 作業開始 
MAIN 
   #Begin:modify by Hiko
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING   
   #End

   CALL cl_tool_init()

   LET g_prog_id = ARG_VAL(2)

   IF g_prog_id = "adzi220" THEN
      LET g_dzej001 = "verify_sql_sample"
      #LET g_dzejl001 = "sql_sample2" #r.v SQL範例的多語言
      LET g_dzejl001 = g_dzej001 #r.v SQL範例的多語言 #2015/04/23 by Hiko
   END IF

   IF g_prog_id = "adzi210" THEN
      LET g_dzej001 = "qry_sql_sample"
      #LET g_dzejl001 = "sql_sample" #r.q SQL範例的多語言
      LET g_dzejl001 = g_dzej001 #r.q SQL範例的多語言 #2015/04/23 by Hiko
   END IF

   IF g_prog_id IS NULL THEN
      DISPLAY "[Hint]:Please execute adzi230 using adzi210 or adzi220!\n",
              "       For example :\n",
              "           r.r adzi230 adzi210 --> for sql sample of adzi210\n",
              "           r.r adzi230 adzi220 --> for sql sample of adzi220"
      RETURN
   END IF
   
   #LOCK CURSOR (identifier)
   LET g_forupd_sql = "SELECT dzej001,dzej002,dzej004 FROM dzej_t WHERE dzej001 = ? AND dzej002 = ? FOR UPDATE" #2015/04/23 by Hiko:移除dzej003的''
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)              #轉換不同資料庫語法
   DECLARE adzi230_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR

   LET g_forupd_sql = "SELECT dzejl004 FROM dzejl_t WHERE dzejl001 = '",g_dzejl001,"' AND dzejl002 = ? AND dzejl003 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE dzejl_cl CURSOR FROM g_forupd_sql

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi230 WITH FORM cl_ap_formpath("adz",g_prog)
 
   CLOSE WINDOW screen

   CALL adzi230_init()   
   
   #Begin:modify by Hiko
   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET lf_form = lw_window.getForm()
   LET ls_4tb_path = os.Path.join(os.Path.join(ls_cfg_path, "4tb"), "toolbar_designer.4tb")
   CALL lf_form.loadToolBar(ls_4tb_path)
   #End

   #進入選單 Menu (="N")
   CALL adzi230_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_adzi230
      
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi230_init()
   CALL adzi230_default_search()
END FUNCTION
 
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi230_ui_dialog() 
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_wc    LIKE type_t.chr200
   
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
 
   WHILE li_exit = FALSE
      CALL adzi230_browser_fill(g_wc,"")
      
      IF g_main_hidden THEN
         CALL cl_navigator_setting(g_current_idx, g_current_cnt)
         #還原為原本指定筆數
         LET g_current_idx = g_current_row
 
         #當每次點任一筆資料都會需要用到  
         IF g_browser_cnt > 0 THEN
            CALL adzi230_fetch("")   
         END IF               
         
         MENU
           #ON ACTION exit
           #   LET g_action_choice="exit"
           #   LET INT_FLAG = FALSE
           #   LET li_exit = TRUE
           #   EXIT MENU 
            
            ON ACTION close
               LET li_exit = TRUE
               EXIT MENU
            
            ON ACTION insert
               LET g_action_choice="insert"
               IF cl_chk_act_auth() THEN 
                  CALL adzi230_insert()
    
                   EXIT MENU
               END IF

            ON ACTION query
               LET g_action_choice="query"
               IF cl_chk_act_auth() THEN 
                  CALL adzi230_query()
    
                   EXIT MENU
               END IF
    
            ON ACTION delete
               LET g_action_choice="delete"
               IF cl_chk_act_auth() THEN 
                  CALL adzi230_delete()
    
                   EXIT MENU
               END IF

            ON ACTION modify
               LET g_action_choice="modify"
               IF cl_chk_act_auth() THEN 
                  CALL adzi230_modify()
    
                   EXIT MENU
               END IF

            ON ACTION reproduce
               LET g_action_choice="reproduce"
               IF cl_chk_act_auth() THEN 
                  CALL adzi230_reproduce()
    
                   EXIT MENU
               END IF
 
            #主選單用ACTION
            &include "main_menu.4gl"
            
            #交談指令共用ACTION
            &include "common_action.4gl"
         END MENU
      ELSE
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
                  CALL adzi230_fetch("")      
                  
            END DISPLAY
         
            BEFORE DIALOG
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #LET g_page = "first" 
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LEt g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
         
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL adzi230_fetch("")   
               END IF               

         ON ACTION close
            LET li_exit = TRUE
            EXIT DIALOG

         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_chk_act_auth() THEN 
               CALL adzi230_insert()
 
               EXIT DIALOG
            END IF
 
         ON ACTION query
            LET g_action_choice="query"
            IF cl_chk_act_auth() THEN 
               CALL adzi230_query()
 
               EXIT DIALOG
            END IF

         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_chk_act_auth() THEN 
               CALL adzi230_delete()
 
               EXIT DIALOG
            END IF

         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_chk_act_auth() THEN 
               CALL adzi230_modify()
 
               EXIT DIALOG
            END IF

         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_chk_act_auth() THEN 
               CALL adzi230_reproduce()
 
               EXIT DIALOG
            END IF

            #主選單用ACTION
            &include "main_menu.4gl"
            
            #交談指令共用ACTION
            &include "common_action.4gl"
         END DIALOG 
      END IF
   END WHILE
END FUNCTION 
 
 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzi230_browser_search(p_type)
   DEFINE p_type      LIKE type_t.chr10
   DEFINE li_wc       STRING
   DEFINE l_str_buf  base.StringBuffer

   LET l_str_buf = base.StringBuffer.create()
   CALL l_str_buf.append(g_searchstr)

     
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol="0" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00001"
      LET g_errparam.extend = "searchcol:"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   
   IF NOT cl_null(g_searchstr) THEN
      #解決"_"字元會被SQL當作"%的情況",將其當作跳脫字元來處理
      IF l_str_buf.getIndexOf("_",1) THEN
         CALL l_str_buf.replace("_","#_",0) #將"_"字元前面加入自訂跳脫字元"#"的符號
         LET li_wc = " lower(", g_searchcol, ") LIKE '%", l_str_buf.toString(), "%' escape '#'"#若搜尋的字串含有"_",將其當作跳脫字元
      ELSE
         LET li_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      END IF
   
      LET li_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET li_wc = li_wc.toLowerCase()
   ELSE
      LET li_wc = " 1=1 "
   END IF         
   
   LET li_wc = li_wc, " ORDER BY dzej001"
   
   LET g_wc = li_wc
   
   CALL adzi230_browser_fill(li_wc,"first")

   RETURN TRUE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi230_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   
   CLEAR FORM
   INITIALIZE g_dzej_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "to_number(dzej002)" #cch:to do 因應不同的資料庫可能會有不同的函式
   ELSE
      #LET l_searchcol = g_searchcol
      LET l_searchcol = "to_number(dzej002)"
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF

   LET g_sql = "SELECT COUNT(*) FROM dzej_t WHERE ", 
                p_wc CLIPPED ," AND dzej001 = '",g_dzej001,"' " #cch

                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   LET g_wc = p_wc
   
   IF ps_page_action = "first" OR
      ps_page_action = "prev"  OR
      ps_page_action = "next"  OR
      ps_page_action = "last"  THEN
      LET g_page_action = ps_page_action
   END IF
 
   CASE ps_page_action
      
      WHEN "first" 
         LET g_pagestart = 1
      
      WHEN "prev"  
         LET g_pagestart = g_pagestart - 10
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
      
      WHEN "next"  
         LET g_pagestart = g_pagestart + 10
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 10) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - 10
            END WHILE
         END IF
      
      WHEN "last"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 10) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - 10
         END WHILE
      
      WHEN "dialog"
         LET g_pagestart = 1
         
      OTHERWISE
         
   END CASE
   
   #單身無輸入資料
   LET l_sql_rank = "SELECT dzej001,dzej002,RANK() OVER(ORDER BY dzej001 ",
                    ",to_number(dzej002) ",g_order,
                    ") AS RANK ",
                    " FROM dzej_t ",
                    " WHERE  dzej001 = '",g_dzej001,"'  AND ",g_wc#cch
   #DISPLAY "l_sql_rank = ",l_sql_rank
   #定義翻頁CURSOR
   LET g_sql= "SELECT dzej001,dzej002,'',RANK FROM (",l_sql_rank,") ",
              " WHERE RANK >= ",g_pagestart,
              " AND   RANK <  ",g_pagestart + 10," AND dzej001 = '",g_dzej001,"' ",#cch
              " ORDER BY ",l_searchcol ," ",g_order
   #DISPLAY "g_sql = ",g_sql
   
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzej001,g_browser[g_cnt].b_dzej002,g_browser[g_cnt].b_dzej003   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      SELECT dzejl004 INTO g_browser[g_cnt].b_dzej003 FROM dzejl_t WHERE dzejl001 = g_dzejl001 AND dzejl002 = g_browser[g_cnt].b_dzej002  AND dzejl003 = g_lang
      
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
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt  = g_rec_b
   LET g_cnt = 0
   
   CALL adzi230_fetch("") 
   
END FUNCTION
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi230_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   
   CLEAR FORM
   INITIALIZE g_dzej_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON dzej001,dzej002,dzej004
      
         BEFORE CONSTRUCT                                    #預設查詢條件
            CALL cl_qbe_init()                               #讀回使用者存檔的預設條件
      
      END CONSTRUCT
  
      ON ACTION accept
         EXIT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
 
END FUNCTION
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi230_query()
   DEFINE ls_wc STRING
   
   LET INT_FLAG = 0
   LET g_current_idx = 1
   LET g_current_cnt = 0
   
   CALL cl_navigator_setting(g_current_idx,g_current_cnt)
 
   CALL g_browser.clear()
 
   IF g_worksheet_hidden THEN  #browser panel 單身折疊
      LET g_worksheet_hidden = 0
   END IF
   IF g_header_hidden THEN    #單頭折疊
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_dzej_m.* TO NULL
   ERROR ""
   CALL adzi230_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLEAR FORM
      LET g_wc = " 1=1"
      RETURN
   END IF
   
   CALL adzi230_browser_fill(g_wc,"first")   # 移到第一頁
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      CALL adzi230_browser_fill(g_wc,"first")
   END IF
   
   #第二層助記碼搜尋
   IF g_browser_cnt = 0 THEN
      IF NOT cl_null(g_wc) THEN
         CALL adzi230_browser_fill(g_wc,"first")
      END IF
   END IF
   
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL adzi230_fetch("F") 
   END IF
END FUNCTION
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi230_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING

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
            CALL cl_getmsg("fetch",g_lang) RETURNING ls_msg
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

   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   # 設定browse索引
   #CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #todo
 
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   
   CALL cl_navigator_setting(g_current_idx, g_current_cnt)  

   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_dzej_m.dzej001 = g_browser[g_current_idx].b_dzej001
   LET g_dzej_m.dzej002 = g_browser[g_current_idx].b_dzej002
   
   #重讀DB,因TEMP有不被更新特性
   #SELECT UNIQUE dzej001,dzej002,'',dzej004 #2015/04/23 by Hiko
   SELECT UNIQUE dzej001,dzej002,dzejl004,dzej004
    INTO g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej003,g_dzej_m.dzej004
    FROM dzej_t
    LEFT JOIN dzejl_t ON dzejl001=dzej001 AND dzejl002=dzej002 AND dzejl003 = g_lang #2015/04/23 by Hiko
    WHERE dzej001 = g_dzej_m.dzej001 AND dzej002 = g_dzej_m.dzej002

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzej_t##"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      INITIALIZE g_dzej_m.* TO NULL
      RETURN
   END IF
   #2015/04/23 by Hiko:移到上面直接LEFT JOIN
   #SELECT dzejl004 INTO g_dzej_m.dzej003 FROM dzejl_t WHERE dzejl001 = g_dzejl001 AND dzejl002 = g_dzej_m.dzej002  AND dzejl003 = g_lang

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,reproduce", TRUE)
   END IF
   
   #重新顯示
   CALL adzi230_show()
END FUNCTION
 
#+ 資料新增
PRIVATE FUNCTION adzi230_insert()
   CLEAR FORM                    #清畫面欄位內容
 
   INITIALIZE g_dzej_m.* LIKE dzej_t.*             #DEFAULT 設定
   LET g_dzej001_t = NULL
   LET g_dzej002_t = NULL
 
   WHILE TRUE
      BEGIN WORK
      CALL adzi230_input("a")
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzej_m.* = g_dzej_m_t.*
         CALL adzi230_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
         ROLLBACK WORK
         EXIT WHILE
      END IF
 
      COMMIT WORK
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
END FUNCTION
 
#+ 資料修改
PRIVATE FUNCTION adzi230_modify()  
   #隱藏瀏覽頁籤
   LET g_worksheet_hidden = 1
   
   IF g_dzej_m.dzej001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      #顯示瀏覽頁籤
      LET g_worksheet_hidden = 0
      RETURN
   END IF 
   
   SELECT UNIQUE dzej001,dzej002,dzej004
      INTO g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej004
      FROM dzej_t
      WHERE dzej001 = g_dzej_m.dzej001 AND dzej002 = g_dzej_m.dzej002
 
   ERROR ""
  
   LET g_dzej001_t = g_dzej_m.dzej001
   LET g_dzej002_t = g_dzej_m.dzej002
 
   BEGIN WORK
   
   OPEN adzi230_cl USING g_dzej_m.dzej001,g_dzej_m.dzej002
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi230_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi230_cl
      ROLLBACK WORK
      #顯示瀏覽頁籤
      CALL gfrm_curr.setElementHidden("worksheet",0)
      CALL gfrm_curr.setElementImage("worksheethidden","small/arr-l.png")
      LET g_worksheet_hidden = 0
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi230_cl INTO g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej004
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzej_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi230_cl
      ROLLBACK WORK
      #顯示瀏覽頁籤
      LET g_worksheet_hidden = 0
      RETURN
   END IF

   OPEN dzejl_cl USING g_dzej_m.dzej002,g_lang

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN dzejl_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE dzejl_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH dzejl_cl INTO g_dzej_m.dzej003 
   
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzejl_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE dzejl_cl
      ROLLBACK WORK
      RETURN
   END IF
   
   CALL adzi230_show()
   WHILE TRUE
      LET g_dzej_m.dzej001 = g_dzej001_t
      LET g_dzej_m.dzej002 = g_dzej002_t
 
      CALL adzi230_input("u")     #欄位更改
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzej_m.* = g_dzej_m_t.*
         CALL adzi230_show()
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
   IF NOT cl_used_modified_record(g_dzej_m.dzej001,g_site) THEN 
      ROLLBACK WORK
   END IF
 
   CLOSE adzi230_cl
   COMMIT WORK
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_dzej_m.dzej001,"U")
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION adzi230_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_count2        LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE ls_tmp          java.lang.String    #JAVA的String變數

   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
 
   DISPLAY BY NAME g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej003,g_dzej_m.dzej004
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej003,g_dzej_m.dzej004 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION

         BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL adzi230_set_entry(p_cmd)
            CALL adzi230_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE

            #cch
            LET g_dzej_m.dzej001 = g_dzej001
   
            IF  p_cmd = 'a' THEN
               LET g_dzej_m.dzej002 = g_browser_cnt+1
               LET g_dzej_m.dzej003 = "### purpose ###"
               LET g_dzej_m.dzej004 = "SELECT <count> ... </count>,<field> ... </field>\n",  
                                      "   FROM <table> ... </table>\n",  
                                      "   WHERE <wc> ... </wc>\n",
                                      "   ORDER BY ..."
            END IF
            
            #其他table資料備份(確定是否更改用)
            
         AFTER FIELD dzej002
            IF  NOT cl_null(g_dzej_m.dzej001) AND NOT cl_null(g_dzej_m.dzej002) THEN #AND NOT cl_null(g_dzej_m.dzej003)  THEN 
               IF  p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_dzej_m.dzej001 != g_dzej001_t  OR g_dzej_m.dzej002 != g_dzej002_t )) THEN   #OR g_dzej_m.dzej003 != g_dzej003_t )) THEN 

                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzej_t WHERE "||"dzej001 = '"||g_dzej_m.dzej001 ||"' AND "|| "dzej002 = '"||g_dzej_m.dzej002 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD dzej002
                  END IF
                  
                  #使用JAVA的String變數
                  LET ls_tmp = String.create(g_dzej_m.dzej002)
                  
                  #使JAVA的正規表示法和GENERO原生的MATCHES,輸入的格式必須為整數或開頭不能為0
                  IF NOT ls_tmp.matches("[0-9]+") OR g_dzej_m.dzej002 MATCHES "0*" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00067"
                     LET g_errparam.extend = "format errors"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD dzej002
                  END IF
                  
               END IF
            END IF

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            IF cl_null(g_dzej_m.dzej003) THEN
               NEXT FIELD dzej003
            END IF

            IF cl_null(g_dzej_m.dzej004) THEN
               NEXT FIELD dzej004
            END IF
                
 
            IF p_cmd <> "u" THEN
               LET l_count = 1  
 
               SELECT COUNT(*) INTO l_count FROM dzej_t
                WHERE  dzej001 = g_dzej001_t AND dzej002 = g_dzej002_t

               LET l_count2 = 1

               SELECT COUNT(*) INTO l_count2 FROM dzejl_t
                WHERE  dzejl001 = g_dzejl001 AND dzejl002 = g_dzej002_t AND dzejl003 = g_lang

               IF l_count = 0 AND l_count2 = 0 THEN

                  #新增dzejl_t資料
                  INSERT INTO dzejl_t (dzejl001,dzejl002,dzejl003,dzejl004)
                     VALUES (g_dzejl001,g_dzej_m.dzej002,g_lang,g_dzej_m.dzej003)
                     
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "add dzejl_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                              
                  #新增dzej_t資料
                  INSERT INTO dzej_t (dzej001,dzej002,dzej003,dzej004)
                     VALUES (g_dzej_m.dzej001,g_dzej_m.dzej002,'',g_dzej_m.dzej004) # DISK WRITE

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "add dzej_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF               
                  
                  #資料多語言用-增/改
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_dzej_m.dzej001"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF 
            ELSE
               #更新dzejl_t資料
               UPDATE dzejl_t SET (dzejl002,dzejl004) = 
                  (g_dzej_m.dzej002,g_dzej_m.dzej003)
                  WHERE  dzejl001 = g_dzejl001 AND dzejl002 = g_dzej002_t AND dzejl003 = g_lang
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "update dzejl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF

               #更新dzej_t資料
               UPDATE dzej_t SET (dzej001,dzej002,dzej003,dzej004) = (g_dzej_m.dzej001,g_dzej_m.dzej002,'',g_dzej_m.dzej004)
                WHERE  dzej001 = g_dzej001_t AND dzej002 = g_dzej002_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "update dzej_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               
            END IF
           #controlp
      END INPUT
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION ACCEPT

         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_action_choice="exit"
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG

END FUNCTION
 
#+ 資料複製
PRIVATE FUNCTION adzi230_reproduce()
   DEFINE l_newno     LIKE dzej_t.dzej001 
   DEFINE l_oldno     LIKE dzej_t.dzej001 
      #key2
   DEFINE l_newno02     LIKE dzej_t.dzej002 
   DEFINE l_oldno02     LIKE dzej_t.dzej002 
   DEFINE l_oldno03     LIKE dzejl_t.dzejl004 
   DEFINE l_master    RECORD LIKE dzej_t.*
   DEFINE l_cnt       LIKE type_t.num5

   IF g_dzej_m.dzej001 IS NULL
      #key2
      OR g_dzej_m.dzej002 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
    
   LET g_before_input_done = FALSE
   CALL adzi230_set_entry("a")
   LET g_before_input_done = TRUE
 
   INPUT l_newno,l_newno02 FROM dzej001,dzej002
         
      BEFORE INPUT
         LET l_newno = g_dzej001
 
      AFTER FIELD dzej001
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         
      #key2
      AFTER FIELD dzej002
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF

 
      AFTER INPUT
         #確定該key值是否有重複定義
         IF g_dzej_m.dzej001 IS NULL  OR g_dzej_m.dzej002 IS NULL
 
         THEN
            NEXT FIELD dzej001                                  
         END IF
         
         LET l_cnt = 0

         SELECT COUNT(*) INTO l_cnt FROM dzej_t 
          WHERE  dzej001 = l_newno AND dzej002 = l_newno02
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD dzej001 
         END IF

         SELECT COUNT(*) INTO l_cnt FROM dzejl_t 
          WHERE  dzejl001 = g_dzejl001 AND dzejl002 = l_newno02 AND dzejl003 = g_lang
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD dzej001 
         END IF
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT
   END INPUT
   
   IF INT_FLAG OR l_newno IS NULL THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   BEGIN WORK
 
   SELECT * INTO l_master.* FROM dzej_t 
    WHERE  dzej001 = g_dzej_m.dzej001 AND dzej002 = g_dzej_m.dzej002
 
   LET l_master.dzej001 = l_newno
      #key2
   LET l_master.dzej002 = l_newno02

   #複製dzejl_t資料

   INSERT INTO dzejl_t (dzejl001,dzejl002,dzejl003,dzejl004)
      VALUES (g_dzejl001,l_master.dzej002,g_lang,g_dzej_m.dzej003)
      
   IF SQLCA.sqlcode THEN
      ROLLBACK WORK
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "copy dzejl_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   #複製dzej_t資料
   INSERT INTO dzej_t VALUES (l_master.*) #複製單頭  
   
   IF SQLCA.sqlcode THEN
      ROLLBACK WORK
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "copy dzej_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   COMMIT WORK
   
   LET l_oldno = g_dzej_m.dzej001
      #key2
   LET l_oldno02 = g_dzej_m.dzej002

 
   SELECT dzej001,dzej002,dzejl004,dzej004 
      INTO g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej003,g_dzej_m.dzej004 FROM dzej_t 
      LEFT JOIN dzejl_t ON dzejl001=dzej001 AND dzejl002=dzej002 AND dzejl003 = g_lang #2015/04/23 by Hiko
      WHERE  dzej001 = l_newno AND dzej002 = g_dzej_m.dzej002

   #2015/04/23 by Hiko:移到上面直接LEFT JOIN
   #SELECT dzejl004 INTO g_dzej_m.dzej003 FROM dzejl_t WHERE dzejl001 = g_dzejl001 AND dzejl002 = g_dzej_m.dzej002  AND dzejl003 = g_lang
 
   CALL adzi230_show()
   
   LET g_dzej_m.dzej001 = l_oldno
      #key2
   LET g_dzej_m.dzej002 = l_oldno02
                       
   SELECT dzej001,dzej002,dzejl004,dzej004 
      INTO g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej003,g_dzej_m.dzej004 FROM dzej_t 
      LEFT JOIN dzejl_t ON dzejl001=dzej001 AND dzejl002=dzej002 AND dzejl003 = g_lang #2015/04/23 by Hiko
      WHERE  dzej001 = g_dzej_m.dzej001 AND dzej002 = g_dzej_m.dzej002

   #2015/04/23 by Hiko:移到上面直接LEFT JOIN
   #SELECT dzejl004 INTO g_dzej_m.dzej003 FROM dzejl_t WHERE dzejl001 = g_dzejl001 AND dzejl002 = g_dzej_m.dzej002  AND dzejl003 = g_lang

   CALL adzi230_show()
 
   DISPLAY BY NAME g_dzej_m.dzej001,g_dzej_m.dzej002
 
END FUNCTION
 
 
#+ 單頭資料重新顯示 
PRIVATE FUNCTION adzi230_show()
   LET g_dzej_m_t.* = g_dzej_m.*      #保存單頭舊值
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej003,g_dzej_m.dzej004
END FUNCTION
 
 
#+ 資料刪除 
PRIVATE FUNCTION adzi230_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING

   
   IF g_dzej_m.dzej001 IS NULL OR g_dzej_m.dzej002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   BEGIN WORK

   OPEN adzi230_cl USING g_dzej_m.dzej001,g_dzej_m.dzej002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi230_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi230_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH adzi230_cl INTO g_dzej_m.dzej001,g_dzej_m.dzej002,g_dzej_m.dzej004

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzej_m.dzej001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi230_cl
      ROLLBACK WORK
      RETURN
   END IF

   OPEN dzejl_cl USING g_dzej_m.dzej002,g_lang

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN dzejl_cl:!"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE dzejl_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH dzejl_cl INTO g_dzej_m.dzej003 
   
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzejl_t&"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE dzejl_cl
      ROLLBACK WORK
      RETURN
   END IF

   CALL adzi230_show()
 
   IF cl_ask_delete() THEN
      #刪除dzejl_t資料
      DELETE FROM dzejl_t 
       WHERE  dzejl001 = g_dzejl001
       AND dzejl002 = g_dzej_m.dzej002 
       AND dzejl003 = g_lang

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del dzejl_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         ROLLBACK WORK
      END IF
 
      #刪除dzej_t資料
      DELETE FROM dzej_t 
       WHERE  dzej001 = g_dzej_m.dzej001 AND dzej002 = g_dzej_m.dzej002 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del dzej_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         ROLLBACK WORK
      END IF
     
      CLEAR FORM
      CALL adzi230_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         #CALL adzi230_fetch("")#cch
         #CALL adzi230_browser_fill(" 1=1 ","prev")
      ELSE
         CALL adzi230_browser_fill(" 1=1 ","first")
      END IF
      
   END IF
 
   CLOSE adzi230_cl
   COMMIT WORK
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzej_m.dzej001,"D")
 
END FUNCTION
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi230_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzej001 = g_dzej_m.dzej001 THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR
   
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF
END FUNCTION
 
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi230_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1 
 
   IF p_cmd = "a" AND ( NOT g_before_input_done ) AND g_chkey="N" THEN
      CALL cl_set_comp_entry("dzej001",TRUE)
   END IF
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi230_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1    
 
   IF p_cmd = "u" AND ( NOT g_before_input_done ) AND g_chkey="N" THEN
      CALL cl_set_comp_entry("dzej001",FALSE)
   END IF
END FUNCTION
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi230_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dzej001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dzej002 = ", g_argv[02], " AND "
   END IF
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
END FUNCTION
