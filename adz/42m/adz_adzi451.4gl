##+ 程式版本......: T6 Version 1.00.00 Build-0002 at 13/01/17
##
##+ 程式代碼......: adzi451
##+ 設計人員......: zhangllc
##樣板功能名稱: code_t01 雙檔有Browser
# Modify.........: 20160331 160331-00017 by Hiko : 清除呼叫q_common的段落
 
IMPORT os
  
SCHEMA ds 
  
GLOBALS "../../cfg/top_global.inc"
  
{<Module define>}
  
#單頭 type 宣告
PRIVATE type type_g_dzde_m        RECORD
   dzde001 LIKE dzde_t.dzde001, 
   dzde002 LIKE dzde_t.dzde002, 
   dzde003 LIKE dzde_t.dzde003, 
   dzdestus LIKE dzde_t.dzdestus, 
   dzdemodid LIKE dzde_t.dzdemodid, 
   modu_desc LIKE type_t.chr500, 
   dzdemoddt DATETIME YEAR TO SECOND, 
   dzdeownid LIKE dzde_t.dzdeownid, 
   oriu_desc LIKE type_t.chr500, 
   dzdeowndp LIKE dzde_t.dzdeowndp, 
   orid_desc LIKE type_t.chr500, 
   dzdecrtid LIKE dzde_t.dzdecrtid, 
   user_desc LIKE type_t.chr500, 
   dzdecrtdp LIKE dzde_t.dzdecrtdp, 
   dept_desc LIKE type_t.chr500, 
   dzdecrtdt DATETIME YEAR TO SECOND
       END RECORD
 
#單身 type1 宣告
PRIVATE TYPE type_g_dzdf_d1       RECORD
       dzdf002_1 LIKE dzdf_t.dzdf002,
       dzdf002_1_desc  LIKE dzdi_t.dzdi005
       END RECORD
 
#單身 type2 宣告
PRIVATE TYPE type_g_dzdf_d2       RECORD
       dzdf002_2 LIKE dzdf_t.dzdf002
       END RECORD
 
PRIVATE TYPE type_g_4gl           RECORD
       pno         LIKE dzde_t.dzde001,
       dzde003_b3  LIKE dzde_t.dzde003
       END RECORD

#模組變數(Module Variables)
DEFINE g_dzde_m          type_g_dzde_m
DEFINE g_dzde_m_t        type_g_dzde_m
 
DEFINE g_dzde001_t     LIKE dzde_t.dzde001
DEFINE g_dzde002_t     LIKE dzde_t.dzde002
 
 
 
DEFINE g_dzdf_d1         DYNAMIC ARRAY OF type_g_dzdf_d1
DEFINE g_dzdf_d1_t       type_g_dzdf_d1
DEFINE g_dzdf_d2         DYNAMIC ARRAY OF type_g_dzdf_d2
DEFINE g_dzdf_d2_t       type_g_dzdf_d2
DEFINE g_4gl             DYNAMIC ARRAY OF type_g_4gl
DEFINE g_4gl_t           type_g_4gl
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
                    b_statepic   LIKE type_t.chr50,
                    b_dzde001    LIKE dzde_t.dzde001,
                    b_dzde002    LIKE dzde_t.dzde002,
                    b_dzde003    LIKE dzde_t.dzde003,
                    rank         LIKE type_t.num10
                    END RECORD 
      
#無單頭append欄位定義
#無單身append欄位定義
 
DEFINE g_wc                  STRING
DEFINE g_wc1                 STRING                          #第1個單身table所使用的g_wc
#DEFINE g_wc2                 STRING                          #第2個單身table所使用的g_wc
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_before_input_done   LIKE type_t.num5 
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_cnt1                LIKE type_t.num10
DEFINE g_cnt2                LIKE type_t.num10
DEFINE g_cnt3                LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE g_rec_b1              LIKE type_t.num5           
DEFINE g_rec_b2              LIKE type_t.num5           
DEFINE g_rec_b3              LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
DEFINE l_ac1                 LIKE type_t.num5    
DEFINE l_ac2                 LIKE type_t.num5    
DEFINE l_ac3                 LIKE type_t.num5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_dzdi003   LIKE dzdi_t.dzdi003
 
#+ 作業開始
MAIN
    
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")
   
   DISCONNECT "dsdemo"
   CONNECT TO "ds"

   #LOCK CURSOR
   LET g_forupd_sql = "SELECT dzde001,dzde002,dzde003,dzdestus,dzdemodid,'',dzdemoddt,dzdeownid,'',dzdeowndp,'',dzdecrtid,'',dzdecrtdp,'',dzdecrtdt FROM dzde_t WHERE dzde001=? AND dzde002=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi451_cl CURSOR FROM g_forupd_sql   #cursor lock 
   
   IF g_bgjob = "Y" THEN
 
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi451 WITH FORM cl_ap_formpath("adz",g_prog)
 
      #程式初始化
      CALL adzi451_init()
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #進入選單 Menu (='N')
      CALL adzi451_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_adzi451
   END IF
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
    
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi451_init()
   
   CALL cl_set_comp_visible('lbl_dzde002',FALSE)
   CALL cl_set_comp_visible('dzde002',FALSE)

   CALL cl_set_comp_visible('Grid1',FALSE)
   
   CALL adzi451_default_search()
    
END FUNCTION
 
 
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi451_ui_dialog()
   WHILE TRUE
      CALL adzi451_bp()
        
      CASE g_action_choice
 
         WHEN "query"
            IF cl_chk_act_auth() THEN 
               CALL adzi451_query()
            END IF
        #WHEN "modify"
        #   IF cl_chk_act_auth() THEN 
        #      CALL adzi451_modify()
        #   END IF
         WHEN "detail1"
            IF cl_chk_act_auth() THEN 
               CALL adzi451_b1()
            END IF
         WHEN "detail2"
            IF cl_chk_act_auth() THEN 
               CALL adzi451_b2()
            END IF
         WHEN "exit"
            EXIT WHILE
 
         WHEN "bw_first"     
            CALL adzi451_browser_fill("first") 
            
         WHEN "bw_prev" 
            CALL adzi451_browser_fill("prev")
            
         WHEN "bw_next" 
            CALL adzi451_browser_fill("next")
            
         WHEN "bw_last"             
            CALL adzi451_browser_fill("last")
 
      END CASE
      
   END WHILE
   
