#+ Version..: T6-ERP-1.00.00 Build-000013
#+ 
#+ Filename...: adzi156
#+ 設計人員......: cch
#+ 功能名稱說明...: SA分鏡規格匯入介面檔維護作業
#+ Memo.......: 
# Modify.........: 2014/04/15 by madey mark掉相關文件cl_del_doc
#                  2014/08/27 by madey mark cl_showmsg
#                  2015/02/02 by madey mark掉 CONNECT TO,吃cl_tool_init的預設連線即可
#                  2015/04/08 by Hiko : 調整畫面
#                : 20160331 160331-00017 by Hiko : 清除呼叫q_common的段落
#                : 20160524 160524-00013 by madey: 1.修正bug:原本只能顯示第1個page的資料
#                                                  2.修正bug:修改後存檔會crash:Not in transaction
#                  20160524 160506-00024 by madey :停用參數二，訊息一律顯示


IMPORT os

SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 

#單頭 type 宣告
PRIVATE TYPE type_g_dzem_m RECORD
   dzem001 LIKE dzem_t.dzem001, 
   dzem002 LIKE dzem_t.dzem002, 
   dzem003 LIKE dzem_t.dzem003, 
   dzem099 LIKE dzem_t.dzem099, 
   dzemcrtid LIKE dzem_t.dzemcrtid, 
   dzemcrtdp LIKE dzem_t.dzemcrtdp, 
   dzemcrtdt DATETIME YEAR TO SECOND, 
   dzemownid LIKE dzem_t.dzemownid, 
   dzemowndp LIKE dzem_t.dzemowndp, 
   dzemmodid LIKE dzem_t.dzemmodid, 
   dzemmoddt DATETIME YEAR TO SECOND, 
   modid_desc LIKE type_t.chr100, 
   ownid_desc LIKE type_t.chr100, 
   crtid_desc LIKE type_t.chr100, 
   crtdp_desc LIKE type_t.chr100, 
   owndp_desc LIKE type_t.chr100
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_dzem_m      type_g_dzem_m
DEFINE g_dzem_m_t    type_g_dzem_m             #備份舊值
DEFINE g_dzem001_t   LIKE dzem_t.dzem001       #Key值備份#key2
DEFINE g_dzem002_t   LIKE dzem_t.dzem002       #Key值備份#key3
DEFINE g_browser1     DYNAMIC ARRAY OF RECORD  #規格編號瀏覽 
       b_dzem001     LIKE dzem_t.dzem001
      END RECORD

DEFINE g_browser     DYNAMIC ARRAY OF RECORD   #識別碼瀏覽 
       b_statepic    LIKE type_t.chr50,
       b_dzem001     LIKE dzem_t.dzem001,
       b_dzem002     LIKE dzem_t.dzem002,
       b_dzem003     LIKE dzem_t.dzem003, 
       rank          LIKE type_t.num10
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
DEFINE g_dzem001             LIKE dzem_t.dzem001
DEFINE g_dzem001_index       LIKE type_t.num10
 
#+ 作業開始 
MAIN 
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING

   CALL cl_tool_init()

   LET g_forupd_sql = "SELECT dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt FROM dzem_t WHERE dzem001 = ? AND dzem002 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)              #轉換不同資料庫語法
   DECLARE adzi156_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR

   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)

   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi156 WITH FORM cl_ap_formpath("adz",g_prog)
    #ATTRIBUTE(STYLE="openwin") #cch
 
   CLOSE WINDOW screen

   CALL adzi156_init()   
   
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

   #進入選單 Menu (="N")
   CALL adzi156_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_adzi156
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi156_init()
  
   CALL adzi156_default_search()
   LOCATE g_dzem_m.dzem099 IN FILE
   LET g_dzem001_index = 1
