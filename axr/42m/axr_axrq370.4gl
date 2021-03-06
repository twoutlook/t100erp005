#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq370.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:11(2016-05-31 16:28:02), PR版次:0011(2017-01-05 14:42:11)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: axrq370
#+ Description: 出貨單銷退開票資料查詢
#+ Creator....: 07166(2015-11-26 13:02:12)
#+ Modifier...: 01531 -SD/PR- 02114
 
{</section>}
 
{<section id="axrq370.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#7   2016/02/24  By yangtt   增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite
#151123-00013#4   2016/05/04  By 01727    修改b_fill的SQL
#160506-00002#5   2016/05/31  By 01531    规格调整
#160727-00019#6   2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
#161026-00013#1   2016/10/26  By 06821    組織類型與職能開窗調整
#161021-00050#5   2016/10/26  By 08729    處理組織開窗
#161111-00049#9   2016/11/28  By 01727    控制组权限修改
#161130-00038#1   2016/12/02  By 01727    发票号码,发票代码栏位取值反了
#161208-00053#1   2016/12/09  By 02114    数量应该是抓计算数量xmdl022不是抓xmdl018
#161207-00036#1   2016/12/12  By 02114    銷退單資料無法呈現原因在於 xmdk000 條件 2,3 與 6 應拆分判斷
#161214-00009#1   2016/12/14  By 02114    1.銷退單要加上狀態碼為S的條件
#                                         2.要限定出貨數量不為0
#                                         3.增加出貨單單別控制組的條件
#                                         4.發票號碼，發票代碼全部取aist310單頭的
#170104-00059#1   2017/01/05  By 02114    发票号码,发票代码字段取错
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
PRIVATE TYPE type_g_xmdk_d RECORD
       
       sel LIKE type_t.chr1, 
   xmdksite LIKE xmdk_t.xmdksite, 
   xmdksite_desc LIKE type_t.chr500, 
   xmdk000 LIKE xmdk_t.xmdk000, 
   xmdk008 LIKE xmdk_t.xmdk008, 
   xmdk008_desc LIKE type_t.chr500, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   xmdldocno LIKE xmdl_t.xmdldocno, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdl001 LIKE xmdl_t.xmdl001, 
   xmdl002 LIKE xmdl_t.xmdl002, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE type_t.chr500, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl008_desc LIKE type_t.chr500, 
   xmdl008_desc_1 LIKE type_t.chr500, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   xmdl018 LIKE xmdl_t.xmdl018, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdl047 LIKE xmdl_t.xmdl047, 
   xmdl018_desc LIKE type_t.num20_6, 
   xmdl048 LIKE xmdl_t.xmdl048, 
   xmdl049 LIKE xmdl_t.xmdl049, 
   isafdocno LIKE type_t.chr20, 
   xmdl038 LIKE xmdl_t.xmdl038
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql_ctrl       STRING                #151231-00010#7
DEFINE g_sql_ctrl2      STRING                #161111-00049#9 Add 料件控制组
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmdk_d            DYNAMIC ARRAY OF type_g_xmdk_d
DEFINE g_xmdk_d_t          type_g_xmdk_d
 
 
 
 
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
DEFINE g_sql1              STRING
DEFINE g_sql2              STRING
DEFINE g_sql3              STRING
DEFINE g_sql4              STRING #160506-00002#5
DEFINE g_b_01 LIKE ooef_t.ooef001
DEFINE g_b_01_desc LIKE ooefl_t.ooefl003   #151123-00013#4 Add
DEFINE g_b_02 LIKE xmdk_t.xmdk000
DEFINE g_b_03 LIKE xmdk_t.xmdk000
#161214-00009#1--add--str--lujh
DEFINE g_sql_ctr1       STRING                
DEFINE g_sql_ctr2       STRING        
#161214-00009#1--add--end--lujh
#end add-point
 
{</section>}
 
{<section id="axrq370.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#7(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#9 Mark
  #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl

   LET g_sql_ctrl2 = NULL
   CALL s_control_get_item_sql('2',l_ooef017,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
  #161111-00049#9 Add  ---(E)---
   #151231-00010#7(E)
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
   DECLARE axrq370_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq370_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq370_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq370 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq370_init()   
 
      #進入選單 Menu (="N")
      CALL axrq370_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq370
      
   END IF 
   
   CLOSE axrq370_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq370.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq370_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
  #LET g_b_01 = g_site  #151123-00013#4 Mark
  #151123-00013#4 Add  ---(S)---
   SELECT ooef017 INTO g_b_01 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_desc_get_department_desc(g_b_01) RETURNING g_b_01_desc
   DISPLAY g_b_01_desc TO b_01_desc
  #151123-00013#4 Add  ---(E)---
   LET g_b_02 = '1'
   LET g_b_03 = '1'
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_xmdk000','2077') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL axrq370_tmp01()     #160727-00019#6  2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
   #end add-point
 
   CALL axrq370_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrq370.default_search" >}
PRIVATE FUNCTION axrq370_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdkdocno = '", g_argv[01], "' AND "
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
 
{<section id="axrq370.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq370_ui_dialog() 
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
   CALL axrq370_ui_dialog_1()
   RETURN
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
 
   
   CALL axrq370_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmdk_d.clear()
 
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
 
         CALL axrq370_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
 
         #end add-point
     
         DISPLAY ARRAY g_xmdk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq370_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq370_b_fill2()
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
            CALL axrq370_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
            NEXT FIELD lbl_b_01
 
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
             LET g_wc2 = " 1=1"
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axrq370_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xmdk_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axrq370_b_fill()
 
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
            CALL axrq370_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq370_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq370_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq370_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq370_filter()
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
 
{<section id="axrq370.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq370_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xmdl047 LIKE xmdl_t.xmdl047
   DEFINE l_ld_str  STRING #160811-00009#2
   #161214-00009#1--add--str--lujh
   DEFINE l_ooef004        LIKE ooef_t.ooef004
   DEFINE l_site_len       LIKE type_t.num5      
   DEFINE l_slip_len       LIKE type_t.num5      
   DEFINE l_i              LIKE type_t.num5      
   DEFINE l_j              LIKE type_t.num5     
   #161214-00009#1--add--end--lujh
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
 
   CALL g_xmdk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdksite','xmdksite')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdk000','xmdk000')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdk008','xmdk008')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdk001','xmdk001')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdldocno','xmdldocno')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdlseq','xmdlseq')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdl001','xmdl001')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdl003','xmdl003')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdl004','xmdl004')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdl008','xmdl008')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_xmdk016','xmdk016')    #160506-00002#5  
   DELETE FROM axrq370_tmp01    #160727-00019#6  2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
   
   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc2 = g_wc2," AND xmdk008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
   
   #161111-00049#9 Add  ---(S)---
   IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
      LET g_wc = g_wc," AND ",g_sql_ctrl2
   END IF
   #161111-00049#9 Add  ---(E)---

   #160811-00009#2  Add  ---(S)---
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","xmdksite")
   LET g_wc2 = g_wc2," AND ",l_ld_str
   #160811-00009#2  Add  ---(E)---   
   
   #161214-00009#1--add--str--lujh
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_b_01
   #出货单限定单别
   CALL s_control_get_docno_sql_q(g_user,g_dept,l_ooef004) RETURNING g_sub_success,g_sql_ctr1,g_sql_ctr2
   
   #SITE 长度
   LET l_site_len = cl_get_para(g_enterprise,g_b_01,'E-COM-0003')
   
   #单别长度
   LET l_slip_len = cl_get_para(g_enterprise,g_b_01,'E-COM-0001')
   
   #第一个分隔符
   IF cl_get_para(g_enterprise,g_site,'E-COM-0008') = '1' THEN    #据点+单别
      LET l_i = l_site_len + 2
      LET l_j = l_slip_len
   ELSE
      LET l_i = 1
      LET l_j = l_slip_len
   END IF 
   #161214-00009#1--add--end--lujh
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,'','','','','','','', 
       '','',xmdk016,'','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xmdk_t.xmdkdocno) AS RANK FROM xmdk_t", 
 
 
 
                     "",
                     " WHERE xmdkent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmdk_t"),
                     " ORDER BY xmdk_t.xmdkdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #151123-00013#4 Mark ---(S)---
   #LET ls_sql_rank = " SELECT  UNIQUE '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
   #                  "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
   #                  "   FROM xmdk_t,xmdl_t ",
   #                  "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
   #                  "    AND xmdkent= ? AND 1=1 AND ", ls_wc
   #151123-00013#4 Mark ---(E)---

