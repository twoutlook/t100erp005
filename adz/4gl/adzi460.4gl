#+ Version..: T6-ERP-1.00.00 Build-000049
#+ 
#+ Filename...: adzi460
#+ Buildtype..: 應用 i01 樣板自動產生
#+ Memo.......: 
#+ 以上段落由子樣板a00產生
# Modify         : 2015/04/09 by Hiko : 調整畫面
#                : 2015/11/26 by Hiko : 去除s_chr_trim,改成CLIPPED
#                : 20160115 by Hiko : 去除權限控制
#                : 161011-00030 20161011 by Hiko : 1.移除不必要的程式段
#                                                  2.修正多語言存檔的問題
 
 
IMPORT os
IMPORT FGL lib_cl_dlg
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"

DEFINE g_today LIKE type_t.dat #161011-00030

#單頭 type 宣告
PRIVATE TYPE type_g_dzdj_m RECORD
       dzdj001 LIKE dzdj_t.dzdj001, 
       dzdj001_desc LIKE dzdi_t.dzdi005, 
   dzdj008 LIKE dzdj_t.dzdj008, 
   dzdj006 LIKE dzdj_t.dzdj006, 
   dzdj003 LIKE dzdj_t.dzdj003, 
   dzdjownid LIKE dzdj_t.dzdjownid, 
   dzdjownid_desc LIKE type_t.chr80, 
   dzdjowndp LIKE dzdj_t.dzdjowndp, 
   dzdjowndp_desc LIKE type_t.chr80, 
   dzdjcrtid LIKE dzdj_t.dzdjcrtid, 
   dzdjcrtid_desc LIKE type_t.chr80, 
   dzdjcrtdp LIKE dzdj_t.dzdjcrtdp, 
   dzdjcrtdp_desc LIKE type_t.chr80, 
   dzdjcrtdt DATETIME YEAR TO SECOND, 
   dzdjmodid LIKE dzdj_t.dzdjmodid, 
   dzdjmodid_desc LIKE type_t.chr80, 
   dzdjmoddt DATETIME YEAR TO SECOND, 
   dzdjcnfid LIKE dzdj_t.dzdjcnfid, 
   dzdjcnfid_desc LIKE type_t.chr80, 
   dzdjcnfdt LIKE dzdj_t.dzdjcnfdt
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_dzdj_m        type_g_dzdj_m
DEFINE g_dzdj_m_t      type_g_dzdj_m                #備份舊值
DEFINE g_dzdj001_t   LIKE dzdj_t.dzdj001    #Key值備份
DEFINE g_dzdi003          LIKE dzdi_t.dzdi003   #多语言说明 
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
            b_dzdj001 LIKE dzdj_t.dzdj001,
            b_dzdj001_desc LIKE dzdi_t.dzdi005,
            b_dzdj008 LIKE dzdj_t.dzdj008,
            b_dzdj006 LIKE dzdj_t.dzdj006 
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
 
#+ 此段落由子樣板a26產生
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

   OPTIONS FIELD ORDER FORM,
           INPUT WRAP
 
   LET g_forupd_sql = "SELECT dzdj001,dzdj008,dzdj006,dzdj003,dzdjownid,'',dzdjowndp,'',dzdjcrtid,'',dzdjcrtdp,'',dzdjcrtdt,dzdjmodid,'',dzdjmoddt,dzdjcnfid,'',dzdjcnfdt FROM dzdj_t WHERE dzdj001=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE adzi460_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi460 WITH FORM cl_ap_formpath("adz",g_code)
 
   #程式初始化
   CALL adzi460_init()   
   
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

   LET g_today = cl_get_current() #161011-00030

   #進入選單 Menu (="N")
   CALL adzi460_ui_dialog() 
 
   CLOSE adzi460_cl
   #畫面關閉
   CLOSE WINDOW w_adzi460
   
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi460_init()
   CALL cl_set_combo_scc('dzdj008','460')
   CALL adzi460_default_search()
 
