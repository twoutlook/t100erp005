#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq408.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:11(2015-07-27 18:49:09), PR版次:0011(2016-10-18 09:24:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000125
#+ Filename...: adeq408
#+ Description: 銀行卡及第三方卡對帳差異查詢作業
#+ Creator....: 02749(2014-06-30 19:12:02)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adeq408.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#6   2016/10/18  by 06137       組織類型與職能開窗清單調整
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
PRIVATE TYPE type_g_deaa_d RECORD
       
       sel LIKE type_t.chr1, 
   deaasite LIKE deaa_t.deaasite, 
   deaasite_desc LIKE type_t.chr500, 
   deaadocno LIKE deaa_t.deaadocno, 
   deaaseq LIKE deaa_t.deaaseq, 
   deaaseq1 LIKE deaa_t.deaaseq1, 
   deay003 LIKE deay_t.deay003, 
   deay001 LIKE deay_t.deay001, 
   deay002 LIKE deay_t.deay002, 
   deay002_desc LIKE type_t.chr500, 
   deaa003 LIKE deaa_t.deaa003, 
   deaa012 LIKE deaa_t.deaa012, 
   deaa015 LIKE deaa_t.deaa015, 
   deaa004 LIKE deaa_t.deaa004, 
   deaa005 LIKE deaa_t.deaa005, 
   deaa006 LIKE deaa_t.deaa006, 
   deaa007 LIKE deaa_t.deaa007, 
   deaa008 LIKE deaa_t.deaa008, 
   deaa008_desc LIKE type_t.chr500, 
   deaa009 LIKE deaa_t.deaa009, 
   deaa009_desc LIKE type_t.chr500, 
   deaa010 LIKE deaa_t.deaa010, 
   deaa010_desc LIKE type_t.chr500, 
   deaa011 LIKE deaa_t.deaa011, 
   deaa013 LIKE deaa_t.deaa013, 
   deaa014 LIKE deaa_t.deaa014, 
   deaa016 LIKE deaa_t.deaa016
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_deay_d DYNAMIC ARRAY OF RECORD
   deaysite        LIKE deay_t.deaysite,
   deaysite_desc   LIKE ooefl_t.ooefl003,
   deaydocno       LIKE deay_t.deaydocno,
   deay003         LIKE deay_t.deay003,
   deay001         LIKE deay_t.deay001,
   deay002         LIKE deay_t.deay002,
   deay002_desc    LIKE ooial_t.ooial003,
   deaa003         LIKE deaa_t.deaa003,
   deaa012_sum     LIKE deaa_t.deaa012,
   deaa015_sum     LIKE deaa_t.deaa015,
   deaa004_sum     LIKE deaa_t.deaa004
                END RECORD
                
   DEFINE g_head      RECORD
          deaysite    STRING,
          deay003     STRING,
          deaydocno   STRING,
          deaa003     STRING,
          process_1   LIKE type_t.chr1,
          process_2   LIKE type_t.chr1
                      END RECORD                
#end add-point
 
#模組變數(Module Variables)
DEFINE g_deaa_d            DYNAMIC ARRAY OF type_g_deaa_d
DEFINE g_deaa_d_t          type_g_deaa_d
 
 
 
 
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
 