#151123-00013#4 Add  ---(S)---
#160506-00002#5 mod ---s---  
#  LET g_sql1 = " SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
#              "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
#              "   FROM xmdk_t,xmdl_t ",
#              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
#              "    AND xmdk000 in ('4','5' ) ", #4.出貨簽收單 5.出貨簽退單
#              "    AND xmdkstus = 'Y' AND xmdk002  ='3' ",
#              "    AND xmdkent = ?",
#             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
#              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
#              "    AND ",g_wc2
#            
#  LET g_sql2 = " SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
#              "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
#              "   FROM xmdk_t,xmdl_t ",
#              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
#              "    AND xmdk000 in ('1','2','3') ",       # 1.出貨單2.無訂單出貨 3.直送訂單出貨 
#              "    AND xmdkstus = 'S' AND xmdk002  ='1' ",
#              "    AND xmdkent = ",g_enterprise,
#             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
#              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
#              "    AND ",g_wc2
#              
#  LET g_sql3 = " SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
#              "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
#              "   FROM xmdk_t,xmdl_t ",
#              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
#              "    AND xmdk000 = '6' ",       # 6.銷退單
#              "    AND xmdkstus = 'S' AND xmdk082  <> '5' ",
#              "    AND xmdkent = ",g_enterprise,
#             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
#              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
#              "    AND ",g_wc2

  LET g_sql = " SELECT xmdl048,xmdl049 ",   #發票代碼 #發票號碼 
              "   FROM xmdl_t ",
              "  WHERE xmdldocno = ? ",
              "    AND xmdlseq = ? ",
              "    AND xmdlent = '",g_enterprise,"'"
  PREPARE axrq370_pre_xmdl FROM g_sql  

  #LET g_sql = " SELECT isaf012,isaf011,isafdocno",   #發票代碼 #發票號碼 #對帳單號         #161130-00038#1  Mod isaf011,isaf012 --> isaf012,isaf011  #170104-00059#1 mark lujh
  LET g_sql = " SELECT isaf010,isaf011,isafdocno",    #發票代碼 #發票號碼 #對帳單號    #170104-00059#1 add lujh
              "  FROM isaf_t,isag_t             ",
              " WHERE isagent  = isafent        ",
              "   AND isagdocno = isafdocno     ",
              "   AND isag002 = ?               ",    
              "   AND isag003 = ?               ",   
              "   AND isafstus ='Y'             ",
              "   AND isagent = '",g_enterprise,"'"
  PREPARE axrq370_pre_isaf FROM g_sql               
             
  LET g_sql1 = " SELECT '',xmdksite,",
              "         (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=xmdksite AND ooefl002='",g_dlang,"'),",
              "         xmdk000,xmdk008,",
              "         (SELECT pmaal003 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xmdk008 AND pmaal002='",g_dlang,"'),",
              "         xmdk001,xmdldocno, ",
              "         xmdlseq,xmdl001 aa,xmdl002,xmdl003,xmdl004,xmdl008,",
              "         (SELECT imaal003 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
              "         (SELECT imaal004 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'), ",
              #"         xmdk016,xmdl018,xmdl027,xmdl028,xmdl047,xmdl018-xmdl047,xmdl048,xmdl049,'',xmdl038 ",    #161208-00053#1 mark lujh
              "         xmdk016,xmdl022,xmdl027,xmdl028,xmdl047,xmdl022-xmdl047,xmdl048,xmdl049,'',xmdl038 ",     #161208-00053#1 add lujh
              "   FROM xmdk_t,xmdl_t ",
              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
              "    AND xmdk000 in ('5' ) ", # 5.出貨簽退單
              "    AND xmdkstus = 'Y' AND xmdk002  ='3' ",
              "    AND xmdkent = ?",
              #161214-00009#1--add--str--lujh
              "    AND xmdl022 <> 0 ",   
              "    AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr1," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2,")" ,
              #161214-00009#1--add--end--lujh
             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
              "    AND ",g_wc2
              
  #xmdk000='1' or '4'时，xmdl001抓xmdkdocno值 
  LET g_sql2 = " SELECT '',xmdksite,",
              "         (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=xmdksite AND ooefl002='",g_dlang,"'),",
              "         xmdk000,xmdk008,",
              "         (SELECT pmaal003 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xmdk008 AND pmaal002='",g_dlang,"'),",
              "         xmdk001,xmdldocno, ",
              "         xmdlseq,xmdkdocno aa,xmdl002,xmdl003,xmdl004,xmdl008,",
              "         (SELECT imaal003 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
              "         (SELECT imaal004 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'), ",
              #"         xmdk016,xmdl018,xmdl027,xmdl028,xmdl047,xmdl018-xmdl047,xmdl048,xmdl049,'',xmdl038 ",   #161208-00053#1 mark lujh
              "         xmdk016,xmdl022,xmdl027,xmdl028,xmdl047,xmdl022-xmdl047,xmdl048,xmdl049,'',xmdl038 ",    #161208-00053#1 add lujh
              "   FROM xmdk_t,xmdl_t ",
              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
              "    AND xmdk000 in ('4') ", #4.出貨簽收單  
              "    AND xmdkstus = 'Y' AND xmdk002  ='3' ",
              "    AND xmdkent = ",g_enterprise,
              #161214-00009#1--add--str--lujh
              "    AND xmdl022 <> 0 ",   
              "    AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr1," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2,")" ,
              #161214-00009#1--add--end--lujh
             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
              "    AND ",g_wc2
  
  #xmdk000='1' or '4'时，xmdl001抓xmdkdocno值  
  LET g_sql3 = " SELECT '',xmdksite,",
              "         (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=xmdksite AND ooefl002='",g_dlang,"'),",
              "         xmdk000,xmdk008,",
              "         (SELECT pmaal003 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xmdk008 AND pmaal002='",g_dlang,"'),",
              "         xmdk001,xmdldocno, ",
              "         xmdlseq,xmdkdocno aa,xmdl002,xmdl003,xmdl004,xmdl008,",
              "         (SELECT imaal003 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
              "         (SELECT imaal004 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'), ",
              #"         xmdk016,xmdl018,xmdl027,xmdl028,xmdl047,xmdl018-xmdl047,xmdl048,xmdl049,'',xmdl038 ",   #161208-00053#1 mark lujh
              "         xmdk016,xmdl022,xmdl027,xmdl028,xmdl047,xmdl022-xmdl047,xmdl048,xmdl049,'',xmdl038 ",    #161208-00053#1 add lujh
              "   FROM xmdk_t,xmdl_t ",
              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
              "    AND xmdk000 in ('1') ",       # 1.出貨單   
              "    AND xmdkstus = 'S' AND xmdk002  ='1' ",
              "    AND xmdkent = ",g_enterprise,
              #161214-00009#1--add--str--lujh
              "    AND xmdl022 <> 0 ",   
              "    AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr1," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2,")" ,
              #161214-00009#1--add--end--lujh
             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
              "    AND ",g_wc2
              
  LET g_sql4 = " SELECT '',xmdksite,",
              "         (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=xmdksite AND ooefl002='",g_dlang,"'),",
              "         xmdk000,xmdk008,",
              "         (SELECT pmaal003 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xmdk008 AND pmaal002='",g_dlang,"'),",
              "         xmdk001,xmdldocno, ",
              "         xmdlseq,xmdl001 aa,xmdl002,xmdl003,xmdl004,xmdl008,",
              "         (SELECT imaal003 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'),",
              "         (SELECT imaal004 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xmdl008 AND imaal002='",g_dlang,"'), ",
              #"         xmdk016,xmdl018,xmdl027,xmdl028,xmdl047,xmdl018-xmdl047,xmdl048,xmdl049,'',xmdl038 ",   #161208-00053#1 mark lujh
              "         xmdk016,xmdl022,xmdl027,xmdl028,xmdl047,xmdl022-xmdl047,xmdl048,xmdl049,'',xmdl038 ",    #161208-00053#1 add lujh
              "   FROM xmdk_t,xmdl_t ",
              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
              #161207-00036#1--mark--str--lujh
              #"    AND xmdk000 in ('2','3','6') ",        #2.無訂單出貨 3.直送訂單出貨 6.销退单  
              #"    AND xmdkstus = 'S' AND xmdk002  ='1' ",
              #161207-00036#1--mark--end--lujh
              "    AND ((xmdk000 IN ('2', '3') AND xmdkstus = 'S' AND xmdk002 = '1') OR (xmdk000 = '6' AND xmdk082 <> '5' AND xmdkstus = 'S'))",  #161207-00036#1 add lujh   #161214-00009#1 add AND xmdkstus = 'S' lujh
              "    AND xmdkent = ",g_enterprise,
              #161214-00009#1--add--str--lujh
              "    AND xmdl022 <> 0 ",   
              "    AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr1," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2,")" ,
              #161214-00009#1--add--end--lujh
             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
              "    AND ",g_wc2              