END FUNCTION
 
 
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi156_ui_dialog() 
 
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_wc    LIKE type_t.chr200
   
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
 
   WHILE li_exit = FALSE
      
      CALL adzi156_browser_fill(g_wc,"")
      
      IF g_main_hidden THEN
         #還原為原本指定筆數
         LET g_current_idx = g_current_row
 
         #當每次點任一筆資料都會需要用到  
         IF g_browser_cnt > 0 THEN
            CALL adzi156_fetch("")   
         END IF               
         
         MENU
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            ON ACTION close
               LET li_exit = TRUE
               EXIT MENU
            
            #Begin:2015/04/08 by Hiko:不需要新增
            #ON ACTION insert
            #   LET g_action_choice="insert"
            #   IF cl_chk_act_auth() THEN 
            #      CALL adzi156_insert()
            #
            #       EXIT MENU
            #   END IF
            #End:2015/04/08 by Hiko

            ON ACTION query
               LET g_action_choice="query"
               IF cl_chk_act_auth() THEN 
                  CALL adzi156_query()
    
                   EXIT MENU
               END IF
    
            ON ACTION delete
               LET g_action_choice="delete"
               IF cl_chk_act_auth() THEN 
                  CALL adzi156_delete()
    
                   EXIT MENU
               END IF

            ON ACTION modify
               LET g_action_choice="modify"
               IF cl_chk_act_auth() THEN 
                  CALL adzi156_modify()
    
                   EXIT MENU
               END IF

            #Begin:2015/04/08 by Hiko:不需要複製
            #ON ACTION reproduce
            #   LET g_action_choice="reproduce"
            #   IF cl_chk_act_auth() THEN 
            #      CALL adzi156_reproduce()
            #
            #       EXIT MENU
            #   END IF
            #End:2015/04/08 by Hiko
 
            #主選單用ACTION
            &include "main_menu.4gl"
            
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

            DISPLAY ARRAY g_browser1 TO s_browse1.* 
               BEFORE ROW
                  LET g_dzem001_index =DIALOG.getCurrentRow("s_browse1")
                  CALL adzi156_browser_fill(g_wc,"first")
                  CALL DIALOG.setCurrentRow("s_browse",1)
                  CALL adzi156_fetch("F")
            END DISPLAY
            
      
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
                  #CALL cl_show_fld_cont() #2015/04/08 by Hiko : 取消show hint   
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL adzi156_fetch("")      
            END DISPLAY
         
            BEFORE DIALOG
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
                  CALL adzi156_fetch("")   
               END IF               
               
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            ON ACTION close
               LET li_exit = TRUE
               EXIT DIALOG
         

         #Begin:2015/04/08 by Hiko:不需要新增
         #ON ACTION insert
         #   LET g_action_choice="insert"
         #   IF cl_chk_act_auth() THEN 
         #      CALL adzi156_insert()
         #
         #      EXIT DIALOG
         #   END IF
         #End:2015/04/08 by Hiko
 
         ON ACTION query
            LET g_action_choice="query"
            IF cl_chk_act_auth() THEN 
               CALL adzi156_query()
 
               EXIT DIALOG
            END IF

         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_chk_act_auth() THEN 
               CALL adzi156_delete()
 
               EXIT DIALOG
            END IF

         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_chk_act_auth() THEN 
               CALL adzi156_modify()
 
               EXIT DIALOG
            END IF

         #Begin:2015/04/08 by Hiko:不需要複製
         #ON ACTION reproduce
         #   LET g_action_choice="reproduce"
         #   IF cl_chk_act_auth() THEN 
         #      CALL adzi156_reproduce()
         #
         #      EXIT DIALOG
         #   END IF
         #End:2015/04/08 by Hiko

         #載入SA的規格分鏡檔
          ON ACTION btn_load_sco 
           #CALL adzi156_run_prog("r.r","adzp165","hidden_hint")
            CALL adzi156_run_prog("r.r","adzp165","") #160506-00024 modify
            CALL adzi156_browser_fill(g_wc,"")

            #主選單用ACTION
            &include "main_menu.4gl"
            
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
   END WHILE
 