{<section id="adeq408.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#1  By Ken 150309 
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
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
   DECLARE adeq408_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq408_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq408_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq408 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq408_init()   
 
      #進入選單 Menu (="N")
      CALL adeq408_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq408
      
   END IF 
   
   CLOSE adeq408_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq408.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq408_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_deay001','8310') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   CALL adeq408_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq408.default_search" >}
PRIVATE FUNCTION adeq408_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " deaaseq = '", g_argv[01], "' AND "
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
 
{<section id="adeq408.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq408_ui_dialog() 
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
   
   #end add-point
 
   
   CALL adeq408_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_deaa_d.clear()
 
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
 
         CALL adeq408_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_head.deaa003,g_head.process_1,g_head.process_2
             FROM deaa003,process_1,process_2
             
            BEFORE INPUT
               LET g_head.process_1 = 'N'
               LET g_head.process_2 = 'N'
               DISPLAY g_head.process_1,g_head.process_2 TO process_1,process_2
            
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON deaysite,deay003,deaydocno FROM deaysite,deay003,deaydocno
            BEFORE CONSTRUCT
               DISPLAY g_head.deaysite,g_head.deay003,g_head.deaydocno
                    TO deaysite,deay003,deaydocno
                    
            ON ACTION controlp INFIELD deaysite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaysite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               LET g_head.deaysite = g_qryparam.return1
               DISPLAY BY NAME g_head.deaysite         #顯示到畫面上
               NEXT FIELD deaysite                     #返回原欄位                    

            ON ACTION controlp INFIELD deaydocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_deaydocno()                     #呼叫開窗
               LET g_head.deaydocno = g_qryparam.return1
               DISPLAY g_head.deaydocno TO deaydocno      #顯示到畫面上
               NEXT FIELD deaydocno                  #返回原欄位
               
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_deaa_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL adeq408_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq408_b_fill2()
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
         DISPLAY ARRAY g_deay_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_deay_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL adeq408_b_fill2()
         END DISPLAY               
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq408_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_head.process_1 = 'N'
            LET g_head.process_2 = 'N'
            DISPLAY g_head.process_1,g_head.process_2 TO process_1,process_2
            
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) #sakura add
            CALL cl_set_comp_visible("sel", FALSE)                     #sakura add
            #end add-point
            NEXT FIELD deaysite
 
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
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL adeq408_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_deaa_d)
               LET g_export_id[1]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               #ken---add---s 需求單號：150107-00009 項次：7
               LET g_export_node[1] = base.typeInfo.create(g_deay_d)
               LET g_export_id[1]   = "s_detail3"
               LET g_export_node[2] = base.typeInfo.create(g_deaa_d)
               LET g_export_id[2]   = "s_detail2"
               #ken---add---s               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq408_b_fill()
 
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
            CALL adeq408_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq408_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq408_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq408_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx = 1 TO g_deaa_d.getLength()
               LET g_deaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 0)
            FOR li_idx = 1 TO g_deaa_d.getLength()
               LET g_deaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_deaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail2", li_idx) THEN
                  LET g_deaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_deaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail2", li_idx) THEN
                  LET g_deaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq408_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
 
               EXIT DIALOG #sakura add                               
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
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="adeq408.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq408_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_order_sql     STRING
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #是否只顯示有差異部分
   IF g_head.process_1 = 'Y' THEN
      LET g_wc = g_wc, " AND deaa004 <> 0 "
   END IF
   #是否只顯示有差異且未處理部分
   IF g_head.process_2 = 'Y' THEN
      LET g_wc = g_wc, " AND deaa004 <> 0 AND deaa005 = 'N'"
   END IF
               
   LET l_where = s_aooi500_sql_where(g_prog,'deaysite')
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE
      LET g_wc = g_wc CLIPPED," AND ",l_where
   END IF
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
 
   CALL g_deaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_deay_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',deaasite,'',deaadocno,deaaseq,deaaseq1,'','','','',deaa003,deaa012, 
       deaa015,deaa004,deaa005,deaa006,deaa007,deaa008,'',deaa009,'',deaa010,'',deaa011,deaa013,deaa014, 
       deaa016  ,DENSE_RANK() OVER( ORDER BY deaa_t.deaaseq) AS RANK FROM deaa_t",
 
 
                     "",
                     " WHERE deaaent=? AND deaadocno=? AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deaa_t"),
                     " ORDER BY deaa_t.deaaseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)
   LET ls_sql_rank = "SELECT 'N', ",
               "       deaasite,  ",
               "       (SELECT ooefl003",
               "          FROM ooefl_t",
               "         WHERE ooeflent = deaaent AND ooefl001 = deaasite ",
               "           AND ooefl002 = '",g_dlang,"') deaasite_desc,",
               "       deaadocno,deaaseq,deaaseq1,deay003,deay001,deay002, ",
               "       (SELECT ooial003",
               "          FROM ooial_t",
               "         WHERE ooialent = deayent AND ooial001 = deay002",
               "           AND ooial002 = '",g_dlang,"') deay002_desc,",
               "       deaa003, ",
               "       deaa012,    deaa015,     deaa004,     deaa005, ",
               "       deaa006,    deaa007,     deaa008,",
               "       (SELECT oogd002",
               "          FROM oogd_t",
               "         WHERE oogdent = deaaent  AND oogdsite = deaasite ",
               "           AND oogd001 = deaa008) deaa008_desc,",
               "       deaa009, ",
               "       (SELECT ooag011",
               "          FROM ooag_t",
               "         WHERE ooagent = deaaent  AND ooag001 = deaa009) deaa009_desc,",
               "       deaa010,",
               "       (SELECT pcaal003",
               "          FROM pcaal_t",
               "         WHERE pcaalent = deaaent AND pcaalsite = deaasite ",
               "           AND pcaal001 = deaa010  AND pcaal002 = '",g_dlang,"') deaa010_desc,",
               "       deaa011, deaa013,deaa014, deaa016 ",
               "       ,DENSE_RANK() OVER( ORDER BY deaa_t.deaaseq) AS RANK",
               "  FROM deaa_t,deay_t ",
               " WHERE deaaent = deayent AND deaadocno = deaydocno ",
               "   AND deaaent=? AND ", ls_wc   
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)  

   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deaa_t"), 
               " ORDER BY deaasite,deaadocno,deaaseq"
   #150826-00013#1 效能調整 20150910 add by beckxie---E
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
 
   LET g_sql = "SELECT '',deaasite,'',deaadocno,deaaseq,deaaseq1,'','','','',deaa003,deaa012,deaa015, 
       deaa004,deaa005,deaa006,deaa007,deaa008,'',deaa009,'',deaa010,'',deaa011,deaa013,deaa014,deaa016", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S)   
   #LET l_sql = "SELECT 'N',deaasite,'',deaadocno,deaaseq, deaaseq1, ",
   #            "       deay003,deay001,deay002,'', deaa003, ",
   #            "       deaa012,deaa015,deaa004,deaa005, ",
   #            "       deaa006, deaa007,deaa008,oogd002,deaa009, ",
   #            "       '',deaa010,'', deaa011,deaa013, ",
   #            "       deaa014, deaa016 ",
   #            "  FROM deaa_t LEFT JOIN oogd_t ON oogdent = deaaent AND oogdsite = deaasite AND oogd001 = deaa008 ",
   #            "      ,deay_t", 
   #            " WHERE deaaent = deayent AND deaadocno = deaydocno ",
   #            "   AND deaaent=? AND ", ls_wc   
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E)          
   #150826-00013#1 效能調整 20150910 mark by beckxie---S
   ##150302-00004#8 150312 by lori522612 add 效能調整---(S)
   #LET l_sql = "SELECT 'N', ",
   #            "       deaasite,   t2.ooefl003, deaadocno,   deaaseq,     deaaseq1, ",
   #            "       deay003,    deay001,     deay002,     t5.ooial003, deaa003, ",
   #            "       deaa012,    deaa015,     deaa004,     deaa005, ",
   #            "       deaa006,    deaa007,     deaa008,     t1.oogd002,  deaa009, ",
   #            "       t3.ooag011, deaa010,     t4.pcaal003, deaa011,deaa013, ",
   #            "       deaa014, deaa016 ",
   #            "  FROM deaa_t ",
   #            "       LEFT JOIN oogd_t  t1 ON t1.oogdent = deaaent  AND t1.oogdsite = deaasite AND t1.oogd001 = deaa008 ",
   #            "       LEFT JOIN ooefl_t t2 ON t2.ooeflent = deaaent AND t2.ooefl001 = deaasite AND t2.ooefl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN ooag_t  t3 ON t3.ooagent = deaaent  AND t3.ooag001 = deaa009 ",
   #            "       LEFT JOIN pcaal_t t4 ON t4.pcaalent = deaaent AND t4.pcaalsite = deaasite AND t4.pcaal001 = deaa010  AND t4.pcaal002 = '",g_dlang,"' ",
   #            "      ,deay_t", 
   #            "       LEFT JOIN ooial_t t5 ON t5.ooialent = deayent AND t5.ooial001 = deay002  AND t5.ooial002 = '",g_dlang,"' ",
   #            " WHERE deaaent = deayent AND deaadocno = deaydocno ",
   #            "   AND deaaent=? AND ", ls_wc   
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)  
   #
   #LET l_order_sql = " ORDER BY deaasite,deaadocno,deaaseq"
   #LET g_sql = l_sql,l_order_sql
   #150826-00013#1 效能調整 20150910 mark by beckxie---E
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   LET g_sql = "SELECT    'N',deaasite,deaasite_desc,   deaadocno,deaaseq,",
               "     deaaseq1, deay003,      deay001,     deay002,deay002_desc,",
               "      deaa003, deaa012,      deaa015,     deaa004,deaa005,",
               "      deaa006, deaa007,      deaa008,deaa008_desc,deaa009,",
               " deaa009_desc, deaa010, deaa010_desc,     deaa011,deaa013,",
               "      deaa014, deaa016", 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150910 add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq408_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq408_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_deaa_d[l_ac].sel,g_deaa_d[l_ac].deaasite,g_deaa_d[l_ac].deaasite_desc, 
       g_deaa_d[l_ac].deaadocno,g_deaa_d[l_ac].deaaseq,g_deaa_d[l_ac].deaaseq1,g_deaa_d[l_ac].deay003, 
       g_deaa_d[l_ac].deay001,g_deaa_d[l_ac].deay002,g_deaa_d[l_ac].deay002_desc,g_deaa_d[l_ac].deaa003, 
       g_deaa_d[l_ac].deaa012,g_deaa_d[l_ac].deaa015,g_deaa_d[l_ac].deaa004,g_deaa_d[l_ac].deaa005,g_deaa_d[l_ac].deaa006, 
       g_deaa_d[l_ac].deaa007,g_deaa_d[l_ac].deaa008,g_deaa_d[l_ac].deaa008_desc,g_deaa_d[l_ac].deaa009, 
       g_deaa_d[l_ac].deaa009_desc,g_deaa_d[l_ac].deaa010,g_deaa_d[l_ac].deaa010_desc,g_deaa_d[l_ac].deaa011, 
       g_deaa_d[l_ac].deaa013,g_deaa_d[l_ac].deaa014,g_deaa_d[l_ac].deaa016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adeq408_detail_show("'1'")
 
      CALL adeq408_deaa_t_mask()
 
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
   LET l_ac = 1
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S)  
   #LET g_sql = "SELECT deaasite,deaadocno,deay003,deay001,deay002, ",
   #            "       deaa003,SUM(deaa012),SUM(deaa015),SUM(deaa004) ",
   #            "  FROM (",l_sql,") ",
   #            " GROUP BY deaasite,deaadocno,deay003,deay001,deay002,deaa003 ",
   #            " ORDER BY deaasite,deaadocno "    
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E)  
   
   LET l_sql=g_sql  #150826-00013#1 效能調整 20150910 add by beckxie
   
   #150826-00013#1 效能調整 20150910 mark by beckxie---S
   ##150302-00004#8 150312 by lori522612 add 效能調整---(S)  
   #LET g_sql = "SELECT deaasite,deaadocno,   deay003,     deay001,     deay002, ",
   #            "       deaa003, SUM(deaa012),SUM(deaa015),SUM(deaa004),ooefl003, ",
   #            "       ooial003 ",
   #            "  FROM (",l_sql,") ",
   #            " GROUP BY deaasite,deaadocno,deay003,deay001,deay002, ",
   #            "          deaa003, ooefl003, ooial003 ",
   #            " ORDER BY deaasite,deaadocno "    
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)  
   #150826-00013#1 效能調整 20150910 mark by beckxie---E
   
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)  
   LET g_sql = "SELECT deaasite,deaadocno,   deay003,     deay001,     deay002, ",
               "       deaa003, SUM(deaa012),SUM(deaa015),SUM(deaa004),deaasite_desc, ",
               "       deay002_desc ",
               "  FROM (",l_sql,") ",
               " GROUP BY deaasite,deaadocno,deay003,deay001,deay002, ",
               "          deaa003, deaasite_desc, deay002_desc ",
               " ORDER BY deaasite,deaadocno "    
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)  
   #150826-00013#1 效能調整 20150910 add by beckxie---E
   
   PREPARE adeq408_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR adeq408_pb1
 
   OPEN b_fill_curs1 USING g_enterprise
   FOREACH b_fill_curs1 INTO g_deay_d[l_ac].deaysite,g_deay_d[l_ac].deaydocno,g_deay_d[l_ac].deay003,
                             g_deay_d[l_ac].deay001,g_deay_d[l_ac].deay002,g_deay_d[l_ac].deaa003,
                             g_deay_d[l_ac].deaa012_sum,g_deay_d[l_ac].deaa015_sum,g_deay_d[l_ac].deaa004_sum,
                             g_deay_d[l_ac].deaysite_desc,g_deay_d[l_ac].deay002_desc                           #150302-00004#8 150312 by lori522612 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL adeq408_detail_show("'2'")
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF   
   END FOREACH                
   #end add-point
 
   CALL g_deaa_d.deleteElement(g_deaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL g_deay_d.deleteElement(g_deay_d.getLength())  
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_deaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq408_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq408_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq408_detail_action_trans()
 
   LET l_ac = 1
   IF g_deaa_d.getLength() > 0 THEN
      CALL adeq408_b_fill2()
   END IF
 
      CALL adeq408_filter_show('deaasite','b_deaasite')
   CALL adeq408_filter_show('deaadocno','b_deaadocno')
   CALL adeq408_filter_show('deaaseq','b_deaaseq')
   CALL adeq408_filter_show('deaaseq1','b_deaaseq1')
   CALL adeq408_filter_show('deay003','b_deay003')
   CALL adeq408_filter_show('deay001','b_deay001')
   CALL adeq408_filter_show('deay002','b_deay002')
   CALL adeq408_filter_show('deaa003','b_deaa003')
   CALL adeq408_filter_show('deaa012','b_deaa012')
   CALL adeq408_filter_show('deaa015','b_deaa015')
   CALL adeq408_filter_show('deaa004','b_deaa004')
   CALL adeq408_filter_show('deaa005','b_deaa005')
   CALL adeq408_filter_show('deaa006','b_deaa006')
   CALL adeq408_filter_show('deaa007','b_deaa007')
   CALL adeq408_filter_show('deaa008','b_deaa008')
   CALL adeq408_filter_show('deaa009','b_deaa009')
   CALL adeq408_filter_show('deaa010','b_deaa010')
   CALL adeq408_filter_show('deaa011','b_deaa011')
   CALL adeq408_filter_show('deaa013','b_deaa013')
   CALL adeq408_filter_show('deaa014','b_deaa014')
   CALL adeq408_filter_show('deaa016','b_deaa016')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq408.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq408_b_fill2()
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
 
{<section id="adeq408.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq408_detail_show(ps_page)
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
      #150302-00004#8 150312 by lori522612 mark---(S)  
      ##營運組織
      #LET g_deaa_d[l_ac].deaasite_desc = s_desc_get_department_desc(g_deaa_d[l_ac].deaasite)
      #DISPLAY BY NAME g_deaa_d[l_ac].deaasite_desc
      ##款別
      #LET g_deaa_d[l_ac].deay002_desc = s_desc_get_ooial_desc(g_deaa_d[l_ac].deay002)
      #DISPLAY BY NAME g_deaa_d[l_ac].deay002_desc    
      ##收銀員
      #LET g_deaa_d[l_ac].deaa009_desc = s_desc_get_person_desc(g_deaa_d[l_ac].deaa009)
      #DISPLAY BY NAME g_deaa_d[l_ac].deaa009_desc      
      ##收銀機
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_deaa_d[l_ac].deaa010
      #CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_deaa_d[l_ac].deaa010_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_deaa_d[l_ac].deaa010_desc  
      #150302-00004#8 150312 by lori522612 mark---(E)        
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #150302-00004#8 150312 by lori522612 mark---(S)  
      ##營運組織
      #LET g_deay_d[l_ac].deaysite_desc = s_desc_get_department_desc(g_deay_d[l_ac].deaysite)
      #DISPLAY BY NAME g_deay_d[l_ac].deaysite_desc
      ##款別
      #LET g_deay_d[l_ac].deay002_desc = s_desc_get_ooial_desc(g_deay_d[l_ac].deay002)
      #DISPLAY BY NAME g_deay_d[l_ac].deay002_desc  
      #150302-00004#8 150312 by lori522612 mark---(E)        
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq408.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq408_filter()
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
      CONSTRUCT g_wc_filter ON deaasite,deaadocno,deaaseq,deaaseq1,deay003,deay001,deay002,deaa003,deaa012, 
          deaa015,deaa004,deaa005,deaa006,deaa007,deaa008,deaa009,deaa010,deaa011,deaa013,deaa014,deaa016 
 
                          FROM s_detail2[1].b_deaasite,s_detail2[1].b_deaadocno,s_detail2[1].b_deaaseq, 
                              s_detail2[1].b_deaaseq1,s_detail2[1].b_deay003,s_detail2[1].b_deay001, 
                              s_detail2[1].b_deay002,s_detail2[1].b_deaa003,s_detail2[1].b_deaa012,s_detail2[1].b_deaa015, 
                              s_detail2[1].b_deaa004,s_detail2[1].b_deaa005,s_detail2[1].b_deaa006,s_detail2[1].b_deaa007, 
                              s_detail2[1].b_deaa008,s_detail2[1].b_deaa009,s_detail2[1].b_deaa010,s_detail2[1].b_deaa011, 
                              s_detail2[1].b_deaa013,s_detail2[1].b_deaa014,s_detail2[1].b_deaa016
 
         BEFORE CONSTRUCT
                     DISPLAY adeq408_filter_parser('deaasite') TO s_detail2[1].b_deaasite
            DISPLAY adeq408_filter_parser('deaadocno') TO s_detail2[1].b_deaadocno
            DISPLAY adeq408_filter_parser('deaaseq') TO s_detail2[1].b_deaaseq
            DISPLAY adeq408_filter_parser('deaaseq1') TO s_detail2[1].b_deaaseq1
            DISPLAY adeq408_filter_parser('deay003') TO s_detail2[1].b_deay003
            DISPLAY adeq408_filter_parser('deay001') TO s_detail2[1].b_deay001
            DISPLAY adeq408_filter_parser('deay002') TO s_detail2[1].b_deay002
            DISPLAY adeq408_filter_parser('deaa003') TO s_detail2[1].b_deaa003
            DISPLAY adeq408_filter_parser('deaa012') TO s_detail2[1].b_deaa012
            DISPLAY adeq408_filter_parser('deaa015') TO s_detail2[1].b_deaa015
            DISPLAY adeq408_filter_parser('deaa004') TO s_detail2[1].b_deaa004
            DISPLAY adeq408_filter_parser('deaa005') TO s_detail2[1].b_deaa005
            DISPLAY adeq408_filter_parser('deaa006') TO s_detail2[1].b_deaa006
            DISPLAY adeq408_filter_parser('deaa007') TO s_detail2[1].b_deaa007
            DISPLAY adeq408_filter_parser('deaa008') TO s_detail2[1].b_deaa008
            DISPLAY adeq408_filter_parser('deaa009') TO s_detail2[1].b_deaa009
            DISPLAY adeq408_filter_parser('deaa010') TO s_detail2[1].b_deaa010
            DISPLAY adeq408_filter_parser('deaa011') TO s_detail2[1].b_deaa011
            DISPLAY adeq408_filter_parser('deaa013') TO s_detail2[1].b_deaa013
            DISPLAY adeq408_filter_parser('deaa014') TO s_detail2[1].b_deaa014
            DISPLAY adeq408_filter_parser('deaa016') TO s_detail2[1].b_deaa016
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_deaasite>>----
         #Ctrlp:construct.c.filter.page2.b_deaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaasite
            #add-point:ON ACTION controlp INFIELD b_deaasite name="construct.c.filter.page2.b_deaasite"
            #161006-00008#6 Add By Ken 161018(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaysite',g_site,'c') 
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_deaasite  #顯示到畫面上
            NEXT FIELD b_deaasite                     #返回原欄位    
            #161006-00008#6 Add By Ken 161018(E)
            #END add-point
 
 
         #----<<b_deaasite_desc>>----
         #----<<b_deaadocno>>----
         #Ctrlp:construct.c.filter.page2.b_deaadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaadocno
            #add-point:ON ACTION controlp INFIELD b_deaadocno name="construct.c.filter.page2.b_deaadocno"
            
            #END add-point
 
 
         #----<<b_deaaseq>>----
         #Ctrlp:construct.c.filter.page2.b_deaaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaaseq
            #add-point:ON ACTION controlp INFIELD b_deaaseq name="construct.c.filter.page2.b_deaaseq"
            
            #END add-point
 
 
         #----<<b_deaaseq1>>----
         #Ctrlp:construct.c.filter.page2.b_deaaseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaaseq1
            #add-point:ON ACTION controlp INFIELD b_deaaseq1 name="construct.c.filter.page2.b_deaaseq1"
            
            #END add-point
 
 
         #----<<b_deay003>>----
         #Ctrlp:construct.c.filter.page2.b_deay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deay003
            #add-point:ON ACTION controlp INFIELD b_deay003 name="construct.c.filter.page2.b_deay003"
            
            #END add-point
 
 
         #----<<b_deay001>>----
         #Ctrlp:construct.c.filter.page2.b_deay001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deay001
            #add-point:ON ACTION controlp INFIELD b_deay001 name="construct.c.filter.page2.b_deay001"
            
            #END add-point
 
 
         #----<<b_deay002>>----
         #Ctrlp:construct.c.filter.page2.b_deay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deay002
            #add-point:ON ACTION controlp INFIELD b_deay002 name="construct.c.filter.page2.b_deay002"
            
            #END add-point
 
 
         #----<<b_deay002_desc>>----
         #----<<b_deaa003>>----
         #Ctrlp:construct.c.filter.page2.b_deaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa003
            #add-point:ON ACTION controlp INFIELD b_deaa003 name="construct.c.filter.page2.b_deaa003"
            
            #END add-point
 
 
         #----<<b_deaa012>>----
         #Ctrlp:construct.c.filter.page2.b_deaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa012
            #add-point:ON ACTION controlp INFIELD b_deaa012 name="construct.c.filter.page2.b_deaa012"
            
            #END add-point
 
 
         #----<<b_deaa015>>----
         #Ctrlp:construct.c.filter.page2.b_deaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa015
            #add-point:ON ACTION controlp INFIELD b_deaa015 name="construct.c.filter.page2.b_deaa015"
            
            #END add-point
 
 
         #----<<b_deaa004>>----
         #Ctrlp:construct.c.filter.page2.b_deaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa004
            #add-point:ON ACTION controlp INFIELD b_deaa004 name="construct.c.filter.page2.b_deaa004"
            
            #END add-point
 
 
         #----<<b_deaa005>>----
         #Ctrlp:construct.c.filter.page2.b_deaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa005
            #add-point:ON ACTION controlp INFIELD b_deaa005 name="construct.c.filter.page2.b_deaa005"
            
            #END add-point
 
 
         #----<<b_deaa006>>----
         #Ctrlp:construct.c.filter.page2.b_deaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa006
            #add-point:ON ACTION controlp INFIELD b_deaa006 name="construct.c.filter.page2.b_deaa006"
            
            #END add-point
 
 
         #----<<b_deaa007>>----
         #Ctrlp:construct.c.filter.page2.b_deaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa007
            #add-point:ON ACTION controlp INFIELD b_deaa007 name="construct.c.filter.page2.b_deaa007"
            
            #END add-point
 
 
         #----<<b_deaa008>>----
         #Ctrlp:construct.c.filter.page2.b_deaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa008
            #add-point:ON ACTION controlp INFIELD b_deaa008 name="construct.c.filter.page2.b_deaa008"
            
            #END add-point
 
 
         #----<<b_deaa008_desc>>----
         #----<<b_deaa009>>----
         #Ctrlp:construct.c.filter.page2.b_deaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa009
            #add-point:ON ACTION controlp INFIELD b_deaa009 name="construct.c.filter.page2.b_deaa009"
            
            #END add-point
 
 
         #----<<b_deaa009_desc>>----
         #----<<b_deaa010>>----
         #Ctrlp:construct.c.filter.page2.b_deaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa010
            #add-point:ON ACTION controlp INFIELD b_deaa010 name="construct.c.filter.page2.b_deaa010"
            
            #END add-point
 
 
         #----<<b_deaa010_desc>>----
         #----<<b_deaa011>>----
         #Ctrlp:construct.c.filter.page2.b_deaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa011
            #add-point:ON ACTION controlp INFIELD b_deaa011 name="construct.c.filter.page2.b_deaa011"
            
            #END add-point
 
 
         #----<<b_deaa013>>----
         #Ctrlp:construct.c.filter.page2.b_deaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa013
            #add-point:ON ACTION controlp INFIELD b_deaa013 name="construct.c.filter.page2.b_deaa013"
            
            #END add-point
 
 
         #----<<b_deaa014>>----
         #Ctrlp:construct.c.filter.page2.b_deaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa014
            #add-point:ON ACTION controlp INFIELD b_deaa014 name="construct.c.filter.page2.b_deaa014"
            
            #END add-point
 
 
         #----<<b_deaa016>>----
         #Ctrlp:construct.c.filter.page2.b_deaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deaa016
            #add-point:ON ACTION controlp INFIELD b_deaa016 name="construct.c.filter.page2.b_deaa016"
            
            #END add-point
 
 
 
 
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
 
      CALL adeq408_filter_show('deaasite','b_deaasite')
   CALL adeq408_filter_show('deaadocno','b_deaadocno')
   CALL adeq408_filter_show('deaaseq','b_deaaseq')
   CALL adeq408_filter_show('deaaseq1','b_deaaseq1')
   CALL adeq408_filter_show('deay003','b_deay003')
   CALL adeq408_filter_show('deay001','b_deay001')
   CALL adeq408_filter_show('deay002','b_deay002')
   CALL adeq408_filter_show('deaa003','b_deaa003')
   CALL adeq408_filter_show('deaa012','b_deaa012')
   CALL adeq408_filter_show('deaa015','b_deaa015')
   CALL adeq408_filter_show('deaa004','b_deaa004')
   CALL adeq408_filter_show('deaa005','b_deaa005')
   CALL adeq408_filter_show('deaa006','b_deaa006')
   CALL adeq408_filter_show('deaa007','b_deaa007')
   CALL adeq408_filter_show('deaa008','b_deaa008')
   CALL adeq408_filter_show('deaa009','b_deaa009')
   CALL adeq408_filter_show('deaa010','b_deaa010')
   CALL adeq408_filter_show('deaa011','b_deaa011')
   CALL adeq408_filter_show('deaa013','b_deaa013')
   CALL adeq408_filter_show('deaa014','b_deaa014')
   CALL adeq408_filter_show('deaa016','b_deaa016')
 
 
   CALL adeq408_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq408.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq408_filter_parser(ps_field)
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
 
{<section id="adeq408.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq408_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq408_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq408.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq408_detail_action_trans()
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
 
{<section id="adeq408.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq408_detail_index_setting()
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
            IF g_deaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_deaa_d.getLength() AND g_deaa_d.getLength() > 0
            LET g_detail_idx = g_deaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_deaa_d.getLength() THEN
               LET g_detail_idx = g_deaa_d.getLength()
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
 
{<section id="adeq408.mask_functions" >}
 &include "erp/ade/adeq408_mask.4gl"
 
{</section>}
 
{<section id="adeq408.other_function" readonly="Y" >}

 
{</section>}
 