#160506-00002#5 mod ---e---                
   CASE 
        WHEN g_b_02 = '1'  LET g_sql1 = g_sql1 , " AND xmdl038 > 0"  #已立帳
                           LET g_sql2 = g_sql2 , " AND xmdl038 > 0"
                           LET g_sql3 = g_sql3 , " AND xmdl038 > 0"
                           LET g_sql4 = g_sql4 , " AND xmdl038 > 0"  #160506-00002#5
        WHEN g_b_02 = '2'  LET g_sql1 = g_sql1 , " AND xmdl038 = 0"  #未立帳
                           LET g_sql2 = g_sql2 , " AND xmdl038 = 0"
                           LET g_sql3 = g_sql3 , " AND xmdl038 = 0"
                           LET g_sql4 = g_sql4 , " AND xmdl038 = 0"  #160506-00002#5
        WHEN g_b_02 = '3'  LET g_sql1 = g_sql1 , " AND xmdl047 > 0"  #已開票
                           LET g_sql2 = g_sql2 , " AND xmdl047 > 0"
                           LET g_sql3 = g_sql3 , " AND xmdl047 > 0"
                           LET g_sql4 = g_sql4 , " AND xmdl047 > 0"  #160506-00002#5
        WHEN g_b_02 = '4'  LET g_sql1 = g_sql1 , " AND xmdl047 = 0"  #未開票
                           LET g_sql2 = g_sql2 , " AND xmdl047 = 0"
                           LET g_sql3 = g_sql3 , " AND xmdl047 = 0"
                           LET g_sql4 = g_sql4 , " AND xmdl047 = 0"  #160506-00002#5
        WHEN g_b_02 = '5'  LET g_sql1 = g_sql1                       #全部
                           LET g_sql2 = g_sql2
                           LET g_sql3 = g_sql3
                           LET g_sql4 = g_sql4                       #160506-00002#5
   END CASE  
   LET g_sql = g_sql1, "    UNION  ", g_sql2 ,"    UNION  ", g_sql3, "    UNION  ",g_sql4  ##160506-00002#5 add g_sql4 
   LET ls_sql_rank = g_sql
  #151123-00013#4 Add  ---(E)---

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
 
   LET g_sql = "SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,'','','','','','','','','',xmdk016, 
       '','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #151123-00013#4 Mark ---(S)--- 移至上方,不然抓出的總比數不對
