#該程式未解開Section, 採用最新樣板產出!
{<section id="artq409.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-07-02 17:45:49), PR版次:0006(2016-10-27 16:56:35)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: artq409
#+ Description: 商戶商品查詢
#+ Creator....: 06137(2016-05-12 11:46:07)
#+ Modifier...: 02439 -SD/PR- 08742
 
{</section>}
 
{<section id="artq409.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#9   2016/10/26  by 08742    组织开窗调整 
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
PRIVATE TYPE type_g_rtdx_d RECORD
       
       sel LIKE type_t.chr1, 
   rtem002 LIKE rtem_t.rtem002, 
   rtem002_desc LIKE type_t.chr500, 
   rtdx055 LIKE rtdx_t.rtdx055, 
   rtdx055_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_desc LIKE type_t.chr500, 
   rtdx001_desc_1 LIKE type_t.chr500, 
   imaf112 LIKE imaf_t.imaf112, 
   imaf112_desc LIKE type_t.chr500, 
   rtdx012 LIKE rtdx_t.rtdx012, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   imaa126 LIKE imaa_t.imaa126, 
   imaa126_desc LIKE type_t.chr500, 
   imaa127 LIKE imaa_t.imaa127, 
   imaa127_desc LIKE type_t.chr500, 
   imaa128 LIKE imaa_t.imaa128, 
   imaa128_desc LIKE type_t.chr500, 
   imaa129 LIKE imaa_t.imaa129, 
   imaa129_desc LIKE type_t.chr500, 
   rtdx056 LIKE rtdx_t.rtdx056, 
   rtdx057 LIKE rtdx_t.rtdx057, 
   rtdx058 LIKE rtdx_t.rtdx058, 
   rtdx059 LIKE rtdx_t.rtdx059, 
   rtdx060 LIKE rtdx_t.rtdx060, 
   rtdx034 LIKE rtdx_t.rtdx034, 
   rtdx016 LIKE rtdx_t.rtdx016, 
   rtdx017 LIKE rtdx_t.rtdx017, 
   rtdx018 LIKE rtdx_t.rtdx018, 
   rtdx019 LIKE rtdx_t.rtdx019, 
   rtdxstus LIKE rtdx_t.rtdxstus, 
   rtem004 LIKE rtem_t.rtem004, 
   rtem005 LIKE rtem_t.rtem005, 
   rtem006 LIKE rtem_t.rtem006, 
   rtem007 LIKE rtem_t.rtem007, 
   rtem008 LIKE rtem_t.rtem008, 
   rtem009 LIKE rtem_t.rtem009, 
   rtem010 LIKE rtem_t.rtem010, 
   rtem011 LIKE rtem_t.rtem011, 
   rtem012 LIKE rtem_t.rtem012, 
   rtem013 LIKE rtem_t.rtem013
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rtdxsite                LIKE type_t.chr500
DEFINE g_wc3                     STRING
DEFINE g_select_1                LIKE type_t.chr10
DEFINE g_select_2                LIKE type_t.chr10
DEFINE g_select_3                LIKE type_t.chr10
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtdx_d            DYNAMIC ARRAY OF type_g_rtdx_d
DEFINE g_rtdx_d_t          type_g_rtdx_d
 
 
 
 
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
 
{<section id="artq409.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success      LIKE type_t.num5   #161024-00025#9   2016/10/26  by 08742    Add
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
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
   DECLARE artq409_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artq409_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artq409_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artq409 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artq409_init()   
 
      #進入選單 Menu (="N")
      CALL artq409_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artq409
      
   END IF 
   
   CLOSE artq409_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success    #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artq409.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artq409_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 
   DEFINE l_success      LIKE type_t.num5   #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','7') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx017",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','8') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx018",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','9') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx019",l_gzcbl004)
   CALL cl_set_combo_scc('combobox_1','6933')
   CALL cl_set_combo_scc('combobox_2','6933')
   CALL cl_set_combo_scc('combobox_3','6933')
   CALL artq409_set_no_visible()
   CALL s_aooi500_create_temp() RETURNING l_success   #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point
 
   CALL artq409_default_search()
END FUNCTION
 
{</section>}
 
{<section id="artq409.default_search" >}
PRIVATE FUNCTION artq409_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtdxsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtdx001 = '", g_argv[02], "' AND "
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
 
{<section id="artq409.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artq409_ui_dialog() 
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
 
   
   CALL artq409_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtdx_d.clear()
 
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
 
         CALL artq409_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON rtem002,rtdx055,l_imaa009_1,imaa009,imaa126   #160513-00037#10 160519 by lori mod imaf153->rtem002
           
            ON ACTION controlp INFIELD rtem002          #160513-00037#10 160519 by lori mod imaf153->rtem002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()                       
               DISPLAY g_qryparam.return1 TO rtem002    #160513-00037#10 160519 by lori mod imaf153->rtem002
               NEXT FIELD rtem002                       #160513-00037#10 160519 by lori mod imaf153->rtem002
            
            ON ACTION controlp INFIELD rtdx055
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhbc001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdx055  #顯示到畫面上
               NEXT FIELD rtdx055                     #返回原欄位
               
            ON ACTION controlp INFIELD l_imaa009_1
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1=cl_get_para(g_enterprise,g_site,'E-CIR-0001')
               CALL q_rtax001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_imaa009_1  #顯示到畫面上
               NEXT FIELD l_imaa009_1                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa126
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()                           #呼叫開
               DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上
               NEXT FIELD imaa126                     #返回原欄位               
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc2 ON rtdxsite          
            BEFORE CONSTRUCT 
               LET g_rtdxsite = GET_FLDBUF(rtdxsite)
               
            ON ACTION controlp INFIELD rtdxsite
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdxsite',g_site,'c')
               CALL q_ooef001_24()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdxsite    #顯示到畫面上
               LET g_rtdxsite = GET_FLDBUF(rtdxsite)
               NEXT FIELD rtdxsite                    #返回原欄位
               
            AFTER CONSTRUCT 
               LET g_rtdxsite = GET_FLDBUF(rtdxsite)
         END CONSTRUCT        

         INPUT g_select_1,g_select_2,g_select_3 FROM combobox_1,combobox_2,combobox_3
         
         END INPUT
         CONSTRUCT BY NAME g_wc3 ON field1,field2,field3
             ON ACTION controlp INFIELD field1
                INITIALIZE g_qryparam.* TO NULL 
                LET g_qryparam.state = "c"
                LET g_qryparam.reqry = FALSE
                CASE g_select_1
                   WHEN 1
                      CALL q_imay001()
                   WHEN 2
                      CALL q_imaa001()
                   WHEN 3
                      CALL q_ooca001_1()
                   WHEN 5
                      LET g_qryparam.arg1='2003'
                      CALL q_oocq002()
                   WHEN 6
                      LET g_qryparam.arg1='2004'
                      CALL q_oocq002()
                   WHEN 7
                      LET g_qryparam.arg1='2005'
                      CALL q_oocq002()
                END CASE
                DISPLAY g_qryparam.return1 TO field1
                NEXT FIELD field1
             ON ACTION controlp INFIELD field2
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               CASE g_select_2
                   WHEN 1
                      CALL q_imay001()
                   WHEN 2
                      CALL q_imaa001()
                   WHEN 3
                      CALL q_ooca001_1()
                   WHEN 5
                      LET g_qryparam.arg1='2003'
                      CALL q_oocq002()
                   WHEN 6
                      LET g_qryparam.arg1='2004'
                      CALL q_oocq002()
                   WHEN 7
                      LET g_qryparam.arg1='2005'
                      CALL q_oocq002()
               END CASE
               DISPLAY g_qryparam.return1 TO field2
               NEXT FIELD field2
             ON ACTION controlp INFIELD field3
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               CASE g_select_3
                   WHEN 1
                      CALL q_imay001()
                   WHEN 2
                      CALL q_imaa001()
                   WHEN 3
                      CALL q_ooca001_1()
                   WHEN 5
                      LET g_qryparam.arg1='2003'
                      CALL q_oocq002()
                   WHEN 6
                      LET g_qryparam.arg1='2004'
                      CALL q_oocq002()
                   WHEN 7
                      LET g_qryparam.arg1='2005'
                      CALL q_oocq002()
               END CASE
               DISPLAY g_qryparam.return1 TO field3
               NEXT FIELD field3

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_rtdx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL artq409_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL artq409_b_fill2()
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
            CALL artq409_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert", FALSE) 
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)            
            DISPLAY g_site TO rtdxsite
            LET g_select_1=1
            LET g_select_2=2
            LET g_select_3=3            
            DISPLAY g_select_1 TO combobox_1
            DISPLAY g_select_2 TO combobox_2
            DISPLAY g_select_3 TO combobox_3
            #end add-point
            NEXT FIELD rtdxsite
 
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
            CALL artq409_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtdx_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL artq409_b_fill()
 
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
            CALL artq409_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL artq409_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL artq409_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL artq409_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               LET g_rtdx_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               LET g_rtdx_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtdx_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtdx_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artq409_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION plsh
            LET g_action_choice="plsh"
            IF cl_auth_chk_act("plsh") THEN
               
               #add-point:ON ACTION plsh name="menu.plsh"
             IF cl_ask_confirm('art-00785') THEN
                if cl_ask_confirm('art-00786')  then 
                   call artq409_plsh()
                else
                    return 
                end if 
            else 
                return  
            end if 
               #END add-point
               
               
            END IF
 
 
 
 
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
 
{<section id="artq409.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artq409_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ooef019         LIKE ooef_t.ooef019
   DEFINE l_where           STRING
   DEFINE l_wd              LIKE gzcb_t.gzcb003
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtdxsite') RETURNING l_where
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
 
   CALL g_rtdx_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
    SELECT gzcb003 INTO l_wd FROM gzcb_t WHERE gzcb001='6933' AND gzcb002=g_select_1
    LET g_wc3=cl_replace_str(g_wc3, 'field1',l_wd)
   
    SELECT gzcb003 INTO l_wd FROM gzcb_t WHERE gzcb001='6933' AND gzcb002=g_select_2
    LET g_wc3=cl_replace_str(g_wc3, 'field2',l_wd)
   
    SELECT gzcb003 INTO l_wd FROM gzcb_t WHERE gzcb001='6933' AND gzcb002=g_select_3
    LET g_wc3=cl_replace_str(g_wc3, 'field3',l_wd)
    
    IF NOT cl_null(g_wc3) THEN
       LET ls_wc=ls_wc," AND rtdx003 = '5' AND ",l_where," AND ",g_wc3
    ELSE
       LET ls_wc=ls_wc," AND rtdx003 = '5' AND ",l_where
    END IF
    LET ls_wc = cl_str_replace(ls_wc,"l_imaa009_1","rtaw001")
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','',rtdx055,'',rtdx002,rtdx001,'','','','',rtdx012,'','','', 
       '','','','','','','',rtdx056,rtdx057,rtdx058,rtdx059,rtdx060,rtdx034,rtdx016,rtdx017,rtdx018, 
       rtdx019,rtdxstus,'','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY rtdx_t.rtdxsite, 
       rtdx_t.rtdx001) AS RANK FROM rtdx_t",
 
 
                     "",
                     " WHERE rtdxent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtdx_t"),
                     " ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001"
 
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
 
   LET g_sql = "SELECT '','','',rtdx055,'',rtdx002,rtdx001,'','','','',rtdx012,'','','','','','','', 
       '','','',rtdx056,rtdx057,rtdx058,rtdx059,rtdx060,rtdx034,rtdx016,rtdx017,rtdx018,rtdx019,rtdxstus, 
       '','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql =#"SELECT 'N' , rtdx002,rtdx001, ",     #160513-00037#10 160519 by lori mark
              #160513-00037#10 160519 by lori add---(S) 
               "SELECT 'N' , rtem002, ",
               "      (SELECT pmaal004 FROM pmaal_t ",
               "        WHERE pmaalent = rtement AND pmaal001 = rtem002 AND pmaal002 = '",g_dlang,"') rtem002_desc, ",
               "       rtdx055 , ",
               "      (SELECT mhbel003 FROM mhbel_t ",
               "        WHERE mhbelent = rtdxent AND mhbel001 = rtdx055 AND mhbel002 = '",g_dlang,"') rtdx055_desc, ",
               "      rtdx002, rtdx001, ",
              #160513-00037#10 160519 by lori add---(E)  
               "      (SELECT imaal003 FROM imaal_t  ",
               "        WHERE imaalent = rtdxent AND imaal001 = rtdx001 AND imaal002 = '",g_dlang,"') imaal003, ",
               "      (SELECT imaal004 FROM imaal_t ",
               "        WHERE imaalent = rtdxent AND imaal001 = rtdx001 AND imaal002 = '",g_dlang,"') imaal004, ",
               "      imaf112, ",
               "      (SELECT oocal003 FROM oocal_t ",
               "        WHERE oocalent = imafent AND oocal001 = imaf112 AND oocal002 = '",g_dlang,"') imaf112_desc, ",
               "      rtdx012,imaa009, ",
               "      (SELECT rtaxl003 FROM rtaxl_t ",
               "        WHERE rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') imaa009_desc, ",
               "      imaa126, ",
               "      (SELECT oocql004 FROM oocql_t ",
               "        WHERE oocqlent = imaaent AND oocql001 = '2002' AND oocql002 = imaa126 AND oocql003 = '",g_dlang,"') imaa126_desc, ",
               "      imaa127, ",
               "      (SELECT oocql004 FROM oocql_t ",
               "        WHERE oocqlent = imaaent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"') imaa127_desc, ",               
               "      imaa128, ",
               "      (SELECT oocql004 FROM oocql_t ",
               "        WHERE oocqlent = imaaent AND oocql001 = '2004' AND oocql002 = imaa128 AND oocql003 = '",g_dlang,"') imaa128_desc, ",               
               "      imaa129, ",
               "      (SELECT oocql004 FROM oocql_t ",
               "        WHERE oocqlent = imaaent AND oocql001 = '2005' AND oocql002 = imaa129 AND oocql003 = '",g_dlang,"') imaa129_desc, ",               
              #"      imaa130,rtdx034,rtdx016,rtdx017,rtdx018, ",   #160513-00037#4  160517 by lori mark
              #"      rtdx056,rtdx057,rtdx034,rtdx016,rtdx017, ",   #160513-00037#4  160517 by lori add #160513-00037#17 160531 by Hans mark
               "      rtdx056,rtdx057,rtdx058,rtdx059,rtdx060, ",   #160513-00037#17 160531 by Hans add 
               "      rtdx034,rtdx016,rtdx017, ",                   #160513-00037#17 160531 by Hans add
               "      rtdx018,rtdx019,rtdxstus, ",                   #160513-00037#4  160517 by lori mod
               "      rtem004,rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013 ", #160604-00009#126 add by lvjh
               #"  FROM rtdx_t,imaa_t,imaf_t,rtaw_t,rtem_t ",       #160513-00037#10 160519 by lori add rtem_t #160528-00002 20160528 mark by beckxie
               #160528-00002 20160528 add by beckxie---S
               "  FROM rtdx_t,imaa_t ",   
               "              LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 AND rtaw003 = '",cl_get_para(g_enterprise,g_site,'E-CIR-0001'),"' ",
               #160528-00002 20160528 add by beckxie---E
               "       ,imaf_t,rtem_t ",        #160528-00002 20160528 add by beckxie
               " WHERE rtdxent  = imaaent ",
               "   AND rtdx001  = imaa001 ",
               "   AND rtdxent  = imafent ",                       
               "   AND rtdxsite = imafsite ",                      
               "   AND rtdx001  = imaf001 ",                       
               #"   AND imaaent  = rtawent ",                       #160528-00002 20160528 mark by beckxie
               #"   AND imaa009  = rtaw002 ",                       #160528-00002 20160528 mark by beckxie
               "   AND rtdxent  = rtement ",                        #160513-00037#10 160519 by lori add 
               "   AND rtdxsite = rtemsite ",                       #160513-00037#10 160519 by lori add 
               "   AND rtdx055  = rtem001 ",                        #160513-00037#10 160519 by lori add 
               "   AND rtdx001  = rtem003 ",                        #160513-00037#10 160519 by lori add 
               "   AND imaf153  = rtem002 ",                        #160513-00037#10 160519 by lori add 
               #"   AND rtaw003 = '",cl_get_para(g_enterprise,g_site,'E-CIR-0001'),"'",   #160528-00002 20160528 mark by beckxie
               "   AND rtdxent= ? AND 1=1 AND ", ls_wc
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq409_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artq409_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtdx_d[l_ac].sel,g_rtdx_d[l_ac].rtem002,g_rtdx_d[l_ac].rtem002_desc,g_rtdx_d[l_ac].rtdx055, 
       g_rtdx_d[l_ac].rtdx055_desc,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx001_desc, 
       g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].imaf112,g_rtdx_d[l_ac].imaf112_desc,g_rtdx_d[l_ac].rtdx012, 
       g_rtdx_d[l_ac].imaa009,g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc, 
       g_rtdx_d[l_ac].imaa127,g_rtdx_d[l_ac].imaa127_desc,g_rtdx_d[l_ac].imaa128,g_rtdx_d[l_ac].imaa128_desc, 
       g_rtdx_d[l_ac].imaa129,g_rtdx_d[l_ac].imaa129_desc,g_rtdx_d[l_ac].rtdx056,g_rtdx_d[l_ac].rtdx057, 
       g_rtdx_d[l_ac].rtdx058,g_rtdx_d[l_ac].rtdx059,g_rtdx_d[l_ac].rtdx060,g_rtdx_d[l_ac].rtdx034,g_rtdx_d[l_ac].rtdx016, 
       g_rtdx_d[l_ac].rtdx017,g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdxstus, 
       g_rtdx_d[l_ac].rtem004,g_rtdx_d[l_ac].rtem005,g_rtdx_d[l_ac].rtem006,g_rtdx_d[l_ac].rtem007,g_rtdx_d[l_ac].rtem008, 
       g_rtdx_d[l_ac].rtem009,g_rtdx_d[l_ac].rtem010,g_rtdx_d[l_ac].rtem011,g_rtdx_d[l_ac].rtem012,g_rtdx_d[l_ac].rtem013 
 
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
 
      CALL artq409_detail_show("'1'")
 
      CALL artq409_rtdx_t_mask()
 
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
 
   CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtdx_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE artq409_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL artq409_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL artq409_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtdx_d.getLength() > 0 THEN
      CALL artq409_b_fill2()
   END IF
 
      CALL artq409_filter_show('rtem002','b_rtem002')
   CALL artq409_filter_show('rtdx055','b_rtdx055')
   CALL artq409_filter_show('rtdx002','b_rtdx002')
   CALL artq409_filter_show('rtdx001','b_rtdx001')
   CALL artq409_filter_show('imaf112','b_imaf112')
   CALL artq409_filter_show('rtdx012','b_rtdx012')
   CALL artq409_filter_show('imaa009','b_imaa009')
   CALL artq409_filter_show('imaa126','b_imaa126')
   CALL artq409_filter_show('imaa127','b_imaa127')
   CALL artq409_filter_show('imaa128','b_imaa128')
   CALL artq409_filter_show('imaa129','b_imaa129')
   CALL artq409_filter_show('rtdx056','b_rtdx056')
   CALL artq409_filter_show('rtdx057','b_rtdx057')
   CALL artq409_filter_show('rtdx058','b_rtdx058')
   CALL artq409_filter_show('rtdx059','b_rtdx059')
   CALL artq409_filter_show('rtdx060','b_rtdx060')
   CALL artq409_filter_show('rtdx034','b_rtdx034')
   CALL artq409_filter_show('rtdx016','b_rtdx016')
   CALL artq409_filter_show('rtdx017','b_rtdx017')
   CALL artq409_filter_show('rtdx018','b_rtdx018')
   CALL artq409_filter_show('rtdx019','b_rtdx019')
   CALL artq409_filter_show('rtdxstus','b_rtdxstus')
   CALL artq409_filter_show('rtem004','b_rtem004')
   CALL artq409_filter_show('rtem005','b_rtem005')
   CALL artq409_filter_show('rtem006','b_rtem006')
   CALL artq409_filter_show('rtem007','b_rtem007')
   CALL artq409_filter_show('rtem008','b_rtem008')
   CALL artq409_filter_show('rtem009','b_rtem009')
   CALL artq409_filter_show('rtem010','b_rtem010')
   CALL artq409_filter_show('rtem011','b_rtem011')
   CALL artq409_filter_show('rtem012','b_rtem012')
   CALL artq409_filter_show('rtem013','b_rtem013')
 
 
END FUNCTION
 
{</section>}
 
{<section id="artq409.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artq409_b_fill2()
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
 
{<section id="artq409.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artq409_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq409.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION artq409_filter()
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
      CONSTRUCT g_wc_filter ON rtem002,rtdx055,rtdx002,rtdx001,imaf112,rtdx012,imaa009,imaa126,imaa127, 
          imaa128,imaa129,rtdx056,rtdx057,rtdx058,rtdx059,rtdx060,rtdx034,rtdx016,rtdx017,rtdx018,rtdx019, 
          rtdxstus,rtem004,rtem005,rtem006,rtem007,rtem008,rtem009,rtem010,rtem011,rtem012,rtem013
                          FROM s_detail1[1].b_rtem002,s_detail1[1].b_rtdx055,s_detail1[1].b_rtdx002, 
                              s_detail1[1].b_rtdx001,s_detail1[1].b_imaf112,s_detail1[1].b_rtdx012,s_detail1[1].b_imaa009, 
                              s_detail1[1].b_imaa126,s_detail1[1].b_imaa127,s_detail1[1].b_imaa128,s_detail1[1].b_imaa129, 
                              s_detail1[1].b_rtdx056,s_detail1[1].b_rtdx057,s_detail1[1].b_rtdx058,s_detail1[1].b_rtdx059, 
                              s_detail1[1].b_rtdx060,s_detail1[1].b_rtdx034,s_detail1[1].b_rtdx016,s_detail1[1].b_rtdx017, 
                              s_detail1[1].b_rtdx018,s_detail1[1].b_rtdx019,s_detail1[1].b_rtdxstus, 
                              s_detail1[1].b_rtem004,s_detail1[1].b_rtem005,s_detail1[1].b_rtem006,s_detail1[1].b_rtem007, 
                              s_detail1[1].b_rtem008,s_detail1[1].b_rtem009,s_detail1[1].b_rtem010,s_detail1[1].b_rtem011, 
                              s_detail1[1].b_rtem012,s_detail1[1].b_rtem013
 
         BEFORE CONSTRUCT
                     DISPLAY artq409_filter_parser('rtem002') TO s_detail1[1].b_rtem002
            DISPLAY artq409_filter_parser('rtdx055') TO s_detail1[1].b_rtdx055
            DISPLAY artq409_filter_parser('rtdx002') TO s_detail1[1].b_rtdx002
            DISPLAY artq409_filter_parser('rtdx001') TO s_detail1[1].b_rtdx001
            DISPLAY artq409_filter_parser('imaf112') TO s_detail1[1].b_imaf112
            DISPLAY artq409_filter_parser('rtdx012') TO s_detail1[1].b_rtdx012
            DISPLAY artq409_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY artq409_filter_parser('imaa126') TO s_detail1[1].b_imaa126
            DISPLAY artq409_filter_parser('imaa127') TO s_detail1[1].b_imaa127
            DISPLAY artq409_filter_parser('imaa128') TO s_detail1[1].b_imaa128
            DISPLAY artq409_filter_parser('imaa129') TO s_detail1[1].b_imaa129
            DISPLAY artq409_filter_parser('rtdx056') TO s_detail1[1].b_rtdx056
            DISPLAY artq409_filter_parser('rtdx057') TO s_detail1[1].b_rtdx057
            DISPLAY artq409_filter_parser('rtdx058') TO s_detail1[1].b_rtdx058
            DISPLAY artq409_filter_parser('rtdx059') TO s_detail1[1].b_rtdx059
            DISPLAY artq409_filter_parser('rtdx060') TO s_detail1[1].b_rtdx060
            DISPLAY artq409_filter_parser('rtdx034') TO s_detail1[1].b_rtdx034
            DISPLAY artq409_filter_parser('rtdx016') TO s_detail1[1].b_rtdx016
            DISPLAY artq409_filter_parser('rtdx017') TO s_detail1[1].b_rtdx017
            DISPLAY artq409_filter_parser('rtdx018') TO s_detail1[1].b_rtdx018
            DISPLAY artq409_filter_parser('rtdx019') TO s_detail1[1].b_rtdx019
            DISPLAY artq409_filter_parser('rtdxstus') TO s_detail1[1].b_rtdxstus
            DISPLAY artq409_filter_parser('rtem004') TO s_detail1[1].b_rtem004
            DISPLAY artq409_filter_parser('rtem005') TO s_detail1[1].b_rtem005
            DISPLAY artq409_filter_parser('rtem006') TO s_detail1[1].b_rtem006
            DISPLAY artq409_filter_parser('rtem007') TO s_detail1[1].b_rtem007
            DISPLAY artq409_filter_parser('rtem008') TO s_detail1[1].b_rtem008
            DISPLAY artq409_filter_parser('rtem009') TO s_detail1[1].b_rtem009
            DISPLAY artq409_filter_parser('rtem010') TO s_detail1[1].b_rtem010
            DISPLAY artq409_filter_parser('rtem011') TO s_detail1[1].b_rtem011
            DISPLAY artq409_filter_parser('rtem012') TO s_detail1[1].b_rtem012
            DISPLAY artq409_filter_parser('rtem013') TO s_detail1[1].b_rtem013
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_rtem002>>----
         #Ctrlp:construct.c.page1.b_rtem002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem002
            #add-point:ON ACTION controlp INFIELD b_rtem002 name="construct.c.filter.page1.b_rtem002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtem002  #顯示到畫面上
            NEXT FIELD b_rtem002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_rtem002_desc>>----
         #----<<b_rtdx055>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx055
            #add-point:ON ACTION controlp INFIELD b_rtdx055 name="construct.c.filter.page1.b_rtdx055"
            
            #END add-point
 
 
         #----<<b_rtdx055_desc>>----
         #----<<b_rtdx002>>----
         #Ctrlp:construct.c.page1.b_rtdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx002
            #add-point:ON ACTION controlp INFIELD b_rtdx002 name="construct.c.filter.page1.b_rtdx002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx002  #顯示到畫面上
            NEXT FIELD b_rtdx002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_rtdx001>>----
         #Ctrlp:construct.c.page1.b_rtdx001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx001
            #add-point:ON ACTION controlp INFIELD b_rtdx001 name="construct.c.filter.page1.b_rtdx001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx001  #顯示到畫面上
            NEXT FIELD b_rtdx001                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_rtdx001_desc>>----
         #----<<b_rtdx001_desc_1>>----
         #----<<b_imaf112>>----
         #Ctrlp:construct.c.page1.b_imaf112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf112
            #add-point:ON ACTION controlp INFIELD b_imaf112 name="construct.c.filter.page1.b_imaf112"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf112  #顯示到畫面上
            NEXT FIELD b_imaf112                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_imaf112_desc>>----
         #----<<b_rtdx012>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx012
            #add-point:ON ACTION controlp INFIELD b_rtdx012 name="construct.c.filter.page1.b_rtdx012"
            
            #END add-point
 
 
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.filter.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_imaa126>>----
         #Ctrlp:construct.c.page1.b_imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa126
            #add-point:ON ACTION controlp INFIELD b_imaa126 name="construct.c.filter.page1.b_imaa126"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa126  #顯示到畫面上
            NEXT FIELD b_imaa126                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_imaa126_desc>>----
         #----<<b_imaa127>>----
         #Ctrlp:construct.c.page1.b_imaa127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa127
            #add-point:ON ACTION controlp INFIELD b_imaa127 name="construct.c.filter.page1.b_imaa127"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2003'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa127  #顯示到畫面上
            NEXT FIELD b_imaa127                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_imaa127_desc>>----
         #----<<b_imaa128>>----
         #Ctrlp:construct.c.page1.b_imaa128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa128
            #add-point:ON ACTION controlp INFIELD b_imaa128 name="construct.c.filter.page1.b_imaa128"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2004'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa128  #顯示到畫面上
            NEXT FIELD b_imaa128                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_imaa128_desc>>----
         #----<<b_imaa129>>----
         #Ctrlp:construct.c.page1.b_imaa129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa129
            #add-point:ON ACTION controlp INFIELD b_imaa129 name="construct.c.filter.page1.b_imaa129"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2005'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa129  #顯示到畫面上
            NEXT FIELD b_imaa129                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_imaa129_desc>>----
         #----<<b_rtdx056>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx056
            #add-point:ON ACTION controlp INFIELD b_rtdx056 name="construct.c.filter.page1.b_rtdx056"
            
            #END add-point
 
 
         #----<<b_rtdx057>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx057
            #add-point:ON ACTION controlp INFIELD b_rtdx057 name="construct.c.filter.page1.b_rtdx057"
            
            #END add-point
 
 
         #----<<b_rtdx058>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx058
            #add-point:ON ACTION controlp INFIELD b_rtdx058 name="construct.c.filter.page1.b_rtdx058"
            
            #END add-point
 
 
         #----<<b_rtdx059>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx059
            #add-point:ON ACTION controlp INFIELD b_rtdx059 name="construct.c.filter.page1.b_rtdx059"
            
            #END add-point
 
 
         #----<<b_rtdx060>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx060
            #add-point:ON ACTION controlp INFIELD b_rtdx060 name="construct.c.filter.page1.b_rtdx060"
            
            #END add-point
 
 
         #----<<b_rtdx034>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx034
            #add-point:ON ACTION controlp INFIELD b_rtdx034 name="construct.c.filter.page1.b_rtdx034"
            
            #END add-point
 
 
         #----<<b_rtdx016>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx016
            #add-point:ON ACTION controlp INFIELD b_rtdx016 name="construct.c.filter.page1.b_rtdx016"
            
            #END add-point
 
 
         #----<<b_rtdx017>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx017
            #add-point:ON ACTION controlp INFIELD b_rtdx017 name="construct.c.filter.page1.b_rtdx017"
            
            #END add-point
 
 
         #----<<b_rtdx018>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx018
            #add-point:ON ACTION controlp INFIELD b_rtdx018 name="construct.c.filter.page1.b_rtdx018"
            
            #END add-point
 
 
         #----<<b_rtdx019>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx019
            #add-point:ON ACTION controlp INFIELD b_rtdx019 name="construct.c.filter.page1.b_rtdx019"
            
            #END add-point
 
 
         #----<<b_rtdxstus>>----
         #Ctrlp:construct.c.filter.page1.b_rtdxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxstus
            #add-point:ON ACTION controlp INFIELD b_rtdxstus name="construct.c.filter.page1.b_rtdxstus"
            
            #END add-point
 
 
         #----<<b_rtem004>>----
         #Ctrlp:construct.c.filter.page1.b_rtem004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem004
            #add-point:ON ACTION controlp INFIELD b_rtem004 name="construct.c.filter.page1.b_rtem004"
            
            #END add-point
 
 
         #----<<b_rtem005>>----
         #Ctrlp:construct.c.filter.page1.b_rtem005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem005
            #add-point:ON ACTION controlp INFIELD b_rtem005 name="construct.c.filter.page1.b_rtem005"
            
            #END add-point
 
 
         #----<<b_rtem006>>----
         #Ctrlp:construct.c.filter.page1.b_rtem006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem006
            #add-point:ON ACTION controlp INFIELD b_rtem006 name="construct.c.filter.page1.b_rtem006"
            
            #END add-point
 
 
         #----<<b_rtem007>>----
         #Ctrlp:construct.c.filter.page1.b_rtem007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem007
            #add-point:ON ACTION controlp INFIELD b_rtem007 name="construct.c.filter.page1.b_rtem007"
            
            #END add-point
 
 
         #----<<b_rtem008>>----
         #Ctrlp:construct.c.filter.page1.b_rtem008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem008
            #add-point:ON ACTION controlp INFIELD b_rtem008 name="construct.c.filter.page1.b_rtem008"
            
            #END add-point
 
 
         #----<<b_rtem009>>----
         #Ctrlp:construct.c.filter.page1.b_rtem009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem009
            #add-point:ON ACTION controlp INFIELD b_rtem009 name="construct.c.filter.page1.b_rtem009"
            
            #END add-point
 
 
         #----<<b_rtem010>>----
         #Ctrlp:construct.c.filter.page1.b_rtem010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem010
            #add-point:ON ACTION controlp INFIELD b_rtem010 name="construct.c.filter.page1.b_rtem010"
            
            #END add-point
 
 
         #----<<b_rtem011>>----
         #Ctrlp:construct.c.filter.page1.b_rtem011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem011
            #add-point:ON ACTION controlp INFIELD b_rtem011 name="construct.c.filter.page1.b_rtem011"
            
            #END add-point
 
 
         #----<<b_rtem012>>----
         #Ctrlp:construct.c.filter.page1.b_rtem012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem012
            #add-point:ON ACTION controlp INFIELD b_rtem012 name="construct.c.filter.page1.b_rtem012"
            
            #END add-point
 
 
         #----<<b_rtem013>>----
         #Ctrlp:construct.c.filter.page1.b_rtem013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtem013
            #add-point:ON ACTION controlp INFIELD b_rtem013 name="construct.c.filter.page1.b_rtem013"
            
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
 
      CALL artq409_filter_show('rtem002','b_rtem002')
   CALL artq409_filter_show('rtdx055','b_rtdx055')
   CALL artq409_filter_show('rtdx002','b_rtdx002')
   CALL artq409_filter_show('rtdx001','b_rtdx001')
   CALL artq409_filter_show('imaf112','b_imaf112')
   CALL artq409_filter_show('rtdx012','b_rtdx012')
   CALL artq409_filter_show('imaa009','b_imaa009')
   CALL artq409_filter_show('imaa126','b_imaa126')
   CALL artq409_filter_show('imaa127','b_imaa127')
   CALL artq409_filter_show('imaa128','b_imaa128')
   CALL artq409_filter_show('imaa129','b_imaa129')
   CALL artq409_filter_show('rtdx056','b_rtdx056')
   CALL artq409_filter_show('rtdx057','b_rtdx057')
   CALL artq409_filter_show('rtdx058','b_rtdx058')
   CALL artq409_filter_show('rtdx059','b_rtdx059')
   CALL artq409_filter_show('rtdx060','b_rtdx060')
   CALL artq409_filter_show('rtdx034','b_rtdx034')
   CALL artq409_filter_show('rtdx016','b_rtdx016')
   CALL artq409_filter_show('rtdx017','b_rtdx017')
   CALL artq409_filter_show('rtdx018','b_rtdx018')
   CALL artq409_filter_show('rtdx019','b_rtdx019')
   CALL artq409_filter_show('rtdxstus','b_rtdxstus')
   CALL artq409_filter_show('rtem004','b_rtem004')
   CALL artq409_filter_show('rtem005','b_rtem005')
   CALL artq409_filter_show('rtem006','b_rtem006')
   CALL artq409_filter_show('rtem007','b_rtem007')
   CALL artq409_filter_show('rtem008','b_rtem008')
   CALL artq409_filter_show('rtem009','b_rtem009')
   CALL artq409_filter_show('rtem010','b_rtem010')
   CALL artq409_filter_show('rtem011','b_rtem011')
   CALL artq409_filter_show('rtem012','b_rtem012')
   CALL artq409_filter_show('rtem013','b_rtem013')
 
 
   CALL artq409_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="artq409.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION artq409_filter_parser(ps_field)
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
 
{<section id="artq409.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION artq409_filter_show(ps_field,ps_object)
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
   LET ls_condition = artq409_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="artq409.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION artq409_detail_action_trans()
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
 
{<section id="artq409.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION artq409_detail_index_setting()
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
            IF g_rtdx_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtdx_d.getLength() AND g_rtdx_d.getLength() > 0
            LET g_detail_idx = g_rtdx_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtdx_d.getLength() THEN
               LET g_detail_idx = g_rtdx_d.getLength()
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
 
{<section id="artq409.mask_functions" >}
 &include "erp/art/artq409_mask.4gl"
 
{</section>}
 
{<section id="artq409.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 動態顯示選擇欄位
# Memo...........:
# Usage..........: CALL artq409_set_no_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-05-012 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artq409_set_no_visible()
   DEFINE l_gzcb002 LIKE gzcb_t.gzcb002
   DEFINE l_gzcb003 LIKE gzcb_t.gzcb003
   DEFINE l_str STRING
   DEFINE l_str1 STRING
   LET l_str=''
   LET l_str1=''
   DECLARE sel_gzcb002 CURSOR FOR SELECT gzcb002 FROM gzcb_t WHERE gzcb001='6933' AND gzcb006="Y"
   FOREACH sel_gzcb002 INTO l_gzcb002
      IF cl_null(l_str) THEN
         LET l_str= l_gzcb002
      ELSE
         LET l_str=l_str,",",l_gzcb002
      END IF
   END FOREACH
   CALL cl_set_combo_scc_part('combobox_1','6933',l_str)
   CALL cl_set_combo_scc_part('combobox_2','6933',l_str)
   CALL cl_set_combo_scc_part('combobox_3','6933',l_str)
   DECLARE sel_gzcb002_b CURSOR FOR SELECT gzcb003 FROM gzcb_t WHERE gzcb001='6933' AND gzcb006="N"
   FOREACH sel_gzcb002_b INTO l_gzcb003
      IF cl_null(l_str1) THEN
         LET l_str1= l_gzcb003,",",l_gzcb003,"_desc"
      ELSE
         LET l_str1=l_str1,",",l_gzcb003,",",l_gzcb003,"_desc"
      END IF
   END FOREACH
   CALL cl_set_comp_visible(l_str1,FALSE)
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
PRIVATE FUNCTION artq409_plsh()
DEFINE l_sql    STRING
DEFINE l_rtekdocno   LIKE rtek_t.rtekdocno
define l_cnt  LIKE type_t.num5
DEFINE li_idx   LIKE type_t.num5
DEFINE l_rtek   DYNAMIC ARRAY OF RECORD
      rtekdocno   LIKE rtek_t.rtekdocno
END RECORD

DEFINE l_msg       LIKE type_t.chr100
DEFINE l_success      LIKE type_t.num5

let l_sql="select rtekdocno  from rtek_t  where rtekent=? and rtekstus='N' order by rtekdocno"
   PREPARE astq409_sel_1 FROM l_sql
   DECLARE b_rtek_curs CURSOR FOR astq409_sel_1
   CALL l_rtek.clear()
   #DISPLAY "b_fill_curs[SQL] ",g_sql
   #end add-point
   LET g_cnt = l_ac
   LET l_ac = 1   
   #ERROR "Searching!" 
   FOREACH b_rtek_curs USING g_enterprise INTO  l_rtek[l_ac].rtekdocno
        IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
         END IF
         LET l_ac = l_ac + 1
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
   END FOREACH
  CALL cl_err_collect_init()
   DISPLAY '' ,0 TO stagenow,stagecomplete
   let l_cnt=l_ac-1
      IF cl_null(l_cnt)THEN LET l_cnt = 0 END IF
      CALL cl_progress_bar_no_window(l_cnt)
   #LET l_msg = cl_getmsg('ast-00330',g_lang)   
  # CALL cl_progress_no_window_ing(l_msg)
  FOR li_idx = 1 TO l_rtek.getLength()-1
   CALL cl_progress_no_window_ing(l_rtek[li_idx].rtekdocno)
   CALL s_artt409_conf_chk(l_rtek[li_idx].rtekdocno) RETURNING l_success
   IF l_success THEN
         CALL s_transaction_begin()   
         CALL s_artt409_conf_upd(l_rtek[li_idx].rtekdocno) RETURNING l_success
         #CALL cl_err_collect_show() 
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            #CONTINUE for 
          ELSE
             CALL s_transaction_end('Y','0')
          END IF
    ELSE
          #CONTINUE FOR             
    END IF
    end for     
    CALL cl_err_collect_show()
    CALL cl_ask_confirm3("std-00012","")
    #LET l_msg = cl_getmsg('std-00012',g_lang)
    #CALL cl_progress_no_window_ing(l_msg)
       

END FUNCTION

 
{</section>}
 