END FUNCTION
 
 
#+ 功能選單
PRIVATE FUNCTION adzi451_bp()
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   CALL adzi451_browser_fill("")
   

  #IF p_ud <> "G" OR g_action_choice = "detail1" OR g_action_choice = "detail2" THEN
  #   RETURN
  #END IF
  #LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   DIALOG ATTRIBUTES(UNBUFFERED)
 
      INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
      
         BEFORE INPUT
         
      END INPUT
 
      #左側瀏覽頁簽
      DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         BEFORE ROW
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            CALL adzi451_fetch('') # reload data
            CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            LET g_detail_idx = 1
           #CALL adzi451_ui_detailshow() #Setting the current row 
            LET l_ac1 = 1
            CALL adzi451_b_fill_2()
            CALL adzi451_b_fill_3()
            
      END DISPLAY
     
      DISPLAY ARRAY g_dzdf_d1 TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b1) #page1  
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac1 = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
           #CALL adzi451_ui_detailshow()
            CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
            CALL adzi451_b_fill_2()
            CALL adzi451_b_fill_3()
            
      END DISPLAY
     
      DISPLAY ARRAY g_dzdf_d2 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1  
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac2 = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)      
           #CALL adzi451_ui_detailshow()
            
      END DISPLAY

      DISPLAY ARRAY g_4gl TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1  
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac3 = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)      
           #CALL adzi451_ui_detailshow()
            
      END DISPLAY

      BEFORE DIALOG
         CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
         LET g_curr_diag = ui.DIALOG.getCurrent()         
         LET g_page = "first"
         LET g_current_sw = FALSE
         #回歸舊筆數位置 (回到當時異動的筆數)
         LET g_current_idx = DIALOG.getCurrentRow("s_browse")
         IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
            CALL DIALOG.setCurrentRow("s_browse",g_current_row)
            LET g_current_idx = g_current_row
         END IF
         LET g_current_row = g_current_idx #目前指標
         LET g_current_sw = TRUE
         
         IF g_current_idx > g_browser.getLength() THEN
            LEt g_current_idx = g_browser.getLength()
         END IF 
         
         #有資料才進行fetch
         IF g_current_idx <> 0 THEN
            CALL adzi451_fetch('') # reload data
         END IF
         CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
         LET g_detail_idx = 1
        #CALL adzi451_ui_detailshow() #Setting the current row 
         LET l_ac1 = 1
         CALL adzi451_b_fill_2()
         CALL adzi451_b_fill_3()
 
      #Browser用Action
 
      #一般搜尋
      ON ACTION searchdata
         #取得搜尋關鍵字
         INITIALIZE g_wc TO NULL
         INITIALIZE g_wc1 TO NULL
        #INITIALIZE g_wc2 TO NULL
 
         LET g_searchstr = GET_FLDBUF(searchstr)
         IF NOT adzi451_browser_search("normal") THEN
            CONTINUE DIALOG
         END IF
         LET g_current_idx = 1
         IF g_browser.getLength() = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = -100
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF   
         LET g_action_choice="searchdata"
         EXIT DIALOG
 
      #進階搜尋
      ON ACTION advancesearch    
      
      #升冪排序
      ON ACTION ascending
         INITIALIZE g_wc TO NULL
         INITIALIZE g_wc1 TO NULL
        #INITIALIZE g_wc2 TO NULL
         LET g_order = "ASC"
         LET g_current_idx = 1
         LET g_searchstr = GET_FLDBUF(searchstr)
         
         IF NOT adzi451_browser_search("normal") THEN
            CONTINUE DIALOG
         END IF
         IF g_browser.getLength() = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = -100
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF   
         LET g_action_choice="ASCENDING"
         EXIT DIALOG
    
      #降冪排序
      ON ACTION descending
         INITIALIZE g_wc TO NULL
         INITIALIZE g_wc1 TO NULL
        #INITIALIZE g_wc2 TO NULL
         LET g_order = "DESC"
         LET g_current_idx = 1
         LET g_searchstr = GET_FLDBUF(searchstr)
         
         IF NOT adzi451_browser_search("normal") THEN
            CONTINUE DIALOG
         END IF
         IF g_browser.getLength() = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = -100
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF   
         LET g_action_choice="DESCENDING"
         EXIT DIALOG
         
      ON ACTION statechange
         CALL adzi451_statechange()
         LET g_action_choice="statechange"
         EXIT DIALOG
 
      #簽核
      ON ACTION signature
         MENU "" ATTRIBUTES( STYLE="popup", IMAGE="tb/authorize/terminate.png" )
            ON ACTION ef_sign
            ON ACTION stop_authflow
            ON ACTION add_auth
            ON ACTION revoke_auth
            ON ACTION approve
            ON ACTION unapprove
            ON ACTION auth_opinion
            ON ACTION auth_status
            ON ACTION auth_attach
            ON ACTION authflow_designer
         END MENU
       
      #ACTION表單列
      ON ACTION first
         CALL adzi451_fetch('F')  
         CALL adzi451_b_fill_2()
         CALL adzi451_b_fill_3()
         LET g_current_row = g_current_idx
       
      ON ACTION previous
         CALL adzi451_fetch('P')
         CALL adzi451_b_fill_2()
         CALL adzi451_b_fill_3()
         LET g_current_row = g_current_idx
       
      ON ACTION jump
         CALL adzi451_fetch('/')
         CALL adzi451_b_fill_2()
         CALL adzi451_b_fill_3()
         LET g_current_row = g_current_idx
     
      ON ACTION next
         CALL adzi451_fetch('N')
         CALL adzi451_b_fill_2()
         CALL adzi451_b_fill_3()
         LET g_current_row = g_current_idx
         
      
      ON ACTION last
         CALL adzi451_fetch('L')
         CALL adzi451_b_fill_2()
         CALL adzi451_b_fill_3()
         LET g_current_row = g_current_idx
       
      ON ACTION close
         LET INT_FLAG=FALSE        
         LET g_action_choice = "exit"
         EXIT DIALOG     
       
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
       
      ON ACTION bw_first               #page first 
         LET g_action_choice = "bw_first"   
         EXIT DIALOG
 
      ON ACTION bw_prev                #page previous
         LET g_action_choice = "bw_prev"     
         EXIT DIALOG
 
      ON ACTION bw_next                #page next
         LET g_action_choice = "bw_next"     
         EXIT DIALOG
       
      ON ACTION bw_last                #page last 
         LET g_action_choice = "bw_last"     
         EXIT DIALOG
 
      ON ACTION mainhidden       #主頁摺疊
         IF g_main_hidden THEN
            CALL gfrm_curr.setElementHidden("mainlayout",0)
            CALL gfrm_curr.setElementImage("mainhidden","small/arr-r.png")
            LET g_main_hidden = 0
         ELSE
            CALL gfrm_curr.setElementHidden("mainlayout",1)
            CALL gfrm_curr.setElementImage("mainhidden","small/arr-l.png")
            LET g_main_hidden = 1
         END IF
 
      ON ACTION worksheethidden   #瀏覽頁折疊
         IF g_worksheet_hidden THEN
            CALL gfrm_curr.setElementHidden("worksheet",0)
            CALL gfrm_curr.setElementImage("worksheethidden","small/arr-l.png")
            LET g_worksheet_hidden = 0
            NEXT FIELD b_dzde001
         ELSE
            CALL gfrm_curr.setElementHidden("worksheet",1)
            CALL gfrm_curr.setElementImage("worksheethidden","small/arr-r.png")
            LET g_worksheet_hidden = 1
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
 
      ON ACTION query
            LET g_action_choice="query"
            EXIT DIALOG 
 
     #ON ACTION modify
     #      LET g_action_choice="modify"
     #      EXIT DIALOG 
      ON ACTION detail1
            LET g_action_choice="detail1"
            EXIT DIALOG 
      ON ACTION detail2
            LET g_action_choice="detail2"
            EXIT DIALOG 
 
     #ON ACTION accept
     #   LET g_action_choice="detail"
     #   EXIT DIALOG
      
      #主選單用ACTION
      &include "main_menu.4gl"
      
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
         
   END DIALOG
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzi451_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   
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
      LET g_wc = g_wc, " ORDER BY dzde001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
   DISPLAY "g_wc:",g_wc
   CALL adzi451_browser_fill("first")
   CALL ui.Interface.refresh()
   RETURN TRUE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi451_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc1             STRING
  #DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzde_m.* TO NULL
   CALL g_dzdf_d1.clear()        
   CALL g_dzdf_d2.clear()        
   CALL g_4gl.clear()        
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "dzde001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc1 = g_wc1.trim() 
  #LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   LET l_wc1 = cl_replace_str(l_wc1,'dzdf','a.dzdf')
  #LET l_wc2 = cl_replace_str(l_wc2,'dzdf','b.dzdf')
   
  #IF g_wc2 <> " 1=1" THEN
  #   IF g_wc1 <> " 1=1" THEN
  #      #單身有輸入搜尋條件
  #      LET l_sub_sql = " SELECT UNIQUE dzde001,dzde002 ",
  #                        " FROM dzde_t ",
  #                              " LEFT JOIN dzdf_t a ON dzde001 = a.dzdf001 where a.dzdf003='Y' ",
  #                              " LEFT JOIN dzdf_t b ON dzde001 = b.dzdf001 where.dzdf003='N' ",
  #                       " WHERE ",l_wc, " AND ", l_wc1, " AND ", l_wc2

  #   ELSE
  #      #單身未輸入搜尋條件
  #      LET l_sub_sql = " SELECT UNIQUE dzde001,dzde002 ",
  #                        " FROM dzde_t ",
  #                              " LEFT JOIN dzdf_t b ON dzde001 = b.dzdf001 where b.dzdf003='N' ",
  #                        "WHERE ",l_wc CLIPPED, " AND ", l_wc2

  #   END IF
  #ELSE
      IF g_wc1 <> " 1=1" THEN
         #元件單身有輸入搜尋條件
         LET l_sub_sql = " SELECT UNIQUE dzde001,dzde002 ",
                           " FROM dzde_t ",
                                 " LEFT JOIN dzdf_t a ON dzde001 = a.dzdf001 AND dzdf003='Y'",
                          " WHERE ",l_wc, " AND ", l_wc1
   
      ELSE
         #單身未輸入搜尋條件
         LET l_sub_sql = " SELECT UNIQUE dzde001,dzde002 ",
                           " FROM dzde_t ",
                           "WHERE ",l_wc CLIPPED
   
      END IF
  #END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
 
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
         LET g_pagestart = g_pagestart - 25
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "next"  
         LET g_pagestart = g_pagestart + 25
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 25) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - 25
            END WHILE
         END IF
      
      WHEN "last"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 25) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - 25
         END WHILE
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc1 <> " 1=1" AND NOT cl_null(g_wc1) THEN 
      #依照dzde001,dzde002,dzde003 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT dzdestus,dzde001,dzde002,dzde003,RANK() OVER(ORDER BY dzde001 ",g_order,") AS RANK ",
                        " FROM dzde_t ",
                              " LEFT JOIN dzdf_t ON dzde001 = dzdf001 AND dzdf003='Y' ",
                       " WHERE  ",g_wc," AND ",g_wc1
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT dzdestus,dzde001,dzde002,dzde003,RANK() OVER(ORDER BY dzde001 ",g_order,") AS RANK ",
                       " FROM dzde_t ",
                       " WHERE  ", g_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT dzdestus,dzde001,dzde002,dzde003,RANK FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK<",g_pagestart+25,
              " ORDER BY ",l_searchcol," ",g_order
                
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_dzde001,g_browser[g_cnt].b_dzde002,g_browser[g_cnt].b_dzde003    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      LET g_browser[g_cnt].b_statepic = cl_get_actipic(g_browser[g_cnt].b_statepic)
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
END FUNCTION
 
 
#+ 單身資料重新顯示
PRIVATE FUNCTION adzi451_ui_detailshow()
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
END FUNCTION
 
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi451_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzde001 = g_dzde_m.dzde001 
      #key2
         AND g_browser[l_i].b_dzde002 = g_dzde_m.dzde002 
 
 
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
 
 
#+ QBE資料查詢
PRIVATE FUNCTION adzi451_construct()
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_dzde_m.* TO NULL
   CALL g_dzdf_d1.clear()        
   CALL g_dzdf_d2.clear()        
   CALL g_4gl.clear()        
 
   
   LET g_current_idx = 1
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc1 TO NULL
  #INITIALIZE g_wc2 TO NULL
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dzde001,dzde002,dzde003,dzdestus,dzdemodid,dzdemoddt,dzdeownid,dzdeowndp,dzdecrtid,dzdecrtdp,dzdecrtdt
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            
         #Begin:160331-00017
         ##----<<dzdemodid>>----
         #ON ACTION controlp INFIELD dzdemodid
         #   CALL q_common('dzde_t','dzdemodid',TRUE,FALSE,g_dzde_m.dzdemodid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdemodid
         #   NEXT FIELD dzdemodid
         
         ##----<<dzdeownid>>----
         #ON ACTION controlp INFIELD dzdeownid
         #   CALL q_common('dzde_t','dzdeownid',TRUE,FALSE,g_dzde_m.dzdeownid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdeownid
         #   NEXT FIELD dzdeownid
         
         ##----<<dzdecrtid>>----
         #ON ACTION controlp INFIELD dzdecrtid
         #   CALL q_common('dzde_t','dzdecrtid',TRUE,FALSE,g_dzde_m.dzdecrtid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdecrtid
         #   NEXT FIELD dzdecrtid
         
         ##----<<dzdeowndp>>----
         #ON ACTION controlp INFIELD dzdeowndp
         #   CALL q_common('dzde_t','dzdeowndp',TRUE,FALSE,g_dzde_m.dzdeowndp) RETURNING ls_return
         #   DISPLAY ls_return TO dzdeowndp
         #   NEXT FIELD dzdeowndp
         
         ##----<<dzdecrtdp>>----
         #ON ACTION controlp INFIELD dzdecrtdp
         #   CALL q_common('dzde_t','dzdecrtdp',TRUE,FALSE,g_dzde_m.dzdecrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO dzdecrtdp
         #   NEXT FIELD dzdecrtdp
         #End:160331-00017
 
         #----<<dzdecrtdt>>----
         AFTER FIELD dzdecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdemoddt>>----
         AFTER FIELD dzdemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc1 ON dzdf002_1
           FROM s_detail1[1].dzdf002_1
                      
        #BEFORE CONSTRUCT
        #   CALL cl_qbe_display_condition(lc_qbe_sn)
         
      END CONSTRUCT
      
     #CONSTRUCT g_wc2 ON dzdf002_2
     #     FROM s_detail2[1].dzdf002_2

     #   BEFORE CONSTRUCT
     #      CALL cl_qbe_display_condition(lc_qbe_sn)


     #END CONSTRUCT
 
      
 
      BEFORE DIALOG
         #add-point:bp段b_dialog
         {<point name="cs.b_dialog"/>}
         #end add-point  
 
      #ON ACTION qbe_select     #條件查詢
      #   CALL cl_qbe_list() RETURNING lc_qbe_sn
      #   CALL cl_qbe_display_condition(lc_qbe_sn)
 
      #ON ACTION qbe_save       #條件儲存
      #   CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   IF INT_FLAG THEN
      RETURN
   END IF

   LET g_wc1 = cl_replace_str(g_wc1,'dzdf002_1','dzdf002')
  #LET g_wc2 = cl_replace_str(g_wc2,'dzdf002_2','dzdf002')
   