#   LET g_sql1 = " SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
#              "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
#              "   FROM xmdk_t,xmdl_t ",
#              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
#              "    AND xmdk000 in ('4','5' ) ", #4.出貨簽收單 5.出貨簽退單
#              "    AND xmdkstus = 'Y' AND xmdk002  ='3' ",
#              "    AND xmdkent = ?",
#             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
#              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
#              "    AND ",g_wc2
#            
#  LET g_sql2 = " SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
#              "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
#              "   FROM xmdk_t,xmdl_t ",
#              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
#              "    AND xmdk000 in ('1','2','3') ",       # 1.出貨單2.無訂單出貨 3.直送訂單出貨 
#              "    AND xmdkstus = 'S' AND xmdk002  ='1' ",
#              "    AND xmdkent = ",g_enterprise,
#             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
#              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
#              "    AND ",g_wc2
#              
#  LET g_sql3 = " SELECT '',xmdksite,'',xmdk000,xmdk008,'',xmdk001,xmdldocno, ",
#              "         xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl008,'' ",
#              "   FROM xmdk_t,xmdl_t ",
#              "  WHERE xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
#              "    AND xmdk000 = '6' ",       # 6.銷退單
#              "    AND xmdkstus = 'S' AND xmdk082  <> '5' ",
#              "    AND xmdkent = ",g_enterprise,
#             #"    AND xmdksite= 'BVI'",   #g_b_01,"'",   #151123-00013#4 Mark
#              "    AND xmdksite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef017 = '",g_b_01,"')",   #g_b_01,"'",   #151123-00013#4 Add
#              "    AND ",g_wc2
#  
#   CASE 
#        WHEN g_b_02 = '1'  LET g_sql1 = g_sql1 , " AND xmdl038 > 0"  #已立帳
#                           LET g_sql2 = g_sql2 , " AND xmdl038 > 0"
#                           LET g_sql3 = g_sql3 , " AND xmdl038 > 0"
#        WHEN g_b_02 = '2'  LET g_sql1 = g_sql1 , " AND xmdl038 = 0"  #未立帳
#                           LET g_sql2 = g_sql2 , " AND xmdl038 = 0"
#                           LET g_sql3 = g_sql3 , " AND xmdl038 = 0"
#        WHEN g_b_02 = '3'  LET g_sql1 = g_sql1 , " AND xmdl047 > 0"  #已開票
#                           LET g_sql2 = g_sql2 , " AND xmdl047 > 0"
#                           LET g_sql3 = g_sql3 , " AND xmdl047 > 0"
#        WHEN g_b_02 = '4'  LET g_sql1 = g_sql1 , " AND xmdl047 = 0"  #未開票
#                           LET g_sql2 = g_sql2 , " AND xmdl047 = 0"
#                           LET g_sql3 = g_sql3 , " AND xmdl047 = 0"
#        WHEN g_b_02 = '5'  LET g_sql1 = g_sql1                       #全部
#                           LET g_sql2 = g_sql2
#                           LET g_sql3 = g_sql3
#   END CASE  
   #151123-00013#4 Mark ---(E)---
   LET g_sql = g_sql1, "    UNION  ", g_sql2 ,"    UNION  ", g_sql3, "    UNION  ",g_sql4  #160506-00002#5 add g_sql4
   CASE  
        WHEN g_b_03 = '1'  LET g_sql = g_sql , " ORDER BY xmdksite,xmdk000,xmdk001,xmdldocno,xmdlseq " #營運據點+出貨性質+出貨日期+ 出貨單號+ 項次
                                                 
        WHEN g_b_03 = '2'  LET g_sql = g_sql , " ORDER BY xmdksite,xmdk008,xmdk001,xmdldocno,xmdlseq " #營運據點+帳款客戶+出貨日期+ 出貨單號+ 項次
                                               
#        WHEN g_b_03 = '3'  LET g_sql = g_sql , " ORDER BY xmdksite,xmdk008,xmdl001 "             #營運據點+帳款客戶+原出貨單號 #160506-00002#5
        WHEN g_b_03 = '3'  LET g_sql = g_sql , " ORDER BY xmdksite,xmdk008,aa "                   #營運據點+帳款客戶+原出貨單號 #160506-00002#5
                                                
   END CASE                                      
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq370_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq370_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmdk_d[l_ac].sel,g_xmdk_d[l_ac].xmdksite,g_xmdk_d[l_ac].xmdksite_desc, 
       g_xmdk_d[l_ac].xmdk000,g_xmdk_d[l_ac].xmdk008,g_xmdk_d[l_ac].xmdk008_desc,g_xmdk_d[l_ac].xmdk001, 
       g_xmdk_d[l_ac].xmdldocno,g_xmdk_d[l_ac].xmdlseq,g_xmdk_d[l_ac].xmdl001,g_xmdk_d[l_ac].xmdl002, 
       g_xmdk_d[l_ac].xmdl003,g_xmdk_d[l_ac].xmdl004,g_xmdk_d[l_ac].xmdl008,g_xmdk_d[l_ac].xmdl008_desc, 
       g_xmdk_d[l_ac].xmdl008_desc_1,g_xmdk_d[l_ac].xmdk016,g_xmdk_d[l_ac].xmdl018,g_xmdk_d[l_ac].xmdl027, 
       g_xmdk_d[l_ac].xmdl028,g_xmdk_d[l_ac].xmdl047,g_xmdk_d[l_ac].xmdl018_desc,g_xmdk_d[l_ac].xmdl048, 
       g_xmdk_d[l_ac].xmdl049,g_xmdk_d[l_ac].isafdocno,g_xmdk_d[l_ac].xmdl038
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
#160506-00002#5 mark s-----
#       IF g_xmdk_d[l_ac].xmdk000 = '1' OR '4' THEN
#          LET g_xmdk_d[l_ac].xmdl001 = g_xmdk_d[l_ac].xmdldocno
#       END IF
#160506-00002#5 mark e-----      
       #IF g_xmdk_d[l_ac].xmdk000 = '5' OR g_xmdk_d[l_ac].xmdk000 ='6' THEN      #退單   #161214-00009#1 mark lujh
#160506-00002#5  mod s-----     
#          SELECT xmdl048,   #發票代碼
#                 xmdl049   #發票號碼
#            FROM xmdl_t
#           WHERE xmdldocno = g_xmdk_d[l_ac].xmdldocno
#             AND xmdlseq = g_xmdk_d[l_ac].xmdlseq
#             AND xmdlent = g_enterprise
          #161214-00009#1--mark--str--lujh
          #EXECUTE axrq370_pre_xmdl USING g_xmdk_d[l_ac].xmdldocno,g_xmdk_d[l_ac].xmdlseq
          #   INTO g_xmdk_d[l_ac].xmdl048,g_xmdk_d[l_ac].xmdl049
          #161214-00009#1--mark--end--lujh
#160506-00002#5  mod e-----  
       #ELSE                 # 出貨單已開發票(aist310)   #161214-00009#1 mark lujh
#160506-00002#5  mod s----- 
#          SELECT xmdl047
#            INTO l_xmdl047          
#            FROM xmdl_t
#           WHERE xmdldocno = g_xmdk_d[l_ac].xmdldocno
#             AND xmdlseq = g_xmdk_d[l_ac].xmdlseq
#             AND xmdlent = g_enterprise  

#          IF l_xmdl047 > 0 THEN
#             SELECT isaf011,   #發票代碼
#                    isaf012 ,  #發票號碼
#                    isafdocno  #對帳單號                    
#               FROM isaf_t , isag_t 
#              WHERE isagent  = isafent
#                AND isagdocno = isafdocno 
#                AND isag002 = xmdkdocno           
#                AND isag003 = xmdlseq            
#                AND isafstus ='Y'
#                AND isagent = g_enterprise                
#          END IF 
          IF g_xmdk_d[l_ac].xmdl047 > 0 THEN
             EXECUTE axrq370_pre_isaf USING g_xmdk_d[l_ac].xmdldocno,g_xmdk_d[l_ac].xmdlseq
                INTO g_xmdk_d[l_ac].xmdl048,g_xmdk_d[l_ac].xmdl049,g_xmdk_d[l_ac].isafdocno                
          END IF 
