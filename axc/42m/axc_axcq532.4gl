#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq532.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-02-03 10:56:50), PR版次:0007(2016-10-11 11:53:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: axcq532
#+ Description: 直接原料明細表
#+ Creator....: 02040(2015-09-27 00:10:31)
#+ Modifier...: 02040 -SD/PR- 05384
 
{</section>}
 
{<section id="axcq532.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#151130-00003#19  2015/11/30 By Sarah       增加單身二次過濾功能
#160111-00010#1-D 2016/01/13 By dorislai    1.修正XG印出來排序亂掉問題、2.修正案列印後，單身二的資料跑掉的問題
#160122-00009#1   2016/02/03 By Polly       增加選項是否要製費分攤數
#160222-00016#1   2016/03/14 By Polly       調整成品投入金額、原物料投入數量和投入金額計算
#160520-00004#4   2016/05/23 By shiun       效能優化
#160727-00019#21  2016/08/4  By 08742       系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod  axcq532_x01_temp--> axcq532_tmp01
#160813-00002#1   2016/09/10 By 02040       工單號一張會由多個成本域領料，因此拿掉工單單頭的成本域對單身的成本域的條件
#160802-00020#7   2016/10/07 By shiun       增加帳套權限管控、法人權限管控
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
       xccdcomp LIKE xccd_t.xccdcomp
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       xccd007 LIKE xccd_t.xccd007, 
   xccd007_desc LIKE type_t.chr500, 
   xccd007_desc_1 LIKE type_t.chr500, 
   xccd008 LIKE xccd_t.xccd008, 
   xccd201 LIKE xccd_t.xccd201, 
   xccd202 LIKE xccd_t.xccd202
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       xcce007 LIKE xcce_t.xcce007, 
   xcce007_desc LIKE type_t.chr500, 
   xcce007_desc_1 LIKE type_t.chr500, 
   xcce008 LIKE xcce_t.xcce008, 
   price LIKE type_t.num20_6, 
   xcce201 LIKE xcce_t.xcce201, 
   xcce202 LIKE xcce_t.xcce202
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_master_d RECORD
                   xccdcomp LIKE xccd_t.xccdcomp,
                   xccdcomp_desc LIKE ooefl_t.ooefl003,
                   xccdld  LIKE xccd_t.xccdld,
                   xccdld_desc   LIKE glaal_t.glaal003,                   
                   xccd004 LIKE xccd_t.xccd004,
                   xccd005 LIKE xccd_t.xccd005,
                   xccd004_1 LIKE xccd_t.xccd004,
                   xccd005_1 LIKE xccd_t.xccd005,
                   xccd003 LIKE xccd_t.xccd003,
                   xccd003_desc  LIKE xcatl_t.xcatl003,
                   xccd001 LIKE xccd_t.xccd001,
                   xccd001_desc  LIKE ooail_t.ooail003,
                   xccd002 LIKE xccd_t.xccd002,
                   xccd002_desc  LIKE xcbfl_t.xcbfl002                   
                   END RECORD

DEFINE g_master_d      type_g_master_d
DEFINE g_master_d_t    type_g_master_d  
DEFINE g_browser   DYNAMIC ARRAY OF RECORD
                  xccdcomp LIKE xccd_t.xccdcomp,
                  xccdld  LIKE xccd_t.xccdld,
                  xccd001 LIKE xccd_t.xccd001,
                  xccd003 LIKE xccd_t.xccd003,
                  xccd002 LIKE xccd_t.xccd002
                  END RECORD
DEFINE g_defaule       LIKE type_t.num5
DEFINE g_para_data     LIKE type_t.chr80     #采用成本域否 
DEFINE g_para_data1    LIKE type_t.chr80     #采用特性否  
DEFINE g_xg            LIKE type_t.num10     #xg目前處理的ARRAY CNT 
DEFINE g_wc_filter1    STRING   #151130-00003#19 add
DEFINE g_wc_filter1_t  STRING   #151130-00003#19 add
DEFINE g_q_type        LIKE type_t.chr5    #160122-00009#1 add  
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
 
 
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
 
{<section id="axcq532.main" >}
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
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
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
   DECLARE axcq532_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = " SELECT DISTINCT xccdcomp,xccdld,xccd001,xccd003 ",
               "   FROM xccd_t ",               
               "  WHERE xccdent = ? AND xccdcomp = ? AND xccdld = ? AND xccd001 = ? AND xccd003 = ? "
 
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE axcq532_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq532_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq532 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq532_init()   
 
      #進入選單 Menu (="N")
      CALL axcq532_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq532
      
   END IF 
   
   CLOSE axcq532_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq532.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq532_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   LET g_wc_filter1   = " 1=1"   #151130-00003#19 add
   LET g_wc_filter1_t = " 1=1"   #151130-00003#19 add
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xccd001','8914')
   CALL axcq532_set_comp_visible()
   CALL axcq532_set_comp_no_visible()    
   CALL axcq532_x01_temp()  #150902-00008#21 20151001 s983961--add  
   #end add-point
 
   CALL axcq532_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq532.default_search" >}
PRIVATE FUNCTION axcq532_default_search()
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
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq532_ui_dialog() 
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
    LET g_defaule = TRUE
    IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
       LET g_detail_idx = 1
       LET g_detail_idx2 = 1
       CALL axcq532_browser_fill()
    ELSE
       CALL axcq532_query()
    END IF
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axcq532_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
 
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
 
         CALL axcq532_init()
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
               CALL axcq532_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq532_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axcq532_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_xccd007
            #end add-point
            NEXT FIELD xccdcomp
 
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
            INITIALIZE g_wc_filter1 TO NULL   #151130-00003#19 add
            #end add-point
 
            CALL axcq532_cs()
 
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
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq532_fetch('F')
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
            CALL axcq532_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq532_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq532_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq532_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq532_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq532_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axcq532_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axcq532_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axcq532_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axcq532_b_fill()
 
         
         
         
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
               #150902-00008#21 20151002 s983961--add(s)
               CALL axcq532_insert_temp()        #把畫面上的值存入temp table內
               CALL axcq532_x01("1 = 1","axcq532_tmp01",g_para_data,g_para_data1)      #160727-00019#21 Mod  axcq532_x01_temp--> axcq532_tmp01 
               #150902-00008#21 20151002 s983961--add(e)
               # 160111-00010#1-D----(S)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL axcq532_b_fill2()
               # 160111-00010#1-D----(E)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150902-00008#21 20151002 s983961--add(s)
               CALL axcq532_insert_temp()        #把畫面上的值存入temp table內
               CALL axcq532_x01("1 = 1","axcq532_tmp01",g_para_data,g_para_data1)      #160727-00019#21 Mod  axcq532_x01_temp--> axcq532_tmp01 
               #150902-00008#21 20151002 s983961--add(e)
               # 160111-00010#1-D----(S)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL axcq532_b_fill2()
               # 160111-00010#1-D----(E)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               LET g_defaule = TRUE
               CALL axcq532_query()
               #開啟上下頁按鈕
               CALL cl_navigator_setting( g_current_idx, g_row_count )
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
        #151130-00003#19 -----(S)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq532_filter()
        #151130-00003#19 -----(E)
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
 
{<section id="axcq532.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axcq532_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      RETURN
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      RETURN
      #end add-point
   END IF
 
   PREPARE axcq532_pre FROM g_sql
   DECLARE axcq532_curs SCROLL CURSOR WITH HOLD FOR axcq532_pre
   OPEN axcq532_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE axcq532_precount FROM g_cnt_sql
   EXECUTE axcq532_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axcq532_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcq532.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axcq532_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   LET g_sql = " SELECT DISTINCT xccdcomp,xccdld,xccd001,xccd003,xccd002 ",
               "   FROM xccd_t ",
               "  WHERE ",g_wc2,
               "    AND xccdent = ? AND xccdcomp = ? AND xccdld = ? ",
               "    AND xccd001 = ? AND xccd003 = ? AND xccd002 = ? ",               
               "  ORDER BY xccdcomp,xccdld,xccd001,xccd003 " 
   PREPARE axcq532_fetch_pre FROM g_sql               
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_xccdcomp
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
 
      #add-point:陣列清空 name="fetch.array_clear"
      
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
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq532_fetch_pre USING g_enterprise,g_browser[g_current_idx].xccdcomp,g_browser[g_current_idx].xccdld,g_browser[g_current_idx].xccd001,
                                   g_browser[g_current_idx].xccd003,g_browser[g_current_idx].xccd002
      INTO g_master_d.xccdcomp,g_master_d.xccdld,g_master_d.xccd001,g_master_d.xccd003,g_master_d.xccd002

   FREE axcq532_fetch_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "xccd_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      INITIALIZE g_master.* TO NULL
      RETURN
   END IF   
   
       
   DISPLAY BY NAME g_master_d.xccdcomp,g_master_d.xccdld,g_master_d.xccd001,g_master_d.xccd003,g_master_d.xccd002
   
   CALL axcq532_set_comp_visible()
   CALL axcq532_set_comp_no_visible() 
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axcq532_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532.show" >}
PRIVATE FUNCTION axcq532_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_xccdcomp
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master_d.xccdcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master_d.xccdcomp_desc = '', g_rtn_fields[1] , ''  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master_d.xccdld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master_d.xccdld_desc = '', g_rtn_fields[1] , ''   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master_d.xccd003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master_d.xccd003_desc = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccdcomp
   LET g_ref_fields[2] = g_master_d.xccd002
   CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp = ? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master_d.xccd002_desc = '', g_rtn_fields[1] , ''


   LET g_master_d.xccd001 = '1'
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master_d.xccdld      
      
   CASE g_master_d.xccd001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master_d.xccd001_desc = '', g_rtn_fields[1] , ''               
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master_d.xccd001_desc = '', g_rtn_fields[1] , '' 
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master_d.xccd001_desc = '', g_rtn_fields[1] , ''
   END CASE
   DISPLAY BY NAME g_master_d.xccdcomp_desc,g_master_d.xccdld_desc,g_master_d.xccd001_desc,g_master_d.xccd003_desc 
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axcq532_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq532_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_wc_filter     STRING   #151130-00003#19 add
   DEFINE l_xcce202       LIKE    xcce_t.xcce202    #160122-00009#1 add   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
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
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc2 = g_wc2 ," AND xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc2 = g_wc2 ," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   #LET g_sql = " SELECT  UNIQUE xccd007,xccd008,SUM(xccd201),SUM(xccd202) ",         #160222-00016 mark
   #mod--160520-00004#4 By shiun--(S)
#   LET g_sql = " SELECT  UNIQUE xccd007,xccd008,SUM(xccd201),SUM(xccd202+xccd204) ",  #160222-00016 add
   LET g_sql = " SELECT xccd007,xccd008,SUM(xccd201) AS xccd201,SUM(xccd202+xccd204) AS xccd202 ",  #160222-00016 add
   #mod--160520-00004#4 By shiun--(E)
               "   FROM xccd_t",
               "  WHERE xccdent = ? AND xccdcomp = ? AND xccdld = ? AND xccd001 = ? AND xccd003 = ? AND xccd002 = ? ", 
               "   AND ",g_wc2
  #151130-00003#19 add -----(S)
   IF NOT cl_null(g_wc_filter) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_filter CLIPPED
   END IF   
   IF NOT cl_null(g_wc_filter1) AND g_wc_filter1 <> ' 1=1' THEN
     #LET g_sql = " SELECT  UNIQUE xccd007,xccd008,SUM(xccd201),SUM(xccd202) ",          #160222-00016 mark
      #mod--160520-00004#4 By shiun--(S)
#      LET g_sql = " SELECT  UNIQUE xccd007,xccd008,SUM(xccd201),SUM(xccd202+xccd204) ",  #160222-00016 add      
      LET g_sql = " SELECT xccd007,xccd008,SUM(xccd201) AS xccd201,SUM(xccd202+xccd204) AS xccd202 ",  #160222-00016 add      
      #mod--160520-00004#4 By shiun--(E)
                  "   FROM xccd_t,xcce_t",
                  "  WHERE xccdent = xcceent AND xccdld = xcceld ",
                  "    AND xccd001 = xcce001 AND xccd003 = xcce003 ",
                  "    AND xccd004 = xcce004 AND xccd005 = xcce005 ",
                  "    AND xccd006 = xcce006 ",
                  "    AND xccdent = ? AND xccdcomp = ? AND xccdld = ? AND xccd001 = ? AND xccd003 = ? AND xccd002 = ? ", 
                  "    AND ",g_wc2," AND ",g_wc_filter1 CLIPPED
      IF NOT cl_null(g_wc_filter) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc_filter CLIPPED
      END IF
   END IF
  #151130-00003#19 add -----(E)
   LET g_sql = g_sql,
               " GROUP BY xccd007,xccd008 ",
               " ORDER BY xccd007 "
   LET g_sql = " SELECT UNIQUE xccd007,(SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = xccd007 AND imaal002 = '",g_dlang,"' ) AS imaal003 , ",
               "               (SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = xccd007 AND imaal002 = '",g_dlang,"' ) imaal004 , ",
               "               xccd008,xccd201,xccd202 ",
               "  FROM (",g_sql,") ",
               " ORDER BY xccd007 "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq532_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq532_pb           
   
   OPEN b_fill_curs USING g_enterprise,g_browser[g_current_idx].xccdcomp,g_browser[g_current_idx].xccdld,g_browser[g_current_idx].xccd001,g_browser[g_current_idx].xccd003,g_browser[g_current_idx].xccd002
   
   FOREACH b_fill_curs INTO g_detail[l_ac].xccd007,g_detail[l_ac].xccd007_desc,g_detail[l_ac].xccd007_desc_1,g_detail[l_ac].xccd008,g_detail[l_ac].xccd201,g_detail[l_ac].xccd202
                
      LET g_xg = l_ac   #s983961             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF
     #160122-00009#1--add--(s)
      IF g_q_type = '2' THEN
         #需排除DL+OH+SUB資料
         LET l_xcce202 = 0
         SELECT SUM(xcce202) INTO l_xcce202
           FROM xccd_t,xcce_t
          WHERE xccdent = xcceent AND xccdld = xcceld
           #AND xccd001 = xcce001 AND xccd002 = xcce002   #160813-00002#1 mark
            AND xccd001 = xcce001                         #160813-00002#1 add
            AND xccd003 = xcce003 AND xccd004 = xcce004
            AND xccd005 = xcce005 AND xccd006 = xcce006
            AND xccdent = g_enterprise
            AND xccdld = g_browser[g_current_idx].xccdld
            AND xccd001 = g_browser[g_current_idx].xccd001
            AND xccd003 = g_browser[g_current_idx].xccd003
            AND xccd002 = g_browser[g_current_idx].xccd002
            AND xccd007 = g_detail[l_ac].xccd007
            AND (xcce004 * 12 + xcce005 BETWEEN g_master_d.xccd004 * 12 + g_master_d.xccd005 AND g_master_d.xccd004_1 * 12 + g_master_d.xccd005_1)
            AND xcce007 = 'DL+OH+SUB'
         IF cl_null(l_xcce202) THEN LET l_xcce202 = 0 END IF
         LET g_detail[l_ac].xccd202 = g_detail[l_ac].xccd202 - l_xcce202
      END IF
     #160122-00009#1--add--(e)      
#      CALL axcq532_detail_show("'1'")   #mark--160520-00004#4 By shiun
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
   LET l_ac = 1 
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_tot_cnt = g_detail.getLength()
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq532_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq532_detail_action_trans()
 
   CALL axcq532_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq532_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_wc_filter1    STRING   #151130-00003#19 add
   #add--160111-00010#1 By shiun--(S)
   DEFINE l_xcce201_total LIKE xcce_t.xcce201
   DEFINE l_xcce202_total LIKE xcce_t.xcce202
   #add--160111-00010#1 By shiun--(E)
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc2 = g_wc2 ," AND xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc2 = g_wc2 ," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   #mod--160520-00004#4 By shiun--(S)
   LET l_sql = "SELECT xcce007,xcce008, ",
             # "              CASE SUM(xcce201) WHEN 0 THEN 0 ELSE SUM(xcce202)/SUM(xcce201) END l_price,",          #160222-00016 mark
             # "              SUM(xcce201),SUM(xcce202) ",                                                           #160222-00016 mark
               "              CASE SUM(xcce201+xcce207) WHEN 0 THEN 0 ELSE SUM(xcce202+xcce208)/SUM(xcce201+xcce207) END AS l_price,",   #160222-00016 add
               "              SUM(xcce201+xcce207) AS xcce201,SUM(xcce202+xcce208) AS xcce202 ",                                                            #160222-00016 add
   #mod--160520-00004#4 By shiun--(E)
               "  FROM xccd_t,xcce_t",
               " WHERE xccdent = xcceent AND xccdld = xcceld ",
               "   AND xccd001 = xcce001 AND xccd003 = xcce003 ",
               "   AND xccd004 = xcce004 AND xccd005 = xcce005 ",
               "   AND xccd006 = xcce006 ",
               "   AND xccdent = ? AND xccdld = ? AND xccd001 = ? ",
               "   AND xccd003 = ? AND xccd002 = ? AND xccd007 = ? ",
               "   AND ",g_wc2
  #160122-00009#1 add--(s)
   IF g_q_type = '2' THEN
      LET l_sql = l_sql CLIPPED, "   AND xcce007 <> 'DL+OH+SUB' "
   END IF
  #160122-00009#1 add--(e)   
  #151130-00003#19 add -----(S)
   IF NOT cl_null(g_wc_filter) THEN
      LET l_sql = l_sql CLIPPED," AND ", g_wc_filter CLIPPED
   END IF
   IF NOT cl_null(g_wc_filter1) THEN
      LET l_sql = l_sql CLIPPED, " AND ", g_wc_filter1 CLIPPED
   END IF
  #151130-00003#19 add -----(E)
   LET l_sql = l_sql, cl_sql_add_filter("xcce_t")
   LET l_sql = l_sql," GROUP BY xcce007,xcce008 ORDER BY xcce007 "
   LET l_sql = " SELECT UNIQUE xcce007,(SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = xcce007 AND imaal002 = '",g_dlang,"' ) AS imaal003 , ",
               "               (SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 = xcce007 AND imaal002 = '",g_dlang,"' ) imaal004 , ",
               "               xcce008,l_price,xcce201,xcce202 ",
               "  FROM (",l_sql,") ",
               " ORDER BY xcce007 "
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   
   #add--160111-00010#1 By shiun--(S)
   LET l_xcce201_total = 0
   LET l_xcce202_total = 0
   #add--160111-00010#1 By shiun--(E)
   
   PREPARE axcq532_pb1 FROM l_sql
   DECLARE b_fill_curs1 CURSOR FOR axcq532_pb1
   
   CALL g_detail2.clear() 
   OPEN b_fill_curs1 USING g_enterprise,g_master_d.xccdld,g_master_d.xccd001,g_master_d.xccd003,g_master_d.xccd002,g_detail[l_ac].xccd007

   FOREACH b_fill_curs1 INTO g_detail2[li_ac].xcce007,g_detail2[li_ac].xcce007_desc,g_detail2[li_ac].xcce007_desc_1,g_detail2[li_ac].xcce008,g_detail2[li_ac].price,g_detail2[li_ac].xcce201,g_detail2[li_ac].xcce202
                            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #add--160111-00010#1 By shiun--(S)
      #mark--160520-00004#4 By shiun--(S)
#      CALL s_desc_get_item_desc(g_detail2[li_ac].xcce007)
#        RETURNING g_detail2[li_ac].xcce007_desc,g_detail2[li_ac].xcce007_desc_1     
      #mark--160520-00004#4 By shiun--(E)
#      CALL axcq532_detail_show("'2'")
     
      LET l_xcce201_total = l_xcce201_total + g_detail2[li_ac].xcce201
      LET l_xcce202_total = l_xcce202_total + g_detail2[li_ac].xcce202
      #add--160111-00010#1 By shiun--(E)
      
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
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
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   #add--160111-00010#1 By shiun--(S)
   LET g_detail2[li_ac].xcce008 = cl_getmsg("axc-00205",g_lang)  
   LET g_detail2[li_ac].xcce201 = l_xcce201_total
   LET g_detail2[li_ac].xcce202 = l_xcce202_total
   #add--160111-00010#1 By shiun--(E)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq532_detail_show(ps_page)
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
      CALL s_desc_get_item_desc(g_detail[l_ac].xccd007)
        RETURNING g_detail[l_ac].xccd007_desc,g_detail[l_ac].xccd007_desc_1

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      #mark--160111-00010#1 By shiun--(S)
#      CALL s_desc_get_item_desc(g_detail2[l_ac].xcce007)
#        RETURNING g_detail2[l_ac].xcce007_desc,g_detail2[l_ac].xcce007_desc_1           
      #mark--160111-00010#1 By shiun--(E)
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq532.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axcq532_maintain_prog()
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
 
{<section id="axcq532.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq532_detail_action_trans()
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
 
{<section id="axcq532.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq532_detail_index_setting()
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
 
{<section id="axcq532.mask_functions" >}
 &include "erp/axc/axcq532_mask.4gl"
 
{</section>}
 
{<section id="axcq532.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 查詢
# Memo...........: 
# Usage..........: CALL axcq532_query()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20150924 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq532_query()
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_xccdcomp LIKE xccd_t.xccdcomp
   DEFINE l_xccdcomp_desc LIKE ooefl_t.ooefl003
   DEFINE l_xccdld  LIKE xccd_t.xccdld
   DEFINE l_xccdld_desc   LIKE glaal_t.glaal003
   DEFINE l_xccd001 LIKE xccd_t.xccd001
   DEFINE l_xccd001_desc  LIKE ooail_t.ooail003
   DEFINE l_xccd003 LIKE xccd_t.xccd003
   DEFINE l_xccd003_desc  LIKE xcatl_t.xcatl003 
   DEFINE ls_wc  STRING   
     

   LET INT_FLAG = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1

   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac

   LET g_wc2 = ''

   CLEAR FORM
   CALL g_detail.clear()
   CALL g_detail2.clear()    
   
   INITIALIZE g_master_d TO NULL
     
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_wc ON xccdcomp,xccdld,xccd002,xccd003,xccd001,xccd007
         FROM xccdcomp,xccdld,xccd002,xccd003,xccd001,s_detail1[1].b_xccd007          
         
            BEFORE CONSTRUCT
              LET g_q_type = '2'                     #160122-00009#1 add   
              DISPLAY g_q_type TO q_type             #160122-00009#1 add            
              IF g_defaule AND g_master_d.xccdcomp IS NULL THEN
                 CALL s_axc_set_site_default() RETURNING g_master_d.xccdcomp,g_master_d.xccdld,g_master_d.xccd004,g_master_d.xccd005,g_master_d.xccd003
                 LET g_master_d.xccd004_1 = g_master_d.xccd004
                 LET g_master_d.xccd005_1 = g_master_d.xccd005
                 CALL axcq532_show()
                 LET g_defaule = FALSE
                 DISPLAY BY NAME g_master_d.xccdcomp,g_master_d.xccdld,g_master_d.xccd001,g_master_d.xccd003,g_master_d.xccd004,
                                 g_master_d.xccd004_1,g_master_d.xccd005,g_master_d.xccd005_1                
              END IF   
                
            AFTER FIELD xccdcomp
               LET l_xccdcomp = GET_FLDBUF(xccdcomp)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xccdcomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xccdcomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xccdcomp_desc TO FORMONLY.xccdcomp_desc
   
             AFTER FIELD xccdld
               LET l_xccdld = GET_FLDBUF(xccdld)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xccdld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xccdld_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xccdld_desc TO FORMONLY.xccdld_desc
               
            AFTER FIELD xccd001
               LET l_xccd001 = GET_FLDBUF(xccd001)
               LET l_xccdld  = GET_FLDBUF(xccdld)
               
               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = l_xccdld
                  
               CASE l_xccd001
                  WHEN '1' 
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa001
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET l_xccd001_desc = '', g_rtn_fields[1] , ''
                                   
                  WHEN '2'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa016
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET l_xccd001_desc = '', g_rtn_fields[1] , ''  
                  WHEN '3'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa020
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET l_xccd001_desc = '', g_rtn_fields[1] , ''  
               END CASE
               DISPLAY  l_xccd001_desc TO FORMONLY.xccd001_desc 
              
            AFTER FIELD xccd003  
               LET l_xccd003 = GET_FLDBUF(xccd003)            
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xccd003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xccd003_desc = '', g_rtn_fields[1] , ''
               DISPLAY l_xccd003_desc TO FORMONLY.xccd003_desc 
               
            ON ACTION controlp INFIELD xccdcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #add--160802-00020#7 By shiun--(S)
      	      #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #add--160802-00020#7 By shiun--(E)
               CALL q_ooef001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccdcomp       #顯示到畫面上
               NEXT FIELD xccdcomp                          #返回原欄位
               
            ON ACTION controlp INFIELD xccdld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept               
               #add--160802-00020#7 By shiun--(S)
               #增加帳套權限控制
               IF NOT cl_null(g_wc_cs_ld) THEN
                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
               END IF
               #add--160802-00020#7 By shiun--(E)
               CALL q_authorised_ld()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccdld         #顯示到畫面上
               NEXT FIELD xccdld                            #返回原欄位
                           
            ON ACTION controlp INFIELD xccd003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xcat001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccd003        #顯示到畫面上
               NEXT FIELD xccd003                           #返回原欄位
 
            ON ACTION controlp INFIELD xccd002
               #此段落由子樣板a08產生
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xcbf001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccd002  #顯示到畫面上            
               NEXT FIELD xccd002                     #返回原欄位


            ON ACTION controlp INFIELD b_xccd007   
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imag001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xccd007      #顯示到畫面上
               NEXT FIELD b_xccd007                         #返回原欄位  
    
         AFTER CONSTRUCT 
            CONTINUE DIALOG
   
       END CONSTRUCT
  
       INPUT g_master_d.xccd004,g_master_d.xccd005,g_master_d.xccd004_1,g_master_d.xccd005_1,g_q_type      #160122-00009#1 add query
          FROM xccd004,xccd005,xccd004_1,xccd005_1,q_type                                                  #160122-00009#1 add query
          AFTER FIELD xccd004 
             IF NOT cl_null(g_master_d.xccd004) AND NOT cl_null(g_master_d.xccd004_1) THEN
                 IF g_master_d.xccd004 > g_master_d.xccd004_1 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'acr-00064'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD xccd004
                 END IF
              END IF
          AFTER FIELD xccd005
             IF NOT cl_null(g_master_d.xccd005) AND NOT cl_null(g_master_d.xccd005_1) THEN
                IF g_master_d.xccd004 = g_master_d.xccd004_1 AND g_master_d.xccd005 > g_master_d.xccd005_1 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00067'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccd005
                END IF
             END IF
          AFTER FIELD xccd004_1
             IF NOT cl_null(g_master_d.xccd004) AND NOT cl_null(g_master_d.xccd004_1) THEN
                 IF g_master_d.xccd004 > g_master_d.xccd004_1 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'acr-00064'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD xccd004_1
                 END IF
              END IF
          AFTER FIELD xccd005_1   
             IF NOT cl_null(g_master_d.xccd005) AND NOT cl_null(g_master_d.xccd005_1) THEN
                IF g_master_d.xccd004 = g_master_d.xccd004_1 AND g_master_d.xccd005 > g_master_d.xccd005_1 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00067'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccd005_1
                END IF
             END IF            
           
       END INPUT    
            

      BEFORE DIALOG
         CALL cl_qbe_init()
        #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
         LET g_detail[1].xccd007 = ""         
         DISPLAY ARRAY g_detail TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY

      ON ACTION accept
         IF cl_null(g_master_d.xccd004) THEN
            NEXT FIELD xccd004
         END IF
         IF cl_null(g_master_d.xccd004_1) THEN
            NEXT FIELD xccd004_1
         END IF
         IF cl_null(g_master_d.xccd005) THEN
            NEXT FIELD xccd005
         END IF
         IF cl_null(g_master_d.xccd005_1) THEN
            NEXT FIELD xccd005_1
         END IF       
         CALL axcq532_browser_fill()   
         EXIT DIALOG

       ON ACTION close      #在dialog button (放棄)
          LET INT_FLAG = 1
          EXIT DIALOG
      
       ON ACTION exit       #toolbar 離開 
          LET INT_FLAG = 1
          EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
       &include "common_action.4gl"
         CONTINUE DIALOG   
   
   END DIALOG 
 
   
END FUNCTION
################################################################################
# Descriptions...: 單頭資料顯示
# Memo...........:
# Usage..........: CALL axcq532_browser_fill()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150925 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq532_browser_fill()

   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING  

   #清除畫面
   CLEAR FORM            
 
   CALL g_browser.clear()
   CALL g_detail.clear()
   CALL g_detail2.clear() 
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF   
   LET g_wc = cl_replace_str(g_wc,'b_xccd007','xccd007')
   LET g_wc = g_wc," AND (xccd004*12+xccd005 BETWEEN ",g_master_d.xccd004,"*12+",g_master_d.xccd005," AND ",g_master_d.xccd004_1,"*12+",g_master_d.xccd005_1,")"
   
   LET g_wc2 = g_wc.trim()    
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc2 = g_wc2 ," AND xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc2 = g_wc2 ," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   LET l_sub_sql = " SELECT DISTINCT xccdcomp,xccdld,xccd001,xccd003,xccd002 ",
                   "   FROM xccd_t ",
                   "  WHERE ",g_wc2,
                   "  ORDER BY xccdcomp,xccdld,xccd001,xccd003 "                   
 
   LET g_sql = l_sub_sql
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].xccdcomp,g_browser[g_cnt].xccdld,g_browser[g_cnt].xccd001,g_browser[g_cnt].xccd003,g_browser[g_cnt].xccd002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF  
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF      
   END FOREACH
 
   CALL g_browser.deleteElement(g_browser.getlength())

   LET g_row_count = g_cnt - 1  
   IF g_row_count = 0 THEN

      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()      
   ELSE      
      CALL axcq532_fetch('F')      
   END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 控制欄位顯示
# Memo...........:
# Usage..........: CALL axcq532_set_comp_visible()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150930 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq532_set_comp_visible()

CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)
CALL cl_set_comp_visible('b_xccd008',TRUE)

END FUNCTION
################################################################################
# Descriptions...: 控制欄位顯示
# Memo...........:
# Usage..........: CALL axcq532_set_comp_no_visible()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150930 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq532_set_comp_no_visible()

   IF cl_null(g_master_d.xccdcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否
   ELSE
      CALL cl_get_para(g_enterprise,g_master_d.xccdcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_master_d.xccdcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否
   END IF

   IF g_para_data = 'N' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)
   END IF
   IF g_para_data1 = 'N' THEN
      CALL cl_set_comp_visible('b_xccd008',FALSE)
   END IF   

END FUNCTION

################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: #150902-00008#21 
# Date & Author..: 2015/10/01 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq532_x01_temp()
   DROP TABLE axcq532_tmp01;           #160727-00019#21 Mod  axcq532_x01_temp--> axcq532_tmp01  
 CREATE TEMP TABLE axcq532_tmp01(      #160727-00019#21 Mod  axcq532_x01_temp--> axcq532_tmp01 
     xccdent          SMALLINT,
     xccdcomp         VARCHAR(10),
     xccdld           VARCHAR(5),
     l_xccdcomp_desc  VARCHAR(500),
     l_xccdld_desc    VARCHAR(500),
     xccd004          SMALLINT,
     xccd005          SMALLINT,
     l_xccd004        SMALLINT,
     l_xccd005        SMALLINT,
     l_xccd002_desc   VARCHAR(500),
     l_xccd003_desc   VARCHAR(500),
     l_xccd001_desc   VARCHAR(500),
     xccd007          VARCHAR(40),
     l_xccd007_desc   VARCHAR(500),
     l_xccd007_desc1  VARCHAR(500),
     xccd008          VARCHAR(256),
     xccd201          DECIMAL(20,6),
     xccd202          DECIMAL(20,6),
     xcce007          VARCHAR(40),
     l_xcce007_desc   VARCHAR(500),
     l_xcce007_desc1  VARCHAR(500),
     xcce008          VARCHAR(256),
     l_price          DECIMAL(20,6),
     xcce201          DECIMAL(20,6),
     xcce202          DECIMAL(20,6),
     xccd_key         VARCHAR(300)
                   )
END FUNCTION

################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #150902-00008#21
#
# Date & Author..: 2015/102 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq532_insert_temp()

DEFINE l_i LIKE type_t.num10
DEFINE l_j LIKE type_t.num10
DEFINE l_k LIKE type_t.num10   #160111-00010#1 add
DEFINE l_x01_tmp RECORD
    xccdent         LIKE xccd_t.xccdent,
    xccdcomp        LIKE xccd_t.xccdcomp,
    xccdld          LIKE xccd_t.xccdld,
    xccdcomp_desc   LIKE type_t.chr500,
    xccdld_desc     LIKE type_t.chr500,
    xccd004         LIKE xccd_t.xccd004,
    xccd005         LIKE xccd_t.xccd005,
    xccd004_1       LIKE xccd_t.xccd004,
    xccd005_1       LIKE xccd_t.xccd005,
    xccd002_desc    LIKE type_t.chr500,
    xccd003_desc    LIKE type_t.chr500,
    xccd001_desc    LIKE type_t.chr500,
    xccd007         LIKE xccd_t.xccd007,
    xccd007_desc    LIKE type_t.chr500,
    xccd007_desc_1  LIKE type_t.chr500,
    xccd008         LIKE xccd_t.xccd008,
    xccd201         LIKE xccd_t.xccd201,
    xccd202         LIKE xccd_t.xccd202,
    xcce007         LIKE xcce_t.xcce007,
    xcce007_desc    LIKE type_t.chr500,
    xcce007_desc_1  LIKE type_t.chr500,
    xcce008         LIKE xcce_t.xcce008,
    price           LIKE type_t.num20_6,
    xcce201         LIKE xcce_t.xcce201,
    xcce202         LIKE xcce_t.xcce202,
#    xccd_key        LIKE type_t.chr300 # 160111-00010#1-D-mod---(S)
    xccd_key        LIKE type_t.num20  #  160111-00010#1-D-mod---(E)
                    END RECORD                    
DELETE FROM axcq532_tmp01;          #160727-00019#21 Mod  axcq532_x01_temp--> axcq532_tmp01 
LET l_k = 0                               #160111-00010#1 add
FOR l_i = 1 TO g_detail.getLength()
 LET l_ac = l_i
 CALL axcq532_b_fill2()
  FOR l_j = 1 TO g_detail2.getLength()
     INITIALIZE l_x01_tmp.* TO NULL
     LET l_k = l_k + 1                    #160111-00010#1 add
     IF l_j = 1 THEN 
     LET l_x01_tmp.xccdent = g_enterprise
     LET l_x01_tmp.xccdcomp = g_master_d.xccdcomp
     LET l_x01_tmp.xccdld = g_master_d.xccdld
     LET l_x01_tmp.xccdcomp_desc = g_master_d.xccdcomp,"(",g_master_d.xccdcomp_desc,")"
     LET l_x01_tmp.xccdld_desc = g_master_d.xccdld,"(",g_master_d.xccdld_desc,")"
     LET l_x01_tmp.xccd004 = g_master_d.xccd004
     LET l_x01_tmp.xccd005 = g_master_d.xccd005
     LET l_x01_tmp.xccd004_1 = g_master_d.xccd004_1
     LET l_x01_tmp.xccd005_1 = g_master_d.xccd005_1
     LET l_x01_tmp.xccd002_desc = g_master_d.xccd002,"(",g_master_d.xccd002_desc,")"
     LET l_x01_tmp.xccd003_desc = g_master_d.xccd003,"(",g_master_d.xccd003_desc,")"
     LET l_x01_tmp.xccd001_desc = g_master_d.xccd001,"(",g_master_d.xccd001_desc,")"
     LET l_x01_tmp.xccd007 = g_detail[l_i].xccd007
     LET l_x01_tmp.xccd007_desc = g_detail[l_i].xccd007_desc
     LET l_x01_tmp.xccd007_desc_1 = g_detail[l_i].xccd007_desc_1
     LET l_x01_tmp.xccd008 = g_detail[l_i].xccd008
     LET l_x01_tmp.xccd201 = g_detail[l_i].xccd201
     LET l_x01_tmp.xccd202 = g_detail[l_i].xccd202
     LET l_x01_tmp.xcce007 = g_detail2[l_j].xcce007
     LET l_x01_tmp.xcce007_desc = g_detail2[l_j].xcce007_desc
     LET l_x01_tmp.xcce007_desc_1 = g_detail2[l_j].xcce007_desc_1
     LET l_x01_tmp.xcce008 = g_detail2[l_j].xcce008
     LET l_x01_tmp.price = g_detail2[l_j].price
     LET l_x01_tmp.xcce201 = g_detail2[l_j].xcce201
     LET l_x01_tmp.xcce202 = g_detail2[l_j].xcce202
    #LET l_x01_tmp.xccd_key = g_detail[l_i].xccd007   #160111-00010#1 mark
     LET l_x01_tmp.xccd_key = l_k                     #160111-00010#1 add
     ELSE
     LET l_x01_tmp.xccdent = g_enterprise
     LET l_x01_tmp.xccdcomp = g_master_d.xccdcomp
     LET l_x01_tmp.xccdld = g_master_d.xccdld
     LET l_x01_tmp.xccdcomp_desc = g_master_d.xccdcomp,"(",g_master_d.xccdcomp_desc,")"
     LET l_x01_tmp.xccdld_desc = g_master_d.xccdld,"(",g_master_d.xccdld_desc,")"
     LET l_x01_tmp.xccd004 = g_master_d.xccd004
     LET l_x01_tmp.xccd005 = g_master_d.xccd005
     LET l_x01_tmp.xccd004_1 = g_master_d.xccd004_1
     LET l_x01_tmp.xccd005_1 = g_master_d.xccd005_1
     LET l_x01_tmp.xccd002_desc = g_master_d.xccd002,"(",g_master_d.xccd002_desc,")"
     LET l_x01_tmp.xccd003_desc = g_master_d.xccd003,"(",g_master_d.xccd003_desc,")"
     LET l_x01_tmp.xccd001_desc = g_master_d.xccd001,"(",g_master_d.xccd001_desc,")"
     LET l_x01_tmp.xccd007 = ' '
     LET l_x01_tmp.xccd007_desc = ' '
     LET l_x01_tmp.xccd007_desc_1 = ' '
     LET l_x01_tmp.xccd008 = ' '
     LET l_x01_tmp.xccd201 = ''
     LET l_x01_tmp.xccd202 = ''
     LET l_x01_tmp.xcce007 = g_detail2[l_j].xcce007
     LET l_x01_tmp.xcce007_desc = g_detail2[l_j].xcce007_desc
     LET l_x01_tmp.xcce007_desc_1 = g_detail2[l_j].xcce007_desc_1
     LET l_x01_tmp.xcce008 = g_detail2[l_j].xcce008
     LET l_x01_tmp.price = g_detail2[l_j].price
     LET l_x01_tmp.xcce201 = g_detail2[l_j].xcce201
     LET l_x01_tmp.xcce202 = g_detail2[l_j].xcce202
    #LET l_x01_tmp.xccd_key = g_detail[l_i].xccd007   #160111-00010#1 mark
     LET l_x01_tmp.xccd_key = l_k                     #160111-00010#1 add     
     END IF
     
     INSERT INTO axcq532_tmp01 VALUES(l_x01_tmp.*)         #160727-00019#21 Mod  axcq532_x01_temp--> axcq532_tmp01 
     
     
  END FOR
END FOR    

END FUNCTION

################################################################################
# Descriptions...: filter過濾功能
# Memo...........:
# Usage..........: CALL axcq532_filter()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/11/30 By Sarah
# Modify.........: 151130-00003#19 add
################################################################################
PRIVATE FUNCTION axcq532_filter()

   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   #備份
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_filter1_t = g_wc_filter1
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   LET g_wc = cl_replace_str(g_wc, g_wc_filter1, '')
 
   LET g_wc_filter       = ''
   LET g_wc_filter1      = ''
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xccd007,xccd008,xccd201,xccd202
           FROM s_detail1[1].b_xccd007,s_detail1[1].b_xccd008,s_detail1[1].b_xccd201,s_detail1[1].b_xccd202
 
         BEFORE CONSTRUCT
            DISPLAY axcq532_filter_parser('xccd007') TO s_detail1[1].b_xccd007
            DISPLAY axcq532_filter_parser('xccd008') TO s_detail1[1].b_xccd008
            DISPLAY axcq532_filter_parser('xccd201') TO s_detail1[1].b_xccd201
            DISPLAY axcq532_filter_parser('xccd202') TO s_detail1[1].b_xccd202
 
         #--单身开窗
         ON ACTION controlp INFIELD b_xccd007   
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xccd007      #顯示到畫面上
            NEXT FIELD b_xccd007                         #返回原欄位
            
      END CONSTRUCT

      CONSTRUCT g_wc_filter1 ON xcce007,xcce008,price,xcce201,xcce202
           FROM s_detail2[1].b_xcce007,s_detail2[1].b_xcce008,s_detail2[1].b_price,s_detail2[1].b_xcce201,s_detail2[1].b_xcce202
 
         BEFORE CONSTRUCT
            DISPLAY axcq532_filter_parser('xcce007') TO s_detail2[1].b_xcce007
            DISPLAY axcq532_filter_parser('xcce008') TO s_detail2[1].b_xcce008
            DISPLAY axcq532_filter_parser('price') TO s_detail2[1].b_price
            DISPLAY axcq532_filter_parser('xcce201') TO s_detail2[1].b_xcce201
            DISPLAY axcq532_filter_parser('xcce202') TO s_detail2[1].b_xcce202
 
         #--单身开窗
         ON ACTION controlp INFIELD b_xcce007   
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcce007      #顯示到畫面上
            NEXT FIELD b_xcce007                         #返回原欄位
            
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter1 = g_wc_filter1, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc_filter1 = g_wc_filter1_t
      LET g_wc = g_wc_t
   END IF

   CALL axcq532_filter_show('xccd007','b_xccd007')
   CALL axcq532_filter_show('xccd008','b_xccd008')
   CALL axcq532_filter_show('xccd201','b_xccd201')
   CALL axcq532_filter_show('xccd202','b_xccd202')
   
   CALL axcq532_filter_show('xcce007','b_xcce007')
   CALL axcq532_filter_show('xcce008','b_xcce008')
   CALL axcq532_filter_show('price','b_price')
   CALL axcq532_filter_show('xcce201','b_xcce201')
   CALL axcq532_filter_show('xcce202','b_xcce202')

   CALL axcq532_b_fill()
   CALL axcq532_show()
   
END FUNCTION

################################################################################
# Descriptions...: filter欄位解析
# Memo...........:
# Usage..........: CALL axcq532_filter_parser(ps_field)
#                  RETURNING ls_var
# Input parameter: ps_field   欄位代號
# Return code....: ls_var     欄位查詢條件
# Date & Author..: 15/11/30 By Sarah
# Modify.........: 151130-00003#19 add
################################################################################
PRIVATE FUNCTION axcq532_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
 
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

################################################################################
# Descriptions...: Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: CALL axcq532_filter_show(ps_field,ps_object)
# Input parameter: ps_field   欄位代號
#                : ps_object  物件代號
# Return code....: 無
# Date & Author..: 15/11/30 By Sarah
# Modify.........: 151130-00003#19 add
################################################################################
PRIVATE FUNCTION axcq532_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   
   LET ls_name = ps_object

   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = axcq532_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION

 
{</section>}
 