END FUNCTION
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi451_query()
   
   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_dzdf_d1.clear()
   CALL g_dzdf_d2.clear()
   CALL g_4gl.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   
   CALL adzi451_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_dzde_m.* TO NULL
      LET g_wc = " 1=1"
     #LET g_wc2 = " 1=1"
      RETURN
   END IF
 
   CALL adzi451_browser_fill("first")
         
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
 
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi451_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
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
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   LET g_dzde_m.dzde001 = g_browser[g_current_idx].b_dzde001
      #key2
   LET g_dzde_m.dzde002 = g_browser[g_current_idx].b_dzde002
 
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE dzde001,dzde002,dzde003,dzdestus,dzdemodid,dzdemoddt,dzdeownid,dzdeowndp,dzdecrtid,dzdecrtdp,dzdecrtdt
 INTO g_dzde_m.dzde001,g_dzde_m.dzde002,g_dzde_m.dzde003,g_dzde_m.dzdestus,g_dzde_m.dzdemodid,g_dzde_m.dzdemoddt,g_dzde_m.dzdeownid,g_dzde_m.dzdeowndp,g_dzde_m.dzdecrtid,g_dzde_m.dzdecrtdp,g_dzde_m.dzdecrtdt
 FROM dzde_t
 WHERE dzde001 = g_dzde_m.dzde001 AND dzde002 = g_dzde_m.dzde002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzde_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      INITIALIZE g_dzde_m.* TO NULL
      RETURN
   END IF
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
     #CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      CALL cl_set_act_visible("statechange,detail1,detail2,delete", FALSE)
   ELSE
      IF g_dzde_m.dzdestus = "Y" THEN
        #CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
         CALL cl_set_act_visible("statechange,detail1,detail2,delete", TRUE)
      ELSE
        #CALL cl_set_act_visible("statechange,reproduce", TRUE)
         CALL cl_set_act_visible("statechange", TRUE)
         CALL cl_set_act_visible("detail1,detail2,delete", FALSE)
      END IF
   END IF
   
   
   
   LET g_data_owner = g_dzde_m.dzdecrtid      
   LET g_data_group = g_dzde_m.dzdecrtdp  
   
   #重新顯示   
   CALL adzi451_show()
 