END FUNCTION 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi156_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   
   CLEAR FORM
   INITIALIZE g_dzem_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "dzem001,dzem002" #cch:to do 因應不同的資料庫可能會有不同的函式
   ELSE
      LET l_searchcol ="dzem001,dzem002"
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF

   #撈取 規格編號的 代號
   LET g_sql="SELECT DISTINCT dzem001 FROM dzem_t WHERE ",p_wc CLIPPED,""

   PREPARE browse_pre1 FROM g_sql
   DECLARE browse_cur1 CURSOR FOR browse_pre1
 
   CALL g_browser1.clear()
   
   LET g_cnt = 1
   FOREACH browse_cur1 INTO g_browser1[g_cnt].b_dzem001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET g_cnt = g_cnt + 1
   END FOREACH
   CALL g_browser1.deleteElement(g_cnt)
   LET g_cnt = g_cnt - 1

   IF cl_null(g_browser1[g_dzem001_index].b_dzem001) THEN #2015/04/08 by Hiko
      LET g_sql = "SELECT COUNT(*) FROM dzem_t WHERE ",     
                   p_wc CLIPPED ,"" #cch
   ELSE 
      LET g_sql = "SELECT COUNT(*) FROM dzem_t WHERE dzem001 = '",g_browser1[g_dzem001_index].b_dzem001 ,"' AND ",     
                   p_wc CLIPPED ,"" #cch
   END IF

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
         LET g_pagestart = g_pagestart - 15
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
      
      WHEN "next"  
         LET g_pagestart = g_pagestart + 15
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 15) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - 15
            END WHILE
         END IF
         
      WHEN "last"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 15) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - 15
         END WHILE
      
      WHEN "dialog"
         LET g_pagestart = 1
         
      OTHERWISE
         
   END CASE
   
   #單身無輸入資料
   LET l_sql_rank = "SELECT dzem001,dzem002,RANK() OVER(ORDER BY dzem001 ",
                    ",dzem002 ",g_order,
                    ") AS RANK ",
                    " FROM dzem_t ",
                    " WHERE dzem001 = '",g_browser1[g_dzem001_index].b_dzem001 ,"' AND ",g_wc
   #DISPLAY "l_sql_rank = ",l_sql_rank
   #定義翻頁CURSOR
   LET g_sql= "SELECT '',dzem001,dzem002,'',RANK FROM (",l_sql_rank,") ",
             #Begin: 160524-00013 mark
             #" WHERE RANK >= ",g_pagestart,
             #" AND   RANK <  ",g_pagestart + 15," ",#cch
             #End: 160524-00013
              " ORDER BY ",l_searchcol ," ",g_order
   #DISPLAY "g_sql = ",g_sql
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_dzem001,g_browser[g_cnt].b_dzem002,g_browser[g_cnt].b_dzem003   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      
      LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic)
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
   
   #CALL adzi156_fetch("") #2015/04/08 by Hiko
   
END FUNCTION
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi156_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   
   CLEAR FORM
   INITIALIZE g_dzem_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt
      
         BEFORE CONSTRUCT                                    #預設查詢條件
            CALL cl_qbe_init()                               #讀回使用者存檔的預設條件
      
         #Begin:160331-00017
         ##公用欄位開窗相關處理
	 #        #----<<dzemmodid>>----
         #ON ACTION controlp INFIELD dzemmodid
         #   CALL q_common('dzem_t','dzemmodid',TRUE,FALSE,g_dzem_m.dzemmodid) RETURNING ls_return
         #   DISPLAY ls_return TO dzemmodid
         #   NEXT FIELD dzemmodid
         #
         ##----<<dzemownid>>----
         #ON ACTION controlp INFIELD dzemownid
         #   CALL q_common('dzem_t','dzemownid',TRUE,FALSE,g_dzem_m.dzemownid) RETURNING ls_return
         #   DISPLAY ls_return TO dzemownid
         #   NEXT FIELD dzemownid  
         #
         ##----<<dzemcrtid>>----
         #ON ACTION controlp INFIELD dzemcrtid
         #   CALL q_common('dzem_t','dzemcrtid',TRUE,FALSE,g_dzem_m.dzemcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO dzemcrtid
         #   NEXT FIELD dzemcrtid
         #
         ##----<<dzemowndp>>----
         #ON ACTION controlp INFIELD dzemowndp
         #   CALL q_common('dzem_t','dzemowndp',TRUE,FALSE,g_dzem_m.dzemowndp) RETURNING ls_return
         #   DISPLAY ls_return TO dzemowndp
         #   NEXT FIELD dzemowndp
         #
         ##----<<dzemcrtdp>>----
         #ON ACTION controlp INFIELD dzemcrtdp
         #   CALL q_common('dzem_t','dzemcrtdp',TRUE,FALSE,g_dzem_m.dzemcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO dzemcrtdp
         #   NEXT FIELD dzemcrtdp
         #End:160331-00017
         
         #----<<dzemcrtdt>>----
         AFTER FIELD dzemcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzemmoddt>>----
         AFTER FIELD dzemmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)


 

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
  
   #LET g_wc = g_wc CLIPPED,cl_get_extra_cond("g_dzem_m.dzemcrtid", "g_dzem_m.dzemcrtdp")
 
