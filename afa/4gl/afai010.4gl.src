#該程式未解開Section, 採用最新樣板產出!
{<section id="afai010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2014-02-13 20:35:00), PR版次:0012(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000205
#+ Filename...: afai010
#+ Description: 資產組織維護作業
#+ Creator....: 02299(2014-01-23 00:00:00)
#+ Modifier...: 02416 -SD/PR- 00000
 
{</section>}
 
{<section id="afai010.global" >}
#應用 i00 樣板自動產生(Version:9)
#add-point:填寫註解說明
#151023-00016#1   2015/10/26  By 01727 錯誤訊息改為正規報錯
#151125-00001#1...: 2015/11/27 BY fionchen 執行[作廢]作業時,增加詢問「是否執行作廢？」
#160318-00005#8  2016/03/23    BY 07675 將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#1   2016-09-05   By08734     ent调整
#end add-point
#add-point:填寫註解說明(客製用)

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
 type type_g_faab_m        RECORD
       faab001 LIKE faab_t.faab001, 
   faab002 LIKE faab_t.faab002,
   faab002_desc LIKE ooefl_t.ooefl003,   
   faab003 LIKE faab_t.faab003, 
   faab006 LIKE faab_t.faab006, 
   faab007 LIKE faab_t.faab007,
   faabstus LIKE faab_t.faabstus,   
   faabownid LIKE faab_t.faabownid, 
   faabownid_desc LIKE type_t.chr80, 
   faabowndp LIKE faab_t.faabowndp, 
   faabowndp_desc LIKE type_t.chr80, 
   faabcrtid LIKE faab_t.faabcrtid, 
   faabcrtid_desc LIKE type_t.chr80, 
   faabcrtdp LIKE faab_t.faabcrtdp, 
   faabcrtdp_desc LIKE type_t.chr80, 
   faabcrtdt DATETIME YEAR TO SECOND, 
   faabmodid LIKE faab_t.faabmodid, 
   faabmodid_desc LIKE type_t.chr80, 
   faabmoddt DATETIME YEAR TO SECOND
       END RECORD
 
#單身 type 宣告
 TYPE type_g_faab_d        RECORD
       faab004 LIKE faab_t.faab004, 
       faab004_desc LIKE ooefl_t.ooefl003,
   faab005 LIKE faab_t.faab005,
   faab005_desc LIKE ooefl_t.ooefl003
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_faab_m          type_g_faab_m
DEFINE g_faab_m_t        type_g_faab_m
 
DEFINE g_faab001_t     LIKE faab_t.faab001
DEFINE g_faab002_t     LIKE faab_t.faab002
 
DEFINE g_faab003_t     LIKE faab_t.faab003
 
DEFINE g_faab004_t        LIKE faab_t.faab004
DEFINE g_faab005_t        LIKE faab_t.faab005

DEFINE g_faab_d          DYNAMIC ARRAY OF type_g_faab_d
DEFINE g_faab_d_t        type_g_faab_d
 
 
DEFINE g_tree    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
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
       b_faab004 LIKE type_t.chr80,
   b_faab005 LIKE type_t.chr80,
      b_faab001 LIKE faab_t.faab001,
      b_faab002 LIKE faab_t.faab002,
      b_faab003 LIKE faab_t.faab003,
      b_faab003_desc LIKE type_t.chr100
       END RECORD
      
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_faab001 LIKE faab_t.faab001,
      b_faab002 LIKE faab_t.faab002,
      b_faab003 LIKE faab_t.faab003
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                        #查詢排序欄位 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_searchtype          LIKE type_t.chr200
                                                   
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_row_index           LIKE type_t.num5
DEFINE g_root_search         BOOLEAN
DEFINE g_browser_root        DYNAMIC ARRAY OF INTEGER      #root資料所在
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_state               STRING
DEFINE g_wc_table1           STRING                        #第1個單身table所使用的g_wc
DEFINE g_faab001             LIKE faab_t.faab001           
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
{</section>}
 
{<section id="afai010.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   #end add-point    
   #add-point:main段define(客製用)
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化
   LET g_faab001 = '4'
   #end add-point
 
   #add-point:SQL_define
   LET g_forupd_sql = "SELECT faab001,faab002,faab003,faab006,faab007,faabstus,faabownid,'',faabowndp,'',faabcrtid,'',faabcrtdp,'',faabcrtdt,faabmodid,'',faabmoddt FROM faab_t WHERE faabent= ? AND faab001=? AND faab002=? AND faab003=?  FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE afai010_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afai010 WITH FORM cl_ap_formpath("afa",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afai010_init()
 
      #進入選單 Menu (='N')
      CALL afai010_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_afai010
   END IF
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="afai010.other_function" readonly="Y" >}
#add-point:自定義元件(Function)
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afai010_query()
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point    
   
   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_faab_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   
   CALL afai010_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_faab_m.* TO NULL
      LET g_wc = " 1=1"
      LET g_wc2 = " 1=1"
      RETURN
   END IF
 
   LET g_error_show = 1
   CALL afai010_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLEAR FORM
   ELSE
      CALL afai010_fetch("F") 
   END IF   
 
END FUNCTION
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afai010_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_faab001 = g_faab_m.faab001 
         AND g_browser[l_i].b_faab002 = g_faab_m.faab002 
 
         AND g_browser[l_i].b_faab003 = g_faab_m.faab003 
 
 
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
#+ 資料新增
PRIVATE FUNCTION afai010_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point    
   
   CLEAR FORM                                #清畫面欄位內容
   CALL g_faab_d.clear()          #清除陣列
   CALL g_tree.clear()
   
   INITIALIZE g_faab_m.* LIKE faab_t.*             #DEFAULT 設定
   INITIALIZE g_faab_m_t.* LIKE faab_t.*
   LET g_faab001_t = NULL
   LET g_faab002_t = NULL
 
   LET g_faab003_t = NULL
 
 
   LET g_faab005_t = NULL
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_faab_m.faabownid = g_user
      LET g_faab_m.faabowndp = g_dept
      LET g_faab_m.faabcrtid = g_user
      LET g_faab_m.faabcrtdp = g_dept 
      LET g_faab_m.faabcrtdt = cl_get_current()
      #LET g_faab_m.faabmodid = g_user
      #LET g_faab_m.faabmoddt = cl_get_current()
      LET g_faab_m.faabstus = "N"
      LET g_faab_m.faab007 = "N"
      LET g_faab_m.faab006 = g_today
      LET g_faab_m.faab003 = 1
      
      
      #append欄位給值
      IF NOT cl_null(g_faab001) THEN
         IF g_faab001 <>'0' THEN 
            LET g_faab_m.faab001 = g_faab001
        END IF
      END IF     
      
      LET g_faab_m_t.* = g_faab_m.*
      #一般欄位給值
      
  
      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point 
     
      CALL afai010_input("a")
      
      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_faab_m.* = g_faab_m_t.*
         CALL afai010_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF
      
      CALL g_faab_d.clear()
 
 
      LET g_rec_b = 0
      EXIT WHILE
        
   END WHILE
   LET g_state = "Y"
   LET g_faab001_t = g_faab_m.faab001
   LET g_faab002_t = g_faab_m.faab002
   LET g_faab003_t = g_faab_m.faab003
END FUNCTION
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afai010_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE l_chr      LIKE type_t.chr1
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point    
   
  # LET ls_chk = g_browser[g_current_idx].b_id
  # LET ls_chk = ls_chk.trim()
  # IF ls_chk.getIndexOf('.',3)  = 0 THEN              
  #    INITIALIZE g_faab_m.* TO NULL
  #    CALL g_faab_d.clear()
  #    DISPLAY BY NAME g_faab_m.*       
  #    CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
  #    DISPLAY '' TO FORMONLY.b_index
  #    RETURN
  # END IF
   
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
   
   #CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   
   CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
 
   #代表沒有資料
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_faab_m.faab001 = g_browser[g_current_idx].b_faab001
   LET g_faab_m.faab002 = g_browser[g_current_idx].b_faab002
 
   LET g_faab_m.faab003 = g_browser[g_current_idx].b_faab003

 
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE faab001,faab002,faab003,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt
 INTO g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt
 FROM faab_t
 WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
   AND faab002 = g_faab_m.faab002 AND faab003 = g_faab_m.faab003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "faab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_faab_m.* TO NULL
      RETURN
   END IF
   CALL afai010_tree_fill()
   #重新顯示   
   CALL afai010_show()
 
END FUNCTION
#+ 資料修改
PRIVATE FUNCTION afai010_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point    
   
   IF g_faab_m.faab001 IS NULL
   OR g_faab_m.faab002 IS NULL
 
   OR g_faab_m.faab003 IS NULL
 
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   IF g_faab_m.faabstus ='Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "abg-00010"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN      
   END IF
   
    SELECT UNIQUE faab001,faab002,faab003,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt
 INTO g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt
 FROM faab_t
 WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 AND faab002 = g_faab_m.faab002 AND faab003 = g_faab_m.faab003
 
   ERROR ""
  
   LET g_faab001_t = g_faab_m.faab001
   LET g_faab002_t = g_faab_m.faab002
 
   LET g_faab003_t = g_faab_m.faab003
 
 
   CALL s_transaction_begin()
   
   OPEN afai010_cl USING g_enterprise,g_faab_m.faab001
                                                       ,g_faab_m.faab002
 
                                                       ,g_faab_m.faab003
 
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN afai010_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE afai010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH afai010_cl INTO g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabownid_desc,g_faab_m.faabowndp,g_faab_m.faabowndp_desc,g_faab_m.faabcrtid,g_faab_m.faabcrtid_desc,g_faab_m.faabcrtdp,g_faab_m.faabcrtdp_desc,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmodid_desc,g_faab_m.faabmoddt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_faab_m.faab001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE afai010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   CALL afai010_show()
   WHILE TRUE
      LET g_faab001_t = g_faab_m.faab001
      LET g_faab002_t = g_faab_m.faab002
 
      LET g_faab003_t = g_faab_m.faab003
 
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_faab_m.faabmodid = g_user 
      LET g_faab_m.faabmoddt = cl_get_current()
 
 
      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point
      
      CALL afai010_input("u")     #欄位更改
 
      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_faab_m.* = g_faab_m_t.*
         CALL afai010_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_faab_m.faab001 != g_faab001_t 
      OR g_faab_m.faab002 != g_faab002_t 
 
      OR g_faab_m.faab003 != g_faab003_t 
 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update" mark="Y"/>}
         #end add-point
         
         #更新單身key值
         UPDATE faab_t SET faab001 = g_faab_m.faab001
                                      ,faab002 = g_faab_m.faab002
 
                                      ,faab003 = g_faab_m.faab003
 
 
          WHERE faabent = g_enterprise AND faab001 = g_faab001_t
            AND faab002 = g_faab002_t
 
            AND faab003 = g_faab003_t
 
 
            
         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update"/>}
         #end add-point
         
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = ""
             LET g_errparam.popup = TRUE
             CALL cl_err()
 
             CALL s_transaction_end('N','0')
             CONTINUE WHILE
         END IF
         
         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update"/>}
         #end add-point
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
      
      EXIT WHILE
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_faab_m.faab001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afai010_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_faab_m.faab001,'U')
 
