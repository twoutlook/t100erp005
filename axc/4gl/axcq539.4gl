#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq539.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2017-02-07 18:18:48), PR版次:0002(2017-02-16 11:09:41)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axcq539
#+ Description: 先進先出出入庫沖銷查詢作業
#+ Creator....: 01534(2017-01-23 14:54:03)
#+ Modifier...: 01534 -SD/PR- 01534
 
{</section>}
 
{<section id="axcq539.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#161230-00010#16  2017/02/15 By lixh  新增来源xccj_t
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
       xcckcomp LIKE type_t.chr10, 
   xcckcomp_desc LIKE type_t.chr80, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr80, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr80, 
   xcck004e LIKE type_t.num5, 
   xcck005e LIKE type_t.num5, 
   chk LIKE type_t.chr1
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       xcck013 LIKE xcck_t.xcck013, 
   xcck012 LIKE xcck_t.xcck012, 
   xcck020 LIKE xcck_t.xcck020, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck202 LIKE xcck_t.xcck202, 
   xccl015 LIKE xccl_t.xccl015, 
   xccl014 LIKE xccl_t.xccl014, 
   xccl020 LIKE xccl_t.xccl020, 
   xccl006 LIKE xccl_t.xccl006, 
   xccl007 LIKE xccl_t.xccl007, 
   xccl008 LIKE xccl_t.xccl008, 
   xccl101 LIKE xccl_t.xccl101, 
   xccl102 LIKE xccl_t.xccl102, 
   xcee402 LIKE xcee_t.xcee402
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_browser        RECORD
       xcckcomp LIKE xcck_t.xcckcomp, 
       xcckld   LIKE xcck_t.xcckld,
       xcck003  LIKE xcck_t.xcck003        
             END RECORD
DEFINE    g_browser         DYNAMIC ARRAY OF type_g_browser
DEFINE    g_wc_cs_ld        STRING
DEFINE    g_wc_cs_comp      STRING
DEFINE    g_wc3             STRING
DEFINE    g_wc_1            STRING
DEFINE    g_wc_2            STRING
DEFINE    g_wc2_1           STRING
DEFINE    g_wc2_2           STRING
DEFINE    g_xcck004         LIKE xcck_t.xcck004
DEFINE    g_xcck005         LIKE xcck_t.xcck005
DEFINE    g_xcck004e        LIKE xcck_t.xcck004
DEFINE    g_xcck005e        LIKE xcck_t.xcck005
DEFINE    g_ooef004         LIKE ooef_t.ooef004
DEFINE    g_ooef008         LIKE ooef_t.ooef008
DEFINE    g_ooef009         LIKE ooef_t.ooef009
DEFINE    g_ooef017         LIKE ooef_t.ooef017
DEFINE    g_oogc006         LIKE oogc_t.oogc006
DEFINE    g_oogc006_2       LIKE oogc_t.oogc006
DEFINE    g_sql2            STRING
DEFINE    g_sql3            STRING
DEFINE    g_sql4            STRING
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
 
{<section id="axcq539.main" >}
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
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_fin_azzi800_sons_query(g_today)  
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld   
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp       #抓取使用者有拜訪權限據點的對應法人
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
   DECLARE axcq539_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq539_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq539_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq539 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq539_init()   
 
      #進入選單 Menu (="N")
      CALL axcq539_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq539
      
   END IF 
   
   CLOSE axcq539_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq539.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq539_init()
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
   CALL cl_set_act_visible("qbehidden",FALSE) 
   SELECT ooef004,ooef008,ooef009,ooef017 INTO g_ooef004,g_ooef008,g_ooef009,g_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site 
   LET g_errshow = 1  
   INITIALIZE g_master_t.* TO NULL 
   #CALL cl_set_combo_scc('b_xccl014','200')  
   #CALL cl_set_combo_scc('b_xcck012','200')  
   #CALL cl_set_combo_scc('b_xcck020','8542')
   #CALL cl_set_combo_scc('b_xccl020','8542')   
   CALL cl_set_combo_scc('b_xcck020','200')
   CALL cl_set_combo_scc('b_xccl020','200')    
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld   
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp    
   #end add-point
 
   CALL axcq539_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq539.default_search" >}
PRIVATE FUNCTION axcq539_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF   
      
   #end add-point
 
   
 
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
 
{<section id="axcq539.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq539_ui_dialog() 
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
   LET g_errshow = 1
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axcq539_cs()
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
 
         CALL axcq539_init()
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
               CALL axcq539_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq539_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axcq539_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_master.chk) THEN
               LET g_master.chk = 'Y' 
            END IF    
            IF cl_null(g_master.xcckcomp) AND cl_null(g_master.xcckld) AND cl_null(g_master.xcck004e)
               AND cl_null(g_master.xcck005e) AND cl_null(g_master.xcck003) 
               AND cl_null(g_master.xcck004) AND cl_null(g_master.xcck005) THEN              
               CALL s_axc_set_site_default() RETURNING g_master.xcckcomp,g_master.xcckld,g_master.xcck004e,g_master.xcck005e,g_master.xcck003
               LET g_master.xcck004 = g_master.xcck004e
               LET g_master.xcck005 = 1
               LET g_master_t.* = g_master.*
            END IF    
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcckcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
             
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcckld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcck003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
            
            DISPLAY g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcck004e,g_master.xcck005e 
                 TO xcckcomp,b_xcckld,b_xcck003,xcck004e,xcck005e            
            CALL cl_set_act_visible("qbehidden",FALSE) 
           {            
            NEXT FIELD xcckcomp
            #end add-point
            NEXT FIELD xcckld
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            }
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
 
            CALL axcq539_cs()
 
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
            CALL axcq539_fetch('F')
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
            CALL axcq539_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq539_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq539_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq539_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq539_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq539_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axcq539_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axcq539_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axcq539_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axcq539_b_fill()
 
         
         
         
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
               CALL axcq539_query()
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
 
{<section id="axcq539.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axcq539_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE  g_cnt_sql2    STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   IF g_master.xcck005 = 1 THEN
      LET g_xcck005 = 12
      LET g_xcck004 = g_master.xcck004 - 1
   ELSE
      LET g_xcck005 = g_master.xcck005 - 1
      LET g_xcck004 = g_master.xcck004       
   END IF   
   
   IF g_master.xcck005e = 1 THEN
      LET g_xcck005e = 12
      LET g_xcck004e = g_master.xcck004e - 1
   ELSE
      LET g_xcck005e = g_master.xcck005e - 1
      LET g_xcck004e = g_master.xcck004e         
   END IF  
   IF NOT cl_null(g_wc) THEN
      #替換
      LET g_wc_1 = cl_replace_str(g_wc,'xcck','xccm')
   END IF
   #161230-00010#16-S
   IF NOT cl_null(g_wc) THEN
      #替換
      LET g_wc_2 = cl_replace_str(g_wc,'xcck','xccj')
   END IF   
   #161230-00010#16-E
   IF NOT cl_null(g_wc2) THEN
      #替換
      LET g_wc2_1 = cl_replace_str(g_wc2,'xcck201','xccm101')
   END IF  
   IF NOT cl_null(g_wc2_1) THEN
      #替換
      LET g_wc2_1 = cl_replace_str(g_wc2_1,'xcck202','xccm102')
   END IF    
   IF NOT cl_null(g_wc2_1) THEN
      #替換
      LET g_wc2_1 = cl_replace_str(g_wc2_1,'xcck','xccm')
   END IF   
   #161230-00010#16-S
   IF NOT cl_null(g_wc2) THEN
      #替換
      LET g_wc2_2 = cl_replace_str(g_wc2,'xcck201','xccj101')
   END IF  
   IF NOT cl_null(g_wc2_2) THEN
      #替換
      LET g_wc2_2 = cl_replace_str(g_wc2_2,'xcck202','xccj102')
   END IF    
   IF NOT cl_null(g_wc2_2) THEN
      #替換
      LET g_wc2_2 = cl_replace_str(g_wc2_2,'xcck','xccj')
   END IF    
   #161230-00010#16-E   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      IF g_master.chk = 'N' THEN
         LET g_sql2 = " SELECT DISTINCT xcckcomp,xcckld,xcck003 FROM xcck_t ",
                      "   LEFT OUTER JOIN xccl_t ON xcclent = xcckent AND xcclcomp = xcckcomp AND xcclld = xcckld AND xccl001 = xcck001 ",
                      "    AND xccl002 = xcck002 AND xccl003 = xcck003 AND xccl004 = xcck004 AND xccl005 = xcck005 ",
                      "    AND xccl009 = xcck006 AND xccl010 = xcck007 AND xccl011 = xcck008 ",
                      "  WHERE xcckent = ",g_enterprise,
                      "    AND xcck009 = '1' ",
                      "    AND (xcck004*12+xcck005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xcck004*12+xcck005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql2 = g_sql2 ," AND xcckld IN ",g_wc_cs_ld
         END IF                      
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql2 = g_sql2 ," AND xcckcomp IN ",g_wc_cs_comp
         END IF           
                     
         LET g_sql3 = " SELECT DISTINCT xccmcomp,xccmld,xccm003 FROM xccm_t ",
                      "   LEFT OUTER JOIN xccl_t ON xcclent = xccment AND xcclcomp = xccmcomp AND xcclld = xccmld AND xccl001 = xccm001 ",
                      "    AND xccl002 = xccm002 AND xccl003 = xccm003 AND xccl004 = xccm004 AND xccl005 = xccm005 ",
                      "    AND xccl009 = xccm006 AND xccl010 = xccm007 AND xccl011 = xccm008 ",
                      "  WHERE xccment = ",g_enterprise,
                      "    AND xccm009 = '1' ",
                      "    AND (xccm004*12+xccm005) >= (",g_xcck004*12+g_xcck005,")",
                      "    AND (xccm004*12+xccm005) <= (",g_xcck004e*12+g_xcck005e,")",
                      "    AND ",g_wc_1
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql3 = g_sql3 ," AND xccmld IN ",g_wc_cs_ld
         END IF                         
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql3 = g_sql3 ," AND xccmcomp IN ",g_wc_cs_comp
         END IF    
         #161230-00010#16-S
         LET g_sql4= " SELECT DISTINCT xccjcomp,xccjld,xccj003 FROM xccj_t ",
                      "   LEFT OUTER JOIN xccl_t ON xcclent = xccjent AND xcclcomp = xccjcomp AND xcclld = xccjld AND xccl001 = xccj001 ",
                      "    AND xccl002 = xccj002 AND xccl003 = xccj003 AND xccl004 = xccj004 AND xccl005 = xccj005 ",
                      "    AND xccl009 = xccj006 AND xccl010 = xccj007 AND xccl011 = xccj008 ",
                      "  WHERE xccjent = ",g_enterprise,
                      "    AND xccj009 = '1' ",
                      "    AND (xccj004*12+xccj005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xccj004*12+xccj005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc_2
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql4= g_sql4," AND xccjld IN ",g_wc_cs_ld
         END IF                         
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql4= g_sql4," AND xccjcomp IN ",g_wc_cs_comp
         END IF          
         #161230-00010#16-E         
         #LET g_sql = g_sql2,"  UNION ",g_sql3, "  ORDER BY xcckcomp,xcckld,xcck003 "       #161230-00010#16  mark       
         LET g_sql = g_sql2,"  UNION ",g_sql3, " UNION ",g_sql4         
         LET g_sql = "SELECT a.xcckcomp,a.xcckld,a.xcck003 FROM (",g_sql,") a ORDER BY a.xcckcomp,a.xcckld,a.xcck003 "          
      END IF    
      IF g_master.chk = 'Y' THEN
         LET g_sql2 = " SELECT DISTINCT xcckcomp,xcckld,xcck003 FROM xcck_t ",
                      "  INNER JOIN xccl_t ON xcclent = xcckent AND xcclcomp = xcckcomp AND xcclld = xcckld AND xccl001 = xcck001 ",
                      "    AND xccl002 = xcck002 AND xccl003 = xcck003 AND xccl004 = xcck004 AND xccl005 = xcck005 ",
                      "    AND xccl009 = xcck006 AND xccl010 = xcck007 AND xccl011 = xcck008 ",
                      "  WHERE xcckent = ",g_enterprise,
                      "    AND xcck009 = '1' ",
                      "    AND (xcck004*12+xcck005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xcck004*12+xcck005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql2 = g_sql2 ," AND xcckld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql2 = g_sql2 ," AND xcckcomp IN ",g_wc_cs_comp
         END IF                          
                                          
         LET g_sql3 =" SELECT DISTINCT xccmcomp,xccmld,xccm003 FROM xccm_t ",
                     "  INNER JOIN xccl_t ON xcclent = xccment AND xcclcomp = xccmcomp AND xcclld = xccmld AND xccl001 = xccm001 ",
                     "    AND xccl002 = xccm002 AND xccl003 = xccm003 AND xccl004 = xccm004 AND xccl005 = xccm005 ",
                     "    AND xccl009 = xccm006 AND xccl010 = xccm007 AND xccl011 = xccm008 ",
                     "  WHERE xccment = ",g_enterprise,
                     "    AND xccm009 = '1' ",
                     "    AND (xccm004*12+xccm005) >= (",g_xcck004*12+g_xcck005,")",
                     "    AND (xccm004*12+xccm005) <= (",g_xcck004e*12+g_xcck005e,")",
                     "    AND ",g_wc_1
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql3 = g_sql3 ," AND xccmld IN ",g_wc_cs_ld
         END IF                         
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql3 = g_sql3 ," AND xccmcomp IN ",g_wc_cs_comp
         END IF      
         #161230-00010#16-S
         LET g_sql4 =" SELECT DISTINCT xccjcomp,xccjld,xccj003 FROM xccj_t ",
                     "  INNER JOIN xccl_t ON xcclent = xccjent AND xcclcomp = xccjcomp AND xcclld = xccjld AND xccl001 = xccj001 ",
                     "    AND xccl002 = xccj002 AND xccl003 = xccj003 AND xccl004 = xccj004 AND xccl005 = xccj005 ",
                     "    AND xccl009 = xccj006 AND xccl010 = xccj007 AND xccl011 = xccj008 ",
                     "  WHERE xccjent = ",g_enterprise,
                     "    AND xccj009 = '1' ",
                     "    AND (xccj004*12+xccj005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                     "    AND (xccj004*12+xccj005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                     "    AND ",g_wc_2
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql4 = g_sql4 ," AND xccjld IN ",g_wc_cs_ld
         END IF                         
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql4 = g_sql4 ," AND xccjcomp IN ",g_wc_cs_comp
         END IF           
         #161230-00010#16-E  
         LET g_sql = g_sql2,"  UNION ",g_sql3, " UNION ",g_sql4         
         #LET g_sql = g_sql2,"  UNION ",g_sql3, " UNION ",g_sql4,"  ORDER BY xcckcomp,xcckld,xcck003 "  #161230-00010#16 
         LET g_sql = "SELECT a.xcckcomp,a.xcckld,a.xcck003 FROM (",g_sql,") a ORDER BY xcckcomp,xcckld,xcck003 " 
      END IF         
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      IF g_master.chk = 'N' THEN
         LET g_sql2 = " SELECT DISTINCT xcckcomp,xcckld,xcck003 FROM xcck_t ",
                      "   LEFT OUTER JOIN xccl_t ON xcclent = xcckent AND xcclcomp = xcckcomp AND xcclld = xcckld AND xccl001 = xcck001 ",
                      "    AND xccl002 = xcck002 AND xccl003 = xcck003 AND xccl004 = xcck004 AND xccl005 = xcck005 ",
                      "    AND xccl009 = xcck006 AND xccl010 = xcck007 AND xccl011 = xcck008 ",
                      "  WHERE xcckent = ",g_enterprise,
                      "    AND xcck009 = '1' ",
                      "    AND (xcck004*12+xcck005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xcck004*12+xcck005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc,
                      "    AND ",g_wc2
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql2 = g_sql2 ," AND xcckld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql2 = g_sql2 ," AND xcckcomp IN ",g_wc_cs_comp
         END IF                                              
                     
         LET g_sql3 = " SELECT DISTINCT xccmcomp,xccmld,xccm003 FROM xccm_t ",
                      "   LEFT OUTER JOIN xccl_t ON xcclent = xccment AND xcclcomp = xccmcomp AND xcclld = xccmld AND xccl001 = xccm001 ",
                      "    AND xccl002 = xccm002 AND xccl003 = xccm003 AND xccl004 = xccm004 AND xccl005 = xccm005 ",
                      "    AND xccl009 = xccm006 AND xccl010 = xccm007 AND xccl011 = xccm008 ",
                      "  WHERE xccment = ",g_enterprise,
                      "    AND xccm009 = '1' ",
                      "    AND (xccm004*12+xccm005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xccm004*12+xccm005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc_1,
                      "    AND ",g_wc2_1
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql3 = g_sql3 ," AND xccmld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql3 = g_sql3 ," AND xccmcomp IN ",g_wc_cs_comp
         END IF  
   
         #161230-00010#16-S
         LET g_sql4 = " SELECT DISTINCT xccjcomp,xccjld,xccj003 FROM xccj_t ",
                      "   LEFT OUTER JOIN xccl_t ON xcclent = xccjent AND xcclcomp = xccjcomp AND xcclld = xccjld AND xccl001 = xccj001 ",
                      "    AND xccl002 = xccj002 AND xccl003 = xccj003 AND xccl004 = xccj004 AND xccl005 = xccj005 ",
                      "    AND xccl009 = xccj006 AND xccl010 = xccj007 AND xccl011 = xccj008 ",
                      "  WHERE xccjent = ",g_enterprise,
                      "    AND xccj009 = '1' ",
                      "    AND (xccj004*12+xccj005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xccj004*12+xccj005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc_2,
                      "    AND ",g_wc2_2
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql4 = g_sql4 ," AND xccjld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql4 = g_sql4 ," AND xccjcomp IN ",g_wc_cs_comp
         END IF           
         #161230-00010#16-E
         
         LET g_sql = g_sql2,"  UNION ",g_sql3, " UNION ",g_sql4  #161230-00010#16               
         LET g_sql = "SELECT a.xcckcomp,a.xcckld,a.xcck003 FROM (",g_sql,") a ORDER BY a.xcckcomp,a.xcckld,a.xcck003 " #161230-00010#16         
                     
      END IF    
      IF g_master.chk = 'Y' THEN
         LET g_sql2 = " SELECT DISTINCT xcckcomp,xcckld,xcck003 FROM xcck_t ",
                      "  INNER JOIN xccl_t ON xcclent = xcckent AND xcclcomp = xcckcomp AND xcclld = xcckld AND xccl001 = xcck001 ",
                      "    AND xccl002 = xcck002 AND xccl003 = xcck003 AND xccl004 = xcck004 AND xccl005 = xcck005 ",
                      "    AND xccl009 = xcck006 AND xccl010 = xcck007 AND xccl011 = xcck008 ",
                      "  WHERE xcckent = ",g_enterprise,
                      "    AND xcck009 = '1' ",
                      "    AND (xcck004*12+xcck005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xcck004*12+xcck005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc,
                      "    AND ",g_wc2
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql2 = g_sql2 ," AND xcckld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql2 = g_sql2 ," AND xcckcomp IN ",g_wc_cs_comp
         END IF                         
                     
         LET g_sql3 = " SELECT DISTINCT xccmcomp,xccmld,xccm003 FROM xccm_t ",
                      "  INNER JOIN xccl_t ON xcclent = xccment AND xcclcomp = xccmcomp AND xcclld = xccmld AND xccl001 = xccm001 ",
                      "    AND xccl002 = xccm002 AND xccl003 = xccm003 AND xccl004 = xccm004 AND xccl005 = xccm005 ",
                      "    AND xccl009 = xccm006 AND xccl010 = xccm007 AND xccl011 = xccm008 ",
                      "  WHERE xccment = ",g_enterprise,
                      "    AND xccm009 = '1' ",
                      "    AND (xccm004*12+xccm005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xccm004*12+xccm005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc_1,
                      "    AND ",g_wc2_1
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql3 = g_sql3 ," AND xccmld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql3 = g_sql3 ," AND xccmcomp IN ",g_wc_cs_comp
         END IF  

         #161230-00010#16-S
         LET g_sql4 = " SELECT DISTINCT xccjcomp,xccjld,xccj003 FROM xccj_t ",
                      "  INNER JOIN xccl_t ON xcclent = xccjent AND xcclcomp = xccjcomp AND xcclld = xccjld AND xccl001 = xccj001 ",
                      "    AND xccl002 = xccj002 AND xccl003 = xccj003 AND xccl004 = xccj004 AND xccl005 = xccj005 ",
                      "    AND xccl009 = xccj006 AND xccl010 = xccj007 AND xccl011 = xccj008 ",
                      "  WHERE xccjent = ",g_enterprise,
                      "    AND xccj009 = '1' ",
                      "    AND (xccj004*12+xccj005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                      "    AND (xccj004*12+xccj005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                      "    AND ",g_wc_2,
                      "    AND ",g_wc2_2
         #增加帳套權限控管
         IF NOT cl_null(g_wc_cs_ld) THEN
            LET g_sql4 = g_sql4 ," AND xccjld IN ",g_wc_cs_ld
         END IF                          
         #增加法人過濾條件
         IF NOT cl_null(g_wc_cs_comp) THEN
            LET g_sql4 = g_sql4 ," AND xccjcomp IN ",g_wc_cs_comp
         END IF         
         #161230-00010#16-E
         LET g_sql = g_sql2,"  UNION ",g_sql3, " UNION ",g_sql4  #161230-00010#16               
         LET g_sql = "SELECT a.xcckcomp,a.xcckld,a.xcck003 FROM (",g_sql,") a ORDER BY a.xcckcomp,a.xcckld,a.xcck003 " #161230-00010#16                       
      END IF   
      #end add-point
   END IF
 
   PREPARE axcq539_pre FROM g_sql
   DECLARE axcq539_curs SCROLL CURSOR WITH HOLD FOR axcq539_pre
   OPEN axcq539_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql2 = " SELECT COUNT(1) FROM (",g_sql,")"  
   PREPARE axcq539_precount2 FROM g_cnt_sql2
   EXECUTE axcq539_precount2 INTO g_row_count 
   
   CALL g_browser.clear()
   IF g_row_count = 0 THEN
      RETURN
   END IF
   LET g_cnt = 1
   FOREACH axcq539_curs INTO g_browser[g_cnt].xcckcomp,g_browser[g_cnt].xcckld,g_browser[g_cnt].xcck003
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF                              
      LET g_cnt = g_cnt + 1
   END FOREACH 
   
   #IF cl_null(g_browser[g_cnt].xcckcomp) THEN
   CALL g_browser.deleteElement(g_browser.getLength())
   LET g_detail_cnt = g_browser.getLength()
   #END IF   
   LET g_row_count = g_browser.getLength() 
   #LET g_cnt = 0
   DISPLAY g_row_count TO FORMONLY.h_count 
   CALL axcq539_fetch("F")
   CALL axcq539_b_fill()
   #筆數顯示
   IF g_row_count > 0 THEN
      DISPLAY g_detail_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_row_count TO FORMONLY.h_count 

   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF   
   RETURN 
   #end add-point
   PREPARE axcq539_precount FROM g_cnt_sql
   EXECUTE axcq539_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axcq539_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcq539.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axcq539_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   IF g_detail_cnt = 0 THEN
      RETURN
   END IF 
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'P' LET g_current_idx = g_current_idx - 1
      WHEN 'N' LET g_current_idx = g_current_idx + 1
      WHEN 'L' LET g_current_idx = g_row_count
      WHEN '/' LET g_current_idx = g_jump
   END CASE
   DISPLAY g_current_idx TO FORMONLY.h_index
   DISPLAY g_row_count TO FORMONLY.h_count
   #代表沒有資料

   IF g_current_idx = 0 THEN
      RETURN
   END IF   
   CALL cl_navigator_setting( g_current_idx, g_row_count )
   LET g_master.xcckcomp = g_browser[g_current_idx].xcckcomp  
   LET g_master.xcckld = g_browser[g_current_idx].xcckld
   LET g_master.xcck003 = g_browser[g_current_idx].xcck003
   
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
            
   DISPLAY g_master.* TO xcckcomp,xcckcomp_desc,b_xcck004,b_xcck005,b_xcck003,b_xcck003_desc, 
       b_xcckld,b_xcckld_desc,xcck004e,xcck005e,chk
    
   CALL axcq539_show()    
   RETURN
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO xcckcomp,xcckcomp_desc,b_xcck004,b_xcck005,b_xcck003,b_xcck003_desc,b_xcckld, 
          b_xcckld_desc,xcck004e,xcck005e,chk
      CALL g_detail.clear()
 
      #add-point:陣列清空 name="fetch.array_clear"
      INITIALIZE g_master_t.* TO NULL
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
   CALL axcq539_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq539.show" >}
PRIVATE FUNCTION axcq539_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO xcckcomp,xcckcomp_desc,b_xcck004,b_xcck005,b_xcck003,b_xcck003_desc,b_xcckld, 
       b_xcckld_desc,xcck004e,xcck005e,chk
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axcq539_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq539.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq539_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_sql2          STRING
   DEFINE l_sql3          STRING
   DEFINE l_sql4          STRING
   DEFINE l_xcck014       LIKE xcck_t.xcck014
   DEFINE l_xcckcrtdt     LIKE xcck_t.xcckcrtdt
   DEFINE l_xccl016       LIKE xccl_t.xccl016
   DEFINE l_xcclcrtdt     LIKE xccl_t.xcclcrtdt
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_xcck010_t     LIKE xcck_t.xcck010
   DEFINE l_xcck013_t     LIKE xcck_t.xcck013
   DEFINE l_xcck014_t     LIKE xcck_t.xcck014
   DEFINE l_xcckcrtdt_t   LIKE xcck_t.xcckcrtdt
   DEFINE l_xcck006_t     LIKE xcck_t.xcck006
   DEFINE l_xcck007_t     LIKE xcck_t.xcck007
   DEFINE l_xcck008_t     LIKE xcck_t.xcck008
   DEFINE l_xcck201_t     LIKE xcck_t.xcck201
   DEFINE l_xcck202_t     LIKE xcck_t.xcck202
   DEFINE s_xcck202       LIKE xcck_t.xcck202
   DEFINE s_xccl102       LIKE xccl_t.xccl102
   DEFINE s_xcee402       LIKE xcee_t.xcee402
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc2_1) THEN
      LET g_wc2_1 = " 1=1"
   END IF
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET l_flag = 'N'
   IF g_wc2.getIndexOf("xccl", 1) > 0 THEN 
      LET l_flag = 'Y' 
   END IF 
   IF g_master.chk = 'N' AND l_flag = 'N' THEN
      LET l_sql2 = " SELECT DISTINCT xcck013,xcck012,xcck020,xcck010,xcck006,xcck007,xcck008,xcck201,xcck202,xccl015,xccl014, ",
                   "        xccl020,xccl006,xccl007,xccl008,xccl101,xccl102,imaal003,imaal004,0,xcck014,xcckcrtdt,xccl016,xcclcrtdt ", #161230-00010#14 add 0
                   "   FROM xcck_t ",
                   "   LEFT OUTER JOIN xccl_t ON xcclent = xcckent AND xcclcomp = xcckcomp AND xcclld = xcckld AND xccl001 = xcck001 ",
                   "    AND xccl002 = xcck002 AND xccl003 = xcck003 AND xccl004 = xcck004 AND xccl005 = xcck005 ",
                   "    AND xccl009 = xcck006 AND xccl010 = xcck007 AND xccl011 = xcck008 ",
                   "   LEFT OUTER JOIN imaal_t ON imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '",g_dlang,"'",
                   "  WHERE xcckent = ",g_enterprise,
                   "    AND xcck009 = '1' ",
                   "    AND (xcck004*12+xcck005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                   "    AND (xcck004*12+xcck005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                   "    AND ",g_wc2,
                   "    AND xcckcomp = ? ",
                   "    AND xcckld = ? ",
                   "    AND xcck003 = ? "  
      #增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql2 = l_sql2 ," AND xcckld IN ",g_wc_cs_ld
       END IF
      #增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql2 = l_sql2 ," AND xcckcomp IN ",g_wc_cs_comp
      END IF                        
                  
      LET l_sql3 = " SELECT DISTINCT xccm013,xccm012,xccm020,xccm010,xccm006,xccm007,xccm008,xccm101,xccm102,xccl015,xccl014, ",
                   "        xccl020,xccl006,xccl007,xccl008,xccl101,xccl102,imaal003,imaal004,0,xccm014,xccmcrtdt,xccl016,xcclcrtdt ",  #161230-00010#14 add 0
                   "   FROM xccm_t ",              
                   "   LEFT OUTER JOIN xccl_t ON xcclent = xccment AND xcclcomp = xccmcomp AND xcclld = xccmld AND xccl001 = xccm001 ",
                   "    AND xccl002 = xccm002 AND xccl003 = xccm003 AND xccl004 = xccm004 AND xccl005 = xccm005 ",
                   "    AND xccl009 = xccm006 AND xccl010 = xccm007 AND xccl011 = xccm008 ",
                   "   LEFT OUTER JOIN imaal_t ON imaalent = xccment AND imaal001 = xccm010 AND imaal002 = '",g_dlang,"'",
                   "  WHERE xccment = ",g_enterprise,
                   "    AND xccm009 = '1' ",
                   "    AND (xccm004*12+xccm005) >= (",g_xcck004*12+g_xcck005,")",
                   "    AND (xccm004*12+xccm005) <= (",g_xcck004e*12+g_xcck005e,")",
                   "    AND ",g_wc2_1,
                   "    AND xccmcomp = ? ",
                   "    AND xccmld = ? ",
                   "    AND xccm003 = ? "
      #增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql3 = l_sql3 ," AND xccmld IN ",g_wc_cs_ld
       END IF
      #增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql3 = l_sql3 ," AND xccmcomp IN ",g_wc_cs_comp
      END IF  

      #161230-00010#16-S
      LET l_sql4 = " SELECT DISTINCT xccj013,xccj012,xccj020,xccj010,xccj006,xccj007,xccj008,xccj101,xccj102,xccl015,xccl014, ",
                   "        xccl020,xccl006,xccl007,xccl008,xccl101,xccl102,imaal003,imaal004,0,substr(xccj014,11,9),xccj014,xccl016,xcclcrtdt ",  #161230-00010#14 add 0
                   "   FROM xccj_t ",              
                   "   LEFT OUTER JOIN xccl_t ON xcclent = xccjent AND xcclcomp = xccjcomp AND xcclld = xccjld AND xccl001 = xccj001 ",
                   "    AND xccl002 = xccj002 AND xccl003 = xccj003 AND xccl004 = xccj004 AND xccl005 = xccj005 ",
                   "    AND xccl009 = xccj006 AND xccl010 = xccj007 AND xccl011 = xccj008 ",
                   "   LEFT OUTER JOIN imaal_t ON imaalent = xccjent AND imaal001 = xccj010 AND imaal002 = '",g_dlang,"'",
                   "  WHERE xccjent = ",g_enterprise,
                   "    AND xccj009 = '1' ",
                   "    AND (xccj004*12+xccj005) >= (",g_xcck004*12+g_xcck005,")",
                   "    AND (xccj004*12+xccj005) <= (",g_xcck004e*12+g_xcck005e,")",
                   "    AND ",g_wc2_2,
                   "    AND xccjcomp = ? ",
                   "    AND xccjld = ? ",
                   "    AND xccj003 = ? "
      #增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql4 = l_sql4 ," AND xccjld IN ",g_wc_cs_ld
       END IF
      #增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql4 = l_sql4 ," AND xccjcomp IN ",g_wc_cs_comp
      END IF  
      #161230-00010#16-E
      
      #LET l_sql = l_sql2,"  UNION ",l_sql3," UNION ",l_sql4,"  ORDER BY xcck010,xcck013,xcck014,xcckcrtdt,xccl015,xccl016,xcclcrtdt "    #161230-00010#16 
      LET l_sql = l_sql2,"  UNION ",l_sql3," UNION ",l_sql4
      LET l_sql = " SELECT DISTINCT a.xcck013,a.xcck012,a.xcck020,a.xcck010,a.xcck006,a.xcck007,a.xcck008,a.xcck201,a.xcck202,a.xccl015,a.xccl014, ",
                  "        a.xccl020,a.xccl006,a.xccl007,a.xccl008,a.xccl101,a.xccl102,a.imaal003,a.imaal004,0,a.xcck014,a.xcckcrtdt,a.xccl016,a.xcclcrtdt ", 
                  "   FROM (",l_sql,") a"," ORDER BY a.xcck010,a.xcck013,a.xcck014,a.xcckcrtdt,a.xccl015,a.xccl016,a.xcclcrtdt "      
   ELSE   
      LET l_sql2 = " SELECT DISTINCT xcck013,xcck012,xcck020,xcck010,xcck006,xcck007,xcck008,xcck201,xcck202,xccl015,xccl014, ",
                   "        xccl020,xccl006,xccl007,xccl008,xccl101,xccl102,imaal003,imaal004,0,xcck014,xcckcrtdt,xccl016,xcclcrtdt  ",  #161230-00010#14 add 0
                   "   FROM xcck_t ",
                   "  INNER JOIN xccl_t ON xcclent = xcckent AND xcclcomp = xcckcomp AND xcclld = xcckld AND xccl001 = xcck001 ",
                   "    AND xccl002 = xcck002 AND xccl003 = xcck003 AND xccl004 = xcck004 AND xccl005 = xcck005 ",
                   "    AND xccl009 = xcck006 AND xccl010 = xcck007 AND xccl011 = xcck008 ",
                   "   LEFT OUTER JOIN imaal_t ON imaalent = xcckent AND imaal001 = xcck010 AND imaal002 = '",g_dlang,"'",
                   "  WHERE xcckent = ",g_enterprise,
                   "    AND xcck009 = '1' ",
                   "    AND (xcck004*12+xcck005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                   "    AND (xcck004*12+xcck005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                   "    AND ",g_wc2,
                   "    AND xcclcomp = ? ",
                   "    AND xcclld = ? ",
                   "    AND xccl003 = ? "    
      #增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql2 = l_sql2 ," AND xcckld IN ",g_wc_cs_ld
       END IF
      #增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql2 = l_sql2 ," AND xcckcomp IN ",g_wc_cs_comp
      END IF                      

      LET l_sql3 = " SELECT DISTINCT xccm013,xccm012,xccm020,xccm010,xccm006,xccm007,xccm008,xccm101,xccm102,xccl015,xccl014, ",
                   "        xccl020,xccl006,xccl007,xccl008,xccl101,xccl102,imaal003,imaal004,0,xccm014,xccmcrtdt,xccl016,xcclcrtdt ", #161230-00010#14 add 0
                   "   FROM xccm_t ",              
                   "  INNER JOIN xccl_t ON xcclent = xccment AND xcclcomp = xccmcomp AND xcclld = xccmld AND xccl001 = xccm001 ",
                   "    AND xccl002 = xccm002 AND xccl003 = xccm003 AND xccl004 = xccm004 AND xccl005 = xccm005 ",
                   "    AND xccl009 = xccm006 AND xccl010 = xccm007 AND xccl011 = xccm008 ",
                   "   LEFT OUTER JOIN imaal_t ON imaalent = xccment AND imaal001 = xccm010 AND imaal002 = '",g_dlang,"'",
                   "  WHERE xccment = ",g_enterprise,
                   "    AND xccm009 = '1' ",
                   "    AND (xccm004*12+xccm005) >= (",g_xcck004*12+g_xcck005,")",
                   "    AND (xccm004*12+xccm005) <= (",g_xcck004e*12+g_xcck005e,")",
                   "    AND ",g_wc2_1,
                   "    AND xccmcomp = ? ",
                   "    AND xccmld = ? ",
                   "    AND xccm003 = ? "
      #增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql3 = l_sql3 ," AND xccmld IN ",g_wc_cs_ld
       END IF
      #增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql3 = l_sql3 ," AND xccmcomp IN ",g_wc_cs_comp
      END IF 

      #161230-00010#16-S
      LET l_sql4 = " SELECT DISTINCT xccj013,xccj012,xccj020,xccj010,xccj006,xccj007,xccj008,xccj101,xccj102,xccl015,xccl014, ",
                   "        xccl020,xccl006,xccl007,xccl008,xccl101,xccl102,imaal003,imaal004,0,substr(xccj014,11,9),xccj014,xccl016,xcclcrtdt ", #161230-00010#14 add 0
                   "   FROM xccj_t ",              
                   "  INNER JOIN xccl_t ON xcclent = xccjent AND xcclcomp = xccjcomp AND xcclld = xccjld AND xccl001 = xccj001 ",
                   "    AND xccl002 = xccj002 AND xccl003 = xccj003 AND xccl004 = xccj004 AND xccl005 = xccj005 ",
                   "    AND xccl009 = xccj006 AND xccl010 = xccj007 AND xccl011 = xccj008 ",
                   "   LEFT OUTER JOIN imaal_t ON imaalent = xccjent AND imaal001 = xccj010 AND imaal002 = '",g_dlang,"'",
                   "  WHERE xccjent = ",g_enterprise,
                   "    AND xccj009 = '1' ",
                   "    AND (xccj004*12+xccj005) >= (",g_master.xcck004*12+g_master.xcck005,")",
                   "    AND (xccj004*12+xccj005) <= (",g_master.xcck004e*12+g_master.xcck005e,")",
                   "    AND ",g_wc2_2,
                   "    AND xccjcomp = ? ",
                   "    AND xccjld = ? ",
                   "    AND xccj003 = ? "
      #增加帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sql4 = l_sql4 ," AND xccjld IN ",g_wc_cs_ld
       END IF
      #增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET l_sql4 = l_sql4 ," AND xccjcomp IN ",g_wc_cs_comp
      END IF       
      #161230-00010#16-E
      LET l_sql = l_sql2,"  UNION ",l_sql3," UNION ",l_sql4
      LET l_sql = " SELECT DISTINCT a.xcck013,a.xcck012,a.xcck020,a.xcck010,a.xcck006,a.xcck007,a.xcck008,a.xcck201,a.xcck202,a.xccl015,a.xccl014, ",
                  "        a.xccl020,a.xccl006,a.xccl007,a.xccl008,a.xccl101,a.xccl102,a.imaal003,a.imaal004,0,a.xcck014,a.xcckcrtdt,a.xccl016,a.xcclcrtdt ", 
                  "   FROM (",l_sql,") a"," ORDER BY a.xcck010,a.xcck013,a.xcck014,a.xcckcrtdt,a.xccl015,a.xccl016,a.xcclcrtdt "    
   END IF   
   PREPARE axcq539_xcck_xccm_pre FROM l_sql
   DECLARE axcq539_xcck_xccm_cur CURSOR FOR axcq539_xcck_xccm_pre  
   
   CALL g_detail.clear()
   LET l_ac = 1
   LET l_xcck010_t = ''
   LET l_xcck013_t = ''
   LET l_xcck014_t = ''
   LET l_xcckcrtdt_t = ''
   LET l_xcck006_t = ''
   LET l_xcck007_t = ''
   LET l_xcck008_t = ''
   LET l_xcck201_t = ''
   LET l_xcck202_t = ''
   LET s_xcck202 = 0
   LET s_xccl102 = 0
   LET s_xcee402 = 0
   FOREACH axcq539_xcck_xccm_cur USING g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcckcomp,g_master.xcckld,g_master.xcck003   #161230-00010#16
                                  INTO g_detail[l_ac].xcck013,g_detail[l_ac].xcck012,g_detail[l_ac].xcck020,g_detail[l_ac].xcck010,g_detail[l_ac].xcck006,g_detail[l_ac].xcck007,
                                       g_detail[l_ac].xcck008,g_detail[l_ac].xcck201,g_detail[l_ac].xcck202,g_detail[l_ac].xccl015,g_detail[l_ac].xccl014,g_detail[l_ac].xccl020, 
                                       g_detail[l_ac].xccl006,g_detail[l_ac].xccl007,g_detail[l_ac].xccl008,g_detail[l_ac].xccl101,g_detail[l_ac].xccl102, 
                                       g_detail[l_ac].xcck010_desc,g_detail[l_ac].xcck010_desc_1,g_detail[l_ac].xcee402,l_xcck014,l_xcckcrtdt,l_xccl016,l_xcclcrtdt   #161230-00010#14 add  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axcq539_xcck_xccm_cur:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      #161230-00010#14-S
      SELECT SUM(xcee013*xcee402) INTO g_detail[l_ac].xcee402 FROM xcee_t
       INNER JOIN xcck_t ON xceeent = xcckent AND xceesite = xccksite AND xceecomp = xcckcomp AND xceeld = xcckld
              AND xcee001 = xcck001 AND xcee002 = xcck002 AND xcee003 = xcck003 AND xcee004 = xcck004 AND xcee005 = xcck005 
              AND xcee006 = xcck006 AND xcee007 = xcck007 AND xcee008 = xcck008 AND xcee009 = xcck009             
       WHERE xceeent = g_enterprise
         AND xceesite = g_site
         AND xceecomp = g_master.xcckcomp
         AND xceeld = g_master.xcckld
         AND xcee006 = g_detail[l_ac].xcck006
         AND xcee007 = g_detail[l_ac].xcck007
         AND xcee008 = g_detail[l_ac].xcck008
      IF cl_null(g_detail[l_ac].xcee402) THEN LET g_detail[l_ac].xcee402 = 0 END IF  
      #161230-00010#14-E
      
      IF l_xcck010_t = g_detail[l_ac].xcck010 AND l_xcck013_t = g_detail[l_ac].xcck013 AND l_xcck014_t = l_xcck014 AND 
         l_xcckcrtdt_t = l_xcckcrtdt AND l_xcck006_t = g_detail[l_ac].xcck006 AND l_xcck007_t = g_detail[l_ac].xcck007 AND 
         l_xcck008_t = g_detail[l_ac].xcck008 AND l_xcck201_t = g_detail[l_ac].xcck201 AND l_xcck202_t = g_detail[l_ac].xcck202 THEN
         LET s_xccl102 = s_xccl102 + g_detail[l_ac].xccl102 
         LET s_xcee402 = s_xcee402 + g_detail[l_ac].xcee402
         LET g_detail[l_ac].xcck013 = ''
         LET g_detail[l_ac].xcck012 = ''
         LET g_detail[l_ac].xcck020 = ''
         LET g_detail[l_ac].xcck010 = ''
         LET g_detail[l_ac].xcck006 = ''
         LET g_detail[l_ac].xcck007 = ''
         LET g_detail[l_ac].xcck008 = ''
         LET g_detail[l_ac].xcck201 = ''
         LET g_detail[l_ac].xcck202 = ''         
      ELSE         
         #合計
         LET l_flag = 'N'
         IF g_detail[l_ac].xcck010 <> l_xcck010_t THEN
            LET l_flag = 'Y'
         ELSE
            LET s_xcck202 = s_xcck202 + g_detail[l_ac].xcck202  
            LET s_xccl102 = s_xccl102 + g_detail[l_ac].xccl102 
            LET s_xcee402 = s_xcee402 + g_detail[l_ac].xcee402            
         END IF 
         LET l_xcck010_t = g_detail[l_ac].xcck010
         LET l_xcck013_t = g_detail[l_ac].xcck013
         LET l_xcck014_t = l_xcck014
         LET l_xcckcrtdt_t = l_xcckcrtdt
         LET l_xcck006_t = g_detail[l_ac].xcck006
         LET l_xcck007_t = g_detail[l_ac].xcck007
         LET l_xcck008_t = g_detail[l_ac].xcck008
         LET l_xcck201_t = g_detail[l_ac].xcck201
         LET l_xcck202_t = g_detail[l_ac].xcck202  
         IF l_flag = 'Y' THEN  #合計
            LET g_detail[l_ac+1].* = g_detail[l_ac].*
            INITIALIZE g_detail[l_ac].* TO NULL  
            CALL cl_getmsg('axc-00205',g_lang) RETURNING g_detail[l_ac].xcck010   
            LET g_detail[l_ac].xcck202 = s_xcck202
            LET g_detail[l_ac].xccl102 = s_xccl102
            LET g_detail[l_ac].xcee402 = s_xcee402
            LET l_ac = l_ac + 1
            LET s_xcck202 = g_detail[l_ac].xcck202 
            LET s_xccl102 = g_detail[l_ac].xccl102
            LET s_xcee402 = g_detail[l_ac].xcee402
         END IF          
      END IF    
      LET l_ac = l_ac + 1                                
   END FOREACH
   IF l_ac > 1 THEN   
      LET g_detail[l_ac].xcck202 = s_xcck202  
      LET g_detail[l_ac].xccl102 = s_xccl102
      LET g_detail[l_ac].xcee402 = s_xcee402
      CALL cl_getmsg('axc-00205',g_lang) RETURNING g_detail[l_ac].xcck010 
      LET g_tot_cnt = l_ac
      DISPLAY g_tot_cnt TO FORMONLY.cnt
   ELSE
      CALL g_detail.deleteElement(g_detail.getLength())     
   END IF   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq539_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq539_detail_action_trans()
 
   CALL axcq539_b_fill2()
   RETURN    
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
  
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET l_ac = l_ac - 1
   LET g_tot_cnt = l_ac
   DISPLAY g_tot_cnt TO FORMONLY.cnt
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq539_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq539_detail_action_trans()
 
   CALL axcq539_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq539.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq539_b_fill2()
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
 
{<section id="axcq539.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq539_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].xcck010
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].xcck010_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq539.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axcq539_maintain_prog()
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
 
{<section id="axcq539.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq539_detail_action_trans()
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
 
{<section id="axcq539.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq539_detail_index_setting()
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
 
{<section id="axcq539.mask_functions" >}
 &include "erp/axc/axcq539_mask.4gl"
 
{</section>}
 
{<section id="axcq539.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询
# Memo...........:
# Usage..........: CALL axcq539_query()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq539_query()
   
   LET INT_FLAG = 0
   #CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   CALL g_detail.clear()   
   CALL g_browser.clear()
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count 
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   INITIALIZE g_master_t.* TO NULL  
   
   CALL axcq539_construct()
   IF NOT INT_FLAG THEN 
      CALL axcq539_cs()
      CALL axcq539_fetch("F")
   END IF   
   #CALL axcq539_b_fill()
   #end add-point
        
   LET g_error_show = 1
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 獲取查詢條件
# Memo...........:
# Usage..........: CALL axcq539_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq539_construct()
    
   CALL g_detail.clear()
   LET g_action_choice = ""
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_filter TO NULL
   LET g_qryparam.state = 'c'
   CALL g_detail.clear()   
   CALL g_browser.clear() 
   INITIALIZE g_master.* TO NULL
   INITIALIZE g_master_t.* TO NULL
   LET INT_FLAG = FALSE
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)     

         
      CONSTRUCT g_wc ON xcckcomp,xcckld,xcck003      
                     FROM xcckcomp,b_xcckld,b_xcck003

         BEFORE CONSTRUCT

#            IF cl_null(g_master.chk) THEN
#               LET g_master.chk = 'Y' 
#            END IF    
#            IF cl_null(g_master.xcckcomp) AND cl_null(g_master.xcckld) AND cl_null(g_master.xcck004e)
#               AND cl_null(g_master.xcck005e) AND cl_null(g_master.xcck003) 
#               AND cl_null(g_master.xcck004) AND cl_null(g_master.xcck005) THEN            
#               CALL s_axc_set_site_default() RETURNING g_master.xcckcomp,g_master.xcckld,g_master.xcck004e,g_master.xcck005e,g_master.xcck003
#               LET g_master.xcck004 = g_master.xcck004e
#               LET g_master.xcck005 = 1               
#               LET g_master_t.* = g_master.*
#            END IF  
#            LET g_master_t.* = g_master.*
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xcckcomp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xcckld
#            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xcck003
#            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
#            
#            DISPLAY g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcck004e,g_master.xcck005e 
#                 TO xcckcomp,b_xcckld,b_xcck003,xcck004e,xcck005e
                 
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="construct.c.xcckcomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF            
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckcomp   #顯示到畫面上
            NEXT FIELD xcckcomp                      #返回原欄位                           
                     
         ON ACTION controlp INFIELD b_xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF            
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcckld  #顯示到畫面上
            NEXT FIELD b_xcckld                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="construct.c.xcck003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck003  #顯示到畫面上
            NEXT FIELD b_xcck003  
            
      END CONSTRUCT               


      INPUT g_master.xcck004,g_master.xcck005,g_master.xcck004e,g_master.xcck005e,g_master.chk
       FROM b_xcck004,b_xcck005,xcck004e,xcck005e,chk
       ATTRIBUTE(WITHOUT DEFAULTS)
       
         BEFORE INPUT 
            IF NOT cl_null(g_master.xcck004) THEN
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_master.xcck004
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF 
            END IF
            IF NOT cl_null(g_master.xcck004e) THEN
               SELECT MAX(oogc006) INTO g_oogc006_2 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_master.xcck004e
               IF cl_null(g_oogc006_2) THEN LET g_oogc006_2 = 12 END IF 
            END IF               
      
      
            
            AFTER FIELD b_xcck004
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004e) THEN
                  IF g_master.xcck004 > g_master.xcck004e THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xcck004 
                     LET g_errparam.code   = "axc-00825" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xcck004 = g_master_t.xcck004
                     NEXT FIELD b_xcck004
                  END IF 
               END IF
               SELECT MAX(oogc006) INTO g_oogc006 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef008
                  AND oogc002 = g_ooef009
                  AND oogc015 = g_master.xcck004
               IF cl_null(g_oogc006) THEN LET g_oogc006 = 12 END IF                   
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck005) THEN
                  IF g_master.xcck005 > g_oogc006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00844'
                     LET g_errparam.extend = g_master.xcck005
                     LET g_errparam.replace[1] =  g_oogc006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_master.xcck004 = g_master_t.xcck004
                     NEXT FIELD b_xcck004
                     DISPLAY BY NAME g_master.xcck004                    
                  END IF                                    
               END IF
               
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004e) AND
                  NOT cl_null(g_master.xcck005) AND NOT cl_null(g_master.xcck005e)  THEN
                  IF g_master.xcck004*12+g_master.xcck005 > g_master.xcck004e*12+g_master.xcck005e THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xcck004 
                     LET g_errparam.code   = "axc-00825" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xcck004 = g_master_t.xcck004
                     NEXT FIELD b_xcck004                     
                  END IF 
               END IF   
               LET g_master_t.xcck004 = g_master.xcck004 
            
            AFTER FIELD b_xcck005
               IF NOT cl_null(g_master.xcck005) THEN
                  IF g_master.xcck005 > g_oogc006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00844'
                     LET g_errparam.extend = g_master.xcck005
                     LET g_errparam.replace[1] =  g_oogc006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_master.xcck005 = g_master_t.xcck005
                     NEXT FIELD b_xcck005
                     DISPLAY BY NAME g_master.xcck005                    
                  END IF                                    
               END IF
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004e) AND
                  NOT cl_null(g_master.xcck005) AND NOT cl_null(g_master.xcck005e)  THEN
                  IF g_master.xcck004*12+g_master.xcck005 > g_master.xcck004e*12+g_master.xcck005e THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xcck005 
                     LET g_errparam.code   = "axc-00825" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xcck005 = g_master_t.xcck005
                     NEXT FIELD b_xcck005                     
                  END IF 
               END IF        
               LET g_master_t.xcck005 = g_master.xcck005
               
            AFTER FIELD xcck004e
            
               IF NOT cl_null(g_master.xcck005e) AND cl_null(g_master.xcck004e) THEN
                  IF g_master.xcck005e > g_oogc006_2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00844'
                     LET g_errparam.extend = g_master.xcck005e
                     LET g_errparam.replace[1] =  g_oogc006_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_master.xcck004e = g_master_t.xcck004e
                     NEXT FIELD xcck004e
                     DISPLAY BY NAME g_master.xcck004e                    
                  END IF                                    
               END IF                    
               IF NOT cl_null(g_master.xcck004e) THEN
                  SELECT MAX(oogc006) INTO g_oogc006_2 FROM oogc_t
                   WHERE oogcent = g_enterprise
                     AND oogc001 = g_ooef008
                     AND oogc002 = g_ooef009
                     AND oogc015 = g_master.xcck004e
                  IF cl_null(g_oogc006_2) THEN LET g_oogc006_2 = 12 END IF 
               END IF                    
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004e) THEN
                  IF g_master.xcck004 > g_master.xcck004e THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xcck004e 
                     LET g_errparam.code   = "axc-00825" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xcck004e = g_master_t.xcck004e
                     NEXT FIELD xcck004e
                  END IF 
               END IF
              
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004e) AND
                  NOT cl_null(g_master.xcck005) AND NOT cl_null(g_master.xcck005e)  THEN
                  IF g_master.xcck004*12+g_master.xcck005 > g_master.xcck004e*12+g_master.xcck005e THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xcck004e 
                     LET g_errparam.code   = "axc-00825" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xcck004e = g_master_t.xcck004e
                     NEXT FIELD xcck004e                     
                  END IF 
               END IF                   
               LET g_master_t.xcck004e = g_master.xcck004e
               
            AFTER FIELD xcck005e
               IF NOT cl_null(g_master.xcck005e) THEN
                  IF g_master.xcck005e > g_oogc006_2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00844'
                     LET g_errparam.extend = g_master.xcck005e
                     LET g_errparam.replace[1] =  g_oogc006_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_master.xcck005e = g_master_t.xcck005e
                     NEXT FIELD xcck005e
                     DISPLAY BY NAME g_master.xcck005e                    
                  END IF                                    
               END IF               
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004e) AND
                  NOT cl_null(g_master.xcck005) AND NOT cl_null(g_master.xcck005e)  THEN
                  IF g_master.xcck004*12+g_master.xcck005 > g_master.xcck004e*12+g_master.xcck005e THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xcck005e 
                     LET g_errparam.code   = "axc-00825" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xcck005e = g_master_t.xcck005e
                     NEXT FIELD xcck005e                     
                  END IF 
               END IF        
               LET g_master_t.xcck005e = g_master.xcck005e
               
            AFTER FIELD chk
      
               IF NOT cl_null(g_master.chk) THEN
               END IF
               
         AFTER INPUT
         
      END INPUT
      
       CONSTRUCT g_wc2 ON xcck013,xcck012,xcck020,xcck010,xcck006,xcck007,xcck008,xcck201,xcck202,
                          xccl015,xccl014,xccl020,xccl006,xccl007,xccl008,xccl101,xccl102
            FROM s_detail1[1].b_xcck013,s_detail1[1].b_xcck012,s_detail1[1].b_xcck020,s_detail1[1].b_xcck010,s_detail1[1].b_xcck006,s_detail1[1].b_xcck007,s_detail1[1].b_xcck008,s_detail1[1].b_xcck201,s_detail1[1].b_xcck202,
                 s_detail1[1].b_xccl015,s_detail1[1].b_xccl014,s_detail1[1].b_xccl020,s_detail1[1].b_xccl006,s_detail1[1].b_xccl007,s_detail1[1].b_xccl008,s_detail1[1].b_xccl101,s_detail1[1].b_xccl102
                 
          BEFORE CONSTRUCT
       
          
          ON ACTION controlp INFIELD b_xcck010
             #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
             #應用 a08 樣板自動產生(Version:3)
             #開窗c段
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c' 
             LET g_qryparam.reqry = FALSE         
             CALL q_imaf001()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_xcck010  #顯示到畫面上
             NEXT FIELD b_xcck010                     #返回原欄位
          
       
          ON ACTION controlp INFIELD b_xcck006
             #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
             #應用 a08 樣板自動產生(Version:3)
             #開窗c段
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c' 
             LET g_qryparam.reqry = FALSE         
             CALL q_xcck006()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_xcck006  #顯示到畫面上
             NEXT FIELD b_xcck006                     #返回原欄位
       
          ON ACTION controlp INFIELD b_xccl006
             #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
             #應用 a08 樣板自動產生(Version:3)
             #開窗c段
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c' 
             LET g_qryparam.reqry = FALSE         
             CALL q_xccl006()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO b_xccl006  #顯示到畫面上
             NEXT FIELD b_xccl006                     #返回原欄位
            
      END CONSTRUCT     

      BEFORE DIALOG

         IF cl_null(g_master.chk) THEN
            LET g_master.chk = 'Y' 
         END IF    
         IF cl_null(g_master.xcckcomp) AND cl_null(g_master.xcckld) AND cl_null(g_master.xcck004e)
            AND cl_null(g_master.xcck005e) AND cl_null(g_master.xcck003) 
            AND cl_null(g_master.xcck004) AND cl_null(g_master.xcck005) THEN            
            CALL s_axc_set_site_default() RETURNING g_master.xcckcomp,g_master.xcckld,g_master.xcck004e,g_master.xcck005e,g_master.xcck003
            LET g_master.xcck004 = g_master.xcck004e
            LET g_master.xcck005 = 1               
            LET g_master_t.* = g_master.*
         END IF  
         LET g_master_t.* = g_master.*
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.xcckcomp
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
       
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.xcckld
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.xcck003
         CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
         
         DISPLAY g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcck004e,g_master.xcck005e 
              TO xcckcomp,b_xcckld,b_xcck003,xcck004e,xcck005e
                 
#         LET g_detail[1].xcck013 = ""
#         DISPLAY ARRAY g_detail TO s_detail1.*
#            BEFORE DISPLAY
#               EXIT DISPLAY
#         END DISPLAY   
         
      AFTER DIALOG
      
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG        
   END DIALOG
   
END FUNCTION

 
{</section>}
 
