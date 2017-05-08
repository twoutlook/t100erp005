#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq538.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2017-01-31 14:27:58), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axcq538
#+ Description: 先進先出拆件式工單成本歷程明細查詢作業
#+ Creator....: 05423(2017-01-26 23:03:43)
#+ Modifier...: 05423 -SD/PR- 00000
 
{</section>}
 
{<section id="axcq538.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"

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
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       xcchcomp LIKE type_t.chr10, 
   xcchcomp_desc LIKE type_t.chr80, 
   xcchld LIKE type_t.chr5, 
   xcchld_desc LIKE type_t.chr80, 
   xcch003 LIKE type_t.chr10, 
   xcch003_desc LIKE type_t.chr80, 
   xcch004 LIKE type_t.num5, 
   xcch005 LIKE type_t.num5, 
   xcch006 LIKE type_t.chr20, 
   xcch007 LIKE type_t.chr500, 
   xcch007_desc LIKE type_t.chr80, 
   xcch007_desc_desc LIKE type_t.chr80, 
   imaa006 LIKE type_t.chr500, 
   xcch009 LIKE type_t.chr30, 
   xcch002 LIKE type_t.chr30
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       l_item LIKE type_t.chr500, 
   xcch101 LIKE xcch_t.xcch101, 
   xcch201 LIKE xcch_t.xcch201, 
   xcch204 LIKE xcch_t.xcch204, 
   xcch301 LIKE xcch_t.xcch301, 
   xcch303 LIKE xcch_t.xcch303, 
   xcch901 LIKE xcch_t.xcch901
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_detail_d RECORD
       xcck013 LIKE xcck_t.xcck013, #单据日期
       xcck006 LIKE xcck_t.xcck006, #参考单号
       xcck007 LIKE xcck_t.xcck007, #项次
       xcck008 LIKE xcck_t.xcck008, #项序 
       xcck010 LIKE xcck_t.xcck010, #元件料號
       xcck010_desc  LIKE imaal_t.imaal003,  #品名
       xcck010_desc_desc  LIKE imaal_t.imaal004,  #規格
       xcck011 LIKE xcck_t.xcck011, #產品特徵
       xcck201 LIKE xcck_t.xcck201, #本期异动数量
       xcck282 LIKE xcck_t.xcck282, #本期异动单价
       xcck282a LIKE xcck_t.xcck282a, #本期异动单价-材料
       xcck282b LIKE xcck_t.xcck282b, #本期异动单价-人工
       xcck282c LIKE xcck_t.xcck282c, #本期异动单价-加工
       xcck282d LIKE xcck_t.xcck282d, #本期异动单价-制费一
       xcck282e LIKE xcck_t.xcck282e, #本期异动单价-制费二
       xcck282f LIKE xcck_t.xcck282f, #本期异动单价-制费三
       xcck282g LIKE xcck_t.xcck282g, #本期异动单价-制费四
       xcck282h LIKE xcck_t.xcck282h, #本期异动单价-制费五
       xcck202 LIKE xcck_t.xcck202, #本期异动金额
       xcck202a LIKE xcck_t.xcck202a, #本期异动金额-材料
       xcck202b LIKE xcck_t.xcck202b, #本期异动金额-人工
       xcck202c LIKE xcck_t.xcck202c, #本期异动金额-加工费
       xcck202d LIKE xcck_t.xcck202d, #本期异动金额-制费一
       xcck202e LIKE xcck_t.xcck202e, #本期异动金额-制费二
       xcck202f LIKE xcck_t.xcck202f, #本期异动金额-制费三
       xcck202g LIKE xcck_t.xcck202g, #本期异动金额-制费四
       xcck202h LIKE xcck_t.xcck202h  #本期异动金额-制费五
END RECORD
PRIVATE TYPE type_g_detail2_d RECORD
       xcck013 LIKE xcck_t.xcck013, #单据日期
       xcck006 LIKE xcck_t.xcck006, #参考单号
       xcck007 LIKE xcck_t.xcck007, #项次
       xcck008 LIKE xcck_t.xcck008, #项序 
       xcck010 LIKE xcck_t.xcck010, #元件料號
       xcck010_desc  LIKE imaal_t.imaal003,  #品名
       xcck010_desc_desc  LIKE imaal_t.imaal004,  #規格
       xcck011 LIKE xcck_t.xcck011, #產品特徵
       xcck201 LIKE xcck_t.xcck201, #本期异动数量
       xcck282 LIKE xcck_t.xcck282, #本期异动单价
       xcck282a LIKE xcck_t.xcck282a, #本期异动单价-材料
       xcck282b LIKE xcck_t.xcck282b, #本期异动单价-人工
       xcck282c LIKE xcck_t.xcck282c, #本期异动单价-加工
       xcck282d LIKE xcck_t.xcck282d, #本期异动单价-制费一
       xcck282e LIKE xcck_t.xcck282e, #本期异动单价-制费二
       xcck282f LIKE xcck_t.xcck282f, #本期异动单价-制费三
       xcck282g LIKE xcck_t.xcck282g, #本期异动单价-制费四
       xcck282h LIKE xcck_t.xcck282h, #本期异动单价-制费五
       xcck202 LIKE xcck_t.xcck202, #本期异动金额
       xcck202a LIKE xcck_t.xcck202a, #本期异动金额-材料
       xcck202b LIKE xcck_t.xcck202b, #本期异动金额-人工
       xcck202c LIKE xcck_t.xcck202c, #本期异动金额-加工费
       xcck202d LIKE xcck_t.xcck202d, #本期异动金额-制费一
       xcck202e LIKE xcck_t.xcck202e, #本期异动金额-制费二
       xcck202f LIKE xcck_t.xcck202f, #本期异动金额-制费三
       xcck202g LIKE xcck_t.xcck202g, #本期异动金额-制费四
       xcck202h LIKE xcck_t.xcck202h  #本期异动金额-制费五
END RECORD
DEFINE g_wc_cs_comp          STRING
DEFINE g_wc_cs_ld            STRING
DEFINE g_bdate      LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE g_edate      LIKE glav_t.glav004
DEFINE g_glaa003    LIKE glaa_t.glaa003
DEFINE g_imaal003 LIKE imaal_t.imaal003
DEFINE g_imaal004 LIKE imaal_t.imaal004
DEFINE g_xcchcomp_desc LIKE type_t.chr80
DEFINE g_xcchld_desc LIKE type_t.chr80
DEFINE g_xcch003_desc LIKE type_t.chr80
DEFINE g_detail_d       DYNAMIC ARRAY OF type_g_detail_d
DEFINE g_detail2_d      DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail3_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
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
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
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
 
{<section id="axcq538.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
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
   DECLARE axcq538_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq538_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq538_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq538 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq538_init()   
 
      #進入選單 Menu (="N")
      CALL axcq538_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq538
      
   END IF 
   
   CLOSE axcq538_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq538.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq538_init()
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
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_comp_required("xcchcomp,xcchld,xcch003,xcch004,xcch005",FALSE)
   #end add-point
 
   CALL axcq538_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq538.default_search" >}
PRIVATE FUNCTION axcq538_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF 
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc," AND xcha006 = '",g_argv[01],"'"      
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq538.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq538_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CLEAR FORM  
 
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
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axcq538_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axcq538_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq538_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq538_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               CALL axcq538_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq538_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
         DISPLAY ARRAY g_detail2_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
 
         END DISPLAY
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axcq538_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
{
            #end add-point
            NEXT FIELD xcchent
 
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
}
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
            #end add-point
 
            CALL axcq538_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq538_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
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
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"
            
            #end add-point
            CALL axcq538_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq538_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq538_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq538_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq538_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq538_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axcq538_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axcq538_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axcq538_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axcq538_b_fill()
 
         
         
         
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
               CALL axcq538_cs()
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
 
{<section id="axcq538.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axcq538_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   CALL axcq538_query()
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      LET g_sql = "SELECT xcchcomp,xcchld,xcch003,xcch004,xcch005,xcch006,xcch007,xcch009,xcch002",
                  "  FROM xcch_t LEFT JOIN imaa_t ON imaaent = xcchent AND imaa001 = xcch007 ",
                  " WHERE xcchent = ",g_enterprise," AND ",g_wc
      IF NOT cl_null(g_master.xcchcomp) THEN
         LET g_sql = g_sql CLIPPED," AND xcchcomp = '",g_master.xcchcomp,"' "
      END IF
      IF NOT cl_null(g_master.xcchld) THEN
         LET g_sql = g_sql CLIPPED," AND xcchld = '",g_master.xcchld,"' "
      END IF
      IF NOT cl_null(g_master.xcch003) THEN
         LET g_sql = g_sql CLIPPED," AND xcch003 = '",g_master.xcch003,"' "
      END IF
      IF NOT cl_null(g_master.xcch004) AND g_master.xcch004<>0 THEN
         LET g_sql = g_sql CLIPPED," AND xcch004 = '",g_master.xcch004,"' "
      END IF
      IF NOT cl_null(g_master.xcch005) AND g_master.xcch005<>0 THEN
         LET g_sql = g_sql CLIPPED," AND xcch005 = '",g_master.xcch005,"' "
      END IF
      
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE axcq538_pre FROM g_sql
   DECLARE axcq538_curs SCROLL CURSOR WITH HOLD FOR axcq538_pre
   OPEN axcq538_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = "SELECT COUNT(*) FROM (",g_sql,")"
   #end add-point
   PREPARE axcq538_precount FROM g_cnt_sql
   EXECUTE axcq538_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axcq538_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcq538.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axcq538_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   CASE p_flag
        WHEN 'N' FETCH NEXT     axcq538_curs INTO g_master.xcchcomp,g_master.xcchld,g_master.xcch003,g_master.xcch004,g_master.xcch005,g_master.xcch006,g_master.xcch007,g_master.xcch009,g_master.xcch002
        WHEN 'P' FETCH PREVIOUS axcq538_curs INTO g_master.xcchcomp,g_master.xcchld,g_master.xcch003,g_master.xcch004,g_master.xcch005,g_master.xcch006,g_master.xcch007,g_master.xcch009,g_master.xcch002
        WHEN 'F' FETCH FIRST    axcq538_curs INTO g_master.xcchcomp,g_master.xcchld,g_master.xcch003,g_master.xcch004,g_master.xcch005,g_master.xcch006,g_master.xcch007,g_master.xcch009,g_master.xcch002
        WHEN 'L' FETCH LAST     axcq538_curs INTO g_master.xcchcomp,g_master.xcchld,g_master.xcch003,g_master.xcch004,g_master.xcch005,g_master.xcch006,g_master.xcch007,g_master.xcch009,g_master.xcch002
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
             
             IF g_jump > 0 AND g_jump <= g_row_count THEN
                 LET g_current_idx = g_jump
             END IF
             LET g_no_ask = FALSE  

            FETCH ABSOLUTE g_jump axcq538_curs INTO g_master.xcchcomp,g_master.xcchld,g_master.xcch003,g_master.xcch004,g_master.xcch005,g_master.xcch006,g_master.xcch007,g_master.xcch009,g_master.xcch002
            
    END CASE
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO xcchcomp,xcchcomp_desc,xcchld,xcchld_desc,xcch003,xcch003_desc,xcch004,xcch005, 
          xcch006,xcch007,xcch007_desc,xcch007_desc_desc,imaa006,xcch009,xcch002
      CALL g_detail.clear()
 
      #add-point:陣列清空 name="fetch.array_clear"
      DISPLAY '' TO xcchcomp_desc
      DISPLAY '' TO xcchld_desc
      DISPLAY '' TO xcch003_desc
      DISPLAY '' TO xcch007_desc
      DISPLAY '' TO xcch007_desc_desc
      CALL g_detail_d.clear()
      CALL g_detail2_d.clear()
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axcq538_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq538.show" >}
PRIVATE FUNCTION axcq538_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO xcchcomp,xcchcomp_desc,xcchld,xcchld_desc,xcch003,xcch003_desc,xcch004,xcch005, 
       xcch006,xcch007,xcch007_desc,xcch007_desc_desc,imaa006,xcch009,xcch002
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcchcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcchcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_xcchcomp_desc TO xcchcomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcchld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcchld_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_xcchld_desc TO xcchld_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcch003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcch003_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_xcch003_desc TO xcch003_desc
   
   IF NOT cl_null(g_master.xcch007) THEN
      SELECT imaal003,imaal004 INTO g_imaal003,g_imaal004
        FROM imaal_t WHERE imaalent = g_enterprise
         AND imaal001 = g_master.xcch007
         AND imaal002 = g_dlang
      DISPLAY g_imaal003 TO xcch007_desc
      DISPLAY g_imaal004 TO xcch007_desc_desc
   END IF
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axcq538_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq538.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq538_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xcck202 LIKE xcck_t.xcck202   #本期异动金额
   DEFINE l_xcck202a LIKE xcck_t.xcck202a #本期异动金额-材料
   DEFINE l_xcck202b LIKE xcck_t.xcck202b #本期异动金额-人工
   DEFINE l_xcck202c LIKE xcck_t.xcck202c #本期异动金额-加工费
   DEFINE l_xcck202d LIKE xcck_t.xcck202d #本期异动金额-制费一
   DEFINE l_xcck202e LIKE xcck_t.xcck202e #本期异动金额-制费二
   DEFINE l_xcck202f LIKE xcck_t.xcck202f #本期异动金额-制费三
   DEFINE l_xcck202g LIKE xcck_t.xcck202g #本期异动金额-制费四
   DEFINE l_xcck202h LIKE xcck_t.xcck202h #本期异动金额-制费五
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET g_sql = "SELECT xcch101,xcch201,'',xcch301,xcch303,xcch901,",
               "       xcch102,xcch202,xcch204,xcch302,xcch304,xcch902",
               "  FROM xcch_t ",
               " WHERE xcchent = ",g_enterprise,
               "   AND xcchld = '",g_master.xcchld,"' AND xcch001 = '1'",
               "   AND xcch002 = '",g_master.xcch002,"' AND xcch003 = '",g_master.xcch003,"'",
               "   AND xcch004 = ",g_master.xcch004," AND xcch005 = ",g_master.xcch005,
               "   AND xcch006 = '",g_master.xcch006,"'"               
                              
   PREPARE axcq538_b_fill_prep FROM g_sql
   EXECUTE axcq538_b_fill_prep INTO g_detail[1].xcch101,g_detail[1].xcch201,  g_detail[1].xcch204,g_detail[1].xcch301,g_detail[1].xcch303,g_detail[1].xcch901,
                                    g_detail[2].xcch101,g_detail[2].xcch201,  g_detail[2].xcch204,g_detail[2].xcch301,g_detail[2].xcch303,g_detail[2].xcch901
   LET g_detail[1].l_item = cl_getmsg('axc-00366',g_lang)
   LET g_detail[2].l_item = cl_getmsg('axc-00658',g_lang)
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET l_ac = 1
   #由工單找該年度期別異動類型(xcck012)為302.生產發料的資料
   LET g_sql = "SELECT xcck013,xcck006,xcck007,xcck008,",
               "       xcck010,",
               "       (SELECT imaal003 FROM imaal_t WHERE imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '",g_dlang,"') xcck010_desc,",
               "       (SELECT imaal004 FROM imaal_t WHERE imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '",g_dlang,"') xcck010_desc_desc,",
               "       xcck011,",
#               "       (SELECT inaml004 FROM inaml_t WHERE inamlent = xcckent AND inaml001 = xcck010 AND inaml002 = xcck011 AND inaml003 = '",g_dlang,"') xcck011_desc,",
               "       xcck201,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,",
               "       xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h",
               "  FROM xcck_t WHERE xcckent = ",g_enterprise," AND xcckcomp = '",g_master.xcchcomp,"'",
               "   AND xcckld = '",g_master.xcchld,"'",
               "   AND xcck001 = '1' AND xcck002 = '",g_master.xcch002,"' AND xcck003 = '",g_master.xcch003,"'",
               "   AND xcck004 = ",g_master.xcch004," AND xcck005 = ",g_master.xcch005,
               "   AND xcck047 = '",g_master.xcch006,"' ",
               "   AND xcck020 IN ('302','303') ", 
               "  ORDER BY xcck013,xcck006,xcck007,xcck008"
   PREPARE axcq538_b_fill_prep2 FROM g_sql
   DECLARE axcq538_b_fill_curs2 CURSOR FOR axcq538_b_fill_prep2
   LET l_xcck202  = 0
   LET l_xcck202a = 0
   LET l_xcck202b = 0
   LET l_xcck202c = 0
   LET l_xcck202d = 0
   LET l_xcck202e = 0
   LET l_xcck202f = 0
   LET l_xcck202g = 0
   LET l_xcck202h = 0
   FOREACH axcq538_b_fill_curs2 INTO g_detail_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_xcck202  = l_xcck202  + g_detail_d[l_ac].xcck202
      LET l_xcck202a = l_xcck202a + g_detail_d[l_ac].xcck202a
      LET l_xcck202b = l_xcck202b + g_detail_d[l_ac].xcck202b
      LET l_xcck202c = l_xcck202c + g_detail_d[l_ac].xcck202c
      LET l_xcck202d = l_xcck202d + g_detail_d[l_ac].xcck202d
      LET l_xcck202e = l_xcck202e + g_detail_d[l_ac].xcck202e
      LET l_xcck202f = l_xcck202f + g_detail_d[l_ac].xcck202f
      LET l_xcck202g = l_xcck202g + g_detail_d[l_ac].xcck202g
      LET l_xcck202h = l_xcck202h + g_detail_d[l_ac].xcck202h
      LET l_ac = l_ac + 1
   END FOREACH
   LET g_detail_d[l_ac].xcck006 = cl_getmsg("axc-00204",g_lang)
   LET g_detail_d[l_ac].xcck202  = l_xcck202  
   LET g_detail_d[l_ac].xcck202a = l_xcck202a 
   LET g_detail_d[l_ac].xcck202b = l_xcck202b 
   LET g_detail_d[l_ac].xcck202c = l_xcck202c 
   LET g_detail_d[l_ac].xcck202d = l_xcck202d 
   LET g_detail_d[l_ac].xcck202e = l_xcck202e 
   LET g_detail_d[l_ac].xcck202f = l_xcck202f 
   LET g_detail_d[l_ac].xcck202g = l_xcck202g 
   LET g_detail_d[l_ac].xcck202h = l_xcck202h    
   LET l_ac = 1
   #由工單找異動類型(xcck012)為113.生產入庫的資料
   LET g_sql = "SELECT xcck013,xcck006,xcck007,xcck008,",
               "       xcck010,",
               "       (SELECT imaal003 FROM imaal_t WHERE imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '",g_dlang,"') xcck010_desc,",
               "       (SELECT imaal004 FROM imaal_t WHERE imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '",g_dlang,"') xcck010_desc_desc,",
               "       xcck011,",
#               "       (SELECT inaml004 FROM inaml_t WHERE inamlent = xcckent AND inaml001 = xcck010 AND inaml002 = xcck011 AND inaml003 = '",g_dlang,"') xcck011_desc,",
               "       xcck201,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,",
               "       xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h",
               "  FROM xcck_t WHERE xcckent = ",g_enterprise," AND xcckcomp = '",g_master.xcchcomp,"'",
               "   AND xcckld = '",g_master.xcchld,"'",
               "   AND xcck001 = '1' AND xcck002 = '",g_master.xcch002,"' AND xcck003 = '",g_master.xcch003,"'",
               "   AND xcck004 = ",g_master.xcch004," AND xcck005 = ",g_master.xcch005,
               "   AND xcck047 = '",g_master.xcch006,"' ",
               "   AND xcck020 = '113' ", 
               "  ORDER BY xcck013,xcck006,xcck007,xcck008"
   PREPARE axcq538_b_fill_prep3 FROM g_sql
   DECLARE axcq538_b_fill_curs3 CURSOR FOR axcq538_b_fill_prep3
   LET l_xcck202  = 0
   LET l_xcck202a = 0
   LET l_xcck202b = 0
   LET l_xcck202c = 0
   LET l_xcck202d = 0
   LET l_xcck202e = 0
   LET l_xcck202f = 0
   LET l_xcck202g = 0
   LET l_xcck202h = 0
   FOREACH axcq538_b_fill_curs3 INTO g_detail2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_xcck202  = l_xcck202  + g_detail2_d[l_ac].xcck202
      LET l_xcck202a = l_xcck202a + g_detail2_d[l_ac].xcck202a
      LET l_xcck202b = l_xcck202b + g_detail2_d[l_ac].xcck202b
      LET l_xcck202c = l_xcck202c + g_detail2_d[l_ac].xcck202c
      LET l_xcck202d = l_xcck202d + g_detail2_d[l_ac].xcck202d
      LET l_xcck202e = l_xcck202e + g_detail2_d[l_ac].xcck202e
      LET l_xcck202f = l_xcck202f + g_detail2_d[l_ac].xcck202f
      LET l_xcck202g = l_xcck202g + g_detail2_d[l_ac].xcck202g
      LET l_xcck202h = l_xcck202h + g_detail2_d[l_ac].xcck202h
      LET l_ac = l_ac + 1
   END FOREACH
   LET g_detail2_d[l_ac].xcck006 = cl_getmsg("axc-00204",g_lang)
   LET g_detail2_d[l_ac].xcck202  = l_xcck202  
   LET g_detail2_d[l_ac].xcck202a = l_xcck202a 
   LET g_detail2_d[l_ac].xcck202b = l_xcck202b 
   LET g_detail2_d[l_ac].xcck202c = l_xcck202c 
   LET g_detail2_d[l_ac].xcck202d = l_xcck202d 
   LET g_detail2_d[l_ac].xcck202e = l_xcck202e 
   LET g_detail2_d[l_ac].xcck202f = l_xcck202f 
   LET g_detail2_d[l_ac].xcck202g = l_xcck202g 
   LET g_detail2_d[l_ac].xcck202h = l_xcck202h    
   {
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   }
#   CALL g_detail_d.deleteElement(g_detail_d.getLength())
#   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_detail2_cnt =  g_detail_d.getLength()     
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq538_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq538_detail_action_trans()
 
   CALL axcq538_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq538.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq538_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq538.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq538_detail_show(ps_page)
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
 
{<section id="axcq538.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axcq538_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq538.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq538_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
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
 
{<section id="axcq538.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq538_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq538.mask_functions" >}
 &include "erp/axc/axcq538_mask.4gl"
 
{</section>}
 
{<section id="axcq538.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢
################################################################################
PRIVATE FUNCTION axcq538_query()
DEFINE ls_wc      LIKE type_t.chr500
DEFINE ls_return  STRING
DEFINE ls_result  STRING
DEFINE l_comp        LIKE xccc_t.xccccomp
DEFINE l_ld          LIKE xccc_t.xcccld
DEFINE l_year        LIKE xccc_t.xccc004
DEFINE l_period      LIKE xccc_t.xccc005
DEFINE l_calc_type   LIKE xccc_t.xccc003

    DISPLAY ' ' TO FORMONLY.idx
    DISPLAY ' ' TO FORMONLY.cnt
    DISPLAY ' ' TO FORMONLY.h_index
    DISPLAY ' ' TO FORMONLY.h_count
     
    LET ls_wc = g_wc
    CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
    CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
    
    LET g_qryparam.state = "c"
    LET g_detail_idx  = 1
    LET g_detail_idx2 = 1
    CLEAR FORM
    INITIALIZE g_master.* TO NULL
    CALL g_detail.clear()
    CALL g_detail_d.clear()
    CALL g_detail2_d.clear()
     
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       INPUT BY NAME g_master.xcchcomp,g_master.xcchld,g_master.xcch003,g_master.xcch004,g_master.xcch005
            ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
               IF cl_null(g_master.xcchcomp) THEN
                  LET g_master.xcchcomp = l_comp
                  CALL s_desc_get_department_desc(g_master.xcchcomp) RETURNING g_master.xcchcomp_desc
                  DISPLAY BY NAME g_master.xcchcomp_desc
                  DISPLAY BY NAME g_master.xcchcomp
                  SELECT glaa003 INTO g_glaa003 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                     AND glaacomp = g_master.xcchcomp                     
               END IF
               IF cl_null(g_master.xcchld) THEN
                  LET g_master.xcchld = l_ld
                  DISPLAY BY NAME g_master.xcchld
                  CALL s_desc_get_ld_desc(g_master.xcchld) RETURNING g_master.xcchld_desc
                  DISPLAY BY NAME g_master.xcchld_desc   
               END IF
               IF cl_null(g_master.xcch003) THEN
                  LET g_master.xcch003 = l_calc_type
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.xcch003
                  CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.xcch003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_master.xcch003
                  DISPLAY BY NAME g_master.xcch003_desc
               END IF
               IF cl_null(g_master.xcch004) AND l_year<>0 THEN
                  LET g_master.xcch004 = l_year
                  DISPLAY BY NAME g_master.xcch004    
               END IF
               IF cl_null(g_master.xcch005) AND l_period<>0 THEN
                  LET g_master.xcch005 = l_period
                  DISPLAY BY NAME g_master.xcch002
               END IF
               IF NOT cl_null(g_master.xcch004) AND NOT cl_null(g_master.xcch005) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcch004,g_master.xcch005)
                      RETURNING g_bdate,g_edate               
               END IF 

            AFTER FIELD xcchcomp
            
               CALL s_desc_get_department_desc(g_master.xcchcomp) RETURNING g_master.xcchcomp_desc
               DISPLAY BY NAME g_master.xcchcomp_desc
               IF NOT cl_null(g_master.xcchcomp) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcchcomp
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist('v_ooef001_15') THEN
                     #檢查失敗時後續處理
                     LET g_master.xcchcomp = g_master_t.xcchcomp
                     CALL s_desc_get_department_desc(g_master.xcchcomp) RETURNING g_master.xcchcomp_desc
                     DISPLAY BY NAME g_master.xcchcomp_desc
                     NEXT FIELD xcchcomp
                  END IF  
                  IF s_chr_get_index_of(g_wc_cs_comp,g_master.xcchcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xcchcomp = g_master_t.xcchcomp
                     CALL s_desc_get_department_desc(g_master.xcchcomp) RETURNING g_master.xcchcomp_desc
                     DISPLAY BY NAME g_master.xcchcomp_desc
                     NEXT FIELD xcchcomp
                  END IF
                  SELECT glaa003 INTO g_glaa003 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                     AND glaacomp = g_master.xcchcomp                
                  IF NOT cl_null(g_master.xcch004) AND NOT cl_null(g_master.xcch005) THEN
                     CALL s_fin_date_get_period_range(g_glaa003,g_master.xcch004,g_master.xcch005)
                      RETURNING g_bdate,g_edate               
                  END IF
                  DISPLAY BY NAME g_master.xcch004,g_master.xcch005
               END IF            

            BEFORE FIELD xcchcomp
               #add-point:BEFORE FIELD xcbtcomp name="input.b.xcbtcomp"
   
               #END add-point
 
 
            #應用 a04 樣板自動產生(Version:3)
            ON CHANGE xcchcomp
               #add-point:ON CHANGE xcbtcomp name="input.g.xcbtcomp"
   
               #END add-point 
    
            AFTER FIELD xcchld
               CALL s_desc_get_ld_desc(g_master.xcchld) RETURNING g_master.xcchld_desc
               DISPLAY BY NAME g_master.xcchld_desc   
               IF NOT cl_null(g_master.xcchld) THEN
                  IF NOT s_axc_chk_ld_comp(g_master.xcchcomp,g_master.xcchld) THEN
                     LET g_master.xcchld = NULL
                     LET g_master.xcchld_desc = NULL
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
            AFTER FIELD xcch003
               IF NOT cl_null(g_master.xcch003) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.xcch003 
                  #呼叫檢查存在並帶值的library
                  IF NOT  cl_chk_exist("v_xcat001") THEN
                     LET g_master.xcch003 = NULL
                     LET g_master.xcch003_desc = NULL
                     NEXT FIELD CURRENT
                  END IF
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.xcch003
                  CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.xcch003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_master.xcch003
                  DISPLAY BY NAME g_master.xcch003_desc
               END IF 
               
            #應用 a01 樣板自動產生(Version:2)
            BEFORE FIELD xcch004
               #add-point:BEFORE FIELD xcbt001 name="input.b.xcbt001"
   
               #END add-point
    
    
            #應用 a02 樣板自動產生(Version:2)
            AFTER FIELD xcch004
               
               #add-point:AFTER FIELD xcch004 name="input.a.xcch004"
               IF NOT cl_null(g_master.xcch004) THEN
                  IF NOT s_fin_date_chk_year(g_master.xcch004) THEN
                     LET g_master.xcch004 = g_master_t.xcch004
                     DISPLAY BY NAME g_master.xcch004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_master.xcch004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     NEXT FIELD CURRENT
                  END IF
                                                       
               END IF  
               IF NOT cl_null(g_master.xcch004) AND NOT cl_null(g_master.xcch005) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcch004,g_master.xcch005)
                      RETURNING g_bdate,g_edate               
               END IF            
               #END add-point
               
    
    
            #應用 a04 樣板自動產生(Version:3)
            ON CHANGE xcch004
               #add-point:ON CHANGE xcbt001 name="input.g.xcbt001"
   
               #END add-point 
    
    
            #應用 a01 樣板自動產生(Version:2)
            BEFORE FIELD xcch005
               #add-point:BEFORE FIELD xcbt002 name="input.b.xcbt002"
               
               #END add-point
    
    
            #應用 a02 樣板自動產生(Version:2)
            AFTER FIELD xcch005
               
               #add-point:AFTER FIELD xcbt002 name="input.a.xcbt002"
               IF NOT cl_null(g_master.xcch005) THEN                      
                  IF NOT s_fin_date_chk_period(g_glaa003,g_master.xcch004,g_master.xcch005) THEN
                     LET g_master.xcch005 = g_master_t.xcch005
                     DISPLAY BY NAME g_master.xcch005
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00106'
                     LET g_errparam.extend = g_master.xcch005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_master.xcch004) AND NOT cl_null(g_master.xcch005) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcch004,g_master.xcch005)
                      RETURNING g_bdate,g_edate               
               END IF 
               #END add-point
               
    
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD xcchcomp
               #add-point:ON ACTION controlp INFIELD xcchcomp name="input.c.xcchcomp"
               #應用 a07 樣板自動產生(Version:3)   
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
    
               LET g_qryparam.default1 = g_master.xcchcomp             #給予default值
               LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
               #給予arg
               LET g_qryparam.arg1 = "" #
   
               #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               CALL q_ooef001_2()                                #呼叫開窗
    
               LET g_master.xcchcomp = g_qryparam.return1   
               DISPLAY g_master.xcchcomp TO xcchcomp              #
               CALL s_desc_get_department_desc(g_master.xcchcomp) RETURNING g_master.xcchcomp_desc
               DISPLAY BY NAME g_master.xcchcomp_desc
               NEXT FIELD xcchcomp                          #返回原欄位
   
               #END add-point
               
            ON ACTION controlp INFIELD xcchld
              #此段落由子樣板a07產生            
              #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xcchld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept 
               IF g_master.xcchcomp IS NOT NULL THEN
                  LET g_qryparam.where = " glaacomp = '",g_master.xcchcomp,"'"
               END IF
               #增加帳套權限控制
               IF NOT cl_null(g_wc_cs_ld) THEN
                  IF g_master.xcchcomp IS NOT NULL THEN
                     LET g_qryparam.where = g_qryparam.where CLIPPED," AND glaald IN ",g_wc_cs_ld
                  ELSE
                     LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
                  END IF
               END IF
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_master.xcchld = g_qryparam.return1              
               DISPLAY g_master.xcchld TO xcchld              
               CALL s_desc_get_ld_desc(g_master.xcchld) RETURNING g_master.xcchld_desc
               DISPLAY BY NAME g_master.xcchld_desc 

               NEXT FIELD xcchld                          #返回原欄位
              
            
            ON ACTION controlp INFIELD xcch003
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_master.xcch003             #給予default值
               
               #給予arg
               CALL q_xcat001()                                #呼叫開窗
               
               LET g_master.xcch003 = g_qryparam.return1              
               
               DISPLAY g_master.xcch003 TO xcch003              #
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcch003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcch003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcch003
               DISPLAY BY NAME g_master.xcch003_desc
               
               NEXT FIELD xcch003                          #返回原欄位
            
                  
            AFTER INPUT
                  #add-point:資料輸入後 name="input.m.after_input"
   
                  #end add-point
                  
               #add-point:其他管控(on row change, etc...) name="input.other"
   
               #end add-point
       END INPUT
       CONSTRUCT BY NAME g_wc ON xcch006,xcch007,imaa006,xcch009,xcch002
           BEFORE CONSTRUCT

         ON ACTION controlp INFIELD xcch006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " sfaa003 <> '3' AND (sfaastus = 'F' OR sfaastus = 'M' ) "
            CALL q_sfaadocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcch006        #顯示到畫面上
            NEXT FIELD xcch006                            #返回原欄位     
            
         ON ACTION controlp INFIELD xcch007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_10()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcch007  #顯示到畫面上
            NEXT FIELD xcch007                     #返回原欄位         
            
         ON ACTION controlp INFIELD imaa006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa006()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa006  #顯示到畫面上
            NEXT FIELD imaa006                     #返回原欄位       
         
         ON ACTION controlp INFIELD xcch002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcch002  #顯示到畫面上
            NEXT FIELD xcch002                     #返回原欄位                  
            
         AFTER CONSTRUCT            
            CONTINUE DIALOG
      END CONSTRUCT
      
      ON ACTION qbe_select
        LET ls_wc = ""
        CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
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
      LET INT_FLAG = 0
      LET g_wc = ls_wc      
    END IF
   LET g_error_show = 1
   LET l_ac = g_master_idx
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
END FUNCTION

 
{</section>}
 