#160506-00002#5  mod e-----           
       #END IF    #161214-00009#1 mark lujh
#160506-00002#5  mod s-----         
      #INSERT INTO axrq370_temp_table VALUES(g_xmdk_d[l_ac].xmdksite,g_xmdk_d[l_ac].*)
      INSERT INTO axrq370_tmp01 VALUES       #160727-00019#6  2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
                 (g_xmdk_d[l_ac].xmdksite,g_xmdk_d[l_ac].xmdksite_desc,g_xmdk_d[l_ac].xmdk000,     g_xmdk_d[l_ac].xmdk008,       g_xmdk_d[l_ac].xmdk008_desc,
                  g_xmdk_d[l_ac].xmdk001, g_xmdk_d[l_ac].xmdldocno,    g_xmdk_d[l_ac].xmdlseq,     g_xmdk_d[l_ac].xmdl001,       g_xmdk_d[l_ac].xmdl002,     g_xmdk_d[l_ac].xmdl003,       
                  g_xmdk_d[l_ac].xmdl004, g_xmdk_d[l_ac].xmdl008,      g_xmdk_d[l_ac].xmdl008_desc,g_xmdk_d[l_ac].xmdl008_desc_1,g_xmdk_d[l_ac].xmdk016,  
                  g_xmdk_d[l_ac].xmdl018, g_xmdk_d[l_ac].xmdl027,      g_xmdk_d[l_ac].xmdl028,     g_xmdk_d[l_ac].xmdl047,       g_xmdk_d[l_ac].xmdl018_desc,g_xmdk_d[l_ac].xmdl048,     
                  g_xmdk_d[l_ac].xmdl049, g_xmdk_d[l_ac].isafdocno,    g_xmdk_d[l_ac].xmdl038)
#160506-00002#5  mod e-----                    
      #end add-point
 
      CALL axrq370_detail_show("'1'")
 
      CALL axrq370_xmdk_t_mask()
 
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
 
   CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmdk_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrq370_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq370_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq370_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmdk_d.getLength() > 0 THEN
      CALL axrq370_b_fill2()
   END IF
 
      CALL axrq370_filter_show('xmdksite','b_xmdksite')
   CALL axrq370_filter_show('xmdk000','b_xmdk000')
   CALL axrq370_filter_show('xmdk008','b_xmdk008')
   CALL axrq370_filter_show('xmdk001','b_xmdk001')
   CALL axrq370_filter_show('xmdldocno','b_xmdldocno')
   CALL axrq370_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq370_filter_show('xmdl001','b_xmdl001')
   CALL axrq370_filter_show('xmdl002','b_xmdl002')
   CALL axrq370_filter_show('xmdl003','b_xmdl003')
   CALL axrq370_filter_show('xmdl008','b_xmdl008')
   CALL axrq370_filter_show('xmdk016','b_xmdk016')
   CALL axrq370_filter_show('xmdl018','b_xmdl018')
   CALL axrq370_filter_show('xmdl027','b_xmdl027')
   CALL axrq370_filter_show('xmdl028','b_xmdl028')
   CALL axrq370_filter_show('xmdl047','b_xmdl047')
   CALL axrq370_filter_show('xmdl048','b_xmdl048')
   CALL axrq370_filter_show('xmdl049','b_xmdl049')
   CALL axrq370_filter_show('xmdl038','b_xmdl038')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq370.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq370_b_fill2()
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
 