END FUNCTION
 
 
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi460_ui_dialog() 
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_wc    LIKE type_t.chr200
   DEFINE li_idx   LIKE type_t.num5
   
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   
   LET g_main_hidden = 1
 
   WHILE li_exit = FALSE
      
      CALL adzi460_browser_fill(g_wc,"")
      #CALL cl_notice() #2015/04/09 by Hiko
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_dzdj001 = g_dzdj001_t
 
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
    
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
               
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL adzi460_fetch("")   
               END IF               
            
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            ON ACTION close
               LET li_exit = TRUE
               EXIT MENU
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            #IF cl_auth_chk_act("delete") THEN #20160115 by Hiko
               CALL adzi460_delete()
            #END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            #IF cl_auth_chk_act("insert") THEN #20160115 by Hiko
               CALL adzi460_insert()
                EXIT MENU
            #END IF
 
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            #IF cl_auth_chk_act("modify") THEN #20160115 by Hiko
               CALL adzi460_modify()
                EXIT MENU
            #END IF
 
         ON ACTION query
 
            LET g_action_choice="query"
            #IF cl_auth_chk_act("query") THEN #20160115 by Hiko
               CALL adzi460_query()
            #END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            #IF cl_auth_chk_act("reproduce") THEN #20160115 by Hiko
               CALL adzi460_reproduce()
                EXIT MENU
            #END IF
 
            
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
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
                  #CALL cl_show_fld_cont() #2015/04/09 by Hiko : 不要show hint    
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL adzi460_fetch("")      
            
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
                  CALL adzi460_fetch("")   
               END IF               
            
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            ON ACTION close
               LET li_exit = TRUE
               EXIT DIALOG
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            #IF cl_auth_chk_act("delete") THEN #20160115 by Hiko
               CALL adzi460_delete()
            #END IF
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            #IF cl_auth_chk_act("insert") THEN #20160115 by Hiko
               CALL adzi460_insert()
                EXIT DIALOG
            #END IF
 
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            #IF cl_auth_chk_act("modify") THEN #20160115 by Hiko
               CALL adzi460_modify()
                EXIT DIALOG
            #END IF
 
         ON ACTION query
 
            LET g_action_choice="query"
            #IF cl_auth_chk_act("query") THEN #20160115 by Hiko
               CALL adzi460_query()
            #END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            #IF cl_auth_chk_act("reproduce") THEN #20160115 by Hiko
               CALL adzi460_reproduce()
                EXIT DIALOG
            #END IF
 
 
            #主選單用ACTION
            &include "main_menu.4gl"
            
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
   END WHILE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzi460_browser_search(p_type)
   DEFINE p_type      LIKE type_t.chr10
   DEFINE li_wc       STRING
     
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
      LET li_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET li_wc = li_wc.toLowerCase()
   ELSE
      LET li_wc = " 1=1 "
   END IF         
   
   LET li_wc = li_wc, " ORDER BY dzdj001"
   
   LET g_wc = li_wc
   
   CALL adzi460_browser_fill(li_wc,"F")
 
   RETURN TRUE
 
END FUNCTION
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi460_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   
   CLEAR FORM
   INITIALIZE g_dzdj_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "dzdj001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM dzdj_t ",
               "  ",
               "  ",
               " WHERE  ", 
               p_wc CLIPPED
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
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
   
   LET l_sql_rank = "SELECT dzdj001,dzdj008,dzdj006,RANK() OVER(ORDER BY dzdj001 ",
 
                    g_order,
                    ") AS RANK ",
                    " FROM dzdj_t ",
                    "  ",
                    "  ",
                    " WHERE  ", g_wc
 
   #定義翻頁CURSOR
   LET g_sql= " SELECT dzdj001,dzdj008,dzdj006 FROM (",l_sql_rank,") ",
              "  WHERE RANK >= ", g_pagestart,
              "    AND RANK <  ", (g_pagestart + g_max_browse) , 
              "  ORDER BY ",l_searchcol," ",g_order
              
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzdj001,g_browser[g_cnt].b_dzdj008,g_browser[g_cnt].b_dzdj006   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #LET g_dzdi003 = s_chr_trim(g_browser[g_cnt].b_dzdj001)
      LET g_dzdi003 = g_browser[g_cnt].b_dzdj001 CLIPPED
      CALL sadz_get_name("dzdj_t","dzdj001",g_dzdi003) RETURNING g_browser[g_cnt].b_dzdj001_desc
      
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
   #該樣板不需此段落LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_rec_b
   #該樣板不需此段落LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0
   
   #CALL adzi460_fetch("") #2015/04/09 by Hiko
   
   FREE browse_pre
   