END FUNCTION
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi156_query()
   DEFINE ls_wc STRING
   
   LET INT_FLAG = 0
   LET g_current_idx = 1
   LET g_current_cnt = 0
   
   CALL g_browser.clear()
 
   INITIALIZE g_dzem_m.* TO NULL
   ERROR ""
 
   CALL adzi156_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLEAR FORM
      LET g_wc = " 1=1"
      RETURN
   END IF
   
   CALL adzi156_browser_fill(g_wc,"first")   # 移到第一頁
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      CALL adzi156_browser_fill(g_wc,"first")
   END IF
   
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL adzi156_fetch("F") 
   END IF
   
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi156_fetch(p_fl)
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
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
 
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF

   LET g_dzem_m.dzem001 = g_browser[g_current_idx].b_dzem001
      #key2
   LET g_dzem_m.dzem002 = g_browser[g_current_idx].b_dzem002


   #重讀DB,因TEMP有不被更新特性
   SELECT UNIQUE dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt
      INTO g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt
      FROM dzem_t
      WHERE dzem001 = g_dzem_m.dzem001 AND dzem002 = g_dzem_m.dzem002

    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzem_t##"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      INITIALIZE g_dzem_m.* TO NULL
      RETURN
   END IF

 
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,reproduce", TRUE)
   END IF

   #重新顯示
   CALL adzi156_show()
 
END FUNCTION

 
 