END FUNCTION
 
PRIVATE FUNCTION adzi451_b1()
   {<Local define>}
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
 
   MESSAGE ''
 
   LET g_action_choice = ""
   IF cl_null(g_dzde_m.dzde001) OR cl_null(g_dzde_m.dzde002) THEN
      RETURN
   END IF
 
   LET g_forupd_sql = "SELECT dzdf002 FROM dzdf_t WHERE dzdf001=? AND dzdf002=? AND dzdf003='Y' FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi451_bcl_1 CURSOR FROM g_forupd_sql
   
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
  #LET g_qryparam.state = 'i'
 
  #CALL cl_set_head_visible("","YES")  
   
   CALL s_transaction_begin()
   DIALOG ATTRIBUTE(UNBUFFERED)
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzdf_d1 FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION
         
         BEFORE INPUT
            CALL g_dzdf_d1.deleteElement(g_cnt1) 
            LET g_rec_b1 = g_dzdf_d1.getLength()
            DISPLAY g_rec_b1 TO FORMONLY.cnt
            IF g_rec_b1 != 0 THEN
               CALL fgl_set_arr_curr(l_ac1)
            END IF
         
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx
         
           #CALL s_transaction_begin()

            OPEN adzi451_cl USING g_dzde_m.dzde001,g_dzde_m.dzde002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN adzi451_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CLOSE adzi451_cl
               CALL s_transaction_end('N',0)
               RETURN
            END IF
            FETCH adzi451_cl INTO g_dzde_m.dzde001,g_dzde_m.dzde002,g_dzde_m.dzde003,g_dzde_m.dzdestus,g_dzde_m.dzdemodid,g_dzde_m.modu_desc,g_dzde_m.dzdemoddt,g_dzde_m.dzdeownid,g_dzde_m.oriu_desc,g_dzde_m.dzdeowndp,g_dzde_m.orid_desc,g_dzde_m.dzdecrtid,g_dzde_m.user_desc,g_dzde_m.dzdecrtdp,g_dzde_m.dept_desc,g_dzde_m.dzdecrtdt # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = g_dzde_m.dzde001
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CLOSE adzi451_cl
               CALL s_transaction_end('N',0)
               RETURN
            END IF
            
           #LET g_rec_b1 = g_dzdf_d1.getLength()
           #IF g_rec_b1 >= l_ac1 AND NOT cl_null(g_dzdf_d1[l_ac1].dzdf002_1) THEN
            IF g_rec_b1 >= l_ac1 THEN
               LET l_cmd='u'
               LET g_dzdf_d1_t.* = g_dzdf_d1[l_ac1].*  #BACKUP
               OPEN adzi451_bcl_1 USING g_dzde_m.dzde001,g_dzdf_d1[l_ac1].dzdf002_1
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "adzi451_bcl_1"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi451_bcl_1 INTO g_dzdf_d1[l_ac1].dzdf002_1
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_dzdf_d1_t.dzdf002_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL adzi451_b_fill_2()
                  CALL adzi451_b_fill_3()
                  DISPLAY ARRAY g_dzdf_d2 TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1
                     BEFORE DISPLAY
                        EXIT DISPLAY
                  END DISPLAY
                  DISPLAY ARRAY g_4gl TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1
                     BEFORE DISPLAY
                        EXIT DISPLAY
                  END DISPLAY
                 #CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzdf_d1[l_ac1].* TO NULL 
            LET g_dzdf_d1_t.* = g_dzdf_d1[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
           #CALL adzi451_set_entry_b()
           #CALL adzi451_set_no_entry_b()
           #NEXT FIELD dzdf002_1
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dzdf_t 
             WHERE dzdf001 = g_dzde_m.dzde001
               AND dzdf002 = g_dzdf_d1[l_ac1].dzdf002_1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzde_m.dzde001
               LET gs_keys[2] = g_dzdf_d1[l_ac1].dzdf002_1
               LET gs_keys[3] = 'Y'
               LET gs_keys[4] = ''
               CALL adzi451_insert_b('dzdf_t',gs_keys)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_dzdf_d1[l_ac1].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dzdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            ELSE
               ERROR 'INSERT O.K'
               LET g_rec_b1=g_rec_b1+1
              #CALL s_transaction_end('Y')
               CALL adzi451_b_fill_2()
               CALL adzi451_b_fill_3()
              #DISPLAY g_rec_b1 TO FORMONLY.cnt
              #CLOSE adzi451_bcl_1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_dzdf_d1[l_ac1].dzdf002_1) THEN
               IF NOT cl_ask_del_detail() THEN
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE
               END IF
               DELETE FROM dzdf_t
                WHERE dzdf001 = g_dzde_m.dzde001 AND
                      dzdf002 = g_dzdf_d1_t.dzdf002_1
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               END IF 
               #删除其下Private
               DELETE FROM dzdf_t
                WHERE dzdf001 = g_dzde_m.dzde001 AND
                      dzdf004 = g_dzdf_d1_t.dzdf002_1
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               END IF 
               LET g_rec_b1 = g_rec_b1-1
              #DISPLAY g_rec_b1 TO FORMONLY.cnt
              #CALL s_transaction_end('Y',0)
               CALL adzi451_b_fill_2()
               CALL adzi451_b_fill_3()
               CLOSE adzi451_bcl_1
               LET l_count = g_dzdf_d1.getLength()
            END IF 
            
         AFTER FIELD dzdf002_1
            IF NOT cl_null(g_dzdf_d1[l_ac1].dzdf002_1)  THEN 
               #显示说明
               LET g_dzdi003 = s_chr_trim(g_dzdf_d1[l_ac1].dzdf002_1)
               LET g_dzdf_d1[l_ac1].dzdf002_1_desc = sadz_get_name("dzda_t","dzda001",g_dzdi003)

               IF  l_cmd = 'a'  OR ( l_cmd = 'u' AND g_dzdf_d1[l_ac1].dzdf002_1 != g_dzdf_d1_t.dzdf002_1) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdf_t WHERE "||"dzdf001 = '"||g_dzde_m.dzde001 ||"' AND "|| "dzdf002 = '"||g_dzdf_d1[l_ac1].dzdf002_1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD dzdf002_1
                  END IF
               END IF
               #需在adzi400中注册
               SELECT COUNT(*) INTO l_cnt FROM dzda_t WHERE dzda001 = g_dzdf_d1[l_ac1].dzdf002_1
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00143'
                  LET g_errparam.extend = g_dzdf_d1[l_ac1].dzdf002_1
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD dzdf002_1
               END IF
            END IF

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzdf_d1[l_ac1].* = g_dzdf_d1_t.*
               CLOSE adzi451_bcl_1
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzdf_d1[l_ac1].dzdf002_1
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzdf_d1[l_ac1].* = g_dzdf_d1_t.*
               CALL s_transaction_end('N',0)
            ELSE
            
               UPDATE dzdf_t SET (dzdf001,dzdf002) = (g_dzde_m.dzde001,g_dzdf_d1[l_ac1].dzdf002_1)
                WHERE dzdf001 = g_dzde_m.dzde001 
                  AND dzdf002 = g_dzdf_d1_t.dzdf002_1
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzdf_d1[l_ac1].* = g_dzdf_d1_t.*
                  CALL s_transaction_end('N',0)
               END IF
               UPDATE dzdf_t SET dzdf004 = g_dzdf_d1[l_ac1].dzdf002_1
                WHERE dzdf001 = g_dzde_m.dzde001 
                  AND dzdf004 = g_dzdf_d1_t.dzdf002_1
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzdf_d1[l_ac1].* = g_dzdf_d1_t.*
                  CALL s_transaction_end('N',0)
               END IF
            END IF
           #CALL s_transaction_end('Y',0)
            
         AFTER ROW
            LET l_ac1 = ARR_CURR()
            CALL adzi451_unlock_b("dzdf_t","1")
           #CALL s_transaction_end('Y',0)
      END INPUT
      
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
         LET g_action_choice="exit"
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_action_choice="exit"
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET INT_FLAG = 0
      CALL s_transaction_end('N',0)
   END IF
 
    
   CALL s_transaction_end('Y',0)
   #add-point:input段after input 
   {<point name="input.after_input"/>}
   #end add-point    
 
END FUNCTION

PRIVATE FUNCTION adzi451_b2()
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
 
   LET g_action_choice = ""
   IF cl_null(g_dzde_m.dzde001) OR cl_null(g_dzde_m.dzde002) THEN
      RETURN
   END IF
   IF cl_null(g_dzdf_d1[l_ac1].dzdf002_1) THEN
      RETURN
   END IF
 
   LET g_forupd_sql = "SELECT dzdf002 FROM dzdf_t WHERE dzdf001=? AND dzdf002=? AND dzdf003='N' FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE adzi451_bcl_2 CURSOR FROM g_forupd_sql
   
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
  #CALL cl_set_head_visible("","YES")  
  #LET g_qryparam.state = 'i'
 
   CALL s_transaction_begin()
   DIALOG ATTRIBUTE(UNBUFFERED)
   
      INPUT ARRAY g_dzdf_d2 FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         BEFORE INPUT
           #LET g_rec_b2 = g_dzdf_d2.getLength()
           #DISPLAY g_rec_b2 TO FORMONLY.cnt2
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac2)
            END IF
         
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx
         
           #CALL s_transaction_begin()
            OPEN adzi451_cl USING g_dzde_m.dzde001,g_dzde_m.dzde002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN adzi451_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CLOSE adzi451_cl
               CALL s_transaction_end('N',0)
               RETURN
            END IF
            FETCH adzi451_cl INTO g_dzde_m.dzde001,g_dzde_m.dzde002,g_dzde_m.dzde003,g_dzde_m.dzdestus,g_dzde_m.dzdemodid,g_dzde_m.modu_desc,g_dzde_m.dzdemoddt,g_dzde_m.dzdeownid,g_dzde_m.oriu_desc,g_dzde_m.dzdeowndp,g_dzde_m.orid_desc,g_dzde_m.dzdecrtid,g_dzde_m.user_desc,g_dzde_m.dzdecrtdp,g_dzde_m.dept_desc,g_dzde_m.dzdecrtdt # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = g_dzde_m.dzde001
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CLOSE adzi451_cl
               CALL s_transaction_end('N',0)
               RETURN
            END IF
            
           #LET g_rec_b2 = g_dzdf_d2.getLength()
           #IF g_rec_b2 >= l_ac2 AND NOT cl_null(g_dzdf_d2[l_ac2].dzdf002_2) THEN
            IF g_rec_b2 >= l_ac2 THEN
               LET l_cmd='u'
               LET g_dzdf_d2_t.* = g_dzdf_d2[l_ac2].*  #BACKUP
               OPEN adzi451_bcl_2 USING g_dzde_m.dzde001,g_dzdf_d2[l_ac2].dzdf002_2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "adzi451_bcl_2"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi451_bcl_2 INTO g_dzdf_d2[l_ac2].dzdf002_2
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_dzdf_d2_t.dzdf002_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                 #CALL adzi451_show()
                 #CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzdf_d2[l_ac2].* TO NULL 
            LET g_dzdf_d2_t.* = g_dzdf_d2[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
           #CALL adzi451_set_entry_b()
           #CALL adzi451_set_no_entry_b()
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dzdf_t 
             WHERE dzdf001 = g_dzde_m.dzde001
               AND dzdf002 = g_dzdf_d2[l_ac2].dzdf002_2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzde_m.dzde001
               LET gs_keys[2] = g_dzdf_d2[l_ac2].dzdf002_2
               LET gs_keys[3] = 'N'
               LET gs_keys[4] = g_dzdf_d1[l_ac1].dzdf002_1
               CALL adzi451_insert_b('dzdf_t',gs_keys)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_dzdf_d2[l_ac2].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dzdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            ELSE
              #CALL s_transaction_end('Y',0)
               ERROR 'INSERT O.K'
               LET g_rec_b2=g_rec_b2+1
              #DISPLAY g_rec_b2 TO FORMONLY.cnt2
              #CLOSE adzi451_bcl_2
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_dzdf_d2[l_ac2].dzdf002_2) THEN
               IF NOT cl_ask_del_detail() THEN
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE
               END IF
               DELETE FROM dzdf_t
                WHERE dzdf001 = g_dzde_m.dzde001 AND
                      dzdf002 = g_dzdf_d2_t.dzdf002_2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b2 = g_rec_b2-1
                 #CALL s_transaction_end('Y',0)
                 #DISPLAY g_rec_b2 TO FORMONLY.cnt2
               END IF 
               CLOSE adzi451_bcl_2
               LET l_count = g_dzdf_d2.getLength()
            END IF 
            
         AFTER FIELD dzdf002_2
            IF  NOT cl_null(g_dzdf_d2[l_ac2].dzdf002_2)  THEN 
               IF  l_cmd = 'a'  OR ( l_cmd = 'u' AND g_dzdf_d2[l_ac2].dzdf002_2 != g_dzdf_d2_t.dzdf002_2) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdf_t WHERE "||"dzdf001 = '"||g_dzde_m.dzde001 ||"' AND "|| "dzdf002 = '"||g_dzdf_d2[l_ac2].dzdf002_2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD dzdf002_2
                  END IF
               END IF
            END IF

 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzdf_d2[l_ac2].* = g_dzdf_d2_t.*
               CLOSE adzi451_bcl_2
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzdf_d2[l_ac2].dzdf002_2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzdf_d2[l_ac2].* = g_dzdf_d2_t.*
            ELSE
               UPDATE dzdf_t SET (dzdf001,dzdf002) = (g_dzde_m.dzde001,g_dzdf_d2[l_ac2].dzdf002_2)
                WHERE  dzdf001 = g_dzde_m.dzde001 
                  AND dzdf002 = g_dzdf_d2_t.dzdf002_2 #項次   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzdf_d2[l_ac2].* = g_dzdf_d2_t.*
               END IF
               
            END IF
            
         AFTER ROW
            LET l_ac2 = ARR_CURR()
            CALL adzi451_unlock_b("dzdf_t","2")
           #CALL s_transaction_end('Y',0)
            #其他table進行unlock

      END INPUT
   
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
         LET g_action_choice="exit"
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_action_choice="exit"
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET INT_FLAG = 0
      CALL s_transaction_end('N',0)
   END IF
   CALL s_transaction_end('Y',0)
    