END FUNCTION
#+ 單身資料重新顯示
PRIVATE FUNCTION afai010_ui_detailshow()
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
#+ ree子節點展開
PRIVATE FUNCTION afai010_tree_expand(pi_id)
   {<Local define>}
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_type_list     STRING
   DEFINE ls_sql           STRING
   {</Local define>}
   #add-point:browser_expand段define

   #end add-point
   
   #已經展開過
   IF g_tree[pi_id].b_isExp = TRUE THEN
      RETURN
   END IF
      
   LET li_lv = g_tree[pi_id].b_expcode
   LET g_tree[pi_id].b_isExp = TRUE
      
   LET ls_sql = " SELECT UNIQUE faab001,faab002,faab003,faab004,faab005", 
                " FROM faab_t ",
                " WHERE faabent = '" ||g_enterprise|| "'",
                "   AND faab001 = '",g_tree[pi_id].b_faab001,"'",
                "   AND faab002 = '",g_tree[pi_id].b_faab002,"'",
                "   AND faab003 = '",g_tree[pi_id].b_faab003,"'",
                "   AND faab005 = '",g_tree[pi_id].b_faab004,"'",
                "   AND faab004 <> faab005 ",
                "   AND faab002 <> faab005 ",
                " ORDER BY faab004 "
   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET li_idx = pi_id + 1
   CALL g_tree.insertElement(li_idx)
   FOREACH expand_cur INTO g_tree[li_idx].b_faab001,g_tree[li_idx].b_faab002,g_tree[li_idx].b_faab003,g_tree[li_idx].b_faab004,g_tree[li_idx].b_faab005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
      LET g_tree[li_idx].b_pid     = g_tree[pi_id].b_id 
      LET g_tree[li_idx].b_id      = g_tree[pi_id].b_id , ".", li_idx USING "<<<"
      LET g_tree[li_idx].b_exp     = FALSE
      LET g_tree[li_idx].b_expcode = li_lv + 1
      LET g_tree[li_idx].b_hasC    = afai010_chk_hasC(li_idx)
      CALL afai010_desc_show(li_idx)
      #IF g_tree[li_idx].b_hasC = 1 THEN
      #   CALL afai010_tree_expand(li_idx)
      #   LET li_idx = g_tree.getLength()
      #END IF         
      

      LET li_idx = li_idx + 1
      CALL g_tree.insertElement(li_idx)
   END FOREACH
   
   CALL g_tree.deleteElement(li_idx) 
   FREE expand_pre
END FUNCTION
#+ QBE資料查詢
PRIVATE FUNCTION afai010_chk_hasC(pi_id)
DEFINE pi_id    INTEGER
DEFINE li_cnt   INTEGER


   LET g_sql = "SELECT COUNT(*) FROM faab_t ",
               " WHERE faabent = '" ||g_enterprise|| "'",
               "   AND faab001 = '",g_faab_m.faab001,"'",
               "   AND faab002 = '",g_faab_m.faab002,"'",
               "   AND faab003 = '",g_faab_m.faab003,"' ",
               "   AND faab004 <> faab005 ",
               "   AND faab002 <> faab005 ",
               "   AND faab005 = ? "
   PREPARE aooi110_master_chk1 FROM g_sql
   EXECUTE aooi110_master_chk1 USING g_tree[pi_id].b_faab004 INTO li_cnt
   FREE aooi110_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
#+ 單頭資料重新顯示
PRIVATE FUNCTION afai010_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point    
   
   LET g_faab_m.faab001 = g_browser[g_current_idx].b_faab001   
   LET g_faab_m.faab002 = g_browser[g_current_idx].b_faab002   
 
   LET g_faab_m.faab003 = g_browser[g_current_idx].b_faab003   
 
 
    SELECT UNIQUE faab001,faab002,faab003,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt
 INTO g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt
 FROM faab_t
 WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 AND faab002 = g_faab_m.faab002 AND faab003 = g_faab_m.faab003
   CALL afai010_show()
   
END FUNCTION
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION afai010_desc_show(pi_ac)
   {<Local define>}
   DEFINE pi_ac   LIKE type_t.num5
   DEFINE li_tmp  LIKE type_t.num5
   DEFINE l_ref   LIKE type_t.chr80 
   DEFINE l_faab007 LIKE faab_t.faab007
   DEFINE ls_msg     STRING
   DEFINE l_str      STRING
   {</Local define>}
   #add-point:desc_show段define
   {<point name="desc_show.define"/>}
   #end add-point
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   IF l_ac = 1 THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[l_ac].b_faab002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_faab_m.faab002_desc = g_rtn_fields[1]
      LET ls_msg = cl_getmsg("aoo-00232",g_lang)
      LET l_str = g_tree[l_ac].b_faab003
      LET l_str = l_str.trim()      
      LET g_tree[l_ac].b_show = g_tree[l_ac].b_faab002,'(',g_rtn_fields[1],')(',ls_msg,l_str,')'           
      SELECT DISTINCT faab007 INTO l_faab007 FROM faab_t WHERE faabent = g_enterprise AND faab001 = g_tree[l_ac].b_faab001 AND faab002 = g_tree[l_ac].b_faab002 AND faab003 = g_tree[l_ac].b_faab003
      IF l_faab007 = 'Y' THEN 
         LET g_tree[l_ac].b_faab003_desc = "16/lt-myfav.png"
      ELSE
         IF g_tree[l_ac].b_exp = TRUE THEN 
            LET g_tree[l_ac].b_faab003_desc = "16/folder-16.png"
         ELSE
            LET g_tree[l_ac].b_faab003_desc = "16/closefolder-16.png"           
         END IF           
      END IF 
   ELSE 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[l_ac].b_faab004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_faab_m.faab002_desc = g_rtn_fields[1]
      LET g_tree[l_ac].b_show = g_tree[l_ac].b_faab004,'(',g_rtn_fields[1],')'    
      IF g_tree[l_ac].b_hasC = TRUE THEN
         IF g_tree[l_ac].b_exp = TRUE THEN 
            LET g_tree[l_ac].b_faab003_desc = "16/folder-16.png"
         ELSE
            LET g_tree[l_ac].b_faab003_desc = "16/closefolder-16.png"           
         END IF
      ELSE   
         LET g_tree[l_ac].b_faab003_desc = "16/module.png"         
      END IF     
   END IF
   LET l_ac = li_tmp
   
END FUNCTION
#+ 尋找符合條件的節點
PRIVATE FUNCTION afai010_find_node(pi_ac)
   {<Local define>}
   DEFINE pi_ac   LIKE type_t.num5
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_tmp  LIKE type_t.num5
   DEFINE ls_pid  STRING
   {</Local define>}
   #add-point:find_node段define
   {<point name="find_node.define"/>}
   #end add-point
   
   LET ls_pid = g_tree[pi_ac].b_pid
   
   LET g_sql = " SELECT UNIQUE '','','','FALSE','','',exp_code,'','',faab001,faab002,faab003 ",
               " FROM afai010_tmp ",
               " WHERE faab005 = ? AND faab005 <> faab004",
               " ORDER BY faab004"
   PREPARE master_getNode FROM g_sql
   DECLARE master_getNodecur CURSOR FOR master_getNode
   
   LET li_idx = pi_ac
   WHILE li_idx <= g_browser.getLength()
      IF g_tree[li_idx].b_expcode = -1 THEN
         OPEN master_getNodecur USING g_tree[li_idx].b_faab004
         FOREACH master_getNodecur INTO g_tree[g_browser.getLength()+1].*
            CALL afai010_desc_show(g_browser.getLength())
            LET g_tree[g_tree.getLength()].b_pid = ls_pid
            LET g_tree[g_tree.getLength()].b_id = g_tree.getLength()
            LET g_tree[g_tree.getLength()].b_hasC = afai010_chk_hasC(g_tree.getLength())
         END FOREACH
         CALL g_tree.deleteElement(li_idx)
         CALL g_tree.deleteElement(g_tree.getLength())
      ELSE
         LET li_idx = li_idx + 1
      END IF
   
   END WHILE
   
   FREE master_getNode
   
   RETURN g_tree.getLength()
   