END FUNCTION
 
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi460_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   
   CLEAR FORM
   INITIALIZE g_dzdj_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON dzdj001,dzdj008,dzdj006,dzdj003,dzdjownid,dzdjowndp,dzdjcrtid,dzdjcrtdp,dzdjcrtdt,dzdjmodid,dzdjmoddt,dzdjcnfid,dzdjcnfdt
      
         BEFORE CONSTRUCT                                    
            CALL cl_qbe_init()    
         
         ##----<<dzdjcrtdt>>----
         AFTER FIELD dzdjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdjmoddt>>----
         AFTER FIELD dzdjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdjcnfdt>>----
         AFTER FIELD dzdjcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdjownid>>----
         #Ctrlp:construct.c.dzdjownid
         ON ACTION controlp INFIELD dzdjownid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdjownid  #顯示到畫面上

            NEXT FIELD dzdjownid                     #返回原欄位
 
         #----<<dzdjowndp>>----
         #Ctrlp:construct.c.dzdjowndp
         ON ACTION controlp INFIELD dzdjowndp
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdjowndp  #顯示到畫面上

            NEXT FIELD dzdjowndp                     #返回原欄位
 
         #----<<dzdjcrtid>>----
         #Ctrlp:construct.c.dzdjcrtid
         ON ACTION controlp INFIELD dzdjcrtid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdjcrtid  #顯示到畫面上

            NEXT FIELD dzdjcrtid                     #返回原欄位

         #----<<dzdjcrtdp>>----
         #Ctrlp:construct.c.dzdjcrtdp
         ON ACTION controlp INFIELD dzdjcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdjcrtdp  #顯示到畫面上

            NEXT FIELD dzdjcrtdp                     #返回原欄位
 
         #----<<dzdjmodid>>----
         #Ctrlp:construct.c.dzdjmodid
         ON ACTION controlp INFIELD dzdjmodid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdjmodid  #顯示到畫面上

            NEXT FIELD dzdjmodid                     #返回原欄位
 
         #----<<dzdjcnfid>>----
         #Ctrlp:construct.c.dzdjcnfid
         ON ACTION controlp INFIELD dzdjcnfid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdjcnfid  #顯示到畫面上

            NEXT FIELD dzdjcnfid                     #返回原欄位
 
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
PRIVATE FUNCTION adzi460_query()
   DEFINE ls_wc STRING
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc

   INITIALIZE g_dzdj_m.* TO NULL
   ERROR ""
 
   CALL adzi460_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzi460_browser_fill(g_wc,"F")
      CALL adzi460_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   CALL adzi460_browser_fill(g_wc,"F")   # 移到第一頁
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   #第一層模糊搜尋
   IF g_browser.getLength() = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      CALL adzi460_browser_fill(g_wc,"F")
   END IF
   
   #第二層助記碼搜尋
   IF g_browser.getLength() = 0 THEN
      IF NOT cl_null(g_wc) THEN
         CALL adzi460_browser_fill(g_wc,"F")
      END IF
      
   END IF
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      CALL adzi460_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi460_fetch(p_fl)
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
   
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
 
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   LET g_dzdj_m.dzdj001 = g_browser[g_current_idx].b_dzdj001
 
                       
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE dzdj001,dzdj008,dzdj006,dzdj003,dzdjownid,dzdjowndp,dzdjcrtid,dzdjcrtdp,dzdjcrtdt,dzdjmodid,dzdjmoddt,dzdjcnfid,dzdjcnfdt
 INTO g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfdt
 FROM dzdj_t
 WHERE dzdj001 = g_dzdj_m.dzdj001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdj_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      INITIALIZE g_dzdj_m.* TO NULL
      RETURN
   END IF
 
   #yemy 20130905  --Begin
   #LET g_dzdi003 = s_chr_trim(g_browser[g_current_idx].b_dzdj001) #2015/11/26 by Hiko
   LET g_dzdi003 = g_browser[g_current_idx].b_dzdj001 CLIPPED
   CALL sadz_get_name("dzdj_t","dzdj001",g_dzdi003) RETURNING g_browser[g_current_idx].b_dzdj001_desc
   #yemy 20130905  --End  


   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,reproduce", TRUE)
   END IF
   
   
   #重新顯示
   CALL adzi460_show()
 