END FUNCTION
 
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzi451_show()
DEFINE l_sql     STRING
   
   LET g_dzde_m_t.* = g_dzde_m.*      #保存單頭舊值
  
   DISPLAY BY NAME g_dzde_m.dzde001,g_dzde_m.dzde002,g_dzde_m.dzde003,g_dzde_m.dzdestus,g_dzde_m.dzdemodid,g_dzde_m.modu_desc,g_dzde_m.dzdemoddt,g_dzde_m.dzdeownid,g_dzde_m.oriu_desc,g_dzde_m.dzdeowndp,g_dzde_m.orid_desc,g_dzde_m.dzdecrtid,g_dzde_m.user_desc,g_dzde_m.dzdecrtdp,g_dzde_m.dept_desc,g_dzde_m.dzdecrtdt
    
   CASE g_dzde_m.dzdestus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "authstatus/void.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "authstatus/invalid.png")
   END CASE
  
   CALL adzi451_b_fill_1()                 #單身
  #CALL adzi451_b_fill_2()                 #單身
     
   #帶出預設欄位之值
   LET g_dzde_m.modu_desc = cl_get_username(g_dzde_m.dzdemodid)
   LET g_dzde_m.oriu_desc = cl_get_username(g_dzde_m.dzdeownid)
   LET g_dzde_m.user_desc = cl_get_username(g_dzde_m.dzdecrtid)
   LET g_dzde_m.dept_desc = cl_get_deptname(g_dzde_m.dzdecrtdp)
   LET g_dzde_m.orid_desc = cl_get_deptname(g_dzde_m.dzdeowndp)
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
END FUNCTION
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi451_b_fill_1()
 
   CALL g_dzdf_d1.clear()    #g_dzdf_d 單頭及單身 
 
   LET g_sql = "SELECT dzdf002 FROM dzdf_t",    
               " WHERE dzdf001 = ? ",
               "   AND dzdf003 = 'Y' "
 
   IF NOT cl_null(g_wc1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY dzdf002"
 
   PREPARE adzi451_pb_1 FROM g_sql
   DECLARE b_fill_cs_1 CURSOR FOR adzi451_pb_1
 
   LET l_ac1 = 1
   LET g_rec_b1 = 0
 
   OPEN b_fill_cs_1 USING g_dzde_m.dzde001
                                            
   FOREACH b_fill_cs_1 INTO g_dzdf_d1[l_ac1].dzdf002_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      LET g_dzdi003 = s_chr_trim(g_dzdf_d1[l_ac1].dzdf002_1)
      LET g_dzdf_d1[l_ac1].dzdf002_1_desc = sadz_get_name("dzda_t","dzda001",g_dzdi003)
 
      LET g_rec_b1 = g_rec_b1 + 1
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_dzdf_d1.deleteElement(g_dzdf_d1.getLength())
   LET g_cnt1 = l_ac1
   LET l_ac1 = l_ac1 - 1
 
END FUNCTION
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi451_b_fill_2()
 
   IF cl_null(l_ac1) OR l_ac1=0 THEN LET l_ac1=1 END IF
   IF cl_null(g_dzdf_d1[l_ac1].dzdf002_1)  THEN RETURN END IF

   CALL g_dzdf_d2.clear()    #g_dzdf_d 單頭及單身 

   LET g_sql = "SELECT dzdf002 FROM dzdf_t",    
               " WHERE dzdf001 = ? ",
               "   AND dzdf003 = 'N' ",
               "   AND dzdf004 = ? "
  #IF NOT cl_null(g_wc2) THEN
  #   LET g_sql = g_sql CLIPPED, " AND ", g_wc2 CLIPPED
  #END IF
   LET g_sql = g_sql, " ORDER BY dzdf002"
 
   PREPARE adzi451_pb_2 FROM g_sql
   DECLARE b_fill_cs_2 CURSOR FOR adzi451_pb_2
 
   LET l_ac2 = 1
   LET g_rec_b2 = 0
 
   OPEN b_fill_cs_2 USING g_dzde_m.dzde001,g_dzdf_d1[l_ac1].dzdf002_1
                                            
   FOREACH b_fill_cs_2 INTO g_dzdf_d2[l_ac2].dzdf002_2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      LET g_rec_b2 = g_rec_b2 + 1
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET g_cnt2 = l_ac2
   CALL g_dzdf_d2.deleteElement(g_dzdf_d2.getLength())
   LET l_ac2 = l_ac2 - 1
   
END FUNCTION

PRIVATE FUNCTION adzi451_b_fill_3()
DEFINE l_dzbb098    LIKE dzbb_t.dzbb098
DEFINE l_str        STRING
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_ch        base.Channel
DEFINE l_buf       STRING
DEFINE l_buf2      STRING
DEFINE l_length    LIKE type_t.num5
DEFINE l_row       LIKE type_t.num5
DEFINE l_flag      LIKE type_t.chr1
 
   CALL g_4gl.clear()    #g_dzdf_d 單頭及單身 
  #LOCATE l_dzbb098      IN FILE

 
   IF cl_null(l_ac1) OR l_ac1=0 THEN LET l_ac1=1 END IF
   IF cl_null(g_dzdf_d1[l_ac1].dzdf002_1)  THEN RETURN END IF

   LET g_sql = "SELECT UNIQUE dzbb001 FROM dzbb_t",    
               " WHERE dzbb098 LIKE '%CALL%",g_dzdf_d1[l_ac1].dzdf002_1,"(%'"    #是被呼叫的
              #" WHERE dzbb098 LIKE '%CALL%",g_dzdf_d1[l_ac1].dzdf002_1,"(%'",   #是被呼叫的
              #"   AND dzbb098 NOT LIKE '%#%CALL%",g_dzdf_d1[l_ac1].dzdf002_1,"(%'" #没被注释的
   LET g_sql = g_sql, " ORDER BY dzbb001"
   PREPARE adzi451_pb_3 FROM g_sql
   DECLARE b_fill_cs_3 CURSOR FOR adzi451_pb_3
   LET l_ac3 = 1
   LET g_rec_b3 = 0
   FOREACH b_fill_cs_3 INTO g_4gl[l_ac3].pno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_flag = ''
      CALL adzi451_b_fill_3_chk(g_4gl[l_ac3].pno,g_dzdf_d1[l_ac1].dzdf002_1) RETURNING l_flag  #排除有被注释掉的
      IF l_flag = 'N' THEN  #不存在有效调用的(包括没被调用或者被注释掉)
         CONTINUE FOREACH
      END IF

      LET l_str = g_4gl[l_ac3].pno
      IF l_str.getIndexOf("_",1) THEN
         SELECT dzde003 INTO g_4gl[l_ac3].dzde003_b3 
           FROM dzde_t
          WHERE dzde001 = g_4gl[l_ac3].pno
            AND dzde002 = g_lang
      ELSE
         SELECT gzzal003 INTO g_4gl[l_ac3].dzde003_b3
           FROM gzzal_t
          WHERE gzzal001 = g_4gl[l_ac3].pno
            AND gzzal002 = g_lang
      END IF

      LET g_rec_b3 = g_rec_b3 + 1
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET g_cnt3 = l_ac3
   CALL g_4gl.deleteElement(g_4gl.getLength())
   LET l_ac3 = l_ac3 - 1
   
  #FREE l_dzbb098

END FUNCTION

#检查某4gl中是否存在调用的某元件的地方
FUNCTION adzi451_b_fill_3_chk(p_dzbb001,p_dzda001)
DEFINE p_dzbb001     LIKE dzbb_t.dzbb001  #程序
DEFINE p_dzda001     LIKE dzda_t.dzda001  #元件
DEFINE r_flag        LIKE type_t.chr1
DEFINE l_dzbb098     LIKE dzbb_t.dzbb098
DEFINE l_str         STRING              #尚未拆解的字符
DEFINE l_str2        STRING              #拆解出来的行内容
DEFINE l_pos1        LIKE type_t.num10   #第一个字符位置  衡为1
DEFINE l_pos2        LIKE type_t.num10   #换行符错在位置
DEFINE l_length      LIKE type_t.num10   #尚未拆解的字符串长度
DEFINE l_idx1        LIKE type_t.num10   #‘#’所在位置
DEFINE l_idx2        LIKE type_t.num10   #‘call’所在位置
DEFINE l_idx3        LIKE type_t.num10   #元件所在位置

   LET r_flag = 'N'   #默认没有找到调用元件

   IF cl_null(p_dzbb001) OR cl_null(p_dzda001) THEN
      RETURN r_flag
   END IF

   LOCATE l_dzbb098      IN FILE

   LET g_sql = "SELECT dzbb098 FROM dzbb_t",    
               " WHERE dzbb098 LIKE '%CALL%",p_dzda001,"(%'",   #是被呼叫的
               "   AND dzbb001 = '",p_dzbb001,"' "
   LET g_sql = g_sql, " ORDER BY dzbb001"
   PREPARE adzi451_pb_3_chk FROM g_sql
   DECLARE b_fill_cs_3_chk CURSOR FOR adzi451_pb_3_chk
   FOREACH b_fill_cs_3_chk INTO l_dzbb098
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #对l_dzbb098拆解成每行解读
      LET l_str = l_dzbb098
      LET l_str = DOWNSHIFT(l_str)
      LET l_length = l_str.getlength()
      WHILE TRUE
          IF l_length = 0 THEN EXIT WHILE END IF  #到底了
          LET l_pos1 = 1
          LET l_pos2 = l_str.getIndexOf("\n",1)
          IF l_pos1 = l_pos2 THEN  #为一行只有一个回车符
             LET l_str = l_str.subString(l_pos2+1,l_length)
             LET l_length = l_length - l_pos2     #\n是1个字符
             CONTINUE WHILE
          END IF
          IF l_pos2 = 0 THEN  #最后一行了
             LET l_str2 = l_str.subString(l_pos1,l_length)  #检查的单行
          ELSE
             LET l_str2 = l_str.subString(l_pos1,l_pos2-1)  #检查的单行
          END IF

          #开始检查
          LET l_idx1 = l_str2.getIndexOf("#",1)        #‘#’所在位置
          LET l_idx2 = l_str2.getIndexOf("call ",1)    #‘call’所在位置
          LET l_idx3 = l_str2.getIndexOf(p_dzda001,1)  #元件所在位置
          CASE 
             WHEN l_idx3 = 0    #没有使用元件,继续下一行查找 
                  IF l_pos2 = 0 THEN EXIT WHILE END IF   #到底了
                  IF l_pos2+1 > l_length THEN EXIT WHILE END IF   #到底了
                  LET l_str = l_str.subString(l_pos2+1,l_length)
                  LET l_length = l_length - l_pos2     #\n是1字符
                  CONTINUE WHILE
             WHEN l_idx2 = 0    #没有调用元件,继续下一行查找 
                  IF l_pos2 = 0 THEN EXIT WHILE END IF   #到底了
                  IF l_pos2+1 > l_length THEN EXIT WHILE END IF   #到底了
                  LET l_str = l_str.subString(l_pos2+1,l_length)
                  LET l_length = l_length - l_pos2     #\n是1个字符
                  CONTINUE WHILE
             WHEN l_idx1 = 0    #找到调用元件了,且没被注释掉，不用再找,可返回信息了
                  LET r_flag = 'Y'  
                  EXIT WHILE 
             WHEN l_idx1 > 0 AND l_idx1 > l_idx3   #找到了,注释在元件后面没影响，不用再找,可返回信息了
                  LET r_flag = 'Y' 
                  EXIT WHILE 
             WHEN l_idx1 > 0 AND l_idx1 < l_idx3   #找到了,但注释在元件前面,继续下一行查找
                  IF l_pos2 = 0 THEN EXIT WHILE END IF   #到底了
                  IF l_pos2+1 > l_length THEN EXIT WHILE END IF   #到底了
                  LET l_str = l_str.subString(l_pos2+1,l_length)
                  LET l_length = l_length - l_pos2     #\n是1个字符
                  CONTINUE WHILE
             OTHERWISE          #继续下一行查找
                  IF l_pos2 = 0 THEN EXIT WHILE END IF   #到底了
                  IF l_pos2+1 > l_length THEN EXIT WHILE END IF   #到底了
                  LET l_str = l_str.subString(l_pos2+1,l_length)
                  LET l_length = l_length - l_pos2     #\n是1个字符
                  CONTINUE WHILE
          END CASE
        
   

          IF l_pos2 = 0 THEN EXIT WHILE END IF   #到底了
          IF l_pos2+1 > l_length THEN EXIT WHILE END IF   #到底了
          LET l_str = l_str.subString(l_pos2+1,l_length)
          LET l_length = l_length - l_pos2     #\n是1个字符
      END WHILE
      IF r_flag = 'Y' THEN EXIT FOREACH END IF
      #对l_dzbb098拆解成每行解读

   END FOREACH

   FREE l_dzbb098
   RETURN r_flag
END FUNCTION

#+ 刪除單身後其他table連動
#PRIVATE FUNCTION adzi451_delete_b(ps_table,ps_keys_bak)
#   DEFINE ps_table    STRING
#   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
#   DEFINE ls_group    STRING
# 
#   #判斷是否是同一群組的table
#   LET ls_group = "dzdf_t,"
#   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "dzdf_t" THEN
#      DELETE FROM dzdf_t
#       WHERE dzdf001 = ps_keys_bak[1]
#         AND dzdf002 = ps_keys_bak[2]
#      IF SQLCA.sqlcode THEN
#         CALL cl_err("",SQLCA.sqlcode,0)
#      END IF
#   END IF
#   
#END FUNCTION
 
#+ 新增單身後其他table連動
PRIVATE FUNCTION adzi451_insert_b(ps_table,ps_keys)
   DEFINE ps_table    STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   
   #判斷是否是同一群組的table
   LET ls_group = "dzdf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      INSERT INTO dzdf_t
                  (
                   dzdf001, dzdf002, dzdf003, dzdf004
                   ) 
            VALUES(
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzdf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   END IF
END FUNCTION
 
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adzi451_unlock_b(ps_table,p_flag)
 
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   DEFINE p_flag  LIKE type_t.chr1
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CASE p_flag 
          WHEN "1"
               CLOSE adzi451_bcl_1
          WHEN "2"
               CLOSE adzi451_bcl_2
      END CASE
   END IF
 
END FUNCTION
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi451_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " dzde001 = '", g_argv[1], "' AND "
   END IF
   
      #key2
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dzde002 = ", g_argv[02], " AND "
   END IF
 
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      CALL adzi451_browser_fill("first")
   ELSE
      IF cl_null(g_wc) THEN
	     LET g_wc = " 1=1"
	  END IF
      CALL adzi451_browser_fill("")
   END IF
   
   #add-point:default_search段結束前前
   {<point name="default_search.after"/>}
   #end add-point  
 
END FUNCTION
 
 
#確認碼變更
PRIVATE FUNCTION adzi451_statechange()
   DEFINE lc_state LIKE type_t.chr5
   
   ERROR ""
 
   IF g_dzde_m.dzde001 IS NULL OR g_dzde_m.dzde002 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_dzde_m.dzdestus
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "N"
               HIDE OPTION "void"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
         IF g_template_type <> "t" THEN
            HIDE OPTION "invalid"
         END IF
      ON ACTION valid
         LET lc_state = "Y"
         EXIT MENU
      ON ACTION void
         LET lc_state = "N"
         EXIT MENU
      ON ACTION invalid
         LET lc_state = "X"
         EXIT MENU
   END MENU
   
   IF (lc_state <> "Y" AND lc_state <> "N" AND lc_state <> "X" ) OR cl_null(lc_state) THEN
      RETURN
   END IF 
   
   UPDATE dzde_t SET dzdestus = lc_state 
    WHERE dzde001 = g_dzde_m.dzde001
      AND dzde002 = g_dzde_m.dzde002
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "authstatus/void.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "authstatus/invalid.png")
      END CASE
   END IF
   
END FUNCTION

PUBLIC FUNCTION adzi451_gen_data(p_dzda001)
DEFINE p_dzda001   LIKE dzda_t.dzda001
DEFINE r_success   LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_dzdf      RECORD LIKE dzdf_t.*
DEFINE l_dzba001   LIKE dzba_t.dzba001
DEFINE l_dzba003   LIKE dzba_t.dzba003
DEFINE l_dzba003_2 LIKE dzba_t.dzba003
DEFINE l_str       STRING
DEFINE l_pos       LIKE type_t.num5
DEFINE l_length    LIKE type_t.num5

   LET r_success = TRUE

   IF NOT s_transaction_chk('Y',0) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF cl_null(p_dzda001) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM dzda_t WHERE dzda001 = p_dzda001
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00143'
      LET g_errparam.extend = p_dzda001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #插入元件(PUBLIC)
   LET l_dzba003 = 'function.',p_dzda001 CLIPPED
   LET l_sql = " SELECT UNIQUE dzba001 ",
               "   FROM dzba_t ",
               "  WHERE dzba003 = '",l_dzba003,"' ",
               "    AND dzbastus = 'Y' "
   DECLARE adzi451_gen_data_c1 SCROLL CURSOR FROM l_sql
   OPEN adzi451_gen_data_c1
   FETCH FIRST adzi451_gen_data_c1 INTO l_dzba001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi451_gen_data_c1
      LET r_success = FALSE
      RETURN r_success
   END IF
   CLOSE adzi451_gen_data_c1

   INITIALIZE l_dzdf.* TO NULL
   LET l_dzdf.dzdf001 = l_dzba001
   LET l_dzdf.dzdf002 = p_dzda001
   LET l_dzdf.dzdf003 = 'Y'
   INSERT INTO dzdf_t VALUES(l_dzdf.*)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #插入函数(PRIVATE)
   LET l_sql = " SELECT UNIQUE dzba003 ",
               "   FROM dzba_t ",
               "  WHERE dzba001 = '",l_dzba001,"' ",
               "    AND dzbastus = 'Y' ",
               "    AND dzba003 LIKE '",l_dzba003,"%' ",
               "    AND dzba003 != '",l_dzba003,"' "
   PREPARE adzi451_gen_data_p2 FROM l_sql
   DECLARE adzi451_gen_data_c2 CURSOR FOR adzi451_gen_data_p2
   FOREACH adzi451_gen_data_c2 INTO l_dzba003_2
       IF SQLCA.sqlcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "dzba_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          EXIT FOREACH
       END IF

       LET l_str = l_dzba003_2
       LET l_pos = l_str.getIndexOf(".",1)
       IF l_pos = 0 THEN
          CONTINUE FOREACH
       END IF
       LET l_length = l_str.getLength()
       LET l_str = l_str.subString(l_pos+1,l_length)

       INITIALIZE l_dzdf.* TO NULL
       LET l_dzdf.dzdf001 = l_dzba001
       LET l_dzdf.dzdf002 = l_str.trim()
       LET l_dzdf.dzdf003 = 'N'
       LET l_dzdf.dzdf004 = p_dzda001
       INSERT INTO dzdf_t VALUES(l_dzdf.*)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          EXIT FOREACH
       END IF
   END FOREACH

   RETURN r_success
END FUNCTION




