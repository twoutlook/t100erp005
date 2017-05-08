#該程式未解開Section, 採用最新樣板產出!
{<section id="afmq560.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-01-27 18:31:29), PR版次:0006(2016-11-09 10:08:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: afmq560
#+ Description: 各期利息收入查詢
#+ Creator....: 02159(2016-01-27 16:10:37)
#+ Modifier...: 02159 -SD/PR- 08171
 
{</section>}
 
{<section id="afmq560.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#140212-00001#38  2016/02/04  by sakura   增加計提單號欄位（含XG）
#160406-00023#1   2016/04/06  By 02097    已收息利息，應從累計暫估扣除
#160902-00004#1   2016/09/04  By Reanna   第一筆的累積暫估利息要扣掉已收息的部分
#161006-00005#25  2016/10/21  By 06814    投資組織(fmmt001)開窗改用q_ooef001_33()
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
   fmmt002 LIKE fmmt_t.fmmt002, 
   fmmsdocno LIKE fmms_t.fmmsdocno, 
   fmmj027 LIKE type_t.chr500, 
   fmms001 LIKE fmms_t.fmms001, 
   fmms002 LIKE fmms_t.fmms002, 
   fmmj017 LIKE fmmj_t.fmmj017, 
   fmmj031 LIKE fmmj_t.fmmj031, 
   fmmjdocdt LIKE fmmj_t.fmmjdocdt, 
   fmmt005 LIKE fmmt_t.fmmt005, 
   fmmt006 LIKE fmmt_t.fmmt006, 
   fmmt007 LIKE fmmt_t.fmmt007, 
   fmmt010 LIKE fmmt_t.fmmt010, 
   fmmt014 LIKE fmmt_t.fmmt014, 
   fmmn003 LIKE fmmn_t.fmmn003, 
   fmmn005 LIKE fmmn_t.fmmn005, 
   fmmn006 LIKE fmmn_t.fmmn006, 
   l_fmmt010_sum LIKE type_t.num20_6, 
   l_fmmt014_sum LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_master RECORD
     fmmt001         LIKE fmmt_t.fmmt001,
     fmmt001_desc    LIKE type_t.chr100,
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
 
{<section id="afmq560.main" >}
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
   DECLARE afmq560_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmq560_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmq560_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmq560 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmq560_init()   
 
      #進入選單 Menu (="N")
      CALL afmq560_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmq560
      
   END IF 
   
   CLOSE afmq560_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmq560.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmq560_init()
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
   CALL afmq560_create_tmp()
   #取該g_site的法人
   CALL s_aooi100_get_comp(g_site) RETURNING g_sub_success,g_input.fmmt001
   CALL s_desc_get_department_desc(g_input.fmmt001) RETURNING g_input.fmmt001_desc
   DISPLAY BY NAME g_input.fmmt001_desc
   #end add-point
 
   CALL afmq560_default_search()
END FUNCTION
 
{</section>}
 
{<section id="afmq560.default_search" >}
PRIVATE FUNCTION afmq560_default_search()
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
 
{<section id="afmq560.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmq560_ui_dialog() 
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
   #XG報表用的temp
   DEFINE l_i            LIKE type_t.num10
   DEFINE l_x01_tmp      RECORD
       fmmj002           LIKE fmmj_t.fmmj002, 
       fmmj002_desc      LIKE type_t.chr500, 
       fmmj006           LIKE fmmj_t.fmmj006, 
       fmmj003           LIKE fmmj_t.fmmj003, 
       fmmj003_desc      LIKE type_t.chr500, 
       fmmt002           LIKE fmmt_t.fmmt002,
       fmmsdocno         LIKE fmms_t.fmmsdocno,   #140212-00001#38
       fmmj027           LIKE type_t.chr500, 
       fmms001           LIKE fmms_t.fmms001, 
       fmms002           LIKE fmms_t.fmms002, 
       fmmj017           LIKE fmmj_t.fmmj017, 
       fmmj031           LIKE fmmj_t.fmmj031, 
       fmmjdocdt         LIKE fmmj_t.fmmjdocdt, 
       fmmt005           LIKE fmmt_t.fmmt005, 
       fmmt006           LIKE fmmt_t.fmmt006, 
       fmmt007           LIKE fmmt_t.fmmt007, 
       fmmt010           LIKE fmmt_t.fmmt010, 
       fmmt014           LIKE fmmt_t.fmmt014, 
       fmmn003           LIKE fmmn_t.fmmn003, 
       fmmn005           LIKE fmmn_t.fmmn005, 
       fmmn006           LIKE fmmn_t.fmmn006, 
       l_fmmt010_sum     LIKE type_t.num20_6, 
       l_fmmt014_sum     LIKE type_t.num20_6
   END RECORD
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
   LET g_input.l_show = 'N'
   #end add-point
 
   
   CALL afmq560_b_fill()
  
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
 
         CALL afmq560_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_input.fmmt001,g_input.l_show ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD fmmt001
           LET g_input.fmmt001_desc = ''
           DISPLAY BY NAME g_input.fmmt001_desc
           IF NOT cl_null(g_input.fmmt001) THEN
              #檢查輸入的資料不存在[組織基本資料檔]中！
              CALL s_fin_account_center_chk(g_input.fmmt001,g_input.fmmt001,'6',g_today) RETURNING g_sub_success,g_errno
              IF NOT g_sub_success THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_input.fmmt001 = ''
                 NEXT FIELD CURRENT
              END IF              
              CALL s_desc_get_department_desc(g_input.fmmt001) RETURNING g_input.fmmt001_desc
              DISPLAY BY NAME g_input.fmmt001_desc
           END IF
            
         ON ACTION controlp INFIELD fmmt001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            #161006-00005#25 20161021 mark by beckxie---S
            #LET g_qryparam.where = " ooef206 = 'Y' "   #資金組織
            #CALL q_ooef001()                           #呼叫開窗
            #161006-00005#25 20161021 mark by beckxie---E
            CALL q_ooef001_33()                         #資金組織 #161006-00005#25 20161021 add by beckxie
            LET g_input.fmmt001 = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.fmmt001) RETURNING g_input.fmmt001_desc
            DISPLAY BY NAME g_input.fmmt001,g_input.fmmt001_desc
            NEXT FIELD CURRENT
            
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_input.wc ON fmmj002,fmmt002,l_date,fmmj003,fmmj006
            
            ON ACTION controlp INFIELD fmmj002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_fmme001()
               DISPLAY g_qryparam.return1 TO fmmj002
               NEXT FIELD CURRENT
            
            ON ACTION controlp INFIELD fmmt002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " fmmjstus = 'Y' "
               #只抓存在計提檔中的投資購買單
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 ",
                                                       "               FROM fmmt_t ",
                                                       "              WHERE fmmtent = ",g_enterprise,
                                                       "                AND fmmt001 = '",g_input.fmmt001,"' ",
                                                       "                AND fmmtent = fmmjent ",
                                                       "                AND fmmt002 = fmmjdocno ) "
               #扣除已平倉資料
               IF g_input.l_show = 'N' THEN
                  LET g_qryparam.where = g_qryparam.where ," AND fmmjdocno NOT IN (",
                                                           "     SELECT fmmjdocno FROM (",
                                                           "            SELECT fmmjdocno,(fmmj005-SUM(fmmy003)) as fmmysum",
                                                           "              FROM fmmj_t,fmmy_t",
                                                           "             WHERE fmmjent = fmmyent ",
                                                           "               AND fmmjdocno = fmmy001 ",
                                                           "               AND fmmystus <> 'X' ",
                                                           "               AND fmmjent = ",g_enterprise,
                                                           "               AND fmmjsite = '",g_input.fmmt001,"'",
                                                           "             GROUP BY fmmjdocno,fmmj005)",
                                                           "      WHERE fmmysum = 0)"
               END IF                                                       
               CALL q_fmmjdocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fmmt002  #顯示到畫面上
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
               CALL afmq560_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afmq560_b_fill2()
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
            CALL afmq560_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD fmmt001
 
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
            IF cl_null(g_input.fmmt001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'acr-00015'
               LET g_errparam.popup  = FALSE
               CALL cl_err()               
               NEXT FIELD fmmt001
            END IF
            IF cl_null(g_input.wc) THEN
               LET g_input.wc = " 1=1"
            END IF
            LET g_wc = " 1=1"
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL afmq560_b_fill()
 
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
            CALL afmq560_b_fill()
 
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
            CALL afmq560_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afmq560_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afmq560_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afmq560_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afmq560_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #依畫面資料INSERT XG_tmp 
               DELETE FROM afmq560_x01_tmp
               FOR l_i = 1 TO g_fmmj_d.getLength()
                  INITIALIZE l_x01_tmp.* TO NULL
	               LET l_x01_tmp.fmmj002         = g_fmmj_d[l_i].fmmj002      
                  LET l_x01_tmp.fmmj002_desc    = g_fmmj_d[l_i].fmmj002_desc 
                  LET l_x01_tmp.fmmj006         = g_fmmj_d[l_i].fmmj006      
                  LET l_x01_tmp.fmmj003         = g_fmmj_d[l_i].fmmj003      
                  LET l_x01_tmp.fmmj003_desc    = g_fmmj_d[l_i].fmmj003_desc 
                  LET l_x01_tmp.fmmt002         = g_fmmj_d[l_i].fmmt002
                  LET l_x01_tmp.fmmsdocno       = g_fmmj_d[l_i].fmmsdocno   #140212-00001#38
                  LET l_x01_tmp.fmmj027         = g_fmmj_d[l_i].fmmj027      
                  LET l_x01_tmp.fmms001         = g_fmmj_d[l_i].fmms001      
                  LET l_x01_tmp.fmms002         = g_fmmj_d[l_i].fmms002      
                  LET l_x01_tmp.fmmj017         = g_fmmj_d[l_i].fmmj017      
                  LET l_x01_tmp.fmmj031         = g_fmmj_d[l_i].fmmj031      
                  LET l_x01_tmp.fmmjdocdt       = g_fmmj_d[l_i].fmmjdocdt    
                  LET l_x01_tmp.fmmt005         = g_fmmj_d[l_i].fmmt005      
                  LET l_x01_tmp.fmmt006         = g_fmmj_d[l_i].fmmt006      
                  LET l_x01_tmp.fmmt007         = g_fmmj_d[l_i].fmmt007      
                  LET l_x01_tmp.fmmt010         = g_fmmj_d[l_i].fmmt010      
                  LET l_x01_tmp.fmmt014         = g_fmmj_d[l_i].fmmt014      
                  LET l_x01_tmp.fmmn003         = g_fmmj_d[l_i].fmmn003      
                  LET l_x01_tmp.fmmn005         = g_fmmj_d[l_i].fmmn005      
                  LET l_x01_tmp.fmmn006         = g_fmmj_d[l_i].fmmn006      
                  LET l_x01_tmp.l_fmmt010_sum   = g_fmmj_d[l_i].l_fmmt010_sum
                  LET l_x01_tmp.l_fmmt014_sum   = g_fmmj_d[l_i].l_fmmt014_sum
                 #INSERT INTO afmq560_x01_tmp VALUES(l_x01_tmp.*) #161104-00024#11 mark
                  #161104-00024#11 --s add
                  INSERT INTO afmq560_x01_tmp(fmmj002,fmmj002_desc,fmmj006,fmmj003,fmmj003_desc,
                                              fmmt002,fmmsdocno,fmmj027,fmms001,fmms002,       
                                              fmmj017,fmmj031,fmmjdocdt,fmmt005,fmmt006,
                                              fmmt007,fmmt010,fmmt014,fmmn003,fmmn005,
                                              fmmn006,l_fmmt010_sum,l_fmmt014_sum)
                  VALUES(l_x01_tmp.fmmj002,l_x01_tmp.fmmj002_desc,l_x01_tmp.fmmj006,l_x01_tmp.fmmj003,l_x01_tmp.fmmj003_desc,
                         l_x01_tmp.fmmt002,l_x01_tmp.fmmsdocno,l_x01_tmp.fmmj027,l_x01_tmp.fmms001,l_x01_tmp.fmms002,         
                         l_x01_tmp.fmmj017,l_x01_tmp.fmmj031,l_x01_tmp.fmmjdocdt,l_x01_tmp.fmmt005,l_x01_tmp.fmmt006,
                         l_x01_tmp.fmmt007,l_x01_tmp.fmmt010,l_x01_tmp.fmmt014,l_x01_tmp.fmmn003,l_x01_tmp.fmmn005,
                         l_x01_tmp.fmmn006,l_x01_tmp.l_fmmt010_sum,l_x01_tmp.l_fmmt014_sum)   
                  #161104-00024#11 --e add
               END FOR               
               CALL afmq560_x01(' 1=1','afmq560_x01_tmp')  #畫面的東西轉成XG報表
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #依畫面資料INSERT XG_tmp 
               DELETE FROM afmq560_x01_tmp
               FOR l_i = 1 TO g_fmmj_d.getLength()
                  INITIALIZE l_x01_tmp.* TO NULL
	               LET l_x01_tmp.fmmj002         = g_fmmj_d[l_i].fmmj002      
                  LET l_x01_tmp.fmmj002_desc    = g_fmmj_d[l_i].fmmj002_desc 
                  LET l_x01_tmp.fmmj006         = g_fmmj_d[l_i].fmmj006      
                  LET l_x01_tmp.fmmj003         = g_fmmj_d[l_i].fmmj003      
                  LET l_x01_tmp.fmmj003_desc    = g_fmmj_d[l_i].fmmj003_desc 
                  LET l_x01_tmp.fmmt002         = g_fmmj_d[l_i].fmmt002
                  LET l_x01_tmp.fmmsdocno       = g_fmmj_d[l_i].fmmsdocno   #140212-00001#38
                  LET l_x01_tmp.fmmj027         = g_fmmj_d[l_i].fmmj027      
                  LET l_x01_tmp.fmms001         = g_fmmj_d[l_i].fmms001      
                  LET l_x01_tmp.fmms002         = g_fmmj_d[l_i].fmms002      
                  LET l_x01_tmp.fmmj017         = g_fmmj_d[l_i].fmmj017      
                  LET l_x01_tmp.fmmj031         = g_fmmj_d[l_i].fmmj031      
                  LET l_x01_tmp.fmmjdocdt       = g_fmmj_d[l_i].fmmjdocdt    
                  LET l_x01_tmp.fmmt005         = g_fmmj_d[l_i].fmmt005      
                  LET l_x01_tmp.fmmt006         = g_fmmj_d[l_i].fmmt006      
                  LET l_x01_tmp.fmmt007         = g_fmmj_d[l_i].fmmt007      
                  LET l_x01_tmp.fmmt010         = g_fmmj_d[l_i].fmmt010      
                  LET l_x01_tmp.fmmt014         = g_fmmj_d[l_i].fmmt014      
                  LET l_x01_tmp.fmmn003         = g_fmmj_d[l_i].fmmn003      
                  LET l_x01_tmp.fmmn005         = g_fmmj_d[l_i].fmmn005      
                  LET l_x01_tmp.fmmn006         = g_fmmj_d[l_i].fmmn006      
                  LET l_x01_tmp.l_fmmt010_sum   = g_fmmj_d[l_i].l_fmmt010_sum
                  LET l_x01_tmp.l_fmmt014_sum   = g_fmmj_d[l_i].l_fmmt014_sum
                 #INSERT INTO afmq560_x01_tmp VALUES(l_x01_tmp.*) #161104-00024#11 mark
                  #161104-00024#11 --s add
                  INSERT INTO afmq560_x01_tmp(fmmj002,fmmj002_desc,fmmj006,fmmj003,fmmj003_desc,
                                              fmmt002,fmmsdocno,fmmj027,fmms001,fmms002,       
                                              fmmj017,fmmj031,fmmjdocdt,fmmt005,fmmt006,
                                              fmmt007,fmmt010,fmmt014,fmmn003,fmmn005,
                                              fmmn006,l_fmmt010_sum,l_fmmt014_sum)
                  VALUES(l_x01_tmp.fmmj002,l_x01_tmp.fmmj002_desc,l_x01_tmp.fmmj006,l_x01_tmp.fmmj003,l_x01_tmp.fmmj003_desc,
                         l_x01_tmp.fmmt002,l_x01_tmp.fmmsdocno,l_x01_tmp.fmmj027,l_x01_tmp.fmms001,l_x01_tmp.fmms002,         
                         l_x01_tmp.fmmj017,l_x01_tmp.fmmj031,l_x01_tmp.fmmjdocdt,l_x01_tmp.fmmt005,l_x01_tmp.fmmt006,
                         l_x01_tmp.fmmt007,l_x01_tmp.fmmt010,l_x01_tmp.fmmt014,l_x01_tmp.fmmn003,l_x01_tmp.fmmn005,
                         l_x01_tmp.fmmn006,l_x01_tmp.l_fmmt010_sum,l_x01_tmp.l_fmmt014_sum)   
                  #161104-00024#11 --e add
               END FOR               
               CALL afmq560_x01(' 1=1','afmq560_x01_tmp')  #畫面的東西轉成XG報表
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
            LET g_input.l_show = 'N'
            CALL s_desc_get_department_desc(g_input.fmmt001) RETURNING g_input.fmmt001_desc
            DISPLAY BY NAME g_input.l_show,g_input.fmmt001_desc            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afmq560.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmq560_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
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
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE fmmj002,'',fmmj006,fmmj003,'','','','','','',fmmj017,fmmj031,fmmjdocdt, 
       '','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY fmmj_t.fmmjdocno) AS RANK FROM fmmj_t", 
 
 
 
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
 
   LET g_sql = "SELECT fmmj002,'',fmmj006,fmmj003,'','','','','','',fmmj017,fmmj031,fmmjdocdt,'','', 
       '','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  fmmj002,   '',       fmmj006,fmmj003,'', ",
               "        fmmt002,   fmmsdocno,fmmj027,  fmms001,fmms002,fmmj017, ",   #140212-00001#38 fmmsdocno
               "        fmmj031,   fmmjdocdt,fmmt005,fmmt006,fmmt007, ",
               "        fmmt010,   fmmt014,  fmmn003,fmmn005,fmmn006, ",
               "        0,         0 ",
               "  FROM (SELECT fmmj002,fmmj006,fmmj003,fmmt002,fmmsdocno,fmmj027, ",   #140212-00001#38 fmmsdocno
               "               fmms001,fmms002,fmmj017,fmmj031,fmmjdocdt, ",
               "               fmmt005,fmmt006,fmmt007,fmmt010,fmmt014, ",
               "               fmmn003,fmmn005,fmmn006, ",
               "               add_months(to_date(fmms001||'/'||fmms002||'/1','yyyy/mm/dd'),1)-1 as l_date",
               "          FROM fmms_t ",
               "          LEFT OUTER JOIN fmmt_t ON fmmsent = fmmtent AND fmmsdocno = fmmtdocno ",
               "          LEFT OUTER JOIN fmmj_t ON fmmtent = fmmjent AND fmmt002 = fmmjdocno ",
               "          LEFT OUTER JOIN fmmn_t ON fmmtent = fmmnent AND fmmsdocno = fmmndocno AND fmmt002 = fmmn001 ",
               "         WHERE fmmsent= ? ",
               "           AND fmmt001 = '",g_input.fmmt001,"'",
               "           AND fmmsstus <> 'X' ) ",
               "WHERE ",g_input.wc,
               "  AND ", ls_wc
   #扣除已平倉資料
   IF g_input.l_show = 'N' THEN
      LET g_sql = g_sql ," AND fmmt002 NOT IN (",
               "     SELECT fmmjdocno FROM (",
               "            SELECT fmmjdocno,(fmmj005-SUM(fmmy003)) as fmmysum",
               "              FROM fmmj_t,fmmy_t",
               "             WHERE fmmjent = fmmyent ",
               "               AND fmmjdocno = fmmy001 ",
               "               AND fmmystus <> 'X' ",
               "               AND fmmjent = ",g_enterprise,
               "               AND fmmjsite = '",g_input.fmmt001,"'",
               "             GROUP BY fmmjdocno,fmmj005)",
               "      WHERE fmmysum = 0)"
   END IF

   LET g_sql = g_sql," ORDER BY fmmt002,fmms001,fmms002"
   ###
   #DISPLAY "SQL:",g_sql
   ###
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmq560_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmq560_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_fmmj_d[l_ac].fmmj002,g_fmmj_d[l_ac].fmmj002_desc,g_fmmj_d[l_ac].fmmj006, 
       g_fmmj_d[l_ac].fmmj003,g_fmmj_d[l_ac].fmmj003_desc,g_fmmj_d[l_ac].fmmt002,g_fmmj_d[l_ac].fmmsdocno, 
       g_fmmj_d[l_ac].fmmj027,g_fmmj_d[l_ac].fmms001,g_fmmj_d[l_ac].fmms002,g_fmmj_d[l_ac].fmmj017,g_fmmj_d[l_ac].fmmj031, 
       g_fmmj_d[l_ac].fmmjdocdt,g_fmmj_d[l_ac].fmmt005,g_fmmj_d[l_ac].fmmt006,g_fmmj_d[l_ac].fmmt007, 
       g_fmmj_d[l_ac].fmmt010,g_fmmj_d[l_ac].fmmt014,g_fmmj_d[l_ac].fmmn003,g_fmmj_d[l_ac].fmmn005,g_fmmj_d[l_ac].fmmn006, 
       g_fmmj_d[l_ac].l_fmmt010_sum,g_fmmj_d[l_ac].l_fmmt014_sum
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
      IF cl_null(g_fmmj_d[l_ac].fmmj017) THEN LET g_fmmj_d[l_ac].fmmj017 = 0 END IF
      IF cl_null(g_fmmj_d[l_ac].fmmj031) THEN LET g_fmmj_d[l_ac].fmmj031 = 0 END IF
      IF cl_null(g_fmmj_d[l_ac].fmmt010) THEN LET g_fmmj_d[l_ac].fmmt010 = 0 END IF
      IF cl_null(g_fmmj_d[l_ac].fmmt014) THEN LET g_fmmj_d[l_ac].fmmt014 = 0 END IF
      IF cl_null(g_fmmj_d[l_ac].fmmn005) THEN LET g_fmmj_d[l_ac].fmmn005 = 0 END IF
      IF cl_null(g_fmmj_d[l_ac].fmmn006) THEN LET g_fmmj_d[l_ac].fmmn006 = 0 END IF
      
      #原幣累計暫估利息
      IF l_ac = 1 THEN
        #LET g_fmmj_d[l_ac].l_fmmt010_sum = g_fmmj_d[l_ac].fmmt010                          #160902-00004#1 mark
         LET g_fmmj_d[l_ac].l_fmmt010_sum = g_fmmj_d[l_ac].fmmt010 - g_fmmj_d[l_ac].fmmn005 #160902-00004#1
      ELSE
         LET g_fmmj_d[l_ac].l_fmmt010_sum = g_fmmj_d[l_ac-1].l_fmmt010_sum + g_fmmj_d[l_ac].fmmt010 - g_fmmj_d[l_ac].fmmn005  #160406-00023#1 add fmmn005
      END IF
      #本幣累計暫估利息
      IF l_ac = 1 THEN
        #LET g_fmmj_d[l_ac].l_fmmt014_sum = g_fmmj_d[l_ac].fmmt014                          #160902-00004#1 mark
         LET g_fmmj_d[l_ac].l_fmmt014_sum = g_fmmj_d[l_ac].fmmt014 - g_fmmj_d[l_ac].fmmn006 #160902-00004#1
      ELSE
         LET g_fmmj_d[l_ac].l_fmmt014_sum = g_fmmj_d[l_ac-1].l_fmmt014_sum + g_fmmj_d[l_ac].fmmt014 - g_fmmj_d[l_ac].fmmn006  #160406-00023#1 add fmmn006
      END IF
      #交易市場名稱
      LET g_fmmj_d[l_ac].fmmj002_desc = s_desc_fmme001_desc(g_fmmj_d[l_ac].fmmj002)
      #投資種類說明
      LET g_fmmj_d[l_ac].fmmj003_desc = s_desc_fmma001_desc(g_fmmj_d[l_ac].fmmj003)
      #end add-point
 
      CALL afmq560_detail_show("'1'")
 
      CALL afmq560_fmmj_t_mask()
 
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
   LET g_tot_cnt = g_fmmj_d.getLength()
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_fmmj_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE afmq560_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afmq560_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afmq560_detail_action_trans()
 
   LET l_ac = 1
   IF g_fmmj_d.getLength() > 0 THEN
      CALL afmq560_b_fill2()
   END IF
 
      CALL afmq560_filter_show('fmmj002','b_fmmj002')
   CALL afmq560_filter_show('fmmj006','b_fmmj006')
   CALL afmq560_filter_show('fmmj003','b_fmmj003')
   CALL afmq560_filter_show('fmmt002','b_fmmt002')
   CALL afmq560_filter_show('fmmsdocno','b_fmmsdocno')
   CALL afmq560_filter_show('fmms001','b_fmms001')
   CALL afmq560_filter_show('fmms002','b_fmms002')
   CALL afmq560_filter_show('fmmj017','b_fmmj017')
   CALL afmq560_filter_show('fmmj031','b_fmmj031')
   CALL afmq560_filter_show('fmmjdocdt','b_fmmjdocdt')
   CALL afmq560_filter_show('fmmt005','b_fmmt005')
   CALL afmq560_filter_show('fmmt006','b_fmmt006')
   CALL afmq560_filter_show('fmmt007','b_fmmt007')
   CALL afmq560_filter_show('fmmt010','b_fmmt010')
   CALL afmq560_filter_show('fmmt014','b_fmmt014')
   CALL afmq560_filter_show('fmmn003','b_fmmn003')
   CALL afmq560_filter_show('fmmn005','b_fmmn005')
   CALL afmq560_filter_show('fmmn006','b_fmmn006')
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmq560.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmq560_b_fill2()
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
 
{<section id="afmq560.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmq560_detail_show(ps_page)
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
 
{<section id="afmq560.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION afmq560_filter()
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
      CONSTRUCT g_wc_filter ON fmmj002,fmmj006,fmmj003,fmmt002,fmmsdocno,fmms001,fmms002,fmmj017,fmmj031, 
          fmmjdocdt,fmmt005,fmmt006,fmmt007,fmmt010,fmmt014,fmmn003,fmmn005,fmmn006
                          FROM s_detail1[1].b_fmmj002,s_detail1[1].b_fmmj006,s_detail1[1].b_fmmj003, 
                              s_detail1[1].b_fmmt002,s_detail1[1].b_fmmsdocno,s_detail1[1].b_fmms001, 
                              s_detail1[1].b_fmms002,s_detail1[1].b_fmmj017,s_detail1[1].b_fmmj031,s_detail1[1].b_fmmjdocdt, 
                              s_detail1[1].b_fmmt005,s_detail1[1].b_fmmt006,s_detail1[1].b_fmmt007,s_detail1[1].b_fmmt010, 
                              s_detail1[1].b_fmmt014,s_detail1[1].b_fmmn003,s_detail1[1].b_fmmn005,s_detail1[1].b_fmmn006 
 
 
         BEFORE CONSTRUCT
                     DISPLAY afmq560_filter_parser('fmmj002') TO s_detail1[1].b_fmmj002
            DISPLAY afmq560_filter_parser('fmmj006') TO s_detail1[1].b_fmmj006
            DISPLAY afmq560_filter_parser('fmmj003') TO s_detail1[1].b_fmmj003
            DISPLAY afmq560_filter_parser('fmmt002') TO s_detail1[1].b_fmmt002
            DISPLAY afmq560_filter_parser('fmmsdocno') TO s_detail1[1].b_fmmsdocno
            DISPLAY afmq560_filter_parser('fmms001') TO s_detail1[1].b_fmms001
            DISPLAY afmq560_filter_parser('fmms002') TO s_detail1[1].b_fmms002
            DISPLAY afmq560_filter_parser('fmmj017') TO s_detail1[1].b_fmmj017
            DISPLAY afmq560_filter_parser('fmmj031') TO s_detail1[1].b_fmmj031
            DISPLAY afmq560_filter_parser('fmmjdocdt') TO s_detail1[1].b_fmmjdocdt
            DISPLAY afmq560_filter_parser('fmmt005') TO s_detail1[1].b_fmmt005
            DISPLAY afmq560_filter_parser('fmmt006') TO s_detail1[1].b_fmmt006
            DISPLAY afmq560_filter_parser('fmmt007') TO s_detail1[1].b_fmmt007
            DISPLAY afmq560_filter_parser('fmmt010') TO s_detail1[1].b_fmmt010
            DISPLAY afmq560_filter_parser('fmmt014') TO s_detail1[1].b_fmmt014
            DISPLAY afmq560_filter_parser('fmmn003') TO s_detail1[1].b_fmmn003
            DISPLAY afmq560_filter_parser('fmmn005') TO s_detail1[1].b_fmmn005
            DISPLAY afmq560_filter_parser('fmmn006') TO s_detail1[1].b_fmmn006
 
 
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
         #----<<b_fmmt002>>----
         #Ctrlp:construct.c.page1.b_fmmt002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmt002
            #add-point:ON ACTION controlp INFIELD b_fmmt002 name="construct.c.filter.page1.b_fmmt002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " fmmjstus = 'Y' "
            CALL q_fmmjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fmmt002  #顯示到畫面上
            NEXT FIELD b_fmmt002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_fmmsdocno>>----
         #Ctrlp:construct.c.page1.b_fmmsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmsdocno
            #add-point:ON ACTION controlp INFIELD b_fmmsdocno name="construct.c.filter.page1.b_fmmsdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmmsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fmmsdocno  #顯示到畫面上
            NEXT FIELD b_fmmsdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<fmmj027>>----
         #----<<b_fmms001>>----
         #Ctrlp:construct.c.filter.page1.b_fmms001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmms001
            #add-point:ON ACTION controlp INFIELD b_fmms001 name="construct.c.filter.page1.b_fmms001"
            
            #END add-point
 
 
         #----<<b_fmms002>>----
         #Ctrlp:construct.c.filter.page1.b_fmms002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmms002
            #add-point:ON ACTION controlp INFIELD b_fmms002 name="construct.c.filter.page1.b_fmms002"
            
            #END add-point
 
 
         #----<<b_fmmj017>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj017
            #add-point:ON ACTION controlp INFIELD b_fmmj017 name="construct.c.filter.page1.b_fmmj017"
            
            #END add-point
 
 
         #----<<b_fmmj031>>----
         #Ctrlp:construct.c.filter.page1.b_fmmj031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmj031
            #add-point:ON ACTION controlp INFIELD b_fmmj031 name="construct.c.filter.page1.b_fmmj031"
            
            #END add-point
 
 
         #----<<b_fmmjdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_fmmjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmjdocdt
            #add-point:ON ACTION controlp INFIELD b_fmmjdocdt name="construct.c.filter.page1.b_fmmjdocdt"
            
            #END add-point
 
 
         #----<<b_fmmt005>>----
         #Ctrlp:construct.c.filter.page1.b_fmmt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmt005
            #add-point:ON ACTION controlp INFIELD b_fmmt005 name="construct.c.filter.page1.b_fmmt005"
            
            #END add-point
 
 
         #----<<b_fmmt006>>----
         #Ctrlp:construct.c.filter.page1.b_fmmt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmt006
            #add-point:ON ACTION controlp INFIELD b_fmmt006 name="construct.c.filter.page1.b_fmmt006"
            
            #END add-point
 
 
         #----<<b_fmmt007>>----
         #Ctrlp:construct.c.filter.page1.b_fmmt007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmt007
            #add-point:ON ACTION controlp INFIELD b_fmmt007 name="construct.c.filter.page1.b_fmmt007"
            
            #END add-point
 
 
         #----<<b_fmmt010>>----
         #Ctrlp:construct.c.filter.page1.b_fmmt010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmt010
            #add-point:ON ACTION controlp INFIELD b_fmmt010 name="construct.c.filter.page1.b_fmmt010"
            
            #END add-point
 
 
         #----<<b_fmmt014>>----
         #Ctrlp:construct.c.filter.page1.b_fmmt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmt014
            #add-point:ON ACTION controlp INFIELD b_fmmt014 name="construct.c.filter.page1.b_fmmt014"
            
            #END add-point
 
 
         #----<<b_fmmn003>>----
         #Ctrlp:construct.c.filter.page1.b_fmmn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmn003
            #add-point:ON ACTION controlp INFIELD b_fmmn003 name="construct.c.filter.page1.b_fmmn003"
            
            #END add-point
 
 
         #----<<b_fmmn005>>----
         #Ctrlp:construct.c.filter.page1.b_fmmn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmn005
            #add-point:ON ACTION controlp INFIELD b_fmmn005 name="construct.c.filter.page1.b_fmmn005"
            
            #END add-point
 
 
         #----<<b_fmmn006>>----
         #Ctrlp:construct.c.filter.page1.b_fmmn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmmn006
            #add-point:ON ACTION controlp INFIELD b_fmmn006 name="construct.c.filter.page1.b_fmmn006"
            
            #END add-point
 
 
         #----<<l_fmmt010_sum>>----
         #----<<l_fmmt014_sum>>----
 
 
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
 
      CALL afmq560_filter_show('fmmj002','b_fmmj002')
   CALL afmq560_filter_show('fmmj006','b_fmmj006')
   CALL afmq560_filter_show('fmmj003','b_fmmj003')
   CALL afmq560_filter_show('fmmt002','b_fmmt002')
   CALL afmq560_filter_show('fmmsdocno','b_fmmsdocno')
   CALL afmq560_filter_show('fmms001','b_fmms001')
   CALL afmq560_filter_show('fmms002','b_fmms002')
   CALL afmq560_filter_show('fmmj017','b_fmmj017')
   CALL afmq560_filter_show('fmmj031','b_fmmj031')
   CALL afmq560_filter_show('fmmjdocdt','b_fmmjdocdt')
   CALL afmq560_filter_show('fmmt005','b_fmmt005')
   CALL afmq560_filter_show('fmmt006','b_fmmt006')
   CALL afmq560_filter_show('fmmt007','b_fmmt007')
   CALL afmq560_filter_show('fmmt010','b_fmmt010')
   CALL afmq560_filter_show('fmmt014','b_fmmt014')
   CALL afmq560_filter_show('fmmn003','b_fmmn003')
   CALL afmq560_filter_show('fmmn005','b_fmmn005')
   CALL afmq560_filter_show('fmmn006','b_fmmn006')
 
 
   CALL afmq560_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq560.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION afmq560_filter_parser(ps_field)
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
 
{<section id="afmq560.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION afmq560_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmq560_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="afmq560.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afmq560_detail_action_trans()
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
 
{<section id="afmq560.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afmq560_detail_index_setting()
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
 
{<section id="afmq560.mask_functions" >}
 &include "erp/afm/afmq560_mask.4gl"
 
{</section>}
 
{<section id="afmq560.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 新增temp table
# Memo...........:
# Usage..........: CALL afmq560_create_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/01/28 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION afmq560_create_tmp()
DEFINE l_session      LIKE type_t.num10 #test

   #查詢session編號
   LET l_session = ''
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   DISPLAY "[afmq560_tmp_session_id] ",l_session

   #XG使用
   DROP TABLE afmq560_x01_tmp;
   #140212-00001#38 add fmmsdocno
   CREATE TEMP TABLE afmq560_x01_tmp(
       fmmj002         LIKE fmmj_t.fmmj002, 
       fmmj002_desc    LIKE type_t.chr500, 
       fmmj006         LIKE fmmj_t.fmmj006, 
       fmmj003         LIKE fmmj_t.fmmj003, 
       fmmj003_desc    LIKE type_t.chr500, 
       fmmt002         LIKE fmmt_t.fmmt002,
       fmmsdocno       LIKE fmms_t.fmmsdocno,       
       fmmj027         LIKE type_t.chr500, 
       fmms001         LIKE fmms_t.fmms001, 
       fmms002         LIKE fmms_t.fmms002, 
       fmmj017         LIKE fmmj_t.fmmj017, 
       fmmj031         LIKE fmmj_t.fmmj031, 
       fmmjdocdt       LIKE fmmj_t.fmmjdocdt, 
       fmmt005         LIKE fmmt_t.fmmt005, 
       fmmt006         LIKE fmmt_t.fmmt006, 
       fmmt007         LIKE fmmt_t.fmmt007, 
       fmmt010         LIKE fmmt_t.fmmt010, 
       fmmt014         LIKE fmmt_t.fmmt014, 
       fmmn003         LIKE fmmn_t.fmmn003, 
       fmmn005         LIKE fmmn_t.fmmn005, 
       fmmn006         LIKE fmmn_t.fmmn006, 
       l_fmmt010_sum   LIKE type_t.num20_6, 
       l_fmmt014_sum   LIKE type_t.num20_6
         )
         
END FUNCTION

 
{</section>}
 