#+ 資料新增
PRIVATE FUNCTION adzi156_insert()
   
   
   CLEAR FORM                    #清畫面欄位內容
 
   INITIALIZE g_dzem_m.* LIKE dzem_t.*             #DEFAULT 設定
   LET g_dzem001_t = NULL
      #key2
   LET g_dzem002_t = NULL

 
   WHILE TRUE
      #公用欄位給值
      LET g_dzem_m.dzemcrtid = g_user
      LET g_dzem_m.dzemcrtdp = g_dept
      LET g_dzem_m.dzemcrtdt = cl_get_current()
      LET g_dzem_m.dzemownid = g_user 
      LET g_dzem_m.dzemowndp = g_dept 
      LET g_dzem_m.dzemmodid = g_user
      LET g_dzem_m.dzemmoddt = cl_get_current()
      #LET g_dzem_m.dzemstus = 'Y'
	  #CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
 
	  #append欄位給值
      #單頭預設值
      #單頭預設值
      
      CALL adzi156_input("a")
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzem_m.* = g_dzem_m_t.*
         CALL adzi156_show()
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
   
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION adzi156_modify()  
   
   IF g_dzem_m.dzem001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF 

   #LOCATE g_dzem_m.dzem099 IN FILE
   SELECT UNIQUE dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt
      INTO g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt
      FROM dzem_t
      WHERE dzem001 = g_dzem_m.dzem001 AND dzem002 = g_dzem_m.dzem002 #AND dzem003 = g_dzem_m.dzem003
 
   ERROR ""

   #key1
   LET g_dzem001_t = g_dzem_m.dzem001
   #key2
   LET g_dzem002_t = g_dzem_m.dzem002
 
   BEGIN WORK

   OPEN adzi156_cl USING g_dzem_m.dzem001,g_dzem_m.dzem002
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi156_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi156_cl
      ROLLBACK WORK

      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi156_cl INTO g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt,g_dzem_m.modid_desc,g_dzem_m.ownid_desc,g_dzem_m.crtid_desc,g_dzem_m.crtdp_desc,g_dzem_m.owndp_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzem_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi156_cl
      ROLLBACK WORK
      RETURN
   END IF

 
   CALL adzi156_show()
   WHILE TRUE
      LET g_dzem_m.dzem001 = g_dzem001_t
      #key2
      LET g_dzem_m.dzem002 = g_dzem002_t
 
	  #寫入修改者/修改日期資訊
      LET g_dzem_m.dzemmodid = g_user 
      LET g_dzem_m.dzemmoddt = cl_get_current()
 
      CALL adzi156_input("u")     #欄位更改
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzem_m.* = g_dzem_m_t.*
         CALL adzi156_show()
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
   #IF NOT cl_used_modified_record(g_dzem_m.dzem001,g_site) THEN 
      #ROLLBACK WORK
   #END IF
 #
   CLOSE adzi156_cl
  #COMMIT WORK     #160524-00013 mark :input(u)內就已經有COMMIT了
 
   #流程通知預埋點-U
   #CALL cl_flow_notify(g_dzem_m.dzem001,"U")
   
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION adzi156_input(p_cmd)
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

   #CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
 
   DISPLAY BY NAME g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION

         BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL adzi156_set_entry(p_cmd)
            CALL adzi156_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE

            
         BEFORE FIELD dzem001

         AFTER FIELD dzem001
            IF  NOT cl_null(g_dzem_m.dzem001) AND NOT cl_null(g_dzem_m.dzem002) THEN 
               IF  p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_dzem_m.dzem001 != g_dzem001_t  OR g_dzem_m.dzem002 != g_dzem002_t )) THEN #  OR g_dzem_m.dzem003 != g_dzem003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzem_t WHERE "||"dzem001 = '"||g_dzem_m.dzem001 ||"' AND "|| "dzem002 = '"||g_dzem_m.dzem002 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD dzem001
                  END IF
               END IF
            END IF


 
         AFTER FIELD dzem002
            IF  NOT cl_null(g_dzem_m.dzem001) AND NOT cl_null(g_dzem_m.dzem002) THEN 
               IF  p_cmd = 'a'  OR ( p_cmd = 'u' AND (g_dzem_m.dzem001 != g_dzem001_t  OR g_dzem_m.dzem002 != g_dzem002_t )) THEN   #OR g_dzem_m.dzem003 != g_dzem003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzem_t WHERE "||"dzem001 = '"||g_dzem_m.dzem001 ||"' AND "|| "dzem002 = '"||g_dzem_m.dzem002 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD dzem002
                  END IF
                  
                  
               END IF
            END IF

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            IF cl_null(g_dzem_m.dzem001) THEN
               NEXT FIELD dzem001
            END IF
 
            IF cl_null(g_dzem_m.dzem002) THEN
               NEXT FIELD dzem002
            END IF
                
            IF p_cmd <> "u" THEN
               BEGIN WORK
               LET l_count = 1  
 
               SELECT COUNT(*) INTO l_count FROM dzem_t
                WHERE  dzem001 = g_dzem001_t AND dzem002 = g_dzem002_t

               IF l_count = 0 THEN

                     
                  #新增dzem_t資料
                  INSERT INTO dzem_t (dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt)
                     VALUES (g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt) # DISK WRITE

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "add dzem_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF               
                  COMMIT WORK

               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_dzem_m.dzem001"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  ROLLBACK WORK
               END IF 
            ELSE


               #更新dzem_t資料
               UPDATE dzem_t SET (dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt) = (g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt)
                WHERE  dzem001 = g_dzem001_t AND dzem002 = g_dzem002_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "update dzem_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  ROLLBACK WORK
               ELSE
                  #資料多語言用-增/改
                  COMMIT WORK
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
PRIVATE FUNCTION adzi156_reproduce()
   DEFINE l_newno     LIKE dzem_t.dzem001 
   DEFINE l_oldno     LIKE dzem_t.dzem001 
      #key2
   DEFINE l_newno02     LIKE dzem_t.dzem002 
   DEFINE l_oldno02     LIKE dzem_t.dzem002 
   DEFINE l_oldno03     LIKE dzem_t.dzem003 
   DEFINE l_master    RECORD LIKE dzem_t.*
   DEFINE l_cnt       LIKE type_t.num5

   IF g_dzem_m.dzem001 IS NULL
      #key2
      OR g_dzem_m.dzem002 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
    
   LET g_before_input_done = FALSE
   CALL adzi156_set_entry("a")
   LET g_before_input_done = TRUE
 
   INPUT l_newno,l_newno02 FROM dzem001,dzem002
         
      BEFORE INPUT
         LET l_newno = ""
         LET l_newno02 = "" 
 
      AFTER FIELD dzem001
         IF  NOT cl_null(l_newno) AND NOT cl_null(l_newno02) THEN 
            IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzem_t WHERE "||"dzem001 = '"||l_newno ||"' AND "|| "dzem002 = '"||l_newno02 ||"' ",'std-00004',0) THEN 
               NEXT FIELD dzem001
            END IF
         END IF
         
      #key2
      AFTER FIELD dzem002
         IF  NOT cl_null(l_newno) AND NOT cl_null(l_newno02) THEN 
            IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzem_t WHERE "||"dzem001 = '"||l_newno ||"' AND "|| "dzem002 = '"||l_newno02 ||"' ",'std-00004',0) THEN 
               NEXT FIELD dzem002
            END IF
         END IF

 
      AFTER INPUT
         #確定該key值是否有重複定義
         IF g_dzem_m.dzem001 IS NULL THEN
            NEXT FIELD dzem001                                  
         END IF

         IF g_dzem_m.dzem002 IS NULL THEN
            NEXT FIELD dzem002                                  
         END IF
         
         LET l_cnt = 0

         SELECT COUNT(*) INTO l_cnt FROM dzem_t 
          WHERE  dzem001 = l_newno AND dzem002 = l_newno02
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD dzem001 
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
   LOCATE l_master.dzem099 IN FILE
   SELECT * INTO l_master.* FROM dzem_t 
    WHERE  dzem001 = g_dzem_m.dzem001 AND dzem002 = g_dzem_m.dzem002
 
   LET l_master.dzem001 = l_newno
      #key2
   LET l_master.dzem002 = l_newno02
   
   LET l_master.dzemcrtid = g_user
   LET l_master.dzemcrtdp = g_dept
   LET l_master.dzemcrtdt = cl_get_current()
   LET l_master.dzemownid = g_user 
   LET l_master.dzemowndp = g_dept 
   LET l_master.dzemmodid = g_user
   LET l_master.dzemmoddt = cl_get_current()


   #複製dzem_t資料
   INSERT INTO dzem_t VALUES (l_master.*) #複製單頭  
   
   IF SQLCA.sqlcode THEN
      ROLLBACK WORK
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "copy dzem_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   COMMIT WORK
   ERROR "ROW(",l_newno,") O.K"
   
   LET l_oldno = g_dzem_m.dzem001
      #key2
   LET l_oldno02 = g_dzem_m.dzem002

   SELECT dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt 
      INTO g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt FROM dzem_t 
      WHERE  dzem001 = l_newno AND dzem002 = g_dzem_m.dzem002

 
   CALL adzi156_show()
   
   LET g_dzem_m.dzem001 = l_oldno
      #key2
   LET g_dzem_m.dzem002 = l_oldno02
   SELECT dzem001,dzem002,dzem003,dzem099,dzemcrtid,dzemcrtdp,dzemcrtdt,dzemownid,dzemowndp,dzemmodid,dzemmoddt 
      INTO g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt FROM dzem_t 
      WHERE  dzem001 = g_dzem_m.dzem001 AND dzem002 = g_dzem_m.dzem002


   CALL adzi156_show()
 
   DISPLAY BY NAME g_dzem_m.dzem001,g_dzem_m.dzem002
 
