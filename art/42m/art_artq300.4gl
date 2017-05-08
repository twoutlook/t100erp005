#該程式未解開Section, 採用最新樣板產出!
{<section id="artq300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-02-22 08:39:27), PR版次:0003(2016-03-14 16:34:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: artq300
#+ Description: 商品資料查詢作業
#+ Creator....: 06189(2015-02-27 10:10:42)
#+ Modifier...: 06137 -SD/PR- 04226
 
{</section>}
 
{<section id="artq300.global" >}
#應用 q01 樣板自動產生(Version:34)
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
 
#單身 type 宣告
PRIVATE TYPE type_g_imaa_d RECORD
       
       sel LIKE type_t.chr1, 
   imaa001 LIKE imaa_t.imaa001, 
   imaa001_desc LIKE type_t.chr500, 
   imaa001_desc_1 LIKE type_t.chr500, 
   imaa001_desc_2 LIKE type_t.chr500, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   imaa003 LIKE imaa_t.imaa003, 
   url_b_imaa003 STRING, 
   imaa003_desc LIKE type_t.chr500, 
   imaa108 LIKE imaa_t.imaa108, 
   imaa100 LIKE imaa_t.imaa100, 
   imaa014 LIKE imaa_t.imaa014, 
   imaa005 LIKE imaa_t.imaa005, 
   imaa005_desc LIKE type_t.chr500, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr500, 
   imaa105 LIKE imaa_t.imaa105, 
   imaa105_desc LIKE type_t.chr500, 
   imaa104 LIKE imaa_t.imaa104, 
   imaa104_desc LIKE type_t.chr500, 
   imaa107 LIKE imaa_t.imaa107, 
   imaa107_desc LIKE type_t.chr500, 
   imaa106 LIKE imaa_t.imaa106, 
   imaa106_desc LIKE type_t.chr500, 
   imaa145 LIKE imaa_t.imaa145, 
   imaa145_desc LIKE type_t.chr500, 
   imaa146 LIKE imaa_t.imaa146, 
   imaa146_desc LIKE type_t.chr500, 
   imaa113 LIKE imaa_t.imaa113, 
   imaa109 LIKE imaa_t.imaa109, 
   imaa019 LIKE imaa_t.imaa019, 
   imaa020 LIKE imaa_t.imaa020, 
   imaa021 LIKE imaa_t.imaa021, 
   imaa022 LIKE imaa_t.imaa022, 
   imaa022_desc LIKE type_t.chr500, 
   imaa025 LIKE imaa_t.imaa025, 
   imaa026 LIKE imaa_t.imaa026, 
   imaa026_desc LIKE type_t.chr500, 
   imaa017 LIKE imaa_t.imaa017, 
   imaa018 LIKE imaa_t.imaa018, 
   imaa018_desc LIKE type_t.chr500, 
   imaa102 LIKE imaa_t.imaa102, 
   imaa103 LIKE imaa_t.imaa103, 
   imaa118 LIKE imaa_t.imaa118, 
   imaa119 LIKE imaa_t.imaa119, 
   imaa120 LIKE imaa_t.imaa120, 
   imaa114 LIKE imaa_t.imaa114, 
   imaa114_desc LIKE type_t.chr500, 
   imaa124 LIKE imaa_t.imaa124, 
   imaa124_desc LIKE type_t.chr500, 
   imaa110 LIKE imaa_t.imaa110, 
   imaa111 LIKE imaa_t.imaa111, 
   imaa112 LIKE imaa_t.imaa112, 
   imaa125 LIKE imaa_t.imaa125, 
   imaa121 LIKE imaa_t.imaa121, 
   imaa122 LIKE imaa_t.imaa122, 
   imaa122_desc LIKE type_t.chr500, 
   imaa123 LIKE imaa_t.imaa123, 
   imaa131 LIKE imaa_t.imaa131, 
   imaa126 LIKE imaa_t.imaa126, 
   imaa126_desc LIKE type_t.chr500, 
   imaa127 LIKE imaa_t.imaa127, 
   imaa127_desc LIKE type_t.chr500, 
   imaa128 LIKE imaa_t.imaa128, 
   imaa128_desc LIKE type_t.chr500, 
   imaa129 LIKE imaa_t.imaa129, 
   imaa129_desc LIKE type_t.chr500, 
   imaa130 LIKE imaa_t.imaa130, 
   imaa143 LIKE imaa_t.imaa143, 
   imaa143_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imaa2_d RECORD
       imaa001 LIKE imaa_t.imaa001, 
   imay001 LIKE imay_t.imay001, 
   imay001_desc LIKE type_t.chr500, 
   imay001_desc_1 LIKE type_t.chr500, 
   imay001_desc_1_desc LIKE type_t.chr500, 
   imaystus LIKE imay_t.imaystus, 
   imay002 LIKE imay_t.imay002, 
   imay003 LIKE imay_t.imay003, 
   imay004 LIKE imay_t.imay004, 
   imay005 LIKE imay_t.imay005, 
   imay006 LIKE imay_t.imay006, 
   imay007 LIKE imay_t.imay007, 
   imay008 LIKE imay_t.imay008, 
   imay009 LIKE imay_t.imay009, 
   imay010 LIKE imay_t.imay010, 
   imay011 LIKE imay_t.imay011
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc3                  STRING
DEFINE g_detail_cnt1          LIKE type_t.num5  #单身2的笔数
DEFINE g_detail_cnt2          LIKE type_t.num5  #单身2的笔数

#end add-point
 
#模組變數(Module Variables)
DEFINE g_imaa_d            DYNAMIC ARRAY OF type_g_imaa_d
DEFINE g_imaa_d_t          type_g_imaa_d
DEFINE g_imaa2_d     DYNAMIC ARRAY OF type_g_imaa2_d
DEFINE g_imaa2_d_t   type_g_imaa2_d
 
 
 
 
 
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
 
{<section id="artq300.main" >}
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
   DECLARE artq300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artq300_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artq300_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artq300 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artq300_init()   
 
      #進入選單 Menu (="N")
      CALL artq300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artq300
      
   END IF 
   
   CLOSE artq300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artq300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artq300_init()
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
   
      CALL cl_set_combo_scc('b_imaa108','2002') 
   CALL cl_set_combo_scc('b_imaa100','2003') 
   CALL cl_set_combo_scc('b_imaa109','2004') 
   CALL cl_set_combo_scc('b_imay002','2003') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
 
   CALL artq300_default_search()
END FUNCTION
 
{</section>}
 
{<section id="artq300.default_search" >}
PRIVATE FUNCTION artq300_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " imaa001 = '", g_argv[01], "' AND "
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
 
{<section id="artq300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artq300_ui_dialog() 
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
   CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
   CALL cl_set_comp_visible("sel", FALSE)
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
 
   
   CALL artq300_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_imaa_d.clear()
         CALL g_imaa2_d.clear()
 
 
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
 
         CALL artq300_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #160126-00002#2 Add By Ken 160203(S)
         CONSTRUCT BY NAME g_wc  ON imaa001,imaa014,imaa009,imaa126,imaa127,imaal003

            ON ACTION controlp INFIELD imaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE                        
              
               CALL q_imaa001()#呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            
               NEXT FIELD imaa001  
            
            
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE                        
              
               CALL q_rtax001()#呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            
               NEXT FIELD imaa009    
        
            ON ACTION controlp INFIELD imaa126
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
		       	LET g_qryparam.reqry = FALSE                        
                LET g_qryparam.arg1 = '2002' 
                CALL q_oocq002()#呼叫開窗
                DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上
            
                NEXT FIELD imaa126    
               
            ON ACTION controlp INFIELD imaa127
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
		       	LET g_qryparam.reqry = FALSE                        
                LET g_qryparam.arg1 = '2003' 
                CALL q_oocq002()#呼叫開窗
                DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上
            
                NEXT FIELD imaa127    
                   
             
         END CONSTRUCT 
         #160126-00002#2 Add By Ken 160203(E)
         #end add-point
     
         DISPLAY ARRAY g_imaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL artq300_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL artq300_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_imaa_d.getLength() TO FORMONLY.h_count
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aimi100
                  LET g_action_choice="prog_aimi100"
                  IF cl_auth_chk_act("prog_aimi100") THEN
                     
                     #add-point:ON ACTION prog_aimi100 name="menu.detail_show.page1_sub.prog_aimi100"
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aimi100'
                     LET la_param.param[1] = g_imaa_d[g_detail_idx].imaa003    #151027-00016#4 151112 by lori add g_detail_idx
                     
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_imaa2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               LET g_detail_cnt2 = g_imaa2_d.getLength()
               DISPLAY g_detail_cnt2 TO FORMONLY.h_count    
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
              
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL artq300_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            CALL cl_set_act_visible("query,insert", FALSE)   #160126-00002#2 Add By Ken 160203         
            #NEXT FIELD sel                                  #160126-00002#2 Mark By Ken 160203
            #end add-point
            NEXT FIELD imaa001
 
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
            #160307-00023#2 160314 By pomelo add(S)
            IF g_imaa_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", 1)
            END IF
            #160307-00023#2 160314 By pomelo add(E)
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL artq300_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_imaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_imaa2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL artq300_b_fill()
 
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
            CALL artq300_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL artq300_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL artq300_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL artq300_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_imaa_d.getLength()
               LET g_imaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_imaa_d.getLength()
               LET g_imaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_imaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_imaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_imaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_imaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artq300_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
               CALL artq300_query()
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
 
{<section id="artq300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artq300_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_wc2 = " 1=2" THEN
      LET g_wc2 = " 1=1"
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
 
   CALL g_imaa_d.clear()
   CALL g_imaa2_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET g_wc3 = ls_wc
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',imaa001,'','','',imaa009,'',imaa003,'',imaa108,imaa100,imaa014, 
       imaa005,'',imaa006,'',imaa105,'',imaa104,'',imaa107,'',imaa106,'',imaa145,'',imaa146,'',imaa113, 
       imaa109,imaa019,imaa020,imaa021,imaa022,'',imaa025,imaa026,'',imaa017,imaa018,'',imaa102,imaa103, 
       imaa118,imaa119,imaa120,imaa114,'',imaa124,'',imaa110,imaa111,imaa112,imaa125,imaa121,imaa122, 
       '',imaa123,imaa131,imaa126,'',imaa127,'',imaa128,'',imaa129,'',imaa130,imaa143,'','','','','', 
       '','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY imaa_t.imaa001) AS RANK FROM imaa_t", 
 
 
 
                     " LEFT JOIN imay_t ON imaa001 = imay003",
                     " WHERE imaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("imaa_t"),
                     " ORDER BY imaa_t.imaa001"
 
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
 
   LET g_sql = "SELECT '',imaa001,'','','',imaa009,'',imaa003,'',imaa108,imaa100,imaa014,imaa005,'', 
       imaa006,'',imaa105,'',imaa104,'',imaa107,'',imaa106,'',imaa145,'',imaa146,'',imaa113,imaa109, 
       imaa019,imaa020,imaa021,imaa022,'',imaa025,imaa026,'',imaa017,imaa018,'',imaa102,imaa103,imaa118, 
       imaa119,imaa120,imaa114,'',imaa124,'',imaa110,imaa111,imaa112,imaa125,imaa121,imaa122,'',imaa123, 
       imaa131,imaa126,'',imaa127,'',imaa128,'',imaa129,'',imaa130,imaa143,'','','','','','','','','', 
       '','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET g_sql = "SELECT  UNIQUE '',imaa001,imaa009,'','','',imaa003,'',imaa108,imaa100,imaa014,imaa005, 
#       '',imaa006,'',imaa105,'',imaa104,'',imaa107,'',imaa106,'',imaa145,'',imaa146,'',imaa113,imaa109, 
#       imaa019,imaa020,imaa021,imaa022,'',imaa025,imaa026,'',imaa017,imaa018,'',imaa102,imaa103,imaa118, 
#       imaa119,imaa120,imaa114,'',imaa124,'',imaa110,imaa111,imaa112,imaa125,imaa121,imaa122,'',imaa123, 
#       imaa131,imaa126,'',imaa127,'',imaa128,'',imaa129,'',imaa130,imaa143,'',imaa001,'','','','','', 
#       '','','','','','','','','' FROM imaa_t,imaal_t",
# 
# 
#              
#               " WHERE imaaent= ? AND 1=1  ",
#               " AND imaaent = imaalent ",
#               " AND imaa001 = imaal001",
#               " AND imaal002 = '",g_dlang,"'  AND ",ls_wc

       #160224-00020#1 2016/03/03 s983961--mark(s)
       #LET g_sql = "SELECT  UNIQUE '',imaa001,imaal003,imaal004,imaal005,imaa009,rtaxl003,imaa003,imckl003,imaa108,imaa100,imaa014,imaa005, 
       #t1.oocql004,imaa006,t2.oocal003,imaa105,t4.oocal003,imaa104,t3.oocal003,imaa107,t5.oocal003,imaa106,t6.oocal003,imaa145,t7.oocal003,imaa146,t8.oocal003,imaa113,imaa109, 
       #imaa019,imaa020,imaa021,imaa022,t9.oocal003,imaa025,imaa026,t10.oocal003,imaa017,imaa018,t11.oocal003,imaa102,imaa103,imaa118, 
       #imaa119,imaa120,imaa114,ooail003,imaa124,oodbl004,imaa110,imaa111,imaa112,imaa125,imaa121,imaa122,t12.oocql004,imaa123, 
       #imaa131,imaa126,t13.oocql004,imaa127,t14.oocql004,imaa128,t15.oocql004,imaa129,t16.oocql004,imaa130,imaa143,dbbal003,imaa001,'','','','','', 
       #'','','','','','','','','' FROM imaa_t",
       #        " LEFT JOIN rtaxl_t ON imaaent = rtaxlent AND imaa009 = rtaxl001 AND rtaxl002='"||g_dlang||"'  ",
       #        " LEFT JOIN imckl_t ON imaa003 = imckl001 AND imckl002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocql_t t1 ON t1.oocql001 ='211'   AND t1.oocqlent = imaaent  AND t1.oocql002 = imaa005 AND t1.oocql003='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t2 ON t2.oocal001 = imaa006 AND t2.oocalent = imaaent AND t2.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t3 ON t3.oocal001 = imaa104 AND t3.oocalent = imaaent AND t3.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t4 ON t4.oocal001 = imaa105 AND t4.oocalent = imaaent AND t4.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t5 ON t5.oocal001 = imaa107 AND t5.oocalent = imaaent AND t5.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t6 ON t6.oocal001 = imaa106 AND t6.oocalent = imaaent AND t6.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t7 ON t7.oocal001 = imaa145 AND t7.oocalent = imaaent AND t7.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t8 ON t8.oocal001 = imaa146 AND t8.oocalent = imaaent AND t8.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t9 ON t9.oocal001 = imaa022 AND t9.oocalent = imaaent AND t9.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t10 ON t10.oocal001 = imaa026 AND t10.oocalent = imaaent AND t10.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN oocal_t t11 ON t11.oocal001 = imaa018 AND t11.oocalent = imaaent AND t11.oocal002='"||g_dlang||"'  ",
       #        " LEFT JOIN ooail_t  ON ooail001 = imaa114 AND ooailent = imaaent AND ooail003='"||g_dlang||"'  ",
       #        " LEFT JOIN oodbl_t  ON oodbl002 = imaa124 AND oodblent = imaaent AND ooail003='"||g_dlang||"'  ",
       #        " LEFT JOIN oocql_t t12 ON t12.oocql001 ='2000'    AND t12.oocqlent = imaaent AND t12.oocql002 = imaa122 AND t12.oocql003='"||g_dlang||"'  ",
       #        " LEFT JOIN oocql_t t13 ON t13.oocql001 ='2002'    AND t13.oocqlent = imaaent AND t13.oocql002 = imaa126 AND t13.oocql003='"||g_dlang||"'  ",
       #        " LEFT JOIN oocql_t t14 ON t14.oocql001 ='2003'    AND t14.oocqlent = imaaent AND t14.oocql002 = imaa127 AND t14.oocql003='"||g_dlang||"'  ",
       #        " LEFT JOIN oocql_t t15 ON t15.oocql001 ='2004'    AND t15.oocqlent = imaaent AND t15.oocql002 = imaa128 AND t15.oocql003='"||g_dlang||"'  ",
       #        " LEFT JOIN oocql_t t16 ON t16.oocql001 ='2005'    AND t16.oocqlent = imaaent AND t16.oocql002 = imaa129 AND t16.oocql003='"||g_dlang||"'  ",  
       #        " LEFT JOIN dbbal_t  ON    dbbal001 = imaa143 AND dbbal002='"||g_dlang||"'  ",                 
       #        " LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 ",
       #        " AND imaal002 = '",g_dlang,"' ",
       #        " WHERE imaaent= ? AND 1=1   AND ",ls_wc
       #160224-00020#1 2016/03/03 s983961--mark(e)
       
       #160224-00020#1 2016/03/03 s983961--add(s)
       LET g_sql = " SELECT  UNIQUE '',imaa001,imaal003,imaal004,imaal005, ",
                   "                   imaa009, ",
                   "                   (SELECT rtaxl003",
                   "                      FROM rtaxl_t",
                   "                     WHERE rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') , ",
                   "                   imaa003, ",
                   "                   (SELECT imckl003",
                   "                      FROM imckl_t",
                   "                     WHERE imcklent = imaaent AND imckl001 = imaa003 AND imckl002 = '",g_dlang,"') , ",
                   "                   imaa108,imaa100,imaa014,imaa005, ", 
                   "                   (SELECT oocql004",
                   "                      FROM oocql_t",
                   "                     WHERE oocqlent = imaaent AND oocql001 = '211'",
                   "                       AND oocql002 = imaa005 AND oocql003 = '",g_dlang,"'), ",
                   "                   imaa006, ",                   
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa006 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa105, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa105 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa104, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa104 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa107, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa107 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa106, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa106 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa145, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa145 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa146, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa146 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa113,imaa109,imaa019, ", 
                   "                   imaa020,imaa021,imaa022, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa022 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa025,imaa026, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa026 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa017,imaa018, ",
                   "                   (SELECT oocal003",
                   "                      FROM oocal_t",
                   "                     WHERE oocalent = imaaent AND oocal001 = imaa018 ",
                   "                       AND oocal002 = '",g_dlang,"'), ",
                   "                   imaa102,imaa103,imaa118, ",
                   "                   imaa119,imaa120,imaa114, ",
                   "                   (SELECT ooail003",
                   "                      FROM ooail_t",
                   "                     WHERE ooailent = imaaent AND ooail001 = imaa114 ",
                   "                       AND ooail003 = '",g_dlang,"'), ",
                   "                   imaa124, ",
                   "                   (SELECT oodbl004",
                   "                      FROM oodbl_t,ooef_t ",
                   "                     WHERE ooefent = oodblent AND ooef001 ='",g_site,"' AND oodblent = imaaent AND oodbl002 = imaa124 AND oodbl001 = ooef019 AND oodbl003 = '",g_dlang,"'), ",
                   "                   imaa110,imaa111,imaa112,imaa125,imaa121,imaa122, ",
                   "                   (SELECT oocql004",
                   "                      FROM oocql_t",
                   "                     WHERE oocqlent = imaaent AND oocql001 = '2000' AND oocql002 = imaa122 AND oocql003 = '",g_dlang,"'), ",
                   "                   imaa123,imaa131,imaa126, ", 
                   "                   (SELECT oocql004",
                   "                      FROM oocql_t",
                   "                     WHERE oocqlent = imaaent AND oocql001 = '2002' AND oocql002 = imaa126 AND oocql003 = '",g_dlang,"'), ",
                   "                   imaa127, ",
                   "                   (SELECT oocql004",
                   "                      FROM oocql_t",
                   "                     WHERE oocqlent = imaaent AND oocql001 = '2003' AND oocql002 = imaa127 AND oocql003 = '",g_dlang,"'), ",
                   "                   imaa128, ",
                   "                   (SELECT oocql004",
                   "                      FROM oocql_t",
                   "                     WHERE oocqlent = imaaent AND oocql001 = '2004' AND oocql002 = imaa128 AND oocql003 = '",g_dlang,"'), ",
                   "                   imaa129, ",
                   "                   (SELECT oocql004",
                   "                      FROM oocql_t",
                   "                     WHERE oocqlent = imaaent AND oocql001 = '2005' AND oocql002 = imaa129 AND oocql003 = '",g_dlang,"'), ",
                   "                   imaa130,imaa143, ",
                   "                   (SELECT dbbal003",
                   "                      FROM dbbal_t",
                   "                     WHERE dbbalent=imaaent AND dbbal001 = imaa143 AND dbbal002 = '",g_dlang,"'), ",
                   "                   imaa001,'','','','','','','','','','','','','','' ",         
                   "   FROM imaa_t",                           
                   "   LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"' ",
                   " WHERE imaaent= ? AND 1=1   AND ",ls_wc
        #160224-00020#1 2016/03/03 s983961--add(e)
        
#       LET g_sql = "SELECT  UNIQUE '',imaa001,'','','',imaa009,'',imaa003,'',imaa108,imaa100,imaa014,imaa005, 
#       '',imaa006,'',imaa105,'',imaa104,'',imaa107,'',imaa106,'',imaa145,'',imaa146,'',imaa113,imaa109, 
#       imaa019,imaa020,imaa021,imaa022,'',imaa025,imaa026,'',imaa017,imaa018,'',imaa102,imaa103,imaa118, 
#       imaa119,imaa120,imaa114,'',imaa124,'',imaa110,imaa111,imaa112,imaa125,imaa121,imaa122,'',imaa123, 
#       imaa131,imaa126,'',imaa127,'',imaa128,'',imaa129,'',imaa130,imaa143,'',imaa001,'','','','','', 
#       '','','','','','','','','' FROM imaa_t",
# 
#               " LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 ",
#               " AND imaal002 = '",g_dlang,"' ",
#               " WHERE imaaent= ? AND 1=1   AND ",ls_wc
 
   LET g_sql = g_sql, cl_sql_add_filter("imaa_t"),
                      " ORDER BY imaa_t.imaa001"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq300_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artq300_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_imaa_d[l_ac].sel,g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].imaa001_desc,g_imaa_d[l_ac].imaa001_desc_1, 
       g_imaa_d[l_ac].imaa001_desc_2,g_imaa_d[l_ac].imaa009,g_imaa_d[l_ac].imaa009_desc,g_imaa_d[l_ac].imaa003, 
       g_imaa_d[l_ac].imaa003_desc,g_imaa_d[l_ac].imaa108,g_imaa_d[l_ac].imaa100,g_imaa_d[l_ac].imaa014, 
       g_imaa_d[l_ac].imaa005,g_imaa_d[l_ac].imaa005_desc,g_imaa_d[l_ac].imaa006,g_imaa_d[l_ac].imaa006_desc, 
       g_imaa_d[l_ac].imaa105,g_imaa_d[l_ac].imaa105_desc,g_imaa_d[l_ac].imaa104,g_imaa_d[l_ac].imaa104_desc, 
       g_imaa_d[l_ac].imaa107,g_imaa_d[l_ac].imaa107_desc,g_imaa_d[l_ac].imaa106,g_imaa_d[l_ac].imaa106_desc, 
       g_imaa_d[l_ac].imaa145,g_imaa_d[l_ac].imaa145_desc,g_imaa_d[l_ac].imaa146,g_imaa_d[l_ac].imaa146_desc, 
       g_imaa_d[l_ac].imaa113,g_imaa_d[l_ac].imaa109,g_imaa_d[l_ac].imaa019,g_imaa_d[l_ac].imaa020,g_imaa_d[l_ac].imaa021, 
       g_imaa_d[l_ac].imaa022,g_imaa_d[l_ac].imaa022_desc,g_imaa_d[l_ac].imaa025,g_imaa_d[l_ac].imaa026, 
       g_imaa_d[l_ac].imaa026_desc,g_imaa_d[l_ac].imaa017,g_imaa_d[l_ac].imaa018,g_imaa_d[l_ac].imaa018_desc, 
       g_imaa_d[l_ac].imaa102,g_imaa_d[l_ac].imaa103,g_imaa_d[l_ac].imaa118,g_imaa_d[l_ac].imaa119,g_imaa_d[l_ac].imaa120, 
       g_imaa_d[l_ac].imaa114,g_imaa_d[l_ac].imaa114_desc,g_imaa_d[l_ac].imaa124,g_imaa_d[l_ac].imaa124_desc, 
       g_imaa_d[l_ac].imaa110,g_imaa_d[l_ac].imaa111,g_imaa_d[l_ac].imaa112,g_imaa_d[l_ac].imaa125,g_imaa_d[l_ac].imaa121, 
       g_imaa_d[l_ac].imaa122,g_imaa_d[l_ac].imaa122_desc,g_imaa_d[l_ac].imaa123,g_imaa_d[l_ac].imaa131, 
       g_imaa_d[l_ac].imaa126,g_imaa_d[l_ac].imaa126_desc,g_imaa_d[l_ac].imaa127,g_imaa_d[l_ac].imaa127_desc, 
       g_imaa_d[l_ac].imaa128,g_imaa_d[l_ac].imaa128_desc,g_imaa_d[l_ac].imaa129,g_imaa_d[l_ac].imaa129_desc, 
       g_imaa_d[l_ac].imaa130,g_imaa_d[l_ac].imaa143,g_imaa_d[l_ac].imaa143_desc,g_imaa2_d[l_ac].imaa001, 
       g_imaa2_d[l_ac].imay001,g_imaa2_d[l_ac].imay001_desc,g_imaa2_d[l_ac].imay001_desc_1,g_imaa2_d[l_ac].imay001_desc_1_desc, 
       g_imaa2_d[l_ac].imaystus,g_imaa2_d[l_ac].imay002,g_imaa2_d[l_ac].imay003,g_imaa2_d[l_ac].imay004, 
       g_imaa2_d[l_ac].imay005,g_imaa2_d[l_ac].imay006,g_imaa2_d[l_ac].imay007,g_imaa2_d[l_ac].imay008, 
       g_imaa2_d[l_ac].imay009,g_imaa2_d[l_ac].imay010,g_imaa2_d[l_ac].imay011
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
 
      CALL artq300_detail_show("'1'")
 
      CALL artq300_imaa_t_mask()
 
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
   CALL artq300_b_fill_2()
   #end add-point
 
   CALL g_imaa_d.deleteElement(g_imaa_d.getLength())
   CALL g_imaa2_d.deleteElement(g_imaa2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_imaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE artq300_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL artq300_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL artq300_detail_action_trans()
 
   LET l_ac = 1
   IF g_imaa_d.getLength() > 0 THEN
      CALL artq300_b_fill2()
   END IF
 
      CALL artq300_filter_show('imaa001','b_imaa001')
   CALL artq300_filter_show('imaa009','b_imaa009')
   CALL artq300_filter_show('imaa003','b_imaa003')
   CALL artq300_filter_show('imaa108','b_imaa108')
   CALL artq300_filter_show('imaa100','b_imaa100')
   CALL artq300_filter_show('imaa014','b_imaa014')
   CALL artq300_filter_show('imaa005','b_imaa005')
   CALL artq300_filter_show('imaa006','b_imaa006')
   CALL artq300_filter_show('imaa105','b_imaa105')
   CALL artq300_filter_show('imaa104','b_imaa104')
   CALL artq300_filter_show('imaa107','b_imaa107')
   CALL artq300_filter_show('imaa106','b_imaa106')
   CALL artq300_filter_show('imaa145','b_imaa145')
   CALL artq300_filter_show('imaa146','b_imaa146')
   CALL artq300_filter_show('imaa113','b_imaa113')
   CALL artq300_filter_show('imaa109','b_imaa109')
   CALL artq300_filter_show('imaa019','b_imaa019')
   CALL artq300_filter_show('imaa020','b_imaa020')
   CALL artq300_filter_show('imaa021','b_imaa021')
   CALL artq300_filter_show('imaa022','b_imaa022')
   CALL artq300_filter_show('imaa025','b_imaa025')
   CALL artq300_filter_show('imaa026','b_imaa026')
   CALL artq300_filter_show('imaa017','b_imaa017')
   CALL artq300_filter_show('imaa018','b_imaa018')
   CALL artq300_filter_show('imaa102','b_imaa102')
   CALL artq300_filter_show('imaa103','b_imaa103')
   CALL artq300_filter_show('imaa118','b_imaa118')
   CALL artq300_filter_show('imaa119','b_imaa119')
   CALL artq300_filter_show('imaa120','b_imaa120')
   CALL artq300_filter_show('imaa114','b_imaa114')
   CALL artq300_filter_show('imaa124','b_imaa124')
   CALL artq300_filter_show('imaa110','b_imaa110')
   CALL artq300_filter_show('imaa111','b_imaa111')
   CALL artq300_filter_show('imaa112','b_imaa112')
   CALL artq300_filter_show('imaa125','b_imaa125')
   CALL artq300_filter_show('imaa121','b_imaa121')
   CALL artq300_filter_show('imaa122','b_imaa122')
   CALL artq300_filter_show('imaa123','b_imaa123')
   CALL artq300_filter_show('imaa131','b_imaa131')
   CALL artq300_filter_show('imaa126','b_imaa126')
   CALL artq300_filter_show('imaa127','b_imaa127')
   CALL artq300_filter_show('imaa128','b_imaa128')
   CALL artq300_filter_show('imaa129','b_imaa129')
   CALL artq300_filter_show('imaa130','b_imaa130')
   CALL artq300_filter_show('imaa143','b_imaa143')
   CALL artq300_filter_show('imay001','b_imay001')
   CALL artq300_filter_show('imaystus','b_imaystus')
   CALL artq300_filter_show('imay002','b_imay002')
   CALL artq300_filter_show('imay003','b_imay003')
   CALL artq300_filter_show('imay004','b_imay004')
   CALL artq300_filter_show('imay005','b_imay005')
   CALL artq300_filter_show('imay006','b_imay006')
   CALL artq300_filter_show('imay007','b_imay007')
   CALL artq300_filter_show('imay008','b_imay008')
   CALL artq300_filter_show('imay009','b_imay009')
   CALL artq300_filter_show('imay010','b_imay010')
   CALL artq300_filter_show('imay011','b_imay011')
 
 
END FUNCTION
 
{</section>}
 
{<section id="artq300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artq300_b_fill2()
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
 
{<section id="artq300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artq300_detail_show(ps_page)
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

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa001
#            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa001_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa001
#            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa001_desc_1 = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa001_desc_1
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa001
#            LET ls_sql = "SELECT imaal005 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa001_desc_2 = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa001_desc_2
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa003
#            LET ls_sql = "SELECT imckl003 FROM imckl_t WHERE imcklent='"||g_enterprise||"' AND imckl001=? AND imckl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa003_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa009
#            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa009_desc
#            
##            INITIALIZE g_ref_fields TO NULL
##            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa005
##            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='211' AND oocql002=? AND oocql003='"||g_dlang||"'"
##            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
##            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
##            LET g_imaa_d[l_ac].imaa005_desc = '', g_rtn_fields[1] , ''
##            DISPLAY BY NAME g_imaa_d[l_ac].imaa005_desc
#            
#        
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa005
#            CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"'  AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa005_desc
#            
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa006
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa105
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa105_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa105_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa104
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa104_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa104_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa107
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa107_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa107_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa106
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa106_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa106_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa145
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa145_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa145_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa146
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa146_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa146_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa022
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa022_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa026
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa026_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa026_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa018
#            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa018_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa018_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa114
#            LET ls_sql = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa114_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa114_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa124
#            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa124_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa124_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa122
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2000' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa122_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa122_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa126
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa126_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa126_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa127
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2003' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa127_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa127_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa128
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2004' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa128_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa128_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa129
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2005' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa129_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa129_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa_d[l_ac].imaa143
#            LET ls_sql = "SELECT dbbal003 FROM dbbal_t WHERE dbbalent='"||g_enterprise||"' AND dbbal001=? AND dbbal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa_d[l_ac].imaa143_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa_d[l_ac].imaa143_desc

#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_imaa_d[l_ac].imaa001
#   LET ls_sql = " SELECT imay001,imaystus,imay002,imay003,imay004,imay005,imay006,imay007_1,imay008_1,imay009_1,imay010,imay011 FROM imay_t WHERE imayent = '"||g_enterprise||"' AND "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields 
#   LET g_imaa2_d[l_ac].imay001 = g_rtn_fields[1] 
#   LET g_imaa2_d[l_ac].imaystus = g_rtn_fields[2] 
#   LET g_imaa2_d[l_ac].imay002 = g_rtn_fields[3] 
#   LET g_imaa2_d[l_ac].imay003 = g_rtn_fields[4] 
#   LET g_imaa2_d[l_ac].imay004 = g_rtn_fields[5] 
#   LET g_imaa2_d[l_ac].imay005 = g_rtn_fields[6] 
#   LET g_imaa2_d[l_ac].imay006 = g_rtn_fields[7] 
#   LET g_imaa2_d[l_ac].imay007 = g_rtn_fields[8] 
#   LET g_imaa2_d[l_ac].imay008 = g_rtn_fields[9] 
#   LET g_imaa2_d[l_ac].imay009 = g_rtn_fields[10] 
#   LET g_imaa2_d[l_ac].imay010 = g_rtn_fields[11] 
#   LET g_imaa2_d[l_ac].imay011 = g_rtn_fields[12] 
#   DISPLAY BY NAME g_imaa2_d[l_ac].imay001,g_imaa2_d[l_ac].imaystus,g_imaa2_d[l_ac].imay002,g_imaa2_d[l_ac].imay003,g_imaa2_d[l_ac].imay004,g_imaa2_d[l_ac].imay005,g_imaa2_d[l_ac].imay006,g_imaa2_d[l_ac].imay007,g_imaa2_d[l_ac].imay008,g_imaa2_d[l_ac].imay009,g_imaa2_d[l_ac].imay010,g_imaa2_d[l_ac].imay011
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imaa2_d[l_ac].imay001
#            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_imaa2_d[l_ac].imay001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_imaa2_d[l_ac].imay001_desc
#

            
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq300.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION artq300_filter()
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
      CONSTRUCT g_wc_filter ON imaa001,imaa009,imaa003,imaa108,imaa100,imaa014,imaa005,imaa006,imaa105, 
          imaa104,imaa107,imaa106,imaa145,imaa146,imaa113,imaa109,imaa019,imaa020,imaa021,imaa022,imaa025, 
          imaa026,imaa017,imaa018,imaa102,imaa103,imaa118,imaa119,imaa120,imaa114,imaa124,imaa110,imaa111, 
          imaa112,imaa125,imaa121,imaa122,imaa123,imaa131,imaa126,imaa127,imaa128,imaa129,imaa130,imaa143, 
          imay001,imaystus,imay002,imay003,imay004,imay005,imay006,imay007,imay008,imay009,imay010,imay011 
 
                          FROM s_detail1[1].b_imaa001,s_detail1[1].b_imaa009,s_detail1[1].b_imaa003, 
                              s_detail1[1].b_imaa108,s_detail1[1].b_imaa100,s_detail1[1].b_imaa014,s_detail1[1].b_imaa005, 
                              s_detail1[1].b_imaa006,s_detail1[1].b_imaa105,s_detail1[1].b_imaa104,s_detail1[1].b_imaa107, 
                              s_detail1[1].b_imaa106,s_detail1[1].b_imaa145,s_detail1[1].b_imaa146,s_detail1[1].b_imaa113, 
                              s_detail1[1].b_imaa109,s_detail1[1].b_imaa019,s_detail1[1].b_imaa020,s_detail1[1].b_imaa021, 
                              s_detail1[1].b_imaa022,s_detail1[1].b_imaa025,s_detail1[1].b_imaa026,s_detail1[1].b_imaa017, 
                              s_detail1[1].b_imaa018,s_detail1[1].b_imaa102,s_detail1[1].b_imaa103,s_detail1[1].b_imaa118, 
                              s_detail1[1].b_imaa119,s_detail1[1].b_imaa120,s_detail1[1].b_imaa114,s_detail1[1].b_imaa124, 
                              s_detail1[1].b_imaa110,s_detail1[1].b_imaa111,s_detail1[1].b_imaa112,s_detail1[1].b_imaa125, 
                              s_detail1[1].b_imaa121,s_detail1[1].b_imaa122,s_detail1[1].b_imaa123,s_detail1[1].b_imaa131, 
                              s_detail1[1].b_imaa126,s_detail1[1].b_imaa127,s_detail1[1].b_imaa128,s_detail1[1].b_imaa129, 
                              s_detail1[1].b_imaa130,s_detail1[1].b_imaa143,s_detail2[1].b_imay001,s_detail2[1].b_imaystus, 
                              s_detail2[1].b_imay002,s_detail2[1].b_imay003,s_detail2[1].b_imay004,s_detail2[1].b_imay005, 
                              s_detail2[1].b_imay006,s_detail2[1].b_imay007,s_detail2[1].b_imay008,s_detail2[1].b_imay009, 
                              s_detail2[1].b_imay010,s_detail2[1].b_imay011
 
         BEFORE CONSTRUCT
                     DISPLAY artq300_filter_parser('imaa001') TO s_detail1[1].b_imaa001
            DISPLAY artq300_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY artq300_filter_parser('imaa003') TO s_detail1[1].b_imaa003
            DISPLAY artq300_filter_parser('imaa108') TO s_detail1[1].b_imaa108
            DISPLAY artq300_filter_parser('imaa100') TO s_detail1[1].b_imaa100
            DISPLAY artq300_filter_parser('imaa014') TO s_detail1[1].b_imaa014
            DISPLAY artq300_filter_parser('imaa005') TO s_detail1[1].b_imaa005
            DISPLAY artq300_filter_parser('imaa006') TO s_detail1[1].b_imaa006
            DISPLAY artq300_filter_parser('imaa105') TO s_detail1[1].b_imaa105
            DISPLAY artq300_filter_parser('imaa104') TO s_detail1[1].b_imaa104
            DISPLAY artq300_filter_parser('imaa107') TO s_detail1[1].b_imaa107
            DISPLAY artq300_filter_parser('imaa106') TO s_detail1[1].b_imaa106
            DISPLAY artq300_filter_parser('imaa145') TO s_detail1[1].b_imaa145
            DISPLAY artq300_filter_parser('imaa146') TO s_detail1[1].b_imaa146
            DISPLAY artq300_filter_parser('imaa113') TO s_detail1[1].b_imaa113
            DISPLAY artq300_filter_parser('imaa109') TO s_detail1[1].b_imaa109
            DISPLAY artq300_filter_parser('imaa019') TO s_detail1[1].b_imaa019
            DISPLAY artq300_filter_parser('imaa020') TO s_detail1[1].b_imaa020
            DISPLAY artq300_filter_parser('imaa021') TO s_detail1[1].b_imaa021
            DISPLAY artq300_filter_parser('imaa022') TO s_detail1[1].b_imaa022
            DISPLAY artq300_filter_parser('imaa025') TO s_detail1[1].b_imaa025
            DISPLAY artq300_filter_parser('imaa026') TO s_detail1[1].b_imaa026
            DISPLAY artq300_filter_parser('imaa017') TO s_detail1[1].b_imaa017
            DISPLAY artq300_filter_parser('imaa018') TO s_detail1[1].b_imaa018
            DISPLAY artq300_filter_parser('imaa102') TO s_detail1[1].b_imaa102
            DISPLAY artq300_filter_parser('imaa103') TO s_detail1[1].b_imaa103
            DISPLAY artq300_filter_parser('imaa118') TO s_detail1[1].b_imaa118
            DISPLAY artq300_filter_parser('imaa119') TO s_detail1[1].b_imaa119
            DISPLAY artq300_filter_parser('imaa120') TO s_detail1[1].b_imaa120
            DISPLAY artq300_filter_parser('imaa114') TO s_detail1[1].b_imaa114
            DISPLAY artq300_filter_parser('imaa124') TO s_detail1[1].b_imaa124
            DISPLAY artq300_filter_parser('imaa110') TO s_detail1[1].b_imaa110
            DISPLAY artq300_filter_parser('imaa111') TO s_detail1[1].b_imaa111
            DISPLAY artq300_filter_parser('imaa112') TO s_detail1[1].b_imaa112
            DISPLAY artq300_filter_parser('imaa125') TO s_detail1[1].b_imaa125
            DISPLAY artq300_filter_parser('imaa121') TO s_detail1[1].b_imaa121
            DISPLAY artq300_filter_parser('imaa122') TO s_detail1[1].b_imaa122
            DISPLAY artq300_filter_parser('imaa123') TO s_detail1[1].b_imaa123
            DISPLAY artq300_filter_parser('imaa131') TO s_detail1[1].b_imaa131
            DISPLAY artq300_filter_parser('imaa126') TO s_detail1[1].b_imaa126
            DISPLAY artq300_filter_parser('imaa127') TO s_detail1[1].b_imaa127
            DISPLAY artq300_filter_parser('imaa128') TO s_detail1[1].b_imaa128
            DISPLAY artq300_filter_parser('imaa129') TO s_detail1[1].b_imaa129
            DISPLAY artq300_filter_parser('imaa130') TO s_detail1[1].b_imaa130
            DISPLAY artq300_filter_parser('imaa143') TO s_detail1[1].b_imaa143
            DISPLAY artq300_filter_parser('imay001') TO s_detail2[1].b_imay001
            DISPLAY artq300_filter_parser('imaystus') TO s_detail2[1].b_imaystus
            DISPLAY artq300_filter_parser('imay002') TO s_detail2[1].b_imay002
            DISPLAY artq300_filter_parser('imay003') TO s_detail2[1].b_imay003
            DISPLAY artq300_filter_parser('imay004') TO s_detail2[1].b_imay004
            DISPLAY artq300_filter_parser('imay005') TO s_detail2[1].b_imay005
            DISPLAY artq300_filter_parser('imay006') TO s_detail2[1].b_imay006
            DISPLAY artq300_filter_parser('imay007') TO s_detail2[1].b_imay007
            DISPLAY artq300_filter_parser('imay008') TO s_detail2[1].b_imay008
            DISPLAY artq300_filter_parser('imay009') TO s_detail2[1].b_imay009
            DISPLAY artq300_filter_parser('imay010') TO s_detail2[1].b_imay010
            DISPLAY artq300_filter_parser('imay011') TO s_detail2[1].b_imay011
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_imaa001>>----
         #Ctrlp:construct.c.page1.b_imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa001
            #add-point:ON ACTION controlp INFIELD b_imaa001 name="construct.c.filter.page1.b_imaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa001  #顯示到畫面上
            NEXT FIELD b_imaa001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa001_desc>>----
         #----<<b_imaa001_desc_1>>----
         #----<<b_imaa001_desc_2>>----
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.filter.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_imaa003>>----
         #Ctrlp:construct.c.page1.b_imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa003
            #add-point:ON ACTION controlp INFIELD b_imaa003 name="construct.c.filter.page1.b_imaa003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imck001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa003  #顯示到畫面上
            NEXT FIELD b_imaa003                     #返回原欄位
    


            #END add-point
 
 
         #----<<url_b_imaa003>>----
         #----<<b_imaa003_desc>>----
         #----<<b_imaa108>>----
         #Ctrlp:construct.c.filter.page1.b_imaa108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa108
            #add-point:ON ACTION controlp INFIELD b_imaa108 name="construct.c.filter.page1.b_imaa108"
            
            #END add-point
 
 
         #----<<b_imaa100>>----
         #Ctrlp:construct.c.filter.page1.b_imaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa100
            #add-point:ON ACTION controlp INFIELD b_imaa100 name="construct.c.filter.page1.b_imaa100"
            
            #END add-point
 
 
         #----<<b_imaa014>>----
         #Ctrlp:construct.c.filter.page1.b_imaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa014
            #add-point:ON ACTION controlp INFIELD b_imaa014 name="construct.c.filter.page1.b_imaa014"
            
            #END add-point
 
 
         #----<<b_imaa005>>----
         #Ctrlp:construct.c.page1.b_imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa005
            #add-point:ON ACTION controlp INFIELD b_imaa005 name="construct.c.filter.page1.b_imaa005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa005  #顯示到畫面上
            NEXT FIELD b_imaa005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa005_desc>>----
         #----<<b_imaa006>>----
         #Ctrlp:construct.c.page1.b_imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa006
            #add-point:ON ACTION controlp INFIELD b_imaa006 name="construct.c.filter.page1.b_imaa006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa006  #顯示到畫面上
            NEXT FIELD b_imaa006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa006_desc>>----
         #----<<b_imaa105>>----
         #Ctrlp:construct.c.page1.b_imaa105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa105
            #add-point:ON ACTION controlp INFIELD b_imaa105 name="construct.c.filter.page1.b_imaa105"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa105  #顯示到畫面上
            NEXT FIELD b_imaa105                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa105_desc>>----
         #----<<b_imaa104>>----
         #Ctrlp:construct.c.page1.b_imaa104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa104
            #add-point:ON ACTION controlp INFIELD b_imaa104 name="construct.c.filter.page1.b_imaa104"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa104  #顯示到畫面上
            NEXT FIELD b_imaa104                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa104_desc>>----
         #----<<b_imaa107>>----
         #Ctrlp:construct.c.page1.b_imaa107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa107
            #add-point:ON ACTION controlp INFIELD b_imaa107 name="construct.c.filter.page1.b_imaa107"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa107  #顯示到畫面上
            NEXT FIELD b_imaa107                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa107_desc>>----
         #----<<b_imaa106>>----
         #Ctrlp:construct.c.page1.b_imaa106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa106
            #add-point:ON ACTION controlp INFIELD b_imaa106 name="construct.c.filter.page1.b_imaa106"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa106  #顯示到畫面上
            NEXT FIELD b_imaa106                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa106_desc>>----
         #----<<b_imaa145>>----
         #Ctrlp:construct.c.page1.b_imaa145
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa145
            #add-point:ON ACTION controlp INFIELD b_imaa145 name="construct.c.filter.page1.b_imaa145"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa145  #顯示到畫面上
            NEXT FIELD b_imaa145                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa145_desc>>----
         #----<<b_imaa146>>----
         #Ctrlp:construct.c.filter.page1.b_imaa146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa146
            #add-point:ON ACTION controlp INFIELD b_imaa146 name="construct.c.filter.page1.b_imaa146"
            
            #END add-point
 
 
         #----<<b_imaa146_desc>>----
         #----<<b_imaa113>>----
         #Ctrlp:construct.c.filter.page1.b_imaa113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa113
            #add-point:ON ACTION controlp INFIELD b_imaa113 name="construct.c.filter.page1.b_imaa113"
            
            #END add-point
 
 
         #----<<b_imaa109>>----
         #Ctrlp:construct.c.filter.page1.b_imaa109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa109
            #add-point:ON ACTION controlp INFIELD b_imaa109 name="construct.c.filter.page1.b_imaa109"
            
            #END add-point
 
 
         #----<<b_imaa019>>----
         #Ctrlp:construct.c.filter.page1.b_imaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa019
            #add-point:ON ACTION controlp INFIELD b_imaa019 name="construct.c.filter.page1.b_imaa019"
            
            #END add-point
 
 
         #----<<b_imaa020>>----
         #Ctrlp:construct.c.filter.page1.b_imaa020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa020
            #add-point:ON ACTION controlp INFIELD b_imaa020 name="construct.c.filter.page1.b_imaa020"
            
            #END add-point
 
 
         #----<<b_imaa021>>----
         #Ctrlp:construct.c.filter.page1.b_imaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa021
            #add-point:ON ACTION controlp INFIELD b_imaa021 name="construct.c.filter.page1.b_imaa021"
            
            #END add-point
 
 
         #----<<b_imaa022>>----
         #Ctrlp:construct.c.page1.b_imaa022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa022
            #add-point:ON ACTION controlp INFIELD b_imaa022 name="construct.c.filter.page1.b_imaa022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa022  #顯示到畫面上
            NEXT FIELD b_imaa022                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa022_desc>>----
         #----<<b_imaa025>>----
         #Ctrlp:construct.c.filter.page1.b_imaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa025
            #add-point:ON ACTION controlp INFIELD b_imaa025 name="construct.c.filter.page1.b_imaa025"
            
            #END add-point
 
 
         #----<<b_imaa026>>----
         #Ctrlp:construct.c.page1.b_imaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa026
            #add-point:ON ACTION controlp INFIELD b_imaa026 name="construct.c.filter.page1.b_imaa026"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa026  #顯示到畫面上
            NEXT FIELD b_imaa026                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa026_desc>>----
         #----<<b_imaa017>>----
         #Ctrlp:construct.c.filter.page1.b_imaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa017
            #add-point:ON ACTION controlp INFIELD b_imaa017 name="construct.c.filter.page1.b_imaa017"
            
            #END add-point
 
 
         #----<<b_imaa018>>----
         #Ctrlp:construct.c.page1.b_imaa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa018
            #add-point:ON ACTION controlp INFIELD b_imaa018 name="construct.c.filter.page1.b_imaa018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa018  #顯示到畫面上
            NEXT FIELD b_imaa018                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa018_desc>>----
         #----<<b_imaa102>>----
         #Ctrlp:construct.c.filter.page1.b_imaa102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa102
            #add-point:ON ACTION controlp INFIELD b_imaa102 name="construct.c.filter.page1.b_imaa102"
            
            #END add-point
 
 
         #----<<b_imaa103>>----
         #Ctrlp:construct.c.filter.page1.b_imaa103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa103
            #add-point:ON ACTION controlp INFIELD b_imaa103 name="construct.c.filter.page1.b_imaa103"
            
            #END add-point
 
 
         #----<<b_imaa118>>----
         #Ctrlp:construct.c.filter.page1.b_imaa118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa118
            #add-point:ON ACTION controlp INFIELD b_imaa118 name="construct.c.filter.page1.b_imaa118"
            
            #END add-point
 
 
         #----<<b_imaa119>>----
         #Ctrlp:construct.c.filter.page1.b_imaa119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa119
            #add-point:ON ACTION controlp INFIELD b_imaa119 name="construct.c.filter.page1.b_imaa119"
            
            #END add-point
 
 
         #----<<b_imaa120>>----
         #Ctrlp:construct.c.filter.page1.b_imaa120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa120
            #add-point:ON ACTION controlp INFIELD b_imaa120 name="construct.c.filter.page1.b_imaa120"
            
            #END add-point
 
 
         #----<<b_imaa114>>----
         #Ctrlp:construct.c.page1.b_imaa114
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa114
            #add-point:ON ACTION controlp INFIELD b_imaa114 name="construct.c.filter.page1.b_imaa114"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa114  #顯示到畫面上
            NEXT FIELD b_imaa114                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa114_desc>>----
         #----<<b_imaa124>>----
         #Ctrlp:construct.c.page1.b_imaa124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa124
            #add-point:ON ACTION controlp INFIELD b_imaa124 name="construct.c.filter.page1.b_imaa124"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa124  #顯示到畫面上
            NEXT FIELD b_imaa124                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa124_desc>>----
         #----<<b_imaa110>>----
         #Ctrlp:construct.c.filter.page1.b_imaa110
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa110
            #add-point:ON ACTION controlp INFIELD b_imaa110 name="construct.c.filter.page1.b_imaa110"
            
            #END add-point
 
 
         #----<<b_imaa111>>----
         #Ctrlp:construct.c.filter.page1.b_imaa111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa111
            #add-point:ON ACTION controlp INFIELD b_imaa111 name="construct.c.filter.page1.b_imaa111"
            
            #END add-point
 
 
         #----<<b_imaa112>>----
         #Ctrlp:construct.c.filter.page1.b_imaa112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa112
            #add-point:ON ACTION controlp INFIELD b_imaa112 name="construct.c.filter.page1.b_imaa112"
            
            #END add-point
 
 
         #----<<b_imaa125>>----
         #Ctrlp:construct.c.filter.page1.b_imaa125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa125
            #add-point:ON ACTION controlp INFIELD b_imaa125 name="construct.c.filter.page1.b_imaa125"
            
            #END add-point
 
 
         #----<<b_imaa121>>----
         #Ctrlp:construct.c.filter.page1.b_imaa121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa121
            #add-point:ON ACTION controlp INFIELD b_imaa121 name="construct.c.filter.page1.b_imaa121"
            
            #END add-point
 
 
         #----<<b_imaa122>>----
         #Ctrlp:construct.c.page1.b_imaa122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa122
            #add-point:ON ACTION controlp INFIELD b_imaa122 name="construct.c.filter.page1.b_imaa122"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa122  #顯示到畫面上
            NEXT FIELD b_imaa122                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa122_desc>>----
         #----<<b_imaa123>>----
         #Ctrlp:construct.c.filter.page1.b_imaa123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa123
            #add-point:ON ACTION controlp INFIELD b_imaa123 name="construct.c.filter.page1.b_imaa123"
            
            #END add-point
 
 
         #----<<b_imaa131>>----
         #Ctrlp:construct.c.page1.b_imaa131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa131
            #add-point:ON ACTION controlp INFIELD b_imaa131 name="construct.c.filter.page1.b_imaa131"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa131  #顯示到畫面上
            NEXT FIELD b_imaa131                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa126>>----
         #Ctrlp:construct.c.page1.b_imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa126
            #add-point:ON ACTION controlp INFIELD b_imaa126 name="construct.c.filter.page1.b_imaa126"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa129  #顯示到畫面上
            NEXT FIELD b_imaa129                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa129_desc>>----
         #----<<b_imaa130>>----
         #Ctrlp:construct.c.filter.page1.b_imaa130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa130
            #add-point:ON ACTION controlp INFIELD b_imaa130 name="construct.c.filter.page1.b_imaa130"
            
            #END add-point
 
 
         #----<<b_imaa143>>----
         #Ctrlp:construct.c.page1.b_imaa143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa143
            #add-point:ON ACTION controlp INFIELD b_imaa143 name="construct.c.filter.page1.b_imaa143"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_dbba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa143  #顯示到畫面上
            NEXT FIELD b_imaa143                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa143_desc>>----
         #----<<b_imaa001_2>>----
         #----<<b_imay001>>----
         #Ctrlp:construct.c.filter.page2.b_imay001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay001
            #add-point:ON ACTION controlp INFIELD b_imay001 name="construct.c.filter.page2.b_imay001"
            
            #END add-point
 
 
         #----<<b_imay001_desc>>----
         #----<<b_imay001_desc_1>>----
         #----<<b_imay001_desc_1_desc>>----
         #----<<b_imaystus>>----
         #Ctrlp:construct.c.filter.page2.b_imaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaystus
            #add-point:ON ACTION controlp INFIELD b_imaystus name="construct.c.filter.page2.b_imaystus"
            
            #END add-point
 
 
         #----<<b_imay002>>----
         #Ctrlp:construct.c.filter.page2.b_imay002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay002
            #add-point:ON ACTION controlp INFIELD b_imay002 name="construct.c.filter.page2.b_imay002"
            
            #END add-point
 
 
         #----<<b_imay003>>----
         #Ctrlp:construct.c.page2.b_imay003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay003
            #add-point:ON ACTION controlp INFIELD b_imay003 name="construct.c.filter.page2.b_imay003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imay003  #顯示到畫面上
            NEXT FIELD b_imay003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imay004>>----
         #Ctrlp:construct.c.page2.b_imay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay004
            #add-point:ON ACTION controlp INFIELD b_imay004 name="construct.c.filter.page2.b_imay004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imay004  #顯示到畫面上
            NEXT FIELD b_imay004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imay005>>----
         #Ctrlp:construct.c.filter.page2.b_imay005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay005
            #add-point:ON ACTION controlp INFIELD b_imay005 name="construct.c.filter.page2.b_imay005"
            
            #END add-point
 
 
         #----<<b_imay006>>----
         #Ctrlp:construct.c.filter.page2.b_imay006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay006
            #add-point:ON ACTION controlp INFIELD b_imay006 name="construct.c.filter.page2.b_imay006"
            
            #END add-point
 
 
         #----<<b_imay007>>----
         #Ctrlp:construct.c.filter.page2.b_imay007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay007
            #add-point:ON ACTION controlp INFIELD b_imay007 name="construct.c.filter.page2.b_imay007"
            
            #END add-point
 
 
         #----<<b_imay008>>----
         #Ctrlp:construct.c.filter.page2.b_imay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay008
            #add-point:ON ACTION controlp INFIELD b_imay008 name="construct.c.filter.page2.b_imay008"
            
            #END add-point
 
 
         #----<<b_imay009>>----
         #Ctrlp:construct.c.filter.page2.b_imay009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay009
            #add-point:ON ACTION controlp INFIELD b_imay009 name="construct.c.filter.page2.b_imay009"
            
            #END add-point
 
 
         #----<<b_imay010>>----
         #Ctrlp:construct.c.filter.page2.b_imay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay010
            #add-point:ON ACTION controlp INFIELD b_imay010 name="construct.c.filter.page2.b_imay010"
            
            #END add-point
 
 
         #----<<b_imay011>>----
         #Ctrlp:construct.c.filter.page2.b_imay011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imay011
            #add-point:ON ACTION controlp INFIELD b_imay011 name="construct.c.filter.page2.b_imay011"
            
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
 
      CALL artq300_filter_show('imaa001','b_imaa001')
   CALL artq300_filter_show('imaa009','b_imaa009')
   CALL artq300_filter_show('imaa003','b_imaa003')
   CALL artq300_filter_show('imaa108','b_imaa108')
   CALL artq300_filter_show('imaa100','b_imaa100')
   CALL artq300_filter_show('imaa014','b_imaa014')
   CALL artq300_filter_show('imaa005','b_imaa005')
   CALL artq300_filter_show('imaa006','b_imaa006')
   CALL artq300_filter_show('imaa105','b_imaa105')
   CALL artq300_filter_show('imaa104','b_imaa104')
   CALL artq300_filter_show('imaa107','b_imaa107')
   CALL artq300_filter_show('imaa106','b_imaa106')
   CALL artq300_filter_show('imaa145','b_imaa145')
   CALL artq300_filter_show('imaa146','b_imaa146')
   CALL artq300_filter_show('imaa113','b_imaa113')
   CALL artq300_filter_show('imaa109','b_imaa109')
   CALL artq300_filter_show('imaa019','b_imaa019')
   CALL artq300_filter_show('imaa020','b_imaa020')
   CALL artq300_filter_show('imaa021','b_imaa021')
   CALL artq300_filter_show('imaa022','b_imaa022')
   CALL artq300_filter_show('imaa025','b_imaa025')
   CALL artq300_filter_show('imaa026','b_imaa026')
   CALL artq300_filter_show('imaa017','b_imaa017')
   CALL artq300_filter_show('imaa018','b_imaa018')
   CALL artq300_filter_show('imaa102','b_imaa102')
   CALL artq300_filter_show('imaa103','b_imaa103')
   CALL artq300_filter_show('imaa118','b_imaa118')
   CALL artq300_filter_show('imaa119','b_imaa119')
   CALL artq300_filter_show('imaa120','b_imaa120')
   CALL artq300_filter_show('imaa114','b_imaa114')
   CALL artq300_filter_show('imaa124','b_imaa124')
   CALL artq300_filter_show('imaa110','b_imaa110')
   CALL artq300_filter_show('imaa111','b_imaa111')
   CALL artq300_filter_show('imaa112','b_imaa112')
   CALL artq300_filter_show('imaa125','b_imaa125')
   CALL artq300_filter_show('imaa121','b_imaa121')
   CALL artq300_filter_show('imaa122','b_imaa122')
   CALL artq300_filter_show('imaa123','b_imaa123')
   CALL artq300_filter_show('imaa131','b_imaa131')
   CALL artq300_filter_show('imaa126','b_imaa126')
   CALL artq300_filter_show('imaa127','b_imaa127')
   CALL artq300_filter_show('imaa128','b_imaa128')
   CALL artq300_filter_show('imaa129','b_imaa129')
   CALL artq300_filter_show('imaa130','b_imaa130')
   CALL artq300_filter_show('imaa143','b_imaa143')
   CALL artq300_filter_show('imay001','b_imay001')
   CALL artq300_filter_show('imaystus','b_imaystus')
   CALL artq300_filter_show('imay002','b_imay002')
   CALL artq300_filter_show('imay003','b_imay003')
   CALL artq300_filter_show('imay004','b_imay004')
   CALL artq300_filter_show('imay005','b_imay005')
   CALL artq300_filter_show('imay006','b_imay006')
   CALL artq300_filter_show('imay007','b_imay007')
   CALL artq300_filter_show('imay008','b_imay008')
   CALL artq300_filter_show('imay009','b_imay009')
   CALL artq300_filter_show('imay010','b_imay010')
   CALL artq300_filter_show('imay011','b_imay011')
 
 
   CALL artq300_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="artq300.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION artq300_filter_parser(ps_field)
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
 
{<section id="artq300.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION artq300_filter_show(ps_field,ps_object)
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
   LET ls_condition = artq300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="artq300.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION artq300_detail_action_trans()
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
 
{<section id="artq300.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION artq300_detail_index_setting()
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
            IF g_imaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_imaa_d.getLength() AND g_imaa_d.getLength() > 0
            LET g_detail_idx = g_imaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_imaa_d.getLength() THEN
               LET g_detail_idx = g_imaa_d.getLength()
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
 
{<section id="artq300.mask_functions" >}
 &include "erp/art/artq300_mask.4gl"
 
{</section>}
 
{<section id="artq300.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询方法
# Date & Author..: 2015/02/27 By geza
# Modify........
################################################################################
PRIVATE FUNCTION artq300_query()
DEFINE ls_wc      LIKE type_t.chr500
DEFINE ls_return  STRING
DEFINE ls_result  STRING 
  
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_imaa_d.clear()
   CALL g_imaa2_d.clear()
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
       CONSTRUCT BY NAME g_wc  ON imaa001,imaa014,imaa009,imaa126,imaa127,imaal003

         
         
         
         ON ACTION controlp INFIELD imaa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
           
            CALL q_imaa001()#呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上

            NEXT FIELD imaa001  
         
        
         ON ACTION controlp INFIELD imaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
           
            CALL q_rtax001()#呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009    
        
        ON ACTION controlp INFIELD imaa126
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
            LET g_qryparam.arg1 = '2002' 
            CALL q_oocq002()#呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上

            NEXT FIELD imaa126    
           
        ON ACTION controlp INFIELD imaa127
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
            LET g_qryparam.arg1 = '2003' 
            CALL q_oocq002()#呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上

            NEXT FIELD imaa127    
       
         
         
        BEFORE CONSTRUCT         
         
        AFTER CONSTRUCT
         
         
      END CONSTRUCT 
      
      
      
      
      BEFORE DIALOG 
    
         CALL cl_qbe_init()

      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
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
 

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   END IF
    
   LET g_error_show = 1
   CALL artq300_b_fill()
   IF g_detail_cnt = 0 AND g_detail_cnt1 = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET INT_FLAG = FALSE
END FUNCTION

################################################################################
# Descriptions...: 单身填充2
# Date & Author..: 2015/02/27 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq300_b_fill_2()
DEFINE ls_sql                 STRING
DEFINE ls_wc           STRING
DEFINE li_ac           LIKE type_t.num5
   CALL g_imaa2_d.clear()
   LET l_ac = 1
   LET g_detail_idx2 = 1

#    LET g_sql = "SELECT  UNIQUE imay001,'','',imaystus,imay002,imay003,imay004, 
#                 imay005,imay006,imay007,imay008,imay009,imay010,imay011
#                 FROM imaa_t,imaal_t,imay_t",
#            
#               " WHERE imaaent= ? AND 1=1  ",
#               " AND imaaent = imayent ",
#               " AND imaa001 = imay001",
#               " AND imaaent = imaalent ",
#               " AND imaa001 = imaal001",
#               " AND imaal002 = '",g_dlang,"'  AND ",g_wc3

   #160224-00020#1 2016/03/03 s983961--mark(s)
   #LET g_sql = "SELECT  UNIQUE imay001,imaal003,imaa009,rtaxl003,imaystus,imay002,imay003,imay004, 
   #              imay005,imay006,imay007,imay008,imay009,imay010,imay011
   #              FROM imay_t,imaa_t",
   #            " LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001  AND imaal002 = '",g_dlang,"' ",
   #            " LEFT JOIN rtaxl_t ON imaaent = rtaxlent AND imaa009 = rtaxl001 AND rtaxl002='"||g_dlang||"'  ",
   #            " WHERE imaaent= ? AND 1=1  ",
   #            " AND imaaent = imayent ",
   #            " AND imaa001 = imay001",
   #         
   #            " AND ",g_wc3
   #160224-00020#1 2016/03/03 s983961--mark(e)
   
   #160224-00020#1 2016/03/03 s983961--add(s)
   LET g_sql = "SELECT  UNIQUE imay001, ",
               "               (SELECT imaal003",
               "                  FROM imaal_t",
               "                 WHERE imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"') , ",
               "               imaa009, ",
               "               (SELECT rtaxl003",
               "                  FROM rtaxl_t",
               "                 WHERE rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') , ",
               "               imaystus,imay002,imay003,imay004,imay005, ",
               "               imay006,imay007,imay008,imay009,imay010,imay011 ",
               " FROM imay_t,imaa_t",
               " WHERE imaaent= ? AND 1=1  ",
               " AND imaaent = imayent ",
               " AND imaa001 = imay001",            
               " AND ",g_wc3
   #160224-00020#1 2016/03/03 s983961--add(e)
   LET g_sql = g_sql, cl_sql_add_filter("imay_t"),
               " ORDER BY imay_t.imay001"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq300_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR artq300_pb2
 
   OPEN b_fill_curs2 USING g_enterprise
 
   FOREACH b_fill_curs2 INTO g_imaa2_d[l_ac].imay001,g_imaa2_d[l_ac].imay001_desc, 
      g_imaa2_d[l_ac].imay001_desc_1,g_imaa2_d[l_ac].imay001_desc_1_desc,g_imaa2_d[l_ac].imaystus,g_imaa2_d[l_ac].imay002,
      g_imaa2_d[l_ac].imay003,g_imaa2_d[l_ac].imay004,g_imaa2_d[l_ac].imay005,g_imaa2_d[l_ac].imay006,
      g_imaa2_d[l_ac].imay007,g_imaa2_d[l_ac].imay008,g_imaa2_d[l_ac].imay009,g_imaa2_d[l_ac].imay010,
      g_imaa2_d[l_ac].imay011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_imaa2_d[l_ac].imay001
#      LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_imaa2_d[l_ac].imay001_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_imaa2_d[l_ac].imay001_desc
# 
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_imaa2_d[l_ac].imay001
#      LET ls_sql = "SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_imaa2_d[l_ac].imay001_desc_1 = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_imaa2_d[l_ac].imay001_desc_1
# 
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_imaa2_d[l_ac].imay001_desc_1
#      LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_imaa2_d[l_ac].imay001_desc_1_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_imaa2_d[l_ac].imay001_desc_1_desc
#     
 
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
   
   LET g_detail_cnt1 = g_imaa2_d.getLength()-1
   
   CLOSE b_fill_curs2
   FREE artq300_pb2
   
END FUNCTION

 
{</section>}
 