{<section id="axrq370.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq370_detail_show(ps_page)
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
#160506-00002#5 mark--s---
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdk_d[l_ac].xmdksite
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_xmdk_d[l_ac].xmdksite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdk_d[l_ac].xmdksite_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdk_d[l_ac].xmdk008
#            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_xmdk_d[l_ac].xmdk008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdk_d[l_ac].xmdk008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmdk_d[l_ac].xmdl008
#            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_xmdk_d[l_ac].xmdl008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmdk_d[l_ac].xmdl008_desc
#160506-00002#5 mark--e---
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq370.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrq370_filter()
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
      CONSTRUCT g_wc_filter ON xmdksite,xmdk000,xmdk008,xmdk001,xmdldocno,xmdlseq,xmdl001,xmdl002,xmdl003, 
          xmdl008,xmdk016,xmdl018,xmdl027,xmdl028,xmdl047,xmdl048,xmdl049,xmdl038
                          FROM s_detail1[1].b_xmdksite,s_detail1[1].b_xmdk000,s_detail1[1].b_xmdk008, 
                              s_detail1[1].b_xmdk001,s_detail1[1].b_xmdldocno,s_detail1[1].b_xmdlseq, 
                              s_detail1[1].b_xmdl001,s_detail1[1].b_xmdl002,s_detail1[1].b_xmdl003,s_detail1[1].b_xmdl008, 
                              s_detail1[1].b_xmdk016,s_detail1[1].b_xmdl018,s_detail1[1].b_xmdl027,s_detail1[1].b_xmdl028, 
                              s_detail1[1].b_xmdl047,s_detail1[1].b_xmdl048,s_detail1[1].b_xmdl049,s_detail1[1].b_xmdl038 
 
 
         BEFORE CONSTRUCT
                     DISPLAY axrq370_filter_parser('xmdksite') TO s_detail1[1].b_xmdksite
            DISPLAY axrq370_filter_parser('xmdk000') TO s_detail1[1].b_xmdk000
            DISPLAY axrq370_filter_parser('xmdk008') TO s_detail1[1].b_xmdk008
            DISPLAY axrq370_filter_parser('xmdk001') TO s_detail1[1].b_xmdk001
            DISPLAY axrq370_filter_parser('xmdldocno') TO s_detail1[1].b_xmdldocno
            DISPLAY axrq370_filter_parser('xmdlseq') TO s_detail1[1].b_xmdlseq
            DISPLAY axrq370_filter_parser('xmdl001') TO s_detail1[1].b_xmdl001
            DISPLAY axrq370_filter_parser('xmdl002') TO s_detail1[1].b_xmdl002
            DISPLAY axrq370_filter_parser('xmdl003') TO s_detail1[1].b_xmdl003
            DISPLAY axrq370_filter_parser('xmdl008') TO s_detail1[1].b_xmdl008
            DISPLAY axrq370_filter_parser('xmdk016') TO s_detail1[1].b_xmdk016
            DISPLAY axrq370_filter_parser('xmdl018') TO s_detail1[1].b_xmdl018
            DISPLAY axrq370_filter_parser('xmdl027') TO s_detail1[1].b_xmdl027
            DISPLAY axrq370_filter_parser('xmdl028') TO s_detail1[1].b_xmdl028
            DISPLAY axrq370_filter_parser('xmdl047') TO s_detail1[1].b_xmdl047
            DISPLAY axrq370_filter_parser('xmdl048') TO s_detail1[1].b_xmdl048
            DISPLAY axrq370_filter_parser('xmdl049') TO s_detail1[1].b_xmdl049
            DISPLAY axrq370_filter_parser('xmdl038') TO s_detail1[1].b_xmdl038
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xmdksite>>----
         #Ctrlp:construct.c.page1.b_xmdksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdksite
            #add-point:ON ACTION controlp INFIELD b_xmdksite name="construct.c.filter.page1.b_xmdksite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdksite  #顯示到畫面上
            NEXT FIELD b_xmdksite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdksite_desc>>----
         #----<<b_xmdk000>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk000
            #add-point:ON ACTION controlp INFIELD b_xmdk000 name="construct.c.filter.page1.b_xmdk000"
            
            #END add-point
 
 
         #----<<b_xmdk008>>----
         #Ctrlp:construct.c.page1.b_xmdk008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk008
            #add-point:ON ACTION controlp INFIELD b_xmdk008 name="construct.c.filter.page1.b_xmdk008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " pmac002 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmac002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_pmac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk008  #顯示到畫面上
            NEXT FIELD b_xmdk008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdk008_desc>>----
         #----<<b_xmdk001>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk001
            #add-point:ON ACTION controlp INFIELD b_xmdk001 name="construct.c.filter.page1.b_xmdk001"
            
            #END add-point
 
 
         #----<<b_xmdldocno>>----
         #Ctrlp:construct.c.filter.page1.b_xmdldocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdldocno
            #add-point:ON ACTION controlp INFIELD b_xmdldocno name="construct.c.filter.page1.b_xmdldocno"
            
            #END add-point
 
 
         #----<<b_xmdlseq>>----
         #Ctrlp:construct.c.filter.page1.b_xmdlseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdlseq
            #add-point:ON ACTION controlp INFIELD b_xmdlseq name="construct.c.filter.page1.b_xmdlseq"
            
            #END add-point
 
 
         #----<<b_xmdl001>>----
         #Ctrlp:construct.c.page1.b_xmdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl001
            #add-point:ON ACTION controlp INFIELD b_xmdl001 name="construct.c.filter.page1.b_xmdl001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xmdg006 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND xmdg006 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xmdgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl001  #顯示到畫面上
            NEXT FIELD b_xmdl001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl002>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl002
            #add-point:ON ACTION controlp INFIELD b_xmdl002 name="construct.c.filter.page1.b_xmdl002"
            
            #END add-point
 
 
         #----<<b_xmdl003>>----
         #Ctrlp:construct.c.page1.b_xmdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl003
            #add-point:ON ACTION controlp INFIELD b_xmdl003 name="construct.c.filter.page1.b_xmdl003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xmda021 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) ",
                                   " AND xmda022 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) ",
                                   " AND xmda004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND xmda021 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")",
                                                       " AND xmda022 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")",
                                                       " AND xmda004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xmdadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl003  #顯示到畫面上
            NEXT FIELD b_xmdl003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl004>>----
         #----<<b_xmdl008>>----
         #Ctrlp:construct.c.page1.b_xmdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl008
            #add-point:ON ACTION controlp INFIELD b_xmdl008 name="construct.c.filter.page1.b_xmdl008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl008  #顯示到畫面上
            NEXT FIELD b_xmdl008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl008_desc>>----
         #----<<b_xmdl008_desc_1>>----
         #----<<b_xmdk016>>----
         #Ctrlp:construct.c.page1.b_xmdk016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk016
            #add-point:ON ACTION controlp INFIELD b_xmdk016 name="construct.c.filter.page1.b_xmdk016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk016  #顯示到畫面上
            NEXT FIELD b_xmdk016                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xmdl018>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl018
            #add-point:ON ACTION controlp INFIELD b_xmdl018 name="construct.c.filter.page1.b_xmdl018"
            
            #END add-point
 
 
         #----<<b_xmdl027>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl027
            #add-point:ON ACTION controlp INFIELD b_xmdl027 name="construct.c.filter.page1.b_xmdl027"
            
            #END add-point
 
 
         #----<<b_xmdl028>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl028
            #add-point:ON ACTION controlp INFIELD b_xmdl028 name="construct.c.filter.page1.b_xmdl028"
            
            #END add-point
 
 
         #----<<b_xmdl047>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl047
            #add-point:ON ACTION controlp INFIELD b_xmdl047 name="construct.c.filter.page1.b_xmdl047"
            
            #END add-point
 
 
         #----<<xmdl018_desc>>----
         #----<<b_xmdl048>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl048
            #add-point:ON ACTION controlp INFIELD b_xmdl048 name="construct.c.filter.page1.b_xmdl048"
            
            #END add-point
 
 
         #----<<b_xmdl049>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl049
            #add-point:ON ACTION controlp INFIELD b_xmdl049 name="construct.c.filter.page1.b_xmdl049"
            
            #END add-point
 
 
         #----<<isafdocno>>----
         #----<<b_xmdl038>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl038
            #add-point:ON ACTION controlp INFIELD b_xmdl038 name="construct.c.filter.page1.b_xmdl038"
            
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
 
      CALL axrq370_filter_show('xmdksite','b_xmdksite')
   CALL axrq370_filter_show('xmdk000','b_xmdk000')
   CALL axrq370_filter_show('xmdk008','b_xmdk008')
   CALL axrq370_filter_show('xmdk001','b_xmdk001')
   CALL axrq370_filter_show('xmdldocno','b_xmdldocno')
   CALL axrq370_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq370_filter_show('xmdl001','b_xmdl001')
   CALL axrq370_filter_show('xmdl002','b_xmdl002')
   CALL axrq370_filter_show('xmdl003','b_xmdl003')
   CALL axrq370_filter_show('xmdl008','b_xmdl008')
   CALL axrq370_filter_show('xmdk016','b_xmdk016')
   CALL axrq370_filter_show('xmdl018','b_xmdl018')
   CALL axrq370_filter_show('xmdl027','b_xmdl027')
   CALL axrq370_filter_show('xmdl028','b_xmdl028')
   CALL axrq370_filter_show('xmdl047','b_xmdl047')
   CALL axrq370_filter_show('xmdl048','b_xmdl048')
   CALL axrq370_filter_show('xmdl049','b_xmdl049')
   CALL axrq370_filter_show('xmdl038','b_xmdl038')
 
 
   CALL axrq370_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq370.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrq370_filter_parser(ps_field)
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
 