END FUNCTION
 
 
#+ 單頭資料重新顯示 
PRIVATE FUNCTION adzi156_show()
   LET g_dzem_m_t.* = g_dzem_m.*      #保存單頭舊值
   
   #在browser 移動上下筆可以連動切換資料
   #CALL cl_show_fld_cont() #2015/04/08 by Hiko : 取消show hint
   
   #帶出公用欄位reference值
   #帶出預設欄位之值
   LET g_dzem_m.modid_desc = cl_get_username(g_dzem_m.dzemmodid)
   LET g_dzem_m.ownid_desc = cl_get_username(g_dzem_m.dzemownid)
   LET g_dzem_m.crtid_desc = cl_get_username(g_dzem_m.dzemcrtid)
   LET g_dzem_m.crtdp_desc = cl_get_deptname(g_dzem_m.dzemcrtdp)
   LET g_dzem_m.owndp_desc = cl_get_deptname(g_dzem_m.dzemowndp)

   #讀入ref值(單頭)
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt,g_dzem_m.modid_desc,g_dzem_m.ownid_desc,g_dzem_m.crtid_desc,g_dzem_m.crtdp_desc,g_dzem_m.owndp_desc
    
END FUNCTION
 
 
#+ 資料刪除 
PRIVATE FUNCTION adzi156_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING

   
   IF g_dzem_m.dzem001 IS NULL OR g_dzem_m.dzem002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   BEGIN WORK

   OPEN adzi156_cl USING g_dzem_m.dzem001,g_dzem_m.dzem002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi156_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi156_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH adzi156_cl INTO g_dzem_m.dzem001,g_dzem_m.dzem002,g_dzem_m.dzem003,g_dzem_m.dzem099,g_dzem_m.dzemcrtid,g_dzem_m.dzemcrtdp,g_dzem_m.dzemcrtdt,g_dzem_m.dzemownid,g_dzem_m.dzemowndp,g_dzem_m.dzemmodid,g_dzem_m.dzemmoddt,g_dzem_m.modid_desc,g_dzem_m.ownid_desc,g_dzem_m.crtid_desc,g_dzem_m.crtdp_desc,g_dzem_m.owndp_desc

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzem_m.dzem001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi156_cl
      ROLLBACK WORK
      RETURN
   END IF

 
   CALL adzi156_show()
 
   IF cl_ask_delete() THEN
     #20140415:madey -start-
     #INITIALIZE g_doc.* TO NULL
     #LET g_doc.column1 = "dzem001","dzem002"

     #LET g_doc.value1 = g_dzem_m.dzem001,"g_dzem_m.dzem002"
 
     #CALL cl_del_doc()
     #20140415:madey -end-

 
      #刪除dzem_t資料
      DELETE FROM dzem_t 
       WHERE  dzem001 = g_dzem_m.dzem001 AND dzem002 = g_dzem_m.dzem002 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del dzem_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         ROLLBACK WORK
      END IF
     
      CLEAR FORM
      CALL adzi156_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         #CALL adzi156_fetch("")#cch
         #CALL adzi156_browser_fill(" 1=1 ","prev")
      ELSE
         CALL adzi156_browser_fill(" 1=1 ","first")
      END IF
      
   END IF
 
   CLOSE adzi156_cl
   COMMIT WORK
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzem_m.dzem001,"D")
 