END FUNCTION
 
 
#+ 資料新增
PRIVATE FUNCTION adzi460_insert()
   
   CLEAR FORM                    #清畫面欄位內容
 
   INITIALIZE g_dzdj_m.* LIKE dzdj_t.*             #DEFAULT 設定
 
   CALL s_transaction_begin()
   
   WHILE TRUE
      #公用欄位給值
      #此段落由子樣板a14產生    
      LET g_dzdj_m.dzdjownid = g_user
      LET g_dzdj_m.dzdjowndp = g_dept
      LET g_dzdj_m.dzdjcrtid = g_user
      LET g_dzdj_m.dzdjcrtdp = g_dept 
      LET g_dzdj_m.dzdjcrtdt = cl_get_current()
 
      LET g_dzdj_m.dzdj006 = 'N'
     
      CALL adzi460_input("a")
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdj_m.* = g_dzdj_m_t.*
         CALL adzi460_show()
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
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR ( ",
              " dzdj001 = '", g_dzdj_m.dzdj001 CLIPPED, "' "
 
              , ") "
 
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION adzi460_modify()
   IF g_dzdj_m.dzdj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF 
   
    SELECT UNIQUE dzdj001,dzdj008,dzdj006,dzdj003,dzdjownid,dzdjowndp,dzdjcrtid,dzdjcrtdp,dzdjcrtdt,dzdjmodid,dzdjmoddt,dzdjcnfid,dzdjcnfdt
 INTO g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfdt
 FROM dzdj_t
 WHERE dzdj001 = g_dzdj_m.dzdj001
 
   ERROR ""
  
   LET g_dzdj001_t = g_dzdj_m.dzdj001
 
   
   CALL s_transaction_begin()
   
   OPEN adzi460_cl USING g_dzdj_m.dzdj001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi460_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi460_cl INTO g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjownid_desc,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjowndp_desc,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtid_desc,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdp_desc,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmodid_desc,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfid_desc,g_dzdj_m.dzdjcnfdt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdj_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   CALL adzi460_show()
   
   WHILE TRUE
      LET g_dzdj_m.dzdj001 = g_dzdj001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_dzdj_m.dzdjmodid = g_user 
      LET g_dzdj_m.dzdjmoddt = cl_get_current()
 
      CALL adzi460_input("u")     #欄位更改
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdj_m.* = g_dzdj_m_t.*
         CALL adzi460_show()
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
   IF NOT cl_used_modified_record(g_dzdj_m.dzdj001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adzi460_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_dzdj_m.dzdj001,"U")
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION adzi460_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_success       LIKE type_t.num5    #wujie add
   #Begin:161011-00030
   DEFINE ls_trans_lang   STRING,
          ls_lang_content STRING
   #End:161011-00030
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL adzi460_set_entry(p_cmd)
   CALL adzi460_set_no_entry(p_cmd)
 
#  DISPLAY BY NAME g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003
   
display 'here'
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_dzdj_m.dzdj001,g_dzdj_m.dzdj001_desc,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            #其他table資料備份(確定是否更改用)
            
          
         #---------------------------<  Master  >---------------------------
         #此段落由子樣板a02產生
         AFTER FIELD dzdj001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdj_m.dzdj001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_dzdj_m.dzdj001 != g_dzdj001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdj_t WHERE "||"dzdj001 = '"||g_dzdj_m.dzdj001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
        #Begin:161011-00030
        #BEFORE FIELD dzdj001_desc
        #  LET g_dzdj_m_t.dzdj001_desc = GET_FLDBUF(dzdj001_desc)

        #AFTER FIELD dzdj001_desc
        #   IF g_dzdj_m_t.dzdj001_desc != g_dzdj_m.dzdj001_desc
        #   OR (g_dzdj_m_t.dzdj001_desc IS NOT NULL AND g_dzdj_m.dzdj001_desc IS NULL)
        #   OR (g_dzdj_m_t.dzdj001_desc IS NULL AND g_dzdj_m.dzdj001_desc IS NOT NULL)
        #   THEN
        #       #LET g_dzdi003 = s_chr_trim(g_dzdj_m.dzdj001) #2015/11/26 by Hiko
        #       LET g_dzdi003 = g_dzdj_m.dzdj001 CLIPPED
        #       CALL sadz_edit_name("dzdj_t","dzdj001",g_dzdi003) RETURNING l_success
        #       CALL sadz_get_name("dzdj_t","dzdj001",g_dzdi003) RETURNING g_dzdj_m.dzdj001_desc
        #       DISPLAY g_dzdj_m.dzdj001_desc TO FORMONLY.dzdj001_desc
        #       #CALL cl_show_fld_cont() #2015/04/09 by Hiko : 不要show hint
        #   END IF
        
        #ON ACTION update_item
        #   CASE
        #      WHEN INFIELD(dzdj001_desc)
        #         #LET g_dzdi003 = s_chr_trim(g_dzdj_m.dzdj001) #2015/11/26 by Hiko
        #         LET g_dzdi003 = g_dzdj_m.dzdj001
        #         CALL sadz_edit_name("dzdj_t","dzdj001",g_dzdi003) RETURNING l_success
        #         CALL sadz_get_name("dzdj_t","dzdj001",g_dzdi003) RETURNING g_dzdj_m.dzdj001_desc
        #         DISPLAY g_dzdj_m.dzdj001_desc TO FORMONLY.dzdj001_desc
        #         #CALL cl_show_fld_cont() #2015/04/09 by Hiko : 不要show hint
        #   END CASE
        #End:161011-00030

       #  #----<<dzdjownid>>----
       #  #此段落由子樣板a02產生
       #  AFTER FIELD dzdjownid
       #     
       #     INITIALIZE g_ref_fields TO NULL
       #     LET g_ref_fields[1] = g_dzdj_m.dzdjownid
       #     CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
       #     LET g_dzdj_m.dzdjownid_desc = '', g_rtn_fields[1] , ''
       #     DISPLAY BY NAME g_dzdj_m.dzdjownid_desc
 
         #Begin:161011-00030
         ##----<<dzdjowndp>>----
         ##此段落由子樣板a02產生
         #AFTER FIELD dzdjowndp
         #   INITIALIZE g_ref_fields TO NULL
         #   LET g_ref_fields[1] = g_dzdj_m.dzdjowndp
         #   CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #   LET g_dzdj_m.dzdjowndp_desc = '', g_rtn_fields[1] , ''
         #   DISPLAY BY NAME g_dzdj_m.dzdjowndp_desc
         
         ##----<<dzdjcrtid>>----
         ##此段落由子樣板a02產生
         #AFTER FIELD dzdjcrtid
         #   INITIALIZE g_ref_fields TO NULL
         #   LET g_ref_fields[1] = g_dzdj_m.dzdjcrtid
         #   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
         #   LET g_dzdj_m.dzdjcrtid_desc = '', g_rtn_fields[1] , ''
         #   DISPLAY BY NAME g_dzdj_m.dzdjcrtid_desc
         
         ##----<<dzdjcrtdp>>----
         ##此段落由子樣板a02產生
         #AFTER FIELD dzdjcrtdp
         #   INITIALIZE g_ref_fields TO NULL
         #   LET g_ref_fields[1] = g_dzdj_m.dzdjcrtdp
         #   CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #   LET g_dzdj_m.dzdjcrtdp_desc = '', g_rtn_fields[1] , ''
         #   DISPLAY BY NAME g_dzdj_m.dzdjcrtdp_desc
         
         
         ##----<<dzdjmodid>>----
         ##此段落由子樣板a02產生
         #AFTER FIELD dzdjmodid
         #   
         #   INITIALIZE g_ref_fields TO NULL
         #   LET g_ref_fields[1] = g_dzdj_m.dzdjmodid
         #   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
         #   LET g_dzdj_m.dzdjmodid_desc = '', g_rtn_fields[1] , ''
         #   DISPLAY BY NAME g_dzdj_m.dzdjmodid_desc
         
         
         ##----<<dzdjcnfid>>----
         ##此段落由子樣板a02產生
         #AFTER FIELD dzdjcnfid
         #   INITIALIZE g_ref_fields TO NULL
         #   LET g_ref_fields[1] = g_dzdj_m.dzdjcnfid
         #   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
         #   LET g_dzdj_m.dzdjcnfid_desc = '', g_rtn_fields[1] , ''
         #   DISPLAY BY NAME g_dzdj_m.dzdjcnfid_desc
         #End:161011-00030
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            CALL cl_showmsg()   #錯誤訊息統整顯示
 
            IF p_cmd <> "u" THEN
               LET l_count = 1  
 
               SELECT COUNT(*) INTO l_count FROM dzdj_t
                WHERE  dzdj001 = g_dzdj_m.dzdj001
 
               IF l_count = 0 THEN
               
                  INSERT INTO dzdj_t (dzdj001,dzdj008,dzdj006,dzdj003,dzdjownid,dzdjowndp,dzdjcrtid,dzdjcrtdp,dzdjcrtdt,dzdjmodid,dzdjmoddt,dzdjcnfid,dzdjcnfdt)
                  VALUES (g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfdt) # DISK WRITE
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "dzdj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "std-00006"
                  LET g_errparam.extend =  "g_dzdj_m.dzdj001"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               UPDATE dzdj_t SET (dzdj001,dzdj008,dzdj006,dzdj003,dzdjownid,dzdjowndp,dzdjcrtid,dzdjcrtdp,dzdjcrtdt,dzdjmodid,dzdjmoddt,dzdjcnfid,dzdjcnfdt) = (g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfdt)
                WHERE  dzdj001 = g_dzdj001_t #
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdj_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF

            #Begin:161011-00030
            CALL adzi460_update_dzdi_t(g_dzdj_m.dzdj001, g_lang, g_dzdj_m.dzdj001_desc)
            #若是簡中/繁中, 則多做一次互換動作.
            IF g_lang="zh_TW" OR g_lang="zh_CN" THEN
               CASE g_lang
                  WHEN "zh_TW"
                     LET ls_trans_lang = "zh_CN"
                  WHEN "zh_CN"
                     LET ls_trans_lang = "zh_TW"
               END CASE

               CALL cl_trans_code_tw_cn(ls_trans_lang, g_dzdj_m.dzdj001_desc) RETURNING ls_lang_content
               CALL adzi460_update_dzdi_t(g_dzdj_m.dzdj001, ls_trans_lang, ls_lang_content)
            END IF
            #End:161011-00030
 
           #controlp
      END INPUT
 
      BEFORE DIALOG
display 'before dialog'

      ON ACTION accept
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
 
PRIVATE FUNCTION adzi460_update_dzdi_t(p_key, p_lang, p_desc)
   DEFINE p_key  LIKE dzdi_t.dzdi003,
          p_lang LIKE dzdi_t.dzdi004,
          p_desc LIKE dzdi_t.dzdi005
   DEFINE l_count SMALLINT

   SELECT COUNT(*) INTO l_count FROM dzdi_t
    WHERE dzdi001 = 'dzdj_t' AND dzdi002='dzdj001' AND dzdi003=p_key AND dzdi004=p_lang
   IF l_count>0 THEN
      UPDATE dzdi_t
         SET dzdi005 = p_desc,
             dzdimodid= g_user,
             dzdimoddt= g_today
       WHERE dzdi001 = 'dzdj_t'
         AND dzdi002 = 'dzdj001'
         AND dzdi003 = p_key
         AND dzdi004 = p_lang
   ELSE
     INSERT INTO dzdi_t(dzdiownid,dzdiowndp,dzdicrtid,dzdicrtdp,
                        dzdicrtdt,dzdimodid,dzdimoddt,dzdicnfid,dzdicnfdt,
                        dzdi001,dzdi002,dzdi003,dzdi004,dzdi005)
                VALUES (g_user,g_dept,g_user,g_dept,
                        g_today,g_user,g_today,g_user,g_today,
                        'dzdj_t','dzdj001',p_key,p_lang,p_desc)
   END IF
END FUNCTION

#+ 資料複製
PRIVATE FUNCTION adzi460_reproduce()
   DEFINE l_newno     LIKE dzdj_t.dzdj001 
   DEFINE l_oldno     LIKE dzdj_t.dzdj001 
 
   DEFINE l_master    RECORD LIKE dzdj_t.*
   DEFINE l_cnt       LIKE type_t.num5
   
   IF g_dzdj_m.dzdj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   LET g_dzdj001_t = g_dzdj_m.dzdj001
 
    
   CALL adzi460_set_entry("a")
   CALL adzi460_set_no_entry("a")
 
   
   INPUT l_newno FROM dzdj001
 
      AFTER FIELD dzdj001
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         
 
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
      
         #確定該key值是否有重複定義
         IF g_dzdj_m.dzdj001 IS NULL  
 
         THEN
            NEXT FIELD dzdj001                                  
         END IF
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM dzdj_t 
          WHERE  dzdj001 = l_newno
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD dzdj001 
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
 
   SELECT * INTO l_master.* FROM dzdj_t 
    WHERE  dzdj001 = g_dzdj_m.dzdj001
 
   LET l_master.dzdj001 = l_newno
 
   
   #公用欄位給予預設值
   #此段落由子樣板a13產生
      LET l_master.dzdjownid = g_user
      LET l_master.dzdjowndp = g_dept
      LET l_master.dzdjcrtid = g_user
      LET l_master.dzdjcrtdp = g_dept 
      LET l_master.dzdjcrtdt = cl_get_current()
   
   INSERT INTO dzdj_t VALUES (l_master.*) #複製單頭  
   
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdj_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
   ERROR "ROW(",l_newno,") O.K"
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " dzdj001 = '", l_newno CLIPPED, "' "
 
              , ") "
   
                   
END FUNCTION
 
 
#+ 單頭資料重新顯示 
PRIVATE FUNCTION adzi460_show()
    LET g_dzdj_m.dzdj001_desc = ''
    CALL sadz_get_name("dzdj_t","dzdj001",g_dzdi003) RETURNING g_dzdj_m.dzdj001_desc
    DISPLAY g_dzdj_m.dzdj001_desc TO FORMONLY.dzdj001_desc
   
   
   LET g_dzdj_m_t.* = g_dzdj_m.*      #保存單頭舊值
   
   #在browser 移動上下筆可以連動切換資料
   #CALL cl_show_fld_cont() #2015/04/09 by Hiko : 不要show hint
   
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_dzdj_m.dzdjownid_desc = cl_get_username(g_dzdj_m.dzdjownid)
      #LET g_dzdj_m.dzdjowndp_desc = cl_get_deptname(g_dzdj_m.dzdjowndp)
      #LET g_dzdj_m.dzdjcrtid_desc = cl_get_username(g_dzdj_m.dzdjcrtid)
      #LET g_dzdj_m.dzdjcrtdp_desc = cl_get_deptname(g_dzdj_m.dzdjcrtdp)
      #LET g_dzdj_m.dzdjmodid_desc = cl_get_username(g_dzdj_m.dzdjmodid)
      #LET g_dzdj_m.dzdjcnfid_desc = cl_get_deptname(g_dzdj_m.dzdjcnfid)
      ##LET g_dzdj_m.dzdjpstid_desc = cl_get_deptname(g_dzdj_m.dzdjpstid)
      
 
 
   
   #讀入ref值(單頭)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdj_m.dzdjownid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdj_m.dzdjownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdj_m.dzdjownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdj_m.dzdjowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dzdj_m.dzdjowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdj_m.dzdjowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdj_m.dzdjcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdj_m.dzdjcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdj_m.dzdjcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdj_m.dzdjcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dzdj_m.dzdjcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdj_m.dzdjcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdj_m.dzdjmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdj_m.dzdjmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdj_m.dzdjmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdj_m.dzdjcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdj_m.dzdjcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdj_m.dzdjcnfid_desc

 
   #將資料輸出到畫面上 #161011-00030 : 顯現資料於畫面上
  DISPLAY BY NAME g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjownid_desc,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjowndp_desc,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtid_desc,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdp_desc,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmodid_desc,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfid_desc,g_dzdj_m.dzdjcnfdt
  #DISPLAY BY NAME g_dzdj_m.dzdj001_desc
END FUNCTION
 
 
#+ 資料刪除 
PRIVATE FUNCTION adzi460_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   
   IF g_dzdj_m.dzdj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_dzdj001_t = g_dzdj_m.dzdj001
   OPEN adzi460_cl USING 
                           g_dzdj_m.dzdj001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi460_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH adzi460_cl INTO g_dzdj_m.dzdj001,g_dzdj_m.dzdj008,g_dzdj_m.dzdj006,g_dzdj_m.dzdj003,g_dzdj_m.dzdjownid,g_dzdj_m.dzdjownid_desc,g_dzdj_m.dzdjowndp,g_dzdj_m.dzdjowndp_desc,g_dzdj_m.dzdjcrtid,g_dzdj_m.dzdjcrtid_desc,g_dzdj_m.dzdjcrtdp,g_dzdj_m.dzdjcrtdp_desc,g_dzdj_m.dzdjcrtdt,g_dzdj_m.dzdjmodid,g_dzdj_m.dzdjmodid_desc,g_dzdj_m.dzdjmoddt,g_dzdj_m.dzdjcnfid,g_dzdj_m.dzdjcnfid_desc,g_dzdj_m.dzdjcnfdt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzdj_m.dzdj001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   CALL adzi460_show()
   IF cl_ask_delete() THEN
      #刪除相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = g_dzdj_m.dzdj001
      LET g_pk_array[1].column = "dzdj001"
      CALL cl_doc_remove()
 
      DELETE FROM dzdj_t 
       WHERE  dzdj001 = g_dzdj_m.dzdj001 
 
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzdj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
  
      CLEAR FORM
      CALL adzi460_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL adzi460_fetch("P")
      ELSE
         CALL adzi460_browser_fill(" 1=1 ","F")
      END IF
      
   END IF
 
   CLOSE adzi460_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzdj_m.dzdj001,"D")
 
END FUNCTION
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi460_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzdj001 = g_dzdj_m.dzdj001 THEN  
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
PRIVATE FUNCTION adzi460_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("dzdj001",TRUE)
   END IF
 
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi460_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
 
   IF p_cmd = "u" THEN
      CALL cl_set_comp_entry("dzdj001",FALSE)
   END IF
END FUNCTION
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi460_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dzdj001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
 
END FUNCTION
