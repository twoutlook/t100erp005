#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq180.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-11-05 08:54:04), PR版次:0003(2016-10-17 14:42:22)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: adeq180
#+ Description: 實時銷售各類彙總查詢
#+ Creator....: 06814(2015-09-18 09:18:51)
#+ Modifier...: 06540 -SD/PR- 08729
 
{</section>}
 
{<section id="adeq180.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#5     2016/10/17  by  08729  處理組織開窗
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
PRIVATE TYPE type_g_rtjb_d RECORD
       
       sel LIKE type_t.chr1, 
   l_rtjadocdt LIKE type_t.dat, 
   l_bdate1 LIKE type_t.dat, 
   l_edate1 LIKE type_t.dat, 
   rtjbsite LIKE rtjb_t.rtjbsite, 
   rtjbsite_desc LIKE type_t.chr500, 
   rtjb004 LIKE rtjb_t.rtjb004, 
   rtjb004_desc LIKE type_t.chr500, 
   rtjb025 LIKE rtjb_t.rtjb025, 
   rtjb025_desc LIKE type_t.chr500, 
   rtjb028 LIKE rtjb_t.rtjb028, 
   rtjb028_desc LIKE type_t.chr500, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   rtaw001_desc LIKE type_t.chr500, 
   rtjb012 LIKE rtjb_t.rtjb012, 
   l_original LIKE type_t.num20_6, 
   rtjb031 LIKE rtjb_t.rtjb031, 
   l_count LIKE type_t.num10, 
   l_pct LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ls_wc     STRING  
DEFINE g_sql_ins   STRING
DEFINE g_sql_upd   STRING
DEFINE g_sql_del   STRING
DEFINE g_sum_sql   STRING 
DEFINE g_head      RECORD
       l_bdate     LIKE type_t.dat,
       l_edate     LIKE type_t.dat,
       l_sumby     LIKE type_t.chr1,
       rtjbsite    STRING,#LIKE rtjb_t.rtjbsite,
       rtjb004     STRING,#LIKE rtjb_t.rtjb004,
       rtjb025     STRING,#LIKE rtjb_t.rtjb025,
       rtjb028     STRING,#LIKE rtjb_t.rtjb028,
       rtdx003     STRING,#LIKE rtdx_t.rtdx003,
       stfa012     STRING,#LIKE stfa_t.stfa012,
       rtaw001     STRING#LIKE rtaw_t.rtaw001
                   END RECORD
DEFINE g_rtjb_d1 DYNAMIC ARRAY OF RECORD  #按库区
   l_rtjadocdt_1 LIKE type_t.dat, 
   l_bdate2      LIKE type_t.chr500, 
   l_edate2      LIKE type_t.chr500, 
   rtjbsite      LIKE rtjb_t.rtjbsite, 
   rtjbsite_desc LIKE type_t.chr500, 
   rtjb025       LIKE rtjb_t.rtjb025,
   rtjb025_desc  LIKE type_t.chr500,    
   rtjb028       LIKE rtjb_t.rtjb028, 
   rtjb028_desc  LIKE type_t.chr500, 
   rtaw001       LIKE rtaw_t.rtaw001, 
   rtaw001_desc  LIKE type_t.chr500, 
   rtjb012       LIKE rtjb_t.rtjb012, 
   l_original_1  LIKE type_t.num20_6, 
   rtjb031       LIKE rtjb_t.rtjb031, 
   l_count_1     LIKE type_t.num20_6, 
   l_pct_1       LIKE type_t.num20_6 
       END RECORD
       
DEFINE g_rtjb_d2 DYNAMIC ARRAY OF RECORD  #按专柜
   l_rtjadocdt_2 LIKE type_t.dat, 
   l_bdate3      LIKE type_t.chr500, 
   l_edate3      LIKE type_t.chr500, 
   rtjbsite      LIKE rtjb_t.rtjbsite,
   rtjbsite_desc LIKE type_t.chr500,    
   rtjb028       LIKE rtjb_t.rtjb028, 
   rtjb028_desc  LIKE type_t.chr500, 
   rtaw001       LIKE rtaw_t.rtaw001, 
   rtaw001_desc  LIKE type_t.chr500, 
   rtjb012       LIKE rtjb_t.rtjb012, 
   l_original_2  LIKE type_t.num20_6, 
   rtjb031       LIKE rtjb_t.rtjb031, 
   l_count_2     LIKE type_t.num20_6, 
   l_pct_2       LIKE type_t.num20_6 
       END RECORD
       
DEFINE g_rtjb_d3 DYNAMIC ARRAY OF RECORD  #按部类
   l_rtjadocdt_3 LIKE type_t.dat, 
   l_bdate4      LIKE type_t.chr500, 
   l_edate4      LIKE type_t.chr500, 
   rtjbsite      LIKE rtjb_t.rtjbsite, 
   rtjbsite_desc LIKE type_t.chr500, 
   rtaw001       LIKE rtaw_t.rtaw001, 
   rtaw001_desc  LIKE type_t.chr500,  
   rtjb012       LIKE rtjb_t.rtjb012, 
   l_original_3  LIKE type_t.num20_6, 
   rtjb031       LIKE rtjb_t.rtjb031, 
   l_count_3     LIKE type_t.num20_6, 
   l_pct_3       LIKE type_t.num20_6 
       END RECORD
       
DEFINE g_rtjb_d4 DYNAMIC ARRAY OF RECORD  #按门店
   l_rtjadocdt_4 LIKE type_t.dat, 
   l_bdate5      LIKE type_t.chr500, 
   l_edate5      LIKE type_t.chr500, 
   rtjbsite      LIKE rtjb_t.rtjbsite, 
   rtjbsite_desc LIKE type_t.chr500, 
   rtjb012       LIKE rtjb_t.rtjb012, 
   l_original_4  LIKE type_t.num20_6, 
   rtjb031       LIKE rtjb_t.rtjb031, 
   l_count_4     LIKE type_t.num20_6, 
   l_pct_4       LIKE type_t.num20_6 
       END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtjb_d            DYNAMIC ARRAY OF type_g_rtjb_d
DEFINE g_rtjb_d_t          type_g_rtjb_d
 
 
 
 
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
 
{<section id="adeq180.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
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
   DECLARE adeq180_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq180_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq180_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq180 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq180_init()   
 
      #進入選單 Menu (="N")
      CALL adeq180_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq180
      
   END IF 
   
   CLOSE adeq180_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL adeq180_drop_tmp() RETURNING l_success
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq180.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq180_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL adeq180_create_tmp() RETURNING l_success
   CALL cl_set_combo_scc('rtdx003','6013')
   #end add-point
 
   CALL adeq180_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq180.default_search" >}
PRIVATE FUNCTION adeq180_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtjbseq = '", g_argv[02], "' AND "
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
 
{<section id="adeq180.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq180_ui_dialog() 
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
   LET g_ls_wc = '1'
   #end add-point
 
   
   CALL adeq180_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtjb_d.clear()
 
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
 
         CALL adeq180_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_head.l_bdate,g_head.l_edate,g_head.l_sumby
             FROM l_bdate,l_edate,l_sumby
             
            BEFORE INPUT
               #讓沒下查詢條件(沒進CONSTRUCT段)也能查的到資料
               CALL cl_str_replace(g_wc,"1=2","1=1") RETURNING g_wc   
            ON CHANGE l_bdate
                  LET g_ls_wc = '1'   #QBE查詢條件變了再重查
            ON CHANGE l_edate
                  LET g_ls_wc = '1'   #QBE查詢條件變了再重查
            ON CHANGE l_sumby
                  LET g_ls_wc = '1'   #QBE查詢條件變了再重查
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON rtjbsite,rtdx003,rtjb028,rtjb025,rtjb004,rtaw001,stfa012
            ON ACTION controlp INFIELD rtjbsite
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjbsite',g_site,'c')
               CALL q_ooef001_24()                    #呼叫開窗
               LET g_head.rtjbsite = g_qryparam.return1
               DISPLAY g_head.rtjbsite TO rtjbsite    #顯示到畫面上
               NEXT FIELD rtjbsite                    #返回原欄位
            ON ACTION controlp INFIELD rtjb004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                       #呼叫開窗
               LET g_head.rtjb004 = g_qryparam.return1
               DISPLAY g_head.rtjb004 TO rtjb004      #顯示到畫面上
               NEXT FIELD rtjb004                     #返回原欄位
            ON ACTION controlp INFIELD rtjb025
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inaa001_1()                     #呼叫開窗
               LET g_head.rtjb025 = g_qryparam.return1
               DISPLAY g_head.rtjb025 TO rtjb025      #顯示到畫面上
               NEXT FIELD rtjb025                     #返回原欄位
            ON ACTION controlp INFIELD rtjb028
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_inaa120()                       #呼叫開窗
               LET g_head.rtjb028 = g_qryparam.return1
               DISPLAY g_head.rtjb028 TO rtjb028      #顯示到畫面上
               NEXT FIELD rtjb028                     #返回原欄位
            ON ACTION controlp INFIELD stfa012
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2002"           #ACC:2002 商品品牌
               CALL q_oocq002()                       #呼叫開窗
               LET g_head.stfa012 = g_qryparam.return1
               DISPLAY g_head.stfa012 TO stfa012      #顯示到畫面上
               NEXT FIELD stfa012                     #返回原欄位
            ON ACTION controlp INFIELD rtaw001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #aoos010:ART設定:品類管理層級
               LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
               CALL q_rtax001()                       #呼叫開窗
               LET g_head.rtaw001 = g_qryparam.return1
               DISPLAY g_head.rtaw001 TO rtaw001      #顯示到畫面上
               NEXT FIELD rtaw001                     #返回原欄位
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_rtjb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq180_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq180_b_fill2()
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
         DISPLAY ARRAY g_rtjb_d1 TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d1.getLength() TO FORMONLY.h_count
 
         END DISPLAY 
         
         
         DISPLAY ARRAY g_rtjb_d2 TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 3

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d2.getLength() TO FORMONLY.h_count
 
         END DISPLAY 
         
         
         DISPLAY ARRAY g_rtjb_d3 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 4

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d3.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         
         
         DISPLAY ARRAY g_rtjb_d4 TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 5

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d4.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq180_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_head.l_bdate  = g_today
            LET g_head.l_edate  = g_today
            LET g_head.l_sumby  = 'N'
            DISPLAY g_head.l_bdate,g_head.l_edate,g_head.l_sumby 
                 TO l_bdate,l_edate,l_sumby
            
            CALL cl_set_act_visible("insert,query,selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            #end add-point
            NEXT FIELD l_bdate
 
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
            CALL adeq180_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtjb_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_rtjb_d1)
               LET g_export_id[2]   = "s_detail2"

               LET g_export_node[3] = base.typeInfo.create(g_rtjb_d2)
               LET g_export_id[3]   = "s_detail3"
               
               LET g_export_node[4] = base.typeInfo.create(g_rtjb_d3)
               LET g_export_id[4]   = "s_detail4"
               
               LET g_export_node[5] = base.typeInfo.create(g_rtjb_d4)
               LET g_export_id[5]   = "s_detail5"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq180_b_fill()
 
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
            CALL adeq180_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq180_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq180_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq180_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               LET g_rtjb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               LET g_rtjb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtjb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtjb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq180_filter()
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
               EXIT DIALOG
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
 
{<section id="adeq180.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq180_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_sum_rtjb012     LIKE rtjb_t.rtjb012
   DEFINE l_sum_original    LIKE rtjb_t.rtjb031
   DEFINE l_sum_rtjb031     LIKE rtjb_t.rtjb031
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtjbsite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   #IF ls_wc != g_ls_wc THEN   #QBE查詢條件變了再重查
      LET g_wc = g_wc," AND ",l_where
   #END IF
   LET g_error_show=1
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
 
   CALL g_rtjb_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',rtjbsite,'',rtjb004,'',rtjb025,'',rtjb028,'','','', 
       rtjb012,'',rtjb031,'',''  ,DENSE_RANK() OVER( ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq) AS RANK FROM rtjb_t", 
 
 
 
                     "",
                     " WHERE rtjbent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t"),
                     " ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #LET ls_sql_rank = "SELECT  UNIQUE '','','','',rtjbsite,'',rtjb004,'',rtjb025,'',rtjb028,'','','',rtjb012,'',rtjb031,'',''  ",
   #                  "        ,DENSE_RANK() OVER( ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq) AS RANK ",
   #                  "  FROM rtja_t,rtjb_t", 
   #                  " WHERE rtjaent=rtjbent AND rtjadocno = rtjbdocno AND rtjbent= ? AND 1=1 AND ", ls_wc,
   #                  " AND rtjadocdt BETWEEN TO_DATE('",g_head.l_bdate,"','YY/MM/DD')",
   #                  "                   AND TO_DATE('",g_head.l_edate,"','YY/MM/DD')"
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t")
   #                  #" ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq"
   #LET ls_sql_rank = " SELECT        '',rtjadocdt,'','',",           #去掉unique
   #                  "               rtjbsite,ooefl003,",
   #                  "               rtjb004,imaal003,",
   #                  "               rtjb025,inayl003,",
   #                  "               rtjb028,stfal003,",
   #                  "               rtaw001,rtaxl003,",
   #                  "               SUM(COALESCE(rtjb012,0)) rtjb012,",
   #                  "               SUM(COALESCE(rtjb008*rtjb012,0)) l_original,",
   #                  "               SUM(COALESCE(rtjb031,0)) rtjb031,",
   #                  "               COUNT(DISTINCT rtjbdocno) l_count,",
   #                  "               SUM(COALESCE(rtjb031,0))/COUNT(DISTINCT rtjbdocno) l_pct  ",
   #                  #"               DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK",
   #                  " FROM rtja_t,rtjb_t ",
   #                  " LEFT JOIN stfa_t ON rtjbent = stfaent AND rtjb028 = stfa005  ",
   #                  " LEFT JOIN ooefl_t ON rtjbent = ooeflent AND rtjbsite = ooefl001 AND ooefl002 = '",g_dlang,"' ",
   #                  " LEFT JOIN imaal_t ON rtjbent = imaalent AND rtjb004 = imaal001 AND imaal002 = '",g_dlang,"' ",
   #                  " LEFT JOIN inayl_t ON rtjbent = inaylent AND rtjb025 = inayl001 AND inayl002 = '",g_dlang,"' ",
   #                  " LEFT JOIN stfal_t ON rtjbent = stfalent AND rtjb028 = stfal001 AND stfal002 = '",g_dlang,"' ",
   #                  " LEFT JOIN imaa_t ON rtjbent = imaaent AND rtjb004 = imaa001 ",
   #                  " LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
   #                  " LEFT JOIN rtaxl_t ON rtawent = rtaxlent AND rtaw001 = rtaxl001 AND rtaxl002 = '",g_dlang,"' ",
   #                  " WHERE rtjaent=rtjbent AND rtjadocno = rtjbdocno AND rtjbent= ? AND 1=1 AND ", ls_wc,
   #                  " AND rtjadocdt BETWEEN TO_DATE('",g_head.l_bdate,"','YY/MM/DD')",
   #                  "                   AND TO_DATE('",g_head.l_edate,"','YY/MM/DD')"
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t"),
   #                  " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjb004,imaal003,
   #                             rtjb025,inayl003,rtjb028,stfal003,
   #                             rtaw001,rtaxl003 "
                                
   LET ls_sql_rank = " SELECT        '",g_enterprise,"','N',rtjadocdt,'",g_head.l_bdate,"','",g_head.l_edate,"',",
                     "               rtjbsite,",
                     "               (SELECT ooefl003",
                     "                  FROM ooefl_t",
                     "                 WHERE rtjbent = ooeflent AND rtjbsite = ooefl001 ",
                     "                   AND ooefl002 = '",g_dlang,"') ooefl003,",
                     "               rtjb004,",
                     "               (SELECT imaal003",
                     "                  FROM imaal_t",
                     "                 WHERE rtjbent = imaalent AND rtjb004 = imaal001",
                     "                   AND imaal002 = '",g_dlang,"') imaal003,",
                     "               rtjb025,",
                     "               (SELECT inayl003",
                     "                  FROM inayl_t",
                     "                 WHERE rtjbent = inaylent AND rtjb025 = inayl001 ",
                     "                   AND inayl002 = '",g_dlang,"') inayl003,",
                     "               rtjb028,",
                     "               (SELECT stfal003",
                     "                  FROM stfal_t",
                     "                 WHERE rtjbent = stfalent AND rtjb028 = stfal001 ",
                     "                   AND stfal002 = '",g_dlang,"') stfal003,",
                     "               rtaw001,",
                     "               (SELECT rtaxl003",
                     "                  FROM rtaxl_t",
                     "                 WHERE rtjbent = rtaxlent AND rtaw001 = rtaxl001 ",
                     "                   AND rtaxl002 = '",g_dlang,"') rtaxl003,",
                     "               rtjb012,",
                     "               l_original,",
                     "               rtjb031,",
                     "               l_count,",
                     "               l_pct  ",
                     #"               DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK",
                     " FROM (SELECT  rtjbent,rtjadocdt,rtjbsite,rtjb004,rtjb025,rtjb028,rtaw001,",
                     "               SUM(COALESCE(rtjb012,0)) rtjb012,",
                     "               SUM(COALESCE(rtjb008*rtjb012,0)) l_original,",
                     "               SUM(COALESCE(rtjb031,0)) rtjb031,",
                     "               COUNT(DISTINCT rtjbdocno) l_count,",
                     "               SUM(COALESCE(rtjb031,0))/COUNT(DISTINCT rtjbdocno) l_pct  ",
                     "         FROM rtja_t,rtjb_t",
                     "              LEFT JOIN rtdx_t ON rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004 ",
                     "              LEFT JOIN stfa_t ON rtjbent = stfaent AND rtjb028 = stfa005  ",
                     "              LEFT JOIN imaa_t ON rtjbent = imaaent AND rtjb004 = imaa001 ",
                     "              LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 ",
                     "                              AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                     "        WHERE rtjaent=rtjbent AND rtjadocno = rtjbdocno AND rtjbent= ? AND 1=1 AND ", ls_wc,
                     " AND rtjadocdt BETWEEN TO_DATE('",g_head.l_bdate,"','YY/MM/DD')",
                     "                   AND TO_DATE('",g_head.l_edate,"','YY/MM/DD')"
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t"),
                     " GROUP BY rtjbent,rtjadocdt,rtjbsite,rtjb004,rtjb025,rtjb028,rtaw001)"
   
   #明细
   #LET g_sql =  " SELECT        '",g_enterprise,"','N',rtjadocdt,'",g_head.l_bdate,"','",g_head.l_edate,"',",
   #             "               rtjbsite,ooefl003,",
   #             "               rtjb004,imaal003,",
   #             "               rtjb025,inayl003,",
   #             "               rtjb028,stfal003,",
   #             "               rtaw001,rtaxl003,",
   #             "               rtjb012, ",
   #             "               l_original,",
   #             "               rtjb031, ",
   #             "               l_count, ",
   #             "               l_pct ",
   #             " FROM (",ls_sql_rank,")"
   
   IF ls_wc != g_ls_wc THEN   #QBE查詢條件變了再重查
      LET g_sql_del = "DELETE FROM adeq180_tmp "
      EXECUTE IMMEDIATE g_sql_del
      LET g_sql_ins = " INSERT INTO adeq180_tmp (enterprise,    sel ,   rtjadocdt,  l_bdate,  l_edate,  
                                                 rtjbsite,    ooefl003,   rtjb004,  imaal003, rtjb025,
                                                 inayl003,    rtjb028,    stfal003, rtaw001,  rtaxl003, 
                                                 rtjb012,     l_original, rtjb031,  l_count,  l_pct)",ls_sql_rank         
                                                           
      PREPARE ins_tmp FROM g_sql_ins
      EXECUTE ins_tmp USING g_enterprise
   END IF
   IF g_head.l_sumby = 'N' THEN
      CALL cl_set_comp_visible("l_rtjadocdt",TRUE)   
      CALL cl_set_comp_visible("l_bdate1",FALSE)
      CALL cl_set_comp_visible("l_edate1",FALSE)
      LET ls_sql_rank = " SELECT  sel ,       rtjadocdt,        '','',  rtjbsite, 
                                  ooefl003,   rtjb004,  imaal003, rtjb025,  inayl003,
                                  rtjb028,    stfal003, rtaw001,  rtaxl003, ",
                        "         sum(rtjb012) A,  sum(l_original) B,
                                  sum(rtjb031) C,  sum(l_count) D, ",
                        "         sum(rtjb031)/sum(l_count) E,",
                        "         DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK ",
                        " FROM adeq180_tmp WHERE enterprise = ? ",
                        " GROUP BY  enterprise,  sel , ",
                        "           rtjadocdt,",              
                        "           rtjbsite,    ooefl003,",
                        "           rtjb004,     imaal003,", 
                        "           rtjb025,     inayl003,", 
                        "           rtjb028,     stfal003,", 
                        "           rtaw001,     rtaxl003 ",
                        " ORDER BY rtjadocdt,rtjb004 "
   ELSE 
      CALL cl_set_comp_visible("l_rtjadocdt",FALSE)   
      CALL cl_set_comp_visible("l_bdate1",TRUE)
      CALL cl_set_comp_visible("l_edate1",TRUE)  
      LET ls_sql_rank = " SELECT  sel ,       '',         l_bdate,  l_edate,   rtjbsite, ",
                        "         ooefl003,   rtjb004,    imaal003, rtjb025,   inayl003, ",
                        "         rtjb028,    stfal003,   rtaw001,  rtaxl003, ",
                        "         sum(rtjb012) A,  sum(l_original) B,",
                        "         sum(rtjb031) C,  sum(l_count) D, ",
                        "         sum(rtjb031)/sum(l_count) E,",
                        "         DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK ",
                        " FROM adeq180_tmp WHERE enterprise = ? ",
                        " GROUP BY  enterprise,  sel ,",      
                        "           l_bdate,     l_edate,",
                        "           rtjbsite,    ooefl003,",
                        "           rtjb004,     imaal003,",
                        "           rtjb025,     inayl003,",
                        "           rtjb028,     stfal003,", 
                        "           rtaw001,     rtaxl003 "
   END IF
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
 
   LET g_sql = "SELECT '','','','',rtjbsite,'',rtjb004,'',rtjb025,'',rtjb028,'','','',rtjb012,'',rtjb031, 
       '',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF g_head.l_sumby = 'N' THEN
      LET g_sql = " SELECT  sel ,       rtjadocdt,  '',       '',        rtjbsite, 
                            ooefl003,   rtjb004,    imaal003, rtjb025,   inayl003,
                            rtjb028,    stfal003,   rtaw001,  rtaxl003,  A,B,C,D,E ",
                  "   FROM (",ls_sql_rank,")",
                  "  WHERE RANK >= ",g_pagestart,
                  "    AND RANK < ",g_pagestart + g_num_in_page
   ELSE 
      LET g_sql = " SELECT  sel ,       '',         l_bdate,  l_edate,   rtjbsite, 
                            ooefl003,   rtjb004,    imaal003, rtjb025,   inayl003,
                            rtjb028,    stfal003,   rtaw001,  rtaxl003,  A,B,C,D,E ",
                  "   FROM (",ls_sql_rank,")",
                  "  WHERE RANK >= ",g_pagestart,
                  "    AND RANK < ",g_pagestart + g_num_in_page
   END IF

   LET g_sum_sql = " SELECT SUM(A),SUM(B),SUM(C) ",
                   " FROM (",ls_sql_rank,")"
   PREPARE SUM_PRE FROM g_sum_sql
   EXECUTE SUM_PRE USING g_enterprise INTO l_sum_rtjb012,l_sum_original,l_sum_rtjb031
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq180_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq180_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtjb_d[l_ac].sel,g_rtjb_d[l_ac].l_rtjadocdt,g_rtjb_d[l_ac].l_bdate1,g_rtjb_d[l_ac].l_edate1, 
       g_rtjb_d[l_ac].rtjbsite,g_rtjb_d[l_ac].rtjbsite_desc,g_rtjb_d[l_ac].rtjb004,g_rtjb_d[l_ac].rtjb004_desc, 
       g_rtjb_d[l_ac].rtjb025,g_rtjb_d[l_ac].rtjb025_desc,g_rtjb_d[l_ac].rtjb028,g_rtjb_d[l_ac].rtjb028_desc, 
       g_rtjb_d[l_ac].rtaw001,g_rtjb_d[l_ac].rtaw001_desc,g_rtjb_d[l_ac].rtjb012,g_rtjb_d[l_ac].l_original, 
       g_rtjb_d[l_ac].rtjb031,g_rtjb_d[l_ac].l_count,g_rtjb_d[l_ac].l_pct
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
 
      CALL adeq180_detail_show("'1'")
 
      CALL adeq180_rtjb_t_mask()
 
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
   IF g_ls_wc != ls_wc THEN   #QBE查詢條件變了再重查
      CALL adeq180_b_fill3()
      CALL adeq180_b_fill4()
      CALL adeq180_b_fill5()
      CALL adeq180_b_fill6()
   END IF
   LET g_ls_wc = ls_wc     
   #end add-point
 
   CALL g_rtjb_d.deleteElement(g_rtjb_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   DISPLAY l_sum_rtjb012,l_sum_original,l_sum_rtjb031 
        TO sum_rtjb012,sum_original,sum_rtjb031
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtjb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq180_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq180_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq180_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtjb_d.getLength() > 0 THEN
      CALL adeq180_b_fill2()
   END IF
 
      CALL adeq180_filter_show('rtjbsite','b_rtjbsite')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq180.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq180_b_fill2()
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
 
{<section id="adeq180.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq180_detail_show(ps_page)
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

            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjbsite
            #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_rtjb_d[l_ac].rtjbsite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_rtjb_d[l_ac].rtjbsite_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjb004
            #LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_rtjb_d[l_ac].rtjb004_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_rtjb_d[l_ac].rtjb004_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjb025
            #LET ls_sql = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_rtjb_d[l_ac].rtjb025_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_rtjb_d[l_ac].rtjb025_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjb028
            #LET ls_sql = "SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_rtjb_d[l_ac].rtjb028_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_rtjb_d[l_ac].rtjb028_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_rtjb_d[l_ac].rtaw001
            #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_rtjb_d[l_ac].rtaw001_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_rtjb_d[l_ac].rtaw001_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq180.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq180_filter()
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
      CONSTRUCT g_wc_filter ON rtjbsite
                          FROM s_detail1[1].b_rtjbsite
 
         BEFORE CONSTRUCT
                     DISPLAY adeq180_filter_parser('rtjbsite') TO s_detail1[1].b_rtjbsite
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<l_rtjadocdt>>----
         #----<<l_bdate1>>----
         #----<<l_edate1>>----
         #----<<b_rtjbsite>>----
         #Ctrlp:construct.c.page1.b_rtjbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbsite
            #add-point:ON ACTION controlp INFIELD b_rtjbsite name="construct.c.filter.page1.b_rtjbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161006-00008#5-add(s)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjbsite',g_site,'c')
            CALL q_ooef001_24()
            #161006-00008#5-add(e)
            #CALL q_ooed004_3()                           #呼叫開窗  #161006-00008#5 mark
            DISPLAY g_qryparam.return1 TO b_rtjbsite  #顯示到畫面上
            NEXT FIELD b_rtjbsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjbsite_desc>>----
         #----<<b_rtjb004>>----
         #----<<b_rtjb004_desc>>----
         #----<<b_rtjb025>>----
         #----<<b_rtjb025_desc>>----
         #----<<b_rtjb028>>----
         #----<<b_rtjb028_desc>>----
         #----<<b_rtaw001>>----
         #----<<b_rtaw001_desc>>----
         #----<<b_rtjb012>>----
         #----<<l_original>>----
         #----<<b_rtjb031>>----
         #----<<l_count>>----
         #----<<l_pct>>----
 
 
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
 
      CALL adeq180_filter_show('rtjbsite','b_rtjbsite')
 
 
   CALL adeq180_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq180.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq180_filter_parser(ps_field)
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
 
{<section id="adeq180.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq180_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq180_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq180.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq180_detail_action_trans()
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
 
{<section id="adeq180.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq180_detail_index_setting()
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
            IF g_rtjb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtjb_d.getLength() AND g_rtjb_d.getLength() > 0
            LET g_detail_idx = g_rtjb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtjb_d.getLength() THEN
               LET g_detail_idx = g_rtjb_d.getLength()
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
 
{<section id="adeq180.mask_functions" >}
 &include "erp/ade/adeq180_mask.4gl"
 
{</section>}
 
{<section id="adeq180.other_function" readonly="Y" >}

PRIVATE FUNCTION adeq180_create_tmp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adeq180_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE adeq180_tmp(
   enterprise  VARCHAR(500), 
   sel         VARCHAR(1), 
   rtjadocdt   DATE,
   l_bdate     VARCHAR(500), 
   l_edate     VARCHAR(500), 
   rtjbsite    VARCHAR(10), 
   ooefl003    VARCHAR(500), 
   rtjb004     VARCHAR(40), 
   imaal003    VARCHAR(255), 
   rtjb025     VARCHAR(10), 
   inayl003    VARCHAR(500), 
   rtjb028     VARCHAR(20), 
   stfal003    VARCHAR(500), 
   rtaw001     VARCHAR(10), 
   rtaxl003    VARCHAR(500), 
   rtjb012     DECIMAL(20,6), 
   l_original  DECIMAL(20,6), 
   rtjb031     DECIMAL(20,6), 
   l_count     DECIMAL(20,6), 
   l_pct       DECIMAL(20,6)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adeq180_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adeq180_drop_tmp()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adeq180_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq180_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 第二个页签（按库区汇总）
# Date & Author..: 2015-09-04 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq180_b_fill3()
   DEFINE l_sql    STRING
   DEFINE l_sql1   STRING
   DEFINE l_sql3   STRING
   DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d1.clear()
    
   IF g_head.l_sumby = 'N' THEN
      CALL cl_set_comp_visible("l_rtjadocdt_1",TRUE)  
      CALL cl_set_comp_visible("l_bdate2",FALSE)
      CALL cl_set_comp_visible("l_edate2",FALSE)      
      LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,",
                   "               rtjb025,inayl003,",
                   "               rtjb028,stfal003,",
                   "               rtaw001,rtaxl003,",
                   "               SUM(rtjb012), ",
                   "               SUM(l_original),",
                   "               SUM(rtjb031), ",
                   "               SUM(l_count),   ",
                   "               SUM(rtjb031)/SUM(l_count) ",
                   " FROM adeq180_tmp ",
                   " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjb025,inayl003,rtjb028,stfal003,rtaw001,rtaxl003 ",
                   " ORDER BY rtjadocdt,rtjb025  "
   ELSE 
      CALL cl_set_comp_visible("l_rtjadocdt_1",FALSE) 
      CALL cl_set_comp_visible("l_bdate2",TRUE)
      CALL cl_set_comp_visible("l_edate2",TRUE)        
      LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,",
                   "               rtjb025,inayl003,",
                   "               rtjb028,stfal003,",
                   "               rtaw001,rtaxl003,",
                   "               SUM(rtjb012), ",
                   "               SUM(l_original),",
                   "               SUM(rtjb031), ",
                   "               SUM(l_count),   ",
                   "               SUM(rtjb031)/SUM(l_count) ",
                   " FROM adeq180_tmp ",
                   " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtjb025,inayl003,rtjb028,stfal003,rtaw001,rtaxl003 ",
                   " ORDER BY rtjb025  "
   END IF

#   LET l_sql1 = " SELECT UNIQUE rtjbsite,
#                                rtjb025,inayl003,
#                                rtjb028,stfal003,
#                                rtaw001,rtaxl003,",
#                "               SUM(rtjb012), ",
#                "               SUM(l_original),",
#                "               SUM(rtjb031), ",
#                "               SUM(l_count),   ",
#                "               SUM(rtjb031)/SUM(l_count) ",
#                " FROM adeq180_tmp ",
#                " GROUP BY rtjbsite,ooefl003,rtjb025,inayl003,rtjb028,stfal003,rtaw001,rtaxl003 "

   #DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_rtjb1_pre1 FROM l_sql1
   DECLARE sel_rtjb1_cs1  CURSOR FOR sel_rtjb1_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs1 # USING g_enterprise 
                       INTO g_rtjb_d1[l_ac].l_rtjadocdt_1,
                            g_rtjb_d1[l_ac].l_bdate2,
                            g_rtjb_d1[l_ac].l_edate2,
                            g_rtjb_d1[l_ac].rtjbsite,
                            g_rtjb_d1[l_ac].rtjbsite_desc,
                            g_rtjb_d1[l_ac].rtjb025,     
                            g_rtjb_d1[l_ac].rtjb025_desc,    
                            g_rtjb_d1[l_ac].rtjb028,     
                            g_rtjb_d1[l_ac].rtjb028_desc,    
                            g_rtjb_d1[l_ac].rtaw001,     
                            g_rtjb_d1[l_ac].rtaw001_desc,    
                            g_rtjb_d1[l_ac].rtjb012,     
                            g_rtjb_d1[l_ac].l_original_1,
                            g_rtjb_d1[l_ac].rtjb031,     
                            g_rtjb_d1[l_ac].l_count_1,   
                            g_rtjb_d1[l_ac].l_pct_1  

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d1.deleteElement(g_rtjb_d1.getLength())
   
   DISPLAY ARRAY g_rtjb_d1 TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs1
END FUNCTION

################################################################################
# Descriptions...: 第三个页签（按专柜汇总）
# Date & Author..: 2015-09-04 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq180_b_fill4()
   DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d2.clear()
 
   IF g_head.l_sumby = 'N' THEN
      CALL cl_set_comp_visible("l_rtjadocdt_2",TRUE)   
      CALL cl_set_comp_visible("l_bdate3",FALSE)
      CALL cl_set_comp_visible("l_edate3",FALSE)   
      LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,",
                   "               rtjb028,stfal003,",
                   "               rtaw001,rtaxl003,",
                   "               SUM(rtjb012), ",
                   "               SUM(l_original),",
                   "               SUM(rtjb031), ",
                   "               SUM(l_count),   ",
                   "               SUM(rtjb031)/SUM(l_count) ",
                   " FROM adeq180_tmp ",
                   " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjb028,stfal003,rtaw001,rtaxl003 ",
                   " ORDER BY rtjadocdt,rtjb028 "
   ELSE 
      CALL cl_set_comp_visible("l_rtjadocdt_2",FALSE)   
      CALL cl_set_comp_visible("l_bdate3",TRUE)
      CALL cl_set_comp_visible("l_edate3",TRUE)
      LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,",
                   "               rtjb028,stfal003,",
                   "               rtaw001,rtaxl003,",
                   "               SUM(rtjb012), ",
                   "               SUM(l_original),",
                   "               SUM(rtjb031), ",
                   "               SUM(l_count),   ",
                   "               SUM(rtjb031)/SUM(l_count) ",
                   " FROM adeq180_tmp ",
                   " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtjb028,stfal003,rtaw001,rtaxl003 ",
                   " ORDER BY rtjb028 "
   END IF
 
#   LET l_sql1 = " SELECT UNIQUE rtjbsite, 
#                                rtjb028,stfal003,
#                                rtaw001,rtaxl003,",
#                "               SUM(rtjb012), ",
#                "               SUM(l_original),",
#                "               SUM(rtjb031), ",
#                "               SUM(l_count),   ",
#                "               SUM(rtjb031)/SUM(l_count) ",
#                " FROM adeq180_tmp ",
#                " GROUP BY rtjbsite,rtjb028,stfal003,rtaw001,rtaxl003 "

   #DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_rtjb1_pre2 FROM l_sql1
   DECLARE sel_rtjb1_cs2  CURSOR FOR sel_rtjb1_pre2   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs2 # USING g_enterprise 
                       INTO g_rtjb_d2[l_ac].l_rtjadocdt_2,
                            g_rtjb_d2[l_ac].l_bdate3,
                            g_rtjb_d2[l_ac].l_edate3,
                            g_rtjb_d2[l_ac].rtjbsite,
                            g_rtjb_d2[l_ac].rtjbsite_desc,
                            g_rtjb_d2[l_ac].rtjb028,     
                            g_rtjb_d2[l_ac].rtjb028_desc,
                            g_rtjb_d2[l_ac].rtaw001,     
                            g_rtjb_d2[l_ac].rtaw001_desc,
                            g_rtjb_d2[l_ac].rtjb012,     
                            g_rtjb_d2[l_ac].l_original_2,
                            g_rtjb_d2[l_ac].rtjb031,     
                            g_rtjb_d2[l_ac].l_count_2,   
                            g_rtjb_d2[l_ac].l_pct_2  

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d2.deleteElement(g_rtjb_d2.getLength())
   
   DISPLAY ARRAY g_rtjb_d2 TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs2
   
END FUNCTION

################################################################################
# Descriptions...: 第四个页签（按管理品类汇总）
# Date & Author..: 2015-09-04 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq180_b_fill5()
   DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d3.clear()
   
   IF g_head.l_sumby = 'N' THEN
      CALL cl_set_comp_visible("l_rtjadocdt_3",TRUE) 
      CALL cl_set_comp_visible("l_bdate4",FALSE)
      CALL cl_set_comp_visible("l_edate4",FALSE)        
      LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,",
                   "               rtaw001,rtaxl003,",
                   "               SUM(rtjb012), ",
                   "               SUM(l_original),",
                   "               SUM(rtjb031), ",
                   "               SUM(l_count),   ",
                   "               SUM(rtjb031)/SUM(l_count) ",
                   " FROM adeq180_tmp ",
                   " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtaw001,rtaxl003 ",
                   " ORDER BY rtjadocdt,rtaw001 "
   ELSE 
      CALL cl_set_comp_visible("l_rtjadocdt_3",FALSE)
      CALL cl_set_comp_visible("l_bdate4",TRUE)
      CALL cl_set_comp_visible("l_edate4",TRUE)      
      LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,",
                   "               rtaw001,rtaxl003,",
                   "               SUM(rtjb012), ",
                   "               SUM(l_original),",
                   "               SUM(rtjb031), ",
                   "               SUM(l_count),   ",
                   "               SUM(rtjb031)/SUM(l_count) ",
                   " FROM adeq180_tmp ",
                   " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtaw001,rtaxl003 ",
                   " ORDER BY rtaw001 "
   END IF
   
#   LET l_sql1 = " SELECT UNIQUE rtjbsite,
#                                rtaw001,rtaxl003,",
#                "               SUM(rtjb012), ",
#                "               SUM(l_original),",
#                "               SUM(rtjb031), ",
#                "               SUM(l_count),   ",
#                "               SUM(rtjb031)/SUM(l_count) ",
#                " FROM adeq180_tmp ",
#                " GROUP BY rtjbsite,rtaw001,rtaxl003 "

   #DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_rtjb1_pre3 FROM l_sql1
   DECLARE sel_rtjb1_cs3  CURSOR FOR sel_rtjb1_pre3   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs3 # USING g_enterprise 
                       INTO g_rtjb_d3[l_ac].l_rtjadocdt_3,
                            g_rtjb_d3[l_ac].l_bdate4,
                            g_rtjb_d3[l_ac].l_edate4,
                            g_rtjb_d3[l_ac].rtjbsite,
                            g_rtjb_d3[l_ac].rtjbsite_desc,
                            g_rtjb_d3[l_ac].rtaw001,     
                            g_rtjb_d3[l_ac].rtaw001_desc,
                            g_rtjb_d3[l_ac].rtjb012,     
                            g_rtjb_d3[l_ac].l_original_3,
                            g_rtjb_d3[l_ac].rtjb031,     
                            g_rtjb_d3[l_ac].l_count_3,   
                            g_rtjb_d3[l_ac].l_pct_3  

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d3.deleteElement(g_rtjb_d3.getLength())
   
   DISPLAY ARRAY g_rtjb_d3 TO s_detail4.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs3
END FUNCTION

################################################################################
# Descriptions...: 第五个页签（按门店汇总）
# Date & Author..: 2015-09-04 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq180_b_fill6()
   DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d4.clear()
   
   IF g_head.l_sumby = 'N' THEN
      CALL cl_set_comp_visible("l_rtjadocdt_4",TRUE)   
      CALL cl_set_comp_visible("l_bdate5",FALSE)
      CALL cl_set_comp_visible("l_edate5",FALSE)      
         LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,",
                "               SUM(rtjb012), ",
                "               SUM(l_original),",
                "               SUM(rtjb031), ",
                "               SUM(l_count),   ",
                "               SUM(rtjb031)/SUM(l_count) ",
                " FROM adeq180_tmp ",
                " GROUP BY rtjadocdt,rtjbsite,ooefl003 ",
                " ORDER BY rtjadocdt,rtjbsite "
   ELSE 
      CALL cl_set_comp_visible("l_rtjadocdt_4",FALSE)  
      CALL cl_set_comp_visible("l_bdate5",TRUE)
      CALL cl_set_comp_visible("l_edate5",TRUE)      
         LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,",
                "               SUM(rtjb012), ",
                "               SUM(l_original),",
                "               SUM(rtjb031), ",
                "               SUM(l_count),   ",
                "               SUM(rtjb031)/SUM(l_count) ",
                " FROM adeq180_tmp ",
                " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003 ",
                " ORDER BY rtjbsite "
   END IF
   
#   LET l_sql1 = " SELECT UNIQUE rtjbsite,",
#                "               SUM(rtjb012), ",
#                "               SUM(l_original),",
#                "               SUM(rtjb031), ",
#                "               SUM(l_count),   ",
#                "               SUM(rtjb031)/SUM(l_count) ",
#                " FROM adeq180_tmp ",
#                " GROUP BY rtjbsite "

   #DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_rtjb1_pre4 FROM l_sql1
   DECLARE sel_rtjb1_cs4  CURSOR FOR sel_rtjb1_pre4   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs4 # USING g_enterprise 
                       INTO g_rtjb_d4[l_ac].l_rtjadocdt_4,
                            g_rtjb_d4[l_ac].l_bdate5,
                            g_rtjb_d4[l_ac].l_edate5,
                            g_rtjb_d4[l_ac].rtjbsite,
                            g_rtjb_d4[l_ac].rtjbsite_desc,
                            g_rtjb_d4[l_ac].rtjb012,     
                            g_rtjb_d4[l_ac].l_original_4,
                            g_rtjb_d4[l_ac].rtjb031,     
                            g_rtjb_d4[l_ac].l_count_4,   
                            g_rtjb_d4[l_ac].l_pct_4  

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d4.deleteElement(g_rtjb_d4.getLength())
   
   DISPLAY ARRAY g_rtjb_d4 TO s_detail5.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs4
END FUNCTION

 
{</section>}
 