END FUNCTION
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi156_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
    
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzem001 = g_dzem_m.dzem001 THEN  
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
PRIVATE FUNCTION adzi156_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1 
 
   IF p_cmd = "a" AND ( NOT g_before_input_done ) AND g_chkey="N" THEN
      CALL cl_set_comp_entry("dzem001",TRUE)
   END IF
 
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi156_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1    
 
   IF p_cmd = "u" AND ( NOT g_before_input_done ) AND g_chkey="N" THEN
      CALL cl_set_comp_entry("dzem001",FALSE)
   END IF
 
END FUNCTION
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi156_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dzem001 = '", g_argv[1], "' AND "
   END IF
   
      #key2
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dzem002 = ", g_argv[02], " AND "
   END IF
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

END FUNCTION

#+ 進行 command line 的程式執行
PRIVATE FUNCTION adzi156_run_prog(p_shell,p_prog_id,p_arg_str)
   DEFINE p_prog_id      STRING
   DEFINE p_shell        STRING
   DEFINE p_arg_str      STRING
   DEFINE l_cmd          STRING    
   DEFINE l_msg          STRING
   DEFINE l_chk          LIKE type_t.num5

   LET l_cmd = p_shell," ",p_prog_id," ",p_arg_str
   CALL cl_cmdrun_openpipe(p_shell,l_cmd,FALSE) RETURNING l_chk,l_msg
   IF NOT l_chk THEN
      MESSAGE 'Error!'
   ELSE
      MESSAGE 'Success!'
   END IF
END FUNCTION
