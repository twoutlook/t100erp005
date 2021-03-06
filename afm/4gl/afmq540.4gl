#該程式未解開Section, 採用最新樣板產出!
{<section id="afmq540.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-01-07 19:44:11), PR版次:0008(2016-11-09 09:57:32)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: afmq540
#+ Description: 投資市場交易查詢
#+ Creator....: 02159(2015-11-24 17:36:18)
#+ Modifier...: 02159 -SD/PR- 08171
 
{</section>}
 
{<section id="afmq540.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#151207-00018#7   2015/12/17  By sakura   交易市場編號改為QBE,單身增加交易市場代碼+名稱,餘額依市場重推算
#151223-00001#1   2015/12/23  By sakura   投資組織,預設值當前site對應的法人
#151228-00008#2   2016/01/04  By sakura   修改原幣金額bug、1.增加"摘要"說明顯示2.增加"摘要"說明顯示,置於投資單號後方,取afmt530的摘要
#160126-00008#1   2016/01/26  By sakura   單筆在計算本幣餘額時,漏掉給予值
#160511-00005#1   2016/05/11  By Belle    未平仓数没有显示
#161006-00005#25  2016/10/21  By 06814    投資組織(fmmjsite)開窗改用q_ooef001_33(),補上投資組織(fmmjsite)校驗
#161104-00024#11  2016/11/09  By 08171    程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_fmmj_d RECORD
       
       fmmj002 LIKE fmmj_t.fmmj002, 
   fmmj002_desc LIKE type_t.chr500, 
   fmmj006 LIKE fmmj_t.fmmj006, 
   fmmj003 LIKE fmmj_t.fmmj003, 
   fmmj003_desc LIKE type_t.chr500, 
   fmmjdocno LIKE fmmj_t.fmmjdocno, 
   fmmj027 LIKE type_t.chr500, 
   fmmjdocdt LIKE fmmj_t.fmmjdocdt, 
   l_type LIKE type_t.chr100, 
   fmmj017 LIKE fmmj_t.fmmj017, 
   l_fmmj017_sum LIKE type_t.chr500, 
   fmmj005 LIKE fmmj_t.fmmj005, 
   fmmj007 LIKE fmmj_t.fmmj007, 
   fmmj008 LIKE fmmj_t.fmmj008, 
   l_fmmj008_sum LIKE type_t.chr500, 
   fmmj009 LIKE fmmj_t.fmmj009, 
   fmmj028 LIKE fmmj_t.fmmj028, 
   l_fmmj028_sum LIKE type_t.chr500, 
   l_fmmy015 LIKE type_t.num20_6, 
   l_fmmy015_sum LIKE type_t.num20_6, 
   l_fmmy016 LIKE type_t.num20_6, 
   l_fmmy016_sum LIKE type_t.num20_6, 
   l_sum LIKE type_t.num20_6, 
   l_sum1 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_master RECORD
     fmmjsite        LIKE fmmj_t.fmmjsite,
     fmmjsite_desc   LIKE type_t.chr100,
	  #fmmj002         LIKE fmmj_t.fmmj002,   #151207-00018#7 mark
	  #fmmj002_desc    LIKE type_t.chr100,    #151207-00018#7 mark
	  l_show          LIKE type_t.chr1,
	  wc              STRING
     END RECORD
DEFINE g_input       type_master
DEFINE g_input_o     type_master
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmmj_d            DYNAMIC ARRAY OF type_g_fmmj_d
DEFINE g_fmmj_d_t          type_g_fmmj_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmq540.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmq540_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmq540_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmq540_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmq540 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmq540_init()   
 
      #進入選單 Menu (="N")
      CALL afmq540_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmq540
      
   END IF 
   
   CLOSE afmq540_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmq540.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmq540_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL afmq540_create_tmp()
   #151223-00001#1(S)
   #取該g_site的法人
   CALL s_aooi100_get_comp(g_site) RETURNING g_sub_success,g_input.fmmjsite
   CALL s_desc_get_department_desc(g_input.fmmjsite) RETURNING g_input.fmmjsite_desc
   DISPLAY BY NAME g_input.fmmjsite_desc
   #151223-00001#1(E)
   #end add-point
 
   CALL afmq540_default_search()
END FUNCTION
 
{</section>}
 
{<section id="afmq540.default_search" >}
PRIVATE FUNCTION afmq540_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " fmmjdocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmq540_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
 
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_input.l_show = 'Y'
   #end add-point
 
   
   CALL afmq540_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_fmmj_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL afmq540_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         #INPUT BY NAME g_input.fmmjsite,g_input.fmmj002,g_input.l_show   #151207-00018#7 mark
         INPUT BY NAME g_input.fmmjsite,g_input.l_show    #151207-00018#7 add
           ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD fmmjsite
           IF NOT cl_null(g_input.fmmjsite) THEN
              #檢查輸入的資料不存在[組織基本資料檔]中！
              #161006-00005#25 20161021 add by beckxie---S
              LET g_errno = NULL
              LET g_sub_success = FALSE
              CALL s_fin_account_center_chk(g_input.fmmjsite,g_input.fmmjsite,'6',g_today) RETURNING g_sub_success,g_errno
              IF NOT g_sub_success THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_input.fmmjsite = ''
                 NEXT FIELD CURRENT
              END IF
              #161006-00005#25 20161021 add by beckxie---E
              CALL s_desc_get_department_desc(g_input.fmmjsite) RETURNING g_input.fmmjsite_desc
              DISPLAY BY NAME g_input.fmmjsite_desc
           END IF
         #151207-00018#7 mark(S)
         #AFTER FIELD fmmj002
         #  IF NOT cl_null(g_input.fmmj002) THEN
         #     CALL s_desc_fmme001_desc(g_input.fmmj002) RETURNING g_input.fmmj002_desc
         #     DISPLAY BY NAME g_input.fmmj002_desc
         #  END IF
         #151207-00018#7 mark(E)            
         ON ACTION controlp INFIELD fmmjsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            #161006-00005#25 20161021 mark by beckxie---S
            #LET g_qryparam.where = " ooef206 = 'Y' "   #資金組織
            #CALL q_ooef001()                           #呼叫開窗
            #161006-00005#25 20161021 mark by beckxie---E
            CALL q_ooef001_33()                         #資金組織 #161006-00005#25 20161021 add by beckxie
            LET g_input.fmmjsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.fmmjsite) RETURNING g_input.fmmjsite_desc
            DISPLAY BY NAME g_input.fmmjsite,g_input.fmmjsite_desc
            NEXT FIELD CURRENT
         
         #151207-00018#7 mark(S)
         #ON ACTION controlp INFIELD fmmj002
         #   INITIALIZE g_qryparam.* TO NULL
         #   LET g_qryparam.state = 'i' 
         #   LET g_qryparam.reqry = FALSE
         #   CALL q_fmme001()                           #呼叫開窗
         #   LET g_input.fmmj002 = g_qryparam.return1
         #   CALL s_desc_fmme001_desc(g_input.fmmj002) RETURNING g_input.fmmj002_desc
         #   DISPLAY BY NAME g_input.fmmj002,g_input.fmmj002_desc
         #   NEXT FIELD CURRENT
         #151207-00018#7 mark(E)
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_input.wc ON fmmj002,fmmjdocno,fmmjdocdt,fmmj003,fmmj006
            
            #151207-00018#7 add(S)
            ON ACTION controlp INFIELD fmmj002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_fmme001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fmmj002
               NEXT FIELD CURRENT
            #151207-00018#7 add(E)
            
            ON ACTION controlp INFIELD fmmjdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " fmmjstus = 'Y' "
               CALL q_fmmjdocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fmmjdocno  #顯示到畫面上
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD fmmj003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_fmma001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fmmj003  #顯示到畫面上            
               NEXT FIELD CURRENT
            
            ON ACTION controlp INFIELD fmmj006            
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooai001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fmmj006  #顯示到畫面上
               NEXT FIELD CURRENT
               
         END CONSTRUCT        
         #end add-point
     
         DISPLAY ARRAY g_fmmj_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afmq540_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afmq540_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afmq540_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD fmmjsite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            #151207-00018#7(S)
            IF cl_null(g_input.fmmjsite) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'acr-00015'
               LET g_errparam.popup  = FALSE
               CALL cl_err()               
               NEXT FIELD fmmjsite
            END IF
            #151207-00018#7(E)
            IF cl_null(g_input.wc) THEN
               LET g_input.wc = " 1=1"
            END IF
            LET g_wc = " 1=1"
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL afmq540_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fmmj_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL afmq540_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL afmq540_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afmq540_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afmq540_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afmq540_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afmq540_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL afmq540_x01(' 1=1','afmq540_x01_tmp')  #畫面的東西轉成XG報表
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL afmq540_x01(' 1=1','afmq540_x01_tmp')  #畫面的東西轉成XG報表
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            CALL g_fmmj_d.clear()
            LET g_input.l_show = 'Y'
            CALL s_desc_get_department_desc(g_input.fmmjsite) RETURNING g_input.fmmjsite_desc
            DISPLAY BY NAME g_input.l_show,g_input.fmmjsite_desc            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmq540_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_fmmj002       LIKE fmmj_t.fmmj002   #151207-00018#7
   DEFINE l_fmmjdocno     LIKE fmmj_t.fmmjdocno
   DEFINE l_fmmj005       LIKE fmmj_t.fmmj005
   DEFINE l_fmmy003       LIKE fmmy_t.fmmy003
   DEFINE l_fmmj006       LIKE fmmj_t.fmmj006
   DEFINE l_fmmj017       LIKE fmmj_t.fmmj017
   DEFINE l_fmmj008       LIKE fmmj_t.fmmj008
   DEFINE l_fmmj028       LIKE fmmj_t.fmmj028
   DEFINE l_fmmy015       LIKE fmmy_t.fmmy015   
   DEFINE l_fmmy016       LIKE fmmy_t.fmmy016   #160107-00018#1
   DEFINE l_sum           LIKE fmmj_t.fmmj008
   DEFINE l_sum1          LIKE fmmj_t.fmmj008   #160107-00018#1
   DEFINE l_f1            LIKE fmmj_t.fmmj008   #期初餘額-原幣
   DEFINE l_f2            LIKE fmmj_t.fmmj008   #期初餘額-本幣
   DEFINE l_fmmj002_f1    LIKE fmmj_t.fmmj002   #151207-00018#7
   DEFINE l_fmmj006_f1    LIKE fmmj_t.fmmj006   
   DEFINE l_fmmj008_f1    LIKE fmmj_t.fmmj008   #期初餘額-購買原幣金額
   DEFINE l_fmmy015_f1    LIKE fmmy_t.fmmy015   #期初餘額-#平倉原幣成本
   #XG報表用的temp
   DEFINE l_i            LIKE type_t.num10
   DEFINE l_x01_tmp      RECORD
      l_seq              LIKE type_t.num10,     #151228-00008#2
      fmmj002            LIKE fmmj_t.fmmj002,   #151207-00018#7 add
      fmmj002_desc       LIKE type_t.chr500,    #151207-00018#7 add
      fmmj006            LIKE fmmj_t.fmmj006,
      fmmj003            LIKE fmmj_t.fmmj003, 
      fmmj003_desc       LIKE type_t.chr500, 
      fmmjdocno          LIKE fmmj_t.fmmjdocno,
      fmmj027            LIKE fmmj_t.fmmj027,   #151228-00008#2      
      fmmjdocdt          LIKE fmmj_t.fmmjdocdt, 
      l_type             LIKE type_t.chr100, 
      fmmj017            LIKE fmmj_t.fmmj017, 
      fmmj005            LIKE fmmj_t.fmmj005,      
      fmmj007            LIKE fmmj_t.fmmj007, 
      fmmj008            LIKE fmmj_t.fmmj008,      
      fmmj009            LIKE fmmj_t.fmmj009, 
      fmmj028            LIKE fmmj_t.fmmj028,
      l_fmmy015          LIKE type_t.num20_6,
      l_sum              LIKE type_t.num20_6,
      l_sum1             LIKE type_t.num20_6   #160107-00018#1
   END RECORD
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_fmmj_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_fmmj005 = 0
   LET l_fmmy003 = 0
   LET l_fmmj017 = 0
   LET l_fmmj008 = 0
   LET l_fmmj028 = 0
   LET l_fmmy015 = 0
   LET l_fmmy016 = 0   #160107-00018#1
   LET l_sum = 0
   LET l_sum1 = 0   #160107-00018#1
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE fmmj002,'',fmmj006,fmmj003,'',fmmjdocno,'',fmmjdocdt,'',fmmj017, 
       '',fmmj005,fmmj007,fmmj008,'',fmmj009,fmmj028,'','','','','','',''  ,DENSE_RANK() OVER( ORDER BY fmmj_t.fmmjdocno) AS RANK FROM fmmj_t", 
 
 
 
                     "",
                     " WHERE fmmjent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("fmmj_t"),
                     " ORDER BY fmmj_t.fmmjdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
 
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT fmmj002,'',fmmj006,fmmj003,'',fmmjdocno,'',fmmjdocdt,'',fmmj017,'',fmmj005,fmmj007, 
       fmmj008,'',fmmj009,fmmj028,'','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #不顯示已平倉投資單
   DELETE FROM afmq540_tmp
   IF g_input.l_show = 'N' THEN
      LET g_sql ="SELECT fmmjdocno,fmmj005 ",
                 "  FROM fmmj_t ",
                 " WHERE fmmjent = ",g_enterprise," AND ", ls_wc,
                 "   AND fmmjsite = '",g_input.fmmjsite,"'",
                 #"   AND fmmj002 = '",g_input.fmmj002,"'",   #151207-00018#7 mark
                 "   AND fmmjstus = 'Y' ",
                 " ORDER BY fmmjdocno "
      PREPARE afmq540_fmmjdocno_pre FROM g_sql
      DECLARE afmq540_fmmjdocno_cur CURSOR FOR afmq540_fmmjdocno_pre
      FOREACH afmq540_fmmjdocno_cur INTO l_fmmjdocno,l_fmmj005
        
        LET l_fmmy003 = 0     #160511-00005#1
        SELECT SUM(fmmy003) INTO l_fmmy003
          FROM fmmy_t
         WHERE fmmyent = g_enterprise
           AND fmmy001 = l_fmmjdocno
        GROUP BY fmmy001
        
        IF l_fmmj005 = l_fmmy003 THEN
           INSERT INTO afmq540_tmp (fmmj002,fmmjdocno) VALUES (l_fmmj002,l_fmmjdocno)   #151207-00018#7 add l_fmmj002
        END IF     
           
      END FOREACH
   END IF      

   LET g_sql ="SELECT fmmj002,'',fmmj006,fmmj003,'',fmmjdocno,fmmj027,fmmjdocdt,'1',fmmj017,0,fmmj005, ",   #151207-00018#7 add fmmj003,'' #151228-00008#2 add fmmj027
              "       fmmj007,fmmj008,0,fmmj009,COALESCE(fmmj028,0),0,0,0,0,0,0,0 ",   #160107-00018#1 add fmmy028,0,0
              "  FROM fmmj_t ",
              " WHERE fmmjent = ? AND ", g_input.wc," AND ", ls_wc,
              "   AND fmmjsite = '",g_input.fmmjsite,"'",
              #"   AND fmmj002 = '",g_input.fmmj002,"'",   #151207-00018#7 mark
              "   AND fmmjstus = 'Y' ",
              "   AND fmmjdocno NOT IN (SELECT fmmjdocno FROM afmq540_tmp) ",
              "UNION "
   LET g_input.wc  = cl_replace_str(g_input.wc,'fmmjdocdt','fmmydocdt') 
   LET g_sql = g_sql,
              "SELECT fmmj002,'',fmmy002,fmmj003,'',fmmy001,fmmj027,fmmydocdt,'2',0,0,-fmmy003, ",   #151207-00018#7 add fmmj003,'' #151228-00008#2 add fmmj027
              "       fmmy004,-fmmy005,0,fmmy007,COALESCE(-fmmy013,0),0,COALESCE(-fmmy015,0),0,COALESCE(-fmmy016,0),0,0,0 ",   #160107-00018#1 add fmmy016,0,0
              "  FROM fmmy_t,fmmj_t ",
              " WHERE fmmyent = fmmjent ",
              "   AND fmmy001 = fmmjdocno ",
              "   AND fmmyent = ",g_enterprise," AND ", g_input.wc," AND ", ls_wc,
              "   AND fmmjsite = '",g_input.fmmjsite,"'",
              #"   AND fmmj002 = '",g_input.fmmj002,"'",   #151207-00018#7 mark
              "   AND fmmystus = 'Y' ",
              "   AND fmmy001 NOT IN (SELECT fmmjdocno FROM afmq540_tmp)",
              " ORDER BY fmmj002,fmmj006,fmmj003,fmmjdocno "   #151207-00018#7 add fmmj002 #order by會影響排序值
   #恢復g_input.wc
   LET g_input.wc  = cl_replace_str(g_input.wc,'fmmydocdt','fmmjdocdt')   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmq540_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmq540_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_fmmj_d[l_ac].fmmj002,g_fmmj_d[l_ac].fmmj002_desc,g_fmmj_d[l_ac].fmmj006, 
       g_fmmj_d[l_ac].fmmj003,g_fmmj_d[l_ac].fmmj003_desc,g_fmmj_d[l_ac].fmmjdocno,g_fmmj_d[l_ac].fmmj027, 
       g_fmmj_d[l_ac].fmmjdocdt,g_fmmj_d[l_ac].l_type,g_fmmj_d[l_ac].fmmj017,g_fmmj_d[l_ac].l_fmmj017_sum, 
       g_fmmj_d[l_ac].fmmj005,g_fmmj_d[l_ac].fmmj007,g_fmmj_d[l_ac].fmmj008,g_fmmj_d[l_ac].l_fmmj008_sum, 
       g_fmmj_d[l_ac].fmmj009,g_fmmj_d[l_ac].fmmj028,g_fmmj_d[l_ac].l_fmmj028_sum,g_fmmj_d[l_ac].l_fmmy015, 
       g_fmmj_d[l_ac].l_fmmy015_sum,g_fmmj_d[l_ac].l_fmmy016,g_fmmj_d[l_ac].l_fmmy016_sum,g_fmmj_d[l_ac].l_sum, 
       g_fmmj_d[l_ac].l_sum1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #####################
      IF l_ac = 1 THEN
         
         #151228-00008#2(S)--mark
         ##購買原幣金額
         #LET l_fmmj002_f1 = ''   #151207-00018#7
         #LET l_fmmj006_f1 = ''
         #LET l_fmmj008_f1 = 0
         #SELECT fmmj002,fmmj006,SUM(fmmj008) INTO l_fmmj002_f1,l_fmmj006_f1,l_fmmj008_f1   #151207-00018#7 add fmmj002
         #  FROM fmmj_t 
         # WHERE fmmjent = g_enterprise 
         #   #AND fmmjdocno = g_fmmj_d[l_ac].fmmjdocno   #151228-00008#2
         #   AND fmmjstus = 'Y'
         #   AND fmmj002 = g_fmmj_d[l_ac].fmmj002   #151207-00018#7
         #   AND fmmj006 = g_fmmj_d[l_ac].fmmj006
         #   AND fmmjdocdt < g_fmmj_d[l_ac].fmmjdocdt
         # GROUP BY fmmj002,fmmj006   #151207-00018#7 add fmmj002
         # IF cl_null(l_fmmj008_f1) THEN LET l_fmmj008_f1 = 0 END IF
         ##平倉原幣成本
         #LET l_fmmy015_f1 = 0
         #LET l_f1 = 0
         #SELECT SUM(fmmy015) INTO l_fmmy015_f1
         #  FROM fmmy_t,fmmj_t
         # WHERE fmmyent = fmmjent
         #   AND fmmy001 = fmmjdocno
         #   AND fmmyent = g_enterprise
         #   #AND fmmy001 = g_fmmj_d[l_ac].fmmjdocno   #151228-00008#2
         #   AND fmmystus = 'Y'
         #   AND fmmj002 = l_fmmj002_f1   #151207-00018#7
         #   AND fmmy002 = l_fmmj006_f1
         #   AND fmmydocdt < g_fmmj_d[l_ac].fmmjdocdt
         #IF cl_null(l_fmmy015_f1) THEN LET l_fmmy015_f1 = 0 END IF
         ##取期初餘額
         #LET l_f1 = l_fmmj008_f1 - l_fmmy015_f1
         #151228-00008#2(E)--mark
         CALL afmq540_get_amount(g_fmmj_d[l_ac].fmmj002,g_fmmj_d[l_ac].fmmj006,g_fmmj_d[l_ac].fmmj003,g_fmmj_d[l_ac].fmmjdocno) RETURNING l_f1,l_f2   #151228-00008#2 #160107-00018#1 add l_f2
         LET l_sum = l_f1
         LET l_sum1 = l_f2   #160107-00018#1
        
         #期初餘額
         LET g_fmmj_d[l_ac + 1].* = g_fmmj_d[l_ac].*
         LET g_fmmj_d[l_ac].fmmj002 = g_fmmj_d[l_ac].fmmj002   #151207-00018#7
         LET g_fmmj_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmj_d[l_ac].fmmj002)   #151207-00018#7
         LET g_fmmj_d[l_ac].l_type = g_fmmj_d[l_ac].fmmj006,cl_getmsg('afm-00215',g_dlang)
         LET g_fmmj_d[l_ac].fmmj006 = g_fmmj_d[l_ac].fmmj006
         LET g_fmmj_d[l_ac].fmmj003 = NULL
         LET g_fmmj_d[l_ac].fmmj003_desc = NULL
         LET g_fmmj_d[l_ac].fmmjdocno = NULL
         LET g_fmmj_d[l_ac].fmmj027 = NULL   #151228-00008#2
         LET g_fmmj_d[l_ac].fmmjdocdt = NULL
         LET g_fmmj_d[l_ac].fmmj017 = NULL
         LET g_fmmj_d[l_ac].fmmj005 = NULL
         LET g_fmmj_d[l_ac].fmmj007 = NULL
         LET g_fmmj_d[l_ac].fmmj008 = NULL
         LET g_fmmj_d[l_ac].fmmj009 = NULL
         LET g_fmmj_d[l_ac].fmmj028 = NULL
         LET g_fmmj_d[l_ac].l_fmmy015 = NULL
         LET g_fmmj_d[l_ac].l_fmmy016 = NULL   #160107-00018#1
         LET g_fmmj_d[l_ac].l_sum = l_sum
         LET g_fmmj_d[l_ac].l_sum1 = l_sum1   #160107-00018#1
         LET l_ac = l_ac + 1
      END IF
      
      IF cl_null(l_fmmj002) THEN LET l_fmmj002 = g_fmmj_d[l_ac].fmmj002 END IF   #151207-00018#7
      IF cl_null(l_fmmj006) THEN LET l_fmmj006 = g_fmmj_d[l_ac].fmmj006 END IF
      
      #IF g_fmmj_d[l_ac].fmmj006 = l_fmmj006 THEN   #151207-00018#7 mark
      IF g_fmmj_d[l_ac].fmmj002 = l_fmmj002 AND g_fmmj_d[l_ac].fmmj006 = l_fmmj006 THEN   #151207-00018#7 add
         IF g_fmmj_d[l_ac].l_type <> '3' THEN
            #總面值
            LET l_fmmj017 = l_fmmj017 + g_fmmj_d[l_ac].fmmj017
            LET g_fmmj_d[l_ac].l_fmmj017_sum = l_fmmj017
            #原幣金額
            LET l_fmmj008 = l_fmmj008 + g_fmmj_d[l_ac].fmmj008
            LET g_fmmj_d[l_ac].l_fmmj008_sum = l_fmmj008
            #本幣金額
            LET l_fmmj028 = l_fmmj028 + g_fmmj_d[l_ac].fmmj028
            LET g_fmmj_d[l_ac].l_fmmj028_sum = l_fmmj028
            #出售成本-原幣
            LET l_fmmy015 = l_fmmy015 + g_fmmj_d[l_ac].l_fmmy015
            LET g_fmmj_d[l_ac].l_fmmy015_sum = l_fmmy015
            #160107-00018#1(S)
            #出售成本-原幣
            LET l_fmmy016 = l_fmmy016 + g_fmmj_d[l_ac].l_fmmy016
            LET g_fmmj_d[l_ac].l_fmmy016_sum = l_fmmy016
            #160107-00018#1(E)
            #原幣餘額&本幣餘額
            CASE g_fmmj_d[l_ac].l_type
              WHEN '1'
                LET l_sum = l_sum + g_fmmj_d[l_ac].fmmj008
                LET l_sum1 = l_sum1 + g_fmmj_d[l_ac].fmmj028   #160107-00018#1
              WHEN '2'
                LET l_sum = l_sum + g_fmmj_d[l_ac].l_fmmy015
                LET l_sum1 = l_sum1 + g_fmmj_d[l_ac].l_fmmy016  #160107-00018#1
            END CASE
            LET g_fmmj_d[l_ac].l_sum = l_sum
            LET g_fmmj_d[l_ac].l_sum1 = l_sum1 #160107-00018#1
         END IF
      ELSE
         LET g_fmmj_d[l_ac + 1].* = g_fmmj_d[l_ac].*
         LET g_fmmj_d[l_ac].l_type = '3'
         LET g_fmmj_d[l_ac].l_type = l_fmmj006,cl_getmsg('lib-00156',g_dlang)         
         #LET g_fmmj_d[l_ac].fmmj002 = NULL   #151207-00018#7   #151228-00008#2 mark
         #151228-00008#2(S)         
         LET g_fmmj_d[l_ac].fmmj002 = l_fmmj002
         LET g_fmmj_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmj_d[l_ac].fmmj002)
		   #151228-00008#2(E)         
         LET g_fmmj_d[l_ac].fmmj006 = NULL
         LET g_fmmj_d[l_ac].fmmj003 = NULL
         LET g_fmmj_d[l_ac].fmmj003_desc = NULL
         LET g_fmmj_d[l_ac].fmmjdocno = NULL
         LET g_fmmj_d[l_ac].fmmj027 = NULL   #151228-00008#2
         LET g_fmmj_d[l_ac].fmmjdocdt = NULL
         LET g_fmmj_d[l_ac].fmmj017 = g_fmmj_d[l_ac-1].l_fmmj017_sum
         LET g_fmmj_d[l_ac].fmmj005 = NULL
         LET g_fmmj_d[l_ac].fmmj007 = NULL
         LET g_fmmj_d[l_ac].fmmj008 = g_fmmj_d[l_ac-1].l_fmmj008_sum
         LET g_fmmj_d[l_ac].fmmj009 = NULL
         LET g_fmmj_d[l_ac].fmmj028 = g_fmmj_d[l_ac-1].l_fmmj028_sum
         LET g_fmmj_d[l_ac].l_fmmy015 = g_fmmj_d[l_ac-1].l_fmmy015_sum
         LET g_fmmj_d[l_ac].l_fmmy016 = g_fmmj_d[l_ac-1].l_fmmy016_sum   #160107-00018#1
         LET g_fmmj_d[l_ac].l_sum = g_fmmj_d[l_ac-1].l_sum
         LET g_fmmj_d[l_ac].l_sum1 = g_fmmj_d[l_ac-1].l_sum1   #160126-00008#1
         LET l_ac = l_ac + 1
         LET l_sum = 0
         LET l_sum1 = 0   #160126-00008#1
         LET l_fmmj017 = 0
         LET l_fmmj008 = 0
         LET l_fmmj028 = 0
         LET l_fmmy015 = 0
         LET l_fmmy016 = 0
      END IF
      
      ###############################
      #IF g_fmmj_d[l_ac].fmmj006 <> l_fmmj006 THEN   #151207-00018#7 mark
      IF g_fmmj_d[l_ac].fmmj002 <> l_fmmj002 OR g_fmmj_d[l_ac].fmmj006 <> l_fmmj006 THEN   #151207-00018#7 add
         #151228-00008#2(S)--mark
         ##購買原幣金額
         #LET l_fmmj002_f1 = ''  #151207-00018#7
         #LET l_fmmj006_f1 = ''
         #LET l_fmmj008_f1 = 0
         #SELECT fmmj002,fmmj006,SUM(fmmj008) INTO l_fmmj002_f1,l_fmmj006_f1,l_fmmj008_f1   #151207-00018#7 add fmmj002
         #  FROM fmmj_t 
         # WHERE fmmjent = g_enterprise 
         #   AND fmmjdocno = g_fmmj_d[l_ac].fmmjdocno
         #   AND fmmjstus = 'Y'
         #   AND fmmj002 = g_fmmj_d[l_ac].fmmj002   #151207-00018#7
         #   AND fmmj006 = g_fmmj_d[l_ac].fmmj006
         #   AND fmmjdocdt < g_fmmj_d[l_ac].fmmjdocdt
         # GROUP BY fmmj002,fmmj006  #151207-00018#7 add fmmj002
         # IF cl_null(l_fmmj008_f1) THEN LET l_fmmj008_f1 = 0 END IF
         ##平倉原幣成本
         #LET l_fmmy015_f1 = 0
         #LET l_f1 = 0
         #SELECT SUM(fmmy015) INTO l_fmmy015_f1
         #  FROM fmmy_t,fmmj_t
         # WHERE fmmyent = fmmjent
         #   AND fmmy001 = fmmjdocno
         #   AND fmmyent = g_enterprise
         #   AND fmmy001 = g_fmmj_d[l_ac].fmmjdocno
         #   AND fmmystus = 'Y'
         #   AND fmmj002 = l_fmmj002_f1   #151207-00018#7
         #   AND fmmy002 = l_fmmj006_f1
         #   AND fmmydocdt < g_fmmj_d[l_ac].fmmjdocdt
         #IF cl_null(l_fmmy015_f1) THEN LET l_fmmy015_f1 = 0 END IF
         ##取期初餘額
         #LET l_f1 = l_fmmj008_f1 - l_fmmy015_f1
         #151228-00008#2(E)--mark
         CALL afmq540_get_amount(g_fmmj_d[l_ac].fmmj002,g_fmmj_d[l_ac].fmmj006,g_fmmj_d[l_ac].fmmj003,g_fmmj_d[l_ac].fmmjdocno) RETURNING l_f1,l_f2   #151228-00008#2   #160107-00018#1 add l_f2
         #期初餘額
         LET g_fmmj_d[l_ac + 1].* = g_fmmj_d[l_ac].*
         LET g_fmmj_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmj_d[l_ac].fmmj002)   #151207-00018#7
         LET g_fmmj_d[l_ac].l_type = g_fmmj_d[l_ac].fmmj006,cl_getmsg('afm-00215',g_dlang)
         LET g_fmmj_d[l_ac].fmmj006 = g_fmmj_d[l_ac].fmmj006
         LET g_fmmj_d[l_ac].fmmj003 = NULL
         LET g_fmmj_d[l_ac].fmmj003_desc = NULL
         LET g_fmmj_d[l_ac].fmmjdocno = NULL
         LET g_fmmj_d[l_ac].fmmj027 = NULL   #151228-00008#2
         LET g_fmmj_d[l_ac].fmmjdocdt = NULL
         LET g_fmmj_d[l_ac].fmmj017 = NULL
         LET g_fmmj_d[l_ac].fmmj005 = NULL
         LET g_fmmj_d[l_ac].fmmj007 = NULL
         LET g_fmmj_d[l_ac].fmmj008 = NULL
         LET g_fmmj_d[l_ac].fmmj009 = NULL
         LET g_fmmj_d[l_ac].fmmj028 = NULL
         LET g_fmmj_d[l_ac].l_fmmy015 = NULL
         LET g_fmmj_d[l_ac].l_fmmy016 = NULL #160107-00018#1
         LET g_fmmj_d[l_ac].l_sum = l_f1
         LET g_fmmj_d[l_ac].l_sum1 = l_f2   #160107-00018#1
         LET l_ac = l_ac + 1
      END IF    
      ###############################
      #IF g_fmmj_d[l_ac].fmmj006 <> l_fmmj006 THEN   #151207-00018#7 mark
      IF g_fmmj_d[l_ac].fmmj002 <> l_fmmj002 OR g_fmmj_d[l_ac].fmmj006 <> l_fmmj006 THEN    #151207-00018#7 add
         #總面值
         LET l_fmmj017 = l_fmmj017 + g_fmmj_d[l_ac].fmmj017
         LET g_fmmj_d[l_ac].l_fmmj017_sum = l_fmmj017
         #原幣金額
         LET l_fmmj008 = l_fmmj008 + g_fmmj_d[l_ac].fmmj008
         LET g_fmmj_d[l_ac].l_fmmj008_sum = l_fmmj008
         #本幣金額
         LET l_fmmj028 = l_fmmj028 + g_fmmj_d[l_ac].fmmj028
         LET g_fmmj_d[l_ac].l_fmmj028_sum = l_fmmj028
         #出售成本-原幣
         LET l_fmmy015 = l_fmmy015 + g_fmmj_d[l_ac].l_fmmy015_sum
         LET g_fmmj_d[l_ac].l_fmmy015_sum = l_fmmy015
         #160107-00018#1(S)
         #出售成本-原幣
         LET l_fmmy016 = l_fmmy016 + g_fmmj_d[l_ac].l_fmmy016
         LET g_fmmj_d[l_ac].l_fmmy016_sum = l_fmmy016
         #160107-00018#1(E)         
         #151228-00008#2(S)--mark
         ##購買原幣金額
         #LET l_fmmj002_f1 = ''   #151207-00018#7
         #LET l_fmmj006_f1 = ''
         #LET l_fmmj008_f1 = 0
         #SELECT fmmj002,fmmj006,SUM(fmmj008) INTO l_fmmj002_f1,l_fmmj006_f1,l_fmmj008_f1   #151207-00018#7 add fmmj002
         #  FROM fmmj_t 
         # WHERE fmmjent = g_enterprise 
         #   AND fmmjdocno = g_fmmj_d[l_ac].fmmjdocno
         #   AND fmmjstus = 'Y'
         #   AND fmmj002 = g_fmmj_d[l_ac].fmmj002   #151207-00018#7
         #   AND fmmj006 = g_fmmj_d[l_ac].fmmj006
         #   AND fmmjdocdt < g_fmmj_d[l_ac].fmmjdocdt
         # GROUP BY fmmj002,fmmj006
         #IF cl_null(l_fmmj008_f1) THEN LET l_fmmj008_f1 = 0 END IF
         ##平倉原幣成本
         #LET l_fmmy015_f1 = 0
         #LET l_f1 = 0
         #SELECT SUM(fmmy015) INTO l_fmmy015_f1
         #  FROM fmmy_t,fmmj_t
         # WHERE fmmyent = fmmjent
         #   AND fmmy001 = fmmjdocno
         #   AND fmmyent = g_enterprise
         #   AND fmmy001 = g_fmmj_d[l_ac].fmmjdocno
         #   AND fmmystus = 'Y'
         #   AND fmmj002 = l_fmmj002_f1   #151207-00018#7
         #   AND fmmy002 = l_fmmj006_f1
         #   AND fmmydocdt < g_fmmj_d[l_ac].fmmjdocdt
         #IF cl_null(l_fmmy015_f1) THEN LET l_fmmy015_f1 = 0 END IF
         ##取期初餘額
         #LET l_f1 = l_fmmj008_f1 - l_fmmy015_f1
         #151228-00008#2(E)--mark
         CALL afmq540_get_amount(g_fmmj_d[l_ac].fmmj002,g_fmmj_d[l_ac].fmmj006,g_fmmj_d[l_ac].fmmj003,g_fmmj_d[l_ac].fmmjdocno) RETURNING l_f1,l_f2   #151228-00008#2 #160107-00018#1 add l_f2
          
         CASE g_fmmj_d[l_ac].l_type
           WHEN '1'
             LET l_sum = l_f1 + g_fmmj_d[l_ac].fmmj008
             LET l_sum1 = l_f2 + g_fmmj_d[l_ac].fmmj028   #160107-00018#1
           WHEN '2'
             LET l_sum = l_f1 + g_fmmj_d[l_ac].l_fmmy015
             LET l_sum1 = l_f2 + g_fmmj_d[l_ac].l_fmmy016   #160107-00018#1
         END CASE
         LET g_fmmj_d[l_ac].l_sum = l_sum
         LET g_fmmj_d[l_ac].l_sum1 = l_sum1   #160107-00018#1
      END IF
      LET l_fmmj002 = g_fmmj_d[l_ac].fmmj002   #151207-00018#7      
      LET l_fmmj006 = g_fmmj_d[l_ac].fmmj006
      
      #151207-00018#7 add(S)
      #交易市場名稱
      LET g_fmmj_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmj_d[l_ac].fmmj002)
      #151207-00018#7 add(E)
      #投資種類說明
      LET g_fmmj_d[l_ac].fmmj003_desc = s_desc_fmma001_desc(g_fmmj_d[l_ac].fmmj003)
      #資料來源
      CASE g_fmmj_d[l_ac].l_type    
        WHEN '1' #購買單
          LET g_fmmj_d[l_ac].l_type = cl_getmsg('afm-00204',g_dlang)
        WHEN '2' #平倉單
          LET g_fmmj_d[l_ac].l_type = cl_getmsg('afm-00205',g_dlang)          
      END CASE
      #end add-point
 
      CALL afmq540_detail_show("'1'")
 
      CALL afmq540_fmmj_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_fmmj_d.deleteElement(g_fmmj_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF l_ac > 1 THEN
      LET g_fmmj_d[l_ac].l_type = '3'
      LET g_fmmj_d[l_ac].l_type = l_fmmj006,cl_getmsg('lib-00156',g_dlang)
      #151228-00008#2(S)         
      LET g_fmmj_d[l_ac].fmmj002 = l_fmmj002
      LET g_fmmj_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmj_d[l_ac].fmmj002)
		#151228-00008#2(E)      
      LET g_fmmj_d[l_ac].fmmj006 = NULL
      LET g_fmmj_d[l_ac].fmmj003 = NULL
      LET g_fmmj_d[l_ac].fmmj003_desc = NULL
      LET g_fmmj_d[l_ac].fmmjdocno = NULL
      LET g_fmmj_d[l_ac].fmmj027 = NULL   #151228-00008#2
      LET g_fmmj_d[l_ac].fmmjdocdt = NULL
      LET g_fmmj_d[l_ac].fmmj017 = g_fmmj_d[l_ac-1].l_fmmj017_sum
      LET g_fmmj_d[l_ac].fmmj005 = NULL
      LET g_fmmj_d[l_ac].fmmj007 = NULL
      LET g_fmmj_d[l_ac].fmmj008 = g_fmmj_d[l_ac-1].l_fmmj008_sum
      LET g_fmmj_d[l_ac].fmmj009 = NULL
      LET g_fmmj_d[l_ac].fmmj028 = g_fmmj_d[l_ac-1].l_fmmj028_sum
      LET g_fmmj_d[l_ac].l_fmmy015 = g_fmmj_d[l_ac-1].l_fmmy015_sum
      LET g_fmmj_d[l_ac].l_fmmy016 = g_fmmj_d[l_ac-1].l_fmmy016_sum   #160107-00018#1
      LET g_fmmj_d[l_ac].l_sum = g_fmmj_d[l_ac-1].l_sum
      LET g_fmmj_d[l_ac].l_sum1 = g_fmmj_d[l_ac-1].l_sum1
   END IF

   #依畫面資料INSERT XG_tmp 
   DELETE FROM afmq540_x01_tmp
   FOR l_i = 1 TO g_fmmj_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.l_seq           = l_i   #151228-00008#2
      LET l_x01_tmp.fmmj002         = g_fmmj_d[l_i].fmmj002        #151207-00018#7
      LET l_x01_tmp.fmmj002_desc    = g_fmmj_d[l_i].fmmj002_desc   #151207-00018#7
      LET l_x01_tmp.fmmj006         = g_fmmj_d[l_i].fmmj006
      LET l_x01_tmp.fmmj003         = g_fmmj_d[l_i].fmmj003   
      LET l_x01_tmp.fmmj003_desc    = g_fmmj_d[l_i].fmmj003_desc   
      LET l_x01_tmp.fmmjdocno       = g_fmmj_d[l_i].fmmjdocno
      LET l_x01_tmp.fmmj027         = g_fmmj_d[l_i].fmmj027   #151228-00008#2      
      LET l_x01_tmp.fmmjdocdt       = g_fmmj_d[l_i].fmmjdocdt
      LET l_x01_tmp.l_type          = g_fmmj_d[l_i].l_type
      LET l_x01_tmp.fmmj017         = g_fmmj_d[l_i].fmmj017
      LET l_x01_tmp.fmmj005         = g_fmmj_d[l_i].fmmj005
      LET l_x01_tmp.fmmj007         = g_fmmj_d[l_i].fmmj007
      LET l_x01_tmp.fmmj008         = g_fmmj_d[l_i].fmmj008     
      LET l_x01_tmp.fmmj009         = g_fmmj_d[l_i].fmmj009
      LET l_x01_tmp.fmmj028         = g_fmmj_d[l_i].fmmj028
      LET l_x01_tmp.l_fmmy015       = g_fmmj_d[l_i].l_fmmy015
      LET l_x01_tmp.l_sum           = g_fmmj_d[l_i].l_sum
      LET l_x01_tmp.l_sum1          = g_fmmj_d[l_i].l_sum1   #160107-00018#1
      #INSERT INTO afmq540_x01_tmp VALUES(l_x01_tmp.*) #161104-00024#11 mark
      #161104-00024#11 --s add
      INSERT INTO afmq540_x01_tmp(l_seq,fmmj002,fmmj002_desc,fmmj006,fmmj003,             
                                  fmmj003_desc,fmmjdocno,fmmj027,fmmjdocdt,l_type,             
                                  fmmj017,fmmj005,fmmj007,fmmj008,fmmj009,
                                  fmmj028,l_fmmy015,l_sum,l_sum1)
      VALUES(l_x01_tmp.l_seq,l_x01_tmp.fmmj002,l_x01_tmp.fmmj002_desc,l_x01_tmp.fmmj006,l_x01_tmp.fmmj003,      
             l_x01_tmp.fmmj003_desc,l_x01_tmp.fmmjdocno,l_x01_tmp.fmmj027,l_x01_tmp.fmmjdocdt,l_x01_tmp.l_type,       
             l_x01_tmp.fmmj017,l_x01_tmp.fmmj005,l_x01_tmp.fmmj007,l_x01_tmp.fmmj008,l_x01_tmp.fmmj009,     
             l_x01_tmp.fmmj028,l_x01_tmp.l_fmmy015,l_x01_tmp.l_sum,l_x01_tmp.l_sum1)
      #161104-00024#11 --e add
   END FOR
   LET g_tot_cnt = g_fmmj_d.getLength()
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_fmmj_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE afmq540_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afmq540_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afmq540_detail_action_trans()
 
   LET l_ac = 1
   IF g_fmmj_d.getLength() > 0 THEN
      CALL afmq540_b_fill2()
   END IF
 
      CALL afmq540_filter_show('fmmj002','b_fmmj002')
   CALL afmq540_filter_show('fmmj006','b_fmmj006')
   CALL afmq540_filter_show('fmmj003','b_fmmj003')
   CALL afmq540_filter_show('fmmjdocno','b_fmmjdocno')
   CALL afmq540_filter_show('fmmjdocdt','b_fmmjdocdt')
   CALL afmq540_filter_show('fmmj017','b_fmmj017')
   CALL afmq540_filter_show('fmmj005','b_fmmj005')
   CALL afmq540_filter_show('fmmj007','b_fmmj007')
   CALL afmq540_filter_show('fmmj008','b_fmmj008')
   CALL afmq540_filter_show('fmmj009','b_fmmj009')
   CALL afmq540_filter_show('fmmj028','b_fmmj028')
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmq540_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmq540_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION afmq540_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON fmmj002,fmmj006,fmmj003,fmmjdocno,fmmjdocdt,fmmj017,fmmj005,fmmj007,fmmj008, 
          fmmj009,fmmj028
                          FROM s_detail1[1].b_fmmj002,s_detail1[1].b_fmmj006,s_detail1[1].b_fmmj003, 
                              s_detail1[1].b_fmmjdocno,s_detail1[1].b_fmmjdocdt,s_detail1[1].b_fmmj017, 
                              s_detail1[1].b_fmmj005,s_detail1[1].b_fmmj007,s_detail1[1].b_fmmj008,s_detail1[1].b_fmmj009, 
                              s_detail1[1].b_fmmj028
 
         BEFORE CONSTRUCT
                     DISPLAY afmq540_filter_parser('fmmj002') TO s_detail1[1].b_fmmj002
            DISPLAY afmq540_filter_parser('fmmj006') TO s_detail1[1].b_fmmj006
            DISPLAY afmq540_filter_parser('fmmj003') TO s_detail1[1].b_fmmj003
            DISPLAY afmq540_filter_parser('fmmjdocno') TO s_detail1[1].b_fmmjdocno
            DISPLAY afmq540_filter_parser('fmmjdocdt') TO s_detail1[1].b_fmmjdocdt
            DISPLAY afmq540_filter_parser('fmmj017') TO s_detail1[1].b_fmmj017
            DISPLAY afmq540_filter_parser('fmmj005') TO s_detail1[1].b_fmmj005
            DISPLAY afmq540_filter_parser('fmmj007') TO s_detail1[1].b_fmmj007
            DISPLAY afmq540_filter_parser('fmmj008') TO s_detail1[1].b_fmmj008
            DISPLAY afmq540_filter_parser('fmmj009') TO s_detail1[1].b_fmmj009
            DISPLAY afmq540_filter_parser('fmmj028') TO s_detail1[1].b_fmmj028
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<b_fmmj002>>----
         #Ctrlp:construct.c.page1.b_fmmj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj002
            #add-point:ON ACTION controlp INFIELD b_fmmj002 name="construct.c.filter.page1.b_fmmj002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmme001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fmmj002  #顯示到畫面上
            NEXT FIELD b_fmmj002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_fmmj002_desc>>----
         #----<<b_fmmj006>>----
         #Ctrlp:construct.c.page1.b_fmmj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj006
            #add-point:ON ACTION controlp INFIELD b_fmmj006 name="construct.c.filter.page1.b_fmmj006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fmmj006  #顯示到畫面上
            NEXT FIELD b_fmmj006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_fmmj003>>----
         #Ctrlp:construct.c.page1.b_fmmj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj003
            #add-point:ON ACTION controlp INFIELD b_fmmj003 name="construct.c.filter.page1.b_fmmj003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmma001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fmmj003  #顯示到畫面上
            NEXT FIELD b_fmmj003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_fmmj003_desc>>----
         #----<<b_fmmjdocno>>----
         #Ctrlp:construct.c.page1.b_fmmjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmjdocno
            #add-point:ON ACTION controlp INFIELD b_fmmjdocno name="construct.c.filter.page1.b_fmmjdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " fmmjstus = 'Y' "
            CALL q_fmmjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fmmjdocno  #顯示到畫面上
            NEXT FIELD b_fmmjdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<fmmj027>>----
         #----<<b_fmmjdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_fmmjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmjdocdt
            #add-point:ON ACTION controlp INFIELD b_fmmjdocdt name="construct.c.filter.page1.b_fmmjdocdt"
            
            #END add-point
 
 
         #----<<l_type>>----
         #----<<b_fmmj017>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj017
            #add-point:ON ACTION controlp INFIELD b_fmmj017 name="construct.c.filter.page1.b_fmmj017"
            
            #END add-point
 
 
         #----<<l_fmmj017_sum>>----
         #----<<b_fmmj005>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj005
            #add-point:ON ACTION controlp INFIELD b_fmmj005 name="construct.c.filter.page1.b_fmmj005"
            
            #END add-point
 
 
         #----<<b_fmmj007>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj007
            #add-point:ON ACTION controlp INFIELD b_fmmj007 name="construct.c.filter.page1.b_fmmj007"
            
            #END add-point
 
 
         #----<<b_fmmj008>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj008
            #add-point:ON ACTION controlp INFIELD b_fmmj008 name="construct.c.filter.page1.b_fmmj008"
            
            #END add-point
 
 
         #----<<l_fmmj008_sum>>----
         #----<<b_fmmj009>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj009
            #add-point:ON ACTION controlp INFIELD b_fmmj009 name="construct.c.filter.page1.b_fmmj009"
            
            #END add-point
 
 
         #----<<b_fmmj028>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj028
            #add-point:ON ACTION controlp INFIELD b_fmmj028 name="construct.c.filter.page1.b_fmmj028"
            
            #END add-point
 
 
         #----<<l_fmmj028_sum>>----
         #----<<l_fmmy015>>----
         #----<<l_fmmy015_sum>>----
         #----<<l_fmmy016>>----
         #----<<l_fmmy016_sum>>----
         #----<<l_sum>>----
         #----<<l_sum1>>----
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         #end add-point
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
 
   END DIALOG
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL afmq540_filter_show('fmmj002','b_fmmj002')
   CALL afmq540_filter_show('fmmj006','b_fmmj006')
   CALL afmq540_filter_show('fmmj003','b_fmmj003')
   CALL afmq540_filter_show('fmmjdocno','b_fmmjdocno')
   CALL afmq540_filter_show('fmmjdocdt','b_fmmjdocdt')
   CALL afmq540_filter_show('fmmj017','b_fmmj017')
   CALL afmq540_filter_show('fmmj005','b_fmmj005')
   CALL afmq540_filter_show('fmmj007','b_fmmj007')
   CALL afmq540_filter_show('fmmj008','b_fmmj008')
   CALL afmq540_filter_show('fmmj009','b_fmmj009')
   CALL afmq540_filter_show('fmmj028','b_fmmj028')
 
 
   CALL afmq540_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION afmq540_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
   #end add-point
 
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
 