{<section id="axrq370.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq370_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq370_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrq370.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq370_detail_action_trans()
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
 
{<section id="axrq370.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq370_detail_index_setting()
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
            IF g_xmdk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmdk_d.getLength() AND g_xmdk_d.getLength() > 0
            LET g_detail_idx = g_xmdk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmdk_d.getLength() THEN
               LET g_detail_idx = g_xmdk_d.getLength()
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
 
{<section id="axrq370.mask_functions" >}
 &include "erp/axr/axrq370_mask.4gl"
 
{</section>}
 
{<section id="axrq370.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/11/26 By lihuanc
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq370_construct()
   DEFINE l_ld_str          STRING                #160811-00009#2     
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add

  #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
  #161111-00049#9 Add  ---(E)---

    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
             #add-point:input段落
             INPUT g_b_01,g_b_02,g_b_03 FROM lbl_b_01,lbl_b_02,lbl_b_03
            # INPUT g_b_02 FROM lbl_b_02,
            # INPUT g_b_03 FROM lbl_b_03
                ATTRIBUTE(WITHOUT DEFAULTS)
                
                BEFORE INPUT
                  #LET g_b_01 = g_site        #151123-00013#4  Mark
                  #151123-00013#4 Add  ---(S)---
                   SELECT ooef017 INTO g_b_01 FROM ooef_t
                    WHERE ooefent = g_enterprise
                      AND ooef001 = g_site
                   CALL s_desc_get_department_desc(g_b_01) RETURNING g_b_01_desc
                   DISPLAY g_b_01_desc TO b_01_desc
                  #151123-00013#4 Add  ---(E)---
                   LET g_b_02 = '1'
                   LET g_b_03 = '1'

               #151123-00013#4 Add  ---(S)---
                AFTER FIELD lbl_b_01
                   IF NOT cl_null(g_b_01) THEN
                      CALL s_fin_comp_chk(g_b_01) RETURNING g_sub_success,g_errno
                      CALL axrq370_lbl_b_01_chk(g_b_01)RETURNING g_sub_success,g_errno
                      IF NOT g_sub_success THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = g_errno
                         LET g_errparam.extend = ''
                         LET g_errparam.replace[1] = 'aooi100'
                         LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                         LET g_errparam.exeprog = 'aooi100'
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         SELECT ooef017 INTO g_b_01 FROM ooef_t
                          WHERE ooefent = g_enterprise
                            AND ooef001 = g_site
                         NEXT FIELD CURRENT
                      END IF
                      CALL s_desc_get_department_desc(g_b_01) RETURNING g_b_01_desc
                      DISPLAY g_b_01_desc TO b_01_desc
                   END IF

                ON ACTION controlp INFIELD lbl_b_01
                   #開窗i段
                   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_ld_str  #160811-00009#2      
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'i'
                   LET g_qryparam.reqry = FALSE

                   LET g_qryparam.default1 = g_b_01             #給予default值
                   #LET g_qryparam.where    = " ooef003 = 'Y'"                  #160811-00009#2 
                   LET g_qryparam.where = l_ld_str CLIPPED," AND ooef003 = 'Y' "#160811-00009#2 
                   #CALL q_ooef001()                                #呼叫開窗    #161021-00050#5 mark
                   CALL q_ooef001_2()                                           #161021-00050#5 add

                   LET g_b_01 = g_qryparam.return1
                   CALL s_desc_get_department_desc(g_b_01) RETURNING g_b_01_desc
                   DISPLAY g_b_01_desc TO b_01_desc
                   DISPLAY g_b_01 TO lbl_b_01              #
                   NEXT FIELD lbl_b_01                          #返回原欄位
               #151123-00013#4 Add  ---(E)---

             END INPUT
             
             CONSTRUCT BY NAME g_wc2 ON b_xmdksite,b_xmdk000,b_xmdk008,b_xmdk001,b_xmdldocno,b_xmdlseq,b_xmdl001,b_xmdl003,
                                        b_xmdl004,b_xmdl008,
                                        b_xmdk016  #160506-00002#5 
                BEFORE CONSTRUCT
     
                #應用 a03 樣板自動產生(Version:2)
                ON ACTION controlp INFIELD b_xmdksite
                   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str #160811-00009#2    
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		          LET g_qryparam.reqry = FALSE
    		          LET g_qryparam.where = l_ld_str CLIPPED #160811-00009#2 
                   #CALL q_bmaasite()                      #呼叫開窗 #160811-00009#2 
                   #CALL q_ooef001_12()                     #160811-00009#2  #161026-00013#1 mark
                   CALL q_ooef001_1()                      #呼叫開窗          #161026-00013#1 add
                   DISPLAY g_qryparam.return1 TO b_xmdksite  #顯示到畫面上                   
                   NEXT FIELD b_xmdksite                    #返回原欄位
    
                ON ACTION controlp INFIELD b_xmdk008
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		          LET g_qryparam.reqry = FALSE
    		          #151231-00010#7--(S)
                   LET g_qryparam.where = " isak001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
                   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                      LET g_qryparam.where = g_qryparam.where," AND isak001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
                   END IF
                   #151231-00010#7--(E)
                   CALL q_isak001()                      #呼叫開窗
                   DISPLAY g_qryparam.return1 TO b_xmdk008  #顯示到畫面上                  
                   NEXT FIELD b_xmdk008                   #返回原欄位
                
                ON ACTION controlp INFIELD b_xmdldocno
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		          LET g_qryparam.reqry = FALSE
    		         #CALL  q_xmdldocno_2()                  #呼叫出货单開窗  #151231-00010#7mark
    		          #151231-00010#7--(S)
                   LET g_qryparam.where = " xmdk008 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
                   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                      LET g_qryparam.where = g_qryparam.where," AND xmdk008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
                   END IF
                   CALL  q_xmdldocno_3() 
                   #151231-00010#7--(E)
                   DISPLAY g_qryparam.return1 TO b_xmdldocno  #顯示到畫面上                 
                   NEXT FIELD b_xmdldocno                    #返回原欄位
                   
                ON ACTION controlp INFIELD b_xmdl001
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		          LET g_qryparam.reqry = FALSE
    		          #151231-00010#7--(S)
                   LET g_qryparam.where = " xmdg006 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
                   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                      LET g_qryparam.where = g_qryparam.where," AND xmdg006 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
                   END IF
                   #151231-00010#7--(E)
                   CALL q_xmdgdocno()                      #呼叫開窗
                   DISPLAY g_qryparam.return1 TO b_xmdl001  #顯示到畫面上                  
                   NEXT FIELD b_xmdl001                    #返回原欄位
                   
                ON ACTION controlp INFIELD b_xmdl003
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		         LET g_qryparam.reqry = FALSE
    		         #151231-00010#7--(S)
                  LET g_qryparam.where = " xmda021 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) ",
                                         " AND xmda022 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) ",
                                         " AND xmda004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = g_qryparam.where," AND xmda021 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")",
                                                             " AND xmda022 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")",
                                                             " AND xmda004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
                  END IF
                  #151231-00010#7--(E)
                   CALL q_xmdadocno_2()                      #呼叫開窗
                   DISPLAY g_qryparam.return1 TO b_xmdl003  #顯示到畫面上                  
                   NEXT FIELD b_xmdl003                    #返回原欄位
                
                ON ACTION controlp INFIELD b_xmdl008
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		          LET g_qryparam.reqry = FALSE
                  #CALL q_imaa001()                       #呼叫開窗   #161111-00049#9 Mark
		  	          #161111-00049#9 Add  ---(S)---
                   IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
                      LET g_qryparam.where = g_qryparam.where,g_sql_ctrl2," AND imafsite = '",l_ooef017,"'"
                   END IF
                   LET g_qryparam.arg1 = l_ooef017
                   CALL q_imaf001_7()                     #呼叫開窗   
		  	          #161111-00049#9 Add  ---(E)---
                   DISPLAY g_qryparam.return1 TO b_xmdl008  #顯示到畫面上                  
                   NEXT FIELD b_xmdl008                    #返回原欄位
                   
                #160506-00002 add s---
                ON ACTION controlp INFIELD b_xmdk016
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c'
    		          LET g_qryparam.reqry = FALSE
                   CALL q_ooai001()                      #呼叫開窗
                   DISPLAY g_qryparam.return1 TO b_xmdk016  #顯示到畫面上                  
                   NEXT FIELD b_xmdk016                    #返回原欄位                
                #160506-00002 add e---                
                
             END CONSTRUCT
             
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
          RETURN
       END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrq370_ui_dialog_1 ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq370_ui_dialog_1()
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
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add

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
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   #161111-00049#9 Add
 
   
 
#   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
#      CALL afaq520_cs()
#   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmdk_d.clear()
         LET g_b_01 = NULL
         LET g_b_02 = NULL
         LET g_b_03 = NULL
 
 
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
 
         CALL axrq370_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         
         #end add-point
 
         #add-point:construct段落
         
         #end add-point
         
          DISPLAY ARRAY g_xmdk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq370_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row

               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為

            #end add-point
 
         END DISPLAY

         
         #add-point:ui_dialog段define

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #CALL afaq520_fetch('')
 
            #add-point:ui_dialog段before dialog
            CALL axrq370_construct()
            CALL axrq370_b_fill()
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

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
 
 
            #add-point:ON ACTION accept

            #end add-point
 
#            CALL afaq520_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xmdk_d)
               LET g_export_id[1]   = "s_detail1"
               #add-point:ON ACTION exporttoexcel

               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 

 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq370_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq370_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq370_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq370_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:2)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION insert
#            LET g_action_choice="insert"
#            IF cl_auth_chk_act("insert") THEN
#               
#               #add-point:ON ACTION insert
#
#               #END add-point
#               
#               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
                  CALL axrq370_x01('1=1','axrq370_tmp01')     #160727-00019#6  2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               CLEAR FORM
               LET g_b_01 = NULL
               LET g_b_02 = NULL
               LET g_b_03 = NULL
               CALL g_xmdk_d.clear()
               
               
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
 
               CALL axrq370_init()
               CALL axrq370_construct()
               CALL axrq370_b_fill()
               #END add-point
               
               
            END IF
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後

            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point 
 
      END DIALOG 
   
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrq370_temp_table ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq370_temp_table()
WHENEVER ERROR CONTINUE
   DROP TABLE axrq370_temp_table   
   CREATE TEMP TABLE axrq370_temp_table(   
    xmdksite  VARCHAR(10), 
   xmdksite_desc  VARCHAR(500), 
   xmdk000  VARCHAR(10), 
   xmdk008  VARCHAR(10), 
   xmdk008_desc  VARCHAR(500), 
   xmdk001  DATE, 
   xmdldocno  VARCHAR(20), 
   xmdlseq  INTEGER, 
   xmdl001  VARCHAR(20), 
   xmdl002  INTEGER, 
   xmdl003  VARCHAR(20), 
   xmdl004  VARCHAR(500), 
   xmdl008  VARCHAR(40), 
   xmdl008_desc  VARCHAR(500),
   #160506-00002#5 add s------
   xmdl008_desc_1  VARCHAR(500),
   xmdk016  VARCHAR(10), 
   xmdl018  DECIMAL(20,6), 
   xmdl027  DECIMAL(20,6), 
   xmdl028  DECIMAL(20,6), 
   xmdl047  DECIMAL(20,6), 
   xmdl018_desc  DECIMAL(20,6), 
   xmdl048  VARCHAR(20), 
   xmdl049  VARCHAR(20), 
   isafdocno  VARCHAR(20), 
   xmdl038  DECIMAL(20,6)
   #160506-00002#5 add e------
   )
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: axrq370_tmp01()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq370_tmp01()
WHENEVER ERROR CONTINUE
   DROP TABLE axrq370_tmp01              #160727-00019#6  2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
   CREATE TEMP TABLE axrq370_tmp01(      #160727-00019#6  2016/07/28  By 08734    axrq370_temp_table ——> axrq370_tmp01
    xmdksite  VARCHAR(10), 
   xmdksite_desc  VARCHAR(500), 
   xmdk000  VARCHAR(10), 
   xmdk008  VARCHAR(10), 
   xmdk008_desc  VARCHAR(500), 
   xmdk001  DATE, 
   xmdldocno  VARCHAR(20), 
   xmdlseq  INTEGER, 
   xmdl001  VARCHAR(20), 
   xmdl002  INTEGER, 
   xmdl003  VARCHAR(20), 
   xmdl004  VARCHAR(500), 
   xmdl008  VARCHAR(40), 
   xmdl008_desc  VARCHAR(500),
   #160506-00002#5 add s------
   xmdl008_desc_1  VARCHAR(500),
   xmdk016  VARCHAR(10), 
   xmdl018  DECIMAL(20,6), 
   xmdl027  DECIMAL(20,6), 
   xmdl028  DECIMAL(20,6), 
   xmdl047  DECIMAL(20,6), 
   xmdl018_desc  DECIMAL(20,6), 
   xmdl048  VARCHAR(20), 
   xmdl049  VARCHAR(20), 
   isafdocno  VARCHAR(20), 
   xmdl038  DECIMAL(20,6)
   #160506-00002#5 add e------
   )
END FUNCTION

################################################################################
# Descriptions...: 法人檢核
# Memo...........:
# Usage..........: CALL axrq370_lbl_b_01_chk(p_comp)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/26 By 08729
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq370_lbl_b_01_chk(p_comp)
DEFINE p_comp       LIKE ooef_t.ooef001
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_ooef       RECORD
                    ooef003   LIKE ooef_t.ooef003,
                    ooefstus  LIKE ooef_t.ooefstus
                       END RECORD
DEFINE l_count      LIKE type_t.num10
DEFINE l_sql STRING   
DEFINE l_comp_str  STRING  

   LET r_success = TRUE
   LET r_errno   = ''

   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 

   INITIALIZE l_ooef.* TO NULL
   LET l_sql = " SELECT ooef003,ooefstus            ",     
               "  FROM ooef_t                       ",
               " WHERE ooefent = '",g_enterprise,"' ",
               "  AND ooef001 = '",p_comp,"'    ",
               "  AND ",l_comp_str CLIPPED        
   PREPARE axrq370_xrgacpmp_prep FROM l_sql
   EXECUTE axrq370_xrgacpmp_prep INTO l_ooef.*
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooef003  <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'aap-00011'
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