END FUNCTION
#+ 資料輸入
PRIVATE FUNCTION afai010_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1                #未取消的ARRAY CNT 
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num5
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
   {<point name="input.define"/>}
   #end add-point    
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   {<point name="input.define_sql" mark="Y"/>}
   #end add-point 
   LET g_forupd_sql = "SELECT faab004,faab005 FROM faab_t WHERE faabent=? AND faab001=? AND faab002=? AND faab003=? AND faab004=? FOR UPDATE"
   #add-point:input段define_sql
   {<point name="input.after_define_sql"/>}
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE afai010_bcl CURSOR FROM g_forupd_sql
   
 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afai010_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL afai010_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   {<point name="input.after_set_no_entry"/>}
   #end add-point
 
   DISPLAY BY NAME g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #add-point:資料輸入前
            LET g_faab001_t = g_faab_m.faab001
            LET g_faab002_t = g_faab_m.faab002
          
            IF p_cmd = 'u' THEN LET g_faab003_t = g_faab_m.faab003 END IF
            #end add-point
            
         #---------------------------<  Master  >---------------------------
         #----<<faab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab001
            #add-point:BEFORE FIELD faab001
            {<point name="input.b.faab001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab001
            IF NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) THEN 
               CALL afai010_faab003_def(g_faab_m.faab001,g_faab_m.faab002) RETURNING g_faab_m.faab003
               DISPLAY BY NAME g_faab_m.faab003
            END IF            
            #add-point:AFTER FIELD faab001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) AND NOT cl_null(g_faab_m.faab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_faab_m.faab001 != g_faab001_t  OR g_faab_m.faab002 != g_faab002_t  OR g_faab_m.faab003 != g_faab003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||g_faab_m.faab001 ||"' AND "|| "faab002 = '"||g_faab_m.faab002 ||"' AND "|| "faab003 = '"||g_faab_m.faab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE faab001
            #add-point:ON CHANGE faab001
            {<point name="input.g.faab001" />}
            #END add-point
 
         #----<<faab002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab002
            #add-point:BEFORE FIELD faab002
            CALL afai010_faab002_desc(g_faab_m.faab002)
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab002
            CALL afai010_faab002_desc(g_faab_m.faab002)   
            IF NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) THEN 
               CALL afai010_faab003_def(g_faab_m.faab001,g_faab_m.faab002) RETURNING g_faab_m.faab003
               DISPLAY BY NAME g_faab_m.faab003
            END IF
            #add-point:AFTER FIELD faab002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) AND NOT cl_null(g_faab_m.faab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_faab_m.faab001 != g_faab001_t  OR g_faab_m.faab002 != g_faab002_t  OR g_faab_m.faab003 != g_faab003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||g_faab_m.faab001 ||"' AND "|| "faab002 = '"||g_faab_m.faab002 ||"' AND "|| "faab003 = '"||g_faab_m.faab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_faab_m.faab002) THEN
               IF NOT ap_chk_isExist(g_faab_m.faab002,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN 
                  LET g_faab_m.faab002 = g_faab_m_t.faab002
                  NEXT FIELD CURRENT
               END IF 
#               IF NOT ap_chk_isExist(g_faab_m.faab002,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'aoo-00095',1) THEN 
                IF NOT ap_chk_isExist(g_faab_m.faab002,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'sub-01302','aooi125') THEN  #160318-00005#8 mod
                  LET g_faab_m.faab002 = g_faab_m_t.faab002
                  NEXT FIELD CURRENT
               END IF 
               #IF NOT ap_chk_isExist(g_faab_m.faab002,"SELECT COUNT(*) FROM ooef_t LEFT OUTER JOIN ooee_t ON ooeeent = ooefent AND ooee001=ooef001  WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y'  AND ooee002='2' AND ooee003='B'",'afa-00004',1) THEN 
               #   LET g_faab_m.faab002 = g_faab_m_t.faab002
               #   NEXT FIELD CURRENT
               #END IF                
            END IF
            CALL afai010_faab002_desc(g_faab_m.faab002)

          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE faab002
            #add-point:ON CHANGE faab002
            {<point name="input.g.faab002" />}
            #END add-point
 
         #----<<faab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab003
            #add-point:BEFORE FIELD faab003
            {<point name="input.b.faab003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab003
            
            #add-point:AFTER FIELD faab003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) AND NOT cl_null(g_faab_m.faab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_faab_m.faab001 != g_faab001_t  OR g_faab_m.faab002 != g_faab002_t  OR g_faab_m.faab003 != g_faab003_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||g_faab_m.faab001 ||"' AND "|| "faab002 = '"||g_faab_m.faab002 ||"' AND "|| "faab003 = '"||g_faab_m.faab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE faab003
            #add-point:ON CHANGE faab003
            {<point name="input.g.faab003" />}
            #END add-point
 
         #----<<faab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab006
            #add-point:BEFORE FIELD faab004
            {<point name="input.b.faab004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab006
            IF NOT cl_null(g_faab_m.faab006) THEN 
               IF NOT afai010_faab006_chk('0') THEN 
                  LET g_faab_m.faab006 = g_faab_m_t.faab006
                  NEXT FIELD CURRENT
               END IF
            END IF
            
 
         #此段落由子樣板a04產生
         ON CHANGE faab006
            #add-point:ON CHANGE faab004
            {<point name="input.g.faab004" />}
            #END add-point
 
         #----<<faab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab007
            #add-point:BEFORE FIELD faab005
            {<point name="input.b.faab005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab007
          
 
         #此段落由子樣板a04產生
         ON CHANGE faab007
            IF NOT afai010_faab007_chk() THEN 
               LET g_faab_m.faab007 = g_faab_m_t.faab007
               NEXT FIELD CURRENT
            END IF  
 

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<faab001>>----
         #Ctrlp:input.c.faab001
#         ON ACTION controlp INFIELD faab001
            #add-point:ON ACTION controlp INFIELD faab001
            {<point name="input.c.faab001" />}
            #END add-point
 
         #----<<faab002>>----
         #Ctrlp:input.c.faab002
         ON ACTION controlp INFIELD faab002

            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faab_m.faab002             #給予default值

            #給予arg

            CALL q_ooef001_6()                                #呼叫開窗141

            LET g_faab_m.faab002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faab_m.faab002 TO faab002              #顯示到畫面上
            CALL afai010_faab002_desc(g_faab_m.faab002) 
            NEXT FIELD faab002                          #返回原欄位
            #END add-point
 
         #----<<faab003>>----
         #Ctrlp:input.c.faab003
#         ON ACTION controlp INFIELD faab003
            #add-point:ON ACTION controlp INFIELD faab003
            {<point name="input.c.faab003" />}
            #END add-point
 
         #----<<faab004>>----
         #Ctrlp:input.c.faab006
#         ON ACTION controlp INFIELD faab006
            #add-point:ON ACTION controlp INFIELD faab006
            {<point name="input.c.faab004" />}
            #END add-point
 
         #----<<faab005>>----
         #Ctrlp:input.c.faab007
#         ON ACTION controlp INFIELD faab007
            #add-point:ON ACTION controlp INFIELD faab007
            {<point name="input.c.faab005" />}
            #END add-point
 
         #----<<faabownid>>----
         #----<<faabowndp>>----
         #----<<faabcrtid>>----
         #----<<faabcrtdp>>----
         #----<<faabcrtdt>>----
         #----<<faabmodid>>----
         #----<<faabmoddt>>----
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            IF NOT cl_null(g_faab_m.faab006) THEN 
               IF NOT afai010_faab006_chk('1') THEN 
                  LET g_faab_m.faab006 = g_faab_m_t.faab006
                  NEXT FIELD faab006
               END IF
            END IF                
            CALL cl_err_collect_show()      #錯誤訊息統整顯示   #151023-00016#1 Mod  cl_showmsg() --> cl_err_collect_show()
            DISPLAY BY NAME g_faab_m.faab001             
                            ,g_faab_m.faab002   
                            ,g_faab_m.faab003   
 
 
 
            IF p_cmd <> 'u' THEN
              LET l_count = 1  
              
              SELECT COUNT(*) INTO l_count FROM faab_t
               WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
                 AND faab002 = g_faab_m.faab002 
                 AND faab003 = g_faab_m.faab003
 
              IF l_count = 0 THEN
                 
                 #add-point:單頭新增前
                 {<point name="input.head.b_insert" mark="Y"/>}
                 #end add-point
                 
                 INSERT INTO faab_t (faabent,faab001,faab002,faab003,faab004,faab005,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt)
                 VALUES (g_enterprise,g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab002,g_faab_m.faab002,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt) # DISK WRITE
                 
                 #add-point:單頭新增中
                 {<point name="input.head.m_insert"/>}
                 #end add-point
                 
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "g_faab_m"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
  
                    CONTINUE DIALOG
                 END IF

                 #add-point:單頭新增後
                 {<point name="input.head.a_insert"/>}
                 #end add-point
                 CALL afai010_ins_faab(g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab002)
                 CALL s_transaction_end('Y','0')
                 
                 LET p_cmd = 'u'
              ELSE
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '!'
                 LET g_errparam.extend =  g_faab_m.faab001
                 LET g_errparam.popup = FALSE
                 CALL cl_err()

                 CALL s_transaction_end('N','0')
                 NEXT FIELD faab001
              END IF 
            ELSE
            
               #add-point:單頭修改前
               LET g_faab_m.faabmodid = g_user
               LET g_faab_m.faabmoddt = cl_get_current()
               #end add-point
               
               UPDATE faab_t SET (faab001,faab002,faab003,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt) = (g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt)
                WHERE faabent = g_enterprise AND faab001 = g_faab001_t
                  AND faab002 = g_faab002_t
 
                  AND faab003 = g_faab003_t
 
 
                  
               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "g_faab_m"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
  
                  CALL s_transaction_end('N','0')
               ELSE
                  
                  
                  #add-point:單頭修改後
                  {<point name="input.head.a_update"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               
               
            END IF
           #controlp
      END INPUT
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_faab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afai010_b_fill()
            LET g_rec_b = g_faab_d.getLength()
         
         BEFORE ROW
            #CALL afai010_show()
            #LET g_rec_b = g_faab_d.getLength()
            
            LET l_insert = FALSE
            LET l_cmd = ''
            #CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN afai010_cl USING g_enterprise,g_faab_m.faab001
            #                                                    ,g_faab_m.faab002
            #                                                    ,g_faab_m.faab003
 
 
            #IF STATUS THEN
            #   CALL cl_err("OPEN afai010_cl:", STATUS, 1)
            #   CLOSE afai010_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
                   
            #FETCH afai010_cl INTO g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab004,g_faab_m.faab005,g_faab_m.faabownid,g_faab_m.faabownid_desc,g_faab_m.faabowndp,g_faab_m.faabowndp_desc,g_faab_m.faabcrtid,g_faab_m.faabcrtid_desc,g_faab_m.faabcrtdp,g_faab_m.faabcrtdp_desc,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmodid_desc,g_faab_m.faabmoddt # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_faab_m.faab001,SQLCA.sqlcode,0)
            #   CLOSE afai010_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_faab_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_faab_d[l_ac].faab004) 
               
            THEN
               LET l_cmd='u'
               LET g_faab_d_t.* = g_faab_d[l_ac].*  #BACKUP
               CALL afai010_set_entry_b(l_cmd)
               CALL afai010_set_no_entry_b(l_cmd)
               IF NOT afai010_lock_b("faab_t","1") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afai010_bcl INTO g_faab_d[l_ac].faab004,g_faab_d[l_ac].faab005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_faab_d_t.faab004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  IF g_faab_d[l_ac].faab004 = g_faab_d[l_ac].faab005 THEN 
                     CALL FGL_SET_ARR_CURR(l_ac+1)
                  END IF
                  LET g_bfill = "N"
                  CALL afai010_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            #end add-point  
            
            #其他table資料備份(確定是否更改用)
            
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faab_d[l_ac].* TO NULL 
            
            LET g_faab_d_t.* = g_faab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afai010_set_entry_b(l_cmd)
            CALL afai010_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)
            
            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
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
            SELECT COUNT(*) INTO l_count FROM faab_t 
             WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
               AND faab002 = g_faab_m.faab002
 
               AND faab003 = g_faab_m.faab003
 
 
               AND g_faab_d[l_ac].faab004 = faab004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               {<point name="input.body.b_insert"/>}
               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faab_m.faab001
               LET gs_keys[2] = g_faab_m.faab002
               LET gs_keys[3] = g_faab_m.faab003
               LET gs_keys[4] = g_faab_d[g_detail_idx].faab004
               CALL afai010_insert_b('faab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               {<point name="input.body.a_insert"/>}
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_faab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "faab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afai010_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               {<point name="input.body.a_insert2"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_faab_d[l_ac].faab004) 
 
               THEN
               IF g_faab_d[l_ac].faab004 = g_faab_d[l_ac].faab005 AND g_faab_d[l_ac].faab004 = g_faab_m.faab002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00016'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF


               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM faab_t
                WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
                  AND faab002 = g_faab_m.faab002 AND faab003 = g_faab_m.faab003 
                  AND faab005 = g_faab_d_t.faab004
               IF l_cnt > 0 THEN   
                  IF NOT cl_ask_confirm('afa-00028') THEN CANCEL DELETE END IF 
               ELSE
                  IF NOT cl_ask_confirm('afa-00029') THEN CANCEL DELETE END IF
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
               {<point name="input.body.b_delete" mark="Y"/>}
               #end add-point   
               
               DELETE FROM faab_t
                WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 AND
                      faab002 = g_faab_m.faab002 AND
 
                      faab003 = g_faab_m.faab003 AND
                      (faab004 = g_faab_d_t.faab004 OR faab005 = g_faab_d_t.faab004)
 
                  
               #add-point:單身刪除中
               {<point name="input.body.m_delete"/>}
               #end add-point  
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "faab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1 - l_cnt
 
                  #add-point:單身刪除後
                  {<point name="input.body.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afai010_bcl
             
               LET l_count = g_faab_d.getLength()

            END IF 
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faab_m.faab001
               LET gs_keys[2] = g_faab_m.faab002
               LET gs_keys[3] = g_faab_m.faab003
               LET gs_keys[4] = g_faab_d[g_detail_idx].faab004
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            CALL afai010_b_fill() 
            #end add-point
            #CALL afai010_delete_b('faab_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<faab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab004
            CALL afai010_faab004_desc(g_faab_d[l_ac].faab004) RETURNING g_faab_d[l_ac].faab004_desc
            DISPLAY g_faab_d[l_ac].faab004_desc TO s_detail1[l_ac].faab004_desc 
 
         #此段落由子樣板a02產生
         AFTER FIELD faab004
            CALL afai010_faab004_desc(g_faab_d[l_ac].faab004) RETURNING g_faab_d[l_ac].faab004_desc
            DISPLAY g_faab_d[l_ac].faab004_desc TO s_detail1[l_ac].faab004_desc           
            #add-point:AFTER FIELD faab004
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) AND NOT cl_null(g_faab_m.faab003) AND NOT cl_null(g_faab_d[g_detail_idx].faab004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_faab_m.faab001 != g_faab001_t OR g_faab_m.faab002 != g_faab002_t OR g_faab_m.faab003 != g_faab003_t OR g_faab_d[g_detail_idx].faab004 != g_faab_d_t.faab004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||g_faab_m.faab001 ||"' AND "|| "faab002 = '"||g_faab_m.faab002 ||"' AND "|| "faab003 = '"||g_faab_m.faab003 ||"' AND "|| "faab004 = '"||g_faab_d[g_detail_idx].faab004 ||"'",'std-00004',0) THEN 
                     LET g_faab_d[g_detail_idx].faab004 = g_faab_d_t.faab004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_faab_d[l_ac].faab004) THEN
               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab004,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN 
                  LET g_faab_d[l_ac].faab004 = g_faab_d_t.faab004
                  NEXT FIELD CURRENT
               END IF 
#               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab004,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'aoo-00095',1) THEN 
               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab004,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'sub-01302','aooi125') THEN  #160318-00005#8 mod
                  LET g_faab_d[l_ac].faab004 = g_faab_d_t.faab004
                  NEXT FIELD CURRENT
               END IF 
              # IF NOT ap_chk_isExist(g_faab_d[l_ac].faab004,"SELECT COUNT(*) FROM ooea_t WHERE "||"ooeaent = '" ||g_enterprise|| "' AND "||"ooea001 = ? AND ooeastus ='Y' AND ooea009 ='Y'",'axr-00008',1) THEN 
              #    LET g_faab_d[l_ac].faab004 = g_faab_d_t.faab004
              #    NEXT FIELD CURRENT
              # END IF                
            END IF
          
          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE faab004
            #add-point:ON CHANGE faab004
            {<point name="input.g.page1.faab004" />}
            #END add-point
 
         #----<<faab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab005
            CALL afai010_faab004_desc(g_faab_d[l_ac].faab005) RETURNING g_faab_d[l_ac].faab005_desc
            DISPLAY g_faab_d[l_ac].faab005_desc TO s_detail1[l_ac].faab005_desc 
 
         #此段落由子樣板a02產生
         AFTER FIELD faab005
            CALL afai010_faab004_desc(g_faab_d[l_ac].faab005) RETURNING g_faab_d[l_ac].faab005_desc
            DISPLAY g_faab_d[l_ac].faab005_desc TO s_detail1[l_ac].faab005_desc             
            IF NOT cl_null(g_faab_d[l_ac].faab005) THEN
               IF g_faab_d[l_ac].faab005 = g_faab_d[l_ac].faab004 AND g_faab_d[l_ac].faab005 <> g_faab_m.faab002 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00014'
                  LET g_errparam.extend = g_faab_d[l_ac].faab005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faab_d[l_ac].faab005 = g_faab_d_t.faab005
                  NEXT FIELD CURRENT                  
               END IF
               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab005,"SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||g_faab_m.faab001||"' AND faab002 = '"||g_faab_m.faab002||"' AND faab003 = "||g_faab_m.faab003||" AND faab004 = ? ",'axr-00014',1) THEN 
                  LET g_faab_d[l_ac].faab005 = g_faab_d_t.faab005
                  NEXT FIELD CURRENT
               END IF                
               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab005,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN 
                  LET g_faab_d[l_ac].faab005 = g_faab_d_t.faab005
                  NEXT FIELD CURRENT
               END IF 
#               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab005,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'aoo-00095',1) THEN 
               IF NOT ap_chk_isExist(g_faab_d[l_ac].faab005,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'sub-01302','aooi125') THEN #160318-00005#8 mod
                  LET g_faab_d[l_ac].faab005 = g_faab_d_t.faab005
                  NEXT FIELD CURRENT
               END IF                
            END IF
            CALL afai010_faab004_desc(g_faab_d[l_ac].faab005) RETURNING g_faab_d[l_ac].faab005_desc
            #DISPLAY BY NAME g_faab_d[l_ac].faab005_desc             
 
         #此段落由子樣板a04產生
         ON CHANGE faab005
            #add-point:ON CHANGE faab005
            {<point name="input.g.page1.faab005" />}
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<faab004>>----
         #Ctrlp:input.c.page1.faab004
         ON ACTION controlp INFIELD faab004
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faab_d[l_ac].faab004             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_faab_d[l_ac].faab004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faab_d[l_ac].faab004 TO faab004              #顯示到畫面上

            NEXT FIELD faab004                          #返回原欄位
 
         #----<<faab005>>----
         #Ctrlp:input.c.page1.faab005
         ON ACTION controlp INFIELD faab005
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faab_d[l_ac].faab005             #給予default值
            LET g_qryparam.where = " faab004 <> '",g_faab_d[l_ac].faab004,"'"
            #給予arg
            LET g_qryparam.arg1 = g_faab_m.faab001
            LET g_qryparam.arg2 = g_faab_m.faab002
            LET g_qryparam.arg3 = g_faab_m.faab003
            
            CALL q_faab004()                                #呼叫開窗

            LET g_faab_d[l_ac].faab005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faab_d[l_ac].faab005 TO faab005              #顯示到畫面上

            NEXT FIELD faab005                          #返回原欄位
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_faab_d[l_ac].* = g_faab_d_t.*
               CLOSE afai010_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_faab_d[l_ac].faab004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_faab_d[l_ac].* = g_faab_d_t.*
            ELSE
            
               #add-point:單身修改前
               LET g_faab_m.faabmodid = g_user
               LET g_faab_m.faabmoddt = cl_get_current()
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE faab_t SET (faab001,faab002,faab003,faab004,faab005) = (g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_d[l_ac].faab004,g_faab_d[l_ac].faab005)
                WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
                  AND faab002 = g_faab_m.faab002 
 
                  AND faab003 = g_faab_m.faab003 
 
 
                  AND faab004 = g_faab_d_t.faab004 #項次   
 
               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "faab_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_faab_d[l_ac].* = g_faab_d_t.*
               ELSE
                  CALL afai010_ref_upd()
               END IF
               
               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL afai010_unlock_b("faab_t","1")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            
         AFTER INPUT
            #add-point:input段after input 
            {<point name="input.body.after_input"/>}
            #end add-point   
              
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
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_action_choice="exit"
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
    
   #add-point:input段after input 
   {<point name="input.after_input"/>}
   #end add-point    
 
END FUNCTION
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afai010_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("faab002",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("faab001",FALSE)
   #end add-point 
END FUNCTION
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afai010_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("faab001,faab002",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point 
END FUNCTION
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afai010_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point   
   
   #先刷新資料
   #CALL afai010_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "faab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afai010_bcl USING g_enterprise,
                                       g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_d[g_detail_idx].faab004
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "afai010_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
                                    
   RETURN TRUE
END FUNCTION
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afai010_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afai010_bcl
   END IF
END FUNCTION
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION afai010_default_search()
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
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " faab001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " faab002 = '", g_argv[02], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " faab003 = ", g_argv[03], " AND "
   END IF
 
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   IF NOT cl_null(g_faab001) THEN
      IF g_faab001 <>'0' THEN 
         CALL cl_set_comp_entry('faab001',FALSE)
      END IF
   END IF
   #end add-point  
END FUNCTION
#+ 單身筆數變更
PRIVATE FUNCTION afai010_idx_chk()
   #add-point:idx_chk段define
   {<point name="idx_chk.define"/>}
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_faab_d.getLength() THEN
         LET g_detail_idx = g_faab_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faab_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_faab_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION
#+ 單身欄位開啟設定
PRIVATE FUNCTION afai010_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   

   CALL cl_set_comp_entry("faab004,faab005",TRUE)

END FUNCTION
#+ 單身欄位關閉設定
PRIVATE FUNCTION afai010_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   IF p_cmd = 'u' AND g_faab_d[l_ac].faab004 = g_faab_d[l_ac].faab005 THEN
      CALL cl_set_comp_entry("faab004,faab005",FALSE) 
   END IF
END FUNCTION
#+ 資料複製
PRIVATE FUNCTION afai010_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE faab_t.faab001 
   DEFINE l_oldno     LIKE faab_t.faab001 
   DEFINE l_newno02     LIKE faab_t.faab002 
   DEFINE l_oldno02     LIKE faab_t.faab002 
 
   DEFINE l_newno03     LIKE faab_t.faab003 
   DEFINE l_oldno03     LIKE faab_t.faab003 
 
 
   DEFINE l_master    RECORD LIKE faab_t.*
   DEFINE l_detail    RECORD LIKE faab_t.*
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point   
 
   IF g_faab_m.faab001 IS NULL
   OR g_faab_m.faab002 IS NULL
 
   OR g_faab_m.faab003 IS NULL
 
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
    
   CALL afai010_set_entry('a')
   CALL afai010_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")

     
   INPUT l_newno   # FROM
         ,l_newno02
 
         ,l_newno03
 
 
    FROM faab001 
         ,faab002 
 
         ,faab003 
 
 
         ATTRIBUTE(FIELD ORDER FORM)
         
      #add-point:複製段落開窗/欄位控管/自定義action
      {<point name="reproduce.action" />}
      #end add-point
      
      BEFORE INPUT
         CALL afai010_faab002_desc(l_newno02)
         LET l_newno = g_faab_m.faab001
         DISPLAY l_newno TO faab001
 
      AFTER FIELD faab001 
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         IF NOT cl_null(l_newno) AND NOT cl_null(l_newno02) THEN 
            CALL afai010_faab003_def(l_newno,l_newno02) RETURNING l_newno03
            DISPLAY l_newno03 TO faab003
         END IF            
         IF NOT cl_null(l_newno) AND NOT cl_null(l_newno02) AND NOT cl_null(l_newno03) THEN 
            IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||l_newno ||"' AND "|| "faab002 = '"||l_newno02 ||"' AND "|| "faab003 = '"||l_newno03 ||"'",'std-00004',0) THEN 
               LET l_newno = l_oldno
               NEXT FIELD CURRENT
            END IF
         END IF
       
      BEFORE FIELD faab002
         CALL afai010_faab002_desc(l_newno02)
         
      AFTER FIELD faab002 
         IF l_newno02 IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         CALL afai010_faab002_desc(l_newno02)   
         IF NOT cl_null(l_newno) AND NOT cl_null(l_newno02) THEN 
            CALL afai010_faab003_def(l_newno,l_newno02) RETURNING l_newno03
            DISPLAY l_newno03 TO faab003
         END IF

         IF NOT cl_null(l_newno) AND NOT cl_null(l_newno02) AND NOT cl_null(l_newno03) THEN 
            IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faab_t WHERE "||"faabent = '" ||g_enterprise|| "' AND "||"faab001 = '"||l_newno||"' AND "|| "faab002 = '"||l_newno02 ||"' AND "|| "faab003 = '"||l_newno03 ||"'",'std-00004',0) THEN 
               LET l_newno02 = l_oldno02
               NEXT FIELD CURRENT
            END IF
         END IF
         IF NOT cl_null(l_newno02) THEN
            IF NOT ap_chk_isExist(l_newno02,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'aoo-00094',1) THEN 
               LET l_newno02 = l_oldno02
               NEXT FIELD CURRENT
            END IF 
#            IF NOT ap_chk_isExist(l_newno02,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'aoo-00095',1) THEN 
             IF NOT ap_chk_isExist(l_newno02,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' ",'sub-01302','aooi125') THEN  #160318-00005#8 mod
               LET l_newno02 = l_oldno02
               NEXT FIELD CURRENT
            END IF 
            #IF NOT ap_chk_isExist(l_newno02,"SELECT COUNT(*) FROM ooef_t LEFT OUTER JOIN ooee_t ON ooeeent = ooefent AND ooee001=ooef001 WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooefstus ='Y' AND ooee002='2' AND ooee003='B' ",'afa-00004',1) THEN 
            #   LET l_newno02 = l_oldno02
            #   NEXT FIELD CURRENT
            #END IF                
         END IF
 
      AFTER FIELD faab003 
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         #add-point:AFTER FIELD faab003
         {<point name="reproduce.a.faab003" />}
         #end add-point

      ON ACTION controlp INFIELD faab002
	 	 INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
		 LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = l_newno02             #給予default值
         CALL q_ooef001_6()                                #呼叫開窗1

         LET l_newno02 = g_qryparam.return1              #將開窗取得的值回傳到變數

         DISPLAY l_newno02 TO faab002              #顯示到畫面上
         CALL afai010_faab002_desc(l_newno02) 
         NEXT FIELD faab002                          #返回原欄位
 
             
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
      
         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM faab_t 
          WHERE faabent = g_enterprise AND faab001 = l_newno
            AND faab002 = l_newno02
 
            AND faab003 = l_newno03
 
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            #NEXT FIELD faab001 
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
    
   LET g_sql = "SELECT * FROM faab_t WHERE faabent = '" ||g_enterprise|| "' AND ",
               " faab001 = '",g_faab_m.faab001,"'"
               ," AND faab002 = '",g_faab_m.faab002,"'"
 
               ," AND faab003 = '",g_faab_m.faab003,"'"
 
 
   DECLARE afai010_reproduce CURSOR FROM g_sql
 
   FOREACH afai010_reproduce INTO l_detail.*
      LET l_detail.faab001 = l_newno
      LET l_detail.faab002 = l_newno02
 
      LET l_detail.faab003 = l_newno03
      IF l_detail.faab004 = g_faab_m.faab002 THEN 
         LET l_detail.faab004 = l_newno02
      END IF
      IF l_detail.faab005 = g_faab_m.faab002 THEN 
         LET l_detail.faab005 = l_newno02
      END IF 
      LET l_detail.faabstus ='N'      
      LET l_detail.faabownid = g_user
      LET l_detail.faabowndp = g_dept
      LET l_detail.faabcrtid = g_user
      LET l_detail.faabcrtdp = g_dept 
      LET l_detail.faabcrtdt = cl_get_current()
      LET l_detail.faabmodid = "" #g_user
      LET l_detail.faabmoddt = "" #cl_get_current()
      
      IF l_detail.faab007 = 'Y' THEN 
         LET l_detail.faab007 = 'N'
      END IF
 
  
      #add-point:單身複製前
      {<point name="reproduce.body.b_insert" mark="Y"/>}
      #end add-point
      
      INSERT INTO faab_t VALUES (l_detail.*) #複製單身
      
      #add-point:單身複製中
      {<point name="reproduce.body.m_insert"/>}
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
   CLOSE afai010_reproduce
   LET g_state = "Y"
   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point
   
END FUNCTION
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afai010_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num5
   DEFINE l_sql     STRING
   {</Local define>}
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point  
 
   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point
   
   
   
   LET g_faab_m_t.* = g_faab_m.*      #保存單頭舊值
  
   DISPLAY BY NAME g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab002_desc,g_faab_m.faab003,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabownid_desc,g_faab_m.faabowndp,g_faab_m.faabowndp_desc,g_faab_m.faabcrtid,g_faab_m.faabcrtid_desc,g_faab_m.faabcrtdp,g_faab_m.faabcrtdp_desc,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmodid_desc,g_faab_m.faabmoddt
  
   IF g_bfill = "Y" THEN
      CALL afai010_b_fill()                 #單身
   END IF
   
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_faab_m.faabownid_desc = cl_get_username(g_faab_m.faabownid)
      #LET g_faab_m.faabowndp_desc = cl_get_deptname(g_faab_m.faabowndp)
      #LET g_faab_m.faabcrtid_desc = cl_get_username(g_faab_m.faabcrtid)
      #LET g_faab_m.faabcrtdp_desc = cl_get_deptname(g_faab_m.faabcrtdp)
      #LET g_faab_m.faabmodid_desc = cl_get_username(g_faab_m.faabmodid)
      ##LET g_faab_m.xrahcnfid_desc = cl_get_deptname(g_faab_m.xrahcnfid)
      ##LET g_faab_m.xrahpstid_desc = cl_get_deptname(g_faab_m.xrahpstid)
      
 
 
 
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   CALL afai010_faab002_desc(g_faab_m.faab002)
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faab_m.faabownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faab_m.faabownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_faab_m.faabownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faab_m.faabowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faab_m.faabowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_faab_m.faabowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faab_m.faabcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faab_m.faabcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_faab_m.faabcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faab_m.faabcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faab_m.faabcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_faab_m.faabcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faab_m.faabmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faab_m.faabmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_faab_m.faabmodid_desc
            
   #end add-point
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
  
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_faab_d.getLength()

      CALL afai010_faab004_desc(g_faab_d[l_ac].faab004) RETURNING g_faab_d[l_ac].faab004_desc
      DISPLAY BY NAME g_faab_d[l_ac].faab004_desc
      
      CALL afai010_faab004_desc(g_faab_d[l_ac].faab005) RETURNING g_faab_d[l_ac].faab005_desc
      DISPLAY BY NAME g_faab_d[l_ac].faab005_desc

   END FOR

   
   CASE g_faab_m.faabstus        
     WHEN "N"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
        CALL cl_set_act_visible("delete,modify",TRUE)
     WHEN "Y"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
        CALL cl_set_act_visible("delete,modify",FALSE)
     WHEN "X"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
        CALL cl_set_act_visible("delete,modify",FALSE)         
   END CASE  
   
    
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point
   
END FUNCTION
#+ 新增單身後其他table連動
PRIVATE FUNCTION afai010_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert" mark="Y"/>}
      #end add-point  
      INSERT INTO faab_t
                  (faabent,
                   faab001,faab002,faab003,
                   faab004
                   ,faab005,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_faab_d[l_ac].faab005,g_faab_m.faab006,g_faab_m.faab007,g_faab_m.faabstus,g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt)
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert"/>}
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "faab_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert"/>}
      #end add-point  
   END IF
   
END FUNCTION
#+ 修改單身後其他table連動
PRIVATE FUNCTION afai010_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      {<point name="update_b.b_update" mark="Y"/>}
      #end add-point  
      UPDATE faab_t 
         SET (faab001,faab002,faab003,
              faab004
              ,faab005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_faab_d[l_ac].faab005) 
         WHERE faab001 = ps_keys_bak[1] AND faab002 = ps_keys_bak[2] AND faab003 = ps_keys_bak[3] AND faab004 = ps_keys_bak[4] AND faabent=g_enterprise #160905-00007#1 add
      #add-point:update_b段修改中
      {<point name="update_b.m_update"/>}
      #end add-point  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
         
      END IF
      #add-point:update_b段修改後
      {<point name="update_b.a_update"/>}
      #end add-point  
      RETURN
   END IF
   
END FUNCTION
#+ 單身陣列填充
PRIVATE FUNCTION afai010_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point     
 
   CALL g_faab_d.clear()    #g_faab_d 單頭及單身 
 
 
   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE faab004,faab005 FROM faab_t",    
               "",
               " WHERE faabent=? AND faab001=? AND faab002=? AND faab003=?"
 
   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY faab004"
 
   PREPARE afai010_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR afai010_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_enterprise,g_faab_m.faab001
                                            ,g_faab_m.faab002
 
                                            ,g_faab_m.faab003
 
 
                                            
   FOREACH b_fill_cs INTO g_faab_d[l_ac].faab004,g_faab_d[l_ac].faab005
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
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
 
   
   CALL g_faab_d.deleteElement(g_faab_d.getLength())
 
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afai010_pb
 
END FUNCTION
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afai010_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete" mark="Y"/>}
      #end add-point  
      DELETE FROM faab_t
       WHERE faabent = g_enterprise AND
         faab001 = ps_keys_bak[1] AND faab002 = ps_keys_bak[2] AND faab003 = ps_keys_bak[3] AND faab004 = ps_keys_bak[4]
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
      RETURN
   END IF
   
END FUNCTION
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION afai010_browser_search()
    {<Local define>}
   DEFINE li_wc       STRING
   {</Local define>}
   #add-point:browser_search段define

   #END add-point

   IF NOT cl_null(g_searchstr) THEN
      LET li_wc = " lower(", g_searchcol, ") LIKE '", g_searchstr, "%'"
      LET li_wc = li_wc.toLowerCase()
   ELSE
      LET li_wc = " 1=1 "
   END IF

   LET g_wc = li_wc
   CALL afai010_browser_fill("F")
   CALL ui.Interface.refresh()   
END FUNCTION
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afai010_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point    
   #畫面資料初始化
   LET g_bfill = "Y"
   LET g_searchtype = "3"
   LET g_error_show = 1
   CALL cl_set_combo_scc_part('faabstus','13','N,Y,X')
   CALL cl_set_combo_scc('faab001','8305') 
   CALL afai010_default_search()
END FUNCTION
#+ 功能選單
PRIVATE FUNCTION afai010_ui_dialog()
   DEFINE l_value     STRING
   DEFINE l_dnd       ui.DragDrop
   DEFINE l_ac1       STRING
   DEFINE l_ac2       STRING
   DEFINE l_faab004   LIKE ooec_t.ooec004
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_faab004_t LIKE ooec_t.ooec004
   DEFINE l_faab005_t LIKE ooec_t.ooec005
   DEFINE l_n2         LIKE type_t.num5
   DEFINE l_ac3       LIKE type_t.num5
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #temp CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
   #temp CALL gfrm_curr.setElementHidden("mainlayout",1)
   #temp CALL gfrm_curr.setElementHidden("worksheet",0)
   #temp LET g_main_hidden = 1
   
   #add-point:ui_dialog段before dialog 
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point
   
   WHILE TRUE 
   
      CALL afai010_browser_fill('')
      
#      CALL lib_cl_dlg.cl_query_bef_disp()
#      CALL lib_cl_dlg.cl_relate_bef_disp() 
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR l_ac3 = 1 TO g_browser.getLength()
            IF g_browser[l_ac3].b_faab001 = g_faab001_t
               AND g_browser[l_ac3].b_faab002 = g_faab002_t
               AND g_browser[l_ac3].b_faab003 = g_faab003_t
               THEN
               LET g_current_row = l_ac3
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF      #temp CALL cl_notice()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol,formonly.rdo_searchtype
            BEFORE INPUT
         END INPUT
            
         #左側瀏覽頁簽
         DISPLAY ARRAY g_tree TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
             
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL afai010_tree_expand(g_row_index)
                  LET g_tree[g_row_index].b_isExp = 1
                  #CALL afai010_desc_show(g_row_index)
               
               ON COLLAPSE (g_row_index)
                  #樹關閉
                  #LET g_tree[g_row_index].b_exp = FALSE
                  #CALL afai010_desc_show(g_row_index)
                  
               ON DRAG_START(l_dnd)
                  LET l_ac1 = ARR_CURR()
                  LET l_value = g_tree[l_ac1].b_faab004
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM faab_t
                   WHERE faabent = g_enterprise
                     AND (faab004 = g_tree[l_ac1].b_faab004
                         OR faab005 = g_tree[l_ac1].b_faab004)
                     AND faab003 = g_faab_m.faab003    
                     AND faab002 = g_faab_m.faab002
                     AND faab001 = g_faab_m.faab001
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00130'
                     LET g_errparam.extend = l_value
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                  END IF
                  LET l_faab004_t = g_tree[l_ac1].b_faab004
                  LET l_faab005_t = g_tree[l_ac1].b_faab005
                                    
               ON DROP(l_dnd)
                   LET l_ac1 = l_dnd.getLocationParent()
                   IF l_ac1 <> 0 THEN 
                   LET l_n = 0
                   SELECT COUNT(*) INTO l_n
                     FROM faab_t
                    WHERE faabent = g_enterprise
                      AND (faab004 = g_tree[l_ac1].b_faab004
                          OR faab005 = g_tree[l_ac1].b_faab004)
                      AND faab003 = g_faab_m.faab003    
                      AND faab002 = g_faab_m.faab002
                      AND faab001 = g_faab_m.faab001
                   IF l_n = 0 AND NOT cl_null(g_tree[l_ac1].b_faab004) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00130'
                      LET g_errparam.extend = g_tree[l_ac1].b_faab004
                      LET g_errparam.popup = FALSE
                      CALL cl_err()

                   ELSE
                      LET l_ac2 = l_dnd.getLocationParent()
                      LET l_faab004 = g_tree[l_ac2].b_faab004
                      CALL DIALOG.insertRow("s_tree",l_ac1)
                      CALL DIALOG.setCurrentRow("s_tree",l_ac1)
                      IF cl_null(l_ac1) THEN
                         LET l_ac1 = l_dnd.getLocationParent()
                      END IF
                      IF cl_null(g_tree[l_ac2+1].b_show) THEN
                         CALL DIALOG.deleteRow("s_tree",l_ac2+1)
                         CALL g_tree.deleteElement(l_ac2+1)
                      END IF
                      
                      UPDATE faab_t SET faab005 = l_faab004
                       WHERE faabent = g_enterprise
                         AND faab001 = g_faab_m.faab001
                         AND faab002 = g_faab_m.faab002
                         AND faab003 = g_faab_m.faab003
                         AND faab004 = l_faab004_t  
                      CALL l_dnd.dropInternal()
                      IF cl_null(g_tree[l_ac1].b_show) THEN
                         CALL g_tree.deleteElement(l_ac1)
                      END IF
                      FOR l_n2 = 1 TO g_tree.getLength()
                         LET g_tree[l_n2].b_hasC = afai010_chk_hasC(l_n2)
                         CALL afai010_desc_show(l_n2)
                      END FOR
                      CALL afai010_b_fill()
                      CALL afai010_show()
                   END IF
                   END IF
               ON ACTION del_note
                  LET l_ac1 = DIALOG.getCurrentRow("s_browse")
                  LET g_action_choice = "del_note"
                  IF cl_auth_chk_act("del_note") THEN 
                      IF NOT cl_null(l_ac1) AND l_ac1 > 0 THEN
                         CALL afai010_del_note(g_tree[l_ac1].b_faab004)
                      END IF
                      CONTINUE WHILE
                  END IF
               
         END DISPLAY

         DISPLAY ARRAY g_faab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               CALL afai010_idx_chk()
               
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL afai010_idx_chk()
         
         END DISPLAY

         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            #LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            
            #IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
            IF g_current_row > 1 AND g_current_sw = FALSE THEN
               #CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL afai010_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afai010_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afai010_idx_chk()
            
            #NEXT FIELD faab004
      
         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point
      
         #Browser用Action
      
         #一般搜尋
         ON ACTION searchdata
            #取得搜尋關鍵字
            INITIALIZE g_wc TO NULL
            INITIALIZE g_wc2 TO NULL
            INITIALIZE g_wc_table1 TO NULL
 
            LET g_searchstr = GET_FLDBUF(searchstr)
            CALL afai010_browser_search() 

            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -100
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF   
            LET g_action_choice = "searchdata"
            EXIT DIALOG
      
         #進階搜尋
         ON ACTION advancesearch    
            
         ON ACTION statechange
            CALL afai010_statechange()
            LET g_action_choice = "statechange"
            
            CALL afai010_set_act_visible() #20141128 add str--by chenying
        
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
            CALL afai010_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai010_idx_chk()
            EXIT DIALOG
            
         ON ACTION previous
            CALL afai010_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai010_idx_chk()
            EXIT DIALOG
            
         ON ACTION jump
            CALL afai010_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai010_idx_chk()
            EXIT DIALOG
            
         ON ACTION next
            CALL afai010_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai010_idx_chk()
            EXIT DIALOG
            
         ON ACTION last
            CALL afai010_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai010_idx_chk()
            EXIT DIALOG

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
                  LET g_export_node[1] = base.typeInfo.create(g_faab_d)
                  LET g_export_id[1]   = "s_detail1"

                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF

         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT WHILE
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT WHILE
          
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
               NEXT FIELD b_faab001
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
               CALL afai010_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
               CONTINUE WHILE
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL afai010_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
               CONTINUE WHILE
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL afai010_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL afai010_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                CONTINUE WHILE
            END IF

         

         ON ACTION version
            LET g_action_choice="version"
            IF cl_auth_chk_act("version") THEN 
               CALL afai010_faab007_upd()
               CONTINUE WHILE
            END IF
            
         ON ACTION open_afai010_01
            LET g_action_choice="open_afai010_01"
            LET l_ac1 = DIALOG.getCurrentRow("s_browse")
            LET l_ac2 = DIALOG.getCurrentRow("s_detail1")
            IF cl_auth_chk_act("open_afai010_01") THEN 
                IF NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) AND NOT cl_null(g_faab_m.faab003) THEN
                   IF NOT cl_null(l_ac1) AND l_ac1 > 0 THEN
                       CALL afai010_ins_faab(g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_tree[l_ac1].b_faab004)
                   ELSE
                      IF NOT cl_null(l_ac2) AND l_ac2 > 0 THEN
                         CALL afai010_ins_faab(g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_d[l_ac2].faab004)
                      ELSE
                        CALL afai010_ins_faab(g_faab_m.faab001,g_faab_m.faab002,g_faab_m.faab003,g_faab_m.faab002)
                      END IF
                   END IF
                END IF
                CONTINUE WHILE
             END IF
         #主選單用ACTION
         &include "main_menu.4gl"
         
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
            
      END DIALOG
    
     # IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
     #    EXIT WHILE
     # END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
#+ 公用欄位更新
PRIVATE FUNCTION afai010_ref_upd()
 
   CALL s_transaction_begin()
   UPDATE faab_t SET (faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt) = (g_faab_m.faabownid,g_faab_m.faabowndp,g_faab_m.faabcrtid,g_faab_m.faabcrtdp,g_faab_m.faabcrtdt,g_faab_m.faabmodid,g_faab_m.faabmoddt)
    WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
      AND faab002 = g_faab_m.faab002 
      AND faab003 = g_faab_m.faab003   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "faab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET g_faab_d[l_ac].* = g_faab_d_t.*
   END IF
   CALL s_transaction_end('Y','0')   
END FUNCTION
#+
PRIVATE FUNCTION afai010_tree_expand_leaf(pi_id)
   {<Local define>}
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_sql           STRING
   DEFINE ls_type_list     STRING
   {</Local define>}
   #add-point:browser_expand_leaf段define

   #end add-point
   
   IF g_tree[pi_id].b_faab005 IS NULL THEN 
      LET ls_wc = " AND faab002 = '", g_tree[pi_id].b_faab002, "'",
                  " AND faab003 = '", g_tree[pi_id].b_faab003, "'"    
   ELSE
      LET ls_wc = " AND faab002 = '", g_tree[pi_id].b_faab002, "'",
                  " AND faab003 = '", g_tree[pi_id].b_faab003, "'",
                  " AND faab005 = '", g_tree[pi_id].b_faab005, "'"   
   END IF
   
   LET ls_sql = " SELECT UNIQUE faab001,faab002,faab003,faab004,faab005 ",
                " FROM faab_t ",
                "  ",
                "  ",
                " WHERE faabent = '" ||g_enterprise|| "' AND ", g_wc, ls_wc

   LET li_lv = g_tree[pi_id].b_expcode 
          
   LET ls_sql = ls_sql, " ORDER BY faab004"
          

          
   PREPARE leaf_pre FROM ls_sql
   DECLARE leaf_cur CURSOR FOR leaf_pre
   
   LET g_cnt = pi_id + 1
   CALL g_tree.insertElement(g_cnt)
   FOREACH leaf_cur INTO g_tree[g_cnt].b_faab001,g_tree[g_cnt].b_faab002,g_tree[g_cnt].b_faab003,g_tree[g_cnt].b_faab004,g_tree[g_cnt].b_faab005
      LET g_tree[g_cnt].b_pid     = g_tree[pi_id].b_id 
      LET g_tree[g_cnt].b_id      = g_tree[pi_id].b_id , ".", g_cnt USING "<<<"
      LET g_tree[g_cnt].b_exp     = FALSE
      LET g_tree[g_cnt].b_expcode = li_lv + 1
      LET g_tree[g_cnt].b_hasC    = FALSE
      LET g_tree[g_cnt].b_show = g_tree[g_cnt].b_faab004
      CALL afai010_desc_show(g_cnt)
      LET g_cnt = g_cnt + 1
      CALL g_tree.insertElement(g_cnt)
   END FOREACH
   
   CALL g_tree.deleteElement(g_cnt)

END FUNCTION
#+ 確認碼變更
PRIVATE FUNCTION afai010_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   DEFINE l_faab006_max  LIKE faab_t.faab006
   DEFINE l_faab003_max  LIKE faab_t.faab003
   DEFINE  l_count         LIKE type_t.num5  
   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_faab_m.faab001 IS NULL
      #key2
      OR g_faab_m.faab002 IS NULL
      OR g_faab_m.faab003 IS NULL
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
         CASE g_faab_m.faabstus
            WHEN "N"
               HIDE OPTION "open"

            WHEN "Y"
               HIDE OPTION "confirmed"
            
            WHEN "X"
               HIDE OPTION "invalid"

         END CASE
     
      #add-point:menu前

      #end add-point
	  
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制
         SELECT MAX(faab003),MAX(faab006) INTO l_faab003_max,l_faab006_max
          FROM faab_t
         WHERE faabent = g_enterprise 
           AND faab001 = g_faab_m.faab001 
           AND faab002 = g_faab_m.faab002
         IF NOT (l_faab003_max = g_faab_m.faab003 OR l_faab006_max = g_faab_m.faab006) AND g_faab_m.faabstus= 'Y' THEN 
            LET lc_state = ''
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00059'
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         #end add-point
         EXIT MENU

      ON ACTION confirmed
         LET lc_state = "Y"
         #add-point:action控制
         SELECT COUNT(*) INTO l_count FROM faab_t
          WHERE faabent = g_enterprise
            AND faab001 = g_faab_m.faab001
            AND faab002 = g_faab_m.faab002
            AND faab007 = 'Y'
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         IF l_count <= 0  THEN
            IF cl_ask_confirm("afa-00001") THEN
               LET g_faab_m.faab007 = 'Y'
               DISPLAY BY NAME g_faab_m.faab007
            END IF
         END IF
     
         #end add-point
         EXIT MENU

      ON ACTION invalid
         LET lc_state = "X"
         #add-point:action控制
         IF g_faab_m.faab007 ='Y' THEN 
            LET lc_state = ''
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00015'
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         #end add-point
         EXIT MENU

	  
      #add-point:stus控制

      #end add-point
	  
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "Y" AND lc_state <> "X"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   #151125-00001#1 add start ------------------
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         RETURN
      END IF
   END IF
   #151125-00001#1 add end   ------------------
   #end add-point
      
   UPDATE faab_t SET faabstus = lc_state,
                     faab007  = g_faab_m.faab007
    WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
      AND faab002 = g_faab_m.faab002
      AND faab003 = g_faab_m.faab003

  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
            
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
            
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
           
      END CASE
   END IF

END FUNCTION
################################################################################
# Descriptions...: 帳務中心說明
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
PRIVATE FUNCTION afai010_faab002_desc(p_faab002)
DEFINE p_faab002   LIKE faab_t.faab002   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_faab002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faab_m.faab002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_faab_m.faab002_desc
END FUNCTION
################################################################################
# Descriptions...: 組織編號說明
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
PRIVATE FUNCTION afai010_faab004_desc(p_faab004)
DEFINE p_faab004  LIKE faab_t.faab004   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_faab004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
################################################################################
# Descriptions...: 版本號預設
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
PRIVATE FUNCTION afai010_faab003_def(p_faab001,p_faab002)
DEFINE p_faab001  LIKE faab_t.faab001
DEFINE p_faab002  LIKE faab_t.faab002
DEFINE l_cnt      LIKE type_t.num5
DEFINE r_faab003  LIKE faab_t.faab003

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM faab_t 
    WHERE faabent = g_enterprise
      AND faab001 = p_faab001
      AND faab002 = p_faab002
   IF l_cnt = 0 THEN 
      LET r_faab003 = 1
   ELSE   
      SELECT MAX(faab003)+1 INTO r_faab003 FROM faab_t 
       WHERE faabent = g_enterprise
         AND faab001 = p_faab001
         AND faab002 = p_faab002 
   END IF
   RETURN r_faab003 
END FUNCTION
################################################################################
# Descriptions...: 生效日期檢查
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
PRIVATE FUNCTION afai010_faab006_chk(p_flag)
DEFINE l_faab006  LIKE faab_t.faab006
DEFINE p_flag     LIKE type_t.chr1

   IF NOT cl_null(g_faab_m.faab006) THEN 
      IF g_faab_m.faab007 = 'Y' AND g_faab_m.faab006 > g_today THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00014'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF 
      IF NOT cl_null(g_faab_m.faab001) AND NOT cl_null(g_faab_m.faab002) AND NOT cl_null(g_faab_m.faab003) AND g_faab_m.faab003 > 1THEN 
         SELECT MAX(faab006) INTO l_faab006 
           FROM faab_t 
          WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 AND faab002 = g_faab_m.faab002 AND faab003 <> g_faab_m.faab003 
         IF l_faab006 > g_faab_m.faab006 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00009'
            LET g_errparam.extend = g_faab_m.faab006
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         IF l_faab006 = g_faab_m.faab006 AND p_flag = '1' THEN 
            IF NOT cl_ask_confirm('axr-00010') THEN 
               RETURN FALSE
            END IF
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 執行版本檢查
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
PRIVATE FUNCTION afai010_faab007_chk()
DEFINE l_cnt   LIKE type_t.num5
DEFINE l_faab006  LIKE faab_t.faab006


   IF g_faab_m.faab007 = 'Y' AND g_faab_m.faab006 > g_today THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00014'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM faab_t 
    WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
      AND faab002 = g_faab_m.faab002 AND  faab007 = 'Y'
      AND faab003 <> g_faab_m.faab003       #AND faabstus = 'Y'   
   IF g_faab_m.faab007 = 'Y' THEN 
      IF l_cnt > 0 THEN 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM faab_t 
          WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
            AND faab002 = g_faab_m.faab002 AND  faab007 = 'Y'
            AND faab003 <> g_faab_m.faab003 AND faabstus = 'Y'          
         IF l_cnt > 0 THEN 
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'axr-00011'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
         ELSE
            UPDATE faab_t SET faab007 = 'N' 
             WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
               AND faab002 = g_faab_m.faab002  
               AND faab003 <> g_faab_m.faab003               
         END IF
      ELSE
         SELECT MAX(faab006) INTO l_faab006 FROM faab_t
          WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
            AND faab002 = g_faab_m.faab002 
            AND faab003 <> g_faab_m.faab003
            AND faabstus = 'Y' 
         IF l_faab006 > g_faab_m.faab006 THEN
            IF NOT cl_ask_confirm('axr-00013') THEN 
               RETURN FALSE
            ELSE
               UPDATE faab_t SET faab007 = 'N' 
                WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
                  AND faab002 = g_faab_m.faab002                
            END IF
         END IF
      END IF
   ELSE
      IF l_cnt = 0 THEN 
         CALL cl_ask_pressanykey('axr-00012')
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 執行版本的修改
# Memo...........:
# Usage..........: 
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afai010_faab007_upd()
DEFINE l_faab006 LIKE faab_t.faab006

   IF cl_null(g_faab_m.faabstus) OR g_faab_m.faabstus <> 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00180'
      LET g_errparam.extend = g_faab_m.faabstus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   IF g_faab_m.faab006 > g_today THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00014'
      LET g_errparam.extend = g_faab_m.faab006
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF   
   SELECT MAX(faab006) INTO l_faab006 FROM faab_t
    WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001
      AND faab002 = g_faab_m.faab002 
      AND faab003 <> g_faab_m.faab003 AND faabstus = 'Y' 
   IF l_faab006 > g_faab_m.faab006 THEN
      IF NOT cl_ask_confirm('axr-00013') THEN 
         RETURN               
      END IF
   END IF   
   
   UPDATE faab_t SET faab007 = 'N' 
    WHERE faabent = g_enterprise
      AND faab001 = g_faab_m.faab001
      AND faab002 = g_faab_m.faab002
      
   UPDATE faab_t SET faab007 = 'Y' 
    WHERE faabent = g_enterprise
      AND faab001 = g_faab_m.faab001
      AND faab002 = g_faab_m.faab002
      AND faab003 = g_faab_m.faab003
      
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
PRIVATE FUNCTION afai010_browser_fill(ps_page_action)
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

   #end add-point    
   
   #add-point:browser_fill段動作開始前

   #end add-point    
   CLEAR FORM
   INITIALIZE g_faab_m.* LIKE faab_t.* 
   CALL g_browser.clear()
   CALL g_tree.clear()
   DISPLAY BY NAME g_faab_m.*
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "faab001,faab002,faab003"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE faab001 ",
                      ", faab002 ",

                      ", faab003 ",


                      " FROM faab_t ",
                      " ",
                      " ",
                      " WHERE faabent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2 
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE faab001 ",
                      ", faab002 ",

                      ", faab003 ",


                      " FROM faab_t ",
                      " ",
                      " ",
                      " WHERE faabent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
 
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
   #若超過最大顯示筆數
   #該樣板不需此段落IF g_browser_cnt > g_max_browse AND g_error_show = 1THEN
   #該樣板不需此段落   CALL cl_err(g_browser_cnt,'9035',1)
   #該樣板不需此段落END IF
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
 
      #依照faab001,faab002,faab003 Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql  = "SELECT DISTINCT faab001,faab002,faab003 ",
                       " FROM faab_t ",
                       " ",
                       " WHERE faabent = '" ||g_enterprise|| "' AND ", g_wc," AND ",g_wc2
 
   ELSE
      #單身無輸入資料
      LET l_sub_sql  = "SELECT DISTINCT faab001,faab002,faab003 ",
                       " FROM faab_t ",
                       " WHERE faabent = '" ||g_enterprise|| "' AND ", g_wc
                 
   END IF
   
   LET l_sql_rank = "SELECT faab001,faab002,faab003,DENSE_RANK() OVER(ORDER BY faab001 ",g_order,") AS RANK ",
                    " FROM (",l_sub_sql,") "
                       
   #定義翻頁CURSOR
   LET g_sql= " SELECT faab001,faab002,faab003 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK<",g_pagestart+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
                
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_faab001,g_browser[g_cnt].b_faab002,g_browser[g_cnt].b_faab003    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference

      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_faab_m.* TO NULL
      CALL g_faab_d.clear()
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   #該樣板不需此段落CALL aiti807_fetch('')
   
   FREE browse_pre
END FUNCTION
################################################################################
# Descriptions...: 刪除某節點及其相應的子節點
# Memo...........:
# Usage..........: CALL afai010_del_note ()
# Input parameter: p_faab004 當前停留節點
# Return code....: 無
# Date & Author..: 14/01/26 By yuhuabao
# Modify.........:
################################################################################
PRIVATE FUNCTION afai010_del_note(p_faab004)
DEFINE p_faab004   LIKE faab_t.faab004
DEFINE l_count     LIKE type_t.num5
DEFINE l_faab005   LIKE faab_t.faab005
      
      IF g_faab_m.faabstus = 'Y' THEN INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'afa-00005'
    LET g_errparam.extend = ''
    LET g_errparam.popup = FALSE
    CALL cl_err()
 RETURN END IF
      IF g_faab_m.faabstus = 'X' THEN INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'afa-00023'
    LET g_errparam.extend = ''
    LET g_errparam.popup = FALSE
    CALL cl_err()
 RETURN END IF
      SELECT faab005 INTO l_faab005
        FROM faab_t
       WHERE faabent = g_enterprise
         AND faab001 = g_faab_m.faab001 
         AND faab002 = g_faab_m.faab002 
         AND faab003 = g_faab_m.faab003      
         AND faab004 = p_faab004        
      #檢查當前節點是否為根節點
      IF p_faab004 = l_faab005 AND p_faab004 = g_faab_m.faab002 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00016'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
  
      LET l_count = 0
      #檢查是否存在子節點
      SELECT COUNT(*) INTO l_count FROM faab_t
       WHERE faabent = g_enterprise AND faab001 = g_faab_m.faab001 
         AND faab002 = g_faab_m.faab002 AND faab003 = g_faab_m.faab003 
         AND faab005 = p_faab004
       IF l_count > 0 THEN   
          IF NOT cl_ask_confirm('afa-00028') THEN RETURN END IF 
       ELSE
          IF NOT cl_ask_confirm('afa-00029') THEN RETURN END IF
       END IF          
       DELETE FROM faab_t
        WHERE faabent = g_enterprise 
          AND faab001 = g_faab_m.faab001 
          AND faab002 = g_faab_m.faab002
          AND faab003 = g_faab_m.faab003 
          AND (faab004 = p_faab004 OR faab005 = p_faab004)
 
END FUNCTION
################################################################################
# Descriptions...: 批次新增
################################################################################
PRIVATE FUNCTION afai010_ins_faab(p_faab001,p_faab002,p_faab003,p_faab004)
DEFINE p_faab001  LIKE faab_t.faab001
DEFINE p_faab002  LIKE faab_t.faab002
DEFINE p_faab003  LIKE faab_t.faab003
DEFINE p_faab004  LIKE faab_t.faab004
DEFINE l_str      STRING
DEFINE tok         base.StringTokenizer
DEFINE l_faab      RECORD
         faabent   LIKE faab_t.faabent,
         faabownid   LIKE faab_t.faabownid,
         faabowndp   LIKE faab_t.faabowndp,
         faabcrtid   LIKE faab_t.faabcrtid,
         faabcrtdp   LIKE faab_t.faabcrtdp,
         faabcrtdt   DATETIME YEAR TO SECOND,
         faabmodid   LIKE faab_t.faabmodid,
         faabmoddt   DATETIME YEAR TO SECOND,
         faabstus   LIKE faab_t.faabstus,
         faab001   LIKE faab_t.faab001,
         faab002   LIKE faab_t.faab002,
         faab003   LIKE faab_t.faab003,
         faab004   LIKE faab_t.faab004,
         faab005   LIKE faab_t.faab005,
         faab006   LIKE faab_t.faab006,
         faab007   LIKE faab_t.faab007
                   END RECORD
DEFINE l_faab004   LIKE faab_t.faab004
DEFINE l_sql       STRING
   IF g_faab_m.faabstus = 'Y' THEN INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'afa-00015'
    LET g_errparam.extend = ''
    LET g_errparam.popup = FALSE
    CALL cl_err()
 RETURN END IF
   IF g_faab_m.faabstus = 'X' THEN INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'afa-00023'
    LET g_errparam.extend = ''
    LET g_errparam.popup = FALSE
    CALL cl_err()
 RETURN END IF
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.state = 'c'
   LET g_qryparam.reqry = FALSE
   LET g_qryparam.arg1 = p_faab001
   LET g_qryparam.arg2 = p_faab002
   LET g_qryparam.arg3 = p_faab003
   CALL q_ooef001_7()                           #呼叫開窗
   LET l_str = g_qryparam.return1 
   LET tok = base.StringTokenizer.create(l_str,"|")
   SELECT * INTO l_faab.* FROM faab_t 
    WHERE faabent = g_enterprise AND faab001 = p_faab001
      AND faab002 = p_faab002 AND faab003 = p_faab003
      AND faab004 = p_faab004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "SEL"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF                    
   WHILE tok.hasMoreTokens()
      LET l_faab004 = tok.nextToken() 
      LET l_faab.faab004 = l_faab004
      LET l_faab.faab005 = p_faab004
      INSERT INTO faab_t VALUES (l_faab.*)
   END WHILE   
END FUNCTION
#+ 瀏覽頁簽where條件組成
PRIVATE FUNCTION afai010_tree_fill()
   {<Local define>}
   DEFINE ps_wc              STRING
   DEFINE ps_page_action     STRING
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num5
   DEFINE li_idx1            LIKE type_t.num5 
   DEFINE li_idx2            LIKE type_t.num5
   DEFINE li_idx3            LIKE type_t.num5

   
   LET ls_sql = " SELECT UNIQUE faab001,faab002,faab003 ",
                " FROM faab_t ",
                "  ",
                "  ",
                " WHERE faabent = '",g_enterprise,"'",
                "   AND faab001 = '",g_faab_m.faab001,"'",
                "   AND faab002 = '",g_faab_m.faab002,"'",
                "   AND faab003 = '",g_faab_m.faab003,"'"
                
   PREPARE tree_pre FROM ls_sql
   DECLARE tree_cur CURSOR FOR tree_pre
   CALL g_tree.clear()

   LET li_idx = 1 
   FOREACH tree_cur INTO g_tree[li_idx].b_faab001,g_tree[li_idx].b_faab002,g_tree[li_idx].b_faab003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_tree[li_idx].b_faab004 = g_tree[li_idx].b_faab002
      LET g_tree[li_idx].b_faab005 = g_tree[li_idx].b_faab002
      LET g_tree[li_idx].b_pid     = 0
      LET g_tree[li_idx].b_id      = li_idx USING "<<<"
      LET g_tree[li_idx].b_exp     = TRUE
      LET g_tree[li_idx].b_expcode = 1
      LET g_tree[li_idx].b_hasC    = TRUE
      LET g_tree[li_idx].b_show    = g_tree[li_idx].b_faab002
      CALL afai010_desc_show(li_idx)
      LET g_tree[li_idx].b_isExp = TRUE
      LET li_idx = li_idx + 1
                 

      LET ls_sql = " SELECT UNIQUE faab001,faab002,faab003,faab004,faab005 ",
                   " FROM faab_t ",
                   " WHERE faabent = '" ||g_enterprise|| "' ",
                   " AND faab001 = ? AND faab002 = ? AND faab003 = ? ",
                   " AND faab002 = faab005 ",
                   " AND faab004 <> faab005 ",
                   " ORDER BY faab005"
         
      PREPARE tree_pre2 FROM ls_sql
      DECLARE tree_cur2 CURSOR FOR tree_pre2
      OPEN tree_cur2 USING g_tree[li_idx-1].b_faab001,g_tree[li_idx-1].b_faab002,g_tree[li_idx-1].b_faab003
      LET li_idx1 = li_idx
      FOREACH tree_cur2 INTO g_tree[li_idx1].b_faab001,g_tree[li_idx1].b_faab002,g_tree[li_idx1].b_faab003,g_tree[li_idx1].b_faab004,g_tree[li_idx1].b_faab005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            EXIT FOREACH
         END IF
         LET g_tree[li_idx1].b_pid     = g_tree[li_idx-1].b_id 
         LET g_tree[li_idx1].b_id      = g_tree[li_idx-1].b_id , ".", li_idx1 USING "<<<"
         LET g_tree[li_idx1].b_exp     = TRUE
         LET g_tree[li_idx1].b_expcode = 2
         LET g_tree[li_idx1].b_hasC    = afai010_chk_hasC(li_idx1)
         CALL afai010_desc_show(li_idx1)
         IF g_tree[li_idx1].b_hasC = 1 THEN
            CALL afai010_tree_expand(li_idx1)
            LET li_idx1 = g_tree.getLength()
         END IF         
         
         LET li_idx1 = li_idx1 + 1
      END FOREACH

      LET li_idx = g_tree.getLength()
      
      --------------------------------------------------------------------------------
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
   
   CALL g_tree.deleteElement(g_tree.getLength())
   
   #LET g_browser_cnt = g_tree.getLength()

   FREE tree_pre
   FREE tree_pre2   
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afai010_set_act_visible()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afai010_set_act_visible()
   #20141128 add str-by chenying
   IF g_faab_m.faabstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #20141128 add end-
END FUNCTION
#+ QBE資料查詢
PRIVATE FUNCTION afai010_construct()
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
   INITIALIZE g_faab_m.* TO NULL
   CALL g_faab_d.clear()        
   CALL g_tree.clear() 
   CALL g_browser.clear() 
   
   LET g_current_idx = 1
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON faab002,faab003,faab004,faab005,faab006,faab007,faabstus,faabownid,faabowndp,faabcrtid,faabcrtdp,faabcrtdt,faabmodid,faabmoddt
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            IF NOT cl_null(g_faab001) THEN
               IF g_faab001 <>'0' THEN 
                  LET g_faab_m.faab001 = g_faab001
              END IF
            END IF 
            DISPLAY BY NAME g_faab_m.faab001
            #end add-point 
            
         #單頭公用欄位開窗
         #此段落由子樣板a11產生---
         ##----<<faabownid>>----
         #ON ACTION controlp INFIELD faabownid
         #   CALL q_common('faab_t','faabownid',TRUE,FALSE,g_faab_m.faabownid) RETURNING ls_return
         #   DISPLAY ls_return TO faabownid
         #   NEXT FIELD faabownid  
         #
         ##----<<faabowndp>>----
         #ON ACTION controlp INFIELD faabowndp
         #   CALL q_common('faab_t','faabowndp',TRUE,FALSE,g_faab_m.faabowndp) RETURNING ls_return
         #   DISPLAY ls_return TO faabowndp
         #   NEXT FIELD faabowndp
         #
         ##----<<faabcrtid>>----
         #ON ACTION controlp INFIELD faabcrtid
         #   CALL q_common('faab_t','faabcrtid',TRUE,FALSE,g_faab_m.faabcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO faabcrtid
         #   NEXT FIELD faabcrtid
         #
         ##----<<faabcrtdp>>----
         #ON ACTION controlp INFIELD faabcrtdp
         #   CALL q_common('faab_t','faabcrtdp',TRUE,FALSE,g_faab_m.faabcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO faabcrtdp
         #   NEXT FIELD faabcrtdp
         #
         ##----<<faabmodid>>----
         #ON ACTION controlp INFIELD faabmodid
         #   CALL q_common('faab_t','faabmodid',TRUE,FALSE,g_faab_m.faabmodid) RETURNING ls_return
         #   DISPLAY ls_return TO faabmodid
         #   NEXT FIELD faabmodid
         #
         ##----<<xrahcnfid>>----
         ##ON ACTION controlp INFIELD xrahcnfid
         ##   CALL q_common('faab_t','xrahcnfid',TRUE,FALSE,g_faab_m.xrahcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO xrahcnfid
         ##   NEXT FIELD xrahcnfid
         #
         ##----<<xrahpstid>>----
         ##ON ACTION controlp INFIELD xrahpstid
         ##   CALL q_common('faab_t','xrahpstid',TRUE,FALSE,g_faab_m.xrahpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO xrahpstid
         ##   NEXT FIELD xrahpstid
         
         ##----<<faabcrtdt>>----
         AFTER FIELD faabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faabmoddt>>----
         AFTER FIELD faabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrahcnfdt>>----
         #AFTER FIELD xrahcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrahpstdt>>----
         #AFTER FIELD xrahpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
          
         #單頭一般欄位開窗          
         #---------------------------<  Master  >---------------------------
         #----<<faab001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab001
            #add-point:BEFORE FIELD faab001
            {<point name="construct.b.faab001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab001
            
            #add-point:AFTER FIELD faab001
            {<point name="construct.a.faab001" />}
            #END add-point
            
 
         #Ctrlp:construct.c.faab001
#         ON ACTION controlp INFIELD faab001
            #add-point:ON ACTION controlp INFIELD faab001
            {<point name="construct.c.faab001" />}
            #END add-point
 
         #----<<faab002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab002
            #add-point:BEFORE FIELD faab002
            {<point name="construct.b.faab002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab002
            
            #add-point:AFTER FIELD faab002
            {<point name="construct.a.faab002" />}
            #END add-point
            
 
         #Ctrlp:construct.c.faab002
         ON ACTION controlp INFIELD faab002
            #add-point:ON ACTION controlp INFIELD faab002
            #add-point:ON ACTION controlp INFIELD glabld
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faab002  #顯示到畫面上

            NEXT FIELD faab002                     #返回原欄位
            #END add-point
 
         #----<<faab003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab003
            #add-point:BEFORE FIELD faab003
            {<point name="construct.b.faab003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab003
            
            #add-point:AFTER FIELD faab003
            {<point name="construct.a.faab003" />}
            #END add-point
            
 
         #Ctrlp:construct.c.faab003
#         ON ACTION controlp INFIELD faab003
            #add-point:ON ACTION controlp INFIELD faab003
            {<point name="construct.c.faab003" />}
            #END add-point
 
         #----<<faab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab004
            #add-point:BEFORE FIELD faab004
            {<point name="construct.b.faab004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab004
            
            #add-point:AFTER FIELD faab004
            {<point name="construct.a.faab004" />}
            #END add-point
            
 
         #Ctrlp:construct.c.faab004
#         ON ACTION controlp INFIELD faab004
            #add-point:ON ACTION controlp INFIELD faab004
            {<point name="construct.c.faab004" />}
            #END add-point
 
         #----<<faab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab005
            #add-point:BEFORE FIELD faab005
            {<point name="construct.b.faab005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab005
            
            #add-point:AFTER FIELD faab005
            {<point name="construct.a.faab005" />}
            #END add-point
            
 
         #Ctrlp:construct.c.faab005
#         ON ACTION controlp INFIELD faab005
            #add-point:ON ACTION controlp INFIELD faab005
            {<point name="construct.c.faab005" />}
            #END add-point
 
         #----<<faabownid>>----
         #Ctrlp:construct.c.faabownid
         ON ACTION controlp INFIELD faabownid
            #add-point:ON ACTION controlp INFIELD faabownid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faabownid  #顯示到畫面上

            NEXT FIELD faabownid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD faabownid
            #add-point:BEFORE FIELD faabownid
            {<point name="construct.b.faabownid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faabownid
            
            #add-point:AFTER FIELD faabownid
            {<point name="construct.a.faabownid" />}
            #END add-point
            
 
         #----<<faabowndp>>----
         #Ctrlp:construct.c.faabowndp
         ON ACTION controlp INFIELD faabowndp
            #add-point:ON ACTION controlp INFIELD faabowndp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faabowndp  #顯示到畫面上

            NEXT FIELD faabowndp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD faabowndp
            #add-point:BEFORE FIELD faabowndp
            {<point name="construct.b.faabowndp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faabowndp
            
            #add-point:AFTER FIELD faabowndp
            {<point name="construct.a.faabowndp" />}
            #END add-point
            
 
         #----<<faabcrtid>>----
         #Ctrlp:construct.c.faabcrtid
         ON ACTION controlp INFIELD faabcrtid
            #add-point:ON ACTION controlp INFIELD faabcrtid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faabcrtid  #顯示到畫面上

            NEXT FIELD faabcrtid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD faabcrtid
            #add-point:BEFORE FIELD faabcrtid
            {<point name="construct.b.faabcrtid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faabcrtid
            
            #add-point:AFTER FIELD faabcrtid
            {<point name="construct.a.faabcrtid" />}
            #END add-point
            
 
         #----<<faabcrtdp>>----
         #Ctrlp:construct.c.faabcrtdp
         ON ACTION controlp INFIELD faabcrtdp
            #add-point:ON ACTION controlp INFIELD faabcrtdp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faabcrtdp  #顯示到畫面上

            NEXT FIELD faabcrtdp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD faabcrtdp
            #add-point:BEFORE FIELD faabcrtdp
            {<point name="construct.b.faabcrtdp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faabcrtdp
            
            #add-point:AFTER FIELD faabcrtdp
            {<point name="construct.a.faabcrtdp" />}
            #END add-point
            
 
         #----<<faabcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faabcrtdt
            #add-point:BEFORE FIELD faabcrtdt
            {<point name="construct.b.faabcrtdt" />}
            #END add-point
 
         #----<<faabmodid>>----
         #Ctrlp:construct.c.faabmodid
         ON ACTION controlp INFIELD faabmodid
            #add-point:ON ACTION controlp INFIELD faabmodid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faabmodid  #顯示到畫面上

            NEXT FIELD faabmodid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD faabmodid
            #add-point:BEFORE FIELD faabmodid
            {<point name="construct.b.faabmodid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faabmodid
            
            #add-point:AFTER FIELD faabmodid
            {<point name="construct.a.faabmodid" />}
            #END add-point
            
 
         #----<<faabmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faabmoddt
            #add-point:BEFORE FIELD faabmoddt
            {<point name="construct.b.faabmoddt" />}
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table1 ON faab004,faab005
           FROM s_detail1[1].faab004,s_detail1[1].faab005
                      
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<faab004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab004
            #add-point:BEFORE FIELD faab004
            {<point name="construct.b.page1.faab004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab004
            
            #add-point:AFTER FIELD faab004
            {<point name="construct.a.page1.faab004" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.faab004
         ON ACTION controlp INFIELD faab004
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faab004  #顯示到畫面上

            NEXT FIELD faab004                     #返回原欄位
 
         #----<<faab005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD faab005
            #add-point:BEFORE FIELD faab005
            {<point name="construct.b.page1.faab005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD faab005
            
            #add-point:AFTER FIELD faab005
            {<point name="construct.a.page1.faab005" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.faab005
         ON ACTION controlp INFIELD faab005
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faab005  #顯示到畫面上

            NEXT FIELD faab005                    #返回原欄位
 
  
       
      END CONSTRUCT
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      {<point name="cs.add_cs"/>}
      #end add-point
 
      BEFORE DIALOG
         #add-point:cs段b_dialog
         {<point name="cs.b_dialog"/>}
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
   
   #組合g_wc2
   LET g_wc2 = g_wc_table1
 
 
   #add-point:cs段after_construct
   LET g_wc = g_wc," AND faab001 = '",g_faab001,"'" 
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION

#end add-point
 
{</section>}
 