{</section>}
 
{<section id="afmq540.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION afmq540_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = afmq540_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="afmq540.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afmq540_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afmq540_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_fmmj_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_fmmj_d.getLength() AND g_fmmj_d.getLength() > 0
            LET g_detail_idx = g_fmmj_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_fmmj_d.getLength() THEN
               LET g_detail_idx = g_fmmj_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmq540.mask_functions" >}
 &include "erp/afm/afmq540_mask.4gl"
 
{</section>}
 
{<section id="afmq540.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 新增temp table
# Memo...........:
# Usage..........: CALL afmq540_create_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/11/25 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION afmq540_create_tmp()
DEFINE l_session      LIKE type_t.num10 #test

   #查詢session編號
   LET l_session = ''
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   DISPLAY "[afmq540_tmp_session_id] ",l_session

   DROP TABLE afmq540_tmp;
   #151207-00018#7 add fmmj002
   CREATE TEMP TABLE afmq540_tmp(
      fmmj002  LIKE fmmj_t.fmmj002,
      fmmjdocno  LIKE fmmj_t.fmmjdocno
         )        
         
   DROP TABLE afmq540_x01_tmp;
   #151207-00018#7 add fmmj002,fmmj002_desc
   #151228-00008#2 add fmmj027,l_seq
   #160107-00018#1 add l_sum1
   CREATE TEMP TABLE afmq540_x01_tmp(
      l_seq              LIKE type_t.num10,
      fmmj002            LIKE fmmj_t.fmmj002,
      fmmj002_desc       LIKE type_t.chr500, 
      fmmj006            LIKE fmmj_t.fmmj006,
      fmmj003            LIKE fmmj_t.fmmj003, 
      fmmj003_desc       LIKE type_t.chr500, 
      fmmjdocno          LIKE fmmj_t.fmmjdocno,
      fmmj027            LIKE fmmj_t.fmmj027,              
      fmmjdocdt          LIKE fmmj_t.fmmjdocdt, 
      l_type             LIKE type_t.chr100, 
      fmmj017            LIKE fmmj_t.fmmj017, 
      fmmj005            LIKE fmmj_t.fmmj005, 
      fmmj007            LIKE fmmj_t.fmmj007, 
      fmmj008            LIKE fmmj_t.fmmj008,      
      fmmj009            LIKE fmmj_t.fmmj009, 
      fmmj028            LIKE fmmj_t.fmmj028,
      l_fmmy015          LIKE type_t.num20_6,
      l_sum              LIKE type_t.num20_6,
      l_sum1             LIKE type_t.num20_6
         )
END FUNCTION

################################################################################
# Descriptions...: 抓取期初餘額
# Memo...........:
# Usage..........: CALL afmq540_get_amount(p_fmmj002,p_fmmj006,p_fmmj003,p_fmmjdocno)
#                  RETURNING r_amount,r_amount1
# Input parameter: p_fmmj002   交易市場
#                  p_fmmj006   幣別
#                  p_fmmj003   投資種類
#                  p_fmmjdocno 投資購買單號
# Return code....: r_amount    期初餘額-原幣
#                : r_amount1   期初餘額-本幣
# Date & Author..: 2016/01/04 By sakura #151228-00008#2
# Modify.........: #160107-00018#1 增加期初餘額-本幣處理
################################################################################
PRIVATE FUNCTION afmq540_get_amount(p_fmmj002,p_fmmj006,p_fmmj003,p_fmmjdocno)
DEFINE p_fmmj002   LIKE fmmj_t.fmmj002
DEFINE p_fmmj006   LIKE fmmj_t.fmmj006
DEFINE p_fmmj003   LIKE fmmj_t.fmmj003
DEFINE p_fmmjdocno LIKE fmmj_t.fmmjdocno
DEFINE r_amount  LIKE fmmj_t.fmmj008 
DEFINE r_amount1 LIKE fmmj_t.fmmj008   #160107-00018#1
DEFINE l_sql     STRING
DEFINE l_fmmj    RECORD
                 fmmj002     LIKE fmmj_t.fmmj002,
                 fmmj006     LIKE fmmj_t.fmmj006,
                 fmmj003     LIKE fmmj_t.fmmj003,
                 fmmjdocno   LIKE fmmj_t.fmmjdocno,
                 fmmjdocdt   LIKE fmmj_t.fmmjdocdt,
                 fmmj008     LIKE fmmj_t.fmmj008,
                 fmmy015     LIKE fmmy_t.fmmy015,
                 fmmj028     LIKE fmmj_t.fmmj028,   #160107-00018#1
                 fmmy016     LIKE fmmy_t.fmmy016    #160107-00018#1
                 END RECORD
   
   LET r_amount = 0
   LET r_amount1 = 0   #160107-00018#1
   INITIALIZE l_fmmj.* TO NULL

   LET l_sql ="SELECT fmmj002,fmmj006,fmmj003,fmmjdocno,fmmjdocdt ",
              "  FROM fmmj_t ",
              " WHERE fmmjent = ",g_enterprise," AND ", g_input.wc,
              "   AND fmmjsite = '",g_input.fmmjsite,"'",
              "   AND fmmjstus = 'Y' ",
              "   AND fmmjdocno NOT IN (SELECT fmmjdocno FROM afmq540_tmp) ",
              "UNION "
   LET g_input.wc  = cl_replace_str(g_input.wc,'fmmjdocdt','fmmydocdt') 
   LET l_sql = l_sql,
              "SELECT fmmj002,fmmy002,fmmj003,fmmy001,fmmydocdt ",
              "  FROM fmmy_t,fmmj_t ",
              " WHERE fmmyent = fmmjent ",
              "   AND fmmy001 = fmmjdocno ",
              "   AND fmmyent = ",g_enterprise," AND ", g_input.wc,
              "   AND fmmjsite = '",g_input.fmmjsite,"'",
              "   AND fmmystus = 'Y' ",
              "   AND fmmy001 NOT IN (SELECT fmmjdocno FROM afmq540_tmp)",
              " ORDER BY fmmjdocdt "
   #恢復g_input.wc
   LET g_input.wc  = cl_replace_str(g_input.wc,'fmmydocdt','fmmjdocdt')
   
   PREPARE afmq540_get_amount_prep FROM l_sql
   DECLARE afmq540_get_amount_curs SCROLL CURSOR FOR afmq540_get_amount_prep
   OPEN afmq540_get_amount_curs
   FETCH FIRST afmq540_get_amount_curs INTO l_fmmj.fmmj002,l_fmmj.fmmj006,l_fmmj.fmmj003,
                                            l_fmmj.fmmjdocno,l_fmmj.fmmjdocdt
     #購買原幣金額
     LET l_fmmj.fmmj008 = 0
     SELECT SUM(fmmj008) INTO l_fmmj.fmmj008
       FROM fmmj_t 
      WHERE fmmjent = g_enterprise 
        AND fmmjsite = g_input.fmmjsite
        AND fmmjstus = 'Y'
        AND fmmj002 = p_fmmj002            #要依傳入值過濾條件
        AND fmmj006 = p_fmmj006            #要依傳入值過濾條件
        AND fmmjdocdt < l_fmmj.fmmjdocdt   #只拿日期篩選小於的資料,當作期初金額
      GROUP BY fmmj002,fmmj006
      IF cl_null(l_fmmj.fmmj008) THEN LET l_fmmj.fmmj008 = 0 END IF
     #平倉原幣成本
     LET l_fmmj.fmmy015 = 0
     SELECT SUM(fmmy015) INTO l_fmmj.fmmy015
       FROM fmmy_t,fmmj_t
      WHERE fmmyent = fmmjent
        AND fmmy001 = fmmjdocno
        AND fmmyent = g_enterprise
        AND fmmjsite = g_input.fmmjsite
        AND fmmystus = 'Y'
        AND fmmj002 = p_fmmj002            #要依傳入值過濾條件
        AND fmmy002 = p_fmmj006            #要依傳入值過濾條件
        AND fmmydocdt < l_fmmj.fmmjdocdt   #只拿日期篩選小於的資料,當作期初金額
     IF cl_null(l_fmmj.fmmy015) THEN LET l_fmmj.fmmy015 = 0 END IF
     #取期初餘額-原幣
     LET r_amount = l_fmmj.fmmj008 - l_fmmj.fmmy015
     
     #160107-00018#1(S)
     #購買本幣金額
     LET l_fmmj.fmmj028 = 0
     SELECT SUM(fmmj028) INTO l_fmmj.fmmj028
       FROM fmmj_t 
      WHERE fmmjent = g_enterprise 
        AND fmmjsite = g_input.fmmjsite
        AND fmmjstus = 'Y'
        AND fmmj002 = p_fmmj002            #要依傳入值過濾條件
        AND fmmj006 = p_fmmj006            #要依傳入值過濾條件
        AND fmmjdocdt < l_fmmj.fmmjdocdt   #只拿日期篩選小於的資料,當作期初金額
      GROUP BY fmmj002,fmmj006
      IF cl_null(l_fmmj.fmmj028) THEN LET l_fmmj.fmmj028 = 0 END IF
     #平倉本幣成本
     LET l_fmmj.fmmy016 = 0
     SELECT SUM(fmmy016) INTO l_fmmj.fmmy016
       FROM fmmy_t,fmmj_t
      WHERE fmmyent = fmmjent
        AND fmmy001 = fmmjdocno
        AND fmmyent = g_enterprise
        AND fmmjsite = g_input.fmmjsite
        AND fmmystus = 'Y'
        AND fmmj002 = p_fmmj002            #要依傳入值過濾條件
        AND fmmy002 = p_fmmj006            #要依傳入值過濾條件
        AND fmmydocdt < l_fmmj.fmmjdocdt   #只拿日期篩選小於的資料,當作期初金額
     IF cl_null(l_fmmj.fmmy016) THEN LET l_fmmj.fmmy016 = 0 END IF
     #取期初餘額-本幣
     LET r_amount1 = l_fmmj.fmmj028 - l_fmmj.fmmy016     
     #160107-00018#1(E)
     
   RETURN r_amount,r_amount1   #160107-00018#1 add r_amount1
END FUNCTION

 
{</section>}
 
